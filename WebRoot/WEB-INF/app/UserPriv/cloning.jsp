<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/15
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="roleAuthorization.th.Clone" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
<%--    <script type="text/javascript" src="js/jquery/jquery.min.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <style>
        .headDiv {
            width: 100%;
            height: 45px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .nav_t1 {
            height: 45px;
            float: left;
            margin-left: 30px;
            width: 26px;
        }
        .nav_t1 img {
            margin-top: 12px;
        }
        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 12px;
            color: #333;
        }
    </style>
</head>
<body>
<div id="north" style="display: none">
    <div class="head w clearfix">
        <ul class="index_head clearfix">
            <li data_id="0">
                <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="roleAuthorization" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>

            <%--<li>--%>
                <%--<span class="headli1_1">--%>
                    <%--<a onclick="jump(this)" href="javascript:void(0)" data-Url="newRole?0" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
            <%--</li>--%>
            <li data_id="1">
                  <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="adjustTheRole" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="modifyThePermissions?0" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="theAuxiliaryRole" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="superPassword" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a onclick="jump(this)" href="javascript:void(0)" data-Url="theHumanResources" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
        </ul>
    </div>
</div>
<div class="navigation  clearfix" style="display: none">
    <div class="left">
        <img src="../img/icon_addrole_06.png" alt="">
        <div class="news"><fmt:message code="sys.th.roleClone" /></div>
    </div>
</div>
<div class="headDiv">
    <div class="nav_t1"><img src="/img/icon_rolemanage_06.png"></div>
    <div class="divP">角色克隆</div>
</div>

<table class="tr_td" width="450" align="center">
    <tbody>
    <tr>
        <td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.RoleSortingNumber" />：</td>
        <td nowrap="" class="TableData">
            <input type="text" name="PRIV_NO" style="margin-left: 0" class="inp" size="3"  value="">&nbsp;
        </td>
    </tr>
    <tr>
        <td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.RoleName" />：</td>
        <td nowrap="" class="TableData">
            <input type="text" name="PRIV_NAME" style="margin-left: 0" class="inp" size="25" maxlength="100" value="">&nbsp;
        </td>
    </tr>
    <tr>
        <td nowrap="" class="TableData">角色分类：</td>
        <td nowrap="" class="TableData">
            <select name="privTypeId" style="margin-left: 0;width: 70%;font-size: 11pt"></select>
        </td>
    </tr>
    <tr align="center" class="TableControl">
        <td colspan="2" nowrap="">
            <input type="hidden" value="4" name="USER_PRIV">
            <input type="button" value='<fmt:message code="global.lang.save" />' class="import" name="submit">&nbsp;&nbsp;
            <input type="button" value='<fmt:message code="notice.th.return" />' class="import" name="back" onclick="location.href='roleAuthorization'">
        </td>
    </tr>

    </tbody></table>
<script>
    initProjectType()

    function jump(me){
        parent.newjump($(me).attr('data-Url'))
    }
    var urlbool={
        urlstr:null,
        init:function () {
            this.urlstr=window.location.href.split('?')[1];
        }
    }
    urlbool.init()
    $('[name="submit"]').click(function () {
        $.post('/userPriv/copyUserPriv',{'userPriv':urlbool.urlstr,'privNo':$('[name="PRIV_NO"]').val(),
        'privName':$('[name="PRIV_NAME"]').val(),'privTypeId':$('[name="privTypeId"]').val()},function (json) {
            if(json.flag){
                layer.alert('<fmt:message code="sys.th.cloneSuccess" />',{title:'<fmt:message code="information" />',btn:'<fmt:message code="global.lang.ok" />'},function (index) {
                    location.href = 'roleAuthorization';
                })
            }
        },'json')
    })
    function initProjectType() {
        $.ajax({
            type: 'post',
            url: '/userPrivType/queryUserPrivType',
            dataType: 'json',
            success: function (json) {
                // var str = '<option selected=selected>无角色分类</option>'
                var str = ''
                for(var i=0;i<json.obj.length;i++){
                    str+='<option value="'+json.obj[i].privTypeId+'">'+json.obj[i].privTypeName+'</option>'
                }
                $("select[name='privTypeId']").html(str)
            }
        })
    }
</script>
</body>
</html>
