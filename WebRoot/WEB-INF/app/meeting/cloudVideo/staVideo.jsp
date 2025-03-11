<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/9/23
  Time: 13:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

</body>
</html>
<script>
    // var url = "http://cloud.iactive.com.cn/startmeeting/?SrvIP=111.47.113.243&app=1&auto=1&AnonymousUser=1&UserName=%E7%B3%BB%E7%BB%9F%E7%AE%A1%E7%90%86%E5%91%98&RoomID=61&ClassPwd=123456"


    $("#attendMeetingIfr" , parent.document);
    var win = window.parent.$("#attendMeetingIfr").attr('urlVid');
    var url = win
    window.location.href = url
    console.log(win)
    // console.log($("#attendMeetingIfr" , parent.document))
</script>
