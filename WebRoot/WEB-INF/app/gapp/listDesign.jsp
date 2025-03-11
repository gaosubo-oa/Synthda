<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/1/6
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>列表设计</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/css/gapp/design/form_design.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>


    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>


    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20220919.2"></script>
</head>
<style>
    .left{
        height: 100%;
        width: 83%;
        float: left;
        border-right: 1px solid rgb(239,241,247);
        background-color: white;
        padding: 16px 0 32px 0;
        overflow: hidden;
        overflow-y: auto;
        border-right: 5px solid white;
    }
    .right{
        height: 100%;
        background-color: white;
        width: 15%;
        float: right;
        padding: 16px 0px 32px 0px;
        overflow-y: auto;
    }
    .where1{
        height: 30px;
        line-height: 30px;
        padding-left: 15px;
        font-size: 14px;
        font-weight: 600;
        color: #304265;
    }
    .where2{
        padding-left: 15px;
    }
    .ji li{
        width: 30%;
        display: inline-block;
        margin-right: 45px;
        margin-bottom: 10px;
    }
    .you li{
        font-size: 14px;
        height: 30px;
        line-height: 30px;
        padding-left: 10px;
        width: 90%;
        border-left: 4px solid white;
        display: inline-block;
    }
    .you li div{
        display: inline-block;
        float: right;
    }
    /*.you li span{*/
    /*    display: none;*/
    /*}*/
    .you{
        margin-left: 15px;
    }
    .yous{
        margin-left: 15px;
        box-shadow: 2px 2px 7px black;
        background-color: white;
    }
    .yous li{
        font-size: 14px;
        height: 30px;
        line-height: 30px;
        padding-left: 10px;
        width: 90%;
    }
    .you li:hover{
        background-color: rgb(244,247,255);
        border-left: 4px solid rgb(94,144,255);
    }
    .layui-form-checkbox span{
        height: 100%;
    }
    .layui-input-block{
        margin: 0;
    }
    #asd li{
        float: left;
        width: 25%;
        height: 25px;
    }
    #asd1 li{
        float: left;
        width: 24%;
    }
    .zxc li{
        display: inline-block;
        height: 30px;
        width: 45%;
        line-height: 30px;
        text-align: center;
        border: 1px solid rgb(16,127,255);
    }
    .anniu{
        text-align: center;
    }
    .anniu li{
        border: 1px dashed rgb(221,221,221)!important;
        height: 30px!important;
        display: inline-block;
        width: 90%;
        line-height: 30px;
        margin-bottom: 5px;
        text-align: left;
        padding-left: 10px;
    }
    .action{
        width: 100%;
        height: 50px;
        text-align: center;
        line-height: 50px;
        border: 1px solid rgb(212,215,224);
        font-size: 14px;
    }
    .lie div{
        display: inline-block;
        margin-left: 25px;
    }
    .layui-table-body {
        overflow-x: hidden;
    }
    .moleft{
        height: 36px;
        line-height: 36px;
        width: 30%;
        text-align: center;
        display: inline-block;
        border: 1px solid rgb(207,207,207);
        position: relative;
        top: 0px;
        left: 5px;
    }
    .moright{
        width: 65%;
        display: inline-block;
    }
    .shizhi li{
        height: 40px;
        line-height: 40px;
    }
    #addss{
        display: inline-block;
        width: 80px;
        height: 35px;
        border-radius: 10px;
        text-align: center;
        line-height: 35px;
        margin-left: 30px;
        margin-bottom: 20px;
        border: 1px solid rgb(221,221,221);
    }
    ::-webkit-scrollbar {
        width: 10px;
        height: 10px;
    }
    ::-webkit-scrollbar-button,
    ::-webkit-scrollbar-button:vertical {
        display: none;
    }
    ::-webkit-scrollbar-track,
    ::-webkit-scrollbar-track:vertical {
        background-color: black;
    }
    ::-webkit-scrollbar-track-piece {
        background-color: #f5f5f5;
    }
    ::-webkit-scrollbar-thumb,
    ::-webkit-scrollbar-thumb:vertical {
        margin-right: 10px;
        background-color: #a6a6a6;
    }
    ::-webkit-scrollbar-thumb:hover,
    ::-webkit-scrollbar-thumb:vertical:hover {
        background-color: #aaa;
    }
    ::-webkit-scrollbar-corner,
    ::-webkit-scrollbar-corner:vertical {
        background-color: #535353;
    }
    ::-webkit-scrollbar-resizer,
    ::-webkit-scrollbar-resizer:vertical {
        background-color: #ff6e00;
    }
    #youb li div{
        margin-top: 6px;
    }
</style>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="background-color: rgb(243,245,248)">
    <span style="font-size: 18px;display: inline-block;position: absolute;top: 14px;left: 10px">应用名称:</span>
    <input type="text" id="tabName" style="margin-left: 45px">

    <ul class="layui-tab-title">
        <li id="biaoshe">表单设计</li>
        <li id="liushe">流程设计(开发中...)</li>
        <li class="layui-this" id="lieshe">列表设计</li>
        <li id="yingshe">应用设置</li>
    </ul>
