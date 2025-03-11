<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2020/12/22
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/email/writeMail.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
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
    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20240827.1?20200715.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <%--		<script type="text/javascript" src="/js/email/fileupload.js"></script>--%>
    <title><fmt:message code="address.th.publicFundedMobileSMS" /></title>
</head>
<body class="bodycolor">
<form  method="post" name="form1">
    <table class="table table-bordered table-hover" align="center" style="width:460px;">
        <tbody>
        <tr>
            <td class="" nowrap="">
                <input type="hidden" name="TO_UID" value="6,">
                <textarea name="TO_NAME" id="senduser"  rows="2" class="" wrap="on" style="width:326px;background-color: #eeeeee;font-size: 17px;"></textarea>
                <a href="javascript:void(0)" class="orgAdd" onclick="addUser()"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:void(0)" class="orgClear" onclick="ClearUser()" style="color: #96a1a7;"><fmt:message code="global.lang.empty" /></a>
                <br>
            </td>
        </tr>
        <tr>
            <td>
                <div id="container"  class="researchPlan" style="min-height: 300px;" name="content" type="text/plain"></div>
            </td>
        </tr>
        <tr align="center" class="">
            <td>
                <div style="position:relative;width:100%;text-align:center">
                    <span id="words_count"></span>
                    <span style="position:absolute;left:10px;top:5px;z-index:2;"><fmt:message code="address.th.pressCtrlEnterToSend" /></span>
                    <input type="hidden" name="I_VER" value="">
                    <input type="hidden" name="C" value="">
                    <input type="hidden" value="sms" name="ACTION_TYPE">
                    <input id="submit-btn" type="submit" value="<fmt:message code="workflow.th.SendOut" />" class="btn btn-primary">&nbsp;&nbsp;
                </div>
            </td>
        </tr>
        </tbody></table>
</form>
<script>
    ue = UE.getEditor('container',{elementPathEnabled : false});
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            //return unescape(r[2]);  // 会中文乱码
            return decodeURI((r[2])); // 解决了中文乱码
        return null;
    }
    var userName = getQueryString('userName');
    var uid = getQueryString('uid');
    $(function(){
        $('#senduser').val(decodeURI(userName));
    })
    $('#submit-btn').on('click',function(){
        if($('#senduser').val() =="" )
        {
            alert("<fmt:message code="address.th.pleaseAddRecipients" />");
            return (false);
        }else if(ue.getContent() == "")
        {
            alert("<fmt:message code="address.th.theSMSContentCannotBeEmpty" />");
            return (false);
        }else{
            var contextString = ue.getContent();
            // var contextString = $('.view').html();
            $.ajax({
                type:'post',
                url:'/sms2Priv/smsSenders',
                dataType:'json',
                data:{'contextString': contextString, 'privArray': uid+','},
                success:function(){
                    layer.confirm('<fmt:message code="address.th.SMSSubmittedPrompt" />', {
                        btn: ['<fmt:message code="global.lang.ok" />'],
                        shade: false,
                        time: 8000
                    });
                }
            });
        }
    })
    function editorLoaded()
    {
        //lp 2012/4/25 1:48:28 增加3000字数限制
        getEditorInstances("CONTENT").on("instanceReady", function () {
            that = this;
            //set keyup event
            this.document.on("keyup", function(e){
                checkWord(that);
                CheckSend(e);
            });
            //and click event
            this.document.on("click", function(){checkWord(that);});
            //选择完成表情之后可以继续输入汉字
            this.document.on("onclick",function(){});
        });
    }

    function checkWord(editor)
    {
        var currentLength = getEditorText('CONTENT').length;
        var maxLength = 3000;
        var info = document.getElementById("words_count");
        if(currentLength < maxLength)
        {
            info.innerHTML = sprintf('<fmt:message code="address.th.youCanStillEnter10Characters1" /><em>%s</em><fmt:message code="address.th.youCanStillEnter10Characters2" />',(maxLength-currentLength));
        }else if(currentLength == maxLength){
            info.innerText = "<fmt:message code="address.th.theCharacterLimitHasCeenReached" />";
        }else{
            info.innerHTML = sprintf('<fmt:message code="address.th.moreThan10CharactersHaveBeenEntered1" /><em>%s</em><fmt:message code="address.th.moreThan10CharactersHaveBeenEntered2" />！',maxLength);
        }
    }
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


</body>
</html>
