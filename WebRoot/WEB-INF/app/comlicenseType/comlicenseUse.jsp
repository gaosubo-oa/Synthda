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

    <title><fmt:message code="license.borrowing"/></title>
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
    <script type="text/javascript" src="../js/email/fileuploadPlus.js?20230529.2"></script>
    <script src="/js/base/base.js"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
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


        .layui-input-block textarea {
            border-color: #e6e6e6;
        }

        .layui-form-label {
            width: 113px;
        }
        .btn{
            vertical-align: inherit;
            height: 38px;
        }
        #questionTable{
            margin-top: -20px;
        }
        .addsubmitter,.addrecipient,.addReviewer{
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
        <img src="/img/infomater.png" alt="" style="margin: 4 5px 0 20px;"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;"><fmt:message code="license.borrowing"/></span>
    </div>
    <hr class="layui-bg-blue">
    <form class="layui-form" action="">
        <div class="layui-form-item" style="display: inline-block;">
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
                        <option value=""><fmt:message code="license.PleaseSelect"/></option>
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
                        <option value=""><fmt:message code="license.PleaseSelect"/></option>
                        <option value="0"><fmt:message code="license.Unapproved"/></option>
                        <option value="1"><fmt:message code="license.Approved"/></option>
                        <option value="2"><fmt:message code="license.not.approved"/></option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-normal inquire" style="margin-top: -5px"><fmt:message code="license.query"/></button>
            <button type="button" class="layui-btn creatAdd" style="margin-top: -5px;margin-left: 20px"><fmt:message code="license.new"/></button>
        </div>
    </form>
    <table id="tableList" lay-filter="tableList" style="margin-top: -18px"></table>
</div>


<script type="text/html" id="barlistDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="license.edit"/></a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
</script>


<script type="text/javascript">

    layui.use(['table', 'form','laydate','xmSelect'], function () {
        var table = layui.table,
            form = layui.form,
            xmSelect = layui.xmSelect,
            laydate = layui.laydate;
        form.render()
        var tableInt = table.render({
            elem: '#tableList',
            url: '/comlicenseUse/getDataByCondition',
            page: true,
            where:{
                isAdmin:0
            },
            // toolbar: '#toolbarDemo',
            defaultToolbar: [''],
            cols: [[
                {field: 'lendTitle', title: '<fmt:message code="license.Borrowing.Title"/>'},
                {field: 'approvalName', title: '<fmt:message code="license.applicant"/>'},
                {field: 'approvalDeptName', title: '<fmt:message code="license.Applicant.department"/>'},
                {field: 'customer', title: '<fmt:message code="license.Customer.Name"/>'},
                {
                    field: 'urgency', title: '<fmt:message code="license.Urgent.level"/>', templet: function (d) {
                        if (d.urgency == "0") {
                            return '<fmt:message code="license.Normal"/>'
                        } else if (d.urgency == "1") {
                            return '<fmt:message code="license.Urgent"/>'
                        }else if (d.urgency == "2") {
                            return '<fmt:message code="license.Very.urgent"/>'
                        }
                    }
                },
                {field: 'approvalStatus', title: '<fmt:message code="license.Audit.status"/>',templet: function (d) {
                        if (d.approvalStatus == "0") {
                            return '<fmt:message code="license.Unapproved"/>'
                        } else if (d.approvalStatus == "1") {
                            return '<fmt:message code="license.Approved"/>'
                        } else if (d.approvalStatus == "2") {
                            return '<fmt:message code="license.not.approved"/>'
                        }
                    }},
                {field: 'licenseNames', title: '<fmt:message code="license.Borrowing"/>',templet: function (d) {
                        var licenseNames = d.licenseNames
                        var projectIds = ''
                        if(licenseNames != undefined){
                            licenseNames.forEach(function (item, index) {
                                projectIds += item+ '，'
                            })
                            return projectIds.substr(0,projectIds.length-1)
                        }else{
                            return ''
                        }

                    }},
                {fixed: 'right', title: '<fmt:message code="license.operation"/>',templet:function(d) {
                        if(d.approvalStatus == "1") {
                            return ' <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>'
                        }else {
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="license.edit"/></a>\n' +
                                '    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>'
                        }
                    }}
            ]],
            parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.data,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                }
            },
        });
        //  新建
        $(document).on('click','.creatAdd',function () {
            creatAdd(0)
        })
        /*新建和编辑的方法*/
        function creatAdd(type,licenseUseId) {
            var projectIdsSelect = null;
            if (type == '0') {
                var title = '<fmt:message code="license.new"/>';
            } else {
                var title = '<fmt:message code="license.edit"/>';
            }
            layer.open({
                type: 1,
                title: title,
                btn: ['<fmt:message code="license.Submit"/>', '<fmt:message code="license.return"/>'],
                shade: 0.5,
                area: ['80%', '90%'],
                content: '<div id="cont" style="margin: 10px">\n' +
                    '        <form class="layui-form" action="" id="forms" lay-filter="ajaxforms">\n' +
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
                    '                    <label class="layui-form-label"><fmt:message code="license.addressee"/>：</label>\n' +
                    '                    <div class="layui-input-inline">\n' +
                    '                        <input type="text" id="recipient" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>\n' +
                    '                    </div>\n' +
                    '                    <a href="javascript:;" style="color:#1E9FFF" class="addrecipient"><fmt:message code="license.add"/></a>\n' +
                    '                    <a href="javascript:;" style="color:#1E9FFF" class="clearrecipient"><fmt:message code="license.empty"/></a>\n' +
                    '                </div>\n'+
                    // '                <div class="layui-inline" style="margin-left: 60px">\n' +
                    // '                    <label class="layui-form-label">实际归还时间：</label>\n' +
                    // '                    <div class="layui-input-inline">\n' +
                    // '                        <input type="text" name="realReturnTime" id="dateofIssue" lay-verify="date"\n' +
                    // '                               autocomplete="off" class="layui-input required">\n' +
                    // '                    </div>\n' +
                    // '                </div>\n' +
                    '            </div>\n' +

                    '            <div class="layui-form-item">\n' +
                    '                <div class="layui-inline" >\n' +
                    '                    <div class="layui-form-item layui-form-text">\n' +
                    '                       <label class="layui-form-label"><fmt:message code="license.Borrowing"/>：</label>\n' +
                    '                        <div class="layui-input-inline">\n' +
                    '                            <div id="projectIdsSelect" class="xm-select-demo"></div>\n' +
                    '                        </div>\n' +
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
                            // model: {
                            //     label: {
                            //         block: {
                            //             template: function (item, sels) {
                            //                 return '<span style="max-width: 70px; overflow: hidden;"  title="' + item.licenseName + '" value="'+item.licenseId+'">' + item.licenseName + '</span>';
                            //             }
                            //         }
                            //     }
                            // },
                            data: data
                        });
                        if (type == 1) {
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
                                    form.val("ajaxforms", res.data);
                                }

                            })
                        }
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
                    //日期
                    laydate.render({
                        elem: '#date'
                        ,type:'datetime'
                        ,trigger: 'click'//呼出事件改成click
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                    });
                    laydate.render({
                        elem: '#creatdate'
                        ,type:'datetime'
                        ,trigger: 'click'//呼出事件改成click
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                    });
                    laydate.render({
                        elem: '#dateofIssue'
                        ,type:'datetime'
                        ,trigger: 'click'//呼出事件改成click
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                    });
                    form.render();

                },
                yes: function (index) {
                    var projectIds = ''
                    // 获取
                    var projectArr = projectIdsSelect.getValue()
                    projectArr.forEach(function (item, index) {
                        projectIds += item.licenseId + ','
                    })
                    var licenseIds = projectIds.substr(0, projectIds.length - 1)
                    var reviewer= $('#reviewer').attr('user_id')
                    var addressee= $('#recipient').attr('user_id')

                    if (type == 0) {
                        var url = '/comlicenseUse/addComlicenseUse'
                        var data = $('#forms').serialize()+'&reviewer='+reviewer.substr(0,reviewer.length-1)+'&addressee='+addressee.substr(0,addressee.length-1)+ '&licenseIds=' + licenseIds+'&approvalStatus=0'
                    } else {
                        var url = '/comlicenseUse/updateComlicenseUse'
                        var data = $('#forms').serialize()+'&reviewer='+reviewer.substr(0,reviewer.length-1)+'&addressee='+addressee.substr(0,addressee.length-1)+'&licenseUseId='+licenseUseId+ '&licenseIds=' + licenseIds
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

        //审核和同意和删除
        table.on('tool(tableList)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var licenseUseId = data.licenseUseId   //获取当前行得id
            if (layEvent === 'edit') {
                creatAdd(1,licenseUseId)
            } else if (layEvent === 'del') {
                layer.confirm('真的删除该数据吗？', function (index) {
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
            }
        });
        //借阅管理查询
        $('.inquire').on("click",function(){
            var currentPage = 1;
            var approvalUser = $('#submitter').attr('user_id')
            tableInt.reload({
                data: {page: currentPage},
                page: {
                    curr: currentPage
                },
                where: {
                    lendTitle: $('input[name="lendTitle"]').val(),
                    urgency:$('select[name="urgency"]').val() ,
                    approvalStatus:$('select[name="approvalStatus"]').val(),
                    isAdmin:0
                }
            })
        })
    });

</script>
</body>
</html>
