<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2020/9/11
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js?20210111.1"></script>
    <script type="text/javascript" src="/js/base/baseTwo.js?20201110.4"></script>
    <script type="text/javascript" src="/js/common/watermark.js?20220317.1"></script>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }
        body {
            margin: 0;
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 14px;
            line-height: 20px;
            color: #333;
        }
        .header{
            position: fixed;
            background: #217346;
            color: #e6e6e6;
            height: 50px;
            line-height: 50px;
            top: 0;
            right: 0;
            left: 0;
            z-index: 1030;
        }
        .headerTitle{
            margin-left: 60px;
            font-size: 18px;
        }
        .icon-img{
            width: auto;
            height: auto;
            position: absolute;
            top: 10px;
            left: 14px;
        }
        .content{

            padding-top: 60px;
        }
        .contentPreview{
            line-height: normal;
            margin-right: auto;
            margin-left: auto;
            margin-bottom: 15px;
            min-height: calc(100% - 100px);
            border-radius: 1px;
            background-color: #FFF;
        }
        .contentBox{
            position: relative;
            max-width: 100%;
            word-wrap: break-word;
            word-break: break-all;
            margin: 0 auto;
            padding-bottom: 10%;
            z-index: 0;
        }
        .contentBox table,.contentBox img{
            width: auto;
            max-width: 100%;
        }
    </style>
</head>
<body>
    <div class="header">
        <img class="icon-img" src="/img/office/office-excel.png?20210201.1" >
        <div class="headerTitle"></div>
    </div>
    <div class="content">
        <div class="contentPreview">
            <div class="contentBox">

            </div>
        </div>
    </div>
    <script>
        var module = '';
        var aid = '';
        var diskId = '';
        var path = '';
        if(location.search&&location.search.split('?AID=')[1]){
            aid = location.search.split('?AID=')[1].split('&')[0];
            module = location.search.split('?AID=')[1].split('&MODULE=')[1];
        }
        function getQueryString(name){
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  unescape(r[2]); return null;
        }
        // diskId = getQueryString('diskId')
        diskId = $.GetRequest().diskId;

        //如果获取到的不是文件名称 请改成文件名成，因为decodeURI解码有时候浏览器识别不到
        if (window.name != undefined && window.name != ''){
            path = window.name
        }
        else {
            path = decodeURI($.GetRequest().path);
        }


        if(diskId!=undefined&&diskId!=''&&path!=undefined&&path != ''){
            var data={
                path:path,
                diskId:diskId
            }
            url = "/netdisk/excelPreview"
        }else {
            var  data= {
                    module:$.GetRequest().module==undefined?$.GetRequest().MODULE:$.GetRequest().module,
                    aid:$.GetRequest().aid==undefined?$.GetRequest().AID:$.GetRequest().aid
                }
            url = "/excelPreview"
        }

        $.ajax({
            url: url,
            data: data,
            type: "POST",
            success: function(res) {
                var htmlStr = '<p>文档加载失败！</p>';
                if(res.flag){
                    var name = res.data.attachName
                    htmlStr = res.data.htmlContent;
                    $('.headerTitle').html(name);
                    $('title').html('Excel 文档预览 - '+name);
                }else{
                    if(res.msg.indexOf("stop")>0){
                        htmlStr = "<p>Open Office未正常启动!</p>"
                    }

                    // alert('文档加载失败！');
                    $('title').html('Excel 文档预览 ');
                }
                $('.contentBox').html(htmlStr);
                var img = $('img');
                if(img.length > 0){
                    imgReloadWidth(img);
                }

                initStyle();
            }
        });

        function initStyle (){
            $("body").append($("<div>").css({"width":"100%","height":"30px","position":"fixed","bottom":"0","left":"0"
                ,"background-color":"#e6e6e6","line-height":"30px","font-size":"13px"}).attr("id","excel-header-nav"));
            $("center").css("display", "none");
            var centerChildrenA = $("center").children("a");
            if (centerChildrenA.length === 0) {
                $("#excel-header-nav").hide();
            }
            $(centerChildrenA).each(function (a, b) {
                // 获取a标签对应的target的name值，并设置name对应标签的样式以避免锚点标签标题被覆盖
                var href = $(b).attr("href");
                var name = href.substr(1);
                $("[name=" + name + "]").css({"display":"block","padding-top":"14.01px"});
                $(b).css({"padding":"5px","border-right":"1px solid white","color":"#000"});
                $("#excel-header-nav").append(b);
            });
            /**给所有的table添加class=table table-striped样式**/
            $("table").addClass("table table-striped");

        }

    </script>

</body>
</html>
