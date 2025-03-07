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
    <title><fmt:message code="customer.contactInformation" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="format-detection" content="telephone=yes"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="../css/address/right.css"/>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/index_ispirit.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <style>
        html{
            height:100%;
        }
        .lb {
            font-size: 14px;
        }
        img[src=""],img:not([src]){opacity:0;}
    </style>
</head>
<body topmargin="5" style="OVERFLOW-Y:auto;height: 100%">
<div class="content">
    <div class="right userName" id="right userName" style="height: 100%">
        <div class="pic">
            <a class="" style="border: 0px solid #ddd;">
                <img class="img-circle" src="" style="width: 90px;height: 90px;"/>
            </a>
        </div>
        <div class="jianjie">
            <p>
                <span id="xm" title="" style="color: #333333;font-size:20px;margin-right: 12px;"></span>
                <span id="zhiwu" title="" style="color: #666666;font-size: 16px;font-weight:bold;"></span>
            </p>
            <p id="gs" title="" style="color: #999999;font-size: 14px;font-weight:bold;margin-top: 4px;"></p>
            <ul id="mail">
            </ul>
        </div>
        <div class="address" style="border-top:1px solid #f1f1f1; padding-top:12px;word-break:break-all;">
            <form>
                <div id='phoneNumber' style="width:550px; margin-bottom:20px; float:left; ">
                </div>
            </form>
        </div>
    </div>
    <div id="dept" style="display: none;padding-left:20px;">
        <h2><fmt:message code="userManagement.th.department" />：<span class="deptName"></span></h2>
        <p><fmt:message code="depatement.th.Telephone" />：<span class="tel"> </span></p>
        <p><fmt:message code="depatement.th.fax" />：<span class="No"> </span></p>
        <p><fmt:message code="depatement.th.address" />：<span class="add"> </span></p>
    </div>
