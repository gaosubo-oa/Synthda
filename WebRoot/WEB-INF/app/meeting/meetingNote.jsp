<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/7/2
  Time: 10:10
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
<!DOCTYPE html>
<html>
    <head>
        <title>会议笔记</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <!-- kindeditor文本编辑器 -->
        <script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
        <script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>

        <style>
            html, body {
                width: 100%;
                height: 100%;
                background: #fff;
            }

            /*伪元素是行内元素 正常浏览器清除浮动方法*/
            .clearfix:after {
                content: "";
                display: block;
                height: 0;
                clear: both;
                visibility: hidden;
            }

            .clearfix {
                *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
            }

            .container {
                position: relative;
                width: 100%;
                height: 100%;
                padding-top: 46px;
                box-sizing: border-box;
            }

            .wrapper {
                position: relative;
                width: 100%;
                height: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

            .wrap_left {
                position: relative;
                float: left;
                width: 250px;
                height: 100%;
                border-right: 1px solid #ccc;
                padding-right: 10px;
                box-sizing: border-box;
                overflow: hidden;
            }

            .wrap_left:hover {
                overflow: auto;
            }

            .wrap_right {
                position: relative;
                height: 100%;
                margin-left: 260px;
                overflow: auto;
            }

            .header {
                position: absolute;
                top: 0px;
                left: 0px;
                width: 100%;
                height: 45px;
                border-bottom: 1px solid #999;
                background: #fff;
                overflow: hidden;
                z-index: 2;
            }

            .list_item {
                position: relative;
                height: 32px;
                line-height: 32px;
                padding: 0 20px;
                word-break: break-all;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                cursor: pointer;
            }

            .list_item.active {
                background-color: #d6f3ff;
            }

            .list_item.active:before {
                position: absolute;
                top: 0;
                left: 0;
                content: "";
                height: 100%;
                width: 5px;
                background-color: #3f73c4;
            }

            .list_item:hover {
                background-color: #d6f3ff;
            }

            .list_item:hover:before {
                position: absolute;
                top: 0;
                left: 0;
                content: "";
                height: 100%;
                width: 5px;
                background-color: #3f73c4;
            }

            .label_item {
                padding: 8px 0;
                text-align: center;
            }

            .label_ttile {
                display: inline-block;
                width: 130px;
                text-align: left;
            }

            .label_con {
                display: inline-block;
                width: 60%;
                min-width: 300px;
                border-bottom: 1px solid #eee;
                text-align: left;
            }

            .button_box {
                padding-bottom: 5px;
                border-bottom: 1px solid #eee;
            }

            .content {
                position: absolute;
                top: 35px;
                left: 0;
                right: 0;
                bottom: 0;
                overflow: auto;
            }

            .scorll_bar {
                position: absolute;
                top: 35px;
                right: 0;
                bottom: 0;
                width: 30px;
                background-color: #fff;
                z-index: 1;
            }

            .content fieldset {
                margin-top: 10px;
                border: none;
                border-top: 1px solid #eee;
            }

            .history_box .label_con {
                border: none;
            }

            .file_item {
                display: block;
                color: #0B7CC4 !important;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <input type="hidden" id="leftId">
            <div class="header">
                <div class="headImg" style="padding-top: 7px">
                    <span style="font-size: 22px; margin-left: 28px; color: #494d59; margin-top: 2px">
                        <img style="margin: -3px 10px 0 0;" src="/img/commonTheme/theme6/icon_myMeeting.png">
                        <span>会议笔记</span>
                    </span>
                </div>
            </div>
            <div class="wrapper">
                <div class="wrap_left">
                    <div class="list_module">
                        <ul class="list_ul"></ul>
                    </div>
                </div>
                <div class="wrap_right">
                    <div class="button_box" style="display: none;">
                        <button id="qrCodeSign" type="button" class="layui-btn layui-btn-sm layui-btn-normal">扫码打卡</button>
                        <button id="imageSign" type="button" class="layui-btn layui-btn-sm layui-btn-normal">图片打卡</button>
                        <button id="writeSign" type="button" class="layui-btn layui-btn-sm layui-btn-normal">手写打卡</button>
                        <button id="save" type="button" class="layui-btn layui-btn-sm layui-btn-normal" style="float: right;">保存</button>
                    </div>
                    <div class="content">
                        <fieldset class="layui-elem-field">
                            <legend>会议信息</legend>
                        </fieldset>
                        <div class="base_info clearfix">
                            <div class="layui row">
                                <div class="layui-col-md12 layui-col-lg6">
                                    <div class="label_item">
                                        <div class="label_ttile"><span>会议名称：</span></div>
                                        <div class="label_con"><span fieldName="meetName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>主题：</span></div>
                                        <div class="label_con"><span fieldName="subject" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>申请人：</span></div>
                                        <div class="label_con"><span fieldName="userName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>联系电话：</span></div>
                                        <div class="label_con"><span fieldName="mobileNo" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item duty_desc_box">
                                        <div class="label_ttile"><span>会议纪要员：</span></div>
                                        <div class="label_con"><span fieldName="recorderName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item duty_desc_box">
                                        <div class="label_ttile"><span>会议时间：</span></div>
                                        <div class="label_con"><span class="range_date"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>会议室：</span></div>
                                        <div class="label_con"><span fieldName="meetRoomName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>审批管理员：</span></div>
                                        <div class="label_con"><span fieldName="managerName" class="field_name"></span></div>
                                    </div>
                                </div>
                                <div class="layui-col-md12 layui-col-lg6">
                                    <div class="label_item">
                                        <div class="label_ttile"><span>出席人员(外部)：</span></div>
                                        <div class="label_con"><span fieldName="attendeeOut" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>出席人员(内部)：</span></div>
                                        <div class="label_con"><span fieldName="attendeeName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>前台会议服务人员：</span></div>
                                        <div class="label_con"><span fieldName="serviceUserName" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>会议设备：</span></div>
                                        <div class="label_con"><span fieldName="equipmentNames" class="field_name"></span></div>
                                    </div>
                                    <div class="label_item duty_desc_box">
                                        <div class="label_ttile"><span>会议议程附件：</span></div>
                                        <div class="label_con"><div id="agendaList"></div></div>
                                    </div>
                                    <div class="label_item duty_desc_box">
                                        <div class="label_ttile"><span>附件：</span></div>
                                        <div class="label_con"><div id="attachmentList"></div></div>
                                    </div>
                                    <div class="label_item duty_desc_box">
                                        <div class="label_ttile"><span>会议描述：</span></div>
                                        <div class="label_con"><pre fieldName="meetDesc" class="field_name"></pre></div>
                                    </div>
                                    <div class="label_item">
                                        <div class="label_ttile"><span>我的打卡：</span></div>
                                        <div class="label_con" style="border: none;"><span class="mySign"></span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <fieldset class="layui-elem-field">
                            <legend>会议记录</legend>
                        </fieldset>
                        <div class="history_box" style="width: 100%; padding: 0 5px; box-sizing: border-box;">
                            <textarea id="meetingNotes" name="meetingNotes" style="width: 100%; height: 400px;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // 会议信息
            var meetingInfo = null;

            // 获取我的会议
            $.get('/meeting/MyMeeting', function (res) {
                var str = '';
                if (res.flag && res.obj.length > 0) {
                    res.obj.forEach(function (item) {
                        str += '<li class="list_item" sid="' + item.sid + '"><span>' + item.meetName + '</span></li>';
                    });
                }
                $('.list_ul').html(str);
            });

            $(document).on('click', '.list_item', function () {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var sid = $(this).attr('sid');
                $('#leftId').attr('sid', sid);
                getmeetingInfo(sid);
                $('.button_box').show();
            });

            // 扫码打卡
            $('#qrCodeSign').on('click', function () {
                if (meetingInfo.myAttendStatus != '0') {
                    layer.msg('该会议已打卡！', {icon: 0});
                    return false;
                }

                layer.open({
                    type: 1,
                    offset: '80px',
                    area: ['650px', '400px'], //宽高
                    title: "<fmt:message code="event.th.two" />",
                    content: '<div class="qrTotal"><div class="qrCenter" style="margin-left: 200px;margin-top: 36px;"><span class="showQRCode" id="showQRCode"  style="display: inline-block;"></span></div></div>',
                    success: function () {
                        var qrcode = new QRCode(document.getElementById("showQRCode"), {
                            width: 250,
                            height: 250
                        });

                        var str = '{"mark":"SID_MEETING","sid":' + meetingInfo.sid + '}';
                        qrcode.makeCode(str);
                    },
                    end: function () {
                        getmeetingInfo(meetingInfo.sid);
                    }
                });
            });

            // 图片打卡
            $('#imageSign').on('click', function () {
                if (meetingInfo.myAttendStatus != '0') {
                    layer.msg('该会议已打卡！', {icon: 0});
                    return false;
                }

                var loadIndex = layer.load();

                // 获取当前用户信息
                $.get('/user/getUserByuid', {uid: -1}, function (res) {
                    layer.close(loadIndex);
                    var userInfo = res.object;
                    $('.signImageId').val(res.object.signImageId);
                    $('.signImageName').val(res.object.signImageName);
                    if (userInfo.attachment && userInfo.attachment.length > 0 && userInfo.signImageId && userInfo.signImageName) {
                        var signUrl = userInfo.attachment[0].attUrl;
                        layer.open({
                            type: 1,
                            title: '图片打卡',
                            offset: '80px',
                            area: ['650px', '400px'], //宽高
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: '<div style="width: 100%; height: 100%; padding: 20px; box-sizing: border-box;"><img style="width: 100%; height: 100%;" src="/xs?' + signUrl + '" alt=""></div>',
                            yes: function (index) {
                                var loadIndex = layer.load();
                                $.post('/MeetSummary/addSign', {
                                    meetingId: meetingInfo.sid,
                                    signId: userInfo.signImageId,
                                    signName: userInfo.signImageName
                                }, function (res) {
                                    layer.close(loadIndex);
                                    if (res.flag) {
                                        layer.msg('打卡成功！', {icon: 1});
                                        getmeetingInfo(meetingInfo.sid);
                                        layer.close(index);
                                    } else {
                                        layer.msg('打卡失败！', {icon: 0});
                                    }
                                });
                            }
                        });
                    } else {
                        layer.msg('您未上传图片签名！', {icon: 0});
                    }
                });
            });

            // 手写打卡
            $('#writeSign').on('click', function () {
                if (meetingInfo.myAttendStatus != '0') {
                    layer.msg('该会议已打卡！', {icon: 0});
                    return false;
                }

                if (meetingInfo.handwritingSignYn != '1') {
                    layer.msg('该会议未开启手写打卡！', {icon: 0});
                    return false;
                }

                layer.open({
                    type: 1,
                    area: ['640px', '460px'],
                    title: ['手写签字', 'background-color:#2b7fe0;color:#fff;'],
                    btn: ['清屏', '确定', '关闭'],
                    btnAlign: 'c',
                    content: '<div id="content" style="width:100%;height:100%;background:#eeeeee;"><div id="signatureparent" style="width:100%;height:97%;"><div id="signatureCon" style="width:100%;height:100%;"></div></div></div>',
                    success: function () {
                        $("#signatureCon").jSignature();
                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
                        } else {
                            $('canvas').height('355px').attr('height', '355px')
                        }
                    },
                    yes: function (index) {
                        $("#signatureCon").jSignature("clear");
                    },
                    btn2: function (index) {
                        var loadIndex = layer.load();

                        var $sigdiv = $("#signatureCon");
                        var datapair = $sigdiv.jSignature("getData", "image");
                        var src = "data:" + datapair[0] + "," + datapair[1];

                        $.ajax({
                            url: '/uploadBase64',
                            dataType: 'json',
                            data: {fileStr: src, module: 'meeting'},
                            type: 'post',
                            success: function (res) {
                                if (res.flag && res.obj.length > 0) {
                                    console.log('手写成功');
                                    var signImg = res.obj[0];

                                    $.post('/MeetSummary/addSign', {
                                        meetingId: meetingInfo.sid,
                                        signId: signImg.attachId,
                                        signName: signImg.attachName
                                    }, function(res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
                                            layer.msg('打卡成功！', {icon: 1});
                                            getmeetingInfo(meetingInfo.sid);
                                            layer.close(index);
                                        } else {
                                            layer.msg('打卡失败！', {icon: 0});
                                        }
                                    });
                                }
                            }
                        });
                        return false;
                    }
                });
            });

            var saveTimer = null;
            // 保存
            $('#save').on('click', function() {
                var loadIndex = layer.load();
                clearTimeout(saveTimer);
                saveTimer = null;
                saveTimer = setTimeout(function(){
                    var text = newKindEditorObj.html();
                    var sid = $(this).attr('sid');
                    $.post('/MeetSummary/updateMeetNotes', {
                        sid: sid,
                        meetingNotes: text
                    }, function (res) {
                        clearTimeout(saveTimer);
                        saveTimer = null;
                        layer.close(loadIndex);
                        if (res.flag) {
                            layer.msg('保存成功！', {icon: 1});
                        } else {
                            layer.msg('保存失败！', {icon: 2});
                        }
                    });
                }, 100);
            });

            /**
             * 获取会议详情
             * @param sid
             */
            function getmeetingInfo(sid) {
                var loadIndex = layer.load();
                $.get('/meeting/queryMeetingById', {sid: sid}, function (res) {
                    if (res.flag) {
                        meetingInfo = res.object;
                        $('.base_info').find('.field_name').each(function(){
                            var fieldName = $(this).attr('fieldName');
                            if (fieldName && meetingInfo[fieldName]) {
                                $(this).text(meetingInfo[fieldName]);
                            }
                        });
                        $('.range_date').text(meetingInfo.startTime + ' ～ ' + meetingInfo.endTime);

                        if (meetingInfo.myAttendStatus == '0') {
                            $('.mySign').html('<span class="layui-badge">未打卡</span>');
                        } else {
                            $('.mySign').html('<span class="layui-badge layui-bg-green">已打卡</span>');
                        }

                        if (meetingInfo.agendaList && meetingInfo.agendaList.length > 0) {
                            var str = '';
                            meetingInfo.agendaList.forEach(function(file) {
                                str += '<a class="file_item" href="/download?' + file.attUrl + '">' + file.attachName + '</a>'
                            });
                            $('#agendaList').html(str);
                        }

                        if (meetingInfo.attachmentList && meetingInfo.attachmentList.length > 0) {
                            var str = '';
                            meetingInfo.attachmentList.forEach(function(file) {
                                str += '<a class="file_item" href="/download?' + file.attUrl + '">' + file.attachName + '</a>'
                            });
                            $('#attachmentList').html(str);
                        }

                        $.get('/MeetSummary/meetNotes', {meetingId: meetingInfo.sid}, function(res) {
                            if (res.flag) {
                                $('#save').attr('sid', res.data.sid);
                                newKindEditorObj.html(res.data.meetingNotes || '');
                            } else {
                                $('#save').attr('sid', '');
                            }
                            layer.close(loadIndex);
                        });
                    } else {
                        meetingInfo = null;
                        layer.close(loadIndex);
                        layer.msg('获取会议信息失败！', {icon: 2});
                    }
                });
            }

            /************** kindEditor编辑器 **************/
            var newKindEditorObj = null;
            KindEditor.ready(function (K) {
                newKindEditorObj = K.create('#meetingNotes', {
                    themeType: 'simple', // 定义编辑器为简洁模式
                    filterMode: false, // 开启过滤
                    allowFileManager: true, // 开启文件空间
                    uploadJson: '/ueditor/upload?module=meeting', // 上传接口
                    filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
                    afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
                    afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
                    afterUploadErrorMsg: 'msg' // 定义上传失败后提示信息的参数名（默认为 message）
                });
            });
        </script>

        <!-- 二维码 -->
        <script type="text/javascript" src="/lib/qrcode.js"></script>
        <!-- 手写签字 -->
        <script type="text/javascript" src="/lib/jSignature-master/src/jSignature.js"></script>
    </body>
</html>
