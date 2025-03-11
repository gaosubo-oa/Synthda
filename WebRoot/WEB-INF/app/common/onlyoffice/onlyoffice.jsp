<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2021/4/12
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Only Office</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8 ? MYOA_CHARSET : htmlspecialchars($HTML_PAGE_CHARSET))?>" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <%--    <script src="/ui/lib/onlyoffice/api.js"></script>--%>
    <style>
        .left_side {
            display: none;
            float: left;
            width: 14%;
            height: 100%;
            box-shadow: 2px 6px 12px #888888;
            background-color: #2b579a;
        }
        .right_side{
            float: left;
            width: 86%;
            margin-left: 0px;
            height: 100%;
        }
        .menu_ul {
            padding: 0;
            margin: 0;
            color: #fff;
        }
        .menu_ul_li {
            list-style: none;
            cursor: pointer;
        }
        .baseOprMenu {
            display: block;
            padding: 10px 0px 15px 20px;
        }
        .menu_ul_li ul {
            list-style: none;
            padding-left: 0px;
        }
        .menu_ul_li ul li {
            height: 18px;
            list-style: none;
            padding: 10px 10px;
            font-size: 14px;
            margin-left: 15px;
        }
        .menu_ul_li ul li:hover {
            background-color: #002050;
        }
    </style>
</head>
<body>
<div class="left_side">
    <ul class="menu_ul">
        <input type="hidden" id="userNameBox" value="${sessionScope.userName}">
        <input type="hidden" id="userName" value="">
        <li class="menu_ul_li base_menu_li">
            <span class="baseOprMenu">文件</span><%--WORD正文--%>
            <ul class="baseOprMenuUl">
                <li class="oper oper3001" style="position: relative">
                    <form id="uploadForm" action="/flow/docUploadFile" enctype="multipart/form-data" method="post">
                        <span style="position: absolute;left: 48px;top: 10px;">上传文件</span><%--上传文件--%>
                        <input title="上传Word" id="fileUpload" onchange="wordUpload()" type="file" name="file" style="cursor:pointer;width: 128px;height: 32px;position: absolute;top: 0px;opacity: 0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        <input type="hidden" name="module" value="document">
                        <input type="hidden" name="id" value="">
                        <input type="hidden" name="fileType" value="1">
                        <input type="hidden" name="prcsId" value="">
                        <input type="hidden" name="flowPrcs" value="">
                    </form>
                </li>
                <li class="oper oper3001" onclick="newWordFile();" style="position: relative">
                    <span style="margin-left: 38px;">新建Word文件</span>
                </li>
            </ul>
        </li>
    </ul>
</div>
<div class="box">
    <div id="placeholder">正在加载中...</div>
</div>

