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
    <title>管理策划填报界面</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <%--    <script type="text/javascript" src="../../js/common/fileupload.js"></script>--%>
    <%--    <script src="/js/technical/technical.js"></script>--%>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210830.1"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>

    <style>
        html,body{
            background: #fff;
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        /*.mbox{*/
        /*    padding: 0px;*/
        /*}*/
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
            min-width: 16%;
            overflow-x: auto;
            height: 600px !important;
        }
        .layui-rt{
            width: 84%;
            margin-left: 6px;
            margin-top:0px;
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
            width:200px;
            overflow-x: scroll;
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
        /*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
        /*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
        /*height: 10px;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-button{*/
        /*background-color: #000;*/
        /*border:1px solid #ccc;*/
        /*display:block;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
        /*border-radius: 5px;*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*background: rgba(0,0,0,0.2);*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*border-radius: 0;*/
        /*background: rgba(0,0,0,0.1);}*/
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
        /*.layui-input{*/
        /*    height: 32px !important;*/
        /*}*/
        .layui-form-item{
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }
        .openFile input[type=file]{
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
        .layui-layer .layui-layer-page  {
            z-index:19000000;
        }

        .con_left {
            float: left;
            width: 210px;
            height: 100%;
            margin-top: 10px;
        }
        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
            overflow-y: auto;
            /*margin-top: 41px;*/
            /*left: -20px;*/
        }
        .operationDiv{
            position: absolute;
            top: -85px;
            width: 150px;
            border: #ccc 1px solid;
            border-radius: 4px;
            background-color: #ffffff;
            z-index: 99;
        }
        .operation{
            display: block;
            /*width: 100%;*/
            margin-left: 0px !important;
            height: 28px;
            padding-left: 10px;
            background: #fff;
            line-height: 28px;
        }
        .operation:hover{
            background-color: #cae1f7;
            color: #000000;
        }
        .layui-col-xs4{
            width: 20%;
            padding: 0 5px;
        }
        .form_label {
            float: none;
            padding: 9px 0;
            text-align: left;
            width: auto;
        }
        .form_block {
            margin: 0;
        }
        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-colla-item">
        <div class="layui-colla-content layui-show plan_base_info">
            <form class="layui-form" id="baseForm" lay-filter="formTest1">
                <div class="layui-row">
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">单据号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="planingNo" id="planingNo" readonly  autocomplete="off">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">项目名称</label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="projectName" id="projectName" readonly autocomplete="off">
                            </div>
                        </div>
                    </div>
<%--                    <div class="layui-col-xs4">--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label form_label">项目类型</label>--%>
<%--                            <div class="layui-form-block form_block">--%>
<%--                                <input type="text" class="layui-input" name="projectTypeName" id="projectTypeName" readonly  autocomplete="off">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">管理策划名称</label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="planingName" id="planingName" placeholder="请填写管理策划名称" autocomplete="off">
                            </div>
                        </div>
                    </div>
<%--                    <div class="layui-col-xs4">--%>
<%--                        <div class="layui-form-item">--%>
<%--                            <label class="layui-form-label form_label">方案类型</label>--%>
<%--                            <div class="layui-form-block form_block">--%>
<%--                                <select id="planingType" name="planingType" class="disab"></select>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">填报人</label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="createName" id="createName" readonly autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">填报时间</label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="createDate" id="createDate" readonly autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <%--                    <div class="layui-col-xs4">--%>
                    <%--                        <div class="layui-form-item">--%>
                    <%--                            <label class="layui-form-label form_label">技术方案名称</label>--%>
                    <%--                            <div class="layui-form-block form_block">--%>
                    <%--                                <input type="text" class="layui-input" name="superviseName" id="superviseName" readonly placeholder="请选择技术方案" autocomplete="off" style="background:#e7e7e7;cursor: pointer;">--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">备注</label>
                            <div class="layui-form-block form_block">
                                <input type="text" class="layui-input" name="planingDesc" id="planingDesc"  autocomplete="off" >
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs4"style="width: 100%">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">管理策划附件</label>
                            <div class="layui-form-block form_block">
                                <div class="layui-input-inline" id="one11" style="width: 100%">
                                    <div id="fileContent">
                                    </div>
                                    <a href="javascript:;" class="openFile" style="position:relative">
                                        <img src="../img/mg11.png" alt="">
                                        <span>添加附件</span>
                                        <input type="file" multiple id="fileupload1" data-url="/upload?module=planning"  name="file">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/html" id="formTable1toolbar1">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm add1" lay-event="add1" style="margin-left:10px;">选择</button>

        <button class="layui-btn layui-btn-sm del1" lay-event="del1" style="margin-left:10px;">删除</button>
    </div>
</script>
<script type="text/html" id="formTable2toolbar2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm add2" lay-event="add2" style="margin-left:10px;">选择</button>

        <button class="layui-btn layui-btn-sm del2" lay-event="del2" style="margin-left:10px;">删除</button>
    </div>
</script>
<script type="text/html" id="formTable3toolbar3">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm add3" lay-event="add3" style="margin-left:10px;">选择</button>

        <button class="layui-btn layui-btn-sm del3" lay-event="del3" style="margin-left:10px;">删除</button>
    </div>
</script>
<script type="text/html" id="formTable4toolbar4">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm add4" lay-event="add4" style="margin-left:10px;">选择</button>

        <button class="layui-btn layui-btn-sm del4" lay-event="del4" style="margin-left:10px;">删除</button>
    </div>
</script>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    var runId=getUrlParam("runId");
    var _disabled=getUrlParam("disabled");
    var urlType=getUrlParam("urlType");
    var planingId=getUrlParam("planingId");
    var projectId=getUrlParam("projectId");

    var detailsInit1;
    var detailsInitData1=[];
    var detailsInit2;
    var detailsInitData2=[];
    var detailsInit3;
    var detailsInitData3=[];
    var detailsInit4;
    var detailsInitData4=[];

    var formData=[];
    var dataArr = [];

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }

    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        TAX_RATE: {},
        CONTRACT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,TAX_RATE,CONTRACT_TYPE';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
    });

    var SettlementTable;

    layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;
        var laydate = layui.laydate;
        var superviseName="";
        var superviseId="";
        $.ajax({
            url:'/planningAdministration/autoNumber?autoNumberType=ssch',
            dataType:'json',
            type:'post',
            async: false,
            success:function(res){
                $('#planingNo').val(res.obj);
                $('#createName').val(res.object.createUserName);
                $('#createDate').val(res.object.createDate);
            }
        })
        if(projectId){
            $.ajax({
                url:'/technicalManager/getProjInfoById?projectId='+projectId,
                async:false,
                success:function(res){
                    $('#projectName').val(res.obj.projName);
                    $('#projectTypeName').val(res.obj.projType);
                }
            })
        }

        fileuploadFn('#fileupload1', $('#fileContent'));


        if(urlType=="add"){

        }else if(urlType=="edit"){
            $.ajax({
                url:'/planningAdministration/getPlanningById?planingId='+planingId,
                async:false,
                success:function(res){
                    formData=res.obj;
                }
            })
            form.val('formTest1',formData);
            if (formData.attachmentList && formData.attachmentList.length > 0) {
                var fileArr = formData.attachmentList;
                var str = '';
                for (var i = 0; i < fileArr.length; i++) {
                    var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                    /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                    str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
                        '<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                }
                $('#fileContent').append(str);
            }

        }else if(urlType=="details"){
            $.ajax({
                url:'/planningAdministration/getPlanningById?planingId='+planingId,
                async:false,
                success:function(res){
                    formData=res.obj;
                }
            })
            form.val('formTest1',formData);
            if (formData.attachmentList && formData.attachmentList.length > 0) {
                var fileArr = formData.attachmentList;
                var str = '';
                for (var i = 0; i < fileArr.length; i++) {
                    var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                    /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                    str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
                        '<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                }
                $('#fileContent').append(str);
            }
            $('input').attr("disabled",true);
            $('select').attr("disabled",true);
            $('.openFile').hide();
        }else if(runId){
            $.ajax({
                url:'/planningAdministration/getPlanningByRunId?runId='+runId,
                async:false,
                success:function(res){
                    formData=res.obj
                }
            })
            if (formData.attachmentList && formData.attachmentList.length > 0) {
                var fileArr = formData.attachmentList;
                var str = '';
                for (var i = 0; i < fileArr.length; i++) {
                    var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                    /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
                    str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
                        '<a  style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                }
                $('#fileContent').append(str);
            }
            form.val('formTest1',formData);
            if (_disabled=="1"){
                $('input').attr("disabled",true);
                $('select').attr("disabled",true);
                $('.openFile').hide();
                $('.deImgs').hide();
            }

        }
        var tableData=[];
        $(document).on('click', '#superviseName', function () {
            var supervisedId = $("#superviseName").attr('superviseId');
            parent.layer.open({
                type: 1,
                title: '选择技术方案',
                area: ['80%', '80%'],
                btnAlign: 'c',
                btn: ['确定', '取消'],
                content: ['<div class="layui-form" id="objectives">' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="reportTable" lay-filter="reportTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    parent.layui.table.render({
                        elem: '#reportTable'
                        , url: '/technicalManager/selectTechnicalReport?projectId=' + projectId+'&auditerStatus=2'
                        , page: true
                        ,cols: [[
                            {type: 'radio'}
                            ,{field:'superviseNo', title:'单据号'}
                            ,{field:'projectName', title:'项目名称'}
                            // ,{field:'projectTypeName', title:'项目类型'}
                            ,{field:'superviseName', title:'技术方案名称'}
                            ,{field:'superviseTypeName', title:'方案类型'}
                            ,{field:'userName', title:'填报人'}
                            ,{field:'createTime', title:'填报时间'}
                            , {field:'auditerStatus',title:"审批状态",templet: function (d) {
                                    if (d.auditerStatus == '0') {
                                        return '未提交';
                                    } else if (d.auditerStatus == '1') {
                                        return '<span style="color: orange">审批中</span>';
                                    } else if (d.auditerStatus == '2') {
                                        return '<span style="color: green">批准</span>'
                                    }else if (d.auditerStatus == '3'){
                                        return '<span style="color: red">不批准</span>'
                                    }else{
                                        return ''
                                    }
                                }}
                            ,{field:'superviseDesc', title:'备注'}
                        ]]
                        , limit: 10
                        ,done:function(res){
                            if(supervisedId){
                                parent.setDatta(supervisedId,res.data);
                            }
                            tableData=res.data;

                        }
                    });
                },
                yes: function (index,layero) {
                    var checkStatus =  parent.getDatta();
                    if(checkStatus!=null){
                        $.each($(parent)[0].$("iframe"),function (i, item) {
                            var iframeFun = item.contentWindow.setDatta;
                            if(iframeFun && typeof(iframeFun) == "function"){
                                item.contentWindow.setDatta(checkStatus)
                            }
                        })
                    }
                    layer.close(index);
                    parent.layui.layer.close(index);
                }, btn2: function (index, layero) {
                    layer.close(index);
                    parent.layui.layer.close(index);
                }
            });
        })
        form.render();
        
    })

    function getData(){
        var obj = {};
        //管理策划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        obj.planingId=formData.planingId;
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
        }
        obj.attachId = attachmentId;
        obj.attachName = attachmentName;

        obj.projectId = projectId;
        obj.planingId=planingId;
        obj.superviseId=$("#superviseName").attr("superviseId");
        obj.urlType=urlType;
        
        return obj;
    }

    function removeArray(_arr, _obj) {
        var length = _arr.length;
        for (var i = 0; i < length; i++) {
            delete _arr[i].LAY_TABLE_INDEX;
            delete _arr[i].LAY_CHECKED;
            if (isObjectValueEqual(_arr[i],_obj)) {
                if(_obj.derailsId != undefined ){
                    $.ajax({
                        url:'/planningAdministration/delDetails?ids='+_obj.derailsId,
                        type: 'post',
                        dataType: 'json',
                        success:function(res){

                        }
                    });
                }
                if (i == 0) {
                    _arr.shift(); //删除并返回数组的第一个元素
                    return _arr;
                }
                else if (i == length - 1) {
                    _arr.pop();  //删除并返回数组的最后一个元素
                    return _arr;
                }
                else {
                    _arr.splice(i, 1); //删除下标为i的元素
                    return _arr;
                }
            }
        }
    }

    function isObjectValueEqual(a, b) {
        var aProps = Object.getOwnPropertyNames(a);
        var bProps = Object.getOwnPropertyNames(b);
        if (aProps.length != bProps.length) {
            return false;
        }
        for (var i = 0; i < aProps.length; i++) {
            var propName = aProps[i];
            if(a[propName] instanceof Object){
                if(!isObjectValueEqual(a[propName],b[propName])){
                    return false;
                }
            }else {
                if (a[propName] !== b[propName]) {
                    return false;
                }
            }
        }
        return true;
    }

    function childFunc(){
        var loadIndex = layer.load();
        //管理策划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        obj.planingId=formData.planingId;
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
        }
        obj.attachId = attachmentId;
        obj.attachName = attachmentName;

        $.ajax({
            url: '/planningAdministration/updatePlanning',
            data: obj,
            dataType: 'json',
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code==='0'||res.code===0) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(loadIndex);
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            }
        });
        // columnId = parent.columnTrId
        // SettlementTable.reload({
        //     url: '/fileManage/getFile?columnIds='+columnId//数据接口
        // });
    }
    // function lookFile(repalogId){//查看附件
    //     if (repalogId == undefined || repalogId == "") {
    //         layer.msg("文件已被损坏，无法查看");
    //     } else {
    //         selectFile1(repalogId,'knowlage');
    //         //window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
    //     }
    // }
    // //查看附件
    // function selectFile1(attchId,model) {
    //     if(attchId){
    //         //查看附件
    //         var data={
    //             attachId:attchId,
    //             model:model
    //         }
    //         var res=toAjaxT1("/equipment/selectAttchUrl",data);
    //         if(res.code==0){
    //             if(res.object){
    //                 limsPreview1(res.object);
    //             }
    //         }
    //     }
    //
    // }
    // //附件预览点击调取
    // function limsPreview1(attrUrl) {
    //     var url = '';
    //     if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
    //         var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
    //         var atturl2 = '';
    //         if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
    //             for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
    //                 atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
    //             }
    //             url = atturl1 + atturl2;
    //         }else{
    //             url = atturl1;
    //         }
    //     }
    //     if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
    //         layui.layer.open({
    //             type: 2,
    //             title: '预览',
    //             offset:["20px",""],
    //             content: "/pdfPreview?"+url,
    //             area: ['80%', '80%']
    //         })
    //         // $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
    //     }else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
    //         layui.layer.open({
    //             type: 2,
    //             title: '预览',
    //             content: "/xs?"+url,
    //             offset:["20px",""],
    //             area: ['80%', '80%'],
    //             success:function(layero, index){
    //                 var iframeWindow = window['layui-layer-iframe'+ index];
    //                 var doc = $(iframeWindow.document);
    //                 doc.find('img').css("width","100%");
    //             }
    //         })
    //         // $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
    //     }else{
    //         pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
    //         // $.ajax({
    //         //     type:'get',
    //         //     url:'/sysTasks/getOfficePreviewSetting',
    //         //     dataType:'json',
    //         //     success:function (res) {
    //         //         if(res.flag){
    //         //             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
    //         //             if(strOfficeApps == ''){
    //         //                 strOfficeApps = 'https://view.officeapps.live.com';
    //         //             }
    //         //             layui.layer.open({
    //         //                 type: 2,
    //         //                 title: '预览',
    //         //                 offset:["20px",""],
    //         //                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
    //         //                 area: ['80%', '80%']
    //         //             })
    //         //             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
    //         //         }
    //         //     }
    //         // })
    //
    //     }
    // }
    //判断是否显示空
    function isShowNull2(data) {
        if(data){
            return data
        }else{
            return "";
        }
    }
    //同步
    function toAjaxT1(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'post',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    //截取附件文件后缀
    // function limsUrlGetRequest(name) {
    //     var attach=name
    //     return attach.substring(attach.lastIndexOf(".")+1,attach.length);
    // }
    // function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
    //     if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
    //         var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
    //         var atturl2 = '';
    //         if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
    //             for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
    //                 atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
    //             }
    //             atturl = atturl1 + atturl2;
    //         }else{
    //             atturl = atturl1;
    //         }
    //     }
    //     if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
    //         $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
    //     }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
    //         layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
    //         layer.msg('点击任意处关闭');
    //     }else if(gs == 'pdf'||gs == 'PDF'){
    //         $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
    //     }else{
    //         var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
    //         $.ajax({
    //             url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
    //             type:'post',
    //             datatype:'json',
    //             async:false,
    //             success: function (res) {
    //                 if(res.flag){
    //                     if(res.object[0].paraValue == 0){
    //                         //默认加载NTKO插件 进行跳转
    //                         url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
    //                     }else if(res.object[0].paraValue == 2){
    //                         //默认加载NTKO插件 进行跳转
    //                         url = "/wps/info?"+ atturl +"&permission=read";
    //                     }
    //                 }
    //
    //             }
    //         })
    //         setTimeout(function(){
    //             $.popWindow(url,PreviewPage,'0','0','1200px','600px');
    //         }, 1000);
    //     }
    // }
    function undefind_nullStr(value) {
        if(value==undefined){
            return ""
        }
        return value
    }
    function getAttachIds(obj) {
        return obj.aid+"@"+obj.ym+"_"+obj.attachId;
    }
    function setDatta(obj){
        $('#superviseName').val(obj.superviseName);
        $("#superviseName").attr('superviseId',obj.superviseId);
    }

</script>
</body>
</html>
