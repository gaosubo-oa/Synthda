<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>蓝信登录</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="/lib/layer/layer_mobile/layer.js?20201106"></script>
    <%--<script src="/js/base/base.js"></script>--%>


</head>
<body>
<header>

</header>

</body>
<script>

    var index=layer.open({
        type: 2,
        shade:'background-color: rgba(0,0,0,.2)'
    });
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    $(function(){

        var appid = getQueryString('appid');
        var code = getQueryString('code');
        var target = getQueryString('target');

        $.ajax({
            url:'/m/lxloginh5api',
            type:'get',
            dataType:'json',
            data:{
                appid:appid,
                code:code
            },
            timeout:20000,
            success:function(res){

                if(res.flag){
                    layer.close(index)

                    location.href= ("/"+target);
                }else {
                    alert("网络错误");
                }

            },
            error:function(jqXHR, textStatus, errorThrown){
                if(textStatus=="timeout"){
                    alert("加载超时");
                }
            }
        })

    })
</script>
</html>