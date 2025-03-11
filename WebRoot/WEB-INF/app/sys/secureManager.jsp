<%--
  Created by IntelliJ IDEA.
  User: luopeng
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
<head>
    <title><fmt:message code="three.th.BatchSetupAuditor" /></title>
    <link rel="stylesheet" href="/css/meeting/equipment.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>

    body{
        font-size: 14px;
        font-family: 微软雅黑;
    }
    .pagediv table tbody tr td {
        border: 1px solid #c0c0c0;
    }
    .main{
        margin-top: 0px;
    }
    input[type="radio"] {
        margin: 3px 3px 0px 5px;
    }
    input[type="radio" ] {
        -webkit-appearance: radio;
        box-sizing: border-box;
    }
    input[type="radio" ], input[type="checkbox" ] {
        background-color: initial;
        margin: 3px 0.5ex;
        padding: initial;
        border: initial;
    }
    table{
        width: 60%;
        margin-left: 20%;
        margin-top: 100px;
    }
    .headTop{
        border-bottom: 0px;
    }
    .divTitle1{
        float: left;
        height: 45px;
        line-height: 45px;
        font-size: 22px;
        margin-left: 60px;
        color: #494d59;
        margin-top: -70px;
    }
    #save{
        display: inline-block;
        float: left;
        width: 78px;
        height: 38px;
        line-height: 35px;
        margin-top: 20px;
        margin-bottom: 20px;
        cursor: pointer;
        border-radius: 3px;
        background: url("../../img/save.png") no-repeat;
        padding-left: 19px;
        font-size: 14px;
        margin-left: 50%;
        text-align: center;
    }
</style>
<body style="font-family: 微软雅黑;">
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_equipment.png" alt="">
    </div>
    <div class="divTitle">
       <fmt:message code="three.th.BatchAuditor" />
    </div>
</div>
<div class="main">
    <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: -30px;">
        <table>
            <thead>
            <tr>
            <td><fmt:message code="journal.th.OperationType" /></td>
                <td class="TableData">
                    <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="TRAIL_PASS_OR_NOT" value="1" onClick="expandIt1()"> <fmt:message code="three.th.increase" />&nbsp;&nbsp;
                    <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="TRAIL_PASS_OR_NOT" value="0" onClick="expandIt1()" checked> <fmt:message code="three.th.reduce" />
                </td>
            </tr>
            <tr>
                <td><fmt:message code="three.th.AuditPersonnel" /></td>
                <td>
                    <div class="inPole"><textarea name="txt" id="userDuserSd" user_id="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div>
                </td>
            </tr>
            <tr>
                <td><fmt:message code="three.th.DepartmentConcerned" /></td>
                <td>
                    <div class="inPole"><textarea name="txt" id="userDept" userDept="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearDept "><fmt:message code="global.lang.empty" /></a></span></div>
                </td>
            </tr>
            <tr> <td colspan="2"><div id="save" type="publish" class="btn_ok" ac="add"><fmt:message code="global.lang.save" /></div></td></tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
    <div class="bottom">
            <div class="divTitle1">
                <fmt:message code="three.th.Auditor" />
            </div>
        <div class="pagediv1" id="already1" style="margin: 0 auto;width: 97%;margin-top: 50px;">
            <table>
                <thead>
                <tr>
                    <td><fmt:message code="depatement.th.Departmentname" /></td><td><fmt:message code="three.th.ConfidentialChecker" /></td>
                </tr>
                <tbody>
                </tbody>
            </table>
        </div>
</div>

<script>
    $("#selectUserSd").on("click",function(){
        user_id='userDuserSd';
        $.popWindow("../common/selectUser");
    });

    $('#clearUserSd').click(function(){ //清空人员
        $('#userDuserSd').attr('user_id','');
        $('#userDuserSd').attr('dataid','');
        $('#userDuserSd').val('');
    });


    $("#selectDept").on("click",function(){//选部门控件
        dept_id='userDept';
        $.popWindow("../common/selectDept");
    });
    $('#clearDept').click(function(){ //清空人员
        $('#userDept').attr('dept_id','');
        $('#userDept').attr('deptid','');
        $('#userDept').val('');
    });

    $(function () {
        init();
    });
    function init(){
        //发送ajaxhuoq数据。
    }

</script>
</body>
</html>
