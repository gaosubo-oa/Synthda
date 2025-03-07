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
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/gapp/design/form_design.css?20230415.1">
    <link rel="stylesheet" href="/css/gapp/design/city-picker.css?20230308.1">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20220825.1"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">

    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
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

    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript"
            charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/gapp/gapp_column.js?20230603.1"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20220825.1"></script>
</head>
<style>
    html, body {
        height: 100%;
        overflow: hidden;
    }

    #box {
        height: 100%;
        overflow-y: auto;
    }

    #box .layui-from {
        width: 100%;
    }

    .layui-table-page > div {
        float: right;
    }

    .layui-table-body {
        /*overflow-x: hidden;*/
    }

    #box .layui-table {
        width: 100%;
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
        top: 77px
    }

    #btn {
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top: 77px
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
        margin-left: 25px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 8px;
        display: block;
        margin-right: 10px;
        margin-bottom: 8px;
    }

    .layui-table-view {
        margin: 0;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn {
        display: none;
    }

    .layui-box layui-laypage layui-laypage-default {
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

    .layui-tab-content {
        /*margin-top: 20px;*/
    }

    .layui-table-view .layui-table td[data-field=TITLES]{
        color: #0047b3;
        height: 32px;
        line-height: 32px;
        cursor: pointer;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }

    .laytable-cell-1-0-6 {
        maxWidth: 220px;

    }

    .niuma {
        width: 680px;
        position: relative;
    }

    .top li {
        display: inline-block;
        padding-left: 10px;
        padding-right: 10px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        cursor: pointer;
    }

    .top li:hover {
        color: rgb(16, 127, 255);
    }

    .tops li {
        display: inline-block;
        line-height: 40px;
    }

    .tops .layui-form-item {
        margin-bottom: 5px;
    }

    .formBox li:hover {
        color: rgb(16, 127, 255);
    }

    .layui-layer-content {
        background-color: rgb(248, 248, 248);
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

    .bian:hover {
        border: 1px solid rgb(64, 169, 255);
    }

    .title {
        color: #107fff;
        cursor: pointer !important;
    }

    .row {
        margin-top: 80px;
    }

    .img {
        width: 20%;
        text-align: center;
    }

    .ji li {
        margin-top: 10px;
    }

    .lian li {
        margin-top: 10px;
    }

    .fadeInRight {
        animation-name: fadeInRight;
        -webkit-animation: fadeInRight;
    }

    .jiben li {
        display: inline-block;
        color: #8893a7;
        font-size: 14px;
        font-weight: 400 !important;
        width: 60px;
        height: 30px;
        text-align: center;
        line-height: 30px;
        border-radius: 4px;
        cursor: pointer;
    }

    .jiben li:hover {
        background-color: rgb(234, 237, 241);
    }

    textarea {
        resize: none;
    }

    #colDes {
        background-color: rgb(83, 107, 155);
        color: #ffffff;
        max-width: 250px;
        position: fixed;
        left: 0;
        top: 0;
        padding: 5px;
        border-radius: 5px;
        display: none;
        z-index: 99999999999
    }

    #colDes::after {
        content: '';
        position: absolute;
        display: block;
        bottom: -20px;
        left: 50%;
        transform: translateX(-50%);
        width: 0px;
        height: 0px;
        border: 10px solid transparent;
        border-top-color: rgb(83, 107, 155);
    }

    .formBox .layui-form-checkbox[lay-skin=primary] {
        height: 0 !important;
    }

    .formBox .layui-form-checkbox[lay-skin=primary] {
        height: 0 !important;
    }

    .disable {
        pointer-events: none;
        cursor: default;
    }

    #fileBoxs .divShow {
        padding: 10px 20px;
    }

    .operationDiv {
        position: absolute;
        width: 150px;
        border: #ccc 1px solid;
        border-radius: 4px;
        background-color: #ffffff;
        z-index: 99;
    }

    .operation {
        display: block;
        /*width: 100%;*/
        margin-left: 0px !important;
        height: 28px;
        padding-left: 10px;
        background: #fff;
        line-height: 28px;
    }

    .operation:hover {
        background-color: #cae1f7;
        color: #000000;
    }

    .layui-layer-content {
        background-color: #fff;
    }

    #box .layui-table-hover {
        background-color: #e6f7ff !important;
    }

    .formBox .layui-colla-title .layui-colla-icon {
        right: 15px !important;
        left: unset !important;
    }

    .formBox .layui-colla-content {
        padding-left: 0 !important;
        padding-right: 0 !important;
    }
    .table-content{
        overflow: visible!important;
        position: relative;
    }
    .table-content .layui-form-select{
        height:40px;
        margin:0!important;
    }
    .layui-form-selectup dl { bottom: auto; }
    #context_gapp .table-col{
        overflow: visible!important;
    }
    .table-col .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: -3px;
        margin-left:0;
    }
    .table-col input[type=text],
    .table-col textarea{
        height: 100%;
        margin: 0;
        padding: 0;
    }
    .table-col .layui-table-body td{
        padding: 0;
    }
    .table-col .layui-table-body td .layui-table-cell {
        height:38px!important;
        line-height: 38px!important;
        padding: 0!important;
        overflow: visible;
        vertical-align: middle;
        text-overflow: inherit;
        white-space: normal;
    }
    .table-col .layui-form-radio {
        margin:0;
        padding: 0;
        margin-right:5px;
        line-height: 38px;
    }
    .table-col .layui-table-box {
        overflow: visible;
    }
    .table-col .layui-form-switch{
        margin-top: 6px;
    }
    .table-col .layui-table-body,
    .table-col .layui-table-header{
        overflow: visible!important;
    }
    /* 设置下拉框的高度与表格单元相同 */
    .table-col td .layui-form-select{
        margin-top: -10px;
        margin-left: -15px;
        margin-right: -15px;
    }
    .table-col .layui-table-view td .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 0;
    }
    .table-col .layui-table-view td .layui-form-checkbox[lay-skin=primary] span {
        display: block;
        margin-left: 22px;
    }
    .table-col .layui-table {
        width: 100%;
        margin: 0 auto;
    }
    .table-col .layui-table-view td .abc{
        overflow: visible!important;
    }
    .table-col .layui-table-view td .abc .layui-form-select dl{
        top:auto;
        bottom: 40px;
    }
</style>
<body>
<p id="colDes"></p>
<div id="box">
    <form class="layui-form" style="margin: 0" action="">
        <div class="box2">
        </div>
        <div class="layui-tab layui-tab-brief" style="margin:0;" lay-filter="docDemoTabBrief">
            <div class="layui-tab-content">
                <ul class="top" style="color: #4f5052">
                    <li style="background-color: rgb(16,127,255);color: white;border-radius: 3px;display: none;"
                        class="layui-icon layui-icon-add-1" id="BUT_LIST_ADD">新增
                    </li>
                    <li class="layui-icon layui-icon-download-circle" style="display: none;" id="BUT_LIST_IN">导入</li>
                    <li class="layui-icon layui-icon-export" style="display: none;" id="BUT_LIST_OUT">导出</li>
                    <li class="layui-icon layui-icon-delete" style="display: none;" id="BUT_LIST_DEL">删除</li>
                    <li class="layui-icon layui-icon-print" style="display: none;" id="dayin">打印二维码</li>
                    <li class="layui-icon layui-icon-template" style="display: none;" id="tj">统计分析</li>
                    <li style="float: right;display: none;">列表</li>
                    <li style="float: right;display: none;">全部</li>
                    <div id="Confidential" style="display: inline-block"></div>
                </ul>
                <ul class="tops" style="margin-top: 10px">

                </ul>
                <table class="layui-hide" id="test" lay-filter="test"></table>
            </div>

        </div>
    </form>
</div>
<div class="boxs fadeInRight"
     style="width: 70%;height: 90%;background-color: white;position: absolute;right: 0;bottom: 0;box-shadow: 1px 1px 16px 5px #c0b9b9;display: none">
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
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">姓名</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name="name"
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">员工工号</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name=""
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">用户描述</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name=""
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">性别</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name=""
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
                    </div>
                    <div class="layui-tab-item lian">
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">电子邮件</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name=""
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
                        <li><span style="display: inline-block;width: 10%;font-weight: bold;">手机号码</span>
                            <div style="width: 90%;display: inline-block"><input type="text" style="" name=""
                                                                                 lay-verify="required|phone"
                                                                                 autocomplete="off" class="layui-input">
                            </div>
                        </li>
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
<script type="text/html" id="barOperation">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">详情</a>
    <a class="layui-btn  layui-btn-xs layui-btn-danger" style="display: none;" lay-event="del">删除</a>
</script>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
    </div>

</script>

