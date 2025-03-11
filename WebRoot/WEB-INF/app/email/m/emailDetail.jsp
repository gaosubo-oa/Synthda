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
    <title><fmt:message code="email.th.mailDetails" /></title><%--邮件详情--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8 ? MYOA_CHARSET : htmlspecialchars($HTML_PAGE_CHARSET))?>" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/base/base.js?20210201.1" type="text/javascript" charset="utf-8"></script>
    <script src="../js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        div table tr td p{margin: 0;padding: 0;}
        body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 10pt;width: 100%;overflow-x: hidden;}
        .detailsContent{width: 100%;margin: 0px auto;height:100%;overflow-x:auto}
        table{width: 71%;float: left;}
        table tr td a{text-decoration: none;}
        table tr td:first-of-type{width: 100px;padding: 8px;}
        table tr td:last-of-type{text-align: left;padding-left: 20px;}
        .detailsContent .p_txt{margin-top: 10px;padding: 0 10px;border-top: #ccc 1px solid;word-wrap: break-word;box-sizing: content-box;}
        .detailsContent .p_txt p{
            word-wrap: break-word;
        }
        .Table tr td a{
            color: #207BD6;
        }
        body,html{height:100%;padding:0px;margin:0px;}
        /*.detailsContent .p_txt *{*/
        /*    font-size: 11pt !important;*/
        /*}*/
        .mainRight{
            float: right !important;
            width: 29% !important;
        }
        .divImg{
            width: 100px;
            height: 90px;
            margin: 10px auto;
        }
        .divImg img{
            width: 100%;
        }
        .userInfo{
            width: 100%;
            margin-top: 20px;
        }
        .userInfo p{
            width: 100%;
            line-height: 10px;
            text-align: center;
        }
        .divBtn{
            width: 100%;
            height: 40px;
            border-bottom: #ccc 1px solid;
            padding-top: 10px;
        }
        .divBtn>div{
            float: left;
            margin: 0 10px;
            height: 28px;
            line-height: 28px;
            border: #ccc 1px solid;
            padding: 0 8px;
            border-radius: 4px;
            cursor: pointer;
        }
        .divBtn img{
            vertical-align: middle;
            margin-top: -3px;
            margin-right: 5px;
        }
        .hoverbox {
            position: absolute;
            background: #fff;
            right: -45px;
            width: 60px;
            z-index: 1001;
            top: 0;
            height: auto;
            padding: 2px 0;
            margin: 2px 0 0;
            list-style: none;
            background-color: #ffffff;
            border: 1px solid #ccc;
            border: 1px solid rgba(0,0,0,0.2);
            border-right-width: 2px;
            border-bottom-width: 2px;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
            -webkit-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            -moz-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            -webkit-background-clip: padding-box;
            -moz-background-clip: padding;
            background-clip: padding-box;
            display: none;
        }
        .hoverbox li {
            font-size: 9pt;
            cursor: pointer;
            color: #333333;
            padding: 0 5px;
        }
        .hoverbox li:hover{
            background-color: #0081c2;
            color: #fff;
        }
       /* .td-min-height{
            margin-left: 15% !important;
        }
        .tr_td , .trtd_d{
            width: 100%;
        }*/
    </style>
    <script type="text/javascript">
        $(function () {
            var id=$.getQueryString('id');
            var TYPE=$.getQueryString('boxType');
            var editType=$.getQueryString('editType');
            var flag=$.getQueryString('flag');
            var copyTime = $.getQueryString('copyTime');
            if(editType){
                $.ajax({
                    type:'get',
                    url:'/email/selectDetailById',
                    dataType:'json',
                    data:{bodyId:id},
                    success:function(res){
                        var data2=res.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var str='';
                        var stra='';
                        var arr=new Array();
                        arr=data2.attachmentList;
                        $('.p_txt').find('p').remove();

                        var emailSubject = '';
                        if(data2.emailList[0].withdrawFlag=='0'){
//                            if(data2.subject == '【无主题 】' && data2.attachmentName != ''){
                            if(data2.subject.indexOf('【<fmt:message code="email.th.noSubject" /> 】') != -1 && data2.attachmentName != ''){
                                var qianzhui=data2.subject.replace('【<fmt:message code="email.th.noSubject" /> 】','');
                                var file=data2.attachment[0].attachName;
                                var filename=file.split('.');
                                emailSubject= qianzhui + filename[0] ;
                            }else {
                                emailSubject= data2.subject ;
                            }
//                            emailSubject =  data2.subject ;
                        }else{
                            emailSubject =  '<fmt:message code="email.th.theSenderHasRecalledTheMessage" />：'+data2.subject;
                        }

                        if(data2.copyName!=''){
                            if(data2.attachmentName!=''){
                                if(data2.emailList[0].withdrawFlag=='0') {
//                                    stra=attachmentShow_mail(arr);
                                    stra=attachView(arr,'','4','0','1','0');
                                }//<span><img src="../img/icon_read_3_07.png"/>'+dataUndefind(data2.toName)+'</span>
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+function () {
                                        var toUserName='';
                                        if(data2.toUserEmailInfo){
                                            for(var i=0;i<data2.toUserEmailInfo.length;i++){
                                                if(data2.toUserEmailInfo[i].readFlag == '1'){
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }else {
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }
                                            }
                                        }
                                        return toUserName;
                                    }()+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td>'+function () {
                                        var copyUserName='';
                                        for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                                            if(data2.copyUserEmailInfo[i].readFlag == '1'){
                                                copyUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>'
                                            }else {
                                                copyUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>'
                                            }
                                        }
                                        return copyUserName;
                                    }()+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                            }else{
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+function () {
                                        var toUserName='';
                                        if(data2.toUserEmailInfo){
                                            for(var i=0;i<data2.toUserEmailInfo.length;i++){
                                                if(data2.toUserEmailInfo[i].readFlag == '1'){
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }else {
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }
                                            }
                                        }
                                        return toUserName;
                                    }()+'</span></td></tr>' +
                                    '<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td>'+function () {
                                        var copyUserName='';
                                        for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                                            if(data2.copyUserEmailInfo[i].readFlag == '1'){
                                                copyUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>'
                                            }else {
                                                copyUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>'
                                            }
                                        }
                                        return copyUserName;
                                    }()+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                            }
                        }else{
                            if(data2.attachmentName!=''){
                                if(data2.emailList[0].withdrawFlag=='0') {
                                    stra=attachView(arr,'','4','0','1','0');
                                }
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+function () {
                                        var toUserName='';
                                        if(data2.toUserEmailInfo){
                                            for(var i=0;i<data2.toUserEmailInfo.length;i++){
                                                if(data2.toUserEmailInfo[i].readFlag == '1'){
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }else {
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }
                                            }
                                        }
                                        return toUserName;
                                    }()+'</span></td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                            }else{
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+function () {
                                        var toUserName='';
                                        if(data2.toUserEmailInfo){
                                            for(var i=0;i<data2.toUserEmailInfo.length;i++){
                                                if(data2.toUserEmailInfo[i].readFlag == '1'){
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }else {
                                                    toUserName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.toUserEmailInfo[i].userName+'</span>'
                                                }
                                            }
                                        }
                                        return toUserName;
                                    }()+'</span></td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                            }
                        }
                        $('.Table').append(str);
                        var content = '';
                        if(data2.emailList[0].withdrawFlag=='0'){
//                        content = data2.content;
                            var contentMsg = data2.content;
                            if(contentMsg.indexOf('iframe') > -1){
                                var cm = $('<div>'+contentMsg.toString()+'</div>');
                                cm.find('iframe').remove();
                                contentMsg = cm.html();
                            }
                            content =contentMsg;
                        }else{
                            content = '<fmt:message code="notice.th.withdrawn" />。';
                        }
                        $('.p_txt').append('<p>'+content+'</p>');

                        $('.userName').text(data2.users.userName);
                        $('.userDept').text(data2.deptName);


                        $('.divImg img').attr('src', function () {
                            if (data2.users.avatar == 0) {
                                return '/img/email/icon_boy.png';
                            }
                            else if (data2.users.avatar == 1) {
                                return '/img/email/icon_girl.png';
                            } else {
                                return '/img/user/' + data2.users.avatar;
                            }
                        }());
                        $('.divImg img').attr('onerror','imgerrorSpecial(this,1)')
                    }
                })
            }else{
                var dataBox;
                if(TYPE == 'outBox'){
                    dataBox={'bodyId':id,flag:'',copyTime:copyTime}
                }else{
                    dataBox={'emailId':id,flag:'isRead',copyTime:copyTime}
                }
                $.ajax({
                    type:'get',
                    url:'queryByID',
                    dataType:'json',
                    data:dataBox,
                    success:function(rsp){
                        var data2=rsp.object;
                        var sendTime=new Date((data2.sendTime)*1000).Format('yyyy-MM-dd hh:mm');
                        var str='';
                        var stra='';
                        var arr=new Array();
//                        arr=data2.attachmentName.split('*');
                        arr=data2.attachment;
                        $('.p_txt').find('p').remove();

                        var emailSubject = '';
                        if(data2.emailList[0].withdrawFlag=='0'){
//                            if(data2.subject == '【无主题 】' && data2.attachmentName != ''){
                            if(data2.subject.indexOf('【<fmt:message code="email.th.noSubject" /> 】') != -1 && data2.attachmentName != ''){
                                var qianzhui=data2.subject.replace('【<fmt:message code="email.th.noSubject" /> 】','');
                                var file=data2.attachment[0].attachName;
                                var filename=file.split('.');
                                emailSubject=qianzhui + filename[0] ;
                            }else {
                                emailSubject= data2.subject ;
                            }
//                            emailSubject =  data2.subject ;
                        }else{
                            emailSubject =  '<fmt:message code="email.th.theSenderHasRecalledTheMessage" />：'+data2.subject;
                        }
                        var dataToName='';
                        if(data2.toUserEmailInfo != undefined){
                            for(var i=0;i<data2.toUserEmailInfo.length;i++){
                                if(data2.toUserEmailInfo[i].readFlag == '1'){
                                    dataToName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.toUserEmailInfo[i].userName+'</span>';
                                }else{
                                    dataToName+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.toUserEmailInfo[i].userName+'</span>';
                                }

                            }
                        }
//                        if(TYPE == 'outBox'){
//                            dataToName=dataUndefind(data2.toName);
//                        }else{
//                            dataToName=dataUndefind(data2.emailList[0].toName);
//                        }

                        if(data2.copyUserEmailInfo){
                            if(data2.attachmentName!=''){
                                if(data2.emailList[0].withdrawFlag=='0') {
                                    stra=attachView(arr,'','4','0','1','0');
                                }
                                var copyNameStr='';
                                for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                                    if(data2.copyUserEmailInfo[i].readFlag == '1'){
                                        copyNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>';
                                    }else{
                                        copyNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>';
                                    }
                                }
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    <%--'<tr><td><fmt:message code="email.th.recipients" />：</td><td><span><img src="../img/icon_read_3_07.png"/>'+dataToName+'</span></td></tr>' +--%>
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+dataToName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td>'+copyNameStr+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                            }else{
                                var copyNameStr='';
                                for(var i=0;i<data2.copyUserEmailInfo.length;i++){
                                    if(data2.copyUserEmailInfo[i].readFlag == '1'){
                                        copyNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>';
                                    }else{
                                        copyNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.copyUserEmailInfo[i].userName+'</span>';
                                    }
                                }
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    <%--'<tr><td><fmt:message code="email.th.recipients" />：</td><td><span><img src="../img/icon_read_3_07.png"/>'+dataToName+'</span></td></tr>' +--%>
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+dataToName+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.carbonCopyRecipients" />：</td><td>'+copyNameStr+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                            }
                        }else{
                            if(data2.attachmentName!=''){
                                if(data2.emailList[0].withdrawFlag=='0') {
                                    stra=attachView(arr,'','4','0','1','0');
                                }
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    <%--'<tr><td><fmt:message code="email.th.recipients" />：</td><td><span><img src="../img/icon_read_3_07.png"/>'+dataToName+'</span></td></tr>' +--%>
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+dataToName+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.file" />：</td><td class="attachment">'+stra+'</td></tr>';
                            }else{
                                <%--str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td>'+data2.subject+'</td></tr>' +--%>
                                str='<tr><td width="100"><fmt:message code="email.th.main" />：</td><td style="font-weight:bold;">'+emailSubject+'</td></tr>' +
                                    '<tr><td><fmt:message code="email.th.sender" />：</td><td>'+data2.users.userName+'</td></tr>' +
                                    <%--'<tr><td><fmt:message code="email.th.recipients" />：</td><td><span><img src="../img/icon_read_3_07.png"/>'+dataToName+'</span></td></tr>' +--%>
                                    '<tr><td><fmt:message code="email.th.recipients" />：</td><td>'+dataToName+'</td></tr>' +function () {
                                        if(data2.sercUserEmailInfo){
                                            var sercNameStr='';
                                            for(var j=0;j<data2.sercUserEmailInfo.length;j++){
                                                if(data2.sercUserEmailInfo[j].readFlag == '1'){
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_read_3_07.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }else{
                                                    sercNameStr+='<span style="margin-right: 5px;"><img style="vertical-align: middle;margin-top: -5px;" src="../img/icon_notread_1_03.png"/>'+data2.sercUserEmailInfo[j].userName+'</span>';
                                                }
                                            }
                                            return '<tr><td><fmt:message code="email.th.BlindPeople" />：</td><td>'+sercNameStr+'</td></tr>'
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '<tr><td><fmt:message code="email.th.time" />：</td><td>'+sendTime+'</td></tr>';
                            }
                        }
                        $('.Table').append(str);
                        var content = '';
                        if(data2.emailList[0].withdrawFlag=='0'){
//                        content = data2.content;
                            var contentMsg = data2.content;
                            if(contentMsg.indexOf('iframe') > -1){
                                var cm = $('<div>'+contentMsg.toString()+'</div>');
                                cm.find('iframe').remove();
                                contentMsg = cm.html();
                            }
                            content =contentMsg;
                        }else{
                            content = '<fmt:message code="notice.th.withdrawn" />。';
                        }
                        $('.p_txt').append('<p>'+content+'</p>');
                        $('.imgfileBox').css("margin-left","25px")
                        $('.imgfileBox').append('<ul class="hoverbox"><li class="hoverboxLiConsult"><span class="plotting">></span><fmt:message code="document.th.ReferTo" /></li><li class="hoverboxLiDownload"><span class="plotting">></span><fmt:message code="file.th.download" /></li></ul>')
                        $('.imgfileBox').mouseover(function () {
                            $(this).children('.hoverbox').show()
                        });
                        $('.imgfileBox').mouseout(function () {
                            $(this).children('.hoverbox').hide()
                        });
                        $('.imgfileBox').on('click','.hoverboxLiDownload',function(){
                            var atturl=$(this).parents('.imgfileBox').find('img').attr('atturl')
                            if(atturl==''|| atturl==undefined) {
                                window.open("/download?"+encodeURI($(this).parents('.imgfileBox').find('img').attr('src')));
                            }else{
                                window.location.href="/download?"+encodeURI(atturl);
                            }
                        })
                        $('.imgfileBox').on('click','.hoverboxLiConsult',function(){
                            var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                            var fileURl=$(this).parents('.imgfileBox').find('span').attr('title')
                            var fileExtension=fileURl.substring(fileURl.lastIndexOf(".")+1,fileURl.length);//截取附件文件后缀
                            pdurl(fileExtension,str);
                        });

                        $('.userName').text(data2.users.userName);
                        $('.userDept').text(dataUndefind(data2.deptName));

                        $('.divImg img').attr('src', function () {
                            if (data2.users.avatar == 0) {
                                return '/img/email/icon_boy.png';
                            }
                            else if (data2.users.avatar == 1) {
                                return '/img/email/icon_girl.png';
                            } else {
                                return '/img/user/' + data2.users.avatar;
                            }
                        }());
                        $('.divImg img').attr('onerror','imgerrorSpecial(this,1)')

                    }
                });
            }

//            回复
            $('#replay').on('click',function () {
                $.popWindow('writeMailDetail?sId=' + id + '&type=0&flag='+flag, '<fmt:message code="global.lang.reply" />', '0', '0', '1200px', '600px');
            })
//            回复全部
            $('#replayAll').on('click',function () {
                $.popWindow('writeMailDetail?sId=' + id + '&type=1&flag='+flag, '<fmt:message code="global.lang.reply" />', '0', '0', '1200px', '600px');
            })
//            转发
            $('#forward').on('click',function () {
                $.popWindow('writeMailDetail?sId=' + id + '&type=2&boxType=inbox&flag='+flag, '<fmt:message code="email.th.transmit" />', '0', '0', '1200px', '600px');
            })

        }) ;
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.divBtn').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;"> 机密级★ </p>')
                    }
                }
            }
        })
        function dataUndefind(data) {
            if(data == undefined){
                return '';
            }else {
                return data;
            }
        }
        function downloads(that) {
            window.open($(that).attr('data-url'))
        }
        function yd(e){
            var atturl = e.attr('attrurl');
            $.pdurl($.UrlGetRequest('?'+atturl),atturl);
        }
        function closePage() {
            window.close();
        }
        // $('.operationImg').click(function(){
            $(document).on("click", ".operationImg", function (e) {
            // $(document).on('click','.operationImg',function () {
            var thisa = $(this).next().attr('openimg')
            var openNmu = $(this).next().attr('openNmu')
            var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
            $('.divBtn').append(str3)
            $('#getIndex').val(thisa)
            console.log(openNmu)
            event.stopPropagation()
            window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
            // layer.open({
            //     title:'图片',
            //     type: 2,
            //     shadeClose: true,
            //     shade: 0.5,
            //     maxmin: true, //开启最大化最小化按钮
            //     area: ['100%', '100%'],
            //     content: '/email/imgOpen',
            //     success: function () {
            //
            //     }
            // });
        })
    </script>
</head>
<body>
<div class="detailsContent">
    <div class="divBtn">
        <div id="replay"><img src="/img/commonTheme/theme6/icon_replay_03.png" class="im"><fmt:message code="global.lang.reply" /></div>
        <div id="replayAll"><img src="/img/commonTheme/theme6/icon_replayAll.png" class="im"><fmt:message code="email.th.replyall" /></div>
        <div id="forward"><img src="/img/commonTheme/theme6/icon_transmit_06.png" class="im"><fmt:message code="email.th.transmit" /></div>
        <div style="float: right;" onclick="closePage()"><img src="/img/email/icon_closed.png" class="im"><fmt:message code="global.lang.close" /></div>
    </div>
    <table class="Table"  cellspacing="0" cellpadding="0">

    </table>
    <div class="mainRight">
        <div class="divImg">
            <img src="../img/crm.png" alt="<fmt:message code="chat.th.photo" />" style="border-radius: 55px">
        </div>
        <div class="userInfo">
            <p class="userName"></p>
            <p class="userDept" style="margin-top: 5px;"></p>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div class="p_txt">

    </div>
</div>
</body>
</html>
