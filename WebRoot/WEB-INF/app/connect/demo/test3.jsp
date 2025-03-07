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
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-1.8.3.min.js"></script>
    <script src="/js/base/base.js?20200529.2"></script>
</head>
<body>
<script>
    var host = $.GetRequest().host;
    var OAtargeturl = $.GetRequest().OAtargeturl;
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

    //域名
    var realm_name=host;

    //应用内部ID
    var app_id='tianchang'  ;

    //调用接口凭证
    var access_token='bf6d9f807df549c493f3fe6095bdba7b' ;

    //OA用户账号，或第三方应用的自身账号（需要先与OA系统账号进行映射绑定）
    var user_id=byname;

    //登录授权成功后，重定向的 接口API地址
    var redirect_uri=  OAtargeturl;

    var   uri= decodeURI(redirect_uri)

    console.log(redirect_uri)
    var url =realm_name+"/connect/syslogin?app_id="+app_id+"&access_token="+access_token+"&user_id="+user_id+"&redirect_uri="+uri;

    window.location.href = url;
</script>
</body>
</html>