</div>
<div class="bodys">
    <div id="header" style="margin-bottom: 2px;">
        <h1 style="display: inline-block;margin-top: 11px;margin-left: 20px;color: #107fff;font-size: 15px">可视化列表设计</h1>
        <div class="save" id="save"><img src="/ui/img/gapp/save.png" alt=""> 保存</div>
    </div>
    <div class="left">

        <div class="where" style="padding-left: 16px;padding-right: 16px;">
            <div class="where1">查询条件</div>
            <div>
                <div class="action">请从右侧面板添加查询条件</div>
                <div id="leftYou" class="layui-tab-item layui-show ji" style="padding-left: 15px">
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">合同名称</span><div style="width: 80%;display: inline-block"><input type="text" style="" name="name"  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                </div>
            </div>
        </div>
        <div class="listField" style="padding-left: 16px;padding-right: 16px">
            <div class="where1">列表字段</div>
            <table class="layui-hide" id="test" lay-filter="test"></table>
        </div>
    </div>
    <div class="right">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">字段设置</li>
                <li>列表设置</li>
            </ul>
            <div class="layui-tab-content" style="height: 100px;">
                <div class="layui-tab-item  layui-show">
                    <div class="where1" style="margin-top: 15px;">查询条件<span class="layui-icon layui-icon-add-1" id="condition" style="float: right;margin-right: 10px;"></span></div>
                    <form class="layui-form" action="">
                        <div id="yous" style="width: 240px;position: absolute;display: none;z-index: 999">
                            <div class="layui-form-item" pane="">
                                <div class="layui-input-block">
                                    <ul id="youss" class="yous" style="height: 345px;overflow: scroll;overflow-x: hidden;">
                                        <li><input name="like[write]" flag="false" data-type="all" lay-filter="yous" value="全选"  title="全选" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="拥有者"  title="拥有者" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="所属部门" title="所属部门" type="checkbox"  lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="创建时间" title="创建时间" type="checkbox"  lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="修改时间" title="修改时间" type="checkbox"  lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="合同类型" title="合同类型" type="checkbox"  lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="单行文本1" title="单行文本1" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="范本名称" title="范本名称" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="范本编号" title="范本编号" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="备注"  title="备注" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="日期"  title="日期" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="创建人"  title="创建人" type="checkbox" lay-skin="primary" draggable="true"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="流程状态" title="流程状态" type="checkbox" lay-skin="primary" draggable="true"></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </form>
                    <ul id="you" class="you">
                        <%--                            <li>合同类型<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                    </ul>
                    <form class="layui-form" action="" id="lieduan" style="z-index: 99;">
                        <div class="where1" style="margin-top: 15px;">列表字段(拖动排序)<span class="lie" style="margin-right: 10px;position: absolute;right: 0px;"><span style="position: relative;right: -20px;">全选</span><input name="likes[write]" value="全选" flag="false" title="" type="checkbox" data-type="all" lay-filter="you"  id="allInputUpdate" lay-skin="primary"></span></div>

                        <ul class="you" id="youb">
                            <%--                            <li>拥有者<input name="like11[write]" flag="false" lay-filter="you" value="A"  title="" data-value="拥有者" checked="" type="checkbox" lay-skin="primary"></li>--%>
                        </ul>
                    </form>
                </div>
                <div class="layui-tab-item">

                    <form class="layui-form" action="" lay-filter="example">

                        <div style="margin: 20px 15px">
                            <div>
                                <span style="font-weight: 600;font-size: 14px;color: #304265">开启视图</span>
                                <div class="layui-collapse" lay-accordion="" style="margin-top: 10px;">
                                    <div class="layui-colla-item">
                                        <h2 class="layui-colla-title" id="h2lie">列表视图</h2>
                                        <div class="layui-colla-content layui-show">
                                            <p>排序字段</p>
                                            <div style="margin-top: 5px;margin-bottom: 10px;">
                                                <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="">

                                                </select>
                                            </div>

                                            <p>排序方式</p>
                                            <div>
                                                <li style="display: inline-block"><input name="sex1" lay-filter="sex" title="降序" type="radio" checked="" value="1"></li>
                                                <li style="display: inline-block"><input name="sex1" lay-filter="sex" title="升序" type="radio" value="2"></li>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div style="margin-top: 20px">
                                <span style="font-weight: 600;font-size: 14px;color: #304265">批量操作</span>
                                <div>
                                    <li style="display: inline-block"><input name="sex" title="允许" type="radio" checked="" value="1"></li>
                                    <li style="display: inline-block"><input name="sex" title="不允许" type="radio" value="0"></li>
                                </div>
                            </div>
                            <div style="margin-top: 10px">
                                <span style="font-weight: 600;font-size: 14px;color: #304265">功能按钮</span>
                                <p id="gong" style="color:rgb(16,127,255);">设置</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
