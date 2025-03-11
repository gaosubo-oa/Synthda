<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/9/25
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>即会通视频会议审批</title>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200715.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js?0923" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    #header{
        background-color: #3984ff;
        box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
    }
    #header a{
        color: #fff;
    }
    #header h1{
        color: #fff;
    }
    .ulli{
        margin: 6px 20px;
        border-bottom: 1px solid #c8c7cc;
        height: 60px;
        line-height: 58px;
    }

    .ulli input{
        width: 70%;
        margin-left: 2%;
        height: 30px;
        margin-top: 22px;
        border: none;
    }
    .nav{
        height: 31px;
        line-height: 28px;
        border: 1px solid #e1dddd;
        border-radius: 10px;
        width: 66%;
        margin-top: 13px;
        margin-right: 27px;
    }
    .nav span{
        width: 48%;
        display: inline-block;
        text-align: center;
    }
    .navc{
        background-color: #00a0e9;
        color: #fff;
        border-radius: 10px;
    }
    .fl{
        float: left;
    }
    .fr{
        float: right;
    }
    .spanc{
        background-color: #00a0e9;
        width: 40px;
        display: inline-block;
        text-align: center;
        height: 22px;
        line-height: 21px;
        border-radius: 6px;
        color: #fff;
    }
    #yspan{
        padding: 4px 10px;
        background-color: #00a0e9;
        color: #fff;
        border-radius: 5px;
        margin-left: 14px;
    }
    .result,.result1{
        color:#00a0e9;
        padding-left: 17px;
    }
    .textareaRen{
        width: 48% !important;
    }
    .add{
        color: red;
    }
    .clear{
        color: #2b7fe0;
    }
    button{
        color: white;
        font-size: 18px;
    }
</style>
<body>
<body>
<div class="box">
    <header data-role="header" class="mui-bar mui-bar-nav" id="header">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" onclick="back()"></a>
        <h1 class="mui-title" id="mtitle" style="font-size: 18px">视频会议审批</h1>
        <button href="javascript:;" id="addes" class="mui-pull-right " style="padding-top: 11px;padding-right: 0px;background: #3984ff;border: 1px solid #3984ff;" onclick="deleteone1()" >批准</button>
        <button href="javascript:;" id="add1" class="mui-pull-right " style="padding-top: 11px;padding-right: 10px;background: #3984ff;    border: 1px solid #3984ff;" onclick="deleteone2()">不批准</button>
    </header>
    <div class="mui-content" style="overflow: auto;">
        <ul>
            <li class="ulli">会议地点：<input class="meetAddress"></li>
            <li class="ulli">最大用户数：<input class="maxUser" id="maxUser" type="number"  ></li>
            <li class="ulli">会议名称：<input type="text" name="meetName"></li>
            <li class="ulli">会议密码：<input class="roomPwd" name="roomPwd" type="text"></li>
            <li class="ulli">会议时间：<input style="width: 30%;"  name="startTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">到
                <input style="width: 30%;"  name="endTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
            </li>

            <li class="ulli ">会议主持人：
                <input id="hostUserId" class="textareaRen" disabled type="text" placeholder="请选择会议主持人">
                <a href="javascript:;" id="hostUser" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </li>
            <li class="ulli">会议纪要员：
                <input id="summaryUserId" class="textareaRen" disabled type="text" placeholder="请选择会议纪要员">
                <a href="javascript:;" id="summaryUser" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </li>
            <li class="ulli" style="height: 50px;">参会人员：
                <div class="inPole" style=" display: inline-block;position: relative;    top: 10px;">
                    <textarea name="txt" class="textareaRen"  id="userIds" user_id='' placeholder="请选择参会人员" style="min-width: 50%;border: none" value="" disabled></textarea>
                    <a href="javascript:;" id="user" class="add">添加</a>
                    <a href="javascript:;" class="clear">清除</a>
                </div>
            </li>
            <li class="ulli" style="height: 50px;">查看范围（部门）：
                <div class="inPole" style=" display: inline-block;  width: 56%;position: relative;  top: 10px;">
                    <textarea name="txt" id="deptId" class="textareaRen" user_id='' placeholder="请选择查看范围" style="min-width: 60%; border: none"  value="" disabled ></textarea>
                    <a href="javascript:;" id="dept" class="add">添加</a>
                    <a href="javascript:;" class="clear">清除</a>
                </div>
            </li>
            <li class="ulli">提醒参会人员：
                <div class="news_t" style="display: inline-block;    width: 60%;">
                    <input type="checkbox" name="isAttend " class="textareaRen" num="1" style="    width: 20px !important;position: relative;top: 7px;" placeholder="请选择提醒参会人员">
                    <span class="remind_msg">发送事务提示信息</span>
                </div>
            </li>
            <li class="ulli">审批人：
                <input id="managerId" class="textareaRen" disabled type="text" placeholder="请选择审批人">
                <a href="javascript:;" id="manager" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </li>
            <li class="ulli">是否是一次性会议：
                <div class="news_t" style="display: inline-block; width: 60%;">
                    <input type="checkbox" name="roomTimeLimit" num="1" style="    width: 20px !important;position: relative;top: 7px;">
                    <span class="remind_msg">一次性</span>
                </div>
            </li>

            <textarea name="meetDesc" id="cont"   placeholder="输入日程内容" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
        </ul>

    </div>
