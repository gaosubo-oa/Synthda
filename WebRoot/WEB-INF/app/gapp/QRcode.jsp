<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/12/29
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>二维码打印</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<h1 style="text-align: center">二维码打印</h1>
<div id="code">
    <center> <div id="qrcode"  style="margin-top: 100px"></div></center>
</div>
<center><strong><div id="address"  style="margin-top: 30px;font-size: 30px"></div></strong></center>
</body>
<script>
    var codeOrder1 = $.GetRequest()['codeOrder1'] || '';
    var address2 = $.GetRequest()['address2'] || '';
    var address3=decodeURI(address2);
    var strr='<p>'+address3+'</p>'
    $('#address').html(strr);


    skipHandle()
    //预览等弹出框
    function skipHandle() {
        var url = '';
        var address1= $("#address").find("option:selected").text()
        // 设置要生成二维码的链接
        new QRCode(document.getElementById("qrcode"), {
            text: location.origin+'/Antiepidemic/antiepidemicH5?codeNo='+codeOrder1,
            width: 300,
            height: 300
        });
        window.print();
    }
</script>
</html>
