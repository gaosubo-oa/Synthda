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
    <title>材料结算预览</title>

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
    <%--        <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

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
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div id="htmBox"></div>
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
    var runId = getUrlParam('runId');
    var _disabled = getUrlParam('disabled');
    var type = null;
    if('0'!=_disabled){
        type = 4
    }else {
        type = 2
    }

    var mtlSettleupId = null;
    var projId = null;

    //var disabledStr = '';
    var _htm = ['<div class="layer_wrap _disabled"><div class="layui-collapse">',
        /* region 基本信息 */
        '<div class="layui-colla-item"><h2 class="layui-colla-title">基本信息</h2>' +
        '<div class="layui-colla-content layui-show order_base_info"><form id="baseForm" class="layui-form" lay-filter="baseForm">',
        '<div class="layui-row">' +
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">结算单编号<span field="mtlSettleupNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" readonly name="mtlSettleupNo" autocomplete="off" style="background: #e7e7e7"class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">项目名称<span field="projName" class="field_required">*</span></label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" name="projName" id="projName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="项目名称">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>' +
        '<div class="layui-input-block form_block">' +
        '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
        '<input type="text" readonly name="contractName" id="contractName" autocomplete="off" style="background: #e7e7e7;cursor: pointer;" placeholder="请选择合同" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">供应商单位名称<span field="customerId" class="field_required">*</span></label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" readonly name="customerName" id="customerName" autocomplete="off" placeholder="供应商" style="background: #e7e7e7;cursor: pointer;" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">合同金额<span field="contractMoney" class="field_required">*</span></label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" readonly name="contractMoney" id="contractMoney" autocomplete="off" placeholder="合同金额" style="background: #e7e7e7;cursor: pointer;" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '</div>',
        '<div class="layui-row">' +
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">累计已结算金额</label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" name="subsettleupMoney" readonly autocomplete="off"  style="background: #e7e7e7" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">本次结算金额</label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" name="settlementMoney" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">复核金额</label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" name="confirmMoney" autocomplete="off"  class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>'+
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">结算日期<span field="settlementDate" class="field_required">*</span></label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" id="settlementDate" name="settlementDate" readonly autocomplete="off" style="cursor: pointer;" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '<div class="layui-col-xs6" style="padding: 0 5px;">' +
        '<div class="layui-form-item">\n' +
        '<label class="layui-form-label form_label">结算年</label>\n' +
        '<div class="layui-input-block form_block">\n' +
        '<input type="text" id="settlementYear" name="settlementYear" autocomplete="off" class="layui-input">\n' +
        '</div>\n' +
        '</div>' +
        '</div>',
        '</div>',
        '<div class="layui-row">' +
        '<div class="layui-col-xs6" style="padding: 0 5px;">' +
        '<div class="layui-form-item">\n' +
        '<label class="layui-form-label form_label">结算季</label>\n' +
        '<div class="layui-input-block form_block">\n' +
        ' <select name="settlementQuarter"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
        '</div>\n' +
        '</div>' +
        '</div>' ,
        '<div class="layui-col-xs6" style="padding: 0 5px;">' +
        '<div class="layui-form-item">\n' +
        '<label class="layui-form-label form_label">结算月</label>\n' +
        '<div class="layui-input-block form_block">\n' +
        '<select name="settlementMonth">' +
        '<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
        '<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
        '<option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
        '</select>' +
        '</div>\n' +
        '</div>' +
        '</div>' ,
        '<div class="layui-col-xs6" style="padding: 0 5px">' +
        '<div class="layui-form-item">' +
        '<label class="layui-form-label form_label">备注</label>' +
        '<div class="layui-input-block form_block">' +
        '<input type="text" name="remark" autocomplete="off" class="layui-input">' +
        '</div>' +
        '</div>' +
        '</div>',
        '</div>',
        /* endregion */
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
        '           </div>',
        /* endregion */
        '       </form>' +
        '    </div>\n' +
        '  </div>\n',
        /* endregion */
        /* region 材料结算明细 */
        '<div class="layui-colla-item"><h2 class="layui-colla-title">材料结算明细</h2>' +
        '<div class="layui-colla-content layui-show mtl_info">' +
        '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
        '</div>' +
        '</div>',
        /* endregion */
        '</div></div>'].join('');

    var warehousingArr = []

    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })


    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        CONTRACT_TYPE: {},
        CBS_UNIT:{},
        TAX_RATE:{}
    }
    var dictionaryStr = 'CONTRACT_TYPE,CBS_UNIT,TAX_RATE';
    $.ajaxSettings.async = false;
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
        initPage();
    });

    function initPage() {
        $.ajaxSettings.async = true;
        layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree'], function () {
            var form = layui.form,
                laydate = layui.laydate,
                table = layui.table,
                layElement = layui.element,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree;


            $("#htmBox").html(_htm)



            if(runId==undefined||runId==""||runId==null){
                layer.msg("获取信息失败")
            }
            form.render();

            $.ajax({
                url:"/plbMtlSettleup/getSettleupByRunId?runId="+runId,
                dataType:"json",
                type:"post",
                async:false,
                success:function(res){
                    if(res.flag){
                        var data = res.data;

                        mtlSettleupId = data.mtlSettleupId;
                        projId = data.projId;

                        //回显项目名称
                        getProjName('#projName',projId?projId:data.projId)
                        fileuploadFn('#fileupload', $('#fileContent'));

                        laydate.render({
                            elem: '#settlementDate' //指定元素
                            , trigger: 'click' //采用click弹出
                            , value: data ? format(data.settlementDate) : '',
                            done:function (value, date, endDate) {
                                $('#settlementYear').val(date.year)
                                if(date.month <4){
                                    $('[name="settlementQuarter"]').val('1')
                                }else if(date.month <7){
                                    $('[name="settlementQuarter"]').val('2')
                                }else if(date.month <10){
                                    $('[name="settlementQuarter"]').val('3')
                                }else{
                                    $('[name="settlementQuarter"]').val('4')
                                }
                                $('[name="settlementMonth"]').val(date.month)
                                form.render()
                            }
                        });

                        //年选择器
                        laydate.render({
                            elem: '#settlementYear'
                            ,type: 'year'
                            , trigger: 'click' //采用click弹出
                            , value: data ? data.settlementYear : ''
                        });

                        var detailsTableData = [];

                        // 编辑时显示数据
                        if (type == 2||type == 4) {
                            warehousingArr = data.plbMtlSettleupLists
                            form.val("baseForm", data);

                            $('#contractName').val(data.contractName || '');
                            $('#contractName').attr('contractId', data.contractId || '');
                            $('#customerName').val(data.customerName || '');
                            $('#customerName').attr('customerId', data.customerId || '');


                            //附件
                            if (data.attachments && data.attachments.length > 0) {
                                var fileArr = data.attachments;
                                $('#fileContent').append(echoAttachment(fileArr));
                            }

                            detailsTableData = data.plbMtlSettleupLists || [];
                        } else {
                            // 获取自动编号
                            getAutoNumber({autoNumber: 'plbMtlSettleup'}, function(res) {
                                $('input[name="mtlSettleupNo"]', $('#baseForm')).val(res);
                            });
                            $('.refresh_no_btn').show().on('click', function() {
                                getAutoNumber({autoNumber: 'plbMtlSettleup'}, function(res) {
                                    $('input[name="mtlSettleupNo"]', $('#baseForm')).val(res);
                                });
                            });
                        }

                        var cols = [
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'mtlStockInNo', title: '入库单编号', minWidth: 166, templet: function (d) {
                                    return '<span class="mtl_info_mtlStockInNo">' + undefind_nullStr(d.mtlStockInNo) + '</span>';
                                }
                            },
                            {
                                field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_wbsName" wbsId="' + undefind_nullStr(d.wbsId) + '">' + undefind_nullStr(d.wbsName) + '</span>';
                                }
                            },
                            {
                                field: 'rbsName', title: 'RBS', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_rbsName" rbsId="' + undefind_nullStr(d.rbsId) + '">' + undefind_nullStr(d.rbsName) + '</span>';
                                }
                            },
                            {
                                field: 'cbsName', title: 'CBS', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_cbsName" cbsId="' + undefind_nullStr(d.cbsId) + '">' + undefind_nullStr(d.cbsName) + '</span>';
                                }
                            },
                            {
                                field: 'mtlName', title: '材料名称', width: 200, templet: function (d) {
                                    return '<span class="mtl_info_mtlName" settleupListId="' + undefind_nullStr(d.settleupListId) + '" stockInListId="' + undefind_nullStr(d.stockInListId) + '">' + undefind_nullStr(d.mtlName) + '</span>';
                                }
                            },
                            {
                                field: 'mtlStandard', title: '材料规格', width: 200, templet: function (d) {
                                    return '<span class="mtl_info_mtlStandard">' + (d.mtlStandard || '') + '</span>';
                                }
                            },
                            {
                                field: 'mtlValuationUnit', title: '单位', width: 200, templet: function (d) {
                                    return '<span class="mtl_info_mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'">' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '</span>';
                                }
                            },
                            {
                                field: 'stockInQuantity', title: '入库数量', minWidth: 120, templet: function (d) {
                                    var str = '<input type="hidden" class="noTaxPrice" value="' + (d.noTaxPrice || 0) + '">';
                                    str += '<input type="hidden" class="taxRate" value="' + (d.taxRate || 0) + '">'
                                    return '<span class="mtl_info_stockInQuantity">' + (d.stockInQuantity || 0) + str + '</span>';
                                }
                            },
                            {
                                field: 'taxPrice', title: '含税单价', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_taxPrice">' + (d.taxPrice || 0) + '</span>';
                                }
                            },
                            {
                                field: 'noTaxPrice', title: '不含税单价', minWidth: 120, templet: function (d) {
                                    return '<span class="noTaxPrice">' + (d.noTaxPrice || 0) + '</span>';
                                }
                            },
                            {
                                field: 'taxMoney', title: '含税总价', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_taxMoney">' + (d.taxMoney || 0) + '</span>';
                                }
                            },
                            {
                                field: 'noTaxMoney', title: '不含税总价', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_noTaxMoney">' + (d.noTaxMoney || 0) + '</span>';
                                }
                            },
                            {
                                field: 'stockInDate', title: '入库日期', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_stockInDate">' + undefind_nullStr(d.stockInDate) + '</span>';
                                }
                            }
                        ]
                        //查看详情
                        if(type!=4){
                            cols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        }

                        table.render({
                            elem: '#detailTable',
                            data: detailsTableData,
                            height: detailsTableData&&detailsTableData.length>5?'full-350':false,
                            toolbar: type==4?false:'#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function (obj) {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                                warehousingArr = obj.data
                            }
                        });

                        //查看详情
                        if(type==4){
                            $('._disabled').find('input,select').attr('disabled', 'disabled');
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                        }
                        layElement.render();
                        form.render()

                        // 选择供应商
                        /*$('#customerName').on('click', function() {
                            var $this = $(this);
                            layer.open({
                                type: 1,
                                title: '选择供应商',
                                area: ['100%', '100%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="container">',
                                    '<div class="wrapper">',
                                    '<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
                                    '<div class="layui-form">' +
                                    '<div class="tree_module" style="top: 0;">' +
                                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>',
                                    '<div class="wrap_right" style="padding-left: 10px;">' +
                                    '<div class="mtl_table_box" style="display: none;">' +
                                    '<div class="layui-form layui-row" id="customerQuery" style="margin-top: 10px;">' +
                                    '<div class="layui-col-xs1">' +
                                    '<h3 style="line-height: 38px;">供应商</h3>' +
                                    '</div>' +
                                    '<div class="layui-col-xs2">' +
                                    '<input type="text" name="customerName" placeholder="供应商名称/简称" autocomplete="off" class="layui-input">' +
                                    '</div>' +
                                    '<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">' +
                                    '<button type="button" class="layui-btn layui-btn-sm" id="searchCustomer">查询</button></div>' +
                                    '</div>' +
                                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                    '<div class="layui-form layui-row" id="contractQuery" style="margin-top: 10px;">' +
                                    '<div class="layui-col-xs1">' +
                                    '<h3 style="line-height: 38px;">合同</h3>' +
                                    '</div>' +
                                    '<div class="layui-col-xs2">' +
                                    '<input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">' +
                                    '</div>' +
                                    '<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">' +
                                    '<button type="button" class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
                                    '</div>' +
                                    '<table id="contractsTable" lay-filter="contractsTable"></table>' +
                                    '</div>' +
                                    '<div class="mtl_no_data" style="text-align: center;">' +
                                    '<div class="no_data_img" style="margin-top:12%;">' +
                                    '<img style="margin-top: 2%;" src="/img/noData.png">' +
                                    '</div>' +
                                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧客商类型</p>' +
                                    '</div>' +
                                    '</div>',
                                    '</div></div>'].join(''),
                                success: function () {
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
                                                    name: 'typeName',
                                                    children: "child",
                                                }
                                            });
                                        }
                                    });

                                    // 树节点点击事件
                                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                                        $('.mtl_no_data').hide();
                                        $('.mtl_table_box').show();
                                        loadMtlTable(d.data.currentData.typeNo);
                                        $('input[name="customerName"]', $('#customerQuery ')).val('');
                                        $('#searchCustomer').attr('typeNo', d.data.currentData.typeNo);
                                    });

                                    $('#searchCustomer').on('click', function() {
                                        var typeNo = $('#searchCustomer').attr('typeNo') || '';
                                        var customerName = $('input[name="customerName"]', $('#customerQuery ')).val();
                                        loadMtlTable(typeNo, customerName);
                                    });

                                    function loadMtlTable(merchantType, customerName) {
                                        table.render({
                                            elem: '#materialsTable',
                                            url: '/PlbCustomer/getDataByCondition',
                                            where: {
                                                merchantType: merchantType,
                                                customerName: customerName || ''
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
                                                {type: 'radio', title: '选择'},
                                                {field: 'customerNo', title: '客商编号'},
                                                {field: 'customerName', title: '客商单位名称'},
                                                {field: 'customerShortName', title: '客商单位简称'},
                                                {field: 'customerOrgCode', title: '组织机构代码'},
                                                {field: 'taxNumber', title: '税务登记号'},
                                                {field: 'accountNumber', title: '开户行账户'}
                                            ]]
                                        });

                                        laodContractsTable('');
                                    }

                                    table.on('radio(materialsTable)', function (obj) {
                                        laodContractsTable(obj.data.customerId);
                                        $('input[name="contractName"]', $('#contractQuery ')).val('');
                                        $('#searchContract').attr('customerId', obj.data.customerId);
                                    });

                                    $('#searchContract').on('click', function() {
                                        var customerId = $('#searchContract').attr('customerId') || '';
                                        var contractName = $('input[name="contractName"]', $('#contractQuery ')).val();
                                        laodContractsTable(customerId, contractName);
                                    });

                                    function laodContractsTable(customerId, contractName) {
                                        table.render({
                                            elem: '#contractsTable',
                                            url: '/plbMtlContract/getAllContractByCustomerId',
                                            where: {
                                                customerId: customerId,
                                                projId: projId,
                                                contractName: contractName || ''
                                            },
                                            page: {
                                                limit: 10,
                                                limits: [10]
                                            },
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
                                                {type: 'radio', title: '选择'},
                                                {field: 'contractNo', title: '合同编号', align: 'center', minWdith: 100},
                                                {
                                                    field: 'contractName', title: '合同名称', align: 'center', minWdith: 100
                                                },
                                                {field: 'contractType', title: '合同类型', align: 'center', minWdith: 100, templet: function (d) {
                                                        return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                                                    }},
                                                {field: 'projName', title: '所属项目', minWdith: 160, align: 'center'},
                                                {field: 'signDate', title: '合同签订日期', minWdith: 160, align: 'center'}
                                            ]]
                                        });
                                    }

                                    form.render()
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('materialsTable');
                                    if (checkStatus.data.length > 0) {
                                        var mtlData = checkStatus.data[0];
                                        $this.val(mtlData.customerName);
                                        $this.attr('customerId', mtlData.customerId);

                                        var checkContractsData = table.checkStatus('contractsTable');

                                        if (checkContractsData.data.length > 0) {
                                            var contractsData = checkContractsData.data[0];
                                            $('#contractName').val(contractsData.contractName);
                                            $('#contractName').attr('contractId', contractsData.mtlContractId);
                                            $('input[name="subsettleupMoney"]', $('#baseForm')).val(contractsData.settleupMoney);
                                        }

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        });*/

                        // 选择合同
                        $('#contractName').on('click', function () {
                            layer.open({
                                type: 1,
                                title: '选择合同',
                                area: ['80%', '80%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div style="padding: 10px;">' +
                                '<div class="layui-form">' +
                                '<div class="layui-form-item" style="margin: 0;">' +
                                '<div class="layui-inline">'+
                                '<div class="layui-input-inline">'+
                                '<input type="text" id="contractNo" placeholder="合同编号" autocomplete="off" class="layui-input">'+
                                '</div>'+
                                '</div>'+
                                '<div class="layui-inline">'+
                                '<div class="layui-input-inline">'+
                                '<input type="text" id="searchContractName" placeholder="合同名称" autocomplete="off" class="layui-input">'+
                                '</div>'+
                                '</div>'+
                                '<div class="layui-inline">'+
                                '<div class="layui-input-inline">'+
                                '<input type="text" id="searchCustomerName" placeholder="供应商" autocomplete="off" class="layui-input">'+
                                '</div>'+
                                '</div>'+
                                '<div class="layui-inline">'+
                                '<button type="button" class="layui-btn layui-btn-sm" id="search_mtl">查询</button>'+
                                '</div>'+
                                '</div>' +
                                '</div>' +
                                '<table id="contractTable" lay-filter="contractTable"></table>' +
                                '</div>'].join(''),
                                success: function () {
                                    var contractTable = table.render({
                                        elem: '#contractTable',
                                        url: '/plbMtlContract/selectAll',
                                        where: {
                                            projId: projId,
                                            auditerStatusFlag:"auditerStatusFlag",
                                            useFlag:true
                                            // customerId: $('#customerName').attr('customerId') || ''
                                        },
                                        page: {
                                            limit: 10,
                                            limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
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
                                        ]]
                                    });
                                    $('#search_mtl').on('click', function() {
                                        contractTable.reload({
                                            where: {
                                                contractNo: $('#contractNo').val(),
                                                customerName: $('#searchCustomerName').val(),
                                                contractName: $('#searchContractName').val(),
                                                projId: projId,
                                                auditerStatusFlag:"auditerStatusFlag",
                                            },
                                            page: {
                                                curr: 1
                                            }
                                        });
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('contractTable');

                                    if (checkStatus.data.length > 0) {
                                        var chooseData = checkStatus.data[0];

                                        $('#contractName').val(chooseData.contractName);
                                        $('#contractName').attr('contractId', chooseData.mtlContractId);
                                        $('input[name="subsettleupMoney"]', $('#baseForm')).val(retainDecimal(chooseData.settleupMoney,2)||0);

                                        $('#customerName').val(chooseData.customerName || '');
                                        $('#customerName').attr('customerId', chooseData.customerId || '');

                                        $('#contractMoney').val(retainDecimal(chooseData.contractMoney,2) || 0);

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                                    }
                                }
                            });
                        });
                    }else{
                        layer.msg("信息获取失败，请刷新重试")
                    }
                }
            })


            form.render();

            // 内部加行按钮
            table.on('toolbar(detailTable)', function (obj) {

                var mtlStockInData = [];
                var _dataa = [];

                switch (obj.event) {
                    case 'add':
                        var projId = $('#leftId').attr('projId');
                        if (!projId) {
                            var checkStatus = table.checkStatus('tableObj');
                            projId = checkStatus.data[0].projId;
                        }
                        var customerId = $('#customerName').attr('customerId');
                        if(!customerId){
                            layer.msg("请选择合同")
                            return false;
                        }
                        var mtlStockInTable = null;
                        var mtlStockInListTable = null;
                        layer.open({
                            type: 1,
                            title: '选择材料入库单',
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            area: ['80%', '80%'],
                            content: ['<div class="layui-collapse">',
                                '<div class="layui-colla-item"><h2 class="layui-colla-title">结算入库单</h2>',
                                '<div class="layui-colla-content layui-show mtlStockIn-class">',
                                '<table id="mtlStockInTable" lay-filter="mtlStockInTable"></table>',
                                '</div>',
                                '</div>',
                                '<div class="layui-colla-item"><h2 class="layui-colla-title">结算入库单明细</h2>',
                                '<div class="layui-colla-content layui-show mtl_class">',
                                '<table id="mtlStockInListTable" lay-filter="mtlStockInListTable"></table>',
                                '</div>',
                                '</div>',
                                '</div>'].join(''),
                            success: function () {
                                layElement.render();

                                mtlStockInTable = table.render({
                                    elem: '#mtlStockInTable',
                                    url: '/plbMtlStockIn/getDataByCondition',
                                    where: {
                                        projId: projId,
                                        module:"mtlSettlement",
                                        customerId:customerId,
                                        mtlContractId:$('#contractName').attr('contractId')
                                    },
                                    page: {
                                        limit: 100,
                                        limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
                                    },
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
                                        {type: 'checkbox', title: '选择'},
                                        {field: 'mtlStockInNo', title: '入库单编号', align: 'center'},
                                        {field: 'warehouseName', title: '仓库名称', align: 'center'},
                                        {field: 'customerName', title: '供应商名称', align: 'center'},
                                        {field: 'mtlContractName', title: '合同名称', align: 'center'},
                                        {field: 'stockInTotal', title: '入库总数量', align: 'center'},
                                        {field: 'stockInAmount', title: '入库总金额', align: 'center'},
                                        {field: 'stockInDate', title: '入库日期', align: 'center'}
                                    ]],
                                    done:function(res){
                                        mtlStockInData=res.data;
                                        if(warehousingArr!=undefined&&warehousingArr.length>0){
                                            var mtlStockInIdsArr=[]
                                            var mtlStockInIds = ''
                                            warehousingArr.forEach(function (v) {
                                                if(!mtlStockInIdsArr.includes(v.mtlStockInId)){
                                                    mtlStockInIdsArr.push(v.mtlStockInId)
                                                    mtlStockInIds+=v.mtlStockInId+','
                                                }
                                            })

                                            for(var i = 0 ; i <mtlStockInData.length;i++){
                                                for(var n = 0 ; n < warehousingArr.length; n++){
                                                    if(mtlStockInData[i].mtlStockInId == mtlStockInIdsArr[n]){
                                                        $('.mtlStockIn-class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').click();
                                                        //$('.mtlStockIn-class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').prop('checked', 'checked');
                                                        form.render('checkbox');
                                                    }
                                                }
                                            }
                                            var _flag = true
                                            $('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                                if(!$(item).find('.layui-form-checked').length>0){
                                                    _flag = false
                                                }
                                            })
                                            if(_flag){
                                                if(!$('.mtlStockIn-class .layui-table-header .layui-form-checked').length>0){
                                                    $('.mtlStockIn-class .layui-table-header input[type="checkbox"]').click();
                                                    form.render('checkbox');
                                                }
                                            }

                                            laodMtlStockInListTable(mtlStockInIds);
                                        }
                                    }
                                });

                                table.on('checkbox(mtlStockInTable)', function (obj) {
                                    //obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
                                    //var checkStatus = table.checkStatus('mtlStockInTable').data
                                    var _mtlStockInId = obj.data.mtlStockInId

                                    var _flag = true
                                    $('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                        if(!$(item).find('.layui-form-checked').length>0){
                                            _flag = false
                                        }
                                    })
                                    if(_flag){
                                        if(!$('.mtlStockIn-class .layui-table-header .layui-form-checked').length>0){
                                            $('.mtlStockIn-class .layui-table-header input[type="checkbox"]').click();
                                            form.render('checkbox');
                                        }

                                    }

                                    var checkStatus=[];
                                    $('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                        if($(item).find('.layui-form-checked').length>0){
                                            checkStatus.push(mtlStockInData[index]);
                                        }
                                    })
                                    var mtlStockInIds = ''
                                    checkStatus.forEach(function (v) {
                                        mtlStockInIds+=v.mtlStockInId+','
                                    })
                                    //mtlClass()
                                    laodMtlStockInListTable(mtlStockInIds,_mtlStockInId);

                                });

                                table.on('checkbox(mtlStockInListTable)', function (obj) {
                                    var _flag = true
                                    $('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                        if(!$(item).find('.layui-form-checked').length>0){
                                            _flag = false
                                        }
                                    })
                                    if(_flag){
                                        if(!$('.mtl_class .layui-table-header .layui-form-checked').length>0){
                                            $('.mtl_class .layui-table-header input[type="checkbox"]').click();
                                            form.render('checkbox');
                                        }

                                    }
                                });

                                function laodMtlStockInListTable(mtlStockInIds,_mtlStockInId) {
                                    mtlStockInListTable = table.render({
                                        elem: '#mtlStockInListTable',
                                        url: '/plbMtlStockIn/getChildList',
                                        where: {
                                            mtlStockInIds: mtlStockInIds,
                                            overMark:"overMark"
                                        },
                                        height: 'full-350',
                                        limit: 10000,
                                        // page: {
                                        //     limit: 100,
                                        //     limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
                                        // },
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
                                            {type: 'checkbox', title: '选择',LAY_CHECKED:true},
                                            {field: 'orderNo', title: '订单编号', align: 'center', minWidth: 100},
                                            {
                                                field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
                                                    return '<span wbsId="' + undefind_nullStr(d.wbsId) + '">' + undefind_nullStr(d.wbsName) + '</span>';
                                                }
                                            },
                                            {
                                                field: 'rbsName', title: 'RBS', minWidth: 160, templet: function (d) {
                                                    return '<span rbsId="' + undefind_nullStr(d.rbsId) + '">' + undefind_nullStr(d.rbsName) + '</span>';
                                                }
                                            },
                                            {
                                                field: 'cbsName', title: 'CBS', minWidth: 160, templet: function (d) {
                                                    return '<span  cbsId="' + undefind_nullStr(d.cbsId) + '">' + undefind_nullStr(d.cbsName) + '</span>';
                                                }
                                            },
                                            {field: 'mtlName', title: '材料名称', align: 'center', minWidth: 100},
                                            {field: 'mtlStandard', title: '材料规格', align: 'center', minWidth: 100},
                                            {field: 'mtlValuationUnit', title: '单位', align: 'center', minWidth: 100,templet:function(d){
                                                    return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || ''
                                                }
                                            },
                                            {field: 'stockInQuantity', title: '入库数量', align: 'center', minWidth: 100},
                                            {field: 'stockInPrice', title: '含税单价', align: 'center', minWidth: 100},
                                            {field: 'noTaxPeice', title: '不含税单价', align: 'center', minWidth: 100},
                                            {field: 'taxMoney', title: '含税总价', align: 'center', minWidth: 100},
                                            {field: 'noTaxMoney', title: '不含税总价', align: 'center', minWidth: 100}
                                        ]],
                                        done:function(res){
                                            _dataa=res.data;
                                            if(warehousingArr!=undefined&&warehousingArr.length>0){
                                                for(var i = 0 ; i <_dataa.length;i++){
                                                    var _flag = true
                                                    if(_mtlStockInId&&_dataa[i].mtlStockInId == _mtlStockInId){
                                                        _flag = false
                                                    }else{
                                                        for(var n = 0 ; n < warehousingArr.length; n++){
                                                            if(_dataa[i].stockInListId == warehousingArr[n].stockInListId){
                                                                _flag = false
                                                                // $('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").prop('checked', 'checked');
                                                            }
                                                        }
                                                    }
                                                    if(_flag){
                                                        $('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').click();
                                                        form.render('checkbox');
                                                    }
                                                }
                                                var _flagg = false
                                                $('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                                    if(!$(item).find('.layui-form-checked').length>0){
                                                        _flagg = true
                                                    }
                                                })
                                                if(_flagg){
                                                    $('.mtl_class .layui-table-header input[type="checkbox"]').click();
                                                    form.render('checkbox');
                                                }
                                            }


                                            // if(warehousingArr!=undefined&&warehousingArr.length>0){
                                            // 	for(var i = 0 ; i <_dataa.length;i++){
                                            // 		for(var n = 0 ; n < warehousingArr.length; n++){
                                            // 			if(_dataa[i].stockInListId == warehousingArr[n].stockInListId){
                                            // 				// $('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").prop('checked', 'checked');
                                            // 				$('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').prop('checked', 'checked');
                                            // 				form.render('checkbox');
                                            // 			}
                                            // 		}
                                            // 	}
                                            // }

                                        }
                                    });
                                }
                            },
                            yes: function (index) {
                                //var checkStatus = table.checkStatus('mtlStockInListTable').data;
                                var checkStatus=[];
                                $('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                    if($(item).find('.layui-form-checked').length>0){
                                        checkStatus.push(_dataa[index]);
                                    }
                                })
                                warehousingArr = checkStatus
                                //var checkStatus = mtlClass();
                                //var checkMtlStockInTable = table.checkStatus('mtlStockInTable');



                                for(var i = 0 ; i <mtlStockInData.length;i++){
                                    for(var n = 0 ; n < checkStatus.length; n++){
                                        if(mtlStockInData[i].mtlStockInId == checkStatus[n].mtlStockInId){
                                            checkStatus[n].mtlStockInNo = mtlStockInData[i].mtlStockInNo||''
                                            checkStatus[n].stockInDate = mtlStockInData[i].stockInDate||''
                                        }
                                    }
                                }

                                if (checkStatus.length > 0) {
                                    var newDataArr = [];
                                    var settlementMoney = 0;
                                    checkStatus.forEach(function(item) {
                                        var newDataObj = {
                                            mtlStockInNo:item.mtlStockInNo||'',//入库单编号
                                            orderNo:item.orderNo||'',//订单编号
                                            stockInDate:item.stockInDate||'',//入库日期
                                            stockInListId: item.stockInListId,
                                            mtlStandard: item.mtlStandard, // 材料规格
                                            mtlStockInId: item.mtlStockInId, // 材料规格
                                            mtlValuationUnit: item.mtlValuationUnit, // 单位
                                            mtlName: item.mtlName, // 材料名称
                                            wbsId: item.wbsId, // WBS id
                                            wbsName: item.wbsName, // WBS名称
                                            rbsId: item.rbsId, // RBS id
                                            rbsName: item.rbsName, // RBS名称
                                            cbsId: item.cbsId, // CBS id
                                            cbsName: item.cbsName, // CBS名称
                                            stockInQuantity: retainDecimal(item.stockInQuantity,3), // 入库数量
                                            taxPrice: retainDecimal(item.stockInPrice,3), // 含税单价
                                            noTaxMoney: retainDecimal(item.noTaxMoney,2), // 不含税总价
                                            taxMoney: retainDecimal(item.taxMoney,2), // 含税总价
                                            noTaxPrice: retainDecimal(item.noTaxPeice,8), // 不含税单价
                                            taxRate: dictionaryObj['TAX_RATE']['object'][item.taxRate]  // 税率
                                        }

                                        if (BigNumber(newDataObj.stockInQuantity).lt(0)) {
                                            newDataObj.stockInQuantity = 0;
                                        }
                                        if (BigNumber(newDataObj.taxPrice).lt(0)) {
                                            newDataObj.taxPrice = 0;
                                        }
                                        if (BigNumber(newDataObj.noTaxMoney).lt(0)) {
                                            newDataObj.noTaxMoney = 0;
                                        }
                                        if (BigNumber(newDataObj.taxMoney).lt(0)) {
                                            newDataObj.taxMoney = 0;
                                        }
                                        if (BigNumber(newDataObj.noTaxPrice).lt(0)) {
                                            newDataObj.noTaxPrice = 0;
                                        }
                                        settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(newDataObj.taxMoney));
                                        newDataArr.push(newDataObj);
                                    });

                                    //遍历表格获取每行数据进行保存
                                    /*var $tr = $('#detailModule').find('.layui-table-main tr');
                                    var oldDataArr = []
                                    $tr.each(function () {
                                        var oldDataObj = {
                                            mtlStockInNo:$(this).find('.mtl_info_mtlStockInNo').text()||'',//入库单编号
                                            stockInDate:$(this).find('.mtl_info_stockInDate').text()||'',//入库日期
                                            settleupListId: $(this).find('.mtl_info_mtlName').attr('settleupListId') || '', // 结算明细id
                                            stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
                                            wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
                                            wbsName: $(this).find('.mtl_info_wbsName').text(), // WBS名称
                                            rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
                                            rbsName: $(this).find('.mtl_info_rbsName').text(), // RBS名称
                                            cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
                                            cbsName: $(this).find('.mtl_info_cbsName').text(), // CBS名称
                                            mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
                                            mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
                                            mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
                                            stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
                                            taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
                                            noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
                                            taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
                                            noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
                                            taxRate: $(this).find('.taxRate').val() // 税率
                                        }
                                        settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(oldDataObj.taxMoney));
                                        oldDataArr.push(oldDataObj);
                                    });*/

                                    /*for(var i = 0 ; i <newDataArr.length;i++){
                                        var _flay = true
                                        for(var n = 0 ; n < oldDataArr.length; n++){
                                            if(newDataArr[i].stockInListId == oldDataArr[n].stockInListId){
                                                _flay = false
                                            }
                                        }
                                        if(_flay){
                                            oldDataArr.push(newDataArr[i])
                                        }
                                    }*/

                                    $('[name="settlementMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
                                    $('[name="confirmMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));

                                    table.reload('detailTable', {
                                        data: newDataArr,
                                        height: newDataArr&&newDataArr.length>5?'full-350':false
                                    });

                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0, time: 2000});
                                }
                            }
                        });
                        break;
                }

                // function mtlClass(){
                //     $('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                //         if($(item).find('.layui-form-checked').length>0){
                //             if(warehousingArr!=undefined&&warehousingArr.length>0){
                //                 var _flag = true
                //                 for(var j=0;j<warehousingArr.length;j++){
                //                     if(_dataa[index].stockInListId == warehousingArr[j].stockInListId){
                //                         _flag = false
                //                     }
                //                 }
                //                 if(_flag){
                //                     warehousingArr.push(_dataa[index]);
                //                 }
                //             }else {
                //                 warehousingArr.push(_dataa[index]);
                //             }
                //         }else {
                //             for(var j=0;j<warehousingArr.length;j++){
                //                 if(_dataa[index].stockInListId == warehousingArr[j].stockInListId){
                //                     warehousingArr.splice(j,1);
                //                 }
                //             }
                //         }
                //     })
                //     return warehousingArr
                // }
            });


            // 内部删行操作
            table.on('tool(detailTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;

                if (layEvent === 'del') {
                    obj.del();
                    if (data.settleupListId) {
                        $.get('/plbMtlSettleup/delPlbMtlSettleupList', {settleupListIds: data.settleupListId}, function (res) {

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $trs = $('#detailModule').find('.layui-table-main tr');
                    var oldDataArr = [];
                    var settlementMoney = 0;
                    $trs.each(function () {
                        var oldDataObj = {
                            mtlStockInNo:$(this).find('.mtl_info_mtlStockInNo').text()||'',//入库单编号
                            orderNo:$(this).find('.mtl_info_orderNo').text()||'',//订单编号
                            stockInDate:$(this).find('.mtl_info_stockInDate').text()||'',//入库日期
                            settleupListId: $(this).find('.mtl_info_mtlName').attr('settleupListId') || '', // 结算明细id
                            stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
                            mtlStockInId: $(this).find('.mtl_info_mtlName').attr('mtlStockInId') || '',
                            wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
                            wbsName: $(this).find('.mtl_info_wbsName').text(), // WBS名称
                            rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
                            rbsName: $(this).find('.mtl_info_rbsName').text(), // RBS名称
                            cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
                            cbsName: $(this).find('.mtl_info_cbsName').text(), // CBS名称
                            mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
                            mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
                            mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
                            stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
                            taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
                            noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
                            taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
                            noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
                            taxRate: $(this).find('.taxRate').val() // 税率
                        }

                        settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(oldDataObj.taxMoney));
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('detailTable', {
                        data: oldDataArr,
                        height: oldDataArr&&oldDataArr.length>5?'full-350':false,
                    });
                    $('[name="settlementMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
                    $('[name="confirmMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
                }
            });

        });
    }


    function childFunc() {
        if('0'!=_disabled){
            return true
        }
        var loadIndex = layer.load();

        var baseData = getSaveData(type, false, loadIndex, mtlSettleupId, projId).dataObj;

        var _flag = false;

        $.ajax({
            url: '/plbMtlSettleup/updatePlbMtlSettleup',
            data: JSON.stringify(baseData),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    /*layer.close(index);
                    reloadTableData();*/
                } else {
                    layer.msg(res.msg, {icon: 2});
                    _flag = true
                }
            }
        });

        if(_flag){
            return false;
        }
        return true;

    }

    /**
     * 获取需要保存的数据
     * @param saveType (1-新增, 2-编辑)
     * @param isSubmit (是否提交)
     * @param loadIndex
     * @param melOrderId
     * @param projId
     * @returns {boolean|{dataObj: {}, baseObj: {}}}
     */
    function getSaveData(saveType, isSubmit, loadIndex, mtlSettleupId, projId) {
        // 基本信息
        var datas = $('#baseForm').serializeArray();
        var dataObj = {}
        datas.forEach(function (item,) {
            dataObj[item.name] = item.value;
        });

        dataObj.mtlContractId = $('#contractName').attr('contractId') || '';
        //dataObj.contractName = $('#contractName').val();
        dataObj.customerId = $('#customerName').attr('customerId') || '';
        dataObj.customerName = $('#customerName').val();

        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        dataObj.attachmentId = attachmentId;
        dataObj.attachmentName = attachmentName;

        if (isSubmit) {
            // 判断必填项
            var requiredFlag = false;
            $('#baseForm').find('.field_required').each(function(){
                var field = $(this).attr('field');
                if (field && !dataObj[field] && dataObj[field] != '0') {
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
        }

        var baseObj = JSON.parse(JSON.stringify(dataObj));

        // 材料结算明细数据
        var $tr = $('#detailModule').find('.layui-table-main tr');
        var plbMtlSettleupLists = [];
        $tr.each(function () {
            var plbMtlSettleupObj = {
                stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
                wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
                rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
                cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
                mtlOrderLisId: $(this).find('.mtl_info_mtlOrderLisId').attr('mtlOrderLisId') || '',
                mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
                mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
                mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
                stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
                taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
                noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
                taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
                noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
                taxRate: $(this).find('.taxRate').val() // 税率
            }
            if ($(this).find('.mtl_info_mtlName').attr('settleupListId')) {
                plbMtlSettleupObj.settleupListId = $(this).find('.mtl_info_mtlName').attr('settleupListId');
            }
            plbMtlSettleupLists.push(plbMtlSettleupObj);
        });
        dataObj.plbMtlSettleupLists = plbMtlSettleupLists;

        if (saveType == 2) {
            dataObj.mtlSettleupId = mtlSettleupId;
        } else {
            dataObj.projId = projId;
        }

        return {
            dataObj: dataObj,
            baseObj: baseObj
        }
    }

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
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