</div>
</body>
</body>
</html>
<script>
    // function back(){
    //     Android.onback();
    // }
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var usid = getQueryString("usid");
    var meetingId = getQueryString("meetingId");

    edit(meetingId,usid)
    function deleteone1(){
        deleteone(meetingId,2)
    }

    function deleteone2(){
        deleteone(meetingId,5)
    }
    // readonly =“readonly”



    function edit(id,num) {
        $('input').attr('readonly','readonly')
        $('.saveBtn').attr('edit',id).css('visibility','');
        $('#uploadimgform').attr('action','/upload?module=jhtmeeting');
        $('.add,.clear').show();
        $('#newClass').hide()
        if(num=='1'){
            $('.add,.clear').hide()
            $('#uploadimgform').attr('action','')
            $('.saveBtn').css('visibility','hidden');
        }
        $.ajax({
            url: '/JHTMeeting/findByMeetingId',
            type: 'get',
            dataType: 'json',
            data: {meetingId: id},
            success: function (res) {
                $('.main').hide();
                $('.mainAdd').show();
                var data = res.object;
                $('[name="roomPwd"]').val(data.roomPwd)
                $('.saveBtn').attr('roomId',data.roomId)
                $('#hostUserId').attr('user_id', data.hostUserId).val(data.hostUserName);
                $('#userIds').attr('user_id', data.userIds).val(data.userIdNames);
                $('#summaryUserId').attr('user_id', data.summaryUserId).val(data.summaryUserName);
                $('#deptId').attr('deptid', data.deptId).val(data.deptName);
                $('[name="meetName"]').val(data.meetName);
                $('#managerId').attr('user_id', data.managerId).val(data.managerName);
                $('.maxUser').val(data.maxUser);
                $('.meetAddress').val(data.meetAddress);
                $('[name="startTime"]').val(data.startTime);
                $('[name="endTime"]').val(data.endTime);
                $('[name="startTime"]').attr('title',data.startTime);
                $('[name="endTime"]').attr('title',data.endTime);
                if (data.isAttend == '1') {
                    $('[name="isAttend"]').prop("checked",true);
                }
                if (data.roomTimeLimit == '1') {
                    $('[name="roomTimeLimit"]').prop("checked",true);
                }
                // ue.ready(function () {
                //     ue.setContent(data.meetDesc);
                // })

                var attachment = data.attachmentList;
                var attachmentStr=''
                if(attachment!=undefined&&attachment!=''){
                    for (var j = 0; j < attachment.length; j++) {
                        attachmentStr += '<div class="dech" deUrl="' + attachment[j].attUrl + '"><a href="/download?' + attachment[j].attUrl + '" NAME="' + attachment[j].attachName + '*"><img style="width:16px;" src="/img/file/cabinet@.png"/>' + attachment[j].attachName + '</a><img class="deImgs" onclick="delImg($(this))" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachment[j].aid + '@' + attachment[j].ym + '_' + attachment[j].attachId + ',"></div>';
                    }
                    $('#files_txt').append().html(attachmentStr)
                }
            }
        })
    }



    // 批准
    function deleteone(id,num) {
        var title='确定批准该会议吗'
        if(num==5){
            title='确定不批准该会议吗'
        }
        layer.confirm(title, {
            btn: ['确定', '取消'], //按钮
            title: " 信息"
        }, function () {
            $.ajax({
                url: '/JHTMeeting/editJHTMeeting',
                type: 'post',
                dataType: 'json',
                data: {
                    meetingId: id,
                    meetStatus:num
                },
                success: function () {
                    layer.msg('操作成功', {icon: 6});
                    history.back(-1)
                    init();
                }
            })
        }, function () {
            layer.closeAll();
        })
    }
</script>
