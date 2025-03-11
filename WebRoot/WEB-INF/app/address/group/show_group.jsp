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
    <title><fmt:message code="userDetails.th.display" /></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" type="text/css" href="../css/address/new_add.css"/>
    <script src="../js/module.js"></script>
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="../js/wdatepicker.js"></script>
    <script type="text/javascript" src="../js/base/base.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>

    <script>
        var param = $.GetRequest();
        var groupId = param.groupId
        $(function(){
            $("#groupId").val(groupId)
            if(groupId == 0){
                $("#zm").val("暂无");
                $("#zm").attr("disabled","disabled");
            }else{
                $(function(){
                    //获取分组详情
                    $.ajax({
                        type:"post",
                        url: "/addressGroup/getGroupInfo",
                        data:{"groupId":groupId},
                        success: function (res) {
                            if(res.status){
                                $("#zm").val(res.data.groupName);
                            }
                        }
                    })
                })

            }
            //初始化已选人员
            $.ajax({
                type:"post",
                url: "/address/getUsersById",
                data:{"groupId":groupId},
                success: function (res) {
                    if(res.status){
                        var data = res.data;
                        var oSelect1 = ""
                        for(var key in data){
                            oSelect1 += "<option value='"+data[key].addId+"'>"+ data[key].psnName +"</option>"
                        }
                        $("#select1").append(oSelect1)
                    }
                }
            })
            //初始化未选人员
            $.ajax({
                type:"post",
                url: "/address/getNotUserById",
                data:{"groupId":groupId},
                success: function (res) {
                    if(res.status){
                        var data = res.data;
                        var oSelect2 = ""
                        for(var key in data){
                            oSelect2 += "<option value='"+data[key].addId+"'>"+ data[key].psnName +"</option>"
                        }
                        $("#select2").append(oSelect2)
                    }
                }
            })
        })

    </script>
    <script>
        function func_color(select_obj) {
            font_color = "black";
            option_text = "";
            for (j = 0; j < select_obj.options.length; j++) {
                str = select_obj.options[j].text;
                if (str.indexOf(option_text) < 0) {
                    if (font_color == "red") {
                        font_color = "blue";
                    }
                    else {
                        font_color = "red";
                    }
                }
                select_obj.options[j].style.color = font_color;

                pos = str.indexOf("] ") + 1;
                option_text = str.substr(0, pos);
            }//for

            return j;
        }

        function func_insert() {
            var oSelect1 = document.form1.select1;
            var oSelect2 = document.form1.select2;
            for (i = oSelect2.options.length - 1; i >= 0; i--) {
                if (oSelect2.options[i].selected) {
                    option_text = oSelect2.options[i].text;
                    option_value = oSelect2.options[i].value;
                    option_style_color = oSelect2.options[i].style.color;

                    var my_option = document.createElement("OPTION");
                    my_option.text = option_text;
                    my_option.value = option_value;
                    my_option.style.color = option_style_color;

                    oSelect1.options.add(my_option);
                    oSelect2.remove(i);
                }
            }//for

            func_init();
        }

        function func_delete() {
            var oSelect1 = document.form1.select1;
            var oSelect2 = document.form1.select2;
            for (i = oSelect1.options.length - 1; i >= 0; i--) {
                if (oSelect1.options[i].selected) {
                    option_text = oSelect1.options[i].text;
                    option_value = oSelect1.options[i].value;

                    var my_option = document.createElement("OPTION");
                    my_option.text = option_text;
                    my_option.value = option_value;

                    oSelect2.options.add(my_option);
                    oSelect1.remove(i);
                }
            }//for

            func_init();
        }

        function func_select_all1() {
            var oSelect1 = document.form1.select1;
            for (i = oSelect1.options.length - 1; i >= 0; i--) {
                oSelect1.options[i].selected = true;
            }
        }

        function func_select_all2() {
            var oSelect2 = document.form1.select2;
            for (i = oSelect2.options.length - 1; i >= 0; i--) {
                oSelect2.options[i].selected = true;
            }
        }

        function func_init() {
            func_color(document.form1.select2);
            func_color(document.form1.select1);
        }

        function SelectAdd(add_id_str, add_name_str, FORM_NAME) {
            var oSelect1 = document.form1.select1;
            var show_add_str = "";

            for (i = 0; i < oSelect1.options.length; i++) {
                options_value = oSelect1.options[i].value;
                show_add_str += options_value + ",";
            }
            document.form1.FLD_STR.value = show_add_str;

            var URL = "select_add/select_add.php?add_id_str=" + add_id_str + "&group_id=<?=$GROUP_ID?>" + "&add_name_str=" + add_name_str + "&show_add_str=" + show_add_str + "&FORM_NAME=" + FORM_NAME;
            var loc_y = 200;
            var loc_x = 1000;
            if (is_ie) {
                loc_x = document.body.scrollLeft + event.clientX + 500;
                loc_y = document.body.scrollTop + event.clientY - 200;
            }

            LoadDialogWindow(URL, self, loc_x, loc_y, 250, 350);
        }
        function show_share() {
            var obj = document.getElementById("show_share");
            if (obj.style.display == 'none') {
                obj.style.display = '';
                $('#show_right').scrollTop($("#show_share").offset().top);
            }
            else {
                obj.style.display = 'none';
            }
        }
        function hide_dialog() {
            parent.parent.document.getElementById('hide_group').click();
        }
        function CheckForm() {
            if (document.form1.group_name.value == "") {
                $.layerMsg({content:"<fmt:message code="main.th.moerseg" />!",icon:2},function(){
                    return false;
                });
            }
            var oSelect1 = document.form1.select1;
            fld_str = "";
            
            for (i = 0; i < oSelect1.options.length; i++) {
                options_value = oSelect1.options[i].value;
                fld_str += options_value + ",";
            }
            document.form1.FLD_STR.value = fld_str;

//            document.form1.submit();
            var formData = new FormData($("form")[0]);
            $.ajax({
                type: "post",
                url: "/addressGroup/putGroup",
                data: formData,
                processData:false,
                contentType:false,
                success: function(res){
                    if(res.status){
                        $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1});
                        parent.location.reload();
                    }else if(res.msg=="<fmt:message code="depatement.th.Modifya" />"){
                        $.layerMsg({content:"<fmt:message code="depatement.th.Modifya" />",icon:2},function(){
                            return false;
                        });
                    }else {
                        $.layerMsg({content:"<fmt:message code="depatement.th.modifyfailed" />",icon:2},function(){
                            return false;
                        });
                    }
                }
            })
        }
    </script>
    <style>
        form {
            margin: 0;
        }
    </style>
