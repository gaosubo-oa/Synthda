<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/3/22
  Time: 10:44
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
        <title>分包预付款预览</title>

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
        <script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>
        <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.1"></script>

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
            .layui-col-xs4{
                width: 20%;
            }

        </style>
    </head>
    <body>

    <div class="container" id="htmBox"></div>

        <script>
            var runId = getUrlParam('runId');
            var _disabled = getUrlParam('disabled');
            //var disabledStr = '';
            var _htm = ['<div class="layui-collapse">\n' +
            /* region 材料计划 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">基本信息</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">付款单编号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="mtlPaymentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">项目名称</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input projectName">' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerName" readonly autocomplete="off" placeholder="请选择分包商" class="layui-input chooseCustomerName" style="cursor: pointer;">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同名称<span field="subcontractName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
            '                       <input type="text" name="subcontractName" placeholder="查找分包合同" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;cursor: pointer;">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="contractMoney" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input" title="合同金额">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
                '<div class="layui-row">' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">合同预付款</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="advanceMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同预付款">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">累计已结算金额</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="settleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">累计已付款金额</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="payedMoney" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">本次付款金额</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="thisPayMon"  autocomplete="off" class="layui-input chinese" title="本次付款金额">\n' +
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
                '</div>',
                '<div class="layui-row">' +
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
                '</div>',
                '<div class="layui-row">' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">付款类型<span field="subPaymentType" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <select name="subPaymentType" title="付款类型"></select>\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">付款日期<span field="payDate" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="payDate"  autocomplete="off" class="layui-input chinese" title="付款日期">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">合同类别</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                        <select name="contractCategory" disabled><option value="">请选择</option></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">用途</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="demo" autocomplete="off" class="layui-input">\n' +
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
                '</div>',
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
                '<input type="file" multiple id="fileupload" data-url="/upload?module=subadvancePayment" name="file">' +
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
                TAX_RATE: {},
                CONTRACT_TYPE: {},
                SUB_PAYMENT_TYPE:{},
                INVOICE_TYPE:{},
                CONTRACT_CATEGORY:{}
            }
            var dictionaryStr = 'TAX_RATE,CONTRACT_TYPE,SUB_PAYMENT_TYPE,INVOICE_TYPE,CONTRACT_CATEGORY';

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

            var data = null
            function initPage() {
                $.ajaxSettings.async = true;
                layui.use(['form', 'table', 'soulTable', 'eleTree', 'xmSelect','laydate'], function () {
                    $("#htmBox").html(_htm)
                    if(runId==undefined||runId==""||runId==null){
                        layer.msg("获取信息失败")
                    }
                    var table = layui.table,
                        soulTable = layui.soulTable,
                        form = layui.form,
                        eleTree = layui.eleTree,
                        xmSelect = layui.xmSelect,
                        laydate = layui.laydate;

                    form.render();

                    $.ajax({
                        url:"/subcontractAdvancePayment/getById?runId="+runId,
                        dataType:"json",
                        type:"post",
                        async:false,
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                data = res.obj;
                                $('#leftId').attr('projId',data.projId)
                                $('#leftId').attr('advanceId',data.advanceId)
                                $("#projectName").val(data.projNam)

                                //付款类型
                                var selectStr ='<option value="">请选择</option>';
                                var optionStr = dictionaryObj['SUB_PAYMENT_TYPE']['str'];
                                $('[name="subPaymentType"]').append(selectStr+optionStr)

                                // $('[name="taxRate"]').append(dictionaryObj['TAX_RATE']['str']);
                                $('[name="invoiceType"]').append(dictionaryObj['INVOICE_TYPE']['str']);

                                $('[name="contractCategory"]').append(dictionaryObj['CONTRACT_CATEGORY']['str'])
                                form.render();

                                fileuploadFn('#fileupload', $('#fileContent'));


                                form.val("formTest", data);
                                $('[name="customerName"]').attr('customerId',data.customerId)
                                //合同id
                                $('#baseForm input[name="subcontractName"]').val(data.contractName||'').attr('subcontractId',data.subcontractId || '');

                                //附件
                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }

                                laydate.render({
                                    elem: 'input[name="payDate"]' //指定元素
                                    ,trigger: 'dblclick' //采用click弹出
                                    ,format: 'yyyy-MM-dd'
                                });


                                if('0'!=_disabled){
                                    $('._disabled').find('input,select').attr('disabled', 'disabled');
                                    $('.refresh_no_btn').hide();
                                    $('.deImgs').hide();
                                }


                                form.render();

                                $('#invoiceType').next().find('input').css('background','#e7e7e7')
                            }else{
                                layer.msg("信息获取失败，请刷新重试")
                            }
                        }
                    })
                    //监听客商单位名称选择
                    /*$(document).on('click', '.chooseCustomerName', function () {
                        var _this = $(this);
                        layer.open({
                            type: 1,
                            title: '选择供应商',
                            area: ['80%', '80%'],
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
                                        // height: 'full-180',
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
                                    //修改供应商改变清空合同
                                    $('#baseForm [name="subcontractName"]').val("")
                                    $('#baseForm [name="subcontractName"]').attr('mtlContractId','')

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
                    });*/

                    // 点击选合同
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
                                    where:{projId:$('#leftId').attr('projId'),approvalStatus:"2"},//,model:"subAdvancePayment"
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
                                    $('#baseForm [name="subcontractName"]').val(chooseData.contractName)
                                    $('#baseForm [name="subcontractName"]').attr('subcontractId',chooseData.subcontractId)
                                    //合同金额
                                    $('#baseForm [name="contractMoney"]').val(chooseData.contractMoney || 0)
                                    //合同预付款
                                    $('#baseForm [name="advanceMoney"]').val(chooseData.paymentPre)
                                    //累计已结算金额
                                    $('#baseForm [name="settleupMoney"]').val(chooseData.settleupMoney || 0)
                                    //累计应付金额
                                    $('#baseForm [name="payedMoney"]').val(chooseData.payedMoney || 0);
                                    //本次付款金额
                                    //$('#baseForm [name="thisPayMon"]').val(chooseData.paymentPre)

                                    //在途应付金额
                                    //$('#baseForm [name="trnPaymentMoney"]').val(chooseData.trnPaymentMoney || 0);

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
                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0, time: 2000});
                                }
                            }
                        });
                    });


                });
            }

            function childFunc() {
                if('0'!=_disabled){
                    return true
                }
                if( $("[name='thisPayMon']").val()>$("[name='advanceMoney']").val()){
                    layer.msg('本次付款金额不能大于合同预付款金额', {icon: 0, time: 2000});
                    return false
                }
                var datas = $('#baseForm').serializeArray();
                var obj = {}
                datas.forEach(function (item) {
                    obj[item.name] = item.value
                });
                // obj.warehouseId=parseInt($('#baseForm [name="warehouseId"]').val())
                //客商单位名称的id
                obj.customerId=$('#baseForm [name="customerName"]').attr('customerId')
                //合同id
                obj.subcontractId = $('#baseForm input[name="subcontractName"]').attr('subcontractId') || '';

                obj.projectId = data.projectId;

                obj.contractCategory = $('[name="contractCategory"]').val()||''

                obj.advanceId= data.advanceId;


                // 附件
                var attachmentId = '';
                var attachmentName = '';
                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                    attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                }
                obj.attachmentId = attachmentId;
                obj.attachmentName = attachmentName;

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

                var loadIndex = layer.load();

                var _flag = false;

                $.ajax({
                    url: '/subcontractAdvancePayment/updateById',
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    contentType: "application/json;charset=UTF-8",
                    type: 'post',
                    success: function (res) {
                        layer.close(loadIndex);
                        if (res.code==='0'||res.code===0) {
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
