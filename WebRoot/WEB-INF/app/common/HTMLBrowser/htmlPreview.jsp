<%--
  Created by IntelliJ IDEA.
  User: 高速波办公
  Date: 2022/8/19
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HTML文件预览</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="/css/workflow/m_reset.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <style>

    </style>
</head>
<body>
    <div class="grid-content bg-purple" style="height: 100%">
        <iframe frameborder="0" id="htmlIframe" src="" style="width: 100%;" width="100%" height="100%"></iframe>
    </div>

    <script>
        function autodivheight(){
            var winHeight=0;
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;
            if (document.documentElement && document.documentElement.clientHeight)
                winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
            document.getElementById("htmlIframe").style.height= winHeight +"px";
            //document.getElementById("officialDocument").style.height= winHeight - 98 +"px";
        };
        var src = '/xs' + location.search;
        $('#htmlIframe').attr('src', src)
        //autodivheight()
    </script>
</body>
</html>
