<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String runId = request.getParameter("runId");
    String flowId = request.getParameter("flowId");
    String tableName = request.getParameter("tableName");
    String tabId = request.getParameter("tabId");
%>
<!DOCTYPE html>
<html>
<head >
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title></title>
    <link rel="stylesheet" href="../../css/workflow/work/m/style.css">
    <style>
        #laydate_box{
            left: 99px !important;
        }
        body{
            font-size: 12px;
            font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
        }
        .ui-dialog{
            margin-left: 0px !important;
            margin-top: -50px !important;
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
        .grey{
            color: #333!important;
        }
        .grey1{
            color: #333!important;
        }
        table{
            border-collapse: inherit;
        }
        .gapp_input {
            height: 45px;
            margin-left: 0px;
            border-width: 0px;
            width: 100%;
            border: 1px solid #e4e4e4;
            border-radius: 4px;
            text-indent: 10px;
        }
        .type_done{border: none;background-color: #3984ff;padding: 13px 35px;font-size: 16px;margin-top: 20px;font-weight: bold}
        #deleteBtn{background-color: #ec5959}
        .done{height: auto;border-bottom:none;margin-bottom: 15px;}
        .head_toptitle{font-size: 14px;height: 14px;line-height: 14px}
        .head_top{
            height: 98px;
            border-top: none;
            padding: 0 16px;
        }
        #basic_infor .table{
            padding-left: 16px;
            padding-right: 16px;
            padding-bottom: 20px;
        }
        #basic_infor .table .td1{
            position: relative;
            width: 110px;
        }
        #basic_infor .table .td1 div{
            min-height: 36px;
            margin: 12px 0 0 0;
            line-height: 36px;
            border-right: none;
        }
        #basic_infor .table .td2 {
            position: relative;
            line-height: 36px;
            padding-left: 10px;
            padding-right: 5px;
            padding-top: 12px;
            padding-bottom: 0;
        }
        @media screen and (min-width: 321px) and (max-width:360px){
            #lctbtn{
                margin-left: 20px!important;
                padding: 13px 24px!important;
            }
            #deleteBtn{
                margin-left: 20px!important;
            }
            #backBtn{
                margin-left: 20px!important;
            }
            .type_done{
                margin-left: 9px;
                padding: 13px 32px;
            }
        }
        @media screen and (max-width: 320px){
            #lctbtn{
                padding: 13px 19px!important;
                margin-left: 22px!important;
            }
            #deleteBtn{
                margin-left: 22px!important;
            }
            #backBtn{
                margin-left: 22px!important;
            }
            .type_done{
                padding: 12px 26px;
                font-size: 15px;
            }
        }
        .td2 img{
            float: left;
            width: 58px;
            height: 58px;
            margin: 0!important;
        }
        .td2 .qrcode img{
            float: left;
            width: 100%;
            height: 100%;
        }
        .head_top{
            margin-top: 14px;
        }
        .weight{
            font-weight: 300;
        }
        .head_top ul li span{
            letter-spacing: 1px;
        }
        #basic_infor .basic_infor_title{
            background: #f5f5f9;
            height: 32px;
            padding: 0 16px;
        }
        #basic_infor .basic_infor_title .basic_infor{
            margin-left: 6px;
            line-height:32px;
        }
        #basic_infor .basic_infor_title .icon{
            margin-top: 8px;
            height: 16px;
            width: auto;
        }
        #content input,#content textarea,#content select{
            border:1px solid #e4e4e4!important;
            font-size: 16px;
font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
            -webkit-appearance: none;
            /*background-color: #fffde9;*/
            background-color: #fff9c1;
        }
        #content input[data-type="checkbox"]{
            -webkit-appearance: checkbox;
            background: #fff!important;
            opacity: 0;
        }
        #content input[data-type="radio"]{
            -webkit-appearance: radio;
            background: #fff!important;
        }
        #content input.grey,#content textarea.grey{
            background: #f8f8f8!important;
        }
        textarea{
            padding: 10px 0;
        }
        input:disabled,textarea:disabled{
            opacity:1;
        }
        .gapp_textarea{
            border: 1px solid #e4e4e4;
            border-radius: 4px;
            padding:10px;
            margin-top: 10px;
            margin-bottom: 0;
            margin-left: 0px;
            box-sizing: border-box;
        }
        .hqbox{
            margin-bottom: 10px;
        }
        input[data-type="calendar"]{
            height:45px!important;
            background: url("/img/workflow/work/workformh5/calendar1.png") no-repeat 95% 12px;
        }
        input[type="radio"],input[type="checkbox"] {
            width: 20px;
            height: 20px;
        }
        label {
            position: absolute;
            left: 9px;
            top: 15px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 1px solid #e4e4e4;
            background: #fff;
        }

        /*设置选中的input的样式*/
        /* + 是兄弟选择器,获取选中后的label元素*/
        input:checked+label {
            background-color: #fe6d32;
            border: 1px solid #fe6d32;
        }

        input:checked+label::after {
            position: absolute;
            content: "";
            width: 5px;
            height: 10px;
            top: 3px;
            left: 6px;
            border: 2px solid #fff;
            border-top: none;
            border-left: none;
            transform: rotate(45deg)
        }
        .gapp_select{
            height: 45px;
            margin-left: 0px;
            border: 1px solid #e4e4e4;
            border-radius: 4px;
            text-indent: 10px;
            background: url("/img/workflow/work/workformh5/selecthei.png") no-repeat 95% 12px;
        }
        .gapp_textarea{
            height: 130px;
        }
        .textareaclass{
            position: absolute;
            top: 0;
        }
        .fl{
            float: left;
        }
        .bgweijinyong{
            /*background:#fffde9;*/
            background:#fff9c1;
        }
        .bgyijingyong{
            background:#f8f8f8;
        }
        .uploadbox{
            font-size: 11pt;
        }
        .autospan{
            color: cornflowerblue;
            position: absolute;
            top: 13px;
            right: 4px;
            height: 40px;
            display: inline-block;
            height: 45px;
            line-height: 45px;
            z-index: 1001;
            background: #fff9c1;
            padding: 0 6px;
        }

        .topleft,.topright,.bottomleft,.bottomright{
            width:50%;
            height:50%;
            position:absolute;
        }
        .topleft{
            /*background-color:red;*/
            top:0;
            left:0;
        }
        .topright{
            /*background-color:green;*/
            top:0;
            right:0;
        }
        .bottomleft{
            /*background-color:blue;*/
            bottom:0;
            left:0;
        }
        .bottomright{
            /*background-color:yellow;*/
            bottom:0;
            right:0;
        }

    </style>
