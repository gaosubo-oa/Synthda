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
    <title><fmt:message code="main.systemlogs"/></title>
    <link rel="stylesheet" type="text/css" href="../css/sys/journal.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../lib/echarts/echarts.common.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .colo {
            background: #e8f4fc !important;
            color: #313131;
            text-align: center;
        }
        .colo td{
            padding: 10px !important;
            font-size: 13pt;
        }
        .title{
            height:35px;
            line-height:35px;
        }
        .title span{
            margin-left:0px;
            font-size:22px;
            line-height:35px;
        }
        .title img{
            margin-left:15px;
            vertical-align: middle;
            width:24px;
            height:26px;
            padding-bottom:8px;
        }
        th{
            text-align:left;
            padding-left:10px;
            font-size: 13pt;
        }
        .tabTwo table tr td{
            text-align:left;
            padding-left:10px;
        }
        .AllData td{
            font-size: 11pt;
        }
    </style>

    <script>
        $(function () {
            //查询日志显示列表
            $('.AllData').remove();
            var id = $('#senduser').attr('dataid');
            if (!id) {
                id = '';
            }
            $.ajax({
                type: 'get',
                url: '../sys/getUserLoginLogs',
                dataType: 'json',
                success: function (res) {
                    var data1 = res.obj;
                    var str = '';
                    for (var i = 0; i < data1.length ; i++) {
                        var sendTime = data1[i].time.replace(/-/g,"/");
                        str += '<tr class="AllData"><td>' + (i + 1) + '</td><td>' + data1[i].userName + '</td><td>' + sendTime + '</td><td>' + data1[i].ip + '</td><td>' + data1[i].typeName + '</td><td>' + data1[i].remark + '</td></tr>';
                    }
                    $('.queryJournalList').after(str);
                }
            })

        });
    </script>
</head>
<body>


<div class="queryResult">
    <div class="title">
        <img src="../img/log.png" alt="安全日志">
        <span><fmt:message code="url.th.safelog" /></span>
    </div>
    <div class="tabTwo">
        <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 90%;">
            <tr class="colo">
                <td colspan="6">
                    <span style="font-weight: bold"><fmt:message code="url.th.twentysafelog" /></span>
                </td>
            </tr>
            <tr class="queryJournalList">
                <th><fmt:message code="url.th.safeLogNo"/></th>
                <th><fmt:message code="journal.th.UserName"/></th>
                <th><fmt:message code="email.th.time"/></th>
                <th><fmt:message code="journal.th.IPaddress"/></th>
                <th><fmt:message code="journal.th.LogType"/></th>
                <th><fmt:message code="journal.th.Remarks"/></th>
            </tr>

        </table>
    </div>
</div>
</div>
</div>
</body>
</html>

