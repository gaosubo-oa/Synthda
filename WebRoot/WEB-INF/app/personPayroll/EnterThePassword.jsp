<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2023/5/17
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>输入密码</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <style>
        .headDiv {

            background: #f5f5f5;
            width: 100%;
            height: 45px;
            border-bottom: #999 1px solid;
            overflow: hidden;
        }

        .div_Img {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }

        .div_Img img {
            width: 23px;
            height: 23px;
            margin-top: 11px;
        }

        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: #494d59;
        }

        .big3 {
            margin-left: 5px;
            font-family: Microsoft yahei, Helvetica Neue, Helvetica, PingFang SC, Tahoma, Arial, sans-serif;
            font-size: 20px;
            color: #494d59;
            FONT-WEIGHT: normal;
        }

        .Big img {
            float: left;
            margin-top: 3px;
            margin-right: 5px;
            padding-left: 20px;
        }

        .head li {
            margin-left: 15px;
        }

        .head .headli1_2 {
            /*margin-left: 15px;*/
            margin-top: -5px;
        }

        .layui-layer {
            top: 200px;
        }

        .th {
            font-size: 11pt;
        }

        .newJuese {
            display: inline-block;
            width: 100px;
            height: 28px;
            line-height: 28px;
            border-radius: 3px;
            background: #2b7fe0;
            color: #ffffff;
            text-align: center;
            cursor: pointer;
        }

        .layui-layer {
            top: 200px !important;
        }

        .lefts {
            width: 15%;
            display: inline-block;
            float: left;
            border-right: 1px solid black;
        }

        .rights {
            width: 84%;
            display: inline-block;
        }

        .one_name {
            font-size: 12pt;
            font-weight: 400;
        }

        .tab_cone li .one_all:hover {
            background: #b6e0ff !important;
        }

        .one_all li:hover {
            background: #ccebff;
            cursor: pointer;
        }

        .one_all li:hover h1 {
            color: #2f8ae3;
        }

        .one_all {
            padding-top: 15px;
            border: none;
            border-bottom: none;
            background: #f5f7f8;
            border-top: 2px solid #fff !important;
        }

        .one_all {
            height: 40px !important;
            width: 100% !important;
            border-left: none !important;
            border-right: none !important;
        }

        .one_all {
            background: #f0f4f7;
            position: relative;
        }

        .one_alltwo {
            background: #fff !important;
            height: 40px !important;
            width: 100% !important;
            border-left: none !important;
            border-right: none !important;
            border: none;
            border-bottom: none;
            border-top: 2px solid #fff !important;
            margin-top: 0%;
        }

        .one_alltwo h1 {
            font-size: 18px;
            color: #2f8ae3;
        }

        .tab_cone li .one_all:hover {
            background: #b6e0ff !important;
        }

        .cont_left {
            overflow-y: auto;
            height: 100%;
            border: 0;
        }

        #top:hover {
            background-color: rgb(246, 247, 249) !important;
        }
    </style>
</head>
<body>
<div id="loginAdmin">
    <input name="username" value="${sign}" type="hidden"/>
    <%--<div class="navigation  clearfix" style="margin-top:0;">--%>
    <%--<div class="left">--%>
    <%--<img src="../img/key_03.png" alt="">--%>
    <%--<div class="news"><fmt:message code="roleAuthoorization.th.EnterSuperPassword" /></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/key_03.png" style="vertical-align: middle;"
                 alt="输入密码">
        </div>
        <div class="divP">输入密码</div>
    </div>
    <table class="tr_td" width="50%" align="center" style="margin-top: 20px">
        <tbody>
        <tr>
            <td class="th" colspan="2">
                <b>说明：</b>
                密码为系统登录密码，可在工资查询设置中开启或关闭密码验证
            </td>
        </tr>
        <tr>
            <td class="TableContent" style="width: 25%">
                请输入密码：
            </td>
            <td class="TableData">
                <input style="margin-left: 10px;" placeholder="请输入密码" type="password" id="super_pass"
                       name="super_pass" class="inp" size="30"><span class="super_pass_msg"></span>
            </td>
        </tr>
        <td nowrap="" style="padding: 7px;" align="center" colspan="2">
            <input class="import" type="button" value="确定">
        </td>
        </tbody>
    </table>
</div>
</body>
</html>
<script>
$(function (){
    $(".import").on("click",function (){
        var password = $("#super_pass").val()
        $.ajax({
            type: 'get',
            url: '/bonusmsg/passWord?passWord='+password,
            dataType: 'json',
            success: function (res) {
                if (res.flag){
                    window.location.href = "/salary/lclb";
                }else {
                    alert("密码错误")
                }
            }
        })
    })
//键盘监听回车
    document.onkeydown = function (event_e){
        if(window.event){
            event_e = window.event;
        }
        var int_keycode = event_e.charCode || event_e.keyCode;
        if(int_keycode == '13'){ //回车键：13
            $(".import").click()
        }
    }

})
</script>
