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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="renderer" content="ie-comp">
    <title>查阅</title><%--查阅--%>
    <script type="text/javascript" src="/js/common/watermark.js?20220317.1"></script>
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

        .left_side, .right_side {
            float: left;
        }

        .left_side {
            width: 14%;
            height: 100%;
            box-shadow: 2px 6px 12px #888888;
            background-color: #f5f7f8;
        }

        .right_side {
            width: 100%;
            height: 100%;
        }

        #EnterRevisionMode option {
            height: 36px;
        }

        .wordFormDiv {
            width: 100%;
            height: 100%;
            margin-left: 0px;
        }

        .menu_ul {
            padding: 0;
            margin: 10px 0px 0px 20px;
        }

        .menu_ul_li {
            list-style: none;
            cursor: pointer;
            padding: 10px 10px 10px 10px;
            /*display: none;*/
        }

        .menu_ul_li ul {
            list-style: none;
            padding-left: 0px;
        }

        .menu_ul_li ul li {
            list-style: none;
            padding: 8px 1px;
        }

        .menu_ul_li ul li img {
            vertical-align: middle;
            margin-left: 22px;
        }

        .menu_ul_li ul li span {
            font-size: 14px;
            margin-left: 8px;
            line-height: 16px;
            vertical-align: middle;
        }

        .menu_ul_li ul li:hover {
            background-color: #ccebff;
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
    </style>
</head>

<body>
<div style="display:none">
    <form id="uploadForm" action="../flow/fileUpload" enctype="multipart/form-data" method="post">
        <a href="javascript:;" class="file"><%--选择文件--%><fmt:message code="system.th.Select" />
            <input id="fileUpload" type="file" name="file">
        </a>
        <input type="hidden" name="module" value="document">
    </form>
    <form id="uploadAipForm" action="../flow/fileUpload" enctype="multipart/form-data"
          method="post">
        <a href="javascript:;" class="file"><%--选择版式文件--%><fmt:message code="common.th.SelLayoutFile" />
            <input id="fileUploadAip" type="file" name="file">
        </a>
        <input type="hidden" name="module" value="document">
    </form>
</div>

<div class="wrap" id="wrap">
    <div class="left_side" style="display: none;">
        <ul class="menu_ul">
            <li class="menu_ul_li base_menu_li">
                <span class="baseOprMenu"><fmt:message code="common.th.wordText" /></span><%--WORD正文--%>
                <ul class="baseOprMenuUl">
                    <li class="oper oper1001" onclick="initFun();" style="display: inline-block"><img src="../img/document/word_aip/icon_save.png"/><span>打开文件按钮</span><%--保存--%>
                    </li>
                    <li class="oper oper1002" class="select_red_li"><img
                            src="../img/document/word_aip/icon_taohong_16.png"/><span><fmt:message code="common.th.setRed" /></span><%--套红--%>
                    </li>
                    <li class="oper oper1003" onclick="TrackRevisions(true)"><img
                            src="../img/document/word_aip/icon_mark_19.png"/><span><fmt:message code="common.th.stayMark" /></span></li><%--留痕--%>
                    <li class="oper oper1004" onclick="TrackRevisions(false)"><img src="../img/document/word_aip/icon_markless_22.png"/><span><fmt:message code="common.th.notStayMark" /></span><%--不留痕--%>
                    </li>
                    <li class="oper oper1005" onclick="EnterRevisionMode(true)"><img src="../img/document/word_aip/icon_showmark.png"/><span><fmt:message code="common.th.showTraces" /></span><%--显示痕迹--%>
                    </li>
                    <li class="oper oper1006" onclick="EnterRevisionMode(false)"><img src="../img/document/word_aip/icon_unshow.png"/><span><fmt:message code="common.th.hideTraces" /></span><%--隐藏痕迹--%>
                    </li>
                    <li class="oper oper3001" onclick="chooseWord();">
                        <img src="../img/document/word_aip/icon_uploading_32.png"/><span><fmt:message code="common.th.uploadWord" /></span><%--上传WORD--%>
                    </li>
                    <li class="oper oper3002" onclick="chooseAip();">
                        <img src="../img/document/word_aip/icon_uploading_32.png"/><span><fmt:message code="common.th.uploadLayoutFile" /></span><%--上传版式文件--%>
                    </li>
                    <li class="oper oper3003" onclick="convertToAip(3)"><img
                            src="../img/document/word_aip/icon_template_03.png"/><span><fmt:message code="common.th.transferFile" /></span></li><%--转版式文件--%>
                </ul>
            </li>
            <li class="menu_ul_li file_menu_li">
                <span class="fileMenu"><fmt:message code="common.th.layoutText" /></span><%--版式正文--%>
                <ul class="fileMenuUl">
                    <li class="oper oper2001" onclick="saveAip();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span></li><%--保存--%>
                    <li class="oper oper2002" onclick="downloadAip()"><img
                            src="../img/document/word_aip/icon_download_07.png"/><span><fmt:message code="file.th.download" /></span></li><%--下载--%>
                    <li class="oper oper2003" onclick="aip_print();"><img src="../img/document/word_aip/icon_print_07.png"/><span><fmt:message code="global.lang.print" /></span><%--打印--%>
                    <li class="oper oper2004" onclick="aip_delete();"><img src="../img/document/word_aip/icon_delete_35.png"/><span><fmt:message code="global.lang.delete" /></span><%--删除--%>
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
        </ul>
    </div>
    <div class="right_side" style="width: 100%;">
        <div class="wordFormDiv" style="display: block">
            <div style="display: none" class="no-control-msg"><img src="/img/document/word_aip/icon_err_msg_03.png" ><SPAN>office文档在线阅读、编辑功能需要安装浏览器插件，请<a href="../lib/officecontrol/WebOffice.exe" class="downCJ">下载安装插件</a>，安装后请点击刷新按钮</SPAN><a href="javascript:void(0)" onclick="location.reload()">点击刷新</a></div>
            <form>
                <script type="text/javascript" src="../lib/officecontrol/LoadWebOffice.js?20190925.1"></script>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
<script type="text/javascript" src="../js/jquery/jquery.form.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
<script type="text/javascript" src="../js/base/base.js" charset="utf-8"></script>
<script src="/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript">
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
    // $.ajax({
    //     url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
    //     type:'post',
    //     datatype:'json',
    //     success: function (res) {
    //         if(res.flag){
    //             if(res.object[0].paraValue == 0){
    //                 //默认加载NTKO插件 进行跳转
    //                 location.href = location.href.split('/common/webOfficeView')[0]+'/common/ntkoview'+location.href.split('/common/webOfficeView')[1];
    //             }
    //         }
    //         $('body').show();
    //     },error:function(XMLHttpRequest, textStatus, errorThrown){
    //         $('body').show();
    //     }
    // });
    $('body').show();
    window.onload=function(){
        initUrl(function (url) {
            initWord(url);
            window.onbeforeunload=window_onunload;
        });
    };
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
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        document.getElementById("wrap").style.height= winHeight +"px";
    }
    autodivheight();
    window.onresize = function(){
       location.reload();
    }
    var TANGER_OCX_OBJ = document.getElementById("WebOffice");
    var url = "";

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
            $('.no-control-msg').show()
            $('.wordFormDiv form').remove();
            return false;
        }
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

    // 从url获取文档
    function initUrl(fn) {
        var flag = notCopy();
        if(flag){
            if (GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'document') {
                $.ajax({
                    url: "/document/selectDocById",
                    type: "get",
                    dataType: "json",
                    data: {id: GetQueryString("tabId"), randomNum: Math.random()},
                    success: function (res) {
                        if (res.flag) {
                            if (res.object.aipAttUrl != undefined && res.object.aipAttUrl != '') {
                                url = res.object.aipAttUrl;
                                url = encodeURI(url);
                                convertToAip(1);
                            } else {
                                url = res.object.wordAttUrl;
                                url = encodeURI(url);
                                if (fn != undefined) {
                                    fn(url)
                                }
                            }
                        }
                    }
                });
            }else if(GetQueryString("networkHardDisk") == '1'){
                var thisFileName = GetQueryString("fileName");
                url += '/netdisk/xs?path=' + GetQueryString("path")+ '&diskId=' + GetQueryString("diskId");
                if (fn != undefined) {
                    fn(url)
                }
            }else{
                url += "AID=" + GetQueryString("AID");
                url += "&MODULE=" + GetQueryString("MODULE");
                url += "&COMPANY=" + GetQueryString("COMPANY");
                url += "&YM=" + GetQueryString("YM");
                url += "&ATTACHMENT_ID=" + GetQueryString("ATTACHMENT_ID");
                url += "&ATTACHMENT_NAME=" + GetQueryString("ATTACHMENT_NAME");

                if (fn != undefined) {
                    if(location.href.indexOf('isOld=1') > -1){
                        url += '&isOld=1'
                    }
                    fn(url)
                }
            }
        }

    }

    function initWord(url) {
        if (url != undefined && url != '' && url != 'undefined') {
            var fileName = GetQueryString("ATTACHMENT_NAME");
            var fomat = GetQueryString("fomat")||'';
            var networkHardDisk = GetQueryString("networkHardDisk")||'';
            url += '&time='+(new Date()).valueOf();
            var session = getCookie('redisSessionId');
            url += '&JSESSIONID1='+session;
            if(networkHardDisk == '1'){
                var session = getCookie('redisSessionId');
                url += '&JSESSIONID1='+session;
                if(fomat=="doc"||fomat=="docx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+url, 'doc');
                }else if(fomat=="xls"||fomat=="xlsx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+url, 'xls');
                }else if(fomat=="ppt"||fomat=="pptx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+url, 'ppt');
                }else if(fomat=="wps"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+url, 'wps');
                }else{
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+url, 'doc');
                }
            }else{
                if(fileName == undefined||fileName == ''){
                    var p = url.split("&");
                    for(var i=0,length=p.length;i<length;i++){
                        if(p[i].indexOf('ATTACHMENT_NAME')>=0){
                            fileName =p[i].substring(p[i].indexOf("=")+1,p[i].length);
                        }
                    }
                }
                var fileType = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length);
                if(fileType == ''){
                    fileType = fomat;
                }
                if(fileType=="doc"||fileType=="docx"||fomat=="doc"||fomat=="docx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+url, 'doc');
                }else if(fileType=="xls"||fileType=="xlsx"||fomat=="xls"||fomat=="xlsx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+url, 'xls');
                }else if(fileType=="ppt"||fileType=="pptx"||fomat=="ppt"||fomat=="pptx"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+url, 'ppt');
                }else if(fileType=="wps"||fomat=="wps"){
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+url, 'wps');
                }else{
                    TANGER_OCX_OBJ.LoadOriginalFile(location.protocol +"//"+location.host+"/download?"+url, 'doc');
                }
            }
        }else {
            TANGER_OCX_OBJ.LoadOriginalFile("", 'doc');
        }
        TANGER_OCX_OBJ.HideMenuItem(0x01 + 0x02 + 0x04 + 0x10 + 0x20 + 0x1000 + 0x800000 + 0x4000);

        /*// 禁用编辑
         TANGER_OCX_OBJ.SetReadOnly(true, "123456");*/

    }
    function initFun(){
        initUrl(function (url) {
            initWord(url);
        });
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

/****************************************************
*
*			关闭页面时调用此函数，关闭文件 
*
****************************************************/


function window_onunload() {
    var flag = notCopy();
    if(flag){
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
