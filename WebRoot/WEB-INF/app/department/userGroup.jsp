<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="depatement.th.customgroup" /></title>
    <link rel="stylesheet" href="/css/dept/userGroup.css">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <style>
        thead td{
            font-size:15px;
            font-weight: 600;
            color:#23477e;
        }
        .bodycolor {
            BACKGROUND: #f9f9f9;
        }
        .navigation .left img {
            padding-left: 0;
            margin-left: 30px;
        }
        .tr_td thead tr{
            background-color: #fff!important;
        }
        .tr_td tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
        .tr_td tr:nth-child(even) {
            background-color: #fff;
        }
        tr td{
            text-align: center;
        }
        .layui-layer-dialog{
            top: 50%!important;
            margin-top: -80px;
        }
    </style>
</head>
<body class="bodycolor">
<div id="showUserGroup">
        <div class="navigation  clearfix">
            <div class="left">
                <img src="../img/department/groupEdit.png" alt="">
                <div class="news newtwo"><fmt:message code="user.th.NewGroup" /></div>
                <div id="Confidential" style="display: inline-block"></div>
            </div>
        </div>
        <div id="showdiv" style="text-align: center">
            <span style="cursor:pointer;" class="new_dept"  onclick="editUserGroup(this)" data-num="0">
                <label> <fmt:message code="user.th.NewGroup" /></label>
            </span>

            <div class="navigation  clearfix" style="margin-top: 47px">
                <div class="left">
                    <img src="../img/department/groupManager.png" alt="">
                        <div class="news"><fmt:message code="user.th.ManagingGroups" /></div>
                </div>
            </div>
            <table class="tr_td tr_tds" width="70%"  style="border-collapse: collapse;border-top: 1px solid #c0c0c0;border-left: 1px solid #c0c0c0;" border="1" align="center">
                <thead>
                    <tr class="TableHeader">
                        <td nowrap="" align="center"><fmt:message code="user.th.UserName" /></td>
                        <td nowrap="" align="center"><fmt:message code="file.th.Sort" /></td>
                        <td nowrap="" align="center"><fmt:message code="notice.th.operation" /></td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <br>
            <%--<input type="button" style="margin-left: 10px" class="backCanBtn" onclick="fanhui1()" value="<fmt:message code="notice.th.return" />">--%>
        </div>
</div>

<div id="addUserGroup" style="display: none">
    <div class="navigation  clearfix">
        <div class="left">
          <img src="../img/department/groupEdit.png" alt="">
          <div class="news"><fmt:message code="user.th.NewPacket" /></div>
        </div>
    </div>

    <form action="" method="post" name="form1">
        <table class="tr_td" width="450" align="center">
             <tbody>
             <tr>
                 <td nowrap="" class="TableData" style="width: 88px;"><fmt:message code="file.th.Sort" />：</td>
                  <td nowrap="" class="TableData">
                        <input type="text" name="ORDER_NO" style="margin: 0;" class="inp" size="5" maxlength="10" value="">&nbsp;<br>
                 </td>
             </tr>
             <tr>
                 <td nowrap="" class="TableData"><fmt:message code="user.th.UserName" />：</td>
                 <td nowrap="" class="TableData">
                        <input type="text" name="GROUP_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;
                 </td>
              </tr>
              <tr>
                    <td nowrap="" class="TableControl" colspan="2" align="center">
                      <input type="button" value="<fmt:message code="global.lang.ok" />" id="import" class="import">&nbsp;&nbsp;
                       <input type="button" style="margin-left: 10px" class="backCanBtn" onclick="fanhui()" value="<fmt:message code="notice.th.return" />">
                    </td>
               </tr>
               </tbody>
          </table>
    </form>
</div>
<div id="setUser" style="display: none">
    <div class="navigation  clearfix">
        <div class="left">
            <img src="../img/department/groupEdit.png" alt="">
            <div class="news newtwo"><fmt:message code="user.th.SetUser" /></div>
        </div>
    </div>
    <table class="tr_td" width="45%" align="center">
        <form action="rolemanagement_submit.php" method="post" name="form1" onsubmit="return CheckForm();"></form>
        <tbody><tr>
            <td class="TableData">
                <input type="hidden" name="HR_ROLE_MANAGE" value="">
                <textarea cols="50" id="mainsstwo" name="COPY_TO_NAME" rows="5" class="BigStatic" wrap="yes" readonly="" dataid="" user_id=""></textarea>
                <a href="javascript:;" class="orgAdd" data-num="0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="orgClear" data-numTwo="0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableControl" colspan="2" align="center">
                <input type="button" value="<fmt:message code="global.lang.ok" />" class="setUserButton import">&nbsp;&nbsp;
                <input type="button" style="margin-left: 10px" class="backCanBtn" onclick="fanhui()" value="<fmt:message code="notice.th.return" />">
            </td>
        </tr>

        </tbody>
    </table>
