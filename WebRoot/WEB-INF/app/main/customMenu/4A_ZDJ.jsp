<%--
  Created by IntelliJ IDEA.
  User: 96394
  Date: 2021/4/10
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>4a首页</title>

        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    </head>
    <body>
        <iframe src="" id="4aIframe" style="width: 100%; height: 100%;"></iframe>

        <script>
            $.get('/getThirdSysConfigInfo', function(res) {
                if (res.flag && res.data.para7) {
                    var url = res.data.para7 + 'apphub/index/appList';

                    $('#4aIframe').attr('src', url);
                }
            });
        </script>
    </body>
</html>
