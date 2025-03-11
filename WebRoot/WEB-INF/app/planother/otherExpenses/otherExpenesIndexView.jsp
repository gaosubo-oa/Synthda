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
        <title>其他费用报销预览</title>

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

            /* .layui-select-disabled .layui-disabled {
                 color: #222 !important;
             }*/

            .deptDel {
                position: absolute;
                top: 10px;
                right: 4px;
                color: #1E9FFF;
                cursor: pointer;
            }

            .deptDel:hover {
                color: #ff0000;
            }

            .con_left {
                float: left;
                height: 100%;
            }

            .con_right {
                float: left;
                height: 100%;
                padding-left: 10px;
                box-sizing: border-box;
            }


            .openFile input[type=file]{
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 18px;
                z-index: 99;
                opacity: 0;
            }
            #reimbursementDetailsModule td[data-field="attachmentName"] .layui-table-cell{
                height: auto;
                overflow:visible;
                text-overflow:inherit;
                white-space:normal;
                word-break: break-word;
            }
            .col-xs{
                width: 20%;
            }
            /*选中行样式*/
            .select_Tr {
                background: #009688 !important;
                color: #fff !important;
            }

        </style>
    </head>
    <body>
    <script type="text/html" id="toolbar">
        <div class="layui-btn-container" style="height: 30px;">
            <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
        </div>
    </script>

    <script type="text/html" id="toolbarDemoIn">
        <div class="layui-btn-container" style="height: 30px;">
            <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
        </div>
    </script>

    <script type="text/html" id="barDemo2">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
    </script>
    <script type="text/html" id="internalBar">
        <a href="javascript:;" class="openFile" style="position:relative;" lay-event="butfile">
            <button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
                <i class="layui-icon" >&#xe67c;</i>附件上传
            </button>
            <input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=costReiBud"  name="file">
        </a>
    </script>

    <div class="container" id="htmBox"></div>

        <script>
            var MYPROJECT = false;
            $.ajax({
                url: '/syspara/selectTheSysPara?paraName=MYPROJECT',
                dataType: 'json',
                type: 'post',
                success: function (res) {
                    if(res.object&&res.object[0]&&res.object[0].paraValue&&res.object[0].paraValue=='yongli'){
                        MYPROJECT = true;
                    }
                }
            });

            var runId = getUrlParam('runId');
            var _disabled = getUrlParam('disabled');
            //var disabledStr = '';
            var _htm = '<div class="container _disabled">\n' +
                '<input type="hidden" id="leftId" value="">\n' +
                '<input type="hidden" id="03" value="">\n' +
                '<input type="hidden" id="04" value="">\n' +
                '<div class="wrapper">\n' +
                '<div class="layui-collapse">\n' +
                '<div class="layui-colla-item">\n' +
                '<h2 class="layui-colla-title">基本信息</h2>\n' +
                '<div class="layui-colla-content layui-show">\n' +
                '<form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                /* region 第一行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">单据编号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">\n' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" readonly id="projectName" name="projectName" autocomplete="off"  class="layui-input " style="background:#e7e7e7">\n' +
                '                           <input type="hidden" name="reiId" autocomplete="off"  class="layui-input ">\n' +
                '                       </div>\n' +
                '                   </div>\n' +
                '               </div>\n' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销日期<span field="reiDate" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" name="reiDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">经手人<span field="handerId" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" name="handerId" id="handerId" placeholder="选择经手人" autocomplete="off" class="layui-input" >' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销人<span field="reiUserId" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" id="reiUserId" placeholder="选择报销人" name="reiUserId" readonly autocomplete="off" class="layui-input" >' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                /* region 第二行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">所属部门<span field="department" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" readonly name="department" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                /*'                       <select '+disabledStr+' name="department"></select>' +*/
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销金额<span field="reiMon" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" readonly name="reiMon" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">费用类型<span field="costType" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <select id="costType" name="costType" "></select>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">备注</label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" id="memo"  name="memo" autocomplete="off"  class="layui-input">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">其他费用需求计划</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                               <input type="text" name="reiPlanId" readonly autocomplete="off" class="layui-input click_one" style="width: 60%; padding-right: 25px;color: blue;background:#e7e7e7;cursor: pointer;float: left">' +
                '                               <a class="layui-btn chooseMtlPlanId" style="width: 30%; float:right;">选择</a>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                /* region 第三行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;display: none">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">是否含招待费</label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" readonly name="businessFlag" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                /*'               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="radio" ' + disabledStr + ' name="overStandard" lay-filter="overStandard" value="1" title="是">' +
                '                       <input type="radio" ' + disabledStr + ' name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +*/
                /*'               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item" style="display: none;">' +
                '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off"  class="layui-input">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +*/
                /*'               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销事由<span field="reiReason" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                /!*'                       <textarea '+disabledStr+' name="reiReason" placeholder="请输入内容" class="layui-textarea"></textarea>' +*!/
                '                       <input type="text" ' + disabledStr + ' name="reiReason" autocomplete="off" class="layui-input">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +*/
                '           </div>'+
                /* endregion */
                /* region 第四行 */
                /*'           <div class="layui-row">' +
                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销事由<span field="reiReason" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <textarea '+disabledStr+' name="reiReason" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +*/
                /* endregion */
                /* region 第五行 */
                '           <div class="layui-row">' +
                /*'               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">附件数量</label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" '+disabledStr+' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +*/
                /*'               <div class="layui-col-xs8" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">附件</label>' +
                '                       <div class="layui-input-block form_block">' +
                '                           <div class="file_module">' +
                '                               <div id="fileContent" class="file_content"></div>' +
                '                               <div class="file_upload_box">' +
                '                                   <a href="javascript:;" class="open_file">' +
                '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=costRei" name="file">' +
                '                                   </a>' +
                '                                   <div class="progress">' +
                '                                       <div class="bar"></div>' +
                '                                   </div>' +
                '                                   <div class="bar_text"></div>' +
                '                               </div>' +
                '                           </div>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +*/
                '           </div>' +
                /* endregion */
                '</form>\n' +
                '</div>\n' +
                '</div>\n' +
                '<div class="layui-colla-item" id="reimbursementDetailsModule">\n' +
                '<h2 class="layui-colla-title">报销明细</h2>\n' +
                '<div class="layui-colla-content layui-show">\n' +
                '<table id="reimbursementDetailsTable" lay-filter="reimbursementDetailsTable"></table>\n' +
                '</div>\n' +
                '</div>\n' +
                '<div class="layui-colla-item" id="paymentDetailsModule">\n' +
                '<h2 class="layui-colla-title">付款明细</h2>\n' +
                '<div class="layui-colla-content layui-show">\n' +
                '<table id="paymentDetailsTable" lay-filter="paymentDetailsTable"></table>\n' +
                '</div>\n' +
                '</div>\n' +
                '</div>' +
                /*'<div style="text-align: center;padding-top: 10px"><button class="layui-btn layui-btn-normal layui-btn-lg preservation"> 保存</button></div>\n' +*/
                '</div>\n' +
                '</div>';
            // 报销单明细数据
            var reiBudList = [];
            var _dataa;
            // 付款单明细数据
            var reiPayList = [];

            var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });
            var dictionaryObj = {
                PAYMENT_METHOD: {},
                REIMBURSEMENT_TYPE: {},
                TRAVEL_TYPE: {},
                COST_TYPE:{},
                CONTROL_TYPE:{},
                CBS_UNIT:{}
            }
            var dictionaryStr = 'PAYMENT_METHOD,REIMBURSEMENT_TYPE,TRAVEL_TYPE,COST_TYPE,CONTROL_TYPE,CBS_UNIT';
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
            var paymentDetailsTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'payMethod',
                    title: '付款方式',
                    event: 'choosePay',
                    minWidth: 150,
                    templet: function (d) {
                        var str = dictionaryObj['PAYMENT_METHOD']['object'][d.payMethod] || '';
                        return '<input type="text" name="payMethod" payId="' + undefind_nullStr(d.payId) + '" reiId="' + undefind_nullStr(d.reiId) + '" readonly payMethod="' + undefind_nullStr(d.payMethod) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'colPeo',
                    title: '收款人',
                    minWidth: 150,
                    event: 'chooseCollectionUser',
                    templet: function (d) {
                        var str = '';
                        var attr = '';
                        if (d.colPeo&&d.userType=='2') {
                            str = undefind_nullStr(d.colPeoName);
                            attr = 'colPeo="' + d.colPeo + '" userType="2"';
                        } else if(d.colPeo&&d.userType=='1') {
                            str = undefind_nullStr(d.colPeoName).replace(/,$/, '');
                            attr = 'colPeo="' + d.colPeo  + '" userType="1"';
                        }
                        return '<input readonly name="colPeo" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'bankAccount',
                    title: '银行账号',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input type="text" name="bankAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.bankAccount) + '">';
                    }
                },
                {
                    field: 'bankDeposit',
                    title: '开户行',
                    minWidth: 150,
                    templet: function (d) {
                        /*return '<span class="bankDeposit">' + undefind_nullStr(d.bankDeposit) + '</span>';*/
                        return '<input type="text" name="bankDeposit" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.bankDeposit) + '">';
                    }
                },
                {
                    field: 'colMon',
                    title: '收款金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input type="text" name="colMon"  class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.colMon) + '">';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.remark) + '">';
                    }
                }
            ]
            if ('0'==_disabled) {
                paymentDetailsTableCols.push({
                    /*fixed: 'right',*/
                    align: 'center',
                    toolbar: '#barDemo2',
                    title: '操作',
                    minWidth: 100
                });
            }

            var reimbursementDetailsTableCols = [
                {type: 'numbers', title: '序号'},
                /*{
                    field: 'deptItemId',
                    title: '预算科目',
                    event: 'chooseItem',
                    minWidth: 200,
                    templet: function (d) {
                        var str = d.plbDeptBudgetItem ? undefind_nullStr(d.plbDeptBudgetItem.itemName) : undefind_nullStr(d.itemName);
                        return '<input name="deptItemId" listId="' + undefind_nullStr(d.listId) + '" deptItemId="' + undefind_nullStr(d.deptItemId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },*/
                {
                    field: 'wbsName', title: 'WBS',minWidth:200, templet: function(d) {
                        return '<span class="wbsName" wbs="'+(d.wbsId||'')+'" budgetId="'+(d.budgetId||'')+'" reiId="'+(d.reiId||'')+'" projBudgetId="'+(d.projBudgetId||'')+'">'+ (d.wbsName || '') + '</span>';
                    }
                },
                {
                    field: 'rbsName', title: 'RBS',minWidth:200, templet: function (d) {
                        return '<span class="rbsName" rbs="'+(d.rbsId||'')+'" >' + (d.rbsName || '') + '</span>';
                    }
                },
                {
                    field: 'cbsName', title: 'CBS',minWidth:200, templet: function (d) {
                        return '<span class="cbsName" cbs="'+(d.cbsId||'')+'" >' + (d.cbsName || '') + '</span>';
                    }
                },
                {
                    field: 'yearBudQuata',
                    title: '管理目标金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="yearBudQuata" >' + (d.yearBudQuata||0) + '</span>';
                    }
                },
                {
                    field: 'monQuata', title: '截止当前额度', minWidth: 150, templet: function (d) {
                        return '<span class="monQuata" currMonQuata="'+(d.currMonQuata||'')+'" >' + (d.monQuata||0) + '</span>';
                    }
                },
                {
                    field: 'monHappenQuata', title: '截止当前已发生额度', minWidth: 180, templet: function (d) {
                        return '<span class="monHappenQuata" currMonHappenQuata="'+(d.currMonHappenQuata||'')+'" >' + (d.monHappenQuata||0) + '</span>';
                    }
                },
                /*{
                    field: 'exaMon', title: '在途中审批金额', minWidth: 150, templet: function (d) {
                        return '<span class="exaMon">' + (d.exaMon||0) + '</span>';
                    }
                },*/

                /*{
                    field: 'budgetBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                        return '<span class="budgetBalance">' + undefind_nullStr(d.budgetBalance) + '</span>';
                    }
                },*/
                {
                    field: 'trnApplicationAmount', title: '在途报销金额', minWidth: 140, templet: function (d) {
                        return '<span class="trnApplicationAmount">' + (d.trnApplicationAmount || '0') + '</span>';

                    }
                },
                {
                    field: 'reiReason', title: '本次报销事由', minWidth: 300, templet: function (d) {
                        return '<input name="reiReason" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.reiReason) + '">';
                    }
                },
                {
                    field: 'implementDate', title: '发生日期*', minWidth: 140, event: 'dateSelection', templet: function (d) {
                        return '<input type="text"  name="implementDate" class="layui-input" style="height: 100%;" value="' + (d.implementDate || '') + '">'
                    }
                },
                {
                    field: 'currentReimbursementAmount',
                    title: '本次报销金额*',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input name="currentReimbursementAmount" type="number"  class="layui-input <!--input_floatNum-->" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.currentReimbursementAmount) + '">';
                    }
                },
                {
                    field: 'taxAmount',
                    title: '税额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input name="taxAmount" type="number"  class="layui-input <!--input_floatNum-->" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax',
                    title: '不含税金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input name="amountExcludingTax" type="number"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.amountExcludingTax) + '">';
                    }
                },
                /* {
                     field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                         return '<input readonly name="deptId" type="text" deptId="' + undefind_nullStr(d.deptId) + '" class="layui-input choose_dept" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + undefind_nullStr(d.deptName) + '">';
                     }
                 },*/
                /*{
                    field: 'reiReason', title: '事项说明', minWidth: 300, templet: function (d) {
                        return '<input name="reiReason" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.reiReason) + '">';
                    }
                },*/
                /*{
                    field: 'applyId', title: '关联申请单', minWidth: 150, templet: function (d) {
                        return '<span class="applyId">' + undefind_nullStr(d.applyId) + '</span>';
                    }
                },
                {
                    field: 'planTaskId', title: '关联工作计划', event: 'choosePlanTask', style: 'cursor: pointer;', minWidth: 150, templet: function (d) {
                        return '<span class="planTaskId" planTaskId="' + undefind_nullStr(d.planTaskId) + '">' + undefind_nullStr(d.planTaskName) + '</span>';
                    }
                },*/
                {
                    field: 'attachmentName',
                    title: '发票内容',
                    align: 'center',
                    minWidth: 200,
                    templet: function (d) {
                        var fileArr = d.attachmentList;
                        return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                            '</div>'

                    }
                },
                /*{title: '发票上传', align: 'center', toolbar: '#internalBar', minWidth: 200},*/
            ]
            if ('0'==_disabled) {
                reimbursementDetailsTableCols.push(
                    {title: '发票上传', align: 'center', toolbar: '#internalBar', minWidth: 200},
                    {
                        /*fixed: 'right',*/
                        align: 'center',
                        toolbar: '#barDemo2',
                        title: '操作',
                        minWidth: 100
                    }
                );
            }
            var iframeLayerIndex = 0;

            function initPage() {
                $.ajaxSettings.async = true;
                layui.use(['form', 'table', 'soulTable','eleTree','xmSelect','laydate','element'], function () {
                    var table = layui.table,
                        soulTable = layui.soulTable,
                        form = layui.form,
                        eleTree = layui.eleTree,
                        xmSelect = layui.xmSelect,
                        laydate = layui.laydate,
                        element  = layui.element;

                    $("#htmBox").html(_htm)
                    if(runId==undefined||runId==""||runId==null){
                        layer.msg("获取信息失败")
                    }

                    form.render();
                    var tableObj = null;
                    var title = '';
                    //var costType = $('#leftId').val()
                    $.ajax({
                        url:"/otherExpenes/getById?runId="+runId,
                        dataType:"json",
                        type:"post",
                        async:false,
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                data = res.obj;
                                $('#leftId').attr('projId',data.projId)
                                $('#leftId').attr('reiId',data.reiId)
                                $("#projectName").val(data.projNam)

                                //经手人
                                $('#handerId').on('click', function() {
                                    user_id = 'handerId';
                                    $.popWindow('/common/selectUser?0');
                                });
                                //报销人
                                $('#reiUserId').on('click', function() {
                                    user_id = 'reiUserId';
                                    $.popWindow('/common/selectUser?0');
                                });


                                var optionStr = '<option value="">请选择</option>'
                                optionStr += dictionaryObj.COST_TYPE.str
                                $('#costType').append(optionStr)
                                //附件
                                fileuploadFn('#fileupload', $('#fileContent'));

                                form.val('baseForm', data);
                                // 报销日期
                                $('input[name="reiDate"]', $('#baseForm')).val(format(data.reiDate));
                                // 经手人
                                $('input[name="handerId"]', $('#baseForm')).attr('user_id', data.handerId).val((data.handerName || '').replace(/,$/, ''));
                                // 报销人
                                $('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId', data.reiUserId).val((data.reiUserName || '').replace(/,$/, ''));
                                // 部门
                                $('input[name="department"]', $('#baseForm')).attr('deptId', data.department).val((data.departmentName || '').replace(/,$/, ''));

                                $('.click_one').attr('reiPlanId',data.reiPlanId).val(data.reiPlan?data.reiPlan.reiPlanName:'')

                                //附件
                                /*if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }*/
                                // 报销明细
                                reiBudList = data.reiBudList || [];
                                // 付款明细
                                reiPayList = data.reiPayList || [];
                                // 初始化报销明细列表
                                table.render({
                                    elem: '#reimbursementDetailsTable',
                                    data: reiBudList,
                                    toolbar: ('0'!=_disabled) ? false : '#toolbar',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [reimbursementDetailsTableCols],
                                    done: function (obj) {

                                        reiBudList = obj.data;
                                        if ('0'==_disabled) {
                                            $('#reimbursementDetailsModule').find('input[name="deptId"]').each(function (i, v) {
                                                $(this).attr('id', 'dept_' + i);
                                            });

                                            $('#reimbursementDetailsModule').find('input[name="reiUserId"]').each(function (i, v) {
                                                $(this).attr('id', 'user_' + i);
                                            });
                                        }
                                    }
                                });
                                // 初始化付款明细列表
                                table.render({
                                    elem: '#paymentDetailsTable',
                                    data: reiPayList,
                                    toolbar: ('0'!=_disabled) ? false : '#toolbarDemoIn',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [paymentDetailsTableCols],
                                    done: function () {

                                        $('#paymentDetailsModule').find('input[name="colPeo"]').each(function (i, v) {
                                            $(v).attr('id', 'colPeo' + i);
                                        });
                                    }
                                });
                                if('0'!=_disabled){
                                    $('._disabled').find('input').attr('readonly', true);
                                    $('[name="reiDate"]').attr('disabled', 'disabled');
                                    $('#costType').attr("disabled",'disabled');
                                    $('.deImgs').hide();
                                    $('.chooseMtlPlanId').hide();
                                }

                                form.render();
                            }else{
                                layer.msg("信息获取失败，请刷新重试")
                            }
                        }
                    })

                    //监听本次报销金额
                    $(document).on('input propertychange', 'input[name="currentReimbursementAmount"]', function () {
                        if (_disabled=='1') {
                            return false
                        }

                        var $tr = $('#reimbursementDetailsModule').find('.layui-table-main tr [name="currentReimbursementAmount"]');
                        //计算报销金额
                        var reiMon = 0;
                        $tr.each(function (index,element) {
                            reiMon=accAdd(reiMon,($(element).val()||0));
                        });
                        $('[name="reiMon"]').val(retainDecimal(reiMon,2))
                    });


                    // 报销明细-选择
                    table.on('toolbar(reimbursementDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                var wbsSelectTree = null;
                                var cbsSelectTree = null;
                                var _this = $(this);
                                layer.open({
                                    type: 1,
                                    title: '管理目标选择',
                                    area: ['100%', '100%'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="layui-form" id="objectives">' +
                                    //下拉选择
                                    '           <div class="layui-row" style="margin-top: 10px">' +
                                    '               <div class="layui-col-xs2">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                                    '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
                                    '               <div class="layui-col-xs2">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                                    '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
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

                                        laodTable();

                                        $('.search_mtl').on('click', function(){
                                            var cbsId = cbsSelectTree.getValue('valueStr');
                                            var wbsId = wbsSelectTree.getValue('valueStr');
                                            var itemNo = $('[name="itemNo"]').val();
                                            var itemName =$('[name="itemName"]').val();

                                            laodTable(wbsId, cbsId,itemNo,itemName);
                                        });

                                        // 加载表格
                                        function laodTable(wbsId, cbsId,itemNo,itemName) {
                                            table.render({
                                                elem: '#managementBudgetTable',
                                                url: '/manageProject/getBudgetByProjId',
                                                where: {
                                                    projId: $('#leftId').attr('projId'),
                                                    wbsId: wbsId || '',
                                                    cbsId: cbsId || '',
                                                    itemNo: itemNo || '',
                                                    itemName: itemName || '',
                                                    rbsTyep:'other'
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
                                                                str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                                            }
                                                            return str;
                                                        }
                                                    },
                                                    // {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                                    // {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                                    {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                                    // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                                    {field: 'monQuata', title: '截止当前额度',minWidth:170},
                                                    {field: 'realOutMoney', title: '截止当前已发生额度',minWidth:170},
                                                    //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                                    //{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                                ]],
                                                done:function(res){
                                                    _dataa=res.data;
                                                    if(reiBudList!=undefined&&reiBudList.length>0){
                                                        for(var i = 0 ; i <_dataa.length;i++){
                                                            for(var n = 0 ; n < reiBudList.length; n++){
                                                                if(_dataa[i].projBudgetId == reiBudList[n].projBudgetId){
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
                                        var dataArr = getReimbursementDetailsData(2).dataArr;

                                        var checkStatus=[];
                                        $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(indexx,item){
                                            if($(item).find('.layui-form-checked').length>0){
                                                checkStatus.push(_dataa[indexx]);
                                            }
                                        })
                                        //var checkStatus = table.checkStatus('managementBudgetTable').data;

                                        var oldDataArr = [];
                                        if (checkStatus.length > 0) {
                                            for(var i=0;i<checkStatus.length;i++){
                                                var oldDataObj = {
                                                    projBudgetId:checkStatus[i].projBudgetId,
                                                    wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                                    wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                                    cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                                    cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                                    rbsName:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsLongName:'',
                                                    rbsId:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsId:'',
                                                    yearBudQuata:checkStatus[i].manageTarAmount,
                                                    monQuata:checkStatus[i].monQuata,
                                                    currMonQuata:checkStatus[i].currMonQuata,//动态值
                                                    monHappenQuata:checkStatus[i].realOutMoney,
                                                    currMonHappenQuata:checkStatus[i].currMonHappenQuata,//动态值
                                                    trnApplicationAmount:checkStatus[i].trnApplicationAmount
                                                }
                                                if(dataArr){
                                                    var _flag = true
                                                    for(var j=0;j<dataArr.length;j++){
                                                        if(dataArr[j].projBudgetId==checkStatus[i].projBudgetId){
                                                            _flag = false
                                                        }
                                                    }
                                                    if(_flag){
                                                        dataArr.push(oldDataObj);
                                                    }

                                                }else{
                                                    dataArr.push(oldDataObj);
                                                }

                                            }

                                            layer.close(index);

                                            table.reload('reimbursementDetailsTable', {
                                                data: dataArr
                                            });
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });


                                break;
                        }
                    });
                    // 报销明细-行操作
                    table.on('tool(reimbursementDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            if (data.budgetId) {
                                $.get('/otherExpenes/delReiBud', {ids: data.budgetId}, function (res) {
                                    if (res.code=="0"||res.code==0) {
                                        layer.msg('删除成功!', {icon: 1, time: 2000});
                                        obj.del();
                                        var reimbursementData = getReimbursementDetailsData(2);
                                        $('[name="reiMon"]', $('#baseForm')).val(reimbursementData.amountTotal);
                                        table.reload('reimbursementDetailsTable', {
                                            data: reimbursementData.dataArr
                                        });
                                    } else {
                                        layer.msg('删除失败!', {icon: 2, time: 2000});
                                    }
                                });
                            } else {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                var reimbursementData = getReimbursementDetailsData(2);
                                $('[name="reiMon"]', $('#baseForm')).val(reimbursementData.amountTotal);
                                table.reload('reimbursementDetailsTable', {
                                    data: reimbursementData.dataArr
                                });
                            }
                        }else if (layEvent == 'butfile') {
                            var $tr = $tr.selector
                            fileuploadFn( $tr+' [id^=fileupload]', $( $tr+' [id^=fileAll]'));
                        }else if (layEvent == 'dateSelection') {
                            var $tr2 = $('#reimbursementDetailsModule').find($tr.selector).find('input[name="implementDate"]');
                            $tr2.each(function (index,element) {
                                laydate.render({
                                    elem: element
                                    , trigger: 'click'
                                    , format: 'yyyy-MM-dd'
                                    // , format: 'yyyy-MM-dd HH:mm:ss'
                                    ,value: new Date()
                                });
                            })
                        }
                    });

                    // 付款明细-加行
                    table.on('toolbar(paymentDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var dataArr = getPaymentmentDetailsData(true).dataArr;
                                dataArr.push({
                                    /*colPeo: ($('#reiUserId').attr('user_id') || '').replace(/,$/, ''),
                                    colPeoName: $('#reiUserId').val()*/
                                });
                                table.reload('paymentDetailsTable', {
                                    data: dataArr
                                });
                                break;
                        }
                    });
                    // 付款明细-行操作
                    table.on('tool(paymentDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            if (data.payId) {
                                $.get('/otherExpenes/delReiPay', {ids: data.payId}, function (res) {
                                    if (res.flag) {
                                        layer.msg('删除成功!', {icon: 1, time: 2000});
                                        obj.del();
                                        table.reload('paymentDetailsTable', {
                                            data: getPaymentmentDetailsData(true).dataArr
                                        });
                                    } else {
                                        layer.msg('删除失败!', {icon: 2, time: 2000});
                                    }
                                });
                            } else {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('paymentDetailsTable', {
                                    data: getPaymentmentDetailsData(true).dataArr
                                });
                            }
                        } else if (layEvent === 'choosePay') {
                            if (type == 3) {
                                return false;
                            }
                            layer.open({
                                type: 1,
                                title: '选择付款方式',
                                area: ['400px', '500px'],
                                maxmin: true,
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="container">',
                                    '<table id="paymentTable" lay-filter="paymentTable"></table>',
                                    '</div>'].join(''),
                                success: function () {
                                    var data = []

                                    $.each(dictionaryObj['PAYMENT_METHOD']['object'], function (k, o) {
                                        var obj = {
                                            type: k,
                                            value: o
                                        }
                                        data.push(obj);
                                    });

                                    // 获取科目
                                    table.render({
                                        elem: '#paymentTable',
                                        data: data,
                                        page: false,
                                        cols: [[
                                            {type: 'radio', title: '选择'},
                                            {field: 'value', title: '付款方式'}
                                        ]]
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('paymentTable');
                                    if (checkStatus.data.length > 0) {
                                        var payData = checkStatus.data[0];

                                        $tr.find('input[name="payMethod"]').val(payData.value);
                                        $tr.find('input[name="payMethod"]').attr('payMethod', payData.type);

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        } else if (layEvent === 'chooseCollectionUser') {
                            if (type == 3) {
                                return false;
                            }
                            var userIndex = layer.open({
                                title: false,
                                area: ['300px', '200px'],
                                btn: false,
                                content: '<div>' +
                                    '<p style="margin-top: 23px;margin-bottom: 30px;text-align: center;"><button class="layui-btn layui-btn-normal" id="selectUser">组织机构内选择</button></p>' +
                                    '<p style="text-align: center;"><button class="layui-btn layui-btn-normal" id="selectCustomer">客商内选择</button></p>' +
                                    '</div>',
                                success: function () {
                                    $('#selectUser').on('click', function() {
                                        layer.close(userIndex);
                                        user_id = $tr.find('[name="colPeo"]').attr('id');
                                        $tr.find('[name="colPeo"]').attr('customerId', '').attr('userType', 1);
                                        $.popWindow('/common/selectUser?0');
                                    });

                                    $('#selectCustomer').on('click', function() {
                                        layer.close(userIndex);
                                        $tr.find('[name="colPeo"]').attr('user_id', '').attr('userType', 2);
                                        layer.open({
                                            type: 1,
                                            title: '选择收款人',
                                            area: ['70%', '80%'],
                                            maxmin: true,
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
                                                '<div class="mtl_table_box" style="display: none;margin: auto 20px">' +
                                                //查询
                                                '       <div class="layui-row inSearchContent">' +
                                                '             <div class="layui-col-xs4">\n' +
                                                '                  <input type="text" name="customerName" placeholder="收款人名称" autocomplete="off" class="layui-input">\n' +
                                                '             </div>\n' +
                                                '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                                                '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                                                '             </div>\n' +
                                                '       </div>'+
                                                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                                '     <div id="downBox" style="margin-top: 20px;">\n' +
                                                '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                                                '      </div>' +
                                                '</div>' +
                                                '<div class="mtl_no_data" style="text-align: center;">' +
                                                '<div class="no_data_img" style="margin-top:12%;">' +
                                                '<img style="margin-top: 2%;" src="/img/noData.png">' +
                                                '</div>' +
                                                '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
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
                                                    $('#downBox').hide()
                                                    loadMtlTable(d.data.currentData.typeNo);
                                                });

                                                function loadMtlTable(merchantType) {
                                                    materialsTable = table.render({
                                                        elem: '#materialsTable',
                                                        url: '/PlbCustomer/getDataByCondition',
                                                        where: {
                                                            merchantType: merchantType
                                                        },
                                                        page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                                            , limits: [5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                                                            , limit:5
                                                            , first: false //不显示首页
                                                            , last: false //不显示尾页
                                                        }, //开启分页
                                                        response: {
                                                            statusName: 'flag',
                                                            statusCode: true,
                                                            msgName: 'msg',
                                                            countName: 'totleNum',
                                                            dataName: 'data'
                                                        },
                                                        request: {
                                                            limitName: 'pageSize'
                                                        },
                                                        cols: [[
                                                            {type: 'radio', title: '选择'},
                                                            {field: 'customerNo', title: '客商编号', minWidth: 100},
                                                            {field: 'customerName', title: '客商单位名称', minWidth: 150},
                                                            {field: 'customerShortName', title: '客商单位简称', minWidth: 150},
                                                            {field: 'customerOrgCode', title: '组织机构代码', minWidth: 150},
                                                            /*{field: 'taxNumber', title: '税务登记号', minWidth: 150},
                                                            {field: 'accountName', title: '开户行名称', minWidth: 150},
                                                            {field: 'accountNumber', title: '开户行账户', minWidth: 150}*/
                                                        ]]
                                                    });
                                                }
                                            },
                                            yes: function (index) {
                                                var checkStatus = table.checkStatus('materialsTable');
                                                var checkStatus2 = table.checkStatus('tableDemoInDown');
                                                if (checkStatus.data.length > 0) {
                                                    var mtlData = checkStatus.data[0];
                                                    $tr.find('[name="colPeo"]').val(mtlData.customerName);
                                                    $tr.find('[name="colPeo"]').attr('colPeo', mtlData.customerId);
                                                    $tr.find('[name="colPeo"]').attr('userType', '2');
                                                    layer.close(index);
                                                }else {
                                                    layer.msg('请选择一项！', {icon: 0});
                                                }
                                                if (checkStatus2.data.length > 0) {
                                                    var mtlData = checkStatus2.data[0];
                                                    $tr.find('[name="bankAccount"]').val(mtlData.bankAccount);
                                                    $tr.find('[name="bankDeposit"]').val(mtlData.bankOfDeposit);
                                                    layer.close(index);
                                                }
                                            }
                                        });
                                    });
                                }
                            });
                        }
                    });
                    //监听行单击事件
                    table.on('row(materialsTable)', function (obj) {
                        // console.log(obj.data) //得到当前行数据
                        var data = obj.data
                        if($(obj.tr[0]).find('.layui-form-radioed').length>0){
                            $('#downBox').show()
                            /* obj.tr.addClass('select_Tr').siblings('tr').removeClass('select_Tr')*/
                            tableShowDown(data.plbCustomerBankList)
                        }

                    });
                    function tableShowDown(data) {
                        table.render({
                            elem: '#tableDemoInDown',
                            //url: '/PlbCustomer/getDataByCondition',
                            data:data,
                            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                , limits: [5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                                , limit:5
                                , first: false //不显示首页
                                , last: false //不显示尾页
                            }, //开启分页
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            },
                            request: {
                                limitName: 'pageSize'
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'bankOfDeposit', title: '开户行名称', minWidth: 150},
                                {field: 'bankAccount', title: '开户行账户', minWidth: 150}
                            ]]
                        });
                    }
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

                    //选择其他费用需求计划
                    $(document).on('click','.chooseMtlPlanId',function () {
                        var projId = $('#leftId').attr('projId');
                        var cols=[
                            {type:'radio'},
                            {field: 'documnetNum', title: '单据号', minWidth:140,sort: true, hide: false},
                            {field: 'reiPlanName', title: '计划名称', minWidth:140, sort: true, hide: false},
                            {field: 'projectName', title: '所属项目',  minWidth:100,sort: true, hide: false},
                            {field: 'estimateAmountSum', title: '需求计划金额', minWidth:180, sort: true, hide: false},
                            {field: 'needDate', title: '需用日期',  minWidth:100,sort: true, hide: false, templet: function (d) {
                                    return format(d.needDate);
                                }},
                            {field: 'createDate', title: '编制时间',  minWidth:100,sort: true, hide: false, templet: function (d) {
                                    return format(d.createDate);
                                }
                            },
                            // {title: '操作', width: 100, align: 'center', toolbar: '#revisionBarDemo'}
                        ]
                        layer.open({
                            type: 1,
                            title: '选择其他费用需求计划',
                            btn: ['确定','取消'],
                            btnAlign: 'c',
                            area: ['90%', '80%'],
                            maxmin: true,
                            content: '<div class="wrap_right flow_Table2" style="margin: 10px;">\n' +
                                '<div style="position: relative">\n' +
                                '<div class="table_box">\n' +
                                '<table id="flowTable2" lay-filter="flowTable2"></table>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '</div>',
                            success: function () {

                                table.render({
                                    elem: '#flowTable2',
                                    url: '/otherCostReiPlan/select',
                                    cols: [cols],
                                    //height: 'full-220',
                                    page: {
                                        limits: [10, 20, 30, 40, 50]
                                    },
                                    where: {
                                        projectId:projId || '',
                                        delFlag: '0',
                                        isCostRei:'costRei'
                                    },
                                    autoSort: false,
                                    request: {
                                        limitName: 'pageSize'
                                    },
                                });
                            },
                            yes: function (index) {
                                var checkStatus = table.checkStatus('flowTable2');
                                if (checkStatus.data.length > 0) {
                                    $('.click_one').val(checkStatus.data[0].reiPlanName).attr('reiPlanId',checkStatus.data[0].reiPlanId)
                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        })
                    });

                    //选择查看详情
                    $(document).on('click','.click_one',function () {
                        if(!($('.click_one').attr('reiPlanId'))){
                            return false
                        }

                        var data=null

                        layer.open({
                            type: 1,
                            title: '查看详情',
                            area: ['100%', '100%'],
                            btn: ['确定'],
                            btnAlign: 'c',
                            content: ['<div class="layui-collapse">\n' ,
                                /* region 材料计划 */
                                '  <div class="layui-colla-item">\n' +
                                '    <h2 class="layui-colla-title">其他费用需求计划</h2>\n' +
                                '    <div class="layui-colla-content layui-show plan_base_info">' +
                                '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                                /* region 第一行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" style="background:#e7e7e7;" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">需求计划名称<span field="reiPlanName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="reiPlanName" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">编制时间<span field="createDate" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="createDate" readonly id="createDate" autocomplete="off" class="layui-input" style="background:#e7e7e7;width: 53%;display: inline-block">\n' +
                                '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">WBS<span field="wbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="wbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +

                                '           </div>' ,
                                /* endregion */
                                /* region 第二行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">RBS<span field="rbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="rbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">CBS<span field="cbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="cbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">控制方式<span field="controlType" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="controlType"  readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">单位</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="itemUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">管理目标数量<span field="manageTarNum" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                                '                       <input type="text" name="manageTarNum" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' ,
                                /* endregion */
                                /* region 第三行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="manageTarAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">累计已发生报销金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="realOutMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">在途报销金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="trnAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">本次需求计划金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="estimateAmountSum"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">需用日期<span field="needDate" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="needDate" id="needDate" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' ,
                                '           </div>' ,
                                /* endregion */
                                /* region 第四行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">备注</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>',
                                '           </div>',
                                /* endregion */
                                /* region 第五行 */
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
                                '<input type="file" multiple id="fileupload" data-url="/upload?module=costReiPlanList" name="file">' +
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
                                '           </div>' ,
                                /* endregion */
                                '       </form>' +
                                '    </div>\n' +
                                '  </div>\n' ,
                                /* endregion */
                                /* region 需求计划明细 */
                                '  <div class="layui-colla-item">\n' +
                                '    <h2 class="layui-colla-title">需求计划明细</h2>\n' +
                                '    <div class="layui-colla-content mtl_info layui-show">' +
                                '       <div>' +
                                '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                                '      </div>' +
                                '    </div>\n' +
                                '  </div>\n' ,
                                /* endregion */
                                '</div>'].join(''),
                            success: function () {
                                $.ajax({
                                    url: '/otherCostReiPlan/getById?kayId='+$('.click_one').attr('reiPlanId'),
                                    dataType: 'json',
                                    type: 'post',
                                    async:false,
                                    success: function (res) {
                                        if (res.code==='0'||res.code===0) {
                                            data = res.obj
                                        } else {
                                            layer.msg('获取数据失败!', {icon: 0});
                                        }
                                    }
                                });

                                //回显数据
                                if (data) {
                                    //回显项目名称
                                    getProjName('#projectName',data.projId)

                                    fileuploadFn('#fileupload', $('#fileContent'));

                                    var reiPlanListData = [];
                                    //回显数据

                                    form.val("formTest", data);

                                    $('.plan_base_info input[name="wbsName"]').attr('wbsId', data.wbsId || '');
                                    $('.plan_base_info input[name="rbsName"]').attr('rbsId', data.rbsId || '');
                                    $('.plan_base_info input[name="cbsName"]').attr('cbsId', data.cbsId || '');
                                    // 控制方式
                                    $('.plan_base_info input[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlType] || '');
                                    $('.plan_base_info input[name="controlType"]').attr('controlType', data.controlType || '');
                                    // 单位
                                    $('.plan_base_info input[name="itemUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.itemUnit] || '');
                                    $('.plan_base_info input[name="itemUnit"]').attr('itemUnit', data.itemUnit || '');

                                    if (data.attachmentList && data.attachmentList.length > 0) {
                                        var fileArr = data.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }

                                    reiPlanListData = data.reiPlanList;

                                    $('.plan_base_info input').attr('readonly', true);
                                    $('.plan_base_info .file_upload_box').hide()
                                    $('.plan_base_info .deImgs').hide()
                                    $('.plan_base_info .chooseManagementBudget').hide()


                                    element.render();
                                    form.render();

                                    var cols=[
                                        {type: 'numbers', title: '操作'},
                                        {
                                            field: 'planListName', title: '名称', templet: function (d) {
                                                return '<input type="text" name="planListName" reiPlanId="'+(d.reiPlanId || '')+'" reiPlanListId="'+(d.reiPlanListId || '')+'" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.planListName || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'departName', title: '单位', templet: function (d) {
                                                return '<input type="text" name="departName" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.departName || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'currNum', title: '本次数量', templet: function (d) {
                                                return '<input type="number" name="currNum"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.currNum || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'estimatePrice', title: '预计单价', templet: function (d) {
                                                return '<input type="number" name="estimatePrice" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimatePrice || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'estimateAmount', title: '预计金额', templet: function (d) {
                                                return '<input type="number" name="estimateAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimateAmount || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'usePosition', title: '使用部位', templet: function (d) {
                                                return '<input type="text" name="usePosition" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePosition || '') + '">'
                                            }
                                        },
                                    ]

                                    table.render({
                                        elem: '#materialDetailsTable',
                                        data: reiPlanListData,
                                        defaultToolbar: [''],
                                        limit: 1000,
                                        cols: [cols],
                                        done:function () {
                                            $('.mtl_info input').attr('readonly', true);
                                        }
                                    });

                                }

                            }
                        })
                    });

                });
            }

            function childFunc() {
                if('0'!=_disabled){
            return true
        }

                var loadIndex = layer.load();
                //材料计划数据
                var datas = $('#baseForm').serializeArray();
                var obj = {}
                datas.forEach(function (item) {
                    obj[item.name] = item.value;
                });
                obj.projectId=$('#leftId').attr('projId');
                obj.handerId = $('input[name="handerId"]', $('#baseForm')).attr('user_id')?$('input[name="handerId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):'';
                obj.reiUserId = $('input[name="reiUserId"]', $('#baseForm')).attr('user_id')?$('input[name="reiUserId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):$('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId');
                obj.department = $('input[name="department"]', $('#baseForm')).attr('deptId');

                obj.reiPlanId = $('.click_one').attr('reiPlanId')

                // 合同附件
                /*var attachmentId = '';
                var attachmentName = '';
                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                    attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                }

                obj.attachmentId = attachmentId;
                obj.attachmentName = attachmentName;*/

                // 报销明细
                obj.reiBudList=getReimbursementDetailsData(1).dataArr;
                // 付款明细
                obj.reiPayList = getPaymentmentDetailsData(true).dataArr;

                // 判断必填项
                var requiredFlag = false;
                $('#baseForm').find('.field_required').each(function(){
                    var field = $(this).attr('field');
                    if (field && !obj[field] && obj[field] != '0') {
                        var fieldName = $(this).parent().text().replace('*', '');
                        layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }
                });


                var _flay = false
                var $tr = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                $tr.each(function (index,element) {
                    //RBS
                    if($(element).find('.rbsName').text()&&$(element).find('.rbsName').text().indexOf('招待费')>0){
                        _flay = true;
                    }

                    //发生日期
                    if(!$(element).find('[name="implementDate"]').val()){
                        layer.msg('发生日期不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }
                    //本次报销金额
                    if(!$(element).find('[name="currentReimbursementAmount"]').val()){
                        layer.msg('本次报销金额不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }

                    //税额
                    if(!$(element).find('[name="taxAmount"]').val()){
                        layer.msg('税额不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }

                    //不含税金额
                    if(!$(element).find('[name="amountExcludingTax"]').val()){
                        layer.msg('不含税金额不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }

                    //截止本月额度(动态值)
                    var _monQuata = $(element).find('.monQuata').attr('currMonQuata')||0;
                    //截止本月已发生额度(动态值)
                    var monHappenQuata = $(element).find('.monHappenQuata').attr('currMonHappenQuata')||0;
                    //本次报销金额
                    var _currentReimbursementAmount = $(element).find('[name="currentReimbursementAmount"]').val()||0;
                    //截至本月额度-截至本月已发生额>=本次报销金额才能提交
                    if(sub(_monQuata,monHappenQuata)<_currentReimbursementAmount){
                        layer.msg('本次报销金额加截止本月已发生额度大于截止本月额度！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }


                    //发票内容
                    if($(element).find('[id^="fileAll"] .dech').length=='0'){
                        layer.msg('请上传发票！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }

                });

                if(MYPROJECT){
                    if(_flay){
                        obj.businessFlag='是'
                    }else {
                        obj.businessFlag='否'
                    }
                }


                var $tr2 = $('#paymentDetailsModule').find('.layui-table-main tr');
                $tr2.each(function (index,element) {
                    //收款人
                    if(!$(element).find('[name="colPeo"]').val()){
                        layer.msg('请填写收款人！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }
                })

                if (requiredFlag) {
                    layer.close(loadIndex);
                    return false;
                }
                var _flag = false;

                $.ajax({
                    url: '/otherExpenes/updateById?reiId=' + $('#leftId').attr('reiId'),
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

            /**
             * 获取报销明细数据
             * @param type (是否编辑)
             * @returns {{dataArr: *[], amountTotal: number}}
             */
            function getReimbursementDetailsData(type) {

                //遍历表格获取每行数据
                var $trs = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                var dataArr = [];
                $trs.each(function (index) {

                    var attachId = '';
                    var attachName = '';
                    var attachmentList = [];

                    if(type=='1'){//提交保存
                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                        }
                    }else if(type=='2'){//加行、删行、选择
                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                            var _obj ={
                                attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
                                attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
                                attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
                                size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
                                aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
                                ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
                            }
                            attachmentList.push(_obj)
                        }
                    }

                    var dataObj = {
                        budgetId: $(this).find('.wbsName').attr('budgetId') || '',
                        reiId: $(this).find('.wbsName').attr('reiId') || '',
                        projBudgetId: $(this).find('.wbsName').attr('projBudgetId') || '',
                        wbsId: $(this).find('.wbsName').attr('wbsId') || '',
                        wbsName: $(this).find('.wbsName').text(),
                        rbsId: $(this).find('.rbsName').attr('rbsId') || '',
                        rbsName: $(this).find('.rbsName').text(),
                        cbsId: $(this).find('.cbsName').attr('cbsId') || '',
                        cbsName: $(this).find('.cbsName').text(),
                        yearBudQuata: $(this).find('.yearBudQuata').text(),
                        monQuata: $(this).find('.monQuata').text(),
                        currMonQuata: $(this).find('.monQuata').attr('currMonQuata'),////动态值
                        //deptId: ($(this).find('input[name="deptId"]').attr('deptId') || '').replace(/,$/, ''),
                        monHappenQuata: $(this).find('.monHappenQuata').text(),
                        currMonHappenQuata: $(this).find('.monHappenQuata').attr('currMonHappenQuata'),//动态值
                        reiReason: $(this).find('input[name="reiReason"]').val(),
                        implementDate: $(this).find('input[name="implementDate"]').val(),
                        currentReimbursementAmount: retainDecimal($(this).find('input[name="currentReimbursementAmount"]').val(),2),
                        taxAmount: retainDecimal($(this).find('input[name="taxAmount"]').val(),2),
                        amountExcludingTax: retainDecimal($(this).find('input[name="amountExcludingTax"]').val(),2),
                        trnApplicationAmount: $(this).find('.trnApplicationAmount').text(),
                        attachmentId:attachId,
                        attachmentName:attachName
                    }
                    if(type=='2'){
                        dataObj.attachmentList = attachmentList;
                    }

                    dataArr.push(dataObj);
                });

                return {
                    dataArr: dataArr,
                }
            }

            /**
             * 获取付款明细数据
             * @param isEdit
             * @returns {{dataArr: *[], amountTotal: number}}
             */
            function getPaymentmentDetailsData(isEdit) {
                var amountTotal = 0;
                //遍历表格获取每行数据
                var $trs = $('#paymentDetailsModule').find('.layui-table-main tr');
                var dataArr = [];
                $trs.each(function () {
                    /*var payId = $(this).find('input[name="payMethod"]').attr('payId') || '';*/

                    var dataObj = {
                        payId: $(this).find('input[name="payMethod"]').attr('payId') || '',
                        reiId: $(this).find('input[name="payMethod"]').attr('reiId') || '',
                        payMethod: $(this).find('input[name="payMethod"]').attr('payMethod') || '',
                        colPeoName:$(this).find('input[name="colPeo"]').val().replace(/,$/, '') || '',
                        userType: $(this).find('input[name="colPeo"]').attr('userType') || '',
                        bankAccount: $(this).find('input[name="bankAccount"]').val(),
                        bankDeposit: $(this).find('input[name="bankDeposit"]').val(),
                        colMon: retainDecimal($(this).find('input[name="colMon"]').val(),2),
                        remark: $(this).find('input[name="remark"]').val()
                    }
                    if($(this).find('input[name="colPeo"]').attr('userType')&&$(this).find('input[name="colPeo"]').attr('userType')=='1'){
                        dataObj.colPeo = $(this).find('input[name="colPeo"]').attr('user_id')?$(this).find('input[name="colPeo"]').attr('user_id').replace(/,$/, '') : $(this).find('input[name="colPeo"]').attr('colPeo').replace(/,$/, '')
                    }else if($(this).find('input[name="colPeo"]').attr('userType')&&$(this).find('input[name="colPeo"]').attr('userType')=='2'){
                        dataObj.colPeo = $(this).find('input[name="colPeo"]').attr('colPeo')?$(this).find('input[name="colPeo"]').attr('colPeo') : ''
                    }

                    /* var $user = $(this).find('input[name="colPeo"]');
                     var userType = $user.attr('userType');
                     if (userType == 2) {
                         dataObj.customerId = $user.attr('customerId') || '';
                     } else {
                         dataObj.colPeo = ($user.attr('user_id') || '').replace(/,$/, '');
                     }

                     if (isEdit) {
                         var userName = $(this).find('input[name="colPeo"]').val()
                         if (userType == 2) {
                             dataObj.customerName = userName;
                         } else {
                             dataObj.colPeoName = userName;
                         }
                     }

                     if (payId) {
                         dataObj.payId = payId;
                     }
                     amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.colMon));*/
                    dataArr.push(dataObj);
                });

                return {
                    dataArr: dataArr,
                    //amountTotal: amountTotal
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
            function responsibleOver(dom) {
                if($('#'+dom).attr('dataid')){
                    var dataid = $('#'+dom).attr('dataid').replace(/,/g, '')
                    $.ajax({
                        url: '/hr/api/getPersonFileByUserId?uid='+dataid,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            //银行账号
                            $('#'+dom).parents('tr').find('[name="bankAccount"]').val(res.bankAccount1?res.bankAccount1:'')
                            //开户行
                            $('#'+dom).parents('tr').find('[name="bankDeposit"]').val(res.bank1?res.bank1:'')
                        }
                    });
                }
            }
        </script>
    </body>
</html>
