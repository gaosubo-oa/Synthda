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
    <title>分包结算流程预览</title>

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
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>

    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210831"></script>

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
        .layui-col-xs4{
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
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>


<script>
    var materialDetailsTableData = [];
    var writeOffTableData = [];
    var plbMtlSubcontractOuts = [];
    var _dataa = null;

    var runId = getUrlParam('runId');
    var _disabled = getUrlParam('disabled');
    //var disabledStr = '';
    var _htm = ['<div class="layui-collapse disabledAll">\n',
        /* region 分包结算 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">分包结算</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="baseForm">',
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">分包结算编号<span field="subsettleup" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="subsettleup" readonly autocomplete="off" class="layui-input chen" title="分包结算编号" style="background: #e7e7e7" title="合同编号">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称<span field="projName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projName" readonly title="项目名称" style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chen" title="项目名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
        '                       <input type="text" name="contractName" title="合同名称" placeholder="查找分包合同" readonly autocomplete="off" class="layui-input chooseManagementBudget chen" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">分包商</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerName" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input  chooseCustomerName" title="客商单位名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="contractFee" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input" title="合同金额">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        /* region 第二行 */
        // '           <div class="layui-row">' +
        // '           </div>',
        /* endregion */
        /* region 第三行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计已结算金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text"  name="subsettleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">在途结算金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="trnSettleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次结算金额<span field="settleupMoney" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="settleupMoney" title="本次结算金额" id="settleup_Money" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chen" title="本次结算金额">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">结算日期<span  field="settleupDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="settleupDate" readonly id="settleupDate"  title="结算日期" autocomplete="off" class="layui-input chen" title="结算日期">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">备注</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* endregion */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">结算年</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" id="settleupYear" name="settleupYear" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">结算季</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select name="settleupQuarter"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">结算月</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select name="settleupMonth">' +
        '                               <option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
        '                               <option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
        '                               <option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
        '                           </select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* endregion */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">结算合同附件</label>' +
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
        /* region 分包结算明细 */
        '<div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">分包结算明细</h2>\n' +
        '<div class="layui-colla-content layui-show">' +
        '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
        '<ul class="layui-tab-title">' +
        '<li class="layui-this">结算明细</li>' +
        '<li>结算清单</li>' +
        '</ul>' +
        '<div class="layui-tab-content">' +
        '<div class="layui-tab-item layui-show mtl_info">' +
        '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
        '</div>' +
        '<div class="layui-tab-item contract_out">' +
        '<div id="paymentSettlementModule">' +
        '          <table id="writeOffTable" lay-filter="writeOffTable"></table>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>\n' +
        /* endregion */
        '</div>'].join('');


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
        CONTROL_MODE: {},
        CBS_UNIT: {},
        CONTRACT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,CONTRACT_TYPE';
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
        layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var soulTable = layui.soulTable;
            var eleTree = layui.eleTree;
            var xmSelect = layui.xmSelect;

            var materialsTable=null;


            $("#htmBox").html(_htm)
            if(runId==undefined||runId==""||runId==null){
                layer.msg("获取信息失败")
            }
            form.render();

            $.ajax({
                url:"/plbMtlSubsettleup/selectByRunId?runId="+runId,
                dataType:"json",
                type:"post",
                async:false,
                success:function(res){
                    if(res.flag){
                        var data = res.object;
                        $('#leftId').attr('projId',data.projId)
                        $('#leftId').attr('subsettleupId',data.subsettleupId)
                        $("#projectName").val(data.projNam)

                        fileuploadFn('#fileupload', $('#fileContent'));

                        materialDetailsTableData = [];
                        writeOffTableData = [];


                        form.val("baseForm", data)
                        //分包合同id
                        $('.plan_base_info input[name="contractName"]').attr('subcontractId',data.subcontractId || '');
                        //客商单位名称id
                        $('.plan_base_info input[name="customerName"]').attr('customerId',data.customerId || '');
                        if (data.attachments && data.attachments.length > 0) {

                            var fileArr = data.attachments;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }
                        materialDetailsTableData = data.plbMtlSubsettleupListWithBLOBs;
                        writeOffTableData = data.plbMtlSubsettleupDetails;



                        $.get('/plbMtlSubcontract/queryId',{subContractId:data.subcontractId},function (res) {
                            $('.plan_base_info input[name="contractName"]').val(res.object.contractName);
                            plbMtlSubcontractOuts = res.object.plbMtlSubcontractOuts
                            // $('.plan_base_info input[name="contractName"]').data('data', res.object.plbMtlSubcontractOuts);
                        })


                        element.render();
                        form.render();
                        laydate.render({
                            elem: '#settleupDate' //指定元素
                            , trigger: 'click' //采用click弹出
                            , value: data ? format(data.settleupDate) : '',
                            done:function (value, date, endDate) {
                                $('#settleupYear').val(date.year)
                                if(date.month <4){
                                    $('[name="settleupQuarter"]').val('1')
                                }else if(date.month <7){
                                    $('[name="settleupQuarter"]').val('2')
                                }else if(date.month <10){
                                    $('[name="settleupQuarter"]').val('3')
                                }else{
                                    $('[name="settleupQuarter"]').val('4')
                                }
                                $('[name="settleupMonth"]').val(date.month)
                                form.render()
                            }
                        });

                        //年选择器
                        laydate.render({
                            elem: '#settleupYear'
                            ,type: 'year'
                            , trigger: 'click' //采用click弹出
                            , value: data ? data.settleupYear : ''
                        });
                        var cols=[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'wbsName', title: 'WBS', width: 200
                            },
                            {
                                field: 'rbsName', title: 'RBS', width: 200,
                            },
                            {
                                field: 'cbsName', title: 'CBS', width: 200,
                            },
                            {
                                field: 'contractOtherContent', title: '合同明细',minWidth:100
                            },
                            {
                                field: 'contractPrice', title: '合同金额',minWidth: 100
                            },
                            {
                                field: 'conSettleupMoney', title: '累计已结算金额', width: 200,
                            },
                            /*{
                                field: 'contractOtherContent1', title: '在途结算工程量',minWidth:100
                            },*/
                            {
                                field: 'trnSettleupMoney', title: '在途结算金额',minWidth:100
                            },
                            /*{
                                field: 'settleupMoney', title: '本次结算工程量',minWidth:100, templet: function (d) {
                                    return '<input type="text" cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subsettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input " style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                                }
                            },*/
                            {
                                field: 'settleupMoney', title: '本次结算金额', minWidth: 100, templet: function (d) {
                                    return '<input type="number"  cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" rbsId="' + (d.rbsId || '') + '" subsettleupId="' +(d.subsettleupId || '')+'" subsettleupLisId="' +(d.subsettleupLisId || '')+'" subcontractOutId="' +(d.subcontractOutId || '')+'"  name="settleupMoney" title="本次结算金额" class="layui-input chen" style="height: 100%;"  value="' + (d.settleupMoney || '') + '">'
                                }
                            },
                            /*
                            {
                                field: 'conSettleupMoney', title: '累计结算金额',minWidth: 100
                            },
                            {
                                field: 'settleupMoney', title: '本次结算金额',minWidth:100, templet: function (d) {
                                    return '<input type="text" cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subsettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input " style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                                }
                            },
                            {
                                field: 'remark', title: '备注',minWidth:100, templet: function (d) {
                                    return '<input type="text" name="remark" class="layui-input" style="height: 100%;" subsettleupLisId="'+(d.subsettleupLisId || '')+'" cbsId="'+(d.cbsId || '')+'" value="' + (d.remark || '') + '">'
                                }
                            },*/
                        ]

                        var cols2=[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'quantities', title: '工程量',minWidth:140,
                                templet: function (d) {
                                    return '<input type="text"  subsettleupId="' +(d.subsettleupId || '')+'" subsettleupDetailsId="' +(d.subsettleupDetailsId || '')+'" name="quantities" class="layui-input " style="height: 100%;" value="' + (d.quantities || '')+ '">'
                                }
                            },
                            {
                                field: 'comprehensiveUnitPrice', title: '综合单价',minWidth:100,
                                templet: function (d) {
                                    return '<input type="text"   name="comprehensiveUnitPrice" class="layui-input " style="height: 100%;" value="' + (d.comprehensiveUnitPrice || '')+ '">'
                                }
                            },
                            {
                                field: 'totalPrice', title: '总价',minWidth:100,
                                templet: function (d) {
                                    return '<input type="text"   name="totalPrice" class="layui-input " style="height: 100%;" value="' + (d.totalPrice || '')+ '">'
                                }
                            },
                            {
                                field: 'sumSettlementQuantities', title: '累计已结算工程量',minWidth:140,
                                templet: function (d) {
                                    return '<input type="text" name="sumSettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.sumSettlementQuantities || '')+ '">'
                                }
                            },
                            /*{
                                field: 'onwaySettlementQuantities', title: '在途结算工程量',minWidth:100,
                                templet: function (d) {
                                    return '<input type="text"  name="onwaySettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.onwaySettlementQuantities || '')+ '">'
                                }
                            },*/
                            {
                                field: 'currentSettlementQuantities', title: '本次结算工程量',minWidth:100, templet: function (d) {
                                    return '<input type="text" name="currentSettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.currentSettlementQuantities || '') + '">'
                                }
                            },
                            {
                                field: 'onwaySettlementQuantities', title: '本次结算金额',minWidth:100, templet: function (d) {
                                    return '<input type="number" name="onwaySettlementQuantities" class="layui-input" style="height: 100%;" value="' + (d.onwaySettlementQuantities || '') + '">'
                                }
                            }
                        ]

                        if('0'==_disabled){
                            cols.push({align: 'center', toolbar: '#barDemo', fixed:'right',title: '操作', width: 100});
                            cols2.push({align: 'center', toolbar: '#barDemo', fixed:'right',title: '操作', width: 100})
                        }
                        table.render({
                            elem: '#materialDetailsTable',
                            data: materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function (obj) {
                                materialDetailsTableData = obj.data
                                if('0'!=_disabled){
                                    $('.addRow').hide()
                                }
                            }
                        });
                        table.render({
                            elem: '#writeOffTable',
                            data: writeOffTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols2],
                            done:function () {
                                if('0'!=_disabled){
                                    $('.addRow').hide()
                                }
                            }
                        });

                        if('0'!=_disabled){
                            $('.disabledAll input').attr('disabled','true')
                            //$('#baseForm input').attr('disabled','true')
                            $('#baseForm select').attr('disabled','true')
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                        }

                        form.render();
                    }else{
                        layer.msg("信息获取失败，请刷新重试")
                    }
                }
            })


            form.render();


            // 内部加行按钮
            table.on('toolbar(materialDetailsTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        // 判断分包合同
                        var subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';

                        if (!subcontractId) {
                            layer.msg('请选择分包合同', {icon: 0, time: 1500});
                            return false;
                        }
                        layer.open({
                            type: 1,
                            title: '选择',
                            area: ['70%', '60%'],
                            btnAlign: 'c',
                            btn: ['确定', '取消'],
                            content: ['<div class="layui-form" id="objectives">' +
                            //表格数据
                            '       <div style="padding: 10px">' +
                            '           <table id="mtlPlanIdTable2" lay-filter="mtlPlanIdTable2"></table>' +
                            '      </div>' +
                            '</div>'].join(''),
                            success: function () {
                                if(plbMtlSubcontractOuts){
                                    plbMtlSubcontractOuts.forEach(function(item){
                                        if(item.LAY_CHECKED){
                                            delete item.LAY_CHECKED
                                        }
                                    })
                                }

                                table.render({
                                    elem: '#mtlPlanIdTable2',
                                    //data: $('.plan_base_info input[name="contractName"]').data('data'),
                                    data:plbMtlSubcontractOuts,
                                    limit: 1000,
                                    cols: [[
                                        {type: 'checkbox', title: '选择'},
                                        {field: 'wbsName', title: 'WBS', width: 200,templet:function(d){
                                                return '<span class="subcontractOutId" subcontractOutId="' + (d.subcontractOutId || '') + '">' + d.wbsName + '</span>'
                                            }
                                        },
                                        {field:'rbsName',title:'RBS',width:200},
                                        {field: 'cbsName', title: 'CBS', width: 200,},
                                        {field: 'contractPrice', title: '合同金额',minWidth:100},
                                        {field:'contractOtherContent',title:'合同明细',minWidth:100},
                                        {
                                            field: 'settleupMoney', title: '累计结算金额',minWidth:100,templet: function (d) {
                                                return d.settleupMoney || 0
                                            }
                                        },
                                    ]],
                                    done:function(res){
                                        _dataa=res.data;
                                        if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                            for(var i = 0 ; i <_dataa.length;i++){
                                                for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                    if(_dataa[i].subcontractOutId == materialDetailsTableData[n].subcontractOutId){
                                                        $('#objectives .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                        //form.render('checkbox');
                                                    }
                                                }
                                            }
                                        }
                                        var flag = true
                                        $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                            if($(item).find('.layui-form-checked').length==0){
                                                flag=false
                                            }
                                        })
                                        if(flag){
                                            $('#objectives .layui-table-header .layui-form-checkbox').click()
                                        }
                                    }
                                });
                            },
                            yes: function (index) {

                                var checkStatus=[];
                                $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                    if($(item).find('.layui-form-checked').length>0){
                                        checkStatus.push(_dataa[index]);
                                    }
                                })

                                //checkStatus = table.checkStatus('mtlPlanIdTable2').data;


                                if (checkStatus.length > 0) {

                                    for(var i=0;i<checkStatus.length;i++){
                                        var addRowData = {
                                            cbsName: checkStatus[i].cbsName,
                                            cbsId: checkStatus[i].cbsId,
                                            rbsName:checkStatus[i].rbsName,
                                            rbsId:checkStatus[i].rbsId,
                                            wbsName: checkStatus[i].wbsName,
                                            wbsId: checkStatus[i].wbsId,
                                            contractOtherContent:checkStatus[i].contractOtherContent,
                                            contractPrice: checkStatus[i].contractPrice,
                                            conSettleupMoney: checkStatus[i].settleupMoney || 0,
                                            trnSettleupMoney: checkStatus[i].trnSettleupMoney || 0,
                                            subcontractOutId:checkStatus[i].subcontractOutId
                                        }

                                        if(materialDetailsTableData){
                                            var _flag = true
                                            for(var j=0;j<materialDetailsTableData.length;j++){
                                                if(materialDetailsTableData[j].subcontractOutId==checkStatus[i].subcontractOutId){
                                                    _flag = false
                                                }
                                            }
                                            if(_flag){
                                                materialDetailsTableData.push(addRowData);
                                            }

                                        }else{
                                            materialDetailsTableData.push(addRowData);
                                        }
                                    }


                                    table.reload('materialDetailsTable', {
                                        data: materialDetailsTableData
                                    });


                                    layer.close(index);


                                    /*var chooseData = checkStatus.data[0];

                                    //遍历表格获取每行数据进行保存
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var oldDataArr = [];
                                    $tr.each(function () {
                                        var oldDataObj = {
                                            contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                                            conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                                            settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                                            remark: $(this).find('[name="remark"]').val(),
                                            // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                            cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                                            subsettleupLisId: $(this).find('[name="remark"]').attr('subsettleupLisId'),
                                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                                            wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                                            subcontractOutId:$(this).find('.subcontractOutId').attr('subcontractOutId')
                                        }
                                        oldDataArr.push(oldDataObj);
                                    });
                                    var addRowData = {
                                        cbsName: chooseData.cbsName,
                                        cbsId: chooseData.cbsId,
                                        rbsName:chooseData.rbsName,
                                        wbsName: chooseData.wbsName,
                                        wbsId: chooseData.wbsId,
                                        contractOtherContent:chooseData.contractOtherContent,
                                        contractPrice: chooseData.contractPrice,
                                        conSettleupMoney: chooseData.settleupMoney || 0,
                                        subcontractOutId:chooseData.subcontractOutId,
                                    };
                                    oldDataArr.push(addRowData);
                                    table.reload('materialDetailsTable', {
                                        data: oldDataArr
                                    });

                                    layer.close(index);*/
                                } else {
                                    layer.msg('请选择一项！', {icon: 0, time: 2000});
                                }
                            }
                        });
                        break;
                }
            });
            // 内部删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data
                var layEvent = obj.event;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.subsettleupLisId) {
                        $.get('/plbMtlSubsettleup/delPlbMtlSubsettleupList', {subSettleupLisIds: data.subsettleupLisId}, function (res) {

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            contractOtherContent: $(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                            contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                            conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                            trnSettleupMoney: $(this).find('[data-field="trnSettleupMoney"] .layui-table-cell').text(),
                            settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                            //remark: $(this).find('[name="remark"]').val(),
                            // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                            cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                            rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                            rbsId: $(this).find('[name="settleupMoney"]').attr('rbsId'),
                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                            wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                            subsettleupLisId: $(this).find('[name="settleupMoney"]').attr('subsettleupLisId'),
                            subsettleupId: $(this).find('[name="settleupMoney"]').attr('subsettleupId'),
                            subcontractOutId: $(this).find('[name="settleupMoney"]').attr('subcontractOutId')
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                }
            });

            table.on('toolbar(writeOffTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.contract_out').find('.layui-table-main tr');
                        var oldDataArr = [];

                        $tr.each(function () {
                            var oldDataObj = {
                                subsettleupId: $(this).find('input[name="quantities"]').attr('subsettleupId') || '',
                                subsettleupDetailsId: $(this).find('input[name="quantities"]').attr('subsettleupDetailsId') || '',
                                quantities: $(this).find('input[name="quantities"]').val(),
                                comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                                totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                                onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                                currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        oldDataArr.push({});
                        table.reload('writeOffTable', {
                            data: oldDataArr
                        });
                        break;
                }
            });
            // 内部-合同清单-删行操作
            table.on('tool(writeOffTable)', function (obj) {

                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.subsettleupDetailsId) {
                        $.get('/plbMtlSubsettleup/deleteDetail', {ids: data.subsettleupDetailsId}, function () {
                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $trs = $('.contract_out').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $trs.each(function () {
                        var oldDataObj = {
                            subsettleupId: $(this).find('input[name="quantities"]').attr('subsettleupId') || '',
                            subsettleupDetailsId: $(this).find('input[name="quantities"]').attr('subsettleupDetailsId') || '',
                            quantities: $(this).find('input[name="quantities"]').val(),
                            comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                            sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                            onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                            currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                        }
                        oldDataArr.push(oldDataObj);
                    })
                    table.reload('writeOffTable', {
                        data: oldDataArr
                    });
                }
            });

            // 点击选分包合同
            $(document).on('click', '.chooseManagementBudget', function () {
                // if(!$('#baseForm [name="customerName"]').attr('customerId')){
                //     layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                //     return false
                // }
                var contractTableObj = null
                layer.open({
                    type: 1,
                    title: '选择分包合同',
                    area: ['80%', '80%'],
                    maxmin: true,
                    btnAlign:'c',
                    btn: ['确定', '取消'],
                    content: ['<div class="layui-form" id="contractTableModule">' +
                    '<div class="layui-row" style="margin-top: 10px;margin-left: 5px">' +
                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractNo" type="text" autocomplete="off" placeholder="合同编号" class="layui-input" /></div>' +
                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractName" type="text" autocomplete="off" placeholder="合同名称" class="layui-input" /></div>' +
                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="customerName" type="text" autocomplete="off" placeholder="分包商" class="layui-input" /></div>' +
                    '<div class="layui-col-xs3" style="padding-top: 3px;"><button class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
                    '</div>' +
                    //表格数据
                    '       <div style="padding: 10px">' +
                    '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                    '      </div>' +
                    '</div>'].join(''),
                    success: function () {

                        contractTableObj = table.render({
                            elem: '#mtlPlanIdTable',
                            url: '/plbMtlSubcontract/selectAll',
                            where:{projId:$('#leftId').attr('projId'),approvalStatus:"2"},
                            page:true,
                            cols: [[
                                {type: 'radio'},
                                {field: 'subcontractNo', title: '合同编号', sort: true, hide: false},
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
                                {field: 'settleupMoney', title: '累计已结算金额',templet: function (d) {
                                        return d.settleupMoney || 0
                                    }
                                }
                            ]],
                            parseData: function(res){ //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "count": res.totleNum, //解析数据长度
                                    "data": res.obj //解析数据列表
                                };
                            }
                        });

                        $('#searchContract').on('click', function () {
                            var contractNo = $('#contractTableModule input[name="contractNo"]').val();
                            var contractName = $('#contractTableModule input[name="contractName"]').val();
                            var customerName=$('#contractTableModule input[name="customerName"]').val();
                            contractTableObj.reload({
                                where: {
                                    contractNo: contractNo,
                                    contractName: contractName,
                                    customerName:customerName
                                }
                            });
                        });
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('mtlPlanIdTable')
                        if (checkStatus.data.length > 0) {
                            var chooseData = checkStatus.data[0];
                            $('#baseForm [name="contractName"]').val(chooseData.contractName)
                            $('#baseForm [name="contractName"]').attr('subcontractId',chooseData.subcontractId)
                            //$('#baseForm [name="contractName"]').data('data',chooseData.plbMtlSubcontractOuts)
                            plbMtlSubcontractOuts = chooseData.plbMtlSubcontractOuts
                            $('#baseForm [name="customerName"]').val(chooseData.customerName);
                            $('#baseForm [name="customerName"]').attr("customerId",chooseData.customerId);
                            //合同金额
                            $('#baseForm [name="contractFee"]').val(chooseData.contractMoney)

                            //累计已结算金额
                            $('#baseForm [name="subsettleupMoney"]').val(chooseData.settleupMoney || 0)

                            $('#baseForm [name="trnSettleupMoney"]').val(chooseData.trnSettleupMoney || 0)

                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0, time: 2000});
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

            //监听本次结算金额
            $(document).on('input propertychange', '[name="settleupMoney"]', function () {
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var settleupMoneySum=0
                $tr.each(function () {
                    settleupMoneySum=accAdd(settleupMoneySum,$(this).find('input[name="settleupMoney"]').val())
                });
                $('#baseForm #settleup_Money').val(settleupMoneySum)
            });
        });
    }


    function childFunc() {
        if('0'!=_disabled){
            return true
        }

        //必填项提示
        for (var i = 0; i < $('.chen').length; i++) {
            if ($('.chen').eq(i).val() == '') {
                layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
                return false
            }
        }
        //提示输入框只能输入数字
        for(var a = 0;a < $('.chinese').length;a++) {
            if (isNaN($('.chinese').eq(a).val())) {
                layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                return false
            }
        }


        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        //分包合同id
        obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
        //客商单位名称id
        obj.customerId=$('.plan_base_info input[name="customerName"]').attr('customerId');

        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;


        var isFlag = false;
        //主表控制逻辑
        //合同金额-累计已结算-在途结算>=本次结算
        //合同金额
        var contractFee = $('#baseForm [name="contractFee"]').val()||0
        //累计已结算
        var subsettleupMoney = $('#baseForm [name="subsettleupMoney"]').val()||0
        //在途结算
        var subsettleupMoney = $('#baseForm [name="trnSettleupMoney"]').val()||0
        //本次结算
        var settleupMoney = $('#baseForm [name="settleupMoney"]').val()||0

        if(sub(sub(contractFee,subsettleupMoney),subsettleupMoney)<settleupMoney){
            layer.msg('合同金额(主表)-累计已结算(主表)-在途结算(主表)>=本次结算(主表)！', {icon: 0, time: 3000});
            isFlag = true
        }

        //分包结算数据
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            var materialDetailsObj = {
                contractOtherContent: $(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                trnSettleupMoney: $(this).find('[data-field="trnSettleupMoney"] .layui-table-cell').text(),
                settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                rbsId: $(this).find('[name="settleupMoney"]').attr('rbsId'),
                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
            }
            if ($(this).find('[name="settleupMoney"]').attr('subsettleupLisId')) {
                materialDetailsObj.subsettleupLisId = $(this).find('[name="settleupMoney"]').attr('subsettleupLisId');
            }
            if ($(this).find('[name="settleupMoney"]').attr('subsettleupId')) {
                materialDetailsObj.subsettleupId = $(this).find('[name="settleupMoney"]').attr('subsettleupId');
            }
            if ($(this).find('[name="settleupMoney"]').attr('subcontractOutId')) {
                materialDetailsObj.subcontractOutId = $(this).find('[name="settleupMoney"]').attr('subcontractOutId');
            }
            //子表控制逻辑
            if(sub(sub(materialDetailsObj.contractPrice,materialDetailsObj.conSettleupMoney),materialDetailsObj.trnSettleupMoney)<materialDetailsObj.settleupMoney){
                layer.msg('合同金额(子表)-累计已结算(子表)-在途结算(子表)>=本次结算(子表)！', {icon: 0, time: 3000});
                isFlag = true
            }

            materialDetailsArr.push(materialDetailsObj);
        });
        obj.plbMtlSubsettleupListWithBLOBs = materialDetailsArr;


        if (isFlag){
            return false
        }

        //结算清单
        var $tr2 = $('.contract_out').find('.layui-table-main tr');
        var oldDataArr = [];

        $tr2.each(function () {
            var oldDataObj = {
                quantities: $(this).find('input[name="quantities"]').val(),
                comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                totalPrice: $(this).find('input[name="totalPrice"]').val(),
                sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
            }
            if ($(this).find('input[name="quantities"]').attr('subsettleupId')) {
                oldDataObj.subsettleupId = $(this).find('input[name="quantities"]').attr('subsettleupId');
            }
            if ($(this).find('input[name="quantities"]').attr('subsettleupDetailsId')) {
                oldDataObj.subsettleupDetailsId = $(this).find('input[name="quantities"]').attr('subsettleupDetailsId');
            }
            oldDataArr.push(oldDataObj);
        });

        obj.plbMtlSubsettleupDetails = oldDataArr;

        obj.projId = parseInt($('#leftId').attr('projId'));

        obj.subsettleupId = $('#leftId').attr('subsettleupId');

        var loadIndex = layer.load();

        var _flag = false;

        $.ajax({
            url: '/plbMtlSubsettleup/updatePlbMtlSubsettleup',
            data: JSON.stringify(obj),
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

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }

</script>
</body>
</html>