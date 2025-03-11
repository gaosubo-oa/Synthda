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
    <title>下发公文</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script src="/js/common/language.js"></script>

    <<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
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
            width: 98.5% !important;
        }
        .page-top-inner-layer{
            width: inherit;
        }
        .pagediv{
            overflow-x: visible!important;
        }
        thead tr th:nth-child(2){
            padding-left: 80px!important;
        }
        thead tr th:nth-child(3){
            padding-left: 30px!important;
        }
        thead tr th:nth-child(5){
            padding-left: 20px!important;
        }
    </style>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daibanfawen.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="document.th.IssueOfficialDocuments"/>
    </div>


</div>
<%--<div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">--%>
    <%--<label class="fl" style="margin-top: 16px;">--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="doc.th.recordType"/>：</span>--%>
        <%--<select name="dispatchType" id="">--%>
            <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
        <%--</select>--%>
    <%--</label>--%>

    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="global.lang.date"/>：</span>--%>
        <%--<label class="fl"><input name="printDate" readonly="readonly" placeholder="<fmt:message code="doc.th.enterDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text"></label>--%>

    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.title"/>：</span>--%>
        <%--<label class="fl"><input name="title" placeholder="<fmt:message code="global.lang.printsubject"/>"  type="text"></label>--%>
    <%--</label>--%>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >--%>
        <%--<span class="fl" style="margin-top: 5px;"><fmt:message code="notice.th.state"/>：</span>--%>
        <%--<label class="fl"><select name="status">--%>
            <%--<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>--%>
            <%--<option value="1"><fmt:message code="lang.th.will"/></option>--%>
            <%--<option value="2"><fmt:message code="lang.th.Process"/></option>--%>
        <%--</select></label>--%>
        <%--<button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>--%>
    <%--</label>--%>

<%--</div>--%>


<div id="pagediv" style="    margin-top: 66px;">

</div>


