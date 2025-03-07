
<%@ page language="java" contentType="text/html; charset=UTF-8"
           pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="censor.th.modulesettings" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <%--<script src="../js/jquery/jquery.cookie.js"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>

        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
    </style>
    <script src="/js/censor/Edit.js"></script>
    <script>

    </script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <h2></h2>

</div>
<div id="pagediv" class="tableMain">
    <form id="ajaxform" action="">
    <table>
        <tbody>
        <input type="hidden" value="" name="moduleId"/>
            <tr>
                <td width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="censor_th_modulename"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="moduleCode" placeholder="">
                </td>
            </tr>
      <%--      <tr>
                <td width="20%">
                    <fmt:message code="censor_th_filtering"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" name="startUsing" value="1">
                    <span><fmt:message code="censor_th_filtering"/></span>
                </td>
            </tr>--%>
            <tr>
                <td width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="censor_th_reviewers"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="checkUser">
                </td>
            </tr>
<%--            <tr class="deptrole">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="censor_th_reviewers"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="personnel" cols="30" rows="10"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="3"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="userId">
                </td>
            </tr>--%>
            <tr>
                <td  width="20%">
                    <fmt:message code="censor_th_remind"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" name="smsRemind" value="1">
                    <span><fmt:message code="censor_th_remind"/></span>
                </td>
            </tr>
            <tr>
                <td  width="20%">
                    <fmt:message code="censor_th_telremind"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" name="sms2Remind" value="0">
                    <span><fmt:message code="censor_th_telremind"/></span>
                </td>
            </tr>
            <tr>
                <td width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="censor_th_Disablingtooltips"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="bannedHint">
                </td>
            </tr>
            <tr>
                <td width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="censor_th_Reviewtips"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="modHint">
                </td>
            </tr>
            <tr>
                <td width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="censor_th_Filtertip"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="filterHint">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center" class="btnarr">
                    <a href="javascript:;" class="savebtn" onclick="ajaxforms(0)"><fmt:message code="global.lang.save"/></a>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</div>
</body>
</html>