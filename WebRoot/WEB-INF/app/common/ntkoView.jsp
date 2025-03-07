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
    <title>Office文档查阅</title><%--查阅--%>

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

        #wordFormDiv {
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
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../lib/officecontrol/ntko-linux.js"></script>
    <script type="text/javascript" src="/js/common/watermark.js?20220317.1"></script>
</head>

<body>
<div style="display:none">
    <%--<form id="uploadForm" action="../flow/fileUpload" enctype="multipart/form-data" method="post">
        <a href="javascript:;" class="file">&lt;%&ndash;选择文件&ndash;%&gt;<fmt:message code="system.th.Select" />
            <input id="fileUpload" type="file" name="file">
        </a>
        <input type="hidden" name="module" value="document">
    </form>
    <form id="uploadAipForm" action="../flow/fileUpload" enctype="multipart/form-data"
          method="post">
        <a href="javascript:;" class="file">&lt;%&ndash;选择版式文件&ndash;%&gt;<fmt:message code="common.th.SelLayoutFile" />
            <input id="fileUploadAip" type="file" name="file">
        </a>
        <input type="hidden" name="module" value="document">
    </form>--%>
</div>

<div class="wrap">
    <%--<div class="left_side">--%>
        <%--<ul class="menu_ul">--%>
            <%--<li class="menu_ul_li base_menu_li">--%>
                <%--<span class="baseOprMenu"><fmt:message code="common.th.wordText" /></span>&lt;%&ndash;WORD正文&ndash;%&gt;--%>
                <%--<ul class="baseOprMenuUl">--%>
                    <%--<li class="oper oper1001" onclick="SaveToURL();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span>&lt;%&ndash;保存&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper1002 select_red_li " ><img--%>
                            <%--src="../img/document/word_aip/icon_taohong_16.png"/><span><fmt:message code="common.th.setRed" /></span>&lt;%&ndash;套红&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper1003" onclick="TrackRevisions(true)"><img--%>
                            <%--src="../img/document/word_aip/icon_mark_19.png"/><span><fmt:message code="common.th.stayMark" /></span></li>&lt;%&ndash;留痕&ndash;%&gt;--%>
                    <%--<li class="oper oper1004" onclick="TrackRevisions(false)"><img src="../img/document/word_aip/icon_markless_22.png"/><span><fmt:message code="common.th.notStayMark" /></span>&lt;%&ndash;不留痕&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper1005" onclick="EnterRevisionMode(true)"><img src="../img/document/word_aip/icon_showmark.png"/><span><fmt:message code="common.th.showTraces" /></span>&lt;%&ndash;显示痕迹&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper1006" onclick="EnterRevisionMode(false)"><img src="../img/document/word_aip/icon_unshow.png"/><span><fmt:message code="common.th.hideTraces" /></span>&lt;%&ndash;隐藏痕迹&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper3001" style="position: relative">--%>
                        <%--<form id="uploadForm" action="../flow/fileUpload" enctype="multipart/form-data" method="post">--%>
                            <%--<img style="position: absolute" src="../img/document/word_aip/icon_uploading_32.png"/><span style="position: absolute;left: 38px;top: 10px;"><fmt:message code="common.th.uploadWord" /></span>&lt;%&ndash;上传WORD&ndash;%&gt;--%>
                            <%--<input title="上传WORD" id="fileUpload" onchange="wordUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
                            <%--<input type="hidden" name="module" value="document">--%>
                        <%--</form>--%>
                    <%--</li>--%>
                    <%--<li class="oper oper3002" style="position: relative">--%>
                        <%--<form id="uploadAipForm" action="../flow/fileUpload" enctype="multipart/form-data"--%>
                              <%--method="post">--%>
                            <%--<img src="../img/document/word_aip/icon_uploading_32.png"/><span  style="position: absolute;left: 38px;top: 10px;"><fmt:message code="common.th.uploadLayoutFile" /></span>&lt;%&ndash;上传版式文件&ndash;%&gt;--%>
                            <%--<input title="上传aip" id="fileUploadAip" onchange="aipUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
                            <%--<input type="hidden" name="module" value="document">--%>
                        <%--</form>--%>
                    <%--</li>--%>
                    <%--<li class="oper oper3003" onclick="convertToAip(3)"><img--%>
                            <%--src="../img/document/word_aip/icon_template_03.png"/><span><fmt:message code="common.th.transferFile" /></span></li>&lt;%&ndash;转版式文件&ndash;%&gt;--%>
                <%--</ul>--%>
            <%--</li>--%>
            <%--<li class="menu_ul_li file_menu_li">--%>
                <%--<span class="fileMenu"><fmt:message code="common.th.layoutText" /></span>&lt;%&ndash;版式正文&ndash;%&gt;--%>
                <%--<ul class="fileMenuUl">--%>
                    <%--<li class="oper oper2001" onclick="saveAip();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span></li>&lt;%&ndash;保存&ndash;%&gt;--%>
                    <%--<li class="oper oper2002" onclick="downloadAip()"><img--%>
                            <%--src="../img/document/word_aip/icon_download_07.png"/><span><fmt:message code="file.th.download" /></span></li>&lt;%&ndash;下载&ndash;%&gt;--%>
                    <%--<li class="oper oper2003" onclick="aip_print();"><img src="../img/document/word_aip/icon_print_07.png"/><span><fmt:message code="global.lang.print" /></span>&lt;%&ndash;打印&ndash;%&gt;--%>
                    <%--<li class="oper oper2004" onclick="aip_delete();"><img src="../img/document/word_aip/icon_delete_35.png"/><span><fmt:message code="global.lang.delete" /></span>&lt;%&ndash;删除&ndash;%&gt;--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</li>--%>
            <%--<li class="menu_ul_li sign_menu_li">--%>
                <%--<span class="signMenu"><fmt:message code="common.th.signature" /></span>&lt;%&ndash;版式签章&ndash;%&gt;--%>
                <%--<ul class="signUl">--%>
                    <%--<li class="oper oper2005" onclick="Handwriting(0)"><img src="../img/document/word_aip/icon_stamp_10.png"/><span><fmt:message code="common.th.stamp" /></span>&lt;%&ndash;盖章&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--<li class="oper oper2006" onclick="Handwriting(1)"><img src="../img/document/word_aip/icon_write_14.png"/><span><fmt:message code="common.th.handwriting" /></span>&lt;%&ndash;手写&ndash;%&gt;--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>
    <div class="right_side">
        <div id="wordFormDiv" style="display: block">
            <form>
                <script type="text/javascript" src="../lib/officecontrol/ntkoofficecontrol.js?20201222.4"></script>
            </form>
        </div>
        <%--<div class="aipFormDiv" style="display: none">--%>
            <%--<OBJECT id='HWPostil1' align='middle' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'--%>
                    <%--classid='clsid:FF1FE7A0-0578-4FEE-A34E-FB21B277D561'--%>
                    <%--codebase='../lib/HWPostil/HWPostil.cab#version=3,1,3,8'></OBJECT>--%>
        <%--</div>--%>
    </div>
