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
        <title><fmt:message code="main.usermanage"/></title>
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
        <link rel="stylesheet" type="text/css" href="../css/base.css"/>
        <link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>
        <script src="/js/common/language.js"></script>
        <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
        <script src="/js/jquery/jquery.cookie.js"></script>
        <script src="../lib/laydate/laydate.js"></script>
        <script src="/lib/layer/layer.js?20201106"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
        <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
        <script src="../js/base/base.js?20191018" type="text/javascript" charset="utf-8"></script>
        <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="/js/common/fileupload.js?20230216.2"></script>
        <script src="../js/sys/adduser.js?20230510" type="text/javascript" charset="utf-8"></script>

        <style>
            .clearfix:after {
                content: '';
                display: block;
                clear: both;
            }

            .fl {
                float: left;
            }

            textarea {
                min-width: 204px;
                min-height: 50px;
                width: 204px;
                height: 50px;
                color: #555;
            }

            #signBtn {
                cursor: pointer;
                background-color: #6299d9;
                padding: 2px 5px;
                border-radius: 4px;
                color: #fff;
            }
            *:focus-visible {
                outline: none;
            }
            .operation {
                display: none;
            }
            .unloading {
                display: none;
            }
        </style>
        <script>
            var moduleId = 11;
            var start = 0;
            var end = 0;
            var priv_id;
            var res;
            var dept_id;
            var user_id;
            var org_id;
            var seleId = GetQueryString('deptId');
            var isAdd = GetQueryString("isAdd");
            var classifyOrg = GetQueryString("classifyOrg") != null ? GetQueryString("classifyOrg") : "";
            var is_ZDJ = false;
            var names
            var qiParaValue;
            var attachmentId = [];
            var attachmentName = [];
            var operationReason = ""
            var secretInfo = null;
            var isOpenSanyuan = false;
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                success:function(res) {
                    secretInfo = res.object[0].paraValue;
                }
            })
            //判断页面是否需要显示机密级字样
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
                success:function(res) {
                    var data = res.object[0];
                    if(data.paraValue == 1) {
                        $(".subText").show()
                    }else {
                        $(".subText").hide()
                    }
                }
            })
            //判断是否新增密级字段
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET",
                success:function(res) {
                    var data = res.object[0];
                    if(data.paraValue == 1) {
                        $(".userSecrecyInfo").show()
                    }else {
                        $(".userSecrecyInfo").hide()
                    }
                }
            })

            //判断是否开启三员管理
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                success:function(res) {
                    var data = res.object[0];
                    if(data.paraValue == 1) {
                        isOpenSanyuan = false;
                    }else if(data.paraValue == 0){
                        isOpenSanyuan = true;
                    }
                }
            })

            // 判断是否为中电建环境
            $.get('/ShowDownLoadQrCode', function (res) {
                if (res.flag && res.object == 1) {
                    is_ZDJ = true;

                    if (isAdd != 0) {
                        $('input[name="userId"]').attr('readonly', 'readonly');
                    }
                }
            });
            // 判断是否为七匹狼项目
            $.get('/syspara/selectTheSysPara?paraName=MYPROJECT', function (res) {
                if(res.flag){
                    qiParaValue = res.object[0].paraValue
                    //七匹狼项目
                    if(qiParaValue == 'septwolves' ){
                        $('.qipilang').css('display', 'table-row');
                        $('.userIdTip').css('display', 'none');
                        $('.mustWrite').show();
                        if (isAdd != 0) {
                            $('input[name="userId2"]').attr('readonly', 'readonly');
                            $('input[name="userId2"]').css('background', '#e0e0e0');
                        }
                    }else{
                        $('.mustWrite').hide();
                        // 手动输入用户id
                        $('#setUserId').on('click',function(){
                            $('.qipilang').toggle();
                        })
                        //编辑时不显示手动输入信息
                        if (isAdd != 0) {
                            $('.qipilang').css('display', 'table-row');
                            $('input[name="userId2"]').attr('readonly', 'readonly');
                            $('input[name="userId2"]').css('background', '#e0e0e0');
                            $('.userIdTip').css('display', 'none');
                        }
                    }
                }
            });
            $(function () {
                //选人控件
                $("#selectUser1").on("click", function () {
                    priv_id = 'senduser1';
                    if ($('input[name="userId"]').val() == 'admin') {
                        $.popWindow("../common/selectPriv?2&moduleId="+moduleId);
                    } else {
                        $.popWindow("../common/selectPriv?0&moduleId="+moduleId);
                    }
                });
                $("#selectUser2").on("click", function () {
                    priv_id = 'senduser2';
                    $.popWindow("../common/selectPriv?moduleId="+moduleId);
                });
                $("#selectUsers").on("click", function () {
                    priv_id = 'sendusers';
                    $.popWindow("../common/selectPriv?moduleId="+moduleId);
                });
                $('.newBtnone').click(function () {
                    dept_id = 'departments'
                    $.popWindow("../common/selectDept?moduleId="+moduleId);
                })
                $('.postDeptBtn').click(function () {
                    dept_id = 'postDept'
                    $.popWindow("../common/selectDept?moduleId="+moduleId);
                })
                $('#tr_Up').click(function () {
                    $('.trOption').toggle();
                })
                $('#trOther').click(function () {
                    $('.otherOption').toggle();
                })
                $('#selectUser7').click(function () {
                    user_id = 'senduser7';
                    $.popWindow("../common/selectUser?moduleId="+moduleId);
                })
                $('#selectUser8').click(function () {
                    dept_id = 'senduser8';
                    $.popWindow("../common/selectDept?moduleId="+moduleId);
                })
                //选其他所属组织
                $('#selectOrg').click(function () {
                    org_id = 'mhOrg';
                    $.popWindow("../common/selectOtherOrg?moduleId="+moduleId);
                })
                //清空所选组织
                $('.clearOrg').click(function () {
                   $('#mhOrg').val('');
                   $('#mhOrg').attr('oid','');
                })
                if (location.href.split('?')[1] != 0) {
                    $.ajax({
                        type: 'get',
                        url: '/syspara/checkDemo',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                $('#passHide').show();
                            } else {
                                $('#passHide').hide();
                            }
                        }
                    })
                }

                //           用户名查重
                var uidd = window.location.search
                if (uidd.indexOf('?') >= 0) {
                    if (uidd.indexOf('=') >= 0) {
                        uidd = null
                    } else {
                        uidd = uidd.replace('?', '')
                    }

                } else {
                    uidd = null
                }
                $('input[name="userId"]').blur(function () {
                    var that = $(this);
                    var byName = $(this).val();
                    $.ajax({
                        type: 'post',
                        url: '/user/selectIsExistUser',
                        dataType: 'json',
                        data: {
                            byname: byName,
                            uid: uidd
                        },
                        success: function (res) {
                            if (res.flag) {
                                that.siblings('.span1').html('该用户名已经存在');
                                that.focus()
                            } else {
                                that.siblings('.span1').html('');
                            }
                        }
                    })
                })
                //            身份证号验证
                $('input[name="idNumber"]').blur(function () {
                    var that = $(this);
                    var idNumber = $(this).val();
                    if (idNumber != '') {
                        isCardNo(idNumber);
                    } else {
                        that.siblings('span').html('');
                    }
                })

                // 查询密码限制长度
                var passWordMin = 6, passWordMax = 20;
                $.ajax({
                    url: "/user/getPwRule",
                    type: "get",
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            var obj = res.object;
                            passWordMin = obj.secPassMin;
                            passWordMax = obj.secPassMax;
                            start = passWordMin;
                            end = passWordMax;
                            $('.passWordRuleSpan').html(passWordMin + "-" + passWordMax);
                        }
                    }
                });
                var timer = null;

                $('#btn1').click(function () {
                    var userSecrecyInfo = $('select[name=userSecrecy]').val() || "";
                    var postPrivInfo = $('#postPriv').val() || "";
                    var postDeptInfo = $('#postDept').attr("deptid") || "";
                    if(isOpenSanyuan && (userSev != userSecrecyInfo || postDeptInfo!= postPrivInfo || postDeptInfo != postDeptId ) && secretInfo == 0 && isAdd != 0) {
                        saveEXaInfo(function() {
                            clearTimeout(timer);
                            timer = setTimeout(function () {
                                if ($('input[name="userId"]').val() == '') {
                                    layer.msg('<fmt:message code="user.th.userName" />', {icon: 5});
                                    return;
                                }
                                if(qiParaValue == 'septwolves' ){
                                    if ($('input[name="userId2"]').val() == '') {
                                        layer.msg('请填写用户ID', {icon: 5});
                                        return;
                                    }
                                }
                                if ($('input[name="userName"]').val() == '') {
                                    layer.msg('<fmt:message code="user.th.realName" />', {icon: 5});
                                    return;
                                }
                                if ($('#senduser1').attr('userPriv') == undefined) {
                                    layer.msg('<fmt:message code="user.th.leadingColors" />', {icon: 5});
                                    return
                                }
                                if ($('#department').val() == -1 || $('#department').val() == "") {
                                    layer.msg('<fmt:message code="user.th.selectDepartment" />', {icon: 5});
                                    return
                                }
                                var departmentId = $('#department').val()
                                if ($('#departments').attr('deptid') != undefined) {
                                    var departmentOtherId = $('#departments').attr('deptid').substring(0, $('#departments').attr('deptid').length - 1).split(',')
                                }
                                if (departmentOtherId != undefined) {
                                    for (var i = 0; i < departmentOtherId.length; i++) {
                                        if (departmentOtherId[i] == departmentId) {
                                            layer.msg('部门和其他所属部门有相同部门，请重新选择！', {icon: 0});
                                            return false
                                        }
                                    }
                                }
                                var emailCapacity = $('input[name="emailCapacity"]').val();
                                if (emailCapacity == null || emailCapacity == "") {
                                    $('input[name="emailCapacity"]').val(0);
                                }

                                var folderCapacity = $('input[name="folderCapacity"]').val();
                                if (folderCapacity == null || folderCapacity == "") {
                                    $('input[name="folderCapacity"]').val(0);
                                }

                                if (is_ZDJ && isAdd == 0) {
                                    if ($('input[name="idNumber"]').val() == '') {
                                        layer.msg('请填写身份证号', {icon: 5});
                                        return;
                                    }

                                    if ($('input[name="password"]').val() == '') {
                                        layer.msg('请填写密码', {icon: 5});
                                        return;
                                    }

                                    if ($('input[name="mobilNo"]').val() == '') {
                                        layer.msg('请填写手机号', {icon: 5});
                                        return;
                                    }
                                }

                                var notLogin = $('input:radio[name="notLogin"]:checked').val();
                                var notMobileLogin = $('input:radio[name="notMobileLogin"]:checked').val();
                                var isLunar = '';
                                var mobilNoHidden = '';
                                var notViewUserstr;
                                var notViewTablestr;
                                var useingKeystr, usingFingerstr, usePop3str, useEmailstr;
                                if ($('[name="notViewUser"]').is(':checked')) {
                                    notViewUserstr = 1
                                } else {
                                    notViewUserstr = 0
                                }
                                if ($('[name="usePop3"]').is(':checked')) {
                                    usePop3str = 1
                                } else {
                                    usePop3str = 0
                                }
                                if ($('[name="useEmail"]').is(':checked')) {
                                    useEmailstr = 1
                                } else {
                                    useEmailstr = 0
                                }
                                if ($('[name="notViewTable"]').is(':checked')) {
                                    notViewTablestr = 1
                                } else {
                                    notViewTablestr = 0
                                }
                                if ($('[name="useingKey"]').is(':checked')) {
                                    useingKeystr = 1
                                } else {
                                    useingKeystr = 0
                                }
                                if ($('[name="usingFinger"]').is(':checked')) {
                                    usingFingerstr = 1
                                } else {
                                    usingFingerstr = 0
                                }
                                if ($('input[name="isLunar"]').prop('checked') == true) {
                                    isLunar = 1;
                                } else {
                                    isLunar = 0;
                                }
                                if ($('input[name="mobilNoHidden"]').prop('checked') == true) {
                                    mobilNoHidden = 0;
                                } else {
                                    mobilNoHidden = 1;
                                }
                                var sexs = $('select[name="sex"] option:checked').val();
                                if (sexs == '') {
                                    var sexs = 0;
                                }
                                if (Number($('input[name="userNo"]').val()) > 65535) {
                                    layer.msg('用户排序号不能大于65535', {icon: 5});
                                    return false;
                                }
                                var deptYj = "";
                                var deptYj1 = $("input[name='deptYj']:checked").each(function (j) {

                                    if (j >= 0) {
                                        deptYj += $(this).val() + ","

                                    }
                                });
                                var theme
                                var style = $('.trOption').css("display")
                                if (style == 'none') {
                                    theme = '';
                                }
                                if (style == 'table-row') {
                                    theme = $('select[name="THEME"] option:checked').val()
                                }

                                var data = {
                                    operationReason:operationReason,
                                    attachmentId:attachmentId.join(","),
                                    attachmentName:attachmentName.join(","),
                                    'postDept':$("#postDept").attr("deptid") || "",
                                    'userSecrecy':$('.userSecrecy').val() || "",
                                    'theme': theme,
                                    'byname': $('input[name="userId"]').val(),
                                    'userName': $('input[name="userName"]').val(),
                                    'userPriv': $('#senduser1').attr('userpriv').replace(/,/g, ''),
                                    'deptId': $('select[name="deptId"] option:checked').val(),
                                    'userNo': $('input[name="userNo"]').val(),
                                    'postPriv': $('select[name="postPriv"] option:checked').val(),
                                    'imRange': $('select[name="imRange"] option:checked').val(),
                                    'notLogin': notLogin,
                                    'notViewUser': notViewUserstr,
                                    'notViewTable': notViewTablestr,
                                    'notMobileLogin': notMobileLogin,
                                    'useingKey': useingKeystr,
                                    'usingFinger': usingFingerstr,
                                    'useEmail': useEmailstr,
                                    'usePop3': usePop3str,
                                    'simpleInterface':$('input[name="simpleInterface"]:checked').val(),
                                    'userPrivOther': $('#sendusers').attr('userpriv'),
                                    'webmailNum': $('[name="webmailNum"]').val(),
                                    'webmailCapacity': $('[name="webmailCapacity"]').val(),
                                    'dutyType': $('[name="twoSele"]').val(),
                                    'emailCapacity': $('[name="emailCapacity"]').val(),
                                    // 'folderCapacity': $('[name="folderCapacity"]').val(),
                                    'bindIp': $('#bindIp').val(),
                                    'remark': $('#remark').val(),
                                    'password': $('input[name="password"]').val(),
                                    'sex': sexs,
                                    'birthday': $('input[name="birthday"]').val(),
                                    'isLunar': isLunar,
                                    'mobilNo': $('input[name="mobilNo"]').val(),
                                    'mobilNoHidden': mobilNoHidden,
                                    'email': $('input[name="email"]').val(),
                                    'telNoDept': $('input[name="telNoDept"]').val(),
                                    'deptIdOther': $('#departments').attr('deptid'),
                                    'privIds': $('#senduser2').attr('userpriv'),
                                    'userIds': $('#senduser7').attr('user_id'),
                                    'deptIds': $('#senduser8').attr('deptid'),
                                    "subject": $('.subject option:selected').val(),
                                    'idNumber': $('input[name="idNumber"]').val(),
                                    'traNumber': $('input[name="traNumber"]').val(),
                                    'postId': $('select[name="postId"]').val(),
                                    'employmentType': $('select[name="employmentType"]').val(),
                                    'jobId': $('select[name="jobId"]').val(),
                                    'jobLevel': $('select[name="jobLevel"]').val(),
                                    'deptYj': deptYj,
                                    'roomNum': $('input[name="roomNum"]').val(),
                                    'signImageId': $('input[name="signImageId"]').val(),
                                    'signImageName': $('input[name="signImageName"]').val(),
                                    'folderCapacity': $('input[name="folderCapacity"]').val(),
                                    'msn': $('input[name="msn"]').val(), //教育服务号
                                    'mhOrg': $('#mhOrg').attr('oid'),//其他组织
                                    'domainUserName': $('input[name="domainUserName"]').val(),
                                    moduleId: 11
                                    // 'userId':$('input[name="userId2"]').val()
                                };
                                if(qiParaValue == 'septwolves'){
                                    data.userId = $('input[name="userId2"]').val()
                                }else{
                                    if($('input[name="userId2"]').val() != '' && $('.qipilang').css('display') != 'none'){
                                        data.userId = $('input[name="userId2"]').val()
                                    }
                                }
                                if (isAdd == 0) {
                                    var reg = /^[0-9]*$/; //数字
                                    var reg1 = /^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
                                    var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
                                    var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
                                    var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
                                    //                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
                                    var values = $('input[name="password"]').val()
                                    if (values != "") {
                                        if (flag == 0) {
                                            if (values != "") {
                                                if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            }
                                        } else if (flag == 1) {
                                            if (!reg1.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 2) {
                                            if (!reg2.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 3) {
                                            if (!reg3.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 4) {
                                            if (!reg4.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            }
                                        }
                                    }
                                    var loadIndex = layer.load()
                                    $.ajax({
                                        type: 'post',
                                        url: '/user/addUser',
                                        dataType: 'json',
                                        data: data,
                                        success: function (rsp) {
                                            if (rsp.flag == true) {
                                                layer.open({
                                                    title: '<fmt:message code="depatement.th.Newsuccessfully" />',
                                                    content: '<fmt:message code="user.thbuildingNew" />',
                                                    btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="global.lang.close" />'],
                                                    yes: function (index) {
                                                        location.reload()
                                                    },
                                                    btn2: function (index) {
                                                        //                                        parent.opener.ajaxdata(window.opener.numdept);
                                                        var deptIds = $('#department').val();
                                                        window.close();
                                                        if (window.opener.$('[deptid="' + deptIds + '"]') != undefined) {
                                                            window.opener.$('[deptid="' + deptIds + '"]').click();
                                                        }
                                                    }
                                                });
                                            } else {
                                                layer.close(loadIndex);
                                                $.layerMsg({content: '保存失败', icon: 2});
                                            }
                                        },
                                        error: function () {
                                            layer.close(loadIndex);
                                            $.layerMsg({content: '保存失败', icon: 2});
                                        }
                                    })
                                } else {
                                    if ($('input[name="password"]').val() != "") {
                                        var reg = /^[0-9]*$/; //数字
                                        var reg1 = /^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
                                        var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
                                        var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
                                        var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
                                        //                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
                                        var values = $('input[name="password"]').val()
                                        if (values != "") {
                                            if (flag == 0) {
                                                if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            } else if (flag == 1) {
                                                if (!reg1.test(values)) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            } else if (flag == 2) {
                                                if (!reg2.test(values)) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            } else if (flag == 3) {
                                                if (!reg3.test(values)) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            } else if (flag == 4) {
                                                if (!reg4.test(values)) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length < start) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                } else if (values.toString().length > end) {
                                                    $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                    return false;
                                                }
                                            }
                                        }
                                    }
                                    data.uid = location.href.split('?')[1];
                                    var loadIndex = layer.load();
                                    if (is_ZDJ) {
                                        $.get('/department/ifJurisdiction?moduleId=11', {
                                            updateUserId: data.uid,
                                            deptId: data.deptId,
                                            deptIdOther: data.deptIdOther
                                        }, function (res) {
                                            if (res.data) {
                                                editUser();
                                            } else {
                                                layer.close(loadIndex);
                                                layer.msg('无调整部门权限！', {icon: 0});
                                            }
                                        });
                                    } else {
                                        editUser();
                                    }
                                    function editUser() {
                                        $.ajax({
                                            type: 'post',
                                            url: '/user/editUser',
                                            dataType: 'json',
                                            data: data,
                                            success: function (rsp) {
                                                if (rsp.flag == true) {
                                                    $.layerMsg({content: '保存成功', icon: 1}, function () {
                                                        var deptIds = $('#department').val();
                                                        window.close();
                                                        if (window.opener.$('[deptid="' + deptIds + '"]') != undefined) {
                                                            window.opener.$('[deptid="' + deptIds + '"]').click();
                                                        }
                                                    });
                                                } else {
                                                    layer.close(loadIndex);
                                                    $.layerMsg({content: rsp.msg, icon: 2});
                                                }
                                            },
                                            error: function () {
                                                layer.close(loadIndex);
                                                $.layerMsg({content: '保存失败', icon: 2});
                                            }
                                        })
                                    }
                                }
                            }, 300);
                        })
                    }else {
                        clearTimeout(timer);
                        timer = setTimeout(function () {
                            if ($('input[name="userId"]').val() == '') {
                                layer.msg('<fmt:message code="user.th.userName" />', {icon: 5});
                                return;
                            }
                            if(qiParaValue == 'septwolves' ){
                                if ($('input[name="userId2"]').val() == '') {
                                    layer.msg('请填写用户ID', {icon: 5});
                                    return;
                                }
                            }
                            if ($('input[name="userName"]').val() == '') {
                                layer.msg('<fmt:message code="user.th.realName" />', {icon: 5});
                                return;
                            }
                            if ($('#senduser1').attr('userPriv') == undefined) {
                                layer.msg('<fmt:message code="user.th.leadingColors" />', {icon: 5});
                                return
                            }
                            if ($('#department').val() == -1 || $('#department').val() == "") {
                                layer.msg('<fmt:message code="user.th.selectDepartment" />', {icon: 5});
                                return
                            }
                            var departmentId = $('#department').val()
                            if ($('#departments').attr('deptid') != undefined) {
                                var departmentOtherId = $('#departments').attr('deptid').substring(0, $('#departments').attr('deptid').length - 1).split(',')
                            }
                            if (departmentOtherId != undefined) {
                                for (var i = 0; i < departmentOtherId.length; i++) {
                                    if (departmentOtherId[i] == departmentId) {
                                        layer.msg('部门和其他所属部门有相同部门，请重新选择！', {icon: 0});
                                        return false
                                    }
                                }
                            }
                            var emailCapacity = $('input[name="emailCapacity"]').val();
                            if (emailCapacity == null || emailCapacity == "") {
                                $('input[name="emailCapacity"]').val(0);
                            }

                            var folderCapacity = $('input[name="folderCapacity"]').val();
                            if (folderCapacity == null || folderCapacity == "") {
                                $('input[name="folderCapacity"]').val(0);
                            }

                            if (is_ZDJ && isAdd == 0) {
                                if ($('input[name="idNumber"]').val() == '') {
                                    layer.msg('请填写身份证号', {icon: 5});
                                    return;
                                }

                                if ($('input[name="password"]').val() == '') {
                                    layer.msg('请填写密码', {icon: 5});
                                    return;
                                }

                                if ($('input[name="mobilNo"]').val() == '') {
                                    layer.msg('请填写手机号', {icon: 5});
                                    return;
                                }
                            }

                            var notLogin = $('input:radio[name="notLogin"]:checked').val();
                            var notMobileLogin = $('input:radio[name="notMobileLogin"]:checked').val();
                            var isLunar = '';
                            var mobilNoHidden = '';
                            var notViewUserstr;
                            var notViewTablestr;
                            var useingKeystr, usingFingerstr, usePop3str, useEmailstr;
                            if ($('[name="notViewUser"]').is(':checked')) {
                                notViewUserstr = 1
                            } else {
                                notViewUserstr = 0
                            }
                            if ($('[name="usePop3"]').is(':checked')) {
                                usePop3str = 1
                            } else {
                                usePop3str = 0
                            }
                            if ($('[name="useEmail"]').is(':checked')) {
                                useEmailstr = 1
                            } else {
                                useEmailstr = 0
                            }
                            if ($('[name="notViewTable"]').is(':checked')) {
                                notViewTablestr = 1
                            } else {
                                notViewTablestr = 0
                            }
                            if ($('[name="useingKey"]').is(':checked')) {
                                useingKeystr = 1
                            } else {
                                useingKeystr = 0
                            }
                            if ($('[name="usingFinger"]').is(':checked')) {
                                usingFingerstr = 1
                            } else {
                                usingFingerstr = 0
                            }
                            if ($('input[name="isLunar"]').prop('checked') == true) {
                                isLunar = 1;
                            } else {
                                isLunar = 0;
                            }
                            if ($('input[name="mobilNoHidden"]').prop('checked') == true) {
                                mobilNoHidden = 0;
                            } else {
                                mobilNoHidden = 1;
                            }
                            var sexs = $('select[name="sex"] option:checked').val();
                            if (sexs == '') {
                                var sexs = 0;
                            }
                            if (Number($('input[name="userNo"]').val()) > 65535) {
                                layer.msg('用户排序号不能大于65535', {icon: 5});
                                return false;
                            }
                            var deptYj = "";
                            var deptYj1 = $("input[name='deptYj']:checked").each(function (j) {

                                if (j >= 0) {
                                    deptYj += $(this).val() + ","

                                }
                            });
                            var theme
                            var style = $('.trOption').css("display")
                            if (style == 'none') {
                                theme = '';
                            }
                            if (style == 'table-row') {
                                theme = $('select[name="THEME"] option:checked').val()
                            }

                            var data = {
                                operationReason:operationReason,
                                attachmentId:attachmentId.join(","),
                                attachmentName:attachmentName.join(","),
                                'postDept':$("#postDept").attr("deptid") || "",
                                'userSecrecy':$('.userSecrecy').val() || "",
                                'theme': theme,
                                'byname': $('input[name="userId"]').val(),
                                'userName': $('input[name="userName"]').val(),
                                'userPriv': $('#senduser1').attr('userpriv').replace(/,/g, ''),
                                'deptId': $('select[name="deptId"] option:checked').val(),
                                'userNo': $('input[name="userNo"]').val(),
                                'postPriv': $('select[name="postPriv"] option:checked').val(),
                                'imRange': $('select[name="imRange"] option:checked').val(),
                                'notLogin': notLogin,
                                'notViewUser': notViewUserstr,
                                'notViewTable': notViewTablestr,
                                'notMobileLogin': notMobileLogin,
                                'useingKey': useingKeystr,
                                'usingFinger': usingFingerstr,
                                'useEmail': useEmailstr,
                                'usePop3': usePop3str,
                                'simpleInterface':$('input[name="simpleInterface"]:checked').val(),
                                'userPrivOther': $('#sendusers').attr('userpriv'),
                                'webmailNum': $('[name="webmailNum"]').val(),
                                'webmailCapacity': $('[name="webmailCapacity"]').val(),
                                'dutyType': $('[name="twoSele"]').val(),
                                'emailCapacity': $('[name="emailCapacity"]').val(),
                                // 'folderCapacity': $('[name="folderCapacity"]').val(),
                                'bindIp': $('#bindIp').val(),
                                'remark': $('#remark').val(),
                                'password': $('input[name="password"]').val(),
                                'sex': sexs,
                                'birthday': $('input[name="birthday"]').val(),
                                'isLunar': isLunar,
                                'mobilNo': $('input[name="mobilNo"]').val(),
                                'mobilNoHidden': mobilNoHidden,
                                'email': $('input[name="email"]').val(),
                                'telNoDept': $('input[name="telNoDept"]').val(),
                                'deptIdOther': $('#departments').attr('deptid'),
                                'privIds': $('#senduser2').attr('userpriv'),
                                'userIds': $('#senduser7').attr('user_id'),
                                'deptIds': $('#senduser8').attr('deptid'),
                                "subject": $('.subject option:selected').val(),
                                'idNumber': $('input[name="idNumber"]').val(),
                                'traNumber': $('input[name="traNumber"]').val(),
                                'postId': $('select[name="postId"]').val(),
                                'employmentType': $('select[name="employmentType"]').val(),
                                'jobId': $('select[name="jobId"]').val(),
                                'jobLevel': $('select[name="jobLevel"]').val(),
                                'deptYj': deptYj,
                                'roomNum': $('input[name="roomNum"]').val(),
                                'signImageId': $('input[name="signImageId"]').val(),
                                'signImageName': $('input[name="signImageName"]').val(),
                                'folderCapacity': $('input[name="folderCapacity"]').val(),
                                'msn': $('input[name="msn"]').val(), //教育服务号
                                'mhOrg': $('#mhOrg').attr('oid'),//其他组织
                                'domainUserName': $('input[name="domainUserName"]').val(),
                                moduleId: 11
                                // 'userId':$('input[name="userId2"]').val()
                            };
                            if(qiParaValue == 'septwolves'){
                                data.userId = $('input[name="userId2"]').val()
                            }else{
                                if($('input[name="userId2"]').val() != '' && $('.qipilang').css('display') != 'none'){
                                    data.userId = $('input[name="userId2"]').val()
                                }
                            }
                            if (isAdd == 0) {
                                var reg = /^[0-9]*$/; //数字
                                var reg1 = /^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
                                var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
                                var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
                                var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
                                //                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
                                var values = $('input[name="password"]').val()
                                if (values != "") {
                                    if (flag == 0) {
                                        if (values != "") {
                                            if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                return false;
                                            }
                                        }
                                    } else if (flag == 1) {
                                        if (!reg1.test(values)) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length < start) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length > end) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        }
                                    } else if (flag == 2) {
                                        if (!reg2.test(values)) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length < start) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length > end) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        }
                                    } else if (flag == 3) {
                                        if (!reg3.test(values)) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length < start) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length > end) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                            return false;
                                        }
                                    } else if (flag == 4) {
                                        if (!reg4.test(values)) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length < start) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        } else if (values.toString().length > end) {
                                            $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                            return false;
                                        }
                                    }
                                }
                                var loadIndex = layer.load()
                                if(isOpenSanyuan && !data.password) {
                                    layer.close(loadIndex);
                                    layer.msg("请填写密码",{icon:2})
                                    return
                                }
                                $.ajax({
                                    type: 'post',
                                    url: '/user/addUser',
                                    dataType: 'json',
                                    data: data,
                                    success: function (rsp) {
                                        if (rsp.flag == true) {
                                            layer.open({
                                                title: '<fmt:message code="depatement.th.Newsuccessfully" />',
                                                content: '<fmt:message code="user.thbuildingNew" />',
                                                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="global.lang.close" />'],
                                                yes: function (index) {
                                                    location.reload()
                                                },
                                                btn2: function (index) {
                                                    //                                        parent.opener.ajaxdata(window.opener.numdept);
                                                    var deptIds = $('#department').val();
                                                    window.close();
                                                    if (window.opener.$('[deptid="' + deptIds + '"]') != undefined) {
                                                        window.opener.$('[deptid="' + deptIds + '"]').click();
                                                    }
                                                }
                                            });
                                        } else {
                                            layer.close(loadIndex);
                                            $.layerMsg({content: '保存失败', icon: 2});
                                        }
                                    },
                                    error: function () {
                                        layer.close(loadIndex);
                                        $.layerMsg({content: '保存失败', icon: 2});
                                    }
                                })
                            } else {
                                if ($('input[name="password"]').val() != "") {
                                    var reg = /^[0-9]*$/; //数字
                                    var reg1 = /^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
                                    var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
                                    var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
                                    var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
                                    //                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
                                    var values = $('input[name="password"]').val()
                                    if (values != "") {
                                        if (flag == 0) {
                                            if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 1) {
                                            if (!reg1.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 2) {
                                            if (!reg2.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 3) {
                                            if (!reg3.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字', icon: 6, time: 3000})
                                                return false;
                                            }
                                        } else if (flag == 4) {
                                            if (!reg4.test(values)) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length < start) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            } else if (values.toString().length > end) {
                                                $.layerMsg({content: '您输入的密码格式不正确，要求密码长度为' + start + '-' + end + '位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符', icon: 6, time: 3000})
                                                return false;
                                            }
                                        }
                                    }
                                }
                                data.uid = location.href.split('?')[1];
                                var loadIndex = layer.load();
                                if (is_ZDJ) {
                                    $.get('/department/ifJurisdiction?moduleId=11', {
                                        updateUserId: data.uid,
                                        deptId: data.deptId,
                                        deptIdOther: data.deptIdOther
                                    }, function (res) {
                                        if (res.data) {
                                            editUser();
                                        } else {
                                            layer.close(loadIndex);
                                            layer.msg('无调整部门权限！', {icon: 0});
                                        }
                                    });
                                } else {
                                    editUser();
                                }
                                function editUser() {
                                    $.ajax({
                                        type: 'post',
                                        url: '/user/editUser',
                                        dataType: 'json',
                                        data: data,
                                        success: function (rsp) {
                                            if (rsp.flag == true) {
                                                $.layerMsg({content: '保存成功', icon: 1}, function () {
                                                    var deptIds = $('#department').val();
                                                    window.close();
                                                    if (window.opener.$('[deptid="' + deptIds + '"]') != undefined) {
                                                        window.opener.$('[deptid="' + deptIds + '"]').click();
                                                    }
                                                });
                                            } else {
                                                layer.close(loadIndex);
                                                $.layerMsg({content: '保存失败', icon: 2});
                                            }
                                        },
                                        error: function () {
                                            layer.close(loadIndex);
                                            $.layerMsg({content: '保存失败', icon: 2});
                                        }
                                    })
                                }
                            }
                        }, 300);
                    }

                })
                function saveEXaInfo(fn) {
                    layer.open({
                        type: 1,
                        title: "变更理由",
                        area: ['900px', '500px'],
                        btn: ['确定', '取消'],
                        content: '<div style="width:800px;margin:10px auto;">' +
                                '<div style="color: red;">提示: 修改了用户密级或者管理范围，需保密员审批后生效</div>'+
                            '<table style="margin: 0;border: none;"><tr class="Attachment" style="border:none;">\n' +
                            '<td style="border:none;" width="20%">附件信息：</td>\n' +
                            '<td style="border:none;" width="80%"   class="files" id="files_txt">\n' +
                            '<div id="fileContent"></div>\n' +
                            '</td>\n' +
                            '</tr></table>'+
                            '<form method="post" action="/upload?module=sys">       <div class="layui-form-item" style="margin: 10px 0;"> '+
                            '                                        <label class="layui-form-label" style="display: inline-block;font-size: 14px;">上传附件:</label> '+
                            '                                        <div class="layui-input-block" style="line-height: 36px; display: inline-block"> '+
                            '<input type="file" multiple="multiple" name="file"  id="fileInp" style="border:none; display:inline-block; cursor:pointer;width: 62px;">'+
                            '                                 </div>' +
                            '                                   </div>' +

                            '</form>'+
                            ' <div class="layui-form-item layui-form-text">\n' +
                            '    <label class="layui-form-label" style="display: inline-block;vertical-align: top;font-size: 14px;">变更理由:</label>\n' +
                            '    <div class="layui-input-block" style="display: inline-block;">\n' +
                            '      <textarea name="approvalOpinion" placeholder="请输入理由" class="layui-textarea" style="width: 600px;height: 200px;"></textarea>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>',
                        success:function() {
                            //附件删除
                            $('#files_txt').on('click','.deImgs',function(){
                                var data=$(this).parents('.dech').attr('deUrl');
                                var dome=$(this).parents('.dech');
                                deleteChatment(data,dome);
                            })
                            fileuploadFn('#fileInp',$('.Attachment td').eq(1));
                        },
                        btn1:function(index) {
                            var doms = $('.inHidden');
                            for(var i = 0; i < doms.length; i++) {
                                attachmentId.push($(doms[i]).val())
                                attachmentName.push($(doms[i]).parents(".dech").attr("name1"))
                            }
                            operationReason = $('[name=approvalOpinion]').val();
                                fn()
                                layer.close(index)
                        }
                    })
                }
                $('select[name=postPriv]').on("change",function() {
                    if(isAdd == 0) {
                        return
                    }
                    if($(this).val() == 2) {
                        $('.postDeptContainer').show();
                    }else {
                        $('.postDeptContainer').hide();
                    }
                })
                //点击按模块设置管理范围的方法
                $("#managementScope").on("click", function () {
                    names = $('input[name="userName"]').val()
                    $.popWindow("modulePriv/ManagementScope?userId=" + location.href.split('?')[1]+'&moduleId=11');
                });
            })

            function GetQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]);
                return null;
            }

            function fun(obj) {
                number = parseInt(document.getElementById("number").value);
            }

        </script>
    </head>
    <body>
        <div class="content">
            <div class="title" style="margin-top: 20px;">
                <span class="titleTxt"><fmt:message code="userManagement.th.NewUser"/></span>
                <span class="subText" style="font-family: Microsoft yahei; font-weight: bolder; font-size: 12pt; color:red; display: none;">机密级★</span>
            </div>
            <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td colspan="2" style="color: #3eb1f0"><fmt:message code="user.th.UserBasicInformation"/></td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="global.lang.user"/>：</td>
                    <td width="70%">
                        <input type="text" name="userId" data-options="required:true" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                        <span style="color: #ff0000;font-size: 10pt;" class="span1"></span>
                        <span style="color: #ff0000;font-size: 10pt;">*</span>
                        <a href="javascript:;" class="userIdTip" id="setUserId">手动设置用户ID</a>
                    </td>
                </tr>
                <tr style="display: none" class="qipilang">
                    <td width="15%"><fmt:message code="journal.th.user"/>ID：</td>
                    <td width="70%">
                        <input type="text" name="userId2" data-options="required:true" />
                        <span style="color: #ff0000;font-size: 10pt;" class="span1"></span>
                        <span style="color: #ff0000;font-size: 10pt;" class="mustWrite">*</span>
                        <span style="color: #ff0000;font-size: 10pt;" class="userIdTip">用户ID一般可以自动生成，无需手动设置</span>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userManagement.th.Realname"/>：</td>
                    <td width="70%">
                        <input type="text" name="userName" data-options="required:true" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                        <span style="color: #ff0000;font-size: 10pt;">*</span>
                    </td>
                </tr>
                <tr class="bindYu" style="display: none">
                    <td width="15%">绑定域用户：</td>
                    <td width="70%">
                        <input type="text" name="domainUserName" data-options="required:true"/>
                    </td>
                </tr>

                <tr>
                    <td width="15%"><fmt:message code="user.th.UserNumber"/>：</td>
                    <td width="70%">
                        <input type="text" id = "number" name="userNo" value="10" onkeyup="fun(this);">
                        <span><fmt:message code="user.th.SortUsers"/></span>
                    </td>
                </tr>

                <tr>
                    <td width="15%"><fmt:message code="url.th.Leading"/>：</td>
                    <td width="70%">
                        <input type="text" name="txtsenduser" id="senduser1" readonly="" user_id='' value="">
                        <span style="color: #ff0000;font-size: 10pt;">*</span>
                        <a href="javascript:;" id="selectUser1" class="Add addUserPriv"><fmt:message code="global.lang.select"/></a>
                        <a href="javascript:;" class="clearData clearUserPriv"><fmt:message code="global.lang.empty"/></a>
                        <a href="javascript:;" id="selectUsertwo" class="Add "><fmt:message code="user.th.AddRoles"/></a>
                    </td>
                </tr>
                <tr id="fuzhuPriv" style="display: none">
                    <td width="15%"><fmt:message code="userDetails.th.AuxiliaryRole"/>：</td>
                    <td width="70%">
                        <textarea name="txtsendusers" id="sendusers" readonly="" user_id='' value=""></textarea>
                        <span style="color: #ff0000;font-size: 10pt;"></span>
                        <a href="javascript:;" id="selectUsers" class="Add "><fmt:message code="global.lang.select"/></a>
                        <a href="javascript:;" class="clearData"><fmt:message code="global.lang.empty"/></a>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userManagement.th.department"/>：</td>
                    <td width="70%">
                        <select id="department" name="deptId" style="width: 200px;">
                        </select>
                        <span style="color: #ff0000;font-size: 10pt;margin-left: 10px;">*</span>
                        <a href="javascript:;" class="departmentbu"><fmt:message code="user.th.DesignatedOther"/></a>
                    </td>
                </tr>
                <tr id="otherDept" style="display: none">
                    <td width="15%"><fmt:message code="user.th.OtherDepartments"/>：</td>
                    <td width="70%">
                        <textarea name="departmentname" id="departments" readonly></textarea>
                        <a href="javascript:;" class="newBtnone"><fmt:message code="global.lang.add"/></a>
                        <a href="javascript:;" class="clearData"><fmt:message code="global.lang.empty"/></a>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="hr.th.post"/>：</td>
                    <td width="70%">
                        <select name="jobId" style="width: 200px;">
                            <option value=""><fmt:message code="sys.th.fillPost"/></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.PostLevel"/>：</td>
                    <td width="70%">
                        <select name="jobLevel" style="width: 200px;">
                            <option value=""><fmt:message code="userDetails.th.PostLevelSelect"/></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.post"/>：</td>
                    <td width="70%">
                        <select name="postId" style="width: 200px;">
                            <option value="0"><fmt:message code="sys.th.fillRet"/></option>
                        </select>
                    </td>
                </tr>
                <%--人员类型--%>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.type"/>：</td>
                    <td width="70%">
                        <select name="employmentType" style="width: 200px;">
                            <option value=""><fmt:message code="global.lang.select"/></option>
                        </select>
                    </td>
                </tr>

