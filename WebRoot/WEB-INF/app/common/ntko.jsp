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
            width: 14%;
            height: 100%;
            box-shadow: 2px 6px 12px #888888;
            background-color: #2b579a;
        }

        .right_side, .rightIcon {
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

        #wordFormDiv {
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
    <script type="text/javascript" src="/lib/officecontrol/ntko-linux.js"></script>
</head>

<body>
<div style="display:none">
</div>
<div style="display: none" id="fileAll"></div>
<div class="wrap" id="wrap">
    <div class="left_side">
        <ul class="menu_ul">
            <input type="hidden" id="userNameBox" value="${sessionScope.userName}">
	        <input type="hidden" id="userName" value="">
            <li class="menu_ul_li base_menu_li">
                <span class="baseOprMenu1">文件</span>
                <ul class="baseOprMenuUl">
                    <li class="oper oper3001" style="position: relative">
                        <form id="uploadForm" action="../flow/docUploadFile" enctype="multipart/form-data" method="post">
                            <img style="position: absolute;top: 7px;" src="../img/document/word_aip/icon_uploading_32.png"/><span style="position: absolute;left: 48px;top: 10px;">上传文件</span><%--上传文件--%>
                            <input title="上传Word" id="fileUpload" onchange="wordUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <input type="hidden" name="module" value="document">
                            <input type="hidden" name="id" value="">
                            <input type="hidden" name="fileType" value="1">
                            <input type="hidden" name="prcsId" value="">
                            <input type="hidden" name="flowPrcs" value="">
                        </form>
                    </li>
                    <li class="oper oper3001" onclick="newWordFile();" style="position: relative">
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
                    <li class="oper oper1003" title="该功能仅在Word文件下可用" onclick="TrackRevisions(true,$(this))" id="liuhen"><img src="../img/document/word_aip/icon_mark_19.png"/><span>修订</span></li><%--留痕--%>
                    <%--                    <li class="oper oper1004" onclick="TrackRevisions(false)" id="buliuhen" style="display: none"><img src="../img/document/word_aip/icon_markless_22.png"/><span><fmt:message code="common.th.notStayMark" /></span>&lt;%&ndash;不留痕&ndash;%&gt;--%>
                    <%--                    </li>--%>
                    <li class="oper oper1005" title="该功能仅在Word文件下可用"  onclick="EnterRevisionMode(true,$(this))"><img src="../img/document/word_aip/icon_showmark.png"/><span style="margin-left: 12px">显示标记</span><%--显示痕迹--%>
                    </li>
                    <%--                    <li class="oper oper1006" onclick="EnterRevisionMode(false)" style="display: none"><img src="../img/document/word_aip/icon_unshow.png"/><span><fmt:message code="common.th.hideTraces" /></span>&lt;%&ndash;隐藏痕迹&ndash;%&gt;--%>
                    <%--                    </li>--%>
                    <li class="oper oper1008" onclick="stamp()" id="writesign"><img src="../img/document/word_aip/icon_markless_22.png"/><span>盖章</span><%--打印--%>
                    </li>
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
                    <li class="oper oper3005" onclick="ToPDF()"><img src="../img/document/word_aip/icon_template_03.png"/><span>转PDF版式文件</span></li><%--转版式文件--%>
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
                    <li class="oper oper3010" onclick="makeSign()" style="display: block"><img src="../img/document/word_aip/icon_template_03.png"/><span>盖章</span>

                </ul>
            </li>
        </ul>
    </div>
    <div class="right_side">
        <div id="wordFormDiv" class="wordFormDiv" style="display: block">
            <form>
                <script type="text/javascript" src="/lib/officecontrol/ntkoofficecontrol.js?20210728.1"></script>
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

<%-- 转pdf完成后触发 --%>
<script language="JScript" for="TANGER_OCX" event="AfterPublishAsPDFToURL(ret,code)">
    if (ret != undefined) {
        ret = JSON.parse(ret);
        if (ret.flag) {
            var url = ret.datas[0].attUrl;
            $.ajax({
                url: "/document/updateDoc",
                type: "post",
                dataType: "json",
                data: {
                    id: GetQueryString("tabId"),
                    mainAipFile: ret.datas[0].attStrId,
                    mainAipFileName: ret.datas[0].attStrName
                },
                success: function (res) {
                    // url = '/download?'+encodeURI(url).replace(/#/g, '%2523');
                    var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
                    TANGER_OCX_OBJ.BeginOpenFromURL('/download?'+encodeURI(fileUrl).replace(/#/g, '%2523'));
                    fileType = 'pdf';
                    $('.PDF_menu_li').show().siblings().hide();
                    // location.href = '/common/PDFEditor?' + encodeURI(fileUrl).replace(/#/g, '%2523')+'&tabId=' + GetQueryString("tabId");
                },
                error:function(res){
                    alert('转PDF版式文件失败！');
                }
            });
        }
    }

</script>
<%-- 文档打开成功后触发 --%>
<script language="JScript" for="TANGER_OCX" event="OnDocumentOpened(doc, statusCode)">
    console.log('文档打开成功!');
    $('object').height('100%');
    TANGER_OCX_OnDocumentOpened();
    // 判断当前打开的文档是否为word
    if (TANGER_OCX_OBJ.DocType == 1) {
        // 默认文档不显示修订痕迹
        // TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
        setShowRevisions(false);
        $('.oper1005').removeClass('hoverClass');
        
        // 文档书签替换关闭修订功能
        TANGER_OCX_OBJ.TrackRevisions(false);
        
        // 文档书签替换
        if (TANGER_OCX_OBJ.ActiveDocument.Bookmarks && TANGER_OCX_OBJ.ActiveDocument.Bookmarks.count) {
            for (var i = 1; i <= TANGER_OCX_OBJ.ActiveDocument.Bookmarks.count; i++) {
                var name = TANGER_OCX_OBJ.ActiveDocument.Bookmarks.item(i).name;
                
                // 获取书签对象
                var bkmkOldObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(name);
                // 获取对应的书签值
                var bkmkObjText = bkmkOldObj.Range.Text;
                // 如果书签内容不为空或内容不包含书签名，则认为该书签已替换过，不在进行替换
                if (bkmkObjText.trim() && bkmkObjText.indexOf(name) == -1) {
                    continue;
                }
                
                if (name == '附件标签') {
                    var $filesList = $('#oneUploadFile', parent.document).find('.item_wordH1');
                    if ($filesList.length > 0) {
                        var str = '';
                        var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(name);
                        var saverange = bkmkObj.Range;
                        $filesList.each(function () {
                            str += $(this).text() + ' ';
                        });
                        saverange.Text = str;
                        TANGER_OCX_OBJ.ActiveDocument.Bookmarks.Add(name, saverange);
                    }
                } else if ($(".form_item[title=" + name + "]", parent.document).length != 0) {
                    var obj = $(".form_item[title=" + name + "]", parent.document);
                    var val = obj.val();
                    if (obj.attr('data-type') == 'radio') {
                        if ($("input[title='" + name + "']:checked", parent.document).length > 0) {
                            val = $("input[title='" + name + "']:checked", parent.document).val();
                        } else {
                            val = "";
                        }
                    }else if(obj.attr('data-type') == 'select'){
                        val = $("select[title='" + name + "'] option:selected", parent.document).text();
                    }else if(obj.attr('data-type') == 'calendar'&&val != ''){
                        if(obj.attr('date_format') == 'YYYY-MM-DD'){
                            val = val.split('-')[0] + '年' + val.split('-')[1] + '月' + val.split('-')[2] + '日'
                        }else{
                            var date = val.split(' ')[0];
                            var time = val.split(' ')[1];
                            val = date.split('-')[0] + '年' + date.split('-')[1] + '月' + date.split('-')[2] + '日' + ' '
                                    + time.split(':')[0] + '时' + time.split(':')[1] + '分' + time.split(':')[2] + '秒';

                        }
                    }
                    if(val == '无'){
                        val = '';
                    }
                    if (val != '' && val != undefined) {
                        var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(name);
                        
                        var saverange = bkmkObj.Range;
                        saverange.Text = val;
                        TANGER_OCX_OBJ.ActiveDocument.Bookmarks.Add(name, saverange);
                    }
                }
            }
        }
        
        // 设置是否为修订状态
        if (TrackRevisionsFlag) {
            TANGER_OCX_OBJ.TrackRevisions(TrackRevisionsFlag);
        }
    }
    
</script>
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
	// 获取用户账号
	$.get('/getLoginUser', function(res){
	    if (res.flag && res.object) {
	        $('#userName').val(res.object.byname);
	    }
	});
    var parentPrcsId = '',parentFlowPrcs = '';
    if(parent.location.href.indexOf('/workflow/work/workform?') > -1){
        parentPrcsId = parent.$.GetRequest().flowStep;
        parentFlowPrcs = parent.$.GetRequest().prcsId;
        $('input[name="prcsId"]').val(parentPrcsId);
        $('input[name="flowPrcs"]').val(parentFlowPrcs);
    }
    var AipObj = document.getElementById("HWPostil1");
    var TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");
    var url = "";
    var documentEditPriv = 0;
    var documentEditPrivDetail = "0";
    var TrackRevisionsFlag = false;

    var ntType=GetQueryString('ntType');
    var printBtn=GetQueryString('print');
    var officeType=GetQueryString('officeType');
    var isLinux = (String(navigator.platform).indexOf("Linux") > -1);
    var mainClearAttUrl = '';
    var saveType = 0;
    var TANGER_OCX_bDocOpen = false; //判断当前文件是否打开

    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串,判断是否是pc客户端打开的qt浏览器
    /**
     * 判断是都是IE浏览器
     *
     */
    function isIE() {
        if (!!window.ActiveXObject || "ActiveXObject" in window)
            return true;
        else
            return false;
    }
    /**
     * 获取地址栏参数
     * @param [String] name 参数名
     */
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
    
    /**
     * 初始化ntko-HTML节点
     */
    function djfn(){
        var str ="<OBJECT id='HWPostil1' align='middle' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%' classid='clsid:FF1FE7A0-0578-4FEE-A34E-FB21B277D561' codebase='/lib/HWPostil/HWPostil.cab#version=3,1,4,2'></OBJECT>"
        $('.aipFormDiv').html(str);
    }
    
    /**
     * 盖章
     */
    function stamp() {
        var login = TANGER_OCX_OBJ.SvrIsLogin;
        if (login == false) {
            TANGER_OCX_OBJ.SvrLoginUrl = 'http://10.191.15.14:1986/ntkoSignServer/';
            // TANGER_OCX_OBJ.SvrShowConfig();
        }
        TANGER_OCX_OBJ.IsAutoSignsGray = true;
        TANGER_OCX_OBJ.IsSetSvrSignBelowText = true;
        //系统会弹出服务器上用户可使用的印章列表，供用户是选择盖章
        // 判断中电建环境自动登录
        $.get('/ShowDownLoadQrCode', function (res) {
            if (res.flag && res.object == 1) {
                var userName = $('#userName').val() || '';
                // 注销
                TANGER_OCX_OBJ.SvrDoLogout();
                // 登录
                TANGER_OCX_OBJ.SvrDoLogin(userName, 'aaaa1111', false);
            }
            TANGER_OCX_OBJ.SvrAddSecsign(true);
        });
    }
    
    /**
     * 从url获取文档
     * @param [Func] fn   方法完成后的执行回调
     */
    function initUrl(fn) {
        debugger
        if (GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'document') {
            $.ajax({
                url: "/document/selectDocById",
                type: "get",
                dataType: "json",
                data: {id: GetQueryString("tabId"), randomNum: Math.random(), flowId:parent.flowId},
                success: function (res) {
                    if (res.flag) {
                        mainClearAttUrl = res.object.mainClearAttUrl || '';
                        if(location.href.indexOf('&initwordType=1') > -1){
                            url = res.object.wordAttUrl;
                            if (fn != undefined) {
                                fn(url,function(){
                                    // alert('打开文档成功!');
                                    if(!isLinux){
                                        // 文档打开后调用
                                        TANGER_OCX_OBJ.OnDocumentOpened();
                                    }

                                })
                            }
                        }else{
                            // 判断是否存在转版文件
                            if (res.object.aipAttUrl != undefined && res.object.aipAttUrl != '') {
                                url = res.object.aipAttUrl;
                                // url = encodeURI(url);
                                var mainAipFileName = res.object.mainAipFileName;
                                // 判断转版文件是否为pdf
                                if(mainAipFileName.substring(mainAipFileName.lastIndexOf(".")) == '.pdf'){
                                    if(isIE()){
                                        if (window.navigator.platform == "Win64") {
                                            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbase64version, pdfbase64, 51, true);
                                        } else {
                                            // TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.1.0", "/lib/officecontrol/ntkooledocall.cab", 51, true);
                                            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbaseversion, pdfbase, 51, true);
                                        }
                                        var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
                                        TANGER_OCX_OBJ.BeginOpenFromURL('/download?'+encodeURI(fileUrl).replace(/#/g, '%2523'));
                                        // 判断如果是详情页面，只显示下载按钮
                                        if(parent.location.href.indexOf('workformPreView')>-1){
                                            $('.PDF_menu_li').show().siblings().hide();
                                            $('.oper3008').show().siblings().hide()
                                        }else{
                                            // 如果是经办人，则只能下载
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
                                                        $('.oper3006').attr('wordAtturl',res.object.wordAttUrl).show();
                                                    } else {
                                                        $('.oper3006').hide()
                                                    }
                                                }
                                                // 判断PDF正文下载是否显示
                                                if(documentEditPrivDetail.indexOf('3008') >-1){
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3008').show()
                                                }else{
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3008').hide()
                                                }
                                                // 判断删除PDF是否显示
                                                if(documentEditPrivDetail.indexOf('3009') >-1){
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3009').show()
                                                }else{
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3009').hide()
                                                }
                                            }

                                        }
                                        fileType = 'pdf';
                                    }else{
                                        location.href = '/common/PDFEditor?'+ url.split('ATTACHMENT_NAME=')[0]+'&tabId='+GetQueryString("tabId");
                                    }
                                }else{
                                    convertToAip(1);
                                }
                            } else {
                                url = res.object.wordAttUrl;
                                // url = encodeURI(url);
                                if(url == ''&&parent.location.href.indexOf('zwClick') > -1){
                                    newWordFile();
                                }else{
                                    if (fn != undefined) {
                                        fn(url, function(){
                                            // alert('打开文档成功!');
                                            if(!isLinux){
                                                // 文档打开后调用
                                                TANGER_OCX_OBJ.OnDocumentOpened();

                                            }

                                        })
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
        }else if(GetQueryString("tableName")!= undefined && GetQueryString("tableName") == 'flowRun'){
            $.ajax({
                url: "/document/selectFunById",
                type: "get",
                dataType: "json",
                data: {rid: GetQueryString("tabId"), randomNum: Math.random(), flowId:parent.flowId},
                success: function (res) {
                    if (res.flag) {
                        mainClearAttUrl = res.object.mainClearAttUrl || '';
                        if(location.href.indexOf('&initwordType=1') > -1){
                            url = res.object.wordAttUrl;
                            if (fn != undefined) {
                                fn(url,function(){
                                    // alert('打开文档成功!');
                                    if(!isLinux){
                                        // 文档打开后调用
                                        TANGER_OCX_OBJ.OnDocumentOpened();
                                    }

                                })
                            }
                        }else{
                            // 判断是否存在转版文件
                            if (res.object.aipAttUrl != undefined && res.object.aipAttUrl != '') {
                                url = res.object.aipAttUrl;
                                // url = encodeURI(url);
                                var mainAipFileName = res.object.mainAipFileName;
                                // 判断转版文件是否为pdf
                                if(mainAipFileName.substring(mainAipFileName.lastIndexOf(".")) == '.pdf'){
                                    if(isIE()){
                                        if (window.navigator.platform == "Win64") {
                                            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbase64version, pdfbase64, 51, true);
                                        } else {
                                            // TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.1.0", "/lib/officecontrol/ntkooledocall.cab", 51, true);
                                            TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbaseversion, pdfbase, 51, true);
                                        }
                                        var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
                                        TANGER_OCX_OBJ.BeginOpenFromURL('/download?'+encodeURI(fileUrl).replace(/#/g, '%2523'));
                                        // 判断如果是详情页面，只显示下载按钮
                                        if(parent.location.href.indexOf('workformPreView')>-1){
                                            $('.PDF_menu_li').show().siblings().hide();
                                            $('.oper3008').show().siblings().hide()
                                        }else{
                                            // 如果是经办人，则只能下载
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
                                                        $('.oper3006').attr('wordAtturl',res.object.wordAttUrl).show();
                                                    } else {
                                                        $('.oper3006').hide()
                                                    }
                                                }
                                                // 判断PDF正文下载是否显示
                                                if(documentEditPrivDetail.indexOf('3008') >-1){
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3008').show()
                                                }else{
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3008').hide()
                                                }
                                                // 判断删除PDF是否显示
                                                if(documentEditPrivDetail.indexOf('3009') >-1){
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3009').show()
                                                }else{
                                                    $('.PDF_menu_li').show().siblings().hide();
                                                    $('.oper3009').hide()
                                                }
                                            }

                                        }
                                        fileType = 'pdf';
                                    }else{
                                        location.href = '/common/PDFEditor?'+ url.split('ATTACHMENT_NAME=')[0]+'&tabId='+GetQueryString("tabId");
                                    }
                                }else{
                                    convertToAip(1);
                                }
                            } else {
                                url = res.object.wordAttUrl;
                                // url = encodeURI(url);
                                if(url == ''&&parent.location.href.indexOf('zwClick') > -1){
                                    newWordFile();
                                }else{
                                    if (fn != undefined) {
                                        fn(url, function(){
                                            // alert('打开文档成功!');
                                            if(!isLinux){
                                                // 文档打开后调用
                                                TANGER_OCX_OBJ.OnDocumentOpened();

                                            }

                                        })
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
                fn(url)
            }
        }
    }
    var fileType = 'doc';
    
    /**
     * 加载office文档
     * @param [String] url  文档的url地址
     * @param [Func] fn   方法完成后的执行回调
     */
    function initWord(url,fn) {
        try{
            // 禁止显示菜单栏
            TANGER_OCX_OBJ.Menubar = false;
            // 禁止显示标题栏
            TANGER_OCX_OBJ.TitleBar = false;
            // 初始化url
            //TANGER_OCX_OBJ.Activate == true;
            if(!isLinux){
                if (window.navigator.platform == "Win64") {
                    TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbase64version, pdfbase64, 51, true);
                } else {
                    // TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.1.0", "/lib/officecontrol/ntkooledocall.cab", 51, true);
                    TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbaseversion, pdfbase, 51, true);
                }
            }
            $('.base_menu_li').css('display', 'block');
            $('.file_menu_li').css('display', 'none');
            $('.sign_menu_li').css('display', 'none');
            $('#wordFormDiv').css('display', 'block');
            $('.aipFormDiv').css('display', 'none');

            var ifread = false;

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
                if(fomat != ''){
                    fileType = fomat;
                }
                var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
                var session = getCookie('redisSessionId');
                fileUrl += '&JSESSIONID1='+session;
                if(fileType!=undefined&&fileType=="doc"||fileType=="docx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("/download?" + encodeURI(fileUrl).replace(/#/g, '%2523'),true,ifread,"Word.Document");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                    // 默认隐藏痕迹
                    //TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
                }else if(fileType=="xls"||fileType=="xlsx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("/download?" + encodeURI(fileUrl).replace(/#/g, '%2523'),true,ifread,"Excel.Sheet");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }else if(fileType=="ppt"||fileType=="pptx"){
                    TANGER_OCX_OBJ.BeginOpenFromURL("/download?" + encodeURI(fileUrl).replace(/#/g, '%2523'),true,ifread,"PowerPoint.Show");
                    // 禁用保存
                    TANGER_OCX_OBJ.FileSave = false;
                }

                if (documentEditPriv == 0) {
                    //判断如果是查看详情页面，只展示下载按钮
                    if(parent.location.href.indexOf('workformPreView')>-1){
                        $('.oper3007').show().siblings().hide()
                    }else{
                        // 隐藏菜单
                        $('.menu_ul').css("display", "none");
                    }
                    // 隐藏菜单
                    // $('.menu_ul').css("display", "none");
                    // 禁用编辑
                    ifread = true;
                }else if (documentEditPriv == 1){

                    if(GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'document'&&documentEditPrivDetail.indexOf('1010') > -1){
                        $('#dayin').show();
                    }else if(GetQueryString("tableName")!=undefined && GetQueryString("tableName") == 'flowRun'&&documentEditPrivDetail.indexOf('1010') > -1){
                        $('#dayin').show();
                    }else{
                        $('#dayin').hide();
                    }
                    if(ntType != undefined && ntType == '1'){
                        $('#liuhen').show();
                        $('#buliuhen').show();
                    }
                    //判断如果是查看详情页面，只展示下载按钮
                    if(parent.location.href.indexOf('workformPreView')>-1){
                        $('.oper3007').show().siblings().hide()
                    }else{
                        if(documentEditPrivDetail!=''&&documentEditPrivDetail!=undefined){
                            var detailArr = documentEditPrivDetail.split(",");
                            for(var i=0;i<detailArr.length;i++){
                                if(detailArr[i]!=''&&detailArr[i]!=undefined&&detailArr[i]!='undefined'){
                                    //如果是经办人，则只能下载
                                    if(GetQueryString("opflag")=='0'){
                                        if(detailArr[i]=='3007'){
                                            $('.oper'+detailArr[i]).css("display","block");
                                            $('.oper'+detailArr[i]).siblings().hide();
                                        }
                                    }else{
                                        if(detailArr[i]==1007||detailArr[i]=="1007"){
                                            $('.oper1003').addClass('hoverClass');
                                            // $('.oper1005').addClass('hoverClass');
                                            // TANGER_OCX_OBJ.TrackRevisions(true);
                                            // TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = true;
                                            TrackRevisionsFlag = true;
                                        }else{
                                            $('.oper'+detailArr[i]).css("display","block");
                                        }
                                    }

                                }
                            }
                        }
                    }
                    if($('.oper1001').is(':hidden')){
                        $('.oper1001').remove();
                    }else if($('.oper3003').is(':hidden')){
                        $('.oper3003').remove();
                    }
                }

            }else {
                if(documentEditPrivDetail != undefined&&documentEditPrivDetail.indexOf('3001') > -1){
                    $('.menu_ul_li').hide();$('.base_menu_li').eq(0).show();$('.oper3001').show()
                }
                $('.right_side').hide();
                $('.rightIcon').show();
                // TANGER_OCX_OBJ.CreateNew("word.document");

            }
            if(ifread){
                TANGER_OCX_OBJ.SetReadOnly(true, "123456");
            }
            if (fn != undefined) {
                fn()
            }
        }catch(e){
            if(documentEditPrivDetail != undefined&&documentEditPrivDetail.indexOf('3001') > -1){
                $('.base_menu_li').eq(0).show();$('.oper3001').show()
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
    
    /**
     * 从url套红功能
     * @param [String] url  必选  远程模板文件URL
     * @param [String] type
     * bool [IsConfirmConversions] 当模板文件不是WORD类型时，是否提示转换，默认true
     */
     function red_chromatography_url(url, type, save) {//套红可用，加载服务器资源下的，路径如下
        
        if(type == ''){
            if (url == undefined || url == '' || url == 'undefined') {
                alert("套红模板地址错误");
            }else {
                var curSel = TANGER_OCX_OBJ.ActiveDocument.Application.Selection;
                // TANGER_OCX_SetMarkModify(false);
                curSel.WholeStory();
                curSel.Cut();
                saveType = save;
                // TANGER_OCX_OBJ.ActiveDocument.Application.Selection.HomeKey(6);
                TANGER_OCX_OBJ.BeginOpenFromURL(encodeURI(url).replace(/#/g, '%2523'), true, false);
                // TANGER_OCX_OBJ.AddTemplateFromURL(encodeURI(url).replace(/#/g, '%2523'));
                TANGER_OCX_bDocOpen = false;
                TANGER_OCX_AddDocHeaderExec();
            }
        }else if(type == 1){
            if(url.indexOf('/download?') > -1){
                initWord(url.split('/download?')[1],function(){
                    saveType = save;
                    // alert('打开文档成功!');
                    if(!isLinux){
                        // 文档打开后调用
                        TANGER_OCX_OBJ.OnDocumentOpened();
                    }
                });
            }else{
                alert('是一个非法模板文件，请检查模板文件路径！')
            }

        }
     }
    /********************处理套红模板***********************************/
    function TANGER_OCX_AddDocHeaderExec(){
         try{
             if(!TANGER_OCX_bDocOpen) {
                 window.setTimeout(TANGER_OCX_AddDocHeaderExec,200);
                 return;
             }
             var BookMarkName = "zhengwen";
             if(TANGER_OCX_OBJ.ActiveDocument.BookMarks.Exists(BookMarkName)){
                 var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(BookMarkName);
                 var saverange = bkmkObj.Range;
                 saverange.Paste();
                 TANGER_OCX_OBJ.ActiveDocument.Bookmarks.Add(BookMarkName, saverange);
             }else{
                 alert("Word 模板中不存在名称为：'zhengwen'的书签！\n关于套红模版制作，请咨询技术支持人员。")
             }
         }catch(err) {
             alert("套红失败，请联系管理员！");
         }
     }
    function TANGER_OCX_OnDocumentOpened(){
        TANGER_OCX_bDocOpen = true;
    }
    /**
     * 定稿功能，退出保留痕迹
     * 不显示修订状态
     */
    function finalized(){
        $('.oper1003').removeClass('hoverClass');
        $('.oper1005').removeClass('hoverClass');
        TANGER_OCX_OBJ.TrackRevisions(false);
        setShowRevisions(false)
        // TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = false;
    }
    
    /**
     * 进入或者退出保留痕迹
     * @param [Boolean] vbool 是否保留痕迹
     */
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
            console.log('留痕！')
        } else {
            console.log('不留痕！')
        }
        TANGER_OCX_OBJ.TrackRevisions(vbool);
        if (vbool) {
            setShowRevisions(true);
            // TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = true;
        }
    }
    
    /**
     * 强制进入或者退出保留痕迹
     * @param [Boolean] flag 是否保留痕迹
     */
    function EnterRevisionMode(flag,e) {
        if(e.hasClass('hoverClass')){
            e.removeClass('hoverClass');
            flag = false;
        }else{
            e.addClass('hoverClass');
            flag = true;
        }
        if (flag) {
            console.log('显示痕迹！')
        } else {
            console.log('隐藏痕迹！')
        }
        setShowRevisions(flag);
        // try {
        //     TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = flag;
        // } catch (ex) {
        //     // console.log("显示/隐藏痕迹出错");
        // }

    }
    
    /**
     * 打印开启
     * @param [Boolean] vbool 是否开启打印
     */
    function printDoc(vbool) {
        var oldOption;
        try{
            var objOptions = TANGER_OCX_OBJ.ActiveDocument.Application.Options;
            oldOption = objOptions.PrintBackground;
            objOptions.PrintBackground = vbool;
        }
        catch (err){};
        TANGER_OCX_OBJ.printout(true);
        try{
            var objOptions = TANGER_OCX_OBJ.ActiveDocument.Application.Options;
            objOptions.PrintBackground = oldOption;
        }
        catch (err){};
    }
    
    /**
     * 该函数使用HTTP协议将文件保存到URL
     * @param [String] url 处理后台保存的URL地址
     * @param [String] FileFieldName 控件文件域名称
     * @param [String] FileName 文件名
     * @param [String] IsShowUI 是否显示进度条
     * return 提交URL之后从服务器返回的数据
     */
    function SaveToURL() {
        var newWordName = '正文.doc';
        var tabId = GetQueryString("tabId");
        if(GetQueryString("runId") != ''){
            // 工作流-正文时，获取流程名；公文-正文、文件柜或者其他模块不需要获取文件名
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

        if(url != undefined && url.indexOf('&MODULE=template&') > -1){

            if(GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'flowRun'){
                var json = eval('(' +TANGER_OCX_OBJ.SaveToURL("/flow/funDocUploadFile?id="+tabId+"&fileType=1&module=document"+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", newWordName)+')');
            }else{
                var json = eval('(' +TANGER_OCX_OBJ.SaveToURL("/flow/docUploadFile?id="+tabId+"&fileType=1&module=document"+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", newWordName)+')');
            }
             // if (json != undefined) {
            //     if (json.flag) {
            //         url = json.datas[0].attUrl;
            //         // url = encodeURI(url);
            //         $.ajax({
            //             url: "/document/updateDoc",
            //             type: "post",
            //             dataType: "json",
            //             data: {
            //                 id: GetQueryString("tabId"),
            //                 mainFile: json.datas[0].attStrId,
            //                 mainFileName: json.datas[0].attStrName
            //             },
            //             success: function (res) {
            //
            //             },
            //             error:function(res){
            //                 alert('文件保存失败！');
            //             }
            //         });
            //     }
            // }
            if (json != undefined && json.flag) {
                url = json.datas[0].attUrl;
                saveType = 0;
            } else {
                alert('文件保存失败！');
            }
        }
        if(url != undefined && url != '' && url != 'undefined') {
            // url = encodeURI(url);
            var fileUrl = url.split('ATTACHMENT_NAME')[0]+'ATTACHMENT_NAME=';
            var session = getCookie('redisSessionId');
            if(GetQueryString("tableName") != undefined && GetQueryString("tableName") == 'flowRun'){
                TANGER_OCX_OBJ.SaveToURL("/flow/funDocUploadFile?" + encodeURI(fileUrl).replace(/#/g, '%2523')+'&JSESSIONID1='+session+'&id='+tabId+'&saveType='+saveType+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", encodeURI(getUrlString("ATTACHMENT_NAME",url)));
            }else{
                TANGER_OCX_OBJ.SaveToURL("/uploadCover?" + encodeURI(fileUrl).replace(/#/g, '%2523')+'&JSESSIONID1='+session+'&id='+tabId+'&saveType='+saveType+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", encodeURI(getUrlString("ATTACHMENT_NAME",url)));
            }
             saveType = 0;
        } else {
            // 非上传和选择模板，默认的空文档保存
            if(GetQueryString("tableName")!=undefined && GetQueryString("tableName") == 'flowRun'){
                var json = eval('(' +TANGER_OCX_OBJ.SaveToURL("/flow/funDocUploadFile?id="+tabId+"&fileType=1&module=document"+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", newWordName)+')');
                if(!isLinux){
                    if (json != undefined && json.flag) {
                        url = json.datas[0].attUrl;
                        saveType = 0;
                    } else {
                        alert('文件保存失败！');
                    }
                }else{
                    if (json) {
                        saveType = 0;
                        alert('文件保存成功！');
                    }
                }
            }else{
                var json = eval('(' +TANGER_OCX_OBJ.SaveToURL("/flow/docUploadFile?id="+tabId+"&fileType=1&module=document"+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", newWordName)+')');
                // if (json != undefined) {
                //     if (json.flag) {
                //         url = json.datas[0].attUrl;
                //         // url = encodeURI(url);
                //         $.ajax({
                //             url: "/document/updateDoc",
                //             type: "post",
                //             dataType: "json",
                //             data: {
                //                 id: GetQueryString("tabId"),
                //                 mainFile: json.datas[0].attStrId,
                //                 mainFileName: json.datas[0].attStrName
                //             },
                //             success: function (res) {
                //
                //             },
                //             error:function(res){
                //                 alert('文件保存失败！');
                //             }
                //         });
                //     }
                // }
                console.log(json)
                if(!isLinux){
                    if (json != undefined && json.flag) {
                        url = json.datas[0].attUrl;
                        saveType = 0;
                    } else {
                        alert('文件保存失败！');
                    }
                }else{
                    if (json) {
                        saveType = 0;
                        alert('文件保存成功！');
                    }
                }
            }

        }
    }
    
    /**
     * 打印功能
     */
    function doc_print() {
        TANGER_OCX_OBJ.PrintPreview();
        TANGER_OCX_OBJ.PrintOut();
    }
    
    /**
     * 判断版式文件是否打开成功
     */
    function isOpenSuccess(IsOpen) {
        if (IsOpen != 1) {
            alert('<fmt:message code="common.th.documentFailed" />！');/*打开文档失败*/
        } else if (IsOpen == 1) {
            $('.left_side').css('display', 'block');
            $('.base_menu_li').css('display', 'none');
            $('.file_menu_li').css('display', 'block');
            $('.sign_menu_li').css('display', 'block');
            $('#wordFormDiv').css('display', 'none');
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
            if($('.oper1001').is(':hidden')){
                $('.oper1001').remove();
            }else if($('.oper3003').is(':hidden')){
                $('.oper3003').remove();
            }
        }
        /*ifHiddenLeft();*/
    }
    
    /**
     * 转换成版式文件
     */
    function convertToAip(type) {
        fileType = 'aip';
        if($('#HWPostil1').length == 0){
            djfn();
        }
        var session = getCookie('redisSessionId');
        AipObj = document.getElementById("HWPostil1");
        if (type == 1) {
            var IsOpen = AipObj.LoadFileEx("/download?" + encodeURI(url).replace(/#/g, '%2523'), "", 0, 0);
            isOpenSuccess(IsOpen);
        } else if (type == 2) {
            var IsOpen = AipObj.LoadFileEx("/download?" + encodeURI(url).replace(/#/g, '%2523'), "", 0, 0);
            isOpenSuccess(IsOpen);
            AipObj.HttpInit(); //初始化HTTP引擎
            AipObj.HttpAddPostCurrFile("file");
            //  str +
            var json = eval('(' +AipObj.HttpPost("/flow/docUploadFile?module=document&JSESSIONID1="+session)+')'); //上传数据
            if (json != undefined) {
                if (json.flag) {
                    url = json.datas[0].attUrl;
                    // url = encodeURI(url);
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
            var IsOpen = AipObj.LoadFileEx("/download?" + encodeURI(url).replace(/#/g, '%2523'), "", 0, 0);
            isOpenSuccess(IsOpen);
            AipObj.HttpInit(); //初始化HTTP引擎
            AipObj.HttpAddPostCurrFile("file");
            var json = eval('(' +AipObj.HttpPost("/flow/docUploadFile?module=document&JSESSIONID1="+session)+')'); //上传数据
            if (json != undefined) {
                if (json.flag) {
                    url = json.datas[0].attUrl;
                    // url = encodeURI(url);
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
        }
    }
    
    /**
     * PDF正文下载、WORD正文下载
     * @param [Number] type 下载类型 1:word，2:pdf
     */
    function downPdfOrWord(type) {
        // 请求接口 设置附件回显到公告附件
        $.get('/flowUtil/flowAttachDocOrPdf',{
            runId:GetQueryString("runId"),
            // module:"notify",
            module:"document",
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

    /**
     * 转换pdf功能
     */
    function ToPDF() {
        if(browser != 'IE'){
            alert('转PDF版式文件功能，请使用IE浏览器或者双核浏览器如360浏览器切换至兼容模式！')
            return false
        }
        try {
            // 先保存word
            // if (!url) {
                SaveToURL();
            // }
        
            var tabId = GetQueryString("tabId");
            if (!TANGER_OCX_OBJ.IsPDFCreatorInstalled()) {
                alert('请下载并安装PDFCreator插件后，重新点击按钮！');
                window.open('/lib/officecontrol/PDFCreator-1_2_3_setup.exe');
            } else {
                var session = getCookie('redisSessionId');
                var jsonurl = "/flow/docUploadFile?id=" + tabId + "&fileType=3&module=document&JSESSIONID1=" + session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs;
            
                $('.oper3006').attr('wordAtturl', url);
                var wordFileName = '';
                if (url) {
                    // var wordUrl = decodeURI(url)
                    var p = url.split("&");
                    for (var i = 0, length = p.length; i < length; i++) {
                        if (p[i].indexOf('ATTACHMENT_NAME') >= 0) {
                            wordFileName = p[i].substring(p[i].indexOf("=") + 1, p[i].length);
                            break;
                        }
                    }
                }
            
                // 转pdf前将word改为可编辑状态（必须，如果文档为被保护状态，接受所有修订会有问题）
                TANGER_OCX_OBJ.SetReadOnly(false, '', '', '');
                // try {
                //     TANGER_OCX_OBJ.ActiveDocument.UnProtect("dianju");
                // }catch(err){
                //     console.log(err);
                // }
                // 转pdf前关闭修订
                TANGER_OCX_OBJ.TrackRevisions(false);
                // 转pdf前显示所有修订痕迹 (必须，否则接受所有修订后转pdf右边会有空白)
                setShowRevisions(true);
                // 转pdf前接受所有修订 (必须，否则转pdf后会将修订内容显示)
                TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
                // 删除文档所有批注 (必须，否则转pdf后会将批注内容显示)
                clearComments();
                // 将文档中的印章转换成图片，防止弹出打印信息
                // signToImg();
                // 保存修订版word
                if (mainClearAttUrl == '') {
                    var json = eval('(' + TANGER_OCX_OBJ.SaveToURL("/flow/docUploadFile?id=" + tabId + "&fileType=2&module=document"+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", wordFileName) + ')');
                
                    if (json != undefined && json.flag) {
                        mainClearAttUrl = json.datas[0].attUrl;
                    }
                } else {
                    var fileUrl = mainClearAttUrl.split('ATTACHMENT_NAME')[0] + 'ATTACHMENT_NAME=';
                    var session = getCookie('redisSessionId');
                    if(GetQueryString("tableName")!=undefined && GetQueryString("tableName") == 'flowRun'){
                        TANGER_OCX_OBJ.SaveToURL("/flow/funDocUploadFile?" + encodeURI(fileUrl).replace(/#/g, '%2523') + '&JSESSIONID1=' + session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", encodeURI(getUrlString("ATTACHMENT_NAME", mainClearAttUrl)));
                    }else{
                        TANGER_OCX_OBJ.SaveToURL("/uploadCover?" + encodeURI(fileUrl).replace(/#/g, '%2523') + '&JSESSIONID1=' + session+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs, "file", "", encodeURI(getUrlString("ATTACHMENT_NAME", mainClearAttUrl)));
                    }
                }
                
                // 将文档控件中的文档转换为PDF文件并保存到URL
                TANGER_OCX_OBJ.PublishAsPDFToURL(jsonurl, "file", "", "1111.pdf", "", "", true, true);
            }
        } catch (err) {
            console.log(err);
            alert('pdf转版失败！');
            return false;
        }
    }

    //ie下加载pdf正文
    function IEpdf(src){
        var str = ' <iframe name="iepdf" width="100%" height="100%" id="iepdf" src="/pdfPreview?'+ src +'" frameborder="0" noresize="noresize" scrolling="yes"></iframe>';
        $('.aipFormDiv').html(str);
    }

    /**
     * 转换Word功能
     */
    function ToWord(e){
        url = e.attr('wordAtturl');
        fileType = 'doc';
        // initWord(encodeURI(url));
        initWord(url);
        $('.PDF_menu_li').hide();
    }
    
    /**
     * 盖章和手写
     * @param [String] doaction	操作类型：0 盖章，1 手写
     */
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
    
    /**
     * 版式文件保存
     */
    function saveAip() {
        AipObj.HttpInit(); //初始化HTTP引擎
        AipObj.HttpAddPostCurrFile("file");
        if(GetQueryString("tableName")!=undefined && GetQueryString("tableName") == 'flowRun'){
            var ispost = AipObj.HttpPost("/flow/funDocUploadFile?" + encodeURI(url).replace(/#/g, '%2523')+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs); //上传数据。
        }else{
            var ispost = AipObj.HttpPost("/uploadCover?" + encodeURI(url).replace(/#/g, '%2523')+'&prcsId='+parentPrcsId+'&flowPrcs='+parentFlowPrcs); //上传数据。
        }

    }
    
    /**
     * 版式文件aip下载
     */
    function downloadAip() {
        window.open("/download?" + encodeURI(url).replace(/#/g, '%2523'));
    }
    
    /**
     * 版式文件aip打印
     */
    function aip_print() {
        var isprint = AipObj.PrintDoc(1, 1);
        if (isprint == 0) {
            alert('<fmt:message code="common.th.printFailed" />！');/*打印失败*/
        }
    }
    
    /**
     * 版式文件删除
     */
    function aip_delete() {
        AipObj.CloseDoc(0);
        // 删除版式文件
        $.ajax({
            url: "/delete?" + encodeURI(url).replace(/#/g, '%2523'),
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
    
    /**
     * 删除文件函数
     */
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
    function parentZhuanjiaoBtn() {
        var dataId = $('.tabAB .active', parent.document).attr('data-id') || 1;
        // 处于正文页面时才可以保存
        if (dataId == 2) {
            
            if (fileType == 'aip' || fileType == 'AIP') {
                if ($('.oper3003').length != 0) {
                    saveAip();
                }
            } else if (fileType == 'doc' || fileType == 'DOC' || fileType == 'docx' || fileType == 'DOCX' || fileType == 'xls' || fileType == 'XLS'
                    || fileType == 'xlsx' || fileType == 'XLSX' || fileType == 'ppt' || fileType == 'PPT'
                    || fileType == 'pptx' || fileType == 'PPTX') {
                if ($('.oper1001').length != 0 && !$('.oper1001').is(':hidden')) {
                    SaveToURL();
                }
            }
        }
    }
    function autodivheight(){
//        $('.wrap').height(document.documentElement.clientWidth || document.body.clientWidth)
    }

    window.onload = function () {
        if (officeType != undefined && officeType == '1') {
            $('.baseOprMenu').html('Office文档')
        } else {
            $('.baseOprMenu').html('Word正文')
        }

        // 权限获取
        if (GetQueryString("documentEditPriv") == 0 && GetQueryString("documentEditPriv") != "") {
            documentEditPriv = 0;
            // 默认初始化
            initUrl(function (url, fn) {
                // initWord(encodeURI(url),fn)
                initWord(url, fn)
            });
        } else {
            documentEditPriv = 1;
            // 查询编辑权限
            if (parent.location.href.indexOf('/workflow/work/workformPreView?') > -1) {
                documentEditPriv = 1;
                documentEditPrivDetail = '1005,1010';
            } else {
                // 权限获取
                if (GetQueryString("documentEditPriv") == 0 && GetQueryString("documentEditPriv") != "") {
                    documentEditPriv = 0;
                } else {
                    documentEditPriv = 0;
                    if (parent.globalData != undefined && parent.globalData.flowProcesses != undefined) {
                        if(GetQueryString("tableName")!=undefined && GetQueryString("tableName") == 'flowRun'){
                            documentEditPriv=1;
                            documentEditPrivDetail ="3001,1009,1001,1002,1003,1005,1007,1008,1010,3004,3005,3006,3007,3008,3009"
                        }else{
                            documentEditPriv = parent.globalData.flowProcesses.documentEditPriv;
                            if (documentEditPriv == 1) {
                                documentEditPrivDetail = parent.globalData.flowProcesses.documentEditPrivDetail || '';
                            }
                        }
                    } else {
                        documentEditPriv = 1;
                        documentEditPrivDetail = '1001,1003,1005,1010';
                    }
                }
            }
        
            initUrl(function (url, fn) {
                // initWord(encodeURI(url),fn)
                initWord(url, fn)
            });
        }
        
        // 选择套红模板
        $('.select_red_li').click(function () {
            if ($(this).hasClass('oper1002')) {
                var type = '';
            } else {
                var type = '?type=1';
            }
            $.popWindow('/template/redTemplateSelect' + type);
        });
        
        // 通用判断方法
        var fileName = GetQueryString("ATTACHMENT_NAME");
        var point = fileName.lastIndexOf(".");
        var type = fileName.substr(point);
        // 判断是否是word文件
        if (type == '.doc' || type == '.docx') {
            $('.base_menu_li').eq(1).css('display', 'block');
            $('.file_menu_li').css('display', 'none');
            $('.sign_menu_li').css('display', 'none');
        } else if (type == '.aip') {
            $('.base_menu_li').css('display', 'none');
            $('.file_menu_li').css('display', 'block');
            $('.sign_menu_li').css('display', 'block');
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
    
    /**
     * 正文文件上传 (office文档和pdf文件)
     */
    function wordUpload() {
        $('input[name="id"]').val(GetQueryString("tabId"));
        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                url = res.datas[0].attUrl;
                // url = encodeURI(url);
                var data = {
                    id: GetQueryString("tabId")
                }
                var attStrId = res.datas[0].attStrId;
                var attStrName = res.datas[0].attStrName;

                // 获取文件后缀
                var type = attStrName.split(/\.(?![^\.]*\.)/)[1].toUpperCase();
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
                        initWord(url,function(){
                            // alert('打开文档成功!');
                            if(!isLinux){
                                // 文档打开后调用
                                TANGER_OCX_OBJ.OnDocumentOpened();
                            }
                        });
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
        debugger
        $('input[name="id"]').val(GetQueryString("tabId"));
        if(GetQueryString("tableName") == 'flowRun'){
            var data = {
                model: 'workflow',
                runId: GetQueryString("runId")
            }
        }else{
            var data = {
                model: 'document',
                tableId: GetQueryString("tabId")
            }
        }

        myPromiseGet('/outDocument/doNewFile', data  ).then(function (value) {
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
                initWord(url, function(){
                    // alert('打开文档成功!');
                    if(!isLinux){
                        // 文档打开后调用
                        TANGER_OCX_OBJ.OnDocumentOpened();
                    }
                });
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
    /**
     * 版式文件上传 (暂未使用)
     */
    function aipUpload() {
        $('#uploadAipForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                url = res.datas[0].attUrl;
                // url = encodeURI(url);
                convertToAip(2);
            }
        });
    }

    function getStringBytes (str) {
        var totalLength = 0;
        var charCode;
        for (var i = 0; i < str.length; i++) {
            charCode = str.charCodeAt(i);
            if (charCode < 0x007f) {
                totalLength++;
            } else if ((0x0080 <= charCode) && (charCode <= 0x07ff)) {
                totalLength += 2;
            } else if ((0x0800 <= charCode) && (charCode <= 0xffff)) {
                totalLength += 3;
            } else {
                totalLength += 4;
            }
        }
        return totalLength;
    }

    /**
     * 设置是否显示痕迹
     * @param booleanValue
     */
    function setShowRevisions(booleanValue) {
        try {
            if (TANGER_OCX_OBJ.doctype == 1) {
                TANGER_OCX_OBJ.ActiveDocument.ShowRevisions = booleanValue;
            }
        } catch (e) {
            console.log(e);
        }
    }

    /***
     * 清除文档所有批注
     * @returns {boolean}
     */
    function clearComments() {
        try {
            var ActiveDocument = TANGER_OCX_OBJ.ActiveDocument;//获得当前正文
        
            if (ActiveDocument.Comments.Count == 0) {//获得批注数量
                return false;
            }
            
            //获得批注数量
            var commentCount = ActiveDocument.Comments.Count;
            
            for (var i = 0; i < commentCount; i++) {
                var comment = ActiveDocument.Comments(1);
                comment.Delete();
            }
        } catch (e) {
            console.log(e);
        }
    }

    /**
     * 将印章转换成图片
     */
     function signToImg(){
        try {
            var obj = document.getElementById("TANGER_OCX");
            console.log('将印章转换成图片:'+obj.ActiveDocument.Shapes.Count);
            for(var i = obj.ActiveDocument.Shapes.Count;i >=1;i--) {
                if(obj.ActiveDocument.Shapes.Item(i).Type == 12) {

                    var InlineShape = obj.ActiveDocument.Shapes.Item(i).ConvertToInlineShape()
                    InlineShape.ConvertToShape();
                }
            }
        }
        catch(e) {
            console.log('将印章转换成图片err:'+e);
        }
    }
    /**
     * 离开正文页面时提示是否保存正文
     */
    function isSaveOffice() {
        if (fileType == 'doc' || fileType == 'DOC' || fileType == 'docx' || fileType == 'DOCX' || fileType == 'xls' || fileType == 'XLS'
                || fileType == 'xlsx' || fileType == 'XLSX' || fileType == 'ppt' || fileType == 'PPT'
                || fileType == 'pptx' || fileType == 'PPTX') {
            if ($('.oper1001').length != 0 && !$('.oper1001').is(':hidden')) {
                SaveToURL();
            }
        }
    }

</script>
</body>
</html>
