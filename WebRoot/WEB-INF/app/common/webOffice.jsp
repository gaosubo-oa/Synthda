<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta name="renderer" content="ie-comp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title><fmt:message code="global.lang.edit" /></title><%--编辑--%>

    <style>
        * {
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-size: 16px;
            font-family: "Microsoft yahei";
            margin: 0;
            color: #333333;
        }

        .wrap {
            width: 100%;
            height: 100%;
            float: left;
            clear: both;
        }

        .left_side, .right_side, .rightIcon {
            float: left;
        }

        .left_side {
            visibility: hidden;
            width: 14%;
            height: 100%;
            box-shadow: 2px 6px 12px #888888;
            background-color: #2b579a;
        }

        .right_side, .rightIcon  {
            width: 86%;
            margin-left:-7px;
            height: 100%;
        }
        .rightIcon{
            display: none;
            position: relative;
        }
        .rightIcon .center{
            position: absolute;
            top: 50%;
            left: 50%;
            /*-webkit 是表示针对 safari 浏览器支持，-ms表示针对 IE 浏览器支持*/
            -webkit-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
        }
        #EnterRevisionMode option {
            height: 36px;
        }

        .wordFormDiv {
            width: 100%;
            height: 100%;
            margin-left: 8px;
        }

        .menu_ul {
            padding: 0;
            margin: 0;
            color: #fff;
        }

        .menu_ul_li {
            list-style: none;
            cursor: pointer;
            display: none;
        }
        .baseOprMenu, .baseOprMenu1{
            display: block;
            padding: 10px 0px 15px 20px;
        }
        .menu_ul_li ul {
            list-style: none;
            padding-left: 0px;
        }

        .menu_ul_li ul li {

            height:18px;
            list-style: none;
            padding: 10px 10px;
        }

        .menu_ul_li ul li img {
            vertical-align: middle;
            margin-left: 22px;
            visibility: hidden;
        }

        .menu_ul_li ul li span {
            font-size: 14px;
            margin-left: 15px;
            line-height: 16px;
            vertical-align: middle;
        }

        .menu_ul_li ul li:hover {
            background-color: #002050;
        }
        .fileMenu,.signMenu{
            display: block;
            padding: 10px 0px 15px 20px;
        }
        .active {
            color: #0A5FA2;
            border-bottom: 2px solid #0A5FA2;
        }

        .menu_ul_div ul {
            padding-left: 20px;
            list-style: none;
            margin: 0;
        }

        .menu_ul_div ul li {
            padding: 10px 0px;
            cursor: pointer;
        }

        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
            cursor: pointer;
        }

        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }
        .oper{
            display: none;
        }

        .no-control-msg {
            border-bottom: 1px solid #ec827d;
            height: 32px;
            background-color: #fff1f0;
            height: auto;
            padding: 0 20px;
        }
        .no-control-msg span {
            color: #ec827d;
            position: relative;
            line-height: 46px;
            font-size: 16px;
            font-weight: bold;
            vertical-align: middle;
            margin-right: 16px;
        }
        .no-control-msg img{
            margin-left: 16px;
            vertical-align: middle;
            margin-right: 10px;
        }

        .no-control-msg a{
            font-size: 16px;
            font-weight:normal;
            cursor: pointer;
            color: #00a0e9;
        }
        .aipFormDiv{
            height: 100%;
            width: 100%;
        }
        form{
            width: 100%;
            height: 100%;
        }
        .no-control-msg .downCJ{
            font-size: 16px;
            font-weight: normal;
            cursor: pointer;
            color: #00a0e9;
        }
        .hoverClass{
            background-color: #002050;
        }
    </style>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
</head>

<body>
<div style="display:none">
</div>
<div style="display: none" id="fileAll"></div>
<div class="wrap" id="wrap">
    <div class="left_side">
        <ul class="menu_ul">
            <input type="hidden" id="userNameBox" value="${sessionScope.userName}">
            <li class="menu_ul_li base_menu_li">
                <span class="baseOprMenu1">文件</span>
                <ul class="baseOprMenuUl">
                    <li class="oper oper3001" style="position: relative">
                        <form id="uploadForm" action="/flow/docUploadFile" enctype="multipart/form-data" method="post">
                            <img style="position: absolute;top: 7px;" src="../img/document/word_aip/icon_uploading_32.png"/><span style="position: absolute;left: 48px;top: 10px;">上传文件</span><%--上传Word--%>
                            <input title="上传Word" id="fileUpload" onchange="wordUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <input type="hidden" name="module" value="document">
                            <input type="hidden" name="id" value="">
                            <input type="hidden" name="fileType" value="1">
                            <input type="hidden" name="prcsId" value="">
                            <input type="hidden" name="flowPrcs" value="">
                        </form>
                    </li>
                    <li id="createWord" class="oper oper3001" onclick="newWordFile();" style="position: relative">
                        <img src="../img/document/word_aip/icon_template_03.png"><span>新建Word文件</span>
                    </li>
                </ul>
            </li>
            <li class="menu_ul_li base_menu_li">
                <span class="baseOprMenu">Word正文</span><%--WORD正文--%>
                <ul class="baseOprMenuUl">
                    <li class="oper oper1009 select_red_li " ><img src="../img/document/word_aip/icon_taohong_16.png"/><span>打开模板</span><%--打开模板--%>
                    </li>
                    <li class="oper oper1001" onclick="SaveToURL();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span><%--保存--%>
                    </li>
                    <li class="oper oper1002 select_red_li " ><img src="../img/document/word_aip/icon_taohong_16.png"/><span><fmt:message code="common.th.setRed" /></span><%--套红--%>
                    </li>
                    <li class="oper oper1003" title="该功能仅在word文件下可用" onclick="TrackRevisions(true,$(this))" id="liuhen"><img src="../img/document/word_aip/icon_mark_19.png"/><span>修订</span></li><%--留痕--%>
