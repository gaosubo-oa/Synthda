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
    <title><fmt:message  code="vote.th.OfficeImport"/></title>
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>

    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.js"></script>
    <style type="text/css">
        .importHead {
            margin: 10px 0 10px 20px;
        }

        .importHead span {
            font-size: 18px;
            margin: 10px 0 10px 20px;
        }

        .importTable {
            width: 80%;
            margin: 0 auto;
        } td:first-child{
                      width:17%;
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
        <span><fmt:message  code="vote.th.InformationImport"/></span>
    </div>
    <div class="importDiv">
        <form class="form1" name="form1" id="uploadForm" method="post" action="/officeSupplies/importOfficeProducts/"
              enctype="multipart/form-data">
            <table class="importTable">
                <tr>
                    <td><fmt:message  code="hr.th.DownloadImportTemplates"/>：</td>
                    <td><a id="model"><fmt:message  code="vote.th.OfficeDownload"/></a></td>
                </tr>
                <tr>
                    <td><fmt:message  code="hr.th.SelectImportfile"/>：</td>
                    <td><input style="width: auto" type="file" name="file"/></td>
                </tr>
                <tr>
                    <td><fmt:message  code="hr.th.Explain"/>：</td>
                    <td><p><fmt:message  code="vote.th.a"/>；</p>
                        <p><fmt:message  code="vote.th.b"/>；</p>
                        <p><fmt:message  code="vote.th.c"/>；</p>
                        <p><fmt:message code="office.d.text"/></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input class="importBtn" type="button" value="<fmt:message  code="workflow.th.Import"/>"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#model').click(function () {
            window.location.href = encodeURI("/file/office/<fmt:message  code="office.import"/>.xls");
        });

        $('.importBtn').click(function () {
            var flag = CheckForm();
            if (flag) {
                layer.msg("<fmt:message  code="down.th.2"/>", {icon: 1});
                var index = layer.load();

                <%--$.upload($('#uploadForm'), function (res) {--%>
                    <%--if (res.flag) {--%>

                        <%--layer.msg("<fmt:message  code="down.th.3"/>" + res.totleNum +"<fmt:message  code="event.th.StripData"/>!", {icon: 1});--%>
                    <%--} else {--%>
                        <%--layer.msg(res.msg, {icon: 2});--%>
                    <%--}--%>
                <%--});--%>
                $('#uploadForm').ajaxSubmit({
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
//                            var str="共导入" + res.object.inputSuccess +"条数据!<br>"+
//                                "更新了" + res.object.updateSuccess +"条数据!";
                            layer.close(index);
                            layer.msg("<fmt:message  code="down.th.3"/>" + res.totleNum +"<fmt:message  code="event.th.StripData"/>!", {icon: 1});

                        } else {
                            layer.msg('<fmt:message code="office.import.text"/>', {icon: 2});
                        }
                    }
                })
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
</script>
</body>
</html>
