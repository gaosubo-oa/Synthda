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
    <title><fmt:message code="adding.th.contact" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="../css/address/middle.css?2"/>
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/address/InitialsDict.js?20220307"></script>
    <script type="text/javascript" src="../js/base/base.js"></script>
    <style>
        .th{
            font-size: 13pt;
        }
        td{

            font-size: 11pt;
        }
        .zimu{
            font-weight:normal;
        }
        .namelist li span{
            left:25px;
        }
        .namelist li:hover a{
            background-color:#ccebff;
        }
        .uesrs span img{
            overflow: hidden;
        }
        .active{
            background-color:#ccebff!important;

        }
    </style>
    <script>
        var SHARE_TYPE = "";

        function show_add(add_id) {

            var Show=2;
            parent.document.getElementById("show_add").src = "/address/show_add?uid="+ add_id +"&SHARE_TYPE="+param.share_type+ "&Show="+ Show;
        }
        function group_show_add(thiss,add_id, userId) {
            $('.namelist li').removeClass('active')
            $(thiss).addClass('active');
            parent.document.getElementById("show_add").src = "/address/show_add?uid="+ add_id +"&userId="+ userId +"&SHARE_TYPE="+4 ;
        }
        function show_user(uid, userId, type) {
            var $deptid = $('span[deptid='+ param["deptid"] +']', window.parent.document);
            if($deptid.attr('pd') == 1){
                $('span[deptid='+ param["deptid"] +']', window.parent.document).attr('pd','0');
                parent.show_dept(param["deptid"]);
            }else{
                parent.document.getElementById("show_add").src = "/address/show_add?uid="+ uid +"&userId="+ userId +"&SHARE_TYPE="+type ;
            }
        }
        //获取姓名拼音首字母
        function getFirestName(name) {
            var first = name.substr(0, 1);
            //如果首字母为汉字，获取第一个汉字的拼音
            if (name.length > 0 && name.charCodeAt(0) > 128) {
                for (var item in InitialsDict) {
                    if (InitialsDict[item].indexOf(first) > 0) {
                        if(item.toUpperCase()==undefined){
                            return ''
                        }else {
                            return item.toUpperCase();
                        }

                    }
                }
                return "#";
            } else if (name.length > 0) {
                //首字母为英文
                first = first.toUpperCase();
                if (first >= 'A' && first <= 'Z') {
                        return first;
                } else {
                    return "#";
                }
            }
        }
    </script>
</head>
<body id="body">