</body>
<script>
    // 获取地址栏参数值
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            //return unescape(r[2]);  // 会中文乱码
            return decodeURI(r[2]); // 解决了中文乱码
        return null;
    }

    var gappId = getQueryString('gappId');
    var showtColumn = [];
    var tabId;
    var gappName = '';
    var DATA_ID = '';
    var showColIds = '';
    var result;
    layui.use(['form', 'table', 'element', 'laydate', 'xmSelect', 'layedit', 'eleTree', 'upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var upload = layui.upload;
        var laydate = layui.laydate;
        var xmSelect = layui.xmSelect;
        var sum = 0;
        $.ajax({
            url: '/gapp/open',
            type: 'get',
            data: {
                gappId: gappId
            },
            dataType: 'json',
            success: function (obj) {
                // console.log('/gapp/open', obj)
                if (obj.flag) {
                    if (JSON.stringify(obj.object) == "{}") {
                        $('.tops').html('')
                        var col = [[
                            {type: 'checkbox',},
                            {type: 'numbers', title: '序号'},
                        ]];
                        var meetTable = table.render({
                            elem: '#test'
                            , url: '/gdata/selectAll'
                            // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                , limits: [10, 20, 30, 40, 50, 60, 80, 100]
                                , first: '首页'
                                , last: '尾页'
                            }
                            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                                title: '提示'
                                , layEvent: 'LAYTABLE_TIPS'
                                , icon: 'layui-icon-tips'
                            }]
                            , where: {
                                tabId: obj.object.tabId,
                                useFlag: true,
                                boolean: true
                            }
                            , title: '用户数据表'
                            , cols: col
                            // ]]
                            , parseData: function (res) { //res 即为原始返回的数据
                                // var data = json.obj
                                return {
                                    "code": 0, //解析接口状态
                                    "msg": res.msg, //解析提示文本
                                    "count": res.totleNum, //解析数据长度
                                    "data": res.obj, //解析数据列表
                                };
                            }
                            , done: function (res) {
                                if (res.data.length > 0) {
                                    $('.layui-table-header').eq(0).css('overflow', 'hidden');
                                } else {
                                    $('.layui-table-header').eq(0).css('overflow', 'auto');
                                }
                            }
                            , limit: 10
                        })
                    } else {
                        gappName = obj.object.tabName
                        document.title = gappName;
                        $.ajax({
                            url: '/gdata/queryControl',
                            type: 'get',
                            data: {
                                tabId: obj.object.tabId
                            },
                            dataType: 'json',
                            success: function (res) {
                                // console.log('/gdata/queryControl', res)
                                if (res.flag) {
                                    if (JSON.stringify(res.object) == "{}") {
                                        $('.tops').html('')
                                        var col = [[
                                            {type: 'checkbox'},
                                            {type: 'numbers', title: '序号'}
                                        ]];
                                        var meetTable = table.render({
                                            elem: '#test'
                                            , url: '/gdata/selectAll'
                                            // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                                            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                                , limits: [10, 20, 30, 40, 50, 60, 80, 100]
                                                , first: '首页'
                                                , last: '尾页'
                                            }
                                            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                                                title: '提示'
                                                , layEvent: 'LAYTABLE_TIPS'
                                                , icon: 'layui-icon-tips'
                                            }]
                                            , where: {
                                                tabId: obj.object.tabId,
                                                useFlag: true,
                                                boolean: true
                                            }
                                            , title: '用户数据表'
                                            , cols: col
                                            , parseData: function (res) { //res 即为原始返回的数据
                                                // console.log('res',res)
                                                // var data = json.obj
                                                return {
                                                    "code": 0, //解析接口状态
                                                    "msg": res.msg, //解析提示文本
                                                    "count": res.totleNum, //解析数据长度
                                                    "data": res.obj, //解析数据列表
                                                };
                                            }
                                            , done: function (res) {
                                                if (res.data.length > 0) {
                                                    $('.layui-table-header').eq(0).css('overflow', 'hidden');
                                                } else {
                                                    $('.layui-table-header').eq(0).css('overflow', 'auto');
                                                }
                                            }
                                            , limit: 10
                                        })
                                    } else {
                                        tabId = res.object.glist.tabId;
                                        result = toAjaxTT('/gtablePriv/selectGcolumnPriv', {tabId: res.object.glist.tabId})
                                        // console.log('result', result)
                                        if (result.object) {
                                            btnPrivFun(result.object, 'list');
                                        } else {
                                            $('.top').hide();
                                        }
                                        showtColumn = res.object.allGcolumnList;
                                        // console.log('showtColumn', showtColumn)
                                        showColIds = res.object.glist.showColIds
                                        // console.log('showColIds', showColIds)
                                        if (res.object.selColList != undefined) {
                                            if (res.object.selColList.length > 0) {
                                                var str = gcolumn_field_search(res.object.selColList, res.object.glist.selColIds);
                                                // console.log('str', str)
                                                $('.tops').html(str)
                                                returnSf(res.object.selColList)
                                                form.render();
                                            } else {
                                                $('.tops').html('')
                                            }
                                        } else {
                                            $('.tops').html('')
                                        }

                                        laydate.render({
                                            elem: '#CREATE_TIME_CH'
                                            , done: function (value, date, endDate) {
                                                // console.log(value); //得到日期生成的值，如：2017-08-18
                                                // console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds:
                                                serchFun()
                                            }
                                        });
                                        laydate.render({
                                            elem: '#UPDATE_TIME_CH'
                                            , done: function (value, date, endDate) {
                                                // console.log(value); //得到日期生成的值，如：2017-08-18
                                                console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds:
                                                serchFun()
                                            }
                                        });
                                        var subjectField = [];
                                        var subjectTitle = [];
                                        for (var i = 0; i < res.object.showColList.length; i++) {
                                            if (res.object.showColList[i].colType == 'C03') {
                                                subjectField.push('COL' + res.object.showColList[i].colId + '_Date_' + res.object.showColList[i].colKtype + '_' + res.object.showColList[i].colStyle);
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            } else if (res.object.showColList[i].colType == 'C04') {
                                                subjectField.push('COL' + res.object.showColList[i].colId + '_NUM_' + res.object.showColList[i].colKtype + '_' + res.object.showColList[i].colStyle);
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            } else if (res.object.showColList[i].colType == 'C08') {
                                                subjectField.push('COL' + res.object.showColList[i].colId + '_NAME');
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            } else if (res.object.showColList[i].colType == 'C09') {
                                                subjectField.push('COL' + res.object.showColList[i].colId + '_NAME');
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            } else if (res.object.showColList[i].colType == 'S01') {
                                                subjectField.push('CREATE_USER_ID');
                                                subjectTitle.push('创建人');
                                            } else if (res.object.showColList[i].colType == 'S02') {
                                                subjectField.push('CREATE_TIME');
                                                subjectTitle.push('创建时间');
                                            } else if (res.object.showColList[i].colType == 'S04') {
                                                subjectField.push('DEPT_ID');
                                                subjectTitle.push('所属部门');
                                            } else if (res.object.showColList[i].colType == 'S05') {
                                                subjectField.push('OWNER_USER_ID');
                                                subjectTitle.push('拥有者');
                                            } else if (res.object.showColList[i].colType == 'S03') {
                                                subjectField.push('UPDATE_TIME');
                                                subjectTitle.push('修改时间');
                                            } else if (res.object.showColList[i].colId == 'DATA_ID') {
                                                subjectField.push('DATA_ID');
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            } else {
                                                subjectField.push('COL' + res.object.showColList[i].colId);
                                                subjectTitle.push(res.object.showColList[i].colName);
                                            }
                                        }
                                        var col = [[
                                            {
                                                type: 'checkbox',
                                                hide: res.object.glist.batchOperate == '1' ? false : true
                                            },
                                            {type: 'numbers', title: '序号', width: 60},
                                            {
                                                field: 'TITLES',
                                                title: '数据标题',
                                                event: 'TITLES',
                                                width: '20%',
                                                templet: function (d) {
                                                    console.log('d', d)
                                                    //渲染数据标题
                                                    let dArr = Object.keys(d)
                                                    if (d.TITLES === undefined) {
                                                        var titlesArr = []
                                                        $.ajax({
                                                            url: '/gtable/selectByTabId',
                                                            type: 'get',
                                                            async: false,
                                                            data: {
                                                                gappId: obj.object.gappId
                                                            },
                                                            dataType: 'json',
                                                            success: function (res) {
                                                                console.log('res', res)
                                                                let dataTitles = res.obj
                                                                dataTitles.forEach(function (value, index) {
                                                                    var newColId = ''
                                                                    if (value.colId === 'OWNER_USER_ID') {
                                                                        newColId = 'OWNER_USER_NAME'
                                                                    } else if (value.colId === 'CREATE_USER_ID') {
                                                                        newColId = 'CREATE_USER'
                                                                    } else if (value.colId === 'UPDATE_TIME' || value.colId === 'DATA_ID') {
                                                                        newColId = value.colId
                                                                    } else {
                                                                        newColId = 'COL' + value.colId
                                                                    }
                                                                    dArr.forEach(function (item, idx) {
                                                                        if (newColId === item) {
                                                                            if (d.UPDATE_TIME === 'undefined') {
                                                                                return
                                                                            } else {
                                                                                d.UPDATE_TIME = String(d.UPDATE_TIME);
                                                                                if (d.UPDATE_TIME.indexOf(':') === -1) {
                                                                                    d.UPDATE_TIME = parseInt(d.UPDATE_TIME)
                                                                                    d.UPDATE_TIME = new Date(d.UPDATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                                                                                }
                                                                            }
                                                                            titlesArr.push(d[newColId])//
                                                                        }
                                                                    })
                                                                })
                                                            }
                                                        })
                                                        return d.TITLES = titlesArr.join(' ');
                                                    }
                                                }
                                            }
                                        ]];
                                        //动态添加列属性
                                        if (subjectField.length < 10) {
                                            for (var i = 0; i < subjectField.length; i++) {
                                                (function (i) {
                                                    //向数组插入元素：splice(index, howmany, items...)
                                                    //index要插入的位置
                                                    //howmany从该位置删除多少项元素
                                                    //items要插入的元素
                                                    //col[0],注意col是二维数组
                                                    // console.log('subjectField[i]', subjectField[i])
                                                    if (subjectField[i].indexOf('_Date_') > -1) {
                                                        var col1 = subjectField[i].split('_Date_')[0];
                                                        var type1 = subjectField[i].split('_Date_')[1].split('_')[1]
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i].split('_Date_')[0],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = getNowFormatDate(d[col1], type1);
                                                                // console.log('str',str)
                                                                return str;
                                                            }
                                                        });
                                                        // console.log('col', col[0])
                                                    } else if (subjectField[i].indexOf('_NUM_') > -1) {
                                                        var col4 = subjectField[i].split('_NUM_')[0];
                                                        var type4 = subjectField[i].split('_NUM_')[1].split('_')[0]
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i].split('_NUM_')[0],
                                                            title: subjectTitle[i],
                                                            templet: function (d) {
                                                                var str = getNowNum(d[col4], type4);
                                                                return str;
                                                            }
                                                        });
                                                        // console.log('col', col[0])
                                                    } else if (subjectField[i].indexOf('_NAME') > -1) {
                                                        var col2 = subjectField[i];
                                                        var title2 = subjectTitle[i];
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 260,
                                                            event: 'getFile',
                                                            templet: function (d) {
                                                                var val = d[col2];
                                                                if (val != undefined && val != '') {
                                                                    var str2 = '<span style="color: #54b6fe;" data-id="' + col2 + '" data-title="' + title2 + '">' + val.split('*')[0] + '</span>';
                                                                } else {
                                                                    var str2 = ''

                                                                }
                                                                // console.log('str',str2)
                                                                return str2
                                                            }
                                                        });
                                                        // console.log('col2', col[0])
                                                    } else if (subjectField[i].indexOf('CREATE_TIME') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.CREATE_TIME != '' && d.CREATE_TIME != null && d.CREATE_TIME != undefined) {
                                                                    if (typeof (d.CREATE_TIME) == 'string') {
                                                                        if (d.CREATE_TIME.indexOf(':') > -1) {
                                                                            var oldTime = (new Date(d.CREATE_TIME)).getTime();
                                                                            str = new Date(oldTime).Format("yyyy-MM-dd hh:mm:ss");
                                                                        }
                                                                    } else {
                                                                        str = new Date(d.CREATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                                                                    }
                                                                } else {
                                                                    str = ''
                                                                }
                                                                // console.log('str',str)
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('UPDATE_TIME') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.UPDATE_TIME != '' && d.UPDATE_TIME != null && d.UPDATE_TIME != undefined) {
                                                                    if (typeof (d.UPDATE_TIME) == 'string') {
                                                                        if (d.UPDATE_TIME.indexOf(':') > -1) {
                                                                            var oldTime = (new Date(d.UPDATE_TIME)).getTime();
                                                                            str = new Date(oldTime).Format("yyyy-MM-dd hh:mm:ss");
                                                                        }
                                                                    } else {
                                                                        str = new Date(d.UPDATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                                                                    }
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('CREATE_USER_ID') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.CREATE_USER != '' && d.CREATE_USER != null && d.CREATE_USER != undefined) {
                                                                    str = d.CREATE_USER
                                                                } else {
                                                                    str = ''
                                                                }
                                                                // console.log('str',str)
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('DEPT_ID') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.DEPT_NAME != '' && d.DEPT_NAME != null && d.DEPT_NAME != undefined) {
                                                                    str = d.DEPT_NAME
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('OWNER_USER_ID') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.OWNER_USER_NAME != '' && d.OWNER_USER_NAME != null && d.OWNER_USER_NAME != undefined) {
                                                                    str = d.OWNER_USER_NAME
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                        });
                                                    }
                                                })(i)

                                            }
                                        } else {
                                            for (var i = 0; i < subjectField.length; i++) {
                                                (function (i) {
                                                    //向数组插入元素：splice(index, howmany, items...)
                                                    //index要插入的位置
                                                    //howmany从该位置删除多少项元素
                                                    //items要插入的元素
                                                    //col[0],注意col是二维数组
                                                    if (subjectField[i].indexOf('_Date_') > -1) {
                                                        var col1 = subjectField[i].split('_Date_')[0];
                                                        var type1 = subjectField[i].split('_Date_')[1].split('_')[1]
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i].split('_Date_')[0],
                                                            title: subjectTitle[i],
                                                            width: 150,
                                                            templet: function (d) {
                                                                var str = getNowFormatDate(d[col1], type1);
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('_NUM_') > -1) {
                                                        var col4 = subjectField[i].split('_NUM_')[0];
                                                        var type4 = subjectField[i].split('_NUM_')[1].split('_')[0]
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i].split('_NUM_')[0],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = getNowNum(d[col4], type4);
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('_NAME') > -1) {
                                                        var col2 = subjectField[i];
                                                        var title2 = subjectTitle[i];
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 260,
                                                            event: 'getFile',
                                                            templet: function (d) {
                                                                var val = d[col2];
                                                                if (val != undefined && val != '') {
                                                                    var str2 = '<span style="color: #54b6fe;" data-id="' + col2 + '" data-title="' + title2 + '">' + val.split('*')[0] + '</span>';
                                                                } else {
                                                                    var str2 = ''

                                                                }
                                                                return str2
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('CREATE_TIME') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.CREATE_TIME != '' && d.CREATE_TIME != null && d.CREATE_TIME != undefined) {
                                                                    if (typeof (d.CREATE_TIME) == 'string') {
                                                                        if (d.CREATE_TIME.indexOf(':') > -1) {
                                                                            var oldTime = (new Date(d.CREATE_TIME)).getTime();
                                                                            str = new Date(oldTime).Format("yyyy-MM-dd hh:mm:ss");
                                                                        }
                                                                    } else {
                                                                        str = new Date(d.CREATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                                                                    }
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('UPDATE_TIME') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.UPDATE_TIME != '' && d.UPDATE_TIME != null && d.UPDATE_TIME != undefined) {
                                                                    if (typeof (d.UPDATE_TIME) == 'string') {
                                                                        if (d.UPDATE_TIME.indexOf(':') > -1) {
                                                                            var oldTime = (new Date(d.UPDATE_TIME)).getTime();
                                                                            str = new Date(oldTime).Format("yyyy-MM-dd hh:mm:ss");
                                                                        }
                                                                    } else {
                                                                        str = new Date(d.UPDATE_TIME).Format("yyyy-MM-dd hh:mm:ss");
                                                                    }
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('CREATE_USER_ID') > -1) {

                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.CREATE_USER != '' && d.CREATE_USER != null && d.CREATE_USER != undefined) {
                                                                    str = d.CREATE_USER
                                                                } else {
                                                                    str = ''
                                                                }
                                                                // console.log('str',str)
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('DEPT_ID') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.DEPT_NAME != '' && d.DEPT_NAME != null && d.DEPT_NAME != undefined) {
                                                                    str = d.DEPT_NAME
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else if (subjectField[i].indexOf('OWNER_USER_ID') > -1) {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 180,
                                                            templet: function (d) {
                                                                var str = ''
                                                                if (d.OWNER_USER_NAME != '' && d.OWNER_USER_NAME != null && d.OWNER_USER_NAME != undefined) {
                                                                    str = d.OWNER_USER_NAME
                                                                } else {
                                                                    str = ''
                                                                }
                                                                return str;
                                                            }
                                                        });
                                                    } else {
                                                        col[0].splice(col[0].length, 0, {
                                                            field: subjectField[i],
                                                            title: subjectTitle[i],
                                                            width: 150,
                                                        });
                                                    }
                                                })(i)
                                            }
                                        }
                                        // console.log('subjectField',subjectField)
                                        if (subjectField.length == 0) {
                                            var obj1 = {
                                                title: '操作',
                                                fixed: 'right',
                                                toolbar: '#barOperation'
                                            }
                                        } else {
                                            var obj1 = {
                                                title: '操作',
                                                width: 110,
                                                fixed: 'right',
                                                toolbar: '#barOperation'
                                            }
                                        }

                                        col[0].push(obj1)
                                        var meetTable = table.render({
                                            elem: '#test'
                                            , url: '/gdata/selectAll'
                                            // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                                            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                                , limits: [10, 20, 30, 40, 50, 60, 80, 100]
                                                , first: '首页'
                                                , last: '尾页'
                                            }
                                            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                                                title: '提示'
                                                , layEvent: 'LAYTABLE_TIPS'
                                                , icon: 'layui-icon-tips'
                                            }]
                                            , where: {
                                                tabId: tabId,
                                                useFlag: true,
                                                boolean: true
                                            }
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
                                                // console.log('res',res)
                                                return {
                                                    "code": 0, //解析接口状态
                                                    "msg": res.msg, //解析提示文本
                                                    "count": res.totleNum, //解析数据长度
                                                    "data": res.obj, //解析数据列表
                                                };
                                            }
                                            , done: function (res) {
                                                if (res.data.length > 0) {
                                                    $('.layui-table-header').eq(0).css('overflow', 'hidden');
                                                } else {
                                                    $('.layui-table-header').eq(0).css('overflow', 'auto');
                                                }
                                            }
                                            , limit: 10
                                        })
                                    }
                                }
                            }
                        })

                    }

                }
            }
        });
        //==================================================================================//
        form.render()
        table.on('checkbox(test)', function (res) {
            sum = (layui.table.checkStatus('test').data).length
        })
        //监听表格单元格
        table.on('tool(test)', function (res) {
            var data = res.data
            if (res.event == 'detail') {
                DATA_ID = data.DATA_ID
                layer.open({
                    // anim:1,
                    type: 1,
                    area: ['73%', '96%'], //宽高
                    title: [gappName, 'font-size:18px;font-weight:bold'],
                    maxmin: false,
                    // offset: 'rt',
                    btn: ['保&nbsp&nbsp存', '暂&nbsp&nbsp存', '取&nbsp&nbsp消', '提&nbsp&nbsp交'], //可以无限个按钮
                    content: gcolumn_field_tatol(getAllColumns(showtColumn), showColIds, 'edit'),
                    success: function () {
                        layui.element.render();
                        if (result.object) {
                            btnPrivFun(result.object, 'form');
                        } else {
                            $('.top').hide();
                        }
                        $("html").css("overflow-y", "hidden");
                        for(var i=0; i<$('.childTable').length; i++) {
                            $('.childTable').eq(i).find('.col-addnew').hide();
                            $('.childTable').eq(i).find('.col-delete').hide();
                        }
                        returnDates(getAllColumns(showtColumn));
                        var fileArr = returnFile(getAllColumns(showtColumn));
                        for (var j = 0; j < fileArr.length; j++) {

                            fileuploadFns('#' + fileArr[j].id + '0', $('#' + fileArr[j].id));
                        }

                        $.ajax({
                            url: '/gdata/selectByDataId',
                            type: 'get',
                            data: {
                                tabId: tabId,
                                dataId: data.DATA_ID
                            },
                            dataType: 'json',
                            success: function (obj) {
                                if (obj.flag) {
                                    echoFun(obj.object);
                                    // 子表回显
                                    var arrs = obj.object;
                                    for(var i=0; i<showtColumn.length; i++) {
                                        if(showtColumn[i].colType == 'L03') {
                                            createTableItems(showtColumn[i],arrs[showtColumn[i].colId],'edit')
                                        }
                                    }
                                }
                            }
                        })
                        form.render()
                    },
                    yes: function (index, layero) {
                        $("html").css("overflow-y", "auto");
                        layer.close(index);
                        var obj = getData()
                        $.ajax({
                            url: '/gdata/updateByDataId',
                            type: 'get',
                            data: {
                                dataId: DATA_ID,
                                tabId: tabId,
                                strJson: JSON.stringify(obj)
                            },
                            dataType: 'json',
                            success: function (obj) {
                                if (obj.flag) {
                                    layer.msg('修改成功!', {icon: 1})
                                    // layer.closeAll();
                                    layui.table.reload('test');
                                } else {
                                    layer.msg(res.msg, {icon: 1})
                                }
                            }
                        })
                    },
                    btn2: function (index) {
                        layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                        return false;
                        // var obj = getData()
                        // $.ajax({
                        //     url:'/gdata/updateByDataId',
                        //     type:'get',
                        //     data:{
                        //         dataId:DATA_ID,
                        //         tabId:tabId,
                        //         strJson:JSON.stringify(obj)
                        //     },
                        //     dataType:'json',
                        //     success:function(obj){
                        //         if(obj.flag){
                        //             layer.msg('修改成功!',{icon:1})
                        //             // layer.closeAll();
                        //             layui.table.reload('test');
                        //         }else{
                        //             layer.msg(res.msg,{icon:1})
                        //         }
                        //     }
                        // })
                    },
                    btn3: function (index) {
                        layui.layer.close(index);
                        $("html").css("overflow-y", "auto");
                        var obj = getData()
                        // $.ajax({
                        //     url:'/gdata/updateByDataId',
                        //     type:'get',
                        //     data:{
                        //         dataId:DATA_ID,
                        //         tabId:tabId,
                        //         strJson:JSON.stringify(obj)
                        //     },
                        //     dataType:'json',
                        //     success:function(obj){
                        //         if(obj.flag){
                        //             layer.msg('修改成功!',{icon:1})
                        //             // layer.closeAll();
                        //             layui.table.reload('test');
                        //         }else{
                        //             layer.msg(res.msg,{icon:1})
                        //         }
                        //     }
                        // })
                    },
                    btn4: function (index) {
                        layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                        return false;
                    },
                    cancel: function () {
                        $("html").css("overflow-y", "auto");
                    }
                });
            } else if (res.event == 'getFile') {
                if ($(this).find('span').length > 0) {
                    getFile(data, $(this).find('span').attr('data-id'), $(this).find('span').attr('data-title'))
                } else {
                    layer.msg('无附件!', {icon: 1});
                    return false;
                }
            } else if (res.event == 'TITLES') {//点击数据标题列事件
                DATA_ID = data.DATA_ID
                layer.open({
                    // anim:1,
                    type: 1,
                    area: ['73%', '96%'], //宽高
                    title: [gappName, 'font-size:18px;font-weight:bold'],
                    maxmin: false,
                    // offset: 'rt',
                    btn: ['保&nbsp&nbsp存', '暂&nbsp&nbsp存', '取&nbsp&nbsp消', '提&nbsp&nbsp交'], //可以无限个按钮
                    content: gcolumn_field_tatol(getAllColumns(showtColumn), showColIds, 'edit'),
                    success: function () {
                        layui.element.render();
                        if (result.object) {
                            btnPrivFun(result.object, 'form');
                        } else {
                            $('.top').hide();
                        }
                        $("html").css("overflow-y", "hidden");
                        returnDates(getAllColumns(showtColumn));
                        var fileArr = returnFile(getAllColumns(showtColumn));
                        for (var j = 0; j < fileArr.length; j++) {

                            fileuploadFns('#' + fileArr[j].id + '0', $('#' + fileArr[j].id));
                        }
                        $.ajax({
                            url: '/gdata/selectByDataId',
                            type: 'get',
                            data: {
                                tabId: tabId,
                                dataId: data.DATA_ID
                            },
                            dataType: 'json',
                            success: function (obj) {
                                if (obj.flag) {
                                    echoFun(obj.object);
                                    // 子表回显
                                    var arrs = obj.object;
                                    for(var i=0; i<showtColumn.length; i++) {
                                        if(showtColumn[i].colType == 'L03') {
                                            createTableItems(showtColumn[i],arrs[showtColumn[i].colId],'edit')
                                        }
                                    }
                                }
                            }
                        })
                        form.render()
                    },
                    yes: function (index, layero) {
                        $("html").css("overflow-y", "auto");
                        layer.close(index);
                        var obj = getData()
                        $.ajax({
                            url: '/gdata/updateByDataId',
                            type: 'get',
                            data: {
                                dataId: DATA_ID,
                                tabId: tabId,
                                strJson: JSON.stringify(obj)
                            },
                            dataType: 'json',
                            success: function (obj) {
                                if (obj.flag) {
                                    layer.msg('修改成功!', {icon: 1})
                                    // layer.closeAll();
                                    layui.table.reload('test');
                                } else {
                                    layer.msg(res.msg, {icon: 1})
                                }
                            }
                        })
                    },
                    btn2: function (index) {
                        layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                        return false;
                        // var obj = getData()
                        // $.ajax({
                        //     url:'/gdata/updateByDataId',
                        //     type:'get',
                        //     data:{
                        //         dataId:DATA_ID,
                        //         tabId:tabId,
                        //         strJson:JSON.stringify(obj)
                        //     },
                        //     dataType:'json',
                        //     success:function(obj){
                        //         if(obj.flag){
                        //             layer.msg('修改成功!',{icon:1})
                        //             // layer.closeAll();
                        //             layui.table.reload('test');
                        //         }else{
                        //             layer.msg(res.msg,{icon:1})
                        //         }
                        //     }
                        // })
                    },
                    btn3: function (index) {
                        layui.layer.close(index);
                        $("html").css("overflow-y", "auto");
                        var obj = getData()
                        // $.ajax({
                        //     url:'/gdata/updateByDataId',
                        //     type:'get',
                        //     data:{
                        //         dataId:DATA_ID,
                        //         tabId:tabId,
                        //         strJson:JSON.stringify(obj)
                        //     },
                        //     dataType:'json',
                        //     success:function(obj){
                        //         if(obj.flag){
                        //             layer.msg('修改成功!',{icon:1})
                        //             // layer.closeAll();
                        //             layui.table.reload('test');
                        //         }else{
                        //             layer.msg(res.msg,{icon:1})
                        //         }
                        //     }
                        // })
                    },
                    btn4: function (index) {
                        layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                        return false;
                    },
                    cancel: function () {
                        $("html").css("overflow-y", "auto");
                    }
                });
            }
        })
        // 新增
        $(document).on("click", "#BUT_LIST_ADD", function () {
            layer.open({
                // anim:1,
                type: 1,
                area: ['73%', '96%'], //宽高
                title: [gappName, 'font-size:18px;font-weight:bold'],
                maxmin: false,
                // offset: 'rt',
                // btn: ['取&nbsp&nbsp消','暂&nbsp&nbsp存','保&nbsp&nbsp存','提&nbsp&nbsp交'], //可以无限个按钮
                btn: ['保&nbsp&nbsp存', '暂&nbsp&nbsp存', '取&nbsp&nbsp消', '提&nbsp&nbsp交'], //可以无限个按钮
                content: gcolumn_field_tatol(getAllColumns(showtColumn), showColIds, 'add'),
                success: function () {
                    layui.element.render();
                    $("html").css("overflow-y", "hidden");
                    if (result.object) {
                        btnPrivFun(result.object, 'form');
                    } else {
                        $('.top').hide();
                    }
                    $('.formBox #CREATE_USER_ID').attr('data-id', $.cookie('userId'));
                    $('.formBox #CREATE_USER_ID').val($.cookie('userName'));
                    $('.formBox #CREATE_TIME').val(new Date().Format("yyyy-MM-dd hh:mm:ss"));
                    returnDates(getAllColumns(showtColumn));

                    var fileArr = returnFile(getAllColumns(showtColumn));
                    for (var j = 0; j < fileArr.length; j++) {
                        fileuploadFns('#' + fileArr[j].id + '0', $('#' + fileArr[j].id));
                    }
                    // 子表渲染
                    for(var i=0; i<showtColumn.length; i++) {
                        if(showtColumn[i].colType == 'L03') {
                            createTableItems(showtColumn[i],[{TITLES:''}],'add')
                        }
                    }
                    layui.form.render()
                },
                yes: function (index, layero) {
                    if ($('.formBox form .layui-form-item').length <= 0) {
                        layui.layer.msg('请先进行表单设计后，进行数据添加', {icon: 1});
                        return false;
                    } else {
                        $("html").css("overflow-y", "auto");
                        var obj = getData()
                        //子表
                        var childTableCaids = [];
                        var tabIds = '';
                        var dom = $('.formBox .childTable');
                        var childObj = {};
                        if ($('.formBox form .childTable').length <= 0) {
                            tabIds = '';
                            childObj = {};
                            // return false;
                        }else{
                            for(var i=0; i<dom.length; i++) {
                                childTableCaids.push($('.formBox .childTable').eq(i).attr('data-id'));
                                childObj[dom.eq(i).attr('data-id')] = moreData(dom.eq(i).find('.layui-table-body'))
                            }
                            tabIds = childTableCaids.join(',')
                        }
                        $.ajax({
                            url: '/gdata/insert',
                            type: 'post',
                            data: {
                                tabId: tabId,
                                strJson: JSON.stringify(obj),
                                tabIds: tabIds,
                                strJsons: JSON.stringify(childObj)
                            },
                            dataType: 'json',
                            success: function (obj) {
                                if (obj.flag) {
                                    layer.closeAll();
                                    layui.table.reload('test');
                                    setTimeout(function () {
                                        layer.msg('新增成功!', {icon: 1})
                                    })
                                }
                            }
                        });
                        // if ($('.formBox form .childTable').length <= 0) {
                        //     return false;
                        // }else{
                        //     // console.log($('.formBox form .childTable').length)
                        //     //表单子表新增接口
                        //     insertColod();
                        // }
                    }
                },
                btn2: function () {
                    layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                    return false;
                    // $("html").css("overflow-y", "auto");
                    // var obj = getData()
                    // $.ajax({
                    //     url:'/gdata/insert',
                    //     type:'get',
                    //     data:{
                    //         tabId:tabId,
                    //         strJson:JSON.stringify(obj)
                    //     },
                    //     dataType:'json',
                    //     success:function(obj){
                    //         if(obj.flag){
                    //             layer.msg('成功!',{icon:1})
                    //             layer.closeAll();
                    //             layui.table.reload('test');
                    //         }
                    //     }
                    // })
                }
                , btn3: function (index) {
                    $("html").css("overflow-y", "auto");
                    layer.close(index);
                }
                , btn4: function () {
                    layui.layer.msg('该功能正在开发中。。。', {icon: 1})
                    return false;
                    // $("html").css("overflow-y", "auto");
                    // var obj = getData()
                    // $.ajax({
                    //     url:'/gdata/insert',
                    //     type:'get',
                    //     data:{
                    //         tabId:tabId,
                    //         strJson:JSON.stringify(obj)
                    //     },
                    //     dataType:'json',
                    //     success:function(obj){
                    //         if(obj.flag){
                    //             layer.msg('新增成功!',{icon:1})
                    //             layer.closeAll();
                    //             layui.table.reload('test');
                    //         }
                    //     }
                    // })
                }
                , cancel: function () {
                    $("html").css("overflow-y", "auto");
                }
            });
        })
        // 批量删除
        $(document).on('click', '#BUT_LIST_DEL', function () {
            if (parseFloat(sum) < 1) {
                layer.msg('请至少选择一项', {icon: 2})
            } else {
                var data = layui.table.checkStatus('test').data;
                var dataIds = '';
                for (var i = 0; i < data.length; i++) {
                    dataIds += data[i].DATA_ID + ',';
                }
                layer.confirm('确定删除选中的' + sum + '条数据吗？', {
                    btn: ['确定', '取消'], //按钮
                    title: "删除"
                }, function () {
                    //确定删除，调接口
                    $.ajax({
                        url: '/gdata/deleteByDataIds',
                        type: 'get',
                        data: {
                            tabId: tabId,
                            dataIds: dataIds
                        },
                        dataType: 'json',
                        success: function (obj) {
                            if (obj.flag) {
                                layer.closeAll();
                                layui.table.reload('test');
                                setTimeout(function () {
                                    layer.msg('删除成功!', {icon: 1})
                                }, 0)
                            }
                        }
                    })

                }, function () {
                    layer.closeAll();
                });
            }
        })
        // 导入
        $(document).on('click', '#BUT_LIST_IN', function () {
            layui.layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title: '导入',
                maxmin: true,
                btn: ['确定'], //可以无限个按钮
                content: '<form id="ajaxform" style="background-color: #fff;margin: 0;" method="post" class="layui-form" action="/gdata/imports" enctype="multipart/form-data">\n' +
                    ' <div class="layui-form-item" style=" padding-top: 20px">\n' +
                    '    <label class="layui-form-label" style="width: 200px;">下载导入模板:</label>\n' +
                    '    <div class="layui-input-block" style="line-height: 38px;">\n' +
                    '       <a href="javascript:;" id="download" style="color: #1E9FFF">导入模板下载</a>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    ' <div class="layui-form-item" style=" padding-top: 20px">\n' +
                    '    <label class="layui-form-label" style="width: 200px;">选择导入文件:</label>\n' +
                    '    <div class="layui-input-block" style="line-height: 38px;">\n' +
                    '       <input type="file" name="file" style="margin-top:6px;" value="请选择文件"/>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '    </form>',
                success: function () {
                    $('#download').click(function () {
                        window.location.href = '/gdata/export?tabId=' + tabId + '&state=download'
                    })

                },
                yes: function (index) {
                    if ($('input[name="file"]').val() == "") {
                        layer.msg("请选择要导入的文件！", {icon: 2});
                        return false;
                    }
                    $('#ajaxform').ajaxSubmit({
                        dataType: 'json',
                        data: {
                            tabId: tabId
                        },
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('导入成功', {icon: 1});
                                layui.table.reload('test');
                            } else {
                                layer.msg('导入失败', {icon: 2});
                            }
                            layui.layer.close(index);
                        },
                        error: function (error) {
                            layer.msg('导入失败', {icon: 2});
                        }
                    });
                }
            });
        })
        // 导出
        $(document).on('click', '#BUT_LIST_OUT', function () {
            window.location.href = '/gdata/selectAll?tabId=' + tabId + '&state=export&strJson=' + encodeURI(JSON.stringify(returnSerData()))
        })

        $(document).on('click', '#dayin', function () {
            layer.msg('该功能尚在开发中！', {icon: 6});
            // if(sum < 1){
            //     layer.msg('请选择打印数据！',{icon:0});
            //     return false;
            // }
            // var url = '';
            // var codeNo1 = $("#visitLocation").val()
            // var codeOrder1 = $("#visitLocation").val()
            // var address1= $("#visitLocation").find("option:selected").text()
            // var address2=decodeURI(address1);
            // layer.open({
            //     type: 1,
            //     title: "生成二维码",//标题
            //     area: ['100%', '100%'],
            //     offset:'0px',
            //     content: '<div id="code">\n' +
            //         '        <center> <div id="qrcode"  style="margin-top: 100px"></div></center>\n' +
            //         '    </div><center><strong><p style="margin-top: 30px;font-size: 30px">'+address1+'</p></strong></center>',
            //     btn:['<i class="layui-icon" style="margin-right: 10px;">&#xe609</i>下载图片','打印','取消'],
            //     //绑定第一个按钮的点击事件
            //     btn1: function(index) {
            //         var img=$('#qrcode img')                       // 获取要下载的图片
            //         var url = img[0].src;                            // 获取图片地址
            //         var a = document.createElement('a');          // 创建一个a节点插入的document
            //         var event = new MouseEvent('click')           // 模拟鼠标click点击事件
            //         a.download = '二维码'                      // 设置a节点的download属性值
            //         a.href = url;                                 // 将图片的src赋值给a节点的href
            //         a.dispatchEvent(event)
            //     },
            //     btn2: function(index) {
            //         window.open('/gapp/QRcode?codeOrder1='+codeOrder1+'&address2='+address2)
            //     }
            // });
            //
            // // 设置要生成二维码的链接
            // new QRCode(document.getElementById("qrcode"), {
            //     text: location.origin+'/Antiepidemic/antiepidemicH5?codeNo='+codeNo1,
            //     width: 300,
            //     height: 300
            // });
        })
        $(document).on('click', '#tj', function () {
            layer.msg('该功能尚在开发中！', {icon: 6});

        })
    });
    function createTableItems(tableObj,data,type){
        var tabId = '#COL' + tableObj.colId;
        var tableObjcolStyle = JSON.parse(tableObj.colStyle);
        var column = [[
            {
                type: 'checkbox',
                hide: type == 'add' ? false : true
            },
            {type: 'numbers', title: '序号', width: 60},
            {
                field: 'TITLES',
                title: '数据标题',
                event: 'TITLES',
                width:'20%',
                templet: function (d) {
                    var titlesArr = []
                    var objects = toAjaxTG('/gcolumn/selecttabidAlls', {tabId: tableObj.tabId});
                    if (objects.flag) {
                        if (objects.obj.length > 0) {
                            for (var k = 0; k < objects.obj.length; k++) {
                                if (tableObj.colId == objects.obj[k].colId) {
                                    var subDataTitleArr = objects.obj[k].subDataTitle ? objects.obj[k].subDataTitle.split(',') : [];
                                    for (var l = 0; l < subDataTitleArr.length; l++) {
                                        if (subDataTitleArr[l]) {
                                            debugger
                                            var dkey = 'COL' + subDataTitleArr[l];
                                            // tableObj.colName + '.' + d[dkey]
                                            titlesArr.push(d[dkey]);
                                        }
                                    }
                                }
                            }

                        }
                    }
                    return '<span title="'+titlesArr.join(' ')+'" style="line-height: 20px;">'+titlesArr.join(' ') + '</span>'
                }
            }
        ]];
        var datas = data;
        for(var i=0; i<tableObjcolStyle.length; i++) {
            var obj = {};
            (function(i){
                switch (tableObjcolStyle[i].colType) {
                    case 'C01':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            templet: function (d) {
                                var v = 'COL' + field
                                if(d[v]) {
                                    var val = d[v]
                                }else{
                                    var val = ''
                                }
                                var str = '<input type="text" lay-verify="title" value="'+val+'" autocomplete="off" placeholder="请输入" class="layui-input" id="COL' + field + '" name="COL' + field + '"></div>';
                                // console.log('str',str)
                                return str;
                            }
                        }
                        break;

                    case 'C02':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            templet: function (d) {
                                var v = 'COL' + field
                                if(d[v]) {
                                    var val = d[v]
                                }else{
                                    var val = ''
                                }
                                var str = '<textarea placeholder="请输入"  class="layui-textarea" style="resize: none!important;height:100%!important;min-height: 0px!important;" rows="' + colStyle + '" colKtype="' + colKtype + '" value="' + defaultVal + '" placeholder="' + isHasTips(inputTips) + '" id="COL' + field + '" name="COL' + field + '">'+val+'</textarea>';
                                // console.log('str',str)
                                return str;
                            }
                        }
                        break;

                    case 'C03':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        var colStyles = tableObjcolStyle[i].colStyle
                        var colKtypes = tableObjcolStyle[i].colKtype
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            event:'dateCh',
                            templet: function (d) {
                                var v = 'COL' + field
                                if(d[v]) {
                                    var val = d[v]
                                }else{
                                    var val = ''
                                }
                                var str = '<input type="text" lay-verify="title" readonly value="'+val+'"  autocomplete="off" placeholder="请选择" colKtype="' + colKtypes + '" colStyle="' + colStyles + '" class="layui-input dateTm" id="COL' + field +d.LAY_INDEX+ '" name="COL' + field + '"/>';

                                return str;
                            }
                        }
                        break;

                    case 'C04':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            templet: function (d) {
                                var v = 'COL' + field
                                if(d[v]) {
                                    var val = getNowNum(d[v],colKtype)
                                }else{
                                    var val = ''
                                }
                                var str = '<input type="text" lay-verify="title" num="num" value="'+val+'" autocomplete="off" placeholder="请输入" colKtype="' + colKtype + '" colStyle="' + colStyle + '" class="layui-input numTm" id="COL' + field +d.LAY_INDEX+ '" name="COL' + field + '"/>';

                                return str;
                            }
                        }
                        break

                    case 'C05':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            templet: function (d) {
                                var radioStr = '';
                                for (var j = 0; j < itemObj.selectOption.length; j++) {
                                    (function (j){
                                        if (itemObj.selectOption[j] == itemObj.selectedOption[0]) {
                                            radioStr += '<input type="radio" colKtype="' + colKtype + '" title="' + itemObj.selectOption[j] + '" checked="" name="COL' + field +d.LAY_INDEX+ '" autocomplete="off" class="layui-input bian">'
                                        } else {
                                            radioStr += '<input type="radio" colKtype="' + colKtype + '" title="' + itemObj.selectOption[j] + '"  name="COL' + field +d.LAY_INDEX+ '" autocomplete="off" class="layui-input bian">'
                                        }
                                    })(j)
                                }

                                var str =  '<div class="layui-input-inline" name="COL' + field + '" style="width:100%">' +
                                    radioStr +
                                    '</div>'
                                // console.log('str',str)
                                return str;
                            }
                        }
                        break;
                    case 'C06':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                        var cheStr = '';
                        for (var j = 0; j < itemObj.selectOption.length; j++) {
                            cheStr += '<input type="checkbox" name="COL' + tableObjcolStyle[i].colId + '" lay-skin="primary" title="' + itemObj.selectOption[j] + '">'
                        }
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:300,
                            templet: function (d) {
                                var str =  '<div class="layui-input-inline" name="COL' + field + '" style="width:100%">' +
                                    cheStr +
                                    '</div>'
                                // console.log('str',str)
                                return str;
                            }
                        }
                        break;

                    case 'C07':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        var itemObj = JSON.parse(tableObjcolStyle[i].colStyle);
                        var selectStr = '<option></option>';
                        for (var j = 0; j < itemObj.selectOption.length; j++) {
                            if (itemObj.selectOption[j] == itemObj.selectedOption[0]) {
                                selectStr += '<option selected="selected" value="' + itemObj.selectOption[j] + '">' + itemObj.selectOption[j] + '</option>'
                            } else {
                                selectStr += '<option value="' + itemObj.selectOption[j] + '">' + itemObj.selectOption[j] + '</option>'
                            }
                        }
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:200,
                            templet: function (d) {
                                var str =  '<div class="table-content"><select name="COL' + field + '">' + selectStr + '</select></div>'
                                // console.log('str',str)
                                return str;
                            }
                        }
                        break;

                    case 'C08':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:500,
                            templet: function (d) {
                                var str =  '           <div class="filesItems" style="width:100%;height: 100%;margin: 0;border: none;">\n' +
                                    '               <div class="layui-inline" style="width:100%;height: 100%;display:block;">\n' +
                                    '                  <div class="layui-input-block" style="margin: 0">\n' +
                                    '                    <div id="COL' + field +d.LAY_INDEX+'" name="COL' + field + '" class="files">' +
                                    '                        <input id="COL' + field +d.LAY_INDEX+ '_id" type="hidden" name="attachmentId">' +
                                    '                        <input id="COL' + field +d.LAY_INDEX+ '_name" type="hidden" name="attachmentName"></div>' +
                                    '                    <div id="COL' + field +d.LAY_INDEX+ 'b" class="fileBoxs" style="float: left;max-width:500px;overflow:hidden;text-overflow:ellipsis;">\n' +
                                    '                    </div>\n' +
                                    '                    <a href="javascript:;" class="openFile" style="margin-left:10px;float: left;position:relative">\n' +
                                    '                        <img src="../img/mg11.png" alt="">\n' +
                                    '                        <span>添加附件</span>\n' +
                                    '                        <input type="file" style="height: 100%;" class="upfiles" name="file" id="COL' + field +d.LAY_INDEX+ 'u" data-url="/upload?module=gapp">\n' +
                                    '                    </a>\n' +
                                    '                   </div>' +
                                    '               </div>\n'
                                return str;
                            }
                        }
                        break;

                    case 'C09':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:500,
                            templet: function (d) {
                                var str =  '           <div class="filesItems" style="width:100%;height: 100%;margin: 0;border: none;">\n' +
                                    '               <div class="layui-inline" style="width:100%;height: 100%;display:block;">\n' +
                                    '                  <div class="layui-input-block" style="margin: 0">\n' +
                                    '                    <div id="COL' + field +d.LAY_INDEX+ '" name="COL' + field + '" class="files">' +
                                    '                        <input id="COL' + field +d.LAY_INDEX+ '_id" type="hidden" name="attachmentId">' +
                                    '                        <input id="COL' + field +d.LAY_INDEX+ '_name" type="hidden" name="attachmentName"></div>' +
                                    '                    <div id="COL' + field +d.LAY_INDEX+ 'b" class="fileBoxs" style="float: left;max-width:500px;overflow:hidden;text-overflow:ellipsis;">\n' +
                                    '                    </div>\n' +
                                    '                    <a href="javascript:;" class="openFile" style="margin-left:10px;float: left;position:relative">\n' +
                                    '                        <img src="../img/mg11.png" alt="">\n' +
                                    '                        <span>添加附件</span>\n' +
                                    '                        <input type="file" style="height: 100%;" class="upfiles" name="file" id="COL' + field +d.LAY_INDEX+ 'u" data-url="/upload?module=gapp">\n' +
                                    '                    </a>\n' +
                                    '                   </div>' +
                                    '               </div>\n'
                                return str;
                            }
                        }
                        break;

                    case 'C16':
                        var title = tableObjcolStyle[i].colName
                        var field = tableObjcolStyle[i].colId
                        var colStyle = tableObjcolStyle[i].colStyle
                        var colKtype = tableObjcolStyle[i].colKtype
                        var defaultVal = tableObjcolStyle[i].defaultVal
                        var inputTips = tableObjcolStyle[i].inputTips
                        obj = {
                            title: title,
                            field:'CLO'+field,
                            width:130,
                            templet: function (d) {
                                var str =  '<input type="checkbox" value="0" name="COL' + field + '" lay-skin="switch" lay-text="是|否">'
                                return str;
                            }
                        }
                        break;
                }
            })(i)
            var keys = 'CLO'+tableObjcolStyle[i].colId;
            if(datas.length > 0) {
                datas[0][keys] = ''
                // datas[1]['CLO'+tableObjcolStyle[i].colId] = ''
                datas[0]['sort'] = 0
                // datas[1]['sort'] = 1
            }
            column[0].push(obj);
        }
        layui.table.render({
            elem:tabId
            , page: false
            , title: '用户数据表'
            , cols: column
            ,data:datas
            , done: function (res) {
                if (res.data.length > 0) {
                    $('.table-col .layui-table-header').eq(0).css('overflow', 'hidden');
                } else {
                    $('.table-col .layui-table-header').eq(0).css('overflow', 'auto');
                }
                var len1 = res.data.length;
                var arr = []
                var arr1 = [];
                for(var i = 0;i<len1;i++){
                    var obj = {colType:'C03'};
                    var obj1 = {colType:'C04'};
                    obj.colKtype = $(tabId).next().find('.dateTm').eq(i).attr('colktype')
                    obj.colStyle = $(tabId).next().find('.dateTm').eq(i).attr('colstyle')
                    obj1.colKtype = $(tabId).next().find('.numTm').eq(i).attr('colktype')
                    obj1.colStyle = $(tabId).next().find('.numTm').eq(i).attr('colstyle')
                    arr.push(obj);
                    arr1.push(obj1);
                    $(tabId).next().find('select').eq(i).parents('.layui-table-cell').addClass('abc')
                    $(tabId).next().find('.dateTm').eq(i).removeAttr('lay-key');
                    for(var j=0; j<$(tabId).next().find('.layui-table-body tr').eq(i).find('.upfiles').length; j++) {
                        fileuploadFns('#' + $(tabId).next().find('.layui-table-body tr').eq(i).find('.upfiles').eq(j).attr('id'), $('#' + $(tabId).next().find('.layui-table-body tr').eq(i).find('.upfiles').eq(j).parents('a.openFile').prev().attr('id')));
                    }

                    (function (i){
                        returnDataC(res.data[i],i,tabId,type)
                    })(i)
                }
                childReturnDates(arr,$(tabId).next().find('.dateTm'));
                childReturnDates(arr1,$(tabId).next().find('.numTm'));
            }
            , limit: 10000
        })
    }
    // 子表回显数据
    function returnDataC(data,index,doms,type) {
        var i = index;
        var tabId = doms
        for(var item in data) {

            if($(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="radio"][name="'+item+(i+1)+'"]').length>0){
                for(var j=0;j<$(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="radio"][name="'+item+(i+1)+'"]').length;j++){
                    if($(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="radio"][name="'+item+(i+1)+'"]').eq(j).attr('title') == data[item]){
                        $(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="radio"][name="'+item+(i+1)+'"]').eq(j).prop('checked',true);
                        layui.form.render();
                    }
                };
            }
            if($(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').length>0){
                if(data[item] != '' && data[item] != undefined){
                    var arr = data[item].split(',');
                    for(var j=0;j<arr.length;j++){
                        (function (j) {
                            if(arr[j] != ''){
                                for(var ch=0;ch<$(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').length;ch++){
                                    if($(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').eq(ch).attr('title') == arr[j]){
                                        $(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="primary"][name="'+item+'"]').eq(ch).prop('checked',true);
                                        layui.form.render();
                                    }
                                }
                            }
                        })(j)
                    };
                }
            }
            if($(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').length>0){
                if(data[item] != '' && data[item] != undefined){
                    var arr = data[item].split(',');
                    for(var j=0;j<arr.length;j++){
                        if(arr[j] != ''){
                            if(arr[j] == '是'){
                                $(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').eq(j).prop('checked',true);
                                layui.form.render();
                            }else {
                                $(tabId).next().find('.layui-table-body tr').eq(i).find('input[type="checkbox"][lay-skin="switch"][name="'+item+'"]').eq(j).prop('checked',false);
                                layui.form.render();
                            }
                        }
                    };
                }
            }
            if($(tabId).next().find('.layui-table-body tr').eq(i).find('select[name="'+item+'"]').length>0){
                $(tabId).next().find('.layui-table-body tr').eq(i).find('select[name="'+item+'"]').find('option[value="'+data[item]+'"]').prop('selected', 'ture');
                layui.form.render('select');
            }
            if(item.indexOf('_ATTACHMENTLIST')>-1){


                var fileArr = data[item];
                var str = '';
                for (var jx = 0; jx < fileArr.length; jx++) {
                    var fileExtension = fileArr[jx].attachName.substring(fileArr[jx].attachName.lastIndexOf(".") + 1, fileArr[jx].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(fileArr[jx].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = fileArr[jx].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[jx].size;

                    /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                    str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[jx].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[jx].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[jx].aid + '@' + fileArr[jx].ym + '_' + fileArr[jx].attachId + ',">' +
                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px;display: none;"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                        '<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[jx].aid + '@' + fileArr[jx].ym + '_' + fileArr[jx].attachId + ',"></div>';
                    str+='<input type="hidden" class="itemVal" value='+JSON.stringify(fileArr[jx]).replace(/\s*/g,"")+'></input>'
                }

                $(tabId).next().find('.layui-table-body tr').eq(i).find('div[name="'+item.split('_ATTACHMENTLIST')[0]+'"]').next('.fileBoxs').append(str)
                // $('#'+item.split('_ATTACHMENTLIST')[0]+(i+1)+'b').append(str);

            }
        }
        if(type == 'edit') {
            $(tabId).next().find('input[type="text"]').css('background-color','#d2d2d2')
            $(tabId).next().find('textarea').css('background-color','#d2d2d2')
            for(var i=0;i<$(tabId).next().find('input').length;i++){
                $(tabId).next().find('input').eq(i).prop('disabled',true);
                layui.form.render();
            }
            for(var i=0;i<$(tabId).next().find('textarea').length;i++){
                $(tabId).next().find('textarea').eq(i).prop('disabled',true);
                layui.form.render();
            }
            for(var i=0;i<$(tabId).next().find('select').length;i++){
                $(tabId).next().find('select').eq(i).attr("disabled","disabled");
                layui.form.render('select');
            }
            for(var i=0;i<$(tabId).next().find('.filesItems').length;i++){
                if($(tabId).next().find('.filesItems').eq(i).find('.openFile').length>0){
                    $(tabId).next().find('.filesItems').eq(i).find('.openFile').hide();
                    $(tabId).next().find('.filesItems').eq(i).find('.deImgs').hide();
                }
            }
        }

    }
    function getData() {
        var $inplen = $('.formBox input[type="text"]').not($('.table-col input[type="text"]'));
        var $ralen = $('.formBox input[type="radio"]').not($('.table-col input[type="radio"]'));
        var $schelen = $('.formBox input[type="checkbox"][lay-skin="switch"]').not($('.table-col input[type="checkbox"][lay-skin="switch"]'));
        var $selectlen = $('.formBox select').not($('.table-col select'));
        var $pchelen = $('.formBox input[type="checkbox"][lay-skin="primary"]').not($('.table-col input[type="checkbox"][lay-skin="primary"]'));
        var $textlen = $('.formBox textarea').not($('.table-col textarea'));
        var $filelen = $('.formBox a.openFile').not($('.table-col a.openFile'));
        var obj = {};
        for (var i = 0; i < $inplen.length; i++) {
            if ($inplen.eq(i).parents('.layui-form-select').length > 0) {

            } else {
                if ($inplen.eq(i).attr('num') == 'num' && $inplen.eq(i).attr('num') != undefined) {
                    if ($inplen.eq(i).val().indexOf('%') > -1) {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val().replace('%', '');
                    } else if ($inplen.eq(i).val().indexOf(',') > -1) {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val().replaceAll(',', '');
                    } else {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                    }
                } else {
                    if ($inplen.eq(i).attr('name') == 'CREATE_USER_ID') {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).attr('data-id');
                    } else if ($inplen.eq(i).attr('name') == 'UPDATE_TIME') {
                        if ($inplen.eq(i).val() == '') {
                            obj[$inplen.eq(i).attr('name')] = null;
                        } else {
                            obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                        }
                    } else {
                        if ($inplen.eq(i).val() == '') {
                            obj[$inplen.eq(i).attr('name')] = null;
                        } else {
                            obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                        }
                    }
                }

            }
        }
        for (var i = 0; i < $ralen.length; i++) {
            if ($ralen.eq(i).next('.layui-form-radioed').length > 0) {
                obj[$ralen.eq(i).attr('name')] = $ralen.eq(i).attr('title')
            }
        }
        for (var i = 0; i < $schelen.length; i++) {
            obj[$schelen.eq(i).attr('name')] = $schelen.eq(i).next('.layui-form-switch').text();
        }
        for (var i = 0; i < $pchelen.length; i++) {
            var dom = $pchelen.eq(i).parent('.layui-input-inline').find('input');
            var str = ''
            for (var j = 0; j < dom.length; j++) {
                if (dom.eq(j).next('.layui-form-checked').length > 0) {
                    str += dom.eq(j).attr('title') + ','
                }
            }
            if (str == '') {
                obj[$pchelen.eq(i).attr('name')] = null;
            } else {
                obj[$pchelen.eq(i).attr('name')] = str;
            }
        }
        for (var i = 0; i < $textlen.length; i++) {
            if ($textlen.eq(i).attr('name') == 'OWNER_USER_ID') {
                if ($textlen.eq(i).attr('user_id') != undefined && $textlen.eq(i).attr('user_id') != '') {
                    obj['OWNER_USER_ID'] = $textlen.eq(i).attr('user_id')
                } else {
                    obj['OWNER_USER_ID'] = '';
                }

            } else if ($textlen.eq(i).attr('name') == 'DEPT_ID') {
                if ($textlen.eq(i).attr('deptid') != undefined && $textlen.eq(i).attr('deptid') != '') {
                    obj['DEPT_ID'] = $textlen.eq(i).attr('deptid')
                } else {
                    obj['DEPT_ID'] = '';
                }

            } else {
                obj[$textlen.eq(i).attr('name')] = $textlen.eq(i).val();
            }
        }
        for (var i = 0; i < $selectlen.length; i++) {
            obj[$selectlen.eq(i).attr('name')] = $selectlen.eq(i).next('.layui-form-select').find('dl dd.layui-this').attr('lay-value');
        }
        for (var i = 0; i < $filelen.length; i++) {
            var dom = $filelen.eq(i).prev('div').find('.dech');
            var str = ''
            var str1 = ''
            if (dom.length > 0) {

                for (var j = 0; j < dom.length; j++) {
                    str += dom.eq(j).find('a').eq(0).attr('name');
                    str1 += dom.eq(j).find('input.inHidden').attr('value');
                }

            }
            obj[$filelen.eq(i).prev('div').attr('id') + '_ID'] = str1;
            obj[$filelen.eq(i).prev('div').attr('id') + '_NAME'] = str;
        }
        for (var item in obj) {
            if (obj[item] == '' || obj[item] == undefined) {
                obj[item] = null
            }
        }
        return obj;
    }
    function insertColod(){
        var childTableCaids = [];
        var dom = $('.formBox .childTable')
        for(var i=0; i<dom.length; i++){
            childTableCaids.push($('.formBox .childTable').eq(i).attr('data-id'));
            var childObj=getChildData(childTableCaids[i])
            //表单子表新增接口
            $.ajax({
                url: '/gdata/insertColod',
                type: 'post',
                data: {
                    tabId: childTableCaids[i],
                    strJson: JSON.stringify(childObj)
                },
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag) {
                        layer.closeAll();
                        layui.table.reload('test');
                        setTimeout(function () {
                            layer.msg('新增成功!', {icon: 1})
                        })
                    }
                }
            });
        }
    }
    function moreData(doms) {
        var len = doms.find('tr');
        var arrAll = [];
        for(var j=0; j<len.length; j++) {
            (function (j){
                arrAll.push(getChildData(len.eq(j)))
            })(j)
        }
        return arrAll
    }
    function getChildData(doms){
        var $inplen = doms.find('input[type="text"]');
        var $ralen = doms.find('input[type="radio"]');
        var $schelen = doms.find('input[type="checkbox"][lay-skin="switch"]').not(doms.find('input[name="layColCheck"]'));
        var $selectlen = doms.find('select');
        var $pchelen = doms.find('input[type="checkbox"][lay-skin="primary"]').not(doms.find('input[name="layColCheck"]')).not(doms.find('input[name="layTableCheckbox"]'));
        var $textlen = doms.find('textarea');
        var $filelen = doms.find('a.openFile');
        var obj = {};
        for (var i = 0; i < $inplen.length; i++) {
            if ($inplen.eq(i).parents('.layui-form-select').length > 0) {

            } else {
                if ($inplen.eq(i).attr('num') == 'num' && $inplen.eq(i).attr('num') != undefined) {
                    if ($inplen.eq(i).val().indexOf('%') > -1) {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val().replace('%', '');
                    } else if ($inplen.eq(i).val().indexOf(',') > -1) {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val().replaceAll(',', '');
                    } else {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                    }
                } else {
                    if ($inplen.eq(i).attr('name') == 'CREATE_USER_ID') {
                        obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).attr('data-id');
                    } else if ($inplen.eq(i).attr('name') == 'UPDATE_TIME') {
                        if ($inplen.eq(i).val() == '') {
                            obj[$inplen.eq(i).attr('name')] = null;
                        } else {
                            obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                        }
                    } else {
                        if ($inplen.eq(i).val() == '') {
                            obj[$inplen.eq(i).attr('name')] = null;
                        } else {
                            obj[$inplen.eq(i).attr('name')] = $inplen.eq(i).val();
                        }
                    }
                }

            }
        }
        for (var i = 0; i < $ralen.length; i++) {
            if ($ralen.eq(i).next('.layui-form-radioed').length > 0) {
                obj[$ralen.eq(i).parents('div.layui-input-inline').attr('name')] = $ralen.eq(i).attr('title')
            }
        }
        for (var i = 0; i < $schelen.length; i++) {
            obj[$schelen.eq(i).attr('name')] = $schelen.eq(i).next('.layui-form-switch').text();
        }
        for (var i = 0; i < $pchelen.length; i++) {
            var dom = $pchelen.eq(i).parent('.layui-input-inline').find('input');
            var str = ''
            for (var j = 0; j < dom.length; j++) {
                if (dom.eq(j).next('.layui-form-checked').length > 0) {
                    str += dom.eq(j).attr('title') + ','
                }
            }
            if (str == '') {
                obj[$pchelen.eq(i).attr('name')] = null;
            } else {
                obj[$pchelen.eq(i).attr('name')] = str;
            }
        }
        for (var i = 0; i < $textlen.length; i++) {
            if ($textlen.eq(i).attr('name') == 'OWNER_USER_ID') {
                if ($textlen.eq(i).attr('user_id') != undefined && $textlen.eq(i).attr('user_id') != '') {
                    obj['OWNER_USER_ID'] = $textlen.eq(i).attr('user_id')
                } else {
                    obj['OWNER_USER_ID'] = '';
                }

            } else if ($textlen.eq(i).attr('name') == 'DEPT_ID') {
                if ($textlen.eq(i).attr('deptid') != undefined && $textlen.eq(i).attr('deptid') != '') {
                    obj['DEPT_ID'] = $textlen.eq(i).attr('deptid')
                } else {
                    obj['DEPT_ID'] = '';
                }

            } else {
                obj[$textlen.eq(i).attr('name')] = $textlen.eq(i).val();
            }
        }
        for (var i = 0; i < $selectlen.length; i++) {
            obj[$selectlen.eq(i).attr('name')] = $selectlen.eq(i).next('.layui-form-select').find('dl dd.layui-this').attr('lay-value');
        }
        for (var i = 0; i < $filelen.length; i++) {
            var dom = $filelen.eq(i).prev('div').find('.dech');
            var str = ''
            var str1 = ''
            if (dom.length > 0) {

                for (var j = 0; j < dom.length; j++) {
                    str += dom.eq(j).find('a').eq(0).attr('name');
                    str1 += dom.eq(j).find('input.inHidden').attr('value');
                }

            }
            obj[$filelen.eq(i).prev('div').prev('div').attr('name') + '_ID'] = str1;
            obj[$filelen.eq(i).prev('div').prev('div').attr('name') + '_NAME'] = str;
        }
        for (var item in obj) {
            if (obj[item] == '' || obj[item] == undefined) {
                obj[item] = null
            }
        }
        return obj;
    }

    function downLoadXls(res) {
        const link = document.createElement('a');  //创建一个a标签
        const blob = new Blob([res]);             //实例化一个blob出来
        link.style.display = 'none';
        link.href = URL.createObjectURL(blob);    //将后端返回的数据通过blob转换为一个地址
        //设置下载下来后文件的名字以及文件格式
        link.setAttribute(
            'download',
            `123.` + `xlsx`,     //upload为下载的文件信息 可以在外层包一个函数 将upload作为参数传递进来
        );
        document.body.appendChild(link);
        link.click();                            //下载该文件
        document.body.removeChild(link);
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</html>