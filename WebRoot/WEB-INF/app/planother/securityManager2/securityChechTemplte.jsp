<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>安全检查计划模板</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <%--<link rel="stylesheet" href="/lims/css/eleTree.css">--%>
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/lay/mymodules/eleTree.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jquery-2.1.4.min.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <style>
        html,body{
            height: 99.8%;
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        .mbox{
            height: 100%;
            padding:0px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
        }
        .deptinput{
            display: inline-block;
            width: 75%;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        .layui-card-body{
            display: flex;
        }
        .layui-lf{
            float: left;
            position: relative;
            border: 1px solid #eee;
            /*width: 200px;*/
            width: 14%;
            overflow-x: auto;
            height: 100%;
            /*height: 600px !important;*/
        }
        .layui-rt{
            float: left;
            width: 84%;
            margin-left: 6px;
            height: 100%;
            /*margin-top: -10px;*/
        }
        .treeTitle{
            display: flex;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 30px;
            background-color: #00a0e9;
            color: #fff;
            padding: 15px;
            position: relative;
        }
        .layui-nav-item,.layadmin-flexible{
            position: absolute;
            left: 5px;
            top: 23px;
            z-index: 9999999;
        }
        .rtfix{
            /*width:200px;*/
            overflow-x: hidden;
        }
        .bg{
            background-color: #F2F2F2;
        }
        .bgs{
            background-color: #F2F2F2;
        }
        .back{
            background-color: #ccc;
        }
        /*滚动条样式*/
        .scroll::-webkit-scrollbar {/*滚动条整体样式*/
            width: 4px;     /*高宽分别对应横竖滚动条的尺寸*/
            height: 10px;
        }
        .scroll::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
            border-radius: 5px;
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            background: rgba(0,0,0,0.2);
        }
        .scroll::-webkit-scrollbar-track {/*滚动条里面轨道*/
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            border-radius: 0;
            background: rgba(0,0,0,0.1);
        }

        .eleTree{
            cursor: pointer;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0;
        }
        .layui-tab layui-tab-card{
            margin-top: -4px;
        }
        .layui-tab-card>.layui-tab-title .layui-this:after {
            border-width: 0px;
        }
        .baseinfo td{
            padding: 5px 2px;
        }
        .active{
            display: none;
        }
        .back{
            background-color: #F2F2F2;
        }
        .layui-colla-item {
            position: relative;
        }
        .layui-collapse .layui-card-body{
            padding: 0 8px;
        }
        .repairLable{
            padding: 8px 15px;
            text-align: right;
            vertical-align: middle;
        }
        .layui-form-select dl dd{
            height: 32px;
            line-height: 32px;
        }
        .layui-form-select .layui-select-title .layui-input{
            height: 32px;
        }
        #formTest .layui-form-select input,#lendListTest .layui-form-select input{
            height: 32px;
        }
        .layui-input{
            height: 32px !important;
        }
        .layui-form-item{
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
        /*.iframe{*/
            /*width: 100% !important;*/
            /*height: 100% !important;*/
        /*}*/
        .layui-tab-title .layui-this {
            color: #000;
            background-color: #fff;
        }
    </style>

    <script type="text/javascript">
        var funcUrl = location.pathname;
        var authorityObject = null;
        if (funcUrl) {
            $.ajax({
                type: 'GET',
                url: '/plcPriv/findPermissions',
                data: {
                    funcUrl: funcUrl
                },
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.flag) {
                        if (res.object && res.object.length > 0) {
                            authorityObject = {}
                            res.object.forEach(function (item) {
                                authorityObject[item] = item;
                            });
                        }
                    }
                },
                error: function () {

                }
            });
        }
    </script>
