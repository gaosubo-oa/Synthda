<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="doc.th.DocumentSupervision"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <style>
        .layui-form-radio{
            margin: 3px 10px 0 0!important;
        }
    </style>
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_documentSupervise.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="doc.th.DocumentSupervision"/>
    </div>


</div>
<div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">
    <label class="fl" style="margin-top: 16px;">
        <fmt:message code="document.th.DateRange"/>：
        <select name="computationNumber" id="" >
            <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            <option value="oneMonth"><fmt:message code="doc.th.MonthOver"/></option>
            <option value="secondMonth"><fmt:message code="doc.th.FebruaryOver"/></option>
            <option value="thirdMonth"><fmt:message code="doc.th.MarchOver"/></option>
            <option value="oneWeek"><fmt:message code="doc.th.endWeek"/></option>
            <option value="secondWeek"><fmt:message code="doc.th.TwoWeek"/></option>
            <option value="thirdWeek"><fmt:message code="doc.th.ThreeWeek"/></option>
        </select>
        <fmt:message code="doc.th.recordType"/>：<select name="dispatchType">
        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
    </select>

        <fmt:message code="notice.th.title"/>：<input name="title" />

        <fmt:message code="global.lang.date"/>：<input name="printDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />

        <button  type="button" class="Query fl"  style="float:right;"><fmt:message code="global.lang.query"/></button>
    </label>




</div>


