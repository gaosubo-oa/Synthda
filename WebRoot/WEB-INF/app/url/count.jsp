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
    <title><fmt:message code="mian.panel" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>

    <script src="../../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../js/sys/userInfor.js" type="text/javascript" charset="utf-8"></script>--%>
    <style>
        #submit{
            margin-bottom: 2px;
            border: none;
        }
        .btn input{
            padding: 2px 10px;
            border-radius: 5px;
            border-width: 1px;
            border-style: solid;
        }
        .content{
            background-color: #ffffff;
        }
        .content .right{
            width: 100%;
        }
        .colo{
            background: #e8f4fc;
            color: #313131;
            text-align: left;
        }
        table.table tr {
            border: none;
        }
        table.table tr.padstyle td {
            padding-top: 40px;
        }
        table.table tr th {
            border-right: none;
            padding: 0px 0px 0px 43px;
            height:36px;
        }
        table.table tr td {
            border-right: none;
            padding: 10px;
        }
        table.table tr td span {
            color:#999;
        }
        table.table tr td:first-of-type {
            text-align: right;
            width: 30%;
            font-weight:bold;
        }
        table.table tr td:last-of-type {
            padding-left: 20px;
        }
        table.table {
            width: 100%;
            margin: 0px auto;
            font-size: 14px;
            margin-bottom: 40px;
        }
        table.table tr td input[type="checkbox"]{
            margin-left: 10px;
            margin-right: 5px;
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


        table.table tr td input[type="text"] {
            width: 200px;
            height: 28px;
            background-color: white;
            border: 0px;
        }

        table.table tr .red_text{
            text-align: right;
            width: 30%;
            font-weight: bold;
        }
        #whiteList span{
            color: black;
        }
        #whiteList label span{
            color: black;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right">
        <div class="title">
            <img src="../img/mycount.png" alt="<fmt:message code="url.th.myAccount" />">
            <span><fmt:message code="url.th.myAccount" /></span>
        </div>
        <div class="main" style="...">
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center">
                    <th colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.AccountInformation" /></span>
                    </th>
                </tr>
                <tr class="padstyle">
                    <td class="red_text"><fmt:message code="userName" />:</td>
                    <td id="byname" name="byname" class="byname" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <div class="btn" style="margin-left: 0px">
                          <%--  <input id="submit" class="submit" type="button" value="保存修改">--%>
                            <%--<input id="submit" style="color: black " type="button" class="inpuBtn backOkBtn"  value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.save" />">--%>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="main" style="...">
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center">
                    <th colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.userRolesAndCommunicationScope" /></span>
                    </th>
                </tr>
                <tr class="padstyle">
                    <td class="red_text"><fmt:message code="url.th.Leading" />:</td>
                    <td class="userPrivZhu">

                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.AuxiliaryRole" />:</td>
                    <td class="userPrivOthers">

                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="user.th.WhiteList" />:</td>
                    <td class="whiteList" id="whiteList">

                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.contactListViewingPermissions" />:</td>
                    <td class="lookAdress" id="lookAdress">

                    </td>
                </tr>
            </table>
            <div class="main" style="...">
                <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                    <tr  class="colo" align="center">
                        <th colspan="2">
                            <span style="font-weight: bold"><fmt:message code="url.th.SystemUsePermission" /></span>
                        </th>
                    </tr>
                    <tr class="padstyle">
                        <td class="red_text"><fmt:message code="url.th.accessControl" />:</td>
                        <td>
                            <input type="checkbox" disabled><fmt:message code="url.th.prohibitWebPageLogin" />
                            <span id="appLogin"> <input type="checkbox" disabled><fmt:message code="url.th.NoLogin" /></span>
                        </td>
                    </tr>
                    <tr id="emailSize">
                        <td class="red_text"><fmt:message code="user.th.InternalMailboxCapacity" />:</td>
                        <td>
                            <fmt:message code="url.th.Unrestricted" />
                        </td>
                    </tr>
                    <tr id="fileSize">
                        <td class="red_text"><fmt:message code="url.th.PersonalCapacity" />:</td>
                        <td class="personFile">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
        //判断是否有开启三员管理
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
            success:function(res) {
                var data = res.object[0];
                if(data.paraValue == 0) {
                    $("#appLogin").hide();
                    $("#emailSize").hide();
                    $("#fileSize").hide();
                }
            }
        })
        var datas=[]
        var datass=[]
        $.ajax({
            type: "get",
            url: "/getLoginUser",
            dataType: 'json',
            success: function (obj) {
                var str = '';
                if (obj.flag) {
                    if(obj.object.modulePriv != undefined){
                        var res = obj.object.modulePriv
                        str += '<span>部门：</span><label style="margin-right: 10px;"><span class="checkChild" value="">' +function(){if(res.deptName == undefined){return ''}else{return ''}}() + '</span></label><br>'
                        str += '<span>角色：</span><label style="margin-right: 10px;"><span class="checkChild" value="">' +function(){if(res.privName == undefined){return ''}else{return res.privName}}()  + '</span></label><br>'
                        str += '<span>人员：</span><label style="margin-right: 10px;"><span class="checkChild" value="">' +function(){if(res.userName == undefined){return ''}else{return res.userName}}()+ '</span></label><br>'
                        $("#whiteList").append(str)
                    }
                    if(obj.object.deptYj != undefined){
                        var id = obj.object.deptYj.split(",")
                    }else{
                        var id = [];
                    }
                    $('#byname').text(obj.object.byname || '');
                    $('#byname').attr('userId',obj.object.userId || '')
                    $('.userPrivZhu').text(obj.object.userPrivName || '');
                    $('.userPrivOthers').text(obj.object.userPrivOtherName || '');
                    $.ajax({
                        url: "/department/getDepartmentYj",
                        type: "get",
                        dataType: "json",
                        success: function (res) {
                            var str = '';
                            if (res.flag) {
                                var data = res.obj;
                                for (var i = 0; i < data.length; i++) {
                                    str += '<label style="margin-right: 10px;"><input name="deptYj" class="checkChild" id="zxc" onclick="return false;"  type="checkbox" value="' + data[i].deptId + '">' + data[i].deptName + '</input></label>'
                                    datas.push(data[i].deptId)
                                    datass.push(id[i])
                                }

                                $("#lookAdress").append(str)
                                let arr = [];
                                for (let i = 0; i < datass.length; i++) {
                                    $('input[name="deptYj"]').each(function(){
                                        if (datass[i] == $(this).val()) {
                                            this.checked = true;
                                        }
                                    })
                                }
                                return arr;
                            }

                        }
                    })
                    if(obj.object.userExt.folderCapacity == '' || obj.object.userExt.folderCapacity == 0){
                        $('.personFile').text('<fmt:message code="url.th.Unrestricted" />')
                    }else{
                        $('.personFile').text(obj.object.userExt.folderCapacity +'M')
                    }
                }else{
                    $.layerMsg({content:'数据返回错误！',icon:1});
                }

            },
        })
        $('#submit').click(function () {
            var data={
                byname:$('#byname').val(),
                userId:$('#byname').attr('userId')
            };
            $.ajax({
                type: "get",
                url: "/user/editUser",
                dataType: 'json',
                data:data,
                success: function (obj) {
                    $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function(){
                        console.log(obj);
                    });
                },
            });
        })


    })
</script>
</body>
</html>

