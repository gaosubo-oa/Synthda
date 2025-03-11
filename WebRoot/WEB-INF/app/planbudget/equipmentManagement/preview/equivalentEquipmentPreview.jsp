<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/19
  Time: 10:03
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
        <title>设备比价详情</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
        <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
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
                padding: 15px 8px;
                box-sizing: border-box;
            }

            .wrapper {
                position: relative;
                width: 100%;
                height: 100%;
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

            .layui_col {
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

            .layui-select-disabled .layui-disabled {
                color: #222 !important;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="wrapper">
                <div class="layui-collapse">
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">设备比价详情</h2>
                        <div class="layui-colla-content layui-show">
                            <form class="layui-form" id="baseForm" lay-filter="baseForm">
                                <div class="layui-row">
                                    <div class="layui-col-xs3" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">比价编号</label>
                                            <div class="layui-input-block form_block">
                                                <input type="text" readonly name="equipmentNo" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs3" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">比价事项</label>
                                            <div class="layui-input-block form_block">
                                                <input type="text" readonly name="priceComparison" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs3" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">比价时间</label>
                                            <div class="layui-input-block form_block">
                                                <input type="text" readonly name="compareTime" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs3" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">比价方式</label>
                                            <div class="layui-input-block form_block">
                                                <select name="compareType" disabled></select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-row">
                                    <div class="layui-col-xs12" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">备注</label>
                                            <div class="layui-input-block form_block">
                                                <input type="text" readonly name="remark" autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-row">
                                    <div class="layui-col-xs12" style="padding: 0 5px">
                                        <div class="layui-form-item">
                                            <label class="layui-form-label form_label">附件</label>
                                            <div class="layui-input-block form_block">
                                                <div class="file_module">
                                                    <div id="fileContent" class="file_content"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="layui-colla-item" id="mtlDetailsModule">
                        <h2 class="layui-colla-title">设备比价明细</h2>
                        <div class="layui-colla-content layui-show">
                            <div id="detailModule"><table id="equipmentListTable" lay-filter="equipmentListTable"></table></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var type =  $.GetRequest()['type'] || '';
            var equipmentId = $.GetRequest()['equipmentId'] || '';
            var runId = $.GetRequest()['runId'] || '';

            // 获取数据字典数据
            var dictionaryObj = {
                COMPARE_TYPE: {}
            }
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
                var loadIndex = layer.load();
                // 获取项目信息
                if (runId) {
                    $.get('/plbMtlEquipment/queryByRunId', {runId: runId}, function (res) {
                        layer.close(loadIndex);
                        if (!res.flag) {
                            layer.msg('获取信息失败！', {icon: 2});
                        }
                        initPage(res.object);
                    });
                } else if (equipmentId) {
                    $.get('/plbMtlEquipment/queryId', {equipmentId: equipmentId}, function (res) {
                        layer.close(loadIndex);
                        if (!res.flag)  {
                            layer.msg('获取信息失败！', {icon: 2});
                        }
                        initPage(res.object);
                    });
                } else {
                    layer.close(loadIndex);
                    layer.msg('获取信息失败！', {icon: 2});
                    initPage();
                }
            });

            function initPage(equipmentData) {
                layui.use(['form', 'table', 'element'], function () {
                    var layForm = layui.form,
                        layTable = layui.table,
                        layElement = layui.element;

                    layElement.render();

                    if (equipmentData) {
                        layForm.val("baseForm", equipmentData);

                        $('select[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str']);

                        // 设备明细列表数据
                        var equipmentList = equipmentData.plbMtlEquipmentListList || [];

                        if (equipmentData.attachments && equipmentData.attachments.length > 0) {
                            var fileArr = equipmentData.attachments;
                            var str = '';
                            for (var i = 0; i < fileArr.length; i++) {
                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                            }
                            $('#fileContent').append(str);
                        }

                        layTable.render({
                            elem: '#equipmentListTable',
                            data: equipmentList,
                            toolbar: false,
                            cellMinWidth:200,
                            limit: 1000,
                            cols: [[
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'budgetItemName', title: '分包项名称', width: 200
                                },
                                {
                                    field: 'customerName1', title: '分包商1'
                                },
                                {
                                    field: 'customerUnit1', title: '分包商1报价'
                                },
                                {
                                    field: 'customerName2', title: '分包商2'
                                },
                                {
                                    field: 'customerUnit2', title: '分包商2报价'
                                },
                                {
                                    field: 'customerName3', title: '分包商3'
                                },
                                {
                                    field: 'customerUnit3', title: '分包商3报价'
                                },
                                {
                                    field: 'customerName4', title: '分包商4'
                                },
                                {
                                    field: 'customerUnit4', title: '分包商4报价'
                                },
                                {
                                    field: 'customerName5', title: '分包商5'
                                },
                                {
                                    field: 'customerUnit5', title: '分包商5报价'
                                },
                                {
                                    field: 'chooseCustomerName', title: '选中分包商'
                                },
                                {
                                    field: 'chooseUnit', title: '选中分包商报价'
                                }
                            ]]
                        });
                    }

                    layForm.render();
                });
            }
        </script>
    </body>
</html>
