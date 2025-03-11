<%@ page import="com.xoa.util.CookiesUtil" %>
<%@ page import="com.xoa.model.users.Users" %>
<%@ page import="com.xoa.util.common.session.SessionUtils" %><%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2020/12/14
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/email/writeMail.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/formdesign/bootstrap/js/bootstrap.js?20200826" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/email/writeMail.js?20201116.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <%--		<script type="text/javascript" src="/js/email/fileupload.js"></script>--%>
    <title><fmt:message code="address.th.publicFundedMobileSMS" /></title>
<%--    <link rel="stylesheet" type="text/css" href="/static/theme/19/style.css?20190719">--%>
    <!--[if lte IE 8]>
    <script type="text/javascript" src="/ui/js/ccorrect_btn.js"></script>
    <![endif]-->

<%--    <link rel="stylesheet" type="text/css" href="/static/js/bootstrap/css/bootstrap.css?190819">--%>
    <style>
        .table-bordered th, .table-bordered td {
            border-left: 1px solid #dddddd;
        }
        .table th, .table td {
            padding: 8px;
            line-height: 20px;
            text-align: left;
            vertical-align: top;
            border-top: 1px solid #dddddd;
        }
        .table th, .table td {
            vertical-align: inherit;
        }
        .table-bordered {
            border: 1px solid #dddddd;
            border-collapse: collapse;
            border-collapse: separate;
            border-left: 0;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
        }
        form {
            margin: 50px 0 20px;
        }
        .left{
            width: 30%;
        }
        .right{
            width: 70%;
        }
        a {
            color: #0088cc;
        }
    </style>
    <script>
        var watermark_config = '[]';
        if(typeof watermark_config == 'string' && watermark_config != ''){
            watermark_config = JSON.parse(watermark_config)
        }
        window.watermark_config = watermark_config
    </script>
<%--    <script type="text/javascript" src="/static/js/watermark/watermark.js"></script>--%>
<%--    <script type="text/javascript" src="/static/js/watermark/index.js" charset="utf-8"></script>--%>
<%--    <script src="/static/js/ba/agent.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
        window._td_ba && window._td_ba.server && (window._td_ba.server.guid = '{94E78546-788A-FDDE-E662-7E60AD173C76}');
    </script>
