<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/12/24
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待办列表</title>
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
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>

    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
<%--    <script type="text/javascript" src="/js/gapp/ming.js?20211208.5"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
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

    #test3 {
        margin-left: 68px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 30px;
        display: block;
        margin-right: 10px;
        margin-bottom: 50px;
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


    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
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
        width: 680px;
        position: relative;
    }
    .top li{
        display: inline-block;
        padding-left: 10px;
        padding-right: 10px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        cursor:pointer;
    }
    .top li:hover{
        color: rgb(16,127,255);
    }
    .tops li{
        display: inline-block;
        line-height: 50px;
    }
    .layui-layer-content{
        background-color: rgb(248,248,248);
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
    .bian:hover{
        border: 1px solid rgb(64,169,255);
    }
    .title{
        color: #107fff;
        cursor:pointer!important;
    }
    .row{
        margin-top: 80px;
    }
    .img{
        width: 20%;
        text-align: center;
    }
    .ji li{
        margin-top: 10px;
    }
    .lian li{
        margin-top: 10px;
    }
    .fadeInRight {
        animation-name: fadeInRight;
        -webkit-animation: fadeInRight;
    }
    .jiben li{
        display: inline-block;
        color: #8893a7;
        font-size: 14px;
        font-weight: 400!important;
        width: 60px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        border-radius: 4px;
        cursor:pointer;
    }
    .jiben li:hover{
        background-color: rgb(234,237,241);
    }
</style>
<body>
<div id="box">
    <form class="layui-form" action="">
    <div class="box2">
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <div class="layui-tab-content">
            <ul class="top">
                <li style="background-color: rgb(16,127,255);color: white;border-radius: 3px" class="layui-icon layui-icon-add-1" id="add">新增</li>
                <li class="layui-icon layui-icon-download-circle" id="import">导入</li>
                <li class="layui-icon layui-icon-export">导出</li>
                <li class="layui-icon layui-icon-delete" id="del">删除</li>
                <li class="layui-icon layui-icon-print" id="dayin">打印二维码</li>
                <li class="layui-icon layui-icon-template">统计分析</li>
                <li style="float: right">列表</li>
                <li style="float: right">全部</li>
            </ul>
            <ul class="tops" style="height: 50px;margin-top: 20px">

                    <li style="width: 33%">
                        <div class="layui-form-item" >
                            <div class="layui-inline" style="width: 100%;margin-right: 0;">
                                <label class="layui-form-label" style="font-size: 14px;width: 100px">合同类型</label>
                                <div class="layui-input-inline" style="width:70%">
                                    <%--                                <input type="text" name="orderNo1"  lay-verify="required|phone" autocomplete="off" class="layui-input">--%>
<%--                                    <select name="parentGtypeIds" id="parentGtypeIds" class="oneDayPerDiem bian">--%>

<%--                                    </select>--%>
                                        <div id="parentGtypeIds" class=""></div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li style="width: 33%">
                        <div class="layui-form-item" >
                            <div class="layui-inline" style="width: 100%;margin-right: 0;">
                                <label class="layui-form-label" style="font-size: 14px;width:100px">范本名称</label>
                                <div class="layui-input-inline" style="width:70%">
                                    <input type="text" name="orderNo2"  lay-verify="required|phone" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li style="width: 33%">
                        <div class="layui-form-item" >
                            <div class="layui-inline" style="width: 100%;margin-right: 0;">
                                <label class="layui-form-label" style="font-size: 14px;width: 100px">范本编号</label>
                                <div class="layui-input-inline" style="width:70%">
                                    <input type="text" name="orderNo3"  lay-verify="required|phone" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </li>

            </ul>
                <table class="layui-hide" id="test" lay-filter="test"></table>
            </div>

        </div>
    </div>
    </form>
</div>
<div class="boxs fadeInRight" style="width: 70%;height: 90%;background-color: white;position: absolute;right: 0;bottom: 0;box-shadow: 1px 1px 16px 5px #c0b9b9;display: none">
    <div class="row">
        <div class="img" style="display: inline-block;float: left">
            <img src="../img/email/icon_head_man_06.png" alt="">
            <h4 class="name1" style="font-size: 18px;margin-top: 10px;"></h4>
        </div>
        <div class="right" style="display:inline-block;width: 75%">
            <div class="layui-tab">
                <ul class="layui-tab-title">
                    <li class="layui-this">基本信息</li>
                    <li>联系方式</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show ji">
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">姓名</span><div style="width: 90%;display: inline-block"><input type="text" style="" name="name"  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">员工工号</span><div style="width: 90%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">用户描述</span><div style="width: 90%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">性别</span><div style="width: 90%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                    </div>
                    <div class="layui-tab-item lian">
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">电子邮件</span><div style="width: 90%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">手机号码</span><div style="width: 90%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script id="barDemo" type="text/html">
    <div class="long">
        <a id="detail" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
        <a lay-event="edit" id="edit" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>
        <a lay-event="del" id="delete" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>

</script>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
    </div>

</script>

</body>
<script>
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var upload = layui.upload;
        var sum=0;
        var tableData = [
            {
                "A": "1",
                "B": "人力资源服务合同 D35263",
                "C": "C",
                "D": "人力资源服务合同",
                "E": "D35263",
                "F": "131****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "2",
                "B": "新奥尔良租凭合同 AS1749058",
                "C": "A",
                "D": "新奥尔良租凭合同",
                "E": "AS1749058",
                "F": "133****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "3",
                "B": "奥来克产品采购合同 CG001",
                "C": "B",
                "D": "奥来克产品采购合同",
                "E": "CG001",
                "F": "149****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "4",
                "B": "中外合作公司合同 HZ0009",
                "C": "C",
                "D": "中外合作公司合同",
                "E": "HZ0009",
                "F": "134****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "5",
                "B": "成都信息科技劳务合同 X197403",
                "C": "C",
                "D": "成都信息科技劳务合同",
                "E": "X197403",
                "F": "139****2819",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束",
                "I": " 已结束"
            }
        ];

//固定列二维数组
        var col = [[
            {type:'checkbox'}
            // ,{field: "name", title: "序号"}
            // , {field: "age", title: "数据标题"}
            // , {field: "class", title: "合同类型"}
        ]];
//动态列
        var subjectField = ["A", "B", "C","D",'E','F','G','H','I'];
        var subjectTitle = ["序号", "数据标题", "合同类型","范本名称","范本编号","创建人","创建时间","流程状态",'aaa'];

//给tableData动态添加数据
//         for (var i = 0; i < subjectField.length; ++i) {
//             for (var j = 0; j < tableData.length; ++j) {
//                 tableData[j][subjectField[i]] = Math.floor((Math.random()*100)+1);
//             }
//         }

//动态添加列属性
        for (var i = 0; i < subjectField.length; ++i) {
            //向数组插入元素：splice(index, howmany, items...)
            //index要插入的位置
            //howmany从该位置删除多少项元素
            //items要插入的元素
            //col[0],注意col是二维数组
            col[0].splice(col[0].length, 0, {field: subjectField[i], title: subjectTitle[i]});
        }
        // var data = json.data
        xmSelect.render({
            el: '#parentGtypeIds',
            toolbar:{
                show: true,
            },
            filterable: true,
            height: '500px',
            data: [
                // {name: '销售员', children: [
                //         {name: '张三1', value: 1, selected: true},
                //         {name: '李四1', value: 2, selected: true},
                //         {name: '王五1', value: 3, disabled: true},
                // ]},
                {name: '合同类型', children: [
                        {name: 'A', value: 1,},
                        {name: 'B', value: 2,},
                        {name: 'C', value: 3,},
                 ]},
            ]

        });
        form.render()
        // 支委会会议记录表格
        var meetTable=table.render({
            elem: '#test'
            , url: '/branchCommitteeMeeting/queryList'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: col
            //     [[
            //     {type:'checkbox'}
            //     ,{field: 'A', title: '序号', sort:true, width:90}
            //     ,{field: 'B', title: '数据标题',  sort:true,minWidth:430,event:'shu'}
            //     , {field: 'C', title: '合同类型',  sort:true, width:117}
            //     , {field: 'D', title: '范本名称',  sort:true,minWidth:430}
            //     , {field: 'E', title: '范本编号', sort:true}
            //     , {field: 'F', title: '创建人',  sort:true,event:'creatUser'}
            //     , {field: 'G', title: '创建时间', sort:true}
            //     , {field: 'H', title: '流程状态', sort:true}
            //     , {field: 'I', title: '流程状态', sort:true}
            // ]]
            , parseData: function (res) { //res 即为原始返回的数据
                // var data = json.obj
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": tableData, //解析数据列表
                };
            }
            ,done:function(res){
                $("td[data-field='B']").addClass("title")
                $("td[data-field='B']").attr('lay-event','shu')
                $("td[data-field='F']").addClass("title")
                $("td[data-field='F']").attr('lay-event','creatUser')
            }
            , page: true
        })
        table.on('checkbox(test)',function(res){
            sum = (layui.table.checkStatus('test').data).length
        })
        table.on('tool(test)',function(res){
            var F = res.data.F
            var data = res.data
            if (res.event == 'shu'){
                layer.open({
                    anim:1,
                    type: 1,
                    area: ['60%', '100%'], //宽高
                    title: ['合同范本','font-size:18px;font-weight:bold'],
                    maxmin: false,
                    offset: 'rt',
                    btn: ['取&nbsp&nbsp消','确&nbsp&nbsp定'], //可以无限个按钮
                    content: '<div style="margin: 30px auto;">' +
                        '       <span class="jiben" style="font-size: 16px;font-weight: bold;margin-left: 20px;display: inline-block;width: 96%;border-bottom: 1px solid rgb(224,227,233);height:35px">基本信息' +
                        '       <div style="display: inline-block;float: right"><li class="layui-icon layui-icon-edit" id="edits">编辑</li>\n' +
                        '       <li class="layui-icon layui-icon-print" id="porints">打印</li>\n' +
                        '       <li class="layui-icon layui-icon-delete" id="dels">删除</li>\n' +
                        '       <li class="layui-icon layui-icon-print" id="QRcode">二维码</li></div>\n' +
                        '</span>\n' +

                        '       <form class="layui-form" action="">\n' +
                        '           <div class="layui-form-item" style="width: 45%;margin-left: 20px;display: inline-block">\n' +
                        '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '                   <p style="font-size: 14px;margin-bottom: 8px;">合同类型</p>\n' +
                        '                   <div class="layui-input-inline" style="width:90%">\n' +
                        '                       <select name="parentGtypeId" disabled id="parentGtypeId" class="oneDayPerDiem bian">\n' +
                        '                           <option value="A">A</option>\n' +
                        '                           <option value="B">B</option>\n' +
                        '                           <option value="C">C</option>\n' +
                        '                       </select>\n' +
                        '                   </div>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '           <div class="layui-form-item" style="width: 45%;display: inline-block;margin-left: 20px;">\n' +
                        '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '                   <p style="font-size: 14px;margin-bottom: 8px;">范本名称</p>\n' +
                        '                   <div class="layui-input-inline" style="width:90%">\n' +
                        '                       <input type="text" placeholder="请输入" id="orderNo" disabled name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input bian">\n' +
                        '                   </div>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '           <div class="layui-form-item" style="width: 45%;display: inline-block;margin-left: 20px;">\n' +
                        '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '                   <p style="font-size: 14px;margin-bottom: 8px;">范本编号</p>\n' +
                        '                   <div class="layui-input-inline" style="width:90%">\n' +
                        '                       <input type="text" placeholder="请输入" disabled name="typeName" id="typeName" lay-verify="required|phone" autocomplete="off" class="layui-input bian">\n' +
                        '                   </div>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '           <div class="layui-form-item" style="margin-left: 20px;">\n' +
                        '               <div class="layui-inline">\n' +
                        '                   <p>附件</p>\n' +
                        '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                        '                      <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                        '                      <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                          <img src="../img/mg11.png" alt="">\n' +
                        '                          <span>添加附件</span>\n' +
                        '                          <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                        '                      </a>\n' +
                        '                   </div>' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '           <div class="layui-form-item" style="width: 96%;display: inline-block;margin-left: 20px;">\n' +
                        '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '                   <p style="font-size: 14px;margin-bottom: 8px;">备注</p>\n' +
                        '                   <div class="layui-input-inline" style="width:90%">\n' +
                        '                       <textarea style="height: 70px;" placeholder="请输入" disabled type="text" id="typeName1" name="typeName"  lay-verify="required|phone" autocomplete="off" class="layui-input bian"></textarea>\n' +
                        '                   </div>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </form>' +
                        '</div>',
                    success: function () {
                        $("input[name='orderNo']").val(data.D)
                        $("input[name='typeName']").val(data.E)
                        $("#parentGtypeId option[value="+data.C+"]").prop('selected',true)
                        form.render()
                    },
                    yes: function (index, layero) {
                        layer.close(index);
                    },
                    btn2:function(){

                    }
                });
            }
            else if(res.event == 'creatUser'){
                $(".fadeInRight").css('display','block')
                $("input[name='name']").val(F)
                $(".name1").text(F)
            }
        })
        $(document).on("click","#add",function(){
            layer.open({
                anim:1,
                type: 1,
                area: ['60%', '100%'], //宽高
                title: ['新增','font-size:18px;font-weight:bold'],
                maxmin: false,
                offset: 'rt',
                btn: ['取&nbsp&nbsp消','确&nbsp&nbsp定'], //可以无限个按钮
                content: '<div style="margin: 30px auto;">' +
                    '       <span style="font-size: 16px;font-weight: bold;margin-left: 20px;display: inline-block;width: 96%;border-bottom: 1px solid rgb(224,227,233);height:35px">基本信息</span>\n' +
                    '       <form class="layui-form" action="">\n' +
                    '           <div class="layui-form-item" style="width: 45%;margin-left: 20px;display: inline-block">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">合同类型</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                       <select name="parentGtypeId" id="parentGtypeId" class="oneDayPerDiem bian">\n' +
                    '                           <option value="A">A</option>\n' +
                    '                           <option value="B">B</option>\n' +
                    '                           <option value="C">C</option>\n' +
                    '                       </select>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '           <div class="layui-form-item" style="width: 45%;display: inline-block;margin-left: 20px;">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">范本名称</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                       <input type="text" placeholder="请输入" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input bian">\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '           <div class="layui-form-item" style="width: 45%;display: inline-block;margin-left: 20px;">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">范本编号</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                       <input type="text" placeholder="请输入" name="typeName"  lay-verify="required|phone" autocomplete="off" class="layui-input bian">\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '           <div class="layui-form-item" style="margin-left: 20px;">\n' +
                    '               <div class="layui-inline">\n' +
                    '                   <p>附件</p>\n' +
                    '                  <div class="layui-input-block" style="padding-top: 9px;margin: 0">\n' +
                    '                      <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '                      <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '                          <img src="../img/mg11.png" alt="">\n' +
                    '                          <span>添加附件</span>\n' +
                    '                          <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                    '                      </a>\n' +
                    '                   </div>' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '           <div class="layui-form-item" style="width: 96%;display: inline-block;margin-left: 20px;">\n' +
                    '               <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '                   <p style="font-size: 14px;margin-bottom: 8px;">备注</p>\n' +
                    '                   <div class="layui-input-inline" style="width:90%">\n' +
                    '                       <textarea style="height: 70px;" placeholder="请输入" type="text" name="typeName"  lay-verify="required|phone" autocomplete="off" class="layui-input bian"></textarea>\n' +
                    '                   </div>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </form>' +
                    '</div>',
                success: function () {
                    form.render()
                },
                yes: function (index, layero) {
                    layer.close(index);
                },
                btn2:function(){

                }
            });
        })
        $(document).on('click','#del',function(){
            if(parseFloat(sum)<1){
                layer.msg('请至少选择一项',{icon:2})
            }else{
                layer.confirm('确定删除选中的'+sum+'条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    //确定删除，调接口


                }, function(){
                    layer.closeAll();
                });
            }
        })
        $(document).on('click','',function(){
            $(".fadeInRight").css('display','none')
        })
        $(document).on('click','.fadeInRight',function(){
            return false
        })
        $(document).on('click','.title',function(){
            return false
        })
        $(document).on('click','#edits',function(){
            var parentGtypeId = document.getElementById('parentGtypeId')
            parentGtypeId.removeAttribute("disabled");
            $("#orderNo").attr('disabled',false)
            $("#typeName").attr('disabled',false)
            $("#typeName1").attr('disabled',false)
        })
        $(document).on('click','#dels',function(){
            layer.confirm('确定删除本条数据吗？', {
                btn: ['确定','取消'], //按钮
                title:"删除"
            }, function(){
                //确定删除，调接口


            }, function(){
                layer.closeAll();
            });
        })
        //右侧的报表导入字段
        $('#import').click(function () {
            var repTableId = $('.select').attr('repTableId');
            Import(repTableId);
        })
        //导入
        function Import(data) {
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title: '导入',
                maxmin: true,
                btn: ['确定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue;cursor:pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="tests">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success: function () {
                    $('#load').click(function () {
                        window.location.href = "/ui/file/dataReport/考勤导入模板.xls"
                    })
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#tests' //绑定元素
                        , url: '/AttendanceType/addAttendanceData'
                        , accept: 'file'
                        , auto: false
                        , bindAction: '.layui-layer-btn0'
                        , choose: function (obj) {
                            var files = obj.pushFile();
                            obj.preview(function (index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        , done: function (res) {
                            var str = ''
                            $.each(res.obj, function (key, value) {
                                str += key + '->' + value + '\n'
                            });
                            layer.msg(res.msg);
                            table.reload('test1', {
                                url: '/AttendanceType/selectAllAttendanceDate',
                                where: {
                                    tableId: data
                                }
                            })
                            layer.open({
                                type: 1 //此处以iframe举例
                                , title: '导入情况详情'
                                , area: ['50%', '50%'],
                                offset:'100',
                                btn: ['确定'],
                                content:'<div id="show2" name="show2"></div>'
                                ,
                                success: function () {
                                },yes:function(){
                                    str1=''
                                    layer.closeAll();
                                }
                            })
                            var last2=res.object
                            var show3=JSON.stringify(last2);
                            str1 +='<div>'+show3+'</div><br/>'

                            for (var i = 0; i < res.obj.length; i++) {
                                var show2=res.obj[i]
                                str1 += '<div>'+show2+'</div><br/>'
                            }
                            $('[name="show2"]').html(str1);
                        }
                        , error: function () {
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function (index) {
                    layer.close(index);
                }
            });
        }
        $(document).on('click','#dayin',function(){
            if(sum < 1){
                layer.msg('请选择打印数据！',{icon:0});
                return false;
            }
            var url = '';
            var codeNo1 = $("#visitLocation").val()
            var codeOrder1 = $("#visitLocation").val()
            var address1= $("#visitLocation").find("option:selected").text()
            var address2=decodeURI(address1);
            layer.open({
                type: 1,
                title: "生成二维码",//标题
                area: ['100%', '100%'],
                offset:'0px',
                content: '<div id="code">\n' +
                    '        <center> <div id="qrcode"  style="margin-top: 100px"></div></center>\n' +
                    '    </div><center><strong><p style="margin-top: 30px;font-size: 30px">'+address1+'</p></strong></center>',
                btn:['<i class="layui-icon" style="margin-right: 10px;">&#xe609</i>下载图片','打印','取消'],
                //绑定第一个按钮的点击事件
                btn1: function(index) {
                    var img=$('#qrcode img')                       // 获取要下载的图片
                    var url = img[0].src;                            // 获取图片地址
                    var a = document.createElement('a');          // 创建一个a节点插入的document
                    var event = new MouseEvent('click')           // 模拟鼠标click点击事件
                    a.download = '二维码'                      // 设置a节点的download属性值
                    a.href = url;                                 // 将图片的src赋值给a节点的href
                    a.dispatchEvent(event)
                },
                btn2: function(index) {
                    window.open('/gapp/QRcode?codeOrder1='+codeOrder1+'&address2='+address2)
                }
            });

            // 设置要生成二维码的链接
            new QRCode(document.getElementById("qrcode"), {
                text: location.origin+'/Antiepidemic/antiepidemicH5?codeNo='+codeNo1,
                width: 300,
                height: 300
            });
        })
    });


</script>
</html>