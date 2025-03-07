<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/15
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="roleAuthorization.th.Clone" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
<%--    <script type="text/javascript" src="js/jquery/jquery.min.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <style>
        .headDiv {
            width: 100%;
            height: 45px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .nav_t1 {
            height: 45px;
            float: left;
            margin-left: 30px;
            width: 26px;
        }
        .nav_t1 img {
            margin-top: 12px;
        }
        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 12px;
            color: #333;
        }
    </style>
</head>
<body>
<div class="headDiv">
    <div class="nav_t1"><img src="/img/icon_rolemanage_06.png"></div>
    <div class="divP">角色克隆</div>
    <div id="Confidential" style="display: inline-block"></div>
</div>
<table class="tr_td" width="450" align="center">
    <tbody>
    <tr>
        <td nowrap="" class="TableData">角色排序号：</td>
        <td nowrap="" class="TableData">
            <input type="text" name="PRIV_NO" style="margin-left: 0" class="inp" size="3"  value="">&nbsp;
        </td>
    </tr>
    <tr>
        <td nowrap="" class="TableData">角色名称：</td>
        <td nowrap="" class="TableData">
            <input type="text" name="PRIV_NAME" style="margin-left: 0" class="inp" size="25" maxlength="100" value="">&nbsp;
        </td>
    </tr>
    <tr align="center" class="TableControl">
        <td colspan="2" nowrap="">
            <input type="hidden" value="4" name="USER_PRIV">
            <input type="button" value='保存' class="import" name="submit">&nbsp;&nbsp;
            <input type="button" value='返回' class="import" name="back" onclick="location.href='permission'">
        </td>
    </tr>

    </tbody></table>
<script>
    function jump(me){
        parent.newjump($(me).attr('data-Url'))
    }
    var urlbool={
        urlstr:null,
        init:function () {
            this.urlstr=window.location.href.split('?')[1];
        }
    }
    urlbool.init()
    $('[name="submit"]').on("click",function () {
        $.post('/userPriv/copyUserPriv',{'userPriv':urlbool.urlstr,'privNo':$('[name="PRIV_NO"]').val(),
            'privName':$('[name="PRIV_NAME"]').val()},function (json) {
            if(json.flag){
                layer.alert('克隆成功',{title:'信息',btn:'确定'},function (index) {
                    location.href = 'permission';
                })
            }
        },'json')
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>
