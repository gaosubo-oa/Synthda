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
    <meta charset="UTF-8">
    <title><fmt:message code="email.title.waitmail"/></title><!-- 写邮件 -->
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../../../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/email/writeMail.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="/js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529.2"></script>
    <style>
        .files a {
            text-decoration: none;
        }

        a {
            text-decoration: none;
            color: #207BD6;
            cursor: pointer;
        }

        #attention {
            margin: 0;
            padding: 0;
            list-style: none;
            width: 100px;
            position: absolute;
            left: 10px;
            text-align: center;
            display: none;
            z-index: 9999;
            border: #ccc 1px solid;
            top: 20px;
        }

        #attention li {
            background: #ffffff;
            cursor: pointer;
            line-height: 22px;
        }

        td {
            padding: 8px;
        }

        #attention li:hover {
            background-color: #6ea1d5;
            color: #fff;
        }

        .choose {
            width: 180px;
            position: absolute;
            left: 255px;
            top: 0px;
        }

        .bar {
            height: 18px;
            background: green;
        }

        .div_btn {
            width: 105px;
        }

        .box {
            width: 200px;
            height: 20px;
        }

        .tbox {
            width: 200px;
            height: 20px;
            background: url(/img/email/bak.png) no-repeat;
            background-size: 100% 100%;
        }

        .tbox div {
            width: 0px;
            height: 20px;
            background: url(/img/email/pro.png) no-repeat;
            background-size: 100% 100%;
            text-align: center;
            font-size: 14px;
            line-height: 20px;
        }
    </style>
</head>
<body>

<table class="TABLE" border="1" cellspacing="0" cellpadding="0"
       style="border-collapse: collapse;margin-bottom: 20px;margin-top: 30px">
    <tr class="append_tr">
        <td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.recipients"/>：</td>
        <td width="85%">
            <form id="uploadimgform1" style="float: left;" target="uploadiframe" action=""
                  method="post">
                <input type="file" multiple="multiple" name="file" id="uploadinputimg1" class="w-icon5"
                       style="width: 70px;">
                <a href="/file/email/<fmt:message code="email.th.emailDistributionTemplate" />.xls" id="mubanDown" style="margin-right: 20px;"><fmt:message
                        code="user.th.TemplateDownload"/></a>
            </form>

        </td>
    </tr>

    <tr>
        <td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.major"/>：</td>
        <td width="85%">
            <input type="text" id="txt" value="" style="width: 70%;" class="input_txt"/>
            <!-- <span class="import">一般邮件</span> -->
        </td>
    </tr>
    <tr>
        <td width="15%" style="padding-left: 10px;">
            <p><fmt:message code="email.th.content"/>：</p>
            <!-- <p class="Color"><fmt:message code="email.th.countnumber" />：<span>0</span></p> -->
            <p class="Color"><a href="javascript:;" onclick="empty()"><fmt:message code="global.lang.empty"/></a></p>
        </td>
        <td width="85%">
            <div id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></div>
        </td>
    </tr>
    <tr class="Attachment" style="width:100%; padding-left: 10px;">
        <td width="15%"><fmt:message code="email.th.filechose"/>：</td>
        <td width="85%" class="files" id="files_txt">
            <div id="fileContent"></div>
        </td>
    </tr>
    <tr>
        <td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.file"/>：</td>
        <td width="85%" class="files" style="position: relative">
            <!-- <fmt:message code="email.th.addfile" /> -->
            <form id="uploadimgform" style="float: left;margin: 0 20px 0 0;" target="uploadiframe"
                  action="" method="post">
                <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5"
                       style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                <a href="#" id="uploadimg" style="display: inline-block;height: 20px;line-height: 20px"><img
                        style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message
                        code="global.th.fileup"/></a>
            </form>
            <form id="uploadimgform2" style="float: left;margin: 0 20px 0 0;" target="uploadiframe"
                  action="/upload?module=email" method="post">
                <input webkitdirectory type="file" multiple="multiple" name="file" id="Folder" class="w-icon5"
                       style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                <a href="#" id=" upload" style="display: inline-block;height: 20px;line-height: 20px"><img
                        style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="file.th.folderUpload" /></a>
            </form>
            <form id="fileform" style="float: left;margin: 0 20px 0 0;" target="" action="" method="post">
                <a href="#" id="uploadfile" style="display: inline-block;height: 20px;line-height: 20px"
                   onclick="fileBox()"><img style="margin:3px 5px 0 0;float: left;" src="../img/mg12.png"/><fmt:message
                        code="email.th.selectUpload"/></a>
            </form>

            <span id="fileTips" style="color: #b6b1b1"><fmt:message code="file.th.fileUploadDesc" /></span>
            <%--<a href="javascript:;" onclick="formFile()" style="float: left;margin: 0 15px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>从文件柜选择附件</a>--%>
            <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                <div class="bar" style="width: 0%;"></div>
            </div>
            <div class="barText" style="float: left;margin-left: 10px;"></div>
        </td>
    </tr>
    <tr>
        <td width="15%" style="padding-left: 10px;"><fmt:message code="sms.th.remind"/>：</td>
        <td width="85%" class="remind">
            <div class="news_t">
                <input type="checkbox" name="remind" class="remindCheck" value="0" checked>
                <fmt:message code="notice.th.remindermessage"/>&nbsp;
                <%--<input type="checkbox" name="smsDefault" style="display: none;" class="smsDefault" value="1" >--%>
                <%--<span class="hideSpan" style="display: none;"><fmt:message code="vote.th.UseRemind" /></span>--%>
            </div>

        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="div_btn">
                <div class="sureBtn"><span style="margin-left: 30px;"><fmt:message
                        code="email.th.transmitimmediate"/></span></div>
                <%--<div class="saveBtn"><span style="margin-left: 33px;"><fmt:message code="email.th.savedraftbox" /></span></div>--%>

            </div>
        </td>
    </tr>
