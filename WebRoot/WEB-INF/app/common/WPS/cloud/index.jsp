<%--
  Created by IntelliJ IDEA.
  User: mr.circle
  Date: 2020/7/2
  Time: 10:12 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>wps在线编辑</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="//unpkg.com/promise-polyfill@8.1.3/dist/polyfill.min.js"></script>
    <script src="/ui/lib/officecontrol/web-office-sdk-v1.1.2.es.js"></script>
    <script src="/ui/lib/officecontrol/web-office-sdk-v1.1.2.umd.js"></script>
    <script src="/ui/lib/officecontrol/web-office-sdk-v1.1.2.cjs.js"></script>

    <style>

    </style>
</head>
<body>
<div class="box">

    <div class="custom-mount" style="height: 100%;"></div>

</div>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var _w_module = $.GetRequest().MODULE;
    // var _w_fileName = $.GetRequest().ATTACHMENT_NAME;
    var _w_fileid = $.GetRequest().ATTACHMENT_ID;
    var _w_permission =$.GetRequest().permission;
    //网络硬盘
    var netdisk = $.GetRequest().netdisk;
    var data = {}
    function myEncodeURI(str) {
        return encodeURI(str).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
    }
    if(netdisk != undefined &&netdisk == 1){
        // data._w_pathNetdisk = myEncodeURI(getQueryString('_w_pathNetdisk'))
        data._w_pathNetdisk = myEncodeURI(getQueryString('_w_pathNetdisk')).substring(0,myEncodeURI(getQueryString('_w_pathNetdisk')).length-3)
        data._w_module = 'netdisk'
        data._w_fileid = $.GetRequest()._w_fileid
        data._w_permission = $.GetRequest().permission
    }else {
        data._w_module = _w_module
        data._w_fileid = _w_fileid
        data._w_permission =_w_permission
    }
    console.log(data)
    if(_w_permission =='read'){
        _w_permission = 'read'
        document.title = 'wps在线预览';

    }else if(_w_permission == 'write'){
        _w_permission = 'write'
        document.title = 'wps在线编辑';
    }

    $.ajax({
        url: "/weboffice/url",    //请求的url地址
        dataType: "json",   //返回格式为json
        async: true,//请求是否异步，默认为异步，这也是ajax重要特性
        data: data,     //参数值    //参数值
        type: "get",   //请求方式
        success: function (res) {
            var wpsUrl = res.data.wpsUrl
            $("#wpsUrl").attr("src", wpsUrl)
            var demo = WebOfficeSDK.config({
                mount: document.querySelector('.custom-mount'),
                url: wpsUrl, // 如果需要通过js-sdk传递token方式鉴权，则需要包含_w_tokentype=1参数
            })
            // 如果需要对iframe进行特殊的处理，可以通过以下方式拿到iframe的dom对象
            // $('#wpsUrl').html(demo.iframe)
            // 打开文档结果
            demo.on('fileOpen', function(data) {
                // console.log(data.success)
            })
            var token = res.data.token;
            // 设置token
            demo.setToken({token: token})
        }
    });

</script>

</body>
</html>
