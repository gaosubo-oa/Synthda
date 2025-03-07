<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2017/6/13
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../../css/base.css">
    <link rel="stylesheet" href="../../css/netdesk/netdesksetting.css">

</head>
<body>
<div class="con">
    <div class="list_p">
        <ul class="power_t clearfix">
            <li>
                <a href="javascript:;" class="power_list power_bg"><fmt:message code="netdisk.th.AccessAuthority" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li><a href="javascript:;" class="power_list"><fmt:message code="workflow.th.privilege" /></a>
                <img src="../../img/twoth.png" alt=""></li>
            <li>
                <a href="javascript:;" class="power_list"><fmt:message code="netdisk.th.NewPermissions" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li>
                <a href="javascript:;" class="power_list"><fmt:message code="netdisk.th.Download-print" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li><a href="javascript:;" class="power_list"><fmt:message code="netdisk.th.BatchSettings" /></a></li>

        </ul>
    </div>
    <div class="con_item">
        <div class="item item_1">
            <div class="power_des">
                <span class="power_ex"><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file1" /></span>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                </div>
                <div class="power_text">
                    <textarea name="txt" id="senddep" dept_id="admin" value="admin" disabled
                              class="sendsave senddep"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_dept1"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_dept1"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                </div>
                <div class="power_text">
                    <textarea name="txt" id="sendrole" priv_id="admin" value="admin" disabled
                              class="sendsave sendrole"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_role1"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_rloe_1"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="senduser" user_id="admin" value="admin" disabled
                      class="sendsave senduser"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="adduesr"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_user"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_but">
                <button type="submit" class="bigButton" value="确定" id="btn_sure"><fmt:message code="global.lang.ok" /></button>
                <button type="submit" class="bigButton btn_back" value="返回"><fmt:message code="notice.th.return" /></button>

            </div>
        </div>
        <div class="item">
            <div class="power_des">
                <span class="power_ex"><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file2" /></span>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_dept2" dept_id="admin" value="admin" disabled
                      class="sendsave senddep"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_dept2"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_dept2"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_role2" priv_id="admin" value="admin" disabled
                      class="sendsave sendrole"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_role2"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_role2"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_uesr2" user_id="admin" value="admin" disabled
                      class="sendsave senduser"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_user2"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_user2"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_but">
                <button type="submit" class="bigButton" value="确定"><fmt:message code="global.lang.ok" /></button>
                <button type="submit" class="bigButton" value="返回"><fmt:message code="notice.th.return" /></button>

            </div>
        </div>
        <div class="item">

            <div class="power_des">
                <span class="power_ex"><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file3" /></span>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_dept3" dept_id="admin" value="admin" disabled
                      class="sendsave senddep"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_dept3"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_dept3"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_role3" priv_id="admin" value="admin" disabled
                      class="sendsave sendrole"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_role3"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_role3"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_user3" user_id="admin" value="admin" disabled
                      class="sendsave senduser"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_user3"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_user3"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_but">
                <button type="submit" class="bigButton" value="确定"><fmt:message code="global.lang.ok" /></button>
                <button type="submit" class="bigButton" value="返回"><fmt:message code="notice.th.return" /></button>

            </div>
        </div>
        <div class="item">

            <div class="power_des">
                <span class="power_ex"><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file4" /></span>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_dept4" dept_id="admin" value="admin" disabled
                      class="sendsave senddep"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_dept4"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_dept4"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_role4" priv_id="admin" value="admin" disabled
                      class="sendsave sendrole"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_role4"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_role4"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_user4" user_id="admin" value="admin" disabled
                      class="sendsave senduser"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_user4"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_user4"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_but">
                <button type="submit" class="bigButton" value="确定"><fmt:message code="global.lang.ok" /></button>
                <button type="submit" class="bigButton" value="返回"><fmt:message code="notice.th.return" /></button>

            </div>
        </div>
        <div class="item">
            <div class="power_des">
                <span class="power_ex"><fmt:message code="netdisk.th.BatchSettings" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.WorksOn" /></span>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r title_no"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_dept5" dept_id="admin" value="admin" disabled
                      class="sendsave senddep saveno"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_dept5"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_dept5"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r title_no"><fmt:message code="netdisk.th.Scope(role)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_role5" priv_id="admin" value="admin" disabled
                      class="sendsave sendrole saveno"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_role5"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_role5"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body clearfix">
                <div class="title_label">
                    <span class="title_r title_no"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                </div>
                <div class="power_text">
            <textarea name="txt" id="send_user5" user_id="admin" value="admin" disabled
                      class="sendsave senduser saveno"></textarea>
                    <a style="margin-left: 10px;cursor: pointer" id="add_user5"><fmt:message code="global.lang.add" /></a>
                    <a style="margin-left: 10px;cursor: pointer" id="del_user5"><fmt:message code="global.lang.empty" /></a>
                </div>
            </div>
            <div class="power_body">
                <div class="title_label">
                    <span class="title_r title_no title_no_t"><fmt:message code="netdisk.th.OptionSetting" /></span>
                </div>
                <div class="check_con">
                    <input type="checkbox" id="access"><span class="check_p"><fmt:message code="netdisk.th.AccessAuthority" /></span>
                    <input type="checkbox" id="download"><span class="check_p"><fmt:message code="netdisk.th.DownloadPermissions" /></span>
                    <input type="checkbox" id="mange"><span class="check_p"><fmt:message code="workflow.th.privilege" /></span>
                    <input type="checkbox" id="stamp"><span class="check_p"><fmt:message code="netdisk.th.Download-print" /></span>
                </div>
            </div>
            <div class="power_body">
                <div class="title_label">
                    <span class="title_r title_no title_no_t" style="margin-right: 30px"><fmt:message code="notice.th.operation" /></span>
                </div>
                <div class="check_con">
                    <input type="radio" name="radio_c" checked><span class="add_mar"><fmt:message code="netdisk.th.addpermission" /></span>
                    <input type="radio" name="radio_c"><span><fmt:message code="netdisk.th.RemovePermissions" /></span>
                </div>
            </div>
            <div class="power_but">
                <button type="submit" class="bigButton" value="确定" id="batch_btn"><fmt:message code="global.lang.ok" /></button>
                <button type="submit" class="bigButton" value="返回"><fmt:message code="notice.th.return" /></button>

            </div>

        </div>
    </div>