<script>
    var node = document.querySelector("#youb");
    var nodes = document.querySelector("#you");
    var draging = null;
    var dragings = null;
    node.addEventListener("dragstart",function(event){
        event.dataTransfer.setData("te", event.target.innerText); //不能使用text，firefox会打开新tab
        draging = event.target;
        console.log(draging);
    });
    node.ondragover = function(event) {
        //console.log("onDrop over");
        //取消默认行为
        event.preventDefault();
        var target = event.target;
        //因为dragover会发生在ul上，所以要判断是不是li
        if (target.nodeName === "LI") {
            if (target !== draging) {
                //getBoundingClientRect()用于获取某个元素相对于视窗的位置集合
                var targetRect = target.getBoundingClientRect();
                var dragingRect = draging.getBoundingClientRect();
                if (target) {
                    if (target.animated) {
                        return;
                    }
                }
                if (_index(draging) < _index(target)) {
                    //nextSibling 属性可返回某个元素之后紧跟的节点（处于同一树层级中）。
                    target.parentNode.insertBefore(draging, target.nextSibling);
                } else {
                    target.parentNode.insertBefore(draging, target);
                }
                console.log(_index(draging)+' ;;;'+ _index(target))
                _animate(dragingRect, draging);
                _animate(targetRect, target);
            }
        }
        // str+='<li name="'+datass[i]+'" draggable="true">'+datass[i]+'<span class="layui-icon layui-icon-delete del" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
        // $('#you').html(str)
        var doms = $('#youb li input');
        var colss = [[]];
        var colids = []
        for(var i=0; i<doms.length; i++) {
            colss[0].push({field: doms.eq(i).val(), title: doms.eq(i).attr('data-value')})
            if(doms.eq(i).attr('flag') == 'false'){
                colids.push(doms.eq(i).val())
            }
        };
        colId = colids;
        layui.table.reload("test", {
            cols: colss,
        })
    }
    //使用事件委托，将li的事件委托给ul
    nodes.addEventListener("dragstart",function(event){
        event.dataTransfer.setData("te", event.target.innerText); //不能使用text，firefox会打开新tab
        dragings = event.target;
        console.log(dragings);
    })
    nodes.ondragover = function(event) {
        //取消默认行为
        event.preventDefault();
        var target = event.target;
        //因为dragover会发生在ul上，所以要判断是不是li
        if (target.nodeName === "LI") {
            if (target !== dragings) {
                //getBoundingClientRect()用于获取某个元素相对于视窗的位置集合
                var targetRect = target.getBoundingClientRect();
                var dragingRect = dragings.getBoundingClientRect();
                if (target) {
                    if (target.animated) {
                        return;
                    }
                }
                if (_index(dragings) < _index(target)) {
                    //nextSibling 属性可返回某个元素之后紧跟的节点（处于同一树层级中）。
                    target.parentNode.insertBefore(dragings, target.nextSibling);
                } else {
                    target.parentNode.insertBefore(dragings, target);
                }
                _animate(dragingRect, dragings);
                _animate(targetRect, target);
            }
        }
    }
    //获取元素在父元素中的index
    function _index(el) {
        var index = 0;

        if (!el || !el.parentNode) {
            return -1;
        }
        //previousElementSibling属性返回指定元素的前一个兄弟元素（相同节点树层中的前一个元素节点）。
        while (el && (el = el.previousElementSibling)) {
            //console.log(el);
            index++;
        }

        return index;
    }

    function _animate(prevRect, target) {
        debugger
        var ms = 300;

        if (ms) {
            var currentRect = target.getBoundingClientRect();
            //nodeType 属性返回以数字值返回指定节点的节点类型。1=元素节点  2=属性节点
            if (prevRect.nodeType === 1) {
                prevRect = prevRect.getBoundingClientRect();
            }
            _css(target, 'transition', 'none');
            _css(target, 'transform', 'translate3d(' +
                (prevRect.left - currentRect.left) + 'px,' +
                (prevRect.top - currentRect.top) + 'px,0)'
            );

            target.offsetWidth; // 触发重绘
            //放在timeout里面也可以
            // setTimeout(function() {
            //     _css(target, 'transition', 'all ' + ms + 'ms');
            //     _css(target, 'transform', 'translate3d(0,0,0)');
            // }, 0);
            _css(target, 'transition', 'all ' + ms + 'ms');
            _css(target, 'transform', 'translate3d(0,0,0)');

            clearTimeout(target.animated);
            target.animated = setTimeout(function() {
                _css(target, 'transition', '');
                _css(target, 'transform', '');
                target.animated = false;
            }, ms);
        }
    }
    //给元素添加style
    function _css(el, prop, val) {
        var style = el && el.style;

        if (style) {
            if (val === void 0) {
                //使用DefaultView属性可以指定打开窗体时所用的视图
                if (document.defaultView && document.defaultView.getComputedStyle) {
                    val = document.defaultView.getComputedStyle(el, '');
                } else if (el.currentStyle) {
                    val = el.currentStyle;
                }

                return prop === void 0 ? val : val[prop];
            } else {
                if (!(prop in style)) {
                    prop = '-webkit-' + prop;
                }

                style[prop] = val + (typeof val === 'string' ? '' : 'px');
            }
        }
    }
    if(sessionStorage.getItem('save')){
        sessionStorage.removeItem('save')
        layer.msg('保存成功', {icon: 6});
    }
    var k;
    var rk;
    var lk;
    k = document.body.clientWidth
    rk = $(".right")[0].offsetWidth
    lk = k-rk-5-2
    $(".left").css('width',''+lk+'')

    $(window).resize(function(){
        k = document.body.clientWidth
        rk = $(".right")[0].offsetWidth
        lk = k-rk-5-2
        $(".left").css('width',''+lk+'')
    })
    var datass = [];
    var strs = '';
    var initSort;
    var field;
    var types;
    var colId;
    var listId;

    //获取地址栏参数
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var gappId = getQueryString('gappId')
    var typeId = getQueryString('typeId')

    var typeList = [

    ];

    layui.use(['form', 'table', 'element', 'layedit','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var upload = layui.upload;
        var sum=0;
        var asd =0;
        var datas = '';
        var selColIds;
        var showColIds;
        var listViewType;
        var listOrderCol;
        var listOrderType;
        var batchOperate;
        var tabId;
        var listButtons = 'BUT_LIST_ADD,BUT_LIST_IN,BUT_LIST_OUT,BUT_LIST_DEL'
        layui.element.render('collapse')
        var tableData = [];
        //固定列二维数组
        var col = [[

        ]];
        //动态列
        var subjectField = ["CREATE_USER_ID","CREATE_TIME","UPDATE_TIME","OWNER_USER_ID","DEPT_ID","DATA_ID"];
        var subjectTitle = ["创建人","创建时间","修改时间","拥有者","所属部门","流水号"];
        //日期时间范围
        laydate.render({
            elem: '#timeRange'
            , type: 'datetime'
            , range: '~'
            ,format: 'yyyy年MM月dd日'
        });
        //日期时间范围
        laydate.render({
            elem: '#timeRanges'
            , type: 'datetime'
            , range: '~'
            ,format: 'yyyy年MM月dd日'
        });
        form.render()
        // 支委会会议记录表格


        $(document).on("click", "#creat", function () {
            org_id="creat";
            $.popWindow("../common/selectPartyMember?0");
        })
        $(document).on("click", "#have", function () {
            org_id="have";
            $.popWindow("../common/selectPartyMember?0");
        })
        $('#dept').click(function () {
            dept_id = 'dept';
            $.popWindow("../common/selectDept?0&eduOrg=1");
        });
        $(document).on('click','#gong',function(){
            layer.open({
                type: 1,
                area: ['40%', '60%'], //宽高
                title: ['设置功能按钮','font-size:20px'],
                maxmin: false,
                btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '   <form class="layui-form" action="">\n' +
                    // '<p class="layui-icon layui-icon-add-1" id="addss" style="color:rgb(61,151,255);"><span style="color: rgb(137,137,137)">新增</span></p>\n'+
                    '<div class="anniu">' +
                    // '<li class="layui-icon layui-icon-add-1">新增</li><li class="layui-icon layui-icon-download-circle">导入</li><li class="layui-icon layui-icon-export">导出</li><li class="layui-icon layui-icon-delete" id="del">删除</li><li class="layui-icon layui-icon-print">打印二维码</li>\n' +
                    '<li class="layui-icon layui-icon-add-1" id="BUT_LIST_ADD">新增</li><li class="layui-icon layui-icon-download-circle" id="BUT_LIST_IN">导入</li><li class="layui-icon layui-icon-export" id="BUT_LIST_OUT">导出</li><li class="layui-icon layui-icon-delete" id="BUT_LIST_DEL">删除</li>\n' +
                    '</div>\n' +
                    '   </form>\n' +
                    '</div>',
                success: function () {

                },
                yes: function (index, layero) {
                    layer.close(index);

                    // for(var s=0;s<$(".anniu li").length;s++){
                    //     listButtons += $(".anniu li").eq(s).attr('id')+','
                    // }
                },
                btn2:function(index, layero){
                    layer.close(index);
                }
            });
        })
        form.on('radio(sex)', function (data) {
            field = $("#zhu").val()
            types = data.value
            if(types == '2'){
                types = 'asc'
            }else if(types == '1'){
                types = 'desc'
            }
            initSort = {field:field,type:types}
            table.reload("test", {
                initSort: initSort,
                where: {
                    field: initSort.field,
                    order: initSort.type
                }
            })
        });
        $(document).on('click','#web',function(){
            $("#web").css('background-color','rgb(16,127,255)')
            $("#web").css('color','white')
            $("#yidong").css('background-color','white')
            $("#yidong").css('color','black')
        })
        $(document).on('click','#yidong',function(){
            $("#yidong").css('background-color','rgb(16,127,255)')
            $("#yidong").css('color','white')
            $("#web").css('background-color','white')
            $("#web").css('color','black')
        })
        form.on('radio(ChoiceRadio)', function(data){
            var data = data.value
            // console.log(data); //被点击的 radio 的 value 值
            if(data == '列表'){
                $("#ChoiceRadio1").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio1").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '日历'){
                $("#ChoiceRadio2").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio2").css('color','white')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '时间轴'){
                $("#ChoiceRadio3").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio3").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '甘特图'){
                $("#ChoiceRadio4").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio4").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
            }
        });
        form.on('checkbox(check)', function(data){
            var data = data.value
            var flag = $(this).attr('flag')
            if(flag == 'false'){
                if(data == '日历'){
                    $(".list2").show()
                }
                if(data == '时间轴'){
                    $(".list3").show()
                }
                if(data == '甘特图'){
                    $(".list4").show()
                }
                $(this).attr('flag','true')
            }else {
                if(data == '日历'){
                    $(".list2").hide()
                }
                if(data == '时间轴'){
                    $(".list3").hide()
                }
                if(data == '甘特图'){
                    $(".list4").hide()
                }
                $(this).attr('flag','false')
            }

        })
        $(document).on('click','#condition',function(){
            if(asd == 0){
                $('#yous').show()
                asd = 1
            }else if(asd == 1){
                $('#yous').hide()
                asd =0
            }

        })
        form.on('checkbox(yous)',function(data){
            $('.action').hide()
            var type = $(data.elem).attr('data-type')
            var flag = $(data.elem).attr('flag')

            //全选
            if(type == 'all'){
                var strr = ''
                var str1 = ''
                var child = $("#youss input[type='checkbox']");
                child.each(function (index, item) {
                    item.checked = data.elem.checked;
                });
                form.render('checkbox');
                //获取checkbox[name='like']的值
                var arrs = new Array();
                $("input:checkbox[name='like1[write]']:checked").each(function(i){
                    datass[i] = $(this).val();
                    arrs[i] = $(this).attr('data-type')
                });
                // datass.splice(0,1)
                // arrs.splice(0,1)
                if(flag == 'false'){
                    //全选创建右侧列表
                    if(datass != undefined || datass != ''){
                        for (var i=0;i<datass.length;i++){
                            strr+='<li draggable="true">'+datass[i]+'<span class="layui-icon layui-icon-delete del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                        }
                        if(strr == undefined){
                            strr = ''
                        }
                        $('#you').html(strr)
                    }
                    // data.field.like = arr.join(",");//将数组合并成字符串
                    // console.log(data.field.like)
                    //全选创建左侧元素
                    for(var j=0;j<datass.length;j++){
                        if(arrs[j] == 'C04'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if (arrs[j] == 'C03'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C02'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }
                        else if(arrs[j] == 'C05'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C06'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C07'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C08'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C09'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C10'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C11'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C12'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C13'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C01'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C14'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C15'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'C16'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'L01'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'L02'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'L03'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'L04'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S01'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S02'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S03'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S04'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S05'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'S06'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }
                    }
                    // $(this).attr('flag','true')
                    $("#youss li input").attr('flag','true')
                }else{
                    $("#leftYou  li").remove()
                    $("#you li").remove()
                    // $(this).attr('flag','false')
                    $("#youss li input").attr('flag','false')
                    $('.action').show()
                    datass.length = 0
                }
            }else{
                var res = data.value
                // console.log('res',res)
                // console.log('data',data)
                if(flag == 'false'){
                    datass.push(data.value)
                    var str=''
                }else{
                    var index = datass.indexOf(res)
                    datass.splice(index,1)
                }

                if(flag == 'false'){
                    //添加右侧列表
                    if(data != undefined || data != ''){
                        var templateStr = ''
                        for (var i=0;i<datass.length;i++){
                            if(datass[i] == ''){

                            }else{
                                str+='<li name="'+datass[i]+'" draggable="true">'+datass[i]+'<span class="layui-icon layui-icon-delete del" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                            }
                        }
                        $('#you').html(str)
                    }
                    // 添加左侧元素
                    var templateStr = ''
                    for(var i = 0;i<datass.length;i++){
                        var nowType;
                        typeList.forEach(function(item,index,arr){
                            if(item.value == datass[i]){
                                nowType = item.type
                            }
                        })
                        if(nowType == 'C04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if (nowType == 'C03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }
                        else if(nowType == 'C05'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C06'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C07'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C08'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C09'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C10'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C11'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C12'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C13'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C14'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C15'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C16'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S05'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S06'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }
                        $('#leftYou').html(templateStr)
                    }
                    $(this).attr('flag','true')
                }else if(flag == 'true'){
                    $(this).attr('flag','false')
                    var liStr = ''
                    if(datass.length == '0'){
                        $("#leftYou li").remove()
                    }
                    for (var i=0;i<datass.length;i++){
                        if(datass[i] == ''){

                        }else{
                            liStr+='<li name="'+datass[i]+'" draggable="true">'+datass[i]+'<span class="layui-icon layui-icon-delete del" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                        }
                    }
                    $('#you').html(liStr)

                    var templateStr = ''
                    for(var i = 0;i<datass.length;i++){
                        var nowType;
                        typeList.forEach(function(item,index,arr){
                            if(item.value == datass[i]){
                                nowType = item.type
                            }
                        })
                        if(nowType == 'C04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if (nowType == 'C03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }
                        else if(nowType == 'C05'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C06'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C07'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType== 'C08'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C09'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C10'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C11'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C12'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C13'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C14'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C15'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'C16'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'L04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S01'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S02'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S03'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S04'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S05'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }else if(nowType == 'S06'){
                            templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(templateStr)
                        }
                        $('#leftYou').html(templateStr)
                    }
                    if(datass.length == '0'){
                        $('.action').show()
                    }
                }

                var arr = new Array();
                $("input:checkbox[name='like1[write]']:checked").each(function(i){
                    arr[i] = $(this).val();
                });
                var zong = $("#youss li").length-1
                if(arr.length != zong){
                    $('#youss li input').eq(0).attr('flag','false')
                    $('#youss li input').eq(0).removeAttr('checked');

                }else{
                    $('#youss li input').eq(0).attr('flag','true')
                    $("#youss li input").eq(0).prop("checked", true);
                }
                form.render()
            }

        })
        form.on('checkbox(you)',function(data){
            form.render('checkbox');
            var datas = $(data.elem).attr('data-type')
            var type = $(data.elem).attr('value')
            var flag = $(data.elem).attr('flag')
            var value = $(data.elem).attr('data-value')
            form.render()
            if(datas == 'all'){
                var field = $("thead th").eq(0).attr('data-field')
                var child = $("#youb input[type='checkbox']");
                child.each(function (index, item) {
                    item.checked = data.elem.checked;
                });
                if(flag == 'false'){
                    $(this).attr('flag','true')
                    $("#youb input[type='checkbox']").attr('flag','true')
                    $("[data-field]").hide()
                    $("[data-field="+field+"]").show()
                    $("#youb li input").eq(0).prop("checked",true)
                    $("#youb li input").eq(0).attr("flag",'false')
                }else{
                    $("#youb input[type='checkbox']").attr('flag','false')
                    $(this).attr('flag','false')
                    $("[data-field]").show()
                }

                form.render();
            }else{
                var arr = new Array();
                $("input:checkbox[name='like11[write]']:checked").each(function(i){
                    arr[i] = $(this).val();
                });
                if(arr.length == '0'){
                    layer.msg('列表字段至少要有一条')
                    $(this).prop("checked", true);
                    form.render()
                    return false
                }else{
                    var zong = $("#youb li").length
                    if(arr.length != zong){
                        $('.lie input').attr('flag','true')
                        $('.lie input').removeAttr('checked');

                    }else{
                        $('.lie input').attr('flag','false')
                        $(".lie input").prop("checked", true);
                    }
                    form.render()
                    if(flag == 'false'){
                        $("[data-field="+type+"]").hide()
                        $(this).attr('flag','true')
                    }else if(flag == 'true'){
                        $("[data-field="+type+"]").show()
                        $(this).attr('flag','false')
                    }
                }

            }

        })
        $(document).on('click','.del',function(res){
            var $this = $(this)
            var data = $this.parent()
            var index = datass.indexOf(data.text())
            var flag = $(res.elem).attr('flag')
            innerTexts = data[0].innerText

            for(var a=0;a<$('#youss li input').length;a++){
                // console.log($('#youss li input').eq(a+1).val())
                if($('#youss li input').eq(a+1).val() == innerTexts){
                    $('#youss li input').eq(a+1).attr('flag','false')
                    $('#youss li input').eq(a+1).attr('checked',false)
                    $('#youss li input').eq(0).attr('flag','false')
                    $('#youss li input').eq(0).attr('checked',false)
                    form.render("checkbox")
                }
            }
            datass.splice(index,1)
            $(this).attr('flag','false')
            var liStr = ''
            if(datass.length == '0'){
                $("#leftYou li").remove()
            }
            for (var i=0;i<datass.length;i++){
                if(datass[i] == ''){

                }else{
                    liStr+='<li draggable="true" name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete del" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                }
            }
            $('#you').html(liStr)

            var templateStr = ''
            for(var i = 0;i<datass.length;i++){
                var nowType;
                typeList.forEach(function(item,index,arr){
                    if(item.value == datass[i]){
                        nowType = item.type
                    }
                })
                if(nowType== 'C04'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if (nowType == 'C03'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C02'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }
                else if(nowType == 'C05'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C06'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType== 'C07'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C08'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C09'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C10'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C11'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C12'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C13'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C01'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C14'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C15'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'C16'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'L01'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'L02'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'L03'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'L04'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S01'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S02'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S03'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S04'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S05'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }else if(nowType == 'S06'){
                    templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                    $('#leftYou').html(templateStr)
                }
                $('#leftYou').html(templateStr)
            }
            if(datass.length == '0'){
                $('.action').show()
            }
        })
        $.ajax({
            url:'/gcolumn/findControl',
            data:{
                gappId:gappId
            },
            async:false,
            success:function(res){
                var data = res.object
                listId = data.glist.listId
                // var myShowColIds = data.glist.listOrderCol
                var myShowColIds = data.glist.listCloOrder
                // 左上角应用名称回显
                $("#tabName").val(data.gappName)
                // 右侧查询条件渲染
                var allGcolumnList = [

                ]
                var ballGcolumnList = [
                    {colId:'CREATE_USER_ID',colName:'创建人',colType:'S01'},
                    {colId:'CREATE_TIME',colName:'创建时间',colType:'S02'},
                    {colId:'UPDATE_TIME',colName:'修改时间',colType:'S03'},
                    {colId:'OWNER_USER_ID',colName:'拥有者',colType:'S04'},
                    {colId:'DEPT_ID',colName:'所属部门',colType:'S05'},
                    {colId:'DATA_ID',colName:'流水号',colType:'S06'}
                ]
                for(var p=0;p<data.allGcolumnList.length;p++){
                    if(data.allGcolumnList[p].colType == 'C08' || data.allGcolumnList[p].colType == 'C09' || data.allGcolumnList[p].colType == 'L02'){

                    }else if(data.allGcolumnList[p].colType == 'L01'){
                        var object = data.allGcolumnList[p].colStyle
                        var arr = JSON.parse(object)
                        delete arr.shareRatio
                        var arr1 = []
                        for (let i in arr) {
                            arr1.push(arr[i]); //属性
                            //arr.push(obj[i]); //值
                        }
                        for(var z=0;z<arr1.length;z++){
                            if(arr1[z].colId == undefined){

                            }else{
                                if(arr1[z].colType == 'S01' || arr1[z].colType == 'S02' || arr1[z].colType == 'S03' || arr1[z].colType == 'S04' || arr1[z].colType == 'S05' || arr1[z].colType == 'S06'){

                                }else{
                                    allGcolumnList.push(arr1[z])
                                }
                            }
                        }
                    }else{
                        allGcolumnList.push(data.allGcolumnList[p])
                    }
                }
                for(var p=0;p<data.allGcolumnList.length;p++){
                    if(data.allGcolumnList[p].colType == 'L02'){

                    }else if(data.allGcolumnList[p].colType == 'L01'){
                        var object = data.allGcolumnList[p].colStyle
                        var arr = JSON.parse(object)
                        delete arr.shareRatio
                        var arr1 = []
                        for (let i in arr) {
                            arr1.push(arr[i]); //属性
                            //arr.push(obj[i]); //值
                        }
                        for(var z=0;z<arr1.length;z++){
                            if(arr1[z].colId == undefined){

                            }else{
                                if(arr1[z].colType == 'S01' || arr1[z].colType == 'S02' || arr1[z].colType == 'S03' || arr1[z].colType == 'S04' || arr1[z].colType == 'S05' || arr1[z].colType == 'S06'){

                                }else{
                                    ballGcolumnList.push(arr1[z])
                                }
                            }
                        }

                    }else if(data.allGcolumnList[p].colType == 'S01' ||
                        data.allGcolumnList[p].colType == 'S02' ||
                        data.allGcolumnList[p].colType == 'S03' ||
                        data.allGcolumnList[p].colType == 'S04' ||
                        data.allGcolumnList[p].colType == 'S05' ||
                        data.allGcolumnList[p].colType == 'S06'
                    ){
                        system:for(let q=0;q<ballGcolumnList.length;q++){
                            if(data.allGcolumnList[p].colId == ballGcolumnList[q].colId){
                                ballGcolumnList[q].colName  = data.allGcolumnList[p].colName
                                break system;
                            }
                        }
                    }else{
                        ballGcolumnList.push(data.allGcolumnList[p])
                    }
                }
                // var myShowColIdsArr = [];
                if(myShowColIds && myShowColIds[0].field){
                    myShowColIds = JSON.parse(myShowColIds);
                    // myShowColIdsArr.push(myShowColIds)
                    for(var i=0;i<myShowColIds.length;i++){
                        for(var j=0;j<myShowColIds.length;j++){
                            if(ballGcolumnList[j] != undefined){
                                ballGcolumnList[j].colId = myShowColIds[j].field;
                                ballGcolumnList[j].colName = myShowColIds[j].title;
                            }else{
                                ballGcolumnList.push({colId: myShowColIds[j].field,colName: myShowColIds[j].title});
                            }
                        }
                    }
                }
                console.log(arr1)
                console.log(allGcolumnList)
                console.log(ballGcolumnList)
                var col = [[]]
                //动态添加列属性
                var showCoIdsList = data.glist.showColIds.split(',');
                var fieldColName = [];
                // console.log(showCoIdsList)
                for (var i = 0; i < ballGcolumnList.length; ++i) {
                    col[0].push({field: ballGcolumnList[i].colId, title: ballGcolumnList[i].colName});
                    // if(showCoIdsList[i] == 'CREATE_USER_ID'){
                    //     fieldColName[i] = '创建人';
                    // }else if(showCoIdsList[i] == 'CREATE_TIME'){
                    //     fieldColName[i]='创建时间';
                    // }else if(showCoIdsList[i] == 'UPDATE_TIME'){
                    //     fieldColName[i]='修改时间';
                    // }else if(showCoIdsList[i] == 'OWNER_USER_ID'){
                    //     fieldColName[i]='拥有者';
                    // }else if(showCoIdsList[i] == 'DEPT_ID'){
                    //     fieldColName[i]='所属部门';
                    // }else if(showCoIdsList[i] == 'DATA_ID'){
                    //     fieldColName[i]='流水号';
                    // }else if(showCoIdsList[i] == "8ea55dbe83b846a694872a3156eb3718"){
                    //     fieldColName[i]='单行文本';
                    // }else if(showCoIdsList[i] == "d3be53517ec0462d8aae562abdd25bf7"){
                    //     fieldColName[i]='附件';
                    // }
                    // console.log(fieldColName[i])
                    // col[0].push({field: showCoIdsList[i], title: fieldColName[i]});
                }

                var meetTable = table.render({
                    elem: '#test'
                    , url: '/branchCommitteeMeeting/queryList'
                    // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                        title: '提示'
                        , layEvent: 'LAYTABLE_TIPS'
                        , icon: 'layui-icon-tips'
                    }]
                    ,cols:col
                    , title: '用户数据表'
                    // ,id: 'idTest'
                    ,cellMinWidth:111
                    , parseData: function (res) { //res 即为原始返回的数据
                        // var data = json.obj
                        return {
                            "code": 0, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": 1, //解析数据长度
                            "data": tableData, //解析数据列表
                        };
                    }
                    ,done:function(res){
                        $("table").css("width","100%")
                        form.render()
                        $("[data-field]").hide()
                        colIdss()
                    }
                    , page: true
                })
                form.render()

                var str = '<li><input name="like[write]" flag="false" data-type="all" lay-filter="yous" value="全选"  title="全选" type="checkbox" lay-skin="primary"></li>'
                for(var i=0;i<allGcolumnList.length;i++){
                    var arrStr = {value:allGcolumnList[i].colName,type:allGcolumnList[i].colType };
                    typeList.push(arrStr)
                    str += '<li><input name="like1[write]" data-value="'+allGcolumnList[i].colId+'" flag="false" data-type="'+allGcolumnList[i].colType+'" lay-filter="yous" value="'+allGcolumnList[i].colName+'"  title="'+allGcolumnList[i].colName+'" type="checkbox" lay-skin="primary"></li>'
                }
                $("#youss").html(str)
                form.render()
                // 右侧查询条件回显
                var selColList = data.selColList
                if(selColList != '' || selColList != undefined){

                    var youss = $('#youss li input').length-1
                    var hui = [];
                    if(data.glist != '' || data.glist != undefined){
                        if(data.glist.selColIds != undefined){
                            var selColIds = data.glist.selColIds
                            selColIds = selColIds.split(',')
                            for(var f=0;f<selColIds.length;f++){
                                if(selColIds[f] == 'CREATE_USER_ID' || selColIds[f] == 'CREATE_TIME' || selColIds[f] == 'UPDATE_TIME' || selColIds[f] == 'OWNER_USER_ID' || selColIds[f] == 'DEPT_ID' || selColIds[f] == 'DATA_ID'){
                                    for(var g=0;g<youss;g++){
                                        if($("#youss li input").eq(g+1).attr('data-value') == selColIds[f]){
                                            $("#youss li input").eq(g+1).attr('flag','true')
                                            $("#youss li input").eq(g+1).attr('checked',true)
                                            datass.push($("#youss li input").eq(g+1).attr('value'))
                                        }
                                    }
                                }
                            }
                        }

                    }

                    for(var e=0;e<selColList.length;e++){
                        // hui += selColList[e].colName+','
                        hui.push({
                            colId:selColList[e].colId,
                            colName:selColList[e].colName,
                        })
                    }
                    if(hui.length){
                        $(".action").hide()
                        var zhui = JSON.parse(JSON.stringify(hui))
                        // zhui.pop()
                        for(var t=0;t<zhui.length;t++){
                            for(var r=0;r<youss;r++){
                                if($("#youss li input").eq(r+1).attr('value') == hui[t].colName){
                                    $("#youss li input").eq(r+1).attr('flag','true')
                                    $("#youss li input").eq(r+1).attr('checked',true)
                                }
                            }
                            if(zhui[t].colId == 'CREATE_USER_ID' || zhui[t].colId == 'CREATE_TIME' || zhui[t].colId == 'UPDATE_TIME' || zhui[t].colId == 'OWNER_USER_ID' || zhui[t].colId == 'DEPT_ID' || zhui[t].colId == 'DATA_ID'){

                            }else{
                                datass.push(zhui[t].colName)
                            }
                        }

                        console.log($("thead tr th").eq(1).parentNode)
                        for(var i=0; i<$("thead tr th").length; i++){
                            // console.log($("thead tr th").eq(i).attr('data-field'))
                            // console.log(_index($("thead tr th").eq(i)));
                        }
                        var str = ''
                        for (var i=0;i<datass.length;i++){
                            if(datass[i] == ''){


                            }else{
                                str+='<li draggable="true" name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete del" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                            }
                        }
                        $('#you').html(str)
                        var templateStr = ''

                        for(var y = 0;y<datass.length;y++){
                            var nowType;
                            typeList.forEach(function(item,index,arr){
                                if(item.value == datass[y]){
                                    nowType = item.type
                                }
                            })
                            if(nowType == 'C04'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if (nowType == 'C03'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C02'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }
                            else if(nowType == 'C05'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C06'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C07'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C08'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C09'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C10'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C11'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C12'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C13'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C01'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C14'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C15'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'C16'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'L01'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'L02'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'L03'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'L04'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S01'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S02'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S03'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S04'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S05'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }else if(nowType == 'S06'){
                                templateStr += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[y]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                                $('#leftYou').html(templateStr)
                            }
                            $('#leftYou').html(templateStr)
                        }
                    }else{

                    }

                }
                // 右侧列表字段渲染
                // var allGcolumnList = data.allGcolumnList
                var bstr = ''
                for(var q=0;q<ballGcolumnList.length;q++){
                    bstr += '<li draggable="true">'+ballGcolumnList[q].colName+'<input name="like11[write]" flag="true" lay-filter="you" value="'+ballGcolumnList[q].colId+'"  title="" data-value="'+ballGcolumnList[q].colName+'" type="checkbox" lay-skin="primary"></li>'
                }
                $('#youb').html(bstr)
                form.render()

                var youb = $("#youb li input").length
                var showColList = data.showColList
                var xhui = '';
                var colIds = '';
                for(var e=0;e<showColList.length;e++){
                    xhui += showColList[e].colId+','
                    colIds += showColList[e].colId+','
                }
                colId = colIds.split(',')
                colId.pop()

                if(xhui != '' || xhui != undefined){
                    var youb = $("#youb li input").length
                    var xzhui = xhui.split(',')
                    if(data.glist != '' || data.glist != undefined){
                        if(data.glist.showColIds != undefined){
                            var showColIds = data.glist.showColIds
                            showColIds = showColIds.split(',')
                            xzhui.pop()
                            for(var h=0;h<showColIds.length;h++){
                                if(showColIds[h] == 'CREATE_USER_ID' || showColIds[h] == 'CREATE_TIME' || showColIds[h] == 'UPDATE_TIME' || showColIds[h] == 'OWNER_USER_ID' || showColIds[h] == 'DEPT_ID' || showColIds[h] == 'DATA_ID') {
                                    for(var j=0;j<youb;j++){
                                        if($("#youb li input").eq(j).attr('value') == showColIds[h]){
                                            $("#youb li input").eq(j).attr('flag','false')
                                            $("#youb li input").eq(j).attr('checked',true)
                                            $("[data-field="+showColIds[h]+"]").show()
                                            colId.push(showColIds[h])
                                        }
                                    }
                                }
                            }
                        }
                    }

                form.render()
                    for(var t=0;t<xzhui.length;t++){
                        for(var r=0;r<youb;r++){
                            if($("#youb li input").eq(r).attr('value') == xzhui[t]){
                                $("#youb li input").eq(r).attr('flag','false')
                                $("#youb li input").eq(r).attr('checked',true)
                            }
                        }
                    }
                    var arrs = new Array();
                    $("input:checkbox[name='like11[write]']:checked").each(function(i){
                        arrs[i] = $(this).val();
                    });
                    var zong = $("#youb li").length
                    if(arrs.length != zong){
                        $('.lie input').attr('flag','true')
                        $('.lie input').removeAttr('checked');

                    }else{
                        $('.lie input').attr('flag','false')
                        $(".lie input").prop("checked", true);
                    }
                }else{

                }
                form.render()
                // 列表设置 排序字段下拉框渲染
                var lieStr = ''
                for(var o=0;o<ballGcolumnList.length;o++){
                    lieStr += '<option value="'+ballGcolumnList[o].colId+'" data-type="'+ballGcolumnList[o].colType+'">'+ballGcolumnList[o].colName+'</option>'
                }
                $('#zhu').html(lieStr)
                // 列表设置 排序字段默认排序
                var listOrderCol = data.glist.listOrderCol
                if(listOrderCol != undefined){
                    if(listOrderCol != 'CREATE_USER_ID' && listOrderCol != 'CREATE_TIME' && listOrderCol != 'UPDATE_TIME' && listOrderCol != 'OWNER_USER_ID' && listOrderCol != 'DEPT_ID' && listOrderCol != 'DATA_ID'){
                        var listOrderCols = listOrderCol.split('COL')
                        listOrderCols = listOrderCols.slice(1)
                        var a = listOrderCols.toString()
                        if(a != '' || a != undefined){
                            $("#zhu option[value="+a+"]").prop("selected",true)
                        }
                    }else{
                        if(listOrderCol != '' || listOrderCol != undefined){
                            $("#zhu option[value="+listOrderCol+"]").prop("selected",true)
                        }
                    }
                }


                var listOrderType = data.glist.listOrderType

                if(listOrderType == '1'){
                    types = 'desc'
                }else if(listOrderType == '2'){
                    types = 'asc'
                }
                $("input:radio[name=sex1][value ="+listOrderType+"]").prop("checked", true);
                field = $("#zhu").val()
                initSort = {field:field,type:types}
                table.reload("test", {
                    initSort: initSort,
                    where: {
                        field: initSort.field,
                        order: initSort.type
                    }
                })
                var batchOperates = data.glist.batchOperate
                $("input:radio[name=sex][value ="+batchOperates+"]").prop("checked", true);
                form.render()


                var data = res.object
                tabId = data.glist.tabId
                var showColList = data.showColList
                var allGcolumnList = data.allGcolumnList
                for(var w=0;w<allGcolumnList.length;w++){
                    if(allGcolumnList[w].colType == 'L02'){

                    }else if(allGcolumnList[w].colType == 'L01'){
                        var object = allGcolumnList[w].colStyle
                        var arr = JSON.parse(object)
                        delete arr.shareRatio
                        var arr1 = []
                        for (let i in arr) {
                            arr1.push(arr[i]); //属性
                            //arr.push(obj[i]); //值
                        }
                        for(var z=0;z<arr1.length;z++){
                            if(arr1[z].colId == undefined){

                            }else{
                                if(arr1[z].colType == 'S01' || arr1[z].colType == 'S02' || arr1[z].colType == 'S03' || arr1[z].colType == 'S04' || arr1[z].colType == 'S05' || arr1[z].colType == 'S06'){

                                }else{
                                    subjectField.push(arr1[z].colId)
                                    subjectTitle.push(arr1[z].colName)
                                }
                            }
                        }
                    }else if(allGcolumnList[w].colType == 'S01' ||
                        allGcolumnList[w].colType == 'S02' ||
                        allGcolumnList[w].colType == 'S03' ||
                        allGcolumnList[w].colType == 'S04' ||
                        allGcolumnList[w].colType == 'S05' ||
                        allGcolumnList[w].colType == 'S06'
                    ){
                        for(let q=0;q<subjectField.length;q++){
                            if(subjectField[q] == allGcolumnList[w].colId){
                                subjectTitle[q] = allGcolumnList[w].colName
                            }
                        }
                    }else{
                        subjectField.push(allGcolumnList[w].colId)
                        subjectTitle.push(allGcolumnList[w].colName)
                    }

                }

                var arrStr = {}
                for(var w=0;w<allGcolumnList.length;w++){
                    arrStr[allGcolumnList[w].colId] = ''
                }
                tableData.push(arrStr)
                form.render()
            }

        })
        $(document).on('click','#save',function(){
            var arr = new Array();
            $("input:checkbox[name='like1[write]']:checked").each(function(i){
                arr[i] = $(this).attr('data-value');
            });
            selColIds = arr.join(",");//将数组合并成字符串

            var arrs = new Array();
            $("input:checkbox[name='like11[write]']:checked").each(function(i){
                arrs[i] = $(this).attr('value');
            });
            showColIds = arrs.join(",");//将数组合并成字符串
            listOrderCol = $('#zhu').val()
            if(listOrderCol != 'CREATE_USER_ID' && listOrderCol != 'CREATE_TIME' && listOrderCol != 'UPDATE_TIME' && listOrderCol != 'OWNER_USER_ID' && listOrderCol != 'DEPT_ID' && listOrderCol != 'DATA_ID'){
                listOrderCol = "COL"+listOrderCol
            }
            listOrderType = $('input[name="sex1"]:checked ').val()//获取选中的值
            var asd = $("#h2lie").text()
            if(asd == '列表视图'){
                listViewType = '1'
            }
            batchOperate = $('input[name="sex"]:checked ').val()//获取选中的值

            var res = arr.join(",");
            $.ajax({
                url:'/glist/saveGlist',
                data:{
                    idgappId:gappId,
                    selColIds:selColIds,
                    showColIds:showColIds,
                    listViewType:listViewType,
                    listOrderCol:listOrderCol,
                    listOrderType:listOrderType,
                    batchOperate:batchOperate,
                    tabId:tabId,
                    listButtons:listButtons
                },
                success:function(res){
                    debugger
                    if(res.flag){
                        sessionStorage.setItem('save','true')
                        var showColIdsParam = [];
                        for(var i=0; i<$("#youb li").length; i++){
                            // showColIdsParam.push($("#youb li input").eq(i).attr("value"));
                            showColIdsParam.push({field: $("#youb li input").eq(i).attr("value"), title: $("#youb li input").eq(i).attr("data-value")});
                        }
                        console.log(showColIdsParam)
                        $.ajax({
                            url:'/glist/updateGlist',
                            async:true,
                            data:{
                                listId:listId,
                                listCloOrder:JSON.stringify(showColIdsParam)
                            },
                            success:function(res){
                                console.log(res);
                            }
                        })
                        window.location.reload()
                    }else{
                        layer.msg('保存失败')
                    }
                }
            })
        })
    });
    function colIdss(){
        for(var u=0;u<colId.length;u++){
            $("[data-field="+colId[u]+"]").show()
        }
    }

    $(document).on('click','#biaoshe',function(){
        window.location.href='/gapp/formDesign?gappId='+gappId+'&typeId='+typeId;
    })

    //流程设计
    $(document).on('click','#liushe',function(){
        window.location.href='/gapp/technological?gappId='+gappId+'&typeId='+typeId;
    })
    //应用设置
    $(document).on('click','#yingshe',function(){
        window.location.href='/gapp/applicationSettings?gappId='+gappId+'&typeId='+typeId;
    })
    // function getQueryString(name){
    //     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    //     var r = window.location.search.substr(1).match(reg);
    //     if(r!=null)return  unescape(r[2]); return null;
    // }
</script>
</html>