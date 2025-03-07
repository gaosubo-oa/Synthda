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
    <title><fmt:message code="adding.th.contact"/></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" type="text/css" href="../css/address/new_add.css"/>
    <link rel="stylesheet" type="text/css" href="../js/validation/validationEngine.jquery.min.css">
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <%--<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">--%>
    <script type="text/javascript" src="../js/utility.js"></script>
    <script type="text/javascript" src="../js/attach.js"></script>
    <script src="../js/module.js"></script>
    <script src="../js/mouse_mon.js"></script>
    <script src="../js/wdatepicker.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>

    <%--<script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>--%>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="../js/validation/jquery.validationEngine.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>

    <script>
        $(document).ready(function () {
            $("#form1").validationEngine({promptPosition: "centerRight"});
            //初始化分组列表
            initGroup();
        });

        //初始化部门列表
        function initGroup() {
            $.ajax({
                type: "post",
                url: "/addressGroup/getGroups",
                success: function (res) {
                    if (res.status) {
                        var data = res.data;
                        var group = "";
                        for (var key in data) {
                            group += " <option value='" + data[key].groupId + "'>" + data[key].groupName + "</option>"
                        }
                        $("#groupId").append(group);
                    }
                }
            })
        }

        function previewImg(path) {
            var pathLength = path.length;
            // substring 从 path 长度-3 的开始截取, 截止位置是 path 的长度，结果就是 path 的最后三位:
            var additionName = path.substring(pathLength - 3, pathLength);
            // 判断是否为 .jpg .png .gif格式图片，是，则显示，否，则提示错误
            if (additionName == "jpg" || additionName == "png" || additionName == "gif") {
                document.getElementById('img').innerHTML = '<img  src= "' + path + '" style="width:170px;height:175px;"/>';
            } else {
                document.getElementById('img').innerHTML = "<font color=red><fmt:message code="adding.th.contav" /></font>";
            }
        }

        function clear_photo() {
            document.getElementById("photo").value = "";
            document.getElementById('img').innerHTML = '<img  src= "../img/address/headMan.png" style="width:170px;height:175px;"/>';
        }

        $(document).ready(function () {
            if (typeof FileReader == 'undefined') {
                $("#photo").on('change',function (event) {
                    var src = event.target.value;
                    var pathLength = src.length;
                    var additionName = src.substring(pathLength - 3, pathLength);
                    if (additionName == "jpg" || additionName == "png" || additionName == "gif" || additionName == "JPG" || additionName == "PNG" || additionName == "GIF") {
                        var img = '<img src="' + src + '" style="width:170px;height:175px;" />';
                        $("#img").empty().append(img);
                    } else {
                        var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                        $("#img").empty().append(img);
                    }
                });
            } else {
                $("#photo").on('change',function (e) {
                    for (var i = 0; i < e.target.files.length; i++) {
                        var file = e.target.files.item(i);
                        if (!(/^image\/.*$/i.test(file.type))) {
                            var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                            $("#img").empty().append(img);
                            continue;
                        }

                        //实例化FileReader API
                        var freader = new FileReader();
                        freader.readAsDataURL(file);
                        freader.onload = function (e) {
                            var img = '<img src="' + e.target.result + '" style="width:170px;height:175px;"/>';
                            $("#img").empty().append(img);
                        }
                    }
                });
            }

            $('#notes').focus(function () {
                var notes = $("#notes").val();
                if (notes == '<fmt:message code="journal.th.Remarks" />：') {
                    $("#notes").val("");
                }
            })
            $("#notes").blur(function () {
                var notes = $("#notes").val();
                if (notes == "") {
                    $("#notes").val("<fmt:message code="journal.th.Remarks" />")
                }
            })
            $("#psn_name").blur(function () {
                var sn_name = ($("#psn_name").val());
                var login_user = ($("#login_user").val());
                if (sn_name != "") {
                    _get('verify_name.php?username=' + sn_name, '', function (req) {
                        if (req.status == 200) {
                            if (req.responseText == 'yes') {
                                $("#repeat").html("&nbsp;&nbsp;<fmt:message code="journal.th.Remarr1" />");
                            } else {
                                $("#repeat").html("");
                            }
                        }
                    });
                }
            })

            bindListener();
        });

        function bindListener() {
            $("a[name=rmlink]").unbind().on('click',function () {
                var show_count = parseInt($('*[id=add_button]').size()) - 2;
                var del_count = parseInt($('*[name=rmlink]').size()) - 2;
                $('*[id=add_button]').eq(show_count).show();
                $('*[name=rmlink]').eq(del_count).show();
                $(this).parent().remove();
            })
        }

        function addimg() {
            var all_count = parseInt($('#add_input_count').val()) + 1;
            /*新增input总个数 + 1*/
            $('#add_input_count').val(all_count);
            var add_select_name = "qt_name" + all_count;
            /*给新增select赋值name*/
            var add_input_name = "input_name" + all_count;
            /*给新增input赋值name*/
            var input_c = parseInt($("input").length) - 5;
            /*定位马上新增的input*/
            var select_c = parseInt($('select').size());
            /*定位马上新增的select*/

            $('[id=add_button]').hide();
            $('[name=rmlink]').hide();
            $("#qt").append('<div class="input-prepend" style="margin-top:20px;"><a href="#" name="rmlink" style="float:left;margin-left:-30px;"> <img src="../img/address/delete.png" /> </a><select class="input-small" name="qt_name" id="qt_name" style="width:81px;height:30px;padding-left: 0px;padding-right: 1px;font-weight: normal; float:left;"><option value="oicq_no"><fmt:message code="address.th.QQ" /></option><option value="icq_no"><fmt:message code="address.th.MSN" /></option><option value="tel_no_dept"><fmt:message code="userInfor.th.Workphone" /></option><option value="tel_no_home"><fmt:message code="url.th.HomePhone" /></option><option value="bp_no"><fmt:message code="url.th.PHP" /></option><option value="fax_no_dept"><fmt:message code="url.th.Workfax" /></option><option value="sex"><fmt:message code="userDetails.th.Gender" /></option><option value="birthday"><fmt:message code="userDetails.th.Birthday" /></option><option value="nick_name"><fmt:message code="workflow.th.nickname" /></option><option value="add_dept"><fmt:message code="workflow.th.officeAddress" /></option><option value="post_no_dept"><fmt:message code="controller.th.liu" /></option><option value="add_home"><fmt:message code="url.th.Home" /></option><option value="per_web"><fmt:message code="url.th.Home1" /></option></select><input class="span2" id="prependedDropdownButton" name="input_name" type="text" style="width: 180px;"/><button class="btn" id="add_button" style="width:40px;margin-left: 4px;" type="button" onClick="addimg()">+</button></div>');
            $("select:eq(" + select_c + ")").attr("name", add_select_name);
            $("input:eq(" + input_c + ")").attr("name", add_input_name);
            bindListener();
        }

        function add_photo() {
            $("#photo_no").append('<div class="control-group"><a href="#" name="rmlink"> <img src="../img/address/delete.png" /> </a><label class="control-label" for="dh"><fmt:message code="depatement.th.Telephone" />：</label><div class="controls"><input type="text" style="width: 200px;"><button class="btn btn-small" type="button" onclick="add_photo()">+</button></div></div>');
            bindListener();
        }

        function show_share() {
            var obj = document.getElementById("show_share");
            if (obj.style.display == 'none') {
                obj.style.display = '';
                $('#show_right').scrollTop($("#show_share").offset().top);
            } else {
                obj.style.display = 'none';
            }
        }

        function IsNumber(str) {
            return str.match(/^[0-9]*$/) != null;
        }

        function IsValidEmail(str) {
            var re = /@/;
            return str.match(re) != null;
        }

        function CheckForm() {
            if ($('#psnName').val() == "") {
                layer.msg('<fmt:message code="url.th.Home2" />', {icon: 5});
                return false;
            }
            if (document.form1.email.value !== "" && !IsValidEmail(document.form1.email.value)) {
                alert("<fmt:message code="hr.th.mailbox" />");
                return false;
            }
            // var groupVal = $("#groupId").val()
            // if(groupVal==null||groupVal=="btn-info"){
            //     layer.msg('分组为必填项', { icon:5});
            //     return false;
            // }
            if (true) {
//                document.form1.submit();
                var indexPage = layer.load(1);
                var srcImg = $('#img img').attr('src')
                // console.log(srcImg)
                var formData = new FormData($('#form1')[0])
                formData.append("type",$('#sharetip').prop("checked"))
                formData.append("shareUserId",$('#shareUser').attr("user_id"))
                // let formData = $('#form1').serialize();
                $.ajax({
                    type: "post",
                    url: "/address/addUser",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (res) {
                        //console.log($('#new_add'));
                        // $('#new_add').modal('hide');
                        layer.close(indexPage);
                        if (res.flag) {
                            layer.msg(res.msg, {icon: 4});
                            parent.closeIframe();
                        } else {
                            layer.msg(res.msg, {icon: 5});
                        }

                    }
                })

            }
        }

        function show_hidden(show_id) {
            $('#' + show_id + '_div').show();
        }

        function hide_div(show_id) {
            $('#' + show_id).val("");
            $('#' + show_id + '_div').hide();
        }

        function hide_show(group_id) {
            var all_public = $('#public_group_id_str').val();
            var all_public_arr = all_public.split(",");
            if ($.inArray(group_id, all_public_arr) > -1) {
                $('#share').hide();
                $('#show_share').hide();
            } else {
                $('#share').show();
            }
        }

        function SelectUser() {
            user_id = 'shareUser';
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
        }

        $(document).delegate('.orgClear', 'click', function () {
            $('#shareUser').val('');
        })

    </script>
    <style>
        .form-horizontal .control-label {
            width: 110px;
        }

        .form-horizontal .controls {
            margin-left: 0px;
        }
    </style>
