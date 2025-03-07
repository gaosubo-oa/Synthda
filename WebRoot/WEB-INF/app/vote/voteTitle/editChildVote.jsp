<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../../lib/ueditor/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.Modifiedvoting" /></title>
    <style>
        table{
            margin-top:2%;
        }
        .BigButton{
            width: 132px;
            height: 35px;
            background-color: rgba(224, 224, 224, 0.61);
            font-size: 16px;
            border-radius: 5px;
        }
        #return {
            display: inline-block;
            width: 78px;
            height: 38px;
            line-height: 30px;
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/edu/eduSchoolCalendar/back.png) no-repeat;
            padding-left: 7px;
            font-size: 14px;
            display: inline-block;
        }
        #clearSave{
            background:url(../../img/vote/clearsave.png) no-repeat;
            color:#fff;
            width:181px;
            font-size:16px;
            height:30px;
            cursor: pointer;
            line-height:30px;
            display: inline-block;
        }
        #save{
            background:url(../../img/vote/saveBlue.png) no-repeat;
            color:#fff;
            line-height:30px;
            font-size:16px;
            width:91px;
            height: 30px;
            cursor: pointer;
            display: inline-block;

        }
        #refulling{
            color:#000;
            width: 87px;
            line-height:30px;
            height: 30px;
            cursor: pointer;
            font-size:16px;
            background: url("../../img/vote/new.png") no-repeat;
            display: inline-block;
        }
    </style>
</head>
<body class="bodycolor" onLoad="javascript:form1.SUBJECT.focus();">
<div>
    <div class="Big"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png" align="absmiddle" style="width: 30px;margin-top: 15px; margin-left: 50px;"></div>
    <div class="BIG" class="big3" style="margin-left: 90px; font-size: 24px;margin-top: -23px;"><fmt:message code="vote.th.Modifiedvoting" /></div>
</div>

<form enctype="multipart/form-data" action="add.php"  method="post" name="form1">
    <table class="TableBlock" width="70%" align="center">
        <tr>
            <td nowrap class="TableData"><fmt:message code="notice.th.title" />：</td>
            <td class="TableData">
                <input type="text" id="SUBJECT" size="42" maxlength="100" style="width: 200px;" class="BigInput" value=""><span style="color: red">(*)</span>
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="vote.th.VotingDescription" />：</td>
            <td class="TableData">
                <textarea id="CONTENT" class="BigInput" cols="50" rows="3"></textarea>
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"><fmt:message code="file.th.Sort" />：</td>
            <td class="TableData">
                <input type="text" id="VOTE_NO" size="10" maxlength="20" style="width: 105px;" class="BigInput" value="">
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData"> <fmt:message code="notice.th.type" />：</td>
            <td class="TableData">
                <select id="TYPE" class="BigSelect" onChange="change_type();">
                    <option value="0" selected><fmt:message code="vote.th.Radio" /></option>
                    <option value="1" ><fmt:message code="vote.th.Multiselect" /></option>
                    <option value="2" ><fmt:message code="vote.th.TextEntry" /></option>
                </select>
                <span id="MAX_NUM_DESC" style="display:none"><fmt:message code="vote.th.MostOptions" /><input type='input' name='MAX_NUM' id='MAX_NUM' value='3' size='2' class='SmallInput'><fmt:message code="vote.th.term" />，&nbsp;<fmt:message code="vote.th.LeastSelection" /><input type='input' name='MIN_NUM' id='MIN_NUM' value='2' size='2' class='SmallInput'><fmt:message code="vote.th.term" />，<fmt:message code="vote.th.limited" /></span>
            </td>
        </tr>
        <tr align="center" class="TableControl">
            <td colspan="2" nowrap>
                <input type="hidden" name="VOTE_ID" value="">
                <input type="hidden" name="VOTE_COUNT_CLEAR" value="1">
                <input type="hidden" name="start" value="0">
                <input type="hidden" name="PARENT_ID" value="19">
                <input type="hidden" name="PUBLISH" value="">
                <input type="hidden" name="OP" value="">
                <input type="hidden" name="ATTACHMENT_ID_OLD" value="">
                <input type="hidden" name="ATTACHMENT_NAME_OLD" value="">
                <span id="clearSave"><fmt:message code="vote.th.DataEmpty" /></span>
                <span id="save"><fmt:message code="global.lang.save" /></span>
                <span id="refulling"><fmt:message code="global.lang.refillings" /></span>
                <span id="return"><fmt:message code="notice.th.return" /></span>
            </td>
        </tr>
    </table>
</form>
<script>
    $(function (reg) {
        var uid=$.GetRequest().childId;
//        根据id数据返现
        $.ajax({
            url:'/vote/manage/getChildDetail',
            type:'get',
            dataType:'json',
            data:{voteId:uid},
            success:function(reg){
                var data=reg.object;
                console.log(reg)
                $('#SUBJECT').val(data.subject);
                $('#CONTENT').val(data.content);
                $('#VOTE_NO').val(data.voteNo);
                $('#TYPE').val(data.type);
            }
        })
//        点击修改保存
        $('#save').on('click',function () {
            var data={
                //投票信息
                subject:$('#SUBJECT').val(),
                content:$('#CONTENT').val(),
                voteNo:$('#VOTE_NO').val(),
                type:$('#TYPE').val(),
                voteId:uid,
            }
            if($('#SUBJECT').val().replace(/(^\s*)|(\s*$)/g, "")==""){
                $.layerMsg({content: '<fmt:message code="event.th.titleCannotEmpty" />', icon: 2});
            }else{
                $.ajax({
                    type: 'post',
                    url: '/vote/manage/updateVoteTitle',
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                            init();
                        } else {
                            $.layerMsg({content: '<fmt:message code="depatement.th.modifyfailed" />！', icon: 2});
                        }
                    }
                })
            }

        })
//      点击清空并保存
        $('#clearSave').on('click',function () {
            var data={
                //投票信息
                subject:$('#SUBJECT').val(),
                content:$('#CONTENT').val(),
                voteNo:$('#VOTE_NO').val(),
                type:$('#type').val(),
                voteId:uid,
            }
            if($('#SUBJECT').val().replace(/(^\s*)|(\s*$)/g, "")==""){
                $.layerMsg({content: '<fmt:message code="event.th.titleCannotEmpty" />', icon: 2});
            }else{
                $.ajax({
                    type: 'post',
                    url: '/vote/manage/updateVoteTitle',
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                            $('#SUBJECT').val('');
                            $('#CONTENT').val('');
                            $('#VOTE_NO').val('');
                            $('#type').val('');
                            init();
                        } else {
                            $.layerMsg({content: '<fmt:message code="depatement.th.modifyfailed" />！', icon: 2});
                        }
                    }
                })
            }

        })

//     点击重填
        $('#refulling').on('click',function () {
            $('#SUBJECT').val('');
            $('#CONTENT').val('');
            $('#VOTE_NO').val('');
            $('#TYPE').val('');
        })

        //点击返回跳转到管理投票列表
        $('#return').on('click',function () {
            self.parent.document.getElementById("iframe").src='/vote/manage/voteChild';
        })
    })
</script>
</body>
</html>