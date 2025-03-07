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
    <title>即会通视频会议审批</title>
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
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>

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
<div class="headTop" >
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRoom.png" alt="">
    </div>
    <div class="divTitle">
        即会通视频会议审批
    </div>
</div>
<div class="main" style="margin-top: 80px">
    <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
        <table>
            <thead>
            <tr>
                <th style="text-align: center" width="5%"><%--<fmt:message code="hr.th.number" />--%></th>
                <th><fmt:message code="meet.th.ConferenceRoomName"/></th>
                <th>申请人</th>
                <th>申请时间</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>会议状态</th>
                <th><fmt:message code="notice.th.operation"/></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

        </div>
    </div>
</div>
<script>

    $(function () {
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
            window.location.replace('/JHTMeeting/approvalH5');
        }
        //初始化数据
        init();

    });

    function init() {
        $('.pagediv tbody tr').remove();
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                managerId:1
            },
            page: function () {
                var me = this;
                $.ajax({
                    type: 'get',
                    url: '/JHTMeeting/findJHTMeeting',
                    dataType: 'json',
                    data: me.data,
                    success: function (res) {
                        var data = res.obj;
                        var str = '';
                        if (data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr><td style="text-align: center"></td>' +
                                    '<td><a href="javascript:void(0);" class="meetRoomDetail" style="color: #404060"  meetRoomId="' + data[i].meetingId + '">' + data[i].meetName + '</a></td>' +
                                    '<td>' + function () {
                                        if (data[i].userId == undefined) {
                                            return '';
                                        } else {
                                            return data[i].userName
                                        }
                                    }() + '</td>' +
                                    '<td>' + function () {
                                        if (data[i].proposerTime == undefined) {
                                            return ''
                                        } else {
                                            return data[i].proposerTime
                                        }
                                    }() + '</td>' +
                                    '<td  title="' + data[i].startTime + '">' + data[i].startTime + '</td>' +
                                    '<td  title="' + data[i].endTime + '">' + data[i].endTime + '</td>' +
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
                                    '<td><a href="javascript:deleteone(' + data[i].meetingId + ',2);">批准</a>&emsp;<a href="javascript:deleteone(' + data[i].meetingId + ',5);">不批准</a>' +
                                '</td>';
                            }
                            $('.pagediv tbody').html(str);
                            me.pageTwo(res.obj.length, me.data.pageSize, me.data.page)
                        }
                    }
                });

            },
            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
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
                    init();
                }
            })
        }, function () {
            layer.closeAll();
        })
    }
</script>
</body>
</html>
