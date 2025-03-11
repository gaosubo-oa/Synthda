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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>微讯审核权限</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/email/manageMail.css"/>
    <script src="/js/common/language.js"></script>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/wxCheck.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .title{
            margin-left: 20px;
            margin-top: 20px;
        }
        table tr th,.TABLE_A table tr th{
            font-size: 13pt;
        }
        .TABLE tr td,.TABLE_A table tr td{
            font-size: 11pt;
        }
        input[type="checkbox"],input[type="radio"]{
            background: transparent;
            border: 0;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="DIV_LIST" id="DIV_LIST" style="display: block;">
        <div class="title">
            <div class="div_im">
                <img src="../img/icon_addEmail_03.png">
            </div>
            <div class="div_title">添加微讯审核权限</div>
        </div>
        <div class="TABLE" style="width: 100%;">
            <form action="" method="get">
                <table cellspacing="0" cellpadding="0" width="40%" style="border-collapse:collapse;background-color: #fff;margin: 0 auto;">
                    <tr>
                        <th colspan="2" style="text-align: center;background-color: #3691DA;color: #fff;font-weight: normal;padding: 6px;">添加微讯审核权限</th>
                    </tr>
                    <tr>
                        <td class="TableContent" width="70px">是否开启：</td>
                        <td class="TableData" width="70%">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                            <label><input style="width:20px;height:15px;" type="radio" name="SWITCH" value=1 id="switch_on" onclick="showsetting()" ></label><label for="switch_on"><fmt:message code="three.th.open" /></label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label></label> <input style="width:20px;height:15px;" type="radio" name="SWITCH" value=0 id="switch_off"  onclick="hidesetting()"  checked ><label for="switch_off"><fmt:message code="three.th.Disable" /></label>

                        </td>
                    </tr>
                    <tr id="hide1">
                        <td>部门：</td>
                        <td>
                            <%--<input type="text" name="txt" id="txt1" value="" />--%>
                            <textarea name="txt" id="deptName" style="min-width: 70%;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseDept">选择</a>
                            <a href="javascript:;" class="clearDept">清空</a>
                        </td>
                    </tr>
                    <tr id="hide2">
                        <td>用户：</td>
                        <td>
                            <%--<input type="text" name="txt" id="txt2" value="" />--%>
                            <textarea name="txt" id="userName" user_id='' style="min-width: 70%;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseUser">选择</a>
                            <a href="javascript:;" class="clearUser">清空</a>
                        </td>
                    </tr>

                    <tr id="hide3">
                        <td colspan="2">
                            <div name="btn" id="btn" >
                                <div class="DIV_Txt" id="AddFolder"><span style="margin-left: 31px;"><fmt:message code="global.lang.add" /></span></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <hr />
        <div class="div_list">
            <div class="title">
                <div class="div_im">
                    <img src="../img/icon_manageEmail_03.png">
                </div>
                <div class="div_title">管理微讯审核权限</div>
            </div>
            <div class="TABLE_A" id="TABLE_A">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:70%;margin: 0 auto;">
                    <tr class='befor'>

                        <th width="10%">部门名称</th>
                        <th width="10%">用户名称</th>
                        <th width="20%"><fmt:message code="notice.th.operation" /></th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="DIV_EDIT_LIST" style="display: none;">
        <div class="title">
            <div class="div_im">
                <img src="../img/icon_manageEmail_03.png">
            </div>
            <div class="div_title">编辑微讯审核权限</div>
        </div>
        <div class="TABLE" style="width: 100%;">
            <form action="" method="get">
                <table cellspacing="0" cellpadding="0" width="40%" style="border-collapse:collapse;background-color: #fff;margin: 0 auto;">
                    <tr>
                        <th colspan="2" style="text-align: center;background-color: #3691DA;color: #fff;font-weight: normal;padding: 6px;">编辑微讯审核权限</th>
                    </tr>
                    <%--tr>
                        <td>部门：</td>
                        <td>
                            &lt;%&ndash;<input type="text" name="txt" id="txt1" value="" />&ndash;%&gt;
                            <textarea name="txt" id="deptNames" style="min-width: 70%;" value="" readonly></textarea>
                            <a href="javascript:;" class="chose2Dept">选择</a>
                            <a href="javascript:;" class="clear2Dept">清空</a>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>部门：</td>
                        <td>
                            <input type="hidden" name="txt" id="txt5">
                            <input type="text" name="txt" id="txt3" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>用户：</td>
                        <td>
                            <%--<input type="text" name="txt" id="txt2" value="" />--%>
                            <textarea name="txt" id="userNames" user_id='' style="min-width: 45%;" value="" readonly></textarea>
                            <a href="javascript:;" class="chose2User">选择</a>
                            <a href="javascript:;" class="clear2User">清空</a>
                        </td>
                    </tr>
                    <%--<tr>
                        <td>部门：</td>
                        <td>
                            <input type="hidden" name="txt" id="txt5">
                            <input type="text" name="txt" id="txt3" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>用户：</td>
                        <td>
                            <input type="hidden" name="txt" id="txt6">
                            <input type="text" name="txt" id="txt4" value="" />
--%>
                    <%--<input type="text" name="txt" id="txt2" value="" />--%>
                    <%--  <td>
                           <textarea name="txt" id="txt4" user_id='' style="min-width: 45%;" value="" readonly></textarea>
                           <a href="javascript:;" class="choseUser">选择</a>
                           <a href="javascript:;" class="clearUser">清空</a>
                       </td>--%>

                    </td>




                    </tr>
                    <tr>
                        <td colspan="2">
                            <div name="btn" id="BTN" >
                                <div class="DIV_BTN" id="btnSure"><fmt:message code="global.lang.ok" /></div>
                                <div class="DIV_BTN" id="btnReturn"><fmt:message code="notice.th.return" /></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <!--<div class="externalMail" id="externalMail" style="display: none;">
        <div class="title IEmail" style="display: block;">
            <div class="div_im">
                <img src="../img/email/icon_intermail_07.png">
            </div>
            <div class="div_title">Internet<fmt:message code="email.th.mailbox" /></div>
            <div class="newAdd"><span style="margin-left: 26px;"><fmt:message code="email.th.NewMailbox" /></span></div>
        </div>
        <div class="newList" style="display: block;">
            <table id="tableList" cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:50%;margin-left:50px;">
                <tr>
                    <th width="60%"><fmt:message code="email.th.E-mailAddress" /></th>
                    <th width="40%"><fmt:message code="menuSSetting.th.menuSetting" /></th>
                </tr>
            </table>
        </div>-->
    <%--<div class="setList" style="display: none;">--%>
    <%--<input type="hidden" name="newOrEdit" value="">--%>
    <%--<input type="hidden" name="editId" value="">--%>
    <%--<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:80%;margin-left:50px;">--%>
    <%--<tr>--%>
    <%--<th width="60%" colspan="2"><fmt:message code="email.th.ConfigureAccounts" /></th>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.E-mailAddress" />：</td>--%>
    <%--<td>--%>
    <%--<input type="email" name="email" value="" id = "webEmail" onkeyup="copyob1toob()">--%>
    <%--<span><fmt:message code="email.th.example" />abc@263.net</span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.ReceiveServer" />(POP3)：</td>--%>
    <%--<td>--%>
    <%--<input type="text" name="popServer" value="" id = "webPopServer">--%>
    <%--<span><fmt:message code="email.th.port" /></span>--%>
    <%--<input type="text" name="pop3Port" value="995" id = "webPop3Port">--%>
    <%--<div class="div_ssL">--%>
    <%--<input type="checkbox" name="pop3Ssl" value="" id = "webPop3Ssl">--%>
    <%--<span><fmt:message code="email.th.connections" />(SSL)</span>--%>
    <%--</div>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.SendServer" />(SMTP)：</td>--%>
    <%--<td>--%>
    <%--<input type="text" name="smtpServer" value="" id = "webSmtpServer">--%>
    <%--<span><fmt:message code="email.th.port" /></span>--%>
    <%--<input type="text" name="smtpPort" value="465" id = "webSmtpPort">--%>
    <%--<div class="div_ssL">--%>
    <%--<input type="checkbox" name="smtpSsl" value="" id="webSmtpSsl">--%>
    <%--<span><fmt:message code="email.th.secureConnections" />(SSL)</span>--%>
    <%--</div>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.LoginAccount" />：</td>--%>
    <%--<td>--%>
    <%--<input type="text" name="emailUser" value="" id = "webEmailUser">--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.LoginPassword" />：</td>--%>
    <%--<td>--%>
    <%--<input type="password" name="emailPass" value="">--%>
    <%--<span><fmt:message code="email.th.mailLogin" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.SMTP" />：</td>--%>
    <%--<td>--%>
    <%--<select name="smtpPass" id="selection">--%>
    <%--<option value="yes" name="yes"><fmt:message code="global.lang.yes" /></option>--%>
    <%--<option value="no" name="no"><fmt:message code="global.lang.no" /></option>--%>
    <%--</select>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.Automaticallymail" />：</td>--%>
    <%--<td>--%>
    <%--<select name="checkFlag" id="selectOut">--%>
    <%--<option value="1" name="1"><fmt:message code="global.lang.yes" /></option>--%>
    <%--<option value="0" name="0"><fmt:message code="global.lang.no" /></option>--%>
    <%--</select>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.MailboxCapacity" />(MB)：</td>--%>
    <%--<td>--%>
    <%--<input type="text" name="quotaLimit" value="" disabled>--%>
    <%--<span><fmt:message code="email.th.ForUnlimited" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.DefaultMailbox" />：</td>--%>
    <%--<td>--%>
    <%--<input type="checkbox" name="isDefault" value="">--%>
    <%--<span><fmt:message code="email.th.accountPassword" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.DeleteMail" />：</td>--%>
    <%--<td>--%>
    <%--<input type="checkbox" name="recvDel" value="">--%>
    <%--<span><fmt:message code="email.th.Deletemail" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.ForwardingSettings" />：</td>--%>
    <%--<td>--%>
    <%--<input type="checkbox" name="recvFw" value="">--%>
    <%--<span><fmt:message code="email.th.ForwardInternal" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td><fmt:message code="email.th.NewmaiReminder" />：</td>--%>
    <%--<td>--%>
    <%--<input type="checkbox" name="recvRemind" value="" checked>--%>
    <%--<span><fmt:message code="email.th.Sennewmail" /></span>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
    <%--<td colspan="2">--%>
    <%--<div class="newButton">--%>
    <%--<div class="newSureBtn"><span style="margin-left: 32px;"><fmt:message code="global.lang.save" /></span></div>--%>
    <%--<div class="newBackBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>--%>
    <%--</div>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--</table>--%>
    <%--</div>--%>
</div>
</div>
<script>
    var user_id;
    var dept_id;
    $(function () {
        $('.choseDept').click(function () {
            dept_id='deptName';
            $.popWindow("../common/selectDept?0");
        })
        $('.choseUser').click(function () {
            user_id='userName';
            $.popWindow("../common/selectUser");
        })
        $('.clearDept').click(function () {
            $('#deptName').attr('deptname','');
            $('#deptName').attr('deptid','');
            $('#deptName').attr('deptno','');
            $('#deptName').val('');
        });
        $('.clearUser').click(function () {
            $('#userName').attr('user_id','');
            $('#userName').attr('username','');
            $('#userName').attr('dataid','');
            $('#userName').attr('userprivname','');
            $('#userName').val('');
        })
//
        $('.chose2Dept').click(function () {
            dept_id='deptNames';
            $.popWindow("../common/selectDept?0");
        })
        $('.chose2User').click(function () {
            user_id='userNames';
            $.popWindow("../common/selectUser");
        })
        $('.clear2Dept').click(function () {
            $('#deptName').attr('deptname','');
            $('#deptName').attr('deptid','');
            $('#deptName').attr('deptno','');
            $('#deptName').val('');
        });
        $('.clear2User').click(function () {
            $('#userNames').attr('user_id','');
            $('#userNames').attr('username','');
            $('#userNames').attr('dataid','');
            $('#userNames').attr('userprivname','');
            $('#userNames').val('');
        })


    })
    function showDiv(){
        $('#externalMail').show().siblings().hide();
    }
    function divListShow(){
        $('#DIV_LIST').show().siblings().hide();
    }



</script>
</body>
</html>


