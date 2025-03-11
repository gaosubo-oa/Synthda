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
            background-color: #e6e6e6;
        }
        .header{
            position: fixed;
            background: #b7472a;
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
            width: 30px;
            position: absolute;
            top: 10px;
            left: 14px;
        }
        .content{
            background-color: #e6e6e6;
            padding-top: 75px;
            padding-right: 20px;
            padding-left: 20px;
            padding-bottom: 10px;
        }
        .contentPreview{
            line-height: normal;
            margin-right: auto;
            margin-left: auto;
            margin-bottom: 15px;
            min-width: 795px;
            max-width: 75%;
            min-height: calc(100% - 100px);
            border-radius: 1px;
        }
        .contentBox{
            position: relative;
            word-wrap: break-word;
            word-break: break-all;
            margin: 25px auto;
            z-index: 0;
            box-shadow: 0 0 10px 5px #888;
        }
        .contentBox table,.contentBox img{
            width: auto;
            max-width: 100%;
        }
    </style>
</head>
<body>
    <div class="header">
        <img class="icon-img" src="/img/office/office-ppt.png?20210201.1" >
        <div class="headerTitle"></div>
    </div>
    <div class="content">
        <div class="contentPreview">

        </div>
    </div>
    <script>
        var module = '';
        var aid = '';
        var diskId = '';
        var path = '';

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
            url = "/netdisk/pptPreview"
        }else {
            var data={
                    module:$.GetRequest().module==undefined?$.GetRequest().MODULE:$.GetRequest().module,
                    aid:$.GetRequest().aid==undefined?$.GetRequest().AID:$.GetRequest().aid
                }
            url = "/pptPreview"
        }
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            success: function(res) {
                var htmlStr = '<p>文档加载失败！</p>';
                if(res.flag){
                    var name = res.data.attachName;

                    var imgs = res.data.imgList;
                    htmlStr = '';
                    for(var i =0,length =imgs.length;i<length;i++){
                        htmlStr += '<div class="contentBox"><img src="/'+imgs[i]+'" ></div>'
                    }

                    $('.headerTitle').html(name);
                    $('title').html('PowerPoint 文档预览 - '+name);
                }else{
                    if(res.msg.indexOf("stop")>0){
                        htmlStr = "<p>Open Office未正常启动!</p>"
                    }
                    // alert('文档加载失败！');
                    $('title').html('PowerPoint 文档预览 ');
                }
                $('.contentPreview').html(htmlStr);
                var img = $('img');
                if(img.length > 0){
                    imgReloadWidth(img);
                }

            }
        });

    </script>

</body>
</html>
