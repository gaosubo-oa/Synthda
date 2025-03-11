<%--
    寇义东
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
<!--[if IE 6 ]> <html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]> <html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]> <html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]> <html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]> <html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <%--<link rel="stylesheet" type="text/css" href="/static/theme/15/style.css" />--%>
    <!--[if lte IE 8]>

    <script type="text/javascript" src="/static/js/ccorrect_btn.js"></script>
    <![endif]-->

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <style type="text/css">
        body{
            overflow-x: hidden;
        }
        table{
            width: 800px;
        }
        .TableBlock, .TableBlock input, .TableBlock select{
            font-size: 20px;
        }

    </style>
</head>
<%--<script type="text/javascript" src="/ui/js/utility.js"></script>--%>
<script Language="JavaScript">
    function CheckForm()
    {

        if(document.form1.EMAIL.value==""||document.form1.POP_SERVER.value==""||document.form1.SMTP_SERVER.value=="")
        { alert("<fmt:message code="email.th.emailAccountInformationCannotBeEmpty" />");
            return (false);
        }

        return (true);
    }
    var mails={};
    mails['163.com']=new Array('pop.163.com',110,0,'smtp.163.com',25,0,0,0);
    mails['vip.163.com']=new Array('pop.vip.163.com',110,0,'smtp.vip.163.com',25,0,0,0);
    mails['188.com']=new Array('pop.188.com',110,0,'smtp.188.com',25,0,0,0);
    mails['126.com']=new Array('pop.126.com',110,0,'smtp.126.com',25,0,0,0);
    mails['yeah.net']=new Array('pop.yeah.net',110,0,'smtp.yeah.net',25,0,0,0);
    mails['qq.com']=new Array('pop.qq.com',995,1,'smtp.qq.com',465,1,0,0);
    mails['vip.qq.com']=new Array('pop.qq.com',995,1,'smtp.qq.com',465,1,1,0);
    mails['sina.com']=new Array('pop.sina.com',110,0,'smtp.sina.com',25,0,0,0);
    mails['vip.sina.com']=new Array('pop3.vip.sina.com',110,0,'smtp.vip.sina.com',25,0,0,0);
    mails['sohu.com']=new Array('pop.sohu.com',110,0,'smtp.sohu.com',25,0,0,0);
    mails['tom.com']=new Array('pop.tom.com',110,0,'smtp.tom.com',25,0,0,0);
    mails['gmail.com']=new Array('pop.gmail.com',995,1,'smtp.gmail.com',465,1,1,0);
    mails['yahoo.com.cn']=new Array('pop.mail.yahoo.com.cn',995,1,'smtp.mail.yahoo.com.cn',465,1,1,0);
    mails['yahoo.cn']=new Array('pop.mail.yahoo.cn',995,1,'smtp.mail.yahoo.cn',465,1,1,0);
    mails['21cn.com']=new Array('pop.21cn.com',110,0,'smtp.21cn.com',25,0,0,0);
    mails['21cn.net']=new Array('pop.21cn.net',110,0,'smtp.21cn.net',25,0,0,0);
    mails['263.net']=new Array('263.net',110,0,'smtp.263.net',25,0,0,0);
    mails['x263.net']=new Array('pop.x263.net',110,0,'smtp.x263.net',25,0,0,0);
    mails['263.net.cn']=new Array('263.net.cn',110,0,'263.net.cn',25,0,0,0);
    mails['263xmail.com']=new Array('pop.263xmail.com',110,0,'smtp.263xmail.com',25,0,0,0);
    mails['foxmail.com']=new Array('pop.foxmail.com',110,0,'smtp.foxmail.com',25,0,0,0);
    mails['hotmail.com']=new Array('pop3.live.com',995,1,'smtp.live.com',25,1,1,0);
    mails['live.com']=new Array('pop3.live.com',995,1,'smtp.live.com',25,1,1,0);

    function FillSettings(email)
    {
        $('EMAIL_USER').value = email;
        if(email.trim()=="" || email.indexOf("@")<0) return;
        var email = email.substr(email.indexOf("@")+1).trim();

        if(isUndefined(mails[email])) return;

        $('POP_SERVER').value=mails[email][0];
        $('POP3_PORT').value=mails[email][1];
        $('POP3_SSL').checked=mails[email][2];
        $('SMTP_SERVER').value=mails[email][3];
        $('SMTP_PORT').value=mails[email][4];
        $('SMTP_SSL').checked=mails[email][5];
//   $('LOGIN_TYPE').selectedIndex=mails[email][6];
        $('SMTP_PASS').selectedIndex=mails[email][7];
        $('EMAIL_PASS') && $('EMAIL_PASS').focus();
    }