<%--                <tr>--%>
<%--                    <td width="15%"><fmt:message code="user.th.UserNumber"/>：</td>--%>
<%--                    <td width="70%">--%>
<%--                        <input type="text" name="userNo" value="10">--%>
<%--                        <span><fmt:message code="user.th.SortUsers"/></span>--%>
<%--                    </td>--%>
<%--                </tr>--%>

                <tr>
                    <td width="15%"><fmt:message code="hr.th.IDNumber"/>：</td>
                    <td width="70%">
                        <input type="text" name="idNumber" value="">
                        <span id="numberName" style="color: #ff0000;font-size: 10pt;"></span>
                    </td>
                </tr>
                <tr class="userSecrecyInfo">
                    <td width="15%">密级：</td>
                    <td width="70%">
                        <select name="userSecrecy" class="userSecrecy" style="width: 200px;">
                        </select>
                    </td>
                </tr>
                <tr class="eduService" style="display: none">
                    <td width="15%">教育服务号：</td>
                    <td width="70%">
                        <input type="text" name="msn" value="">
                    </td>
                </tr>
                <tr class="jiaoyu">
                    <td width="15%"><fmt:message code="sys.th.planNo"/>：</td>
                    <td width="70%">
                        <input type="text" name="traNumber" value="">
                    </td>
                </tr>
                <tr class="jiaoyu">
                    <td width="15%"><fmt:message code="sys.th.subject"/>：</td>
                    <td width="70%">
                        <select name="" class="subject" name="subject">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="color:#3eb1f0 "><fmt:message code="user.th.UserRights"/></td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userManagement.th.ManagementScope"/>：</td>
                    <td width="70%">
                        <select name="postPriv">
                            <option value="0"><fmt:message code="sys.th.ThisDepartment"/></option>
                            <option value="1"><fmt:message code="url.th.all"/></option>
                            <option value="2"><fmt:message code="sys.th.DesignatedDepartment"/></option>
                        </select>
                        <span style="color: #3eb1f0;cursor: pointer;margin-right: 10px" id="managementScope"><fmt:message code="userDetails.th.scopeModule"/></span>
                        <span><fmt:message code="user.th.PlayRole"/></span>
                    </td>
                </tr>
                <tr class="postDeptContainer" style="display: none;">
                    <td width="15%"> <fmt:message code="userDetails.th.DesignatedDepartments"/>：</td>
                    <td width="70%">
                        <textarea name="postDept" id="postDept" readonly></textarea>
                        <a href="javascript:;" class="postDeptBtn"><fmt:message code="global.lang.add"/></a>
                        <a href="javascript:;" class="clearData"><fmt:message code="global.lang.empty"/></a>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="url.th.accessControl"/>：</td>
                    <td width="70%">
                        <div class="divRadio" style="float: left">
                            <input type="radio" checked="true" name="notLogin" value="0">
                            <span><fmt:message code="userDetails.th.loginType1"/></span>
                            <input type="radio" name="notLogin" value="1">
                            <span><fmt:message code="userDetails.th.loginType2"/> </span>
                            <input type="radio" name="notMobileLogin" checked="true" class="appInfo" value="0">
                            <span class="appInfo"><fmt:message code="userDetails.th.loginType3"/></span>
                            <input class="appInfo" type="radio" name="notMobileLogin" value="1">
                            <span class="appInfo"><fmt:message code="userDetails.th.loginType4"/></span>
                        </div>

                    </td>
                </tr>
