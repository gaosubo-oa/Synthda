
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
    <title>查询</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        html{
            background: #fff;
        }
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 50px;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .color{
            /*font-size: 14px;*/
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 281px;
            height: 34px;
            line-height:34px;
            padding-left:10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 10pt;
        }
        table tbody td select{
            width: 119px;
            height: 28px;
            border-radius: 4px;
        }
        table tbody td input[type=text]{
            width: 288px;
            height: 32px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        .btnsava{
            padding:5px 15px;
            border-radius: 4px;
            background: #2F8AE3;
            color: #fff;
        }
        #pageTbody tr td{
            text-align: left;
        }
        .page-top-inner-layer{
            padding-right:0px!important;
        }
        .page-bottom-outer-layer,.page-bottom-inner-layer{
            width:100%;
        }
        .layui-layer-btn .layui-layer-btn0 {
            margin-right: 600px;
        }
    </style>
    <script src="/js/mynotice/queryAll.js"></script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png" alt="">
    <h2>查询</h2>
</div>
<div class="query" style="width: 560px;">
    <div class="header"><fmt:message code="event.th.PleaseCriteria"/></div>
    <form id="ajaxform" action="">
        <input type="hidden" name="read">
        <input type="hidden" name="sendTime">
        <table style="width: 100%">
            <tbody>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.publisher"/>：</td>
                <td width="70%">

                    <textarea name="" placeholder="<fmt:message code="addiing.th.Publisher"/>" class="theControlData" readonly="readonly" id="reles" cols="30" rows="10"></textarea>
                    <a href="javascript:;" class="addroles"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="delete"><fmt:message code="global.lang.empty"/></a>

                    <input type="hidden" name="fromId">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.title"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="main.th.ContentSearch"/>" name="subject">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.title.Releasedate"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="doc.th.startDate"/>" name="beginDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" readonly="readonly" style="width: 128px">
                    <span><fmt:message code="global.lang.to"/></span>
                    <input type="text" placeholder="<fmt:message code="doc.th.endDate"/>" name="endDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  style="width: 128px" readonly="readonly">
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.type"/>：</td>
                <td width="70%">
                    <select name="typeId">
                        <%--<option value=""><fmt:message code="notice.type.alltype"/></option>--%>
                        <option value="0" id="noticeType"></option>

                    </select>
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color"><fmt:message code="notice.th.content"/>：</td>
                <td width="70%">
                    <input type="text" placeholder="<fmt:message code="new.th.putcontent"/>" name="content">
                </td>
            </tr>
            <tr class="borderNone">
                <td colspan="2" style="text-align: center">
                    <a href="javascript:;" class="btnsava" onclick="ajaxforms(1)"><fmt:message code="global.lang.query"/></a>
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava chongtian"  ><fmt:message code="global.lang.refillings"/></a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="pagediv" style="visibility:hidden;">

</div>
<script>
    $(function(){
        $('.delete').click(function(){
            $('#reles').attr('username','').attr('dataid','').attr('user_id','').attr('userprivname','');
            $('#reles').val('');
        })
    })
</script>
</body>
</html>