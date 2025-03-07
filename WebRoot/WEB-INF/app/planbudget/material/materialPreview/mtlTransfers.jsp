<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/18
  Time: 9:36
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
        <title>材料调拨预览</title>

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
            .layui-col-xs6{
                width: 20%;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="wrapper">
                <form class="layui-form" id="baseForm" lay-filter="baseForm">
                    <div class="layui-row">
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">调拨编号</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="mtlOutNo" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">调拨时间</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="createTime" readonly autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
<%--                    </div>--%>
<%--                    <div class="layui-row">--%>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">调拨人</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="createUser" readonly autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">材料名称</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly autocomplete="off" name="mtlName" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">出库仓库</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="mtlStockOutName" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">入库仓库</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="mtlStockInName" readonly autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
<%--                    </div>--%>
<%--                    <div class="layui-row">--%>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">数量</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="mtlAmount" readonly autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">调拨备注</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="remark" readonly autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
            var type =  $.GetRequest()['type'] || '';
            var mtlOutInId = $.GetRequest()['mtlOutInId'] || '';
            var runId = $.GetRequest()['runId'] || '';

            var params = {}

            if (runId) {
                params.runId = runId;
            } else if (mtlOutInId) {
                params.mtlOutInId = mtlOutInId;
            } else {
                layer.msg('获取信息失败！', {icon: 2});
                initPage();
            }

            $.get('/plbMtlOutIn/queryByMtlOutInId', params, function (res) {
                if (res.flag) {
                    initPage(res.data);
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                    initPage();
                }
            });

            function initPage(mtlOutInData) {
                layui.use(['form'], function () {
                    var layForm = layui.form;

                    layForm.render();

                    if (mtlOutInData) {
                        layForm.val("baseForm", mtlOutInData);
                    }
                });
            }
        </script>
    </body>
</html>
