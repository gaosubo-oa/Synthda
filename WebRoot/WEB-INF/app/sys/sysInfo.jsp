<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.syeteminfo"/></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>

    <script>

    </script>
    <style type="text/css">
        .TableBlock {
            border: 1px #cccccc solid;
            line-height: 20px;
            font-size: 11pt;
            border-collapse: collapse;
            position: relative;
            top: 50px;
        }

        .TableBlock .TableContent td, .TableBlock td.TableContent {
            background: #fff;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
        }

        .TableContent {
            /* BACKGROUND: #4897e8; */
        }

        .TableBlock .TableData td, .TableBlock td.TableData {
            background: #FFFFFF;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
            border-top: 1px #cccccc solid;
        }

        .TableData {
            BACKGROUND: #FFFFFF;
            COLOR: #000000;
        }

        td, th {
            display: table-cell;
            vertical-align: inherit;
        }

        tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }

        table {
            width: 94%;
            margin: 0 auto;
            font-size: 14px;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        table tr td {
            border-right: 0px solid !important;
        }

        .big3 {
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            font-size: 22px;
            color: #494d59;
            margin-top: -4px;
        }

        .TableHeader {
            background: #fff;
            border-bottom: 1px #cccccc solid;
        }

        .TableContent {
            border-right: 1px #cccccc solid !important;
        }

        #small {
            position: fixed;
            z-index: 99;
            top: 0px;
            background: #f6f7f9;
            width: 100%;
            margin-top: 0;
            height: 40px;
        }

        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 18px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background: #f6f7f9;">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small" id="small">
    <input type="hidden" id="theme" value="${sessionScope.InterfaceModel}">
    <tbody>
    <tr>
        <td class="Big" style="padding: 10px 30px;border-bottom: 1px solid #999;">
            <c:choose>
                <c:when test="${sessionScope.InterfaceModel!=''&&sessionScope.InterfaceModel!=undefined}">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/sysinfo.png" style="float:left;margin-right: 12px;">
                </c:when>
                <c:otherwise>
                    <img src="/img/commonTheme/theme1/sysinfo.png" style="float:left;margin-right: 12px;">
                </c:otherwise>
            </c:choose>


            <div class="big3"><fmt:message code="main.syeteminfo"/></div>
        </td>
    </tr>
    </tbody>
</table>
<table class="TableBlock" width="800" align="center" id="TableBlock" style="margin-top: 20px;margin-bottom: 50px;"></table>
<br>
<br>
<div class="logo" style="margin-left: 60px;">
</div>
<br>
<br>