</head>
<body style="display: none">
<div class="head_top">
    <span class="head_toptitle" style="color: #3682e1;font-size: 18px;font-weight: 900;"><span style="letter-spacing: 1px;"><fmt:message code="workflow.th.liushui" />&nbsp;</span><span id="flowRunId"></span></span>
    <ul style="margin-top: 10px;color: #333;font-weight: 300;">
        <li><span class="head_toptitle weight" id="flowName"><fmt:message code="workflow.th.processname" />：</span></li>
        <li style="margin-top: 7px"><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiator" />：</span><span id="flowBeginUser" class="head_toptitle" style="margin-left: 2px;"></span></li>
        <li style="margin-top: 7px"><span class="head_toptitle weight" ><fmt:message code="workflow.th.ProcessInitiation" />：</span><span id="flowBeginTime" class="head_toptitle" style=" margin-left: 2px;"></span></li>
    </ul>
</div>
<div id="basic_infor">
    <div class="basic_infor_title">
        <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
        <div class="basic_infor" style="font-size: 16px;color: #333;margin-left: 6px;font-weight: 300"><fmt:message code="url.th.EssentialInformation" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div class="table">
        <table  id="content" style="font-size: 16px;">
        </table>
    </div>
    <div class="done">
        <button class="type_done" id="lctbtn" style="padding: 13px 27px;margin-left: 20px;"><fmt:message code="workflow.th.chart" /></button>
        <button class="type_done" id="saveBtn"><fmt:message code="global.lang.save" /></button>
        <button class="type_done" id="turnBtn" style="  margin-left: 10px;"><fmt:message code="workflow.th.Transfer" /></button>
        <button class="type_done" id="endturnBtn" style="  margin-left: 10px;padding: 13px 20px;display: none;">办理完毕</button>
        <button class="type_done" style="display: none;"><fmt:message code="workflow.th.Entrust" /></button>
        <button class="type_done" id="deleteBtn"  style="margin-left: 20px;"><fmt:message code="menuSSetting.th.deleteMenu" /></button>
        <button class="type_done" id="backBtn" style="background-color: #ec5959;display: none;margin-left: 20px;"><fmt:message code="workflow.th.backbtn" /></button>
    </div>
    <!-- 会签意见区-->
    <div class="basic_infor_title">
        <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
        <div class="basic_infor" style="font-size: 16px;color: #333;margin-left: 6px;font-weight: 300"><fmt:message code="work.th.CountersignedArea" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>

    <div class="signBox">
        <textarea rows="4" id="signText" class="gapp_textarea" data-key="0" data-field-type="020000" data-must="0" data-is-write="1" name="COL101214452217682884218739" placeholder=""></textarea>
        <div class="hqbox"></div>
    </div>
    <%--<div class="basic_infor_title">--%>
    <%--<img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">--%>
    <%--<div class="basic_infor"><fmt:message code="email.th.file" /></div>--%>
    <%--<div class="basic_infor_title_link">--%>
    <%--<a href="#"></a>--%>
    <%--</div>--%>
    <%--</div>--%>

    <div class="basic_infor_title">
        <img src="/img/workflow/work/workformh5/leftpng.png" alt="" class="icon">
        <div class="basic_infor" style="font-size: 16px;color: #333;margin-left: 6px;font-weight: 300"><fmt:message code="email.th.file" /></div>
        <div class="basic_infor_title_link">
            <a href="#"></a>
        </div>
    </div>
    <div style="padding-bottom: 8px;">
        <ul class="uploadbox" style="">

        </ul>
        <div class="photo_box" style="margin: 20px;">

        </div>
    </div>
    <div style="width: 100%;height: 45px;" class="choose_box">

        <div style="width: 100%;text-align: center;position: relative">

            <%--<img class="choosewj" src="/img/workflow/work/choose_img.png" alt="" onclick="btn1()" style="height:46px;width: 100%;margin-bottom: 40px">--%>
            <span class="xzbtn" style="padding: 13px 80px;background: #3984ff;font-size: 16px;font-weight: bold; border-radius: 2px;color:#fff;">选择文件</span>
                <form id="uploadimgform" target="uploadiframe" action="/workflow/work/workUpload?module=workflow&runId=<%=runId%>" class="xzbtn" enctype="multipart/form-data" method="post">
                    <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="    position: absolute;top: -12px;opacity: 0;left: 50px;padding: 11px 0px;
                            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                    <a id="" style="cursor: pointer;"></a>
                </form>
        </div>

        <div>


            <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
            </div>

        </div>
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
<script src="/lib/layer/layer.js?20201106"></script>
<%--<script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>--%>
<%--<script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>--%>
<%--<script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>--%>
<%--无主办会签问题--%>
<script src="../../js/base/workformbase.js"></script>
<script src="../../js/workflow/work/workform.js?20210423.3"></script>
<script src="../../js/workflow/work/m/H5websign_main.js?20190516.1"></script>
<script src="../../js/workflow/work/m/workformh5.js?20190705.2"></script>
<%--无主办会签问题--%>
<script src="../../js/base/workformbase.js"></script>
<script src="../../js/jquery/jquery.form.min.js" ></script>
<script src="../../js/jquery/jquery.cookie.js"></script>
<script src="../../lib/qrcode.js"></script>
<!-- 金格签章 begin -->
<script src="/lib/layer/layer.js?20201106"></script>
<script src="/lib/jSignature-master/libs/modernizr.js?20190709"></script>
<script src="/lib/jSignature-master/libs/jSignature.min.noconflict.js?20190709"></script>
<script type="text/javascript" src="/js/workflow/work/writeSign.js?201907103"></script>

<link rel="stylesheet" href="../../lib/kinggrid/dialog/artDialog/ui-dialog.css">
<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.css">
<link rel="stylesheet" type="text/css" href="../../css/workflow/m_reset.css">
<link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">

<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.min.js"></script>
<script type="text/javascript" src="../../lib/kinggrid/core/kinggrid.plus.min.js"></script>
<script type="text/javascript" src="../../lib/kinggrid/dialog/artDialog/dialog.js"></script>

