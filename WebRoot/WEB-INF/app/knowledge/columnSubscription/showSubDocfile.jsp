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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>查看客户下载/浏览文档记录</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>
    <style>
        body, html {
            background-color: #fff;
        }
        .eleTree-node-content-label {
            display: inline-block;
            width: 99% !important;
        }

        .ele1 div.eleTree-node:nth-child(1) {
            overflow: hidden;
        }

        #formBox .layui-form-item {
            width:49.5%;
            margin-top: 10px;
            margin-bottom: 10px;
            margin-bottom: 5px;
        }
        #formBox .layui-form-item .layui-inline{
            width:100%;
        }
        #formBox .layui-form-item  .layui-form-label{
            width:29%;
        }
        #formBox .layui-form-item  .layui-input-inline {
            width:60%;
        }
    </style>
</head>
<body>
<div class="main" style="padding: 20px 20px;background-color: #fff;">
<%--    <div>--%>
<%--        <form class="layui-form" id="formBox" action="" lay-filter="formTest">--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">企业名称</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" disabled id="companyName" name="companyName" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">机构代码</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" disabled id="companyCode" name="companyCode" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">联系人</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" id="contactUser" disabled readonly placeholder="请选择" name="contactUser"--%>
<%--                               autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">联系电话</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" disabled id="contactPhone" name="contactPhone" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">企业性质</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <select name="companyNatrue" disabled id="companyNatrue"></select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">权限类别</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <select id="privType" disabled name="privType">--%>
<%--                            <option value="">请选择</option>--%>
<%--                            <option value="0">浏览</option>--%>
<%--                            <option value="1">下载</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block">--%>
<%--                <label class="layui-form-label">父级栏目</label>--%>
<%--                <div class="layui-input-inline" id="parentColumnId" style="position: relative">--%>
<%--                    <input type="text" id="pele" disabled pid name="ttitle" required="" style="cursor: pointer"--%>
<%--                            lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">--%>
<%--                    <div class="eleTree ele1" lay-filter="data1"--%>
<%--                         style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item" style="display: inline-block;float: right;margin-right: 15px;">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">备注</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" disabled id="memo" name="memo" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
    <div>
        <%--表格内容--%>
        <table id="allDocfile" lay-filter="allDocfile"></table>
    </div>
</div>
<script type="text/html" id="toolBar">

</script>
<script type="text/javascript">
    // 获取地址栏参数值
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    var userId = getQueryString('userId')
    var customerName = getQueryString('customerName')

    layui.use(['laydate', 'table', 'layer', 'form', 'eleTree', 'element'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , laydate = layui.laydate
            , element = layui.element
            , eleTree = layui.eleTree
            , table = layui.table;
        var tabInit;
        if(userId!=undefined&&userId!=''){
            tabInit = table.render({
                elem: '#allDocfile'
                ,toolbar: '#toolBar' //开启头部工具栏占位
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,url:'/client/getLogByUserId?userId='+userId+'&customerName='+customerName
                , cols: [[ //表头
                    {field: 'logId', title: 'ID'}
                    , {field: 'customerName', title: '客户名称'}
                    //, {field: 'docfileNo', title: '文档编号'}
                    , {field: 'docfileName', title: '文档名称'}
                    , {field: 'useType', title: '操作类型'}
                    , {field: 'useTime', title: '操作时间'}
                    //,{width:200, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                ,page: true
            });
         }
        //else{
        //     tabInit = table.render({
        //         elem: '#allDocfile'
        //         ,data:[]
        //         ,defaultToolbar: ['filter', 'exports', 'print', {
        //             title: '提示'
        //             ,layEvent: 'LAYTABLE_TIPS'
        //             ,icon: 'layui-icon-tips'
        //         }]
        //         ,cols: [[
        //             {field:'subscribeId', title:'序号'}
        //             ,{field:'customerName', title:'客户名称'}
        //             ,{field:'docfileName', title:'文档名称'}
        //             ,{field:'status', title:'订阅审核状态',templet:function(d){
        //                     if(d.status!=undefined){
        //                         if(d.status==0||d.status=='0'){
        //                             return "同意"
        //                         }else if(d.status==1||d.status=='1'){
        //                             return "不同意"
        //                         }else if(d.status==3||d.status=='3'){
        //                             return "待审批"
        //                         }else{
        //                             return '';
        //                         }
        //                     }else{
        //                         return '';
        //                     }
        //                 }}
        //             ,{field:'subscribeUser', title:'订阅用户'}
        //             ,{field:'subscribeTime', title:'订阅时间'}
        //             ,{field:'memo', title:'备注'}
        //         ]]
        //         ,page: true
        //     });
        // }

        // //加载一级栏目
        // $.ajax({
        //     url: '/knowledge/getKnowledgeType',
        //     dataType: 'json',
        //     type: 'post',
        //     async: false,
        //     data: {parentColumnId: 0},
        //     success: function (res) {
        //         var $select1 = $("select[name='companyNatrue']");
        //         var optionStr = '<option value="">请选择</option>';
        //         $.ajax({ //查询文档等级
        //             url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
        //             type: 'get',
        //             dataType: 'json',
        //             async: false,
        //             success: function (res) {
        //                 if (res.obj != undefined && res.obj.length > 0) {
        //                     for (var i = 0; i < res.obj.length; i++) {
        //                         optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
        //                     }
        //                 }
        //             }
        //         })
        //         $select1.html(optionStr);
        //         form.render();//初始化表单
        //         $.ajax({
        //             url: '/client/getCustomerById',
        //             dataType: 'json',
        //             type: 'post',
        //             async: false,
        //             data: {
        //                 customerId: customerId
        //             },
        //             success: function (res) {
        //                 var data = res.object
        //                 form.val("formTest", data)
        //                 $('input').attr("disabled", "disabled")
        //                 $('select').attr("disabled", "disabled")
        //                 form.render()
        //             }
        //         })
        //     }
        // })
        // var el;
        // $("[name='ttitle']").on("click", function (e) {
        //     e.stopPropagation();
        //     if (!el) {
        //         el = eleTree.render({
        //             elem: '.ele1',
        //             url: '/knowledge/childTree',
        //             expandOnClickNode: false,
        //             highlightCurrent: true,
        //             showLine: true,
        //             showCheckbox: true,
        //         });
        //     }
        //     $(".ele1").slideDown();
        // })
        // eleTree.on("nodeClick(data1)", function (d) {
        //     $("[name='ttitle']").val(d.data.currentData.label)
        //     $("#pele").attr("pid", d.data.currentData.id)
        //     PcolumnId = d.data.currentData.id;
        //     $(".ele1").slideUp();
        // })
        // $(document).on("click", function () {
        //     $(".ele1").slideUp();
        // })
    });
</script>
</body>
</html>