<script type="text/javascript">

    // <!--
    var type=true;

    // OA版本
    var edition = "Synthda";

    $(function () {
                $.ajax({
                    url: '../../sys/getSysMessage',
                    type: 'post',
                    data:{
                        queryType:'sysInfo'
                    },
                    dataType: 'json',
                    success: function (data) {
                        var block = 'display: none;';
                        var str;
                        if(data.object==undefined){
                            data.object = {};
                        }
                        if(data.object.endLecDateStr){
                            var endLecDateStr = data.object.endLecDateStr.split(' ')[0]
                        }else{
                            var endLecDateStr = '';
                        }
                        if(data.object.isSoftAuth == '<fmt:message code="sysInfo.th.registered" />'){
                            str = '<tbody>' +
                                    '<tr><td nowrap="" colspan="2" align="left" style="border-bottom:1px solid #c0c0c0;">'+function(){
                                if($('#theme').val()!=""&&$('#theme').val()!=undefined){
                                    return '<img src="/img/commonTheme/${sessionScope.InterfaceModel}/xthhkxx.png" style="float:left;margin-right: 12px;vertical-align: baseline;">'
                                }else{
                                    return '<img src="/img/commonTheme/theme1/xthhkxx.png" style="float:left;margin-right: 12px;vertical-align: baseline;">'
                                }



                                }()+'<b style="color: #2F5C8F; font-size: 13pt; vertical-align: -webkit-baseline-middle;"><fmt:message code="system.th.SystemAndEnvironment" /></b></td></tr>' +
                                    '<tr><td nowrap="" class="TableContent" width="150"><b>&nbsp;<fmt:message code="sysInfo.th.SoftwareName" />：</b></td>' +
                                    '<td class="TableData">' +
                                        '<p style="display: inline;">' + edition + '</P>' +
                                    '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Copyright" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.cpright) + '</td></tr>' +
                                    '<tr class="website"><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.OfficialWebsite" />：</b></td>' +
                                    '<td style="background:#fff">' + undefinedStr(data.object.weblocation) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Software" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.softVersion) + '</td></tr>' +
                                   '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.DatabaseVersion" />：</b></td>' +
                                   '<td class="TableData">' + undefinedStr(data.object.dataversion) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.InstallationDirectory" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.installPath) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.WebPort" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.webPort) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.WebServer" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.webServer) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;JRE<fmt:message code="depatement.th.Edition" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.jdkVersion) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.jdbc" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.dbName) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.DatabaseVersion" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.dbVersion) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.operatingSystem" />：</b></td>' +
                                    '<td class="TableData">' + undefinedStr(data.object.operationSystem) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.LanguageEnvironment" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.language) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.timeZone" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.timezone) + '</td></tr>' +
                                    '<tr><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xthhkxx.png""><td nowrap="" colspan="2" align="left" style="border-bottom:1px solid #c0c0c0;"><div>'+function(){
                                    if($('#theme').val()!=""&&$('#theme').val()!=undefined){
                                        return ' <img src="/img/commonTheme/${sessionScope.InterfaceModel}/zcxx.png" style="float:left;margin-right: 12px; vertical-align: baseline;">'
                                    }else{
                                        return ' <img src="/img/commonTheme/theme1/zcxx.png" style="float:left;margin-right: 12px; vertical-align: baseline;">'
                                    }
                                }()+'<b style="color: #2F5C8F; font-size: 13pt; vertical-align: -webkit-baseline-middle;"><fmt:message code="system.th.RegistrationInformation" /></b></div></td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.SoftNoName" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.softNoName) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.MachineCode" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.authorizationCode) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.RegistrationStatus" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.isSoftAuth) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.Authorized" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.authorizationUnit) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.install" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.installDate) + '</td></tr>' +
                                    '<tr style="'+ block +'"><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.UseDeadline" />：</b></td>' +
                                    '<td nowrap=""  class="TableData">' + undefinedStr(data.object.useEndDate) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Registration" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.lecDateStr) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.EndAuthorizationDate" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + function(){
                                        if(endLecDateStr.indexOf('2040')>=0){
                                            return '<fmt:message code="sysInfo.th.permanentUse" />'
                                        }else{
                                            return endLecDateStr;
                                        }
                                }()+function(){
                                    if(data.object.isSoftAuth.indexOf('<fmt:message code="sysInfo.th.registered" />')>=0&&data.object.show =='<fmt:message code="sysInfo.th.showNonRenewal" />' ){
                                        return '<span style="color: red;margin-left: 10px;"><fmt:message code="sysInfo.th.youCanRenewItDaysBeforeTheExpirationDate" /></span>'
                                    }else{
                                        return ''
                                    }
                                }()+ '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.AuthorizedUnits" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.company_num) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.NumberUnitsUsed" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.useCom) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.NumberUsers" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.oaUserLimit) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.concern" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.userInfo) + '</td></tr>' +
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.softSerialNo" />：</b></td>' +
                                    '<td nowrap="" class="TableData">' + undefinedStr(data.object.softSerialNo) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.optionalComponents" />：</b></td>' +
                                '<td nowrap="" class="TableData"><div class="zujian">' +
                                // '<input type="checkbox" value="1" /><span>手机短信</span>' +
                                // '<input type="checkbox" value="2" style="margin-left:10px"/><span>点聚web签章</span>' +
                                // '<input type="checkbox" value="3" style="margin-left:10px"/><span>CRM客户管理</span>' +
                                // '<input type="checkbox" value="4" style="margin-left:10px"/><span>CMS门户内容管理</span>' +
                                // '<input type="checkbox" value="5" style="margin-left:10px"/><span>预算管理</span>' +
                                // '<br/><input type="checkbox" value="6" /><span>企业微信</span>' +
                                // '<input type="checkbox" value="7" style="margin-left:10px"/><span>钉钉</span>' +
                                // '<input type="checkbox" value="8" style="margin-left:10px"/><span>附件加密</span>' +
                                // '<input type="checkbox" value="8" style="margin-left:10px"/><span>三员管理</span>' +
                                // '<input type="checkbox" value="10" style="margin-left:10px"/><span>手机手写签字</span>' +
                                // '<input type="checkbox" value="11" style="margin-left:10px"/><span>项目管理</span>' +
                                '</div></td></tr>' +
                                    <%--'<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="edition" />：</b></td>' +--%>
                                    <%--'<td nowrap="" class="TableData">' + data.object.edition + '</td></tr>' +--%>
                                    '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Uploadfile" />：</b></td>' +
                                    '<td><form id="formSub" action="/sys/uploadLec" method="post" enctype="multipart/form-data"><input type="file" onchange="types(this)" id="fileData" name="lecFile"  value="<fmt:message code="system.th.Select" />"><input type="button" class="file" onclick="subimtBtn();" style="margin-left: 50px;" value="<fmt:message code="diary.th.remand" />"></form></td></tr></tbody>';
                        }else{
                            var block = 'display: none;';
                            str = '<tbody>' +
                                '<tr><td nowrap="" colspan="2" align="left" style="border-bottom:1px solid #c0c0c0;">'+function(){
                                    if($('#theme').val()!=""&&$('#theme').val()!=undefined){
                                        return '<img src="/img/commonTheme/${sessionScope.InterfaceModel}/xthhkxx.png" style="float:left;margin-right: 12px;vertical-align: baseline;">'
                                    }else{
                                        return '<img src="/img/commonTheme/theme1/xthhkxx.png" style="float:left;margin-right: 12px;vertical-align: baseline;">'
                                    }
                                }()+'<b style="color: #2F5C8F; font-size: 13pt; vertical-align: -webkit-baseline-middle;"><fmt:message code="system.th.SystemAndEnvironment" /></b></td></tr>' +
                                '<tr><td nowrap="" class="TableContent" width="150"><b>&nbsp;<fmt:message code="sysInfo.th.SoftwareName" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.softName) + '<p style="display: inline;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;">&nbsp;&nbsp;&nbsp;&nbsp;' + edition + '</P></td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Copyright" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.cpright) + '</td></tr>' +
                                '<tr class="website"><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.OfficialWebsite" />：</b></td>' +
                                '<td style="background:#fff">' + undefinedStr(data.object.weblocation) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Software" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.softVersion) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.DatabaseVersion" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.dataversion) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.InstallationDirectory" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.installPath) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.WebPort" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.webPort) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.WebServer" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.webServer) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;JRE<fmt:message code="depatement.th.Edition" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.jdkVersion) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.jdbc" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.dbName) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.DatabaseVersion" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.dbVersion) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.operatingSystem" />：</b></td>' +
                                '<td class="TableData">' + undefinedStr(data.object.operationSystem) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.LanguageEnvironment" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.language) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.timeZone" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.timezone) + '</td></tr>' +
                                '<tr><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xthhkxx.png""><td nowrap="" colspan="2" align="left" style="border-bottom:1px solid #c0c0c0;"><div>'+function(){
                                    if($('#theme').val()!=""&&$('#theme').val()!=undefined){
                                        return ' <img src="/img/commonTheme/${sessionScope.InterfaceModel}/zcxx.png" style="float:left;margin-right: 12px; vertical-align: baseline;">'
                                    }else{
                                        return ' <img src="/img/commonTheme/theme1/zcxx.png" style="float:left;margin-right: 12px; vertical-align: baseline;">'
                                    }

                                }()+'<b style="color: #2F5C8F; font-size: 13pt; vertical-align: -webkit-baseline-middle;"><fmt:message code="system.th.RegistrationInformation" /></b></div></td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.SoftNoName" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.softNoName) +'</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.MachineCode" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.authorizationCode) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.RegistrationStatus" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.isSoftAuth) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.Authorized" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.authorizationUnit) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.install" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.installDate) + '</td></tr>' +
                                '<tr style="'+ block +'"><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.UseDeadline" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.useEndDate) + '</td></tr>' +
                                '<tr style="'+ block +'"><td nowrap=""  class="TableContent"><b>&nbsp;<fmt:message code="system.th.Registration" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.lecDateStr) + '</td></tr>' +
                                '<tr style="'+ block +'"><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="sysInfo.th.EndAuthorizationDate" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + function(){
                                    if(endLecDateStr.indexOf('2040')>=0){
                                        return '<fmt:message code="sysInfo.th.permanentUse" />'
                                    }else{
                                        return endLecDateStr;
                                    }
                                }() + function(){
                                    if(data.object.isSoftAuth!=undefined&&data.object.isSoftAuth.indexOf('<fmt:message code="sysInfo.th.registered" />')>=0&&data.object.show =='<fmt:message code="sysInfo.th.showNonRenewal" />' ){
                                        return '<span style="color: red;margin-left: 10px;"><fmt:message code="sysInfo.th.youCanRenewItDaysBeforeTheExpirationDate" /></span>'
                                    }else{
                                        return ''
                                    }

                                }()+ '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.AuthorizedUnits" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.company_num) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.NumberUnitsUsed" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.useCom) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.NumberUsers" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.oaUserLimit) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.concern" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.userInfo) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.softSerialNo" />：</b></td>' +
                                '<td nowrap="" class="TableData">' + undefinedStr(data.object.softSerialNo) + '</td></tr>' +
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.optionalComponents" />：</b></td>' +
                                '<td nowrap="" class="TableData"><div class="zujian">' +
                                // '<input type="checkbox" value="1" /><span>手机短信</span>' +
                                // '<input type="checkbox" value="2" style="margin-left:10px"/><span>点聚web签章</span>' +
                                // '<input type="checkbox" value="3" style="margin-left:10px"/><span>CRM客户管理</span>' +
                                // '<input type="checkbox" value="4" style="margin-left:10px"/><span>CMS门户内容管理</span>' +
                                // '<input type="checkbox" value="5" style="margin-left:10px"/><span>预算管理</span>' +
                                // '<br/><input type="checkbox" value="6" /><span>企业微信</span>' +
                                // '<input type="checkbox" value="7" style="margin-left:10px"/><span>钉钉</span>' +
                                // '<input type="checkbox" value="8" style="margin-left:10px"/><span>附件加密</span>' +
                                // '<input type="checkbox" value="8" style="margin-left:10px"/><span>三员管理</span>' +
                                // '<input type="checkbox" value="10" style="margin-left:10px"/><span>手机手写签字</span>' +
                                // '<input type="checkbox" value="11" style="margin-left:10px"/><span>项目管理</span>' +
                                '</div></td></tr>' +
                                <%--'<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="edition" />：</b></td>' +--%>
                                <%--'<td nowrap="" class="TableData">' + data.object.edition + '</td></tr>' +--%>
                                '<tr><td nowrap="" class="TableContent"><b>&nbsp;<fmt:message code="system.th.Uploadfile" />：</b></td>' +
                                '<td><form id="formSub" action="/sys/uploadLec" method="post" enctype="multipart/form-data"><input type="file" onchange="types(this)" id="fileData" name="lecFile"  value="<fmt:message code="system.th.Select" />"><input type="button" class="file" onclick="subimtBtn();" style="margin-left: 50px;" value="<fmt:message code="diary.th.remand" />"></form></td></tr></tbody>';
                        }
                        $("#TableBlock").html(str);

                        $(".logo").html('<img class="HWlogo" src="/img/sys/HUAWEIcompatible.png">')

                        //判断是否开启了三员管理
                        $.ajax({
                            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                            success:function(res) {
                                var data = res.object[0];
                                console.log(data.paraValue)
                                if(data.paraValue == 0) {
                                    //    如果开启了三元管理，隐藏官方网站信息
                                    $(".website").css("display",'none');
                                    $(".HWlogo").css("display",'none');
                                }
                            }
                        })

                        var module = data.object.module;
                        var str=[]
                        if(module!=""){
                            var arr = module.split(',');
                            for(var i=0;i<arr.length;i++){
                                if(arr[i]==1){
                                    str.push('手机短信')
                                }else if(arr[i]==2){
                                    str.push('点聚web签章')
                                }else if(arr[i]==3){
                                    str.push('CRM客户管理')
                                }else if(arr[i]==4){
                                    str.push('CMS门户内容管理')
                                }else if(arr[i]==5){
                                    str.push('预算管理')
                                }else if(arr[i]==6){
                                    str.push('企业微信')
                                }else if(arr[i]==7){
                                    str.push('钉钉')
                                }else if(arr[i]==8){
                                    str.push('附件加密')
                                }else if(arr[i]==9){
                                    str.push('三员管理')
                                }else if(arr[i]==10){
                                    str.push('手机手写签字')
                                }else if(arr[i]==11){
                                    str.push('项目管理')
                                }else if(arr[i]==12){
                                    str.push('动态密码卡')
                                }
                            }
                            str = str.join('、');
                        }else{
                            str = '手机短信'
                        }
                        $('.zujian').html(str)
                    }
                })
            }
    );

    function undefinedStr(str){
        if(str==undefined||str=='undefined'){
            return ''
        } else {
            return str;
        }
    }

    function subimtBtn() {
        if($('[name="lecFile"]').val()==''){
            $.layerMsg({content:'<fmt:message code="withdraw.th.up" />',icon:2})
            return;
        }
        if(type){
            console.log('通过')
            var form = $("form[id=formSub]");
            var options = {
                //上传文件的路径 
                type:'post',
                dataType : "json",
                success:function(data){
                    $.layerMsg({content: '授权成功！', icon: 1}, function () {
                        location.reload();
                    });
                    //....       //异步上传成功之后的操作
                }
            };
            form.ajaxSubmit(options);
        }else {
            $.layerMsg({content:'只能上传文件类型为.txt的文件',icon:2})
        }

    }

    //-->
    Array.prototype.indexOf = function(val) {//查找
        for (var i = 0; i < this.length; i++) {
            if (this[i] == val) return i;
        }
        return -1;
    };
    function types(me) {
        var url=$(me).val().split('\\')
        if(!/\.(dat)$/.test(url)){
            type=false;
            $.layerMsg({content:'只能上传文件类型为.dat的文件',icon:2})
            var file = document.getElementById("fileData");
            var ie = (navigator.appVersion.indexOf("MSIE")!=-1);
            if( ie ){
                var file2= file.cloneNode(false);
                file2.onchange= file.onchange;
                file.parentNode.replaceChild(file2,file);
            }else{
                $(file).val("");
            }
        }else {
            type=true;
        }
    }
</script>
</body>
</html>
