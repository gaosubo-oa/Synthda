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
    <title>供应商材料比价表单操作</title>

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
            /*height: 100%;*/
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
    </style>
</head>
<body>
<input type="hidden" id="leftId" class="layui-input">
<div class="container">
    <div class="wrapper">

    </div>
    <div style="text-align: center;margin-top: 35px;">
        <button class="layui-btn layui-btn-normal" id="save">保存</button>
    </div>
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

    var runId =  $.GetRequest()['runId'] || '';
    var dictionaryObj = {
        COMPARE_TYPE: {},
        CUSTOMER_NAME: {},
    }
    var dictionaryStr = 'COMPARE_TYPE,CUSTOMER_NAME,';
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

        var inSearchTable=null

        var str=['<div class="layui-collapse">\n' +
        /* region 材料计划 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">基本信息</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">比价编号<span field="contrastNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contrastNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
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
        '           </div>' +
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
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
        /* endregion */
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
        '           </div>' +
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
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
        '           </div>' +
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商5</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId5" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商6</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId6" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
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
        '           </div>' +
        /* endregion */
        /* region 第三行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">材料需求计划</label>\n' +
        '                       <div class="layui-input-block form_block">' +
        '                         <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
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
        /* endregion */
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
        '           </div>',
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
            /* endregion */
            '</div>'].join('')
        $('.wrapper').html(str)
        $('[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str'])
        element.render();
        fileuploadFn('#fileupload', $('#fileContent'));

        //回显数据
        $.get('/plbMtlContrast/queryByRunId', {runId: runId}, function (res) {
            if (res.flag) {
                var data=res.object

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
                var materialDetailsTableData =  data.plbMtlContrastListWithBLOBs || [];
                if(data.mtlPlanId){
                    $.get('/plbMtlPlanList/selectAll',{mtlPlanId:data.mtlPlanId},function (res) {
                        $('.plan_base_info input[name="mtlPlanId"]').val(res.object.planName);
                        $('.plan_base_info input[name="mtlPlanId"]').data('data', res.object.listWithBLOBs);
                    })
                }
                $('.plan_base_info input[name="mtlPlanId"]').attr('mtlPlanId', data.mtlPlanId);

                $('.plan_base_info input[name="mtlPlanId"]').attr('contrastId', data.contrastId);
                $('.plan_base_info input[name="mtlPlanId"]').attr('projId', data.projId);

                if (data.attachments && data.attachments.length > 0) {
                    var fileArr = data.attachments;
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
                    {field: 'valuationUnit', title: '单位', width: 100,templet: function(d){
                            return '<span valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                        }},
                ]
                detailCols.forEach(function (item,index) {
                    item.hide=colsArr[index]
                    showCols.push(item)
                })

                loadDetail(showCols,materialDetailsTableData)

                element.render();
                form.render();
                laydate.render({
                    elem: '#compareTime' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.compareTime) : ''
                });

            } else {
                layer.msg('获取信息失败！', {icon: 2});
            }
        });

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
                area: ['70%', '60%'],
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
                                    return dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '';
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
            layer.open({
                type: 1,
                title: '选择材料资源库',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="wrapper" style="height: 100%">',
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
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
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
                        if (currentData.mtlLibId) {
                            loadMtlTable({mtlLibId: currentData.mtlLibId});
                        } else {
                            loadMtlTable({mtlType: currentData.mtlType});
                        }
                        //判断是否是末级节点
                        if(!currentData.son){
                            // console.log(currentData.mtlName);
                            $('#leftId').attr('mtlName',currentData.mtlName)
                        }else{
                            $('#leftId').attr('mtlName','')
                        }
                    });

                    loadMtlType();
                    loadMtlTable({})

                    function loadMtlType() {
                        // 获取左侧树
                        $.get('/plbMtlLibrary/queryAll', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    // defaultExpandAll: false,
                                    request: {
                                        name: "mtlName", // 显示的内容
                                        children: 'son',
                                    }
                                });
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
                                , {field: 'mtlNo', title: '材料编码',width: 200}
                                , {field: 'mtlName', title: '材料名称',width: 200}
                                , {field: 'mtlStandard', title: '材料规格'}
                                , {field: 'mtlValuationUnit', title: '计量单位',templet: function (d) {
                                        return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '';
                                    }}
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
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                            planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                            valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
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
                        {field: 'valuationUnit', title: '单位', width: 100,templet: function(d){
                                return '<span valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
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
                                valuationUnit: item.mtlValuationUnit,
                            }
                            oldDataArr.push(addRowData)
                        })
                        if($('#leftId').attr('mtlName')){
                            oldDataArr.push({ planMtlName:$('#leftId').attr('mtlName')})
                        }
                        loadDetail(showCols,oldDataArr)

                        layer.close(index);
                    }else {
                        layer.msg('请选择一项！', {icon: 0});
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
                area: ['70%', '60%'],
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
                            projId: $('.plan_base_info input[name="mtlPlanId"]').attr('projId'),
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

        //供应商内侧查询
        $(document).on('click','.customerSearchData',function () {
            var searchParams = {}
            var $seachData = $('.customerSearchContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            customerSearchTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });


        $(document).on('click','#save',function () {
            var loadIndex = layer.load();
            //基本信息数据
            var datas = $('#baseForm').serializeArray();
            var obj = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
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
                    customerUnit1: $(this).find('[name="customerUnit1"]').val(),
                    customerUnit2: $(this).find('[name="customerUnit2"]').val(),
                    customerUnit3: $(this).find('[name="customerUnit3"]').val(),
                    customerUnit4: $(this).find('[name="customerUnit4"]').val(),
                    customerUnit5: $(this).find('[name="customerUnit5"]').val(),
                    customerUnit6: $(this).find('[name="customerUnit6"]').val(),
                    customerUnit7: $(this).find('[name="customerUnit7"]').val(),
                    customerUnit8: $(this).find('[name="customerUnit8"]').val(),
                    chooseUnit: $(this).find('[name="chooseUnit"]').val(),
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

            obj.contrastId = $('[name="mtlPlanId"]').attr('contrastId')


            $.ajax({
                url: '/plbMtlContrast/update',
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
                    '<div class="wrapper" style="height: 100%">',
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
                        table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType:typeNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-180',
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'customerNo', title: '客商编号',width: 200}
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


                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                                planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                                valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
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
                            {field: 'valuationUnit', title: '单位', width: 100,templet: function(d){
                                    return '<span valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
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

        //监听供应商1，赋值给选中供应商
        $(document).on('blur','.customerUnit1Item',function () {
            $(this).parents('tr').find('[name="chooseUnit"]').val($(this).val())
        })


    });
</script>
</body>
</html>