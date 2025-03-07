<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2017/6/13
  Time: 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title><fmt:message code="netdisk.th.Managing" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../../css/base.css">
    <link rel="stylesheet" href="../../css/netdesk/netdesksetting.css?2021">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui-v2.6.8/layui/css/layui.css">
<%--    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>--%>
    <script src="/lib/layui/layui-v2.6.8/layui/layui.js"></script>


<%--    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>--%>
<%--    <script type="text/javascript"  src="/js/common/language.js"></script>--%>
<%--    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>--%>
<%--    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>--%>
<%--    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>--%>
<%--    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>--%>
<%--    <script src="/js/base/base.js"></script>--%>
<%--    --%>



    <style>
        .layui-layer-title{
            color:#fff!important;
        }
        .power_t{
            height: 45px;
        }
        .power_list{
            height: 30px;
            line-height:30px;
            width: auto;
            padding: 0 20px;
            margin-top: 7px;
        }
        .share_t{
            height: 70px;
            line-height: 70px;
            /*margin-top:30px;*/
            margin-left: 30px;
            margin-bottom: 0;
        }
        .power_des {
            position: relative;
            height: 70px;
            line-height: 24px;
        }
        .newtory {
            float: right;
            border: 1px solid #e5e5e5;
            padding: 3px 5px;
            border-radius: 4px;
            background: #fafafa;
            font-size: 14px;
            color: #333;
        }
        .power_t>li {
            height: 100%;
            line-height: 45px;
        }
        .access{
            margin-right: 30px;
        }
        .power_stage{
            position: absolute;
            top: 25px;
        }
        .tr_td th:first-of-type{
            width: 200px;
        }
        .layui-layer{

        }
        .netdisk .save_a{
            cursor: pointer;
            vertical-align: top;
        }
        .tbox {
            margin: 0 auto; /*水平居中*/
            position: relative;
            margin-top:20px;
        }
        .layui-form-item {
            margin-bottom: 5px;
        }
        .tbox .layui-form-item .layui-form-label{
            width: 120px;
            text-align: right;
        }
        .tbox .layui-form-item .layui-input-block{
            margin-left: 170px;
            width: 60%;
        }
        .yiji li{
            cursor: pointer;
        }

        .right{
            margin-bottom: 10px;
        }
        .red{
            color: red;
        }
    </style>



    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="netdiskPar">
    <caption class="clearfix">
        <span class="share_t" style="    height: 70px;line-height: 70px;">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/wangluo.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.Managing" />
        </span>
        <span class="newtory" id="newtory" style="cursor: pointer;margin-top: 22px;margin-right: 30px;"><img style="margin-right: 4px;margin-left: -22px;margin-bottom: 2px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="netdisk.th.NewSharedDirectory" /></span>
    </caption>
    <input type="hidden" id="diskId">
    <table class="netdisk" cellspacing="0" id="netdisk">
    </table>
</div>

