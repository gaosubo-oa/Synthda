<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/3/16
  Time: 9:46
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
    <title>分包比价预览</title>

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
<script>
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })
    var runId =  $.GetRequest()['runId'] || '';
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

    var tipIndex = null
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text');
        tipIndex = layer.tips(tip, this);
    }, function () {
        layer.close(tipIndex);
    });

    var TableUIObj = new TableUI('plb_mtl_subpackage');


    var dictionaryObj = {
        COMPARE_TYPE: {}
    }
    var _htm = '<div class="layui-collapse">'+
        '<div class="layui-colla-item">'+
        '<h2 class="layui-colla-title">分包比价详情</h2>'+
        '<div class="layui-colla-content layui-show">'+
        '<form class="layui-form" id="baseForm" lay-filter="baseForm">'+
        /* region 第一行 */
        '<div class="layui-row">' +
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">比价编号<span field="subpackageNo" class="field_required">*</span></label>' +
                    '<div class="layui-input-block form_block">' +
                        '<input type="text" name="subpackageNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">' +
                    '</div>' +
                '</div>'+
            '</div>'+
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">项目名称</label>' +
            '<div class="layui-input-block form_block">' +
            '<input type="text" name="projName" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input projName">' +
            '</div>' +
            '</div>'+
            '</div>'+
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">比价事项<span field="priceComparison" class="field_required">*</span></label>' +
            '<div class="layui-input-block form_block">' +
            '<input type="text" name="priceComparison" autocomplete="off" class="layui-input">' +
            '</div>' +
            '</div>' +
            '</div>'+
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">比价时间<span field="compareTime" class="field_required">*</span></label>' +
            '<div class="layui-input-block form_block">' +
            '<input type="text" readonly name="compareTime" id="compareTime" autocomplete="off" class="layui-input">' +
            '</div>' +
            '</div>' +
            '</div>'+
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">比价方式<span field="compareType" class="field_required">*</span></label>' +
            '<div class="layui-input-block form_block">' +
            '<select name="compareType"></select>' +
            '</div>' +
            '</div>' +
            '</div>'+
                '</div>'+
                /* endregion */
                /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商1</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId1" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商2</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId2" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商3</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId3" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商4</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId4" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">分包商5</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId5" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
            '           </div>' +
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商6</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId6" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商7</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId7" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">分包商8</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId8" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '<div class="layui-col-xs6" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">备注</label>' +
            '<div class="layui-input-block form_block">' +
            '<input type="text" name="remark" autocomplete="off" class="layui-input">' +
            '</div>' +
            '</div>' +
            '           </div>' +
            /* endregion */
            /* region 第二行 */
                '</div>'+
                /* endregion */
                '</form>'+
                /* region 附件 */
            '<div class="layui-row">' +
            '<div class="layui-col-xs12" style="padding: 0 5px">' +
            '<div class="layui-form-item">' +
            '<label class="layui-form-label form_label">附件</label>' +
            '<div class="layui-input-block form_block">' +
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
            '</div>' +
            '</div>' +
            '</div>'+
                '</div>'+
                /* endregion */
                '</div></div>'+
                '<div class="layui-colla-item">'+
                '<h2 class="layui-colla-title">分包比价明细</h2>'+
                '<div class="layui-colla-content mtl_info_detail layui-show">'+
            ' <button class="layui-btn layui-btn-sm" id="addRow">加行</button>'+
            '<table id="equipmentListTable" lay-filter="equipmentListTable"></table>'+
                '</div></div>'+
        '</div>';
    var dictionaryStr = 'COMPARE_TYPE';
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

    layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree', 'element'], function () {
        $("#htmBox").html(_htm)
        var layForm = layui.form,
            laydate = layui.laydate,
            layTable = layui.table,

            eleTree = layui.eleTree,
            element = layui.element,
            soulTable = layui.soulTable;
        var table = layui.table;
        layForm.render();
        var materialsTable = null
        var tableObj = null;


        fileuploadFn('#fileupload', $('#fileContent'));
        $('select[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str']);
        // 分包明细列表数据
        $.get('/plbMtlSubpackage/getByRunId', {runId: runId}, function (res) {
            if (res.flag) {
                var data = res.data
                var materialDetailsTableData = []

                //回显项目名称
                getProjName('.projName',(data.projId))

                layForm.val("baseForm", data);
                //回显分包商信息
                $('[name="customerId1"]').val(data.customerName1)
                $('[name="customerId1"]').attr('customerId', data.customerId1)
                $('[name="customerId2"]').val(data.customerName2)
                $('[name="customerId2"]').attr('customerId', data.customerId2)
                $('[name="customerId3"]').val(data.customerName3)
                $('[name="customerId3"]').attr('customerId', data.customerId3)
                $('[name="customerId4"]').val(data.customerName4)
                $('[name="customerId4"]').attr('customerId', data.customerId4)
                $('[name="customerId5"]').val(data.customerName5)
                $('[name="customerId5"]').attr('customerId', data.customerId5)
                $('[name="customerId6"]').val(data.customerName6)
                $('[name="customerId6"]').attr('customerId', data.customerId6)
                $('[name="customerId7"]').val(data.customerName7)
                $('[name="customerId7"]').attr('customerId', data.customerId7)
                $('[name="customerId8"]').val(data.customerName8)
                $('[name="customerId8"]').attr('customerId', data.customerId8)
                materialDetailsTableData = data.subpackageList || []
                //附件解析
                if (data.attachments && data.attachments.length > 0) {
                    var fileArr = data.attachments;
                    $('#fileContent').append(echoAttachment(fileArr));
                }
                //遍历分包商，判断分包商是否显示
                var colsArr = []
                $('.chooseEquivalent').each(function () {
                    if ($(this).attr('customerId')) {
                        colsArr.push(false)
                    } else {
                        colsArr.push(true)
                    }
                })
                //回显表格数据
                var showCols = []
                detailCols.forEach(function (item, index) {
                    item.hide = colsArr[index]
                    showCols.push(item)
                })

                //查看详情
                $('.layui-layer-btn-c').hide()
                $('#baseForm [name="priceComparison"]').attr('disabled', 'true')
                $('#compareTime').attr('disabled', 'true')
                $('#baseForm [name="compareType"]').attr('disabled', 'true')
                $('.chooseEquivalent').attr('disabled', 'true')
                $('#baseForm [name="remark"]').attr('disabled', 'true')
                $('.file_upload_box').hide()
                $('.deImgs').hide()
                $('#addRow').hide()
                loadDetail(showCols, materialDetailsTableData, 4)
                layForm.render();
                element.render();

                //加载明细表
                function loadDetail(showCols, materialDetailsTableData, type) {
                    showCols.push(
                        {
                            field: 'chooseUnit', title: '选中分包商单价', width: 150, templet: function (d) {
                                return '<input type="number" name="chooseUnit" ' + (type ? 'readonly' : '') + ' subpackageListId="' + (d.subpackageListId || '') + '" autocomplete="off" class="layui-input" style="height: 100%;" value="' + (d.chooseUnit || '') + '">'
                            }
                        },
                    )
                    if (!type) {
                        showCols.push(
                            {align: 'center', toolbar: '#barDemo', title: '操作', fixed: 'right'}
                        )
                    }
                    layTable.render({
                        elem: '#equipmentListTable',
                        data: materialDetailsTableData,
                        /*toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],*/
                        limit: 1000,
                        cols: [showCols],
                        done: function () {
                            if (type) {
                                $('.customerUnitItem').attr('readonly', 'readonly')
                            }
                        }
                    });
                }
            }
        })
    })
    //附件上传 方法
    var timer = null;
    function fileuploadFn(formId, element) {
        $(formId).fileupload({
            dataType: 'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                    'width',
                    progress + '%'
                );
                element.siblings('.barText').html(progress + '%');
                if (progress >= 100) {  //判断滚动条到100%清除定时器
                    timer = setTimeout(function () {
                        element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                            'width',
                            0 + '%'
                        );
                        element.siblings('.file_upload_box').find('.barText').html('');
                    }, 2000);

                }
            },
            done: function (e, data) {
                if (data.result.obj != '') {
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
                                layer.closeAll();
                            });
                        } else {
                            var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    element.append(str);
                } else {
                    layer.alert('添加附件大小不能为空!', {}, function (index) {
                        layer.close(index);
                    });
                }
            }
        });
    }
</script>
</body>
</html>
