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
    <title></title>
    <link rel="stylesheet" href="../../css/workflow/work/m/style.css">

    <style> 
        #basic_infor .table .td1{width: 130px;}
        #basic_infor .table .td1 div{min-height: 36px;}
        body{
            font-size: 14px;
        }
        .main2{background: #efefef;margin-top: 0px;}
        .file {
            position: relative;
            display: inline-block;
            background: #007df8;
            border: 1px solid #007df8;
            border-radius: 2px;
            padding: 0px 6px;
            overflow: hidden;
            color: #fff;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .uploadbox p{margin-bottom: 5px;color: #095de0;}
        #basic_infor .table .td1{width: 160px;}
        .done {
            height: auto;
            border-bottom: none;
            margin-bottom: 15px;
        }
        .type_done{border: none;background-color: #3984ff;padding: 13px 35px;font-size: 16px;margin-top: 20px;font-weight: bold}

    </style>
</head>
<body style="display: none">
<div class="head_top">
    <span  class="head_toptitle" style="color: #007cfd;font-style: italic;font-size: 15px;font-weight: 900;"><fmt:message code="workflow.th.liushui" />：<span id="flowRunId"></span></span>
    <ul>
        <li><span class="head_toptitle weight" id="flowName"><fmt:message code="workflow.th.processname" />：</span></li>
        <li><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiator" />：</span><span id="flowBeginUser" class="head_toptitle" style="font-weight: 600;    margin-left: 2px;"></span></li>
        <li><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiation" />：</span><span id="flowBeginTime" class="head_toptitle" style="font-weight: 600;    margin-left: 2px;"></span></li>
    </ul>
</div>
<div id="basic_infor">
    <div class="basic_infor_title">
        <img src="../../img/workflow/m/gapp_icon_no.png" alt="" class="icon">
        <div class="basic_infor"><fmt:message code="url.th.EssentialInformation" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div class="table">
        <table  id="content">
        </table>
    </div>
    <div class="done">
        <button class="type_done" id="lctbtn" style="padding: 13px 27px;margin-left: 27px;"><fmt:message code="workflow.th.chart" /></button>
    </div>
    <div class="basic_infor_title">
        <img src="../../img/workflow/m/gapp_icon_no.png" alt="" class="icon">
        <div class="basic_infor"><fmt:message code="work.th.CountersignedArea" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div class="signBox">
        <textarea rows="4" class="gapp_textarea" data-key="0" style="display: none" data-field-type="020000" data-must="0" data-is-write="1" name="COL101214452217682884218739" placeholder=""></textarea>
        <div class="hqbox" style="min-height: 40px;"></div>
    </div>
    <div class="basic_infor_title">
        <img src="../../img/workflow/m/gapp_icon_no.png" alt="" class="icon">
        <div class="basic_infor"><fmt:message code="email.th.file" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div >
        <ul class="uploadbox">

        </ul>
    </div>
    <div style="width: 100%;height: 24px;display: none" class="choose_box">

    </div>
    <div class="photo_box" style="padding: 5px;">

    </div>

</div>
<div class="lct" style="display: none">
    <div class="lct_title">
        <fmt:message code="workflow.th.chart" />
    </div>
    <div class="lct_body">
        <ul class="lct_info">
            <li><span class="head_toptitle weight" style="color:#0074ec;"><fmt:message code="workflow.th.SerialRegistration" /></span></li>
            <li><span class="head_toptitle weight" ><fmt:message code="workflow.th.HostedAdministrator" /></span><span class="head_toptitle" style="color: #73a282;margin-left: 2px;"><fmt:message code="workflow.th.second" /></span></li>
            <li><span class="head_toptitle weight" ><fmt:message code="workflow.th.StartedOn" />：</span><span class="head_toptitle" style="font-weight: 600;    margin-left: 2px;">2017-07-26 19:24</span></li>
        </ul>
    </div>
</div>
<script src="../../js/xoajq/xoajq1.js"></script>
<script src="../../js/template.js"></script>
<script src="../../lib/laydate/laydate.js"></script>
<script src="../../js/mustache.min.js"></script>
<script src="../../js/base/base.js"></script>
<script src="../../js/workflow/work/workform.js?20210423"></script>
<script type="text/javascript" src="../../js/workflow/work/writeSign.js?201907103"></script>
<%--<script src="../../js/workflow/work/m/workformh5PreView.js"></script>--%>
<script src="../../js/jquery/jquery.form.min.js" ></script>
<script src="../../js/jquery/jquery.cookie.js"></script>
<link rel="stylesheet" href="../../lib/kinggrid/dialog/artDialog/ui-dialog.css">
<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.css">

<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.min.js"></script>
<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.plus.min.js"></script>
<script type="text/javascript" src="../../lib/kinggrid/dialog/artDialog/dialog.js"></script>

<!-- html签章核心JS -->
<script type="text/javascript" src="../../lib/kinggrid/signature.min.js"></script>
<!-- PC端附加功能 -->
<script type="text/javascript" src="../../lib/kinggrid/signature.pc.min.js"></script>
<!-- 移动端端附加功能 -->
<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.mobile.css">
<script type="text/javascript" src="../../lib/kinggrid/signature.mobile.min.js"></script>
<script>
    function ready(){
        //alert(1111);
    }
    function anios(e){
        var url = e.attr('url');
        var name = e.attr('name');
//        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//            overLookFile(url,name);
//        } else if (/(Android)/i.test(navigator.userAgent)) {
//            Android.overLookFile(url,name);
//        }
    }
    $(function () {
        //imgadd('/xs?AID=5124&MODULE=workflow&COMPANY=xoa1001&YM=1708&ATTACHMENT_ID=407195972&ATTACHMENT_NAME=1503645688962.jpg,/xs?AID=5124&MODULE=workflow&COMPANY=xoa1001&YM=1708&ATTACHMENT_ID=407195972&ATTACHMENT_NAME=1503645688962.jpg,','1503645688962.jpg,1503645688962.jpg','1');
        function auto() {
            var width = $('#word').width() / 2;
            $('#word .table td').css('width', '' + width + '');
            var width1 = width - 62;
            $('#word .action').css('width', '' + width1 + '');
        }

        function dateclick(e) {
            laydate({
                elem: '#' + $(e).attr('target'),
                format: 'YYYY-MM-DD hh:mm:ss'
            });
        }

        function uploadimg(data) {
            $('#picture').val(data);
            $('#picture').attr('value', data);
        }

        $('#fileUpload').change(function () {
            var e = this;
            $('#uploadForm').ajaxSubmit({
                dataType:'json',
                success:function (res) {
                    if(res.msg == 'OK'){
                        if( res.obj[0].isImage ==0){
                            readURL(e);
                        }else{
                            url = res.obj[0].attUrl;
                    //        console.log(url);
                            var str = '<li><a href="#"><span>'+ res.obj[0].attachName+'</span></a></li>';
                            $('.uploadbox').append(str);
                        }
                    }

                }
            })
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {

                        var img = '<img id="blah" src="'+e.target.result+'" alt="<fmt:message code="workflow.th.DisplayUploaded" />" style="width:50px;height:50px;">';
                        $('.photo_box').append(img);
                    }

                    reader.readAsDataURL(input.files[0]);

                }
            }
        });
    });


    var globalData = {};
    var turn = function(){
        alert("正在加载。。");
    }

    $(function () {
        layer.load();
        $('body').show();
        globalData.flowId = $.getQueryString("flowId");
        globalData.flowStep = $.getQueryString("flowStep") || '';
        globalData.prcsId = $.getQueryString("prcsId") || '';
        globalData.runId = $.getQueryString("runId") || '';
        globalData.tableName = $.getQueryString("tableName") || '';
        globalData.tabId =  $.getQueryString("tabId") || '';
        //alert(globalData.runId);
        var workformh5 = {
            init:function (cb) {
                var _this = this;

                workForm.init({
                        formhtmlurl:'../../workflow/work/workfastAdd',//URL
                        resdata:{
                            flowId:globalData.flowId,
                            runId:globalData.runId,
                            prcsId:globalData.prcsId,
                            flowStep:globalData.flowStep
                        },
                        flowStep:globalData.prcsId,//预览
                        target:'.cont_form',
                        preView:true,
                        ish5:true
                    },
                    function (data,option,target) {

                        globalData.flowRun = data.object.flowRun;
                        globalData.listFp = data.object.listFp;
                        globalData.flowRunPrcs = data.object.flowRunPrcs;
                        globalData.option = option;
                        globalData.flowTypeModel = data.object.flowTypeModel;
                        globalData.attachPriv = data.object.attachPriv;
                        globalData.allowBack = data.object.allowBack;
                        globalData.flowPrcs = data.object.flowRunPrcs.flowPrcs;
                        globalData.signlock = data.object.signlock;

                        if(globalData.signlock == 1){
                            $('.gapp_textarea').attr("disabled",true);
                        }
                        var runid = data.object.flowRun.runId;
                        if(globalData.allowBack != 0){
                            $('#backBtn').show();
                        }
                        $('#backBtn').click(function () {
                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                try{
                                    window.webkit.messageHandlers.rightTitle.postMessage({'title':'转交','name':'审批及转交','function':'feedback'});
                                }catch(err){
                                    rightTitle('转交','审批及转交','feedback');
                                }
                            } else if (/(Android)/i.test(navigator.userAgent)) {
                                //alert(navigator.userAgent);
                                Android.rightTitle('转交','xxxxx','feedback');
                            }
                            window.location.href='feedback?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId+'&allowback='+globalData.allowBack;
                        });
                        $.ajax({
                            type: "get",
                            url: "/workflow/work/findworkUpload",
                            dataType: 'JSON',
                            data: {
                                runId:runid
                            },
                            success: function (obj) {
                                var data = obj.obj;
                                var img = '';
                                var names = '';
                                for(var i=0;i<obj.obj.length;i++){
                                    var pic_name = obj.obj[i].attachName;
                                    var index = pic_name .lastIndexOf("\.");
                                    var pic_name = pic_name.substring(index + 1, pic_name .length);
                                    var http = 'http://'+ window.location.host;
                                    if(pic_name == "png"||pic_name == "jpeg"||pic_name == "bmp"||pic_name == "jpg"){
                                        img += '<img id="blah" src="/xs?'+ obj.obj[i].attUrl +'" onclick="anios($(this))" style="width:50px;height:50px;margin-right: 10px;margin-bottom: 10px;" url="'+ http + '/xs?'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'">';
                                    }else{
                                        names += '<a href="'+ http + '/download?'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'" onclick="anios($(this))">'+ obj.obj[i].attachName +'</a>'
                                    }
                                }
                                if(names == ''){
                                    $('.uploadbox').hide();
                                }
                                $('.photo_box').append(img);
                                $('.uploadbox').append(names);
                            }
                        });

                        $.ajax({
                            type: "get",
                            url: "/workflow/work/findworkfeedback",
                            dataType: 'JSON',
                            data: {
                                prcsId:globalData.prcsId,
                                signlock: globalData.signlock,
                                flowPrcs:globalData.flowPrcs,
                                runId:runid
                            },
                            success: function (obj) {
                                var str = '';
                                for(var i=0;i<obj.obj.length;i++){
                                    str +=  '<div style="text-align: left;margin: 0 12px;margin-top: 10px;">' +
                                        '<span style="display: block;margin-bottom: 5px;font-size: 13px;">'+obj.obj[i].users.userName+'：</span>' +
                                        '<span style="color: #919191;display: block;margin-bottom: 5px;">'+obj.obj[i].editTime+'</span>' +
                                        '<span style="display: block;font-size: 12px;">'+obj.obj[i].content+'</span>' +
                                        '</div>'
                                }
                                $('.hqbox').html(str);
                            }
                        });

                        $('#flowName').text(data.object.flowRun.runName);
                        $('#flowBeginUser').text(data.object.flowRun.userName);
                        $('#flowBeginTime').text(data.object.flowRun.beginTime);
                        $('#flowRunId').text('No.'+data.object.flowRun.runId);

                        _this.buildBody(target);
                        _this.buildEvent();
                        cb();
                    });

            },
            turnH5Btn:function(){
                var _this = this;
                _this.saveFlowData(function(res){
                    if(res.flag){
                        var content = $('.signBox .gapp_textarea').val();
                        if(content != ''){
                            $.ajax({
                                type: "get",
                                url: "../../workflow/work/workfeedback",
                                dataType: 'JSON',
                                data: {
                                    prcsId:globalData.prcsId,
                                    runId:globalData.flowRun.runId,
                                    flowPrcs:globalData.flowPrcs,
                                    content:content,
                                    file:''
                                },
                                success: function(res){
                                }
                            })
                        }
                        window.location.href='turnh5?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId;


                    }

                });
            },
            buildEvent:function () {
                var _this = this;
                $('#lctbtn').click(function () {
                    // /flowSetting/processDesignToolTwo?flowId=141&rilwId=1381
                    window.location.href="/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId;
                });
                $('#turnBtn').click(function () {
                    _this.turnH5Btn();
                });

                $('#saveBtn').click(function () {

                    _this.saveFlowData(function(res){
                        if(res.flag){
                            alert("保存成功")
                        }else{
                            alert("保存失败")
                        }

                    });
                });
                $('#deleteBtn').click(function () {
                    alert('删除成功！');
                });
            },
            saveFlowData:function (cb) {
                var flowfun = globalData.flowRun;
                var form_item=$('#content .form_item');
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
                        value=obj.attr('title');
                    }else if(datatype=="macros"){
                        if(obj.attr('type') == "text"){
                            if(obj.attr('datafld')=='SYS_USERNAME'&&obj.attr('orgsignImg')==1){
                                if(obj.attr('signSrc')!=undefined&&obj.attr('signSrc')!=''){
                                    value = obj.attr('signSrc')
                                }else{
                                    value = ''
                                }
                            }else{
                                value= obj.val();
                            }

                        }else{
                            value = obj.val() == 0?'':form_item.eq(i).val();
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
                    }else if(datatype == "imgupload"){

                        $('img[name='+name+']').each(function(i,v){
                            var url = $(v).attr('src');
                            if(url!='/img/icon_uploadimg.png'){
                                value+= (url+',');
                            }
                        })

                    }else{
                        value = obj.val();
                    }

                    if(ismust == 'true' && value == ""){
                        flag = true;
                        layer.msg('请填写'+obj.attr('title'), {icon: 1});
                        break;
                    }
                    if( value!=null){
                        baseData["key"]=key;
                        baseData["value"]=value;
                        realData.push(baseData);
                    }
                    if(value != ''){
                        modifydata.push(baseData);
                    }
                }
                if(!flag){
                    var fdata={
                        flowId:globalData.flowId,
                        formdata:JSON.stringify(realData),
                        runId:globalData.flowRun.runId,
                        runName:globalData.flowRun.runName,
                        beginTime:globalData.flowRun.beginTime,
                        beginUser:globalData.flowRun.beginUser,
                        formLength:globalData.option.formLength,
                        prcsId : globalData.prcsId,
                        flowPrcs : globalData.flowPrcs,
                        modifydata:JSON.stringify(modifydata),
                        fromDataReject:JSON.stringify(globalData.fromDataReject),
                        tableName:globalData.tableName,
                        tabId:globalData.tabId
                    };
                    $.ajax({
                        type: "post",
                        url: "../../workflow/work/nextwork",
                        dataType: 'JSON',
                        data: fdata,
                        success: function(res){
                            // alert(res.msg);
                            var data ={};
                            if(cb){
                                if(res.flag){
                                    data.flag = true;
                                }else{
                                    data.flag = false;
                                }
                                data.data = res.obj;
                                cb(data)
                            }
                        }
                    });
                }
            },
            buildBody : function(data){
                var _this = (this);
                var target = data;
                var dataList = data.find('.form_item');
                var preObj = '';
                var tableObj = [];
                dataList.each(function(i,v) {
                    var __this = $(this);
                    var dataType = __this.attr('data-type');
                    var title = __this.attr('title');
                    var name = __this.attr('name');
                    var isMust = __this.attr('isMust');
                    var isMustText = '';
                    if(isMust){
                        isMustText = '<span style="color:red;">&nbsp;*</span>';
                    }

                    var eleTrObj = $('<tr><td class="td1"><div>' + title + isMustText + '</div></td><td class="td2"></td></tr>');
                    var e = {};
                    var val = "";
                    switch (dataType) {
                        case 'text':
                            // __this.addClass("gapp_input gapp_form");
                            // __this.attr("style",'');
                            val = __this.val();
                            __this.remove();
                            break;
                        case 'textarea':
                            // __this.addClass("gapp_textarea");
                            // __this.attr("style",'');
                            val = __this.val();
                            __this.remove();
                            break;
                        case 'select':
                            __this.addClass("gapp_select gapp_form");
                            __this.attr("style",'');
                            val = __this.val();
                            __this.remove();
                            break;
                        case 'radio':

                            break;
                        case 'checkbox':

                            break;
                        case 'macros':

                            val = __this.val();
                            __this.remove();
                            break;
                        case 'calendar':

                            val = __this.val();
                            __this.remove();
                            break;
                        case 'imgupload':
                            data.find('img[name="'+name+'"]').each(function (i,v) {
                                if($(v).attr("src")!='/img/icon_uploadimg.png'){
                                    eleTrObj.find('.td2').append(v);
                                }else{
                                    __this.attr("onclick",'phoneimgupload(this);')
                                }
                            });
                            break;
                        case 'autocode':
                            __this.addClass('gapp_input gapp_form');
                            __this.attr('readonly',"readonly");
                            var targetid =  __this.attr('id')
                            eleTrObj.find('.td2').append(__this.val());
                            break;
                        case 'kgsign':
                        //    console.log(__this);
                            $(__this.find("img").get(0)).attr("style","cursor: pointer; margin: 0 auto;width:100%;height:100%;")
                            eleTrObj.find('.td2').append(__this);

                            break;
                        default:

                    }

                    eleTrObj.find('.td2').append(val);
                    tableObj.push(eleTrObj);
                    $('#content').append(tableObj);
                    globalData.fromDataReject = _this.buildFormData();
                });
            },
            buildFormData : function(){
                var arr = {};
                $("#content").find('.form_item').each(function(i,v){
                    var _this = $(this);
                    arr[_this.attr('title')] = _this.attr('name');
                });
                return arr;
            },
            tool:{
                ajaxHtml:function (url,data,cb) {
                    var that = this;
                    $.ajax({
                        type: "get",
                        url: url,
                        async:false,
                        dataType: 'JSON',
                        data:  data,
                        success: function (res) {
                            if(cb){
                                cb(res);
                            }
                        },
                        error:function(e){
                        }
                    });
                }
            }
        }
        workformh5.init(function(){
            turn = function(){
                workformh5.turnH5Btn();
            }
        });
    });
</script>
</body>
</html>