<%--    <script src="/static/js/jquery/jquery-with-migrate.min.js"></script>--%>
<%--    <script src="/static/js/module.js?v=200928"></script>--%>
<%--    <link href="/static/common/userselect.css?20200622" type="text/css" rel="stylesheet">--%>
<%--    <script src="/module/DatePicker/WdatePicker.js"></script>--%>
    <link href="http://39.100.157.117:8090/module/DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    <script language="JavaScript">
        var sign = "";
        $.get('/getLoginUser', function (res) {
            if (res.flag && res.object) {
                sign = res.object.userName+"：";
                SignName();
            }
        });
        function getQueryString(name){
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null)
                //return unescape(r[2]);  // 会中文乱码
                return decodeURI(r[2]); // 解决了中文乱码
            return null;
        }
        var userName = getQueryString('userName');
        var mobilNo = getQueryString('mobilNo');
        $(function(){
            // document.form1.TO_NAME.value = userName;
            document.form1.TO_ID1.value = mobilNo+',';

            $("#sendMsg").on('click',function() {
                checkForm();
            });

            $('input[name="SEND_TIME"]').val(currentTime());
        });

        function checkForm() {
            if(document.form1.TO_NAME.value=="" && document.form1.TO_ID1.value=="") {
                alert("<fmt:message code="address.th.pleaseAddRecipients" />");
                return (false);
            } else if (document.form1.CONTENT.value == "" || document.form1.CONTENT.value == sign) {
                alert("<fmt:message code="address.th.theSMSContentCannotBeEmpty" />");
                return (false);
            } else if(document.form1.CONTENT.value.length > 70) {
                msg = '<fmt:message code="address.th.contentExceeding70WordsPrompt" />';
                if(window.confirm(msg)) {
                    var currentIndex = 0;
                    for (var i = 0; i< Math.ceil(document.form1.CONTENT.value.length/70); i++) {
                        var nextIndex = (i + 1)* 70;
                        var sendContext = document.form1.CONTENT.value.slice(currentIndex, nextIndex);
                        currentIndex = nextIndex;
                        if (i > 0) sendContext = sign + sendContext;
                        sms(sendContext);
                    }
                }
                else {
                    return (false);
                }
            } else {
                sms(document.form1.CONTENT.value);
            }
        }

        function sms(contextString) {
            //去掉回车换行  替换成逗号
            var mobileArray = document.form1.TO_ID1.value.replace(/\r\n/g, ',').replace(/\r/g, ',').replace(/\n/g, ',').replace(/,{2,}/g, ',')
            var contextString = contextString;
            $.ajax({
                type:'post',
                // url:'/sms2Priv/smsSenderMobiles',
                dataType:'json',
                data:{'contextString': contextString, 'mobileArray': mobileArray},
                success:function() {
                    layer.msg('<fmt:message code="address.th.SMSSubmittedPrompt" />');
                }
            });
        }

        function notice() {
            msg = "<fmt:message code="address.th.SMSRecordPrompt" />";
            alert(msg);
        }

        function CheckSend() {
            if(event.keyCode==10)
            {
                if(checkForm())
                {
                    document.form1.submit();
                }
            }
        }

        var cap_max=200;

        function getLeftChars(varField)
        {
            var i = 0;
            var counter = 0;
            var cap = cap_max;
            var leftchars = cap - varField.value.length;

            return (leftchars);
        }

        function ce_len(str)
        {
            var celen=0;
            for(var k=0;k< str.length;k++)
            {
                if(str.charAt(k)>'~')
                {
                    celen+=2;
                }
                else
                {
                    celen++;
                }
            }
            return celen;
        }

        function onCharsChange(varField)
        {
            var leftChars = getLeftChars(varField);
            if ( leftChars >= 0)
            {
                document.form1.charsmonitor1.value=cap_max-leftChars;
                document.form1.charsmonitor2.value=leftChars;
                return true;
            }
            else
            {
                document.form1.charsmonitor1.value=cap_max;
                document.form1.charsmonitor2.value="0";
                window.alert("<fmt:message code="address.th.theSMSContentExceedsTheCharacterLimit" />");
                var len = document.form1.CONTENT.value.length + leftChars;
                document.form1.CONTENT.value = document.form1.CONTENT.value.substring(0, len);
                leftChars = getLeftChars(document.form1.CONTENT);
                if ( leftChars >= 0)
                {
                    document.form1.charsmonitor1.value=cap_max-leftChars;
                    document.form1.charsmonitor2.value=leftChars;
                }
                return false;
            }
        }


        // function LoadDo() {
        //     SignName();
        // }

        function SignName() {
            document.form1.CONTENT.value += sign;
            onCharsChange(document.form1.CONTENT);
            document.form1.CONTENT.focus();
        }

        function ClearContent() {
            document.form1.CONTENT.value="";
            onCharsChange(document.form1.CONTENT);
            document.form1.CONTENT.focus();
        }

        function LoadWindow3()
        {
            URL="/address/addr_select/";
            loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
            loc_y=document.body.scrollTop+event.clientY-event.offsetY+170;
            //window.open(URL,"read_notify","height=400,width=550,status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,top=150,left=150,resizable=yes");
            if(window.showModalDialog){
                window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:350px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
            }else{
                window.open(URL,"load_dialog_win","height=350,width=450,status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,top="+loc_y+",left="+loc_x+",resizable=yes,modal=yes,dependent=yes,dialog=yes,minimizable=no",true);
            }
        }

        function ClearSendUser() {
            document.form1.TO_ID1.value = "";
        }

        // 补0
        function pad(num, n) {
            var len = num.toString().length;
            while(len < n) {
                num = "0" + num;
                len++;
            }
            return num;
        }

        function currentTime() {
            var myDate = new Date;
            var year = myDate.getFullYear(); //获取当前年
            var mon = myDate.getMonth() + 1; //获取当前月
            var date = myDate.getDate(); //获取当前日
            var h = pad(myDate.getHours(), 2);//获取当前小时数(0-23)
            var m = pad(myDate.getMinutes(), 2);//获取当前分钟数(0-59)
            var s = pad(myDate.getSeconds(), 2);//获取当前秒
            var week = myDate.getDay();
            var weeks = ["<fmt:message code="Sunday" />", "<fmt:message code="Monday" />", "<fmt:message code="Tuesday" />", "<fmt:message code="Wednesday" />", "<fmt:message code="Thursday" />", "<fmt:message code="Friday" />", "<fmt:message code="Saturday" />"];
            // console.log(year, mon, date, weeks[week])
            return year +"-"+ mon +"-"+ date +" "+ h +":"+ m +":"+ s;
        }