<%--                <tr>--%>
<%--                    <td width="15%">--%>
<%--                        <span><fmt:message code="user.th.WhiteList"/>：</span>--%>
<%--                        <p><fmt:message code="user.th.SetRole"/></p>--%>
<%--                        <a href="javascript:;" style="color: sandybrown" class="tdAnewrole"><fmt:message code="user.th.SetUp"/></a>--%>
<%--                    </td>--%>
<%--                    <td width="70%">--%>
<%--                        <div class="inPole">--%>
<%--                            <textarea name="txtPrivName" id="senduser2" readonly style="height: 50px;min-height: 50px;"></textarea>--%>
<%--                            <span class="add_img" style="margin-left: 10px">--%>
<%--                                            <a href="javascript:;" id="selectUser2" class="Add "><fmt:message code="global.lang.select"/></a>--%>
<%--                                            <a href="javascript:void (0)" class="clearDataTwo"><fmt:message code="global.lang.empty"/></a>--%>
<%--                                        </span>--%>
<%--                            <span class="add_img">--%>
<%--                                        </span>--%>
<%--                            <p>属于以上所选角色的人员可以给此用户发送邮件和即时消息，角色和人员设置均为空则不限制</p>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.emailLimit" />：</td>
                    <td width="70%">
                        <input type="text" name="emailCapacity" value="100">
                        <p style="display: inline-block">：MB  <fmt:message code="email.th.ForUnlimited" /></p>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.fileLimit" />：</td>
                    <td width="70%">
                        <input type="text" name="folderCapacity" value="100">
                        <p style="display: inline-block">：MB  <fmt:message code="email.th.ForUnlimited" /></p>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.Minimalist" />：</td>
                    <td width="70%">
                        <input type="radio" name="simpleInterface" value="1"><fmt:message code="global.lang.yes" />
                        <input type="radio" name="simpleInterface" value="0"><fmt:message code="global.lang.no" />

                    </td>
                </tr>
                <tr id="otherOrg" style="display: none">
                    <td width="15%">其他所属组织：</td>
                    <td width="70%">
                        <textarea name="mhOrg" id="mhOrg" readonly style="height: 50px;min-height: 50px;"></textarea>
                        <span class="add_img" style="margin-left: 10px">
                              <a href="javascript:;" id="selectOrg" class="Add ">选择</a>
                              <a href="javascript:void (0)" class="clearOrg">清空</a>
                         </span>
                    </td>
                </tr>