</head>
<body>
<div class="new_f">
    <form action="/address/addUser" method="post" name="form1" id="form1" class="form-horizontal" style="margin: 0px;"
          onSubmit="return CheckForm();">
        <div class="left" style="width: 220px;height: 400px;">
            <div id="img" name="img">
                <img class="uploads" src="../img/address/headMan.png" style="width: 170px;"/>
            </div>
            <div id="left_bts">
                <button type="button" class="btn btn-success" style="width:80px;margin-right: 3px;margin-bottom:5px;"
                        id="upload" onClick="photo.click()" title="<fmt:message code="url.th.format" />"><i
                        class="icon-arrow-up icon-white"></i><fmt:message code="global.th.upload"/>
                </button>
                <button type="button" class="btn btn-danger" style="width:80px;margin-right: 0px;margin-bottom:5px;"
                        id="clear" onClick="clear_photo()"><i class="icon-remove icon-white"></i><fmt:message
                        code="notice.th.delete1"/>
                </button>
                <br/>
                <button type="button" class="btn btn-info" style="width:170px;" id="share" onClick="show_share()">
                    <fmt:message code="diary.th.Share"/>
                </button>
                <input type='file' id="photo" name="file"
                       style="cursor:pointer; position:absolute; top:0; right:80px; height:24px; filter:alpha(opacity:0);opacity: 0;width:100px"
                       size='1' hideFocus='' title="<fmt:message code="url.th.format" />"/>
                <!-- onChange="previewImg(this.value);"-->
            </div>
        </div>

        <div class="right" id="show_right" style="width: 780px;height:400px; background-color:#fff;">
            <div id="name">
                <div class="control-group" style="margin-top:20px;">
                    <label class="control-label" for="psnName"><fmt:message code="userDetails.th.name"/>：</label>
                    <div class="controls" style="position:relative;">
                        <input type="text" id="psnName" class="validate[required]"
                               data-prompt-position="centerRight:0,-3" name="psnName" style="width: 180px;"><span
                            class="red">&nbsp;&nbsp;<fmt:message code="userDetails.th.required"/></span><span
                            class="red" id="repeat"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="mobilNo"><fmt:message code="userDetails.th.mobilePhone"/>：</label>
                    <div class="controls">
                        <input type="text" id="mobilNo" class="validate[required]"
                               data-prompt-position="centerRight:0,-3" name="mobilNo" style="width: 180px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="email"><fmt:message code="main.email"/>：</label>
                    <div class="controls">
                        <input type="text" id="email" class="validate[custom[email]"
                               data-prompt-position="centerRight:0,-3" name="email" style="width: 180px;">
                    </div>
                </div>
            </div>
            <div id="add">
                <div class="control-group">
                    <label class="control-label" for="groupId"><fmt:message code="user.th.Grouping"/>：</label>
                    <div class="controls">
                        <select name="groupId" id="groupId" class="input-large" style="width: 195px;"
                                onChange="hide_show(this.value)">
                            <option value="0"><fmt:message code="main.th.mo" /></option>
                        </select>
                        <%--<span class="red">&nbsp;&nbsp;<fmt:message code="userDetails.th.required" /></span>--%>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="ministration"><fmt:message code="main.position"/>：</label>
                    <div class="controls" style="position:relative;">
                        <input type="text" id="ministration" name="ministration" style="width: 180px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="deptName"><fmt:message code="depatement.th.Company"/>：</label>
                    <div class="controls">
                        <input type="text" id="deptName" name="deptName" style="width: 180px;">
                    </div>
                </div>
                <div id="tel_no_dept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="telNoDept"><fmt:message code="depatement.th.phone"/>：</label>
                    <div class="controls">
                        <input type="text" id="telNoDept" name="telNoDept" style="width: 180px;">
                        <a href="#" onClick="hide_div('tel_no_dept')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/> </a>
                    </div>
                </div>
                <div id="tel_no_home_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="telNoHome"><fmt:message code="depatement.th.telephone"/>：</label>
                    <div class="controls">
                        <input type="text" id="telNoHome" name="telNoHome" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('tel_no_home')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="fax_no_dept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="faxNoDept"><fmt:message code="url.th.Workfax"/>：</label>
                    <div class="controls">
                        <input type="text" id="faxNoDept" name="faxNoDept" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('fax_no_dept')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="per_web_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="perWeb"><fmt:message code="url.th.Home1"/>：</label>
                    <div class="controls">
                        <input type="text" id="perWeb" name="perWeb" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('per_web')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="icq_no_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="icqNo"><fmt:message code="address.th.MSN" />：</label>
                    <div class="controls">
                        <input type="text" id="icqNo" name="icqNo" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('icq_no')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="oicq_no_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="oicqNo"><fmt:message code="address.th.QQ" />：</label>
                    <div class="controls">
                        <input type="text" id="oicqNo" name="oicqNo" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('oicq_no')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="sex_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="sex"><fmt:message code="userDetails.th.Gender"/>：</label>
                    <div class="controls">
                        <select name="sex" id="sex" class="input-large" style="width: 135px;">
                            <option value=""></option>
                            <option value="0"><fmt:message code="userInfor.th.male"/></option>
                            <option value="1"><fmt:message code="userInfor.th.female"/></option>
                        </select>
                        <a href="#" onClick="hide_div('sex')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="birthday_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="birthday"><fmt:message code="userInfor.th.Birthday"/>：</label>
                    <div class="controls">
                        <input  id="birthday" name="birthday" style="width: 180px;"
                               onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"/>
                        <a href="#" onClick="hide_div('birthday')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="nick_name_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="nickName"><fmt:message code="workflow.th.nickname"/>：</label>
                    <div class="controls">
                        <input type="text" id="nickName" name="nickName" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('nick_name')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="add_dept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="addDept"><fmt:message code="workflow.th.officeAddress"/>：</label>
                    <div class="controls">
                        <input type="text" id="addDept" name="addDept" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('add_dept')"
                           tyle=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="add_home_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="addHome"><fmt:message code="workflow.th.Address"/>：</label>
                    <div class="controls">
                        <input type="text" id="addHome" name="addHome" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('add_home')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>
                <div id="post_no_dept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="postNoDept"><fmt:message code="controller.th.liu"/>：</label>
                    <div class="controls">
                        <input type="text" id="postNoDept" name="postNoDept" style="width: 180px;"/>
                        <a href="#" onClick="hide_div('post_no_dept')"
                           style=" cursor: pointer; text-decoration: none; height: 20px; ">
                            <img src="../img/address/delete.png"/>
                        </a>
                    </div>
                </div>

                <div class="control-group" style="width:480px;">
                    <div class="btn-group dropup" style="margin-left: 40px;">
                        <button data-toggle="dropdown" class="btn dropdown-toggle"><fmt:message
                                code="email.th.more"/><span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="#" onClick="show_hidden('tel_no_dept')"><fmt:message
                                    code="depatement.th.phone"/></a></li>
                            <li><a href="#" onClick="show_hidden('tel_no_home')"><fmt:message
                                    code="depatement.th.telephone"/></a></li>
                            <li><a href="#" onClick="show_hidden('fax_no_dept')"><fmt:message
                                    code="url.th.Workfax"/></a></li>
                            <li><a href="#" onClick="show_hidden('per_web')"><fmt:message code="url.th.Home1"/></a></li>
                            <li><a href="#" onClick="show_hidden('icq_no')"><fmt:message code="address.th.MSN" /></a></li>
                            <li><a href="#" onClick="show_hidden('oicq_no')"><fmt:message code="address.th.QQ" /></a></li>
                            <li><a href="#" onClick="show_hidden('sex')"><fmt:message code="userDetails.th.Gender"/></a>
                            </li>
                            <li><a href="#" onClick="show_hidden('birthday')"><fmt:message
                                    code="userInfor.th.Birthday"/></a></li>
                            <li><a href="#" onClick="show_hidden('nick_name')"><fmt:message
                                    code="workflow.th.nickname"/></a></li>
                            <li><a href="#" onClick="show_hidden('add_dept')"><fmt:message
                                    code="workflow.th.officeAddress"/></a></li>
                            <li><a href="#" onClick="show_hidden('add_home')"><fmt:message
                                    code="workflow.th.Address"/></a></li>
                            <li><a href="#" onClick="show_hidden('post_no_dept')"><fmt:message
                                    code="controller.th.liu"/></a></li>
                        </ul>
                    </div>
                    <input class="span2" id="prependedDropdownButton" name="input_name0" type="text"
                           style="width: 180px;"/>
                </div>
            </div>
            <div id="beizhu">
                <textarea name="notes" id="notes"
                          style="margin-top: 0px; margin-bottom: 0px; height: 170px;"><fmt:message
                        code="journal.th.Remarks"/>：</textarea>
            </div>
            <div id="show_share" style="display:none;clear:both; padding-top:10px;">
                <div class="control-group" style="height:150px;">
                    <label class="control-label" for="addStart" style="float:left;"><fmt:message
                            code="journal.th.Sharing"/>：</label>
                    <div class="controls" style="margin-bottom:30px; float:left; display:inline;">
                        <input  name="addStart" id="addStart"  style="width:100px;"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"/>&nbsp;<fmt:message code="global.lang.to"/>&nbsp;
                        <input name="addEnd" id="addEnd"  style="width: 100px;" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  /><br>
                        <font color=red><b><fmt:message code="news.th.notes"/>：</b></font><fmt:message
                            code="meet.th.EndTime1"/>！
                    </div>

                    <label class="control-label" for="shareUser" style="clear:both; float:left"><fmt:message
                            code="diart.th.scope"/>：</label>
                    <div class="controls" style="margin-bottom:30px; float:left">
                        <textarea type="text"  user_id='' rows="3" name="shareUser" id="shareUser" style="min-width: 70%;"
                                  readonly></textarea>
                        <a href="#" class="orgAdd" onclick="SelectUser()"><fmt:message code="global.lang.add"/></a>
                        <a href="#" class="orgClear"><fmt:message code="global.lang.empty"/></a><br>
                        <!--<input type='checkbox' style="width:20px; margin-bottom:6px;" NAME='sms' id="sharetip"/><label style="display:inline;">向共享人员发送事务提醒</label>-->
                        <label style="display:inline; margin-bottom:0px;">
                            <input type='checkbox' style="width:20px; margin-top:3px;" NAME='sms'
                                   id="sharetip"><fmt:message code="global.lang.transaction"/></label>
                    </div>

                </div>
            </div>
            <input type="hidden" name="add_input_count" id="add_input_count" value="0">
            <input type="hidden" name="public_group_id_str" id="public_group_id_str"
                   value="<?=$s_public_group_id_str?>">
        </div>
    </form>
</div>
</body>
</html>
