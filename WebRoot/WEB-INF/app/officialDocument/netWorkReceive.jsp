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
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>来文接收</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui_v2.5.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script src="/js/base/base.js" type="text/javascript"></script>

    <style>
        .layui-anim-upbit {
            max-height: 200px !important;
        }
        .layui-form-label {
            width: 100px !important;
        }
        .layui-input-block {
            margin-left: 130px !important;
        }

        .layui-table-body{
            overflow-x:auto;
        }

        .divShow {
            display: block;
            position: relative;
            text-align: left;
            line-height: 20px;
        }
        .divShow a {
            color: #1687cb !important;
            text-decoration: none !important;
        }

        .divShow .operationDiv {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: #f2f2f2;
            z-index: 1;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-shadow: 0 0 6px 0px;
        }
        .divShow:hover .operationDiv {
            display: block;
        }
        .layui-col-xs5 {
            width: 30.666667%;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="demo">
    <ul class="layui-tab-title">
        <li class="layui-this"><fmt:message code="document.th.InternalIncomingMessage"/></li>
        <li class="receive" style="display: none"><fmt:message code="document.th.GroupReceipt"/></li>
        <li><fmt:message code="document.th.ReturnTheDocument"/></li>
        <span id="Confidential"></span>
    </ul>
    <div class="layui-tab-content">
        <!-- 内部收文 -->
        <div class="layui-tab-item layui-show">
            <div class="layui-form" >
                <div class="layui-row">
                    <div class="layui-col-xs5">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><fmt:message code="dem.th.FileTitle"/></label>
                            <div class="layui-input-block" style="width: 200px">
                                <input type="text" name="docTitle" id="fileTitle" required  lay-verify="required"  autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs5">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><fmt:message code="dem.th.FileSize"/></label>
                            <div class="layui-input-block" style="width: 200px">
                                <input type="text" name="numSelect" id="fileNum"  required  lay-verify="required"  autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs5">
                        <div class="layui-form-item">
                            <label class="layui-form-label"><fmt:message code="document.th.StatusOfReceipt"/></label>
                            <div class="layui-input-block" style="width: 200px">
                                <select name="receiveStatus" id="receiveState" lay-verify="required">
                                    <option value=""></option>
                                    <option value="0"><fmt:message code="sup.th.Substitute"/></option>
                                    <option value="1"><fmt:message code="document.th.ATao"/></option>
                                    <option value="4"><fmt:message code="document.th.ATao1"/></option>
                                    <option value="3"><fmt:message code="document.th.Returned"/></option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm" id="query" style="margin-top: 4px;"><fmt:message code="global.lang.query"/></button>
                    <button type="button" class="layui-btn layui-btn-sm" id="reset" style="margin-left: 10px;margin-top: 4px;"><fmt:message code="workflow.th.Reset"/></button>
                </div>
                <div><table id="internalTable" lay-filter="internalTable" class="layui-hide"></table></div>
            </div>
        </div>
        <!-- 集团收文 -->
        <div class="layui-tab-item">
            <div id="internalTableBox">
                <button type="button" class="layui-btn receive_btn"><fmt:message code="doc.th.In"/></button>
                <table id="internalTables" lay-filter="internalTables"></table>
            </div>
        </div>
        <!-- 退回发文 -->
        <div class="layui-tab-item">
            <table id="returnPost" lay-filter="returnPost"></table>
        </div>
    </div>
</div>

<script type="text/html" id="internalBar">
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">收文</a>--%>
    {{# if(d.receiveStatus ==0){ }}
    <a class="layui-btn layui-btn-xs" lay-event="editRe"><fmt:message code="sup.th.Sign"/></a>
    <a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="document.th.ATao3"/></a>
    <a class="layui-btn layui-btn-xs" lay-event="return"><fmt:message code="workflow.th.backbtn"/></a>
    {{# } else if(d.receiveStatus ==4){ }}
    <a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="document.th.InitiatingProcess"/></a>
    {{# } }}
</script>
<script type="text/html" id="internalBars">
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">收文</a>--%>
    {{# if(d.receiveStatus ==0){ }}
    <a class="layui-btn layui-btn-xs" lay-event="edits"><fmt:message code="doc.th.In"/></a>
    {{# } }}
</script>

<%--<script type="text/html" id="externalBar">--%>
<%--<a class="layui-btn layui-btn-xs" lay-event="edit">收文</a>--%>
<%--</script>--%>

<!-- 弹窗 -->
<div type="text/html" id="newModal" style="display: none;padding: 10px 40px 10px 0;">
    <form class="layui-form" lay-filter="newForm" id="addform">

        <div class="layui-form">
            <div style="display: flex;margin-top:15px">
                <div class="layui-form-item" style="width: 370px">
                    <label class="layui-form-label"><fmt:message code="document.th.IncomingTextTitle"/></label>
                    <div class="layui-input-block">
                        <input type="text" id="docTitle" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="width: 370px">
                <label class="layui-form-label"><fmt:message code="doc.th.TypeDocument"/></label>
                <div class="layui-input-block">
                    <select name="dispatchType" id="dispatchType" lay-verify="required" class="search" lay-filter="searchSelects">
                        <option value="" ><fmt:message code="document.th.SelectTypeDocument"/></option>
                    </select>
                </div>
            </div>
        </div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <p style="font-size: 15px;margin-left: 60px;margin-top: 15px"><fmt:message code="document.th.SelectInboundProcess"/>:</p>
            <div class="layui-form-item"  style="margin-left: -70px;margin-top: 15px" >
                <div class="layui-input-block input_radio tableDl"  >

                </div>
            </div>

        </fieldset>
        <%--<div>--%>
        <%--<p>选择收文流程</p>--%>
        <%--</div>--%>
        <%--<div class="layui-form-item"  style="margin-left: -70px" >--%>
        <%--<div class="layui-input-block input_radio tableDl"  >--%>

        <%--</div>--%>
        <%--</div>--%>
        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="attachmentName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="receiveId" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="attachmentId" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="attachmentId2" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="attachmentName2" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: none" >
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="fromRunId" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none">
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="documentType" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

    </form>
</div>
    
<script>
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
            }
        }
    })

    var pathReceiveId = GetQueryString('receiveId');

    // 取消事务提醒
    if (pathReceiveId && pathReceiveId != '') {
        $.post('/documentExchangeReceive/cancel', {receiveId: pathReceiveId}, function(res){
            if (res.flag) {

            }
        });
    }

    layui.use(['form','table', 'layer','element'], function(){
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var element = layui.element;
        form.render();
        /*切换tab页签*/
        element.on('tab(demo)', function(data){
            // console.log(data.index); //得到当前Tab的所在下标
            if(data.index==0){
                internalTable.reload({
                    url: '/documentExchangeReceive/query',
                    page: {
                        curr: 1
                    },
                    where: {
                        flag: 1,
                        useFlag: true,
                        time: new Date().getTime()
                    }
                });
            }else if(data.index==1){
                internalTableGroup.reload({
                    url: '/documentExchangeReceive/query',
                    page: {
                        curr: 1
                    },
                    where: {
                        flag: 2,
                        useFlag: true,
                        time: new Date().getTime()
                    }
                });
            }else if(data.index==2){
                returnPostTable.reload({
                    page: {
                        curr: 1
                    },
                    where: {
                        useFlag: true,
                        receiveStatus: 3,
                        time: new Date().getTime()
                    }
                });
            }
        });
        /********************************************内部收文******************************************/
        // 初始化-内部收文-表格
        var internalTable = table.render({
            elem: '#internalTable'
            ,autoSort: false
            ,url: '/documentExchangeReceive/query' //数据接口
            ,page: true //开启分页
            // ,toolbar: '<div><a class="layui-btn layui-btn-sm" lay-event="del">删除</a></div>'
            ,defaultToolbar: []
            ,cols: [[ //表头
                // {checkbox: true},
                {field: 'receiveId', align:'center', title:'<fmt:message code="url.th.safeLogNo"/>'},
                {field: 'docTitle',width: 100, align:'center',title:'<fmt:message code="dem.th.FileTitle"/>'},
                {field: 'receiveStatus',width: 150, align:'center',title:' <fmt:message code="document.th.StatusOfReceipt"/>',sort:true,templet:function (d) {
                        if(d.receiveStatus==0){
                            return  '<fmt:message code="sup.th.Substitute"/>'
                        }else if(d.receiveStatus==1){
                            return  '<fmt:message code="document.th.ATao"/>'
                        }else if(d.receiveStatus==2){
                            return  '<fmt:message code="document.th.TakenBack"/>'
                        }else if(d.receiveStatus==3){
                            return  '<fmt:message code="document.th.Returned"/>'
                        }else if(d.receiveStatus==4){
                            return  '<fmt:message code="document.th.ATao1"/>'
                        }else{
                            return   ''
                        }
                    }},
                    {field: 'printDept',width: 150, align:'center',title: '<fmt:message code="document.th.IssuingAndDistributingUnit"/>'},
                {field: 'fromUnit', width: 150,align:'center',title: '<fmt:message code="document.th.UnitOfCommunication"/>'},
                {field: 'receiveUnit', width: 150,align:'center',title: '<fmt:message code="doc.th.DispatchUnit2"/>'},
                {field: 'docNo',width: 150, align:'center',sort:true,title: '<fmt:message code="dem.th.FileSize"/>'},
                {field: 'attachment2', width: 150,align: 'center', title: '<fmt:message code="main.th.text"/>',
                    templet: function (d) {
                        var attachmentList = d.attachAndDoc;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        } else if (fileExtension == 'ceb') {
                                            return '';
                                        } else {
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                {field: 'attachment',width: 180, align: 'center', title: '<fmt:message code="notice.th.fileUpload"/>',
                    templet: function (d) {
                        var attachmentList = d.attachment;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }else{
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                    {field: 'fromTime',width: 180, align:'center',title: '<fmt:message code="sup.th.SendingTime"/>', sort:true},
                {field: 'receiveTime',width: 180, align:'center',title: '<fmt:message code="work.th.shouTime"/>', sort:true,templet:function(d){
                    if (d.receiveTime) {
                        return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                    } else {
                        return '';
                    }
                    }},
                {field: 'receiveUser',width: 150,align:'center', title: '<fmt:message code="document.th.PersonOfRegistration"/>'},
                {field: 'urgency',align:'center',width: 150, title: '<fmt:message code="document.th.Urgency"/>',templet:function(d){
                        if (d.urgency != undefined) {
                            if(d.urgency == 1){
                                return '';
                            }else if(d.urgency == 2){
                                return '<fmt:message code="document.th.GeneralEmergency"/>';
                            }else if(d.urgency == 3){
                                return '<fmt:message code="document.th.MoreUrgent"/>';
                            }else if(d.urgency == 4){
                                return '<fmt:message code="document.th.ItsUrgent"/>';
                            }else{
                                return d.urgency;
                            }
                        } else {
                            return '';
                        }
                    }},
                {field: 'receiveStatus', fixed: 'right',width: 230, title: '<fmt:message code="menuSSetting.th.menuSetting"/>',align:'center', toolbar: '#internalBar',templet:function(d){}}
            ]],
                where: {
                    useFlag: true,
                    flag: 1,
                    _:new Date().getTime()
                },
                request: {
                    limitName: 'pageSize'
                }
            ,response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'obj',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            },
            done: function(res) {
                if (res.object) {
                    $('.receive').show()
                }
                $('.divShow').parent().css('height','auto');
                $('.divShow').parent().css('overflow','visible');
                var $operationDiv = $('#internalTable').next().find('.layui-table-main tr').last().find('.operationDiv');

                $operationDiv.each(function(){
                    var length = $(this).children('a').length;
                    $(this).css('top', '-'+(length*20+2)+'px');
                });
            }
        });
        table.on('sort(internalTable)', function(obj){
            var flag;
            if(obj.type == 'desc'){
                flag = false;
            }else if(obj.type == 'asc'){
                flag = true;
            }
            if(obj.field == 'receiveStatus'){
                getTable("signSort",flag)
            }else if(obj.field == 'docNo'){
                getTable("fontSort",flag)
            }else if(obj.field == 'receiveTime'){
                getTable("timeSort",flag)
            }

        });
        function getTable(arg,flag) {
            table.render({
                elem: '#internalTable'
                ,autoSort: false
                ,url: '/documentExchangeReceive/query?useFlag=true&flag=1&'+arg+'='+flag+'&_='+ new Date().getTime()//数据接口
                ,page: true //开启分页
                ,defaultToolbar: []
                ,cols: [[ //表头
                    // {checkbox: true},
                    {field: 'receiveId', align:'center', title: '<fmt:message code="url.th.safeLogNo"/>'},
                    {field: 'docTitle', align:'center',title: '<fmt:message code="dem.th.FileTitle"/>'},
                    {field: 'receiveStatus', align:'center',title: '<fmt:message code="document.th.StatusOfReceipt"/>',sort:true,templet:function (d) {
                            if(d.receiveStatus==0){
                                return  '<fmt:message code="sup.th.Substitute"/>'
                            }else if(d.receiveStatus==1){
                                return  '<fmt:message code="document.th.ATao"/>'
                            }else if(d.receiveStatus==2){
                                return  '<fmt:message code="document.th.TakenBack"/>'
                            }else if(d.receiveStatus==3){
                                return  '<fmt:message code="document.th.Returned"/>'
                            }else if(d.receiveStatus==4){
                                return  '<fmt:message code="document.th.ATao1"/>'
                            }else{
                                return   ''
                            }
                        }},
                    {field: 'fromUnit', align:'center',title: '<fmt:message code="document.th.UnitOfCommunication"/>'},
                    {field: 'receiveUnit', align:'center',title: '<fmt:message code="doc.th.DispatchUnit2"/>'},
                    {field: 'docNo', align:'center',sort:true,title: '<fmt:message code="dem.th.FileSize"/>'},
                    {field: 'attachment2', align: 'center', title: '<fmt:message code="main.th.text"/>',
                        templet: function (d) {
                            var attachmentList = d.attachAndDoc;
                            var str = ''
                            if (attachmentList && attachmentList.length > 0) {
                                attachmentList.forEach(function(item){
                                    var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                    str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                        '<div class="operationDiv">'+function(){
                                            if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            } else if (fileExtension == 'ceb') {
                                                return '';
                                            } else {
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }
                                        }()+
                                        '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                        +'</div>' +
                                        '</div>'
                                });
                            }
                            return str;
                        }
                    },
                    {field: 'attachment', align: 'center', title: '附件',
                        templet: function (d) {
                            var attachmentList = d.attachment;
                            var str = ''
                            if (attachmentList && attachmentList.length > 0) {
                                attachmentList.forEach(function(item){
                                    var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                    str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                        '<div class="operationDiv">'+function(){
                                            if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }else{
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }
                                        }()+
                                        '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                        +'</div>' +
                                        '</div>'
                                });
                            }
                            return str;
                        }
                    },
                    {field: 'receiveTime', align:'center',title: '<fmt:message code="work.th.shouTime"/>', sort:true,templet:function(d){
                            if (d.receiveTime) {
                                return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                            } else {
                                return '';
                            }
                        }},
                    {field: 'receiveUser',align:'center', title: '<fmt:message code="document.th.PersonOfRegistration"/>'},
                    {field: 'urgency',align:'center', title: '<fmt:message code="document.th.Urgency"/>',templet:function(d){
                            if (d.urgency != undefined) {
                                return d.urgency;
                            } else {
                                return '';
                            }
                        }},
                    {field: 'receiveStatus',width: 250, title: '<fmt:message code="menuSSetting.th.menuSetting"/>',align:'center', toolbar: '#internalBar',templet:function(d){}}
                ]],
                request: {
                    limitName: 'pageSize'
                }
                ,response: {
                    statusName: 'flag',  //规定数据状态的字段名称，默认：code
                    statusCode: true,   //规定成功的状态码，默认：0
                    dataName: 'obj',    //规定数据列表的字段名称，默认：data
                    countName: 'totleNum'
                },
                done: function(res) {
                    if (res.object) {
                        $('.receive').show()
                    }
                    $('.divShow').parent().css('height','auto');
                    $('.divShow').parent().css('overflow','visible');
                    var $operationDiv = $('#internalTable').next().find('.layui-table-main tr').last().find('.operationDiv');

                    $operationDiv.each(function(){
                        var length = $(this).children('a').length;
                        $(this).css('top', '-'+(length*20+2)+'px');
                    });
                }
            });
        }
            //监听-内部收文-表格-工具条
        table.on('tool(internalTable)', function(obj){
            var data = obj.data;
            var layEvent = obj.event;

            if(layEvent === 'edit'){
                var isShou=isBack(data.receiveId)
                if(isShou){
                    layer.msg('该条文已被收回！');
                    internalTable.reload({
                        url: '/documentExchangeReceive/query',
                        page: {
                            curr: 1
                        },
                        where: {
                            flag: 1,
                            useFlag: true,
                            time: new Date().getTime()
                        }
                    })
                    return false
                }
                $("#docTitle").val(data.docTitle);
                $("#attachmentName").val(data.attachmentName);
                $("#receiveId").val(data.receiveId);
                $("#attachmentId").val(data.attachmentId);
                $("#fromRunId").val(data. fromRunId);
                $("#dispatchType").val(data. dispatchType);
                $("#attachmentId2").val(data.attachmentId2);
                $("#attachmentName2").val(data.attachmentName2);
    
                $.get('/document/sortFlow?mainType=DOCUMENTTYPE&detailType=RECEIVE', function (res) {
                    var str = ''
                    if (res.flag && res.datas.length > 0) {
                        res.datas.forEach(function (data) {
                            if (data.flows.length > 0) {
                                data.flows.forEach(function(flow){
                                    str += '<input class="tableDl " id="flowId"   type="radio" name="flowId" value="' + flow.flowId + '" title="' + flow.flowName + '"><br/>'
                                });
                            }
                        });
                    }
                    $('.input_radio').html(str);
                    form.render();
                });

                layer.open({
                    type: 1,
                    title: '来文接收',
                    content: $('#newModal'),
                    area: ['550px', '450px'],
                    btn: ['确认', '取消'],
                    yes: function(){
                        var attachmentName = document.getElementById("attachmentName").value
                        var receiveId = document.getElementById("receiveId").value
                        var attachmentId = document.getElementById("attachmentId").value
                        var fromRunId = document.getElementById("fromRunId").value
                        var title = document.getElementById("docTitle").value
                        var frunName = document.getElementById("docTitle").value
                        var flowId = $('input:radio:checked').val()
                        var fflowId =$('input:radio:checked').val()
                        var dispatchType = document.getElementById("dispatchType").value
                        
                        if (!flowId) {
                            layer.msg('<fmt:message code="document.th.SelectReceivingProcess"/>');
                            return false;
                        }
                                $.ajax({
                                    type: 'post',
                                    url: '/documentExchangeReceive/receiveDoc',
                                    dataType: 'json',
                                    data: {
                                        attachmentName: attachmentName,
                                        receiveId: receiveId,
                                        attachmentId:attachmentId,
                                        fromRunId: fromRunId,
                                        frunId:'',
                                        fprcsId:1,
                                        fflowStep:1,
                                        documentType:1,
                                        title:title,
                                        frunName:frunName,
                                        flowId:flowId,
                                        fflowId: fflowId,
                                        dispatchType:dispatchType,
                                    },
                                    async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                                    success:function(json){
                                        if(json.flag){
                                            resetForm(form)
                                            layer.closeAll();
                                            internalTable.reload({
                                                url: '/documentExchangeReceive/query',
                                                page: {
                                                    curr: 1
                                                },
                                                where: {
                                                    flag: 1,
                                                    useFlag: true,
                                                    time: new Date().getTime()
                                                }
                                            });
                                            $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                            // $.layerMsg({},function () {
                                            // });
                                            // $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                        } else {
                                            layer.msg('<fmt:message code="document.th.ReceivingFailure"/>', {icon: 2});
                                        }
                                    }
                                })
                    },
                    btn2: function(){
                        resetForm(form)
                        layer.close();
                    },
                    cancel: function(){
                        resetForm(form)
                        layer.close();
                    }
                })
            }else if(layEvent==='return'){
                layer.open({
                    type: 1,
                    title: '<fmt:message code="workflow.th.backbtn"/>',
                    content:'<div class="layui-form" >' +
                                ' <div class="layui-form-item layui-form-text" style="width:90%;margin-top: 15px">\n' +
                                '    <label class="layui-form-label" style="width: 80px !important;"><fmt:message code="document.th.ReturnAdvice"/></label>\n' +
                                '    <div class="layui-input-block"  style="margin-left: 112px !important;">\n' +
                                '      <textarea name="returnComments"  class="layui-textarea"></textarea>\n' +
                                '    </div>\n' +
                                '  </div>'+
                            '</div>',
                    area: ['500px', '250px'],
                    btn: ['<fmt:message code="menuSSetting.th.menusetsure"/>', '<fmt:message code="depatement.th.quxiao"/>'],
                    yes: function(index){
                        $.ajax({
                            type: 'post',
                            url: '/documentExchangeReceive/returnComments',
                            dataType: 'json',
                            data: {
                                docTitle:data.docTitle,
                                receiveStatus:3,
                                receiveId:data.receiveId,
                                returnComments:$('[name="returnComments"]').val()
                            },
                            success:function(res){
                                if(res.flag){
                                    layer.msg('<fmt:message code="document.th.SuccessfulReturn"/>！', {icon: 1, time: 1000});
                                }else{
                                    layer.msg('<fmt:message code="document.th.ReturnFailure"/>！', {icon: 0, time: 1000});
                                }
                                layer.close(index)
                                internalTable.reload({
                                    url: '/documentExchangeReceive/query',
                                    page: {
                                        curr: 1
                                    },
                                    where: {
                                        flag: 1,
                                        useFlag: true,
                                        time: new Date().getTime()
                                    }
                                });
                            }
                        })
                    }
                })
            }else if(layEvent === 'editRe'){
                var isShou=isBack(data.receiveId)
                if(isShou){
                    layer.msg('<fmt:message code="document.th.WithdrawnProvision"/>！');
                    internalTable.reload({
                        url: '/documentExchangeReceive/query',
                        page: {
                            curr: 1
                        },
                        where: {
                            flag: 1,
                            useFlag: true,
                            time: new Date().getTime()
                        }
                    })
                    return false
                }
                var delIndex = layer.confirm('<fmt:message code="document.th.ConfirmationReceipt"/>', {
                    btn: ['<fmt:message code="menuSSetting.th.menusetsure"/>', '<fmt:message code="depatement.th.quxiao"/>'] //按钮
                }, function () {
                    $.post('/documentExchangeReceive/updateStatus', {receiveId:data.receiveId,receiveStatus:4}, function (res) {
                        if (res.flag) {
                            internalTable.reload({
                                url: '/documentExchangeReceive/query',
                                where: {
                                    useFlag: true,
                                    flag: 1,
                                    date: new Date().getTime()
                                },
                                page: {
                                    curr: 1
                                }
                            })
                            layer.msg('<fmt:message code="document.th.SignInSuccessful"/>', {icon: 1})
                        } else {
                            layer.msg('<fmt:message code="document.th.SignInFailure"/>', {icon: 2})
                        }
                        layer.close(delIndex)
                    })
                });
            }

        });

        //选择公文文种
        $.get('/code/GetDropDownBox?CodeNos=GWTYPE', function(res){
            var arrTwo=res.GWTYPE;
            var str= '    <option value=""><fmt:message code="file.th.download"/></option>\n';
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeOrder+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
            form.render()
        });
    
        table.on('toolbar(internalTable)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'del':
                    if (checkStatus.data.length === 0) {
                        layer.msg('<fmt:message code="document.th.SelectDeleteData"/>！', {icon: 2});
                    } else {
                        var delIndex = layer.confirm('<fmt:message code="document.th.ConfirmMessage"/>？', {
                            btn: ['<fmt:message code="menuSSetting.th.menusetsure"/>', '<fmt:message code="depatement.th.quxiao"/>'] //按钮
                        }, function () {
                            var receiveIds = ''
                            checkStatus.data.forEach(function (item) {
                                receiveIds += item.receiveId + ','
                            })
                            $.post('/documentExchangeReceive/delete', {receiveIds: receiveIds}, function (res) {
                                if (res.flag) {
                                    layer.msg('<fmt:message code="document.th.Deleted"/>' + checkStatus.data.length + '<fmt:message code="document.th.PieceOfData"/>！', {icon: 1})
                                    internalTable.reload({
                                        url: '/documentExchangeReceive/query',
                                        where: {
                                            useFlag: true,
                                            flag: 1,
                                            date: new Date().getTime()
                                        },
                                        page: {
                                            curr: 1
                                        }
                                    })
                                } else {
                                    layer.msg('<fmt:message code="lang.th.deleSucess"/>', {icon: 2})
                                }
                            })
                        }, function () {
                            layer.close(delIndex)
                        });
                    }
                    break;
            }
        });

        /*查询*/
        $(document).on('click','#query',function () {
            internalTable.reload({
                url: '/documentExchangeReceive/query',
                page: {
                    curr: 1
                },
                where: {
                    flag: 1,
                    useFlag: true,
                    time: new Date().getTime(),
                    docTitle:$('[name="docTitle"]').val(),
                    receiveStatus:$('[name="receiveStatus"]').val(),
                    docNo:$('[name="numSelect"]').val(),
                }
            });
        })
        //重置
        $(document).on('click','#reset',function () {
            $('#fileNum').val(""),
            $('#receiveState').val(" "),
            form.render()
            $('#fileTitle').val(""),
            table.render({
                elem: '#internalTable'
                ,autoSort: false
                ,url: '/documentExchangeReceive/query' //数据接口
                ,page: true //开启分页
                // ,toolbar: '<div><a class="layui-btn layui-btn-sm" lay-event="del">删除</a></div>'
                ,defaultToolbar: []
                ,cols: [[ //表头
                    // {checkbox: true},
                    {field: 'receiveId', align:'center', title: '<fmt:message code="url.th.safeLogNo"/>'},
                    {field: 'docTitle', align:'center',title: '<fmt:message code="dem.th.FileTitle"/>'},
                    {field: 'receiveStatus', align:'center',title: '<fmt:message code="document.th.StatusOfReceipt"/>',sort:true,templet:function (d) {
                            if(d.receiveStatus==0){
                                return  '<fmt:message code="sup.th.Substitute"/>'
                            }else if(d.receiveStatus==1){
                                return  '<fmt:message code="document.th.ATao"/>'
                            }else if(d.receiveStatus==2){
                                return  '<fmt:message code="document.th.TakenBack"/>'
                            }else if(d.receiveStatus==3){
                                return  '<fmt:message code="document.th.Returned"/>'
                            }else if(d.receiveStatus==4){
                                return  '<fmt:message code="document.th.ATao1"/>'
                            }else{
                                return   ''
                            }
                        }},
                    {field: 'fromUnit', align:'center',title: '<fmt:message code="document.th.UnitOfCommunication"/>'},
                    {field: 'receiveUnit', align:'center',title: '<fmt:message code="doc.th.DispatchUnit2"/>'},
                    {field: 'docNo', align:'center',sort:true,title: '<fmt:message code="dem.th.FileSize"/>'},
                    {field: 'attachment2', align: 'center', title: '<fmt:message code="main.th.text"/>',
                        templet: function (d) {
                            var attachmentList = d.attachAndDoc;
                            var str = ''
                            if (attachmentList && attachmentList.length > 0) {
                                attachmentList.forEach(function(item){
                                    var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                    str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                        '<div class="operationDiv">'+function(){
                                            if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            } else if (fileExtension == 'ceb') {
                                                return '';
                                            } else {
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }
                                        }()+
                                        '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                        +'</div>' +
                                        '</div>'
                                });
                            }
                            return str;
                        }
                    },
                    {field: 'attachment', align: 'center', title: '附件',
                        templet: function (d) {
                            var attachmentList = d.attachment;
                            var str = ''
                            if (attachmentList && attachmentList.length > 0) {
                                attachmentList.forEach(function(item){
                                    var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                    var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                    str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                        '<div class="operationDiv">'+function(){
                                            if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }else{
                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                            }
                                        }()+
                                        '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                        +'</div>' +
                                        '</div>'
                                });
                            }
                            return str;
                        }
                    },
                    {field: 'receiveTime', align:'center',title: '<fmt:message code="work.th.shouTime"/>', sort:true,templet:function(d){
                            if (d.receiveTime) {
                                return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                            } else {
                                return '';
                            }
                        }},
                    {field: 'receiveUser',align:'center', title: '<fmt:message code="document.th.PersonOfRegistration"/>'},
                    {field: 'urgency',align:'center', title: '<fmt:message code="document.th.Urgency"/>',templet:function(d){
                            if (d.urgency != undefined) {
                                return d.urgency;
                            } else {
                                return '';
                            }
                        }},
                    {field: 'receiveStatus',width: 250, title: '<fmt:message code="menuSSetting.th.menuSetting"/>',align:'center', toolbar: '#internalBar',templet:function(d){}}
                ]],
                where: {
                    useFlag: true,
                    flag: 1,
                    _:new Date().getTime()
                },
                request: {
                    limitName: 'pageSize'
                }
                ,response: {
                    statusName: 'flag',  //规定数据状态的字段名称，默认：code
                    statusCode: true,   //规定成功的状态码，默认：0
                    dataName: 'obj',    //规定数据列表的字段名称，默认：data
                    countName: 'totleNum'
                },
                done: function(res) {
                    if (res.object) {
                        $('.receive').show()
                    }
                    $('.divShow').parent().css('height','auto');
                    $('.divShow').parent().css('overflow','visible');
                    var $operationDiv = $('#internalTable').next().find('.layui-table-main tr').last().find('.operationDiv');

                    $operationDiv.each(function(){
                        var length = $(this).children('a').length;
                        $(this).css('top', '-'+(length*20+2)+'px');
                    });
                }
            });
        })

        /********************************************集团收文******************************************/
        var internalTableGroup = table.render({
            elem: '#internalTables'
            ,url: '/documentExchangeReceive/query' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'receiveId', align:'center', title: '<fmt:message code="url.th.safeLogNo"/>'},
                {field: 'docTitle', align:'center',title: '<fmt:message code="dem.th.FileTitle"/>'},
                {field: 'fromUnit', align:'center',title: '<fmt:message code="document.th.UnitOfCommunication"/>'},
                {field: 'receiveUnit', align:'center',title: '<fmt:message code="doc.th.DispatchUnit2"/>'},
                {field: 'docNo', align:'center',title: '<fmt:message code="dem.th.FileSize"/>'},
                {field: 'attachment2', align: 'center', title: '<fmt:message code="main.th.text"/>',
                    templet: function (d) {
                        var attachmentList = d.attachment2;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        } else if (fileExtension == 'ceb') {
                                            return '';
                                        } else {
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                {field: 'attachment', align: 'center', title: '<fmt:message code="notice.th.fileUpload"/>',
                    templet: function (d) {
                        var attachmentList = d.attachment;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }else{
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt=""><fmt:message code="document.th.ReferTo"/></a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt=""><fmt:message code="file.th.download"/></a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                {field: 'receiveTime', align:'center',title: '<fmt:message code="work.th.shouTime"/>',templet:function(d){
                        if (d.receiveTime) {
                            return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                        } else {
                            return '';
                        }
                    }},
                {field: 'receiveUser',align:'center', title: '<fmt:message code="document.th.PersonOfRegistration"/>'},
                {field: 'receiveStatus',title: '<fmt:message code="menuSSetting.th.menuSetting"/>',align:'center', toolbar: '#internalBars',templet:function(d){}}
            ]],
            done: function(){
                $('.divShow').parent().css('height','auto');
                $('.divShow').parent().css('overflow','visible');
                var $operationDiv = $('#internalTableBox .layui-table-main tr').last().find('.operationDiv');

                $operationDiv.each(function(){
                    var length = $(this).children('a').length;
                    $(this).css('top', '-'+(length*20+2)+'px');
                });
            },
            where: {
                useFlag: true,
                flag: 2,
                _:new Date().getTime()
            },
            request: {
                limitName: 'pageSize'
            }
            ,response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'obj',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });

        //监听-集团收文-表格-工具条
        table.on('tool(internalTables)', function(obj){
            var data = obj.data;
            var layEvent = obj.event;

            if(layEvent === 'edits'){
                $("#docTitle").val(data.docTitle);
                $("#attachmentName").val(data.attachmentName);
                $("#receiveId").val(data.receiveId);
                $("#attachmentId").val(data.attachmentId);
                $("#fromRunId").val(data. fromRunId);
                $("#dispatchType").val(data. dispatchType);
                $("#attachmentId2").val(data.attachmentId2);
                $("#attachmentName2").val(data.attachmentName2);

                $.get('/document/sortFlow?mainType=DOCUMENTTYPE&detailType=RECEIVE',function(res){
                    var data=res.datas[0].flows
                    if (res.flag) {
                        if (res.datas[0].flows.length > 0) {
                            var str=''
                            for(var i=0;i<data.length;i++){
                                str+= '<input class="tableDl " id="flowId"   type="radio" name="flowId" value="'+data[i].flowId+'" title="'+data[i].flowName+'"><br/>'
                                // '<input id="dispatchType"   type="text" style="display: none" value="'+data[i].dispatchType+'" ><br/>'+
                                // '<input id="documentType"   type="text" style="display: none" value="'+data[i].documentType+'" ><br/>'
                            }
                            $('.input_radio').html(str);
                            form.render()

                        }
                    }

                });

                layer.open({
                    type: 1,
                    title: '<fmt:message code="document.th.CommunicationReception"/>',
                    content: $('#newModal'),
                    area: ['550px', '450px'],
                    btn: ['<fmt:message code="main.th.confirm"/>', '<fmt:message code="depatement.th.quxiao"/>']
                    , yes: function(){
                        var attachmentName = document.getElementById("attachmentName").value
                        var receiveId = document.getElementById("receiveId").value
                        var attachmentId = document.getElementById("attachmentId").value
                        // var fromRunId = document.getElementById("fromRunId").value
                        var title = document.getElementById("docTitle").value
                        var frunName = document.getElementById("docTitle").value
                        var flowId = $('input:radio:checked').val()
                        var fflowId =$('input:radio:checked').val()
                        var dispatchType = document.getElementById("dispatchType").value
                        var attachmentId2 = document.getElementById("attachmentId2").value || ''
                        var attachmentName2 = document.getElementById("attachmentName2").value || ''
                        var mainFile ='';
                        var mainFileName='';
                        var mainAipFile='';
                        var mainAipFileName='';

                        if (!flowId) {
                            layer.msg('<fmt:message code="document.th.SelectReceivingProcess"/>');
                            return false;
                        }

                        if (data.attachment2 && data.attachment2.length > 0) {
                            data.attachment2.forEach(function (file) {
                                var type = file.attachName.split(/\.(?![^\.]*\.)/)[1].toUpperCase();
                                if (type == "DOCX" || type == "DOC") {
                                    mainFile += file.id;
                                    mainFileName += file.name;
                                } else if (type == "PDF") {
                                    mainAipFile += file.id;
                                    mainAipFileName += file.name;
                                }
                            })
                        }

                        mainFile = mainFile.replace(/\,$/g, '');
                        mainFileName = mainFileName.replace(/\*$/g, '');
                        mainAipFile = mainAipFile.replace(/\,$/g, '');
                        mainAipFileName = mainAipFileName.replace(/\*$/g, '');

                        $.ajax({
                            type: 'post',
                            url: '/documentExchangeReceive/receives',
                            dataType: 'json',
                            data: {
                                attachmentName: attachmentName,
                                receiveId: receiveId,
                                attachmentId:attachmentId,
                                fromRunId: '',//集团收文不需要，传空
                                frunId:'',
                                fprcsId:1,
                                fflowStep:1,
                                documentType:1,
                                title:title,
                                frunName:frunName,
                                flowId:flowId,
                                fflowId: fflowId,
                                dispatchType:dispatchType,
                                mainFile:mainFile,
                                mainFileName:mainFileName,
                                mainAipFile:mainAipFile,
                                mainAipFileName:mainAipFileName,
                                //.docx的就存main_file,main_file_name     剩余的存到main_aip_file，main_aip_file_name

                            },
                            async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                            success:function(json){
                                if(json.flag){
                                    resetForm(form)
                                    layer.closeAll();
                                    internalTableGroup.reload({
                                        url: '/documentExchangeReceive/query',
                                        page: {
                                            curr: 1
                                        },
                                        where: {
                                            flag: 2,
                                            useFlag: true,
                                            time: new Date().getTime()
                                        }
                                    });
                                    $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                    // $.layerMsg({},function () {
                                    // });
                                    // $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                } else {
                                    layer.msg('收文失败', {icon: 2});
                                }
                            }
                        })
                    },
                    btn2: function(){
                        resetForm(form)
                        layer.close();
                    },
                    cancel: function(){
                        resetForm(form)
                        layer.close();
                    }
                })
            }
        });

        //选择公文文种
        $.get('/code/GetDropDownBox?CodeNos=GWTYPE', function(res){
            var arrTwo=res.GWTYPE;
            var str= '    <option value=""><fmt:message code="document.th.TypeOfficialDocument"/>)</option>\n';
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeOrder+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
            form.render()
        });

        // 集团收文-附件查阅
        $(document).on('click','.yulan',function () {
            var url=$(this).attr('data-url');
            pdurl($.UrlGetRequest('?'+url),url);
        });

        $('.receive_btn').on('click', function(){
            var loadIndex = layer.load();
            $.post('/documentExchangeReceive/Receive', function(res){
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg(res.msg);
                    internalTableGroup.reload({
                        url: '/documentExchangeReceive/query',
                        page: {
                            curr: 1
                        },
                        where: {
                            flag: 2,
                            useFlag: true,
                            time: new Date().getTime()
                        }
                    });
                }
            })
        });

        /********************************************退回发文******************************************/
        var returnPostTable = table.render({
            elem: '#returnPost'
            ,url: '/documentExchangeReceive/queryByReturn' //数据接口
            ,page: true //开启分页
            // ,toolbar: '<div><a class="layui-btn layui-btn-sm" lay-event="del">删除</a></div>'
            ,defaultToolbar: []
            ,cols: [[ //表头
                {field: 'receiveId', align:'center', title: '<fmt:message code="file.th.download"/>'},
                {field: 'docTitle', align:'center',title: '<fmt:message code="dem.th.FileTitle"/>'},
                {field: 'printDept', align:'center',title: '<fmt:message code="document.th.IssuingAndDistributingUnit"/>'},
                {field: 'fromUnit', align:'center',title: '<fmt:message code="document.th.UnitOfCommunication"/>'},
                {field: 'receiveUnit', align:'center',title: '<fmt:message code="doc.th.DispatchUnit2"/>'},
                {field: 'docNo', align:'center',title: '<fmt:message code="dem.th.FileSize"/>'},
                {field: 'fromTime', align:'center',title: '<fmt:message code="sup.th.SendingTime"/>'},
                {field: 'receiveTime', align:'center',title: '<fmt:message code="work.th.shouTime"/>', templet:function(d){
                        if (d.receiveTime) {
                            return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                        } else {
                            return '';
                        }
                    }},
                {field: 'receiveUser',align:'center', title: '<fmt:message code="document.th.PersonOfRegistration"/>'},
                {field: 'returnComments',align:'center', title: '<fmt:message code="document.th.ReturnAdvice"/>'},
            ]],
            where: {
                useFlag: true,
                receiveStatus: 3,
                _:new Date().getTime()
            }
            ,response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'obj',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            },
        });
    });

    //集团收文
    /*layui.use(['form','table', 'layer'], function() {
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        form.render();
        var internalTable = table.render({
            elem: '#internalTables'
            ,url: '/documentExchangeReceive/query' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'receiveId', align:'center', title: '序号'},
                {field: 'docTitle', align:'center',title: '文件标题'},
                {field: 'fromUnit', align:'center',title: '来文单位'},
                {field: 'receiveUnit', align:'center',title: '收文单位'},
                {field: 'docNo', align:'center',title: '文件字号'},
                {field: 'attachment2', align: 'center', title: '正文',
                    templet: function (d) {
                        var attachmentList = d.attachment2;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                        } else if (fileExtension == 'ceb') {
                                            return '';
                                        } else {
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                {field: 'attachment', align: 'center', title: '附件',
                    templet: function (d) {
                        var attachmentList = d.attachment;
                        var str = ''
                        if (attachmentList && attachmentList.length > 0) {
                            attachmentList.forEach(function(item){
                                var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

                                str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
                                    '<div class="operationDiv">'+function(){
                                        if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                        }else{
                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                        }
                                    }()+
                                    '<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                    +'</div>' +
                                    '</div>'
                            });
                        }
                        return str;
                    }
                },
                {field: 'receiveTime', align:'center',title: '接收时间',templet:function(d){
                    if (d.receiveTime) {
                        return new Date(d.receiveTime).Format('yyyy-MM-dd hh:mm:ss');
                    } else {
                        return '';
                    }
                    }},
                {field: 'receiveUser',align:'center', title: '登记人'},
                {field: 'receiveStatus',title: '操作',align:'center', toolbar: '#internalBars',templet:function(d){}}
            ]],
            done: function(){
                $('.divShow').parent().css('height','auto');
                $('.divShow').parent().css('overflow','visible');
                var $operationDiv = $('#internalTableBox .layui-table-main tr').last().find('.operationDiv');
                
                $operationDiv.each(function(){
                   var length = $(this).children('a').length;
                   $(this).css('top', '-'+(length*20+2)+'px');
                });
            },
                where: {
                    useFlag: true,
                    flag: 2
                },
                request: {
                    limitName: 'pageSize'
                }
            ,response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'obj',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });

        //监听-集团收文-表格-工具条
        table.on('tool(internalTables)', function(obj){
            var data = obj.data;
            var layEvent = obj.event;

            if(layEvent === 'edits'){
                $("#docTitle").val(data.docTitle);
                $("#attachmentName").val(data.attachmentName);
                $("#receiveId").val(data.receiveId);
                $("#attachmentId").val(data.attachmentId);
                $("#fromRunId").val(data. fromRunId);
                $("#dispatchType").val(data. dispatchType);
                $("#attachmentId2").val(data.attachmentId2);
                $("#attachmentName2").val(data.attachmentName2);

                $.get('/document/sortFlow?mainType=DOCUMENTTYPE&detailType=RECEIVE',function(res){
                    var data=res.datas[0].flows
                    if (res.flag) {
                        if (res.datas[0].flows.length > 0) {
                            var str=''
                            for(var i=0;i<data.length;i++){
                                str+= '<input class="tableDl " id="flowId"   type="radio" name="flowId" value="'+data[i].flowId+'" title="'+data[i].flowName+'"><br/>'
                                // '<input id="dispatchType"   type="text" style="display: none" value="'+data[i].dispatchType+'" ><br/>'+
                                // '<input id="documentType"   type="text" style="display: none" value="'+data[i].documentType+'" ><br/>'
                            }
                            $('.input_radio').html(str);
                            form.render()

                        }
                    }

                });

                layer.open({
                    type: 1,
                    title: '来文接收',
                    content: $('#newModal'),
                    area: ['550px', '450px'],
                    btn: ['确认', '取消']
                    , yes: function(){
                        var attachmentName = document.getElementById("attachmentName").value
                        var receiveId = document.getElementById("receiveId").value
                        var attachmentId = document.getElementById("attachmentId").value
                        // var fromRunId = document.getElementById("fromRunId").value
                        var title = document.getElementById("docTitle").value
                        var frunName = document.getElementById("docTitle").value
                        var flowId = $('input:radio:checked').val()
                        var fflowId =$('input:radio:checked').val()
                        var dispatchType = document.getElementById("dispatchType").value
                        var attachmentId2 = document.getElementById("attachmentId2").value || ''
                        var attachmentName2 = document.getElementById("attachmentName2").value || ''
                        var mainFile ='';
                        var mainFileName='';
                        var mainAipFile='';
                        var mainAipFileName='';
                        
                        if (!flowId) {
                            layer.msg('请选择收文流程');
                            return false;
                        }
                        
                        if (data.attachment2 && data.attachment2.length > 0) {
                            data.attachment2.forEach(function (file) {
                                var type = file.attachName.split(/\.(?![^\.]*\.)/)[1].toUpperCase();
                                if (type == "DOCX" || type == "DOC") {
                                    mainFile += file.id;
                                    mainFileName += file.name;
                                } else if (type == "PDF") {
                                    mainAipFile += file.id;
                                    mainAipFileName += file.name;
                                }
                            })
                        }

                        mainFile = mainFile.replace(/\,$/g, '');
                        mainFileName = mainFileName.replace(/\*$/g, '');
                        mainAipFile = mainAipFile.replace(/\,$/g, '');
                        mainAipFileName = mainAipFileName.replace(/\*$/g, '');

                        $.ajax({
                            type: 'post',
                            url: '/documentExchangeReceive/receives',
                            dataType: 'json',
                            data: {
                                attachmentName: attachmentName,
                                receiveId: receiveId,
                                attachmentId:attachmentId,
                                fromRunId: '',//集团收文不需要，传空
                                frunId:'',
                                fprcsId:1,
                                fflowStep:1,
                                documentType:1,
                                title:title,
                                frunName:frunName,
                                flowId:flowId,
                                fflowId: fflowId,
                                dispatchType:dispatchType,
                                mainFile:mainFile,
                                mainFileName:mainFileName,
                                mainAipFile:mainAipFile,
                                mainAipFileName:mainAipFileName,
                                //.docx的就存main_file,main_file_name     剩余的存到main_aip_file，main_aip_file_name

                            },
                            async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                            success:function(json){
                                if(json.flag){
                                    resetForm(form)
                                    layer.closeAll();
                                    internalTable.reload({
                                        url: '/documentExchangeReceive/query',
                                        page: {
                                            curr: 1
                                        },
                                        where: {
                                            flag: 1,
                                            useFlag: true,
                                            time: new Date().getTime()
                                        }
                                    });
                                    $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                    // $.layerMsg({},function () {
                                    // });
                                    // $.popWindow('/workflow/work/workform?&flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                                } else {
                                    layer.msg('收文失败', {icon: 2});
                                }
                            }
                        })
                    },
                    btn2: function(){
                        resetForm(form)
                        layer.close();
                    },
                    cancel: function(){
                        resetForm(form)
                        layer.close();
                    }
                })
            }
        });

        //选择公文文种
        $.get('/code/GetDropDownBox?CodeNos=GWTYPE', function(res){
            var arrTwo=res.GWTYPE;
            var str= '    <option value="">请填写公文文种(可不填写)</option>\n';
            for(var i=0;i<arrTwo.length;i++){
                str+='<option value="'+arrTwo[i].codeOrder+'">'+arrTwo[i].codeName+'</option>'
            }
            $('[name="dispatchType"]').html(str)
            form.render()
        });

        // 集团收文-附件查阅
        $(document).on('click','.yulan',function () {
            var url=$(this).attr('data-url');
            pdurl($.UrlGetRequest('?'+url),url);
        });

        $('.receive_btn').on('click', function(){
            $.post('/documentExchangeReceive/Receive', function(res){
                if (res.flag) {
                    layer.msg(res.msg);
                    internalTable.reload({
                        url: '/documentExchangeReceive/query',
                        page: {
                            curr: 1
                        },
                        where: {
                            flag: 1,
                            useFlag: true,
                            time: new Date().getTime()
                        }
                    });
                }
            })
        });

    });*/

    function resetForm(form) {
        $('#newModal').hide();
        $('.exchange_user').empty();
        form.val("newForm", {
            "fromUnit": '',
            'receiveUnit': '',
            'exchangeDeptId': '-1',
            'exchangeUserId': '',
            'documentPriv': ''
        });
    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        re = new RegExp("amp;", "g"); //定义正则表达式
        var r = window.location.search.substr(1).replace(re, "").match(reg);  //获取url中"?"符后的字符串并正则匹配
        var context = "";
        if (r != null)
            context = r[2];
        reg = null;
        r = null;
        return context == null || context == "" || context == "undefined" ? "" : context;
    }

    //判断文是否被收回
    function isBack(receiveId) {
        var back
        $.ajax({
            type: 'get',
            url: '/documentExchangeReceive/queryById',
            dataType: 'json',
            data: {
                receiveId: receiveId,
            },
            async: false,
            success:function(res){
                if(res.flag &&res.object.receiveStatus==2){
                    back=true
                }
            }
        })
        return back
    }

</script>
</body>
</html>