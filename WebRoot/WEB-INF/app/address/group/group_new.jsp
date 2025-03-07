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
    <title><fmt:message code="user.th.NewPacket" /></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" type="text/css" href="../css/address/new_add.css" />
    <script src="../js/module.js"></script>
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="../js/wdatepicker.js"></script>
<script>
    function func_color(select_obj)
    {
        font_color="black";
        option_text="";
        for (j=0; j<select_obj.options.length; j++)
        {
            str=select_obj.options[j].text;
            if(str.indexOf(option_text)<0)
            {
                if(font_color=="red")
                {
                    font_color="blue";
                }
                else
                {
                    font_color="red";
                }
            }
            select_obj.options[j].style.color=font_color;

            pos=str.indexOf("] ")+1;
            option_text=str.substr(0,pos);
        }//for

        return j;
    }

    function func_insert()
    {
        var oSelect1 = document.form1.select1;
        var oSelect2 = document.form1.select2;
        for (i=oSelect2.options.length-1; i>=0; i--)
        {
            if(oSelect2.options[i].selected)
            {
                option_text=oSelect2.options[i].text;
                option_value=oSelect2.options[i].value;
                option_style_color=oSelect2.options[i].style.color;

                var my_option = document.createElement("OPTION");
                my_option.text=option_text;
                my_option.value=option_value;
                my_option.style.color=option_style_color;

                oSelect1.options.add(my_option);
                oSelect2.remove(i);
            }
        }//for

        func_init();
    }

    function func_delete()
    {
        var oSelect1 = document.form1.select1;
        var oSelect2 = document.form1.select2;
        for (i=oSelect1.options.length-1; i>=0; i--)
        {
            if(oSelect1.options[i].selected)
            {
                option_text=oSelect1.options[i].text;
                option_value=oSelect1.options[i].value;

                var my_option = document.createElement("OPTION");
                my_option.text=option_text;
                my_option.value=option_value;

                oSelect2.options.add(my_option);
                oSelect1.remove(i);
            }
        }//for

        func_init();
    }

    function func_select_all1()
    {
        var oSelect1 = document.form1.select1;
        for (i=oSelect1.options.length-1; i>=0; i--)
        {
            oSelect1.options[i].selected=true;
        }
    }

    function func_select_all2()
    {
        var oSelect2 = document.form1.select2;
        for (i=oSelect2.options.length-1; i>=0; i--)
        {
            oSelect2.options[i].selected=true;
        }
    }

    function func_init()
    {
        func_color(document.form1.select2);
        func_color(document.form1.select1);
    }

    function SelectAdd(add_id_str, add_name_str, FORM_NAME)
    {
        var URL="select_add/select_add.php?add_id_str="+add_id_str+"&group_id=<?=$GROUP_ID?>"+"&add_name_str="+add_name_str+"&FORM_NAME="+FORM_NAME;
        var loc_y=loc_x=200;
        if(is_ie)
        {
            loc_x=document.body.scrollLeft+event.clientX-200;
            loc_y=document.body.scrollTop+event.clientY+170;
        }
        alert(URL);
        LoadDialogWindow(URL,self,loc_x, loc_y, 250, 350);
    }
    function show_share()
    {
        var obj = document.getElementById("show_share");
        if(obj.style.display=='none')
        {
            obj.style.display='';
        }
        else
        {
            obj.style.display='none';
        }
    }
    function hide_dialog()
    {
        parent.parent.document.getElementById('hide_group').click();
    }

    function CheckForm()
    {
        if(document.form1.group_name.value=="")
        {
            alert("<fmt:message code="user.th.Newsdg" />！");
            return false;
        }

        var oSelect1 = document.form1.select1;
        fld_str="";
        for (i=0; i< oSelect1.options.length; i++)
        {
            options_value=oSelect1.options[i].value;
            fld_str+=options_value+",";
        }
        document.form1.FLD_STR.value=fld_str;

//        document.form1.submit();
        var formData = new FormData($("form")[0]);
        $.ajax({
            type: "post",
            url: "/addressGroup/addGroup",
            data: formData,
            processData:false,
            contentType:false,
            success: function(res){
                if(res.status){
                    alert("<fmt:message code="url.th.addSuccess" />");
                    parent.location.reload();
                }else{
                    alert("<fmt:message code="hr.th.AddFailed" />！\n"+res.msg);
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
<form action="/addressGroup/addGroup" method="post" name="form1" class="form-horizontal" style="width: 787px;height: 400px">
    <div class="group" style="width: 100%;height: 400px;">
        <div class="right" style="width: 100%;height: 400px;">
            <div class="gname" style="width: 100%">
                <div class="control-group">
                    <div class="controls" style="margin-left:0px; margin-top:30px; padding-left:0px;">
                        <label class="control-label" for="zm" id="bj"><fmt:message code="hr.th.Addname" />：</label>
                        <input type="text" id="zm" name="group_name" value="">
                        <span class="red" id="pp"><fmt:message code="hr.th.Required" /></span>
                    </div>
                </div>
            </div>

            <div style="width:100%;">
                <div style="width:543px;margin-left: 90px;">
                    <div style="width:200px; float:left">
                        <div style="width:200px; text-align:center;"><fmt:message code="hr.th.Requ" /></div>
                        <div style="width:200px; background-color:#f8f8f8;">
                            <select name="select1" ondblclick="func_delete();" style="width:200px;height:200px;padding-left: 30px;" multiple="multiple">
                            </select>
                        </div>
                        <div style="width:200px; text-align:center; margin-top: 5px;"><button type="button" class="btn" onClick="func_select_all1();"><fmt:message code="notice.th.allchose" /></button></div>
                    </div>

                    <div style="width:143px;height:250px; float:left; position:relative;">
                        <button type="button" style="position:absolute;top:30%;left:25%;" class="btn btn-success" onClick="func_insert();"><i class="icon-arrow-left icon-white"></i><fmt:message code="global.lang.add" /></button>
                        <button type="button" style="position:absolute;top:50%;left:25%;" class="btn btn-danger" onClick="func_delete();"><i class="icon-arrow-right icon-white"></i><fmt:message code="netdisk.th.Remove" /></button>
                    </div>

                    <div style="width:200px; float:left">
                        <div style="width:200px; text-align:center;"><fmt:message code="netdisk.th.members" /></div>
                        <div style="width:200px;background-color:#f8f8f8;">
                            <select name="select2" ondblclick="func_insert();" style="width:200px;height:200px;padding-left: 30px;" multiple="multiple">
                            </select>
                        </div>
                        <div style="width:200px; text-align:center;margin-top: 10px;"><button type="button" class="btn" onClick="func_select_all2();"><fmt:message code="notice.th.allchose" /></button></div>
                    </div>
                    <div style="clear:both; width:480px; text-align:center; padding-top:10px;"><p><span style="color:#F00;"><fmt:message code="news.th.notes" />：</span><fmt:message code="hr.th.ClickItems" />！</p></div>
                </div>
            </div>

            <div id="show_share" style="width:490px;height:150px;clear:both;padding-top:20px; display:none;">
                <div class="control-group" style="height:150px;">
                    <label class="control-label" for="yx"><fmt:message code="journal.th.Sharing" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px; ">
                        <input type="text" id="share_start" name="share_start" style="width:180px;" size="20" maxlength="19" value="" title="<fmt:message code="sup.th.startTime" />" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">&nbsp;<fmt:message code="global.lang.to" />&nbsp;
                        <input type="text" id="share_end" name="share_end" style="width: 180px;" size="20" maxlength="19" value="" title="<fmt:message code="meet.th.EndTime" />" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"><br>
                        <font color=red><b><fmt:message code="news.th.notes" />：</b></font><fmt:message code="meet.th.EndTime1" />！
                    </div>
                    <label class="control-label" for="yx"><fmt:message code="diart.th.scope" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px;">
                        <input type="hidden" name="to_id" id="to_id" value="">
                        <textarea rows="3" class="SmallStatic" name="to_name" id="to_name" style="width:270px;" readonly> </textarea>
                        <a href="#" class="orgAdd" onClick="SelectUser('10', '', 'to_id', 'to_name')"><fmt:message code="global.lang.add" /></a>
                        <a href="#" class="orgClear" onClick="ClearUser('to_id', 'to_name')"><fmt:message code="global.lang.empty" /></a><br>
                        <input type='checkbox' style="width:20px;" NAME='sms'/><fmt:message code="global.lang.transaction" />
                    </div>

                    <label class="control-label" for="yx"><fmt:message code="global.lang.content1" />：</label>
                    <div class="controls" style="margin-bottom:30px; width:480px;">
                        <input type="hidden" name="add_id_str" id="add_id_str" value="">
                        <textarea name="add_name_str" id="add_name_str" rows="3" style="overflow-y:auto;width:270px;" class="SmallStatic" wrap="yes" readonly></textarea>
                        <a href="javascript:;" class="orgAdd" onClick="SelectAdd('add_id_str','add_name_str','')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="orgClear" onClick="ClearUser('add_id_str', 'add_name_str')"><fmt:message code="global.lang.empty" /></a>&nbsp;&nbsp;
                    </div>
                </div>
            </div><!--共享隐藏区域-->
            <input type="hidden" name="FLD_STR" value="<?=$FLD_STR?>">
            <!--<div class="bts" style="margin-bottom: 50px;">
                <button type="button" class="button button-primary button-rounded" id="bc" onClick="mysubmit()">保存</button>
                <button type="button" class="btn button-rounded" id="fh" onClick="hide_dialog()">关闭</button>
            </div>-->
        </div>
    </div>
</form>
</body>