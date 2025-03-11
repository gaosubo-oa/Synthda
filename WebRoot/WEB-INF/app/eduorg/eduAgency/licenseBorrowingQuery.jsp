
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>证照借阅查询</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
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
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    .layui-table-body{overflow-x: hidden;}
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .zxc {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }
    .layui-form-select{
        width: 200px!important;
    }

    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 35px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-unselect{
        width: 350px;
    }
    .layui-input{
        width: 200px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
</style>
<body>
<div style="margin-top: 20px">
    <div>
        <span class="zxc">证照借阅查询</span>
    </div>
    <form class="layui-form" action="">
        <div>
            <div class="layui-inline">
                <label class="layui-form-label">借阅标题</label>
                <div class="layui-input-inline">
                    <input  style="width: 200px" id="borrowSubject" name="borrowSubject" class="layui-input" type="text">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">借阅时间</label>
                <div class="layui-input-inline">
                    <input  style="width: 200px" id="borrowTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="borrowTime" class="layui-input" type="text">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label" >审批状态</label>
                <div class="layui-input-inline">
                    <select  style="width: 200px" id="approveStatus" name="approveStatus" lay-verify="approveStatus">
                        <option value="" class="layui-this">请选择</option>
                        <option value="3">未提交</option>
                        <option value="0">待审批</option>
                        <option value="1" >同意</option>
                        <option value="2" >不同意</option>
                    </select>
                </div>
            </div>
            &nbsp&nbsp&nbsp&nbsp&nbsp
            <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>
        </div>


    </form>

    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<script id="barDemo" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
    </div>

</script>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
    </div>

</script>

</body>
<script>

    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()

        var el;
        $("[name='orgDeptId']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                $.get('/orgDepartment/queryByDepIdList?deptId=0', function (res) {
                    //layer.close(loadingIndex);
                    if (res.flag) {
                        el = layui.eleTree.render({
                            elem: '.ele2',
                            data: res.obj,
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine: true,
                            showCheckbox: false,
                            checked: false,
                            lazy: true,
                            //defaultExpandAll: false,
                            request: {
                                name: 'orgDeptName',
                                id:'orgDeptId',
                                isLeaf:false
                                //children: "plbProjList",
                            },
                            load: function(data,callback) {
                                $.post('/orgDepartment/queryByDepIdList?deptId='+data.deptId,function (res) {
                                    callback(res.obj);//点击节点回调
                                })
                            },
                            done: function(res){
                                if(res.data.length == 0){
                                    $(".ele2").html('<div style="text-align: center">暂无数据</div>');
                                }
                            }
                        });

                    }
                });
            }
            $(".ele2").slideDown();
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        //节点点击事件
        layui.eleTree.on("nodeClick(data2)",function(d) {
            var parData1 = d.data.currentData;
            $("[name='orgDeptId']").val(parData1.deptName);
            $("#orgDeptName").attr("pid",parData1.deptId);
        })

        $('#search').click(function () {
            var approveStatus = $("#approveStatus").val()
            var borrowTime = $("#borrowTime").val()
            var borrowSubject = $("#borrowSubject").val()
            table.render({
                elem: '#test1'
                , url:'/EduorgBorrow/selectAll?borrowSubject='+borrowSubject+'&borrowTime='+borrowTime+'&approveStatus='+approveStatus
                ,cols:[[
                    {field:'borrowSubject',title:'借阅主题',align:'center'},
                    {field:'applicant',title:'申请人',align:'center'},
                    {field:'applicanDept',title:'申请人所在部门',align:'center'},
                    {field:'borrowReason',title:'借阅理由',align:'center'},
                    {field:'borrowTime',title:'借阅时间',align:'center'},
                    {field:'returnTime',title:'计划归还时间',align:'center'},
                    {field:'approver',title:'审批人',align:'center'},
                    {field:'approveStatus',title:'审批状态',align:'center'},
                    {field: 'approverComment', title: '审批人意见', },
                    {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
                ]],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
            });
        });

        
        var meetTable=table.render({
            elem: '#test1'
            , url: '/EduorgBorrow/selectAll?pageSize='+'10'+'&useflag='+true
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field:'borrowSubject',title:'借阅主题',align:'center'},
                {field:'applicant',title:'申请人',align:'center'},
                {field:'applicanDept',title:'申请人所在部门',align:'center'},
                {field:'borrowReason',title:'借阅理由',align:'center'},
                {field:'borrowTime',title:'借阅时间',align:'center'},
                {field:'returnTime',title:'计划归还时间',align:'center'},
                {field:'approver',title:'审批人',align:'center'},
                {field:'approveStatus',title:'审批状态',align:'center'},
                {field: 'approverComment', title: '审批人意见', },
                {title:'操作',toolbar:'#barDemos',minWidth:200,align:'center'},
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
        })


        $(document).on("click", "#people1", function () {
            org_id="people1";
            $.popWindow("../common/selectPartyMember?0");
        })


        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            layer.open({
                type: 1
                , title: '查看'
                , area: ['70%', '80%'],
                content: '<div class="layui-tab-item layui-show">\n' +
                    '                <span class="asd">证照借阅</span>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">借阅机构</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled" id="borrowOragn4" name="borrowOragn4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">借阅证件</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  id="licenceId" name="licenceId" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  id="borrowTime4" name="borrowTime4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">计划归还时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  id="returnTime" name="returnTime" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                    '                            <label class="layui-form-label">申请人</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  id="applicant4" name="applicant4" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-inline" style="margin-left: 10%">\n' +
                    '                            <label class="layui-form-label">申请人所在部门</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  id="applicanDept" name="applicanDept" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div>\n' +
                    '                    <form class="layui-form" action="">\n' +
                    '                        <label class="layui-form-label" style="margin-left: 5%">借阅理由</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <textarea disabled="disabled"  id="borrowReason" name="borrowReason" class="layui-textarea" placeholder="请输入内容" style="width:500px">请输入内容</textarea>\n' +
                    '                        </div>\n' +
                    '                    </form></div>\n' +
                    '                <div style="margin-top: 30px;text-align: center">\n' +
                    '                    <button class="layui-btn" id="return" type="button">返回</button>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-tab-item two">\n' +
                    '                <div>\n' +
                    '                    <span class="zxc">我的借阅</span>\n' +
                    '                </div>\n' +
                    '                <form class="layui-form" action="">\n' +
                    '                    <div>\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅标题</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  style="width: 200px" id="borrowSubject" name="borrowSubject" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label">借阅时间</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <input disabled="disabled"  style="width: 200px" id="borrowTime" name="borrowTime" class="layui-input" type="text">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '\n' +
                    '                        <div class="layui-inline">\n' +
                    '                            <label class="layui-form-label" >审批状态</label>\n' +
                    '                            <div class="layui-input-inline">\n' +
                    '                                <select disabled="disabled"  style="width: 200px" id="approveStatus" name="approveStatus" lay-verify="orgDeptId">\n' +
                    '                                    <option value="" class="layui-this">请选择</option>\n' +
                    '                                </select>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        &nbsp&nbsp&nbsp&nbsp&nbsp\n' +
                    '                        <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>\n' +
                    '                    </div>\n' +
                    '\n' +
                    '\n' +
                    '                </form>\n' +
                    '\n' +
                    '                <table class="layui-hide" id="test1" lay-filter="test1"></table>\n' +
                    '            </div>\n' +
                    '        </div>'
                ,
                success: function () {
                    $("#return").click(function() {
                        layer.closeAll();
                    })

                    $.ajax({
                        type: 'post',
                        url: '/EduorgBorrow/selectById',
                        dataType: 'json',
                        data:{
                            borrowId:data.borrowId
                        },
                        success: function (json) {
                            if(json.flag){
                                $('#returnTime').val(json.object.returnTime);
                                $('#applicant4').val(json.object.applicant);
                                $('#borrowTime4').val(json.object.borrowTime);
                                $('#borrowReason').val(json.object.borrowReason);
                                $('#approver').val(json.object.approver);
                                $('#applicanDept').val(json.object.applicanDept);
                                $('#borrowOragn4').val(json.object.borrowOragn);
                                $('#licenceId').val(json.object.licenceId);
                                $('#licenceId').val(json.object.licenceName);
                                $('#borrowSubject').val(json.object.borrowSubject);
                                form.render();
                            }
                        }
                    })

                    form.render()
                },


            })

        })


    });


</script>
</html>
