<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/28
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="doc.th.DocumentInquiry" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/lib/laydate.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.form.min.js?20230315.2"></script>
    <script src="/js/jquery/jquery-validate.js?20230315.1"></script>
    <script src="/lib/validate-mothods.js"></script>
    <style>
        /*.fffbg tbody tr{*/
            /*background: #fff!important;*/
        /*}*/
        /*.eeebg{*/
            /*background: #eee!important;*/
        /*}*/
        .fffbg tbody tr input[type=text]{
            width: 70%;
            height:30px;
            border:1px solid #ccc;
            border-radius: 4px;
            padding-left: 10px;
        }
        .fffbg tbody tr select{
            width: 70%;
            height:30px;
            border:1px solid #ccc;
            border-radius: 4px;
            padding-left: 10px;
        }

        #btnsearch{
            top: -42px;
            right: 53px;
            padding: 5px 10px;
            background: red;
            color: #fff;
            border-radius: 6px;
            position: absolute;
        }
        .errrs{
            width:100px;
            height: 100px;
            background: red;
            display: inline-block;
        }
        input[type=submit]{
            width: 70px;
            height: 28px;
            line-height: 26px;
            padding: 0 0 0 10px;
            text-align: center;
            background-image: url(../img/center_q.png);
            background-repeat: no-repeat;
            color: #000;
            cursor: pointer;
            font-size: 14px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            float: none;
            border:none;
        }
        .chongzhi{
            width: 70px;
            height: 28px;
            line-height: 28px;
            padding-left: 8px;
            text-align: center;
            background-image: url(../img/center_q.png);
            background-repeat: no-repeat;
            color: #000;
            cursor: pointer;
            font-size: 13px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            float: none;
            display: inline-block;
            border:none;
            box-sizing: border-box;
        }
        textarea{
            outline: none;
            width: 70%;
            border-radius: 4px;
            padding:10px;
            height:60px;
        }
        .headTop{
            z-index: 999;
        }
        tbody tr td{
            font-size: 11pt;
        }
        .detail{
            cursor: pointer;
        }

        .tableData .fffbg th {
            padding: 0 15px 0 10px;
            font-size: 12pt;
            text-align: left;
        }
        .tableData .fffbg td {
            text-align: left;
            font-size: 10pt;
        }

        .M-box3 a {
            width: 29px;
        }
        .M-box3 a.next,.M-box3 a.prev {
            width: 46px;
        }
    </style>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/workflow/work/workform.js?20210423"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/contractinfoend.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="document.th.DocumentRetrieval" />
    </div>
</div>

<div style="margin: 0 auto;margin-top: 48px;height: 60px;width: 97%;" class="clearfix">

