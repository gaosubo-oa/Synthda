<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>即会通视频会议</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/room.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
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
<%--    <script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>--%>
    <script src="../lib/pagination/js/jquery.pagination.min.js?0923" type="text/javascript" charset="utf-8"></script>

    <style>
        .table .span_td {
            margin: 0;
        }

        .equip tbody td {
            text-align: center;
        }

        .equipSpan {
            background-color: #00a2d4;
        }

        .equip {
            width: 77%;
            margin: 20px auto;
        }

        .jump-ipt {
            float: left;
            width: 30px;
            height: 30px;
        }

        .M-box3 .active {
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color: #fff;
            text-align: center;
            display: inline-block;
        }

        .M-box3 a {
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align: center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }

        /*导航栏*/
        .header {
            width: 100%;
            height: 45px;
            border-bottom: 1px solid #9E9E9E;
        }

        .nav {
            overflow: hidden;
        }

        .nav li {
            height: 28px;
            line-height: 28px;
            float: left;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 6px;
            cursor: pointer;
        }

        .select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 20px;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            -o-border-radius: 20px;;
            -ms-border-radius: 20px;
        }

        .pad {
            padding: 0px 15px;
            line-height: 23px;
            display: inline-block;
        }

        .space {
            width: 2px;
            margin-left: 16px;
            vertical-align: middle;
        }

        .headTop {
            position: absolute;
            top: 0;
            left: 0;
        }

        .saveBtn {
            display: block;
            float: left;
            background: url(../img/confirm.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }

        .resetBtn {
            display: block;
            float: left;
            background: url(../img/news/new_filling.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }

        .mainAdd input, select {
            width: 200px;
            border-radius: 5px;
            height: 30px;
        }

        .mainAdd table tr {
            height: 60px;
        }

        .inPole {
            display: inline-block;
            width: 400px;
            height: 100px;
        }

        textarea {
            min-width: 70%;
            height: 80%;
            margin: 10px;
        }

        .remind_msg {
            vertical-align: text-bottom;
        }

        .clear {
            color: red;
        }

        .table tr td:first-of-type {
            text-align: left;
            padding-left: 10px;
        }

        b {
            color: red;
        }

        .bar {
            height: 18px;
            background: green;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="font-family: 微软雅黑;">
<div class="header">
    <ul class="nav">
        <li>
            <span class="select pad">我申请的</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li style="margin-top: 9px;">
            <span class="pad">我参与的</span>
        </li>
    </ul>
</div>
<div class="headTop" style="margin-top: 50px">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRoom.png" alt="">
    </div>
    <div class="divTitle">
        即会通视频会议
    </div>
    <div class="newClass" id="newClass" style="padding: 0 10px; border-radius: 20px; text-align: center;">
        <span><img style="margin-right: 4px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png"
                   alt="">申请会议</span>
    </div>
</div>
<div class="main" style="margin-top: 80px;overflow-y: auto;">
    <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
        <table>
            <thead>
            <tr>
                <th style="text-align: center" width="5%"><%--<fmt:message code="hr.th.number" />--%></th>
                <th><fmt:message code="meet.th.ConferenceRoomName"/></th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>会议地点</th>
                <th>会议ID</th>
                <th>会议密码</th>
                <th>主持人信息</th>
                <th>状态</th>
                <th style="width: 250px;"><fmt:message code="notice.th.operation"/></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

        </div>
    </div>
</div>
<div class="mainAdd" style="margin-top: 40px;display: none;margin-bottom: 46px;border: 1px solid #F6F7F9">
    <table class="TABLE" border="1" cellspacing="0" cellpadding="0"
           style="border-collapse: collapse;margin-bottom: 20px;margin-top: 30px">
        <tbody>
        <tr class="append_tr">
            <td width="28%"style="padding-left: 10px">会议地点:</td>
            <td width="70%"><input class="meetAddress"></td>
            <td width="28%" style="padding-left: 10px;">最大用户数:</td>
            <td width="70%"><input class="maxUser" id="maxUser" type="number"  ></td>
<%--            <td><input type="text" value="10" placeholder="10"></td>--%>
        </tr>
        <tr>
            <td width="28%">会议名称:</td>
            <td width="70%"><input type="text" name="meetName"><b>*</b></td>
            <td width="28%" style="padding-left: 10px">会议密码:</td>
            <td width="70%"><input class="roomPwd" name="roomPwd" type="text"><b>*</b></td>
        </tr>
        <tr>
            <td style="padding-left: 10px" width="28%">会议时间:</td>
            <td colspan="3" width="70%"><input name="startTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                到<input name="endTime" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"><b>*</b>
            </td>
        </tr>
        <tr>
            <td  width="28%">会议主持人:</td>
            <td  width="70%">
                <input id="hostUserId" disabled type="text">
                <a href="javascript:;" id="hostUser" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </td>
            <td   width="28%"style="padding-left: 10px">会议纪要员:</td>
            <td  width="70%">
                <input id="summaryUserId" disabled type="text">
                <a href="javascript:;" id="summaryUser" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </td>
        </tr>
        <tr class="append_tr">
            <td  width="28%" style="padding-left: 10px;">参会人员：</td>
            <td  width="70%">
                <div class="inPole">
                    <textarea name="txt" id="userIds" user_id='' style="min-width: 50%;" value="" disabled></textarea>
                    <a href="javascript:;" id="user" class="add">添加</a>
                    <a href="javascript:;" class="clear">清除</a>
                </div>
            </td>
            <td  width="28%"style="padding-left: 10px;">查看范围（部门）:</td>
            <td  width="70%">
                <div class="inPole">
                    <textarea name="txt" id="deptId" user_id='' style="min-width: 50%;" value="" disabled></textarea>
                    <a href="javascript:;" id="dept" class="add">添加</a>
                    <a href="javascript:;" class="clear">清除</a>
                </div>
            </td>
        </tr>
        <tr style="display: none">
            <td  width="28%"style="padding-left: 10px;">提醒参会人员:</td>
            <td  width="70%"class="remind" colspan="3">
                <div class="news_t">
                    <input type="checkbox" name="isAttend" num="1">
                    <span class="remind_msg">发送事务提示信息</span>
                </div>
            </td>
            <%--<td style="padding-left: 10px;">提醒查看人员:</td>--%>
            <%--<td class="remind">--%>
            <%--<div class="news_t">--%>
            <%--<input type="checkbox" name="remind" class="remindCheck" value="0" checked>--%>
            <%--<span class="remind_msg">发送事务提示信息</span>--%>
            <%--</div>--%>
            <%--</td>--%>
        </tr>
        <tr>
            <td width="28%">审批人:</td>
            <td  width="70%" colspan="3">
                <input id="managerId" disabled type="text"><b>*</b>
                <a href="javascript:;" id="manager" class="add">添加</a>
                <a href="javascript:;" class="clear">清除</a>
            </td>
        </tr>
        <tr class="append_tr">
            <td width="28%" style="padding-left: 10px;">是否是一次性会议:</td>
            <td width="70%" colspan="3">
                <div class="news_t">
                    <%--<input type="checkbox" name="roomTimeLimit" value="0">--%>
                    <%--<span class="remind_msg">永久</span>--%>
                    <input type="checkbox" name="roomTimeLimit" num="1">
                    <span class="remind_msg">一次性</span>
                </div>
                </select>
            </td>
        </tr>

        <tr class="Attachment" style="width:100%; padding-left: 10px;">
            <td  width="28%">附件文档:</td>
            <td  width="70%" colspan="3" class="files" id="files_txt">
                <div id="fileContent"></div>
            </td>
        </tr>
        <tr>
            <td width="28%" style="padding-left: 10px;">附件选择:</td>
            <td width="70%" class="files" colspan="3" style="position: relative">
                <!-- 添加附件 -->
                <form id="uploadimgform" style="float: left;" target="uploadiframe" action="/upload?module=jhtmeeting"
                      method="post">
                    <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5"
                           style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                    <a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>附件上传</a>
                </form>

                <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 10px;">
                    <div class="bar" style="width: 0%;"></div>
                </div>
                <div class="barText" style="float: left;margin-left: 10px;"></div>
            </td>
        </tr>
        <tr>
            <td width="28%" style="padding-left: 10px;">
                <p>会议描述：</p>
                <!-- <p class="Color">计算字数：<span>0</span></p> -->
            </td>
            <td width="70%" colspan="3">
                <scrtpt id="container" style="width: 99.9%;min-height: 300px;" name="meetDesc"
                        type="text/plain"></scrtpt>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <div class="div_btn" style="width: 280px;margin: 5px auto;">
                    <div class="saveBtn"><span style="margin-left: 30px;">保存</span></div>
                    <div class="resetBtn"><span style="margin-left: 30px;">返回</span></div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<iframe id="attendMeetingIfr" width="0" height="0" src=""></iframe>
<script>
    $(function () {
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
            window.location.replace('/JHTMeeting/indexH5');
        }
    })
    $('.header').on('click', 'li', function () {
        $('.header span').removeClass('select');
        $(this).find('span').addClass('select');
        $('.mainAdd').hide();
        $('.main').show();
        if($(this).children('.pad').text()=="我申请的"){
            init(1)
        }else{
            init(2)
        }

    })
    //附件上传方法
    fileuploadFn('#uploadinputimg', $('.Attachment td').eq(1));
    //附件删除
    $('#files_txt').on('click', '.deImgs', function () {
        var data = $(this).parents('.dech').attr('deUrl');
        var dome = $(this).parents('.dech');
        deleteChatment(data, dome);
    })

    var dept_id = '';
    var user_id = '';
    var ue = UE.getEditor('container', {elementPathEnabled: false});
    UEimgfuc();
    $(function () {

        $.ajax({
            url: '/Meetequipment/getuser',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                $('#already').attr('name',res.object.userName)
            }
        })

        //初始化数据
        init(1);
        $("#hostUser").on("click", function () {
            user_id = 'hostUserId';
            $.popWindow("../common/selectUser?0");
        });
        $("#manager").on("click", function () {
            user_id = 'managerId';
            $.popWindow("../common/selectUser?0");
        });
        $("#summaryUser").on("click", function () {
            user_id = 'summaryUserId';
            $.popWindow("../common/selectUser?0");
        });
        $("#user").on("click", function () {
            user_id = 'userIds';
            $.popWindow("../common/selectUser");
        });
        $("#dept").on("click", function () {//选部门控件
            dept_id = 'deptId';
            $.popWindow("/common/selectDept");
        });
        $('.clear').click(function () { //清空人员
            $(this).siblings('textarea').attr('user_id', '').attr('dept_id', '').attr('userid', '').attr('deptid', '').val('');
            $(this).siblings('input').attr('user_id', '').attr('dept_id', '').attr('userid', '').attr('deptid', '').val('');
        });

    });
    $('.resetBtn').click(function () {
        $('.main,#newClass').show();
        $('.mainAdd').hide();
    })
    //点击新建分类
    $('#newClass').click(function (event) {
        $('.add,.clear').show();
        $('#newClass').hide()
        $('#uploadimgform').attr('action','/upload?module=jhtmeeting')
        $('.saveBtn').attr('edit','').css('visibility','');
        $('.main').hide();
        $('.mainAdd').show();
        $('input,select').val('').attr('user_id','');
        $('textarea').val('').attr('user_id','').attr('deptid','');
        $('.dech').remove();
        $('#maxUser').attr('value',10)
        ue.ready(function () {
            ue.setContent('');
        })
        $('[name="roomTimeLimit"],[name="isAttend"]').prop("checked",false);
    })

    function init(num) {
        $('#newClass').show()
        var str='&userId=1'
        if(num==2){
            str='&hostUserId=1&summaryUserId=1&userIds=1'
        }else{
            str='&userId=1'
        }
        $('.pagediv tbody tr').remove();
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true
                // totleNum:
            },
            page: function () {
                var me = this;
                $.ajax({
                    type: 'get',
                    url: '/JHTMeeting/findJHTMeeting?'+str,
                    dataType: 'json',
                    data:me.data,
                    // count:me.totleNum,
                    success: function (res) {
                        var data = res.obj;
                        var str = '';
                        if (data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                var hostUserName = ''
                                if(data[i].hostUserName == undefined){
                                    hostUserName = ''
                                }else {
                                    hostUserName = data[i].hostUserName
                                }
                                str += '<tr><td style="text-align: center"></td>' +
                                    '<td><a href="javascript:edit(' + data[i].meetingId + ',1);" class="meetRoomDetail"  meetRoomId="' + data[i].meetingId + '">' + data[i].meetName + '</a></td>' +
                                    '<td>' + data[i].startTime + '</td>' +
                                    '<td>' + function () {
                                        if (data[i].endTime == undefined) {
                                            return '';
                                        } else {
                                            return data[i].endTime
                                        }
                                    }() + '</td>' +
                                    '<td>' + function () {
                                        if (data[i].meetAddress == undefined) {
                                            return ''
                                        } else {
                                            return data[i].meetAddress
                                        }
                                    }() + '</td>' +
                                    '<td class = "roomId"  title="' + data[i].roomId + '" >' + data[i].roomId + '</td>' +
                                    '<td class = "roomPwd"  title="' + data[i].roomPwd + '">' + data[i].roomPwd + '</td>' +
                                    '<td class = "hostUserName"  title="' + hostUserName + '">' + hostUserName + '</td>' +
                                    '<td>' + function () {
                                        if (data[i].meetStatus == 1) {
                                            return '待批'
                                        } else if (data[i].meetStatus == 2) {
                                            return '已批准'
                                        } else if (data[i].meetStatus == 3) {
                                            return '进行中'
                                        } else if (data[i].meetStatus == 4) {
                                            return '未批准'
                                        } else if (data[i].meetStatus == 5) {
                                            return '已结束'
                                        } else if (data[i].meetStatus == undefined) {
                                            return ''
                                        }
                                    }() + '</td>' +
                                    '<td>'+function () {
                                            if(data[i].meetStatus == 2||data[i].meetStatus == 3){
                                                // return '<a class="join" href="javascript:join(' + data[i].roomId + ',' + data[i].roomPwd + ');">参加会议</a>&emsp;'
                                                return '<a class="join" style="cursor:pointer;"  onclick="attendMeeting(' + data[i].roomId + ',' + data[i].roomPwd + ')">参加会议</a>&emsp;'
                                            }else{
                                                return ''
                                            }
                                    }()+'<a href="javascript:edit(' + data[i].meetingId + ',1);">查看详情</a>&emsp;<a class="edit" href="javascript:edit(' + data[i].meetingId + ',0);"><fmt:message code="global.lang.edit" /></a>&emsp;<a class="delete" style="color:red" href="javascript:deleteone(' + data[i].meetingId + ','+data[i].roomId+');"><fmt:message code="global.lang.delete" /></a></td>';
                            }
                            $('.pagediv tbody').html(str);
                            $('.edit,.delete').show()
                            if(num==2){
                                $('.edit,.delete').hide()
                            }else{
                                $('.edit,.delete').show()
                            }
                            me.pageTwo(res.totleNum, me.data.pageSize, me.data.page)
                        }
                    }
                });

            },
            pageTwo: function (totalData, pageSize, indexs,totleNum) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    totleNum:totleNum,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: indexs || 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();
    }
    //删除附件
    function deleteChatment(data,element){
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
            ,offset:["100px",""]
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
//                                     var file = $('[name="file"]')
//                                     file.after(file.clone().val(""));
//                                     file.remove();
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
    //保存
    $('.saveBtn').click(function () {
        var starttime = $('input[name="startTime"]').val();
        var endtime = $('input[name="endTime"]').val();
        var start = new Date(starttime.replace("-", "/").replace("-", "/"));
        var end = new Date(endtime.replace("-", "/").replace("-", "/"));
       if ($('input[name="meetName"]').val() == '') {
           alert("请输入会议名称");
           return false;
        }else if ($('input[name="startTime"]').val()  == ''|| $('input[name="endTime"]').val() == '') {
           alert("请输入会议时间");
           return false;
        }else if($('input[name="roomPwd"]').val()== ''){
           alert("请输入会议密码");
           return false;
       }else if($('#managerId').val() == ''||$('#managerId').val() == null) {
           alert("请选择会议审批人");
           return false;
       }else if(end<start) {
           alert("会议结束日期不能早于开始日期");
           return false;
       }
        // console.log($('.maxUser').val())
        // var isAttend = 0
        // if ( $('input:checkbox[name="isAttend"]:checked').attr('num') == 1) {
        //     isAttend = 1
        // }
        var roomTimeLimit = 0
        if ( $('input:checkbox[name="roomTimeLimit"]:checked').attr('num') == 1) {
            roomTimeLimit = 1
        }
        var aId = '';
        var uId = '';
        var attach = $('.Attachment td').eq(1).find('a');
        for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
            aId += $('.Attachment td .inHidden').eq(i).val();
        }
        for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
            uId += attach.eq(i).attr('NAME');
        }
        var meetingId='';
        var url='/JHTMeeting/insertJHTMeeting';
        var roomId=0
        if($('.saveBtn').attr('edit')!=''){
            meetingId=$('.saveBtn').attr('edit');
            roomId=$('.saveBtn').attr('roomId')
            url='/JHTMeeting/editJHTMeeting'
        }
        var data = {
            meetingId:meetingId,
            roomPwd:$('[name="roomPwd"]').val(),
            hostUserId: $('#hostUserId').attr('user_id').split(",")[0],
            userIds: $('#userIds').attr('user_id'),
            summaryUserId: $('#summaryUserId').attr('user_id').split(",")[0],
            deptId: $('#deptId').attr('deptid'),
            meetName: $('[name="meetName"]').val(),
            managerId: $('#managerId').attr('user_id').split(",")[0],
            maxUser: $('.maxUser').val(),
            roomId: roomId,
            meetDesc: ue.getContent(),
            meetAddress: $('.meetAddress').val(),
            startTime: $('[name="startTime"]').val(),
            endTime: $('[name="endTime"]').val(),
            isAttend: 1,
            attachmentId: aId,
            attachmentName: uId,
            roomTimeLimit: roomTimeLimit,
            isop:'1'
        }
        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            data: data,
            success: function (data) {
                if (data.flag) {
                    layer.msg('保存成功！', {icon: 1}, function () {
                        $('.main').show();
                        $('.mainAdd').hide();
                        window.location.reload()
                        init()
                    });
                    /*添加成功*/
                } else {
                    layer.msg('保存失败！', {icon: 2});
                    /*添加失败*/
                }
            },
            error: function (data) {
                layer.msg('保存失败！', {icon: 2});
                /*添加失败*/
            }
        })
    })
    function deleteone(id,roomId) {
        layer.confirm(' 确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除"
        }, function () {
            $.ajax({
                url: '/JHTMeeting/delJHTMeeting',
                type: 'post',
                dataType: 'json',
                data: {
                    meetingId: id,
                    roomId:roomId
                },
                success: function () {
                    layer.msg(' 删除成功', {icon: 6});
                    init();
                }
            })
        }, function () {
            layer.closeAll();
        })
    }
    function edit(id,num) {
        $('.saveBtn').attr('edit',id).css('visibility','');
        $('#uploadimgform').attr('action','/upload?module=jhtmeeting');
        $('.add,.clear').show();
        $('#newClass').hide()
        if(num=='1') {
            $('.add,.clear').hide()
            $('#uploadimgform').attr('action', '')
            $('.saveBtn').css('visibility', 'hidden');
            $('.meetAddress').attr('disabled', 'disabled')
            $('.maxUser').attr('disabled', 'disabled')
            $("input[name='meetName']").attr('disabled', 'disabled')
            $('.roomPwd').attr('disabled', 'disabled')
            $("input[type='checkbox']").attr('disabled', 'disabled')
            $("input[name='startTime']").attr('disabled', 'disabled')
            $("input[name='endTime']").attr('disabled', 'disabled')
            $('#files_txt').attr('disabled', 'disabled')
            $("input[type='file']").attr('disabled', 'disabled')
        }else{
            $('.meetAddress').removeAttr('disabled','disabled')
            $('.maxUser').removeAttr('disabled','disabled')
            $("input[name='meetName']").removeAttr('disabled','disabled')
            $('.roomPwd').removeAttr('disabled','disabled')
            $("input[type='checkbox']").removeAttr('disabled','disabled')
            $("input[name='startTime']").removeAttr('disabled','disabled')
            $("input[name='endTime']").removeAttr('disabled','disabled')
            $('#files_txt').removeAttr('disabled','disabled')
            $("input[type='file']").removeAttr('disabled', 'disabled')
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
                ue.ready(function () {
                    ue.setContent(data.meetDesc);
                })
                $('.meetAddress').val(data.meetAddress);
                $('[name="startTime"]').val(data.startTime);
                $('[name="endTime"]').val(data.endTime);
                if (data.isAttend == '1') {
                    $('[name="isAttend"]').prop("checked",true);
                }
                if (data.roomTimeLimit == '1') {
                    $('[name="roomTimeLimit"]').prop("checked",true);
                }
                var attachment = data.attachmentList;
                var attachmentStr=''
                if(attachment!=undefined&&attachment!=''){
                    for (var j = 0; j < attachment.length; j++) {
                        if(num=='1') {
                            attachmentStr += '<div class="dech" deUrl="' + attachment[j].attUrl + '"><a href="/download?' + attachment[j].attUrl + '" NAME="' + attachment[j].attachName + '*"><img style="width:16px;" src="/img/file/cabinet@.png"/>' + attachment[j].attachName + '</a><input type="hidden" class="inHidden" value="' + attachment[j].aid + '@' + attachment[j].ym + '_' + attachment[j].attachId + ',"></div>';
                        }else{
                            attachmentStr += '<div class="dech" deUrl="' + attachment[j].attUrl + '"><a href="/download?' + attachment[j].attUrl + '" NAME="' + attachment[j].attachName + '*"><img style="width:16px;" src="/img/file/cabinet@.png"/>' + attachment[j].attachName + '</a><img class="deImgs"  onclick="deImgs()"style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachment[j].aid + '@' + attachment[j].ym + '_' + attachment[j].attachId + ',"></div>';
                              }
                        }
                     $('#files_txt').append().html(attachmentStr)
                }
            }
        })
    }
    function attendMeeting(roomid,classpwd) {
        var attendMeetingIfr = $('#attendMeetingIfr')

        $('#attendMeetingIfr').attr('src','/JHTMeeting/staVideo')

        var pwd=classpwd;
        if(classpwd=='0'){
            pwd='0000'
        }

        $.ajax({
            url: '/syspara/selectTheSysPara',
            type: 'get',
            dataType: 'json',
            data: {paraName:'WD_MEETING'},
            success: function (res) {
                var type=eval("(" + res.object[0].paraValue + ")")
                if(type.jhtType=='iactive'){
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {

                    } else if (/(Android)/i.test(navigator.userAgent)) {
                        Android.Instant('111.47.113.243',$('#already').attr('name'),'',roomid,pwd);
                    } else {
                        //私有云
                        // window.open('http://cloud.iactive.com.cn/startmeeting?SrvIP=111.47.113.243&app=1&auto=1&AnonymousUser=1&UserName='+$('#already').attr('name')+'&RoomID='+roomid+'&ClassPwd='+pwd+'');
                        var urlVideo = 'http://cloud.iactive.com.cn/startmeeting?SrvIP=111.47.113.243&app=1&auto=1&AnonymousUser=1&UserName='+$('#already').attr('name')+'&RoomID='+roomid+'&ClassPwd='+pwd+''
                        var urlVideoSi = replaceInfo(urlVideo)
                        attendMeetingIfr.attr('urlVid',urlVideoSi)
                    }

                }else if(type.jhtType=='liveuc'){
                    //公有云
                    // window.open('http://mware.liveuc.net/ameeting?app=imm&isanyuser=1&nickname='+$('#already').attr('name')+'&roomid='+roomid+'&classpwd='+pwd+'');
                    var siVideo = 'http://mware.liveuc.net/ameeting?app=imm&isanyuser=1&nickname='+$('#already').attr('name')+'&roomid='+roomid+'&classpwd='+pwd+''
                    var gongsiVideo = replaceInfo (siVideo)
                    attendMeetingIfr.attr('urlVid',gongsiVideo)
                }
            }
        })

    }
    function replaceAll (str, oldSubStr, newSubStr)
    {
        var ret = "";
        if (str != null && oldSubStr!= null && newSubStr!= null)
        {
            ret = str.replace(new RegExp(oldSubStr, 'gm'), newSubStr);
        }
        return ret;
    }
    function replaceInfo(url)
    {
        var roomid = $('.roomId').attr('title'); //会议id
        var nickname = $('.roomPwd').attr('title'); //主持人信息
        var classpwd = $('.hostUserName').attr('title');  //会议密码

        var ret = url;
        ret = replaceAll(ret, "IACTIVEROOMID", roomid);
        ret = replaceAll(ret, "IACTIVENICKNAME", encodeURIComponent(nickname));
        ret = replaceAll(ret, "IACTIVECLASSPWD", encodeURIComponent(classpwd));

        return ret;
        // $('#attendMeetingIfr').attr('urlVid',ret)
    }
</script>
</body>
</html>
