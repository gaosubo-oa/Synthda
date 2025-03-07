<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>

    <title><fmt:message code="license.management"/></title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/email/fileuploadPlus.js?20230529.3"></script>
    <script src="/js/base/base.js"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }

        .ztree * {
            font-size: 11pt !important;
        }

        #questionTree li {
            border-bottom: 1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor: pointer;
            border-radius: 3px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .select {
            background: #c7e1ff;
        }

        .layui-form-item .layui-input-inline {
            width: 300px;
        }

        .layui-form-radio > i {
            font-size: 18px;
        }

        .layui-btn + .layui-btn {
            margin: 0px;
        }

        .layui-btn-xs {
            height: 25px;
            line-height: 25px;
            padding: 0 10px;
            font-size: 13px;
        }

        .openFile input[type=file] {
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

        .layui-input-block textarea {
            border-color: #e6e6e6;
        }

        .layui-form-label {
            width: 113px;
        }

        .btn {
            vertical-align: inherit;
            height: 38px;
        }

        #questionTable {
            margin-top: -20px;
        }

        .addExecute, .addDept, .addReviewer, .addsender, .addrecipient,.addsubmitter{
            display: inline-block;
            margin-top: 10px;
        }
        .item img{
            height: 35px;
        }
    </style>

</head>
<body>
<div style="padding:10px">
    <div class="item">
        <img src="/img/infomater.png" alt="" style="margin: 4 5px 0 20px;"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;"><fmt:message code="license.management"/></span>
    </div>
    <hr class="layui-bg-blue">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this"><fmt:message code="license.management"/></li>
            <li><fmt:message code="license.borrowing.management"/></li>
        </ul>
        <div class="layui-tab-content" style="height: 100px;">
            <div class="layui-tab-item layui-show">
                <div class="layui-fluid" id="LAY-app-message">
                    <input type="hidden" id="sortId">
                    <div class="layui-row ">
                        <div class="layui-lf" style="width:260px;float:left;margin-left: -33px">
                            <div class="layui-card">
                                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                                    <ul id="questionTree" style="overflow:auto;height:100%">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="layui-rt " style="width:calc(100% - 260px);float:left">
                            <div class="layui-card rightHeight" style="padding-left: 10px;">
                                <form class="layui-form" action="" style="display: flex">
                                    <div class="layui-form-item" style="display: inline-block;flex: none;">
                                        <div class="layui-inline">
                                            <label class="layui-form-label"
                                                   style="width: 60px;margin-left: -14px"><fmt:message code="license.name"/></label>
                                            <div class="layui-input-inline" style="width: 150px;">
                                                <input type="text" name="licenseName" lay-verify="email"
                                                       autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-inline" style="margin-left: -30px;">
                                            <label class="layui-form-label" style="width: 60px"><fmt:message code="license.status"/></label>
                                            <div class="layui-input-inline" style="width: 150px;">
                                                <select name="licenseStatus" lay-verify="required" lay-search="">
                                                    <option value=""><fmt:message code="license.PleaseSelect"/></option>
                                                    <option value="0"><fmt:message code="license.invalidity"/></option>
                                                    <option value="1"><fmt:message code="license.effective"/></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="layui-inline" style="margin-left: -30px;">
                                            <label class="layui-form-label" style="width: 60px"><fmt:message code="license.Issuing.unit"/></label>
                                            <div class="layui-input-inline" style="width: 150px;">
                                                <input type="text" name="issueUnit" lay-verify="email"
                                                       autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-inline" style="margin-left: -30px;">
                                            <label class="layui-form-label" style="width: 70px"><fmt:message code="license.validity.period"/></label>
                                            <div class="layui-input-inline" style="width: 150px;">
                                                <select name="effectiveDate" lay-verify="required" lay-search="">
                                                    <option value=""><fmt:message code="license.selected"/></option>
                                                    <option value="1"><fmt:message code="license.Expired"/></option>
                                                    <option value="2"><fmt:message code="license.one.month"/></option>
                                                    <option value="3"><fmt:message code="license.three.months"/></option>
                                                    <option value="4"><fmt:message code="license.six.months"/></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="layui-btn btn" id="search"><fmt:message code="license.query"/>
                                    </button>
                                </form>
                                <table id="questionTable" lay-filter="questionTable-table" onload=''></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-tab-item">
                <div class="btn">
                    <form class="layui-form" action="" style="display: flex">
                        <div class="layui-form-item" style="display: inline-block;flex: none;">
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 60px;margin-left: -14px"><fmt:message code="license.Borrowing.Title"/></label>
                                <div class="layui-input-inline" style="width: 150px;">
                                    <input type="text" name="lendTitle" lay-verify="email" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 60px"><fmt:message code="license.Urgent.level"/></label>
                                <div class="layui-input-inline" style="width: 150px;">
                                    <select name="urgency" lay-verify="required" lay-search="">
                                        <option value=""><fmt:message code="license.selected"/></option>
                                        <option value="0"><fmt:message code="license.Normal"/></option>
                                        <option value="1"><fmt:message code="license.Urgent"/></option>
                                        <option value="2"><fmt:message code="license.Very.urgent"/></option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 60px"><fmt:message code="license.Audit.status"/></label>
                                <div class="layui-input-inline" style="width: 150px;">
                                    <select name="approvalStatus" lay-verify="required" lay-search="">
                                        <option value=""><fmt:message code="license.selected"/></option>
                                        <option value="0"><fmt:message code="license.Unapproved"/></option>
                                        <option value="1"><fmt:message code="license.Approved"/></option>
                                        <option value="2"><fmt:message code="license.not.approved"/></option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 50px;"><fmt:message code="license.submitter"/></label>
                                <div class="layui-input-inline" style="width: 150px;">
                                    <input type="text" id="submitter" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>
                                </div>
                                <a href="javascript:;" style="color:#1E9FFF" class="addsubmitter"><fmt:message code="license.add"/></a>
                                <a href="javascript:;" style="color:#1E9FFF" class="clearsubmitter"><fmt:message code="license.empty"/></a>
                            </div>
                            <button type="button" class="layui-btn layui-btn-normal inquire" style="margin-top: -5px"><fmt:message code="license.query"/></button>
                        </div>
                    </form>
                </div>
                <table id="tableList" lay-filter="tableList"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addTable" id="addTable"><fmt:message code="license.new"/></button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="license.edit"/></a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="log"><fmt:message code="license.history"/></a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