<%--                    <li class="oper oper1004" onclick="TrackRevisions(false)" id="buliuhen" style="display: none"><img src="../img/document/word_aip/icon_markless_22.png"/><span><fmt:message code="common.th.notStayMark" /></span>&lt;%&ndash;不留痕&ndash;%&gt;--%>
<%--                    </li>--%>
                    <li class="oper oper1005" title="该功能仅在word文件下可用"  onclick="EnterRevisionMode(true,$(this))"><img src="../img/document/word_aip/icon_showmark.png"/><span style="margin-left: 12px">显示标记</span><%--显示痕迹--%>
                    </li>
<%--                    <li class="oper oper1006" onclick="EnterRevisionMode(false)" style="display: none"><img src="../img/document/word_aip/icon_unshow.png"/><span><fmt:message code="common.th.hideTraces" /></span>&lt;%&ndash;隐藏痕迹&ndash;%&gt;--%>
<%--                    </li>--%>
                    <!-- <li class="oper oper1008" onclick="stamp()" id="writesign" style="display: none!important;"><img src="../img/document/word_aip/icon_markless_22.png"/><span>盖章</span><%--打印--%>
                    </li> -->
                    <li class="oper oper1010" onclick="printDoc(false)" id="dayin" style="display: none"><img src="../img/document/word_aip/icon_markless_22.png"/><span>打印</span><%--打印--%>
                    </li>
<%--                    <li class="oper oper3002" style="position: relative;display: none">--%>
<%--                        <form id="uploadAipForm" action="../flow/fileUpload" enctype="multipart/form-data"--%>
<%--                              method="post">--%>
<%--                            <img style="position: absolute;top: 7px;" src="../img/document/word_aip/icon_uploading_32.png"/><span  style="position: absolute;left: 47px;top: 10px;"><fmt:message code="common.th.uploadLayoutFile" /></span>&lt;%&ndash;上传版式文件&ndash;%&gt;--%>
<%--                            <input title="上传aip" id="fileUploadAip" onchange="aipUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
<%--                            <input type="hidden" name="module" value="document">--%>
<%--                        </form>--%>
<%--                    </li>--%>
                    <li class="oper oper3004" onclick="finalized()"><img src="../img/document/word_aip/icon_template_03.png"/><span>定稿</span></li>
<%--                    <li class="oper oper3003" onclick="convertToAip(3)"><img src="../img/document/word_aip/icon_template_03.png"/><span>转AIP版式文件</span></li>&lt;%&ndash;转版式文件&ndash;%&gt;--%>
                    <li class="oper oper3005" onclick="ToPDF()"><img src="../img/document/word_aip/icon_template_03.png" /><span>转PDF版式文件</span></li><%--转版式文件--%>
                    <li class="oper oper3007" onclick="downPdfOrWord(1)"><img src="../img/document/word_aip/icon_template_03.png"/><span>Word正文下载</span></li><%--WORD正文下载--%>
                </ul>
            </li>
            <li class="menu_ul_li file_menu_li">
                <span class="fileMenu"><fmt:message code="common.th.layoutText" /></span><%--版式正文--%>
                <ul class="fileMenuUl">
                    <li class="oper oper2001" onclick="saveAip();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span></li><%--保存--%>
                    <li class="oper oper2002" onclick="downloadAip()"><img src="../img/document/word_aip/icon_download_07.png"/><span style="margin-left: 13px;"><fmt:message code="file.th.download" /></span></li><%--下载--%>
                    <li class="oper oper2003" onclick="aip_print();"><img src="../img/document/word_aip/icon_print_07.png"/><span style="margin-left: 14px;"><fmt:message code="global.lang.print" /></span><%--打印--%>
                    <li class="oper oper2004" onclick="aip_delete();"><img src="../img/document/word_aip/icon_delete_35.png"/><span style="margin-left: 17px;"><fmt:message code="global.lang.delete" /></span><%--删除--%>
                    </li>
                </ul>
            </li>
            <li class="menu_ul_li sign_menu_li">
                <span class="signMenu"><fmt:message code="common.th.signature" /></span><%--版式签章--%>
                <ul class="signUl">
                    <li class="oper oper2005" onclick="Handwriting(0)"><img src="../img/document/word_aip/icon_stamp_10.png"/><span><fmt:message code="common.th.stamp" /></span><%--盖章--%>
                    </li>
                    <li class="oper oper2006" onclick="Handwriting(1)"><img src="../img/document/word_aip/icon_write_14.png"/><span><fmt:message code="common.th.handwriting" /></span><%--手写--%>
                    </li>
                </ul>
            </li>
            <li class="menu_ul_li PDF_menu_li">
                <span class="signMenu">PDF正文</span><%--版式签章--%>
                <ul class="signUl">
                    <li class="oper oper3006" onclick="ToWord($(this))" wordAtturl=""><img src="../img/document/word_aip/icon_stamp_10.png"/><span>切换为Word编辑</span><%--切换为Word编辑--%>
                    </li>
                    <li class="oper oper3008" onclick="downPdfOrWord(2)"><img src="../img/document/word_aip/icon_template_03.png"/><span>PDF正文下载</span></li><%--PDF正文下载--%>
                    <li class="oper oper3009" onclick="deletePdf()"><img src="../img/document/word_aip/icon_template_03.png"/><span>删除PDF</span></li><%--删除PDF--%>
                    <li class="oper oper3010" onclick="makeSign()" style="display: block;"><img src="../img/document/word_aip/icon_template_03.png"/><span>盖章</span>

                </ul>
            </li>
        </ul>
    </div>
    <div class="right_side">
        <div class="wordFormDiv" style="display: block">
            <div style="display: none" class="no-control-msg"><img src="/img/document/word_aip/icon_err_msg_03.png" ><SPAN>office文档在线阅读、编辑功能需要安装浏览器插件，请<a href="../lib/officecontrol/WebOffice.exe" class="downCJ" >下载安装插件</a>，安装后请点击刷新按钮</SPAN><a href="javascript:void(0)" onclick="location.reload()">点击刷新</a></div>
            <form>
                <script type="text/javascript" src="/lib/officecontrol/LoadWebOffice.js?20190604.1"></script>
            </form>
        </div>
        <div class="aipFormDiv" style="display: none">
        </div>
    </div>
    <div class="rightIcon">
        <div class="center">请上传Word或PDF文件，或新建Word文件</div>

    </div>
