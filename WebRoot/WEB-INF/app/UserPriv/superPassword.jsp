<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="sys.th.superPass" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>

</head>
<style>
    .head .headli1_2{
        margin-top: -5px;
    }
</style>
<body class="bodycolor">
    <div id="north">
        <div class="head w clearfix">
            <ul class="index_head clearfix">
                <li data_id="0">
                <span class="headli1_1">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>

                <%--<li>--%>
                <%--<span class="headli1_1 ">--%>
                    <%--<a  href="newRole" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                    <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
                <%--</li>--%>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="adjustTheRole" data-Url="" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="modifyThePermissions?0" data-Url="" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1 one">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="roleAndClassification" data-Url="" ><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
            </ul>
        </div>
</div>
    <div class="navigation  clearfix" style="margin-top: 43px">
        <div class="left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/key_03.png" alt="">
            <div class="news"><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></div>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
    </div>

    <form method="post" action="" name="form1">
        <table class="tr_td" width="400" align="center">
            <tbody><tr>
                <td class="TableData" width="25%"><fmt:message code="url.th.OriginalPW" />：</td>
                <td class="TableData">
                    <input type="password" name="PASS0" style="margin:0;" class="inp" size="30">
                </td>
            </tr>

            <tr>
                <td class="TableData"><fmt:message code="url.th.newPW" />：</td>
                <td class="TableData">
                    <input type="password" name="PASS1" style="margin:0;" class="inp" size="30" maxlength="20">
                </td>
            </tr>

            <tr>
                <td class="TableData"><fmt:message code="url.th.Confirm" />：</td>
                <td class="TableData">
                    <input type="password" name="PASS2" style="margin:0;" class="inp" size="30" maxlength="20">
                </td>
            </tr>

            <tr align="center">
                <td class="TableData" colspan="2">
                    <input type="button" value='<fmt:message code="global.lang.save" />' class="import">
                </td>
            </tr>
            </tbody></table>
    </form>
    <script>
        function jump(me){
            parent.newjump($(me).attr('data-Url'))
        }





        $('.import').on("click",function () {
            if($('[name="PASS1"]').val()!=$('[name="PASS2"]').val()){
                alert('<fmt:message code="url.th.TwoPassword" />')
                return false;
            }
            $.post('/userPriv/checkSuperPass',{'password':$('[name="PASS0"]').val()},function (json) {
                if(!json.flag){
                    layer.alert('<fmt:message code="main.th.PasswordError" />')
                }else {
                    $.post('/userPriv/updateSuperPass',{'newPwd':$('[name="PASS1"]').val()},function (jsonTwo) {
                        layer.alert('<fmt:message code="menuSSetting.th.editSuccess" />',{title:'<fmt:message code="information" />',btn:'<fmt:message code="menuSSetting.th.menusetsure" />'},function () {
                            parent.newjump('roleAuthorization')
                        })
                    },'json')
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
