<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/7/29
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js?20200529.2"></script>
</head>
<body>
<script>
    var host = $.GetRequest().host;
    var OAtargeturl = $.GetRequest().OAtargeturl;

    if(OAtargeturl.indexOf('/workflow/work/newflowguider?') > -1){
        OAtargeturl = location.href.split('&OAtargeturl=')[1];
    }
    var byname = '';
    $.ajax({
        type: "post",
        url: "/users/getUserTheme",
        dataType: 'json',
        async:false,
        success: function (res) {
            var data = res.object;
            byname = data.byname;
        }
    })
    var url = host+'/xoaCas/loginTwo?OAtargeturl='+OAtargeturl+'&userName='+byname;
    window.location.href = url;
</script>
</body>
</html>
