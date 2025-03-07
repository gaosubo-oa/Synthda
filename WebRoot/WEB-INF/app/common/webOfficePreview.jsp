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
    <title><fmt:message code="global.lang.edit" /></title><%--编辑--%>
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
            margin: 10px 0px 0px 20px;
        }

        .menu_ul_li {
            list-style: none;
            cursor: pointer;
            padding: 10px 10px 10px 10px;
            display: none;
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

<div class="wrap">
    <div class="left_side" style="display: none;">
        <ul class="menu_ul">
            <li class="menu_ul_li base_menu_li">
                <span class="baseOprMenu"><fmt:message code="common.th.wordText" /></span><%--WORD正文--%>
                <ul class="baseOprMenuUl">
                    <li class="oper oper1001" onclick="SaveToURL();"><img src="../img/document/word_aip/icon_save.png"/><span><fmt:message code="global.lang.save" /></span><%--保存--%>
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
    <div class="right_side">
        <div class="wordFormDiv" style="display: block">
            <form>
                <script type="text/javascript" src="../lib/officecontrol/ntkoofficecontrol.js?20201222.1"></script>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
<script type="text/javascript" src="../js/jquery/jquery.form.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
<script type="text/javascript" src="../js/base/base.js" charset="utf-8"></script>
<script type="text/javascript">
    var TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");
    var url = "";

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
        } else {
            url += "AID=" + GetQueryString("AID");
            url += "&MODULE=" + GetQueryString("MODULE");
            url += "&COMPANY=" + GetQueryString("COMPANY");
            url += "&YM=" + GetQueryString("YM");
            url += "&ATTACHMENT_ID=" + GetQueryString("ATTACHMENT_ID");
            url += "&ATTACHMENT_NAME=" + GetQueryString("ATTACHMENT_NAME");

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
        TANGER_OCX_OBJ.Activate == true;
        if (window.navigator.platform == "Win64") {
            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", "4.0.0.2", "../lib/officecontrol/ntkooledocallx64.cab", 51, true);
        } else {
            TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.0.2", "../lib/officecontrol/ntkooledocall.cab", 51, true);
            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", "4.0.0.2", "../lib/officecontrol/ntkooledocall.cab", 51, true);
        }
        TANGER_OCX_OBJ.CreateNew("word.Document");
        // 禁用保存
        TANGER_OCX_OBJ.FileSave = false;

        if (url != undefined && url != '' && url != 'undefined') {
            TANGER_OCX_OBJ.AddTemplateFromURL("../download?" + url);
        }

        /*// 禁用编辑
         TANGER_OCX_OBJ.SetReadOnly(true, "123456");*/

    }
</script>
<script type="text/javascript">
    $(function () {
        initUrl(function (url) {
            initWord(url)
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
</script>

</body>
</html>
