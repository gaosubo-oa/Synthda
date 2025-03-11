<%--
  Created by IntelliJ IDEA.
  User: Gsubo
  Date: 2021/11/1
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选择组织</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
</head>
<style>
    .mainCon {
        height: 100%;
        background: url(/img/default/theme1/background.jpg) no-repeat;
        background-size: 100% 100%;
    }
    .mainCon .entry {
        height: 100%;
        position: relative;
    }
    .mainCon .entry .entryBg {
        width: 736px;
        height: 370px;
        margin: 0 auto;
        background: url(/img/default/theme8/loginpanel.png) no-repeat;
        background-size: contain;
        background: transparent\9;
        filter: progid:DXImageTransform.Microsoft.AlphaImageLoader( src='/img/default/gradient.png', sizingMethod='scale');
        position: relative;
        top: 25%;
    }
    .mainCon .entry .entryBg>div {
        float: left;
    }
    .mainLeft {
        margin-top: 80px;
        margin-left: 50px;
    }
    .mainLeft span {
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        display: block;
        font-size: 21px;
        /* letter-spacing: 2px; */
        font-weight: bold;
        width: 280px;
        background-image: -webkit-gradient(linear,0 8, 0 bottom, from(rgba(82, 174, 251, 1)), to(rgba(10, 98, 160, 1)));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    .desktop {
        width: 180px;
        margin: 10px auto;
    }
    .mainMiddle {
        width: 2px;
        height: 330px;
        background: url(/img/default/theme8/partingLine.png) no-repeat;
        margin: 17px 20px 0 20px;
    }
    .mainRight {
        position: absolute;
        top: 130px;
        right: 60px;
    }
    .mainRight select {
        height: 33px;
        width: 260px;
        border-radius: 5px;
        padding-left: 10px;
        border-color: #ccc;
        padding-top: 5px\9;
        padding-bottom: 5px\9;
    }
    .mainRight .txt .imgDiv {
        display: inline-block;
        width: 24px;
        text-align: center;
        margin-right: 15px;
    }
    .mainRight .txt .imgDiv img {
        vertical-align: middle;
    }
    .mainRight .loginBtn {
        width: 122px;
        height: 38px;
        margin: 27px auto;
        background: url(/img/default/theme8/loginback.png) no-repeat;
        background-size: 100% 100%;
        color: #FFFFFF;
        line-height: 38px;
        font-size: 18px;
        cursor: pointer;
    }
</style>
<body>
<div class="mainCon">
    <div class="entry">
        <div class="entryBg">
            <div class="mainLeft">
                <span class="mainLefttext" style="text-align: center">闵行教育云办公平台</span>
                <div class="desktop">
                    <img src="/img/default/theme8/loginlogo.png" alt="" style="width: 100%;">
                </div>
            </div>
            <div class="mainMiddle"></div>
            <div class="mainRight">
                <div class="txt">
                    <div class="imgDiv">
                        <img src="/img/default/theme8/icon_organination_2.png">
                    </div>
                    <select id="orgs">

                    </select>

                </div>

                <div class="loginBtn" id="loginBtn">
                    <span style="margin-left: 52px;">登录</span>
                    <%--                <button id="loginBtn" type="button">登录</button>--%>
                </div>

            </div>
        </div>
    </div>
</div>



<script type="text/javascript">

    $(function(){

        $.ajax({
            type: 'get',
            url: '/mhsso/getCompany',
            dataType: 'json',
            data:{
                eduId:$.GetRequest().eduId
            },
            success: function (res) {
                var data = res.data;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].oid + '" isOrg="' + data[i].isOrg + '" >' + data[i].name + '</option>';
                }
                $('#orgs').html(str)
            }
        })

        $("#loginBtn").click(function(){

            window.location.href = "/mhsso/login?loginId="+$('#orgs').val()+"&eduId="+$.GetRequest().eduId;
            /*$.ajax({
                type: 'get',
                url: '/mhsso/login',
                dataType: 'json',
                data:{
                    loginId: $('#orgs').val(),
                    eduId:$.GetRequest().eduId
                },
                success: function (res) {

                }
            })*/
        })

    })

</script>
</body>
</html>