</div>


</body>

<script src="../../js/xoajq/xoajq1.js"></script>
<script src="../../js/base/base.js"></script>
<script type="text/javascript">
    <%--$(function () {--%>
    <%--$('.item_1').show();--%>
    <%--/*人员部门角色控件*/--%>
    <%--function controlData() {--%>
    <%--$("#add_dept1").click(function () {--%>
    <%--dept_id = 'senddep';--%>
    <%--$.popWindow("../common/selectDept");--%>
    <%--});--%>
    <%--$('#del_dept').click(function () {--%>
    <%--$('#senddep').val(null);--%>
    <%--});--%>

    <%--$("#add_role1").click(function () {--%>
    <%--priv_id = 'sendrole';--%>
    <%--$.popWindow("../common/selectPriv");--%>
    <%--});--%>
    <%--$('#del_rloe_1').click(function () {--%>
    <%--$('#sendrole').val(null);--%>
    <%--});--%>

    <%--$("#adduesr").click(function () {--%>
    <%--user_id = 'senduser';--%>
    <%--$.popWindow("../common/selectUser");--%>
    <%--});--%>
    <%--$('#del_user').click(function () {--%>
    <%--$('#senduser').val(null);--%>
    <%--});--%>

    <%--$("#add_dept2").click(function () {--%>
    <%--dept_id = 'send_dept2';--%>
    <%--$.popWindow("../common/selectDept");--%>
    <%--});--%>
    <%--$('#del_dept2').click(function () {--%>
    <%--$('#send_dept2').val(null);--%>
    <%--});--%>

    <%--$("#add_role2").click(function () {--%>
    <%--priv_id = 'send_role2';--%>
    <%--$.popWindow("../common/selectPriv");--%>
    <%--});--%>
    <%--$('#del_role2').click(function () {--%>
    <%--$('#send_role2').val(null);--%>
    <%--});--%>

    <%--$("#add_user2").click(function () {--%>
    <%--user_id = 'send_uesr2';--%>
    <%--$.popWindow("../common/selectUser");--%>
    <%--});--%>
    <%--$('#del_user2').click(function () {--%>
    <%--$('#send_uesr2').val(null);--%>
    <%--});--%>

    <%--$("#add_dept3").click(function () {--%>
    <%--dept_id = 'send_dept3';--%>
    <%--$.popWindow("../common/selectDept");--%>
    <%--});--%>
    <%--$('#del_dept3').click(function () {--%>
    <%--$('#send_dept3').val(null);--%>
    <%--});--%>

    <%--$("#add_role3").click(function () {--%>
    <%--priv_id = 'send_role3';--%>
    <%--$.popWindow("../common/selectPriv");--%>
    <%--});--%>
    <%--$('#del_role3').click(function () {--%>
    <%--$('#send_role3').val(null);--%>
    <%--});--%>

    <%--$("#add_user3").click(function () {--%>
    <%--user_id = 'send_user3';--%>
    <%--$.popWindow("../common/selectUser");--%>
    <%--});--%>
    <%--$('#del_user3').click(function () {--%>
    <%--$('#send_user3').val(null);--%>
    <%--});--%>

    <%--$("#add_dept4").click(function () {--%>
    <%--dept_id = 'send_dept4';--%>
    <%--$.popWindow("../common/selectDept");--%>
    <%--});--%>
    <%--$('#del_dept4').click(function () {--%>
    <%--$('#send_dept4').val(null);--%>
    <%--});--%>

    <%--$("#add_role4").click(function () {--%>
    <%--priv_id = 'send_role4';--%>
    <%--$.popWindow("../common/selectPriv");--%>
    <%--});--%>
    <%--$('#del_role4').click(function () {--%>
    <%--$('#send_role4').val(null);--%>
    <%--});--%>

    <%--$("#add_user4").click(function () {--%>
    <%--user_id = 'send_user4';--%>
    <%--$.popWindow("../common/selectUser");--%>
    <%--});--%>
    <%--$('#del_user4').click(function () {--%>
    <%--$('#send_user4').val(null);--%>
    <%--});--%>

    <%--$("#add_dept5").click(function () {--%>
    <%--dept_id = 'send_dept5';--%>
    <%--$.popWindow("../common/selectDept");--%>
    <%--});--%>
    <%--$('#del_dept5').click(function () {--%>
    <%--$('#send_dept5').val(null);--%>
    <%--});--%>

    <%--$("#add_role5").click(function () {--%>
    <%--priv_id = 'send_role5';--%>
    <%--$.popWindow("../common/selectPriv");--%>
    <%--});--%>
    <%--$('#del_role5').click(function () {--%>
    <%--$('#send_role5').val(null);--%>
    <%--});--%>

    <%--$("#add_user5").click(function () {--%>
    <%--user_id = 'send_user5';--%>
    <%--$.popWindow("../common/selectUser");--%>
    <%--});--%>
    <%--$('#del_user5').click(function () {--%>
    <%--$('#send_user5').val(null);--%>
    <%--});--%>
    <%--}--%>

    <%--controlData();--%>

    <%--$('.power_list').click(function () {--%>
    <%--$('.power_list').removeClass('power_bg')--%>
    <%--$(this).addClass('power_bg');--%>
    <%--});--%>
    <%--/* 权限设置页面切换*/--%>
    <%--var $list = $('.power_t .power_list')--%>
    <%--$list.each(function (index, item) {--%>
    <%--$(item).click(function () {--%>
    <%--$('.con_item .item').eq(index).show().siblings().hide();--%>
    <%--})--%>

    <%--});--%>

    <%--/*返回*/--%>

    <%--$('.btn_back').click(function () {--%>
    <%--$('.con').hide();--%>
    <%--});--%>

    <%--/* 权限设置*/--%>

    <%--$('#batch_btn').click(function () {--%>
    <%--var deptid = $('#senddep').attr('deptid');--%>
    <%--var privid = $('#sendrole').attr('privid');--%>
    <%--var user_id = $('#senduser').attr('user_id');--%>

    <%--var deptid_2 = $('#send_dept2').attr('deptid');--%>
    <%--var privid_2 = $('#send_role2').attr('privid');--%>
    <%--var user_id_2 = $('#send_uesr2').attr('user_id');--%>

    <%--var deptid_3 = $('#send_dept3').attr('deptid');--%>
    <%--var privid_3 = $('#send_role3').attr('privid');--%>
    <%--var user_id_3 = $('#send_user3').attr('user_id');--%>

    <%--var deptid_4 = $('#send_dept4').attr('deptid');--%>
    <%--var privid_4 = $('#send_role4').attr('privid');--%>
    <%--var user_id_4 = $('#send_user4').attr('user_id');--%>

    <%--var data = {--%>
    <%--userId: {--%>
    <%--dept: deptid,--%>
    <%--role: privid,--%>
    <%--user: user_id--%>
    <%--},--%>
    <%--manageUser: {--%>
    <%--dept: deptid_2,--%>
    <%--role: privid_2,--%>
    <%--user: user_id_2--%>
    <%--},--%>
    <%--newUser: {--%>
    <%--dept: deptid_3,--%>
    <%--role: privid_3,--%>
    <%--user: user_id_3--%>
    <%--},--%>
    <%--downUser: {--%>
    <%--dept: deptid_4,--%>
    <%--role: privid_4,--%>
    <%--user: user_id_4--%>
    <%--},--%>
    <%--diskId:1--%>

    <%--};--%>
    <%--var datas=JSON.stringify(data);--%>
    <%--var auth={--%>
    <%--auth:datas--%>
    <%--}--%>
    <%--$.ajax({--%>
    <%--type: 'POST',--%>
    <%--url: '/netdiskSettings/editNetdiskJurisdictionSettings',--%>
    <%--dataType: 'json',--%>
    <%--data: auth,--%>
    <%--success: function (data) {--%>
    <%--console.log(data)--%>
    <%--}--%>

    <%--})--%>
    <%--})--%>

    <%--})--%>

</script>
</html>