<script>
    var openRold=parent.opensload;
    var typeName;
    var huiqian;
    <%--$.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {--%>
        <%--var arrTwo=json.GWTYPE;--%>
        <%--var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'--%>
        <%--for(var i=0;i<arrTwo.length;i++){--%>
            <%--str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'--%>
        <%--}--%>
        <%--$('[name="dispatchType"]').html(str)--%>
    <%--},'json')--%>


    function judge(that) {
        if($(that).val()!=''){
            $(that).attr('data-type',2)
        }else {
            $(that).attr('data-type',1)
        }
    }


    var pageObj=$.tablePage('#pagediv','100%',[
        {
            width:'90px',
            title:'<fmt:message code="workflow.th.liushui"/>',
            name:'id'
        },
        {
            width:'180px',
            title:'<fmt:message code="doc.th.DispatchHeader"/>',
            name:'title',
            selectFun:function (title) {
                if(title!=undefined){
                    return title
                }else {
                    return ""
                }
            }
        },
        <%--{--%>
            <%--width:'122px',--%>
            <%--title:'<fmt:message code="doc.th.TypeDocument"/>',--%>
            <%--name:'codeName',--%>
            <%--selectFun:function (codeName,obj) {--%>
                <%--if(codeName){--%>
                    <%--return codeName--%>
                <%--}else {--%>
                    <%--return ""--%>
                <%--}--%>
            <%--}--%>
        <%--},--%>
       /* {
            width:'120px',
            title:'<fmt:message code="doc.th.Scholar"/>',
            name:'transferUserName'
        },{
            width:'170px',
            title:'<fmt:message code="doc.th.DispatchUnit"/>',
            name:'unit',
            selectFun:function (unit,obj) {
                if(unit){
                    return unit
                }else {
                    return ""
                }
            }
        },*/{
            width:'180px',
            title:'<fmt:message code="doc.th.DispatchTime"/>',
            name:'transferTime'
        },

        {
            width:'120px',
            title:'<fmt:message code="notice.th.state"/>',
            name:'transferFlag',
            selectFun:function (prFlag) {
                if(prFlag==0){
                    return '未转交'
                }else if(prFlag==1){
                    return '已转交'
                } else {
                    return ''
                }
            }
        },
        {
            width:'128px',
            title:'<fmt:message code="notice.th.operation"/>'
        }
    ],function (me) {
//        me.data.printDate=$('[name="printDate"]').val();
//        me.data.dispatchType=$('[name="dispatchType"]').val()
//        me.data.title=$('[name="title"]').val()
//        me.data.docStatus=$('[name="status"]').val()
//        me.data.documentType=0;
        //1显示  // 2不显示  //不写fn这个属性就是全显示
        me.init('/documentOrg/selDocumentOrg',[{name:'<fmt:message code="document.th.handle"/>',fn:function (obj) {
            if(obj.transferFlag==0){
                return 1
            }else {
                return 2
            }
        }},{
            name:'<fmt:message code="document.th.HaveBeenHandled"/>',
            fn:function (obj) {
                if(obj.transferFlag==0){
                    return 2
                }else {
                    return '<span style="color: #111;"><fmt:message code="document.th.HaveBeenHandled"/></span>'
                }
            }
        },{
            name:'<fmt:message code="long.th.See"/>',
            fn:function (obj) {
                if(obj.transferFlag==0){
                    return 1
                }else {
                    return 1
                }
            }
        }])
    })


    $(document).on('click','.editAndDelete2',function () {
        var obj=pageObj.arrs[$(this).attr('data-i')];
        // console.log(obj)
        huiqian='zhuban';
        layer.open({
            title:'查看是否接收',
            type:1,
            closeBtn:0,
            shadeClose:true,
            area:['600px','400px'],
            content: '<div class="infobox" style="height: 73px;margin-top: 20px">' +
                        '<ul style="margin:0 auto;width: 90%;"><table>'+
                            '<tr>' +
                                '<td style="text-align: center;font-size: 10pt;padding: 10px"><fmt:message code="lang.th.will"/>：</td><td id="1" colspan="2"></td>' +
                            '</tr>'+
                            '<tr>' +
                                '<td style="text-align: center;font-size: 10pt;padding: 10px"><fmt:message code="lang.th.received"/>：</td><td id="2" colspan="2"></td>' +
                            '</tr>'+
                        '</ul>'+
                '</div>',
            success:function () {
                var str='';
                $.get('/documentOrg/selectDocumentOrgIsConduct',{runId:obj.runId,transferReceiveOrg:obj.transferReceiveOrg,title:obj.title},function (json) {
                        var str='';
                        var arr=json.obj;
                        for(var i=0;i<arr.length;i++){
                            str+='<li style="margin: 10px;">' +
                                '<label><p>'+arr[i].name+'</p></label>'
                        }
                        $('#1').html(str);

                },'json'),
                    $.get('/documentOrg/selectDocumentOrgIsConducts',{runId:obj.runId,transferReceiveOrg:obj.transferReceiveOrg,title:obj.title},function (json) {
                        var str='';
                        var arr=json.obj;
                        for(var i=0;i<arr.length;i++){
                            str+='<li style="margin: 10px;">' +
                                '<label><p>'+arr[i].name+'</p></label></li>'
                        }
                        $('#2').html(str);

                    },'json')
            }
        })
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

        var obj=pageObj.arrs[$(this).attr('data-i')];
        huiqian='zhuban';
        layer.open({
            title:'<fmt:message code="document.th.IssueAnArticle"/>',
            btn:['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'],
            type:1,
            area:['600px','400px'],
            content:'<form id="datasave" action="" method="post" >' +
            '<ul class="formUl">' +
            <%--'<li class="clearfix"><label><b>*</b><fmt:message code="sms.th.TemplateName"/>:</label>' +--%>
            <%--'<input type="text" name="name" placeholder="<fmt:message code="doc.th.PleaseEnterTemplateName"/>">' +--%>
            <%--'</li>' +--%>



            '</ul>' +
            '</form>',
            success:function () {
               $.get('/document/sortFlow?mainType=DOCUMENTTYPE&detailType=SENDNG',function (json) {
                   if(json.flag){
                       var str='<li style="font-size: 14pt;\
                       box-sizing: border-box;\
                       padding-left: 79px;\
                       font-weight: bold;"><fmt:message code="document.th.IssueAnArticle"/></li>';
                       var arr=json.datas;
                       for(var i=0;i<arr.length;i++){
                           str+='<li class="clearfix">' +
                               '<label>'+arr[i].sortName+':</label>' +
                               '<select name="fawen" onchange="judge(this)" data-type="1" data-id="'+arr[i].sortId+'">' +function () {
                                  var ops='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
                                   for(var o=0;o<arr[i].flows.length;o++){
                                       ops+='<option value="'+arr[i].flows[o].flowId+'">'+arr[i].flows[o].flowName+'</option>'
                                   }
                                   return ops;
                               }()+'</select>'+
                               '</li>'
                       }
                       $('.formUl').append(str);

                   }
               },'json')
                $.get('/document/sortFlow?mainType=DOCUMENTTYPE&detailType=RECEIVE',function (json) {
                    if(json.flag){
                        var str='<li style="font-size: 14pt;\
                       box-sizing: border-box;\
                       padding-left: 79px;\
                       font-weight: bold;"><fmt:message code="document.th.SendingAnIncomingMessage"/></li>';
                        var arr=json.datas;
                        for(var i=0;i<arr.length;i++){
                            str+='<li class="clearfix">' +
                                '<label>'+arr[i].sortName+':</label>' +
                                '<select onchange="judge(this)" name="shouwen" data-type="1" data-id="'+arr[i].sortId+'">' +function () {
                                    var ops='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
                                    for(var o=0;o<arr[i].flows.length;o++){
                                        ops+='<option value="'+arr[i].flows[o].flowId+'">'+arr[i].flows[o].flowName+'</option>'
                                    }
                                    return ops;
                                }()+'</select>'+
                                '</li>'
                        }
                        $('.formUl').append(str);

                    }
                },'json')
            },yes:function (index) {
                var selectArr=$('.formUl [data-type="2"]').length;
                if(selectArr!=1){
                    $.layerMsg({
                        content:'<fmt:message code="common.th.onlyChooseOne"/>',
                        icon:2
                    })
                    return
                }else {
                    var sortId=obj.id;
                    var flowId=$('[data-type="2"]').val();
                    var documentType;
                    if($('[data-type="2"]').attr('name')=='fawen'){
                        documentType=0
                    }else if($('[data-type="2"]').attr('name')=='shouwen'){
                        documentType=1
                    }
                    $.get('/documentOrg/saveToDocument',{
                        flowId:flowId,
                        id:sortId,
                        documentType:documentType
                    },function (json) {
                        if(json.flag){
                            pageObj.init();
                            window.open('/workflow/work/workform?flowId='+json.object.flowId+'&flowStep=1&tableName=document&tabId='+json.object.id+'&runId='+json.object.runId+'&prcsId=1&isNomalType=false')
                            layer.close(index)
                        }
                    },'json')
                }
            }
        })

    })




</script>
</body>
</html>
