<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>外部公文</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="/js/document/makeADraft.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table{
            table-layout: fixed;
        }
    </style>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daibanfawen.png" alt="">
    </div>
    <div class="divTitle">
        接收公文
    </div>


</div>


<div id="pagediv" style="    margin-top: 66px;">

</div>


<script>

    function judge(that) {
        if($(that).val()!=''){
            $(that).attr('data-type',2)
        }else {
            $(that).attr('data-type',1)
        }
    }

    var pageObj=$.tablePage('#pagediv','1260px',[
        {
            width:'180px',
            title:'流程名称',
            name:'processDefinitionName',
            selectFun:function (processDefinitionName,obj) {
                var str = '<span class="businessKey" style="display: none" attr_id="'+ obj.id +'">' + obj.businessKey + '</span>';
                if(processDefinitionName!=undefined){
                    return processDefinitionName+str;
                }else {
                    return str;
                }
            }
        },
        {
            width:'360px',
            title:'主题',
            name:'processInstanceName',
            selectFun:function (processInstanceName) {
                if(processInstanceName!=undefined){
                    return processInstanceName
                }else {
                    return ""
                }
            }
        },
        {
            width:'120px',
            title:'当前节点',
            name:'name',
            selectFun:function (name) {
                if(name!=undefined){
                    return name
                }else {
                    return ""
                }
            }
        },{
            width:'180px',
            title:'到达时间',
            name:'friendlyCreateTime',
            selectFun:function (friendlyCreateTime) {
                if(friendlyCreateTime!=undefined){
                    return friendlyCreateTime
                }else {
                    return ""
                }
            }
        },{
            width:'120px',
            title:'负责人',
            name:'assigneeName',
            selectFun:function (assigneeName) {
                if(assigneeName!=undefined){
                    return assigneeName
                }else {
                    return ""
                }
            }
        },

        {
            width:'120px',
            title:'流程发起人',
            name:'startUserName',
            selectFun:function (startUserName) {
                if(startUserName!=undefined){
                    return startUserName
                }else {
                    return ""
                }
            }
        },
        {
            width:'180px',
            title:'操作',
            name:'startUserName',
            selectFun:function (startUserName) {
                if(startUserName!=undefined){
                    return startUserName
                }else {
                    return ""
                }
            }
        }
    ],function (me) {
//        me.data.printDate=$('[name="printDate"]').val();
//        me.data.dispatchType=$('[name="dispatchType"]').val()
//        me.data.title=$('[name="title"]').val()
//        me.data.docStatus=$('[name="status"]').val()
//        me.data.documentType=0;
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init('/outDocument/getHttpDocuments',[{name:'接收',fn:function (obj) {
                return 1
        }},{
            name:'接收并转发',
            fn:function (obj) {
                return 1
            }
        }])
    })




//    $('.Query').click(function () {
//        pageObj.data.page=1;
//        pageObj.data.printDate=$('[name="printDate"]').val();
//        pageObj.data.dispatchType=$('[name="dispatchType"]').val()
//        pageObj.data.title=$('[name="title"]').val()
//        pageObj.data.docStatus=$('[name="status"]').val()
//        pageObj.init();
//    })
    $(document).on('click','.editAndDelete0',function () {
        var businessKey = $(this).parents('tr').find('.businessKey').text();
        var id = $(this).parents('tr').find('.businessKey').attr('attr_id');
        layer.load();
        $.get('/outDocument/receiveDoc',{
            flag:1,
            id:businessKey,
            taskId:id
        },function (json) {
            if(json.flag){
                pageObj.init();
                $.layerMsg({content:'接收成功！',icon:1},function(){
                    layer.close();
                });
            }else{
                $.layerMsg({content:'接受失败！',icon:1},function(){
                    layer.close();
                });
            }
        },'json')
    })
    $(document).on('click','.editAndDelete1',function () {
        var businessKey = $(this).parents('tr').find('.businessKey').text();
        var id = $(this).parents('tr').find('.businessKey').attr('attr_id');
        layer.load();
        $.get('/outDocument/receiveDoc',{
            flag:1,
            id:businessKey,
            taskId:id
        },function (json) {
            if(json.flag){
                pageObj.init();
                var obj = json.object;
                window.open('/workflow/work/workform?tableName=document&opflag=1&flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowProcesses.prcsId+'&flowStep=1'
                    +'&runId='+obj.flowRun.runId);
            }else{
                $.layerMsg({content:'接受失败！',icon:1},function(){
                    layer.close();
                });
            }
        },'json')
    })



</script>
</body>
</html>
