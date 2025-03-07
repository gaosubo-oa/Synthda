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
    <title><fmt:message code="adding.th.fenzu" /></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.tag.css">
    <link rel="stylesheet" type="text/css" href="../css/address/new_add.css"/>
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>


    <script type="text/javascript">
        function delete_group(group_id) {
            msg = '<fmt:message code="user.th.default" />';
            if (window.confirm(msg)) {
//            URL="delete_group.php?GROUP_ID=" + group_id;
//            window.location=URL;
                $.ajax({
                    type: "post",
                    url: "/addressGroup/deleteGroups",
                    data: {"groupId":group_id},
                    success: function(res){
                        if(res.status){
                            $.layerMsg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                            window.location.reload();
                        }
                    }
                })
            }
        }
        function show_group(group_id, group_type,group_name) {
            if (group_type == '0') {
                document.getElementById('group_edit').src = "/addressGroup/showGroup?groupId=" + group_id;
            }
            else {
                document.getElementById('group_edit').src = "/addressGroup/showGroup?groupId=" + group_id;
            }
        }
        function group_new() {
            document.getElementById('group_edit').src = "/addressGroup/add";
        }

        function group_submit() {
            document.getElementById('group_edit').contentWindow.CheckForm();
        }

        //初始化左侧分组列表
        function initLeft() {
            $.ajax({
                type: "post",
                url: "/addressGroup/getGroups",
                success: function (res) {
                    if (res.status) {
                        var data = res.data;
                        var group = "";
                        if(data!=undefined&&data.length>0){
                            $("#group_edit").attr("src","/addressGroup/showGroup?groupId="+data[0].groupId)
                        }else{
                            $("#group_edit").attr("src","/addressGroup/showGroup?groupId=0")
                        }
                        for (var key in data) {
                            group += " <li class='fz' style='position:relative' onClick=show_group(" + data[key].groupId + ",0); title='" + data[key].groupName + "'><span style='margin-right:54px;width:80px;overflow: hidden;height:44px;text-overflow:ellipsis;white-space:nowrap;display: inline-block'>" + data[key].groupName + "</span><span class='dl' style='position:absolute;right:20px;*+top:5px;' onClick='delete_group(" + data[key].groupId + ");'><img class='imgx' src='../img/address/x.png' /></span></li>"
                        }
                        $(".leftul").append(group);
                    }
                }
            })
        }
        $(document).ready(function () {
            $(".imgx").mouseover(function () {
                $(this).attr("src", "../img/address/x-hover-gray.png");
            });
            $(".imgx").mouseout(function () {
                $(this).attr("src", "../img/address/x.png");
            });

            $(".fz").mouseover(function () {
                $(this).css("background-color", "rgb(238, 238, 238)")
            });
            $(".fz").mouseout(function () {
                $(this).css("background-color", "#f7f7f7")
            });

            jQuery(".leftul li").click(function () {
                jQuery(this).css("background-color", "rgb(238, 238, 238)")
                jQuery(this).parent().siblings().children().css("background-color", "#f7f7f7")
            })

            //左侧分组初始化
            initLeft();
        });
    </script>
</head>
<body>
<div class="group" style="width: 1000px;height: 400px;">
    <div class="left" style="width:213px;">
        <dl>
            <dt class="left1"><span><img src="../img/address/group.png"/></span><fmt:message code="adding.th.me" /></dt>
            <dd style="margin-left:0px;">
                <ul class="leftul"
                    style="height:270px;overflow-y:auto;overflow-x: hidden;position:relative;top:0px;left:0px;">
                    <%--<li class="fz" onClick="show_group('0','0');" style="text-align: left;">
                        <span class="left-span" src="../img/address/all.png" width="22" height="22"></span>
                        <span style="margin-left:61px;"><fmt:message code="adding.th.mo" /></span>
                    </li>--%>
                </ul>
            </dd>
            <button type="button" class="btn btn-success"
                    style="width:120px;height:35px;margin-left:40px;margin-top: 10px;" onClick="group_new();"><fmt:message code="user.th.NewPacket" />
            </button>
        </dl>
    </div>

    <div class="right" style="width: 787px;height: 400px;overflow: hidden;">
        <iframe width="100%" height="400px" id="group_edit" name="group_edit" frameborder="0"
                src="">
        </iframe>
    </div>
</div>
</body>
</html>