</div>
<script src="/js/jquery/jquery.form.min.js"></script>
<script src="/lib/layer/layer.js?20201106"></script>
<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    var isOpenSanyuan = false;
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if(data.paraValue == 0) {
                    isOpenSanyuan = true
                    $("#createWord").css("visibility","hidden");
                    $("#email").css("visibility","hidden");
                }
            }
        }
    })
    if(!getCookie('redisSessionId')) {
        var session = '';
        $.ajax({
            url: '/getSessionId',
            type: 'get',
            dataType: 'json',
            async: false,
            success: function (json) {
                if (json.id != undefined) {
                    session = json.id;
                    $.cookie('redisSessionId', json.id, {expires: 7})
                }
            }
        });
    }
    var parentPrcsId = '',parentFlowPrcs = '';
    if(parent.location.href.indexOf('/workflow/work/workform?') > -1){
        parentPrcsId = parent.$.GetRequest().flowStep;
        parentFlowPrcs = parent.$.GetRequest().prcsId;
        $('input[name="prcsId"]').val(parentPrcsId);
        $('input[name="flowPrcs"]').val(parentFlowPrcs);
    }
    var AipObj = document.getElementById("HWPostil1");
    var TANGER_OCX_OBJ = document.getElementById("WebOffice");
    var url = "";
    var documentEditPriv = 0;
    var documentEditPrivDetail = "0";

    var ntType=GetQueryString('ntType');
    var printBtn=GetQueryString('print');
    var officeType=GetQueryString('officeType');

    var mainClearAttUrl = '';
    var saveType = 0;

    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串,判断是否是pc客户端打开的qt浏览器
    /****************************************************
     *
     *					禁止复制(判断ie下是否会加载控件)
     *
     /****************************************************/
    function notCopy() {
        try{
            var webObj=document.getElementById("WebOffice");
            webObj.SetSecurity(0x04);
            return true;
        }catch(e){
            $('.base_menu_li').css('display', 'block');
            $('.baseOprMenuUl li').css("display","block");

            $('.no-control-msg').show();
            $('.menu_ul li').hide();
            // $('.left_side').hide();
            // $('.right_side').css({'width':'100%'});
            return false;
        }
    }