</script>
<script type="text/html" id="barlistDemo">
    {{#  if(d.approvalStatus == 0){ }}
    <a class="layui-btn layui-btn-xs" lay-event="editreview"><fmt:message code="license.examine"/></a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
    {{#  }else if(d.approvalStatus == 1){ }}
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="returns"><fmt:message code="license.edit"/></a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
    {{#  }else if(d.approvalStatus == 2){ }}
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
    {{#  } }}

</script>

<script>
    var form
    var table
    var element
    var versionName
    var versionExplain
    var height = $(window).height()
    $('#leftHeight').height(height - 130);
    $('.rightHeight').height(height - 110);
    $('#questionTree').height(height - 160);


    layui.use(['form', 'table', 'laydate', 'element', 'layer', 'upload','xmSelect'], function () {
        var layer = layui.layer;
        table = layui.table;
        form = layui.form;
        element = layui.element;
        xmSelect:layui.xmSelect;
        var upload = layui.upload;
        var laydate = layui.laydate
        form.render()


        $('#questionTree').on('click', 'li', function () {
            var licenseType = $(this).attr('licenseType');
            $(this).addClass('select').siblings().removeClass('select');

            table.reload('questionTable', {
                url: '/comlicenseInfo/queryAll',
                where: {
                    licenseType: licenseType
                }
            })
        })
        getlis();

        function getlis() {
            $.ajax({
                url: '/comlicenseType/queryAll',
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    var data = res.data
                    var str = ''
                    for (var i = 0; i < data.length; i++) {
                        if (i == 0) {
                            str += '<li class="select" title="' + data[i].licenseTypeName + '" dictNo="' + data[i].licenseTypeName + '"  licenseType="' + data[i].licenseType + '">' + data[i].licenseTypeName + '</li>'
                        } else {
                            str += '<li dictNo="' + data[i].licenseTypeName + '" licenseType="' + data[i].licenseType + '" title="' + data[i].licenseTypeName + '">' + data[i].licenseTypeName + '</li>'
                        }
                    }
                    $('#questionTree').html(str)
                }
            })
        }

        //添加的按钮

        function refresh() {
            var tableIns = table.render({
                elem: '#questionTable'
                , url: '/comlicenseInfo/queryAll?licenseType=' + $('.select').attr('licenseType')//数据接口
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    }
                },
                where:{
                    isAdmin:1
                }
                , defaultToolbar: ['']
                ,toolbar: '#toolbarDemo'
                , cols: [[ //表头
                    {field: 'licenseNo', title: '<fmt:message code="license.no"/>'}
                    , {field: 'licenseName', title: '<fmt:message code="license.name"/>'}
                    , {
                        field: 'licenseStatus', title: '<fmt:message code="license.status"/>', templet: function (d) {
                            if (d.licenseStatus == "0") {
                                return '<fmt:message code="license.invalidity"/>'
                            } else if (d.licenseStatus == "1") {
                                return '<fmt:message code="license.effective"/>'
                            }
                        }
                    }
                    , {field: 'validityBeginDate', title: '<fmt:message code="license.validityBeginDate"/>'}
                    , {field: 'validityEndDate', title: '<fmt:message code="license.validityEndDate"/>'}
                    , {field: 'validityYear', title: '<fmt:message code="license.validityYear"/>'}
                    , {field: 'issueUnit', title: '<fmt:message code="license.Issuing.unit"/>'}
                    , {title: '<fmt:message code="license.operation"/>', align: 'center', toolbar: '#barDemo', width: '250'}
                ]],
                page: true,
            });
            if ($('.select').attr('licenseType') == undefined) {
                $('.layui-table-body').hide()
            }

            //监听工具条
            table.on('tool(questionTable-table)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var licenseType = $('.select').attr('licenseType')
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var licenseId = data.licenseId   //获取当前行得id
                if (layEvent === 'edit') {
                    creat(1, licenseId, licenseType)
                } else if (layEvent === 'del') {
                    layer.confirm('<fmt:message code="license.deleting.this"/>', function (index) {
                        $.ajax({
                            url: '/comlicenseInfo/delete',
                            data: {
                                licenseId: licenseId,
                            },
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('<fmt:message code="license.delsucess"/>', {icon: 1});
                                    tableIns.reload()
                                }
                            }
                        })
                    });
                } else {
                    layer.open({
                        type: 1,
                        title: '<fmt:message code="license.log"/>',
                        btn: ['<fmt:message code="license.cancel"/>'],
                        shade: 0.5,
                        area: ['80%', '90%'],
                        content: '<div id="conts" style="margin: 10px">\n' +
                            '        <form class="layui-form" action="" id="ajaxforms" lay-filter="ajaxforms">\n' +
                            '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                            '                <div class="layui-inline">\n' +
                            '                  <label class="layui-form-label"><fmt:message code="license.Version.creation.name"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                       <select  class="createTime" lay-verify="required" lay-filter="aihao" lay-search="">\n' +
                            '                          </select>\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.Version.name"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="versionName" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.Version.Description"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="versionExplain" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.name"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="licenseName" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.validityBeginDate"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="validityBeginDate" id="creatdate" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.validityEndDate"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="validityEndDate" id="date" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.validityYear"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="validityYear" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.Date.issue"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="inssueDate" id="dateofIssue" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +

                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.AnnualInspectionDate"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="annualInspectionDate" id="inspectionDate" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.Issuing.unit"/></label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="issueUnit" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <div class="layui-form-item layui-form-text">\n' +
                            '                       <label class="layui-form-label"><fmt:message code="license.remarks"/></label>\n' +
                            '                        <div class="layui-input-inline">\n' +
                            '                            <textarea placeholder="<fmt:message code="license.Please.enter"/>" class="layui-textarea"  name="remark"></textarea>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            ' <div class="layui-inline"  style="margin-top:-50px">\n' +
                            '    <label class="layui-form-label" style="width: 100px;margin-left:15px"><fmt:message code="license.upAttach"/></label>\n' +
                            '    <div class="layui-input-inline">\n' +
                            '<div id="fujians"></div>' +
                            ' <div id="fileAll">\n' +
                            '</div>\n' +
                            '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            '<img src="../img/mg11.png" alt="">\n' +
                            '<span><fmt:message code="license.add.attach"/></span>\n' +
                            '<input type="file" multiple id="fileupload" data-url="/upload?module=comlicense" name="file">\n' +
                            '</a>\n' +
                            '</div>\n' +
                            '</div>' +
                            '            </div>\n' +
                            '        </form>\n' +
                            '    </div>',
                        success: function (res) {
                            $.ajax({
                                url: '/comlicenseInfo/getLogById',
                                dataType: 'json',
                                type: 'get',
                                data: {
                                    licenseId: licenseId
                                },
                                success: function (res) {
                                    var strs = ''
                                    for (var i = 0; i < res.data.length; i++) {
                                        strs += '<option title="' + res.data[i].versionName + '" value="' + res.data[i].versionId + '">' + res.data[i].versionName + '</option>'
                                    }
                                    $('.createTime').append(strs)
                                    form.render('select');
                                    version($('.createTime').val())
                                    //监听下拉框的改变
                                    form.on('select(aihao)', function (data) {
                                        version($('.createTime').val())
                                        $('#fileAll').html('')
                                    })

                                    function version(createTime) {
                                        $.ajax({
                                            url: '/comlicenseInfo/getLogDetailById',
                                            dataType: 'json',
                                            type: 'get',
                                            data: {
                                                logId: createTime
                                            },
                                            success: function (res) {
                                                var str = ''
                                                if (res.data.attachments !=undefined) {
                                                    for (var i = 0; i < res.data.attachments.length; i++) {
                                                        var fileExtension=res.data.attachments[i].attachName.substring(res.data.attachments[i].attachName.lastIndexOf(".")+1,res.data.attachments[i].attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(res.data.attachments[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                                        var deUrl = res.data.attachments[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+res.data.attachments[i].size;
                                                        str += '<div class="dech" deUrl="' + res.data.attachments[i].attUrl + '"><a href="/download?' + res.data.attachments[i].attUrl + '" NAME="' + res.data.attachments[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + res.data.attachments[i].attachName + '</a><input type="hidden" class="inHidden" value="' + res.data.attachments[i].aid + '@' + res.data.attachments[i].ym + '_' + res.data.attachments[i].attachId + ',"><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + res.data.attachments[i].aid + '@' + res.data.attachments[i].ym + '_' + res.data.attachments[i].attachId + ',"></div>'
                                                    }
                                                } else {
                                                    str = '';
                                                }
                                                $('#fileAll').append(str)
                                                var option = $('.createTime option')  //商品大类回显
                                                for (var i = 0; i < option.length; i++) {
                                                    if (option.eq(i).attr('title') == data.versionName) {
                                                        option.eq(i).prop('selected', 'selected')
                                                    }
                                                }
                                                form.render()
                                                form.val("ajaxforms", res.data);
                                            }

                                        })
                                    }
                                }
                            })
                        }
                    })
                }
            });

            //头工具栏事件
            table.on('toolbar(questionTable-table)', function(obj){
                switch(obj.event){
                    case 'addTable':
                        var licenseType = $('.select').attr('licenseType')
                        creat(0, '', licenseType)
                        break;
                };
            });

            $('#search').on("click",function () {
                var licenseType = $('.select').attr('licenseType')
                var currentPage = 1;
                table.reload('questionTable', {
                    url: '/comlicenseInfo/getDataByCondition',
                    data: {page: currentPage},
                    page: {
                        curr: currentPage
                    },
                    where: {
                        licenseName: $('input[name="licenseName"]').val(),
                        licenseStatus: $('select[name="licenseStatus"]').val(),
                        effectiveDate: $('select[name="effectiveDate"]').val(),
                        issueUnit: $('input[name="issueUnit"]').val(),
                        licenseType: licenseType
                    }
                })
            })

            /*新建和编辑的方法*/
            function creat(type, licenseId, licenseType) {
                if (type == '0') {
                    var title = '<fmt:message code="license.new"/>';
                } else {
                    var title = '<fmt:message code="license.edit"/>';
                }
                layer.open({
                    type: 1,
                    title: title,
                    btn: ['<fmt:message code="license.determine"/>', '<fmt:message code="license.cancel"/>'],
                    area: ['55%', '90%'],
                    content: '<div id="cont" style="margin-left: 116px">\n' +
                        '        <form class="layui-form" action="" id="ajaxforms" lay-filter="ajaxforms">\n' +
                        '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                        '                <div class="layui-inline">\n' +
                        '                    <span style="color:red">*</span><label class="layui-form-label"><fmt:message code="license.no"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="licenseNo" lay-verify="required|phone" autocomplete="off"\n' +
                        '                               class="layui-input required">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '                <div class="layui-inline">\n' +
                        '                    <span style="color:red">*</span><label class="layui-form-label"><fmt:message code="license.name"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="licenseName"  id="licenseName" lay-verify="required|phone" autocomplete="off"\n' +
                        '                               class="layui-input required">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item">\n' +
                        '                <div class="layui-inline">\n' +
                        '                     <span style="color:red">*</span><label class="layui-form-label"><fmt:message code="license.validityBeginDate"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="validityBeginDate" id="creatdate" lay-verify="date"\n' +
                        '                               autocomplete="off" class="layui-input required">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label"><fmt:message code="license.status"/></label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input type="radio" name="licenseStatus" value="0" title="<fmt:message code="license.invalidity"/>" checked="">\n' +
                        '                    <input type="radio" name="licenseStatus" value="1" title="<fmt:message code="license.effective"/>">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item">\n' +
                        '                <div class="layui-inline">\n' +
                        '                     <span style="color:red">*</span><label class="layui-form-label"><fmt:message code="license.validityEndDate"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="validityEndDate" id="date" lay-verify="date"\n' +
                        '                               autocomplete="off" class="layui-input required">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '                <div class="layui-inline">\n' +
                        '                   <label class="layui-form-label"><fmt:message code="license.validityYear"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="validityYear" lay-verify="required|phone" autocomplete="off"\n' +
                        '                               class="layui-input">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item">\n' +
                        '                <div class="layui-inline">\n' +
                        '                    <label class="layui-form-label"><fmt:message code="license.Date.issue"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="inssueDate" id="dateofIssue" lay-verify="date"\n' +
                        '                               autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '                <div class="layui-inline">\n' +
                        '                    <label class="layui-form-label"><fmt:message code="license.AnnualInspectionDate"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="annualInspectionDate" id="inspectionDate" lay-verify="date"\n' +
                        '                               autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                        '                <div class="layui-inline">\n' +
                        '                   <label class="layui-form-label"><fmt:message code="license.Issuing.unit"/></label>\n' +
                        '                    <div class="layui-input-inline">\n' +
                        '                        <input type="text" name="issueUnit" lay-verify="required|phone" autocomplete="off"\n' +
                        '                               class="layui-input">\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        ' <div class="layui-inline" >\n' +
                        '    <label class="layui-form-label" style="width: 100px;margin-left:14px"><fmt:message code="license.upAttach"/></label>\n' +
                        '    <div class="layui-input-inline">\n' +
                        '<div id="fujians"></div>' +
                        ' <div id="fileAll">\n' +
                        '</div>\n' +
                        '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                        '<img src="../img/mg11.png" alt="">\n' +
                        '<span><fmt:message code="license.add.attach"/></span>\n' +
                        '<input type="file" multiple id="fileupload" data-url="/upload?module=comlicense" name="file">\n' +
                        '</a>\n' +
                        '</div>\n' +
                        '</div>' +
                        '            </div>\n' +
                        '            <div class="layui-form-item">\n' +
                        '                <div class="layui-inline">\n' +
                        '                    <div class="layui-form-item layui-form-text">\n' +
                        '                       <label class="layui-form-label"><fmt:message code="license.remarks"/></label>\n' +
                        '                        <div class="layui-input-inline">\n' +
                        '                            <textarea placeholder="<fmt:message code="license.Please.enter"/>" class="layui-textarea"  name="remark"></textarea>\n' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </form>\n' +
                        '    </div>',
                    success: function (res) {
                        //日期
                        laydate.render({
                            elem: '#date'
                            , trigger: 'click'//呼出事件改成click
                        });
                        laydate.render({
                            elem: '#creatdate'
                            , trigger: 'click'//呼出事件改成click
                        });
                        laydate.render({
                            elem: '#dateofIssue'
                            , trigger: 'click'//呼出事件改成click
                        });
                        laydate.render({
                            elem: '#inspectionDate'
                            , trigger: 'click'//呼出事件改成click
                        });
                        form.render();
                        fileuploadFn('#fileupload', $('#fileAll'));
                        if (type == 1) {
                            $.ajax({
                                url: '/comlicenseInfo/queryByTypeId',
                                dataType: 'json',
                                type: 'get',
                                data: {
                                    licenseId: licenseId
                                },
                                success: function (res) {
                                    var str = ''
                                    form.render()
                                    if (res.data.attachments!=undefined) {
                                        for (var i = 0; i < res.data.attachments.length; i++) {
                                            var fileExtension=res.data.attachments[i].attachName.substring(res.data.attachments[i].attachName.lastIndexOf(".")+1,res.data.attachments[i].attachName.length);//截取附件文件后缀
                                            var attName = encodeURI(res.data.attachments[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                            var deUrl = res.data.attachments[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+res.data.attachments[i].size;
                                            str += '<div class="dech" deUrl="' + res.data.attachments[i].attUrl + '"><a href="/download?' + res.data.attachments[i].attUrl + '" NAME="' + res.data.attachments[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + res.data.attachments[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + res.data.attachments[i].aid + '@' + res.data.attachments[i].ym + '_' + res.data.attachments[i].attachId + ',"><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + res.data.attachments[i].aid + '@' + res.data.attachments[i].ym + '_' + res.data.attachments[i].attachId + ',"></div>'
                                        }
                                    } else {
                                        str = '';
                                    }
                                    $('#fileAll').append(str)
                                    form.val("ajaxforms", res.data);
                                }

                            })
                        }
                    },
                    yes: function (index) {
                        //第二次弹框
                        if (versionName == undefined || versionExplain == undefined) {
                            layer.open({
                                type: 1,
                                title: title,
                                btn: ['<fmt:message code="license.determine"/>', '<fmt:message code="license.cancel"/>'],
                                area: ['40%', '40%'],
                                content: '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                                    '                <div class="layui-inline">\n' +
                                    '                   <label class="layui-form-label"><fmt:message code="license.Version.name"/>:</label>\n' +
                                    '                    <div class="layui-input-inline">\n' +
                                    '                        <input type="text" lay-verify="required|phone" autocomplete="off"\n' +
                                    '                               class="layui-input  versionName">\n' +
                                    '                    </div>\n' +
                                    '                </div>\n' +
                                    '            </div>\n' +
                                    '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                                    '                <div class="layui-inline">\n' +
                                    '                   <label class="layui-form-label"><fmt:message code="license.Version.Description"/>:</label>\n' +
                                    '                    <div class="layui-input-inline">\n' +
                                    '                        <input type="text" lay-verify="required|phone" autocomplete="off"\n' +
                                    '                               class="layui-input  versionExplain">\n' +
                                    '                    </div>\n' +
                                    '                </div>\n' +
                                    '            </div>\n',
                                yes: function (index) {
                                    versionName = $('.versionName').val()
                                    versionExplain = $('.versionExplain').val()
                                    layer.close(index);
                                }

                            })
                        } else {
                            for (var i = 0; i < $('.required').length; i++) {
                                if ($('.required').eq(i).val() == '') {
                                    var content=$('.required').eq(i).parents('.layui-inline').children('.layui-form-label').text()
                                    if(content==''){
                                        var content=$('.required').eq(i).parents('.layui-form-item').children('.layui-form-label').text()
                                    }
                                    $.layerMsg({
                                        content: '' + content + '<fmt:message code="license.notnull"/>',
                                        icon: 2
                                    });
                                    return false;
                                }
                            }
                            var starttime = $('#creatdate').val();
                            var endtime = $('#date').val();
                            var start = new Date(starttime.replace("-", "/").replace("-", "/"));
                            var end = new Date(endtime.replace("-", "/").replace("-", "/"));
                            if(end<start){
                                layer.msg('<fmt:message code="license.start.than.end"/>！', {icon: 2});
                                return false;
                            }

                            var obj = {}
                            //附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileAll .dech').length; i++) {
                                attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                                attachmentName += $('#fileAll a').eq(i).attr('name');
                            }

                            if (type == 0) {
                                var url = '/comlicenseInfo/add'
                            } else {
                                var url = '/comlicenseInfo/update'
                                obj.licenseId = licenseId
                            }
                            obj.licenseNo = $('input[name="licenseNo"]').val()
                            obj.licenseName = $('#cont input[name="licenseName"]').val()
                            obj.versionName = versionName
                            obj.versionExplain = versionExplain
                            obj.licenseStatus = $('input[name="licenseStatus"]:checked').val()
                            obj.validityBeginDate = $('input[name="validityBeginDate"]').val()
                            obj.validityEndDate = $('input[name="validityEndDate"]').val()
                            obj.validityYear = $('input[name="validityYear"]').val()
                            obj.inssueDate = $('input[name="inssueDate"]').val()
                            obj.annualInspectionDate = $('input[name="annualInspectionDate"]').val()
                            obj.issueUnit = $('#cont input[name="issueUnit"]').val()
                            obj.remark = $('#cont textarea[name="remark"]').val()
                            obj.licenseType = licenseType
                            obj.versionId = 1
                            obj.attachmentId = attachmentId
                            obj.attachmentName = attachmentName
                            $.ajax({
                                url: url,
                                dataType: 'json',
                                type: 'get',
                                data: obj,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('<fmt:message code="license.modify"/>', {icon: 1});
                                        tableIns.reload()
                                        layer.closeAll();
                                    }
                                }
                            })
                        }
                    }
                })
            }
        }

        $(function () {
            setTimeout(refresh, 1500);
        })

        //监听tab切换
        element.on('tab(docDemoTabBrief)', function (data) {
            var index = data.index;
            if (index == '0') {

            } else {
                var tableInt = table.render({
                    elem: '#tableList',
                    url: '/comlicenseUse/getDataByCondition',
                    page: true,
                    where: {
                        isAdmin: 1
                    },
                    defaultToolbar: [''],
                    cols: [[
                        {field: 'lendTitle', title: '<fmt:message code="license.Borrowing.Title"/>'},
                        {field: 'approvalName', title: '<fmt:message code="license.applicant"/>'},
                        {field: 'approvalDeptName', title: '<fmt:message code="license.Applicant.department"/>'},
                        {field: 'approvalStatus', title: '<fmt:message code="license.Audit.status"/>',templet: function (d) {
                                if (d.approvalStatus == "0") {
                                    return '<fmt:message code="license.Unapproved"/>'
                                } else if (d.approvalStatus == "1") {
                                    return '<fmt:message code="license.Approved"/>'
                                } else if (d.approvalStatus == "2") {
                                    return '<fmt:message code="license.not.approved"/>'
                                }
                            }},
                        {
                            field: 'urgency', title: '<fmt:message code="license.Urgent.level"/>', templet: function (d) {
                                if (d.urgency == "0") {
                                    return '<fmt:message code="license.Normal"/>'
                                } else if (d.urgency == "1") {
                                    return '<fmt:message code="license.Urgent"/>'
                                } else if (d.urgency == "2") {
                                    return '<fmt:message code="license.Very.urgent"/>'
                                }
                            }
                        },
                        {field: 'useReason', title: '<fmt:message code="license.Reason"/>'},
                        {field: 'useTime', title: '<fmt:message code="license.hours"/>'},
                        {fixed: '', title: '<fmt:message code="license.operation"/>', toolbar: '#barlistDemo',width:'200'}
                    ]],
                    parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.data,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        }
                    },
                });
                //审核和同意和删除
                table.on('tool(tableList)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var licenseUseId = data.licenseUseId   //获取当前行得id
                    if (layEvent === 'editreview') {
                        creatAdd(0,licenseUseId)
                    } else if (layEvent === 'del') {
                        layer.confirm('<fmt:message code="license.deleting.this"/>', function (index) {
                            $.ajax({
                                url: '/comlicenseUse/delComlicenseUse',
                                data: {
                                    licenseUseIds: licenseUseId,
                                },
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('<fmt:message code="license.delsucess"/>', {icon: 1});
                                        tableInt.reload()
                                    }
                                }
                            })
                            layer.close(index);

                        });
                    }else{
                        var projectIdsSelect = null;
                        layer.open({
                            type: 1,
                            title: '<fmt:message code="license.edit"/>',
                            btn: ['保存','<fmt:message code="license.cancel"/>'],
                            area: ['100%', '100%'],
                            content: '<div id="cont" style="margin: 10px">\n' +
                                '        <form class="layui-form" action="" id="forms" lay-filter="forms">\n' +
                                '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                                '                <div class="layui-inline">\n' +
                                '                   <label class="layui-form-label"><fmt:message code="license.Borrowing.Title"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="lendTitle" lay-verify="required|phone" autocomplete="off"\n' +
                                '                               class="layui-input required" disabled>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-inline" style="margin-left: 60px">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.applicant"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" id="rescueUser" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                                '                    </div>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="addExecute"><fmt:message code="license.add"/></a>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute"><fmt:message code="license.empty"/></a>\n' +
                                '                </div>\n'+
                                '            </div>\n' +
                                '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                                '                <div class="layui-inline">\n' +
                                '                  <label class="layui-form-label"><fmt:message code="license.Customer.Name"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="customer" lay-verify="required|phone" autocomplete="off"\n' +
                                '                               class="layui-input required">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-inline" style="margin-left: 60px">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Applicant.department"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" id="deptNames"  lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                                '                    </div>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="addDept"><fmt:message code="license.add"/></a>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="clearDept"><fmt:message code="license.empty"/></a>\n' +
                                '                </div>\n'+
                                '            </div>\n' +

                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Urgent.level"/>：</label>\n' +
                                '                       <div class="layui-input-inline">\n' +
                                '                           <input type="radio" name="urgency" value="0" title="<fmt:message code="license.Normal"/>" checked="">\n' +
                                '                           <input type="radio" name="urgency" value="1" title="<fmt:message code="license.Urgent"/>">\n' +
                                '                           <input type="radio" name="urgency" value="2" title="<fmt:message code="license.Very.urgent"/>">\n' +
                                '                      </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label" style="margin-left: 60px"><fmt:message code="license.Borrowing.status"/>：</label>\n' +
                                '                       <div class="layui-input-inline">\n' +
                                '                           <input type="radio" name="useStatus" value="0" title="<fmt:message code="license.Not.loaned.out"/>" checked="">\n' +
                                '                           <input type="radio" name="useStatus" value="1" title="<fmt:message code="license.Borrowed"/>">\n' +
                                '                           <input type="radio" name="useStatus" value="1" title="<fmt:message code="license.Returned"/>">\n' +
                                '                      </div>\n' +
                                '            </div>\n' +
                                '            </div>\n' +
                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.hours"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="useTime" id="creatdate" lay-verify="date"\n' +
                                '                               autocomplete="off" class="layui-input required" disabled>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-inline" style="margin-left: 60px">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.return.time"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="planReturnTime" id="date" lay-verify="date"\n' +
                                '                               autocomplete="off" class="layui-input required">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>\n' +
                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Actual.return.time"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="realReturnTime" id="dateofIssue" lay-verify="date"\n' +
                                '                               autocomplete="off" class="layui-input required">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-inline" style="margin-left: 60px">\n' +
                                '                    <div class="layui-form-item layui-form-text">\n' +
                                '                       <label class="layui-form-label"><fmt:message code="license.Borrowing"/>：</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '                            <div id="projectIdsSelect" class="xm-select-demo"></div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '         </div>\n' +

                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Reviewer"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" id="reviewer" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                                '                    </div>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="addReviewer"><fmt:message code="license.add"/></a>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="clearReviewer"><fmt:message code="license.empty"/></a>\n' +
                                '                </div>\n'+
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Sender"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" id="sender" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                                '                    </div>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="addsender"><fmt:message code="license.add"/></a>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="clearsender"><fmt:message code="license.empty"/></a>\n' +
                                '                </div>\n'+
                                '            </div>\n' +

                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.addressee"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" id="recipient" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                                '                    </div>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="addrecipient"><fmt:message code="license.add"/></a>\n' +
                                '                    <a href="javascript:;" style="color:#1E9FFF" class="clearrecipient"><fmt:message code="license.empty"/></a>\n' +
                                '                </div>\n'+
                                '                <div class="layui-inline">\n' +
                                '                  <label class="layui-form-label"><fmt:message code="license.courier.number"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="courierNum" lay-verify="required|phone" autocomplete="off"\n' +
                                '                               class="layui-input required">\n' +
                                '                    </div>\n' +
                                '            </div>\n' +
                                '            </div>\n' +
                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <label class="layui-form-label"><fmt:message code="license.Delivery.time"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="dispatchTime" id="dispatchTime" lay-verify="date"\n' +
                                '                               autocomplete="off" class="layui-input required">\n' +
                                '                    </div>\n' +
                                '                </div>\n'+
                                '                <div class="layui-inline" style="margin-left: 60px">\n' +
                                '                  <label class="layui-form-label"><fmt:message code="license.Shipping.address"/>：</label>\n' +
                                '                    <div class="layui-input-inline">\n' +
                                '                        <input type="text" name="mailAddress" lay-verify="required|phone" autocomplete="off"\n' +
                                '                               class="layui-input required">\n' +
                                '                    </div>\n' +
                                '            </div>\n' +
                                '            </div>\n' +
                                '            <div class="layui-form-item">\n' +
                                '                <div class="layui-inline">\n' +
                                '                    <div class="layui-form-item layui-form-text">\n' +
                                '                       <label class="layui-form-label"><fmt:message code="license.Reason"/>：</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '                            <textarea class="layui-textarea"  name="useReason"></textarea>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>\n' +
                                '        </form>\n' +
                                '    </div>',
                            success: function (res) {
                                //进货人点击添加的按钮
                                $(".addExecute").on("click",function(){
                                    user_id = "rescueUser";
                                    $.popWindow("/common/selectUser?0");
                                });
                                $('.clearExecute').on("click",function () {
                                    $("#rescueUser").val("");
                                    $("#rescueUser").attr('username','');
                                    $("#rescueUser").attr('dataid','');
                                    $("#rescueUser").attr('user_id','');
                                    $("#rescueUser").attr('userprivname','');
                                });

                                //审核人
                                $(".addReviewer").on("click",function(){
                                    user_id = "reviewer";
                                    $.popWindow("/common/selectUser?0");
                                });
                                $('.clearReviewer').on("click",function () {
                                    $("#reviewer").val("");
                                    $("#reviewer").attr('username','');
                                    $("#reviewer").attr('dataid','');
                                    $("#reviewer").attr('user_id','');
                                    $("#reviewer").attr('userprivname','');
                                });

                                //寄件人
                                $(".addsender").on("click",function(){
                                    user_id = "sender";
                                    $.popWindow("/common/selectUser?0");
                                });
                                $('.clearsender').on("click",function () {
                                    $("#sender").val("");
                                    $("#sender").attr('username','');
                                    $("#sender").attr('dataid','');
                                    $("#sender").attr('user_id','');
                                    $("#sender").attr('userprivname','');
                                });

                                //寄件人
                                $(".addrecipient").on("click",function(){
                                    user_id = "recipient";
                                    $.popWindow("/common/selectUser?0");
                                });
                                $('.clearrecipient').on("click",function () {
                                    $("#recipient").val("");
                                    $("#recipient").attr('username','');
                                    $("#recipient").attr('dataid','');
                                    $("#recipient").attr('user_id','');
                                    $("#recipient").attr('userprivname','');
                                });
                                // 添加部门信息
                                $(".addDept").on("click", function () {
                                    dept_id = "deptNames";
                                    $.popWindow("../../common/selectDept?0");
                                });
                                // 清空部门信息
                                $('.clearDept').on("click",function () {
                                    $('#deptNames').attr("deptid", "");
                                    $('#deptNames').attr("deptno", "");
                                    $('#deptNames').attr("deptname", "");
                                    $('#deptNames').val("");
                                });
                                //日期
                                laydate.render({
                                    elem: '#date'
                                    , type: 'datetime'
                                    , trigger: 'click'//呼出事件改成click
                                    , format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                laydate.render({
                                    elem: '#creatdate'
                                    , type: 'datetime'
                                    , trigger: 'click'//呼出事件改成click
                                    , format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                laydate.render({
                                    elem: '#dateofIssue'
                                    , type: 'datetime'
                                    , trigger: 'click'//呼出事件改成click
                                    , format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                laydate.render({
                                    elem: '#dispatchTime'
                                    , type: 'datetime'
                                    , trigger: 'click'//呼出事件改成click
                                    , format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                form.render();
                                $.get('/comlicenseInfo/queryAll', function(res){
                                    var data = [];
                                    if (res.flag && res.data.length > 0) {
                                        data = res.data;
                                    }
                                    projectIdsSelect=xmSelect.render({
                                        el: '#projectIdsSelect',
                                        toolbar: {
                                            show: true,
                                        },
                                        filterable: true,
                                        autoRow: true,
                                        prop: {
                                            name: 'licenseName',
                                            value: 'licenseId',
                                        },
                                        data: data
                                    });
                                    $.ajax({
                                        url: '/comlicenseUse/getDataByLicenseUseId',
                                        dataType: 'json',
                                        type: 'get',
                                        data: {
                                            licenseUseId: licenseUseId
                                        },
                                        success: function (res) {
                                            //申请人
                                            $('#rescueUser').val(res.data.approvalName)
                                            $("#rescueUser").attr('user_id',res.data.approvalUser+',');

                                            //申请人所在部门
                                            $('#deptNames').val(res.data.approvalDeptName)
                                            $("#deptNames").attr('deptid',res.data.approvalDept+',');
                                            // 寄件人
                                            $('#sender').val(res.data.senderName)
                                            $("#sender").attr('user_id',res.data.sender+',');
                                            //审核人
                                            $('#reviewer').val(res.data.reviewerName)
                                            $("#reviewer").attr('user_id',res.data.reviewer+',');
                                            //收件人
                                            $('#recipient').val(res.data.addresseeName)
                                            $("#recipient").attr('user_id',res.data.addressee+',');

                                            //回显 借阅证照
                                            var viewUserTypeArr = (res.data.licenseIds || '').split(',');
                                            projectIdsSelect.setValue(viewUserTypeArr);
                                            form.val("forms", res.data);
                                        }

                                    })
                                });
                            },
                            yes: function (index) {
                                var projectIds = ''
                                // 获取
                                var projectArr = projectIdsSelect.getValue()
                                projectArr.forEach(function (item, index) {
                                    projectIds += item.licenseId + ','
                                })
                                var approvalUser = $('#rescueUser').attr('user_id')
                                var approvalDept = $('#deptNames').attr('deptid')
                                var reviewer = $('#reviewer').attr('user_id')
                                var sender = $('#sender').attr('user_id')
                                var addressee = $('#recipient').attr('user_id')
                                var licenseIds = projectIds.substr(0, projectIds.length - 1)
                                $.ajax({
                                    url: '/comlicenseUse/updateComlicenseUse',
                                    dataType: 'json',
                                    type: 'get',
                                    data: $('#forms').serialize() + '&approvalUser=' + approvalUser.substr(0, approvalUser.length - 1) + '&approvalDept=' + approvalDept.substr(0, approvalDept.length - 1) + '&reviewer=' + reviewer.substr(0, reviewer.length - 1) + '&sender=' + sender.substr(0, sender.length - 1) + '&addressee=' + addressee.substr(0, addressee.length - 1)+ '&licenseIds=' + licenseIds+ '&licenseUseId=' + licenseUseId,
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.msg('<fmt:message code="license.modify"/>', {icon: 1});
                                            tableInt.reload()
                                            layer.closeAll();
                                        }
                                    }
                                })
                            }
                        })
                    }
                });
                /*审核方法*/
                function creatAdd(type,licenseUseId) {
                    if (type == '0') {
                        var title = '<fmt:message code="license.examine"/>';
                    }
                    var projectIdsSelect = null;
                    layer.open({
                        type: 1,
                        title: title,
                        btn: ['<fmt:message code="license.Approved"/>','<fmt:message code="license.not.approved"/>','<fmt:message code="license.cancel"/>'],
                        shade: 0.5,
                        area: ['80%', '80%'],
                        content: '<div id="cont" style="margin: 10px">\n' +
                            '        <form class="layui-form" action="" id="forms" lay-filter="forms">\n' +
                            '            <div class="layui-form-item" style="margin-top: 15px">\n' +
                            '                <div class="layui-inline">\n' +
                            '                   <label class="layui-form-label"><fmt:message code="license.Borrowing.Title"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="lendTitle" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline" style="margin-left: 60px">\n' +
                            '                  <label class="layui-form-label"><fmt:message code="license.Customer.Name"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="customer" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.Urgent.level"/>：</label>\n' +
                            '                       <div class="layui-input-inline">\n' +
                            '                           <input type="radio" name="urgency" value="0" title="<fmt:message code="license.Normal"/>" checked="">\n' +
                            '                           <input type="radio" name="urgency" value="1" title="<fmt:message code="license.Urgent"/>">\n' +
                            '                           <input type="radio" name="urgency" value="2" title="<fmt:message code="license.Very.urgent"/>">\n' +
                            '                      </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline" style="margin-left: 60px">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.hours"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="useTime" id="creatdate" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.return.time"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="planReturnTime" id="date" lay-verify="date"\n' +
                            '                               autocomplete="off" class="layui-input required">\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline" style="margin-left: 60px">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.Reviewer"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" id="reviewer" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="addReviewer"><fmt:message code="license.add"/></a>\n' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="clearReviewer"><fmt:message code="license.empty"/></a>\n' +
                            '                </div>\n'+
                            '            </div>\n' +

                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                    <div class="layui-form-item layui-form-text">\n' +
                            '                       <label class="layui-form-label"><fmt:message code="license.Borrowing"/>：</label>\n' +
                            '                        <div class="layui-input-inline">\n' +
                            '                            <div id="projectIdsSelect" class="xm-select-demo"></div>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '                <div class="layui-inline" style="margin-left: 60px">\n' +
                            '                    <label class="layui-form-label"><fmt:message code="license.addressee"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" id="recipient" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                            '                    </div>\n' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="addrecipient"><fmt:message code="license.add"/></a>\n' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="clearrecipient"><fmt:message code="license.empty"/></a>\n' +
                            '                </div>\n'+
                            '            </div>\n' +

                            '            <div class="layui-form-item">\n' +
                            '                <div class="layui-inline">\n' +
                            '                  <label class="layui-form-label"><fmt:message code="license.address"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                        <input type="text" name="mailAddress" lay-verify="required|phone" autocomplete="off"\n' +
                            '                               class="layui-input required">\n' +
                            '                    </div>\n' +
                            '            </div>\n' +
                            '                <div class="layui-inline" style="margin-left: 60px">\n' +
                            '                  <label class="layui-form-label"><fmt:message code="license.Reason"/>：</label>\n' +
                            '                    <div class="layui-input-inline">\n' +
                            '                            <textarea class="layui-textarea"  name="useReason"></textarea>\n' +
                            '                    </div>\n' +
                            '            </div>\n' +
                            '            </div>\n' +
                            '        </form>\n' +
                            '    </div>',
                        success: function (res) {
                            //进货人点击添加的按钮
                            $(".addExecute").on("click",function(){
                                user_id = "rescueUser";
                                $.popWindow("/common/selectUser?0");
                            });
                            $('.clearExecute').on("click",function () {
                                $("#rescueUser").val("");
                                $("#rescueUser").attr('username','');
                                $("#rescueUser").attr('dataid','');
                                $("#rescueUser").attr('user_id','');
                                $("#rescueUser").attr('userprivname','');
                            });

                            //审核人
                            $(".addReviewer").on("click",function(){
                                user_id = "reviewer";
                                $.popWindow("/common/selectUser?0");
                            });
                            $('.clearReviewer').on("click",function () {
                                $("#reviewer").val("");
                                $("#reviewer").attr('username','');
                                $("#reviewer").attr('dataid','');
                                $("#reviewer").attr('user_id','');
                                $("#reviewer").attr('userprivname','');
                            });

                            //寄件人
                            $(".addsender").on("click",function(){
                                user_id = "sender";
                                $.popWindow("/common/selectUser?0");
                            });
                            $('.clearsender').on("click",function () {
                                $("#sender").val("");
                                $("#sender").attr('username','');
                                $("#sender").attr('dataid','');
                                $("#sender").attr('user_id','');
                                $("#sender").attr('userprivname','');
                            });

                            //寄件人
                            $(".addrecipient").on("click",function(){
                                user_id = "recipient";
                                $.popWindow("/common/selectUser?0");
                            });
                            $('.clearrecipient').on("click",function () {
                                $("#recipient").val("");
                                $("#recipient").attr('username','');
                                $("#recipient").attr('dataid','');
                                $("#recipient").attr('user_id','');
                                $("#recipient").attr('userprivname','');
                            });
                            // 添加部门信息
                            $(".addDept").on("click", function () {
                                dept_id = "deptNames";
                                $.popWindow("../../common/selectDept?0");
                            });
                            // 清空部门信息
                            $('.clearDept').on("click",function () {
                                $('#deptNames').attr("deptid", "");
                                $('#deptNames').attr("deptno", "");
                                $('#deptNames').attr("deptname", "");
                                $('#deptNames').val("");
                            });
                            //日期
                            laydate.render({
                                elem: '#date'
                                , type: 'datetime'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd HH:mm:ss'
                            });
                            laydate.render({
                                elem: '#creatdate'
                                , type: 'datetime'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd HH:mm:ss'
                            });
                            laydate.render({
                                elem: '#dateofIssue'
                                , type: 'datetime'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd HH:mm:ss'
                            });
                            laydate.render({
                                elem: '#dispatchTime'
                                , type: 'datetime'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd HH:mm:ss'
                            });
                            form.render();
                            $.get('/comlicenseInfo/queryAll', function(res){
                                var data = [];
                                if (res.flag && res.data.length > 0) {
                                    data = res.data;
                                }
                                projectIdsSelect=xmSelect.render({
                                    el: '#projectIdsSelect',
                                    toolbar: {
                                        show: true,
                                    },
                                    filterable: true,
                                    autoRow: true,
                                    prop: {
                                        name: 'licenseName',
                                        value: 'licenseId',
                                    },
                                    data: data
                                });
                                if (type == 0) {
                                    $.ajax({
                                        url: '/comlicenseUse/getDataByLicenseUseId',
                                        dataType: 'json',
                                        type: 'get',
                                        data: {
                                            licenseUseId: licenseUseId
                                        },
                                        success: function (res) {
                                            //审核人
                                            $('#reviewer').val(res.data.reviewerName)
                                            $("#reviewer").attr('user_id',res.data.reviewer+',');
                                            //收件人
                                            $('#recipient').val(res.data.addresseeName)
                                            $("#recipient").attr('user_id',res.data.addressee+',');
                                            //回显 借阅证照
                                            var viewUserTypeArr = (res.data.licenseIds || '').split(',');
                                            projectIdsSelect.setValue(viewUserTypeArr);
                                            form.val("forms", res.data);
                                            form.render()
                                        }

                                    })
                                }
                            });
                        },
                        yes: function (index) {
                            var projectIds = ''
                          // 获取
                          var projectArr = projectIdsSelect.getValue()
                            projectArr.forEach(function (item, index) {
                                projectIds += item.licenseId + ','
                            })
                            var reviewer = $('#reviewer').attr('user_id')  //reviewer
                            var addressee = $('#recipient').attr('user_id')   //recipient
                            var licenseIds = projectIds.substr(0, projectIds.length - 1)
                            if (type == 0) {
                                var url = '/comlicenseUse/approvalStatus'
                                var data = $('#forms').serialize()+ '&reviewer=' + reviewer.substr(0, reviewer.length - 1)+ '&addressee=' + addressee.substr(0, addressee.length - 1)+ '&licenseIds=' + licenseIds+ '&licenseUseId=' + licenseUseId+ '&approvalStatus=1'
                            } else {
                                var url = '/comlicenseUse/updateComlicenseUse'
                                var data = $('#forms').serialize()+ '&reviewer=' + reviewer.substr(0, reviewer.length - 1) + '&addressee=' + addressee.substr(0, addressee.length - 1)+ '&licenseIds=' + licenseIds+ '&licenseUseId=' + licenseUseId+ '&approvalStatus=1'
                            }
                            $.ajax({
                                url: url,
                                dataType: 'json',
                                type: 'get',
                                data: data,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('<fmt:message code="license.modify"/>', {icon: 1});
                                        tableInt.reload()
                                        layer.closeAll();
                                    }
                                }
                            })
                        }
                        ,btn2: function(index, layero){
                            var projectIds = ''
                            // 获取
                            var projectArr = projectIdsSelect.getValue()
                            projectArr.forEach(function (item, index) {
                                projectIds += item.licenseId + ','
                            })
                            var reviewer = $('#reviewer').attr('user_id')
                            var addressee = $('#recipient').attr('user_id')
                            var licenseIds = projectIds.substr(0, projectIds.length - 1)

                            if (type == 0) {
                                var url = '/comlicenseUse/approvalStatus'
                                var data = $('#forms').serialize()  + '&reviewer=' + reviewer.substr(0, reviewer.length - 1)+ '&addressee=' + addressee.substr(0, addressee.length - 1)+ '&licenseIds=' + licenseIds+ '&licenseUseId=' + licenseUseId+ '&approvalStatus=2'
                            } else {
                                var url = '/comlicenseUse/updateComlicenseUse'
                                var data = $('#forms').serialize() + '&reviewer=' + reviewer.substr(0, reviewer.length - 1) + '&addressee=' + addressee.substr(0, addressee.length - 1)+ '&licenseIds=' + licenseIds+ '&licenseUseId=' + licenseUseId+ '&approvalStatus=2'
                            }
                            $.ajax({
                                url: url,
                                dataType: 'json',
                                type: 'get',
                                data: data,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('<fmt:message code="license.modify"/>', {icon: 1});
                                        tableInt.reload()
                                        layer.closeAll();
                                    }
                                }
                            })
                        }
                    })
                }
                //提交人点击添加的按钮
                $(".addsubmitter").on("click",function(){
                    user_id = "submitter";
                    $.popWindow("/common/selectUser?0");
                });
                $('.clearsubmitter').on("click",function () {
                    $("#submitter").val("");
                    $("#submitter").attr('username','');
                    $("#submitter").attr('dataid','');
                    $("#submitter").attr('user_id','');
                    $("#submitter").attr('userprivname','');
                });
                //借阅管理查询
                $('.inquire').on("click",function () {
                    var currentPage = 1;
                    var approvalUser = $('#submitter').attr('user_id')
                    tableInt.reload({
                        url:'/comlicenseUse/getDataByCondition',
                        data: {page: currentPage},
                        page: {
                            curr: currentPage
                        },
                        where: {
                            lendTitle: $('input[name="lendTitle"]').val(),
                            urgency:$('select[name="urgency"]').val() ,
                            approvalStatus:$('select[name="approvalStatus"]').val(),
                            approvalUser:approvalUser.substr(0, approvalUser.length - 1),
                            isAdmin:1
                        }
                    })
                })
            }
        });
    })

    //删除附件
    $(document).on('click', '.deImgs', function () {
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('<fmt:message code="license.del.attach"/>', function (index) {
            // $.ajax({
            //     type: 'get',
            //     url: '/delete?' + attUrl,
            //     dataType: 'json',
            //     success: function (res) {
            //
            //         if (res.flag == true) {
            //             layer.msg('<fmt:message code="license.delsucess"/>', {icon: 6, time: 1000});
            //             $(_this).parent().remove();
            //         } else {
            //             layer.msg('删除失败', {icon: 2, time: 1000});
            //         }
            //     }
            // })
            layer.msg('<fmt:message code="license.delsucess"/>', {icon: 6, time: 1000});
            $(_this).parent().remove();
        });
    });

    //判断参数是否为un\
    function IsUndefined(item) {
        if (item != undefined) {
            return item;
        }
        return '';
    }

</script>
</body>
</html>
