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
    <title>分包合同预览</title>

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
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.11"></script>

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

        .layui-collapse .layui_col {
            width: 20% !important;
            padding: 0 5px;
        }
    </style>
</head>
<body>
<div class="container" id="_preview">

</div>



<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="plbMtlContrastBar">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="choosePlbMtlContrast">选择分包比价</button>
    </div>
</script>

<script type="text/html" id="contTool">
    <a class="layui-btn layui-btn-xs" lay-event="info">比价详情</a>
</script>

<script>
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var runId = getUrlParam('runId');
    var _disabled = getUrlParam('disabled');
    var type = null;
    if('1'==_disabled){
        type = '1'
    }else {
        type = '4'
    }

    var _html = ['<div class="layui-collapse">\n',
        /* region 材料计划 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">分包合同</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="documentNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="单据号">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contractName" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同编号<span field="subcontractNo" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="subcontractNo" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同类型</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                        <select name="contractType"></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>',
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">甲方<span field="contractA" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contractA" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input testNull choose_Equivalent" title="甲方">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">乙方<span field="customerId" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input testNull choose_Equivalent" title="乙方">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同金额(元)<span field="contractMoney" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="contractMoney" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input testNull chinese" title="合同金额(元)">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">预付款</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="paymentPre" autocomplete="off" class="layui-input chinese" title="预付款">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">税率</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select name="taxRate" lay-filter="taxRate">' +
        '                               <option value=""></option>' +
        '                               <option value="0">0</option>' +
        '                               <option value="1">1</option>' +
        '                               <option value="3">3</option>' +
        '                               <option value="6">6</option>' +
        '                               <option value="9">9</option>' +
        '                               <option value="10">10</option>' +
        '                               <option value="13">13</option>' +
        '                           </select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>',
        /* endregion */
        /* region 第三行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">不含税合同价</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="contractMoneyNotax" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input chinese" title="不含税合同价">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同工期</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contractPeriod" autocomplete="off" class="layui-input" title="合同工期">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">质保期</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="warrantyPeriod" autocomplete="off" class="layui-input" title="质保期">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="bondRatio" autocomplete="off" class="layui-input chinese" title="履约金比例">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="warrantyRatio" autocomplete="off" class="layui-input chinese" title="质保金比例">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +*/
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">质保金</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="warrantyCash" autocomplete="off" class="layui-input chinese" title="质保金">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">发票类型</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                        <select name="invoiceType" id="invoiceType"></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同类别<span field="contractCategory" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                        <select name="contractCategory"><option value="">请选择</option></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">' +
        '                       <label class="layui-form-label form_label">备注</label>' +
        '                       <div class="layui-input-block form_block">' +
        '                       <input type="text" name="remark" autocomplete="off" class="layui-input">' +
        '                       </div>' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        /* region 第四行*/
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
        '                   <ul class="layui-tab-title">' +
        '                   <li class="layui-this">合同内容</li>' +
        '                   <li>合同范围</li>' +
        '                   <li>付款方式</li>' +
        '                   </ul>' +
        '                   <div class="layui-tab-content">' +
        '                   <div class="layui-tab-item layui-show contract_list">' +
        '                   <textarea name="contractContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
        '                   </div>' +
        '                   <div class="layui-tab-item contract_out">' +
        '                   <textarea name="contractScope" placeholder="请输入内容" class="layui-textarea"></textarea>' +
        '                   </div>' +
        '                   <div class="layui-tab-item">' +
        '                   <textarea name="paymentType" placeholder="请输入内容" class="layui-textarea"></textarea>' +
        '                   </div>' +
        '                   </div>' +
        '                   </div>' +
        '               </div>' +
        /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">付款方式</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                        <select name="paymentType"></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +*/
        /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">履约保证金</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="number" name="bondCash" autocomplete="off" class="layui-input  chinese" title="履约保证金">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +*/
        '            </div>' +
        /* endregion */
        /* region 第五行 */
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
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">明细</h2>\n' +
        '    <div class="layui-colla-content mtl_info layui-show">' +
        '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
        '<ul class="layui-tab-title">' +
        '<li class="layui-this">合同明细</li>' +
        '<li>合同清单</li>' +
        '</ul>' +
        '<div class="layui-tab-content">' +
        '<div class="layui-tab-item layui-show contract_list">' +
        '<div id="contractDetailsModule"><table id="materialDetailsTable" lay-filter="materialDetailsTable"></table></div>' +
        '</div>' +
        '<div class="layui-tab-item contract_out">' +
        '<div id="paymentSettlementModule"><table id="paymentSettlementTable" lay-filter="paymentSettlementTable"></table></div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        /*'       <div>' +
        '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
        '      </div>' +*/
        '    </div>\n' +
        '  </div>\n',
        /* endregion */
        /* region 供应商比价 */
        '<div class="layui-colla-item"><h2 class="layui-colla-title">分包比价</h2>' +
        '<div class="layui-colla-content layui-show">',
        '<div><table id="plbMtlContrastTable" lay-filter="plbMtlContrastTable"></table>' +
        '</div>',
        '</div>' +
        '</div>',
        /* endregion */
        '</div>'].join('');

    var materialDetailsTableData = [];
    var paymentSettlementTableData = [];
    var mtlSubpackageData = null;

    var _dataa = null;


    //明细表头
    var detailCols = [
        {field: 'customerUnit1', title: '分包商1单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit1" autocomplete="off"  class="layui-input customerUnitItem customerUnit1Item" style="height: 100%;" value="' + (d.customerUnit1 || '') + '">'
            }},
        {field: 'customerUnit2', title: '分包商2单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit2" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit2 || '') + '">'
            }},
        {field: 'customerUnit3', title: '分包商3单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit3" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit3 || '') + '">'
            }},
        {field: 'customerUnit4', title: '分包商4单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit4" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit4 || '') + '">'
            }},
        {field: 'customerUnit5', title: '分包商5单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit5" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit5 || '') + '">'
            }},
        {field: 'customerUnit6', title: '分包商6单价', width: 150,hide: true, templet: function (d) {return '<input type="number" name="customerUnit6" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit6 || '') + '">'}},
        {field: 'customerUnit7', title: '分包商7单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit7" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit7 || '') + '">'
            }},
        {field: 'customerUnit8', title: '分包商8单价', width: 150,hide: true, templet: function (d) {return '<input type="number" name="customerUnit8" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit8 || '') + '">'}},
    ]


    var dictionaryObj = {
        CONTRACT_TYPE: {},
        PAYMENT_METHOD: {},
        CONTROL_TYPE:{},
        CBS_UNIT:{},
        INVOICE_TYPE:{},
        COMPARE_TYPE:{},
        CONTRACT_CATEGORY:{}
    }
    var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,CONTROL_TYPE,CBS_UNIT,INVOICE_TYPE,COMPARE_TYPE,CONTRACT_CATEGORY';
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
    });
    $.ajaxSettings.async = true;
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;

        $('#_preview').html(_html);

        if(runId==undefined||runId==""||runId==null){
            layer.msg("获取信息失败")
        }
        form.render();

        $.ajax({
            url:"/plbMtlSubcontract/queryId?runId="+runId,
            dataType:"json",
            type:"post",
            async:false,
            success:function(res){
                if(res.flag){
                    data = res.object;

                    //回显项目名称
                    getProjName('#projectName',(data.projId))
                    //付款方式、合同类型、合同类别
                    $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])
                    $('[name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str'])
                    $('[name="contractCategory"]').append(dictionaryObj['CONTRACT_CATEGORY']['str'])

                    form.on('select(taxRate)', function(data){
                        // console.log(data.value); //得到被选中的值
                        if(data.value && $('#baseForm [name="contractMoney"]').val()){
                            var taxRate=data.value * 0.01
                            var contractMoney=$('#baseForm [name="contractMoney"]').val()
                            $('#baseForm [name="contractMoneyNotax"]').val(keepTwoDecimalFull(contractMoney / (1+taxRate)))
                        }
                    });

                    var optionStr = '<option value="">请选择</option>'
                    optionStr += dictionaryObj.INVOICE_TYPE.str
                    $('#invoiceType').append(optionStr)


                    fileuploadFn('#fileupload', $('#fileContent'));

                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);
                        $('[name="contractA"]').val(data.contractAName || '')
                        $('[name="contractA"]').attr('customerId',data.contractA || '')
                        $('[name="customerId"]').val(data.customerName || '')
                        $('[name="customerId"]').attr('customerId',data.customerId || '')

                        //附件
                        if (data.attachment && data.attachment.length > 0) {
                            var fileArr = data.attachment;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }

                        //合同明细
                        materialDetailsTableData = data.plbMtlSubcontractOuts;
                        // 合同清单
                        paymentSettlementTableData = data.plbMtlSubcontractLists;
                        //分包比价
                        mtlSubpackageData = data.mtlSubpackage;


                        //查看详情
                        if(type!=4){
                            //$('.layui-layer-btn-c').hide()
                            $('#baseForm input').attr('disabled','true')
                            $('textarea').attr('readonly','readonly')
                            //$('[name="contractOtherContent"]').attr('disabled','true')
                            $('.file_upload_box').hide()
                            $('select').attr("disabled","disabled")
                            $('.deImgs').hide()

                        }
                    }

                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#signDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.signDate) : ''
                    });

                    var cols=[
                        {type: 'numbers', title: '操作'},
                        {
                            field: 'wbsName', title: 'WBS', minWidth: 200,
                        },
                        {
                            field: 'rbsName', title: 'RBS', minWidth: 200,
                        },
                        {
                            field: 'cbsName', title: 'CBS', minWidth: 200,
                        },
                        {
                            field: 'manageTarAmount', title: '管理目标金额',minWidth:130,
                        },
                        {
                            field: 'accumulatedSignedContractAmount', title: '累计已签合同金额',minWidth:160,
                        },{
                            field: 'trnOutMoney', title: '在途合同价',minWidth:160,
                        },
                        {
                            field: 'contractPrice', title: '*本次合同价',
                            templet: function (d) {
                                return '<input type="number" '+(type==4||type==5 ? 'readonly' : '')+'  name="contractPrice" subcontractId="'+(d.subcontractId||'')+'" subcontractOutId="'+(d.subcontractOutId||'')+'" projBudgetId="'+(d.projBudgetId||'')+'" cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" rbsId="' + (d.rbsId || '') + '" class="layui-input contractPriceItem testNull" title="本次合同价" style="height: 100%;" value="' + (d.contractPrice || '')+ '">'
                            }
                        },
                        {
                            field: 'contractOtherContent', title: '合同明细',
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+'   name="contractOtherContent" class="layui-input " style="height: 100%;" value="' + (d.contractOtherContent || '')+ '">'
                            }
                        }
                    ]
                    var colsPaymentSettlement=[
                        {type: 'numbers', title: '序号'},
                        {
                            field: 'subcontractContent', title: '合同明细',minWidth:140,
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+' subcontractId="' + (d.subcontractId || '')+ '" subcontractListId="'+d.subcontractListId+'" projBudgetId="'+d.projBudgetId+'" name="subcontractContent" class="layui-input " style="height: 100%;" value="' + (d.subcontractContent || '')+ '">'
                            }
                        },
                        {
                            field: 'subcontractUnit', title: '单位',minWidth:100,
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+'  name="subcontractUnit" class="layui-input " style="height: 100%;" value="' + (d.subcontractUnit || '')+ '">'
                            }
                        },
                        {
                            field: 'quantities', title: '工程量',minWidth:140,
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+'   name="quantities" class="layui-input " style="height: 100%;" value="' + (d.quantities || '')+ '">'
                            }
                        },
                        {
                            field: 'comprehensiveUnitPrice', title: '综合单价',minWidth:100,
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+'   name="comprehensiveUnitPrice" class="layui-input " style="height: 100%;" value="' + (d.comprehensiveUnitPrice || '')+ '">'
                            }
                        },
                        {
                            field: 'totalPrice', title: '合价',minWidth:100,
                            templet: function (d) {
                                return '<input type="text" '+(type!=4 ? 'readonly' : '')+'   name="totalPrice" class="layui-input " style="height: 100%;" value="' + (d.totalPrice || '')+ '">'
                            }
                        }
                        /*{
                            field: 'contractMoney', title: '约定付款金额', templet: function (d) {
                                return '<input type="number" '+(type==4 ? 'readonly' : '')+' mtlSubcontractPayId="' + (d.mtlSubcontractPayId || '') + '" name="contractMoney" class="layui-input contractMoney" style="height: 100%;" value="' + (d.contractMoney || '') + '">'
                            }
                        },
                        {
                            field: 'contractRatio', title: '约定付款比例', templet: function (d) {
                                return '<input type="number" '+(type==4 ? 'readonly' : '')+' name="contractRatio" class="layui-input contractRatio" style="height: 100%" value="' + (d.contractRatio || '') + '">'
                            }
                        },
                        {
                            field: 'paymentPeriod', title: '约定付款日期', templet: function (d) {
                                return '<input type="text" name="paymentPeriod" '+(type==4 ? 'disabled' : 'readonly')+' class="layui-input paymentPeriod" style="height: 100%;" value="' + (d.paymentPeriod || '') + '">'
                            }
                        },
                        {
                            field: 'termOfPayment', title: '付款条件', templet: function (d) {
                                return '<input type="text" '+(type==4 ? 'readonly' : '')+' name="termOfPayment" class="layui-input termOfPayment" style="height: 100%;" value="' + (d.termOfPayment || '') + '">'
                            }
                        },*/
                    ]
                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100,fixed:'right'})
                        colsPaymentSettlement.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100,fixed:'right'})
                    }
                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData||[],
                        toolbar: type==4?false:'#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function () {
                            if(type==4){
                                $('.addRow').hide()
                            }
                        }
                    });
                    table.render({
                        elem: '#paymentSettlementTable',
                        data: paymentSettlementTableData||[],
                        toolbar: type==4?false:'#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [colsPaymentSettlement],
                        done:function (res) {
                            if(type==4){
                                $('.addRow').hide()
                            }
                            var datas = res.data;
                            $('.contract_out').find('.paymentPeriod').each(function (i, v) {
                                laydate.render({
                                    elem: v,
                                    trigger: 'click',
                                    value: datas[i].paymentPeriod || ''
                                });
                            });
                        }
                    });
                    // 初始化供应商比价
                    table.render({
                        elem: '#plbMtlContrastTable',
                        data: mtlSubpackageData?[mtlSubpackageData]:[],
                        toolbar: type==4?false:'#plbMtlContrastBar',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [[
                            {type: 'numbers', title: '序号'},
                            {field: 'subpackageNo', title: '比价编号'},
                            {field: 'priceComparison', title: '比价事项'},
                            {
                                field: 'compareTime', title: '比价时间', templet: function (d) {
                                    return format(d.compareTime);
                                }
                            },
                            {
                                field: 'compareType', title: '比价方式', templet: function (d) {
                                    return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || '';
                                }
                            },
                            {field: 'remark', title: '备注'},
                            {align: 'center', toolbar: '#contTool', title: '操作',fixed:'right'}
                        ]]
                    });


                    form.render();
                }else{
                    layer.msg("信息获取失败，请刷新重试")
                }
            }
        })

        //监听本次合同价之和赋值给合同金额
        $(document).on('blur', '.contractPriceItem', function () {
            var $tr = $('.contract_list').find('.layui-table-main tr');
            var contractMoney=0
            $tr.each(function () {
                contractMoney=accAdd(contractMoney,$(this).find('input[name="contractPrice"]').val())
            });
            $('#baseForm [name="contractMoney"] ').val(contractMoney)

            //
            if($('[name="taxRate"]').val() && $('#baseForm [name="contractMoney"]').val()){
                var taxRate=$('[name="taxRate"]').val() * 0.01
                var contractMoney=$('#baseForm [name="contractMoney"]').val()
                $('#baseForm [name="contractMoneyNotax"]').val(keepTwoDecimalFull(contractMoney / (1+taxRate)))
            }
        });

        // 内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var wbsSelectTree = null;
                    var cbsSelectTree = null;
                    var rbsSelectTree =null;
                    var _this = $(this);
                    layer.open({
                        type: 1,
                        title: '管理目标选择',
                        area: ['80%', '80%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" id="objectives">' +
                        //下拉选择
                        '           <div class="layui-row" style="margin-top: 10px">' +
                        // '               <div class="layui-col-xs2">' +
                        // '                   <div class="layui-form-item">\n' +
                        // '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                        // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        // '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                        // '                       </div>\n' +
                        // '                   </div>' +
                        // '               </div>' +
                        // '               <div class="layui-col-xs2">' +
                        // '                   <div class="layui-form-item">\n' +
                        // '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                        // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        // '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                        // '                       </div>\n' +
                        // '                   </div>' +
                        // '               </div>' +
                        '               <div class="layui-col-xs3">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label">WBS</label>\n' +
                        '                       <div class="layui-input-block">\n' +
                        '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label">RBS</label>\n' +
                        '                       <div class="layui-input-block">\n' +
                        '<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' ,
                            '               <div class="layui-col-xs3">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label">CBS</label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs2">' +
                            '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                            '               </div>' +
                            '           </div>' +
                            //表格数据
                            '       <div style="padding: 10px">' +
                            '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                            '      </div>' +
                            '</div>'].join(''),
                        success: function () {
                            // 获取WBS数据
                            $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
                                wbsSelectTree = xmSelect.render({
                                    el: '#wbsSelectTree',
                                    content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                    name: 'wbsName',
                                    prop: {
                                        name: 'wbsName',
                                        value: 'id'
                                    }
                                });

                                eleTree.render({
                                    elem: '#wbsTree',
                                    data: res.obj,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'wbsName',
                                        children: "child"
                                    }
                                });

                                // 树节点点击事件
                                eleTree.on("nodeClick(wbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        wbsName: currentData.wbsName,
                                        id: currentData.id
                                    }
                                    wbsSelectTree.setValue([obj]);
                                });
                            });

                            // 获取CBS数据
                            $.get('/plbCbsType/getAllList', function (res) {
                                cbsSelectTree = xmSelect.render({
                                    el: '#cbsSelectTree',
                                    content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                    name: 'cbsName',
                                    prop: {
                                        name: 'cbsName',
                                        value: 'cbsId'
                                    }
                                });

                                eleTree.render({
                                    elem: '#cbsTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'cbsName',
                                        children: "childList"
                                    }
                                });

                                // 树节点点击事件
                                eleTree.on("nodeClick(cbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        cbsName: currentData.cbsName,
                                        cbsId: currentData.cbsId
                                    }
                                    cbsSelectTree.setValue([obj]);
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
                                obj.rbsTyep = 'subcontract'
                                if(type == '1'){
                                    obj.rbsName=parentId?parentId:'';
                                }else {
                                    obj.parentId=parentId?parentId:'0';
                                }
                                // 获取RBS数据
                                $.get('/manageProject/getProjRbsByProjId',obj, function (res) {
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
                            laodTable();

                            $('.search_mtl').on('click', function(){
                                var cbsId = cbsSelectTree.getValue('valueStr');
                                var wbsId = wbsSelectTree.getValue('valueStr');
                                var rbsId = rbsSelectTree.getValue('valueStr');
                                // var itemNo = $('[name="itemNo"]').val();
                                // var itemName =$('[name="itemName"]').val();

                                laodTable(wbsId,rbsId,cbsId);
                            });

                            // 加载表格
                            function laodTable(wbsId,rbsId,cbsId) {
                                table.render({
                                    elem: '#managementBudgetTable',
                                    url: '/manageProject/getBudgetByProjId',
                                    where: {
                                        projId: $('#leftId').attr('projId'),
                                        wbsId: wbsId || '',
                                        cbsId: cbsId || '',
                                        rbsId: rbsId || '',
                                        // itemNo: itemNo || '',
                                        // itemName: itemName || '',
                                        rbsTyep:'subcontract'
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
                                        countName: 'count',
                                        dataName: 'data'
                                    },
                                    cols: [[
                                        {type: 'checkbox'},
                                        {
                                            field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
                                                var str = '';
                                                if (d.plbProjWbs) {
                                                    str = d.plbProjWbs.wbsName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    str = d.plbRbs.rbsLongName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
                                                var str = '';
                                                if (d.plbCbsTypeWithBLOBs) {
                                                    str = d.plbCbsTypeWithBLOBs.cbsName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
                                                return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                            }
                                        },
                                        {
                                            field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    // str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                                    str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
                                                }
                                                return str;
                                            }
                                        },
                                        {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                        {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                        {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                        // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                        // {field: 'monQuata', title: '',minWidth:170},
                                        {field: 'accumulatedSignedContractAmount', title: '累计已签合同金额',minWidth:170},
                                        //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                        //{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                    ]],
                                    done:function(res){
                                        _dataa=res.data;
                                        if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                            for(var i = 0 ; i <_dataa.length;i++){
                                                for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                    if(_dataa[i].projBudgetId == materialDetailsTableData[n].projBudgetId){
                                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                        //form.render('checkbox');
                                                    }
                                                }
                                            }
                                        }
                                    }
                                });
                            }
                        },
                        yes: function (index) {


                            materialDetailsTableData = []

                            var checkStatus=[];
                            /*$('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                if($(item).find('.layui-form-checked').length>0){
                                    checkStatus.push(_dataa[index]);
                                }
                            })*/
                            //遍历表格获取每行数据进行保存
                            var $tr = $('.contract_list').find('.layui-table-main tr');
                            $tr.each(function () {
                                var oldDataObj = {
                                    wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                                    wbsId: $(this).find('[name="contractPrice"]').attr('wbsId')||'',
                                    rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                                    rbsId: $(this).find('[name="contractPrice"]').attr('rbsId')||'',
                                    cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                    cbsId: $(this).find('[name="contractPrice"]').attr('cbsId')||'',
                                    manageTarAmount: $(this).find('[data-field="manageTarAmount"] .layui-table-cell').text(),
                                    accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                                    contractPrice: $(this).find('[name="contractPrice"]').val(),
                                    contractOtherContent: $(this).find('[name="contractOtherContent"]').val(),
                                    subcontractId: $(this).find('[name="contractPrice"]').attr('subcontractId')?$(this).find('[name="contractPrice"]').attr('subcontractId'):'',
                                    subcontractOutId: $(this).find('[name="contractPrice"]').attr('subcontractOutId')?$(this).find('[name="contractPrice"]').attr('subcontractOutId'):'',
                                    projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId')?$(this).find('[name="contractPrice"]').attr('projBudgetId'):'',
                                    trnOutMoney:$(this).find('[data-field="trnOutMoney"] .layui-table-cell').text()||"0",
                                }
                                materialDetailsTableData.push(oldDataObj);
                            });


                            var checkStatus = table.checkStatus('managementBudgetTable').data;

                            if (checkStatus.length > 0) {
                                for(var i=0;i<checkStatus.length;i++){
                                    var newDataObj = {
                                        projBudgetId:checkStatus[i].projBudgetId,
                                        wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                        wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                        rbsName:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsName:'',
                                        rbsId:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsId:'',
                                        cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                        cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                        manageTarAmount:checkStatus[i].manageTarAmount,
                                        accumulatedSignedContractAmount:checkStatus[i].accumulatedSignedContractAmount,
                                        trnOutMoney:checkStatus[i].trnOutMoney,
                                    }

                                    if(materialDetailsTableData){
                                        var _flag = true
                                        for(var j=0;j<materialDetailsTableData.length;j++){
                                            if(materialDetailsTableData[j].projBudgetId==checkStatus[i].projBudgetId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            materialDetailsTableData.push(newDataObj);
                                        }

                                    }else{
                                        materialDetailsTableData.push(newDataObj);
                                    }
                                }


                                table.reload('materialDetailsTable', {
                                    data: materialDetailsTableData
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
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                obj.del();
                if (data.subcontractOutId) {
                    $.get('/plbMtlSubcontractOut/delete', {subcontractOutId: data.subcontractOutId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.contract_list').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                        wbsId: $(this).find('[name="contractPrice"]').attr('wbsId')||'',
                        rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                        rbsId: $(this).find('[name="contractPrice"]').attr('rbsId')||'',
                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                        cbsId: $(this).find('[name="contractPrice"]').attr('cbsId')||'',
                        manageTarAmount: $(this).find('[data-field="manageTarAmount"] .layui-table-cell').text(),
                        accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                        contractPrice: $(this).find('[name="contractPrice"]').val(),
                        contractOtherContent: $(this).find('[name="contractOtherContent"]').val(),
                        subcontractId: $(this).find('[name="contractPrice"]').attr('subcontractId')?$(this).find('[name="contractPrice"]').attr('subcontractId'):'',
                        subcontractOutId: $(this).find('[name="contractPrice"]').attr('subcontractOutId')?$(this).find('[name="contractPrice"]').attr('subcontractOutId'):'',
                        projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId')?$(this).find('[name="contractPrice"]').attr('projBudgetId'):'',
                        trnOutMoney:$(this).find('[data-field="trnOutMoney"] .layui-table-cell').text()||"0"
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });
        // 内部-合同清单-上方按钮显示
        table.on('toolbar(paymentSettlementTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('#paymentSettlementModule').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            subcontractId: $(this).find('input[name="subcontractContent"]').attr('subcontractId') || '',
                            subcontractListId: $(this).find('input[name="subcontractContent"]').attr('subcontractListId') || '',
                            projBudgetId: $(this).find('input[name="subcontractContent"]').attr('projBudgetId') || '',
                            subcontractContent: $(this).find('input[name="subcontractContent"]').val(),
                            subcontractUnit: $(this).find('input[name="subcontractUnit"]').val(),
                            quantities: $(this).find('input[name="quantities"]').val(),
                            comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                            totalPrice: $(this).find('input[name="totalPrice"]').val()
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    oldDataArr.push({});
                    table.reload('paymentSettlementTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 内部-合同清单-删行操作
        table.on('tool(paymentSettlementTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subcontractListId) {
                    $.get('/plbMtlSubcontract/deleteContractList', {ids: data.subcontractListId}, function () {
                    });
                }
                //遍历表格获取每行数据进行保存
                var $trs = $('#paymentSettlementModule').find('.layui-table-main tr');
                var oldDataArr = [];
                $trs.each(function () {
                    var oldDataObj = {
                        subcontractId: $(this).find('input[name="subcontractContent"]').attr('subcontractId') || '',
                        subcontractListId: $(this).find('input[name="subcontractContent"]').attr('subcontractListId') || '',
                        projBudgetId: $(this).find('input[name="subcontractContent"]').attr('projBudgetId') || '',
                        subcontractContent: $(this).find('input[name="subcontractContent"]').val(),
                        subcontractUnit: $(this).find('input[name="subcontractUnit"]').val(),
                        quantities: $(this).find('input[name="quantities"]').val(),
                        comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                        totalPrice: $(this).find('input[name="totalPrice"]').val()
                    }
                    oldDataArr.push(oldDataObj);
                })
                table.reload('paymentSettlementTable', {
                    data: oldDataArr
                });
            }
        });

        //选择供应商比价
        table.on('toolbar(plbMtlContrastTable)', function (obj) {
            switch (obj.event) {
                case 'choosePlbMtlContrast':
                    layer.open({
                        type: 1,
                        title: '选择分包比价',
                        area: ['100%', '100%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" id="objectives">' +
                        //下拉选择
                        '           <div class="layui-row" style="margin-top: 10px">' +
                        '               <div class="layui-col-xs2" style="padding-left: 10px;">\n' +
                        '                    <input type="text" name="subpackageNo" placeholder="比价编号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;margin-left: 10px;">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm search_mtl">查询</button>\n' +
                        '                </div>' +
                        '           </div>' +
                        //表格数据
                        '       <div style="padding: 10px">' +
                        '           <table id="tableObj" lay-filter="tableObj"></table>' +
                        '      </div>' +
                        '</div>'].join(''),
                        success: function () {

                            laodTable();

                            $('.search_mtl').on('click', function(){
                                laodTable();
                            });

                            // 加载表格
                            function laodTable() {
                                var _where = {
                                    projId: $('#leftId').attr('projId'),
                                    //approvalStatus: 2
                                }
                                if($('[name="subpackageNo"]').val()){
                                    _where.subpackageNo = $('[name="subpackageNo"]').val()
                                }

                                _where.isContract="contract";
                                table.render({
                                    elem: '#tableObj',
                                    url: '/plbMtlSubpackage/getDataByCondition',
                                    where: _where,
                                    page: true,
                                    limit: 10,
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
                                        {type: 'radio'},
                                        {field: 'subpackageNo', title: '比价编号', sort: true, hide: false},
                                        {field:'projName',title:'所属项目',sort:true,hide:false},
                                        {field: 'priceComparison', title: '比价事项', hide: false},
                                        {field: 'compareTime', title: '比价时间', sort: true, hide: false, templet: function (d) {
                                                return format(d.compareTime);
                                            }
                                        },
                                        {field: 'compareType', title: '比价方式', sort: true, hide: false, templet: function (d) {
                                                return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || '';
                                            }
                                        },
                                        /*{field: 'approvalStatus', title: '审批状态',width:150, sort: true, hide: false, templet: function (d) {
                                                var str = '';
                                                switch (d.approvalStatus) {
                                                    case '0':
                                                        str = '未提交';
                                                        break;
                                                    case '1':
                                                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                                        str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                                                        break;
                                                    case '2':
                                                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                                        str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
                                                        break;
                                                    case '3':
                                                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                                        str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
                                                        break;
                                                }
                                                return str;
                                            }
                                        },*/
                                        {field: 'remark', title: '备注', hide: false},
                                    ]],
                                    done:function(res){
                                        var _dataa2=res.data;
                                        if(mtlSubpackageData){
                                            for(var i = 0 ; i <_dataa2.length;i++){
                                                if(_dataa2[i].subpackageId == mtlSubpackageData[0].subpackageId){
                                                    $('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
                                                    //form.render('checkbox');
                                                }
                                            }
                                        }

                                    }
                                });
                            }
                        },
                        yes: function (index) {

                            var checkStatus = table.checkStatus('tableObj').data;
                            if (checkStatus.length > 0) {
                                mtlSubpackageData = checkStatus[0]

                                $('#baseForm').attr('subpackageId',mtlSubpackageData.subpackageId)

                                layer.close(index);

                                table.reload('plbMtlContrastTable', {
                                    data: [mtlSubpackageData]
                                });
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
            }
        });

        //比价详情
        table.on('tool(plbMtlContrastTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if(layEvent === 'info'){
                var projId = $('#leftId').attr('projId');
                layer.open({
                    type: 1,
                    title: '比价详情',
                    area: ['100%', '100%'],
                    btn: ['确定'],
                    btnAlign: 'c',
                    content: ['<div class="layui-collapse">',
                        '<div class="layui-colla-item">',
                        '<h2 class="layui-colla-title">分包比价详情</h2>',
                        '<div class="layui-colla-content layui-show">',
                        '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">比价编号<span field="subpackageNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="subpackageNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">比价事项<span field="priceComparison" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="priceComparison" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">比价时间<span field="compareTime" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" readonly name="compareTime" id="compareTime" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第二行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px">' +
                        '                   <div class="layui-form-item">' +
                        '                       <label class="layui-form-label form_label">比价方式<span field="compareType" class="field_required">*</span></label>' +
                        '                       <div class="layui-input-block form_block">' +
                        '                           <select name="compareType"></select>' +
                        '                       </div>' +
                        '                   </div>' +
                        '               </div>',
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商1</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId1" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商2</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId2" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商3</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId3" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +

                        '           </div>' +
                        /* endregion */
                        /* region 第二行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商4</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId4" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商5</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId5" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商6</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId6" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">分包商7</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="customerId7" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' +
                        /* endregion */
                        /* region 第二行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label form_label">分包商8</label>\n' +
                        '        <div class="layui-input-block form_block">\n' +
                        '        <input type="text" name="customerId8" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                        '        </div>\n' +
                        '    </div>' +
                        '</div>' +
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">备注</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="remark" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        '</form>',
                        /* region 附件 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">附件</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<div class="file_module">' +
                        '<div id="fileContentX" class="file_content"></div>' +
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
                        '</div>',
                        '</div>',
                        /* endregion */
                        '</div></div>',
                        '<div class="layui-colla-item">',
                        '<h2 class="layui-colla-title">分包比价明细</h2>',
                        '<div class="layui-colla-content mtl_info_detail layui-show">',
                        ' <button class="layui-btn layui-btn-sm" id="addRow">加行</button>'+
                        '<table id="equipmentListTable" lay-filter="equipmentListTable"></table>',
                        '</div></div>',
                        '</div>'].join(''),
                    success: function () {
                        //回显项目名称
                        getProjName('#projectName',(projId?projId:data.projId))

                        fileuploadFn('#fileupload', $('#fileContentX'));

                        $('select[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str']);

                        // 初始化时间控件
                        laydate.render({
                            elem: '#compareTime',
                            trigger: 'click',
                            value: data ? format(data.compareTime) : ''
                        });

                        // 分包明细列表数据
                        var materialDetailsTableData2 = []

                        form.val("baseForm", data);
                        //回显分包商信息
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
                        materialDetailsTableData2=data.subpackageList || []
                        //附件解析
                        if (data.attachments && data.attachments.length > 0) {
                            var fileArr = data.attachments;
                            $('#fileContentX').append(echoAttachment(fileArr));
                        }
                        //遍历分包商，判断分包商是否显示
                        var colsArr=[]
                        $('.chooseEquivalent').each(function () {
                            if($(this).attr('customerId')){
                                colsArr.push(false)
                            }else{
                                colsArr.push(true)
                            }
                        })
                        //回显表格数据
                        var showCols=[]
                        detailCols.forEach(function (item,index) {
                            item.hide=colsArr[index]
                            showCols.push(item)
                        })

                        //$('.layui-layer-btn-c').hide()
                        $('#baseForm [name="priceComparison"]').attr('disabled','true')
                        $('#compareTime').attr('disabled','true')
                        $('#baseForm [name="compareType"]').attr('disabled','true')
                        $('.chooseEquivalent').attr('disabled','true')
                        $('#baseForm [name="remark"]').attr('disabled','true')
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()
                        $('#addRow').hide()
                        loadDetail(showCols,materialDetailsTableData2,4)

                        table.render();

                        element.render();


                    },
                    yes: function (index) {
                        layer.close(index);
                    }
                });
            }
        })

        //加载明细表
        function loadDetail(showCols,materialDetailsTableData2,type){
            showCols.push(
                {field: 'chooseUnit', title: '选中分包商单价', width: 150,templet: function (d) {
                        return '<input type="number" name="chooseUnit" '+(type ? 'readonly' : '')+' subpackageListId="'+(d.subpackageListId || '')+'" autocomplete="off" class="layui-input" style="height: 100%;" value="' + (d.chooseUnit || '') + '">'
                    }},
            )
            if(!type){
                showCols.push(
                    {align: 'center', toolbar: '#barDemo', title: '操作',fixed:'right'}
                )
            }
            table.render({
                elem: '#equipmentListTable',
                data: materialDetailsTableData2,
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

        $(document).on('click', '.choose_Equivalent', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择分包商',
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
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
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
                        table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType:typeNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-180'
                            , toolbar: '#toolbar'
                            , defaultToolbar: ['']
                            ,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'customerNo', title: '客商编号', sort: true, width: 200}
                                , {field: 'customerName', title: '客商单位名称',}
                                , {field: 'customerShortName', title: '客商单位简称',}
                                , {field: 'customerOrgCode', title: '组织机构代码'}
                                , {field: 'taxNumber', title: '税务登记号'}
                                , {field: 'accountNumber', title: '开户行账户'}
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

    function childFunc() {
        if ('0' != _disabled) {
            return false
        }

        var loadIndex = layer.load();
        //必填项提示
        for (var i = 0; i < $('.testNull').length; i++) {
            if ($('.testNull').eq(i).val() == '') {
                layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                return false
            }
        }
        //提示输入框只能输入数字
        for (var a = 0; a < $('.chinese').length; a++) {
            if (isNaN($('.chinese').eq(a).val())) {
                layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                return false
            }
        }

        //管理目标金额-累计已签合同金额-在途合同金额>=本次合同价  才能提交
        var requiredFlag = false;
        var $tr = $('.contract_list').find('.layui-table-main tr');
        $tr.each(function (index,element) {
            //管理目标金额
            var _manageTarAmount = $(element).find('[data-field="manageTarAmount"] div').text()||0;
            //累计已签合同金额
            var _accumulatedSignedContractAmount = $(element).find('[data-field="accumulatedSignedContractAmount"] div').text()||0;
            //在途合同金额
            var _trnOutMoney = $(element).find('[data-field="trnOutMoney"] div').text()||0;
            //本次合同价
            var _contractPrice = $(element).find('[name="contractPrice"]').val()||0;
            if(sub(sub(_manageTarAmount,_accumulatedSignedContractAmount),_trnOutMoney)<_contractPrice){
                layer.msg('本次合同价加累计已签合同金额大于管理目标金额！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });
        if (requiredFlag) {
            return false;
        }
        //分包合同数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });

        obj.contractA = $('[name="contractA"]').attr('customerId')
        obj.customerId = $('[name="customerId"]').attr('customerId')

        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;

        //合同明细数据
        var $tr = $('.contract_list').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            var materialDetailsObj = {
                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                wbsId: $(this).find('[name="contractPrice"]').attr('wbsId')||'',
                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                rbsId: $(this).find('[name="contractPrice"]').attr('rbsId')||'',
                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                cbsId: $(this).find('[name="contractPrice"]').attr('cbsId')||'',
                manageTarAmount: $(this).find('[data-field="manageTarAmount"] .layui-table-cell').text(),
                accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                contractPrice: $(this).find('[name="contractPrice"]').val(),
                contractOtherContent: $(this).find('[name="contractOtherContent"]').val(),
                subcontractId: $(this).find('[name="contractPrice"]').attr('subcontractId') ? $(this).find('[name="contractPrice"]').attr('subcontractId') : '',
                subcontractOutId: $(this).find('[name="contractPrice"]').attr('subcontractOutId') ? $(this).find('[name="contractPrice"]').attr('subcontractOutId') : '',
                projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId') ? $(this).find('[name="contractPrice"]').attr('projBudgetId') : ''
            }
            if ($(this).find('input[name="contractPrice"]').attr('subcontractOutId')) {
                materialDetailsObj.subcontractOutId = $(this).find('input[name="contractPrice"]').attr('subcontractOutId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        obj.plbMtlSubcontractOuts = materialDetailsArr;

        // 合同清单数据
        var $tr2 = $('#paymentSettlementModule').find('.layui-table-main tr');
        var plbMtlContractOuts = [];
        $tr2.each(function () {
            var plbMtlContractObj = {
                subcontractId: $(this).find('input[name="subcontractContent"]').attr('subcontractId') || '',
                subcontractListId: $(this).find('input[name="subcontractContent"]').attr('subcontractListId') || '',
                projBudgetId: $(this).find('input[name="subcontractContent"]').attr('projBudgetId') || '',
                subcontractContent: $(this).find('input[name="subcontractContent"]').val(),
                subcontractUnit: $(this).find('input[name="subcontractUnit"]').val(),
                quantities: $(this).find('input[name="quantities"]').val(),
                comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                totalPrice: $(this).find('input[name="totalPrice"]').val()
            }
            plbMtlContractOuts.push(plbMtlContractObj);
        });
        obj.plbMtlSubcontractLists = plbMtlContractOuts;
        if(mtlSubpackageData!=undefined&&mtlSubpackageData.length>0&&mtlSubpackageData[0].subpackageId!=undefined){
            obj.subpackageId = mtlSubpackageData[0].subpackageId;
        }

        //if (type == 1) {
            obj.subcontractId = data.subcontractId
            obj.runId = runId;
        //} else {
        //    obj.projId = parseInt(projId);
        //}

        var _flag = false;
        $.ajax({
            url: '/plbMtlSubcontract/update',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layui.layer.close(loadIndex);
                if (res.flag) {
                    layui.layer.msg('保存成功！', {icon: 1});
                } else {
                    layui.layer.msg('保存失败！', {icon: 2});
                    _flag = true;
                }
            }
        });
        if (_flag) {
            return false;
        }
        return true;
    }
</script>
</body>
</html>