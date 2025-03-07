<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="main.administratorset" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/setLeader.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    table tr td a {
        font-size: 14px;
        color: #2b7fe0;
    }
</style>
<body style="font-family: 微软雅黑;">
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageUser.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="main.administratorset" />
    </div>
</div>
<div class="main">
    <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
        <table style="background: white; width:50%;">
            <tr>
                <td style="color: #2F5C8F!important;font-weight: bold;text-align: center; font-family:微软雅黑;font-size: 13pt; height: 40px;border-bottom: solid 1px #cccccc;"><fmt:message code="meet.th.AddPersonnel" /></td>
            </tr>
            <tr>
                <td>
                    <div style="margin: 30px auto;">
                        <textarea name="text" id="meetingUser" user_id="" value="" disabled="" style="background:#f2f2f2; min-width: 60%;height:150px;padding:10px;margin-left: 94px;"></textarea>
                        <span class="add_img"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span>
                        <span class="add_img" style="margin-left: 5px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: center;height: 50px; border-top: solid 1px #cccccc;">
                    <div class="btnSure">
                        <span style="margin-left: 22px;" id="okbtn"><fmt:message code="global.lang.ok" /></span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</div>

<script>
    var user_id='';
    $(function () {
        $.ajax({
            url: "/syspara/getUserName",
            type: "get",
            data: {
                paraName: "MEETING_MANAGER_TYPE"
            },
            dataType: 'json',
            success: function (obj) {
                $('#meetingUser').attr('user_id',obj.object.userId);
                $('#meetingUser').html(obj.object.userName);
            }
        });

        $("#selectUser").on("click",function(){//选人员控件
            user_id='meetingUser';
            $.popWindow("../common/selectUser");
        });
        $('#clearUser').on("click",function(){ //清空人员
            $('#meetingUser').attr('user_id','');
            $('#meetingUser').attr('dataid','');
            $('#meetingUser').val('');
        });
    })
    $('#okbtn').on("click",function(){
        var data={
            usersIds:$('#meetingUser').attr("user_id")
        }
        $.ajax({
            url: "/syspara/editSysPara",
            type: 'get',
            dataType: "JSON",
            data: data,
            success:function (data){
                if(data.flag==true){
                    layer.msg('<fmt:message code="diary.th.modify" />', {icon: 1});
                }else{
                    layer.msg('<fmt:message code="meet.th.SaveFailed" />', {icon: 6});
                }
            }
        })
    });
</script>
</body>
</html>
