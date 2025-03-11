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
    <title>质量控制要点</title>
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
<%--    <script type="text/javascript" src="/js/email/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?2212021083015081"></script>

    <style>
        html,body{
            height: 99.8%;
        }
        .mbox{
            height: 100%;
            padding:0px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
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
            width: 18%;
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
        .rtfix{
            /*width:200px;*/
            overflow-x: hidden;
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
        .layui-tab layui-tab-card{
            margin-top: -4px;
        }
        .layui-tab-card>.layui-tab-title .layui-this:after {
            border-width: 0px;
        }
        .back{
            background-color: #F2F2F2;
        }
        .layui-form-select dl dd{
            height: 32px;
            line-height: 32px;
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
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }
        .tranDiv{
            transition-property:width;
            transition-duration:0.5s;
            transition-timing-function:linear;
            transition-delay:0s;
            width: 0;
            height: 100%;
            position: absolute;
            right: 1px;
            box-shadow: 1px 1px 7px #000000;
            z-index: 99999;
            background-color: #FFFFFF;
            overflow: hidden;
        }
        .bubble::before {
            content: '';
            width: 0;
            height: 0;
            border: 17px solid;
            position: absolute;
            top: 15px;
            left: -36px;
            border-color: transparent #000000 transparent transparent;
        }
        .bubble{
            width: 200px;
            height: 100px;
            border: 2px solid #000000;
            position: relative;
            left: 79px;
            /*top: 17px;*/
            top: -35px;
        }
        .bubble::after {
            content: '';
            width: 0;
            height: 0;
            border: 17px solid;
            position: absolute;
            top: 15px;
            left: -33px;
            border-color: transparent #fff transparent transparent;
        }
        .bubbleCustomer::before {
            content: '';
            width: 0;
            height: 0;
            border: 17px solid;
            position: absolute;
            top: 15px;
            right: -36px;
            border-color: transparent transparent transparent #000000;
        }
        .bubbleCustomer{
            width: 200px;
            height: 100px;
            border: 2px solid #000000;
            position: relative;
            left: 245px;
            top: -38px;
        }
        .bubbleCustomer::after {
            content: '';
            width: 0;
            height: 0;
            border: 17px solid;
            position: absolute;
            top: 15px;
            right: -33px;
            border-color: transparent transparent transparent #fff;
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
    <%--<div class="layui-card" style="height: 100%;">
        <div class="layui-card-body" style="padding-left: 6px;">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"  style="width: 100%">
                <ul class="layui-tab-title"  style="width: 100%">
                    <li class="layui-this">隐患排查标准</li>
                    <li >计家云</li>
                </ul>
                <div class="layui-tab-content">

                    <div class="layui-tab-item layui-show">
                        <div class="layui-card" style="height: 100%">
                            <div class="layui-card-body" style="height: 100%">
                                <div class="layui-lf rtfix">
                                    <div style="margin: 1% 1%;" id="editBox">
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan">导入</button>
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

                    <div class="layui-tab-item ">
                        <div class="layui-card" style="height: 100%">
                            <div class="layui-card-body" style="height: 100%">
                                <div class="layui-lf rtfix">
                                    <div style="margin: 1% 1%;" id="editBox2">
                                        &lt;%&ndash;<button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan2">新增</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan2">编辑</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan2">删除</button>&ndash;%&gt;
                                        <button type="button" style="width: 25%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan2">导入本地</button>
                                    </div>
                                    <div class="panel-body">
                                        <div class="eleTree ele22" lay-filter="tdata22"></div>
                                    </div>
                                </div>
                                <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                                <div class="layui-rt" style="position: relative">
                                    <table id="Settlement2" lay-filter="SettlementFilter2"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>--%>
    <div class="tranDiv">
        <div style="width: 100%;height: 10%;background-color: #F2F2F2">
            <i class="layui-icon layui-icon-triangle-r" style="position: absolute;right: 5px;top: 2%;font-size: 30px;cursor: pointer" id="iconBack"></i>
        </div>
        <div style="width: 100%;height: 61%;border: 1px solid #000000;border-left: none;border-right: none;">
            <div style="width: 100%">
                <img src="/img/main_img/serviceMan.png" style="width: 50px;height: 50px;border-radius: 25px;position: relative;top: 22px;left: 7px;border: 1px solid;display: inline-block">
                <div class="bubble"></div>
            </div>
            <div style="width: 100%">
                <img src="/img/main_img/nantouxiang.png" style="width: 50px;height: 50px;border-radius: 25px;position: relative;top: 22px;left: 89%;border: 1px solid">
                <div class="bubbleCustomer"></div>
            </div>
        </div>
        <div style="width: 100%;height: 29%;position: relative">
            <i class="layui-icon layui-icon-picture" style="position: absolute;left: 24px;font-size: 26px" id="photoIcon"></i>
            <i class="layui-icon layui-icon-file-b" style="position: absolute;left: 73px;top: 1px;font-size: 26px" id="fileIcon"></i>
            <textarea style="position: absolute;top: 18%;width: 98%;height: 70%;border: none;padding: 7px" wrap="hard"></textarea>
            <button class="layui-btn layui-btn-normal" style="position:absolute;right: 0;bottom: 7px;" id="submitBtn">发送</button>
        </div>
    </div>
    <div class="layui-card" style="height: 100%;">
        <div class="layui-tab layui-tab-card" lay-filter="docDemoTabBrief" style="position:relative;height: 100%;overflow-x: hidden">
            <div style="position: absolute;top: 5px;right: 10px;height: 35px;line-height: 35px;z-index: 10000">
                <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
            </div>
            <div class="scroll" style="overflow-x:auto;overflow-y:hidden;background-color: #f2f2f2;">
                <ul class="layui-tab-title" id="ulBox">
                    <li class="layui-this">本地知识库</li>
                    <%--<li >计家云</li>--%>
                </ul>
            </div>

            <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                <%--工程类别--%>
                <div class="layui-tab-item layui-show" style="height: 100%">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">
                                <div style="position: relative;">
                                    <input type="text" placeholder="请输入搜索内容" style="height: 30px;width: 97%">
                                    <i class="layui-icon layui-icon-search" style="position: absolute;top: 7px;right: 7px"></i>
                                </div>
                                <div style="margin: 1% 1%;" id="editBox">
                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan">导入</button>
                                </div>
                                <div class="panel-body">
                                    <div class="eleTree ele1" lay-filter="tdata"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" id="objectives" style="position: relative">
                                <div id="clientSerch" style="height: 40px">
                                    <%--表格上方搜索栏--%>
                                    <form class="layui-form" action="" style="height: 40px">
                                        <div class="query_module layui-form layui-row" style="position: relative">
                                            <div class="layui-col-xs2">
                                                <input type="text" name="securityDanger" placeholder="质量控制要点" autocomplete="off" class="layui-input">
                                            </div>
                                            <div class="layui-col-xs2" style="margin-left: 15px;">
                                                <input type="text" name="securityDangerMeasures" placeholder="特征描述" autocomplete="off" class="layui-input">
                                            </div>
                                            <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                                                <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
                                                <%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <table id="Settlement" lay-filter="SettlementFilter"></table>
                            </div>
                        </div>
                    </div>
                </div>
                <%--工程类别--%>
                <%--<div class="layui-tab-item" style="height: 100%">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">
                                <div class="panel-body" style="width:100%">
                                    <div class="eleTree ele22" lay-filter="tdata22"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" style="position: relative">
                                <table id="Settlement2" lay-filter="SettlementFilter2"></table>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <%--        {{#  if(authorityObject && authorityObject['11']){ }}--%>
        <button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 70px">新增</button>
        <%--        {{#  } }}--%>
        <%--        {{#  if(authorityObject && authorityObject['05']){ }}--%>
        <button class="layui-btn layui-btn-sm" lay-event="edit" style="width: 70px">编辑</button>
        <%--        {{#  } }}--%>
        <%--        {{#  if(authorityObject && authorityObject['02']){ }}--%>
        <button class="layui-btn layui-btn-sm" lay-event=" " style="width: 70px">导入</button>
        <%--        {{#  } }}--%>
        <%--        {{#  if(authorityObject && authorityObject['03']){ }}--%>
        <button class="layui-btn layui-btn-sm" lay-event="supplierExport" style="width: 70px">导出</button>
        <%--        {{#  } }}--%>
        <%--        {{#  if(authorityObject && authorityObject['04']){ }}--%>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" style="width: 60px">删除</button>
        <%--        {{#  } }}--%>
    </div>
</script>

<%--<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 70px">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit" style="width: 70px">编辑</button>
        <button class="layui-btn layui-btn-sm" lay-event=" " style="width: 70px">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="supplierExport" style="width: 70px">导出</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" style="width: 60px">删除</button>
    </div>
</script>--%>
<script type="text/html" id="toolbar2">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="supplierImport2" style="width: 100px">导入本地</button>
    </div>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">
    $(".layui-icon-survey").click(function(){
        $(".tranDiv").css("display","");
        setTimeout(function(){
            $(".tranDiv").css("width","46%");
        },100);
    });
    $("#iconBack").click(function(){
        $(".tranDiv").css("display","none");
        $(".tranDiv").css("width","0");
    })
    $("#submitBtn").click(function(){
        var textVal=$("textarea").val();
        alert(textVal);
    })

    initAuthority();


    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });


    var idss = getUrlParam('ids');
    console.log(idss);
    if(idss){
        idss = idss.split(",");
        console.log(idss);
    }
    var urlType = getUrlParam("urlType");
    console.log(urlType);
    var toolbar;
    if(urlType=='addImplementationPlanning'||urlType=='qualityCheck'){
        toolbar = ''
    }else {
        toolbar = '#toolbar'
    }

    var _dataa=null

    $('.rtfix').css('max-height',autodivheight()-55)
    var el;
    var ell;
    var parData;
    var arr = [];
    //var directjudge;
    //var idkey;
    //var AllEquipTypeId;
    var columnTrId;
    var codeNo;
    var codNam;
    var SettlementTable;
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var knowTypeIds=getUrlParam('knowTypeIds');
    var type = getUrlParam('pageType');
    var tableType = getUrlParam('type');
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
        //$.ajax({
        //    url:'/knowledgeCenter/getCloudPriv',
        //    dataType:'json',
        //    type:'post',
        //    success:function(res){
        //        if(res.obj.knowledgeFlag!=undefined&&res.obj.knowledgeFlag==0){
        //            if(tab(res.obj.knowledgeBTime,res.obj.knowledgeETime)){
        //                 $('#ulBox').append('<li >计家云</li>')
        //                 var htmlDiv = '<div class="layui-tab-item" style="height: 100%">\n' +
        //                     '                    <div class="layui-card" style="height: 100%">\n' +
        //                     '                        <div class="layui-card-body" style="height: 100%">\n' +
        //                     '                            <div class="layui-lf rtfix">\n' +
        //                     '                                <div class="panel-body">\n' +
        //                     '                                    <div class="eleTree ele22" lay-filter="tdata22"></div>\n' +
        //                     '                                </div>\n' +
        //                     '                            </div>\n' +
        //                     '                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>\n' +
        //                     '                            <div class="layui-rt" style="position: relative">\n' +
        //                     '                                <table id="Settlement2" lay-filter="SettlementFilter2"></table>\n' +
        //                     '                            </div>\n' +
        //                     '                        </div>\n' +
        //                     '                    </div>\n' +
        //                     '                </div>'
        //                 $('#divBox').append(htmlDiv);
        //                 // 初始化渲染 树形菜单
        //
        //                 var el2 = eleTree.render({
        //                     elem: '.ele22',
        //                     showLine:true,
        //                     url:'/knowledge/goToParent?url=/workflow/qualityManager/getSecurityByType&parent=0',
        //                     lazy: true,
        //                     // checked: true,
        //                     load: function(data,callback) {
        //                         $.post('/knowledge/goToParent?url=/workflow/qualityManager/getSecurityByType&parent='+data.id,function (res) {
        //                             callback(res.data);//点击节点回调
        //                         })
        //                     },
        //                     done:function (data) { //渲染完成回调
        //                         var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
        //                         var na = $("#ulBox").find("li.layui-this").html();
        //                         codNam2 = encodeURI(encodeURI(na));
        //                         codeNo2 = n1;
        //                         if(data.data.length == 0){
        //                             $('.ele22').html('<div style="text-align: center">暂无数据</div>');
        //                             columnTrId2 = undefined;
        //                         }else{
        //                             columnTrId2 = data.data[0].id;
        //                             var dataid=$('.ele22 div').attr("data-id")
        //                             $('.eleTree-node').removeClass('back')
        //                             $('.ele1 div[data-id='+dataid+']').addClass('back')
        //                             $('.eleTree-node-group').css('background','#fff');
        //                             childFunc2(columnTrId2);  //调用应用中方法
        //                         }
        //                     }
        //                 });
        //            }
        //       }
        //   }
        //})

        //隐患排查标准
        if(tableType!=undefined&&tableType=="checkTemplte"){
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: '.ele1',
                showLine:true,
                url:'/workflow/qualityManager/getSecurityKnowledgeTypeByType?knowledgeTypes='+knowTypeIds,
                lazy: false,
                // checked: true,
                /*load: function(data,callback) {
                    $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
                        callback(res.data);//点击节点回调
                    })
                },*/
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
        }else{
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: '.ele1',
                showLine:true,
                url:'/workflow/qualityManager/getSecurityByType?parent=0',
                lazy: true,
                // checked: true,
                load: function(data,callback) {
                    $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
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
        }

        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            parData = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            columnTrId = d.data.currentData.id;
            var clas = "";
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
        /*$(document).on("click",function() {
            $(".ele1").slideUp();
        })*/
        //树的方法
        /*function treeFn(cla) {
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
        }*/
        function childFunc(secirityId){
            if(tableType!=undefined&&tableType=="radio"){
                $("#editBox").hide();
                // 树右侧表格实例
                SettlementTable = layui.table.render({
                    elem: '#Settlement'
                    // , data: []
                    , url: '/workflow/qualityManager/getSecurityByIds?ids='+secirityId//数据接口
                    , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                        layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                        , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                        , first: false //不显示首页
                        , last: false //不显示尾页
                    } //开启分页
                    //, toolbar: '#toolbar'
                    , cols: [[ //表头
                        {type: 'radio'}
                        , {type: 'numbers', title: '序号'}
                        , {field: 'securityDanger',title: '质量控制要点', templet: function (d) {
                                return '<span class="securityDanger" knowledgeTopName="'+(d.knowledgeTopName || '')+'" securityDangerId="'+(d.securityDangerId || '')+'">' + (d.securityDanger || '') + '</span>';
                            }}
                        , {field: 'securityDangerMeasures', title: '特征描述'}
                        , {field: 'securityDangerGrade', width:100,title: '重大问题',templet:function(d){
                                if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                    if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                        return "<span style='color: red' securityDangerGrade="+d.securityDangerGrade+">是</span>";
                                    }else{
                                        return "<span securityDangerGrade="+d.securityDangerGrade+">否</span>";
                                    }
                                }else{
                                    return "";
                                }
                            }}
                        // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                    ]]
                    , limit: 10
                    , done: function (res) {
                        _dataa=res.data;
                        //设置危险等级背景高亮
                        //$(".layui-table-body tr[data-index=" + 1 + "]").attr({ "style": "background:#FF6EB4;" });//改变当前tr颜色
                    }
                });
            }else if(tableType!=undefined&&((tableType=="checkTemplte"&&knowTypeIds!=undefined)||tableType=="checkbox")){
                $("#editBox").hide();
                // 树右侧表格实例
                SettlementTable = layui.table.render({
                    elem: '#Settlement'
                    // , data: []
                    , url: '/workflow/qualityManager/getSecurityByIds?ids='+secirityId//数据接口
                    , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                        layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                        , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                        , first: false //不显示首页
                        , last: false //不显示尾页
                    } //开启分页
                    //, toolbar: '#toolbar'
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号'}
                        , {field: 'securityDanger', title: '质量控制要点'}
                        , {field: 'securityDangerMeasures', title: '特征描述'}
                        , {
                            field: 'attachmentName',
                            title: '特征图片',
                            align: 'center',
                            minWidth: 200,
                            templet: function (d) {
                                var fileArr = d.attachmentList;
                                var str = '';
                                if (fileArr && fileArr.length > 0) {
                                    for (var i = 0; i < fileArr.length; i++) {
                                        var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                        var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                        /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                                        str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;display: none" src="/img/file/icon_deletecha_03.png"/>' +
                                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                            '<input type="hidden" class="inHidden" deUrl="' + fileArr[i].attUrl+ '" attachId="' + fileArr[i].attachId+ '" attachName="' + fileArr[i].attachName+ '" fileName="'+fileArr[i].attachName+'*" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                                            '</div>';
                                    }
                                    //$('#fileContent').append(str);
                                }
                                return '<div id="fileAll'+d.LAY_INDEX+'"> ' +str+
                                    '</div>'

                            }
                        }
                        , {field: 'securityDangerGrade', width:100,title: '重大问题',templet:function(d){
                                if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                    if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                        return "<div><span style='color: red'>是</span></div>";
                                    }else{
                                        return "<div>否</div>";
                                    }
                                }else{
                                    return "";
                                }
                            }}
                        // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                    ]]
                    , limit: 10
                    , done: function (res) {
                        _dataa=res.data;
                        //设置危险等级背景高亮
                        //$(".layui-table-body tr[data-index=" + 1 + "]").attr({ "style": "background:#FF6EB4;" });//改变当前tr颜色
                    }
                });
            }else{
                $("#editBox").show();
                // 树右侧表格实例
                SettlementTable = layui.table.render({
                    elem: '#Settlement'
                    // , data: []
                    , url: '/workflow/qualityManager/getSecurityByIds?ids='+secirityId//数据接口
                    , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                        layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                        , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                        , first: false //不显示首页
                        , last: false //不显示尾页
                    } //开启分页
                    , toolbar: toolbar
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号'}
                        , {field: 'securityDanger', title: '质量控制要点'}
                        , {field: 'securityDangerMeasures', title: '特征描述'}
                        , {
                            field: 'attachmentName',
                            title: '特征图片',
                            align: 'center',
                            minWidth: 200,
                            templet: function (d) {
                                var fileArr = d.attachmentList;
                                var str = '';
                                if (fileArr && fileArr.length > 0) {
                                    for (var i = 0; i < fileArr.length; i++) {
                                        var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                        var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                        /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                                        str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;display: none" src="/img/file/icon_deletecha_03.png"/>' +
                                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                            '<input type="hidden" class="inHidden" deUrl="' + fileArr[i].attUrl+ '" attachId="' + fileArr[i].attachId+ '" attachName="' + fileArr[i].attachName+ '" fileName="'+fileArr[i].attachName+'*" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                                            '</div>';
                                    }
                                    //$('#fileContent').append(str);
                                }
                                return '<div id="fileAll'+d.LAY_INDEX+'"> ' +str+
                                    '</div>'

                            }
                        }
                        , {field: 'securityDangerGrade',width:100, title: '重大问题',templet:function(d){
                                if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                    if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                        return "<div><span style='color: red'>是</span></div>";
                                    }else{
                                        return "<div>否</div>";
                                    }
                                }else{
                                    return "";
                                }
                            }}
                        // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                    ]]
                    , limit: 10
                    , done: function (res) {
                        _dataa=res.data;
                        var data = res.data;
                        if(idss!=undefined&&idss.length>0){
                            for(var i = 0 ; i <data.length;i++){
                                for(var n = 0 ; n < idss.length; n++){
                                    if(data[i].securityDangerId == idss[n]){
                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                        // form.render('checkbox');
                                    }
                                }
                            }
                        }
                        //设置危险等级背景高亮
                        //$(".layui-table-body tr[data-index=" + 1 + "]").attr({ "style": "background:#FF6EB4;" });//改变当前tr颜色
                    }
                });
            }
        }

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                // $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            SettlementTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //表格头工具事件
        table.on('toolbar(SettlementFilter)', function(obj){
            var checkStatus = table.checkStatus("Settlement").data;
            var event = obj.event;
            switch(event){
                case 'upfile': //上传附件
                    if(columnTrId==undefined){
                        layer.msg("请选择知识类型");
                        return false;
                    }
                    var index = layer.open({
                        type: 1,
                        //skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '新建',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        btnAlign: 'c',
                        content: '<div class="layui-form" id="boxfo">' +
                            '<div class="inbox" style="margin-top:30px"><label class="layui-form-label" style="width: 100px;">排序号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<input class="layui-input"  lay-verify="required" name="securityDangerSort" id="securityDangerSort" style="width: 90%;float: left;"><div><i id="reKey" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh layui-anim " ></i></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>质量控制要点</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<textarea name="securityDanger" id="securityDanger" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;">特征描述</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<textarea name="securityDangerMeasures" id="securityDangerMeasures" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;">重大问题</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<select name="securityDangerGrade" id="securityDangerGrade"></select></div></div>' +
                            '<div class="inbox">' +
                            '<label class="layui-form-label" style="width: 100px;">特征图片</label>' +
                            '<div class="layui-input-block" style="margin-left: 130px;">' +
                            '<div class="file_module" style="margin-top: 8px;">' +
                            '<div id="fileContent" class="file_content"></div>' +
                            '<div class="file_upload_box">' +
                            '<a href="javascript:;" class="open_file">' +
                            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '<input type="file" multiple id="fileupload" data-url="/upload?module=qualityDanger" name="file">' +
                            '</a>' +
                            '<div class="progress" id="progress">' +
                            '<div class="bar"></div>\n' +
                            '</div>' +
                            '<div class="bar_text"></div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<input type="hidden" name="attachmentId">' +
                            '<input type="hidden" name="attachmentName">' +
                            '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
                            '</div>'+
                            '</div>',
                        success: function () {
                            $.ajax({
                                url: '/workflow/qualityManager/getStandSort?parentId='+columnTrId+'&isStand=true',
                                type: 'get',
                                dataType: 'json',
                                async:false,
                                success: function (res) {
                                    $('#securityDangerSort').val(res.obj);
                                }
                            })
                            var $select1 = $("select[name='securityDangerGrade']");
                            var optionStr = '<option value="">请选择</option>';
                            optionStr += '<option value="0"><span style="color:red">是</span></option>'
                            optionStr += '<option value="1">否</option>'
                            $select1.html(optionStr);

                            fileuploadFn('#fileupload', $('#fileContent'),1);

                            $("#reKey").on("click",function (e) {
                                $("#reKey").addClass("layui-anim-rotate layui-anim-loop");
                                $.ajax({
                                    url: '/workflow/qualityManager/getStandSort?parentId='+columnTrId+'&isStand=true',
                                    type: 'get',
                                    dataType: 'json',
                                    async:false,
                                    success: function (res) {
                                        setTimeout(function(){
                                            $("#reKey").removeClass("layui-anim-rotate layui-anim-loop");
                                        },1000);
                                        $('#securityDangerSort').val(res.obj);
                                    }
                                })
                            })

                            form.render();//初始化表单
                        },
                        yes: function (index, layero) {
                            if($("#securityDanger").val()==undefined||$("#securityDanger").val()==""){
                                layer.msg("请输入质量控制要点");
                                return false;
                            }
                                // else if($("#securityDangerMeasures").val()==undefined||$("#securityDangerMeasures").val()==""){
                                //     layer.msg("请输入特征描述");
                                //     return false;
                            // }
                            else {
                                // 附件
                                var attachmentId = '';
                                var attachmentName = '';
                                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                    attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                                }
                                $('[name="attachmentId"]').val(attachmentId)
                                $('[name="attachmentName"]').val(attachmentName)

                                $("#add-file-submit").click();
                            }
                        }
                    });
                    form.on('submit(add-file-submit)', function (data) {
                        var securityDanger = data.field;
                        securityDanger.securityDangerTypeId = columnTrId;
                        $.ajax({
                            url:'/workflow/qualityManager/insertSecurityDanger',
                            type: 'post',
                            dataType:'json',
                            data:securityDanger,
                            success:function(res){
                                if(res.code===0||res.code==="0"){
                                    SettlementTable.reload();
                                    layer.closeAll();
                                }
                                layer.msg(res.msg)
                            }
                        })
                    });
                    break;
                case 'delete':  //多条删除
                    if(checkStatus.length == 0){
                        layer.msg("请选中一条或多条数据，进行删除");
                        return false;
                    }else{
                        var ids = "";
                        for(var i=0;i<checkStatus.length;i++){
                            ids += checkStatus[i].securityDangerId+",";
                        }
                        layer.confirm('确定要删除吗？', function(index){
                            $.ajax({
                                type: "post",
                                url: '/workflow/qualityManager/delSecurityDanger',
                                dataType: "json",
                                data:{
                                    ids:ids
                                },
                                success:function (res) {
                                    if(res.code === "0" || res.code === 0){
                                        SettlementTable.reload();
                                    }
                                    layer.msg(res.msg);
                                }
                            })
                            layer.close(index);
                        });
                    }
                    break;
                case 'edit':
                    if(checkStatus.length == 1){
                        var danger = checkStatus[0];
                        var index = layer.open({
                            type: 1,
                            //skin: 'layui-layer-molv', //加上边框
                            area: ['80%', '90%'], //宽高
                            title: '编辑',
                            maxmin: true,
                            btn: ['提交', '取消'],
                            btnAlign: 'c',
                            content: '<div class="layui-form" id="boxfo">' +
                                '<div class="inbox" style="margin-top:30px"><label class="layui-form-label" style="width: 100px;">排序</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<input class="layui-input"  lay-verify="required" name="securityDangerSort" id="securityDangerSort"><input type="hidden"  name="securityDangerId" id="securityDangerId"></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>质量控制要点</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<textarea name="securityDanger" id="securityDanger" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;">特征描述</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<textarea name="securityDangerMeasures" id="securityDangerMeasures" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;">重大问题</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<select name="securityDangerGrade" id="securityDangerGrade"></select></div></div>' +
                                '<div class="inbox">' +
                                '<label class="layui-form-label" style="width: 100px;">特征图片</label>' +
                                '<div class="layui-input-block" style="margin-left: 130px;">' +
                                '<div class="file_module" style="margin-top: 8px;">' +
                                '<div id="fileContent" class="file_content"></div>' +
                                '<div class="file_upload_box">' +
                                '<a href="javascript:;" class="open_file">' +
                                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                                '<input type="file" multiple id="fileupload" data-url="/upload?module=qualityDanger" name="file">' +
                                '</a>' +
                                '<div class="progress" id="progress">' +
                                '<div class="bar"></div>\n' +
                                '</div>' +
                                '<div class="bar_text"></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '<input type="hidden" name="attachmentId">' +
                                '<input type="hidden" name="attachmentName">' +
                                '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="edit-file-submit" id="edit-file-submit" value="确认"></div>' +
                                '</div>',//<span style="color:#ff0000">*</span>
                            success: function () {
                                var $select1 = $("select[name='securityDangerGrade']");
                                var optionStr = '<option value="">请选择</option>';
                                optionStr += '<option value="0"><span style="color:red">是</span></option>'
                                optionStr += '<option value="1">否</option>'
                                $select1.html(optionStr);

                                fileuploadFn('#fileupload', $('#fileContent'),1);

                                $("#securityDangerSort").val(danger.securityDangerSort)
                                $("#securityDanger").text(danger.securityDanger)
                                $("#securityDangerMeasures").text(danger.securityDangerMeasures)
                                $("#securityDangerGrade").val(danger.securityDangerGrade)
                                $("#securityDangerId").val(danger.securityDangerId)

                                //附件
                                if (danger.attachmentList && danger.attachmentList.length > 0) {
                                    var fileArr = danger.attachmentList;
                                    var str = '';
                                    for (var i = 0; i < fileArr.length; i++) {
                                        var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                        var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                        /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                                        str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                                    }
                                    $('#fileContent').append(str);
                                }


                                form.render();//初始化表单
                            },
                            yes: function (index, layero) {
                                if($("#securityDanger").val()==undefined||$("#securityDanger").val()==""){
                                    layer.msg("请输入质量控制要点");
                                    return false;
                                }
                                    // else if($("#securityDangerMeasures").val()==undefined||$("#securityDangerMeasures").val()==""){
                                    //     layer.msg("请输入特征描述");
                                    //     return false;
                                // }
                                else {
                                    // 附件
                                    var attachmentId = '';
                                    var attachmentName = '';
                                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                        attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                                    }
                                    $('[name="attachmentId"]').val(attachmentId)
                                    $('[name="attachmentName"]').val(attachmentName)

                                    $("#edit-file-submit").click();
                                }
                            }
                        });
                        form.on('submit(edit-file-submit)', function (data) {
                            var plbSecurityDanger = data.field;
                            plbSecurityDanger.securityDangerGrade = $("#securityDangerGrade").val();
                            plbSecurityDanger.securityDangerTypeId = columnTrId;
                            $.ajax({
                                url:'/workflow/qualityManager/updateSecirityDanger',
                                type: 'post',
                                dataType:'json',
                                data:plbSecurityDanger,
                                success:function(res){
                                    if(res.code===0||res.code==="0"){
                                        SettlementTable.reload();
                                        layer.closeAll();
                                    }
                                    layer.msg(res.msg)
                                }
                            })
                        });
                    }else{
                        layer.msg("请选中一条进行编辑");
                    }
                    break;
                case 'supplierImport':
                    layer.msg("功能正在开发中");
                    return false;
                    var index = layer.open({
                        type: 1
                        , area: ['100%', '100%']
                        , title: '导入'
                        , content:
                            '<div class="layui-form " id="ids">' +
                            '   <div class="main importTable">' +
                            '       <div class="layui-input-block" style="margin-left:0px">\n' +
                            '       <form class="form1" name="form1" id="uploadForm" method="post" action="/workflow/qualityManager/insertImport?type='+columnTrId+'" enctype="multipart/form-data">\n' +
                            '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                            '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">下载导入模板：</label>\n' +
                            '   <div style="padding: 15px;" style="display: inline-block;width: 70%;">\n' +
                            '     <a id="model" style="color: deepskyblue;cursor:pointer">隐患台账导入模板下载</a>\n' +
                            '   </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;">\n' +
                            '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">选择导入文件：</label>\n' +
                            '   <div style="padding: 15px" style="display: inline-block;width: 70%;">\n' +
                            '     <input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>\n' +
                            '   </div>\n' +
                            ' </div>\n' +
                            ' <div style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                            '   <label style="padding: 0px 6px 15px 6px;width: 100px" class="layui-form-label">说明：</label>\n' +
                            '   <div style="display: inline-block;width: 70%">\n' +
                            '                    <p >1.请导入.xls文件或者.xlsx。</p>\n' +
                            '                    <p style="padding: 15px 0px 10px 0px">2.模版格式均为文本格式。</p>\n' +
                            '   </div>\n' +
                            ' </div>\n' +
                            ' <div style="text-align: center;padding-top: 20px;width: 700px;">\n' +
                            '      <input class="importBtn layui-btn layui-btn-normal" type="button" value="导入">\n' +
                            '      <input class="return layui-btn layui-btn-normal" type="button" value="返回">\n' +
                            ' </div>\n' +
                            '   </form>\n' +
                            '</div>\n'+
                            '</div>\n'+
                            '</div>'
                        , success: function (res) {
                            $('#model').click(function () {
                                window.location.href = encodeURI("/file/security/security.xls");
                            });

                            $('.importBtn').click(function () {
                                var flag = CheckForm();
                                if (flag) {
                                    $('#uploadForm').ajaxSubmit({
                                        dataType: 'json',
                                        success:function (res) {
                                            if (res.flag) {
                                                layer.msg("导入成功！", {icon: 1});
                                                layer.close(index);
                                                SettlementTable.reload();
                                            } else {
                                                layer.msg("导入失败！", {icon: 2});
                                            }
                                        }
                                    })
                                }
                            });
                            $(".return").click(function(){
                                layer.close(index);
                            })
                            function CheckForm() {
                                if (document.form1.file.value == "") {
                                    layer.msg("<fmt:message code='user.th.selectImport' />！", {icon: 2});
                                    return (false);
                                }
                                return (true);
                            }
                        }

                    })
                    break;
                case 'supplierExport':
                    window.location = "/workflow/qualityManager/export"
                    break;
            };
        });

        //左侧新建类型
        $('#addPlan').click(function () {
            layer.open({
                type: 1,
                title: "新建",
                shadeClose: true,
                btn: ['提交', '取消'],
                btnAlign: 'c',
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    '                                    <input type="text" name="equipId" style="display: none" id="layui-form">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="securityKnowledgeSort" name="securityKnowledgeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="securityKnowledgeName" id="securityKnowledgeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url: '/workflow/qualityManager/getStandSort?parentId='+columnTrId+'&isStand=false',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            $('#securityKnowledgeSort').val(res.obj);
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/workflow/qualityManager/getSecurityByType?parent=0',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
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
                    plbSecurityKnowledge.securityKnowledgeSort = $("#securityKnowledgeSort").val();
                    plbSecurityKnowledge.securityKnowledgeName = $("#securityKnowledgeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.securityKnowledgeParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#securityKnowledgeName").val()==''||$("#securityKnowledgeSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/qualityManager/insertSecirityManager',
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

        //左侧导入类型
        $('#importPlan').click(function () {
            var index = layer.open({
                type: 1
                , area: ['100%', '100%']
                , title: '导入'
                , content:
                    '<div class="layui-form " id="ids">' +
                    '   <div class="main importTable">' +
                    '       <div class="layui-input-block" style="margin-left:0px">\n' +
                    '       <form class="form1" name="form1" id="uploadForm" method="post" action="/workflow/qualityManager/importSecurityKnowledge" enctype="multipart/form-data">\n' +
                    '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                    '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">下载导入模板：</label>\n' +
                    '   <div style="padding: 15px;" style="display: inline-block;width: 70%;">\n' +
                    '     <a id="model" style="color: deepskyblue;cursor:pointer">隐患台账导入模板下载</a>\n' +
                    '   </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;">\n' +
                    '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">选择导入文件：</label>\n' +
                    '   <div style="padding: 15px" style="display: inline-block;width: 70%;">\n' +
                    '     <input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>\n' +
                    '   </div>\n' +
                    ' </div>\n' +
                    ' <div style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                    '   <label style="padding: 0px 6px 15px 6px;width: 100px" class="layui-form-label">说明：</label>\n' +
                    '   <div style="display: inline-block;width: 70%">\n' +
                    '                    <p >1.请导入.xls文件或者.xlsx。</p>\n' +
                    '                    <p style="padding: 15px 0px 10px 0px">2.模版格式均为文本格式。</p>\n' +
                    '   </div>\n' +
                    ' </div>\n' +
                    ' <div style="text-align: center;padding-top: 20px;width: 700px;">\n' +
                    '      <input class="importBtn layui-btn layui-btn-normal" type="button" value="导入">\n' +
                    '      <input class="return layui-btn layui-btn-normal" type="button" value="返回">\n' +
                    ' </div>\n' +
                    '   </form>\n' +
                    '</div>\n'+
                    '</div>\n'+
                    '</div>'
                , success: function (res) {
                    $('#model').click(function () {
                        window.location.href = encodeURI("/file/security/security.xls");
                    });

                    $('.importBtn').click(function () {
                        var flag = CheckForm();
                        if (flag) {
                            $('#uploadForm').ajaxSubmit({
                                dataType: 'json',
                                success:function (res) {
                                    if (res.flag) {
                                        layer.msg("导入成功！", {icon: 1});
                                        layer.close(index);
                                        SettlementTable.reload();
                                    } else {
                                        layer.msg("导入失败！", {icon: 2});
                                    }
                                }
                            })
                        }
                    });
                    $(".return").click(function(){
                        layer.close(index);
                    })
                    function CheckForm() {
                        if (document.form1.file.value == "") {
                            layer.msg("<fmt:message code='user.th.selectImport' />！", {icon: 2});
                            return (false);
                        }
                        return (true);
                    }
                }

            })
        })
        //左侧编辑类型
        $('#editPlan').click(function () {
            layer.open({
                type: 1,
                title: "编辑",
                shadeClose: true,
                btn: ['提交', '取消'],
                btnAlign: 'c',
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    // '                                    <input type="text" name="equipId" style="display: none" id="layui-form">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="securityKnowledgeSort" name="securityKnowledgeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="securityKnowledgeName" id="securityKnowledgeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url:'/workflow/qualityManager/selectSecurityManager?secirityId='+columnTrId,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                if(res.obj){
                                    if(res.obj.securityKnowledgeSort!=undefined&&res.obj.securityKnowledgeSort!=""){
                                        $("#securityKnowledgeSort").val(res.obj.securityKnowledgeSort);
                                    }
                                    if(res.obj.securityKnowledgeName!=undefined&&res.obj.securityKnowledgeName!=""){
                                        $("#securityKnowledgeName").val(res.obj.securityKnowledgeName);
                                    }
                                    if(res.obj.parentName!=undefined&&res.obj.parentName!=""){
                                        $("#pele").val(res.obj.parentName);
                                        $("#pele").attr("pid",res.obj.securityKnowledgeParent);
                                    }
                                }
                            }
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/workflow/qualityManager/getSecurityByType?parent=0',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
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
                    plbSecurityKnowledge.securityKnowledgeId = columnTrId;
                    plbSecurityKnowledge.securityKnowledgeSort = $("#securityKnowledgeSort").val();
                    plbSecurityKnowledge.securityKnowledgeName = $("#securityKnowledgeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.securityKnowledgeParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#securityKnowledgeName").val()==''||$("#securityKnowledgeSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/qualityManager/updateSecirityManager',
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
                        url: '/workflow/qualityManager/delSecurityByType',
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

        //计家云
        var parData2;
        var arr2 = [];
        var columnTrId2;
        var codeNo2;
        var codNam2;
        var SettlementTable2;

        element.on('tab(docDemoTabBrief)', function(){
            childFunc2(columnTrId2);
        });


        // 节点点击事件
        eleTree.on("nodeClick(tdata22)",function(d) {
            parData2 = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam2 = encodeURI(encodeURI(na));
            codeNo2 = n1;
            columnTrId2 = d.data.currentData.id;
            var clas = "";
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            childFunc2(columnTrId2);  //调用应用中方法
        });
        //选中监听事件
        eleTree.on("nodeChecked(tdata22)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr2.push(id);
            }else{
                arr2.remove(id);
            }
        })


        /*$(document).on("click",function() {
            $(".ele22").slideUp();
        })*/
        function childFunc2(secirityId){
            // 树右侧表格实例
            SettlementTable2 = layui.table.render({
                elem: '#Settlement2'
                // , data: []
                , url: '/knowledge/goToParent?url=/workflow/qualityManager/getSecurityByIds&ids='+secirityId//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#toolbar2'
                , cols: [[ //表头
                    {type: 'radio'}
                    , {type: 'numbers', title: '序号'}
                    , {field: 'securityDanger', title: '质量控制要点'}
                    , {field: 'securityDangerMeasures', title: '特征描述'}
                    , {field: 'securityDangerGrade',width:100, title: '重大问题',templet:function(d){
                            if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                    return "<div><span>是</span></div>";
                                }else{
                                    return "<div>否</div>";
                                }
                            }else{
                                return "";
                            }
                        }}
                    // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res) {
                    var data = res.data;
                    if(idss!=undefined&&idss.length>0){
                        for(var i = 0 ; i <data.length;i++){
                            for(var n = 0 ; n < idss.length; n++){
                                if(data[i].securityDangerId == idss[n]){
                                    $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                    // form.render('checkbox');
                                }
                            }
                        }
                    }
                    //设置危险等级背景高亮
                    //$(".layui-table-body tr[data-index=" + 1 + "]").attr({ "style": "background:#FF6EB4;" });//改变当前tr颜色
                }
            });
        }
        //表格头工具事件
        var parData3;
        var columnTrId3;
        var codeNo3;
        var codNam3;
        table.on('toolbar(SettlementFilter2)', function(obj){
            var checkStatus = table.checkStatus("Settlement2").data[0];
            var event = obj.event;
            switch(event){
                case 'supplierImport2': //导入本地
                    if(table.checkStatus("Settlement2").data.length!='1'){
                        layer.msg("请选择一条");
                    }else{
                        layer.open({
                            type: 1,
                            //skin: 'layui-layer-molv', //加上边框
                            area: ['23%', '64%'], //宽高
                            title: '导入本地',
                            maxmin: true,
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content:
                                '<div class="layui-card-body" style="height: 100%">'+
                                '<div class="panel-body" style="width: 100%">'+
                                '<div class="eleTree elee4" lay-filter="tdata1"></div>'+
                                '</div>'+
                                '</div>',
                            success: function () {
                                // 初始化渲染 树形菜单
                                var el = eleTree.render({
                                    elem: '.elee4',
                                    showLine:true,
                                    url:'/workflow/qualityManager/getSecurityByType?parent=0',
                                    lazy: true,
                                    // checked: true,
                                    load: function(data,callback) {
                                        $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
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
                                // 节点点击事件
                                eleTree.on("nodeClick(tdata1)",function(d) {
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
                            },
                            yes: function (index, layero) {
                                delete  checkStatus.securityCreateUser;
                                delete  checkStatus.securityCreateTime;
                                delete  checkStatus.securityDangerId;
                                checkStatus.securityDangerTypeId = columnTrId3;
                                $.ajax({
                                    url:'/workflow/qualityManager/insertSecurityDanger',
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
    });



    function getRepairDate(){
        var datas = layui.table.checkStatus('Settlement').data;
        if(datas.length<0){
            layui.layer.msg("请至少选择一条")
            return null;
        }else{
            for(var i=0;i<datas.length;i++){
                datas[i].tr1 = datas[i].securityDanger;
                datas[i].tr2 = datas[i].securityDangerMeasures;
                datas[i].tr4 = datas[i].securityDangerGrade;
            }
            return datas
        }
        return null;
    }

    function getRepairDate2(){
        var datas = layui.table.checkStatus('Settlement2').data;
        if(datas.length<0){
            layui.layer.msg("请至少选择一条")
            return null;
        }else{
            for(var i=0;i<datas.length;i++){
                datas[i].tr1 = datas[i].securityDanger;
                datas[i].tr2 = datas[i].securityDangerMeasures;
                datas[i].tr4 = datas[i].securityDangerGrade;
            }
            return datas
        }
        return null;
    }
    //安全检查页面引用
    function getRepairDate3(){
        //var datas = layui.table.checkStatus('Settlement').data;
        var dataa ={};

        $('#objectives .layui-table-body .laytable-cell-radio').each(function(index,item){
            if($(item).find('.layui-form-radioed').length>0){
                dataa={
                    securityKnowledgeName : $(item).parents('tr').find('.securityDanger').attr('knowledgetopname')||'',
                    securityDanger : $(item).parents('tr').find('.securityDanger').text()||'',
                    securityDangerMeasures : $(item).parents('tr').find('[data-field="securityDangerMeasures"] div').text()||'',
                    securityGrade : $(item).parents('tr').find('[data-field="securityDangerGrade"] span').attr('securityDangerGrade')||'',
                    securityDangerId : $(item).parents('tr').find('.securityDanger').attr('securitydangerid')||'',
                }
            }
        })
        return dataa
    }
    //安全模板
    function getRepairDate4(){
        var datas = layui.table.checkStatus('Settlement').data;
        for(var i=0;i<datas.length;i++){
            datas[i].securityKnowledgeName = datas[i].knowledgeTopName?datas[i].knowledgeTopName:'',
                datas[i].securityDanger = datas[i].securityDanger?datas[i].securityDanger:'',
                datas[i].securityDangerMeasures = datas[i].securityDangerMeasures?datas[i].securityDangerMeasures:'',
                datas[i].securityDangerGrade = datas[i].securityDangerGrade?datas[i].securityDangerGrade:''
        }
        return datas
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
            if (authorityObject['02']) {
                $('#importPlan').show();
            }
        }
    }
</script>
</body>
</html>