<%--                <tr class="trrole" id="anUser" style="display: none">--%>
<%--                    <td width="15%">--%>
<%--                        <span><fmt:message code="user.th.WhiteList"/>：</span>--%>
<%--                        <p><fmt:message code="user.th.SetPersonnel"/></p>--%>
<%--                    </td>--%>
<%--                    <td width="70%">--%>
<%--                        <div class="inPole">--%>
<%--                            <textarea name="txtUserName" id="senduser7" readonly style="height: 50px;min-height: 50px;"></textarea>--%>
<%--                            <span class="add_img" style="margin-left: 10px">--%>
<%--                                            <a href="javascript:;" id="selectUser7" class="Add "><fmt:message code="global.lang.add"/></a>--%>
<%--                                    <a href="javascript:void (0)" class="clearDataTwo"><fmt:message code="global.lang.empty"/></a>--%>
<%--                                        </span>--%>
<%--                            <span class="add_img">--%>
<%--                                        </span>--%>
<%--                            <p><fmt:message code="user.th.Personnel"/></p>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr class="trrole" id="anDept" style="display: none">--%>
<%--                    <td width="15%">--%>
<%--                        <span><fmt:message code="user.th.WhiteList"/>：</span>--%>
<%--                        <p><fmt:message code="user.th.SetDepartment"/></p>--%>
<%--                    </td>--%>
<%--                    <td width="70%">--%>
<%--                        <div class="inPole">--%>
<%--                            <textarea name="txtDeptName" id="senduser8" readonly style="height: 50px;min-height: 50px;"></textarea>--%>
<%--                            <span class="add_img" style="margin-left: 10px">--%>
<%--                                            <a href="javascript:;" id="selectUser8" class="Add "><fmt:message code="global.lang.add"/></a>--%>
<%--                                      <a href="javascript:void (0)" class="clearDataTwo"><fmt:message code="global.lang.empty"/></a>--%>
<%--                                        </span>--%>
<%--                            <span class="add_img">--%>
<%--                                </span>--%>
<%--                            <p><fmt:message code="user.th.withoutRestriction"/></p>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr style="" class="otherOption">
                    <td colspan="2">
                        <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top:0;"></table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><a href="javascript:;" id="tr_Up" style="text-decoration: none;"><fmt:message code="sys.th.user"/></a></td>
                </tr>
                <tr style="" class="trOption">
                    <td colspan="2">
                        <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top:0;">
                            <tr id="passHide">
                                <td width="15%"><fmt:message code="passWord"/>：</td>
                                <td width="70%">
                                    <input type="text" name="password" value="" onfocus="this.type='password'" autocomplete="new-password" style="width: 200px"
                                           onkeydown="validatePwdStrong(this.value);"/>
                                    <span class="passWordRuleSpan">6-20</span><span><fmt:message code="sys.th.zimu"/></span>
                                    <div class="clearfix" style="    width: 206px;height: 10px;border: 1px solid #ccc;margin-top: 5px;border-radius: 4px;" id="main">
                                        <span class="fl" style="display:inline-block;width: 67px;height:10px;border-right: 1px solid #ccc" id="low"></span>
                                        <span class="fl" style="display:inline-block;width: 67px;height:10px;border-right: 1px solid #ccc" id="medium"></span>
                                        <span class="fl" style="display:inline-block;width: 68px;height:10px;" id="height"></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="userDetails.th.Gender"/>：</td>
                                <td width="20%">
                                    <select name="sex">
                                        <option value="0"><fmt:message code="userInfor.th.male"/></option>
                                        <option value="1"><fmt:message code="userInfor.th.female"/></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="userDetails.th.Birthday"/>：</td>
                                <td width="30%">
                            <span class="spanChech">
                                <input type="text" name="birthday" value=""
                                       onclick="laydate({istime: false, format: 'YYYY-MM-DD',min:'1900-01-01 00:00:00',max:getNowFormatDate(),start:'1970-01-01 00:00:00',istoday: false})">
                                <input type="checkbox" name="isLunar" value="">
                                <span><fmt:message code="url.th.Lunar"/></span>
                            </span>
                                    <script>
                                        //获取当前时间，格式YYYY-MM-DD
                                        function getNowFormatDate() {
                                            var date = new Date();
                                            var seperator1 = "-";
                                            var year = date.getFullYear();
                                            var month = date.getMonth() + 1;
                                            var strDate = date.getDate();
                                            if (month >= 1 && month <= 9) {
                                                month = "0" + month;
                                            }
                                            if (strDate >= 0 && strDate <= 9) {
                                                strDate = "0" + strDate;
                                            }
                                            var currentdate = year + seperator1 + month + seperator1 + strDate;
                                            return currentdate;
                                        }
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="interfaceSetting.th.InterfaceTopics"/>：</td>
                                <td width="70%">
                                    <select name="THEME" class="BigSelect">
                                        <option value="20"><fmt:message code="home.page.fashion.title"/></option>
                                        <option value="6"><fmt:message code="controller.th.er"/></option>
                                        <option value="7"><fmt:message code="controller.th.san"/></option>
                                        <option value="3"><fmt:message code="controller.th.si"/></option>
                                        <option value="4"><fmt:message code="controller.th.gm"/></option>
                                        <option value="5"><fmt:message code="controller.th.dge"/></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="userDetails.th.MobilePhone"/>：</td>
                                <td width="30%">
                                    <input type="text" name="mobilNo" value="">
                                    <span class="spanChech">
                                        </span>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="main.email"/>：</td>
                                <td width="70%">
                                    <input type="email" name="email" value="" style="width: 200px;">
                                </td>
                            </tr>
                            <tr>
                                <td width="15%"><fmt:message code="userInfor.th.Workphone"/>：</td>
                                <td width="70%">
                                    <input type="text" name="telNoDept" value="">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.roomNumber" />：</td>
                    <td width="70%">
                        <input type="text" name="roomNum" value="">
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.AddressPermission" />：</td>
                    <td width="70%" id="lookAdress">
                    </td>
                </tr>
                <tr>
                    <td width="15%"><fmt:message code="userDetails.th.SignatureImage" />：</td>
                    <td width="70%" id="" style="position: relative">
                        <form action="/upload?module=user" method="post">
                            <div class="showSign" id="showSign" style="display: none;">
                                <img src="" style="width:140px;" alt="">
                                <input type="button" id="delSign"style="margin-left:10px;width:50px;border-radius: 3px;cursor:pointer" value="<fmt:message code="global.lang.delete" />">
                            </div>
                            <span id="signBtn"><fmt:message code="userDetails.th.UploadSignatureImage" /></span>
                            <input type="hidden" class="signImageId" name="signImageId">
                            <input type="hidden" class="signImageName" name="signImageName">
                            <input type="file" name="file" id="uploadinputimg" class="upsign" title="<fmt:message code="url.th.SelectPicture" />" style="height: 27px;position: absolute;top:3px;left:0px;opacity: 0;width:107px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        </form>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div class="div_btn">
                            <input type="button" class="inpuBtn new_liucheng" id="btn1" value="<fmt:message code="global.lang.save" />"/>
                            <input type="button" class="inpuBtn backCanBtn" style="padding-left: 28px;" id="btn2" onclick="backtn($(this))"
                                   value="<fmt:message code="global.lang.close" />"/>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <script>
            if(isAdd == 0) {
               $('.userSecrecyInfo').empty().hide()
               $('.postDeptContainer').hide()
            }
            $.ajax({
                url:"/syspara/querySecrecySysPara",
                success:function(res) {
                    const data = res.obj;
                    const result = data.filter(function(it) {
                        return it.paraName == "IS_USE_APP"
                    })
                    if(result[0].paraValue == 1) {
                        $('.appInfo').hide()
                    }
                }
            })
            /***********兼容OA精灵没有cookie信息的情况****************/
            var userId = '';
            try{
                userId = $.cookie('userId');
                if(userId == null){
                    $.ajax({
                        type: "post",
                        url: "/users/getUserTheme",
                        dataType: 'json',
                        async: false,
                        success: function (res) {
                            var data = res.object;
                            userId = data.userId;
                            $.cookie('userId', userId, { expires: 7 })
                            $.cookie('userName', res.object.userName, {expires: 7});
                            $.cookie('userPriv', res.object.userPriv, {expires: 7});
                        }
                    })
                }
            }catch (e) {
                console.log(e)
            }
            /***********结束*******************/
            var flag = 0;
            // loadALLDeptSidebarurl = '/getOrgList?queryType=all'

            function backtn(e) {
                window.close();
            }
            //判断是否是闵行项目
            $.ajax({
                type:'get',
                url:'/syspara/selectProjectId',
                dataType:'json',
                success:function (res) {
                    var data = res.object;
                    if(data == 'MINHANG_EDU'){
                        $('#otherOrg').css('display','table-row')
                        $('.eduService').css('display','table-row')
                    }
                }
            })
            //判断域是否开启
            $.ajax({
                type:'get',
                url:'/ad/queryUseDomain',
                dataType:'json',
                success:function (res) {
                    if(res.object){
                        $('.bindYu').css('display','table-row')
                    }
                }
            })

            $('#delSign').click(function () {
                $('.signImageId').val('')
                $('.signImageName').val('')
                $('#showSign').hide();
                $('#signBtn').show();
                $('#uploadinputimg').show();
            })
            //上传图片
            fileuploadFn1('#uploadinputimg', $('.Attachment td').eq(1));

            function fileuploadFn1(formId, element) {
                $(formId).fileupload({
                    dataType: 'json',

                    done: function (e, data) {
                        if (data.result.obj != '') {
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                var gs = data[i].attachName.split('.')[1];
                                if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
                                    str += '';
                                    layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
                                        layer.closeAll();
                                    });
                                } else {
                                    var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;
                                    var name = data[i].attachName + '*'
                                    var attId = data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ','
                                }
                            }
                            $('#showSign').show();
                            $('#showSign img').attr('src', '/xs?' + deUrl)
                            $('.signImageId').val(attId)
                            $('.signImageName').val(name);
                            $('#signBtn').hide();
                            $('#uploadinputimg').hide();
                        } else {
                            layer.alert('添加附件大小不能为空!', {}, function () {
                                layer.closeAll();
                            });
                        }
                    }
                });
            }

            $.ajax({
                url: "/department/getDepartmentYj",
                type: "get",
                dataType: "json",
                success: function (res) {
                    var str = '<label style="margin-right: 10px;"><input type="checkbox" class="checkAll" value=""><fmt:message code="mailMonitoring.selectAll" /></input></label>';
                    if (res.flag) {
                        var data = res.obj;
                        for (var i = 0; i < data.length; i++) {
                            str += '<label style="margin-right: 10px;"><input name="deptYj" class="checkChild" type="checkbox" value="' + data[i].deptId + '">' + data[i].deptName + '</input></label>'
                        }
                        $("#lookAdress").append(str)
                    }
                }
            })
            $('body').on('click', '.checkAll', function () {
                if ($(this).is(':checked')) {
                    $('.checkChild').prop('checked', true)
                } else {
                    $('.checkChild').prop('checked', false)
                }
            })
            $.ajax({
                url: '/sysTasks/selectAll',
                dataType: 'json',
                type: 'get',
                success: function (res) {
                    var data = res.obj;
                    if(location.href.indexOf('isAdd')<0){
                        $.ajax({
                            url: '/user/queryEditByNameAuth',
                            dataType: 'json',
                            data:{
                                uid:location.href.split('?')[1].split('&')[0]
                            },
                            success: function(res){
                                // console.log(res)
                                if(!res.flag){
                                    $('input[name="userId"]').attr('readonly', 'readonly');
                                }
                            }
                        })
                    }
                    for (var i = 0; i < data.length; i++) {

                        // if(isAdd !== '0'){
                        //     $.ajax({
                        //
                        //     })
                        //     $('input[name="userId"]').attr('readonly', 'readonly');
                        // }
                        // 判断是否系统管理员。角色id为1
                        if($.cookie('userPriv')=="1"){

                        }else if (data[i].paraName == 'EDIT_BYNAME') {
                            if (data[i].paraValue == 0) {

                            }
                        }
                        if (data[i].paraName == 'SEC_PASS_SAFE') {
                            if (data[i].paraValue == 0) {
                                flag = 0;
                                $('.redspan').hide();
                                $('.passWordRuleSpan').next().html('')
                            } else if (data[i].paraValue == 1) {
                                flag = 1
                                $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu" />')
                            } else if (data[i].paraValue == 2) {
                                flag = 2
                                $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu2" />')
                            } else if (data[i].paraValue == 3) {
                                flag = 3
                                $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu3" />')
                            } else if (data[i].paraValue == 4) {
                                flag = 4
                                $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu4" />')
                            }
                        }
                    }
                }
            })
            $(function () {
                if (seleId) {
                    $('#department').deptquerySelect2(function (me) {
                        $(me).val(window.opener.numdept);
                        $.get('/department/selectUnallocated', function (res) {
                            $(me).append('<option value="0"><fmt:message code="userManagement.th.Outgoing" /></option>')
                            if (res.flag && res.msg != 'false') {
                                $(me).append('<option value="' + res.object.deptId + '">' + res.object.deptName + '</option>')
                            }
                            $(me).val(seleId);
                        })
                    });
                }
            });

            //时间控件调用
            var start = {
                format: 'YYYY-MM-DD',
                istime: true,
                istoday: false
            };

            function isCardID(sId) {
                var iSum = 0;
                var info = "";
                if (!/^\d{17}(\d|x)$/i.test(sId)) return '<fmt:message code="sys.th.cardID" />';
                sId = sId.replace(/x$/i, "a");
                if (aCity[parseInt(sId.substr(0, 2))] == null) return '<fmt:message code="sys.th.cardFei" />';
                sBirthday = sId.substr(6, 4) + "-" + Number(sId.substr(10, 2)) + "-" + Number(sId.substr(12, 2));
                var d = new Date(sBirthday.replace(/-/g, "/"));
                if (sBirthday != (d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate())) return '<fmt:message code="sys.th.illegal" />';
                for (var i = 17; i >= 0; i--) iSum += (Math.pow(2, i) % 11) * parseInt(sId.charAt(17 - i), 11);
                if (iSum % 11 != 1) return '<fmt:message code="sys.th.fillIllegal" />';
                return true;
            }

            function isCardNo(card) {
                // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
                var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                if (reg.test(card) === false) {
                    $('#numberName').text('身份证输入格式不正确');
                    $('input[name="idNumber"]').focus();
                    return false;
                } else {
                    $('#numberName').text('');
                }
            }

            /******************************************************验证用户输入******************************************************/
            function ValidateInput(element, value) {
                //验证密码
                var i = start;
                var j = end;
                var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/

                if (flag == 1 && !reg.test(value)) {
                    $.layerMsg({content: '密码必须包含大写字母、小写字母和数字', icon: 6})
                    return;
                } else if (flag == 0 && Evaluate(value) != 2) {
                    $.layerMsg({content: '密码必须包含字母和数字', icon: 6})
                    return;
                }

                if (element == "password") {
                    if (value.toString().length < start) {
                        $.layerMsg({content: '您的密码不到' + start + '位', icon: 6})
                        return;
                    }
                }
            }

            /*================================密码强度 ===========Begin=======================================*/
            function Evaluate(word) {
                var low = /^[0-9]*$/;
                var mid = /^[A-Za-z0-9]+$/
                var big = /[0-9a-zA-Z\._\$%&\*\!]/

                if (low.exec(word)) {
                    return 1;
                } else if (mid.exec(word)) {
                    return 2;
                } else if (big.exec(word)) {
                    return 3;
                } else {
                    return 1;
                }
            }

            function colorInit() {
                $('#low').css("backgroundColor", "#fff")
                $('#medium').css("backgroundColor", "#fff")
                $('#height').css("backgroundColor", "#fff")
            }

            function validatePwdStrong(value) {
                if (Evaluate(value) == 1) {
                    colorInit();
                    $('#low').css("backgroundColor", "red")
                    $('#medium').css("backgroundColor", "#fff")
                    $('#height').css("backgroundColor", "#fff")
                } else if (Evaluate(value) == 2) {
                    colorInit();
                    $('#low').css("backgroundColor", "#dfff36")
                    $('#medium').css("backgroundColor", "#dfff36")
                    $('#height').css("backgroundColor", "#fff")
                } else if (Evaluate(value) == 3) {
                    colorInit();
                    $('#low').css("backgroundColor", "#2dff44")
                    $('#medium').css("backgroundColor", "#2dff44")
                    $('#height').css("backgroundColor", "#2dff44")
                    $('#height').css("width", "70")
                }
            }
        </script>
    </body>
</html>
