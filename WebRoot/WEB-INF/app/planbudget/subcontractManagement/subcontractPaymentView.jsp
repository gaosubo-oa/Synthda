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
    <title>分包付款预览</title>

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
        .layui-col-xs4{
            width: 20%;
        }
    </style>
</head>
<body>
<div id="htmBox">

</div>
<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择结算单</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script type="text/html" id="toolbarDemoIn2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择预付款</button>
    </div>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var htmBox=['<div class="layui-collapse _disabled">\n',
        /* region 分包付款 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">分包付款</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">付款单编号<!--<span field="subpaymentNo" class="field_required">*</span>--><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="subpaymentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projName" id="projName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="项目名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
        '                       <input type="text" name="contractName" placeholder="查找分包合同" readonly autocomplete="off" class="layui-input chooseSubcontract testNull"  title="合同名称" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerName" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input testNull chooseCustomerName" title="客商单位名称">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>',
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同预付款</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="paymentPre" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计已结算金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="settleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       <input type="hidden" name="currSettleupMoney">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计已付款金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="payedMoney" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">\n' +
        '                       <input type="hidden" name="currPayedMoney">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">在途付款金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="trnPaymentMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +                    '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次应付金额<!--<span class="field_required">*</span>--></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="applyPayMoney"  autocomplete="off" class="layui-input chinese applyPayMoney"  title="本次应付金额">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>',
        /* endregion */
        /* region 第三行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次核销金额合计</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="payMoney2" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input chinese" title="本次核销金额合计">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次付款申请金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="payMoney" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input chinese" title="本次付款申请金额">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次付款后累计付款比例%</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="totalPayRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同余款</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="conSpareMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">付款节点</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="payNode"   autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>',
        /* endregion */
        /* region 第四行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">收款方户名</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="colPeo"  autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">账号</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="bankAccount"   autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">开户行</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="bankDeposit" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">发票类型</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select name="invoiceType" id="invoiceType" disabled lay-filter="invoiceType">' +
        '                               <option value="">请选择</option>' +
        '                           </select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">税率(%)</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="taxRate" readonly  id="taxRate" style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
        // '                           <select name="taxRate" disabled lay-filter="taxRate">' +
        // '                               <option value="">请选择</option>' +
        // '                           </select>\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        /* region 第五行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">付款日期</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="paymentDate"   id="paymentDate"  autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;width: 40%"">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">用途</label>\n' +
        '                       <div class="layui-input-block form_block">' +
        '                       <textarea type="text" name="remark" style="resize: vertical; height: 38px;" autocomplete="off" class="layui-input"></textarea>\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;width: 40%">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">备注</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <textarea type="text" name="memo" style="resize: vertical; height: 38px;" autocomplete="off" class="layui-input"></textarea>\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        /* region 第六行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">合同类别</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                        <select name="contractCategory" disabled><option value="">请选择</option></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        /* region 第七行 */
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
        /* region 分包付款明细 */
        '<div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">预付款核销明细</h2>\n' +
        '<div class="layui-colla-content layui-show">' +
        '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
        /*'<ul class="layui-tab-title">' +
        '<li class="layui-this">本次应付款</li>' +
        '<li>预付款核销</li>' +
        '<li>实际付款</li>' +
        '</ul>' +*/
        '<div class="layui-tab-content">' +
        /*'<div class="layui-tab-item layui-show mtl_info">' +
        '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
        '</div>' +*/
        '<div class="layui-tab-item layui-show contract_out">' +
        '<div id="paymentSettlementModule">' +
        '          <table id="writeOffTable" lay-filter="writeOffTable"></table>' +
        '</div>' +
        '</div>' +
        /*'<div class="layui-tab-item contract_on">' +
        '          <table id="actualPaymentTable" lay-filter="actualPaymentTable"></table>' +
        '</div>' +*/
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>\n' +
        /* endregion */
        '</div>'].join('');

    $("#htmBox").html(htmBox);
    $('input[name="payMoney2"]', $('#baseForm')).val(0);
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var runId=getUrlParam("runId");
    var _disabled=getUrlParam("disabled");
    var _type;
    if(_disabled){
        if(_disabled==="0"||_disabled===0){
            _type = 1;
        }else if(_disabled==="1"||_disabled===1){
            _type = 4;
        }
    }
    var projId;
    var plbMtlSubpaymentDetailsListData = [];
    var plbMtlSubpaymentWriteOffListData = [];
    var _dataa = null;

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
        TAX_RATE:{},
        INVOICE_TYPE:{},
        CONTRACT_CATEGORY:{}
    }
    var dictionaryStr = 'CONTRACT_TYPE,TAX_RATE,INVOICE_TYPE,CONTRACT_CATEGORY';
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
    var data;
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;
        var materialsTable = null;
        if(!runId){
            layer.msg('获取信息失败！', {icon: 0});
            return false;
        }else{
            $.ajax({
                url:'/plbMtlSubpayment/getByRunId?runId='+runId,
                async:false,
                success:function(res){
                    data=res.object
                }
            })

            // $('[name="taxRate"]').append(dictionaryObj['TAX_RATE']['str']);
            $('[name="invoiceType"]').append(dictionaryObj['INVOICE_TYPE']['str']);

            $('[name="contractCategory"]').append(dictionaryObj['CONTRACT_CATEGORY']['str'])
            //回显项目名称
            getProjName('#projName',data.projId)
            projId = data.projId;
            $('#leftId').attr('projId',data.projId)

            fileuploadFn('#fileupload', $('#fileContent'));
            plbMtlSubpaymentDetailsListData = [];
            plbMtlSubpaymentWriteOffListData = [];
            //回显数据
            if (_type == 1 || _type==4) {
                form.val("formTest", data);
                plbMtlSubpaymentDetailsListData = data.plbMtlSubpaymentDetailsList || [];
                plbMtlSubpaymentWriteOffListData = data.plbMtlSubpaymentWriteOffList || [];
                // 分包合同id
                $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
                //客商单位名称id
                $('.plan_base_info input[name="customerName"]').attr('customerId',data.customerId || '');

                //附件
                if (data.attachments && data.attachments.length > 0) {
                    var fileArr = data.attachments;
                    $('#fileContent').append(echoAttachment(fileArr));
                }


            }
            laydate.render({
                elem: 'input[name="paymentDate"]' //指定元素
                ,trigger: 'click' //采用click弹出
                ,format: 'yyyy-MM-dd'
            });

            $('#invoiceType').next().find('input').css('background','#e7e7e7')

            element.render();
            form.render();

            var cols=[
                {
                    field: 'mtlPaymentNo', title: '预付款编号'
                },{
                    field: 'payDate', title: '预付款时间'
                },
                {
                    field: 'paymentPreMoney', title: '预付款金额'
                },
                /*{
                    field: 'paymentPreOutMoney', title: '预付款已付金额'
                },*/
                {
                    field: 'paymentPreWriteMoney', title: '预付款已核销金额'
                },
                {
                    field: 'trnWriteMoney', title: '预付款在途核销金额', templet: function (d) {
                        return '<span>'+ (d.trnWriteMoney || 0) + '</span>'
                    }
                },
                {
                    field: 'paymentPreCurrWriteMoney', title: '预付款本次核销金额', templet: function (d) {
                        return '<input type="number" name="paymentPreCurrWriteMoney" subpaymentWriteoffId="'+(d.subpaymentWriteoffId || '')+'" subpaymentId="'+(d.subpaymentId || '')+'" advanceId="'+(d.advanceId || '')+'" class="layui-input outMoneyItem" style="height: 100%;" value="' + (d.paymentPreCurrWriteMoney || 0) + '">'
                    }
                },
            ]



            // if(_type!=4){
            //     cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
            // }

            table.render({
                elem: '#writeOffTable',
                data: plbMtlSubpaymentWriteOffListData||[],
                // toolbar: '#toolbarDemoIn2',
                defaultToolbar: [''],
                limit: 1000,
                cols: [cols],
                done:function (obj) {
                    plbMtlSubpaymentWriteOffListData = obj.data
                    if(_type==4){
                        $('.addRow').hide()
                    }
                }
            });

            //查看详情
            if(_type==4){
                /*$('.layui-layer-btn-c').hide()
                $('#baseForm [name="customerName"]').attr('disabled','true')
                $('#baseForm [name="contractName"]').attr('disabled','true')
                $('#baseForm [name="applyPayMoney"]').attr('disabled','true')
                $('#baseForm [name="remark"]').attr('disabled','true')*/
                $('._disabled').find('[name]').attr('disabled', 'disabled');
                $('.file_upload_box').hide()
                $('.deImgs').hide()
            }

        }

        //预付款核销加行
        table.on('toolbar(writeOffTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var contracttId = $('#baseForm [name="contractName"]').attr('mtlcontractid');
                    if(!contracttId){
                        layer.msg('请先选择材料合同！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择预付款',
                        area: ['80%', '70%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" style="padding:0px 10px">' +
                        /*'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs2">\n' +
                        '                    <input type="text" name="mtlPaymentNo" placeholder="付款单编号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>\n' +
                        '                </div>\n' +
                        '</div>' +*/
                        '<div>' +
                        '     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
                        /* '     <div id="downBox">\n' +
                         '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                         '      </div>' +*/
                        '</div>' +
                        '</div>'].join(''),
                        success: function () {
                            table.render({
                                elem: '#tableDemoIn',
                                url: '/subcontractAdvancePayment/select',
                                cols: [[
                                    {type: 'checkbox'},
                                    {field: 'mtlPaymentNo', title: '预付款编号', sort: true, hide: false},
                                    {field: 'payDate', title: '预付款时间', sort: true, hide: false},
                                    {field: 'customerName', title: '客商单位名称', sort: true, hide: false},
                                    {field:'contractName',title:'合同名称',sort:false,hide:false},
                                    {field: 'advanceMoney', title: '合同预付款', sort: true, hide: false},
                                    {field: 'thisPayMon', title: '申请金额', sort: true, hide: false},
                                ]],
                                //height: 'full-350',
                                page: true,
                                where: {
                                    projectId:$('#leftId').attr('projId'),
                                    mtlContractId: contracttId,
                                    auditerStatus:2,
                                    model:"materialPayment"
                                },
                                /* parseData: function (res) { //res 即为原始返回的数据
                                     return {
                                         "code": 0, //解析接口状态
                                         "data": res.data, //解析数据列表
                                         "count": res.totleNum, //解析数据长度
                                     };
                                 },
                                 request: {
                                     limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                 },*/
                                done:function(res){
                                    _dataa=res.data;
                                    if(plbMtlSubpaymentWriteOffListData!=undefined&&plbMtlSubpaymentWriteOffListData.length>0){
                                        for(var i = 0 ; i <_dataa.length;i++){
                                            for(var n = 0 ; n < plbMtlSubpaymentWriteOffListData.length; n++){
                                                if(_dataa[i].advanceId == plbMtlSubpaymentWriteOffListData[n].advanceId){
                                                    $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                    //form.render('checkbox');
                                                }
                                            }
                                        }
                                    }
                                }
                            });
                        },
                        yes: function (index) {

                            plbMtlSubpaymentWriteOffListData = []

                            var checkStatus = table.checkStatus('tableDemoIn'); //获取选中行状态
                            var data = checkStatus.data;  //获取选中行数据

                            //判断是否选择数据
                            if (data.length == 0) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }

                            //遍历表格获取每行数据进行保存
                            var $tr = $('.contract_out').find('.layui-table-main tr');
                            $tr.each(function () {
                                var oldDataObj = {
                                    paymentPreMoney: $(this).find('[data-field="paymentPreMoney"] .layui-table-cell').text(),
                                    payDate: $(this).find('[data-field="payDate"] .layui-table-cell').text(),
                                    mtlPaymentNo: $(this).find('[data-field="mtlPaymentNo"] .layui-table-cell').text(),
                                    paymentPreWriteMoney: $(this).find('[data-field="paymentPreWriteMoney"] .layui-table-cell').text(),
                                    trnWriteMoney: $(this).find('[data-field="trnWriteMoney"] .layui-table-cell').text(),
                                    paymentPreCurrWriteMoney: $(this).find('input[name="paymentPreCurrWriteMoney"]').val(),
                                    subpaymentId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentId') || '',
                                    subpaymentWriteoffId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentWriteoffId') || '',
                                    advanceId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('advanceId') || '',
                                }
                                plbMtlSubpaymentWriteOffListData.push(oldDataObj);
                            });
                            data.forEach(function (item) {
                                var addRowData={
                                    payDate:item.payDate||"",
                                    mtlPaymentNo:item.mtlPaymentNo||"",
                                    paymentPreMoney: retainDecimal(item.paymentPreMoney,2) || 0,
                                    paymentPreWriteMoney: retainDecimal(item.paymentPreWriteMoney,2) || 0,
                                    trnWriteMoney: retainDecimal(item.trnWriteMoney,2) || 0,
                                    advanceId: item.advanceId,
                                }

                                if(plbMtlSubpaymentWriteOffListData){
                                    var _flag = true
                                    for(var j=0;j<plbMtlSubpaymentWriteOffListData.length;j++){
                                        if(plbMtlSubpaymentWriteOffListData[j].advanceId==item.advanceId){
                                            _flag = false
                                        }
                                    }
                                    if(_flag){
                                        plbMtlSubpaymentWriteOffListData.push(addRowData)
                                    }

                                }else{
                                    plbMtlSubpaymentWriteOffListData.push(addRowData)
                                }
                            })
                            table.reload('writeOffTable', {
                                data: plbMtlSubpaymentWriteOffListData
                            });
                            layer.close(index)
                        },
                    })
                    break;
            }
        })
        // 预付款核销删行操作
        table.on('tool(writeOffTable)', function (obj) {

            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subpaymentWriteoffId) {
                    $.get('/plbMtlSubpayment/deleteDetails', {dtype:'writeOff',ids: data.subpaymentWriteoffId}, function () {
                    });
                }
                //遍历表格获取每行数据进行保存
                var $trs = $('.contract_out').find('.layui-table-main tr');
                var oldDataArr = [];
                $trs.each(function () {
                    var oldDataObj = {
                        paymentPreMoney: $(this).find('[data-field="paymentPreMoney"] .layui-table-cell').text(),
                        payDate: $(this).find('[data-field="payDate"] .layui-table-cell').text(),
                        mtlPaymentNo: $(this).find('[data-field="mtlPaymentNo"] .layui-table-cell').text(),
                        paymentPreWriteMoney: $(this).find('[data-field="paymentPreWriteMoney"] .layui-table-cell').text(),
                        trnWriteMoney: $(this).find('[data-field="trnWriteMoney"] .layui-table-cell').text(),
                        paymentPreCurrWriteMoney: $(this).find('input[name="paymentPreCurrWriteMoney"]').val(),
                        subpaymentId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentId') || '',
                        subpaymentWriteoffId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentWriteoffId') || '',
                        advanceId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('advanceId') || '',
                    }
                    oldDataArr.push(oldDataObj);
                })
                table.reload('writeOffTable', {
                    data: oldDataArr
                });
            }
        });

        // 点击选分包合同
        $(document).on('click', '.chooseSubcontract', function () {
            // if(!$('#baseForm [name="customerName"]').attr('customerId')){
            //     layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
            //     return false
            // }
            var contractTableObj = null
            layer.open({
                type: 1,
                title: '选择合同',
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
                    contractTableObj=table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbMtlSubcontract/selectAll',
                        where:{projId:$('#leftId').attr('projId'),approvalStatus:"2",subpaymentId:data.subpaymentId},
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

                        //合同名称
                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        //合同名称ID
                        $('#baseForm [name="contractName"]').attr('mtlContractId',chooseData.mtlContractId)

                        //合同金额
                        $('#baseForm [name="contractMoney"]').val(retainDecimal(chooseData.contractMoney,2) || 0)
                        //合同预付款
                        $('#baseForm [name="paymentPre"]').val(retainDecimal(chooseData.paymentPre,2) || 0)
                        //累计已结算金额
                        $('#baseForm [name="settleupMoney"]').val(retainDecimal(chooseData.settleupMoney,2) || 0)
                        //累计已结算金额(动态值)
                        $('#baseForm [name="currSettleupMoney"]').val(retainDecimal(chooseData.currSettleupMoney,2) || 0)
                        //累计应付金额
                        $('#baseForm [name="payedMoney"]').val(retainDecimal(chooseData.payedMoney,2) || 0);
                        //累计应付金额(动态值)
                        $('#baseForm [name="currPayedMoney"]').val(retainDecimal(chooseData.currPayedMoney,2) || 0);
                        //在途应付金额
                        $('#baseForm [name="trnPaymentMoney"]').val(retainDecimal(chooseData.trnPaymentMoney,2) || 0);

                        //分包商
                        $('#baseForm [name="customerName"]').val(chooseData.customerName);
                        $('#baseForm [name="customerName"]').attr("customerId",chooseData.customerId);
                        $('#baseForm [name="contractName"]').attr("subcontractId",chooseData.subcontractId);

                        //收款方户名
                        $('#baseForm [name="colPeo"]').val(chooseData.customerName);
                        //账号
                        var _data = chooseData.plbCustomerWithBLOBs&&chooseData.plbCustomerWithBLOBs.plbCustomerBankList[0]||null
                        $('#baseForm [name="bankAccount"]').val(_data?_data.bankAccount:'');
                        //开户行
                        $('#baseForm [name="bankDeposit"]').val(_data?_data.bankOfDeposit:'');
                        //发票类型
                        $('#baseForm [name="invoiceType"]').val(chooseData.invoiceType);
                        //税率(%)
                        $('#baseForm [name="taxRate"]').val(chooseData.taxRate);
                        //合同类别
                        $('#baseForm [name="contractCategory"]').val(chooseData.contractCategory);

                        form.render();

                        plbMtlSubpaymentWriteOffListData = chooseData.writeOffList;
                        table.reload('writeOffTable', {
                            data: plbMtlSubpaymentWriteOffListData
                        });

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1
                    //重新从第 1 页开始
                }
            });
        });

        //选择客商单位名称
        /*$(document).on('click', '.chooseCustomerName', function () {
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
                    //查询
                    '       <div class="layui-row inSearchContent">' +
                    '             <div class="layui-col-xs4">\n' +
                    '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                    '             </div>\n' +
                    '       </div>' +
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
                        materialsTable = table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType: typeNo,
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
                        _this.attr('customerId', mtlData.customerId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        })
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
        });*/

        //监听本次应付金额
        //监听预付款本次核销金额
        $(document).on('input propertychange', '.outMoneyItem', function () {
            /*if($('#leftId').attr('_type')=='4'){
                return false
            }*/
            var $tr = $('.contract_out').find('.layui-table-main tr');
            //本次应付金额
            var applyPayMoney = $('[name="applyPayMoney"]').val()||0
            //本次付款申请金额
            var payMoney=0
            //本次核销金额合计
            var payMoney2 = 0
            $tr.each(function (index) {
                payMoney2=accAdd(payMoney2,$(this).find('input[name="paymentPreCurrWriteMoney"]').val()||0)
            });
            $('[name="payMoney2"]').val(retainDecimal(payMoney2,2)||0)
            $('[name="payMoney"]').val(retainDecimal(sub(applyPayMoney,payMoney2),2)||0)


            //累计已付款金额
            var payedMoney = $('[name="payedMoney"]').val()||0
            //累计已结算金额
            var settleupMoney = $('[name="settleupMoney"]').val()||0
            //本次付款后累计付款比例
            payMoney=$('[name="payMoney"]').val()||0;
            var totalPayRatio = 0
            if(settleupMoney==0){
                totalPayRatio = retainDecimal(div(accAdd(payedMoney,payMoney),1),4)
            }else {
                totalPayRatio = retainDecimal(div(accAdd(payedMoney,payMoney),settleupMoney),4)
            }

            // $('[name="totalPayRatio"]').val(retainDecimal(sub(applyPayMoney,totalPayRatio),2)||0)
            $('[name="totalPayRatio"]').val(retainDecimal(mul(totalPayRatio,100),2)+'%')

            //合同余款
            var conSpareMoney = 0
            //合同金额
            var contractMoney = $('[name="contractMoney"]').val()||0

            conSpareMoney = sub(sub(contractMoney,payedMoney),payMoney||0)

            $('[name="conSpareMoney"]').val(retainDecimal(conSpareMoney,2))||0

        });

        //监听预付款本次核销金额
        $(document).on('input propertychange', '.applyPayMoney', function () {
            //本次应付金额
            var applyPayMoney = $(this).val()||0 //本次应付金额
            var a2 = $('[name="payMoney2"]').val()||0 //本次核销金额合计
            $('[name="payMoney"]').val(retainDecimal(sub(applyPayMoney,a2),2)||0)


            //本次付款后累计付款比例=（累计已付款金额+本次付款申请金额）/累计结算金额
            var a3 = $('[name="payedMoney"]').val()||0 //累计已付款金额
            var a4 = $('[name="payMoney"]').val()||0 //本次付款申请金额
            var a5 = $('[name="settleupMoney"]').val()?$('[name="settleupMoney"]').val():1
            $('[name="totalPayRatio"]').val(retainDecimal(mul(retainDecimal(div(retainDecimal(accAdd(a3,a4),2),a5),4),100),2)+'%');


            //合同余款=合同金额-累计已付款金额-本次付款申请金额
            var a6 = $('[name="contractMoney"]').val()||0 //合同金额
            var a7 = $('[name="payedMoney"]').val()||0 //累计已付款金额
            var a8 = $('[name="payMoney"]').val()||0 //本次付款申请金额
            $('[name="conSpareMoney"]').val(retainDecimal(sub(retainDecimal(sub(a6,a7),2),a8),2))
        });
    });

    function childFunc(){
        if(_type != 1){
            return true
        }

        //必填项提示
        for (var i = 0; i < $('.testNull').length; i++) {
            if ($('.testNull').eq(i).val() == '') {
                layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                return false
            }
        }

        //提示输入框只能输入数字
        /*for(var a = 0;a < $('.chinese').length;a++) {
            if (isNaN($('.chinese').eq(a).val())) {
                layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                return false
            }
        }*/
        var isFlag = false;
        //子表
        var paymentPreMoneySum = 0
        var paymentPreWriteMoneySum = 0
        //预付款金额>=预付款已核销金额+预付款在途核销金额+预付款本次核销金额
        var $tr2 = $('.contract_out').find('.layui-table-main tr');
        $tr2.each(function (index) {
            //预付款金额
            var paymentPreMoney = $(this).find('td[data-field="paymentPreMoney"] div').text()||0
            //预付款已核销金额
            var paymentPreWriteMoney = $(this).find('td[data-field="paymentPreWriteMoney"] div').text()||0
            //预付款在途核销金额
            var trnWriteMoney = $(this).find('td[data-field="trnWriteMoney"] span').text()||0
            //预付款本次核销金额
            var paymentPreCurrWriteMoney = $(this).find('input[name="paymentPreCurrWriteMoney"]').val()||0

            if(!(paymentPreMoney>=accAdd(accAdd(paymentPreWriteMoney,trnWriteMoney),paymentPreCurrWriteMoney))){
                layer.msg('累计应付金额+在途应付金额+本次应付金额<=预付款金额！', {icon: 0});
                isFlag = true
                return false
            }
            paymentPreMoneySum+=paymentPreMoney
            paymentPreWriteMoneySum+=paymentPreWriteMoney
        });
        //主表
        //累计已结算金额-累计已付款金额-在途付款金额+（SUM（子表.预付款金额）-SUM（子表.预付款已核销金额））-本次付款申请金额>=0
        //累计已结算金额（动态值）
        var settleupMoney = $('[name="currSettleupMoney"]').val()||0
        //累计已付款金额（动态值）
        var payedMoney = $('[name="currPayedMoney"]').val()||0
        //在途付款金额
        var trnPaymentMoney = $('[name="trnPaymentMoney"]').val()||0
        //本次付款申请金额
        var payMoney = $('[name="payMoney"]').val()||0

        if(accAdd(sub(sub(settleupMoney,payedMoney),trnPaymentMoney),sub(paymentPreMoneySum,paymentPreWriteMoneySum))<payMoney){
            layer.msg('累计已结算金额-累计已付款金额-在途付款金额+（SUM（子表.预付款金额）-SUM（子表.预付款已核销金额））-本次付款申请金额>=0！', {icon: 0, time: 3000});
            isFlag = true
        }

        if (isFlag){
            return false
        }

        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });

        obj.contractCategory = $('[name="contractCategory"]').val()||''

        // 分包合同id
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


        //预付款核销数据
        var $tr2 = $('.contract_out').find('.layui-table-main tr');
        var materialDetailsArr2 = [];
        $tr2.each(function () {
            var materialDetailsObj2 = {
                paymentPreMoney: $(this).find('[data-field="paymentPreMoney"] .layui-table-cell').text(),
                payDate: $(this).find('[data-field="payDate"] .layui-table-cell').text(),
                mtlPaymentNo: $(this).find('[data-field="mtlPaymentNo"] .layui-table-cell').text(),
                paymentPreWriteMoney: $(this).find('[data-field="paymentPreWriteMoney"] .layui-table-cell').text(),
                trnWriteMoney: $(this).find('[data-field="trnWriteMoney"] .layui-table-cell').text(),
                paymentPreCurrWriteMoney: $(this).find('input[name="paymentPreCurrWriteMoney"]').val(),
                subpaymentId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentId') || '',
                subpaymentWriteoffId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('subpaymentWriteoffId') || '',
                advanceId: $(this).find('input[name="paymentPreCurrWriteMoney"]').attr('advanceId') || '',
            }

            materialDetailsArr2.push(materialDetailsObj2);
        });
        obj.plbMtlSubpaymentWriteOffList = materialDetailsArr2;

        if (_type == 1) {
            obj.subpaymentId = data.subpaymentId
        }else{
            obj.projId = parseInt(projId);
        }

        var _flag = false;
        $.ajax({
            url: "/plbMtlSubpayment/updatePlbMtlSubpayment",
            data: JSON.stringify(obj),
            dataType: 'json',
            type: 'post',
            contentType: "application/json;charset=UTF-8",
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(index);
                    tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();
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