</head>
<body>
<div class="mbox">
    <div class="layui-card" style="height: 100%;">
        <div class="layui-tab layui-tab-card" lay-filter="tabTaggle" style="position:relative;height: 100%;overflow: hidden">
            <div class="scroll" style="overflow-x:auto;overflow-y:hidden;background-color: #f2f2f2;">
            <ul class="layui-tab-title" id="ulBox">
                <li num="1" class="layui-this">隐患排查标准</li>
                <%--<li>计家云</li>--%>
            </ul>
            </div>
            <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                <%--工程类别--%>
                <div class="layui-tab-item layui-show" style="height: 100%">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">
                                <div style="margin: 1% 1%;" id="editBox">
                                    <button type="button" style="margin-left:2px;display: none" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
                                    <button type="button" style="margin-left:2px;display: none" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
                                    <button type="button" style="margin-left:2px;display: none" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
                                </div>
                                <div class="panel-body">
                                   <div class="eleTree ele1" lay-filter="tdata"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" style="position: relative">
                                <table id="Settlement" lay-filter="SettlementFilter"></table>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="layui-tab-item" style="height: 100%;">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">

                                <div class="panel-body">
                                    <div class="eleTree ele3"  lay-filter="tdata1"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" style="position: relative">
                                <table id="Settlement1" lay-filter="SettlementFilter1"></table>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="formTable1toolbar">
    <div class="layui-btn-container">
        {{#  if(authorityObject && authorityObject['11']){ }}
        <input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
        {{#  } }}
        {{#  if(authorityObject && authorityObject['05']){ }}
        <input type="button" class="layui-btn layui-btn-sm" lay-event="editTest" value="编辑">
        {{#  } }}
        <%--{{#  if(authorityObject && authorityObject['02']){ }}
        <button class="layui-btn layui-btn-sm" lay-event=" " style="width: 70px">导入</button>
        {{#  } }}
        {{#  if(authorityObject && authorityObject['03']){ }}
        <button class="layui-btn layui-btn-sm" lay-event="supplierExport" style="width: 70px">导出</button>
        {{#  } }}--%>
        {{#  if(authorityObject && authorityObject['04']){ }}
        <input type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delTest" value="删除">
        {{#  } }}
    </div>
</script>


<script type="text/html" id="formTable1bar">
    <div class="layui-btn-container" style="height: 30px;">
        {{#  if(authorityObject && authorityObject['04']){ }}
        <input type="button" class="layui-btn layui-btn-sm" lay-event="delete" value="删除">
        {{#  } }}
    </div>
</script>

<script type="text/html" id="toolbar2">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="supplierImport2" style="width: 100px">导入本地</button>
    </div>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">


    initAuthority();

    $('.rtfix').css('max-height',autodivheight()-55)
    var el;
    var el1;
    var ell;
    var parData;
    var arr = [];
    var directjudge;
    var idkey;
    var AllEquipTypeId;
    var columnTrId;
    var columnTrId1;
    var codeNo;
    var codNam;
    var SettlementTable;
    var SettlementTable1;
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var type = getUrlParam('pageType');
    var tableType = getUrlParam('type');;
    var urrl = "";
    layui.use(['table','layer','form','element','eleTree','laydate','upload'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var upload = layui.upload;

        function tab(date1,date2){
            var oDate1 = new Date(date1);
            var oDate2 = new Date(date2);
            var dataTime = new Date();
            if(oDate1!=undefined&&oDate2!=undefined){
                if(dataTime.getTime() >= oDate1.getTime()&&dataTime.getTime() <= oDate2.getTime()){
                    return true;
                }
            }
        }
        //判断权限
        $.ajax({
            url:'/knowledgeCenter/getCloudPriv',
            dataType:'json',
            type:'post',
            success:function(res){
                if(res.obj.knowledgeFlag!=undefined&&res.obj.knowledgeFlag==0){
                    if(tab(res.obj.knowledgeBTime,res.obj.knowledgeETime)){
                        $('#ulBox').append('<li>计家云</li>')
                        var htmlDiv = '<div class="layui-tab-item" style="height: 100%;">\n' +
                            '                    <div class="layui-card" style="height: 100%">\n' +
                            '                        <div class="layui-card-body" style="height: 100%">\n' +
                            '                            <div class="layui-lf rtfix">\n' +
                            '                                <div class="panel-body">\n' +
                            '                                    <div class="eleTree ele3"  lay-filter="tdata1"></div>\n' +
                            '                                </div>\n' +
                            '                            </div>\n' +
                            '                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>\n' +
                            '                            <div class="layui-rt" style="position: relative">\n' +
                            '                                <table id="Settlement1" lay-filter="SettlementFilter1"></table>\n' +
                            '                            </div>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>'
                        $('#divBox').append(htmlDiv);
                        // 初始化渲染 树形菜单

                        el1 = eleTree.render({
                            elem: '.ele3',
                            showLine:true,
                            url:'/workflow/secirityManager/getSecurityTemplteByType?parent=0',
                            lazy: true,
                            // checked: true,
                            load: function(data,callback) {
                                $.post('/workflow/secirityManager/getSecurityTemplteByType?parent='+data.id,function (res) {
                                    callback(res.data);//点击节点回调
                                })
                            },
                            done:function (data) { //渲染完成回调
                                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                                var na = $("#ulBox").find("li.layui-this").html();
                                codNam = encodeURI(encodeURI(na));
                                codeNo = n1;
                                if(data.data.length == 0){
                                    $('.ele1').html('<div style="text-align: center">暂无数据</div>');
                                    columnTrId1 = undefined;
                                }else{
                                    columnTrId1 = data.data[0].id;
                                    var dataid=$('.ele1 div').attr("data-id")
                                    $('.eleTree-node').removeClass('back')
                                    $('.ele1 div[data-id='+dataid+']').addClass('back')
                                    $('.eleTree-node-group').css('background','#fff');
                                    childFunc1(columnTrId1);  //调用应用中方法
                                }
                                if(type == 1 || type == "1"){
                                    urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId1+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
                                }else if(type == 2 || type == "2"){
                                    urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId1
                                }
                                $("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                            }
                        });
                    }
                }
            }
        })

        // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: '.ele1',
                showLine:true,
                url:'/workflow/secirityManager/getSecurityTemplteByType?parent=0',
                lazy: true,
                // checked: true,
                load: function(data,callback) {
                    $.post('/workflow/secirityManager/getSecurityTemplteByType?parent='+data.id,function (res) {
                        callback(res.data);//点击节点回调
                    })
                },
                done:function (data) { //渲染完成回调
                    var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                    var na = $("#ulBox").find("li.layui-this").html();
                    codNam = encodeURI(encodeURI(na));
                    codeNo = n1;
                    if(data.data.length == 0){
                        $('.ele1').html('<div style="text-align: center">暂无数据</div>');
                        columnTrId = undefined;
                    }else{
                        columnTrId = data.data[0].id;
                        var dataid=$('.ele1 div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $('.ele1 div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                        childFunc(columnTrId);  //调用应用中方法
                    }
                    // if(type == 1 || type == "1"){
                    //     urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
                    // }else if(type == 2 || type == "2"){
                    //     urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId
                    // }
                    //$("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                }
            });
        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            parData = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            columnTrId = d.data.currentData.id;
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
           childFunc(columnTrId);  //调用应用中方法
        });
        //选中监听事件
        eleTree.on("nodeChecked(tdata)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
            }else{
                arr.remove(id);
            }
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        //树的方法
        function treeFn(cla) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");

            codeNo = n1;
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: cla,
                showLine:true,
                // showCheckbox: true,
                url:'/knowledge/getKnowledgeType?colunmType='+n1+'&parentColumnId=0',
                lazy: true,
                load: function(data,callback) {
                    $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
                        callback(res.data);//点击节点回调
                    })
                },
                done:function (data) { //渲染完成回调
                    if(data.data.length == 0){
                        $(cla).html('<div style="text-align: center">暂无数据</div>');
                        columnTrId = undefined;
                    }else{
                        aldata = data.data
                        columnTrId = data.data[0].id;
                        var dataid=$(cla+' div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $(cla+' div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                    }
                }
            });
        }

        eleTree.on("nodeClick(tdata1)",function(d) {
            //debugger
            parData = d.data.curtdatarentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            columnTrId1 = d.data.currentData.id;
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            childFunc1(columnTrId1);  //调用应用中方法
        });

        eleTree.on("nodeChecked(tdata1)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
            }else{
                arr.remove(id);
            }
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })

        function childFunc(secirityId){
            SettlementTable = layui.table.render({
                elem: '#Settlement'
                , page:true
                ,url:'/workflow/secirityManager/selectTemplteDetails?templteId='+secirityId
                ,toolbar:'#formTable1toolbar'
                ,cols: [[
                    {type: 'checkbox'}
                    ,{type: 'numbers', title: '序号'}
                    ,{field:'detailsName',title:'名称'}
                    ,{field: 'securityKnowledgeName', title: '检查项'}
                    ,{field: 'securityDangerName', title: '检查内容'}
                    ,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                ]],
                done:function(obj, curr, count){

                }
            });
        }

        function childFunc1(secirityId){
            SettlementTable1 = layui.table.render({
                elem: '#Settlement1'
                , page:true
                ,url:'/workflow/secirityManager/selectTemplteDetails?templteId='+secirityId
                ,toolbar:'#toolbar2'
                ,cols: [[
                    {type: 'radio'}
                    ,{type: 'numbers', title: '序号'}
                    ,{field:'detailsName',title:'名称'}
                    ,{field: 'securityKnowledgeName', title: '检查项'}
                    ,{field: 'securityDangerName', title: '检查内容'}
                    //,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                ]],
                done:function(obj, curr, count){

                }
            });
        }




        table.on('toolbar(SettlementFilter)', function (obj) {
            var events = obj.event;
            var datas = table.checkStatus('Settlement').data;
            // 新增
            if (events == 'addTest') {
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '80%'], //宽高
                    title: '新增',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: '<div class="layui-form">' +
                        '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                        '<label class="layui-form-label">名称</label>' +
                        '<div class="layui-input-block">' +
                        '<input class="layui-input"  lay-verify="required" name="testName" id="testName">' +
                        '</div>' +
                        '</div>' +
                        '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                        '<div>'+
                        '<label class="layui-form-label"><span style="color: red">*</span>检查项</label>' +
                        '</div>'+
                        '<div class="layui-input-block">' +
                        '<textarea type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查项" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                        '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                        '<div>'+
                        '<label class="layui-form-label"><span style="color: red">*</span> 检查内容</label>' +
                        '</div>'+
                        '<div class="layui-input-block">' +
                        '<textarea type="text" id="pele3" pid name="ttitle3" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查内容" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                    success: function () {
                        //渲染项目名称
                        // var $select2 = $("#aqProjName");
                        // var optionStr2 = '<option value="">请选择</option>';
                        // $.ajax({ //查询文档等级
                        //     url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
                        //     type: 'get',
                        //     dataType: 'json',
                        //     async:false,
                        //     success: function (res) {
                        //         var data=res.data
                        //         if(data!=undefined&&data.length>0){
                        //             for(var i=0;i<data.length;i++){
                        //                 optionStr2 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
                        //             }
                        //         }
                        //     }
                        // })
                        // $select2.html(optionStr2);
                        Array.prototype.remove = function(val) {
                            var index = this.indexOf(val);
                            if (index > -1) {
                                this.splice(index, 1);
                            }
                        };

                        var el;
                        $("[name='ttitle1']").on("click",function (e) {
                            //debugger
                            e.stopPropagation();
                            if(!el){
                                el=eleTree.render({
                                    elem: '.ele2',
                                    url:'/workflow/secirityManager/getSecurityByType?parent=0',
                                    expandOnClickNode: false,
                                    highlightCurrent: true,
                                    showLine:true,
                                    showCheckbox: false,
                                    checked: false,
                                    lazy: true,
                                    load: function(data,callback) {
                                        $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    },
                                    done: function(res){

                                    }
                                });
                            }
                            $(".ele2").slideDown();
                        })
                        $(document).on("click",function() {
                            $(".ele2").slideUp();
                        })
                        //节点点击事件
                        eleTree.on("nodeClick(data2)",function(d) {
                            var parData1 = d.data.currentData;
                            var str111="";
                            console.log(parData1)
                            $.ajax({
                                url:'/workflow/secirityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
                                dataType:'json',
                                type:'post',
                                async: false,
                                success:function(res){
                                    if(res.code===0||res.code==="0"){
                                        var securityKnowledgeName = res.obj;
                                        str111+=securityKnowledgeName+"，"
                                    }
                                }
                            })

                            $("[name='ttitle1']").val(str111);
                            $("#pele").attr("pid",parData1.id);
                        })
                        var ell;
                        $("[name='ttitle3']").on("click",function (e) {

                            var standTypeId =  $("#pele").attr("pid");
                            if(standTypeId==undefined||standTypeId==""){
                                layer.msg("请先选择检查项")
                                return false;
                            }else{
                                layer.open({
                                    type: 2,
                                    skin: 'layui-layer-molv', //加上边框
                                    area: ['90%', '90%'], //宽高
                                    title: '隐患项',
                                    maxmin: true,
                                    btn: ['提交', '取消'],
                                    content: '/workflow/secirityManager/toSecirityStandard?type=checkTemplte&knowTypeIds='+standTypeId,
                                    success: function () {

                                    },
                                    yes: function (index, layero){
                                        var experience = window["layui-layer-iframe" + index].getRepairDate();
                                        //debugger
                                        if(experience!=undefined&&experience!=null){
                                            var securityDangers ="";
                                            var securityDangerIds ="";
                                            for(var i = 0; i < experience.length; i++){
                                                securityDangers+=experience[i].securityDanger+"，";
                                                securityDangerIds+=experience[i].securityDangerId+",";
                                            }
                                            $("#pele3").text(securityDangers);
                                            $("#pele3").attr("securityDangerId",securityDangerIds);
                                            /*if(experience.securityDangerGrade!=undefined){
                                                $("#pele3").attr("dangerGrade",experience.securityDangerGrade);
                                                if(experience.securityDangerGrade===0||experience.securityDangerGrade==="0"){
                                                    $("#dangerGrade").val("重大隐患");
                                                }else{
                                                    $("#dangerGrade").val("一般隐患");
                                                }
                                            }*/
                                            //$("#securityDanger").val(experience.securityDanger);
                                            //$("#securityDangerMeasures").val(experience.securityDangerMeasures);
                                            layer.close(index)
                                        }
                                    }
                                })
                            }
                        })
                        form.render();//初始化表单
                    },
                    yes: function (index, layero) {

                        var detailsName = $("#testName").val()//名称

                        var securityKnowledgeIds = $("#pele").attr("pid"); //检查项

                        var securityDangerIds = $("#pele3").attr("securityDangerId"); //检查内容Id

                       if(securityDangerIds==undefined||securityDangerIds==""){
                            layer.msg("请选择检查内容");
                            return false;
                        }else if(securityKnowledgeIds==undefined||securityKnowledgeIds==""){
                            layer.msg("请选择检查项");
                            return false;
                        }else {
                            if(securityDangerIds.substring(securityDangerIds.length-1,securityDangerIds.length)==","){
                                securityDangerIds = securityDangerIds.substring(0,securityDangerIds.length-1);
                            }

                            if(securityKnowledgeIds.substring(securityKnowledgeIds.length-1,securityKnowledgeIds.length)==","){
                                securityKnowledgeIds = securityKnowledgeIds.substring(0,securityKnowledgeIds.length-1);
                            }

                            var details = {
                                detailsName:detailsName,
                                securityKnowledgeIds:securityKnowledgeIds,
                                securityDangerIds:securityDangerIds,
                                templteId:columnTrId
                            }
                            // detailsInitData.push(details);
                            // detailsInit.reload({
                            //     url:'',data:detailsInitData
                            //     ,done:function(d){
                            //         layer.close(index)
                            //     }
                            // });
                            $.ajax({
                                url:'/workflow/secirityManager/insertSecurityTemplteDetails',
                                dataType:'json',
                                type:'post',
                                data:details,
                                success:function(res){
                                    if(res.code===0||res.code==="0"){
                                        layer.msg(res.msg,{icon:1});
                                        SettlementTable.reload();
                                        layer.close(index)
                                    }else{
                                        layer.msg(res.msg,{icon:0});
                                    }
                                }
                            })
                        }
                    }
                });
            }else if (events == 'delTest') {//删除
                if(datas.length<1){
                    layer.msg("请至少选择一条");
                }else{
                    layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
                        var ids="";
                        for(var i=0;i<datas.length;i++){
                            ids+=datas[i].templteDetailsId+",";
                        }
                        $.ajax({
                            url:'/workflow/secirityManager/delSecurityTemplteDetails',
                            type: 'post',
                            dataType: 'json',
                            data:{details:ids},
                            success:function(res){
                                layer.msg(res.msg);
                                SettlementTable.reload();
                            }
                        });
                        layer.close(index);
                    });
                }
            }else if (events == 'editTest') {//编辑
                if(datas.length!=1){
                    layer.msg("请选择一条");
                }else {
                    var checkDate = datas[0];
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '80%'], //宽高
                        title: '编辑',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<div class="layui-form">' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label">名称</label>' +
                            '<div class="layui-input-block">' +
                            '<input class="layui-input"  lay-verify="required" name="testName" id="testName">' +
                            '</div>' +
                            '</div>' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label"><span style="color: red">*</span>检查项</label>' +
                            '<div class="layui-input-block">' +
                            '<textarea type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查项" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                            '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label"><span style="color: red">*</span>检查内容</label>' +
                            '<div class="layui-input-block">' +
                            '<textarea type="text" id="pele3" pid name="ttitle3" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查内容" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                        success: function () {
                            $("#testName").val(checkDate.detailsName)//名称
                            $("#pele").attr("pid",checkDate.securityKnowledgeIds); //检查项
                            $("#pele3").attr("securityDangerId",checkDate.securityDangerIds); //检查内容Id
                            $("#pele").text(checkDate.securityKnowledgeName);
                            $("#pele3").text(checkDate.securityDangerName);
                            //渲染项目名称
                            // var $select2 = $("#aqProjName");
                            // var optionStr2 = '<option value="">请选择</option>';
                            // $.ajax({ //查询文档等级
                            //     url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
                            //     type: 'get',
                            //     dataType: 'json',
                            //     async:false,
                            //     success: function (res) {
                            //         var data=res.data
                            //         if(data!=undefined&&data.length>0){
                            //             for(var i=0;i<data.length;i++){
                            //                 optionStr2 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
                            //             }
                            //         }
                            //     }
                            // })
                            // $select2.html(optionStr2);
                            Array.prototype.remove = function(val) {
                                var index = this.indexOf(val);
                                if (index > -1) {
                                    this.splice(index, 1);
                                }
                            };
                            var el;
                            $("[name='ttitle1']").on("click",function (e) {
                                e.stopPropagation();
                                var elm = ".ele2";
                                if(!el){
                                    el=eleTree.render({
                                        elem: '.ele2',
                                        url:'/workflow/secirityManager/getSecurityByType?parent=0',
                                        expandOnClickNode: false,
                                        highlightCurrent: true,
                                        showLine:true,
                                        showCheckbox: false,
                                        checked: false,
                                        lazy: true,
                                        load: function(data,callback) {
                                            $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                                callback(res.data);//点击节点回调
                                            })
                                        },
                                        done: function(res){
                                            var pidar = checkDate.securityKnowledgeIds.split(",");
                                            var pidarr = [];
                                            for (var j = 0; j < pidar.length; j++) {
                                                if (pidar[j] == "") {

                                                } else {
                                                    pidarr.push(pidar[j]);
                                                }
                                            }
                                            for (var j = 0; j < pidarr.length; j++) {
                                                $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
                                                $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
                                                // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                                $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                                $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                            }
                                            var $inp = $(elm +' input[eletree-status="1"]');
                                            var str = "";
                                            var str1 = "";
                                            for(var i=0;i<$inp.length;i++){
                                                str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
                                                str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
                                            }
                                            $(elm).prev("textarea").attr("pid",str1)
                                            $(elm).prev("textarea").text(str);
                                        }
                                    });
                                }
                                $(".ele2").slideDown();
                            })
                            $(document).on("click",function() {
                                $(".ele2").slideUp();
                            })
                            //选中监听事件
                            /*var arr = [];
                            var arr1 = [];
                            eleTree.on("nodeChecked(data2)",function(d) {
                                var id = d.data.currentData.id+"";
                                var label = d.data.currentData.label+"";
                                if(d.isChecked == true || d.isChecked == "true"){
                                    arr.push(id);
                                    arr1.push(label);
                                }else{
                                    arr.remove(id);
                                    arr1.remove(label);
                                }
                                var str = "";
                                var str1 = "";
                                var str2 = "";
                                for(var i=0;i<arr.length;i++){
                                    var aid = arr[i];
                                    var aName = arr1[i];
                                    $.ajax({
                                        url:'/workflow/secirityManager/getKnowledgeById?knowleId='+aid,
                                        dataType:'json',
                                        type:'post',
                                        async: false,
                                        success:function(res){
                                            if(res.code===0||res.code==="0"){
                                                var regionName = res.obj;
                                                str1+=regionName+"，"
                                            }
                                        }
                                    })
                                    str+=arr[i]+","
                                }
                                $("[name='ttitle1']").text(str1);
                                $("#pele").attr("pid",str);
                            })*/
                            //节点点击事件
                            eleTree.on("nodeClick(data2)",function(d) {
                                var parData1 = d.data.currentData;
                                var str111="";
                                console.log(parData1)
                                $.ajax({
                                    url:'/workflow/secirityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
                                    dataType:'json',
                                    type:'post',
                                    async: false,
                                    success:function(res){
                                        if(res.code===0||res.code==="0"){
                                            var securityKnowledgeName = res.obj;
                                            str111+=securityKnowledgeName+"，"
                                        }
                                    }
                                })

                                $("[name='ttitle1']").val(str111);
                                $("#pele").attr("pid",parData1.id);
                            })

                            var ell;
                            $("[name='ttitle3']").on("click",function (e) {
                                var standTypeId =  $("#pele").attr("pid");
                                if(standTypeId==undefined||standTypeId==""){
                                    layer.msg("请先选择检查项")
                                    return false;
                                }else{
                                    layer.open({
                                        type: 2,
                                        skin: 'layui-layer-molv', //加上边框
                                        area: ['90%', '90%'], //宽高
                                        title: '隐患项',
                                        maxmin: true,
                                        btn: ['提交', '取消'],
                                        content: '/workflow/secirityManager/toSecirityStandard?type=checkTemplte&knowTypeIds='+standTypeId,
                                        success: function () {

                                        },
                                        yes: function (index, layero){
                                            var experience = window["layui-layer-iframe" + index].getRepairDate();
                                            //debugger
                                            if(experience!=undefined&&experience!=null){
                                                var securityDangers ="";
                                                var securityDangerIds ="";
                                                for(var i = 0; i < experience.length; i++){
                                                    securityDangers+=experience[i].securityDanger+"，";
                                                    securityDangerIds+=experience[i].securityDangerId+",";
                                                }
                                                $("#pele3").text(securityDangers);
                                                $("#pele3").attr("securityDangerId",securityDangerIds);
                                                /*if(experience.securityDangerGrade!=undefined){
                                                    $("#pele3").attr("dangerGrade",experience.securityDangerGrade);
                                                    if(experience.securityDangerGrade===0||experience.securityDangerGrade==="0"){
                                                        $("#dangerGrade").val("重大隐患");
                                                    }else{
                                                        $("#dangerGrade").val("一般隐患");
                                                    }
                                                }*/
                                                //$("#securityDanger").val(experience.securityDanger);
                                                //$("#securityDangerMeasures").val(experience.securityDangerMeasures);
                                                layer.close(index)
                                            }
                                        }
                                    })
                                }
                            })
                            form.render();//初始化表单
                        },
                        yes: function (index, layero) {

                            var detailsName = $("#testName").val()//名称

                            var securityKnowledgeIds = $("#pele").attr("pid"); //检查项

                            var securityDangerIds = $("#pele3").attr("securityDangerId"); //检查内容Id

                            if(securityDangerIds==undefined||securityDangerIds==""){
                                layer.msg("请选择检查内容");
                                return false;
                            }else if(securityKnowledgeIds==undefined||securityKnowledgeIds==""){
                                layer.msg("请选择检查项");
                                return false;
                            }else {
                                if(securityDangerIds.substring(securityDangerIds.length-1,securityDangerIds.length)==","){
                                    securityDangerIds = securityDangerIds.substring(0,securityDangerIds.length-1);
                                }

                                if(securityKnowledgeIds.substring(securityKnowledgeIds.length-1,securityKnowledgeIds.length)==","){
                                    securityKnowledgeIds = securityKnowledgeIds.substring(0,securityKnowledgeIds.length-1);
                                }

                                var details = {
                                    detailsName:detailsName,
                                    securityKnowledgeIds:securityKnowledgeIds,
                                    securityDangerIds:securityDangerIds,
                                    templteId:columnTrId,
                                    templteDetailsId:checkDate.templteDetailsId
                                }
                                // detailsInitData.push(details);
                                // detailsInit.reload({
                                //     url:'',data:detailsInitData
                                //     ,done:function(d){
                                //         layer.close(index)
                                //     }
                                // });
                                $.ajax({
                                    url:'/workflow/secirityManager/updateSecurityTemplteDetails',
                                    dataType:'json',
                                    type:'post',
                                    data:details,
                                    success:function(res){
                                        if(res.code===0||res.code==="0"){
                                            //layer.msg("更新成功",{icon:1});
                                            layer.msg(res.msg,{icon:1});
                                            SettlementTable.reload()
                                            layer.close(index)
                                        }else{
                                            //layer.msg("更新成功",{icon:1});
                                            layer.msg(res.msg,{icon:0});
                                        }
                                    }
                                })
                            }
                        }
                    });
                }
            }
        })
        //隐患排查标准页面与计家云页面切换
        element.on('tab(tabTaggle)', function(){
            childFunc(columnTrId);
            childFunc1(columnTrId1);
        });




        //表格头工具事件
        var parData3;
        var columnTrId3;
        var codeNo3;
        var codNam3;
        table.on('toolbar(SettlementFilter1)', function(obj){
            var checkStatus = table.checkStatus("Settlement1").data[0];
            var event = obj.event;
            switch(event){
                case 'supplierImport2': //导入本地
                    if(table.checkStatus("Settlement1").data.length!='1'){
                        layer.msg("请选择一条");
                    }else{
                        layer.open({
                            type: 1,
                            skin: 'layui-layer-molv', //加上边框
                            area: ['20%', '60%'], //宽高
                            title: '导入本地',
                            btn: ['确定', '取消'],
                            content:
                                '<div class="layui-card-body" style="height: 100%">'+
                                '<div class="panel-body">'+
                                '<div class="eleTree elee4" lay-filter="tdata2"></div>'+
                                '</div>'+
                                '</div>',
                            success: function () {
                                // 初始化渲染 树形菜单
                                var el = eleTree.render({
                                    elem: '.elee4',
                                    showLine:true,
                                    url:'/workflow/secirityManager/getSecurityTemplteByType?parent=0',
                                    lazy: true,
                                    // checked: true,
                                    load: function(data,callback) {
                                        $.post('/workflow/secirityManager/getSecurityTemplteByType?parent='+data.id,function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    },
                                    done:function (data) { //渲染完成回调
                                        var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                                        var na = $("#ulBox").find("li.layui-this").html();
                                        codNam3 = encodeURI(encodeURI(na));
                                        codeNo3 = n1;
                                        if(data.data.length == 0){
                                            $('.elee4').html('<div style="text-align: center">暂无数据</div>');
                                            columnTrId3 = undefined;
                                        }else{
                                            columnTrId3 = data.data[0].id;
                                            var dataid=$('.elee4 div').attr("data-id")
                                            $('.eleTree-node').removeClass('back')
                                            $('.elee4 div[data-id='+dataid+']').addClass('back')
                                            $('.eleTree-node-group').css('background','#fff');
                                        }
                                    }
                                });
                            },
                            yes: function (index, layero) {
                                delete  checkStatus.securityCreateUser;
                                delete  checkStatus.securityCreateTime;
                                delete  checkStatus.securityDangerId;
                                delete  checkStatus.templteDetailsId;
                                checkStatus.securityDangerTypeId = columnTrId3;
                                $.ajax({
                                    url:'/workflow/secirityManager/insertSecurityTemplteDetails',
                                    type: 'post',
                                    dataType:'json',
                                    data:checkStatus,
                                    success:function(res){
                                        if(res.code===0||res.code==="0"){
                                            layer.close(index);
                                        }
                                        layer.msg(res.msg)
                                    }
                                })
                            }
                        });
                    }
                    break;
            };
        });

        // 节点点击事件
        eleTree.on("nodeClick(tdata2)",function(d) {
            parData3 = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo3");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam3 = encodeURI(encodeURI(na));
            codeNo3 = n1;
            columnTrId3 = d.data.currentData.id;
            var clas = "";
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
        });


        //表格行操作事件
        table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var dataa = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'delete'){ //删除
                layer.confirm('确定要删除检查项吗？', {icon: 3, title:'提示'}, function(index){
                    var ids=dataa.templteDetailsId;
                    $.ajax({
                        url:'/workflow/secirityManager/delSecurityTemplteDetails',
                        type: 'post',
                        dataType: 'json',
                        data:{details:ids},
                        success:function(res){
                            layer.msg(res.msg);
                            SettlementTable.reload();
                        }
                    });
                    layer.close(index);
                });
            }
        })








        //左侧新建类型
        $('#addPlan').click(function () {
            layer.open({
                type: 1,
                title: "新建",
                shadeClose: true,
                btn: ['提交', '取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="templteSort" name="templteSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="templteName" id="templteName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                            ell=eleTree.render({
                                elem: '.ele2',
                                url:'/workflow/secirityManager/getSecurityTemplteByType?parent=0',
                                expandOnClickNode: false,
                                highlightCurrent: true,
                                showLine:true,
                                lazy: true,
                                load: function(data,callback) {
                                    $.post('/workflow/secirityManager/getSecurityTemplteByType?parent='+data.id,function (res) {
                                        callback(res.data);//点击节点回调
                                    })
                                },
                                done: function(res){

                                }
                            });
                        $(".ele2").slideDown();
                    })
                    eleTree.on("nodeClick(data1)",function(d) {
                        $("[name='ttitle']").val(d.data.currentData.label)
                        $("#pele").attr("pid",d.data.currentData.id)
                        $(".ele2").slideUp();
                    })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                },
                yes: function (indexx) {
                    var plbSecurityKnowledge = {};
                    plbSecurityKnowledge.templteSort = $("#templteSort").val();
                    plbSecurityKnowledge.templteName = $("#templteName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.templteParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#templteName").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/secirityManager/insertSecirityTemplte',
                            dataType: "json",
                            data:plbSecurityKnowledge,
                            success:function (res) {
                                if(res.code == "0" || res.code == 0){
                                    layer.msg(res.msg);
                                    setTimeout(function(){
                                        if(el){
                                            el.reload()
                                        }
                                        if(ell){
                                            ell.reload();
                                        }
                                        layer.close(indexx)
                                    },1000)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    }
                }
            });
        })
        //左侧编辑类型
        $('#editPlan').click(function () {
            layer.open({
                type: 1,
                title: "编辑",
                shadeClose: true,
                btn: ['提交', '取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="templteSort" name="templteSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="templteName" id="templteName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url:'/workflow/secirityManager/selectSecurityTemplte?secirityId='+columnTrId,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                if(res.obj){
                                    if(res.obj.templteSort!=undefined&&res.obj.templteSort!=""){
                                        $("#templteSort").val(res.obj.templteSort);
                                    }
                                    if(res.obj.templteName!=undefined&&res.obj.templteName!=""){
                                        $("#templteName").val(res.obj.templteName);
                                    }
                                    if(res.obj.parentName!=undefined&&res.obj.parentName!=""){
                                        $("#pele").val(res.obj.parentName);
                                        $("#pele").attr("pid",res.obj.templteParent);
                                    }
                                }
                            }
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                            ell=eleTree.render({
                                elem: '.ele2',
                                url:'/workflow/secirityManager/getSecurityTemplteByType?parent=0',
                                expandOnClickNode: false,
                                highlightCurrent: true,
                                showLine:true,
                                lazy: true,
                                load: function(data,callback) {
                                    $.post('/workflow/secirityManager/getSecurityTemplteByType?parent='+data.id,function (res) {
                                        callback(res.data);//点击节点回调
                                    })
                                },
                                done: function(res){

                                }
                            });
                        $(".ele2").slideDown();
                    })
                    eleTree.on("nodeClick(data1)",function(d) {
                        $("[name='ttitle']").val(d.data.currentData.label)
                        $("#pele").attr("pid",d.data.currentData.id)
                        $(".ele2").slideUp();
                    })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                },
                yes: function (indexx) {
                    var plbSecurityKnowledge = {};
                    plbSecurityKnowledge.templteId = columnTrId;
                    plbSecurityKnowledge.templteSort = $("#templteSort").val();
                    plbSecurityKnowledge.templteName = $("#templteName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.templteParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#templteName").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/secirityManager/updateSecirityTemplte',
                            dataType: "json",
                            data:plbSecurityKnowledge,
                            success:function (res) {
                                if(res.code == "0" || res.code == 0){
                                    layer.msg(res.msg);
                                    setTimeout(function(){
                                        if(el){
                                            el.reload()
                                        }
                                        if(ell){
                                            ell.reload();
                                        }
                                        layer.close(indexx)
                                    },1000)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    }
                }
            });
        })

        //左侧删除类型
        $('#delPlan').click(function () {
            if(columnTrId){
                layer.confirm('是否要删除', {icon: 3, title: '删除'}, function (index) {
                    $.ajax({
                        url: '/workflow/secirityManager/delSecurityTemplteByType',
                        data: {secirityId: columnTrId},
                        type: 'get',
                        dataType: 'json',
                        success: function (res) {
                            if (res.code===0||res.code==="1") {
                                if(el){
                                    el.reload()
                                }
                                if(ell){
                                    ell.reload();
                                }
                                layer.msg(res.msg, {icon: 1})
                            } else {
                                layer.msg(res.msg, {icon: 2})
                            }
                        }
                    })
                    layer.close(index);
                });
            }else{
                layer.msg('请点击左侧类型进行删除')
            }
        })
    });
    function getRepairDate(){
        var datas = layui.table.checkStatus('Settlement').data;
        if(datas.length<1){
            layui.layer.msg("请选择一条")
            return null;
        }else{
            return datas[0]
        }
        return null;
    }

    // 初始化页面操作权限
    function initAuthority() {
        // 是否设置页面权限
        if (authorityObject) {
            // 检查保存权限
            if (authorityObject['01']) {
                $('#addPlan').show();
            }
            if (authorityObject['05']) {
                $('#editPlan').show();
            }
            if (authorityObject['04']) {
                $('#delPlan').show();
            }
        }
    }
</script>
</body>
</html>

