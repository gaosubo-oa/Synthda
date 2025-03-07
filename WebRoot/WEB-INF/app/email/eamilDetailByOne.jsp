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
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 10pt;width: 100%;}
        .content{
            width: 80%;
            margin: 30px auto;
        }
        .mainCon table{
            width: 70%;
            float: left;
        }
        .mainCon table tr th{
            text-align: left;
            padding: 8px;
            color: #2F5C8F;
            font-size: 16px;
        }
        .mainCon table tr td{
            padding: 8px;
            font-size: 16px;
        }
        #appendTable tr td{
            text-align: left;
        }
        #appendTable tr td:first-of-type{
            width: 16%;
        }
        .mainRight{
            float: right;
            width: 29%;
        }
        .divImg{
            width: 100px;
            height:100px;
            margin: 20px auto;
            margin-bottom: 10px;
        }
        .divImg img{
            width: 100%;
        }
        .userInfo{
            width: 100%;
        }
        .userInfo p{
            width: 100%;
            height: 20px;
            line-height: 20px;
            text-align: center;
        }
        .article{
            padding-top: 10px;
            margin-top: 10px;
            border-top: #eee 1px solid;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var dataId=GetQueryString("dataId");
            $.ajax({
                type:'get',
                url:'/email/selectDetailById',
                dataType:'json',
                data:{bodyId:dataId},
                success:function(res){
                    var datas=res.object;
                    $('.subTh').html('');
                    $('.sendName').html('');
                    $('.todoName').html('');
                    $('.copyName').html('');
                    $('.dateTime').html('');
                    $('.userName').text('');
                    $('.userDept').text('');
                    $('.article').text('');

                    $('.subTh').html(datas.subject);
                    $('.sendName').html(datas.users.userName);
                    $('.todoName').html(datas.toName);
                    $('.copyName').html(datas.copyName);
                    $('.dateTime').html(datas.sendTimes);
                    $('.userName').text(datas.users.userName);
                    $('.userDept').text(datas.deptName);
                    $('.article').html(datas.content);

                    $('.divImg img').attr('src', function () {
                        if (datas.users.avatar == 0) {
                            return '/img/user/boy.png';
                        }
                        else if (datas.users.avatar == 1) {
                            return '/img/user/girl.png';
                        } else {
                            return '/img/user/' + datas.users.avatar;
                        }
                    }());

                    var str='';
                    if(datas.attachmentList.length > 0){
                        for(var i=0;i<datas.attachmentList.length;i++){
                            str='<div class="dech" deUrl="'+datas.attachmentList[i].attUrl+'"><a href="/download?'+datas.attachmentList[i].attUrl+'" NAME="'+datas.attachmentList[i].attachName+'*" style="text-decoration:none;"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+datas.attachmentList[i].attachName+'</a><input type="hidden" class="inHidden" value="'+datas.attachmentList[i].aid+'@'+datas.attachmentList[i].ym+'_'+datas.attachmentList[i].attachId+',"></div>'
                        }
                    }
                    $('.attachName').append(str);
                }
            })

        })

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  unescape(r[2]); return null;
        }
    </script>
</head>
<body>
<div class="content">
    <div class="mainCon" style="">
        <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
            <thead>
            <tr>
                <th colspan="2" class="subTh"></th>
            </tr>
            </thead>
            <tbody id="appendTable">
                <tr>
                    <td><fmt:message code="email.th.sender" />：</td>
                    <td class="sendName"></td>
                </tr>
                <tr>
                    <td><fmt:message code="email.th.recipients" />：</td>
                    <td class="todoName"></td>
                </tr>
                <tr>
                    <td><fmt:message code="main.th.CC" />：</td>
                    <td class="copyName"></td>
                </tr>
                <tr>
                    <td><fmt:message code="email.th.time" />：</td>
                    <td class="dateTime"></td>
                </tr>
                <tr>
                    <td><fmt:message code="email.th.file" />：</td>
                    <td class="attachName"></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="mainRight">
        <div class="divImg">
            <img src="../img/crm.png" alt="<fmt:message code="chat.th.photo" />">
        </div>
        <div class="userInfo">
            <p class="userName"></p>
            <p class="userDept"></p>
        </div>
    </div>
    <div style="clear: both"></div>
    <div class="article">

    </div>
</div>
</body>
</html>
