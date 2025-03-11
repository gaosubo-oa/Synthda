<%--
  Created by IntelliJ IDEA.
  User: yangc
  Date: 2018/3/25
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PDF在线阅读</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/base.js?20210106.2" ></script>
    <script type="text/javascript" src="/lib/officecontrol/ntkoofficecontrol.js?20210728.1"></script>
    <script type="text/javascript" src="/js/common/watermark.js?20220317.1"></script>
    <SCRIPT LANGUAGE="javascript" FOR="HWPostil" EVENT="NotifyCtrlReady">
        //全局对象
        var AIP;
        //判断是否是IE，不是则跳转到xs预览接口
        AIP = document.getElementById("HWPostil");
        AIP.ShowToolBar = false;
        AIP.ShowDefMenu = 0;
        AIP.ShowScrollBarButton = 1;
    </SCRIPT>
    <style>
        body{
            display: none;
        }
    </style>
</head>

<body>
<OBJECT id='HWPostil' align='middle' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'
        classid='clsid:FF1FE7A0-0578-4FEE-A34E-FB21B277D561'
        codebase='/lib/HWPostil/HWPostil.cab#version=3,1,4,4'>
    <PARAM NAME='_Version' VALUE='65536'>
    <PARAM NAME='_ExtentX' VALUE='17410'>
    <PARAM NAME='_ExtentY' VALUE='10874'>
    <PARAM NAME='_StockProps' VALUE='0'>
</OBJECT>
        <script type="text/javascript">
            var TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");
            var fileUrl;
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
            window.onresize = function(){
                location.reload();
            }
            window.onload = function() {
                $.ajax({
                    url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                    type: 'post',
                    datatype: 'json',
                    success: function (res) {
                        $('body').show();
                        if (res.flag) {
                            // if (res.object[0].paraValue == 0) { //使用ntko插件预览pdf
                                $('#HWPostil').remove()
                                if(location.href.indexOf('path=netDisk') > -1){
                                    var path = $("#pathName", window.opener.document).val()||'';
                                    path = encodeURI('path='+path);
                                    var diskId = $.GetRequest().diskId||'';
                                    fileUrl = "/netdisk/download?"+ path+'&diskId='+diskId+'&type=preview';
                                }else{
                                    fileUrl = "/download" + url;
                                }
                                if (window.navigator.platform == "Win64") {
                                    TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbase64version, pdfbase64, 51, true);
                                } else {
                                    // TANGER_OCX_OBJ.AddDocTypePlugin(".tif", "tif.NtkoDocument", "4.0.1.0", "/lib/officecontrol/ntkooledocall.cab", 51, true);
                                    TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", pdfbaseversion, pdfbase, 51, true);
                                }
                                setTimeout(function() {
                                    TANGER_OCX_OBJ.BeginOpenFromURL(fileUrl);
                                }, 1000)

                            // }else{
                            //     var winHeight=0;
                            //     if (window.innerHeight)
                            //         winHeight = window.innerHeight;
                            //     else if ((document.body) && (document.body.clientHeight))
                            //         winHeight = document.body.clientHeight;
                            //     if (document.documentElement && document.documentElement.clientHeight)
                            //         winHeight = document.documentElement.clientHeight;
                            //     $('body').height(winHeight - 20 +'px')
                            //     $('#TANGER_OCX').remove()
                            //     AIP = document.getElementById("HWPostil");
                            //     if(location.href.indexOf('path=netDisk') > -1){
                            //         var path = $("#pathName",window.opener.document).val()||'';
                            //         path = encodeURI('path='+path);
                            //         var diskId = $.GetRequest().diskId||'';
                            //         url = path+'&diskId='+diskId+'&type=preview';
                            //         AIP.LoadFile("/netdisk/download?"+url);
                            //     }else{
                            //         AIP.LoadFile("/xs"+url);
                            //     }
                            // }
                        }
                    },
                    error: function(err) {
                        $('body').show();
                        AIP = document.getElementById("HWPostil");
                        if(location.href.indexOf('path=netDisk') > -1){
                            var path = $("#pathName",window.opener.document).val()||'';
                            path = encodeURI('path='+path);
                            var diskId = $.GetRequest().diskId||'';
                            url = path+'&diskId='+diskId+'&type=preview';
                            AIP.LoadFile("/netdisk/download?"+url);
                        }else{
                            AIP.LoadFile("/xs"+url);
                        }
                    }
                });
            }
            var url = location.search;
            if(url.indexOf('&JSESSIONID1=') == -1){
                var session = getCookie('redisSessionId');
                url += '&JSESSIONID1=' + session;
            }
            if(!isIE()){
                window.location = "/common/PDFBrowser"+url;
            }else{

            }

            function isIE() { //判断是都是IE浏览器
                if (!!window.ActiveXObject || "ActiveXObject" in window)
                    return true;
                else
                    return false;
            }

        </script>

</body>

</html>