<div class="pagediv" style="margin: 0 auto;width: 1600px;">
    <table>
        <thead>
        <tr>
            <th><fmt:message code="workflow.th.liushui"/></th>
            <th><fmt:message code="doc.th.DispatchHeader"/></th>
            <th><fmt:message code="doc.th.DocumentType"/></th>
            <th><fmt:message code="doc.th.Scholar"/></th>
            <th><fmt:message code="doc.th.DispatchUnit"/></th>
            <th><fmt:message code="doc.th.DispatchTime"/></th>
            <th><fmt:message code="attend.th.CurrentStep"/></th>
            <th><fmt:message code="notice.th.state"/></th>
            <th><fmt:message code="notice.th.operation"/></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr" style="margin-top: 40px;">

    </div>
    <script>
        ;!function(){
            //当使用了 layui.all.js，无需再执行layui.use()方法
            var form = layui.form()
                ,layer = layui.layer;

            $('.pagediv').on('click', '.oversee', function () {
                var me=this;
                var str='<fmt:message code="doc.th.Your"/> ('+$(me).siblings('[name="prcsName"]').val()+')<fmt:message code="doc.th.NeedHandle"/>，' +
                    '<fmt:message code="notice.th.title"/> ：'+$(me).parent().parent().find('td').eq(0).text()+', <fmt:message code="doc.th.recordType"/> ：'+$(me).parent().parent().find('td').eq(1).text()+'';
                layer.open({
                    title:'<fmt:message code="sup.th.SupervisionContent"/>',
                    content:'<form class="layui-form" action=""><div style="margin-top: 10px;">' +
                    '<p class="clearfix">' +
                    '<label style="margin-right: 10px;display: inline-block;width: 150px;float:left;' +
                    'vertical-align: middle;height: 30px;line-height: 30px;text-align: right;"><fmt:message code="doc.th.ManagerSelection"/>:</label>' +
                    '<input type="checkbox" title="<fmt:message code="doc.th.CurrentManager"/>" value="" style="margin-left: 10px;vertical-align: middle" name="nametitle">' +
                    '</p>' +
                    '<p style="margin-top: 25px;">' +
                    '<label style="margin-right: 10px;display: inline-block;float:left;width: 150px;' +
                    'vertical-align: middle;height: 30px;line-height: 30px;text-align: right;"><fmt:message code="doc.th.ManagerSelection"/>:</label>' +
                    '<input type="checkbox" title="<fmt:message code="doc.th.AllHandlers"/>" style="margin-left: 10px;vertical-align: middle" name="nametitleTwo">'+
                    '</p>' +
                    '<p style="margin-top: 25px;">' +
                    '<label style="margin-right: 10px;display: inline-block;float:left;width: 150px;' +
                    'vertical-align: middle;height: 30px;line-height: 30px;text-align: right;"><fmt:message code="sup.th.SupervisionContent"/>:</label>' +
                    '<textarea id="textareas"   style="width: 275px;height:60px;padding: 5px 10px;border-radius:4px;vertical-align: middle" name="nametitlesda"' +
                    'placeholder="<fmt:message code="doc.th.enterContents"/>" value="'+str+'">'+str+'</textarea>'+
                    '</p>' +
                    '</div></form>',
                    btn:['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'],
                    area:['600px','350px'],
                    success:function () {
                        if($(me).nextAll('[name="curUserIdName"]').val()!=''){
                            $('[name="nametitle"]').attr('checked',true)
                        }
                        if($(me).nextAll('[name="allUserIdName"]').val()!=''){
                            $('[name="nametitleTwo"]').attr('checked',true)
                        }
                        form.render('checkbox')
                    },
                    yes:function () {
                        var classifyNum=null;
                        if($('[name="nametitle"]').is(':checked')){
                            classifyNum=0
                        }
                        if($('[name="nametitleTwo"]').is(':checked')){
                            classifyNum=1
                        }
                        if($('[name="nametitle"]').is(':checked')&&$('[name="nametitleTwo"]').is(':checked')){
                            classifyNum=2
                        }





                        $.post('/document/addDocSendSms',{cuName:$(me).siblings('[name="curUserId"]').val(),
                            allName:$(me).siblings('[name="allUserId"]').val(),
                            title:$('[name="nametitlesda"]').val(),
                            classify:classifyNum,
                            flowId:$(me).siblings('[name="flowId"]').val(),
                            prcsId:$(me).siblings('[name="prcsId"]').val(),
                            flowStep:$(me).siblings('[name="flowStep"]').val(),
                            opFlag:$(me).siblings('[name="opFlag"]').val(),
                            runId:$(me).siblings('[name="runId"]').val()
                        },function (json) {
                            if(json.flag){
                                $.layerMsg({content:'<fmt:message code="document.th.SuperviseSuccess"/>！',icon:1},function(){
                                    ajaxPage.data.page=1;
                                    ajaxPage.page();
                                });

                            }else{
                                $.layerMsg({content:'<fmt:message code="document.th.Supervisefailure"/>！',icon:2});
                            }
                        },'json')
                    }
                })
            })

        }();
        var ajaxPage={
            data:{
                page:1,//当前处于第几页
                pageSize:7,//一页显示几条
                useFlag:true,
                computationNumber:null
            },
            page:function () {
                var me=this;
                this.data.computationNumber=$('[name="computationNumber"]').val();
                this.data.title=$('input[name="title"]').val();
                this.data.dispatchType=$('[name="dispatchType"]').val();
                this.data.printDate=$('[name="printDate"]').val();
                $.get('/document/selOverseeTheOfficialDocument',me.data,function (json) {

                    var str='';
                    var arr=json.datas;
                    for(var i=0;i<arr.length;i++){
                        str+='<tr>' +
                                '<td>'+arr[i].runId+'</td>'+
                            '<td>'+function () {
                            if(arr[i].title!=undefined){
                                return arr[i].title
                            }else {
                                return ""
                            }
                        }()+'</td>' +
                            '<td>'+function () {
                                if(arr[i].codeName){
                                    return arr[i].codeName
                                }else {
                                    return ""
                                }
                            }()+'</td>' +
                            '<td>'+arr[i].createrName+'</td>' +
                            '<td>'+function () {
                                if(arr[i].unit){
                                    return arr[i].unit
                                }else {
                                    return ""
                                }
                            }()+'</td>' +
                            '<td>'+arr[i].printDate+'</td>' +
                            '<td><fmt:message code="workflow.th.First" />'+arr[i].step+'<fmt:message code="workflow.th.step" />：'+arr[i].prcsName+'</td>' +
                            '<td>'+function () {
                                if(arr[i].prFlag==1){
                                    return '<fmt:message code="lang.th.will"/>'
                                }else {
                                    return '<fmt:message code="lang.th.Process"/>'
                                }
                            }()+'</td>' +
                            '<td>' +
                            '<a href="javascript:void(0)" class="oversee" data-id="'+arr[i].id+'" style="margin-right: 10px"><fmt:message code="doc.th.Supervise"/></a>' +
                            '<input type="hidden" name="allUserId" value="'+arr[i].allUserId+'">' +
                            '<input type="hidden" name="curUserId" value="'+arr[i].curUserId+'">' +
                            '<input type="hidden" name="prcsName" value="'+arr[i].prcsName+'">' +
                            '<input type="hidden" name="flowId" value="'+arr[i].flowId+'">' +
                            '<input type="hidden" name="prcsId" value="'+arr[i].realPrcsId+'">' +
                            '<input type="hidden" name="flowStep" value="'+arr[i].step+'">' +
                            '<input type="hidden" name="runId" value="'+arr[i].runId+'">' +
                            '<input type="hidden" name="opFlag" value="'+arr[i].opFlag+'">' +
                            '<a href="/workflow/work/workformPreView?flowId='+arr[i].flowId+'&flowStep='+arr[i].step+'&tabId='+arr[i].id+'&tableName='+arr[i].tableName+'&runId='+arr[i].runId+'&prcsId='+arr[i].realPrcsId+'&isNomalType=false&hidden=true" target="_blank"><fmt:message code="roleAuthorization.th.ViewDetails"/></a>' +
                            '</td>' +
                            '</tr>'
                    }
                    $('.pagediv table tbody').html(str)
                    me.pageTwo(json.total,me.data.pageSize,me.data.page)

                },'json')
            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage:'',
                    endPage: '',
                    current:indexs||1,
                    callback: function (index) {

                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPage.page()
        $('.Query').on('click', function () {
            ajaxPage.data.page=1;
            ajaxPage.page()
        })

        $(function () {
            $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
                var arrTwo=json.GWTYPE;
                var str='';
                for(var i=0;i<arrTwo.length;i++){
                    str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
                }
                $('[name="dispatchType"]').append(str)
            },'json')
        })

    </script>
</div>
</body>
</html>