</body>
<%--<script src="http://119.3.215.83:9001/web-apps/apps/api/documents/api.js" ></script>--%>
<script>
    // 获取用户账号
    $.get('/getLoginUser', function(res){
        if (res.flag && res.object) {
            $('#userName').val(res.object.byname);
        }
    });
    <%--    附件类型--%>
    var getDocumentType = function (ext) {
        if (".doc.docx.docm.dot.dotx.dotm.odt.fodt.ott.rtf.txt.html.htm.mht.pdf.djvu.fb2.epub.xps".indexOf(ext) != -1) return "text";
        if (".xls.xlsx.xlsm.xlt.xltx.xltm.ods.fods.ots.csv".indexOf(ext) != -1) return "spreadsheet";
        if (".pps.ppsx.ppsm.ppt.pptx.pptm.pot.potx.potm.odp.fodp.otp".indexOf(ext) != -1) return "presentation";
        return null;
    };
    //正则
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    function myEncodeURI(str) {
        return encodeURI(str).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
    }
    <%--    查找对应附件--%>
    var AID =  $.GetRequest().AID;
    var MODULE = $.GetRequest().MODULE;



    var attUrl = '';
    var edit = $.GetRequest().edit;
    if(edit == 'false'){
        edit = false
    }else{
        edit = true
    }
    var data = {}
    //网络硬盘
    var netdisk = $.GetRequest().netdisk;
    // var _w_pathNetdisk = myEncodeURI(getQueryString('_w_pathNetdisk')).substring(0,myEncodeURI(getQueryString('_w_pathNetdisk')).length-3)
    var _w_pathNetdisk = $.GetRequest()._w_pathNetdisk;
    var _w_module = 'netdisk'
    var diskId = $.GetRequest()._w_fileid

    var http = ''
    var url = '';
    var title = '';
    var type = '';
    var documentType = '';
    var userInfo = '';

    // 公文id 用于保存公文附件
    var tabId =  $.GetRequest().tabId || '';
    var attachmentType = $.GetRequest().attachmentType || '';
    var mainFile = '';
    var mainFileName = '';
    if(attachmentType == 'zw'){
        var documentEditPriv = parent.globalData.flowProcesses.documentEditPriv || '';
        if(documentEditPriv==0){
            edit = false;
        }
        var documentEditPrivDetail = parent.globalData.flowProcesses.documentEditPrivDetail || '';
        if(documentEditPrivDetail.indexOf('3001') > -1&&parent.window.location.href.indexOf('/workformPreView?') == -1){
            $('.left_side').show().next().addClass('right_side');
        }
    }
    //预览编辑
    // var edit = true
    if(AID != ''&&MODULE != ''){
        //同步请求
        $.ajaxSettings.async = false;
        var href = '/web-apps/apps/api/documents/api.js';
        // 获取配置信息
        $.get('/sysTasks/getSysParaList',{
            paraName:'ONLY_OFFICE_ADDRESS,OUTSIDE_ADDRESS,ONLY_OFFICE_ADDRESS_LAN'
        },function(json){
            if(json.flag){
                var objs = json.obj;
                for (var i = 0; i < objs.length; i++) {
                    var data = objs[i];
                    // 获取only office服务器地址 并引入相对应的js
                    // 判断是否是内网ip
                    if(isInnerIPFn()){
                        if(data.paraName=='ONLY_OFFICE_ADDRESS_LAN'){
                            var head= document.getElementsByTagName('head')[0];
                            var script= document.createElement('script');
                            href = data.paraValue+href;
                            script.type= 'text/javascript';
                            script.src= href;
                            head.appendChild(script);
                        }
                    } else {
                        if(data.paraName=='ONLY_OFFICE_ADDRESS'){
                            var head= document.getElementsByTagName('head')[0];
                            var script= document.createElement('script');
                            href = data.paraValue+href;
                            script.type= 'text/javascript';
                            script.src= href;
                            head.appendChild(script);
                        }
                    }


                    if(data.paraName=='OUTSIDE_ADDRESS'){
                        http = data.paraValue;
                        // http = 'http://yangpu.yanshi.xtdoa.cn/';
                    }
                }
            }
        })

        // 获取附件信息
        $.get('/attachment/findByAid',{
            aid: AID,
            module: MODULE
        },function(json){
            if(json.flag){
                var attObj = json.object;
                attUrl = '&'+attObj.attUrl;
                title = attObj.attachName
                type = ('?'+title).substring(('?'+title).lastIndexOf(".")+1,('?'+title).length)
                documentType = getDocumentType(type);

                mainFile = attObj.aid+'@'+attObj.ym+'_'+attObj.attachId
                mainFileName = attObj.attachName
                $('title').html(title);
            }
        })
        var onlyOfficeDownload = "/onlyOfficeDownload?code="
        //判断网络硬盘
        if(netdisk != undefined &&netdisk == 1){
            attUrl = '&path='+_w_pathNetdisk+'&diskId='+ diskId;
            title = decodeURI(_w_pathNetdisk).split('\\')[decodeURI(_w_pathNetdisk).split('\\').length-1];
            title = title.split('%2F')[title.split('%2F').length - 1];
            type = ('?'+title).substring(('?'+title).lastIndexOf(".")+1,('?'+title).length)
            documentType = getDocumentType(type);
            onlyOfficeDownload = '/netdisk/onlyOfficeDownload?code='
        }
        // 获取下载密钥
        $.ajax({
            url:'/onlyOfficeCode',
            dataType: 'json',
            type: 'post',
            success:function(res){
                if(res.flag){
                    code = res.obj;
                    userInfo = res.data;
                    url = http+onlyOfficeDownload+code+attUrl+'&type=preview';
                    setTimeout (function(){
                        initEditor();
                    },1000);

                }
            }
        })
    }


    // 初始化编辑器
    function initEditor(){
        var head= document.getElementsByTagName('head')[0];
        var script= document.createElement('script');
        script.type= 'text/javascript';
        script.src= '/js/onlyoffice/onlyoffice.js?20220810.1';
        head.appendChild(script);

        // 公文正文
        updateDoc();
    }


    // 更新公文正文
    function updateDoc(){
        // 判断是否符合要求
        if(tabId!=''&&attachmentType=='zw'){
            $.ajax({
                url: "/document/updateDoc",
                type: "post",
                dataType: "json",
                data: {
                    id: tabId,
                    mainFile: mainFile,
                    mainFileName: mainFileName
                },
                success: function (res) {
                }
            });
        }

    }

    /**
     * 正文文件上传
     */
    function wordUpload() {
        $('input[name="id"]').val(tabId);
        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            success: function (res) {
                var data = {
                    id: tabId
                }
                var attStrId = res.datas[0].attStrId;
                var attStrName = res.datas[0].attStrName;

                // 获取文件后缀
                var type = attStrName.split(/\.(?![^\.]*\.)/)[1].toUpperCase();

                if(type=="PDF"){
                    data['mainAipFile'] = attStrId;
                    data['mainAipFileName'] = attStrName;
                } else {
                    data['mainFile'] = attStrId;
                    data['mainFileName'] = attStrName;
                }

                if(type == "DOCX" || type == "DOC") {
                    var url = '/common/onlyoffice?' + res.datas[0].attUrl.split('&ATTACHMENT_NAME=')[0] +'&ATTACHMENT_NAME=&attachmentType=zw&tabId='+ tabId +'&edit=true'
                    location.href = url;
                }else{
                    parent.$('.tabAB .active').trigger('click')
                }
            }
        });
    }

    /**
     * 新建word文件
     */
    function newWordFile() {
        debugger
        myPromiseGet('/outDocument/doNewFile', {
            model: 'document',
            tableId:tabId
        }).then(function (value) {
            var res = value;
            var url = '/common/onlyoffice?' + res.object.attUrl +'&ATTACHMENT_NAME=' + res.object.attachName +'&attachmentType=zw&tabId='+ tabId +'&edit=true'
            location.href = url;
        }).catch(function(reason) {
            console.log(reason);
            $.layerMsg({content: '新建word文件失败，请重试！', icon: 2});
        })
    }

    /*判断是否是内网IP*/

    function isInnerIPFn(){

// 获取当前页面url

        var curPageUrl =window.location.href;

        console.log('curPageUrl-0 '+curPageUrl);

        var reg1 =/(http|ftp|https|www):\/\//g;//去掉前缀

        curPageUrl =curPageUrl.replace(reg1,'');

        // console.log('curPageUrl-1 '+curPageUrl);

        var reg2 =/\:+/g;//替换冒号为一点

        curPageUrl =curPageUrl.replace(reg2,'.');

        // console.log('curPageUrl-2 '+curPageUrl);

        curPageUrl =curPageUrl.split('.');//通过一点来划分数组

        console.log(curPageUrl);

        var ipAddress =curPageUrl[0]+'.'+curPageUrl[1]+'.'+curPageUrl[2]+'.'+curPageUrl[3];

        var isInnerIp =false;//默认给定IP不是内网IP

        var ipNum =getIpNum(ipAddress);

        /**

         * 私有IP：A类 10.0.0.0  -10.255.255.255

          B类 172.16.0.0 -172.31.255.255

           *   C类 192.168.0.0 -192.168.255.255

           *   D类 127.0.0.0 -127.255.255.255(环回地址)

         **/

        var aBegin =getIpNum("10.0.0.0");

        var aEnd =getIpNum("10.255.255.255");

        var bBegin =getIpNum("172.16.0.0");

        var bEnd =getIpNum("172.31.255.255");

        var cBegin =getIpNum("192.168.0.0");

        var cEnd =getIpNum("192.168.255.255");

        var dBegin =getIpNum("127.0.0.0");

        var dEnd =getIpNum("127.255.255.255");

        isInnerIp =isInner(ipNum,aBegin,aEnd) ||isInner(ipNum,bBegin,bEnd) ||isInner(ipNum,cBegin,cEnd) ||isInner(ipNum,dBegin,dEnd);

        console.log('是否是内网:'+isInnerIp);

        return isInnerIp;

    }

    function getIpNum(ipAddress) {/*获取IP数*/

        var ip =ipAddress.split(".");

        var a =parseInt(ip[0]);

        var b =parseInt(ip[1]);

        var c =parseInt(ip[2]);

        var d =parseInt(ip[3]);

        var ipNum =a *256 *256 *256 +b *256 *256 +c *256 +d;

        return ipNum;

    }

    function isInner(userIp,begin,end){

        return (userIp>=begin) && (userIp<=end);

    }

</script>
</html>