//    获取cookie
    function getCookie (key) {
        var arr=document.cookie.split('; '); //多个cookie之间是用;+空格连接的
        for (var i = 0; i < arr.length; i++) {
            var arr2=arr[i].split('=');
            if(arr2[0]==key){
                return arr2[1];
            }
        }
        return false;//如果函数没有返回值，得到的结果是undefined
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
    //ie下加载pdf正文
    function IEpdf(src){
        var str = ' <iframe name="iepdf" width="100%" height="100%" id="iepdf" src="/pdfPreview?'+ src +'" frameborder="0" noresize="noresize" scrolling="yes"></iframe>';
        $('.aipFormDiv').html(str);
    }
    function ToWord(e){
        url = e.attr('wordAtturl');
        fileType = 'doc';
        // initWord(encodeURI(url));
        initWord(url);
        $('.PDF_menu_li').hide();
    }
    function djfn(){
        var str ="<OBJECT id='HWPostil1' align='middle' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%' classid='clsid:FF1FE7A0-0578-4FEE-A34E-FB21B277D561' codebase='/lib/HWPostil/HWPostil.cab#version=3,1,4,2'></OBJECT>"
        $('.aipFormDiv').html(str);
    }
    //盖章
    function stamp() {
        var login = TANGER_OCX_OBJ.SvrIsLogin;
        if(login==false){
            TANGER_OCX_OBJ.SvrLoginUrl = 'http://10.191.15.14:1986/ntkoSignServer/';
            TANGER_OCX_OBJ.SvrShowConfig();
        }
        //系统会弹出服务器上用户可使用的印章列表，供用户是选择盖章
        TANGER_OCX_OBJ.SvrAddSecsign();

    }
    // 从url获取文档
    function initUrl(fn) {
        var flag = notCopy();
        if(flag||paraValue|| GetQueryString("tabId") != ''){
            if (GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'document') {
                $.ajax({
                    url: "/document/selectDocById",
                    type: "get",
                    dataType: "json",
                    data: {id: GetQueryString("tabId"), randomNum: Math.random(), flowId: parent.flowId},
                    success: function (res) {
                        if (res.flag) {
                            mainClearAttUrl = res.object.mainClearAttUrl || '';
                            //从pdf文件返回的
                            if(location.href.indexOf('&initwordType=1') > -1){
                                if(!flag){
                                    url = res.object.wordAttUrl;
                                    if (fn != undefined) {
                                        fn(url)
                                    }
                                }
                            }else{
                                if (res.object.aipAttUrl != undefined && res.object.aipAttUrl != '') {
                                    url = res.object.aipAttUrl;
                                    var mainAipFileName = res.object.mainAipFileName;
                                    if(mainAipFileName.substring(mainAipFileName.lastIndexOf(".")) == '.pdf'){
                                        if(isIE()){
                                            $('.oper3006').attr('wordAtturl', res.object.wordAttUrl);
                                            IEpdf(url.split('ATTACHMENT_NAME=')[0]+'&ATTACHMENT_NAME=&tabId='+GetQueryString("tabId"));
                                            $('.wordFormDiv').hide().next().show();
                                            $('.left_side').css('visibility','visible');
                                            if(parent.location.href.indexOf('workformPreView')>-1){
                                                $('.PDF_menu_li').show().siblings().hide();
                                                $('.oper3008').show().siblings().hide()
                                            }else{
                                                //如果是经办人，则只能下载
                                                if(GetQueryString("opflag")=='0'){
                                                    if(documentEditPrivDetail.indexOf('3008') >-1){
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3008').show().siblings().hide()
                                                    }else{
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3008').hide()
                                                    }
                                                }else{
                                                    if(documentEditPrivDetail.indexOf('3006') >-1){
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        if (res.object.wordAttUrl && res.object.wordAttUrl != '') {
                                                            $('.oper3006').attr('wordAtturl',res.object.wordAttUrl.split('&ATTACHMENT_NAME=')[0]+'&ATTACHMENT_NAME=').show();
                                                        } else {
                                                            $('.oper3006').hide()
                                                        }
                                                    }
                                                    //判断PDF正文下载是否显示
                                                    if(documentEditPrivDetail.indexOf('3008') >-1){
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3008').show()
                                                    }else{
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3008').hide()
                                                    }
                                                    //判断删除PDF是否显示
                                                    if(documentEditPrivDetail.indexOf('3009') >-1){
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3009').show()
                                                    }else{
                                                        $('.PDF_menu_li').show().siblings().hide();
                                                        $('.oper3009').hide()
                                                    }
                                                    // //判断PDF盖章是否显示
                                                    // if(documentEditPrivDetail.indexOf('3010') >-1){
                                                    //     $('.PDF_menu_li').show().siblings().hide();
                                                    //     $('.oper3010').show()
                                                    // }else{
                                                    //     $('.PDF_menu_li').show().siblings().hide();
                                                    //     $('.oper3010').hide()
                                                    // }
                                                }

                                            }
                                        }else{
                                            location.href = '/common/PDFEditor?'+ url.split('ATTACHMENT_NAME=')[0]+'&ATTACHMENT_NAME=&tabId='+GetQueryString("tabId");
                                        }
                                    }else{
                                        convertToAip(1);
                                    }
                                } else {
                                    url = res.object.wordAttUrl;
                                    if(url == ''&&parent.location.href.indexOf('zwClick') > -1){
                                        newWordFile();
                                    }else{
                                        if (fn != undefined) {
                                            fn(url)
                                        }
                                    }

                                }
                            }
                        }else{
                            url = '';
                            if (fn != undefined) {
                                fn(url)
                            }
                        }
                    }
                });
            } else {
                url += "AID=" + GetQueryString("AID");
                url += "&MODULE=" + GetQueryString("MODULE");
                url += "&COMPANY=" + GetQueryString("COMPANY");
                url += "&YM=" + GetQueryString("YM");
                url += "&ATTACHMENT_ID=" + GetQueryString("ATTACHMENT_ID");
                url += "&ATTACHMENT_NAME=" + GetQueryString("ATTACHMENT_NAME");

                if(GetQueryString("documentEditPriv")==0&&GetQueryString("documentEditPriv")!=""){
                    documentEditPriv = 0;
                }else{
                    documentEditPriv = 1;
                }

                if (fn != undefined) {
                    if(location.href.indexOf('isOld=1') > -1){
                        url += '&isOld=1'
                    }
                    fn(url)
                }
            }
        }

    }
    var fileType = 'doc';
    function initWord(url) {
        $('.base_menu_li').css('display', 'block');
        $('.file_menu_li').css('display', 'none');
        $('.sign_menu_li').css('display', 'none');
        $('.wordFormDiv').css('display', 'block');
        $('.aipFormDiv').css('display', 'none');
        $('.left_side').css('visibility','visible');
        try{
            if (url != undefined && url != '' && url != 'undefined') {
                var fileName = GetQueryString("ATTACHMENT_NAME");
                var fomat = GetQueryString("fomat")||'';
                if(fileName==undefined||fileName==''){
                    var p = url.split("&");
                    for(var i=0,length=p.length;i<length;i++){
                        if(p[i].indexOf('ATTACHMENT_NAME')>=0){
                            fileName =p[i].substring(p[i].indexOf("=")+1,p[i].length);
                        }
                    }
                }
                fileType = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length);
                if(location.href.indexOf('isOld=1') > -1){
                    var fileUrl = url;
                }else{
                    var fileUrl = encodeURI(url).split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
                }

                if(fileType == ''){
                    fileType = fomat;
                }
                var session = getCookie('redisSessionId');
                fileUrl += '&JSESSIONID1='+session;
                if(fileType=="doc"||fileType=="docx"||fomat=="doc"||fomat=="docx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+fileUrl.replace(/#/g, '%2523'), 'doc');
                }else if(fileType=="xls"||fileType=="xlsx"||fomat=="xls"||fomat=="xlsx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+fileUrl.replace(/#/g, '%2523'), 'xls');
                }else if(fileType=="ppt"||fileType=="pptx"||fomat=="ppt"||fomat=="pptx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+fileUrl.replace(/#/g, '%2523'), 'ppt');
                }else if(fileType=="wps"||fomat=="wps"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+fileUrl.replace(/#/g, '%2523'), 'wps');
                }else{
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+fileUrl.replace(/#/g, '%2523'), 'doc');
                }

                if (documentEditPriv == 0) {
                    // 隐藏菜单
                    $('.menu_ul').css("display", "none");
                    // 禁用编辑
                }else if (documentEditPriv == 1){
                    if(GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'document'&&documentEditPrivDetail.indexOf('1010') > -1){
                        $('#dayin').show();
                    }else{
                        $('#dayin').hide();
                    }
                    if(ntType != undefined && ntType == '1'){
                        $('#liuhen').show();
                        $('#buliuhen').show();
                    }

                    // 根据产品开发文档需求修改位默认留痕
                    $('.oper1003').addClass('hoverClass');
                    $('.oper1005').addClass('hoverClass');
                    TANGER_OCX_OBJ.SetTrackRevisions(1);
                    TANGER_OCX_OBJ.ShowRevisions(1);

                    if(documentEditPrivDetail!=''&&documentEditPrivDetail!=undefined){
                        var detailArr = documentEditPrivDetail.split(",");
                        for(var i=0;i<detailArr.length;i++){
                            if(detailArr[i]!=''&&detailArr[i]!=undefined&&detailArr[i]!='undefined'){
                                if(detailArr[i]==1007||detailArr[i]=="1007"){
                                    $('.oper1003').addClass('hoverClass');
                                    $('.oper1005').addClass('hoverClass');
                                    TANGER_OCX_OBJ.SetTrackRevisions(1);
                                }else{                                          // 保存按钮if(detailArr[i]==1001||detailArr[i]=="1001")
                                    $('.oper'+detailArr[i]).css("display","block");
                                }
                            }
                        }
                        if($('.oper1001').is(':hidden')){
                            $('.oper1001').remove();
                        }else if($('.oper3003').is(':hidden')){
                            $('.oper3003').remove();
                        }
                    }
                }
            }else {
                if(documentEditPrivDetail != undefined&&documentEditPrivDetail.indexOf('3001') > -1){
                    $('.menu_ul_li').hide();$('.base_menu_li').eq(0).show();$('.oper3001').show()
                }
                $('.right_side').hide();

            }
            TANGER_OCX_OBJ.HideMenuItem(0x01 + 0x02 + 0x04 + 0x10 + 0x20 + 0x1000 + 0x800000 + 0x4000);

            var userName = $('#userNameBox').val();
            if(userName == undefined||userName == ''){
                userName = decodeURI(getCookie('userName'));
            }
            TANGER_OCX_OBJ.SetCurrUserName(userName);
            TANGER_OCX_OBJ.ShowRevisions(1)

            /***************针对岭南师范提出的公文正文全局都要强制留痕 SARRT************************/
            /************ TrackRevisions('true');$('.oper1003').css("display","none");$('.oper1004').css("display","none");$('.oper1005').css("display","none");$('.oper1006').css("display","none"); *****************/
            /***************针对岭南师范提出的公文正文全局都要强制留痕   END************************/
        }catch(e){
            console.log(e)
            if(documentEditPrivDetail != undefined&&documentEditPrivDetail.indexOf('3001') > -1){
                $('.menu_ul_li').hide();$('.base_menu_li').eq(0).show();$('.oper3001').show()
            }
            if(userAgent.indexOf('QtWebEngine') > -1){
                if(url != ''){
                    window.open(parent.location.href+'&ie_open=yes&IE=1&zwClick')
                    parent.window.close()
                }
                $('.right_side').hide();
                $('.rightIcon').show();
            }
        }

    }


    /*
     *  func 从url套红功能
     *  string URL 必选  远程模板文件URL
     *  bool [IsConfirmConversions] 当模板文件不是WORD类型时，是否提示转换，默认true
     * */
    function red_chromatography_url(url,type) {//套红可用，加载服务器资源下的，路径如下
        if (url == undefined || url == '' || url == 'undefined') {
            alert("套红模板地址错误");
        }else {
            TANGER_OCX_OBJ.SetFieldValue("zhengwen", "", "::ADDMARK::")
            TANGER_OCX_OBJ.SetFieldValue("zhengwen", window.location.protocol +'//'+  window.location.host + encodeURI(url), "::FILE::");
        }
    }
    /*
    * 定稿功能，退出保留痕迹
    * 不显示修订状态
    * */
    function finalized(){
        $('.oper1003').removeClass('hoverClass');
        $('.oper1005').removeClass('hoverClass');
        TANGER_OCX_OBJ.SetTrackRevisions(0);
        TANGER_OCX_OBJ.ShowRevisions(0);
    }
    /*
     * 进入或者退出保留痕迹
     * bool vbool 是否保留痕迹
     * */
    function TrackRevisions(vbool,e) {
        if(e.hasClass('hoverClass')){
            e.removeClass('hoverClass');
            vbool = false;
        }else{
            e.addClass('hoverClass');
            $('.oper1005').addClass('hoverClass');
            vbool = true;
        }
        if (vbool) {
            console.log('<fmt:message code="common.th.stayMark" />');/*留痕*/
        } else {
            console.log('<fmt:message code="common.th.notStayMark" />');/*不留痕*/
        }
        TANGER_OCX_OBJ.SetTrackRevisions(1);
        if (vbool) {
//            TANGER_OCX_OBJ.SetTrackRevisions(4);
        }else{
            TANGER_OCX_OBJ.SetTrackRevisions(0);
        }
    }

    /*
     * 强制进入或者退出保留痕迹
     * bool vbool 是否保留痕迹
     * */
    function EnterRevisionMode(flag,e) {
        if(e.hasClass('hoverClass')){
            e.removeClass('hoverClass');
            flag = false;
        }else{
            e.addClass('hoverClass');
            flag = true;
        }
        if (flag) {
            console.log('<fmt:message code="common.th.showTraces" />');/*显示痕迹*/
            TANGER_OCX_OBJ.ShowRevisions(1);
        } else {
            console.log('<fmt:message code="common.th.hideTraces" />');/*隐藏痕迹*/
            TANGER_OCX_OBJ.ShowRevisions(0);
        }

    }

    /*
     * 该函数使用HTTP协议将文件保存到URL
     * string URL 处理后台保存的URL地址
     * String FileFieldName 控件文件域名称
     * string FileName 文件名
     * bool IsShowUI 是否显示进度条
     * return 提交URL之后从服务器返回的数据
     * */
    function SaveToURL() {
        var newWordName = '正文.doc';
        var tabId = GetQueryString("tabId");
        if(GetQueryString("runId") != '') {
            // 工作流-正文时，获取流程名；文件柜或者其他模块不需要获取文件名
            $.ajax({
                url: '/flowUtil/flowAttachDocumentTitle',
                type: 'GET',
                dataType: 'json',
                data: { runId: GetQueryString("runId") },
                async: false,
                success: function (res) {
                    if (res.flag) {
                        newWordName = res.object + '.doc'
                    }
                }
            })
        }

        var session = getCookie('redisSessionId');
        if(url != undefined && url.indexOf('&MODULE=template&') > -1) {
            TANGER_OCX_OBJ.HttpInit(); //初始化HTTP引擎
            TANGER_OCX_OBJ.HttpAddPostCurrFile("file","newWord");
            var json = TANGER_OCX_OBJ.HttpPost(location.protocol +"//"+location.host+"/flow/docUploadFile?id=" + tabId + "&fileType=1&module=document"+'&JSESSIONID1='+session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs+'&runName='+newWordName);
            json = eval('(' + json + ')');
            if (json != undefined) {
                url = json.datas[0].attUrl;
                saveType = 0;
            } else {
                alert('文件保存失败！');
            }
        }
        if (url != undefined && url != '' && url != 'undefined') {
            TANGER_OCX_OBJ.HttpInit(); //初始化HTTP引擎
            TANGER_OCX_OBJ.HttpAddPostCurrFile("file",'');
            var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';

            var json = TANGER_OCX_OBJ.HttpPost(location.protocol +"//"+location.host+"/uploadCover?" + encodeURI(fileUrl).replace(/#/g, '%2523')+'&JSESSIONID1='+session+'&id='+tabId+'&saveType='+saveType+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs);
            if("succeed" == json){
                alert('文件保存成功！');
            }else{
                alert('文件保存失败！');
            }
        } else {
            TANGER_OCX_OBJ.HttpInit(); //初始化HTTP引擎
            TANGER_OCX_OBJ.HttpAddPostCurrFile("file","newWord");
            var json = TANGER_OCX_OBJ.HttpPost(location.protocol +"//"+location.host+"/flow/docUploadFile?id=" + tabId + "&fileType=1&module=document"+'&JSESSIONID1='+session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs+'&runName=');
            json = eval('(' + json + ')');
            if (json != undefined && json.flag) {
                alert('文件保存成功！');
                url = json.datas[0].attUrl;
                saveType = 0;
            } else {
                alert('文件保存失败！');
            }
        }

    }

    //打印功能
    function printDoc(flag) {
        console.log('<fmt:message code="global.lang.print" />');/*打印*/
        TANGER_OCX_OBJ.PrintDoc(1);
    }

    // 判断版式文件是否打开成功
    function isOpenSuccess(IsOpen) {
        if (IsOpen != 1) {
            alert('<fmt:message code="common.th.documentFailed" />！');/*打开文档失败*/
        } else if (IsOpen == 1) {
            $('.left_side').css('display', 'block');
            $('.base_menu_li').css('display', 'none');
            $('.file_menu_li').css('display', 'block');
            $('.sign_menu_li').css('display', 'block');
            $('.wordFormDiv').css('display', 'none');
            $('.aipFormDiv').css('display', 'block');
            if (documentEditPriv == 0) {
                $('.file_menu_li').css('display', 'none');
            }else if(documentEditPriv == 1){
                if(documentEditPrivDetail!=''&&documentEditPrivDetail!=undefined){
                    var detailArr = documentEditPrivDetail.split(",");
                    for(var i=0;i<detailArr.length;i++){
                        if(detailArr[i]!=''&&detailArr[i]!=undefined&&detailArr[i]!='undefined'){
                            $('.oper'+detailArr[i]).css("display","block");
                        }
                    }
                }
            }
        }
        /*ifHiddenLeft();*/
    }

    // 转换成版式文件
    function convertToAip(type) {
        fileType = 'aip';
        if($('#HWPostil1').length == 0){
            djfn();
        }
        var session = getCookie('redisSessionId');
        AipObj = document.getElementById("HWPostil1");
        if (type == 1) {
            var IsOpen = AipObj.LoadFileEx(location.protocol +"//"+location.host+"/download?" + url, "", 0, 0);
            isOpenSuccess(IsOpen);
        } else if (type == 2) {
            var IsOpen = AipObj.LoadFileEx(location.protocol +"//"+location.host+"/download?" + url, "", 0, 0);
            isOpenSuccess(IsOpen);
            AipObj.HttpInit(); //初始化HTTP引擎
            AipObj.HttpAddPostCurrFile("file");
            //  str +
            var json = AipObj.HttpPost(location.protocol +"//"+location.host+"/flow/fileUpload?module=document&JSESSIONID1="+session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs);
            json = eval('(' + json + ')');
            if (json != undefined) {
                if (json.flag) {
                    url = json.datas[0].attUrl;
                    url = encodeURI(url);
                    $.ajax({
                        url: "/document/updateDoc",
                        type: "post",
                        dataType: "json",
                        data: {
                            id: GetQueryString("tabId"),
                            mainAipFileName: json.datas[0].attStrName,
                            mainAipFile: json.datas[0].attStrId
                        },
                        success: function (res) {
                            // console.log(res);
                        }
                    });
                }
            }
        } else if (type == 3) {
            SaveToURL();
            var IsOpen = AipObj.LoadFileEx(location.protocol +"//"+location.host+"/download?" + url, "", 0, 0);
            isOpenSuccess(IsOpen);
            AipObj.HttpInit(); //初始化HTTP引擎
            AipObj.HttpAddPostCurrFile("file");
            var json = AipObj.HttpPost(location.protocol +"//"+location.host+"/flow/fileUpload?module=document&JSESSIONID1="+session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs);
            json = eval('(' + json + ')');
            if (json != undefined) {
                if (json.flag) {
                    url = json.datas[0].attUrl;
                    url = encodeURI(url);
                    $.ajax({
                        url: "/document/updateDoc",
                        type: "post",
                        dataType: "json",
                        data: {
                            id: GetQueryString("tabId"),
                            mainAipFileName: json.datas[0].attStrName,
                            mainAipFile: json.datas[0].attStrId
                        },
                        success: function (res) {
                            // console.log(res);
                        }
                    });
                }else{
                    alert('转版式文件失败！');
                }
            }else{
                alert('转版式文件失败！');
            }
        }
        /*ifHiddenLeft();*/

    }
    //PDF正文下载、WORD正文下载
    function downPdfOrWord(type) {
        // 请求接口 设置附件回显到公告附件
        $.get('/flowUtil/flowAttachDocOrPdf',{
            runId:GetQueryString("runId"),
            module:"notify",
            type:type
        },function (res) {
            var data = res.obj;
            // window.location.href="/download?'+encodeURI(data[i].attUrl)";
            var str = '';
            for (var i = 0; i < data.length; i++) {
                str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a href="/download?'+encodeURI(data[i].attUrl)+'" class="ATTACH_a" style="color: #2b7fe0;" NAME="'+data[i].attachName+'*" href="javascript:;"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
            }
            $('#fileAll').append(str);
            $('.ATTACH_a').click()
        })
    }
    /**
     * 删除PDF
     */
    function deletePdf() {
        if (confirm('确定删除PDF正文？')) {
            $.get('/document/delPDF',{ runId: GetQueryString("runId") },function (res) {
                if(res.flag){
                    window.location.reload(true);
                }else{
                    alert({content:'删除失败！', icon:2 });
                }
            })
        }


    }
    /**
     * pdf盖章功能
     */
    function makeSign(){
        alert('PDF盖章功能，请使用谷歌浏览器或者双核浏览器如360浏览器切换至极速模式！')
    }
    function ToPDF() {
        alert('转PDF版式文件功能点聚WebOffice插件不支持，请前往系统管理-电子文件设置-文档设置-使用软航NTKO插件打开正文！')
    }
    // 盖章和手写 参数说明：doaction	操作类型：0 盖章，1 手写
    function Handwriting(doaction) {
        var islogin = AipObj.Login("", 1, 65535, "", "");
        if (islogin != 0) {
            return islogin;
        } else {
            if (doaction == 0) {
                AipObj.CurrAction = 2568;
            } else if (doaction == 1) {
                AipObj.CurrAction = 264;
            }
        }
    }

    // 版式文件保存
    function saveAip() {
        AipObj.HttpInit(); //初始化HTTP引擎
        AipObj.HttpAddPostCurrFile("file");
        var ispost = AipObj.HttpPost("/uploadCover?" + url+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs); //上传数据。
    }

    // 版式文件aip下载
    function downloadAip() {
        window.open("/download?" + url);
    }

    // 版式文件aip打印
    function aip_print() {
        var isprint = AipObj.PrintDoc(1, 1);
        if (isprint == 0) {
            alert('<fmt:message code="common.th.printFailed" />！');/*打印失败*/
        }
    }

    // 版式文件删除
    function aip_delete() {
        AipObj.CloseDoc(0);
        // 删除版式文件
        $.ajax({
            url: "/delete?" + url,
            type: "get",
            dataType: "json",
            success: function (res) {
                // console.log(res);
                if (res.flag) {
                    // 删除后更新
                    $.ajax({
                        url: "/document/updateDoc",
                        type: "post",
                        dataType: "json",
                        data: {
                            id: GetQueryString("tabId"),
                            mainAipFileName: "",
                            mainAipFile: ""
                        },
                        success: function (res) {
                            // console.log(res);
                            if (res.flag) {
                                alert('<fmt:message code="workflow.th.delsucess" />');/*删除成功*/
                                // 重新加载
                                initUrl(function (url) {
                                    initWord(url)
                                });
                            }
                        }
                    });
                }
            }
        });
    }

    //删除文件函数
    function deleteFile(name) {
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (fso.FileExists(name))
            fso.DeleteFile(name);
        else {
            return false;
        }
    }

</script>
<script type="text/javascript">
    var paraValue = false;
    var paraV = '2';
    $(function () {
        if(officeType != undefined && officeType == '1'){
            $('.baseOprMenu').html('Office文档')
        }else{
            $('.baseOprMenu').html('Word正文')
        }
        if(parent.location.href.indexOf('/workflow/work/workformPreView?') > -1){
            documentEditPriv = 1;
            documentEditPrivDetail = '1005,1010,3007';
        }else{
            // 权限获取
            if(GetQueryString("documentEditPriv")==0&&GetQueryString("documentEditPriv")!=""){
                documentEditPriv = 0;
            }else{
                documentEditPriv = 0;
                if(parent.globalData != undefined&&parent.globalData.flowProcesses != undefined){
                    documentEditPriv = parent.globalData.flowProcesses.documentEditPriv;
                    if(documentEditPriv == 1){
                        documentEditPrivDetail = parent.globalData.flowProcesses.documentEditPrivDetail||'';
                    }
                }else{
                    documentEditPriv = 1;
                    documentEditPrivDetail = '1001,1003,1005,1010';
                }
            }
        }

        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 2||res.object[0].paraValue == 3){
                        // 处理设置查阅通过WPS或onlyOffice插件加载正文word的功能
                        paraV = res.object[0].paraValue;
                        paraValue = true;
                    }
                }
            },
            error:function(xhr){
            }
        })
        initUrl(function (url) {
            initWord(url);
        });

        // 选择套红模板
        $('.select_red_li').click(function () {
            if($(this).hasClass('oper1002')){
                var type= '';
            }else{
                var type= '?type=1';
            }
            $.popWindow('/template/redTemplateSelect'+type);
        });


        // 通用判断方法
        var fileName = GetQueryString("ATTACHMENT_NAME");
        var point = fileName.lastIndexOf(".");
        var type = fileName.substr(point);
        // 判断是否是word文件
        if (type == '.doc' || type == '.docx') {
            $('.base_menu_li').eq(0).css('display', 'block');
            $('.file_menu_li').css('display', 'none');
            $('.sign_menu_li').css('display', 'none');
        } else if (type == '.aip') {
            $('.base_menu_li').css('display', 'none');
            $('.file_menu_li').css('display', 'block');
            $('.sign_menu_li').css('display', 'block');
        }
    });

    function parentZhuanjiaoBtn(){
        if (fileType == 'aip'||fileType == 'AIP') {
            if($('.oper3003').length != 0){
                saveAip();
            }
        }else if(fileType == 'doc'||fileType == 'DOC'||fileType == 'docx'||fileType == 'DOCX'||fileType == 'xls'||fileType == 'XLS'
            ||fileType == 'xlsx'||fileType == 'XLSX'||fileType == 'ppt'||fileType == 'PPT'
            ||fileType == 'pptx'||fileType == 'PPTX'){
            if($('.oper1001').length != 0 && !$('.oper1001').is(':hidden')){
                SaveToURL();
            }
        }
    }

    function getUrlString(name, url) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        re = new RegExp("amp;", "g"); //定义正则表达式
        var r = url.match(reg);
        var context = "";
        if (r != null)
            context = r[2];
        reg = null;
        r = null;
        return context == null || context == "" || context == "undefined" ? "" : context;
    }

    function ifHiddenLeft() {
        var flag = GetQueryString('hidden');
        if(flag||flag=='true'){
            $('.left_side').css("display","none");
        }
    }

    function showRight(){
        $('.right_side').css("display","block");
        $('.rightIcon').hide();
    }

    function hiddenRight(){
        $('.right_side').css("display","none");
        $('.rightIcon').show();
    }

    function wordUpload() {
        $('input[name="id"]').val(GetQueryString("tabId"));
        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                if(!res.flag) {
                    layer.msg(res.msg,{icon:2})
                    return
                }
                url = res.datas[0].attUrl;
                // url = encodeURI(url);
                var data = {
                    id: GetQueryString("tabId")
                }
                var attStrId = res.datas[0].attStrId;
                var attStrName = res.datas[0].attStrName;

                // 获取文件后缀
                var type = attStrName.split(/\.(?![^\.]*\.)/)[1].toUpperCase();
                if(isOpenSanyuan && type != "PDF") {
                    layer.msg("开启三员管理后只能上传PDF格式文件",{icon:2});
                    return
                }
                $('.right_side').show();
                $('.rightIcon').hide();
                if(type=="PDF"){
                    data['mainAipFile'] = attStrId;
                    data['mainAipFileName'] = attStrName;
                } else {
                    data['mainFile'] = attStrId;
                    data['mainFileName'] = attStrName;
                }

                if(type=="DOCX" || type=="DOC") {
                    mainClearAttUrl = '';
                    saveType = 0;
                    if(userAgent.indexOf('QtWebEngine') > -1){
                        window.open(parent.location.href+'&ie_open=yes&IE=1&zwClick')
                        parent.window.close()
                    }else{
                        initWord(url);
                    }
                } else {
                    // 上传pdf文件清空word文件
                    $.post('/document/setMainFile', {id: GetQueryString("tabId")}, function(res){
                        if (res.flag) {
                            // 重新加载正文模板
                            var iframeUrl = $('#zw', parent.document).attr('src') + '&date=' + new Date().getTime();
                            $('#zw', parent.document).attr('src', iframeUrl);
                        }
                    });
                }
            }
        });
    }
    /**
     * 新建word文件
     */
    function newWordFile() {
        $('input[name="id"]').val(GetQueryString("tabId"));
        myPromiseGet('/outDocument/doNewFile', {
            model: 'document',
            tableId: GetQueryString("tabId")
        }).then(function (value) {
            var res = value;
            url = res.object.attUrl+'&ATTACHMENT_NAME=' + res.object.attachName || '';
            mainClearAttUrl = '';
            saveType = 0;
            $('.right_side').show();
            $('.rightIcon').hide();
            if(userAgent.indexOf('QtWebEngine') > -1){
                window.open(parent.location.href+'&ie_open=yes&IE=1&zwClick')
                parent.window.close()
            }else{
                initWord(url);
            }
        }).catch(function(reason) {
            console.log(reason);
            if(myBrowser.indexOf('IE') > -1){
                alert('新建word文件失败，请重试！')
            }else{
                $.layerMsg({content: '新建word文件失败，请重试！', icon: 2});
            }
        })
    }
    function aipUpload() {
        $('#uploadAipForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                url = res.datas[0].attUrl;
                url = encodeURI(url);
                convertToAip(2);
            }
        });
    }



/****************************************************
*
*			关闭页面时调用此函数，关闭文件
*
****************************************************/
function window_onunload() {
    var flag = notCopy();
    if(flag){
        var msg="是否保存文件内容？"
        if(window.confirm(msg)){
            SaveToURL();
        }
        try{
            TANGER_OCX_OBJ.CloseDoc(0);
        }catch(e){
            alert("释放WORD控件异常，请使用任务管理器结束Microsoft WORD进程 \r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
        }
    }
}


</script>


</body>
</html>