</script>
</head>
<body class="bodycolor" onload="LoadDo();">
<form  method="post" name="form1" onsubmit="return checkForm();">
    <table class="table table-bordered table-hover table-600" style="width:650px" align="center">
        <tbody><tr>
            <td nowrap="" class="left"><fmt:message code="address.th.recipientInternalUser" />：</td>
            <td nowrap="" class="right">
                <input type="hidden" name="TO_ID" value="">
<%--                <textarea cols="55" name="TO_NAME" rows="3" class="" readonly="" disabled></textarea>--%>
                <textarea name="TO_NAME" id="senduser" rows="3" cols="55"  user_id=''  value="" disabled></textarea>
                <a href="javascript:void(0)" class="orgAdd" id="selectUser" onclick="addUser()"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:void(0)" class="orgClear" onclick="ClearUser()" style="color: #96a1a7;"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="left"><fmt:message code="address.th.recipientExternalNumber" />：</td>
            <td class="right">
                <fmt:message code="address.th.recipientExternalNumberDesc" /><br>
                <textarea cols="55" name="TO_ID1" rows="3" class=""></textarea>
                <a href="javascript:void(0)" class="orgAdd" onclick="LoadWindow3()" title="<fmt:message code="address.th.addRecipientsFromTheAddressBook" />"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:void(0)" class="orgClear" onclick="ClearSendUser()" style="color: #96a1a7;"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="left"> <fmt:message code="main.th.rl" />：</td>
            <td class="right">
                <fmt:message code="address.th.alreadyEntered" /><input class="input-mini" type="text" name="charsmonitor1" size="3" readonly="true" disabled><fmt:message code="address.th.SMSContentDesc1" /><input class="input-mini" disabled type="text" name="charsmonitor2" size="3" readonly="true"><fmt:message code="address.th.SMSContentDesc2" /><br>
                <textarea cols="70" name="CONTENT" rows="5" class="" onpaste="return onCharsChange(this);" onkeyup="return onCharsChange(this);" onkeypress="CheckSend()" style="margin-top:5px;"></textarea>
                <br><fmt:message code="address.th.SMSContentDesc3" /> &nbsp;<a href="javascript:notice();"><fmt:message code="address.th.privacyWarning" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="left"> <fmt:message code="sup.th.SendingTime" />：</td>
            <td class="right">
                <input type="text" name="SEND_TIME" size="19" maxlength="19" class="" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" autocomplete="off" disabled>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" nowrap="" style="text-align:center">
                <input type="button" value="<fmt:message code="workflow.th.SendOut" />" class="btn btn-primary" id="sendMsg">
                <input type="button" value="<fmt:message code="address.th.signature" />" class="btn" onclick="SignName()">
                <input type="button" value="<fmt:message code="address.th.clearContent" />" class="btn" onclick="ClearContent()">
            </td>
        </tr>
        </tbody></table>
</form>
<br>
<%--<div align="center" style="font-size:9pt;color:gray">手机短信组件尚未注册，如需购买，请联系开发厂商</div>--%>

<div id="_my97DP" style="position: absolute; top: -1970px; left: -1970px;"><iframe style="width: 202px; height: 217px;" src="http://39.100.157.117:8090/module/DatePicker/My97DatePicker.htm" frameborder="0" border="0" scrolling="no"></iframe></div></body>
<script>
    //选人控件
    function addUser(){
        user_id='senduser';
        $.popWindow("/common/selectUser");
    }
    function ClearUser(){
        $("#senduser").val("");
        $("#senduser").attr('username','');
        $("#senduser").attr('dataid','');
        $("#senduser").attr('user_id','');
        $("#senduser").attr('userprivname','');
    }
</script>
</html>