</div>
<div style="margin: 0 auto;width: 97%;">
    <div class="formData" style="display: none">
    <form id="registerForm" action="/document/selectDocSelective?page=1&pageSize=20">
        <%--/document/selectDocSelective--%>
    <table class="fffbg">
        <thead>
        <tr>
            <th width="15%" style="font-size: 16pt;"><fmt:message code="doc.th.CommonConditions" /></th>
            <th width="35%"></th>
            <th width="15%"></th>
            <th width="35%"></th>
        </tr>
        </thead>
        <tbody>
            <tr>
                <td width="15%">
                    <fmt:message code="document.th.DocumentType" />：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="documentType" >
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                        <option value="1"><fmt:message code="doc.th.In" /></option>
                        <option value="0"><fmt:message code="doc.th.Dispatch" /></option>
                    </select>
                </td>
                <td width="15%">
                    <fmt:message code="notice.th.title"/>：
                </td>
                <td width="35%"  style="text-align: left">
                    <input type="text" placeholder="<fmt:message code="global.lang.printsubject"/>" id="title" name="title">
                </td>
            </tr>
            <tr>
                <td width="15%">
                    <fmt:message code="doc.th.TechnologicalProcess"/>：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="flowId" >
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                    </select>
                </td>
                <td width="15%">
                    <fmt:message code="workflow.th.liushui" />：
                </td>
                <td width="35%" style="text-align: left">
                    <input type="text" placeholder="<fmt:message code="workflow.th.PleaseNumber" />" id="runId" name="runId">
                </td>
            </tr>
            <tr>
                <td width="15%" >
                    <fmt:message code="document.th.Urgency"/>：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="urgency" style="display: none">
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                        <option value="急件"><fmt:message code="doc.th.Dispatch1"/></option>
                        <option value="特急"><fmt:message code="doc.th.ExtraUrgent"/></option>
                        <option value="加急"><fmt:message code="doc.th.Urgent"/></option>
                    </select>
                    <select name="workLevel">
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                        <option value="0"><fmt:message code="sup.th.ordinary" /></option>
                        <option value="1"><fmt:message code="sup.th.urgent" /></option>
                        <option value="2"><fmt:message code="doc.th.ExtraUrgent" /></option>
                    </select>
                    <%--<input type="text" placeholder="请输入紧急程度" name="urgency">--%>
                </td>
                <td width="15%" >
                    <fmt:message code="doc.th.ClassifiedLevel"/>：
                </td>
                <td width="35%" style="text-align: left">

                    <select name="secrecy" >
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                        <option value="秘密"><fmt:message code="doc.th.Secret"/></option>
                        <option value="内部"><fmt:message code="doc.th.inside"/></option>
                        <option value="机密"><fmt:message code="doc.th.Confidential"/></option>
                        <option value="绝密"><fmt:message code="doc.th.Top-secret"/></option>
                    </select>
                    <%--<input type="text" placeholder="请输入机密等级" name="secrecy">--%>
                </td>

            </tr>
            <tr>

                <td width="15%">
                    <fmt:message code="file.th.builder"/>：
                </td>
                <td width="35%" style="text-align: left">

                    <textarea name="" readonly style="vertical-align: middle" placeholder="<fmt:message code="doc.th.PleaseCreator"/>" id="creater" cols="30" rows="10"></textarea>
                    <a href="javascript:void (0)" style="vertical-align: bottom" data-num="1" class="theCandidates"><fmt:message code="global.lang.select"/></a>
                    <a href="javascript:void (0)" class="clearAll" style="vertical-align: bottom"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="userId">
                </td>
                <td width="15%">
                    <fmt:message code="doc.th.FoundingDepartment"/>：
                </td>
                <td width="35%" style="text-align: left">

                    <textarea name="" readonly style="vertical-align: middle" placeholder="<fmt:message code="doc.th.selectCreationSection"/>" id="createDept" cols="30" rows="10"></textarea>
                    <a href="javascript:void (0)" style="vertical-align: bottom" data-num="2"  class="theCandidates"><fmt:message code="global.lang.select"/></a>
                    <a href="javascript:void (0)" class="clearAll" style="vertical-align: bottom"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="deptId">
                </td>

            </tr>
            <tr>

                <td width="15%">
                    <fmt:message code="notice.th.createTime"/>：
                </td>
                <td width="35%"  style="text-align: left">
                    <input type="text" readonly="readonly" placeholder="<fmt:message code="doc.th.enterCreationTime"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="createTime">
                </td>
                <td width="15%">
                    <fmt:message code="notice.th.state"/>：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="status" id="">
                        //查询状态改为两个：0-办理中，1-已办结
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                        <option value="0"><fmt:message code="work.th.Executing"/></option>
                        <option value="1"><fmt:message code="work.th.ItOver."/></option>
                        <%--<option value="3"><fmt:message code="doc.th.ToReceive"/></option>
                        <option value="4"><fmt:message code="lang.th.HaveThrough"/></option>--%>
                    </select>
                    <%--<input type="text" placeholder="请输入状态" name="status">--%>
                </td>

            </tr>
            <tr>
                <td width="15%">
                    <fmt:message code="doc.th.DocumentType1"/>：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="dispatchType" >
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                    </select>
                    <%--<input type="text" placeholder="请输入公文种类" name="dispatchType">--%>
                </td>
                <td width="15%">
                   表单字段：
                </td>
                <td width="35%" style="text-align: left">
                    <select name="formData">
                        <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
                    </select>
                    <span id="addFormItem" style="font-size: 30px;vertical-align: middle;display: inline-block;margin: -5px 0px 0px 20px;cursor: pointer">+</span>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <%--<a href="javascript:void(0)" style="margin-right: 10px" class="dataBtn">搜索</a>--%>
                        <input type="submit" value="<fmt:message code="workflow.th.sousuo"/>">
                    <a href="javascript:void(0)" class="chongzhi"><fmt:message code="workflow.th.Reset"/></a>
                </td>

            </tr>
        </tbody>
    </table>
    </form>
    </div>


    <div class="tableData" style="display: none;position: relative">
        <a href="javascript:void(0)" id="btnsearch"><fmt:message code="doc.th.AdvancedSearch"/></a>
        <table class="fffbg">
            <thead>
            <tr>
                <th style="min-width: 55px"><fmt:message code="workflow.th.liushui" /></th>
                <th style="min-width: 74px"><fmt:message code="document.th.DocumentType"/></th>
                <th style="min-width: 230px"><fmt:message code="notice.th.title"/></th>
                <th style="min-width: 90px"><fmt:message code="doc.th.TechnologicalProcess"/></th>
                <th style="min-width: 75px"><fmt:message code="doc.th.DocumentType1"/></th>
                <th style="min-width: 75px"><fmt:message code="document.th.Urgency"/></th>
                <th style="min-width: 75px"><fmt:message code="doc.th.ClassifiedLevel"/></th>
                <th style="min-width: 85px"><fmt:message code="file.th.builder"/></th>
                <th style="min-width: 80px"><fmt:message code="notice.th.createTime"/></th>
                <th style="min-width: 65px"><fmt:message code="notice.th.state"/></th>
                <th style="min-width: 80px"><fmt:message code="notice.th.operation"/></th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
