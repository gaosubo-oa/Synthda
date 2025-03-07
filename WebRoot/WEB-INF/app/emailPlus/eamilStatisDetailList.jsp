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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="adding.th.list" /></title><%--邮件详情--%>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 10pt;width: 100%;}
        .content{
            width: 100%;
        }
        select{
            width: 200px;
            height: 30px;
            outline: none;
            border-radius: 4px;
        }
        .header{
            margin-left: 10px;
            margin-top: 10px;
        }
        .mainCon{
            width: 100%;
        }
        .mainCon table{
            width: 99%;
            margin: 20px auto;
        }
        .mainCon table tr{
            border: #ccc 1px solid;
        }
        .mainCon table tr th{
            padding: 5px;
            color: #2F5C8F;
        }
        .mainCon table tr td{
            padding: 5px;

        }
    </style>
</head>
<body>
<div class="content">
    <div class="header">
        <div><fmt:message code="adding.th.xdf" />—</div>

        <div class="saveBtn"><span style=""><fmt:message code="notice.th.return" /></span></div>
    </div>
    <div class="mainCon">
        <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
            <thead>
            <tr>
                <th><fmt:message code="global.lang.date" /></th>
                <th><fmt:message code="notice.th.title" /></th>
                <th><fmt:message code="notice.th.fileUpload" /></th>
            </tr>
            </thead>
            <tbody id="divTable">

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