<div class="con">
    <div class="list_p">
        <ul class="power_t clearfix">
            <li>
                <a href="javascript:void(0)" class="power_list power_bg"><fmt:message code="netdisk.th.AccessAuthority" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li><a href="javascript:void(0)" class="power_list"><fmt:message code="workflow.th.privilege" /></a>
                <img src="../../img/twoth.png" alt=""></li>
            <li>
                <a href="javascript:void(0)" class="power_list"><fmt:message code="netdisk.th.NewPermissions" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li>
                <a href="javascript:void(0)" class="power_list"><fmt:message code="main.th.EditPermissions" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li>
                <a href="javascript:void(0)" class="power_list"><fmt:message code="netdisk.th.Download-print" /></a>
                <img src="../../img/twoth.png" alt="">
            </li>
            <li><a href="javascript:void(0)" class="power_list"><fmt:message code="netdisk.th.BatchSettings" /></a></li>
        </ul>
    </div>

    <div class="con_item">

        <%--/*****************************************************************item_1****************************************************************--%>
        <div class="item item_1">
            <div class="power_des">
                <span class="share_t"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/fangwenquanxian.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file1" /></span>
            </div>
            <div class="divtable">
                <table class="tr_td">
                    <thead>
                    <tr>
                        <th class="th"><fmt:message code="workflow.th.name" /></th>
                        <th class="th"><fmt:message code="notice.th.content" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                        </td>
                        <td>
                            <textarea name="txt" id="senddep" dept_id="admin" value="admin" class="sendsave senddep" disabled></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_dept1"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_dept1"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                        </td>
                        <td>
                            <textarea name="txt" id="sendrole" priv_id="admin" value="admin" class="sendsave sendrole" disabled></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_role1"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_rloe_1"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                        </td>
                        <td>
                            <textarea name="txt" id="senduser"  class="sendsave senduser" disabled></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="adduesr"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_user"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="bigButton access import" data-num="1" value="确定" id="btn_sure"><fmt:message code="global.lang.ok" /></button>
                            <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%--/*****************************************************************item_2****************************************************************--%>
        <div class="item">
            <div class="power_des">
                <span class="share_t"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/guanliquanxian.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file2" /></span>
            </div>
            <div class="divtable">
                <table class="tr_td">
                    <thead>
                    <tr>
                        <th class="th"><fmt:message code="workflow.th.name" /></th>
                        <th class="th"><fmt:message code="notice.th.content" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td> <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span></td>
                        <td>
                                 <textarea name="txt" id="send_dept2" dept_id="admin" value="admin" disabled
                                           class="sendsave senddep"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_dept2"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_dept2"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                        </td>
                        <td>
                                 <textarea name="txt" id="send_role2" priv_id="admin" value="admin" disabled
                                           class="sendsave sendrole"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_role2"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_role2"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                        </td>
                        <td>
                                 <textarea name="txt" id="send_uesr2" user_id="admin" value="admin" disabled
                                           class="sendsave senduser"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_user2"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_user2"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="bigButton access import" data-num="2" value="确定" ><fmt:message code="global.lang.ok" /></button>
                            <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%--/*****************************************************************item_3****************************************************************--%>
        <div class="item">
            <div class="power_des">
                <span class="share_t"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinjianquanxian.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file3" /></span>
            </div>
            <div class="divtable">
                <table class="tr_td">
                    <thead>
                    <tr>
                        <th class="th"><fmt:message code="workflow.th.name" /></th>
                        <th class="th"><fmt:message code="notice.th.content" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                        </td>
                        <td>
                                    <textarea name="txt" id="send_dept3" dept_id="admin" value="admin" disabled
                                              class="sendsave senddep"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_dept3"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_dept3"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                        </td>
                        <td>
                                 <textarea name="txt" id="send_role3" priv_id="" value="" disabled
                                           class="sendsave sendrole"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_role3"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_role3"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                        </td>
                        <td>
                                    <textarea name="txt" id="send_user3" user_id="" value="" disabled
                                              class="sendsave senduser"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_user3"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_user3"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="bigButton access import" data-num="3" value="确定" ><fmt:message code="global.lang.ok" /></button>
                            <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
            <%--/*****************************************************************item_4****************************************************************--%>
            <div class="item">
                <div class="power_des">
                    <span class="share_t"><img src="/img/bianjixian.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                    <span class="power_stage"><fmt:message code="netdisk.th.specifyEditingPermissions" /></span>
                </div>

                <div class="divtable">
                    <table class="tr_td">
                        <thead>
                        <tr>
                            <th class="th"><fmt:message code="workflow.th.name" /></th>
                            <th class="th"><fmt:message code="notice.th.content" /></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                            </td>
                            <td>
                                  <textarea name="txt" id="send_dept6" dept_id="admin" value="admin" disabled
                                            class="sendsave senddep"></textarea>
                                <a style="margin-left: 10px;cursor: pointer" id="add_dept6"><fmt:message code="global.lang.add" /></a>
                                <a style="margin-left: 10px;cursor: pointer" id="del_dept6"><fmt:message code="global.lang.empty" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                            </td>
                            <td>
                                 <textarea name="txt" id="send_role6" priv_id="admin" value="admin" disabled
                                           class="sendsave sendrole"></textarea>
                                <a style="margin-left: 10px;cursor: pointer" id="add_role6"><fmt:message code="global.lang.add" /></a>
                                <a style="margin-left: 10px;cursor: pointer" id="del_role6"><fmt:message code="global.lang.empty" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                            </td>
                            <td>
                                   <textarea name="txt" id="send_user6" user_id="admin" value="admin" disabled
                                             class="sendsave senduser"></textarea>
                                <a style="margin-left: 10px;cursor: pointer" id="add_user6"><fmt:message code="global.lang.add" /></a>
                                <a style="margin-left: 10px;cursor: pointer" id="del_user6"><fmt:message code="global.lang.empty" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button type="submit" class="bigButton access import" data-num="6" value="确定" ><fmt:message code="global.lang.ok" /></button>
                                <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        <%--/*****************************************************************item_5****************************************************************--%>
        <div class="item">
            <div class="power_des">
                <span class="share_t"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/wangluo.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.SpecifiedPermissions" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.file4" /></span>
            </div>

            <div class="divtable">
                <table class="tr_td">
                    <thead>
                    <tr>
                        <th class="th"><fmt:message code="workflow.th.name" /></th>
                        <th class="th"><fmt:message code="notice.th.content" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                        </td>
                        <td>
                                  <textarea name="txt" id="send_dept4" dept_id="admin" value="admin" disabled
                                            class="sendsave senddep"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_dept4"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_dept4"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(role)" /></span>
                        </td>
                        <td>
                                 <textarea name="txt" id="send_role4" priv_id="admin" value="admin" disabled
                                           class="sendsave sendrole"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_role4"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_role4"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                        </td>
                        <td>
                                   <textarea name="txt" id="send_user4" user_id="admin" value="admin" disabled
                                             class="sendsave senduser"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_user4"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_user4"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="bigButton access import" data-num="4" value="确定" ><fmt:message code="global.lang.ok" /></button>
                            <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%--/*****************************************************************item_6****************************************************************--%>
        <div class="item">
            <div class="power_des">

                <span class="share_t"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/piliangshezhis.png" style="margin-right: 15px;" alt=""><fmt:message code="netdisk.th.BatchSettings" /></span>
                <span class="power_stage"><fmt:message code="netdisk.th.WorksOn" /></span>
            </div>

            <div class="divtable">
                <table class="tr_td">
                    <thead>
                    <tr>
                        <th class="th"><fmt:message code="workflow.th.name" /></th>
                        <th class="th"><fmt:message code="notice.th.content" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <span class="title_r title_no"><fmt:message code="netdisk.th.ScopeAuthorization" /></span>
                        </td>
                        <td>
                                 <textarea name="txt" id="send_dept5"  value="admin" disabled
                                           class="sendsave senddep saveno"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_dept5"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_dept5"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r title_no"><fmt:message code="netdisk.th.Scope(role)" /></span>
                        </td>
                        <td>
                                  <textarea name="txt" id="send_role5"  value="admin" disabled
                                            class="sendsave sendrole saveno"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_role5"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_role5"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r title_no"><fmt:message code="netdisk.th.Scope(personnel)" /></span>
                        </td>
                        <td>
                                    <textarea name="txt" id="send_user5"  value="admin" disabled
                                              class="sendsave senduser saveno"></textarea>
                            <a style="margin-left: 10px;cursor: pointer" id="add_user5"><fmt:message code="global.lang.add" /></a>
                            <a style="margin-left: 10px;cursor: pointer" id="del_user5"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td>  <span class="title_r title_no title_no_t"><fmt:message code="netdisk.th.OptionSetting" /></span></td>
                        <td>
                            <input type="checkbox" id="access"><span class="check_p"><fmt:message code="netdisk.th.AccessAuthority" /></span>
                            <input type="checkbox" id="download"><span class="check_p"><fmt:message code="workflow.th.privilege" /></span>
                            <input type="checkbox" id="mange"><span class="check_p"><fmt:message code="netdisk.th.NewPermissions" /></span>
                            <input type="checkbox" id="stamp"><span class="check_p"><fmt:message code="netdisk.th.Download-print" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="title_r title_no title_no_t"><fmt:message code="notice.th.operation" /></span>
                        </td>
                        <td>
                            <input type="radio" name="radio_c" checked><span class="add_mar"><fmt:message code="netdisk.th.addpermission" /></span>
                            <%--<input type="radio" name="radio_c"><span><fmt:message code="netdisk.th.RemovePermissions" /></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="bigButton  import"value="确定" id="batch_btn" style="margin-right: 30px"><fmt:message code="global.lang.ok" /></button>
                            <button type="submit" class="bigButton btn_back import" value="返回"><fmt:message code="notice.th.return" /></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>


        </div>
    </div>

</div>

</body>
<script src="../../js/xoajq/xoajq3.js"></script>
<script src="../../lib/layer/layer.js?20201106"></script>
<script src="../../js/base/base.js"></script>
<script type="text/javascript">
    // var form;
    // layui.use(['form','element','laydate', 'xmSelect','layedit','eleTree','upload'], function () {
    //      form = layui.form
    // });

    var isOrgScope = false;// 是否开启分支机构
    var branchDeptId = "";// 当前登陆人 所在分支机构ID
    var branchDeptName = "";// 当前登陆人 所在分支机构名称

    function netdiskQuery() {
        $.ajax({
            type: 'GET',
            url: '/netdiskSettings/selectNetdiskSettings',
            dataType: 'json',
            success: function (data) {
                if (data.flag) {
                    var data = data.object;
                    var html = '<thead><tr><th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="netdisk.th.DirectoryName" /></th><th><fmt:message code="netdisk.th.Directorypath" /></th>' +
                        '<th><fmt:message code="netdisk.th.LimitedCapacity" /></th>' +
                        '<th><fmt:message code="netdisk.th.undefand" /></th><th style="width: 240px;"><fmt:message code="notice.th.operation" /></th></tr>' +
                        '</thead>';
                    var spaceLimit='';
                    var orderBy;
                    for (var i = 0; i < data.length; i++) {
                        // console.log(data[i])
                        /*容量*/
                        if (data[i].spaceLimit == 0) {
                            spaceLimit = "<fmt:message code="main.th.xian" />"
                        }else {
                            spaceLimit=data[i].spaceLimit
                        }
                        /*默认排序名称*/
                        if (data[i].orderBy == '0') {
                            orderBy = '<fmt:message code="main.th.name" />'
                        } else if (data[i].orderBy == '1') {
                            orderBy = '<fmt:message code="notice.th.type" />'
                        } else if (data[i].orderBy == '2') {
                            orderBy = '<fmt:message code="netdisk.th.Size" />'
                        } else if (data[i].orderBy == '3') {
                            orderBy = '<fmt:message code="email.th.time" />'
                        }
                        /*升序降序*/
                        var ascDesc;
                        if (data[i].ascDesc == 0) {
                            ascDesc = '<fmt:message code="netdisk.th.asc" />'
                        } else {
                            ascDesc = '<fmt:message code="netdisk.th.desc" />'
                        }
                        var datas = JSON.stringify(data[i]).replace(/"/g, "'");
                        html += '<tbody>' +
                            '<tr><td>' + data[i].diskNo + '</td><td class="manage">' + data[i].diskName + '</td><td class="management">' + data[i].diskPath + '</td>' +
                            '<td class="sector">' + spaceLimit + '</td><td class="">' + orderBy + "(" + ascDesc + ")" + '</td>' +
                            '<td class=""><span class="save_a" id="editor"><input id="datahide"  type="hidden" value="' + datas + '"><fmt:message code="global.lang.edit" /></span>&nbsp; ' +
                            '<span class="save_a" id="updete_d"><input id="datahide"  type="hidden" value="' + datas + '"><fmt:message code="global.lang.delete" /></span>&nbsp;<br/>' +
                            '<a href="javascript:void(0)" class="save_a powerset" id="powerset" ><input id="datahide"  type="hidden" value="' + datas + '"><fmt:message code="netdisk.th.PermissionSetting" /></a>&nbsp;' +
                           '<span class="save_a" id="publishUaeApps"><input id="publishUaeApps"  type="hidden" value="' + datas + '"><fmt:message code="file.th.releaseMenu" /></span>'
                            //                                '<a href="javascript:void(0)" class="save_a Menusave" >菜单定义指南</a>' +
                            '</td></tr>' +
                            '</tbody>';
                    }
                }
                $('#netdisk').html(html);
            }
        });
    }




    function clearData() {
        $('textarea').each(function () {
            $(this).val('');
            $(this).attr('deptid','')
            $(this).attr('user_id','')
            $(this).attr('userpriv','')
        })
        $('.divtable').find('input[type="checkbox"]').each(function () {
            $(this).prop('checked',false)
        })
    }

    function myrefresh() {
        window.location.reload();
    }
    //获取权限信息
    function getdiskinfor(diskId) {
        $.ajax({
            type: 'GET',
            url: '/netdiskSettings/getNetiskBySortId',
            data:{
                diskId:diskId
            },
            dataType: 'json',
            success: function (data) {
                var userId = data.data.userId;
                $('#senddep').attr('deptid',userId.dept).val(userId.data.deptStr);
                $('#sendrole').attr('userpriv',userId.role).val(userId.data.roleStr);
                $('#senduser').attr('user_id',userId.user).val(userId.data.userStr);

                var manageUser = data.data.manageUser;
                $('#send_dept2').attr('deptid',manageUser.dept).val(manageUser.data.deptStr);
                $('#send_role2').attr('userpriv',manageUser.role).val(manageUser.data.roleStr);
                $('#send_uesr2').attr('user_id',manageUser.user).val(manageUser.data.userStr);

                var newUser = data.data.newUser;
                $('#send_dept3').attr('deptid',newUser.dept).val(newUser.data.deptStr);
                $('#send_role3').attr('userpriv',newUser.role).val(newUser.data.roleStr);
                $('#send_user3').attr('user_id',newUser.user).val(newUser.data.userStr);

                var downUser = data.data.downUser;
                $('#send_dept4').attr('deptid',downUser.dept).val(downUser.data.deptStr);
                $('#send_role4').attr('userpriv',downUser.role).val(downUser.data.roleStr);
                $('#send_user4').attr('user_id',downUser.user).val(downUser.data.userStr);
                var editUser = data.data.editUser;
                $('#send_dept6').attr('deptid',downUser.dept).val(editUser.data.deptStr);
                $('#send_role6').attr('userpriv',downUser.role).val(editUser.data.roleStr);
                $('#send_user6').attr('user_id',downUser.user).val(editUser.data.userStr);
            }
        });
    }



    $(function () {
        /*数据查询*/
        netdiskQuery();
        /*人员部门角色控件*/
        $("#add_dept1").on("click",function () {
            dept_id = 'senddep';
            $.popWindow("../common/selectDept?allDept=1");
        });
        /*$('#del_dept').click(function () {
            $('#senddep').val(null);
        });*/
        $('#del_dept1').on("click",function () {
            $('#senddep').val(null);
            $('#senddep').attr('deptid','');
            $('#senddep').attr('deptname','');
        });

        $("#add_role1").on("click",function () {
            priv_id = 'sendrole';
            $.popWindow("../common/selectPriv?1");
        });

        $('#del_rloe_1').on("click",function () {
            $('#sendrole').val(null);
            $('#sendrole').attr('userpriv','');
            $('#sendrole').attr('privid','');
        });

        $("#adduesr").on("click",function () {
            user_id = 'senduser';
            $.ajax({
                url:'/imfriends/getIsFriends',
                type:'get',
                dataType:'json',
                data:{},
                success:function(obj){
                    if(obj.object == 1){
                        $.popWindow("../common/selectUserIMAddGroup");
                    }else{
                        $.popWindow("../common/selectUser");
                    }
                },
                error:function(res){
                    $.popWindow("../common/selectUser");
                }
            })
        });
        $('#del_user').on("click",function () {
            $('#senduser').val(null);
            $('#senduser').attr('user_id','');
            $('#senduser').attr('username','');
            $('#senduser').attr('dataid','');
            $('#senduser').attr('userprivname','');
        });

        $("#add_dept2").on("click",function () {
            dept_id = 'send_dept2';
            $.popWindow("../common/selectDept?allDept=1");
        });
        $('#del_dept2').on("click",function () {
            $('#send_dept2').val(null);
            $('#send_dept2').attr('deptid','');
            $('#send_dept2').attr('deptname','');
        });

        $("#add_role2").on("click",function () {
            priv_id = 'send_role2';
            $.popWindow("../common/selectPriv?1");
        });
        $('#del_role2').on("click",function () {
            $('#send_role2').val(null);
            $('#send_role2').attr('userpriv','');
            $('#send_role2').attr('privid','');
        });

        $("#add_user2").on("click",function () {
            user_id = 'send_uesr2';
            $.popWindow("../common/selectUser");
        });
        $('#del_user2').on("click",function () {
            $('#send_uesr2').val(null);
            $('#send_uesr2').attr('user_id','');
            $('#send_uesr2').attr('username','');
            $('#send_uesr2').attr('dataid','');
            $('#send_uesr2').attr('userprivname','');
        });

        $("#add_dept3").on("click",function () {
            dept_id = 'send_dept3';
            $.popWindow("../common/selectDept?allDept=1");
        });
        $('#del_dept3').on("click",function () {
            $('#send_dept3').val(null);
            $('#send_dept3').attr('deptid','');
            $('#send_dept3').attr('deptname','');
        });

        $("#add_role3").on("click",function () {
            priv_id = 'send_role3';
            $.popWindow("../common/selectPriv?1");
        });
        $('#del_role3').on("click",function () {
            $('#send_role3').val(null);
            $('#send_role3').attr('userpriv','');
            $('#send_role3').attr('privid','');
        });

        $("#add_user3").on("click",function () {
            user_id = 'send_user3';
            $.popWindow("../common/selectUser");
        });
        $('#del_user3').on("click",function () {
            $('#send_user3').val(null);
            $('#send_user3').attr('user_id','');
            $('#send_uesr3').attr('username','');
            $('#send_uesr3').attr('dataid','');
            $('#send_uesr3').attr('userprivname','');
        });

        $("#add_dept4").on("click",function () {
            dept_id = 'send_dept4';
            $.popWindow("../common/selectDept?allDept=1");
        });
        $('#del_dept4').on("click",function () {
            $('#send_dept4').val(null);
            $('#send_dept4').attr('deptid','');
            $('#send_dept4').attr('deptname','');
        });

        $("#add_role4").on("click",function () {
            priv_id = 'send_role4';
            $.popWindow("../common/selectPriv?1");
        });
        $('#del_role4').on("click",function () {
            $('#send_role4').val(null);
            $('#send_role4').attr('userpriv','');
            $('#send_role4').attr('privid','');
        });

        $("#add_user4").on("click",function () {
            user_id = 'send_user4';
            $.popWindow("../common/selectUser");
        });
        $('#del_user4').on("click",function () {
            $('#send_user4').val(null);
            $('#send_user4').attr('user_id','');
            $('#send_user4').attr('username','');
            $('#send_user4').attr('dataid','');
            $('#send_user4').attr('userprivname','');
        });

        $("#add_dept5").on("click",function () {
            dept_id = 'send_dept5';
            $.popWindow("../common/selectDept?allDept=1");
        });
        $('#del_dept5').on("click",function () {
            $('#send_dept5').val(null);
            $('#send_dept5').attr('deptid','');
            $('#send_dept5').attr('deptname','');
        });

        $("#add_role5").on("click",function () {
            priv_id = 'send_role5';
            $.popWindow("../common/selectPriv?1");
        });
        $('#del_role5').on("click",function () {
            $('#send_role5').val(null);
            $('#send_role5').attr('userpriv','');
            $('#send_role5').attr('privid','');
        });

        $("#add_user5").on("click",function () {
            user_id = 'send_user5';
            $.popWindow("../common/selectUser");
        });
        $('#del_user5').on("click",function () {
            $('#send_user5').val(null);
            $('#send_uesr5').attr('user_id','');
            $('#send_user5').attr('username','');
            $('#send_user5').attr('dataid','');
            $('#send_user5').attr('userprivname','');
        });
        $("#add_dept6").on("click",function () {
            dept_id = 'send_dept6';
            $.popWindow("../common/selectDept?allDept=1");
        });
        $('#del_dept6').on("click",function () {
            $('#send_dept6').val(null);
            $('#send_dept6').attr('deptid','');
            $('#send_dept6').attr('deptname','');
        });

        $("#add_role6").on("click",function () {
            priv_id = 'send_role6';
            $.popWindow("../common/selectPriv?1");
        });
        $('#del_role6').on("click",function () {
            $('#send_role6').val(null);
            $('#send_role6').attr('userpriv','');
            $('#send_role6').attr('privid','');
        });

        $("#add_user6").on("click",function () {
            user_id = 'send_user6';
            $.popWindow("../common/selectUser");
        });
        $('#del_user6').on("click",function () {
            $('#send_user6').val(null);
            $('#send_user6').attr('user_id','');
            $('#send_user6').attr('username','');
            $('#send_user6').attr('dataid','');
            $('#send_user6').attr('userprivname','');
        });
        $('.power_list').on("click",function () {
            $('.power_list').removeClass('power_bg')
            $(this).addClass('power_bg');
        });

        $(document).delegate('.Menusave','click',function () {
            var titlestr='<fmt:message code="netdisk.th.NewMenu" />';
            var contstr='<div class="newTable">' +
                '<p class="tableTop"><fmt:message code="main.network" /></p>' +
                '<p><label><input type="radio"><fmt:message code="netdisk.th.DirectoryName" /> </label>&nbsp;&nbsp;&nbsp;&nbsp; <fmt:message code="netdisk.th.(level two or three menu)" /></p>' +
                '</div>'
            layer.open({
                title:titlestr,
                content:contstr,
                closeBtn:0,
                area:['300px','230px'],
                btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                yes:function (index) {

                },
                success:function () {

                }
            })
        })
        /* 权限设置页面切换*/
        $('.power_t .power_list').on("click",function () {
            $('.con_item .item').hide()

            $('.con_item .item').eq($(this).parent().index()).show()
        })


        /*权限设置页面*/
        /*批量设置*/
        var data = {};
        var userId = {
            dept: "",
            role: "",
            user: ""
        };
        var manageUser = {
            dept: "",
            role: "",
            user: ""
        };
        var newUser = {
            dept: "",
            role: "",
            user: ""
        };
        var downUser={
            dept: "",
            role: "",
            user: ""
        };
        function settingData() {
            var comdata={
                dept:$('#send_dept5').attr('deptid'),
                role:$('#send_role5').attr('userpriv'),
                user:$('#send_user5').attr('user_id')
            };
            if($('#access').is(':checked') == true){
                data["userId"]=comdata;
            }
            if($('#download').is(':checked') == true){
                data["manageUser"]=comdata;
            }
            if($('#mange').is(':checked') == true){
                data["newUser"]=comdata;
            }
            if($('#stamp').is(':checked') == true){
                data["downUser"]=comdata;
            }
        }

        var diskId;
        $('.netdiskPar').delegate('.powerset', 'click', function () {
            var date_hide = $(this).find("input").val().replace(/'/g, '"');
            var dataMsg = JSON.parse(date_hide);
            diskId = dataMsg.diskId;
            getdiskinfor(diskId);
            $('.con').show();
            $('.con_item .item').hide()
            $('.item_1').show();
            $('.netdiskPar').hide();
            $('.power_t').find('.power_list').each(function () {
                $(this).removeClass('power_bg')
            })
            $($('.power_t').find('.power_list')[0]).addClass('power_bg')
        });

        $('.access').on("click",function () {
            if($(this).attr('data-num')==1) {
                var objTwos = {
                    userId: {
                        dept: $('#senddep').attr('deptid'),
                        user: $('#senduser').attr('user_id'),
                        role: $('#sendrole').attr('userpriv'),
                    },
                    diskId: diskId
                }
            }else if($(this).attr('data-num')==2){
                var objTwos = {
                    manageUser: {
                        dept: $('#send_dept2').attr('deptid'),
                        user: $('#send_uesr2').attr('user_id'),
                        role: $('#send_role2').attr('userpriv'),
                    },
                    diskId: diskId
                }
            }else if($(this).attr('data-num')==3){
                var objTwos = {
                    newUser: {
                        dept: $('#send_dept3').attr('deptid'),
                        user: $('#send_user3').attr('user_id'),
                        role: $('#send_role3').attr('userpriv'),
                    },
                    diskId: diskId
                }
            }else if($(this).attr('data-num')==4){
                var dept = $('#send_dept3').attr('deptid');
                if(dept==null||dept==undefined)dept=="";
                var objTwos = {
                    downUser: {
                        dept: $('#send_dept4').attr('deptid'),
                        user: $('#send_user4').attr('user_id'),
                        role: $('#send_role4').attr('userpriv'),
                    },
                    diskId: diskId
                }
            }else if($(this).attr('data-num')==6){
                var objTwos = {
                    editUser: {
                        dept: $('#send_dept6').attr('deptid'),
                        user: $('#send_user6').attr('user_id'),
                        role: $('#send_role6').attr('userpriv'),
                    },
                    diskId: diskId
                }
            }
            $.post('/netdiskSettings/editNetdiskJurisdictionSettings',{'auth':JSON.stringify(objTwos),myflag:1},function (json) {
                if(json.flag){
                    $.layerMsg({content:'<fmt:message code="diary.th.modify" />！',icon:1});
                }
                setTimeout('myrefresh()',1000);
            },'json')
        })


        /*返回*/
        $('.btn_back').on("click",function () {
            $('.con').hide();
            $('.netdiskPar').show();
            clearData()
        });
        /*权限设置确定提交接口*/
        $('#batch_btn').on("click",function () {
            settingData()
            data["diskId"]=diskId;
            var datas = JSON.stringify(data);
            var auth = {
                auth: datas,
                myflag:0
            }
            $.ajax({
                type: 'POST',
                url: '/netdiskSettings/editNetdiskJurisdictionSettings',
                dataType: 'json',
                data: auth,
                success: function (data) {
                    if (data.flag) {
                        layer.msg('<fmt:message code="netdisk.th.Success" />!', {icon: 6});
                        setTimeout('myrefresh()',1000);
                    }
                }

            })
        })

        /*新建共享目录*/
        $('.netdiskPar').delegate('#newtory', 'click', function () {
            layer.open({
                title: '<p style="height: 43px;width: 100%;font-size: 16px;padding-left: 10px;color: #fff"><fmt:message code="netdisk.th.NewSharedDirectory" /></p>',
                shade: 0.3,
                offset:['150px','35%'],
                content: '<div class="newpop">' +
                '<div class="list_group">' +
                '<label for="sortNum" class="toryList"><fmt:message code="file.th.Sort" /> :</label>' +
                '<input type="text" id="sortNum" class="save_w"></div>' +
                '<div class="list_group"><label for="catalog" class="toryList"><fmt:message code="netdisk.th.SharedDirectoryName" />:</label>' +
                '<input type="text" id="catalog" class="save_w"></div>' +
                '<div class="list_group"><label for="path" class="toryList"><fmt:message code="netdisk.th.SharedDirectoryPath" /> :</label>' +
                '<input type="text" id="path" class="save_w">' +
                '<p class="file_path"><fmt:message code="netdisk.th.TheFilePath" />/soft，<fmt:message code="netdisk.th.settingTheFullDiskPathIsNotSupported" /></p>' + '</div>' +
                '<div class="list_group"><label for="maxcap" class="toryList"> <fmt:message code="netdisk.th.Maximumcapacity" />:</label>' +
                '<input type="text" id="maxcap" class="save_w" value="0"><span> MB <fmt:message code="netdisk.th.(0 unrestricted)" /></span></div>' +
                '<div class="list_group">' +
                '<label for="defaultSort" class="toryList"><fmt:message code="netdisk.th.undefand" /> :</label>' +
                '<select name="defaultSort" id="defaultSort" class="defaultSort"><option value="0"><fmt:message code="workflow.th.name" /></option>' +
                '<option value="2"><fmt:message code="netdisk.th.Size" /></option><option value="1"><fmt:message code="notice.th.type" /></option><option value="3"><fmt:message code="netdisk.th.Lastmodifiedtime" /></option>' +
                '</select><select name="defaultSort" id="Ascend" class="Ascend">' + '<option value="0"><fmt:message code="netdisk.th.asc" /></option>' +
                '<option value="1"><fmt:message code="netdisk.th.desc" /></option></select></div>' + '</div>' +
                '<div class="list_group"><label for="branchDeptId" class="toryList"><fmt:message code="user.th.branchDept"/>:</label>' +
                '<select name="branchDeptId" id="branchDeptId" class="branchDeptId"></select></div>',
                area: ['600px','480px'],
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="notice.th.return" />'],
                // scrolling: 'no',
                success: function () {
                    // 如果当前登陆人是管理员，则不选就行
                    // 如果当前登陆人是分支机构人员，则只显示本分支机构（分支机构人员新建时，只能选本分支机构）
                    if (isOrgScope && branchDeptId !== "" && branchDeptName !== "") {
                        //下拉框加选项
                        $('select[name="branchDeptId"]').html('<option value="' + branchDeptId + '">' + branchDeptName + '</option>');
                    }
                },
                yes: function () {
                    var reNum=/^\d*$/;
                    if(!reNum.test($('#sortNum').val())){
                        $.layerMsg({content:'<fmt:message code="netdisk.th.theSerialNumberMustBeInNumericType" />',icon:2})
                        return false;
                    }
                    var path = $('#path').val();
                    if(path!=undefined&&
                        (path.indexOf('tomcat')!=-1
                            ||path.indexOf('xoa')!=-1
                            ||path.indexOf('webapp')!=-1
                            ||path.indexOf('.')!=-1)){

                        layer.msg('<fmt:message code="netdisk.th.theDirectoryFormatIsIncorrect.pleaseModifyItAgain" />', {icon: 0})
                        return;
                    }

                    $.ajax({
                        url: '/netdiskSettings/addNetdiskSettings',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            diskNo: $('#sortNum').val(),
                            diskName: $('#catalog').val(),
                            diskPath: $('#path').val(),
                            spaceLimit: $('#maxcap').val(),
                            orderBy: $('#defaultSort').val(),
                            ascDesc: $('#Ascend').val(),
                            branchDeptId: $('#branchDeptId').val() != null ? $('#branchDeptId').val() : ""
                        },
                        success: function (data) {
                            if (data.flag) {
                                layer.msg('<fmt:message code="depatement.th.Newsuccessfully" />。', {icon: 6})
                                netdiskQuery();
                            }else {
                                $.layerMsg({content:data.msg,icon:2});

                            }

                        }
                    })

                }
            })
        });
        /*编辑*/
        $('.netdiskPar').delegate('#editor', 'click', function () {
            var date_hide = $(this).find("input").val().replace(/'/g, '"');

            layer.open({
                title: '<p style="height: 43px;width: 100%;font-size: 16px;padding-left: 10px;color: #fff"><fmt:message code="netdisk.th.EditorSharedDirectory" /></p>',
                shade: 0.3,
                content: '<div class="newpop">' +
                '<div class="list_group">' +
                '<label for="sortNum" class="toryList"><fmt:message code="file.th.Sort" /> :</label>' +
                '<input type="text" id="sortNum" class="save_w"></div>' +
                '<div class="list_group"><label for="catalog" class="toryList"> <fmt:message code="netdisk.th.SharedDirectoryName" />:</label>' +
                '<input type="text" id="catalog" class="save_w"></div>' +
                '<div class="list_group"><label for="path" class="toryList"><fmt:message code="netdisk.th.SharedDirectoryPath" /> :</label>' +
                '<input type="text" id="path" class="save_w">' +
                '<p class="file_path"><fmt:message code="netdisk.th.TheFilePath" />/soft</p>' + '</div>' +
                '<div class="list_group"><label for="maxcap" class="toryList"> <fmt:message code="netdisk.th.Maximumcapacity" />:</label>' +
                '<input type="text" id="maxcap" class="save_w"><span> MB <fmt:message code="netdisk.th.(0 unrestricted)" /></span></div>' +
                '<div class="list_group">' +
                '<label for="defaultSort" class="toryList"> <fmt:message code="netdisk.th.undefand" />:</label>' +
                '<select name="defaultSort" id="defaultSort" class="defaultSort"><option value="0"><fmt:message code="workflow.th.name" /></option>' +
                '<option value="2"><fmt:message code="netdisk.th.Size" /></option><option value="1"><fmt:message code="notice.th.type" /></option><option value="3"><fmt:message code="netdisk.th.Lastmodifiedtime" /></option>' +
                '</select><select name="defaultSort" id="Ascend" class="Ascend">' + '<option value="0"><fmt:message code="netdisk.th.asc" /></option>' +
                '<option value="1"><fmt:message code="netdisk.th.desc" /></option></select></div>' + '</div>' +
                '<div class="list_group"><label for="branchDeptId" class="toryList"><fmt:message code="user.th.branchDept"/>:</label>' +
                '<select name="branchDeptId" id="branchDeptId" class="branchDeptId"></select></div>',
                area: ['600px', '480px'],
                offset: ['60px', '400px'],
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="notice.th.return" />'],
                success: function () {
                    // 如果当前登陆人是管理员，则不选就行
                    // 如果当前登陆人是分支机构人员，则只显示本分支机构（分支机构人员新建时，只能选本分支机构）
                    if (isOrgScope && branchDeptId !== "" && branchDeptName !== "") {
                        //下拉框加选项
                        $('select[name="branchDeptId"]').html('<option value="' + branchDeptId + '">' + branchDeptName + '</option>');
                    }

                    var dataMsg = JSON.parse(date_hide);
                    $('#sortNum').val(dataMsg.diskNo);
                    $('#catalog').val(dataMsg.diskName);
                    $('#path').val(dataMsg.diskPath);
                    $('#desc').val();
                    $('#maxcap').val(dataMsg.spaceLimit);
                    $('#defaultSort').val(dataMsg.orderBy);
                    $('#Ascend').val(dataMsg.ascDesc);
//                     $('#path').parent().hide();
                    $('#branchDeptId').val(dataMsg.branchDeptId);

                },
                yes: function () {
                    var reNum=/^\d*$/;
                    if(!reNum.test($('#sortNum').val())){
                        $.layerMsg({content:'<fmt:message code="netdisk.th.theSerialNumberMustBeInNumericType" />',icon:2})
                        return false;
                    }
                    var dataMsg = JSON.parse(date_hide);
                    var diskId = dataMsg.diskId;
                    var path = $('#path').val();
                    if(path!=undefined&&
                        (path.indexOf('tomcat')!=-1
                        ||path.indexOf('xoa')!=-1
                        ||path.indexOf('webapp')!=-1
                        ||path.indexOf('.')!=-1)){

                        layer.msg('<fmt:message code="netdisk.th.theDirectoryFormatIsIncorrect.pleaseModifyItAgain" />', {icon: 0})
                        return;
                    }
                    $.ajax({
                        url: '/netdiskSettings/editNetdiskSettings',
                        type: 'post',
                        dataType: 'json',
                        data: {
                            diskNo: $('#sortNum').val(),
                            diskName: $('#catalog').val(),
                            diskPath: $('#path').val(),
                            remark: $('#desc').val(),
                            spaceLimit: $('#maxcap').val(),
                            orderBy: $('#defaultSort').val(),
                            ascDesc: $('#Ascend').val(),
                            branchDeptId: $('#branchDeptId').val() != null ? $('#branchDeptId').val() : "",
                            diskId: diskId
                        },
                        success: function (data) {
                            if (data.flag) {
                                netdiskQuery();
                                layer.msg('<fmt:message code="netdisk.th.Editsuccess" />', {icon: 6})
                            } else{
                                netdiskQuery();
                                layer.msg('<fmt:message code="event.th.EditFailed" />', {icon: 2})
                            }
                        }

                    })

                }
            })
        })
        /*删除*/
        $('.netdiskPar').delegate('#updete_d', 'click', function () {

            var date_hide = $(this).find("input").val().replace(/'/g, '"');
            var dataMsg = JSON.parse(date_hide);
            var diskId = dataMsg.diskId;
            layer.confirm('<fmt:message code="sys.th.commit"/>！', {
                btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                title:"<fmt:message code="netdisk.th.deleteTheSharedDirectory" />"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/netdiskSettings//deleteByDiskId',
                    dataType:'json',
                    data:{
                        diskId: diskId
                    },
                    success:function(data){
                        if (data.flag) {
                            window.parent.frames.layer.msg('<fmt:message code="workflow.th.delsucess" />',{icon:1});
                            netdiskQuery();
                            layer.closeAll();
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
            $('.layui-layer-dialog').css('top',$('.layui-layer-shade').height()/2-104 +'px');
        })

        // 判断是否开启分支机构
        $.ajax({
            type: 'get',
            url: '/syspara/queryOrgScope',
            dataType: 'json',
            success: function (res) {
                if (res.object !== undefined && res.object.paraValue === "1") {
                    isOrgScope = true;

                    //获取当前登陆人 角色
                    $.ajax({
                        type:'get',
                        url:'/getLoginUser',
                        dataType:'json',
                        success:function(res){
                            if (res.object.branchDeptId !== undefined && res.object.branchDeptId !== "" && res.object.branchDeptName !== undefined && res.object.branchDeptName !== "") {
                                branchDeptId = res.object.branchDeptId;
                                branchDeptName = res.object.branchDeptName;
                            }
                        }
                    })
                }
            }
        })

    })
    //发布菜单
    $('.netdiskPar').delegate('#publishUaeApps', 'click', function () {
        // var  v = $(this).find('input[name="value"]').val();
        // var  v =  $("input[name=value]").val();
        // var  v = $(this).find('input[name=value]');
        var date_hide = $(this).find("input").val().replace(/'/g, '"');
        // console.log("1111111111",date_hide);
        // console.log(this)
        var dataMsg = JSON.parse(date_hide);
        var diskId = dataMsg.diskId;
        var diskPath = dataMsg.diskPath;
        var pathName = diskPath.split("/")[1]
        var getNetDiskMenu=dataMsg.getNetDiskMenu;
         // console.log(pathName)
         // console.log(diskId)
    layer.open({
        title: '<p style="height: 43px;width: 100%;font-size: 16px;padding-left: 10px;color: #fff"><fmt:message code="file.th.releaseMenu" /></p>',
        shade: 0.3,
        type: 1,
        content:'<div class="tbox">\n' +
            '        <form class="layui-form" action="" style="margin: auto;">\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><fmt:message code="menuSetting.th.ID" /></label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text"  name="addfId" id="addfId"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSetting.th.menud" /></label>\n' +
            '\n' +
            '                <div class="layui-input-block">\n' +
            '                    <select name="addParentId" id="addParentId" lay-filter="addParentId" lay-verify="required"  class="layui-input-block">\n' +
            '                        <option></option>\n' +
            '                    </select>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSetting.th.itemCode" /></label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addId"  id="addId" lay-verify="title" autocomplete="off" class="layui-input">\n' +
            '            <div><fmt:message code="workflow.th.description2" />\n'+
            '                </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSSetting.th.menuName" /></label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addName"  id="addName" style="border: 1px solid #c0c0c0" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><fmt:message code="workflow.th.module" /></label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addUrl"  id="addUrl"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" id="userBox" style="position:relative;">\n' +
            '                <label class="layui-form-label"><span class="red">*</span><fmt:message code="doc.th.Autho" /></label>\n' +
            '                <div class="layui-input-block">\n' +
            '                        <textarea  style="float: left;border: 1px solid #c0c0c0;background-color: #e7e7e7;" id="privDuser"  readonly="readonly" class="layui-textarea"></textarea>\n' +
            '             <div>\n'+
            '                    <a style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;cursor: pointer;" onclick="selectUser($(this))"><fmt:message code="global.lang.select" /></a>\n' +
            '                    <a style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;margin-left:40px;cursor: pointer;" onclick="reset1()"><fmt:message code="global.lang.empty" /></a>\n' +
            '                </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </form>\n' +
            '    </div>\n',
        area: ['800px', '500px'],
        offset: ['60px', '400px'],
        btn: ['发布', '<fmt:message code="depatement.th.quxiao" />'],
        success: function(layero){
            // $("#addName").val(gappName);
            // var diskPath = e.attr('diskPath');
            // window.open('/netdiskSettings/netqhseworkHard?parentPath='+diskPath);
            // var diskPath ="path";
            if(pathName==''){
                pathName="/";
            }
            $("#addUrl").val('/netdiskSettings/oneNetdisk?diskPath='+pathName+'&diskId='+diskId);
            // $("#addUrl").val('/netdiskSettings/oneNetdisk?diskPath='+diskPath+'&diskId='+diskId+'&getNetDiskMenu='+getNetDiskMenu);
            //获取子菜单项ID
            $.ajax({
                url: '/getMenuId',
                dataType: 'json',
                type: 'post',
                success: function (res) {
                    $("#addfId").val(res.object)
                }
            })
            selectMenu($('#addParentId'));
            // //获取上级菜单类型
            // $.ajax({
            //     type: 'get',
            //     url: '/showNewMenu',
            //     dataType: 'json',
            //     success: function (res) {
            //         if (res.datas.length > 0) {
            //             var $select1 = $("select[name='addParentId']");
            //             var optionStr = '';
            //             for (var i = 0; i < res.datas.length; i++) {
            //                 var select1option = res.datas[i];
            //                 optionStr += '<option class="fwlb" value="' + select1option.id + '">' + select1option.name + '</option>'
            //             }
            //             $select1.append(optionStr);
            //         }
            //         layui.form.render('select')
            //     }
            // })
        },
        yes: function (index, layero) {
            //发布应用
            var privDuser = $("#privDuser").val();//授权角色
            var privDuserids =$("#privDuser").attr('privid');//授权角色id
            var fId =$("#addfId").val();
            var parentIdn = $("#addParentId").val();
            var idss =$("#addId").val();
            var names = $("#addName").val();
            var urls =$("#addUrl").val()
            if(fId=='' || parentIdn=='' || idss=='' ||names=='' || urls=='' ||privDuser==''){
                layer.msg("<fmt:message code="file.th.requiredTtemsCannotBeLeftBlank" />",{icon:5});
                return false;
            }else{
                // console.log(urls);
                $.ajax({
                    url: '/addFunction',
                    data:{
                        fId: fId,
                        parentId: parentIdn,
                        id: idss,
                        name: names,
                        url: urls,
                        isopenNew: 0,
                        isShowFunc: 0
                    },
                    type: 'get',
                    success: function (res) {
                        if(res.flag){
                            layer.msg(res.msg, {icon: 1});
                            $.ajax({
                                url: '/updateUserPrivfuncIdStr',
                                data:{
                                    privids: privDuserids,
                                    funcId: fId
                                },
                                type: 'post',
                                success: function (res) {
                                    layui.layer.close(index);
                                    if(res.flag){
                                        layui.layer.msg("<fmt:message code="user.th.PublishSuccessfully" />", {icon: 1})

                                        // $.ajax({
                                        //     url: '/gtable/selectGtableByGappId',
                                        //     type: 'post',
                                        //     data:{
                                        //         gappId:gappId
                                        //     },
                                        //     success: function (res) {
                                        //         if(res.flag){
                                        //             $.ajax({
                                        //                 url: '/gappLogs/addGappLogs',
                                        //                 type: 'post',
                                        //                 data:{
                                        //                     opObject:"0",
                                        //                     opTyep:"2",
                                        //                     opApp:res.object.tabId,
                                        //                     opDesc:"发布应用["+res.object.tabName+"]"
                                        //                 },
                                        //                 success: function (res) {
                                        //                 }
                                        //             })
                                        //         }
                                        //     }
                                        // })

                                    }
                                }
                            })
                        }else{
                            layer.msg(res.msg, {icon: 5})
                        }
                    }
                });
            }

        },
        btn2:function(index,layer){
            //取消
            layui.layer.close(index);
        }
    })
        // stopPropagation();
    })


    function reset1(){
        $('#userBox').find('textarea').val('');
        $('#userBox').find('textarea').attr('privid','');
        $('#userBox').find('textarea').attr('userpriv','');
    }
    function selectUser(e){
        var privDuser = e.parents('div#userBox').find('textarea').attr('id')
        priv_id = privDuser;
        $.popWindow("../common/selectPriv?1");
    }
    function selectMenu(element) {
        $.ajax({
            type: 'get',
            url: '/showMenu',
            dataType: 'json',
            success: function (rsp) {
                var data = rsp.obj;
                // console.log(data);
                var str = '';
                str = queryMenuT(data, str);
                element.append(str);
                layui.form.render('select');
            }
        })
    }

    function queryMenuT(data, str) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.length==2){
                str += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
            }else{
                str += '<option value="' + data[i].id + '">' +"&nbsp;&nbsp;├"+data[i].name + '</option>';
            }

            if (data[i].child) {
                if (data[i].child.length > 0) {
                    str = queryMenuT(data[i].child, str);
                }
            }

        }
        return str;
    }

    function checkNumber(e){
        e.value = Number.parseInt(e.value)
    }

</script>
</html>
