<%--
<%--
 /**
 * @创建作者:李然  Lr
 * @方法描述：导入
 * @创建时间：14:24 2019/5/5
 **/
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="address.th.importExternalContacts" /></title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" href="../../css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .importHead {
            margin: 10px 0 10px 20px;
        }

        .importHead span {
            font-size: 18px;
            margin: 10px 0 10px 5px;
            color: black;
        }

        .importTable {
            width: 80%;
            margin: 0 auto;
        }

        .importBtn {
            width: 60px;
            height: 30px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 40%;
        }

        #model{
            color: #00a0e9;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="importHead">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addrole_06.png" style="margin-left: 30px;margin-bottom: 2px;">
        <span><fmt:message code="address.th.externalContactImport" /></span>
    </div>
    <div class="importDiv">
        <form class="form1" name="form1" id="uploadForm" method="post" action="/address/importAddress"
              enctype="multipart/form-data">
            <table class="importTable">
                <tr>
                    <td><fmt:message code="hr.th.DownloadImportTemplates" />：</td>
                    <td><a id="model"><fmt:message code="address.th.downloadTheImportTemplateForExternalContacts" /></a></td>
                </tr>
                <tr>
                    <td><fmt:message code="hr.th.SelectImportfile" />：</td>
                    <td><input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/></td>
                </tr>
                <tr>
                    <td><fmt:message code="roleAuthorization.th.Explain" />：</td>
                    <td><p><fmt:message code="ipmort.th.7" />。</p>
                        <p>2、<fmt:message code="address.th.userNameIsMandatory" />。</p>
                        <%--<p><fmt:message code="import.th.5" />。</p>
                        <p><fmt:message code="import.th.4" />。</p>
                        <p><fmt:message code="import.th.3" />。</p>
                        <p><fmt:message code="import.th.2" />。</p>
                        <p><fmt:message code="import.th.1" />。</p>
                        <p><fmt:message code="import.th.0" />。</p>--%>
                    </td>
                </tr>
                <%--<tr>--%>
                    <%--<td colspan="2"><input class="importBtn" type="button" value="<fmt:message code="workflow.th.Import" />"></td>--%>
                <%--</tr>--%>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#model').on('click',function () {
            window.location.href = encodeURI("/file/address/<fmt:message code="address.th.publicAddress" />.xls");
        });

        $('.importBtn').on('click',function () {
            var flag = CheckForm();
            if (flag) {
                layer.msg("<fmt:message code="down.th.2" />", {icon: 1});
                $.upload($('#uploadForm'), function (res) {
                    if (res.flag) {

                        layer.msg("<fmt:message code="down.th.3" />" + res.totleNum +"<fmt:message code="event.th.StripData" />!", {icon: 1});
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }
        });

    })
    function CheckForm() {
        if (document.form1.file.value == "") {
            layer.msg("<fmt:message code="user.th.selectImport" />！", {icon: 2});
            return (false);
        }

        return (true);
    }
    function importAddress() {
        var flag = CheckForm();
        if (flag) {
            layer.msg("<fmt:message code="down.th.2" />", {icon: 1});
            $.upload($('#uploadForm'), function (res) {
                if (res.flag) {
                    layer.msg(res.msg, {icon: 1});
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            });
        }
    }
</script>
</body>
</html>