</table>

<script type="text/javascript">
    var uid = $.GetRequest().uid || '';
    var uname = $.GetRequest().uname || '';
    var attach_id = '';
    $(function () {
        $('table').width($(document).width() - 100);
        var userId = $.getQueryString('userId');
        var userName = $.getQueryString('userName');
        if (userId != null || userName != null) {  //判断userId或者userName是否为空
            $('#senduser').attr('user_id', userId + ',');
            $('#senduser').attr('username', decodeURI(userName) + ',');
            $('#senduser').val(decodeURI(userName) + ',');
        } else {
            $('#senduser').attr('user_id', '');
            $('#senduser').attr('username', '');
            $('#senduser').val('');
        }
//				查是否有权限使用手机短信提醒
        $.ajax({
            type: 'get',
            url: '/sms2Priv/selectSms2',
            dataType: 'json',
            data: {
                sysCode: 2
            },
            success: function (res) {
                if (res.flag) {
                    $('.smsDefault').show();
                    $('.hideSpan').show();
                } else {
                    $('.smsDefault').hide();
                    $('.hideSpan').hide();
                }
            }
        })

        if (uid != '') {
            $.ajax({
                type: 'get',
                url: '/user/findUserByuid',
                dataType: 'json',
                data: {
                    uid: uid
                },
                success: function (res) {
                    if (res.flag) {
                        $('#senduser').attr('user_id', res.object.userId + ',').val(decodeURI(uname) + ',').attr('username', decodeURI(uname) + ',');
                        $('.add_img').hide();
                    }
                }
            });
        }
    })
    //			附件上传方法
    fileuploadFn('#uploadinputimg', $('.Attachment td').eq(1));
    fileuploadFn('#Folder', $('.Attachment td').eq(1));
    //模版上传
    fileuploadFn('#uploadinputimg1', $('.append_tr td').eq(1));
    //解决拖拽上传执行多次接口，文件夹上传方法如果被点击后执行
    $("#uploadimgform").on('click',function (){
        $("#uploadimgform").attr("action","/upload?module=email")
    })
    $("#uploadimgform1").on('click',function (){
        $("#uploadimgform1").attr("action","/upload?module=email")
    })

    //			从文件柜上传文件
    function fileBox() {
        attach_id = 'fileContent';
        $.popWindow("/email/formFileCabinet");
    }


    var user_id = 'senduser';
    //获取输入框内容
    var ue = UE.getEditor('container', {elementPathEnabled: false});
    UEimgfuc();

    var res;
    $(function () {

        $(document).on('delegate','.clearBCC', 'click', function () {
            $('#secritText').attr('username', '');
            $('#secritText').attr('dataid', '');
            $('#secritText').attr('user_id', '');
            $('#secritText').attr('userprivname', '');
            $('#secritText').val('');
        })
        $(document).on('delegate','.clearCC', 'click', function () {
            $('#copeNameText').attr('username', '');
            $('#copeNameText').attr('dataid', '');
            $('#copeNameText').attr('user_id', '');
            $('#copeNameText').attr('userprivname', '');
            $('#copeNameText').val('');
        })
        //选人控件
        $("#selectUser").on("click", function () {
            user_id = 'senduser';
            $.ajax({
                url: '/imfriends/getIsFriends',
                type: 'get',
                dataType: 'json',
                data: {},
                success: function (obj) {
                    if (obj.object == 1) {
                        $.popWindow("../common/selectUserIMAddGroup");
                    } else {
                        $.popWindow("../common/selectUser");
                    }
                },
                error: function (res) {
                    $.popWindow("../common/selectUser");
                }
            })
        });
        $('.TABLE').on('click', '#selectUserO', function () {
            user_id = 'copeNameText';
            $.ajax({
                url: '/imfriends/getIsFriends',
                type: 'get',
                dataType: 'json',
                data: {},
                success: function (obj) {
                    if (obj.object == 1) {
                        $.popWindow("../common/selectUserIMAddGroup");
                    } else {
                        $.popWindow("../common/selectUser");
                    }
                },
                error: function (res) {
                    $.popWindow("../common/selectUser");
                }
            })
        })
        $('.TABLE').on('click', '#selectUserT', function () {
            user_id = 'secritText';
            $.ajax({
                url: '/imfriends/getIsFriends',
                type: 'get',
                dataType: 'json',
                data: {},
                success: function (obj) {
                    if (obj.object == 1) {
                        $.popWindow("../common/selectUserIMAddGroup");
                    } else {
                        $.popWindow("../common/selectUser");
                    }
                },
                error: function (res) {
                    $.popWindow("../common/selectUser");
                }
            })
        })

        //附件删除
        $('td').on('click', '.deImgs', function () {
            var data = $(this).parents('.dech').attr('deUrl');
            var dome = $(this).parents('.dech');
            deleteChatment(data, dome);
        })

        //点击立即发送按钮
        $(".sureBtn").on("click", function () {
            var remindVal = 0;
            if ($('.remindCheck').is(":checked")) {
                remindVal = 1;
            }
            var smsDefault = 1;
            if ($('.smsDefault').is(":checked")) {
                smsDefault = 0;
            }
            var dataId1 = $('.inPole').find('#senduser').attr('user_id');
            var dataId2 = $('.tian').find('#copeNameText').attr('user_id');
            var dataId3 = $('.mis').find('#secritText').attr('user_id');

            var userId = $('textarea[name="txt"]').attr('user_id');
            var txt = ue.getContentTxt();
            var html = ue.getContent();
//					var val=$('#txt').val();
            var attach = $('.Attachment td').eq(1).find('a');
            var attach1 = $('.append_tr td').eq(1).find('a');
            var aId = '';
            var uId = '';
            var mId = ''; //模板 id 串
            var mName = '';  //模板 name
            for (var i = 0; i <= $('.Attachment td .inHidden').length; i++) {
                //aId += $('.Attachment td .inHidden').eq(i).val();
                aId += $('.dech').eq(i).find('input').val();
            }
            for (var i = 0; i <= $('.Attachment td .inHidden').length; i++) {
                //uId += attach.eq(i).attr('NAME');
                uId += $($('.dech').get(i)).children('[name!=""]').attr('name');
            }
            for (var i = 0; i < $('.append_tr td .inHidden').length; i++) {
                mId += $('.append_tr td .inHidden').eq(i).val();
            }
            for (var i = 0; i < $('.append_tr td .inHidden').length; i++) {
                mName += $('.append_tr td .inHidden').eq(i).parent().find('a').attr('name');
            }
            var data = {
                toId2: dataId1,
                copyToId: dataId2,
                secretToId: dataId3,
                toWebmail: '',
                fromWebmail: '',
                subject: $('#txt').val(),
                content: html,
                attachmentId: aId,
                attachmentName: uId,
                remind: remindVal,//事务提醒
                mId: mId,
                mName: mName,
                // smsDefault:smsDefault //手机提醒
            };
            if ($('.a3').attr('a3type') == '1') {
                data.toWebmail = $('#outEmail').val();
                data.fromWebmail = $('#outSelect option:selected').val();
            } else {
                if (data.toId2 == '') {
                    layer.msg('<fmt:message code="email.th.pleaseFillInTheRecipient" />！', {icon: 6});/*请输入收件人*/
                    return;
                }
                data.toWebmail = '';
                data.fromWebmail = '';
            }

            layer.load(0, {shade: [0.2, '#ffffff']});
            $.ajax({
                type: 'post',
                url: '/email/SendEmails',
                dataType: 'json',
                data: data,
                success: function (rsp) {
                    if (rsp.flag == true) {
                        if (rsp.msg == 'needAdmin') {
                            $.layerMsg({content: '<fmt:message code="email.th.pleaseSetUpTheApprovers" />！', icon: 1}, function () {
                                layer.closeAll();
                            });

                        } else {
                            $.layerMsg({content: '<fmt:message code="global.lang.send" />！', icon: 1}, function () {
                                if (uid != '') {
                                    layer.closeAll();
                                    location.reload();
                                } else {
                                    if (userId != null || userName != null) {
                                        layer.closeAll();
                                        window.close();
                                    }
                                    parent.location.reload();
                                    layer.closeAll();
                                }
                            });
                        }
                        window.open('/email/index');
                        $('#txt').val('');
                        location.reload();
                    } else {
                        $.layerMsg({content: '<fmt:message code="global.lang.err" />！', icon: 2}, function () {
                            layer.closeAll();
                        });
                    }
                    layer.closeAll();

                }
            });
        });

        //点击保存到草稿箱按钮
        $(".saveBtn").on("click", function () {
            var dataId1 = $('.inPole').find('#senduser').attr('user_id');
            var dataId2 = $('.tian').find('#copeNameText').attr('user_id');
            var dataId3 = $('.mis').find('#secritText').attr('user_id');
            var userId = $('textarea[name="txt"]').attr('user_id');
            var txt = ue.getContentTxt();
            var html = ue.getContent();
//					var val=$('#txt').val();
            var attach = $('.Attachment td').eq(1).find('a');
            var aId = '';
            var uId = '';
            for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
                aId += $('.Attachment td .inHidden').eq(i).val();
            }
            for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
                uId += attach.eq(i).attr('NAME');
            }
            <%--if(dataId1 == '' && html == '' && val == '' && aId == '' && uId == ''){--%>
            <%--val='<fmt:message code="email.th.noSubject" />';/*无主题*/--%>
            <%--}--%>

            var data = {
                'toId2': dataId1,
                'copyToId': dataId2,
                'secretToId': dataId3,
                'subject': $('#txt').val(),
                'content': html,
                'attachmentId': aId,
                'attachmentName': uId
            };
            $.ajax({
                type: 'post',
                url: 'saveEmail',
                dataType: 'json',
                data: data,
                success: function () {
                    $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon: 1}, function () {
                        parent.location.reload();
                    });
                }
            });
        });

        //删除附件
        function deleteChatment(data, element) {

            layer.confirm('<fmt:message code="workflow.th.que" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="notice.th.DeleteAttachment" />"
            }, function () {
                //确定删除，调接口
                $.ajax({
                    type: 'post',
                    url: '../delete',
                    dataType: 'json',
                    data: data,
                    success: function (res) {

                        if (res.flag == true) {
                            layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
//                                     var file = $('[name="file"]')
//                                     file.after(file.clone().val(""));
//                                     file.remove();
                            element.remove();
                        } else {
                            layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 6});
                        }
                    }
                });

            }, function () {
                layer.closeAll();
            });
        }

    });

    //清空UE内容
    function empty() {
        ue.setContent('');
    }

    $(function () {
        //添加常联系人员
        $('.choose ').on('click',function (e) {
//                    $("#attention").show();
            e.stopPropagation();
            $("#attention").toggle();
            $.ajax({
                type: 'post',
                url: '/contactPerson/serchContactPerson',
                dataType: 'json',
                success: function (json) {
                    var arr = json.obj;
                    var str = '';
                    for (var i = 0; i < arr.length; i++) {
                        str += '<li dataid="' + arr[i].uid + '" user_id="' + arr[i].userId + '">' + arr[i].userName + '</li>';
                    }
                    $('#attention').html(str);
                }
            });
        });
        var userName = [];
        var userIds = [];
        $('#attention').on('click', 'li', function () {
            var uName = $(this).text();
            var uId = $(this).attr('user_id');
            userName.push(uName);
            userIds.push(uId);

            function unique(arr) {
                var res = [];
                var json = {};
                for (var i = 0; i < arr.length; i++) {
                    if (!json[arr[i]]) {
                        res.push(arr[i]);
                        json[arr[i]] = 1;
                    }
                }
                return res;
            }

            var d = unique(userName);
            var f = unique(userIds);
            $('#senduser').val(d);
            $('#senduser').attr('user_id', f);
        });

//                $('#attention'). mouseleave(function (){
//                    $("#attention").hide();
//                });
        $(document).on('click',function () {
            if ($('#attention').css('display') == 'block') {
                $('#attention').css('display', 'none');
            }
        })
    })

</script>
</body>
</html>