</head>
<body style="overflow-x:hidden">
<div class="group" style="position:relative;width:787px;height:400px;overflow-x: hidden;">
    <div class="right" id="show_right" style="width:787px;height:400px;overflow-y:auto;overflow-x: hidden;">
        <form  method="post" name="form1" class="form-horizontal" style="height:400px;">
            <input type="hidden" name="groupId" id="groupId" />
            <div class="gname" style="width: 100%">
                <div class="control-group">
                    <div class="controls" style="margin-top:30px; margin-left:0px; padding-left:0px;">
                        <label class="control-label" for="zm" id="bj"><fmt:message code="depatement.th.modifyname" />：</label>
                        <input type="text" id="zm" name="group_name"value=""/>
                        <span class="red" id="pp"><fmt:message code="userDetails.th.required" /></span>
                        <%--<button type="button" class="btn btn-info" style="width:120px;" id="share1"--%>
                                <%--onClick="show_share()"><fmt:message code="diary.th.Share" /></button>--%>
                    </div>
                </div>
            </div>

            <div style="width:100%;margin-top: 10px;">
                <div style="width:543px;margin-left: 90px;">
                    <div style="width:200px; float:left">
                        <div style="width:200px; text-align:center;"><fmt:message code="hr.th.Requ" /></div>
                        <div style="width:200px; background-color:#f8f8f8;/* border:1px #CCCCCC solid;*/">
                            <select id="select1" name="select1" ondblclick="func_delete();"
                                    style="width:200px;height:200px;padding-left: 30px;" multiple="multiple">
                            </select>
                        </div>
                        <div style="width:200px; text-align:center; margin-top: 5px;">
                            <button type="button" class="btn" onClick="func_select_all1();"><fmt:message code="notice.th.allchose" /></button>
                        </div>
                    </div>

                    <div style="width:143px;height:250px; float:left;line-height:250px; position:relative;">
                        <button type="button" style="position:absolute;top:30%;left:25%;" class="btn btn-success"
                                onClick="func_insert();"><i class="icon-arrow-left icon-white"></i><fmt:message code="global.lang.add" /></button>
                        <button type="button" style="position:absolute;top:50%;left:25%" class="btn btn-danger"
                                onClick="func_delete();"><i class="icon-arrow-right icon-white"></i><fmt:message code="netdisk.th.Remove" />
                        </button>
                    </div>

                    <div style="width:200px; float:left">
                        <div style="width:200px; text-align:center;"><fmt:message code="netdisk.th.members" /></div>
                        <div style="width:200px;background-color:#f8f8f8;/* border:1px #CCCCCC solid;*/">
                            <select id="select2" name="select2" ondblclick="func_insert();"
                                    style="width:200px;height:200px;padding-left: 30px;" multiple="multiple">

                            </select>
                        </div>
                        <div style="width:200px; text-align:center;margin-top: 10px;">
                            <button type="button" class="btn" onClick="func_select_all2();"><fmt:message code="notice.th.allchose" /></button>
                        </div>
                    </div>
                    <div style="clear:both; width:480px; text-align:center; padding-top:10px;"><p><span
                            style="color:#F00;"><fmt:message code="news.th.notes" />：</span><fmt:message code="hr.th.ClickItems" />！</p></div>
                </div>
            </div>

            <div id="show_share"
                 style="width:100%;clear:both;padding-top:20px; display:none;border-top:1px #CCCCCC solid">
                <div class="control-group" style="height:150px;">
                    <label class="control-label" for="yx"><fmt:message code="journal.th.Sharing" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px; ">
                        <input type="text" id="share_start" name="share_start" style="width:180px;" size="20"
                               maxlength="19" value="" title=" <fmt:message code="sup.th.startTime" />" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">&nbsp;<fmt:message code="global.lang.to" />&nbsp;
                        <input type="text" id="share_end" name="share_end" style="width: 180px;" size="20"
                               maxlength="19" value="" title=" <fmt:message code="meet.th.EndTime" />" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'share_start\')}'})"><br>
                        <font color=red><b><fmt:message code="news.th.notes" />：</b></font><fmt:message code="meet.th.EndTime1" />！
                    </div>
                    <label class="control-label" for="yx"><fmt:message code="diart.th.scope" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px;">
                        <input type="hidden" name="to_id" id="to_id" value="">
                        <textarea rows="3" class="SmallStatic" name="to_name" id="to_name" style="width:270px;"
                                  wrap="yes" readonly> </textarea>
                        <a href="javascript:;" class="orgAdd"
                           onClick="SelectUser('10', '', 'to_id', 'to_name')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="orgClear" onClick="ClearUser('to_id', 'to_name')"><fmt:message code="global.lang.empty" /></a><br>
                        <input type='checkbox' style="width:20px; margin-bottom:6px;" NAME='sms'/><label
                            style="display:inline;"><fmt:message code="global.lang.transaction" /></label>
                    </div>

                    <label class="control-label" for="yx"><fmt:message code="global.lang.content1" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px;">
                        <input type="hidden" name="add_id_str" id="add_id_str" value="">
                        <input type="hidden" name="FLD_STR" value="">
                        <textarea name="add_name_str" id="add_name_str" rows="3" style="overflow-y:auto;width:270px;"
                                  class="SmallStatic" wrap="yes" readonly></textarea>
                        <a href="javascript:;" class="orgAdd"
                           onClick="SelectAdd('add_id_str','add_name_str','')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="orgClear"
                           onClick="ClearUser('add_id_str', 'add_name_str')"><fmt:message code="global.lang.empty" /></a>&nbsp;&nbsp;<br><br>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
</body>