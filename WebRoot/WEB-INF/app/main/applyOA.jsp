<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.th.ApplicationPortal" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <%--<link rel="stylesheet" type="text/css" href="css/main/${sessionScope.InterfaceModel}/bootstrap-responsive.min.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/managementPortal.css" />
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20201106.1"/>
    <%--${sessionScope.InterfaceModel}--%>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <script type="text/javascript" src="/js/jqmeter.min.js"></script>

    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <style type="text/css">
        body{
            overflow-y: auto;
            font-size: 9pt;
        }
        .apply_all {
            padding-bottom: 6%;
            width: 80%;
            height: 80%;
            margin: 4% auto;
        }
        .apply_every_logo {
            width: 25%;
            text-align: center;
            margin-top: 2%;
            margin-left: 0px;
            height: 150px;
        }
        .apply_every_logo:hover {
            background: #e9f3ff;
        }
        .apply_every_logo h2 {
            text-align: center;
            line-height: 30px;
        }
    </style>
    <script>

    </script>
</head>
<body>
<div class="apply_all"></div>

<script>
    getMenu()
    function getMenu(fn) {
        $.get('/getMenu', function (json) {
            if (json.flag) {
                $.ajax({
                    url:'/portals/selPortalsById?portalsId=2',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        var portals= res.object.portalsMenu.split(',');

                        var stringGetMenus = '';
                        for(var j = 0;j<portals.length;j++){
                            for (var i = 0; i < json.obj.length; i++) {
                                if(portals[j] == json.obj[i].id){
                                    stringGetMenus += '<a href="javascript:void(0)" onclick="parent.getMenuOpen(this)"  menu_tid="' + json.obj[i].id + '" data-url="' + json.obj[i].url + '"><div class="apply_every_logo">' +
                                        '<img src="/img/main_img/app/' + json.obj[i].fId + '.png" style="width: 80px;margin-top: 22px">' +
                                        '<h2 style="color: #666;font-size: 15px;font-weight: bold;">' + json.obj[i].name + '</h2>' +
                                        '</div></a>'
                                }

                            }
                        }
                        $('.apply_all').html(stringGetMenus)
                        if(fn!=undefined){
                            fn()
                        }
                    }
                })

            }
        }, 'json')
    }
</script>
</body>
</html>
