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
    <title><fmt:message code="global.lang.Edit" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" type="text/css" href="../css/address/new_add.css" />
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="../js/utility.js"></script>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <script type="text/javascript" src="../js/attach.js"></script>
    <script src="../js/module.js"></script>
    <script src="../js/mouse_mon.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>

<%--<script src="../js/jquery/jquery.min.js"></script>--%>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script>
        var param = $.GetRequest();
        var test = window.location.href;
        var uid = test.split('=')[1]
        $(function(){
            // 初始化分组
            $.ajax({
                url:"/addressGroup/getGroups",
                success:function(res) {
                    var data = res.data;
                    var str =  '<option value="0"><fmt:message code="main.th.mo" /></option>'
                    for(var i = 0; i < data.length; i++) {
                        str += '<option value="'+data[i].groupId+'">'+data[i].groupName+'</option>'
                    }
                    $("#groupId").html(str)
                }
            })
            //初始化联系人信息
            $.ajax({
                type: "post",
                url: "/address/getUserInfoById?uid="+uid,
                data: param,
                success: function (res) {
                    if (res.status) {
                        var data = res.data;
                        var icon = data.addressWithBLOBs.attachmentId;
                        if (icon == "") {
                            if (data["sex"] == 0) {
                                icon = "../img/address/headMan.png";
                            } else if (data["sex"] == 1) {
                                icon = "../img/email/icon_head_woman_06.png";
                            } else {
                                icon = "../img/address/headMan.png";
                            }
                        }else {
                            icon = '../ui/img/address/'+icon.replace("s","");
                        }
                        var doms = $("#groupId option");
                        for(var i = 0; i < doms.length; i++) {
                            const dom = doms[i];
                            if($(dom).val() == data.addressWithBLOBs.groupId) {
                                $(dom).attr("checked",true);
                            }
                        }
                        $("#img img").attr("src",icon);
                        $("#addId").val(data.addressWithBLOBs.addId)
                        $("#psnName").val(data.addressWithBLOBs.psnName);
                        $("#mobilNo").val(data.addressWithBLOBs.mobilNo);
                        $("#email").val(data.addressWithBLOBs.email);
                        $("#ministration").val(data.addressWithBLOBs.ministration);
                        $("#deptName").val(data.addressWithBLOBs.deptName);
                        $("#notes").val(data.addressWithBLOBs.notes);
                        $("#shareUser").val(data.addressWithBLOBs.shareUserName)
                        $("#shareUser").attr('user_id',data.addressWithBLOBs.shareUser)
                        $("#addStart").val(data.addStart)
                        $("#addEnd").val(data.addEnd)
                        if(data.addressWithBLOBs.telNoDept!=null&&data.addressWithBLOBs.telNoDept!=""){
                            $("#telNoDept").val(data.addressWithBLOBs.telNoDept);
                            show_hidden('telNoDept');
                        }
                        if(data.addressWithBLOBs.telNoHome!=null&&data.addressWithBLOBs.telNoHome!=""){
                            $("#telNoHome").val(data.addressWithBLOBs.telNoHome);
                            show_hidden('telNoHome');
                        }
                        if(data.addressWithBLOBs.faxNoDept!=null&&data.addressWithBLOBs.faxNoDept!=""){
                            $("#faxNoDept").val(data.addressWithBLOBs.faxNoDept);
                            show_hidden('faxNoDept');
                        }
                        if(data.addressWithBLOBs.perWeb!=null&&data.addressWithBLOBs.perWeb!=""){
                            $("#perWeb").val(data.addressWithBLOBs.perWeb);
                            show_hidden('perWeb');
                        }
                        if(data.addressWithBLOBs.icqNo!=null&&data.addressWithBLOBs.icqNo!=""){
                            $("#icqNo").val(data.addressWithBLOBs.icqNo);
                            show_hidden('icqNo');
                        }
                        if(data.addressWithBLOBs.oicqNo!=null&&data.addressWithBLOBs.oicqNo!=""){
                            $("#oicqNo").val(data.addressWithBLOBs.oicqNo);
                            show_hidden('oicqNo');
                        }
                        if(data.addressWithBLOBs.sex!=null&&data.addressWithBLOBs.sex!=""){
                            $("#sex").val(data.addressWithBLOBs.sex);
                            show_hidden('sex');
                        }
                        if(data.birthday!=null&&data.birthday!=""){
                            $("#birthday").val(data.birthday);
                            show_hidden('birthday');
                        }
                        if(data.addressWithBLOBs.nickName!=null&&data.addressWithBLOBs.nickName!=""){
                            $("#nickName").val(data.addressWithBLOBs.nickName);
                            show_hidden('nickName');
                        }
                        if(data.addressWithBLOBs.addDept!=null&&data.addressWithBLOBs.addDept!=""){
                            $("#addDept").val(data.addressWithBLOBs.addDept);
                            show_hidden('addDept');
                        }
                        if(data.addressWithBLOBs.addHome!=null&&data.addressWithBLOBs.addHome!=""){
                            $("#addHome").val(data.addressWithBLOBs.addHome);
                            show_hidden('addHome');
                        }
                        if(data.addressWithBLOBs.postNoDept!=null&&data.addressWithBLOBs.postNoDept!=""){
                            $("#postNoDept").val(data.addressWithBLOBs.postNoDept);
                            show_hidden('postNoDept');
                        }


                    }
                }
            })
        })
    </script>
    <script>
        $(document).ready(function () {
            if (typeof FileReader == 'undefined') {
                $("#photo").on('change',function (event) {
                    var src = event.target.value;
                    var pathLength = src.length;
                    var additionName = src.substring(pathLength - 3, pathLength);
                    if (additionName == "jpg" || additionName == "png" || additionName == "gif" || additionName == "JPG" || additionName == "PNG" || additionName == "GIF") {
                        var img = '<img src="' + src + '" style="width:170px;height:175px;" />';
                        $("#img").empty().append(img);
                    }
                    else {
                        var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                        $("#img").empty().append(img);
                    }
                });
            }
            else {
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
                <%--if (notes == "") {--%>
                <%--    $("#notes").val("<fmt:message code="journal.th.Remarks" />")--%>
                <%--}--%>
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
        function bindListener(){
            $("a[name=rmlink]").unbind().on('click',function(){
                var show_count = parseInt($('*[id=add_button]').size()) - 2;
                var del_count = parseInt($('*[name=rmlink]').size()) - 2;
                $('*[id=add_button]').eq(show_count).show();
                $('*[name=rmlink]').eq(del_count).show();
                $(this).parent().remove();
            })
        }
        function IsNumber(str)
        {
            return str.match(/^[0-9]*$/)!=null;
        }

        function IsValidEmail(str)
        {
            var re = /@/;
            return str.match(re)!=null;
        }
        function CheckForm()
        {
            if(document.form1.psnName.value=="")
            {
                alert("<fmt:message code="hr.th.empty" />");
                return (false);
            }
            if(document.form1.email.value!="" && !IsValidEmail(document.form1.email.value))
            {
                alert("<fmt:message code="hr.th.mailbox" />");
                return (false);
            }

//            document.form1.submit();
            var formData = new FormData($("#form1")[0]);
            var type = $('#sharetip').prop("checked")
            if (type = true){
                type = 1
            }
            formData.append("type",type)
            formData.append("shareUserId",$('#shareUser').attr("user_id"))
            formData.append("attachmentId",$('#img img').attr("src").slice($('#img img').attr("src").lastIndexOf('/')));
            $.ajax({
                type: "post",
                url: "/address/updateUser",
                data: formData,
                processData:false,
                contentType:false,
                success: function(res){
                    layer.close();
                    if(res.flag){
                        alert("<fmt:message code="depatement.th.Modifysuccessfully" />");
                        parent.location.reload();
                    }else{
                        alert("<fmt:message code="depatement.th.modifyfailed" />");
                    }
                }
            })
        }

        function clear_photo() {
            $("#imgs").attr("src","../img/address/headMan.png")
        }

        function show_hidden(show_id)
        {
            $('#'+show_id+'_div').show();
        }

        function hide_div(show_id)
        {
            $('#'+show_id).val("");
            $('#'+show_id+'_div').hide();
        }
        function hide_show(group_id)
        {
            var all_public = $('#public_group_id_str').val();
            var all_public_arr = all_public.split(",");
            if($.inArray(group_id, all_public_arr) > -1)
            {
                $('#share').hide();
                $('#show_share').hide();
            }
            else
            {
                $('#share').show();
            }
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
</head>
<body>
<div class="new_f">
    <form enctype="multipart/form-data" action="edit_update.php"  method="post" name="form1" id="form1" class="form-horizontal" onSubmit="return CheckForm();" style="margin: 0px;">
        <div class="left" style="width: 220px;height: 400px;">
            <div id="img" class="layui-upload-list">
                <img id="imgs" class="layui-upload-img uploads" src="" style="width:170px;height:175px"/>
            </div>
            <div id="left_bts" class="layui-upload">
                <button type="button" class="btn btn-success" onClick="photo.click()"  style="width:80px;margin-right: 3px;margin-bottom:5px;" id="upload"  title="<fmt:message code="url.th.format" />"><i class="icon-arrow-up icon-white"></i><fmt:message code="global.th.upload" /></button>
                <button type="button" class="btn btn-danger" style="width:80px;margin-right: 0px;margin-bottom:5px;" id="clear" onClick="clear_photo()"><i class="icon-remove icon-white"></i><fmt:message code="notice.th.delete1" /></button><br />
                <input type='file' id="photo" name="file" style="cursor:pointer; position:absolute; top:0; right:80px; height:24px; filter:alpha(opacity:0);opacity: 0;width:100px"
                       size='1'  hideFocus='' title="<fmt:message code="url.th.format" />"/><!-- onChange="previewImg(this.value);"-->
                <button type="button" class="btn btn-info" style="width:170px;" id="share" onClick="show_share()">
                    <fmt:message code="diary.th.Share"/>
                </button>
            </div>
        </div>
        <input type="hidden" id="addId" name="addId"/>
        <div class="right" id="show_right" style="height:400px;width: 780px;">
            <div id="name">
                <div class="control-group" style="margin-top:20px;">
                    <label class="control-label" for="psnName"><fmt:message code="userDetails.th.name" />：</label>
                    <div class="controls" style="position:relative;">
                        <input type="text" id="psnName" name="psnName" style="width: 180px;" value=""><span class="red">&nbsp;&nbsp;<fmt:message code="userDetails.th.required" /></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="mobilNo"><fmt:message code="userDetails.th.mobilePhone" />：</label>
                    <div class="controls">
                        <input type="text" id="mobilNo" name="mobilNo" value="" style="width: 180px;">
                    </div>
                </div>
                <div class="control-group" style="width:480px;">
                    <label class="control-label" for="email"><fmt:message code="main.email" />：</label>
                    <div class="controls">
                        <input type="text" id="email" name="email" value="" style="width: 180px;">
                    </div>
                </div>
            </div>
            <div id="add">
                <div class="control-group">
                    <label class="control-label" for="groupId"><fmt:message code="user.th.Grouping" />：</label>
                    <div class="controls">
                        <select name="groupId" id="groupId" class="input-large" style="width: 195px;" onChange="hide_show(this.value)">
                            <option value="0"><fmt:message code="main.th.mo" /></option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="ministration"><fmt:message code="main.position" />：</label>
                    <div class="controls" style="position:relative;">
                        <input type="text" id="ministration" name="ministration" style="width: 180px;" value="">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="deptName"><fmt:message code="depatement.th.Company" />：</label>
                    <div class="controls">
                        <input type="text" id="deptName" name="deptName" value="" style="width: 180px;">
                    </div>
                </div>
                <div id="telNoDept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="telNoDept"><fmt:message code="depatement.th.phone" />：</label>
                    <div class="controls">
                        <input type="text" id="telNoDept" name="telNoDept" value="" style="width: 180px;"><a href="#" onClick="hide_div('telNoDept')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="telNoHome_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="telNoHome"><fmt:message code="depatement.th.telephone" />：</label>
                    <div class="controls">
                        <input type="text" id="telNoHome" name="telNoHome" value="" style="width: 180px;"><a href="#" onClick="hide_div('telNoHome')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="faxNoDept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="faxNoDept"><fmt:message code="url.th.Workfax" />：</label>
                    <div class="controls">
                        <input type="text" id="faxNoDept" name="faxNoDept" value="" style="width: 180px;"><a href="#" onClick="hide_div('faxNoDept')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="perWeb_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="perWeb"><fmt:message code="url.th.Home1" />：</label>
                    <div class="controls">
                        <input type="text" id="perWeb" name="perWeb" value="" style="width: 180px;"><a href="#" onClick="hide_div('perWeb')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="icqNo_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="icqNo"><fmt:message code="address.th.MSN" />：</label>
                    <div class="controls">
                        <input type="text" id="icqNo" name="icqNo" value="" style="width: 180px;"><a href="#" onClick="hide_div('icqNo')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="oicqNo_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="oicqNo"><fmt:message code="address.th.QQ" />：</label>
                    <div class="controls">
                        <input type="text" id="oicqNo" name="oicqNo" value="" style="width: 180px;"><a href="#" onClick="hide_div('oicqNo')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="sex_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="sex"><fmt:message code="userDetails.th.Gender" />：</label>
                    <div class="controls">
                        <select name="sex" id="sex" class="input-large" style="width: 194px;">
                            <option value="" ></option>
                            <option value="0"><fmt:message code="userInfor.th.male" /></option>
                            <option value="1"><fmt:message code="userInfor.th.female" /></option>
                        </select>
                        <a href="#" onClick="hide_div('sex')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="birthday_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="birthday"><fmt:message code="userInfor.th.Birthday" />：</label>
                    <div class="controls">
                        <input type="text" id="birthday" name="birthday" value="" style="width: 180px;" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"><a href="#" onClick="hide_div('birthday')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="nickName_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="nickName"><fmt:message code="workflow.th.nickname" />：</label>
                    <div class="controls">
                        <input type="text" id="nickName" name="nickName" value="" style="width: 180px;"><a href="#" onClick="hide_div('nickName')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="addDept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="addDept"><fmt:message code="workflow.th.officeAddress" />：</label>
                    <div class="controls">
                        <input type="text" id="addDept" name="addDept" value="" style="width: 180px;"><a href="#" onClick="hide_div('addDept')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="addHome_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="addHome"><fmt:message code="workflow.th.Address" />：</label>
                    <div class="controls">
                        <input type="text" id="addHome" name="addHome" value="" style="width: 180px;"><a href="#" onClick="hide_div('addHome')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>
                <div id="postNoDept_div" class="control-group" style="width:480px;display:none;">
                    <label class="control-label" for="postNoDept"><fmt:message code="controller.th.liu" />：</label>
                    <div class="controls">
                        <input type="text" id="postNoDept" name="postNoDept" value="" style="width: 180px;"><a href="#" onClick="hide_div('postNoDept')" style=" cursor: pointer; text-decoration: none; height: 20px; "> <img src="../img/address/delete.png" /> </a>
                    </div>
                </div>

                <div class="control-group" style="width:480px;">
                    <div class="btn-group dropup" style="margin-left: 90px;">
                        <button data-toggle="dropdown" class="btn dropdown-toggle"><fmt:message code="email.th.more" /><span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="#" onClick="show_hidden('telNoDept')"><fmt:message code="depatement.th.phone" /></a></li>
                            <li><a href="#" onClick="show_hidden('telNoHome')"><fmt:message code="depatement.th.telephone" /></a></li>
                            <li><a href="#" onClick="show_hidden('faxNoDept')"><fmt:message code="url.th.Workfax" /></a></li>
                            <li><a href="#" onClick="show_hidden('perWeb')"><fmt:message code="url.th.Home1" /></a></li>
                            <li><a href="#" onClick="show_hidden('icqNo')"><fmt:message code="address.th.MSN" /></a></li>
                            <li><a href="#" onClick="show_hidden('oicqNo')"><fmt:message code="address.th.QQ" /></a></li>
                            <li><a href="#" onClick="show_hidden('sex')"><fmt:message code="userDetails.th.Gender" /></a></li>
                            <li><a href="#" onClick="show_hidden('birthday')"><fmt:message code="userInfor.th.Birthday" /></a></li>
                            <li><a href="#" onClick="show_hidden('nickName')"><fmt:message code="workflow.th.nickname" /></a></li>
                            <li><a href="#" onClick="show_hidden('addDept')"><fmt:message code="workflow.th.officeAddress" /></a></li>
                            <li><a href="#" onClick="show_hidden('addHome')"><fmt:message code="workflow.th.Address" /></a></li>
                            <li><a href="#" onClick="show_hidden('postNoDept')"><fmt:message code="controller.th.liu" /></a></li>
                        </ul>
                    </div>
                    <input class="span2" id="prependedDropdownButton" name="input_name0" type="text" style="width: 180px;margin-left: 25px;"/>
                </div>
            </div>
            <div id="beizhu">
                备注：
                <textarea name="notes" id="notes" style="margin-top: 0px; margin-bottom: 0px; height: 170px;"></textarea>
            </div>
            <div id="show_share" style="display:none;width:500px;clear:both; padding-top:10px; float:left;">
                <div class="control-group" style="height:150px;">
                    <label class="control-label" for="yx"><fmt:message code="journal.th.Sharing" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:500px; ">
                        <input type="text" id="addStart" name="addStart" style="width:180px;" size="20" maxlength="19" value="" title="<fmt:message code="sup.th.startTime" />" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">&nbsp;<fmt:message code="global.lang.to" />&nbsp;
                        <input type="text" id="addEnd" name="addEnd" style="width: 180px;" size="20" maxlength="19" value="" title="<fmt:message code="meet.th.EndTime" />" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"><br>
                        <font color=red><b><fmt:message code="news.th.notes" />：</b></font><fmt:message code="meet.th.EndTime1" />！
                    </div>

                    <label class="control-label" for="yx"><fmt:message code="diart.th.scope" />：</label>
                    <div class="controls" style="margin-bottom:30px;width: 500px;">
                        <input type="hidden" name="to_id" id="to_id" value="">
                        <textarea rows="3" class="SmallStatic" name="shareUser" id="shareUser" style="width:270px;" readonly></textarea>
                        <a href="#" class="orgAdd" onclick="SelectUser()"><fmt:message code="global.lang.add" /></a>
                        <a href="#" class="orgClear" onClick="ClearUser('to_id', 'to_name')"><fmt:message code="global.lang.empty" /></a><br>
                        <input type='checkbox' style="width:20px; margin-bottom:6px;" NAME='sms' id="sharetip"/><label style="display:inline;"><fmt:message code="global.lang.transaction" /></label>
                    </div>

                    <!--    <label class="control-label" for="yx">共享内容：</label>
                        <div class="controls">
                            <input type="hidden" name="add_id_str" id="add_id_str" value="">
                            <textarea name="add_name_str" id="add_name_str" rows="3" style="overflow-y:auto;width:270px;" class="SmallStatic" wrap="yes" readonly></textarea>
                            <a href="javascript:;" class="orgAdd" onClick="SelectAdd('add_id_str','add_name_str','')">添加</a>
                            <a href="javascript:;" class="orgClear" onClick="ClearUser('add_id_str', 'add_name_str')">清空</a>&nbsp;&nbsp;
                        </div>-->
                </div>
            </div>

            <input type="hidden" name="add_input_count" id="add_input_count" value="0">
            <input type="hidden" name="add_id" id="add_id" value="">
            <input type="hidden" name="attachment_id_old" value="">
            <input type="hidden" name="attachment_name_old" value="">
            <!--<div id="bts">
                <button type="submit" class="button button-primary button-rounded" id="bc" style="margin-right:20px;">保存</button>
                <button type="button" class="btn button-rounded" id="fh" onClick="hide_dialog()">关闭</button>
            </div>-->
        </div>
        <input type="hidden" name="public_group_id_str" id="public_group_id_str" value="">
    </form>
</div>
</body>
</html>
