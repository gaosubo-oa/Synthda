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
    <title>材料需求计划表单操作</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>

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
    </style>
</head>
<body>
<div class="container">
    <div class="wrapper">

    </div>
    <div style="text-align: center;margin-top: 35px;">
        <button class="layui-btn layui-btn-normal" id="save">保存</button>
    </div>
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
    var runId =  $.GetRequest()['runId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT';
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

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;

        var str=['<div class="layui-collapse">\n' ,
            /* region 材料计划 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">材料计划</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">需求计划编号<span field="planNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;width: 73%">\n' +
            '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">需求计划名称<span field="planName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="planName" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">需求计划时间<span field="planDate" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="planDate" readonly id="planDate" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">WBS<span field="wbsId" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="wbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="cbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">计量单位</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="valuationUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">控制方式<span field="controlMode" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="controlMode" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">管理目标数量<span field="budgetItemId" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
            '                       <input type="text" name="totalManagementTarget" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="mgeTargetPrice" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row planNum" style="display: none">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">已提需求计划数量</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="addupNeedAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">在途需求计划数量</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="onwayAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">剩余可提需求计划数量</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="surplusAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第六行*/
            '           <div class="layui-row planMoney" style="display: none">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">已提需求计划金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="addupNeedMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">在途需求计划金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="onwayMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">剩余可提需求计划金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" readonly name="surplusMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第六行*/
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次需求计划数量<span field="planAmount" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="planAmount" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次需求计划预计金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="planMoney" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">需用日期<span field="useDate" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="useDate" readonly id="useDate" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">备注</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' ,
            /* endregion */
            /* region 第八行 */
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
            '           </div>' ,
            /* endregion */
            '       </form>' +
            '    </div>\n' +
            '  </div>\n' ,
            /* endregion */
            /* region 材料明细 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">材料明细</h2>\n' +
            '    <div class="layui-colla-content mtl_info layui-show">' +
            '       <div>' +
            '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
            '      </div>' +
            '    </div>\n' +
            '  </div>\n' ,
            /* endregion */
            /* region 其他 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">其他</h2>\n' +
            '    <div class="layui-colla-content other_info layui-show">' ,
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">编制人<span style="margin: 0 10px;">流程定义某节点为编制节点</span>编制时间</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="createTime" id="createTime" readonly autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                     <label class="layui-form-label form_label">审核人<span style="margin: 0 10px;">流程定义某节点为审核节点</span>审核时间</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="approvalDate" id="approvalDate" readonly autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">审批人<span style="margin: 0 10px;">流程定义某节点为审批节点</span>审批时间</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="auditerDate" id="auditerDate" readonly autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' +
            '   </div>' ,
            /* endregion */
            '  </div>\n' +
            '</div>'].join('')
        $('.wrapper').html(str)
        element.render();
        fileuploadFn('#fileupload', $('#fileContent'));

        //回显数据
        $.get('/plbMtlPlan/selectByRunId', {runId: runId}, function (res) {
            if (res.flag) {
                var data=res.object
                form.val("formTest", data);

                $('#planDate').val(data ? format(data.planDate) : '')

                var materialDetailsTableData=[]

                $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', data.budgetItemId || '');
                $('.plan_base_info input[name="totalManagementTarget"]').attr('mtlPlanId', data.mtlPlanId || '');
                $('.plan_base_info input[name="totalManagementTarget"]').attr('projId', data.projId || '');

                $('.plan_base_info input[name="wbsId"]').val(data.wbsName || '');
                $('.plan_base_info input[name="wbsId"]').attr('wbsId', data.wbsId || '');
                $('.plan_base_info input[name="cbsId"]').val(data.cbsName || '');
                $('.plan_base_info input[name="cbsId"]').attr('cbsId', data.cbsId || '');
                // 控制类型
                $('.plan_base_info input[name="controlMode"]').val(data.controlMode ? dictionaryObj['CONTROL_TYPE']['object'][data.controlMode] : '');
                $('.plan_base_info input[name="controlMode"]').attr('controlMode', data.controlMode || '');
                // 计量单位
                $('.plan_base_info input[name="valuationUnit"]').val(data.valuationUnit ? dictionaryObj['CBS_UNIT']['object'][data.valuationUnit] : '');
                $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', data.valuationUnit || '');

                if (data.attachmentList && data.attachmentList.length > 0) {
                    var fileArr = data.attachmentList;
                    var str = '';
                    for (var i = 0; i < fileArr.length; i++) {
                        var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                        var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                        str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                    }
                    $('#fileContent').append(str);
                }

                materialDetailsTableData = res.object.listWithBLOBs ? res.object.listWithBLOBs  : [];

                element.render();
                form.render();
               /* laydate.render({
                    elem: '#planDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.planDate) : ''
                });*/
                laydate.render({
                    elem: '#useDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.useDate) : ''
                });
                laydate.render({
                    elem: '#createTime' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.createTime) : ''
                });
                laydate.render({
                    elem: '#approvalDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.approvalDate) : ''
                });
                laydate.render({
                    elem: '#auditerDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.auditerDate) : ''
                });


                var cols=[
                    {type: 'numbers', title: '操作'},
                    {
                        field: 'planMtlName', title: '材料名称', width: 200, templet: function (d) {
                            return '<input mtlPlanListId="' + (d.mtlPlanListId || '') + '" mtlLibId="'+(d.mtlLibId || '')+'" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
                        }
                    },
                    {
                        field: 'planMtlStandard', title: '材料规格', templet: function (d) {
                            return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;" value="' + (d.planMtlStandard || '') + '">'
                        }
                    },
                    {
                        field: 'valuationUnit', title: '计量单位',
                        templet: function (d) {
                            return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(disabled == '1' ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer;" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                        }
                    },
                    {
                        field: 'directUnitPrice', title: '指导单价',
                    },
                    {
                        field: 'estiUnitPrice', title: '预计单价', templet: function (d) {
                            return '<input type="text" name="estiUnitPrice" '+(disabled == '1' ? 'readonly' : '')+' class="layui-input estiUnitPriceItem" autocomplete="off" style="height: 100%;" value="' + (d.estiUnitPrice || '') + '">'
                        }
                    },
                    {
                        field: 'thisAmount', title: '本次数量', templet: function (d) {
                            return '<input type="text" name="thisAmount" '+(disabled == '1' ? 'readonly' : '')+' class="layui-input thisAmountItem" autocomplete="off" style="height: 100%;" value="' + (d.thisAmount || '') + '">'
                        }
                    },
                    {
                        field: 'thisTotalPrice', title: '预计金额', templet: function (d) {
                            return '<input type="text" name="thisTotalPrice" readonly class="layui-input" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + (d.thisTotalPrice || '') + '">'
                        }
                    },
                    {
                        field: 'usePlace', title: '使用部位', templet: function (d) {
                            return '<input type="text" name="usePlace" '+(disabled == '1'? 'readonly' : '')+' class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePlace || '') + '">'
                        }
                    },
                ]
                if(disabled == '0'){
                    cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
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
                            $('.chooseManagementBudget').hide()
                            $('[name="planName"]').attr('disabled',true)
                            $('[name="useDate"]').attr('disabled',true)
                            $('[name="remark"]').attr('disabled',true)
                            $('[name="createTime"]').attr('disabled',true)
                            $('[name="approvalDate"]').attr('disabled',true)
                            $('[name="auditerDate"]').attr('disabled',true)
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                            $('.chooseMaterials').hide()
                            $('#save').hide()
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
                    // 判断控制方式
                    var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

                    if (!controlMode) {
                        layer.msg('请选择管理目标', {icon: 0, time: 1500});
                        return false;
                    }
                    var valuationUnit = '';
                    if (controlMode == '01') {
                        valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                    }

                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('input[name="planMtlName"]').val(),
                            planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                            directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                            estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                            thisAmount: $(this).find('input[name="thisAmount"]').val(),
                            thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId')
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {
                        valuationUnit: valuationUnit
                    };
                    oldDataArr.push(addRowData);
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
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
                if (data.mtlPlanListId) {
                    $.get('/plbMtlPlanList/deleteByMtlPlanListIds', {mtlPlanListIds: data.mtlPlanListId}, function(res){

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        planMtlName: $(this).find('input[name="planMtlName"]').val(),
                        planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                        valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                        directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                        estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                        thisAmount: $(this).find('input[name="thisAmount"]').val(),
                        thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                        usePlace: $(this).find('input[name="usePlace"]').val(),
                        mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });

                //重新计算本次需求计划数量和本次需求计划预计金额
                var thisAmount=0
                var planMoney=0
                $tr.each(function () {
                    thisAmount=accAdd(thisAmount,$(this).find('input[name="thisAmount"]').val())

                    var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                    var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                    planMoney=accAdd(planMoney,estiUnitPriceItem * thisAmountItem)
                });
                $('#baseForm [name="planAmount"] ').val(thisAmount)
                $('#baseForm [name="planMoney"] ').val(planMoney)
            }
        });

        $(document).on('click','#save',function () {
            /*//需求计划金额不得大于剩余可提需求计划金额
            if(Number($('#baseForm [name="planMoney"]').val()) > Number($('#baseForm [name="surplusMoney"]').val())){
                layer.msg('需求计划金额不得大于剩余可提需求计划金额!', {icon: 0, time: 2000});
                return  false
            }*/

            var sum1=$('[name="totalManagementTarget"]').val() - $('[name="addupNeedAmount"]').val() -$('[name="onwayAmount"]').val() -$('[name="planAmount"]').val()
            var sum2=$('[name="mgeTargetPrice"]').val() - $('[name="addupNeedMoney"]').val() -$('[name="onwayMoney"]').val() -$('[name="planMoney"]').val()
            //当控制方式为数量控制时，管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0，否则无法提交
            if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '01' && sum1 < 0){
                layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0，否则无法提交!', {icon: 0, time: 2000});
                return  false
            }
            //当控制方式为金额控制时，管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交
            else if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '02' && sum2 < 0){
                layer.msg('需管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交!', {icon: 0, time: 2000});
                return  false
            }
            //当控制方式为数量+金额控制时，需同时满足上述两种控制逻辑，否则无法提交
            else if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '02' && sum1 < 0 && sum2 < 0){
                layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0且管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交!', {icon: 0, time: 2000});
                return  false
            }



            var loadIndex = layer.load();
            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var obj = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
            obj.wbsId = $('.plan_base_info input[name="wbsId"]').attr('wbsId') || '';
            obj.cbsId = $('.plan_base_info input[name="cbsId"]').attr('cbsId') || '';
            // 控制类型
            obj.controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
            // 计量单位
            obj.valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';

            obj.budgetItemId = $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId') || '';
            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;
            //材料明细数据
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            $tr.each(function () {
                var materialDetailsObj = {
                    planMtlName: $(this).find('input[name="planMtlName"]').val(),
                    planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                    valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                    directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                    estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                    thisAmount: $(this).find('input[name="thisAmount"]').val(),
                    thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                    usePlace: $(this).find('input[name="usePlace"]').val(),
                    mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId')
                }
                if ($(this).find('input[name="planMtlName"]').attr('mtlPlanListId')) {
                    materialDetailsObj.mtlPlanListId = $(this).find('input[name="planMtlName"]').attr('mtlPlanListId');
                }
                materialDetailsArr.push(materialDetailsObj);
            });
            obj.listWithBLOBS = materialDetailsArr;
            //其他数据
            obj.createTime = $('#createTime').val();
            obj.approvalDate = $('#approvalDate').val();
            obj.auditerDate = $('#auditerDate').val();



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

            obj.mtlPlanId = $('.plan_base_info input[name="totalManagementTarget"]').attr('mtlPlanId')

            $.ajax({
                url: '/plbMtlPlan/updateMtlPlan',
                data: JSON.stringify(obj),
                dataType: 'json',
                contentType: "application/json;charset=UTF-8",
                type: 'post',
                success: function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        layer.msg(res.msg, {icon: 1});
                    } else {
                        layer.msg(res.msg || '保存失败!', {icon: 2});
                    }
                }
            });
        })

        // 点击选管理预算
        $(document).on('click', '.chooseManagementBudget', function () {
            var wbsSelectTree = null;
            var cbsSelectTree = null;

            layer.open({
                type: 1,
                title: '管理目标选择',
                area: ['100%', '100%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-form">' +
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
                    wbsSelectTree = xmSelect.render({
                        el: '#wbsSelectTree',
                        content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search wbsSearch" style="width: 80%;margin: 5px"><div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                        name: 'wbsName',
                        prop: {
                            name: 'wbsName',
                            value: 'id'
                        }
                    });
                    wbsData()
                    // 树节点点击事件
                    eleTree.on("nodeClick(wbsTree)", function (d) {
                        var currentData = d.data.currentData;
                        var obj = {
                            wbsName: currentData.wbsName,
                            id: currentData.id
                        }
                        wbsSelectTree.setValue([obj]);
                    });

                    var searchTimerWBS = null
                    $('.wbsSearch').on('input propertychange', function () {
                        clearTimeout(searchTimerWBS)
                        searchTimerWBS = null
                        var val = $(this).val()
                        searchTimerWBS = setTimeout(function () {
                            wbsData(val)
                        }, 300)
                    });

                    function wbsData(wbsName){
                        $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('.plan_base_info input[name="totalManagementTarget"]').attr('projId'),wbsName:wbsName}, function (res) {
                            eleTree.render({
                                elem: '#wbsTree',
                                data: res.obj,
                                highlightCurrent: true,
                                showLine: true,
                                // defaultExpandAll: false,
                                request: {
                                    name: 'wbsName',
                                    children: "child"
                                }
                            });
                        });
                    }


                    // 获取CBS数据
                    cbsSelectTree = xmSelect.render({
                        el: '#cbsSelectTree',
                        content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search cbsSearch" style="width: 80%;margin: 5px"><div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                        name: 'cbsName',
                        prop: {
                            name: 'cbsName',
                            value: 'cbsId'
                        }
                    });
                    cbsData()
                    // 树节点点击事件
                    eleTree.on("nodeClick(cbsTree)", function (d) {
                        var currentData = d.data.currentData;
                        var obj = {
                            cbsName: currentData.cbsName,
                            cbsId: currentData.cbsId
                        }
                        cbsSelectTree.setValue([obj]);
                    });

                    var searchTimerCBS = null
                    $('.cbsSearch').on('input propertychange', function () {
                        clearTimeout(searchTimerCBS)
                        searchTimerCBS = null
                        var val = $(this).val()
                        searchTimerCBS = setTimeout(function () {
                            cbsData(val)
                        }, 300)
                    });

                    function cbsData(cbsName){
                        $.get('/plbCbsType/getAllList',{cbsName:cbsName}, function (res) {
                            eleTree.render({
                                elem: '#cbsTree',
                                data: res.data,
                                highlightCurrent: true,
                                showLine: true,
                                // defaultExpandAll: false,
                                request: {
                                    name: 'cbsName',
                                    children: "childList"
                                }
                            });
                        });
                    }

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
                            url: '/plbBudgetItem/getDataByProjId',
                            where: {
                                projId: $('.plan_base_info input[name="totalManagementTarget"]').attr('projId'),
                                wbsId: wbsId || '',
                                cbsId: cbsId || '',
                                itemNo: itemNo || '',
                                itemName: itemName || '',
                            },
                            cellMinWidth:120,
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
                                {type: 'radio', title: '选择'},
                                {
                                    field: 'wbsName', title: 'WBS',width:100, templet: function(d) {
                                        var str = '';
                                        if (d.plbProjWbs) {
                                            str = d.plbProjWbs.wbsName;
                                        }
                                        return str;
                                    }
                                },
                                {
                                    field: 'cbsName', title: 'CBS',width:200, templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
                                            str = d.plbCbsTypeWithBLOBs.cbsName;
                                        }
                                        return str;
                                    }
                                },
                                {field: 'manageTarPrice', title: '管理目标单价',width:120},
                                {field: 'manageTarNum', title: '管理目标数量',width:120},
                                {field: 'manageTarAmount', title: '管理目标总价',width:120},
                                {field: 'addupNeedAmount', title: '累计已提需求计划量',width:170},
                                {field: 'addupNeedMoney', title: '累计已提需求计划金额',width:170},
                                {field: 'manageSurplusAmount', title: '管理目标数量余额',width:150},
                                {field: 'manageSurplusMoney', title: '管理目标金额余额',width:150},
                                {
                                    field: 'controlType', title: '控制类型', width:120,templet: function (d) {
                                        return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                    }
                                },
                                {
                                    field: 'cbsUnit', title: '计量单位',templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
                                            str = dictionaryObj['CBS_UNIT']['object'][d.plbCbsTypeWithBLOBs.cbsUnit] || '';
                                        }
                                        return str;
                                    }
                                }
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    $('.planNum').hide()
                    $('.planMoney').hide()
                    var checkStatus = table.checkStatus('managementBudgetTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];


                        var sum1=chooseData.manageTarNum - chooseData.addupNeedAmount - chooseData.onwayAmount
                        var sum2=chooseData.manageTarAmount - chooseData.addupNeedMoney - chooseData.onwayMoney
                        //判断能否选择管理目标
                        if (chooseData.controlType == '01') {    // 数量控制
                            //当控制方式为数量控制时，管理目标数量-已提需求计划数量-在途需求计划数量>0，否则无法选择到
                            if(sum1 < 0){
                                layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量>0，否则无法选择到!', {icon: 0, time: 2000});
                                return  false
                            }


                            $('.planNum').show()
                            //已提需求计划数量
                            var addupNeedAmount = chooseData.addupNeedAmount || 0;
                            $('.plan_base_info input[name="addupNeedAmount"]').val(addupNeedAmount);
                            //在途需求计划数量
                            var onwayAmount = chooseData.onwayAmount || 0;
                            $('.plan_base_info input[name="onwayAmount"]').val(onwayAmount);
                            //剩余可提需求计划数量
                            var surplusAmount = chooseData.surplusAmount || 0;
                            $('.plan_base_info input[name="surplusAmount"]').val(surplusAmount);

                        } else if (chooseData.controlType == '02') {  // 金额控制
                            //当控制方式为金额控制时，管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到
                            if(sum2 < 0){
                                layer.msg('需管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到', {icon: 0, time: 2000});
                                return  false
                            }


                            $('.planMoney').show()
                            //已提需求计划金额
                            var addupNeedMoney = chooseData.addupNeedMoney || 0;
                            $('.plan_base_info input[name="addupNeedMoney"]').val(addupNeedMoney);
                            //在途需求计划金额
                            var onwayMoney = chooseData.onwayMoney || 0;
                            $('.plan_base_info input[name="onwayMoney"]').val(onwayMoney);
                            //剩余可提需求计划金额
                            var surplusMoney = chooseData.surplusMoney || 0;
                            $('.plan_base_info input[name="surplusMoney"]').val(surplusMoney);
                        }else if (chooseData.controlType == '03') {   // 数量+金额控制
                            //当控制方式为数量+金额控制时，管理目标数量-已提需求计划数量-在途需求计划数量>0，且管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到
                            if(sum1 < 0 && sum2 < 0){
                                layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量>0，且管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到', {icon: 0, time: 2000});
                                return  false
                            }


                            $('.planNum').show()
                            $('.planMoney').show()
                            //已提需求计划数量
                            var addupNeedAmount = chooseData.addupNeedAmount || 0;
                            $('.plan_base_info input[name="addupNeedAmount"]').val(addupNeedAmount);
                            //在途需求计划数量
                            var onwayAmount = chooseData.onwayAmount || 0;
                            $('.plan_base_info input[name="onwayAmount"]').val(onwayAmount);
                            //剩余可提需求计划数量
                            var surplusAmount = chooseData.surplusAmount || 0;
                            $('.plan_base_info input[name="surplusAmount"]').val(surplusAmount);
                            //已提需求计划金额
                            var addupNeedMoney = chooseData.addupNeedMoney || 0;
                            $('.plan_base_info input[name="addupNeedMoney"]').val(addupNeedMoney);
                            //在途需求计划金额
                            var onwayMoney = chooseData.onwayMoney || 0;
                            $('.plan_base_info input[name="onwayMoney"]').val(onwayMoney);
                            //剩余可提需求计划金额
                            var surplusMoney = chooseData.surplusMoney || 0;
                            $('.plan_base_info input[name="surplusMoney"]').val(surplusMoney);

                        }


                        $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', chooseData.budgetItemId);

                        //WBS
                        $('.plan_base_info input[name="wbsId"]').val(chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsName : '');
                        $('.plan_base_info input[name="wbsId"]').attr('wbsId', chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsId : '');
                        //CBS
                        $('.plan_base_info input[name="cbsId"]').val(chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsName : '');
                        $('.plan_base_info input[name="cbsId"]').attr('cbsId', chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsId : '');
                        // 单位
                        var valuationUnit = chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsUnit : '';
                        $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                        $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                        //控制方式
                        $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][chooseData.controlType] || '');
                        $('.plan_base_info input[name="controlMode"]').attr('controlMode', chooseData.controlType);
                        //管理目标数量
                        var totalManagementTarget = chooseData.manageTarNum ? chooseData.manageTarNum : '';
                        $('.plan_base_info input[name="totalManagementTarget"]').val(totalManagementTarget);
                        // 管理目标金额
                        var mgeTargetPrice = chooseData.manageTarAmount || '';
                        $('.plan_base_info input[name="mgeTargetPrice"]').val(mgeTargetPrice);




                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });
        // 点击选择材料明细
        $(document).on('click', '.chooseMaterials', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择材料',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="wrapper">',
                    '<div class="wrap_left">' +
                    '<div class="layui-form">' +
                    '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                    '<div class="tree_module" style="top: 48px;">' +
                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="wrap_right">' +
                    '<div class="layui-form">' +
                    '<div class="layui-form-item" style="margin: 0;">' +
                    '<label class="layui-form-label">材料名称</label>' +
                    '<div class="layui-input-block">' +
                    '<input type="text" name="planMtlName" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="mtl_table_box" style="display: none;">' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img" style="margin-top:12%;">' +
                    '<img style="margin-top: 2%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    $('.tree_module').height($(window).height() - 300)
                    // 获取材料类型
                    $.get('/plbDictonary/getTgTypeByDictNo?plbDictNo=MTL_TYPE', function (res) {
                        var str = '<option value="">请选择<option>';
                        if (res.flag && res.obj.length > 0) {
                            res.obj.forEach(function (item) {
                                str += '<option value="' + item.plbDictNo + '">' + item.dictName + '<option>';
                            });
                        }
                        $('#mtlTypeTree').html(str);
                        form.render();
                    });

                    form.on('select(mtlTypeTree)', function (data) {
                        loadMtlType(data.value);
                    });

                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.mtlLibId) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.mtlLibId);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType(mtlType) {
                        mtlType = mtlType ? mtlType : '';
                        // 获取左侧树
                        $.get('/plbMtlLibrary/queryAll', {mtlType: mtlType}, function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'mtlName',
                                        children: "son",
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(mtlLibId) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbMtlLibrary/queryByParentId',
                            where: {
                                mtlLibId: mtlLibId
                            },
                            page: false,
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'mtlNo', title: '材料编码'},
                                {field: 'mtlName', title: '材料名称'},
                                {field: 'mtlStandard', title: '材料规格'},
                                {
                                    field: 'mtlValuationUnit', title: '计量单位', templet: function (d) {
                                        return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '';
                                    }
                                },
                                {field: 'mtlPriceUnit', title: '指导单价'}
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];

                        _this.parents('tr').find('[name="planMtlName"]').val(mtlData.mtlName);
                        _this.parents('tr').find('[name="planMtlStandard"]').val(mtlData.mtlStandard);
                        _this.parents('tr').find('[data-field="directUnitPrice"] .layui-table-cell').text(mtlData.mtlPriceUnit);

                        // 判断控制方式是否为数量
                        var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
                        if (controlMode != '01') {
                            _this.parents('tr').find('[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][mtlData.mtlValuationUnit] || '');
                            _this.parents('tr').find('[name="valuationUnit"]').attr('valuationUnit', mtlData.mtlValuationUnit);
                        }
                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        // 点击选择计量单位
        $(document).on('click', '.chooseMtlUnit', function(){
            var $this = $(this);
            var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

            if (controlMode != '01') {
                layer.open({
                    type: 1,
                    title: '选择计量单位',
                    area: ['400px', '400px'],
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: '<div style="padding: 10px"><table id="chooseMtlUnit" lay-filter="chooseMtlUnit"></table></div>',
                    success: function () {
                        var dataArr = []
                        $.each(dictionaryObj['CBS_UNIT']['object'], function (k, o) {
                            var obj = {
                                mtlValuationUnit: k,
                                mtlValuationUnitStr: o
                            }
                            dataArr.push(obj);
                        });
                        table.render({
                            elem: '#chooseMtlUnit',
                            data: dataArr,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'mtlValuationUnitStr', title: '计量单位'}
                            ]]
                        });
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('chooseMtlUnit');
                        if (checkStatus.data.length > 0) {
                            $this.val(checkStatus.data[0].mtlValuationUnitStr);
                            $this.attr('valuationunit', checkStatus.data[0].mtlValuationUnit);
                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            }
        });

        //监听本次数量
        $(document).on('blur', '.thisAmountItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var thisAmount=0
            $tr.each(function () {
                thisAmount=accAdd(thisAmount,$(this).find('input[name="thisAmount"]').val())
            });
            $('#baseForm [name="planAmount"] ').val(thisAmount)

            //计算需求计划金额
            if($(this).val() && $(this).parents('tr').find('[name="estiUnitPrice"]').val()){
                var planMoney=0
                $tr.each(function () {
                    var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                    var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                    planMoney=accAdd(planMoney,estiUnitPriceItem * thisAmountItem)
                });
                $('#baseForm [name="planMoney"] ').val(planMoney)

                //计算预计金额
                $(this).parents('tr').find('[name="thisTotalPrice"]').val($(this).val() * $(this).parents('tr').find('[name="estiUnitPrice"]').val())
            }
        });

        //监听预计单价
        $(document).on('blur', '.estiUnitPriceItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            //计算需求计划金额
            if($(this).val() && $(this).parents('tr').find('[name="thisAmount"]').val()){
                var planMoney=0
                $tr.each(function () {
                    var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                    var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                    planMoney=accAdd(planMoney,estiUnitPriceItem * thisAmountItem)
                });
                $('#baseForm [name="planMoney"] ').val(planMoney)

                //计算预计金额
                $(this).parents('tr').find('[name="thisTotalPrice"]').val($(this).val() * $(this).parents('tr').find('[name="thisAmount"]').val())
            }
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

    });
</script>
</body>
</html>