<!-- html签章核心JS -->
<script type="text/javascript" src="../../lib/kinggrid/signature.min.js"></script>
<!-- PC端附加功能 -->
<%--<script type="text/javascript" src="../../lib/kinggrid/signature.pc.min.js"></script>--%>
<!-- 移动端端附加功能 -->
<link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.mobile.css">
<script type="text/javascript" src="../../lib/kinggrid/signature.mobile.min.js"></script>
<%--<script src="/js/base/vconsole.min.js"></script>--%>
<script type="text/javascript" src="../../lib/kinggrid/signature_pad.min.js"></script>
<script type="text/javascript" src="../../lib/kinggrid/jquery.timer.dev.js"></script>
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
    var opFlag = $.getQueryString("opFlag");
    var runId = $.getQueryString("runId");
    var prcsId = $.getQueryString("prcsId");
    var flowPrcs = $.getQueryString("flowPrcs");


    $(function(){
        if(opFlag==0){
            $('#turnBtn').css('display','none')
            $('#endturnBtn').css('display','inline-block')
        }
        $('#endturnBtn').click(function(){
            $.ajax({
                type:'post',
                url:'/workflow/work/saveHandle?flowId=<%=flowId%>&tableName=<%=tableName%>&tabId=<%=tabId%>',
                data:{
                    runId:runId,
                    prcsId:prcsId,
                    flowPrcs:flowPrcs
                },
                dataType:'json',
                success:function(){
                    window.location.href = 'zhuanjiaoh5?backType='+backType;
                }
            })
        })
    })

    $.fn.ImgZoomIn = function () {
        bgstr = '<div id="ImgZoomInBG" style="background:#000000; filter:Alpha(Opacity=70); opacity:0.7; position:fixed; left:0; top:0; z-index:10000; width:100%; height:100%; display:none;"><iframe src="about:blank" frameborder="5px" scrolling="yes" style="width:100%; height:100%;"></iframe></div>';
//alert($(this).attr('src'));
        imgstr = '<img id="ImgZoomInImage" src="' + $(this).attr('src')+'" onclick=$(\'#ImgZoomInImage\').hide();$(\'#ImgZoomInBG\').hide(); style="cursor:pointer; display:none; position:absolute; z-index:10001;width: 100%;" />';
        if ($('#ImgZoomInBG').length < 1) {
            $('body').append(bgstr);
        }
        if ($('#ImgZoomInImage').length < 1) {
            $('body').append(imgstr);
        }
        else {
            $('#ImgZoomInImage').attr('src', $(this).attr('src'));
        }
//alert($(window).scrollLeft());
//alert( $(window).scrollTop());
        $('#ImgZoomInImage').css('left', $(window).scrollLeft() + ($(window).width() - $('#ImgZoomInImage').width()) / 2);
        $('#ImgZoomInImage').css('top', $(window).scrollTop() + ($(window).height() - $('#ImgZoomInImage').height()) / 2);
        $('#ImgZoomInBG').show();
        $('#ImgZoomInImage').show();
    };
    $(document).ready(function () {
        $("#imgTest").bind("click", function () {
            $(this).ImgZoomIn();
        });
    });


    function imgShow(outerdiv, innerdiv, bigimg, _this){
        var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
        $('#outerdiv').attr('display','block');
        $(bigimg).attr("src", src);//设置#bigimg元素的src属性
        $(outerdiv).fadeIn("fast");

        $(outerdiv).click(function(){//再次点击淡出消失弹出层
            $(this).fadeOut("fast");
        });
    }

    $('#uploadinputimg').fileupload({
        dataType:'json',
        done: function (e, data) {
            if(data.result.obj != ''){
                var data = data.result.obj;
                var str = '';
                var str1 = '';
                for (var i = 0; i < data.length; i++) {
                    var gs = data[i].attachName.split('.')[1];
                    if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                        str += '';
                        layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                            layer.closeAll();
                        });
                    }else{
//                        var attname = data[i].aid+'@'+data[i].ym+'_'+data[i].attachId
//                        attachmentId+=attname+','
//                        attachmentName+=data[i].attachName+'*'

                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                }
                $('.uploadbox').append(str);
            }else{
                //alert('添加附件大小不能为空!');
                layer.alert('添加附件大小不能为空!',{},function(){
                    layer.closeAll();
                });
            }
        }
    });


    /**********************与移动端对接webview的初始化调用函数*****************************/
    function ready(){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.rightTitle.postMessage({'title':'<fmt:message code="workflow.th.Transfer" />','name':'321','function':'turn'});
            }catch(err){
                rightTitle('<fmt:message code="workflow.th.Transfer" />','321','turn');
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            //alert(navigator.userAgent);
            Android.rightTitle('<fmt:message code="workflow.th.Transfer" />','321','turn');
        }
    }
    /**********************结束*****************************/
    /**********************与移动端交互 调用移动端选取文件的方法*****************************/
    function btn1(){
        $('.choosewj').attr('src','/img/workflow/work/choose_imgclick.png')
        btn('imgadd1',0)

    }
    function btn(cb,num){
//        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//            //alert(navigator.userAgent);
//            addImage(cb,num);
//        } else if (/(Android)/i.test(navigator.userAgent)) {
//            //alert(navigator.userAgent);
//            Android.addImage(cb,num);
//        }
        $('.choosewj').attr('src','/img/workflow/work/choose_img.png')
    }
    function imgadd1(img,name,type){
        var arr = img.split(',');
        var name_arr = name.split(',');

        if(type == 1){
            var img = '';
            for(var i=0;i<arr.length -1;i++){
                var url =  arr[i];

                img += '<img id="blah"  src="'+ arr[i] +'" class="exampleImg"  onClick="$(this).ImgZoomIn()" onclick="anios($(this))" style="width:50px;height:50px;margin-right: 10px;margin-bottom: 10px;" url="'+url +'" name="'+ name_arr[i] +'">';
            }
            $('.photo_box').append(img);
        }else{
            var name_str = '';
            for(var i=0;i<name_arr.length -1;i++){
                var url = arr[i];
                name_str += '<p onclick="anios($(this))" url="'+url+'"  name="'+ name_arr[i] +'">'+ name_arr[i] +'</p>'
            }
            $('.uploadbox').css('min-height', '50px')
            $('.uploadbox').append(name_str);
        }
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
    function anios1(e){
        var url = e.attr('url');
        var name = e.attr('names');
//        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//            overLookFile(url,name);
//        } else if (/(Android)/i.test(navigator.userAgent)) {
//            Android.overLookFile(url,name);
//        }
    }
    /**********************结束*****************************/
    /**********************与移动端交互 页面加载后 将附件的图片添加 初始化页面附件查看方式*****************************/
    imptarget = '';
    function phoneimgupload(e) {
        imptarget = $(e);
        if($(e).attr('src') == '/img/fileupload.png'){
            btn("imgupload4",2)
        }else{
            btn("imgupload3",1)
        }
    }
    function imgupload3(img,name,type){
        var url = img.split(',')[0];
        var names = name.split(',')[0];
        var listStr = '<img name="'+imptarget.attr('name')+'" names="'+names+'" onclick="anios1($(this))" src="'+url+'" url="'+url+'" style="cursor: pointer;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="imgupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/>';
        imptarget.before(listStr);
        imptarget = '';
        alert('ssss')
    }
    function imgupload4(img,name,type){
        var arr = img.split(',');
        var name_arr = name.split(',');
        var http = 'http://'+ window.location.host;
        var iconImgType = {
            txt : '/img/icon_file.png',
            jpg : '/img/icon_image.png',
            png : '/img/icon_image.png',
            pdf :  '/img/icon_pdf.png',
            ppt : '/img/icon_ppt.png',
            pptx :  '/img/icon_ppt.png',
            doc : '/img/icon_word.png',
            docx : '/img/icon_word.png',
            xls :  '/img/icon_excel.png',
            xlsx :  '/img/icon_excel.png'
        };
        var attrnametype = name.split('.')[1];
        imptarget.attr('src',iconImgType[attrnametype])
        if(iconImgType[attrnametype] == undefined){
            imptarget.attr('src','/img/icon_file.png')
        }
        imptarget.attr('onclick','anios1($(this))')
        imptarget.attr('url',arr[0]);
        imptarget.attr('atturl',arr[0]);
        imptarget.attr('names',name_arr[0]);
    }
    /*******************结束*****************************/

    $(function () {
//        var vConsole = new VConsole();
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

//        function uploadimg(data) {
//            $('#picture').val(data);
//            $('#picture').attr('value', data);
//        }

        $('img[data-type="fileupload"]').on('click',function(){
            if(!$(this).hasClass('grey')){
                if($(this).attr('src') == '/img/fileupload.png'){
                    phoneimgupload($(this));
                }
            }
        })
        $('img[data-type="imgupload"]').on('click',function(){
            if(!$(this).hasClass('grey')){
                if($(this).attr('src') == '/img/workflow/work/workformh5/addpng.png'){
                    phoneimgupload($(this));
                }
            }
        })
    });



    /**********************与移动端交流时间控件调用*****************************************/
    var timename = '';
    function timeclick(e){
        timename = e.attr('name');
        if(e.attr('dates_format').indexOf('hh:mm:ss') == -1){
            var cs = '0';
        }else{
            var cs = '1';
        }
        console.log(cs)
//        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//            setSelectTime(cs);
//        } else if (/(Android)/i.test(navigator.userAgent)) {
//            Android.setSelectTime(cs);
//        }
    }
    function autoclik(e) {
        var __this = $('#'+e.attr('target'))
        $.ajax({
            type: "post",
            url: "../../../document/updateCount",
            dataType: 'JSON',
            data:{
                id:__this.attr('uuid')

            },
            success: function (obj) {
                if(obj.flag){
                    __this.attr("value",obj.object.expressionStr)
                }
            }
        })
    }
    function timeclickjs(time){
        $('input[name='+ timename +']').val(time);
    }
    var globalData = {};
    var turn = function(){
        //alert("正在加载。。");
    }
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
    function myTrim(x) {
        return x.replace(/^\s+|\s+$/gm,'');
    }
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
            case '<>':
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
        var prcsOutArr = prcsOut.split('\n');
        if(prcsOutArr.length == 1 && prcsOutSet == ''){
            prcsOutSet = '[1]';
        }
        if(prcsOutSet != ""){
            var prcsOutArr = prcsOut.split('\n');
            formdata = covertToFormData(formdata);


            prcsOutArr.forEach(function(v,i){
                if(v){
                    var check_pass = 0;
                    var titleValue = '';
                    var arr_rule = v.split("'");
                    var item_title = myTrim(arr_rule[1]);
                    var item_con = myTrim(arr_rule[2]);
                    var item_value = myTrim(arr_rule[3]);
                    var item_pag = $('[Id="'+fromDataReject[item_title]+'"]')

                    if(v.indexOf('[')<=-1){
                        if(item_pag.attr('data-type')=='macros'&&item_pag.attr('datafld')=='SYS_USERNAME'&&item_pag.attr('orgsignImg')==1){
                            if(item_pag.prev().find('img').attr('src')!=undefined&&item_pag.prev().find('img').attr('src')!=''){
                                titleValue = item_pag.prev().find('img').attr('src');
                            }else{
                                titleValue=''
                            }
                            alert(titleValue)
                        }else{
                            titleValue = formdata[fromDataReject[item_title]];
                        }

                    }else{
                        if(item_title == '[当前步骤号]' || item_title == '[CUR_PRCS_ID]'){
                            titleValue = globalData.flowRunPrcs.prcsId
                        }else if(item_title == '[当前主办人姓名]' || item_title == '[CUR_USER_NAME]'){
                            titleValue = globalData.userName;
                        }else if(item_title == '[公共附件名称]' || item_title == '[ATTACH_NAME]'){
                            titleValue = '';
                            for(var j=0;j<$('#oneUploadFile .item_wordH1').length;j++){
                                if($('#oneUploadFile .item_wordH1').length ==1){
                                    titleValue = GetFileNameNoExt($('#oneUploadFile .item_wordH1').eq(j).attr('title'))
                                }else{
                                    titleValue += GetFileNameNoExt($('#oneUploadFile .item_wordH1').eq(j).attr('title')) + ','
                                }
                            }
                        }else if(item_title == '[公共附件个数]' || item_title == '[ATTACH_COUNT]'){
                            titleValue = $('#oneUploadFile .item_wordH1').length;
                        }else if(item_title == '[当前流程设计步骤号]' || item_title == '[CUR_FLOW_PRCS]'){
                            titleValue = globalData.flowRunPrcs.flowPrcs
                        }else if(item_title == '[当前主办人角色]' || item_title == '[CUR_USER_PRIV]'){
                            titleValue = workForm.tool.MacrosData.data.sYS_USERPRIV
                        }else if(item_title == '[当前主办人部门]' || item_title == '[CUR_USER_DEPT]'){
                            titleValue = workForm.tool.getMacrosData('SYS_DEPTNAME_SHORT')()
                        }else if(item_title == '[当前主办人上级部门]' || item_title == '[CUR_USER_DEPT_PARENT]'){
                            titleValue = workForm.tool.getMacrosData('SYS_MANAGER2')()
                        }else if(item_title == '[主办人会签意见]' ||　item_title == '[MAIN_USER_SIGN]'){
                            var data = globalData.sign;
                            titleValue=""
                            if(data!=''&&data!=undefined){
                                for(var j=0;j<data.length;j++){
                                    if(data[j].opFlag == 1){
                                        titleValue += data[j].content
                                    }
                                }
                            }
                        }else if(item_title == '[经办人会签意见]' || item_title == '[USER_SIGN]'){
                            var data = globalData.sign;
                            titleValue=""
                            if(data!=''&&data!=undefined){
                                for(var j=0;j<data.length;j++){
                                    if(data[j].opFlag == 0){
                                        titleValue += data[j].content
                                    }
                                }
                            }

                        }
                    }
//                           判断 第二个值是字段还是类型
                    if(fromDataReject[item_value]){//如果是字段并且是表单中字段的话
                        item_value = formdata[fromDataReject[item_value]];
                    }else{
                        if(item_value.indexOf('[')>-1){ //如果是字段并且不是表单中字段
                            if(item_value == '[当前步骤号]' || item_value == '[CUR_PRCS_ID]'){
                                item_value = globalData.flowRunPrcs.prcsId
                            }else if(item_value == '[当前主办人姓名]' ||item_value == '[CUR_USER_NAME]'){
                                item_value = globalData.userName;
                            }else if(item_title == '[公共附件名称]'　|| item_title == '[ATTACH_NAME]'){
                                item_value = item_value;
                            }else if(item_title == '[公共附件个数]' || item_title == '[ATTACH_COUNT]'){
                                item_value = item_value;
                            }else if(item_value == '[当前流程设计步骤号]' || item_value == '[CUR_FLOW_PRCS]'){
                                item_value = globalData.flowRunPrcs.flowPrcs
                            }else if(item_value == '[当前主办人角色]' || item_value == '[CUR_USER_PRIV]'){
                                item_value = $.cookie('userPrivName')||workForm.tool.MacrosData.data.sYS_USERPRIV;
                            }else if(item_value == '[当前主办人部门]' || item_value == '[CUR_USER_DEPT]'){
                                item_value = workForm.tool.getMacrosData('SYS_DEPTNAME_SHORT')()
                            }else if(item_value == '[当前主办人上级部门]' ||item_value == '[CUR_USER_DEPT_PARENT]'){
                                item_value = workForm.tool.getMacrosData('SYS_MANAGER2')()
                            }else if(item_value == '[主办人会签意见]'　|| item_value == '[MAIN_USER_SIGN]'){
                                var data = globalData.sign;
                                item_value=""
                                for(var j=0;j<data.length;j++){
                                    if(data[j].opFlag == 1){
                                        item_value += data[j].content
                                    }
                                }
                            }else if(item_value == '[经办人会签意见]' ||item_value == '[USER_SIGN]'){
                                var data = globalData.sign;
                                item_value=""
                                for(var j=0;j<data.length;j++){
                                    if(data[j].opFlag == 0){
                                        item_value += data[j].content
                                    }
                                }
                            }
                        }else{ //如果是类型值的话
                            if(item_value == '数值'){
                                item_value = 'shu'
                            }else if(item_value == '日期'){
                                item_value = 'date'
                            }else if(item_value == '时间+日期'){
                                item_value = 'time';
                            }else{
                                item_value = item_value;
                            }
                        }
                    }
//                           console.log(item_value)
                    if(titleValue == undefined){
                        res.msg = '条件设置有误，不存在“'+item_title+'”字段，请联系系统管理员前往流程设计器修改！';
                    }else{
                        check_pass = checkTileValue(titleValue,item_con,item_value);
                    }
                    var setitem = (i+1)
                    var reg = new RegExp('\\['+setitem+'\\]',"g");//g,表示全部替换。

                    prcsOutSet = prcsOutSet.replace(reg,check_pass);
                }
            });
            prcsOutSet = covertToPrcsOutSet(prcsOutSet.toLowerCase());
            if(prcsOutSet.indexOf('（') > -1 ||prcsOutSet.indexOf('）') > -1){
                var result = '';
                alert('条件设置有误，请联系系统管理员前往流程设计器重新设置!')
            }else{
                var result = eval(prcsOutSet);
            }

            if(result == 0){
                res.flag = false;
            }
        }
        if(cb){
            cb(res);
        }
    };
    function checkttachPriv(privNum){
        if(attachPriv.indexOf(privNum) > -1){
            return true;
        }
        return false   ;
    }
    $(function () {
        layer.load();
        $('body').show();
        var history = document.referrer;
        globalData.flowId = $.getQueryString("flowId");
        globalData.flowStep = $.getQueryString("flowStep") || '';
        globalData.prcsId = $.getQueryString("prcsId") || '';
        globalData.runId = $.getQueryString("runId") || '';
        globalData.tableName = $.getQueryString("tableName") || '';
        globalData.tabId =  $.getQueryString("tabId") || '';

        var workformh5 = {
            /************移动端工作流的初始化方法************************/
            init:function (cb) {
                var _this = this;
                workForm.init({
                    formhtmlurl:'../../workflow/work/workfastAdd',//URL
                    resdata:{
                        flowId:globalData.flowId,
                        runId:globalData.runId,
                        prcsId:globalData.prcsId,
                        flowStep:globalData.flowStep,
                    },
                    flowStep:globalData.prcsId,//预览
                    ish5:true,
                    target:'.cont_form'
                }, function (data,option,target) {
                    var obj = data.object;
                    globalData.flowRun = data.object.flowRun;
                    globalData.listFp = data.object.listFp;
                    globalData.flowRunPrcs = data.object.flowRunPrcs;
                    globalData.option = option;
                    globalData.flowTypeModel = data.object.flowTypeModel;
                    globalData.attachPriv = data.object.attachPriv;
                    globalData.allowBack = data.object.allowBack;
                    globalData.flowPrcs = data.object.flowRunPrcs.flowPrcs;
                    globalData.signlock = data.object.signlock;
                    globalData.conditionDesc = obj.conditionDesc;
                    globalData.prcsOut = obj.prcsOut;
                    globalData.prcsType = obj.flowProcesses.prcsType;
                    globalData.prcsOutSet = obj.prcsOutSet;
                    attachPriv = data.object.attachPriv;
                    if(globalData.signlock == 1){
                        $('.gapp_textarea').attr("disabled",true);
                    }
                    if(checkttachPriv(1)){
                        $('.xzbtn').show();
                    }else{
                        $('.xzbtn').hide();
                    }
                    var runid = data.object.flowRun.runId;
                    /************回退按钮显示方法************************/
                    if(globalData.allowBack != 0){
                        $('#backBtn').show();
                    }
                    /************删除按钮隐藏方法************************/
                    if(globalData.prcsId !=1){
                        $('#deleteBtn').hide();
                    }
                    /************调用移动端回退的方法************************/
                    $('#backBtn').click(function () {
                        _this.saveFlowData(function(res){
                            if(res.flag){
                                //alert("保存成功");
//                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                                    //alert(navigator.userAgent);
//                                    rightTitle('转交','审批及转交','feedback');
//                                } else if (/(Android)/i.test(navigator.userAgent)) {
//                                    //alert(navigator.userAgent);
//                                    Android.rightTitle('转交','xxxxx','feedback');
//                                }
                                window.location.href='getFeedbacks?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId+'&allowback='+globalData.allowBack;
                            }else{
                                $.layerMsg({content:"保存失败！",icon:2},function(){

                                });
                            }
                        });
//                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                            //alert(navigator.userAgent);
//                            rightTitle('转交','审批及转交','feedback');
//                        } else if (/(Android)/i.test(navigator.userAgent)) {
//                            //alert(navigator.userAgent);
//                            Android.rightTitle('转交','xxxxx','feedback');
//                        }
                        window.location.href='getFeedbacks?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId+'&allowback='+globalData.allowBack;
                    });
                    /************和后台获取附件信息的方法************************/
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
                                    img += '<img id="blah"  onClick="$(this).ImgZoomIn()" src="/xs?'+ obj.obj[i].attUrl +'" onclick="anios($(this))" style="width:50px;height:50px;margin-right: 10px;margin-bottom: 10px;" url="'+ http + '/xs?'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'">';
                                }else{
                                    names += '<p><a href="'+ http + '/download?'+ obj.obj[i].attUrl +'" name="'+ obj.obj[i].attachName +'">'+ obj.obj[i].attachName +'</a></p>'
                                }

                            }
                            $('.photo_box').append(img);
                            $('.uploadbox').append(names);
                        }
                    });
                    /************和后台获取会签信息的方法************************/
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
                                str +=  '<div style="text-align: left;margin: 0px auto;margin-top: 15px;width: 90%;">' +
                                    '<span style="display: block;margin-bottom: 5px;font-size: 13px;">'+obj.obj[i].users.userName+'：</span>' +
                                    '<span style="color: #919191;display: block;margin-bottom: 5px;font-size: 12px;">'+obj.obj[i].editTime+'</span>' +
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
                    $('#deleteBtn').attr('tid',globalData.flowRunPrcs.id);
                    // if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                    //     getRunIdStr(runid);
                    // } else if (/(Android)/i.test(navigator.userAgent)) {
                    //     Android.getRunIdStr(runid);
                    // }
                    _this.buildBody(target);
                    _this.buildEvent();
                    cb();
                });

            },
            /************调用工作流转交按钮的方法************************/
            turnH5Btn:function(){
                var _this = this;
                _this.saveFlowData(function(res){
                    if(res.flag){
                        var content = $('.signBox .gapp_textarea').val();
                        if(content == ""){
                            window.location.href='/document/getSuperturnh5?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId+'&tableName='+globalData.tableName+'&tabId='+globalData.tabId+'&backType='+backType;
                        }else{
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
                        window.location.href='/document/getSuperturnh5?flowId='+globalData.flowId+'&flowStep='+globalData.flowStep+'&prcsId='+globalData.prcsId+'&runId='+globalData.flowRun.runId+'&tableName='+globalData.tableName+'&tabId='+globalData.tabId+'&backType='+backType;
//                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                            //alert(navigator.userAgent);
//                            rightTitle('转交','123','turn');
//                        } else if (/(Android)/i.test(navigator.userAgent)) {
//                            //alert(navigator.userAgent);
//                            Android.rightTitle('转交','123','turn');
//                        }
                    }
                });
            },
            buildEvent:function () {
                var _this = this;
                $('#turnBtn').click(function () {
                    _this.turnH5Btn();
                });
                $('#lctbtn').click(function () {
                    window.location.href="/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId
//                    if(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                        lookFlowChart("/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId);
//                    }else if(/(Android)/i.test(navigator.userAgent)){
//                        Android.lookFlowChart("/flowSetting/processDesignToolTwo?flowId="+ globalData.flowId +"&rilwId="+ globalData.runId);
//                    }
                });
                /************工作流 保存 按钮 点击方法************************/
                $('#saveBtn').click(function () {
                    _this.saveFlowData(function(res){
                        if(res.flag){
                            $.layerMsg({content:"保存成功！",icon:1},function(){
                                window.history.go(-1)
                                location.reload();
                            });
                            /************调用移动端返回工作流列表方法************************/
//                            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                                finishWork();
//                            } else if (/(Android)/i.test(navigator.userAgent)) {
//                                Android.finishWebActivity();
//                            }
                        }else{
                            $.layerMsg({content:"保存失败！",icon:2},function(){

                            });
                        }
                    });
                });
                /************工作流 删除 按钮 点击方法************************/
                $('#deleteBtn').click(function () {
                    var tid=$(this).attr('tid');
                    //删除判断
                    layer.confirm('确认删除吗？', {
                        btn: ['确定','返回'] //按钮
                    }, function(){
                        //确定删除，调接口
                        $.ajax({
                            url: '/workflow/work/deleteRunPrcs',
                            type: 'get',
                            dataType: 'json',
                            data:{
                                id:tid
                            },
                            success: function (obj) {
                                if (obj.code == '100066'){
                                    layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                                } else {
                                    //第三方扩展皮肤
                                    layer.msg('删除成功！', { icon:6},function(){
                                        window.history.go(-1)
                                        location.reload();
                                    });
                                }
                                /************调用移动端返回工作流列表方法************************/
//                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
//                                    finishWork();
//                                } else if (/(Android)/i.test(navigator.userAgent)) {
//                                    Android.finishWebActivity();
//                                }

                            }
                        })
                    }, function(){
                        layer.closeAll();
                    });
                });
            },
            /************工作流 保存数据库的方法************************/
            saveFlowData:function (cb){
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
                            value= obj.val();
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
                        var name = obj.attr('name');
                        $('img[name='+name+']').each(function(i,v){
                            var url = $(v).attr('src');
                            if(url!='/img/icon_uploadimg.png'){
                                value+= (url+',');
                            }
                        })
                    }else if(datatype == "fileupload"){
                        value= obj.attr('atturl');
                    }else if(datatype == "kgsign"){
                        value = (obj.attr('signatureId') || '');
                    }else{
                        value = obj.val();
                    }

                    if(ismust == 'true' && value == ""){
                        flag = true;
                        alert('请填写'+obj.attr('title'));
                        //layer.msg('请填写'+obj.attr('title'), {icon: 1});
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
                    var list = Signature.list;
                    var signatureCreator = Signature.create();
                    var kgsignList=$('#content .kgsign');
                    kgsignList.each(function(){
                        // var value = $(this).attr('value');
                        // if(value){//已经存在签章
                        //
                        // }else{
                        //新增签章
                        var key = $(this).attr('signatureid');
                        if(list[key]){
                            signatureCreator.saveSignature(flowfun.runId, key, list[key].getSignatureData());
                        }
                        // }
                    });
                    checkPrcOut(JSON.parse(fdata.formdata),JSON.parse(fdata.fromDataReject),function(res){
                        if(res.flag){
                            $.ajax({
                                type: "post",
                                url: "../../workflow/work/nextwork",
                                dataType: 'JSON',
                                data: fdata,
                                success: function(res){
                                    var data ={};
                                    if(cb){
                                        if(res.flag){
                                            data.flag = true;
                                        }else{
                                            data.flag = false;
                                        }
                                        data.data = res.obj;
                                        cb(data);
                                    }
                                }
                            });
                        }else{
                            $.layerMsg({content:res.msg,icon:0},function(){

                            });
                        }
                    });

                }
            },
            /************工作流数据录入、判断方法************************/
            buildBody : function(data){
                var _this = (this);
                var target = data;
                var dataList = data.find('.form_item');
                var preObj = '';
                var tableObj = [];
                var idnum = 0;
                var checkidnum=0;
                dataList.each(function(i,v) {
                    var __this = $(this);
                    var dataType = __this.attr('data-type');
                    var title = __this.attr('title');
                    var name = __this.attr('name');
                    var isMust = __this.attr('isMust');
                    var isMustText = '';
                    if(isMust){
                        isMustText = '<span style="color:red;font-size: 10px;margin-left: 2px">*</span>';
                    }

                    var eleTrObj = $('<tr><td class="td1"><div>' + title + isMustText + '</div></td><td class="td2"></td></tr>');
                    var e = {};
                    switch (dataType) {
                        case 'text':
                            __this.addClass("gapp_input gapp_form");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'textarea':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'select':
                            __this.addClass("gapp_select gapp_form");
                            __this.attr("style",'');
                            if(__this.attr('disabled')=='disabled'){
                                __this.css('background','url("/img/workflow/work/workformh5/select.png") no-repeat 95% 12px')
                                __this.css('background-color',' #f8f8f8!important')
                                __this.css('color',' #333!important')
                            }
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'radio':
                            var bool=true;
                            for(var i=0;i<tableObj.length;i++){
                                if($(tableObj[i]).find('[name="'+__this.attr('name')+'"]').length!=0){
                                    bool=false;
                                }
                            }
                            if(bool) {
                                var radioObj = $('<span style="position: relative;width: 22px;height: 22px;display: inherit"></span>');
                                var id = __this.attr('name');
                                __this.attr('id', id + '_' + idnum);
                                $(__this).css({
                                    'position': 'absolute',
                                    'top': '0',
                                    'left': '2px'
                                })
                                radioObj.append(__this)
                                var lable = '<label style="left: 0;top: 0;" class="bgweijinyong" for="' + id + '_' + idnum + '"></label>';
                                if(__this.attr('disabled')=='disabled') {
                                    lable = '<label style="left: 0;top: 0;" class="bgyijingyong" for="' + id + '_' + idnum + '"></label>';
                                }
                                radioObj.append(lable);
                                eleTrObj.find('.td2').append(radioObj);
                                eleTrObj.find('.td2')
                                    .append('<span  style="line-height: 22px;display: inherit;padding-left: 5px;' +
                                        'padding-right: 15px;">' + __this.val() + '</span>')
                                idnum++;
                            }else {
                                eleTrObj=$('');
                                for(var i=0;i<tableObj.length;i++){
                                    if($(tableObj[i]).find('[name="'+__this.attr('name')+'"]').length!=0){
                                        var tableObjParent=$(tableObj[i]).find('[name="'+__this.attr('name')+'"]').parent().parent();
                                        var radioObj = $('<span style="position: relative;width: 22px;height: 22px;display: inherit"></span>');
                                        var id = __this.attr('name');
                                        __this.attr('id', id + '_' + idnum);
                                        $(__this).css({
                                            'position': 'absolute',
                                            'top': '0',
                                            'left': '2px'
                                        })
                                        radioObj.append(__this)
                                        var lable = '<label style="left: 0;top: 0;" class="bgweijinyong" for="' + id + '_' + idnum + '"></label>';
                                        if(__this.attr('disabled')=='disabled') {
                                            lable = '<label style="left: 0;top: 0;" class="bgyijingyong" for="' + id + '_' + idnum + '"></label>';
                                        }
                                        radioObj.append(lable);

                                        tableObjParent.append(radioObj);
                                        tableObjParent
                                            .append('<span  style="line-height: 22px;display: inherit;padding-left: 5px;' +
                                                'padding-right: 15px;">' + __this.val() + '</span>')
                                    }
                                }
                                idnum++;
                            }

                            break;
                        case 'checkbox':
                            var id = __this.attr('name');
                            __this.attr('id',id+'_'+checkidnum);
                            eleTrObj.find('.td2').append(__this);
                            var lable = '<label class="bgweijinyong" style="border-radius: 0px" for="'+ id+'_'+checkidnum +'"></label>';
                            if(__this.attr('disabled')=='disabled'){
                                lable = '<label class="bgyijingyong" style="border-radius: 0px" for="'+ id+'_'+checkidnum +'"></label>';
                            }
                            eleTrObj.find('.td2').append(lable);
                            checkidnum++;
                            break;
                        case 'qrcode':
                            __this.css("float","none");
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'kgsign':

                            $(__this.find("img").get(0)).attr("style","cursor: pointer; margin: 0 auto;width:100%;height:100%;")
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'macros':
                            __this.addClass("gapp_input gapp_form");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'calendar':
                            __this.addClass("gapp_input gapp_date").removeClass('laydate-icon');
                            __this.attr("style",'padding-right: 0px;');
                            __this.attr("dates_format",__this.attr("date_format"));
                            __this.attr("onclick","laydate({istime: true, format: \'YYYY-MM-DD hh:mm:ss\'})");
                            __this.removeAttr("date_format");
                            eleTrObj.find('.td2').append(__this);
                            break;
                        case 'imgupload':
                            data.find('img[name="'+name+'"]').each(function (i,v) {
                                if($(v).attr("src")!='/img/icon_uploadimg.png'){
                                    $(v).attr('url',$(v).attr('src'));
                                    $(v).attr('names',$(v).attr('url').split('&ATTACHMENT_NAME=')[1].split('&')[0]);
                                    $(v).attr('onclick','anios1($(this))');
                                    if($(v).attr('disabled')!='disabled'){
                                        eleTrObj.find('.td2').append(v);
                                    }

                                }else{
                                    if($(v).attr('disabled')!='disabled'){
                                        $(v).attr("onclick","phoneimgupload(this)");
                                        eleTrObj.find('.td2').append(v);
                                    }else {
                                        eleTrObj.find('.td2').append('无');
                                    }
                                }
                            });
                            break;
                        case 'fileupload':
                            if($(v).attr("src")!='/img/fileupload.png'){
                                $(v).attr('url',$(v).attr('atturl'));
                                $(v).attr('names',$(v).attr('atturl').split('&ATTACHMENT_NAME=')[1].split('&')[0]);
                                $(v).attr('onclick','anios1($(this))');
                                if($(v).attr('disabled')!='disabled') {
                                    eleTrObj.find('.td2').html(v);
                                }
                            }else{
                                if($(v).attr('disabled')!='disabled') {
                                    eleTrObj.find('.td2').append(v);
                                }else {
                                    eleTrObj.find('.td2').append('无');
                                }
                            }
                            break;
                        case 'list':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'sign':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'readcomments':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'listing':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            eleTrObj.find('.td2').append('<textarea  class="form_item gapp_textarea grey" gwidth="200" gheight="50" style="background-color: rgb(228, 228, 228); color: rgb(0, 0, 0);" disabled="disabled"></textarea>');
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'userselect':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');
                            var uservalue =  __this.attr('username') || '';
                            eleTrObj.find('.td2').append('<input class="form_item gapp_input gapp_form grey" disabled="disabled" value="'+ uservalue +'">');
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'deptselect':
                            __this.addClass("gapp_textarea");
                            __this.attr("style",'');

                            var deptnamevalue =  __this.attr('deptname') || '';
                            eleTrObj.find('.td2').append('<input class="form_item gapp_input gapp_form grey" disabled="disabled" value="'+ deptnamevalue +'">');
                            eleTrObj.find('.td1').find('div').addClass('textareaclass');
                            break;
                        case 'autocode':
                            __this.addClass('gapp_input gapp_form');
                            __this.attr('readonly',"readonly");
                            var targetid =  __this.attr('id');
                            eleTrObj.find('.td2').append(__this);
                            eleTrObj.find('.td2').append('<span class="autospan" target="'+targetid+'" onclick="autoclik($(this))">赋值</span>');
                            break;
                        case 'macrossign':
                            var datafld = __this.attr('datafld');
                            if(datafld == "SYS_FLOW_SIGNTEXT"){
                                var textvalue = ''
                                if(__this.html().indexOf('{宏标记-会签控件}') == -1){
                                    textvalue = __this.html();
                                }
                                eleTrObj.find('.td2').append('<div class="form_item gapp_textarea grey" gwidth="200" gheight="50" style="overflow-x: auto;background:#f8f8f8!important ;color: rgb(0, 0, 0);" disabled="disabled">'+textvalue+'</div>');
                            }else{
                                eleTrObj.find('.td2').append('<input class="form_item gapp_input gapp_form grey" disabled="disabled" value="'+ __this.html() +'">');
                            }
                            break;
                        default:

                    }
                    if(__this.attr('hidden') == 'hidden'){
                        $(this).parent().append('*********');
                    }
                    var dis = __this.attr('disabled');
                    if(dis == 'disabled'){
                        __this.css({
                            'background-color':'#f8f8f8',
                            'color':'#000'
                        })
                        __this.addClass('grey').parents('tr').find('.td1').addClass('grey1');
                        // __this.attr('disabled',false)
                        //
                        // if(__this.val() == ''){
                        //     __this.parent().siblings().find('div').css('color','#999')
                        // }
                        var _this = $(this);
                        if(__this.attr('data-type') == "calendar"){
                            if(_this.attr('class').indexOf('grey') != -1){
                                _this.removeAttr('onclick');
                            }
                        }else if(__this.attr('data-type') == 'autocode'){
                            _this.next().remove();
                        }
                    }else {
                        __this.css('color','#111')
                    }
                    tableObj.push(eleTrObj);

                });
                $('#content').append(tableObj);
                $('#content').find('.qrcode').each(function () {
                    var _this = $(this);
                    var msg = {"mark":"SID_MEETING","url":_this.attr('textstr')};
                    var id = _this.attr('id')
                    var qrcode = new QRCode(id, {
                        text: JSON.stringify(msg),
                        width: _this.attr('orgwidth'),
                        height: _this.attr('orgheight'),
                        colorDark : '#000000',
                        colorLight : '#ffffff',
                        correctLevel : QRCode.CorrectLevel.H
                    });
                });
                var signatureCreator = Signature.create();
                signatureCreator.getSaveSignatures( globalData.flowRun.runId, function(signs){
                    var signdata = new Array();
                    var jsonList = eval("("+signs+")");
                    for(var i=0;i<jsonList.length;i++){
                        var map = {};
                        map.signatureid = jsonList[i]["signatureId"];
                        map.signatureData = jsonList[i]["signature"];
                        signdata.push(map);
                    }
                    console.log(signdata);
                    Signature.loadSignatures(signdata);
                });
                globalData.fromDataReject = _this.buildFormData();

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
        /************调用工作流初始化方法************************/
        workformh5.init(function(){
            turn = function(){
                workformh5.turnH5Btn();
            }
        });
    });
</script>
</body>
</html>