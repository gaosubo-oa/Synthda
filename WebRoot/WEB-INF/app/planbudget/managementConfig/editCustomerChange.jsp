<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2021/5/13
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>客商变更审批</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
    var runId = $.GetRequest()['runId'] || '';
    var dictionaryObj = {
        MERCHANT_TYPE: {},
        CUSTOMER_SOURCE: {},
        CUSTOMER_NATURE: {},
        CUSTOMER_TYPE: {}
    }
    var dictionaryStr = 'MERCHANT_TYPE,CUSTOMER_SOURCE,CUSTOMER_NATURE,CUSTOMER_TYPE';
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
        if (runId != null) {
            $.get('/PlbCustomer/queryHistoryVersionByRunId', {runId: runId, reviseType: '04'}, function (res) {
                var list = []
                if (res.flag) {
                    for (var i = 0; i < res.data.length; i++) {
                        var content = [
                            '<div class="layui-collapse">\n',
                            '  <div class="layui-colla-item">\n' +
                            '    <h2 class="layui-colla-title">' + res.data[i].version + '</h2>\n' +
                            '    <div class="layui-colla-content layui-show plan_base_info">' +
                            '<form action="" class="layui-form"  lay-filter="formContentTest' + i + '" id="editTab" style="padding: 0px 10px">' +
                            '<div class="layui-table editTab" style="margin: 8px 0px;">\n' +
                            //第一行
                            '<div class="layui-row"> ' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">客商编号<span style="color: #ff0000; font-size: 20px;">*</span></label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="customerNo" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                            '   </div>' +
                            '</div>\n' +
                            '</div>\n' +
                            '<div class="layui-col-xs3">' +
                            '<div class="layui-form-item">' +
                            '    <label class="layui-form-label">客商单位名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="customerName" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="layui-col-xs3">' +
                            '<div class="layui-form-item">' +
                            '    <label class="layui-form-label">客商单位简称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="customerShortName" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="layui-col-xs3">' +
                            '<div class="layui-form-item">' +
                            '    <label class="layui-form-label">客商类型<span style="color: red; font-size: 20px;">*</span></label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="merchantType" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong"></input>\n' +
                            '  </div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            //第二行

                            '<div class="layui-row" > ' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">客商来源</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="customerSource" id="customerSource" disabled lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">组织机构代码</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="customerOrgCode" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">单位性质</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="customerNature" id="customerNature" lay-verify="required" disabled autocomplete="off" class="layui-input jinyong"></select>\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">单位类别</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="customerType" id="customerType" lay-verify="required" disabled autocomplete="off" class="layui-input jinyong"></select>\n' +
                            '  </div></div></div>' +
                            '</div>' +


                            //第三行

                            '<div class="layui-row" > ' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">税务登记号</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="taxNumber" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">开户行名称</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="accountName" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">开户行账户</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="number" name="accountNumber" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">账号单位地址</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="accountAddress" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '</div>' +

                            //第四行

                            '<div class="layui-row" > ' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">账号单位电话</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="accountTelno" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">法人代表</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="legalPeron" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">注册资金（万元）</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="number" name="regCapital" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">单位营业地址</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="businessAddress" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '</div>' +


                            //第五行

                            '<div class="layui-row" > ' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">联系人</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="contactPerson" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">联系电话</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="contactTelno" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +

                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">营业范围</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="businessScope" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '<div class="layui-col-xs3"> ' +
                            '<div class="layui-form-item" >\n' +
                            '    <label class="layui-form-label">备注</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="remarks" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                            '  </div></div></div>' +
                            '</div>' +


                            //第六行

                            '<div class="layui-row" > ' +
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required"></span></label>' +
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
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</form>' +
                            '    </div>\n' +
                            '  </div>\n',
                            '</div>'
                        ].join('')
                        list += content
                    }
                    $('#baseForm').html(list);

                    initPage(res);
                } else {
                    var content = [
                        '<div class="layui-collapse">\n',
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">客商变更</h2>\n' +
                        '    <div class="layui-colla-content layui-show plan_base_info">' +
                        '<form action="" class="layui-form"  lay-filter="formContentTest" id="editTab" style="padding: 0px 10px">' +
                        '<div class="layui-table editTab" style="margin: 8px 0px;">\n' +
                        //第一行
                        '<div class="layui-row"> ' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">客商编号<span style="color: #ff0000; font-size: 20px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="customerNo" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '   </div>' +
                        '</div>\n' +
                        '</div>\n' +
                        '<div class="layui-col-xs3">' +
                        '<div class="layui-form-item">' +
                        '    <label class="layui-form-label">客商单位名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="customerName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="layui-col-xs3">' +
                        '<div class="layui-form-item">' +
                        '    <label class="layui-form-label">客商单位简称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="customerShortName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="layui-col-xs3">' +
                        '<div class="layui-form-item">' +
                        '    <label class="layui-form-label">客商类型<span style="color: red; font-size: 20px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="merchantType" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong"></input>\n' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        //第二行

                        '<div class="layui-row" > ' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">客商来源</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <select name="customerSource" id="customerSource" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">组织机构代码</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="customerOrgCode" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">单位性质</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <select name="customerNature" id="customerNature" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">单位类别</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <select name="customerType" id="customerType" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                        '  </div></div></div>' +
                        '</div>' +


                        //第三行

                        '<div class="layui-row" > ' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">税务登记号</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="taxNumber" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">开户行名称</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="accountName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">开户行账户</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="number" name="accountNumber" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">账号单位地址</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="accountAddress" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '</div>' +

                        //第四行

                        '<div class="layui-row" > ' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">账号单位电话</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="accountTelno" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">法人代表</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="legalPeron" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">注册资金（万元）</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="number" name="regCapital" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">单位营业地址</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="businessAddress" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '</div>' +


                        //第五行

                        '<div class="layui-row" > ' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">联系人</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="contactPerson" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">联系电话</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="contactTelno" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +

                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">营业范围</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="businessScope" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '<div class="layui-col-xs3"> ' +
                        '<div class="layui-form-item" >\n' +
                        '    <label class="layui-form-label">备注</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="remarks" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                        '  </div></div></div>' +
                        '</div>' +


                        //第六行

                        '<div class="layui-row" > ' +
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required"></span></label>' +
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
                        '</div>' +
                        '</div>' +
                        '</form>' +
                        '    </div>\n' +
                        '  </div>\n',
                        '</div>'
                    ].join('')
                    $('#baseForm').html(content);
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
    });

    function initPage(coustomerChangeInfo) {
        layui.use(['form', 'table', 'element', 'laydate', 'eleTree'], function () {
            var layTable = layui.table,
                layElement = layui.element,
                laydate = layui.laydate,
                layForm = layui.form,
                eleTree = layui.eleTree;


            layElement.render();

            $('[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str'])
            $('[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str'])
            $('[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str'])

            for (var i = 0; i < coustomerChangeInfo.data.length; i++) {
                layForm.val("formContentTest" + i, coustomerChangeInfo.data[i]);
            }
            $('form input[name="merchantType"]').val(coustomerChangeInfo.data[0].merchantTypeName)
            layElement.render();
            layForm.render();


        })
    }
</script>
</html>