<script>
    var param = $.GetRequest();

    var data={
        deptId:param.groupId
    }
    var Show=param["Show"];
    var url = ""
    if(param.SHARE_TYPE == 2){
        url = "/address/selectUser"
        SHARE_TYPE = param["SHARE_TYPE"]
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: data,
            success: function (reg) {
                if (reg.flag) {
                    var data = reg.obj;

                    //保存姓名首字母的数组
                    var name = {};
                    //保存首字母的编号
                    var nidx = {};
                    var show_list = {};
                    for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                        name[String.fromCharCode(i)] = new Array();
                        nidx[String.fromCharCode(i)] = new Array();
                        show_list[String.fromCharCode(i)] = new Array();
                    }
                    name["#"] = new Array();
                    nidx["#"] = new Array();
                    show_list["#"] = new Array();
                    for (var item in data) {
                        show_add(data[0]["uid"])
                        //获取姓名首字母
                        var firstName = getFirestName(data[item]["userName"]);

                        //裁剪名字长度
                        var short_name = data[item]["userName"].length > 10 ? data[item]["userName"].substr(0, 10) : data[item]["userName"];

                        //设置头像
                        var url_pic = "";
                        if (data[item].avatar != '') {
                            if (data[item].avatar == '0') {
                                url_pic = '/img/workLog/basichead_man.png';
                            } else if (data[item].avatar === '1') {
                                url_pic = '/img/workLog/portrait3.png';
                            } else {
                                url_pic = '/img/user/' + data[item].avatar;
                            }
                        } else {
                            if (data[item].sex == '0') {
                                url_pic = '/img/user/boy.png';
                            } else {
                                url_pic = '/img/user/girl.png';
                            }
                        }

                        if (name[firstName]!=undefined&&name[firstName].length == 0) {
                            show_list[firstName]["show_add_id"] = data[item]["uid"];
                            show_list[firstName]["show_list"] = "<div class='zm'>"
                                + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                + "<ul class='namelist'>"
                                + '<li style="padding-left: 26px;display: flex;cursor: pointer;flex-direction: row;align-items: center;" onclick="show_user('+ data[item]["uid"] +', \''+ data[item]["userId"] +'\', '+ param.SHARE_TYPE +')"; title='+ data[item]["userName"] +'>'
                                + '<div style="margin: 0px 7px;">'
                                + "<span class='photo' style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > "
                                + '</div>'
                                + '<div>'
                                + "<a style='padding-left: 5px;'>" + short_name + "</a>"
                                + function () {
                                    // console.log(data[i].mobilNo)
                                   /* if (data[item]["mobilNo"] != "" && data[item]["mobilNo"] != undefined) {
                                        return '<p style=" font-size: 10px;color: #666;margin-left: 5px;">' + data[item]["mobilNo"] + ' </p>\n'
                                    }*/
                                    return '';
                                }()
                                + "</div></li >"
                        }else{
                            show_list[firstName]["show_list"] += '<li style="padding-left: 26px;display: flex;cursor: pointer;flex-direction: row;align-items: center;" onclick="show_user('+ data[item]["uid"] +', \''+ data[item]["userId"] +'\', '+ param.SHARE_TYPE +')"; title='+ data[item]["userName"] +'>'
                                + '<div style="margin: 0px 7px;">'
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span >"
                                + '</div>'
                                + '<div>'
                                + "<a style='padding-left: 5px;'>" + short_name + "</a>"
                                + function () {
                                    // console.log(data[i].mobilNo)
                                    if (data[item]["mobilNo"] != "" && data[item]["mobilNo"] != undefined) {
                                        return '<p style=" font-size: 10px;color: #666;margin-left: 4px;">' + data[item]["mobilNo"] +  ' </p>\n'
                                    }
                                    return '';
                                }()
                                +"</div></li >"
                        }
                        name[firstName].push(data[item]);
                    }
                    show_user(data[0]["uid"], data[0]["userId"], param.SHARE_TYPE);
                    //对应的ul标签结束
                    var startId = -1;
                    for(var key in show_list ){
                        if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                            if(startId = -1){
                                startId = show_list[key]["show_list"];
                            }
                            show_list[key]["show_list"] += "</ul></div>";
                            $("#body").append(show_list[key]["show_list"]);
                        }
                    }
                }
            }
        })
    }else if (param.SHARE_TYPE == 0){
        url =  "/address/getUsersById"
        SHARE_TYPE = param["SHARE_TYPE"]
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: param,
            success: function (reg) {
                if (reg.status) {
                    var data = reg.data;
                    if(data.length==0){
                    layer.msg("<fmt:message code="adding.th.noContactsAvailableAtTheMoment" />",{icon:6})
                    }
                    //保存姓名首字母的数组
                    var name = {};
                    //保存首字母的编号
                    var nidx = {};
                    var show_list = {};
                    for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                        name[String.fromCharCode(i)] = new Array();
                        nidx[String.fromCharCode(i)] = new Array();
                        show_list[String.fromCharCode(i)] = new Array();
                    }
                    name["#"] = new Array();
                    nidx["#"] = new Array();
                    show_list["#"] = new Array();
//                    show_add(data[0].addId)
                    for (var item in data) {

                        //获取姓名首字母
                        var firstName = getFirestName(data[item]["psnName"]);
                        //裁剪名字长度
                        var short_name = data[item]["psnName"].length > 10 ? data[item]["psnName"].substr(0, 10) : data[item]["psnName"];

                        //默认分组 用户头像
                        var url_pic = data[item].attachmentId;
                        if (url_pic == "") {
                            if (data[item]["sex"] == 1) {
                                url_pic = "../img/address/smallWoman.png";
                            } else {
                                url_pic = "../img/address/smallMan.png";
                            }
                        } else {
                            url_pic = '../ui/img/address/' + url_pic.replace("s", "");
                        }

                        if(name[firstName]==undefined){
                            name[firstName]=[]
                        }
                        if(name[show_list[firstName]]){
                            show_list[firstName]=[]
                        }
                        if(item==0){
                        if (name[firstName]!=undefined&&name[firstName].length == 0) {
                            show_list[firstName]["show_add_id"] = data[item]["addId"];
                            show_list[firstName]["show_list"] = "<div class='zm'>"
                                + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                + "<ul class='namelist'>"
                                + '<li class="uesrs active" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +' ,\''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                   return ''
                                }()+
                                "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0]["addId"])
                        }else{
                            show_list[firstName]["show_list"] += '<li class="uesrs" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +', \''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                    return ''
                                }()
                                + "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0]["addId"])
                        }
                    }else{
                            if (name[firstName]!=undefined&&name[firstName].length == 0) {
                                show_list[firstName]["show_add_id"] = data[item]["addId"];
                                show_list[firstName]["show_list"] = "<div class='zm'>"
                                    + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                    + "<ul class='namelist'>"
                                    + '<li class="uesrs" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +' ,\''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                    + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                        return ''
                                    }()+
                                    "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                    + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                    + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                    + "</span > </li >"
                                show_add(data[0]["addId"])
                            }else{
                                show_list[firstName]["show_list"] += '<li class="uesrs" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +', \''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                    + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                        return ''
                                    }()
                                    + "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                    + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                    + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                    + "</span > </li >"
                                show_add(data[0]["addId"])
                            }
                        }
                        name[firstName].push(data[item]);
                    }
                    //对应的ul标签结束
                    var startId = -1;
                    for(var key in show_list ){
                        if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                            if(startId = -1){
                                startId = show_list[key]["show_list"];
                            }
                            show_list[key]["show_list"] += "</ul></div>";
                            $("#body").append(show_list[key]["show_list"]);
                        }
                    }

                }
            }
        })
    }else if (param.SHARE_TYPE == 1){
        url =  "/address/getShareUsersById"
        SHARE_TYPE = param["SHARE_TYPE"]
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: param,
            success: function (reg) {
                if (reg.status) {
                    var data = reg.data;
                    //保存姓名首字母的数组
                    var name = {};
                    //保存首字母的编号
                    var nidx = {};
                    var show_list = {};
                    for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                        name[String.fromCharCode(i)] = new Array();
                        nidx[String.fromCharCode(i)] = new Array();
                        show_list[String.fromCharCode(i)] = new Array();
                    }
                    name["#"] = new Array();
                    nidx["#"] = new Array();
                    show_list["#"] = new Array();
//                    show_add(data[0].addId)
                    for (var item in data) {

                        //获取姓名首字母
                        var firstName = getFirestName(data[item]["psnName"]);
                        //裁剪名字长度
                        var short_name = data[item]["psnName"].length > 10 ? data[item]["psnName"].substr(0, 10) : data[item]["psnName"];

                        //设置头像
                        var url_pic = "";
                        if (data[item].avatar != '') {
                            if (data[item].avatar == '0') {
                                url_pic = '../img/address/smallMan.png';
                            } else if (data[item].avatar === '1') {
                                url_pic = '../img/address/smallWoman.png';
                            } else {
                                url_pic = '/img/user/' + data[item].avatar;
                            }
                        } else {
                            if (data[item].sex == '0') {
                                url_pic = '/img/user/boy.png';
                            } else {
                                url_pic = '/img/user/girl.png';
                            }
                        }

                        if (name[firstName]!=undefined&&name[firstName].length == 0) {
                            show_list[firstName]["show_add_id"] = data[item]["addId"];
                            show_list[firstName]["show_list"] = "<div class='zm'>"
                                + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                + "<ul class='namelist'>"
                                + '<li class="uesrs" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +' ,\''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                   return ''
                                }()+
                                "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0]["addId"])
                        }else{
                            show_list[firstName]["show_list"] += '<li class="uesrs" style="line-height: 41px;" onclick="group_show_add(this,'+ data[item]["addId"] +', \''+ data[item]["userId"] +'\')"; title="'+ data[item]["psnName"] +'">'
                                + "<input type='checkbox' class='chekEmail' checkid='" +data[item]["addId"] + "' emailid='" + data[item]["addId"] + "' style='width: 16px;display: none'>"+function(){
                                    return ''
                                }()
                                + "<a style='padding-left: 60px;display: inline;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0]["addId"])
                        }
                        name[firstName].push(data[item]);
                    }
                    //对应的ul标签结束
                    var startId = -1;
                    for(var key in show_list ){
                        if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                            if(startId = -1){
                                startId = show_list[key]["show_list"];
                            }
                            show_list[key]["show_list"] += "</ul></div>";
                            $("#body").append(show_list[key]["show_list"]);
                        }
                    }

                }
            }
        })
    }

    if(param.gettype&&param.gettype==1){
        var psnName=decodeURI(param.psnName);
        url =  "/address/selectAddress"
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: {psnName:psnName},
            success: function (reg) {
                if (reg.flag) {
                    var data = reg.obj;
//                    show_user(data[0].addId)
                    //保存姓名首字母的数组
                    var name = {};
                    //保存首字母的编号
                    var nidx = {};
                    var Show1;
                    var show_list = {};
                    for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                        name[String.fromCharCode(i)] = new Array();
                        nidx[String.fromCharCode(i)] = new Array();
                        show_list[String.fromCharCode(i)] = new Array();
                    }
                    name["#"] = new Array();
                    nidx["#"] = new Array();
                    show_list["#"] = new Array();
                    for (var item in data) {
                        //获取姓名首字母
                        var firstName = getFirestName(data[item]["psnName"]);
                        //裁剪名字长度
                        var short_name = data[item]["psnName"].length > 10 ? data[item]["psnName"].substr(0, 10) : data[item]["psnName"];

                        //设置头像
                        var url_pic = "";
                        if (data[item].avatar != '') {
                            if (data[item].avatar == '0') {
                                url_pic = '../img/address/smallMan.png';
                            } else if (data[item].avatar === '1') {
                                url_pic = '../img/address/smallWoman.png';
                            } else {
                                url_pic = '/img/user/' + data[item].avatar;
                            }
                        } else {
                            if (data[item].sex == '0') {
                                url_pic = '/img/user/boy.png';
                            } else {
                                url_pic = '/img/user/girl.png';
                            }
                        }

                        if (name[firstName]!=undefined&&name[firstName].length == 0) {
                            show_list[firstName]["show_add_id"] = data[item]["addId"];
                            show_list[firstName]["show_list"] = "<div class='zm'>"
                                + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                + "<ul class='namelist'>"
                                + "<li style='line-height: 41px;'onclick=show_add('" + data[item]["addId"] + "');  title=" + data[item]["psnName"] + ">"
                                + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0].addId)
                        }else{
                            show_list[firstName]["show_list"] += "<li style='line-height: 41px;'onclick=show_add('" + data[item]["addId"] + "');  title=" + data[item]["psnName"] + ">"
                                + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0].addId)
                        }
                        name[firstName].push(data[item]);
                    }
                    //对应的ul标签结束
                    var startId = -1;
                    for(var key in show_list ){
                        if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                            if(startId = -1){
                                startId = show_list[key]["show_list"];
                            }
                            show_list[key]["show_list"] += "</ul></div>";
                            $("#body").append(show_list[key]["show_list"]);
                        }
                    }

                }
            }
        })
    }else if(param.gettype&&param.gettype==2){
        var userName=decodeURI(param.userName);

        url =  "/address/selectUser"
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: {userName:userName},
            success: function (reg) {
                if (reg.flag) {
                    var data = reg.obj;
                    if(data!=undefined&&data.length>0){
                        show_user(data[0].uid, data[0]["userId"], param.gettype)
                        //保存姓名首字母的数组
                        var name = {};
                        //保存首字母的编号
                        var nidx = {};
                        var show_list = {};
                        for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                            name[String.fromCharCode(i)] = new Array();
                            nidx[String.fromCharCode(i)] = new Array();
                            show_list[String.fromCharCode(i)] = new Array();
                        }
                        name["#"] = new Array();
                        nidx["#"] = new Array();
                        show_list["#"] = new Array();


                        if(data.length!=0){
                            for(var i=0;i<data.length;i++){
                                //获取姓名首字母
                                var firstName = getFirestName(data[i]["userName"]);
                                //裁剪名字长度
                                var short_name = data[i]["userName"].length > 10 ? data[i]["userName"].substr(0, 10) : data[i]["userName"];

                                //设置头像
                                var url_pic = "";
                                if (data[i].avatar != '') {
                                    if (data[i].avatar == '0') {
                                        url_pic = '../img/address/smallMan.png';
                                    } else if (data[i].avatar === '1') {
                                        url_pic = '../img/address/smallWoman.png';
                                    } else {
                                        url_pic = '/img/user/' + data[i].avatar;
                                    }
                                } else {
                                    if (data[i].sex == '0') {
                                        url_pic = '/img/user/boy.png';
                                    } else {
                                        url_pic = '/img/user/girl.png';
                                    }
                                }

                                if (name[firstName]!=undefined&&name[firstName].length == 0) {
                                    show_list[firstName]["show_add_id"] = data[i]["uid"];
                                    show_list[firstName]["show_list"] = "<div class='zm'>"
                                        + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                        + "<ul class='namelist'>"
                                        + "<li style='line-height: 41px;'onclick=show_add('" + data[i]["uid"] + "');  title=" + data[i]["psnName"] + ">"
                                        + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                        + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                        + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                        + "</span > </li >"
                                }else{
                                    show_list[firstName]["show_list"] += "<li style='line-height: 41px;'onclick=show_add('" + data[i]["uid"] + "');  title=" + data[i]["psnName"] + ">"
                                        + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                        + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                        + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                        + "</span > </li >"
                                }
                                name[firstName].push(data[i]);
                            }

                        }

                        //对应的ul标签结束
                        var startId = -1;
                        for(var key in show_list ){
                            if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                                if(startId = -1){
                                    startId = show_list[key]["show_list"];
                                }
                                show_list[key]["show_list"] += "</ul></div>";
                                $("#body").append(show_list[key]["show_list"]);
                            }
                        }
                    }
                }
            }
        })
    }else if(param.gettype&&param.gettype==3){
        var userName=decodeURI(param.userName);

        url =  "/address/selectStartUser"
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'json',
            data: {userName:userName},
            success: function (reg) {
                if (reg.flag) {
                    var data = reg.obj;
//                    show_user(data[0].addId)
                    //保存姓名首字母的数组
                    var name = {};
                    //保存首字母的编号
                    var nidx = {};
                    var Show1;
                    var show_list = {};
                    for (var i = 'A'.charCodeAt(0); i <= 'Z'.charCodeAt(0); i++) {
                        name[String.fromCharCode(i)] = new Array();
                        nidx[String.fromCharCode(i)] = new Array();
                        show_list[String.fromCharCode(i)] = new Array();
                    }
                    name["#"] = new Array();
                    nidx["#"] = new Array();
                    show_list["#"] = new Array();
                    for (var item in data) {
                        //获取姓名首字母
                        var firstName = getFirestName(data[item]["psnName"]);
                        //裁剪名字长度
                        var short_name = data[item]["psnName"].length > 10 ? data[item]["psnName"].substr(0, 10) : data[item]["psnName"];

                        //设置头像
                        var url_pic = "";
                        if (data[item].avatar != '') {
                            if (data[item].avatar == '0') {
                                url_pic = '../img/address/smallMan.png';
                            } else if (data[item].avatar === '1') {
                                url_pic = '../img/address/smallWoman.png';
                            } else {
                                url_pic = '/img/user/' + data[item].avatar;
                            }
                        } else {
                            if (data[item].sex == '0') {
                                url_pic = '/img/user/boy.png';
                            } else {
                                url_pic = '/img/user/girl.png';
                            }
                        }

                        if (name[firstName]!=undefined&&name[firstName].length == 0) {
                            show_list[firstName]["show_add_id"] = data[item]["addId"];
                            show_list[firstName]["show_list"] = "<div class='zm'>"
                                + "<p id=" + firstName + " class='zimu' name=" + firstName + ">" + firstName + "</p>"
                                + "<ul class='namelist'>"
                                + "<li style='line-height: 41px;'onclick=show_add('" + data[item]["addId"] + "');  title=" + data[item]["psnName"] + ">"
                                + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;' >"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0].addId)
                        }else{
                            show_list[firstName]["show_list"] += "<li style='line-height: 41px;'onclick=show_add('" + data[item]["addId"] + "');  title=" + data[item]["psnName"] + ">"
                                + "<a style='padding-left: 60px;'>" + short_name + "</a>"
                                + "<span style = 'cursor: pointer;margin-top: 5px;width: 32px;height: 32px;position: absolute;'>"
                                + "<img src = " + url_pic + " height = '32px'  width = '32px' >"
                                + "</span > </li >"
                            show_add(data[0].addId)
                        }
                        name[firstName].push(data[item]);
                    }
                    //对应的ul标签结束
                    var startId = -1;
                    for(var key in show_list ){
                        if(show_list[key]["show_list"] && show_list[key]["show_list"]!=""){
                            if(startId = -1){
                                startId = show_list[key]["show_list"];
                            }
                            show_list[key]["show_list"] += "</ul></div>";
                            $("#body").append(show_list[key]["show_list"]);
                        }
                    }

                }
            }
        })
    }
    //标记已读
    $(".signReaders" , parent.document).click(function(){
        $('.chekEmail').prop('checked', false);
        $('.chekEmail').toggle();
    });
    //一键全选
    $(".selectReaders" , parent.document).click(function(){
        $('.chekEmail').attr('fuxuan','no');
        if ($('.chekEmail').prop('checked') == true) {
            $('.chekEmail').prop('checked', false);
            // $('.chekEmail').hide();
        } else {
            $('.chekEmail').show();
            $('.chekEmail').prop('checked', true);
        }
    })
    $('.middle').click(function(){
        alert(111)
    });

    //删除事件
    $("#delete" , parent.document).click(function(){
        var arrId2='';
        if($('.chekEmail').css('display') == 'inline-block'){
            $('.namelist li').find(".chekEmail:checkbox:checked").each(function(){
                var ueID=$(this).parents('.uesrs').find('input[type="checkbox"]').attr('checkid');
                arrId2+=ueID+',';
            })
        }
        arrId2=arrId2.substring(0,arrId2.length-1)
        if (arrId2.length==0){
            alert('<fmt:message code="address.th.pleaseSelectTheContactsToBeDeleted" />')
            return;
        }
       //if($('.chekEmail').css('display') == 'inline-block'){
            $('.namelist li').find(".chekEmail:checkbox:checked").each(function(){
                var ueID=$(this).parents('.uesrs').find('input[type="checkbox"]').attr('checkid');
                console.log(ueID)
            })
      //  }
        if(window.confirm('<fmt:message code="workflow.th.flowDeleteWarn2" />'))
        {
            $.ajax({
                type: "get",
                url: "/address/deleteUserAll",
                data: {
                    addId:arrId2
                },
                success: function(res){
                    if(res.status){
                        alert("<fmt:message code="workflow.th.delsucess" />");
                        parent.location.reload();
                    }else{
                        alert("<fmt:message code="lang.th.deleSucess" />！\n"+res.message);
                    }
                }
            })
        }

    })
</script>

</body>
</html>