<!-- 分页按钮-->
<%--<div class="M-box3">--%>
</div>

<script>
    // 每次搜索后修改分页末页、首页的样式
    function changeBtn () {
        var f_page = $('.M-box3 .prev').next().text()
        var l_page = $('.M-box3 .next').prev().text()
        if (f_page === "首页") {
            $('.M-box3 .prev').next().css('width','46px')
        }
        if (l_page === "末页") {
            $('.M-box3 .next').prev().css('width', '46px')
        }
    }

    var user_id='';
    var dept_id='';
    var data = {
        'page':1
    }
    $.get('/code/GetDropDownBox',{CodeNos:'GWTYPE'},function (json) {
        var arrTwo=json.GWTYPE;
        var str='<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
        for(var i=0;i<arrTwo.length;i++){
            str+='<option value="'+arrTwo[i].codeNo+'">'+arrTwo[i].codeName+'</option>'
        }
        $('[name="dispatchType"]').html(str)
    },'json')

    $.get('/document/getFlowDocument',function (json) {
        if(json.flag) {
            var arrTwo = json.datas;
            var str = '<option value=""><fmt:message code="hr.th.PleaseSelect"/></option>'
            for (var i = 0; i < arrTwo.length; i++) {
                str += '<option value="' + arrTwo[i].flowId + '">' + arrTwo[i].flowName + '</option>'
            }
            $('[name="flowId"]').html(str)
        }
    },'json')

    $('.theCandidates').on('click', function () {

        var num=$(this).attr('data-num')
        if(num==1) {
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser?0");
        }else if(num==2){
            dept_id=$(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectDept?0");
        }
    })

    $('#btnsearch').on('click', function () {
        $('.formData').show()
        $('.tableData').hide()
        $('.M-box3').hide()
    })
    // initPagination(1710,20)
    function initPagination(totalData,pageSize){
        $('.M-box3').pagination({
            totalData:totalData,
            showData:pageSize,
            jump:true,
            coping:true,
            current: data.page,
            homePage:'首页',
            endPage:'末页',
            prevContent:'上页',
            nextContent:'下页',
            jumpBtn:'跳转',
            callback:function(index){
                data.page = index.getCurrent();
                $('#registerForm').attr('action','/document/selectDocSelective?page='+ data.page +'&pageSize=20');
                ajaxsubmit(function(pageCount){
                    initPagination(pageCount,20);
                });
            }
        });
        changeBtn()
    }
    function ajaxsubmit(cb){
        $('.formItem').each(function () {
            var condition=$(this).find('option:selected').val()
            var conditionValue=$(this).find('input').eq(0).val()
            if(conditionValue){
                $(this).find('input').eq(1).attr('name',$(this).find('input').eq(1).attr('title'))
                $(this).find('input').eq(1).val(condition+'|'+conditionValue)
            }else{
                $(this).find('input').eq(1).removeAttr('name')
            }
        })
        $('#registerForm').ajaxSubmit({
            type:'post',
            dataType:'json',
            success:function (json) {
                if(json.flag){
                    if(json.datas.length>0) {
                        $('.formData').hide()
                        $('.tableData').show()
                        $('.M-box3').show()
                        var  dataArr=json.datas;
                        var str = '';
                        for (var i = 0; i < dataArr.length; i++) {
                            str+='' +
                                '<tr>' +
                                    '<td>'+ dataArr[i].runId +'</td>'+
                                '<td>'+function () {
                                    if(dataArr[i].documentType==0){
                                        return '<fmt:message code="doc.th.Dispatch" />'
                                    }else if(dataArr[i].documentType==1){
                                        return '<fmt:message code="doc.th.In" />'
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+ function(){
                                    if(dataArr[i].title!=undefined){
                                        return dataArr[i].title
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+dataArr[i].flowName+'</td>' +
                                '<td>'+function(){
                                    if(dataArr[i].codeName!=undefined){
                                        return dataArr[i].codeName
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+function(){
                                    if(dataArr[i].workLevel!=undefined){
                                        if(dataArr[i].workLevel == 1){
                                            return '<span style="color: red;">【<fmt:message code="sup.th.urgent" />】</span>'
                                        }else if(dataArr[i].workLevel == 2){
                                            return '<span style="color: red;">【<fmt:message code="doc.th.ExtraUrgent" />】</span>'
                                        }else{
                                            return '<span style="color: #2b7fe0;">【<fmt:message code="sup.th.ordinary" />】</span>'
                                        }

                                    }else {
                                        return '<span style="color: #2b7fe0;">【<fmt:message code="sup.th.ordinary" />】</span>'
                                    }
                                }()+'</td>' +
                                '<td>'+function(){
                                    if(dataArr[i].secrecy!=undefined){
                                        return dataArr[i].secrecy
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+dataArr[i].createrName+'</td>' +
                                '<td>'+function(){
                                    if(dataArr[i].printDate!=undefined){
                                        return dataArr[i].printDate
                                    }else {
                                        return ''
                                    }
                                }()+'</td>' +
                                '<td>'+function () {
                                //查询状态改为两个：0-办理中，1-已办结
                                    /*if(dataArr[i].prFlag==1){
                                        return '<fmt:message code="lang.th.will"/>'
                                    }else*/
                                    if(!dataArr[i].endTime){
                                        return '<fmt:message code="lang.th.Process"/>'
                                    } else {
                                        return '<fmt:message code="lang.th.HaveThrough"/>'
                                    }/*else  if(dataArr[i].prFlag==4){
                                        return '<fmt:message code="lang.th.HaveThrough"/>'
                                    }*/
                                }()+'</td>' +
                                '<td><a class="detail" url-data="/workflow/work/workformPreView?flowId='+dataArr[i].flowId+'&flowStep='+dataArr[i].step+'' +
                                '&tabId='+dataArr[i].id+'&tableName='+dataArr[i].tableName+'&runId='+dataArr[i].runId+'&' +
                                'prcsId='+dataArr[i].realPrcsId+'&isNomalType=false&hidden=true"><fmt:message code="roleAuthorization.th.ViewDetails"/></a></td>'+
                                '</tr>'

                        }
                        $('.tableData table tbody').html(str)
                    }else {
                        $('.tableData table tbody').html('')
                        $.layerMsg({content:'<fmt:message code="doc.th.NoData"/>！',icon:2});
                    }

                    if(cb){
                          cb(json.total);
                    }
                }
            }
        })

    }
$(function () {
    ajaxsubmit(function(pageCount){
        initPagination(1070,20);
    })
    $("#registerForm").validate({
        checkStart: true,
        focusInvalid: false,
        errorPlacement: function(error, element) { //错误信息位置设置方法
            layer.tips(error[0].innerText, $(element) , { time: 2000,tipsMore: true});
        },
        rules:{//验证那个东西
            title:{
//                required:true,
//                maxlength:100
            },
            documentType:{
//                required:true
            }
        },
        messages:{//提示信息
            title:{
//                required:'该项为必填项',
//                maxlength:'最多输入十0位'
            },
            documentType:{
//                required:'该项为必填项'
            }
        },
        submitHandler:function(form){//提交
            if($('[name="userId"]').siblings('textarea').attr('user_id')!=undefined){
                $('[name="userId"]').val($('[name="userId"]').siblings('textarea').attr('user_id').replace(/,/,''))
            }
            if($('[name="deptId"]').siblings('textarea').attr('deptid')!=undefined){
                $('[name="deptId"]').val($('[name="deptId"]').siblings('textarea').attr('deptid').replace(/,/,''))
            }
            data.page = 1
            $('#registerForm').attr('action','/document/selectDocSelective?page='+ data.page +'&pageSize=20');
            ajaxsubmit(function(pageCount){
                initPagination(pageCount,20);
            });
        }
    })

    $('.fffbg').on("click",".detail",function(){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            window.open($(this).attr('url-data').split('workformPreView')[0]+'workformh5PreView'+$(this).attr('url-data').split('workformPreView')[1]);
        } else if (/(Android)/i.test(navigator.userAgent)) {
            window.open($(this).attr('url-data').split('workformPreView')[0]+'workformh5PreView'+$(this).attr('url-data').split('workformPreView')[1]);
        }else{
            window.open($(this).attr('url-data'));
        }
    })
})

    $('.chongzhi').on('click', function () {
        $('#registerForm input[type=text]').each(function (i,n) {
            $(this).val('')
        })
        $('#registerForm select option').each(function (i,n) {
            if($(this).val()==''){
                $(this).prop('selected', true)
            }else {
                $(this).prop('selected', false)
            }
        })
        $('#registerForm textarea').val('')
        $('#registerForm textarea').attr('user_id','')
        $('#registerForm textarea').attr('deptid','')
    })


    $('.clearAll').on('click', function () {
        $(this).siblings('textarea').attr('user_id','').attr('dataid','').attr('username','').attr('userprivname','');
        $(this).siblings('textarea').attr('deptid','').attr('deptname','');
        $(this).siblings('textarea').val('')
    })

    //监听流程选择
    $("select[name='flowId']").on('change', function(){
        var selectedFlowID=$(this).children('option:selected').val()
        $.post('/flowhook/queryFormId',{'folwId':selectedFlowID},function (json) {
            if(json.flag){
                workForm.init({
                        formhtmlurl: '../../form/formType',
                        resdata: {
                            fromId: json.object.formId
                        },
                        flag: 3
                    },
                    function (datas) {
                        var processData = datas;
                        var str='';//流程
                        for(var m=0;m<processData.length;m++){
                            str+='<option value="'+processData[m].name+'">'+processData[m].title+'</option>'
                        }
                        $('select[name="formData"]').html(str)
                    });
            }
        },'json')
    });
    //添加表单字段
    $('#addFormItem').on('click', function () {
        var selectVal=$(this).prev().find('option:selected').val()
        var selectText=$(this).prev().find('option:selected').text()
        if(!selectVal){
            $.layerMsg({content:'<fmt:message code="hr.th.PleaseSelectFlow" />！',icon:0});
            return false
        }
        addFormItem(selectVal,selectText)
    })
    //删除单个表单查询
    $(document).on('click','.delFormItem',function () {
        $(this).parents('tr').remove()
    })
    function addFormItem(selectVal,selectText) {
        $('#registerForm tr').eq(-2).after('<tr class="formItem">' +
            '<td >'+selectText+'</td>' +
            '<td colspan="3" style="text-align: left"><select style="width: 150px"><option value="1"><fmt:message code="workflow.th.equal" /></option><option value="2"><fmt:message code="workflow.th.notEqualTo" /></option><option value="3"><fmt:message code="workflow.th.Startfor" /></option><option value="4"><fmt:message code="hr.th.Contain" /></option><option value="5"><fmt:message code="workflow.th.Endfor" /></option></select>' +
            '<input type="text" style="margin-left: 20px"><input type="hidden" name="'+selectVal+'" title="'+selectVal+'"><span class="delFormItem" style="font-size: 35px;vertical-align: middle;display: inline-block;margin: -8px 0px 0px 15px;width: 20px;cursor: pointer;text-align: center">-</span></td>' +
            '</tr>')
    }

</script>
</body>
</html>
