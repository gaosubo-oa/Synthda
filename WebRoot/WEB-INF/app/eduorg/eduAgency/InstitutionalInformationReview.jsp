<%--
  Created by IntelliJ IDEA.
  User: 椰子
  Date: 2022/2/10
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>机构信息审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
    <%--    <script src="//res.layui.com/layui/dist/layui.js" charset="utf-8"></script>--%>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
</head>
<style>
    .openFile input[type=file] {
        position: absolute;
        top: 13px;
        right: 0;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 18px;
        z-index: 99;
        opacity: 0;
    }
    .layui-table-cell{
        height: 40px!important;
    }
    .locality-p {
        height: 40px;
        /*background: #3791DA;*/
        /*color: #fff;*/
        font-size: 18px;
        line-height: 40px;
        /*border-bottom:1px solid #9E9E9E;*/
        display: inline-block;
        padding: 0 10px;
        margin: 10px;
        /*border-radius: 10px;*/
        /*border-right: 1px solid;*/
    }

    /*.content{*/
    /*    height: 100%;*/
    /*}*/
    /* region 上传附件样式 */
    /*.file_upload_box {*/
    /*    position: relative;*/
    /*    height: 22px;*/
    /*    overflow: hidden;*/
    /*}*/

    .open_file {
        float: left;
        position: relative;
    }
    .layui-col-xs4{
        height: 70px;
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
    .imgs{
        position: absolute;
        margin: 2px;
        margin-left: 20px;
    }
    .layui-table th{
        text-align: center!important;
    }
    .operationDiv{
        position: absolute;
        width: 150px;
        border: #ccc 1px solid;
        border-radius: 4px;
        background-color: #ffffff;
        z-index: 99;
    }
    #x1{
        margin-top: 0px!important;
    }
    .layui-table-view{
        width: 100% !important;
    }
    .layui-table-main{
        overflow-x: hidden!important;
    }
    .layui-table-page{
        text-align: right;
    }
    .layui-form-label{
        margin-top: 20px;
        width: 100px;
    }
    .layui-table-view .layui-table td{
        height: 50px;
    }
    .layui-input-inline{
        width: 200px;
        margin-top: 20px;
    }
    .layui-layer-tips{
        z-index: 9999999999 !important;
    }
    .layui-table-cell{
        height: auto;
        overflow: visible;
        text-overflow: inherit;
        white-space: normal;
        word-break: break-word;
    }
</style>
<body>
<div style="margin-left: 20px"><h1 style="margin-top: 20px">机构信息审核</h1></div>
    <div style="margin-top: 20px">
        <div class="layui-form">
            <div class="layui-input-block">
                <div style="display: flex">
                    <div id="book1" style="margin-top: 10px;">
                        <input id="book1" name="radio" title="待审批" type="radio" checked="" value="待审批">
                    </div>
                    <div id="book2" style="margin-top: 10px;">
                        <input id="book2" name="radio" title="同意" type="radio" value="同意">
                    </div>
                    <div id="book3" style="margin-top: 10px">
                        <input id="book3" name="radio" title="不同意" type="radio" value="不同意">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="tableDemo5" lay-filter="tableDemo5"></table>
</body>
<script id="doSth1" type="text/html">
    <div class="long">
        <a id="detail1" class="layui-btn layui-btn-xs" lay-event="detail1">查看</a>&nbsp&nbsp&nbsp
        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">同意</a>&nbsp&nbsp&nbsp
        <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">不同意</a>
    </div>

</script>
<script >
    layui.use(['form', 'table', 'laypage'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var laypage = layui.laypage;
        form.render();


        table.render({
            elem: '#tableDemo5'
            , url: '/EduorgMessage/myOrg'
            , cols: [[
                {field: 'applicant', title: '申请人', align: 'center'},
                {field: 'orgName', title: '机构简称', align: 'center'},
                {field: 'changeType', title: '变更类型', align: 'center',templet: function (d) {
                    if(d.changeType=='1'){
                        return '基本信息'
                    }else if(d.changeType=='2'){
                        return '办园信息'
                    }

                    }},
                {field: 'changes', title: '变更事项', align: 'center'},
                {field: 'beforeChange', title: '变更前', align: 'center'},
                {field: 'afterChange', title: '变更后', align: 'center'},
                {field: 'submissionTime', title: '提交时间', align: 'center'},
                {field: 'auditTime', title: '审核时间', align: 'center'},
                {field: 'auditStatus', title: '审核状态', align: 'center',templet: function (d) {
                        if(d.auditStatus=='0'){
                            return '待审批'
                        }else if(d.auditStatus=='1'){
                            return '同意'
                        }else if(d.auditStatus=='2'){
                            return '不同意'
                        }
                    }},
                {field: 'auditDesc', title: '审核意见', align: 'center'},
                {title: '操作', toolbar: '#doSth1', minWidth: 200, align: 'center'},
            ]],
            page: true,
            limit: 10
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0,
                    "count": res.totleNum,
                    "data": res.obj //解析数据列表
                };
            }
        });
    })
</script>
</html>