</div>
<script>

    $(window).resize(function(){
        $('#right').height($(window).height());
    });

    var param = $.GetRequest();
    var uid = param["uid"];
    var userId = param["userId"];
    var SHARE_TYPE = param["SHARE_TYPE"];
    var url = "";
    //SHARE_TYPE = 2,即获取同事信息
    if(param.deptId){
        $.ajax({
            url:'/department/getDeptById',
            type:'get',
            data:{deptId:param.deptId},
            dataType:'json',
            success:function(res){
//                var data=res.object;
//                $('.deptName').html(data.deptName);
//                $('.No').html(data.faxNo);
//                $('.tel').html(data.telNo);
//                $('.add').html(data.deptAddress);
                if (res.flag) {
                    var data = res.object;
                    // 部门图标
                    var icon = data["attachmentName"];
                    icon = "../img/address/department.png";
                    $(".img-circle").attr("src",icon);
                    $("#xm").attr("title",data["deptName"])
                    $("#xm").text(data["deptName"]);
//                    $("#gs").attr("title",data["deptName"]);
//                    $("#gs").text(data["deptName"]);
//                    var mailcontent = " <li style='cursor:pointer;'><img src='../img/address/A1.png' width='31' height='29' title='发送邮件' onClick='send_email("+data["email"]+");' />" +
//                        "</li><li style='cursor:pointer;'><img src='../img/address/A3.png' width='31' height='29' title='发送短信' onClick='window.open('../../../mobile_sms/new/index.php?TO_ID1="+1+"','','height=550,width=800,status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,left=110,top=60,resizable=yes')' /></li>";
//                            mailcontent += "<li style='cursor:pointer;'><img src='../img/address/A4.png' width='31' height='29' title='编辑' onClick='add_edit("+data["addId"]+");' /></li>" +
//                                "<li style='cursor:pointer;'><img src='../img/address/A2.jpg' width='31' height='29' title='删除' onClick='delete_add("+data["addId"]+","+data["groupId"]+");'/></li>"
//
//                    $("#mail").html(mailcontent);
                    var phoneNumber = "";
                    if(data.telNo!="") {
                        phoneNumber += "<div style='float: left;width: 500px;'>"
                            + "<label class='lb'>电话</label>"+data.telNo+"<br>"
                            + "</div>"
                    }
                    if(data.faxNo!="") {
                        phoneNumber += "<div style='float: left;width: 500px;'>"
                            + "<label class='lb'><fmt:message code="depatement.th.fax" /></label>"+data.faxNo+"<br>"
                            + "</div>"
                    }
                    if(data.deptAddress!="") {
                        phoneNumber += "<div style='float: left;width: 500px;'>"
                            + "<label class='lb'><fmt:message code="depatement.th.address" /></label>"+data.deptAddress+"<br>"
                            + "</div>"
                    }
                    $("#phoneNumber").html(phoneNumber)
                }

            }
        })
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){

                var data = obj.object.unitName;
//                $("#zhiwu").attr("title",data["userPrivName"]);
//                $("#zhiwu").text(data["userPrivName"]);
                $('#gs').text(data).attr('title',data);

            }
        })

    }else{
        if (SHARE_TYPE && SHARE_TYPE == 2) {


            url = "/address/queryUserInfoById";

            var data1={"uid" : param.uid}

            $('#right').height($(window).height());
            $('#dept').css('display','none');
            // 填充联系人信息
            $.ajax({
                type: "get",
                url: url,
                data: data1,
                success: function (res) {
                    if (res.flag) {
                        var data = res.object;
                        // 为了确保sendSms方法能正常传参执行，而定义的变量，其他地方请直接使用data.mobilNo
                        var mobilPhoneNo = data.mobilNo?data.mobilNo:"";
                        if (mobilPhoneNo == undefined || mobilPhoneNo == "") mobilPhoneNo = 0;

                        if(data.mobilNo == undefined){
                            data.mobilNo = ''
                        }
                        if(data["email"] == undefined){
                            data["email"] = ''
                        }

                        //我的同事 用户头像
                        var url_pic = "";
                        if (data.avatar != '') {
                            if (data.avatar == '0') {
                                url_pic = "../img/address/smallMan.png";
                            } else if (data.avatar === '1') {
                                url_pic = "../img/address/smallWoman.png";
                            } else {
                                url_pic = '/img/user/' + data.avatar;
                            }
                        } else {
                            if (data.sex == '0') {
                                url_pic = '/img/user/boy.png';
                            } else {
                                url_pic = '/img/user/girl.png';
                            }
                        }

                        $(".img-circle").attr("src",url_pic);
                        $("#xm").attr("title",data["userName"])
                        $("#xm").text(data["userName"]);
                        $("#zhiwu").attr("title",data["userPrivName"]);
                        $("#zhiwu").text(data["userPrivName"]);
                        $("#gs").attr("title",data["deptName"]);
                        $("#gs").text(data["deptName"]);
                        // console.log(data)
                        var mailcontent = " <li class='emailLi' style='cursor:pointer;'>" +
                            "<img class='email' src='../img/address/email.png' style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendAnEmail" />' email='"+(data.addressWithBLOBs?data.addressWithBLOBs.email:"")+"' />" +
                            "</li>" +
                            "<li class='smsLi' style='cursor:pointer;'>" +
                            "<img src='../img/address/sms.png'style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendATextMessage" />' onClick='sendSms("+ uid +", "+ mobilPhoneNo +", 1);' />" +
                            "</li>";
                        // onClick='window.open('../../../mobile_sms/new/index.php?TO_ID1="+1+"','','height=550,width=800,status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,left=110,top=60,resizable=yes')'
//                            mailcontent += "<li style='cursor:pointer;'><img src='../img/address/A4.png' width='31' height='29' title='编辑' onClick='add_edit("+data["addId"]+");' /></li>" +
//                                "<li style='cursor:pointer;'><img src='../img/address/A2.jpg' width='31' height='29' title='删除' onClick='delete_add("+data["addId"]+","+data["groupId"]+");'/></li>"

                        $("#mail").html(mailcontent);
                        var phoneNumber = "";
                        if(data["mobilNo"]!="") {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="userDetails.th.mobilePhone" /></label>"
                                + '<a href="tel://'+ data.mobilNo +'">' + data["mobilNo"] + "</a>" + "<br>"
                            // + '<span onclick="callPhone('+ data.mobilNo + ')">' + data["mobilNo"] + "</span>" + "<br>"
                                + "</div>"
                        }
                        if(data["telNoDept"]!=""&& data["telNoDept"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="depatement.th.phone" /></label>"+data["telNoDept"]+"<br>"
                                + "</div>"
                        }
                        if(data["email"]!="") {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="email.th.mail" /></label>"+data["email"]+"<br>"
                                + "</div>"
                        }
                        $("#phoneNumber").html(phoneNumber)
                        //判断是否开启三员管理
                        $.ajax({
                            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                            success:function(res) {
                                var data = res.object[0];
                                if(data.paraValue == 0){
                                    $(".emailLi").hide();
                                    $(".smsLi").hide();
                                }
                            }
                        })
                    }
                }
            })

        }
        else {
            url = "/address/getUserInfoById";

            $('#right').height($(window).height());
            $('#dept').css('display','none');
            // 填充联系人信息
            $.ajax({
                type: "post",
                url: url,
                data: param,
                success: function (res) {
                    if (res.status) {
                        var data = res.data;
                        // 为了确保sendSms方法能正常传参执行，而定义的变量，其他地方请直接使用data.mobilNo
                        var mobilPhoneNo = data.addressWithBLOBs.mobilNo;
                        if (mobilPhoneNo == undefined || mobilPhoneNo == "") mobilPhoneNo = 0;
                        // 我的分组 用户头像
                        var icon = data.addressWithBLOBs.attachmentId;
                        if (icon == "") {
                            if (data.addressWithBLOBs["sex"] == 1) {
                                icon = "../img/address/smallWoman.png";
                            } else {
                                icon = "../img/address/smallMan.png";
                            }
                        } else {
                            icon = '../ui/img/address/' + icon.replace("s", "");
                        }

                        $(".img-circle").attr("src", icon);
                        $("#xm").attr("title",data.addressWithBLOBs["psnName"])
                        $("#xm").text(data.addressWithBLOBs["psnName"]);
                        $("#zhiwu").attr("title",data.addressWithBLOBs["ministration"]);
                        $("#zhiwu").text(data.addressWithBLOBs["ministration"]);
                        $("#gs").attr("title",data.addressWithBLOBs["deptName"]);
                        $("#gs").text(data.addressWithBLOBs["deptName"]);
                        var mailcontent = " <li class='emailLi' style='cursor:pointer;margin-left: -20px;'>" +
                            "<img class='email' src='../img/address/email.png' style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendAnEmail" />' email='"+data.addressWithBLOBs.email+"' />" +
                            '</li>' +
                            '<li class="smsLi" style="cursor:pointer;">' +
                            "<img src='../img/address/sms.png'style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendATextMessage" />'  onClick='sendSms("+ uid +","+ mobilPhoneNo +",2);'/>" +
                            '</li>'
                        // onClick="window.open('../../address/group/sendMessage.jsp?TO_ID1=123,','','height=550,width=800,status=1,toolbar=no,menubar=no,location=no,scrollbars=yes,left=110,top=60,resizable=yes')"
                        mailcontent += "<li style='cursor:pointer;'><img src='../img/address/edit.png' style=' height: 20px;width: 20px;' title='<fmt:message code="global.lang.edit" />' onClick='add_edit("+data.addressWithBLOBs["addId"]+");' /></li>" +
                            "<li style='cursor:pointer;'><img src='../img/address/doDelete.png' style=' height: 20px;width: 20px;' title='<fmt:message code="global.lang.delete" />' onClick='delete_add("+data.addressWithBLOBs["addId"]+","+data.addressWithBLOBs["groupId"]+");'/></li>"

                        $("#mail").html(mailcontent);
                        var phoneNumber = "";
                        if(data.addressWithBLOBs["deptName"]!="" && data.addressWithBLOBs["deptName"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="userManagement.th.department" /></label>\n"
                                + '<span>' + data.addressWithBLOBs["deptName"] + "</span>" + "<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["ministration"]!="" && data.addressWithBLOBs["ministration"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="main.position" /></label>\n"
                                + '<span>' + data.addressWithBLOBs["ministration"] + "</span>" + "<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["mobilNo"]!="" && data.addressWithBLOBs["mobilNo"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;'>"
                                + "<label class='lb'><fmt:message code="userDetails.th.mobilePhone" /></label>\n"
                                + '<a href="tel://'+ data.mobilNo +'">' + data.addressWithBLOBs["mobilNo"] + "</a>" + "<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["telNoDept"]!=""&&data.addressWithBLOBs["telNoDept"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="depatement.th.phone" /></label>"+data.addressWithBLOBs["telNoDept"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["telNoHome"]!=""&&data.addressWithBLOBs["telNoHome"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="depatement.th.telephone" /></label>"+data.addressWithBLOBs["telNoHome"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["faxNoDept"]!=""&&data.addressWithBLOBs["faxNoDept"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="url.th.Workfax" /></label>"+data.addressWithBLOBs["faxNoDept"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["perWeb"]!=""&&data.addressWithBLOBs["perWeb"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="url.th.Home1" /></label>"+data.addressWithBLOBs["perWeb"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["icqNo"]!=""&&data.addressWithBLOBs["icqNo"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="address.th.MSN" /></label>"+data.addressWithBLOBs["icqNo"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["oicqNo"]!=""&&data.addressWithBLOBs["oicqNo"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="address.th.QQ" /></label>"+data.addressWithBLOBs["oicqNo"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["sex"]!=""&&data.addressWithBLOBs["sex"]!=null) {
                            var sex;
                            if(data.addressWithBLOBs["sex"] == '1'){
                                sex = '<fmt:message code="userInfor.th.female" />'
                            }else{
                                sex = '<fmt:message code="userInfor.th.male" />'
                            }
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="userDetails.th.Gender" /></label>"+sex+"<br>"
                                + "</div>"
                        }
                        if(data["birthday"]!=""&&data["birthday"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="userInfor.th.Birthday" /></label>"+data["birthday"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["nickName"]!=""&&data.addressWithBLOBs["nickName"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="workflow.th.nickname" /></label>"+data.addressWithBLOBs["nickName"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["addDept"]!=""&&data.addressWithBLOBs["addDept"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="workflow.th.officeAddress" /></label>"+data.addressWithBLOBs["addDept"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["addHome"]!=""&&data.addressWithBLOBs["addHome"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="workflow.th.Address" /></label>"+data.addressWithBLOBs["addHome"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["postNoDept"]!=""&&data.addressWithBLOBs["postNoDept"]!=null) {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="controller.th.liu" /></label>"+data.addressWithBLOBs["postNoDept"]+"<br>"
                                + "</div>"
                        }
                        if(data.addressWithBLOBs["email"]!="") {
                            phoneNumber += "<div style='float: left;width: 500px;height: 35px;'>"
                                + "<label class='lb'><fmt:message code="email.th.mail" /></label>"+data.addressWithBLOBs["email"]+"<br>"
                                + "</div>"
                        }
                        $("#phoneNumber").html(phoneNumber)
                        //判断是否开启三员管理
                        $.ajax({
                            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                            success:function(res) {
                                var data = res.object[0];
                                if(data.paraValue == 0){
                                    $(".emailLi").hide();
                                    $(".smsLi").hide();
                                }
                            }
                        })
                    }
                }
            })
        }
    }

    function add_edit(add_id)
    {
        //eval("parent.form1."+NAME+".value=VALUE")
        parent.document.getElementById('show_add_id').value = add_id;
        parent.document.getElementById('edit').click();
    }
    function delete_add(ADD_ID,GROUP_ID)
    {
        // console.log(ADD_ID,GROUP_ID)
        var msg='<fmt:message code="global.lang.transadel" />？';
        if(window.confirm(msg))
        {
            var data = {"addId":ADD_ID,"groupId":GROUP_ID};
//            console.log(data);
            $.ajax({
                type: "post",
                url: "/address/deleteUser",
                data: data,
                success: function(res){
                    if(res.status){
                        alert("<fmt:message code="workflow.th.delsucess" />");
                        parent.location.reload();
                        parent.close();
                    }else{
                        alert("<fmt:message code="lang.th.deleSucess" />！\n"+res.message);
                    }
                }
            })
        }
    }
    function sendSms(uid, mobilNo, type) {
        var userName = $('#xm').attr('title');
        if (mobilNo == 0) {
            layer.msg("<fmt:message code="address.th.mobilePhoneIsEmptyUnableToSend" />");
            return;
        }
        if(type == '2'){
            var ua = navigator.userAgent.toLowerCase();
            if(ua.indexOf("android") > -1 || ua.indexOf("iPhone") > -1) {
                $('.smsLi').css('display','none')
                var obj = document.createElement("li");
                obj.innerHTML='<a href="sms:'+ mobilNo +'">' +
                    "<img src='../img/address/sms.png'style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendATextMessage" />' />" +
                    "</a>";
                $('.emailLi').after(obj);
            }else{
                window.open('/address/sendMessage?userName='+ userName +"&uid="+ uid +"&mobilNo="+ mobilNo);
            }
        } else {
            var ua = navigator.userAgent.toLowerCase();
            if(ua.indexOf("android") > -1 || ua.indexOf("iPhone") > -1) {
                $('.smsLi').css('display','none')
                var obj=document.createElement("li");
                obj.innerHTML='<a href="sms:'+ mobilNo +'">' +
                    "<img src='../img/address/sms.png'style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendATextMessage" />' />" +
                    "</a>";
                $('.emailLi').after(obj);
            }else{
                window.open('/address/oaMessage?userName='+ userName +'&uid='+ uid);
            }
        }
    }

    $('#mail').on('click', '.email', function () {
        var email = $(this).attr("email");
        if (SHARE_TYPE != 2 && email === "") {
            layer.msg("<fmt:message code="address.th.emailIsEmptyUnableToSend" />");
            return;
        }
        var ua = navigator.userAgent.toLowerCase();
        if (ua.indexOf("android") > -1 || ua.indexOf("iPhone") > -1) {
            $('.emailLi').css('display', 'none')
            var obj = document.createElement("li");
            obj.style.marginLeft = '-20px'
            obj.innerHTML = '<a href="mailto:johndoe@sample.com">' +
                "<img src='../img/address/email.png' style=' height: 20px;width: 20px;' title='<fmt:message code="address.th.sendAnEmail" />' />" +
                "</a>";
            $('#mail').prepend(obj);
        } else {
            var userName = $('#xm').attr('title');
            window.open('/email/addbox?type=1&userName=' + userName + '&userId=' + userId);
        }
    })

</script>
</body>
</html>
