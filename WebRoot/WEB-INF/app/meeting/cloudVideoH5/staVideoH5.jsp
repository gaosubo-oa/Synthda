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
    $("#attendMeetingIfr" , parent.document);
    var win = window.parent.$("#attendMeetingIfr").attr('urlVid');
    var url = win
    window.location.href = url
</script>
