<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/9/17
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
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
    <title><fmt:message code="office.apply"/></title>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../js/office/applyRecordBatch.js?20230328"></script>
    <style>
        body{
            width: 100%;
            height: 100%;
            overflow-x: hidden;
        }
        .navigation img{
            margin-left: 20px;
            vertical-align: middle;
        }
        a{
            text-decoration: none;
        }
        textarea{
            vertical-align: middle;
        }
        .navigation h2{
            font-weight: normal;
            display: inline-block;
            font-size: 22px;
            color: #494d59;
            vertical-align: middle;
            margin-left: 10px;
        }
        .navigation label{
            vertical-align: middle;
            margin-left: 15px;
        }
        .navigation label select,.navigation label a{
            vertical-align: middle;
            color: #000;
        }
        .navigation label select{
            width: 150px;
            height: 29px;
            line-height: 29px;
            border-radius: 4px;
            margin-right: 10px;
        }
        .navigation label input{
            width: 150px;
            outline: none;
            height: 29px;
            line-height: 29px;
            padding-left: 5px;
            border-radius: 4px;
            margin-right: 10px;
            border: 1px #999 solid;
        }
        .navigation a.submit{
            text-decoration: none;
            background: url(../../img/center_q.png) no-repeat;
            background-size: 74px;
            width: 74px;
            height: 29px;
            line-height: 29px;
            display: inline-block;
            padding-left: 28px;
            box-sizing: border-box;
            vertical-align: middle;
        }
        #pagediv table{
            width: 70%;
            margin: 0 auto;
        }
        #pagediv table tr{
            border: #ccc 1px solid;
        }
        #pagediv table tr th{
            color: #2F5C8F;
            font-weight: bold;
            padding: 8px;
            text-align: center;
            font-size: 13pt;
        }
        #pagediv table tr td{
            padding: 8px;
            text-align: center;
            border-right: #ccc 1px solid;
            font-size: 11pt;
        }
        .dataNum{
            width: 80px;
            height: 30px;
            text-align: center;
        }
        .jiajian{
            display: inline-block;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            font-size: 20pt;
            cursor: pointer;
         }
        .divBtn{
            width: 30%;
            height: 30px;
            margin-left: 35%;
        }
        .saveBtn{
            width: 60px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
            background: #2e8ded;
            color: #ffffff;
            border-radius: 4px;
            margin: 15px auto;
        }
        .save{
            width: 100px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
            background: #2e8ded;
            color: #ffffff;
            border-radius: 4px;
            margin: 15px auto;
        }
        #deptUser{
            width: 260px;
            height: 60px;
            border-radius: 5px;
        }
        #remark{
            width: 260px;
            height: 130px;
            border-radius: 5px;
        }
        .tab{
            width: 96%;
            margin: 15px auto;
        }
        .tab td{
            padding: 8px;
        }
        .tab td:first-of-type{
            text-align: right;
        }
    </style>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
    <h2><fmt:message code="office.Batch.application"/></h2>
    <label>
        <span><fmt:message code="vote.th.OfficeStorehouse"/>：</span>
        <select name="depositoryName">
            <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
        </select>
    </label>
    <label>
        <span><fmt:message code="vote.th.OfficeCategory"/>：</span>
        <select name="typeName" id="typeName">
            <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
        </select>
    </label>
    <label>
        <span><fmt:message code="vote.th.OfficeSupplies"/>：</span>
        <input type="text" name="deposName" value="">
    </label>
    <a href="javascript:;" class="submit"><fmt:message code="datasource.query"/></a>
</div>
<div id="pagediv">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
        <thead>
            <tr>
                <th><fmt:message code="main.th.name"/></th>
                <th><fmt:message code="office.stock"/></th>
                <th><fmt:message code="vote.th.UnitPrice"/></th>
                <th style="width: 150px;"><fmt:message code="event.th.Number"/></th>
                <th style="width: 150px;"><fmt:message code="office.Total.price"/></th>
            </tr>
        </thead>
        <tbody id="trList">

        </tbody>
    </table>
    <div class="divBtn" style="display: flex">
        <div class="saveBtn"><fmt:message code="diary.th.remand"/></div>
        <div class="save"><fmt:message code="office.Join"/></div>
    </div>
</div>
</body>
</html>