</script>
<body class="bodycolor mg-10" >
<div class="EmailInfo">
    <table class="TableTop">
        <tr>
            <td class="left"></td>
            <td class="center subject"><h3><fmt:message code="email.th.fileSize" /></h3></td>
            <td class="right"></td>
        </tr>
    </table>

    <form action="internetEmailList.jsp"  method="post" name="form1" onsubmit="return CheckForm();">
        <table class="TableBlock">
            <input type='hidden' name='type' value='' />
            <tr>
                <td nowrap> <fmt:message code="email.th.emailAddress" />：</td>
                <td class="TableData">
                    <input type="text" id="EMAIL" name="EMAIL" size="30" maxlength="200" value="" onkeyup='FillSettings(this.value);'>
                    <br> <fmt:message code="email.th.example" />abc@263.net
                </td>
            </tr>

            <tr>
                <td nowrap> <fmt:message code="email.th.receivingServer" />(POP3)：</td>
                <td>
                    <input type="text" id="POP_SERVER" name="POP_SERVER" size="20" maxlength="100" value="">&nbsp;
                    <fmt:message code="email.th.port" /> <input type="text" id="POP3_PORT" name="POP3_PORT" size="4" value="110">&nbsp;<br>
                    <input type="checkbox" id="POP3_SSL" name="POP3_SSL" id="POP3_SSL"><label for="POP3_SSL"><fmt:message code="email.th.secureConnections" />(SSL)</label>
                </td>
            </tr>
            <tr>
                <td nowrap> <fmt:message code="email.th.sendingServer" />(SMTP)：</td>
                <td>
                    <input type="text" id="SMTP_SERVER" name="SMTP_SERVER" size="20" maxlength="100" value="">&nbsp;
                    <fmt:message code="email.th.port" /><input type="text" id="SMTP_PORT" name="SMTP_PORT" size="4" value="25">&nbsp;<br>
                    <input type="checkbox" id="SMTP_SSL" name="SMTP_SSL" id="SMTP_SSL"><label for="SMTP_SSL"><fmt:message code="email.th.secureConnections" />(SSL)</label>
                </td>
            </tr>
            <tr>
                <td nowrap>  <fmt:message code="email.th.LoginAccount" />：</td>
                <td>
                    <input id="EMAIL_USER" type="text" name="EMAIL_USER" size="20" maxlength="100" value="">
                </td>
            </tr>
            <tr>
                <td nowrap>  <fmt:message code="email.th.LoginPassword" />：</td>
                <td>
                    <input type="password" name="EMAIL_PASS" size="20" maxlength="100" value="">
                    <fmt:message code="email.th.mailLogin" />      </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.SMTP" />：</td>
                <td class="TableData">
                    <select id="SMTP_PASS" name="SMTP_PASS">
                        <option value="yes" ><fmt:message code="global.lang.yes" /></option>
                        <option value="no" ><fmt:message code="global.lang.no" /></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.Automaticallymail" />：</td>
                <td>
                    <select id="CHECK_FLAG" name="CHECK_FLAG">
                        <option value="1" ><fmt:message code="global.lang.yes" /></option>
                        <option value="0" ><fmt:message code="global.lang.no" /></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td nowrap> <fmt:message code="email.th.MailboxCapacity" />(MB)：</td>
                <td>
                    <input type="text" name="QUOTA_LIMIT" size="6" maxlength="10" value="" readonly> <fmt:message code="email.th.ForUnlimited" />      </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.DefaultMailbox" />：</td>
                <td>
                    <input type="checkbox" name="IS_DEFAULT" id="IS_DEFAULT"><label for="IS_DEFAULT"><fmt:message code="email.th.accountPassword" /></label>
                </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.DeleteMail" />：</td>
                <td>
                    <input type="checkbox" name="RECV_DEL" id="RECV_DEL"><label for="RECV_DEL"><fmt:message code="email.th.Deletemail" /></label>
                </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.ForwardingSettings" />：</td>
                <td>
                    <input type="checkbox" name="RECV_FW" id="RECV_FW"><label for="RECV_FW"><fmt:message code="email.th.ForwardInternal" /></label>
                </td>
            </tr>
            <tr>
                <td nowrap valign="top"> <fmt:message code="email.th.NewmaiReminder" />：</td>
                <td>
                    <input type="checkbox" name="RECV_REMIND" id="RECV_REMIND" checked><label for="RECV_REMIND"><fmt:message code="email.th.Sennewmail" /> </label>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2" nowrap>
                    <input type="hidden" name="OPERATION" value="1">
                    <input type="submit" value="<fmt:message code="global.lang.save" />" id="saveBtn">&nbsp;&nbsp;
                    <input type="button" value="<fmt:message code="notice.th.return" />" id="backBtn">
                </td>
            </tr>
        </table>
    </form>
</div>
<script>
    function showDiv(){
        $('#externalMail').show().siblings().hide();
    }
    function divListShow(){
        $('#DIV_LIST').show().siblings().hide();
    }
</script>
<script>
    $(function(){
        $('.saveBtn').on('click', function(){
            var pop3PortVal;
            if($('POP3_SSL').checked){
                pop3PortVal = 1;
            }
            var data = {
                email: $('EMAIL').val(), // 邮件地址
                popServer: $('POP_SERVER').val() + ':' + $('POP3_PORT').val(), // 接收服务器(POP3)
                pop3Port: 1
            };
            $.ajax({
                url: '/email/saveWebMail',
                type: 'get',
                dataType: 'json',
                data: {

                },
                success: function(res){
                    console.log(res);
                }
            });

            $('.EmailInfo').css('display', 'none');
            var Ifrmae = '<div class="div_iframeOne" style="width: 100%; overflow-y: hidden; overflow-x: hidden; float: left; height: 100%;">' +
                '<iframe name="iframe1" width="100%" height="100%" src="/email/internetEmailList" onload="this.height=iframe1.document.body.scrollHeight+100" frameborder="0" noresize="noresize"></iframe>' +
                '</div>';
            $('.EmailInfo').append(Ifrmae);
            document.getElementById("iframe_id").onload = function () { //控制子页面的方法
                myFrame.window.showDiv();
            };



        });

    })

</script>
</body>
</html>
