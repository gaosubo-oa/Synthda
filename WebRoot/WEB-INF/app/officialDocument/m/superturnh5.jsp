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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title><fmt:message code="document.th.nextStep" /></title>
    <link rel="stylesheet" href="../../css/workflow/work/m/style.css">
    <style>
        .basic_infor_title{
            background: #f5f5f9;
            height: 32px;
            padding: 0 16px;
        }
        .basic_infor_title .basic_infor{
            margin-left: 6px;
            line-height:32px;
        }
        .basic_infor_title .icon{
            margin-top: 8px;
            height: 16px;
            width: auto;
        }
        .word_title .word_quick_action{
            font-size:16px;
        }
        .main_2 h1{
            margin-left: 5px;
        }
        .main_2{
            padding-left: 15px;
        }
        .list-panel{
            padding-left: 15px;
            margin-top: 0;
        }
        .l .circle{

            margin-right: 8px;
            border: none;
        }
        .l .circle1{

            margin-right: 8px;
            border: none;
            width: 20px;
            height: 20px;
            border-radius: 10px;

        }
        .circle1 {
            margin-top: 12px;
        }
        .bag{
            background: none;
            /*background: url(../../../../img/widget_check2.png)no-repeat 0px 0px;*/
            /*border: none!important;*/
            width: 20px!important;
            height: 20px!important;
        }
        .circle {
            margin-top: 12px;
        }
        .main_2{
            height: 44px;
            padding-left: 30px;
        }
        .r{
            line-height:44px;
        }
        .nofirest{
            height:44px;
            line-height:44px;
            padding-left: 15px;
        }
        .list-group-item{
            position: relative;
            height:44px;
            line-height:44px;
            padding-left: 18px;
        }
        .inputbtn{
            position: absolute;
            width:16px;
            height: 16px;
            top: 14px;
        }
        .list-panel span{
            margin-left: 28px;
        }
        body{
            font-size:15px;
        }
        .head_top{
            height: 98px;
            border-top: none;
            padding: 0 16px;
        }
        .head_toptitle{
            font-size: 14px;
            height: 14px;
            line-height: 14px
        }
        .head_top ul li span {
            letter-spacing: 1px;
        }
        .weight {
            font-weight: 300;
        }
        .zhuanjiaotitle li{
            font-size: 12px;
        }
        .l, .r{
            height: 40px;
        }
        .done{height: auto;border-bottom:none;margin-bottom: 15px;}
        .type_done{border: none;background-color: #3984ff;padding: 13px 35px;font-size: 16px;margin-top: 20px;font-weight: bold}
        .bzclass{
            position: absolute;
            top: 7px;
            left: 150px;
            color: red;
        }
        .xz_bz{
            height: 40px;
            line-height: 40px;
            padding-left: 20px;
        }
         header {
             height: 38px;
             display: flex;
             align-items: center;
             justify-content: space-between;
             font-size: 15px;
             color: #fff;
             position: fixed;
             width: 90%;
             z-index: 1;
             top: 0;
             padding: 0 5%;
             background-color: #3984ff;
             box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
         }
        .bags{
            background: none;
            /*background: url(../../../../img/widget_check2.png)no-repeat 0px 0px;*/
            /*border: none!important;*/
            width: 20px!important;
            height: 20px!important;
        }
    </style>
</head>
<body>
<header>
    <i><a href="javascript:history.go(-1);" style="color: #fff">返回</a></i>
    <span>转交下一步骤</span>
    <i id="turnBtn">转交</i>
</header>
<div style="height: 38px;">

</div>
<%--<button id="turnBtn" style="display: none;"><fmt:message code="workflow.th.Transfer" /></button>--%>
<div class="head_top">
    <span class="head_toptitle" style="color: #3682e1;font-size: 18px;font-weight: 900;"><span style="letter-spacing: 1px;"><fmt:message code="workflow.th.liushui" />&nbsp;</span><span id="flowRunId"></span></span>
    <ul style="margin-top: 10px;color: #333;font-weight: 300;"  class="zhuanjiaotitle">
        <li><span class="head_toptitle weight" id="flowName"><fmt:message code="workflow.th.processname" />：</span></li>
        <li style="margin-top: 7px"><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiator" />：</span><span id="flowBeginUser" class="head_toptitle" style="margin-left: 2px;"></span></li>
        <li style="margin-top: 7px"><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiation" />：</span><span id="flowBeginTime" class="head_toptitle" style=" margin-left: 2px;"></span></li>
    </ul>
</div>
<div class="turnview" id="pro_turn" style="display: none">
    <%--<div class="word_title" style="margin-top: 0">--%>
    <%--<img src="../../img/workflow/m/apply_next_select.png" alt="" class="icon">--%>
    <%--<div class="word_quick_action"><fmt:message code="main.th.nextStep" /></div>--%>
    <%--</div>--%>
    <div class="basic_infor_title" style="position: relative">
        <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
        <div class="basic_infor" style="position:  relative;display: inline-block;font-size: 16px;color: #333;margin-left: 6px;font-weight: 300;top: -3px;"><fmt:message code="main.th.nextStep" /></div>
        <div class="bzclass"></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div class="list-panel" id="nextstep">

    </div>

    <div id="panel-next-user" style="margin-top: 15px;">

        <%--<div class="word_title nofirest">--%>
        <%--<img src="../../img/workflow/m/apply_next_select.png" alt="" class="icon">--%>
        <%--<div class="word_quick_action"><fmt:message code="workflow.th.nextStepStaff" /></div>--%>
        <%--</div>--%>
        <div class="basic_infor_title">
            <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
            <div class="basic_infor" style="position:  relative;display: inline-block;font-size: 16px;color: #333;margin-left: 6px;font-weight: 300;top: -3px;"><fmt:message code="workflow.th.nextStepStaff" /></div>
            <div class="basic_infor_title_link">
                <a href="#"></a>
            </div>
        </div>

        <div class="main" style="position:inherit;">
            <div class="main2" id="prcsUserlist" style="margin-top:0px;">
            </div>
        </div>
    </div>
    <%--<div class="word_title nofirest">--%>
    <%--<img src="../../img/workflow/m/apply_next_select.png" alt="" class="icon">--%>
    <%--<div class="word_quick_action"><fmt:message code="workflow.th.NotificationRange" /></div>--%>
    <%--</div>--%>
    <div class="basic_infor_title">
        <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
        <div class="basic_infor" style="position:  relative;display: inline-block;font-size: 16px;color: #333;margin-left: 6px;font-weight: 300;top: -3px;"><fmt:message code="workflow.th.NotificationRange" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div class="list-panel">
        <ul class="list-group next_steps">
            <%--<li class="list-group-item" style="display: none;">--%>
            <%--<input type="checkbox" value="1" name="notice_prev_user" class="inputbtn">--%>
            <%--<span><fmt:message code="workflow.th.PreviousApplicationPersonnel" /></span>--%>
            <%--</li>--%>
            <li class="list-group-item">
                <input type="checkbox" value="1" name="notice_next_user" checked="" class="inputbtn">
                <span><fmt:message code="workflow.th.NextStaff" /></span>
            </li>
            <li class="list-group-item">
                <input type="checkbox" value="3" name="notice_apply_user" class="inputbtn">
                <span><fmt:message code="workflow.th.firstApplyPersonnel" /></span>
            </li>
            <li class="list-group-item">
                <input type="checkbox" value="5" name="notice_all_user" class="inputbtn">
                <span><fmt:message code="workflow.th.AllPersonnel" /></span>
            </li>
        </ul>
    </div>
    <%--<div class="done" style="text-align: center; display: none">--%>
        <%--<button class="type_done" id="backBtn" style="background-color: #ec5959;">返回</button>--%>
        <%--<button class="type_done" id="turnBtn" style="">转交</button>--%>
    <%--</div>--%>
</div>
<div class="cont_form" style="display: none;"></div>

<script src="../../js/xoajq/xoajq1.js"></script>
<script src="../../js/jquery/jquery.cookie.js"></script>
<script src="../../lib/layer/layer.js?20201106"></script>
<script src="../../js/template.js"></script>
<script src="../../lib/laydate/laydate.js"></script>
<script src="../../js/mustache.min.js"></script>


<script src="../../js/base/base.js"></script>
<%--<script src="../../js/base/vconsole.min.js"></script>--%>
<script src="../../js/workflow/work/workform.js?20210423"></script>
<%--<!-- 金格签章 -->--%>

<%--<link rel="stylesheet" href="../../lib/kinggrid/dialog/artDialog/ui-dialog.css">--%>
<%--<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.css">--%>

<%--<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.min.js"></script>--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.plus.min.js"></script>--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/dialog/artDialog/dialog.js"></script>--%>

<%--<!-- html签章核心JS -->--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/signature.min.js"></script>--%>
<%--<!-- PC端附加功能 -->--%>
<%--&lt;%&ndash;<script type="text/javascript" src="../../lib/kinggrid/signature.pc.min.js"></script>&ndash;%&gt;--%>
<%--<!-- 移动端端附加功能 -->--%>
<%--<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.mobile.css">--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/signature.mobile.min.js"></script>--%>
<%--&lt;%&ndash;<script src="/js/base/vconsole.min.js"></script>&ndash;%&gt;--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/signature_pad.min.js"></script>--%>
<%--<script type="text/javascript" src="../../lib/kinggrid/jquery.timer.dev.js"></script>--%>

<script>


    $.extend({
        getQueryString:function(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
    });

    //使用
    var backType = $.getQueryString("backType");
    var globalData = {};
    var turn;
    $(function () {

//        var vConsole = new VConsole();
        var flowId = $.getQueryString("flowId");
        var flowStep = $.getQueryString("flowStep") || '';
        var prcsId = $.getQueryString("prcsId") || '';
        var runId = $.getQueryString("runId") || '';
        var tableName = $.getQueryString("tableName") || '';
        var tabId = $.getQueryString("tabId") || '';
        layer.load();
        workForm.init({
                formhtmlurl:'../../workflow/work/workfastAdd',//URL
                resdata:{
                    flowId:flowId,
                    runId:runId,
                    prcsId:prcsId,
                    flowStep:flowStep
                },
                flowStep:prcsId,//预览
                target:'.cont_form'},
            function (data,option) {
                console.log(data);
                console.log(option);
                globalData.fromDataReject = buildFormData();
                globalData.formdatavalue = builformValue();
                globalData.listFp = data.object.listFp;
                globalData.flowRun = data.object.flowRun;
                globalData.flowRunPrcs = data.object.flowRunPrcs;
                globalData.flowProcesses = data.object.flowProcesses;
                globalData.topDefault = globalData.flowProcesses.topDefault;
                globalData.checkTurnPriv = data.object.checkTurnPriv;

                buildNextStep(globalData.listFp,prcsId);
                $('#flowName').text(data.object.flowRun.runName);
                $('#flowBeginUser').text(data.object.flowRun.userName);
                $('#flowBeginTime').text(data.object.flowRun.beginTime);
                $('#flowRunId').text('No.'+data.object.flowRun.runId);
            });
        function builformValue(){
            var form_item=$('.cont_form .form_item');
            var realData=[];
            var radioArr = {};
            var modifydata =[];
            var flag = false;
            for(var i=0;i<form_item.length;i++){
                var baseData={};
                var value="";
                var obj = form_item.eq(i);
                var datatype = obj.attr("data-type");
                var key=obj.attr("name");
                var ismust = obj.attr('ismust');
                if(datatype=="select"){
                    value= obj.val()==0?'':form_item.eq(i).val();
                }else if(datatype=="textarea" || datatype=="text"  ){
                    value=obj.val();
                }else if(datatype=="checkbox"){
                    if(obj.is(':checked')){
                        value = '1';
                    }else{
                        value = '0'
                    }
                }else if(datatype=="macros"){
                    if(obj.attr('type') == "text"){
                        value= obj.val();
                    }else{
                        if(obj.val() > -1){
                            value = obj.val()+'_'+obj.find("option:selected").text();
                        }
                    }
                }else if(datatype == "radio"){
                    var name = obj.attr('name');
                    if(!radioArr[obj.attr('name')]){
                        radioArr[obj.attr('name')] = true;
                        if($("input[name='"+name+"']:checked").length>0){
                            value= $("input[name='"+name+"']:checked").val();
                        }else{
                            value = "";
                        }
                    }else{
                        continue;
                    }
                }else if(datatype == "macrossign"){
                    value= obj.html();

                }else if(datatype == "fileupload"){
                    value= obj.attr('atturl');
                }else if(datatype == "imgupload"){
                    var name = obj.attr('name');
                    $('img[name='+name+']').each(function(i,v){
                        var url = $(v).attr('src');
                        if(url!='/img/icon_uploadimg.png'){
                            value+= (url+',');
                        }
                    })
                }else if(datatype == "sign"){
                    //if(!_this.attr('disabled') == 'disabled'){
                    var pre = obj.prev();
                    value = Mustache.render(pre.html(),{content:''});
//                        }else{
//                            value = "";
//                        }

                } else if(datatype == "userselect"){
                    value= (obj.attr('user_id')||'')+'|'+ (obj.attr('username')||'');
                }else if(datatype == "deptselect"){
                    value= (obj.attr('deptid') || '')+'|'+(obj.attr('deptname')||'');
                }else if(datatype == "kgsign"){
                    value = (obj.attr('signatureId') || '');
                }else if(datatype == "listing"){
                    var vtrStr = [];
                    obj.find('tr').each(function(){
                        if($(this).attr('class') != 'listhead' && $(this).attr('class')!= 'listfoot'){
                            var  listTdObj = $(this).find('td');
                            var vtdStr = []
                            listTdObj.each(function (i,v) {

                                var _this = $(v);
                                var listtype = $(v).attr('listtype');
                                switch (listtype){
                                    case 'text':
                                        vtdStr.push(_this.find('input').val());
                                        break;
                                    case 'textarea':
                                        vtdStr.push(_this.find('textarea').val());
                                        break;
                                    case 'select':
                                        vtdStr.push(_this.find('select').val());
                                        break;
                                    case 'radio':
                                        var name = _this.find('input').eq(0).attr('name');
                                        vtdStr.push($('input[name="'+name+'"]:checked').val());
                                        break;
                                    case 'checkbox':
                                        var checkboxStr = [];
                                        _this.find('input:checked').each(function(i,v){
                                            checkboxStr.push($(v).attr('value'));
                                        });
                                        vtdStr.push(checkboxStr.join(','));
                                        break;
                                    case 'datetime':
                                        vtdStr.push(_this.text())
                                        break;
                                    case 'dateAndTime':
                                        vtdStr.push(_this.text())
                                        break;
                                    default:

                                }

                            });

                            vtrStr.push(vtdStr.join('`'))
                        }
                    });
                    value = vtrStr.join('\r\n');
                }else if(datatype == 'readcomments'){
                    value = obj.val();
                }else{
                    value = obj.val();
                }
                if(ismust == 'true' && value == ""){
                    flag = true;
                    layer.msg('<fmt:message code="main.th.PleaseFill" />'+obj.attr('title'), {icon: 1});
                    break;
                }
                if( value!=null){
                    baseData["key"]=key;
                    baseData["value"]=value;
                    realData.push(baseData);
                }
                if(value && value != ''){
                    modifydata.push(baseData);
                }
            }
            return realData;
        }
        function buildFormData(){
            var arr = {};
            $(".cont_form").find('.form_item').each(function(i,v){
                var _this = $(this);
                arr[_this.attr('title')] = _this.attr('name');
            });
            return arr;
        }
//        $.ajax({
//            type: "get",
//            url: '../../workflow/work/workfastAdd',
//            dataType: 'JSON',
//            data: {
//                flowId:flowId,
//                runId:runId,
//                prcsId:prcsId,
//                flowStep:flowStep,
//            },
//            success: function (res) {
//                if(res.flag){
//                    globalData.listFp = res.object.listFp;
//                    globalData.flowRun = res.object.flowRun;
//                    globalData.flowRunPrcs = res.object.flowRunPrcs;
//                    buildNextStep(globalData.listFp,prcsId);
//                    $('#flowName').text(res.object.flowRun.runName);
//                    $('#flowBeginUser').text(res.object.flowRun.userName);
//                    $('#flowBeginTime').text(res.object.flowRun.beginTime);
//                    $('#flowRunId').text('No.'+res.object.flowRun.runId);
//                }
//            }
//        });
        function buildNextStep(arr,prcsId){
            var listFp = {}
            arr.forEach(function(v,i){
                listFp[v.prcsId] = v;
            })
            var prcName = '';
            var nextPrcsArr = listFp[prcsId].prcsTo;
            if(nextPrcsArr.indexOf(',')){
                nextPrcsArr = nextPrcsArr.split(',');
            }
            if(globalData.flowProcesses.prcsType == '4'){   //循环节点
                nextPrcsArr.push(prcsId)
            }
            if(globalData.flowProcesses.syncDeal == 0){     //并发判断
                syncDeal = '禁止并发';
            }else if(globalData.flowProcesses.syncDeal == 1){
                syncDeal = '允许并发';
            }else if(globalData.flowProcesses.syncDeal == 2){
                syncDeal = '强制并发';
            }
            $('.bzclass').html('（此步骤'+syncDeal+'）');

            nextPrcsArr.forEach(function (v,i) {
                if(v){
                    var prc = listFp [v];
                    if(v == 0){
                        prcName +='<li class="nofirest"  onclick="ajax_info($(this))" datasnum="js"><div class="l"><img src="/img/widget_open.png" id="end" uname="" class="circle"  type="radio" nextPrcsId="0" value="normal2" name="nextstep"></div></div><div class="r"><span class="bz_name" style="margin-left: 0;"><fmt:message code="workflow.th.EndingApproval" /></span></li>'
                        if(i == 0){
                            $('#panel-next-user').hide();
                            $('.next_steps li').eq(0).remove();
                            $('.next_steps li').eq(0).find('input').attr('checked',true);
                        }


                    }else{
                        checkPrcIn(prc.prcsIn,prc.prcsInSet,globalData.formdatavalue,globalData.fromDataReject,function(res){
                            if(res.flag){
                                var click = 'onclick="ajax_info($(this))" datasnum="kd"';
                            }else{
                                var click = 'onclick="ajax_info1($(this))" datasnum="bkd" msg="'+ prc.conditionDesc.split('\n')[0] +'"';
                            }
                            var checked = 'checked="checked"';
                            if(prcsId ==1){
                                $('.next_steps li').eq(2).remove();
                                $('.next_steps li').eq(1).remove();
                            }
                            prcName +='<li class="nofirest" '+ click +'><div class="l"><img src="/img/widget_open.png" uname="" class="circle"  type="radio" nextPrcsId="'+prc.prcsId+'" value="normal2" name="nextstep"></div><div class="r"><span class="bz_name" style="margin-left: 0;">'+prc.prcsName+'</span></div><div class="r"><span style="display: none;margin-left: 0;color: red;" class="r_s"></span></div></li>'
                        });
                    }
                }else{
                    var prc = listFp [v];
                }
            });
            $('#nextstep').html(prcName);
//            var firstNextPrc =  $('#nextstep').find('input');
            var firstNextPrc =  $('#nextstep').find('.circle');
            var next1 = '';
            for(var i=0;i<firstNextPrc.length;i++){
                var nextPrcsId = firstNextPrc.eq(i).attr('nextPrcsId');
                next1 += nextPrcsId+',';
            }
//            $('#nextstep').find('input').eq(0).prop('checked','checked');
            console.log($('#nextstep .nofirest[datasnum=js]'))
            if($('#nextstep .nofirest[datasnum=js]').length == 0){
                $('#nextstep .nofirest[datasnum=kd]').eq(0).find('.circle').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                $('#nextstep .nofirest[datasnum=kd]').eq(0).find('.circle1').addClass('bags').attr('src','/img/widget_check2.png');
            }else{
                $('#nextstep .nofirest').eq(0).find('.circle').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                $('#nextstep .nofirest').eq(0).find('.circle1').addClass('bags').attr('src','/img/widget_check2.png');
            }
            buildUserByNextPrcId(next1);
        };
        function buildUserByNextPrcId(nextPrcsId){
            var firstNextPrc =  $('#nextstep').find('.circle').eq(0).attr('nextPrcsId');
            $.ajax({
                type: "get",
                url: "../../workflow/work/findbranch",
                dataType: 'JSON',
                data: {
                    flowId:flowId,
                    flowPrcs:nextPrcsId,
                    runId:runId,
                    currentFlowPrcs:prcsId
                },
                success: function (res) {
                    if(res.flag){
                        var userList = '';
                        var nextprcsid0 = $('#nextstep .nofirest').eq(0).find('.circle').attr('nextprcsid');
                        if(res.obj[firstNextPrc] && res.obj[firstNextPrc].prcsUserlist){
                            res.obj[firstNextPrc].prcsUserlist.forEach(function (v,i) {
                                userList += '<div class="all_select"><div class="main_2"><div class="r" style="font-size: 12px;margin-right: 10px;">主办</div> <div class="l" style="margin-right: 10px;"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle1"></div> <div class="l"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle"></div><div class="r"><span>'+v.userName+'&nbsp;'+v.userPrivName+'</span></div></div></div>'
                            });
                            var prcsUserlist = '<div id="prcsUserlist'+ $('#nextstep .nofirest').eq(0).find('.circle').attr('nextprcsid') +'"><div class="xz_bz">选择'+ $('#nextstep .nofirest').eq(0).find('.bz_name').text() +'步骤办理人员：</div>'+ userList +'</div>';
                            var num1 =  $('#nextstep').find('.circle');
                            for(var i=0;i<num1.length;i++){
                                var nextPrcsId = num1.eq(i).attr('nextPrcsId');
                                if(nextPrcsId != 0){
                                    $('.nofirest .circle[nextprcsid='+ nextPrcsId +']').attr('datas',JSON.stringify(res.obj[nextPrcsId].prcsUserlist)).parents('.nofirest').attr('autodata',JSON.stringify(res.obj[nextPrcsId].autoTypelist[0]));
                                }
                            }
                            if(globalData.flowProcesses.syncDeal == 0){
                                $('#prcsUserlist').append(userList);
                                nextprcsid0 = '';
                            }else if(globalData.flowProcesses.syncDeal == 1){
                                $('.main').append(prcsUserlist);
                            }else if(globalData.flowProcesses.syncDeal == 2){
                                $('.main').append(prcsUserlist);
                                var length = $('#nextstep .nofirest').length;
                                for(var i=1;i<length;i++){
                                    var prcsUserlist1 = '<div id="prcsUserlist'+ $('#nextstep .nofirest').eq(i).find('.circle').attr('nextprcsid') +'"><div class="xz_bz">选择'+ $('#nextstep .nofirest').eq(i).find('.bz_name').text() +'步骤办理人员：</div>'+ userList +'</div>';
                                    $('.main').append(prcsUserlist1);
                                    $('#nextstep .nofirest').eq(i).find('.circle').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                                    if($('#nextstep .nofirest').eq(i).attr('autodata') != undefined){
                                        $('#prcsUserlist'+ $('#nextstep .nofirest').eq(i).find('.circle').attr('nextprcsid') +' .circle[uid='+ JSON.parse($('#nextstep .nofirest').eq(i).attr('autodata')).uid +']').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                                        $('#prcsUserlist'+ $('#nextstep .nofirest').eq(i).find('.circle1').attr('nextprcsid') +' .circle[uid='+ JSON.parse($('#nextstep .nofirest').eq(i).attr('autodata')).uid +']').addClass('bags').attr('src','/img/widget_check2.png');

                                    }else{
                                        $('#prcsUserlist'+ $('#nextstep .nofirest').eq(i).find('.circle').attr('nextprcsid') +' .circle').eq(0).addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                                        $('#prcsUserlist'+ $('#nextstep .nofirest').eq(i).find('.circle1').attr('nextprcsid') +' .circle1').eq(0).addClass('bag').attr('src','/img/widget_check2.png');
                                    }
                                }
                            }
                            if($('#nextstep .nofirest').eq(0).attr('autodata') != undefined){
                                $('#prcsUserlist'+ nextprcsid0 +' .circle[uid='+ JSON.parse($('#nextstep .nofirest').eq(0).attr('autodata')).uid +']').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                                $('#prcsUserlist'+ nextprcsid0 +' .circle1[uid='+ JSON.parse($('#nextstep .nofirest').eq(0).attr('autodata')).uid +']').addClass('bags').attr('src','/img/widget_check2.png');
                            }else{
                                $('#prcsUserlist'+ nextprcsid0 +' .circle').eq(0).addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                                $('#prcsUserlist'+ nextprcsid0 +' .circle1').eq(0).addClass('bags').attr('src','/img/widget_check2.png');
                            }

                        }
//                        $('#nextstep .nofirest[datasnum=kd]').eq(0).click();
                        layer.closeAll();
                        $('#pro_turn').show();
                    }else{
                        alert('该流程无法获取到下一步步骤，请重新设置!')
                    }
                }
            });
        };
        turn = function(){
//            layer.load();
            var flag = true;
            if(globalData.checkTurnPriv ==1){

                if(globalData.flowProcesses.syncDeal == 1||globalData.flowProcesses.syncDeal == 2){         //允许并发//强制并发
                    var pId = [];
                    var pIds = [];
                    var beginUser = [];
                    var jingbanUser = [];

    //                $('#nextstep .bag').each(function(){
    //                    var prcsid = $(this).attr('nextprcsid');
    //                    pId.push(prcsid);
    //                    var bu = $('#prcsUserlist'+prcsid+' .bag').attr('userid');
    //                    if(bu == ''){
    //                        flag = false;
    //                    }
    //                    if(bu && bu.indexOf(',') > -1){
    //                        bu = bu.split(',')[0];
    //                    }
    //                    beginUser.push(bu);
    //                    jingbanUser.push(bu+',');
    //                });
                    $('#nextstep .bag').each(function(){
                        var prcsid = $(this).attr('nextprcsid');
                        pId.push(prcsid);
                        var bu = $('#prcsUserlist'+prcsid+' .bags').attr('userid');
                        if(bu == ''){
                            flag = false;
                        }
                        if(bu && bu.indexOf(',') > -1){
                            bu = bu.split(',');
                        }
                        beginUser.push(bu);
                    });

                    $('#nextstep .bag').each(function(){
                        var prcsid = $(this).attr('nextprcsid');
                        pIds.push(prcsid);
                        var bus=[]
                        $('#prcsUserlist'+prcsid+' .bag').each(function(){
                            bus.push ($(this).attr("userid"))
                        });
                        if(bus == ''){
                            flag = false;
                        }
                        if(bus && bus.indexOf(',') > -1){
                            bus = bus.split(',');
                        }
                        jingbanUser.push(bus+',');
                    });

                    beginUser = beginUser.join(',');
                    jingbanUser = jingbanUser.join('|');

                    var flowprcss = pId.join(',');
    //                var flowprcsss = pIds.join(',');
                    var nextprcsid = $('#nextstep .bag').eq(0).attr('nextprcsid') || '';
                }else{
                    //禁止并发
                    var jingbanUser = [];
                        var beginUser = $('#prcsUserlist .bags').attr('userid');
                        if(beginUser == ''){
                            flag = false;
                        }
                        var bus=[]
                        $('#prcsUserlist .bag').each(function(){
                            bus.push ($(this).attr("userid"))
                        });
                        if(bus == ''){
                            flag = false;
                        }
                        if(bus && bus.indexOf(',') > -1){
                            bus = bus.split(',');
                        }
                        jingbanUser.push(bus+',|');
                        jingbanUser = jingbanUser.join('');
                    beginUser = beginUser+',';


    //                var beginUser = $('#prcsUserlist .bag').eq(0).attr('userid')||'';
                    var nextprcsid = $('#nextstep .bag').eq(0).attr('nextprcsid') || '';
                    var flowprcss = $('#nextstep .bag').eq(0).attr('nextprcsid');
                    var flowprcsss = $('#nextstep .bag').eq(0).attr('nextprcsid');
    //                var jingbanUser = beginUser+',';
    //                console.log(nextprcsid)
                }
                if(globalData.topDefault == 1||globalData.topDefault == 2){
                    beginUser = "";
                }
                var smsType = '';
                if( !flag &&nextprcsid　!= '0'){
                    layer.msg('请选择流程办理人');
                    return false;
                }else{
                    $('.next_steps input[type=checkbox]').each(function(){
                        if($(this).is(':checked')){
                            smsType += $(this).val()+',';
                        }
                    });

                    var savedData ={
                        flowId:flowId,
                        runId:runId,
                        runName:globalData.flowRun.runName,
                        beginTime:globalData.flowRun.beginTime,
                        beginUser:beginUser,
                        prcsId:globalData.flowRunPrcs.prcsId,
                        prcsflag:1,
                        flowPrcs:flowprcss,
                        jingbanUser:jingbanUser,
                        tableName:tableName,
                        tabId:tabId,
                        flowStep:flowStep,
                        currentPrcsId:prcsId,
                        viewUser:'',
                        smsType:smsType,
                        orgAdd:'',
                        smsContent:'',
                        topDefault:globalData.topDefault
                    };
                    $.ajax({
                        type: "post",
                        url: "/workflow/work/saveWork",
                        dataType: 'JSON',
                        data: savedData,
                        success: function (obj) {
                            if(obj.flag){
                                window.location.href = 'zhuanjiaoh5?backType='+backType;

                            }
                        }
                    });
                }
            }else{
                layer.msg('经办人未办理完毕，无法转交');
            }

        };
        $('#turnBtn').click(function(){
            turn();

        })
        $(".main").on("click",'.circle',function(){
            if($(this).hasClass('bags1')){
                $(this).addClass('bag').attr('src','/img/widget_check2.png');
            }
            else if($(this).hasClass('bag')){
                $(this).removeClass('bag').attr('src','/img/widget_open.png');
            }else{
                $(this).addClass('bag').attr('src','/img/widget_check2.png');
            }
        });

        $(".main").on("click",'.circle1',function(){
            var par='#'+$(this).parent().parent().parent().parent().attr('id')
            $(''+par+' .circle1').parents('.all_select').find('.circle1').removeClass('bags').attr('src','/img/widget_open.png');
//            $(''+par+' .circle1').parent().siblings().find('.bags1').removeClass('bag').removeClass('bags1').attr('src','/img/widget_open.png');
            $(''+par+' .circle1').parent().siblings().find('.bag').removeClass('bags1')
            $(this).addClass('bags').attr('src','/img/widget_check2.png');
            $(this).parent().siblings().find('.circle').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
        });

    });
    function myTrim(x) {
        return x.replace(/^\s+|\s+$/gm,'');
    }
    function checkPrcIn(prcsIn,prcsInSet,formdata,fromDataReject,cb){
        var res = {
            flag:true,
            msg:''
        };
        if(prcsInSet != ""){
            var prcsInArr = prcsIn.split('\n');
            formdata = covertToFormData(formdata);

            prcsInArr.forEach(function(v,i){
                var check_pass = 0;
                var titleValue = '';
                if(v.indexOf("'") > -1){
                    var arr_rule = v.split("'");

                    var item_title = myTrim(arr_rule[1]);
                    var item_con = myTrim(arr_rule[2]);
                    var item_value = myTrim(arr_rule[3]);
                    titleValue = formdata[fromDataReject[item_title]];
                    check_pass = checkTileValue(titleValue,item_con,item_value);
                    var setitem =  '['+(i+1)+']'
                    prcsInSet = prcsInSet.replace(setitem,check_pass);
                }
            });
            prcsInSet = covertToPrcsOutSet(prcsInSet.toLowerCase());

            var result = eval(prcsInSet);

            if(result == 0){
                res.flag = false;
            }
        }
        if(cb){
            cb(res);
        }
    };
    function covertToFormData(formdata){
        var data = {};
        if(formdata instanceof Array){
            formdata.forEach(function(v,i){
                data[v.key] =  v.value;
            });
        }
        return data;
    }
    function covertToPrcsOutSet(data){
        data = data.replace(/or/g,'||')
        data = data.replace(/and/g,'&&')
        return data;
    }
    function checkPrcOut(formdata,fromDataReject,cb){
        var msg = globalData.conditionDesc.split('\n')[1];
        var res = {
            flag:true,
            msg:""
        };
        if(msg){
            res.msg = msg;
        }else{
            res.msg =  '<fmt:message code="main.th.NonConformity" />'
        }
        var prcsOut = globalData.prcsOut;
        var prcsOutSet = globalData.prcsOutSet;
        if(prcsOutSet != ""){
            var prcsOutArr = prcsOut.split('\n');
            formdata = covertToFormData(formdata);
            prcsOutArr.forEach(function(v,i){
                var check_pass = 0;
                var titleValue = '';
                var arr_rule = v.split("'");
                var item_title = myTrim(arr_rule[1]);
                var item_con = myTrim(arr_rule[2]);
                var item_value = myTrim(arr_rule[3]);
                titleValue = formdata[fromDataReject[item_title]];
                check_pass = checkTileValue(titleValue,item_con,item_value);
                var setitem =  '['+(i+1)+']'
                prcsOutSet = prcsOutSet.replace(setitem,check_pass);
            });

            prcsOutSet = covertToPrcsOutSet(prcsOutSet.toLowerCase());
            var result = eval(prcsOutSet);

            if(result == 0){
                res.flag = false;
            }
        }
        if(cb){
            cb(res);
        }
    };
    function checkTileValue(item_title,rule,item_value){
        var checkpass = 0;
        var item_title = parseInt(item_title) || item_title;
        var item_value = parseInt(item_value) || item_value;
        switch (rule) {
            case '=':
                if (item_title == item_value) {
                    checkpass = 1;
                }
                break;
            case '!=':
                if (item_title != item_value) {
                    checkpass = 1;
                }
                break;
            case '>':
                if (item_title > item_value) {
                    checkpass = 1;
                }
                break;
            case '<':
                if (item_title < item_value) {
                    checkpass = 1;
                }
                break;
            case '<=':
                if (item_title <= item_value) {
                    checkpass = 1;
                }
                break;
            case '>=':
                if (item_title >= item_value) {
                    checkpass = 1;
                }
                break;
            case 'include':
                if (item_value.indexOf(item_title) > -1) {
                    checkpass = 1;
                }
                break;
            case 'exclude':
                if (item_title.indexOf(item_value) == -1) {
                    checkpass = 1;
                }
                break;
        }
        return checkpass;
    }

    function ajax_info(a){
        var e = a.find('.circle');
        var bz_name = a.find('.bz_name').text();
        var nextprcsid = e.attr('nextprcsid');
        if(globalData.flowProcesses.syncDeal == 1){ //允许并发
            if(nextprcsid != 0){
                if(e.hasClass('bag')){
                    if(e.parents('#nextstep').find('.bag').length >1){
                        e.removeClass('bag').attr('src','/img/widget_open.png');
                        $('#prcsUserlist'+ nextprcsid +'').hide();
                    }
                }else{
                    e.addClass('bag').attr('src','/img/widget_check2.png');
                    if($('#prcsUserlist'+ nextprcsid +'').length != 1){
                        $('#panel-next-user').show();
                        $('.next_steps li').eq(0).show();
                        var data = JSON.parse(e.attr('datas'));
                        if(a.attr('autodata') != undefined){         //智能选人功能
                            var datas = JSON.parse(a.attr('autodata'));
                        }else{
                            var datas = '';
                        }
                        var userList = '';
                        data.forEach(function (v,i) {
                            userList += '<div class="all_select"><div class="main_2"><div class="r" style="font-size: 12px;margin-right: 10px;">主办</div> <div class="l" style="margin-right: 10px;"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle1"></div> <div class="l"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle"></div><div class="r"><span>'+v.userName+'&nbsp;'+v.userPrivName+'</span></div></div></div>'
                        });
                        var prcsUserlist = '<div id="prcsUserlist'+ nextprcsid +'"><div class="xz_bz">选择'+ bz_name +'步骤办理人员：</div>'+ userList +'</div>';
                        $('.main').append(prcsUserlist);
                        if(datas != ''){
                            $('#prcsUserlist'+ nextprcsid +' .circle[uid='+ datas.uid +']').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                            $('#prcsUserlist'+ nextprcsid +' .circle1[uid='+ datas.uid +']').addClass('bags').attr('src','/img/widget_check2.png');
                        }else{
                            $('#prcsUserlist'+ nextprcsid +' .circle').eq(0).addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                            $('#prcsUserlist'+ nextprcsid +' .circle1').eq(0).addClass('bags').attr('src','/img/widget_check2.png');
                        }
                    }else {
                        $('#prcsUserlist'+ nextprcsid +'').show();
                    }
                }
            }else{
                $('#panel-next-user').hide();
                $('.next_steps li').eq(0).hide();
                $('.next_steps li').eq(1).find('input').attr('checked',true);
            }
            $(a).siblings().children().children('#end').removeClass('bag').attr('src','/img/widget_open.png');

            $('#end').parent().parent().click(function(){
                if($(a).children().children('#end').hasClass('bag')){
                    $(a).children().children('#end').removeClass('bag').attr('src','/img/widget_open.png');
                }else {
                    $(a).children().children('#end').addClass('bag').attr('src','/img/widget_check2.png');
                    $(a).siblings().children().children('.circle').removeClass('bag').attr('src','/img/widget_open.png');

//                    $('#prcsUserlist'+ nextprcsid +' .circle[uid='+ datas.uid +']').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
//                    $('#prcsUserlist'+ nextprcsid +' .circle1[uid='+ datas.uid +']').addClass('bags').attr('src','/img/widget_check2.png');
                    $('#prcsUserlist'+ nextprcsid +'').hide();
                }
            })


        }else if(globalData.flowProcesses.syncDeal == 2){ //强制并发


        }else{                                                 //禁止并发
            e.addClass('bag').attr('src','/img/widget_check2.png').parents('.nofirest').siblings().find('.circle').removeClass('bag').attr('src','/img/widget_open.png');
            if(nextprcsid != 0){
                $('#panel-next-user').show();
                $('.next_steps li').eq(0).show();
                var data = JSON.parse(e.attr('datas'));
                if(a.attr('autodata') != undefined){
                    var datas = JSON.parse(a.attr('autodata'));
                }else{
                    var datas = '';
                }
                var userList = '';
                data.forEach(function (v,i) {
                    userList += '<div class="all_select"><div class="main_2"><div class="r" style="font-size: 12px;margin-right: 10px;">主办</div> <div class="l" style="margin-right: 10px;"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle1"></div> <div class="l"><img src="/img/widget_open.png" uname="" uid="'+v.uid+'" userId="'+v.userId+'" class="circle"></div><div class="r"><span>'+v.userName+'&nbsp;'+v.userPrivName+'</span></div></div></div>'
                });
                $('#prcsUserlist').html(userList);
                if(datas != ''){
                    $('#prcsUserlist .circle[uid='+ datas.uid +']').addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                    $('#prcsUserlist .circle1[uid='+ datas.uid +']').addClass('bags').attr('src','/img/widget_check2.png');
                }else{
                    $('#prcsUserlist .circle').eq(0).addClass('bag').addClass('bags1').attr('src','/img/widget_check2.png');
                    $('#prcsUserlist .circle1').eq(0).addClass('bags').attr('src','/img/widget_check2.png');
                }
            }else{
                $('#panel-next-user').hide();
                $('.next_steps li').eq(0).hide();
                $('.next_steps li').eq(1).find('input').attr('checked',true);
            }
        }

    };
    function ajax_info1(e){ //条件分支
        var msg = e.attr('msg') || '不符合条件！';'+ msg +'
        e.find('.r_s').html(msg).show();
        setTimeout(function(){
            e.find('.r_s').hide();
        },5000)
    }

</script>
</body>
</html>