</div>
</body>
<script>
    var groupId;//既用于判断是新建还是编辑，又用于存储编辑时传的groupId
    function editUserGroup(me) {
       if($(me).attr('data-num')!=0){
          $('#addUserGroup .news').text('<fmt:message code="user.th.EditGroup" />')
           this.ajaxdata($(me).attr('data-num'));//请求回显数据
       }else {
           $('#addUserGroup .news').text('<fmt:message code="user.th.NewPacket" />')
           $('[name="ORDER_NO"]').val("")
           $('[name="GROUP_NAME"]').val("")
       }
        groupId=$(me).attr('data-num')
        $('#addUserGroup').show()
        $('#showUserGroup').hide()
    }
    function ajaxdata(data) {
       /* console.log(this.urlstr)*/
        $.get('/usergroup/getUserGroupByGroupId',{'groupId':data},function (json) {
            if(json.flag){
                $('[name="ORDER_NO"]').val(json.object.orderNo)
                $('[name="GROUP_NAME"]').val(json.object.groupName)
            }
        },'json')
    }

    //循环显示数据
    $(function () {
        $.get('/usergroup/getAllUserGroup', function (data) {
            if (data.flag) {
                var streingt = ''
                for (var i = 0; i < data.obj.length; i++) {
                    streingt += '<tr><input type="hidden" name="groupId" value="' + data.obj[i].groupId  + '">' +
                        '<td align="left">' + data.obj[i].groupName + '<input type="hidden" name="groupName" value="' + data.obj[i].groupName + '"></td>' +
                        '<td align="left">' + data.obj[i].orderNo + '<input type="hidden" name="orderNo" value="' + data.obj[i].orderNo + '"></td>' +
                        '<td nowrap="" align="center"><a href="javascript:void(0)" onclick="editUserGroup(this)" data-num="'+data.obj[i].groupId+'" class="textbj" style="margin-right: 10px"><fmt:message code="global.lang.edit" /></a>' +
                        '<a href="javascript:void(0)" class="deletea" style="margin-right: 10px"  data-num="'+data.obj[i].groupId+'"><fmt:message code="global.lang.delete" /></a>'+'<a href="javascript:void(0)" class="setUserBt"  data-num="'+data.obj[i].groupId+'"><fmt:message code="user.th.SetUser" /></a></td></tr>'
                }
                $('.tr_tds tbody').html(streingt)

            }
        }, 'json')
    })
$('#import').on("click",function () {
    if(groupId==0){
        postUrl='/usergroup/insertUserGroup';//走添加步骤
        obj={'groupName':$('[name="GROUP_NAME"]').val(),
            'orderNo':$('[name="ORDER_NO"]').val()
        }
    }else{
        postUrl='/usergroup/updateUserGroup';//走修改步骤
        obj={'groupId':groupId,
            'groupName':$('[name="GROUP_NAME"]').val(),
            'orderNo':$('[name="ORDER_NO"]').val()
        }
    }
    $.post(postUrl,obj,function (json) {
        if(json.flag){
            $.layerMsg({content:'<fmt:message code="user.th.SuccessfulOperation" />',icon:1},function () {
                location.reload();
            })
        }
    },'json')
    $('#addUserGroup').hide()
    $('#showUserGroup').show()
})
    $(document).on('click','.deletea',function () {
        var delGroupId=$(this).attr("data-num");
        $.layerConfirm({title: '<fmt:message code="workflow.th.suredel" />', content: '<fmt:message code="workflow.th.que" />？', icon: 0}, function () {
            $.post('/usergroup/delUserGroupByGroupId', {'groupId':delGroupId }, function (json) {
                if (json.flag) {
                    location.reload()
                }
            }, 'json')
        })
        $('.layui-layer-dialog').css('top',$('.layui-layer-shade').height()/2-80 +'px')
    })

    //设置用户
    $('.orgAdd').on("click",function(){
        user_id = $(this).prev().prop('id')
        $.popWindow("../common/selectUser");
    })
    var upGroupId;
    $('.tr_td ').on('click','.setUserBt',function(){//设置用户按钮

        upGroupId=$(this).attr("data-num");
        $.ajax({
            url: '/usergroup/getUserGroupByGroupId',
            type: 'get',
            dataType: 'json',
            data:{
                groupId:upGroupId
            },
            success: function (obj) {
                if(obj.flag){
                    $('[name="COPY_TO_NAME"]').val(obj.object.userName)
                    $('[name="COPY_TO_NAME"]').attr("user_id",obj.object.userStr)
                }
            }
        })
        $('#addUserGroup').hide()
        $('#showUserGroup').hide()
        $('#setUser').show()
    })

    $(".setUserButton").on("click",function(){
        var userStr=$("#mainsstwo").attr("user_id");
        postUrl='/usergroup/updateUserGroup';//设置用户
        obj={'groupId':upGroupId,
            'userStr':userStr
        }
        if(userStr==""){
            $.layerMsg({content:'用户不能为空',icon:2},function () {
            })
            return
        }
        $('#setUser').hide()
        $.post(postUrl,obj,function (json) {
            if(json.flag){

                $.layerMsg({content:'<fmt:message code="user.th.SuccessfulOperation" />',icon:1},function () {
                    /*location.reload();*/

                    //window.location.href = '/usergroup/userGroup';
                })

            }
        },'json')
        $('#addUserGroup').hide()
        $('#showUserGroup').show()
    })
    $('.orgClear').on("click",function () {
        $('#mainsstwo').val('')
        $('#mainsstwo').attr('dataid','')
        $('#mainsstwo').attr('user_id','')
        $('#mainsstwo').attr('username','')
        $('#mainsstwo').attr('userprivname','')
    })

    $(".backCanBtn").on("click",function(){
        $('#addUserGroup').hide()
        $('#showUserGroup').show()
        $('#setUser').hide()
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }

        }
    })
</script>
</html>
