<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/5/10
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>合同变更审批表单操作</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210421.1"></script>

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

        /*.wrapper {*/
        /*    position: absolute;*/
        /*    top: 0;*/
        /*    left: 0;*/
        /*    bottom: 60px;*/
        /*    width: 100%;*/
        /*    padding: 8px;*/
        /*    box-sizing: border-box;*/
        /*    overflow: auto;*/
        /*}*/

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

        .wrap_left {
            position: relative;
            float: left;
            width: 230px;
            height: 100%;
            padding-right: 10px;
            box-sizing: border-box;
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

        .del_trip_btn {
            position: absolute;
            top: 10px;
            right: 20px;
            cursor: pointer;
            z-index: 1;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 8%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" value="">
    <input type="hidden" id="01" value="">
    <input type="hidden" id="02" value="">
    <input type="hidden" id="04" value="">
    <div class="wrapper">
        <h2 class="layui-colla-title">基本信息</h2>
        <div class="layui-form" id="baseForm" lay-filter="baseForm">
        </div>
    </div>
</div>
</body>
<script>
    var runId =  $.GetRequest()['runId'] || '';
    var dictionaryObj = {
        CONTRACT_TYPE: {},
        PAYMENT_METHOD: {},
        TAX_RATE: {},
        INVOICE_TYPE: {},
    }
    var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,TAX_RATE,INVOICE_TYPE';
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
        if(runId!=null){
            $.get('/plbDeptSubcontract/queryHistoryVersionByRunId', {runId: runId, reviseType:'06'}, function (res) {
                var list = []
                if (res.flag) {
                    for (var i = 0;i<res.data.length;i++){
                        var content = ['<div class="layui-collapse">\n',
                            /* region 材料计划 */
                            '  <div class="layui-colla-item">\n' +
                            '    <h2 class="layui-colla-title">'+res.data[i].version+'</h2>\n' +
                            '    <div class="layui-colla-content layui-show plan_base_info">' +
                            '       <form class="layui-form" id="baseForm" lay-filter="formContentTest'+ i +'">',
                            /* region 第一行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            /*'                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull"  title="合同编号">\n' +
                            '                       </div>\n' +
                            '                   </div>' +*/
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同编号">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="contractName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同金额(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同金额(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第二行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="bondRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="履约金比例">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">质保期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="warrantyPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="质保期">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="warrantyRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="质保金比例">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第三行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">甲方</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="contractA" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">乙方</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="customerId" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">发票类型</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                        <select name="invoiceType" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>' +
                            /* endregion */
                            /* region 第四行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">付款方式</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                        <select name="paymentType" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同类型</label>\n' +
                            '                       <div class="layui-input-block form_block" name="noEditSelect">\n' +
                            '                        <select name="contractType" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly style="background: #e7e7e7" name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第五行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同有效期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="contractPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同工期">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">预付款(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="paymentPre" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="预付款(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">税率</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <select name="taxRate" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第六行*/
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">不含税合同价(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="contractMoneyNotax" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="不含税合同价(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">押金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="depositRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">履约保证金(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="bondCash" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input  chinese" title="履约保证金(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '            </div>' +
                            /* endregion */
                            /* region 第七行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">比价附件</label>' +
                            '                       <div class="layui-input-block form_block">' +
                            '<div class="file_module">' +
                            '<div id="fileContent2" class="file_content"></div>' +
                            '<div class="file_upload_box">' +
                            '<a href="javascript:;" class="open_file">' +
                            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '<input type="file" multiple id="fileupload2" data-url="/upload?module=planbudget" name="file">' +
                            '</a>' +
                            '<div class="progress">' +
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
                            /* region 第八行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同附件</label>' +
                            '                       <div class="layui-input-block form_block">' +
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
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            '       </form>' +
                            '    </div>\n' +
                            '  </div>\n',
                            /* endregion */
                            /* region 合同明细 */
                            /* endregion */
                            '</div>'].join('')
                        list += content
                    }
                    $('#baseForm').html(list);
                    initPage(res);
                } else {
                    var content = ['<div class="layui-collapse">\n',
                        /* region 材料计划 */
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">'+res.data[i].version+'</h2>\n' +
                        '    <div class="layui-colla-content layui-show plan_base_info">' +
                        '       <form class="layui-form" id="baseForm" lay-filter="formContentTest'+ i +'">',
                        /* region 第一行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        /*'                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull"  title="合同编号">\n' +
                        '                       </div>\n' +
                        '                   </div>' +*/
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同编号">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="contractName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同金额(元)</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input  chinese" title="合同金额(元)">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        /* endregion */
                        /* region 第二行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="bondRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="履约金比例">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">质保期</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="warrantyPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="质保期">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="warrantyRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="质保金比例">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        /* endregion */
                        /* region 第三行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">甲方</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="contractA" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">乙方</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">发票类型</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                        <select name="invoiceType" disabled></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' +
                        /* endregion */
                        /* region 第四行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">付款方式</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                        <select name="paymentType" disabled></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同类型</label>\n' +
                        '                       <div class="layui-input-block form_block" name="noEditSelect">\n' +
                        '                        <select name="contractType" disabled></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" readonly style="background: #e7e7e7" name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        /* endregion */
                        /* region 第五行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同有效期</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="contractPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同工期">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">预付款(元)</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="paymentPre" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="预付款(元)">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">税率</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <select name="taxRate" disabled></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        /* endregion */
                        /* region 第六行*/
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">不含税合同价(元)</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="contractMoneyNotax" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="不含税合同价(元)">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">押金比例</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="depositRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">履约保证金(元)</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="number" name="bondCash" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input  chinese" title="履约保证金(元)">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '            </div>' +
                        /* endregion */
                        /* region 第七行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">比价附件</label>' +
                        '                       <div class="layui-input-block form_block">' +
                        '<div class="file_module">' +
                        '<div id="fileContent2" class="file_content"></div>' +
                        '<div class="file_upload_box">' +
                        '<a href="javascript:;" class="open_file">' +
                        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '<input type="file" multiple id="fileupload2" data-url="/upload?module=planbudget" name="file">' +
                        '</a>' +
                        '<div class="progress">' +
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
                        /* region 第八行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">合同附件</label>' +
                        '                       <div class="layui-input-block form_block">' +
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
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        /* endregion */
                        '       </form>' +
                        '    </div>\n' +
                        '  </div>\n',
                        /* endregion */
                        /* region 合同明细 */
                        /* endregion */
                        '</div>'].join('')
                    $('#baseForm').html(content);
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
    });

    function initPage(contractChangeInfo) {
        layui.use(['form', 'table', 'element', 'laydate', 'eleTree'], function() {
            var layTable = layui.table,
                layElement = layui.element,
                laydate = layui.laydate,
                layForm = layui.form,
                eleTree = layui.eleTree;


            // layElement.render();

            $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])
            $('[name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str'])
            $('[name="taxRate"]').html(dictionaryObj['TAX_RATE']['str'])
            $('[name="invoiceType"]').html(dictionaryObj['INVOICE_TYPE']['str'])
            for (var i = 0;i<contractChangeInfo.data.length;i++){
                // console.log(contractChangeInfo.data[i])
                layForm.val("formContentTest"+i, contractChangeInfo.data[i]);
            }
            layElement.render();
            layForm.render();


        })
    }
</script>
<script type="text/javascript" src="/js/editIEprint/index.js?20210811.2"></script>

</html>
