<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="sys.th.addQuan" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>

    <style>
        input{
            vertical-align: text-bottom;
        }
        .TableContentTwo>td{
            padding-right: 5px;
        }
        input[type=checkbox]{
            padding: 0 !important;
        }
        .TableBlock td{
            padding: 5px;
        }
        .TableHeader{
            background: #ccebff;
            font-weight: bold;
        }
        .navigation{
            margin-top:47px;
        }
        .newrole input[type="checkbox"]{
            vertical-align: middle;
        }
        .TableContentTwo input[type="checkbox"]{
            vertical-align: middle;
        }
        .secondary td{
            padding-left: 15px;
        }
        .head .headli1_2{
            margin-top: -5px;
        }
    </style>
</head>
<body >
    <div id="north">

        <div class="head w clearfix">
            <ul class="index_head clearfix">
                <li data_id="0">
                <span class="headli1_1">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>

                <%--<li>--%>
                <%--<span class="headli1_1 ">--%>
                    <%--<a  href="newRole" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                    <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
                <%--</li>--%>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="adjustTheRole" data-Url="" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1 one">
                <a  href="modifyThePermissions?0" data-Url="" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="roleAndClassification" data-Url="" ><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
            </ul>
        </div>
    </div>
    <div class="navigation  clearfix">
        <div class="left">
            <img src="../img/icon_addrole_06.png" alt="">
            <div class="news"><fmt:message code="roleAuthorization.th.Add-delete" /></div>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
        <div style="margin-top: 18px;margin-left:84%;position:fixed;">
            <input type="button" class="import btntrue" value='<fmt:message code="global.lang.ok" />'>
            <input type="button" style="margin-left: 10px" class="backCanBtn" onclick="history.back()" value='<fmt:message code="notice.th.return" />'>
        </div>
    </div>

    <table class="TableBlockthree" width="100%" align="center">
        <form method="post" name="form1" action="add_remove_priv.php"></form>
        <tbody><tr class="TableData">
            <td nowrap="" width="80"><b><fmt:message code="notice.th.operation" />：</b></td>
            <td>
                <input type="radio" name="OPERATION" value="0" id="OPERATION0" checked=""><label for="OPERATION0"><fmt:message code="netdisk.th.addpermission" /></label>
                <input type="radio" name="OPERATION" value="1" id="OPERATION1"><label for="OPERATION1"><fmt:message code="main.th.DeletePermissions" /></label>
            </td>
        </tr>
        <tr class="TableData">
            <td nowrap=""><b><fmt:message code="userManagement.th.role" />：</b><a href="javascript:;" id="alls"><u>全选</u></a></td>

            <td class="newrole">
                <%--<input type="checkbox" name="USER_PRIV" value="19" id="USER_PRIV19"><label for="USER_PRIV19">aa</label>&nbsp;--%>
            </td>
        </tr>
        <input type="hidden" name="USER_PRIV_STR" value="">
        <input type="hidden" name="FUNC_ID_STR" value="">

        </tbody>
    </table>
    <table border="0" cellspacing="0" class="small" cellpadding="3" align="left">
        <tbody>
        <tr class="TableContentTwo">

        </tr>
        </tbody>
    </table>
    <script>
        //全选
        $(document).ready(function() {
            $("#alls").on("click",function(){
                var checkAll=true;
                var checkBoxList=$(this).parent().siblings().find('input')
                for(var i=0;i<checkBoxList.length;i++){
                    if(!checkBoxList[i].checked){
                        checkAll=false;
                        break;
                    }
                }
                if(checkAll){
                    $( $(this).parent().siblings().find('input') ).prop("checked",false);
                }else{
                    $( $(this).parent().siblings().find('input') ).prop("checked",true);
                }
            })
        });
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

</body>
<script async="false" src="/js/UserPriv/modifyThePermissions.js?20230424.1"></script>
</html>