</div>
<script src="../js/jquery/jquery.form.min.js"></script>
<script src="../../lib/layer/layer.js?20201106"></script>
<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    var AipObj = document.getElementById("HWPostil1");
    var TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");
    var url = "";
    var documentEditPriv = 0;
    var documentEditPrivDetail = "0";
    var isLinux = (String(navigator.platform).indexOf("Linux") > -1);
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

            if(GetQueryString("documentEditPriv")==0&&GetQueryString("documentEditPriv")!=""){
                documentEditPriv = 0;
            }else{
                documentEditPriv = 1;
                documentEditPrivDetail = "1001";
            }

            if (fn != undefined) {
                fn(encodeURI(url))
            }
        }
    }

    function initWord(url) {
        // 禁止显示菜单栏
        TANGER_OCX_OBJ.Menubar = false;
        // 禁止显示标题栏
        TANGER_OCX_OBJ.TitleBar = false;
        // 初始化url
        //TANGER_OCX_OBJ.Activate == true;
        // if(!isLinux){
        //     if (window.navigator.platform == "Win64") {
        //     TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbase64version, pdfbase64, 51, true);
        //     } else {
        //         TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.0.2", "../lib/officecontrol/ntkooledocall.cab", 51, true);
        //     TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbaseversion, pdfbase, 51, true);
        //     }
        // }
        $('.base_menu_li').css('display', 'block');
        $('.file_menu_li').css('display', 'none');
        $('.sign_menu_li').css('display', 'none');
        $('#wordFormDiv').css('display', 'block');
        $('.aipFormDiv').css('display', 'none');

        if (url != undefined && url != '' && url != 'undefined') {
            var fileName = GetQueryString("ATTACHMENT_NAME");
            var fomat = GetQueryString("fomat")||'';
            var networkHardDisk = GetQueryString("networkHardDisk")||'';
            url += '&time='+(new Date()).valueOf();
            if(networkHardDisk == '1'){
                var session = getCookie('redisSessionId');
                url += '&JSESSIONID1='+session;
                if(fomat=="doc"||fomat=="docx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL(url,true,true,"Word.Document");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                    // 默认隐藏痕迹
                    if(!isLinux){
                        TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
                    }
                }else if(fomat=="xls"||fomat=="xlsx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL(location.protocol +"//"+location.host+url,true,true,"Excel.Sheet");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }else if(fomat=="ppt"||fomat=="pptx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL(location.protocol +"//"+location.host+url,true,true,"PowerPoint.Show");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }else{
                    TANGER_OCX_OBJ.BeginOpenFromURL(location.protocol +"//"+location.host+url,true,true,"Word.Document");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                    // 默认隐藏痕迹
                    if(!isLinux){
                        TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
                    }
                }
            }else{
                if(fileName==undefined||fileName==''){
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
                if(fileType!=undefined&&fileType=="doc"||fileType=="docx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("../download?" + url,true,true,"Word.Document");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                    // 默认隐藏痕迹
                    if(!isLinux){
                        TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
                    }
                }else if(fileType=="xls"||fileType=="xlsx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("../download?" + url,true,true,"Excel.Sheet");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }else if(fileType=="ppt"||fileType=="pptx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("../download?" + url,true,true,"PowerPoint.Show");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }else{
                    TANGER_OCX_OBJ.BeginOpenFromURL("../download?" + url,true,true,"Word.Document");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                    // 默认隐藏痕迹
                    TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
                }
            }
        }else {
            TANGER_OCX_OBJ.CreateNew("word.document");
        }

        if (documentEditPriv == 0) {
            // 隐藏菜单
            $('.menu_ul').css("display", "none");
            if(!isLinux){
                // 禁用编辑
                TANGER_OCX_OBJ.SetReadOnly(true, "123456");
            }
        }else if (documentEditPriv == 1){
            if(documentEditPrivDetail!=''&&documentEditPrivDetail!=undefined){
                var detailArr = documentEditPrivDetail.split(",");
                for(var i=0;i<detailArr.length;i++){
                    if(detailArr[i]!=''&&detailArr[i]!=undefined&&detailArr[i]!='undefined'){
                        if(detailArr[i]==1007||detailArr[i]=="1007"){
                            TANGER_OCX_OBJ.TrackRevisions(true);
                            TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = true;
                        }else{
                            $('.oper'+detailArr[i]).css("display","block");
                        }
                    }
                }
            }
        }



    }


    /*
     *  func 从url套红功能
     *  string URL 必选  远程模板文件URL
     *  bool [IsConfirmConversions] 当模板文件不是WORD类型时，是否提示转换，默认true
     * */
    function red_chromatography_url(url) {//套红可用，加载服务器资源下的，路径如下
        if (url == undefined || url == '' || url == 'undefined') {
            alert("套红模板地址错误");
        }else {
            TANGER_OCX_OBJ.ActiveDocument.Application.Selection.HomeKey(6);
            TANGER_OCX_OBJ.AddTemplateFromURL(encodeURI(url));
        }
    }

    /*
     * 进入或者退出保留痕迹
     * bool vbool 是否保留痕迹
     * */
    function TrackRevisions(vbool) {
        if (vbool) {
            parent.layer.msg('<fmt:message code="common.th.stayMark" />');/*留痕*/
        } else {
            parent.layer.msg('<fmt:message code="common.th.notStayMark" />');/*不留痕*/
        }
        TANGER_OCX_OBJ.TrackRevisions(vbool);
        if (vbool) {
            TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = true;
        }
    }

    /*
     * 强制进入或者退出保留痕迹
     * bool vbool 是否保留痕迹
     * */
    function EnterRevisionMode(flag) {
        if (flag) {
            parent.layer.msg('<fmt:message code="common.th.showTraces" />');/*显示痕迹*/
        } else {
            parent.layer.msg('<fmt:message code="common.th.hideTraces" />');/*隐藏痕迹*/
        }
        try {
            TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = flag;
        } catch (ex) {
            // console.log("显示/隐藏痕迹出错");
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
        if (url != undefined && url != '' && url != 'undefined') {
            layer.msg('<fmt:message code="global.lang.save" />');/*保存*/
            TANGER_OCX_OBJ.SaveToURL("/uploadCover?" + url, "file", "", encodeURI(getUrlString("ATTACHMENT_NAME",url)));
        } else {
            var json = eval('(' +TANGER_OCX_OBJ.SaveToURL("/flow/fileUpload?module=document", "file", "", "newWord.doc")+')');
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
                            mainFile: json.datas[0].attStrId,
                            mainFileName: json.datas[0].attStrName
                        },
                        success: function (res) {
                            // console.log(res);
                        }
                    });
                }
            }
        }

    }

    //打印功能
    function doc_print() {
        layer.msg('<fmt:message code="global.lang.print" />');/*打印*/
        TANGER_OCX_OBJ.PrintPreview();
        TANGER_OCX_OBJ.PrintOut();
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
    <%--function convertToAip(type) {--%>
        <%--if (type == 1) {--%>
            <%--var IsOpen = AipObj.LoadFileEx("../download?" + url, "", 0, 0);--%>
            <%--isOpenSuccess(IsOpen);--%>
        <%--} else if (type == 2) {--%>
            <%--var IsOpen = AipObj.LoadFileEx("../download?" + url, "", 0, 0);--%>
            <%--isOpenSuccess(IsOpen);--%>
            <%--AipObj.HttpInit(); //初始化HTTP引擎--%>
            <%--AipObj.HttpAddPostCurrFile("file");--%>
            <%--//  str +--%>
            <%--var json = eval('(' +AipObj.HttpPost("/flow/fileUpload?module=document")+')'); //上传数据--%>
            <%--if (json != undefined) {--%>
                <%--if (json.flag) {--%>
                    <%--url = json.datas[0].attUrl;--%>
                    <%--url = encodeURI(url);--%>
                    <%--$.ajax({--%>
                        <%--url: "/document/updateDoc",--%>
                        <%--type: "post",--%>
                        <%--dataType: "json",--%>
                        <%--data: {--%>
                            <%--id: GetQueryString("tabId"),--%>
                            <%--mainAipFileName: json.datas[0].attStrName,--%>
                            <%--mainAipFile: json.datas[0].attStrId--%>
                        <%--},--%>
                        <%--success: function (res) {--%>
                            <%--// console.log(res);--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--} else if (type == 3) {--%>
            <%--SaveToURL();--%>
            <%--var IsOpen = AipObj.LoadFileEx("../download?" + url, "", 0, 0);--%>
            <%--isOpenSuccess(IsOpen);--%>
            <%--AipObj.HttpInit(); //初始化HTTP引擎--%>
            <%--AipObj.HttpAddPostCurrFile("file");--%>
            <%--var json = eval('(' +AipObj.HttpPost("/flow/fileUpload?module=document")+')'); //上传数据--%>
            <%--if (json != undefined) {--%>
                <%--if (json.flag) {--%>
                    <%--url = json.datas[0].attUrl;--%>
                    <%--url = encodeURI(url);--%>
                    <%--$.ajax({--%>
                        <%--url: "/document/updateDoc",--%>
                        <%--type: "post",--%>
                        <%--dataType: "json",--%>
                        <%--data: {--%>
                            <%--id: GetQueryString("tabId"),--%>
                            <%--mainAipFileName: json.datas[0].attStrName,--%>
                            <%--mainAipFile: json.datas[0].attStrId--%>
                        <%--},--%>
                        <%--success: function (res) {--%>
                            <%--// console.log(res);--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--}--%>
        <%--/*ifHiddenLeft();*/--%>

    <%--}--%>

    // 盖章和手写 参数说明：doaction	操作类型：0 盖章，1 手写
//    function Handwriting(doaction) {
//        var islogin = AipObj.Login("", 1, 65535, "", "");
//        if (islogin != 0) {
//            return islogin;
//        } else {
//            if (doaction == 0) {
//                AipObj.CurrAction = 2568;
//            } else if (doaction == 1) {
//                AipObj.CurrAction = 264;
//            }
//        }
//    }

    // 版式文件保存
    <%--function saveAip() {--%>
        <%--AipObj.HttpInit(); //初始化HTTP引擎--%>
        <%--AipObj.HttpAddPostCurrFile("file");--%>
        <%--var ispost = AipObj.HttpPost("/uploadCover?" + url); //上传数据。--%>
    <%--}--%>

    // 版式文件aip下载
//    function downloadAip() {
//        window.open("/download?" + url);
//    }

    // 版式文件aip打印
    <%--function aip_print() {--%>
        <%--var isprint = AipObj.PrintDoc(1, 1);--%>
        <%--if (isprint == 0) {--%>
            <%--alert('<fmt:message code="common.th.printFailed" />！');/*打印失败*/--%>
        <%--}--%>
    <%--}--%>

    // 版式文件删除
    <%--function aip_delete() {--%>
        <%--AipObj.CloseDoc(0);--%>
        <%--// 删除版式文件--%>
        <%--$.ajax({--%>
            <%--url: "/delete?" + url,--%>
            <%--type: "get",--%>
            <%--dataType: "json",--%>
            <%--success: function (res) {--%>
                <%--// console.log(res);--%>
                <%--if (res.flag) {--%>
                    <%--// 删除后更新--%>
                    <%--$.ajax({--%>
                        <%--url: "/document/updateDoc",--%>
                        <%--type: "post",--%>
                        <%--dataType: "json",--%>
                        <%--data: {--%>
                            <%--id: GetQueryString("tabId"),--%>
                            <%--mainAipFileName: "",--%>
                            <%--mainAipFile: ""--%>
                        <%--},--%>
                        <%--success: function (res) {--%>
                            <%--// console.log(res);--%>
                            <%--if (res.flag) {--%>
                                <%--alert('<fmt:message code="workflow.th.delsucess" />');/*删除成功*/--%>
                                <%--// 重新加载--%>
                                <%--initUrl(function (url) {--%>
                                    <%--initWord(url)--%>
                                <%--});--%>
                            <%--}--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

    //删除文件函数
//    function deleteFile(name) {
//        var fso = new ActiveXObject("Scripting.FileSystemObject");
//        if (fso.FileExists(name))
//            fso.DeleteFile(name);
//        else {
//            return false;
//        }
//    }

</script>
<script type="text/javascript">
    function autodivheight(){
//        $('.wrap').height(document.documentElement.clientWidth || document.body.clientWidth)
    }
    $(function () {
        autodivheight()
        /*alert($(document).height());

        $(".wrap").height($(document).height());*/
        // 权限获取
        if(GetQueryString("documentEditPriv")==0&&GetQueryString("documentEditPriv")!=""){
            documentEditPriv = 0;
            // 默认初始化
            initUrl(function (url) {
                initWord(url)
            });
        }else{
            documentEditPriv = 0;
            // 查询编辑权限
            $.ajax({
                url: "/document/getDocumentEditPriv",
                type: "post",
                data: {id: GetQueryString("tabId")},
                dataType: "json",
                success: function (res) {
                    if (res.flag) {
                        documentEditPriv = res.object.documentEditPriv;
                        if(documentEditPriv == 1||documentEditPriv == "1"){
                            documentEditPrivDetail = res.object.documentEditPrivDetail;
                        }
                    }
                    // 默认初始化
                    initUrl(function (url) {
                        initWord(url)
                    });
                }
            });
        }



        // 选择套红模板
        $('.select_red_li').click(function () {
            $.popWindow('/template/redTemplateSelect');
        });


        // 通用判断方法
        var fileName = GetQueryString("ATTACHMENT_NAME");
        var point = fileName.lastIndexOf(".");
        var type = fileName.substr(point);
        // 判断是否是word文件
        if (type == '.doc' || type == '.docx') {
            $('.base_menu_li').css('display', 'block');
            $('.file_menu_li').css('display', 'none');
            $('.sign_menu_li').css('display', 'none');
        } else if (type == '.aip') {
            $('.base_menu_li').css('display', 'none');
            $('.file_menu_li').css('display', 'block');
            $('.sign_menu_li').css('display', 'block');
        }


        parent.$('.zhuanjiao').on('click', function () {
            var fileName1 = getUrlString("ATTACHMENT_NAME", url);
            var point = fileName1.lastIndexOf(".");
            var type = fileName1.substr(point);
            if (type == '.doc' || type == '.docx') {
                SaveToURL();
            } else if (type == '.aip') {
                saveAip();
            }
        });

    });

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
    }

    function hiddenRight(){
        $('.right_side').css("display","none");
    }
    
    function wordUpload() {
        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                url = res.datas[0].attUrl;
                url = encodeURI(url);
                // 判断是否是公文模块
                $.ajax({
                    url: "/document/updateDoc",
                    type: "post",
                    dataType: "json",
                    data: {
                        id: GetQueryString("tabId"),
                        mainFile: res.datas[0].attStrId,
                        mainFileName: res.datas[0].attStrName
                    },
                    success: function (res) {
                        // console.log(res);
                    }
                });
                initWord(url);
            }
        });
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

</script>

</body>
</html>
