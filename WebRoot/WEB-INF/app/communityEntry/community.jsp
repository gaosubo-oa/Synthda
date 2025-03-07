<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="community" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <link rel="stylesheet" href="../css/notes/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/notes/base.css">
    <link rel="stylesheet" type="text/css" href="../css/notes/note.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="../js/notes/jquery-2.1.2.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="../js/notes/base.js"></script>
    <script type="text/javascript" src="../js/notes/note.js"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<%--    <script src="../../lib/layer/layer.js?20201106"></script>--%>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/base/base.js"></script>
    <style type="text/css">

        .dingbu{height :45px;border-bottom: 1px solid #999;}
        .dingbu .headImg {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .headImg img {
            width: 23px;
            height: 23px;
            margin-top: 11px;
            vertical-align: middle;
            border: 0;
        }

        .dingbu .divTitle {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: rgb(73, 77, 89);
        }
        .textList{
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 8;
            -webkit-box-orient: vertical;
            color: #333;
        }
        .btn_sps{
            color: rgb(255, 255, 255);
            font-size: 14px;
            line-height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            background: #2b7fe0!important;
            position: absolute;
            left: 37%;
            top: 65%;
        }
        .main_left{
            overflow: auto;
            width: 80%;
            border: 1px solid #ddd;
            margin-left: 15%;
            display: inline-block;
        }
        .main_right{
            overflow: hidden;
            width: 25%;
            display: inline-block;
            height: 50%;
            float: left;
            background: url(../../img/workLog/hearder_team_back.png) no-repeat;
            background-size: 100% 100%;
            min-height: 300px;
        }
        .modular_info .modular_name li {
            display: inline-block;
            float: left;
            padding-right: 10px;
            list-style: none;
        }
        /*.main_left .details {*/
        /*    padding: 0px 30px 30px;*/
        /*    border: 1px solid #ddd;*/
        /*    !* height: 800px; *!*/
        /*    margin-top: 40px;*/
        /*    margin-bottom: 10px;*/
        /*}*/
        .details_modular {
            border-bottom: 1px solid #ddd;
        }
        .modular_footer li {
            display: inline-block;
            float: left;
            padding-left: 6px;
            list-style: none;
        }
        .M-box3{margin-top:10px;float:right;margin-right: 8%;}
        .M-box3 a{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;text-decoration: none;}
        .M-box3 .active{margin: 0px 3px;width: 29px;height: 29px;line-height: 29px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
        .jump-ipt{margin: 0 3px;width: 30px;height: 22px;line-height: 29px;font-size: 12px;}
        .M-box3 a:hover{background: #2b7fe0;}
        select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
            height: 30px;
        }
        [class*="span"] {
            min-height: 1px;
            float: none;
        }
        .feed-ext-add-comment {
            margin-bottom: 30px!important;
        }
        .feed-ext-body {
            /*border: 1px solid #ddd;*/
            border-top: 0;
            width: 89%;
            padding: 5px;
            margin-left: 5%;
            height: 70px;
            margin-right: 5%;
        }
        .modular_footer {
            display: inline-block;
            float: right;
            position: absolute;
            right: 0px;
            bottom: 0;
        }
        .displayNone{
            display: none;
        }
        .displayBlock{
            display: block;
        }
        .picture{
            height: 70px;
            border: 1px solid #ddd;
            border-radius: 6px;
            width: 92%;
            margin-left: 6%;
            padding-left: 10px;
            outline: none;
            color: #9a9a9a;
            font-size: 16px;
            margin-top: 20px;
            padding: 5px 10px;
            background: #fcfcfc;
            position: relative;
        }
        .picture ul li {
            float: left;
            width: 60px;
            height: 60px;
            position: relative;
            margin-right: 10px;
            margin-bottom: 5px;
            margin-top: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            float: left;
            /* text-align: center; */
            line-height: 57px;
        }
        .picture ul li b {
            position: absolute;
            top: -9px;
            right: -10px;
            line-height: 1;
            color: red;
            cursor: pointer;
        }
        .imgLook{
            margin-left: 50px;
            width: 400px;
        }
        .big{
            height: 110px;
            width: 110px;
            float: left;
            margin-right: 10px;
            margin-bottom: 20px;
        }
        /*.big:only-child{*/
        /*    height: initial;  !*相当于删除已设置的某一属性*!*/
        /*    width: initial;*/
        /*    max-width: 230px;*/
        /*    max-height: 230px;*/
        /*}*/
        /*.big:nth-child(2):nth-last-child(3){*/
        /*    margin-right: 110px;*/
        /*}*/

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script  type="text/javascript">
        // 获取当前登录人信息
        var uid;
        var srcUser = '';
        var strs = '';
        var colors = '#6A9CCE';
        var userName;
        var pageNum;
        $.get('/getLoginUser',function(res) {
            if (res.flag) {
                uid = res.object.uid;
                userName = res.object.userName;
            }
        })
        $.get('/user/findUserByuid',{uid: uid}, function(res) {
            if (res.flag) {
                var avatar = res.object.avatar;
                if (avatar == undefined || avatar == "") {
                    avatar = res.object.sex;
                }
                if (avatar == 0) {
                    srcUser ='/img/email/icon_head_man_06.png'
                } else if (avatar == 1) {
                    srcUser ='/img/user/girl.png'
                } else {
                    srcUser = '/img/user/' + avatar
                }
                $('.userImg').attr('src',srcUser)
                $('.zong').html(res.object.userName)
            }
        })
        // $.post('/login', function(res) {
        //     if (res.flag) {
        //     }
        // })
        //初始化显示页面

        function clicked(){
            layer.msg('<fmt:message code="global.lang.doing" />', {icon: 6});
        }

        function onl_d(type,numpage){
            var ajaxPage={
                data:{
                    page:1,
                    pageSize:10,
                    useFlag:true,
                    uid:uid
                },
                page:function(types){
                    var me=this;
                    if(type == '1' && types != '2'){
                        $.ajax({
                            'url':'/weChat/selectWeChat',
                            'type':'get',
                            'dataType':'json',
                            'data':{
                                page:numpage,
                                pageSize:10,
                                useFlag:true,
                                uid:uid
                            },
                            success:function(rsp){
                                if(rsp.obj.length != 0){
                                    var length=rsp.obj.length;
                                    var data = rsp.obj;
                                    var divstr='';
                                    var imgs = '';
                                    var openimg;
                                    for(var i=0;i<length;i++){

                                        var src_sex ="";
                                        if(data[i].userSex!=undefined&&data[i].userSex!=''){
                                            if(data[i].userSex == '0'){
                                                src_sex='/img/workLog/basichead_man.png';
                                            }else{
                                                src_sex='/img/workLog/portrait3.png';
                                            }
                                        }else{
                                            src_sex='/img/workLog/basichead_man.png';
                                        }
                                        divstr += '<div class="tianErNiu1" uid="'+data[i].uid+'">' +
                                            '<div class="details_modular clearfix" style="margin-left: 5%;margin-right: 5%;height: auto;min-height: 167px; position: relative;">' +
                                            <%--头像--%>
                                            //                            ' <div class="modular_user"></div>' +
                                            ' <div class="modular_user"  style="float:left;display: inline-block;padding-top: 18px;">' +
                                            '<img src="'+ src_sex + '" style="width: 55px;height: 55px;" onerror="imgerror(this,1)">' +
                                            // '<img src="'+ function () {
                                            //     var avatar = data[i].userAvatar;
                                            //     if (avatar == undefined || avatar == "") {
                                            //         avatar = data[i].userSex;
                                            //     }
                                            //     if (avatar == 0) {
                                            //         return '/img/email/icon_head_man_06.png'
                                            //     } else if (avatar == 1) {
                                            //         return '/img/email/icon_head_woman_06.png'
                                            //     } else {
                                            //         return '/img/user/' + data[i].userAvatar
                                            //     }
                                            // }() + '" style="width: 55px;height: 55px;" onerror="imgerror(this,1)">' +
                                            '</div>' +
                                            <%--内容部分--%>
                                            '<div class="modular_info" style="padding-top: 18px;padding-bottom: 10px;">' +
                                            ' <div class="modular_title clearfix">' +
                                            '<div class="modular_name clearfix" style="margin-left: 10%;">' +
                                            '<div style="margin-top: 6px;"><span style="font-size: 15px;">' + data[i].userName + '</span>' +
                                            '<span style="margin-left:20px;color:#b4b4b4;">'+data[i].deptName+'</span>' +
                                            '<div style="color: #b4b4b4;font-size: 12px;margin-top: 5px;float:right">' +
                                            '<span>'+data[i].time+'</span>' +
                                            // '<span style="margin-left:20px">'+data[i].userPrivName+'</span>' +
                                            ' </div>' +
                                            '</div>' +
                                            '<div style="margin-bottom: 20px;text-overflow:ellipsis;overflow:hidden;white-space：nowrap;margin-top: 10px;">' + data[i].message + '</div>' +
                                            ' </div>' +
                                            ' </div>' +
                                            //图片显示区域
                                            '<div class="imgLook">' +
                                            function(){
                                                if(data[i].attachment.length != 0){
                                                    imgs = '';
                                                    openimg = '';
                                                    for(var j=0;j<data[i].attachment.length;j++){
                                                        console.log(data[i].attachment[j].attachName)
                                                        if(data[i].attachment[j].attachName.indexOf('.mp4')!=-1){
                                                            imgs += '<video class="big" type="1" id="playVideo" controls>' +
                                                                '<source type="video/mp4" src="/xs?'+data[i].attachment[j].attUrl+'" >'+
                                                                '</video>'
                                                        }else if(data[i].attachment[j].attachName.indexOf('.png')!=-1||data[i].attachment[j].attachName.indexOf('.jpg')!=-1||data[i].attachment[j].attachName.indexOf('.PNG')!=-1||data[i].attachment[j].attachName.indexOf('.JPG')!=-1){
                                                            var attchUrl = data[i].attachment[j].attUrl;
                                                            var domain = document.location.origin;
                                                            openimg += domain +'/xs?' + attchUrl +'*';
                                                            imgs += ' <img class="big" id="imgSee"   src="/xs?'+data[i].attachment[j].attUrl+'"   openNmu="'+ j +'">'
                                                        }else if(data[i].attachment[j].attachName.indexOf('.pdf')!=-1) {
                                                            var attchUrl = data[i].attachment[j].attUrl;
                                                            var domain = document.location.origin;
                                                            imgs += '<div style="display: inline-block;"><div class="pdfContainer" data-url='+data[i].attachment[j].attUrl+' style="width:80px;height:100px;display:inline-block;"><img style="height: 80px;width:80px;" src="/img/pdf.png"/><div style="font-size:12px;width: 80px;height: 20px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data[i].attachment[j].attachName+'</div></div><div style="font-size: 12px;"> <a href="/download?'+data[i].attachment[j].attUrl+'">下载</a> <a href="/common/PDFBrowser?'+data[i].attachment[j].attUrl+'"  target="_blank">预览</a> </div></div>'
                                                        }
                                                    }
                                                    return imgs;
                                                }else{
                                                    return '';
                                                }
                                            }()+
                                            '<p style="display:none" openimg="'+ openimg + '"></P>' +
                                            ' </div>' +
                                            '<div class="modular_footer">' +
                                            // ' <ul>' +
                                            // '<li><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + data[i].wid + ')">评论('+data[i].commentNum+')</a></li>' +
                                            // '<li style="margin-top: 2px;"><a style="color:black" href="javascript:;" class="likeNumber' + i + '" onclick= "like(' + i +',' +data[i].wid + ')">点赞('+data[i].likeNum+')</a></li>' +
                                            // ' </ul>' +
                                            ' <ul>' +
                                            '<li onclick= "details(' + i + ',' + data[i].wid + ')" style="cursor: pointer;"><img src="../img/weChat/comment.png"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + data[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="news.th.comment"/>('+data[i].commentNum+')</a></li>' +
                                            '<li onclick= "like(' + data[i].wid + ',' + i + ')" style="margin-left: 20px;cursor: pointer;"><img src="../img/weChat/like.png"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" class="likeNumber' + i + '" onclick= "like(' + data[i].wid + ',' + i + ')" style = "color:'+ colors+ '"> <fmt:message code="like.button" />('+data[i].likeNum+')</a></li>' +
                                            '<li onclick= "delete_log(' + data[i].wid + ')" style="margin-left: 20px;cursor: pointer;" ><img src="../img/weChat/delete.png" class="'+
                                            function(){
                                                if(uid == '1'){
                                                    return " displayBlock "
                                                }else{
                                                    if(data[i].uid != uid){
                                                        return " displayNone "
                                                    }else{
                                                        return " displayBlock "
                                                    }
                                                }
                                            }() + '"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" del='+data[i].wid+' class="'+
                                            function(){
                                                if(uid == '1'){
                                                    return " displayBlock "
                                                }else{
                                                    if(data[i].uid != uid){
                                                        return " displayNone "
                                                    }else{
                                                        return " displayBlock "
                                                    }
                                                }
                                            }()+'delete' + i + '" onclick= "delete_log(' + data[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="license.delete" /></a></li>' +
                                            '</ul>' +
                                            '</div>' +
                                            '</div>' +
                                            '</div>' +
                                            <%--评论--%>
                                            '<div class="feed-ext-body comment' + i + '" id="comment' + i + '" style="display: none;">' +
                                            '<div class="feed-ext-add-comment">' +
                                            '<form target="" action="" name="feed-comment-form" style="text-align: center;">' +
                                            ' <input class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;">' +
                                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context" style="width: 60%;height: 65%;margin-top: 10px;"></textarea>' +
                                            '<button type="button" class="btn btn-primary feed-submit-cmt-btn" cutId="" onclick="commentDia($(this),' + i +','+data[i].wid+ ')" style="margin-top: 28px;margin-left: 30px;"><fmt:message code="diary.th.remand" /></button>' +
                                            '<input type="hidden" name="comment-to" value="">' +
                                            ' <input type="hidden" name="comment-id" value="">' +
                                            '<input type="hidden" name="comment-type" value="">' +
                                            '<input type="hidden" name="diary-id" value="11">' +
                                            ' </form>' +
                                            ' </div>' +
                                            '   <ul class="feed-ext-list">' +

                                            ' </ul>' +
                                            '  </div>' +
                                            // 浏览信息
                                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                                            '   <div class="feed-ext-readers">' +
                                            '      <span></span>' +
                                            '   </div> ' +
                                            ' </div>'+
                                            '</div>';
                                    }
                                    $(".befor").html(divstr);
                                    // $(".imgLook").append(imgs);
                                    me.pageTwo(10,numpage,rsp.totleNum)
                                }else{
                                    $('.tishi').css("display","block");
                                }



                            }
                        });
                    }else{
                        $.ajax({
                            'url':'/weChat/selectWeChat',
                            'type':'get',
                            'dataType':'json',
                            'data':me.data,
                            success:function(rsp){
                                if(rsp.obj.length != 0){
                                    var length=rsp.obj.length;
                                    var data = rsp.obj;
                                    var divstr='';
                                    var imgs = '';
                                    var openimg;
                                    for(var i=0;i<length;i++){

                                        var src_sex ="";
                                        if(data[i].userSex!=undefined&&data[i].userSex!=''){
                                            if(data[i].userSex == '0'){
                                                src_sex='/img/workLog/basichead_man.png';
                                            }else{
                                                src_sex='/img/workLog/portrait3.png';
                                            }
                                        }else{
                                            src_sex='/img/workLog/basichead_man.png';
                                        }
                                        divstr += '<div class="tianErNiu1" uid="'+data[i].uid+'">' +
                                            '<div class="details_modular clearfix" style="margin-left: 5%;margin-right: 5%;height: auto;min-height: 167px; position: relative;">' +
                                            <%--头像--%>
                                            //                            ' <div class="modular_user"></div>' +
                                            ' <div class="modular_user"  style="float:left;display: inline-block;padding-top: 18px;">' +
                                            '<img src="'+ src_sex + '" style="width: 55px;height: 55px;" onerror="imgerror(this,1)">' +
                                            // '<img src="'+ function () {
                                            //     var avatar = data[i].userAvatar;
                                            //     if (avatar == undefined || avatar == "") {
                                            //         avatar = data[i].userSex;
                                            //     }
                                            //     if (avatar == 0) {
                                            //         return '/img/email/icon_head_man_06.png'
                                            //     } else if (avatar == 1) {
                                            //         return '/img/email/icon_head_woman_06.png'
                                            //     } else {
                                            //         return '/img/user/' + data[i].userAvatar
                                            //     }
                                            // }() + '" style="width: 55px;height: 55px;" onerror="imgerror(this,1)">' +
                                            '</div>' +
                                            <%--内容部分--%>
                                            '<div class="modular_info" style="padding-top: 18px;padding-bottom: 10px;">' +
                                            ' <div class="modular_title clearfix">' +
                                            '<div class="modular_name clearfix" style="margin-left: 10%;">' +
                                            '<div style="margin-top: 6px;"><span style="font-size: 15px;">' + data[i].userName + '</span>' +
                                            '<span style="margin-left:20px;color:#b4b4b4;">'+data[i].deptName+'</span>' +
                                            '<div style="color: #b4b4b4;font-size: 12px;margin-top: 5px;float:right">' +
                                            '<span>'+data[i].time+'</span>' +
                                            // '<span style="margin-left:20px">'+data[i].userPrivName+'</span>' +
                                            ' </div>' +
                                            '</div>' +
                                            '<div style="margin-bottom: 20px;text-overflow:ellipsis;overflow:hidden;white-space：nowrap;margin-top: 10px;">' + data[i].message + '</div>' +
                                            ' </div>' +
                                            ' </div>' +
                                            //图片显示区域
                                            '<div class="imgLook">' +
                                            function(){
                                                if(data[i].attachment.length != 0){
                                                    imgs = '';
                                                    openimg = '';
                                                    for(var j=0;j<data[i].attachment.length;j++){
                                                        if(data[i].attachment[j].attachName.indexOf('.mp4')!=-1){
                                                            imgs += '<video class="big" type="1" id="playVideo" controls>' +
                                                                '<source type="video/mp4" src="/xs?'+data[i].attachment[j].attUrl+'" >'+
                                                                '</video>'
                                                        }else if(data[i].attachment[j].attachName.indexOf('.png')!=-1||data[i].attachment[j].attachName.indexOf('.jpg')!=-1||data[i].attachment[j].attachName.indexOf('.PNG')!=-1||data[i].attachment[j].attachName.indexOf('.JPG')!=-1){
                                                            var attchUrl = data[i].attachment[j].attUrl;
                                                            var domain = document.location.origin;
                                                            openimg += domain +'/xs?' + attchUrl +'*';
                                                            imgs += ' <img class="big" id="imgSee"   src="/xs?'+data[i].attachment[j].attUrl+'"   openNmu="'+ j +'">'
                                                        }else if(data[i].attachment[j].attachName.indexOf('.pdf')!=-1) {
                                                            var attchUrl = data[i].attachment[j].attUrl;
                                                            var domain = document.location.origin;
                                                            imgs += '<div style="display: inline-block;"><div class="pdfContainer" data-url='+data[i].attachment[j].attUrl+' style="width:80px;height:100px;display:inline-block;"><img style="height: 80px;width:80px" src="/img/pdf.png"/><div style="font-size:12px;width: 80px;height: 20px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data[i].attachment[j].attachName+'</div></div><div style="font-size: 12px;"> <a href="/download?'+data[i].attachment[j].attUrl+'">下载</a> <a href="/common/PDFBrowser?'+data[i].attachment[j].attUrl+'"  target="_blank">预览</a> </div></div>'
                                                        }
                                                    }
                                                    return imgs;
                                                }else{
                                                    return '';
                                                }
                                            }()+
                                            '<p style="display:none" openimg="'+ openimg + '"></P>' +
                                            ' </div>' +
                                            '<div class="modular_footer">' +
                                            // ' <ul>' +
                                            // '<li><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + data[i].wid + ')">评论('+data[i].commentNum+')</a></li>' +
                                            // '<li style="margin-top: 2px;"><a style="color:black" href="javascript:;" class="likeNumber' + i + '" onclick= "like(' + i +',' +data[i].wid + ')">点赞('+data[i].likeNum+')</a></li>' +
                                            // ' </ul>' +
                                            ' <ul>' +
                                            '<li onclick= "details(' + i + ',' + data[i].wid + ')" style="cursor: pointer;"><img src="../img/weChat/comment.png"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + data[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="news.th.comment"/>('+data[i].commentNum+')</a></li>' +
                                            '<li onclick= "like(' + data[i].wid + ',' + i + ')" style="margin-left: 20px;cursor: pointer;"><img src="../img/weChat/like.png"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" class="likeNumber' + i + '" onclick= "like(' + data[i].wid + ',' + i + ')" style = "color:'+ colors+ '"><fmt:message code="like.button" />('+data[i].likeNum+')</a></li>' +
                                            '<li onclick= "delete_log(' + data[i].wid + ')" style="margin-left: 20px;cursor: pointer;" ><img src="../img/weChat/delete.png" class="'+
                                            function(){
                                                if(uid == '1'){
                                                    return " displayBlock "
                                                }else{
                                                    if(data[i].uid != uid){
                                                        return " displayNone "
                                                    }else{
                                                        return " displayBlock "
                                                    }
                                                }
                                            }() + '"></li>'+
                                            '<li style="margin-top: 2px;"><a href="javascript:;" del='+data[i].wid+' class="'+
                                            function(){
                                                if(uid == '1'){
                                                    return " displayBlock "
                                                }else{
                                                    if(data[i].uid != uid){
                                                        return " displayNone "
                                                    }else{
                                                        return " displayBlock "
                                                    }
                                                }
                                            }()+'delete' + i + '" onclick= "delete_log(' + data[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="license.delete" /></a></li>' +
                                            '</ul>' +
                                            '</div>' +
                                            '</div>' +
                                            '</div>' +
                                            <%--评论--%>
                                            '<div class="feed-ext-body comment' + i + '" id="comment' + i + '" style="display: none;">' +
                                            '<div class="feed-ext-add-comment">' +
                                            '<form target="" action="" name="feed-comment-form" style="text-align: center;">' +
                                            ' <input class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;">' +
                                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context" style="width: 60%;height: 65%;margin-top: 10px;"></textarea>' +
                                            '<button type="button" class="btn btn-primary feed-submit-cmt-btn" cutId="" onclick="commentDia($(this),' + i +','+data[i].wid+ ')" style="margin-top: 28px;margin-left: 30px;"><fmt:message code="diary.th.remand" /></button>' +
                                            '<input type="hidden" name="comment-to" value="">' +
                                            ' <input type="hidden" name="comment-id" value="">' +
                                            '<input type="hidden" name="comment-type" value="">' +
                                            '<input type="hidden" name="diary-id" value="11">' +
                                            ' </form>' +
                                            ' </div>' +
                                            '   <ul class="feed-ext-list">' +

                                            ' </ul>' +
                                            '  </div>' +
                                            // 浏览信息
                                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                                            '   <div class="feed-ext-readers">' +
                                            '      <span></span>' +
                                            '   </div> ' +
                                            ' </div>'+
                                            '</div>';
                                    }
                                    $(".befor").html(divstr);
                                    // $(".imgLook").append(imgs);
                                    me.pageTwo(me.data.pageSize,me.data.page,rsp.totleNum)
                                }else{
                                    $('.tishi').css("display","block");
                                }



                            }
                        });
                    }
                },
                pageTwo:function ( pageSize,indexs,totalData) {//设置分页
                    var mes=this;
                    $('#dbgz_page').pagination({
                        totalData: totalData,
                        showData: pageSize,
                        jump: true,
                        coping: true,
                        homePage:'',
                        // endPage: '',
                        current:indexs||1,
                        callback: function (index) {
                            mes.data.page=index.getCurrent();
                            pageNum = index.getCurrent();
                            mes.page(2);
                        }
                    });
                }
            };
            ajaxPage.page();
        }
        //查看评论
        function details(i,wid) {
            $('.btn-primary').attr('btnType','2');
            if ($("#comment" + i).css('display') == 'block') {
                $("#comment" + i).hide();
                $('.feed-cmt-list-item').hide();
                $(".commentNumber" + i).removeClass("font_color");
            } else {
                disComment(i,wid)
                $("#comment" + i).show();
                $(".commentNumber" + i).addClass("font_color");
            }
        };
        // 提交按钮
        function commentDia(that,num,wid){
            var cmtTpe=that.attr('cutId');
            var val=that.siblings('.feed-ext-add-comment-to').val();
            if(that.siblings('.feed-ext-add-comment-to').css('display') == 'none'){
                commentEvent(num,wid);
            }else if(that.siblings('.feed-ext-add-comment-to').css('display') == 'inline-block'){
                replayCommetTo(cmtTpe,val,num,wid)
            }
        }
        //评论接口
        function commentEvent(num,wid){
            var content = $('.comment'+num+' textarea').val();
            var data = {
                wid:wid,
                message:content
            };
            if(content == null || content =="" ){
                layer.msg("内容不能为空",{icon:2},function(){
                    return false;
                });
            }else{
                $.ajax({
                    url: "/weChatComment/insertWeChatComment",
                    type: 'post',
                    dataType: "JSON",
                    data: data,
                    async: false,
                    success: function (res) {
                        if(res.flag){
                            layer.msg('评论成功！',{icon:6});/*评论成功*/
                            $('.feed-submit-cmt-context').val('');
                            $('.feed-ext-body comment' +num).css('display','none');
                            // disComment(num,wid)
                            onl_d(1,pageNum);
                        }
                    }
                });
            }

        }
        //评论显示
        function disComment(num,wid){
            $('.feed-cmt-list-item').remove();
            $.ajax({
                url: "/weChatComment/selectWeChatCommentByWID",
                type: 'get',
                dataType: "JSON",
                data: "wid="+wid,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        for (var j = 0; j < res.obj.length; j++) {
                            var stra='';
                            if(res.obj[j].weChatCommentReplyList != ''){
                                for(var i=0; i<res.obj[j].weChatCommentReplyList.length; i++){
                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;margin-left:3%;margin-top: 10px;margin-right: 3%;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user" style="color: #2A94CF;">'+res.obj[j].weChatCommentReplyList[i].userName+'</a>&nbsp; &nbsp;<span><fmt:message code="email.th.reply" /></span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].weChatCommentReplyList[i].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext" style="color: #AAABAF;float: right;">' +
                                        '       <span>'+res.obj[j].weChatCommentReplyList[i].time+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].weChatCommentReplyList[i].rid+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))" style="color: #2A94CF;"><fmt:message code="license.delete" /></a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment" data-to-id="" data-cmt-type="" data-to-text="" href="javascript:;" style="color: #2A94CF;" onclick="reply()">回复</a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content" style="margin-bottom: 10px;">'+res.obj[j].weChatCommentReplyList[i].message+'</div> ' +
                                        '</li></ul>';
                                }
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="" style="margin-left:5%;margin-top: 10px;border-bottom: 1px dashed #CCC;width: 90%;">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user" style="color: #2A94CF;">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext" style="color: #AAABAF;float: right;">' +
                                    '       <span>'+res.obj[j].time+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].cid+'" data-to-id="'+res.obj[j].uid+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].cid+');" hidefocus="hidefocus" style="color: #2A94CF;"><fmt:message code="license.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].uid+'" data-cmt-type="'+res.obj[j].cid+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;" style="color: #2A94CF;" onclick="reply()">回复</a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].time+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content" style="margin-bottom: 10px;">'+res.obj[j].message+'</div> ' +
                                    '</li>' +
                                    '   <div class="feed-cmt-attachments" style="width: 80%; margin-left: 10%; border: 1px solid #dbdbdb;margin-top: 10px;">'+stra+'</div> ' ;
                            }else{
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="" style="margin-left:5%;margin-top: 10px;border-bottom: 1px dashed #CCC;width: 90%;">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user" style="color: #2A94CF;">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext" style="color: #AAABAF;float: right;">' +
                                    '       <span>'+res.obj[j].time+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].cid+'" data-to-id="'+res.obj[j].uid+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].cid+');" hidefocus="hidefocus" style="color: #2A94CF;"><fmt:message code="license.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].uid+'" data-cmt-type="'+res.obj[j].cid+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus" style="color: #2A94CF;" onclick="reply()">回复</a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content" style="margin-bottom: 10px;">'+res.obj[j].message+'</div> ' +
                                    '</li>';
                            }

                        }
                        // $(".comment" + num+" ul").html(str);
                        $(".comment" + num).after(str);
                    }
                }
            });
        }
        // ----删除评论接口
        function deleteCmt(num,cmtId) {
            var cid = cmtId;
            layer.confirm('<fmt:message code="diary.th.removeComment" />？', {/*确定删除该条评论*/
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定  取消*/
                title:['删除评论', 'background-color:#2b7fe0;color:#fff;']
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/weChatComment/deleteByPrimaryKey",
                    type: 'post',
                    dataType: "JSON",
                    data: "cid="+cid,
                    async: false,
                    success: function (res) {
                        var str = "";
                        if(res.flag){
                            layer.msg("<fmt:message code="workflow.th.delsucess" />！",{icon:1});/*删除评论成功*/
                            onl_d();
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }
        //回复
        // $('.feed-cmt-reply-handle').on('click',function(){
        function reply(){
            console.log($(this))
            // var uName=$(this).attr('data-to-text');
            // var comId=$(this).attr('data-cmt-type');
            var uName=$(".feed-cmt-reply-handle").attr('data-to-text');
            var comId=$(".feed-cmt-reply-handle").attr('data-cmt-type');
            $('.feed-submit-cmt-btn').attr('btnType','1');
            $('.feed-submit-cmt-btn').attr('cutId',comId);
            $('.feed-ext-add-comment-to').toggle();
            $('.feed-ext-add-comment-to').text(uName);
        }
        //回复接口
        function replayCommetTo(cmtTpe,val,num,wid){
            if(val == null || val =="" ){
                layer.msg("内容不能为空",{icon:2},function(){
                    return false;
                });
            }else {
                $.ajax({
                    type: 'post',
                    url: '/weChatCommentReply/insertWeChatCommentReply',
                    dataType: 'json',
                    data: {
                        'message': val,
                        'cid': cmtTpe,
                        'wid': wid,
                        'tid': $('.feed-cmt-reply-handle').attr('data-to-id')
                    },
                    success: function (res) {
                        if (res.flag) {
                            layer.msg('回复成功！', {icon: 1});
                            /*回复成功*/
                            disComment(num, wid)
                            $('.feed-submit-cmt-context').val('');
                            $('.feed-ext-add-comment-to').hide();
                        }else{
                            layer.msg('回复失败！', {icon: 2});
                        }
                    }
                })

            }
        }
        //回复删除
        function deleteReplayCom(that){
            var rid=that.attr('data-cmt-id');
            layer.confirm('确定删除该条评论吗？', {  /*确定删除该条评论*/
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定 取消*/
                title:['删除评论', 'background-color:#2b7fe0;color:#fff;']
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/weChatCommentReply/deleteByPrimaryKey',
                    dataType:'json',
                    data:{'rid':rid},
                    success:function(res){
                        if(res.flag){
                            layer.msg("<fmt:message code="workflow.th.delsucess" />！",{icon:1});/*删除评论成功*/
                            onl_d()
                            // $('.feed-cmt-attachments').hide();
                        }
                    }
                })
            }, function(){
                layer.closeAll();
            });

        }
        //点赞社区
        function like(id,i) {
            data = {
                wid : id,
            };
            $.ajax({
                url: "/weChat/updateWeChatByPrimaryKey",
                type: 'get',
                dataType: "JSON",
                data:data,
                success: function (obj) {
                    //location.reload();
                    onl_d(1,pageNum);
                }
            });
        }
        //删除社区
        function delete_log(i,type){
            var data1={
                'wid':i
            };
            layer.confirm('<fmt:message code="confirm.delete.dynamic" />', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],
                title: ['<fmt:message code="delete.dynamic.title" />', 'background-color:#2b7fe0;color:#fff;']
            },function(){
                $.ajax({
                    url:"/weChat/deleteByPrimaryKey",
                    type:'get',
                    dataType:"JSON",
                    data : data1,
                    success:function(dataResult){
                        // location.reload();
                        layer.msg('<fmt:message code="workflow.th.delsucess" />！', {icon: 1,time: 2000});
                        location.reload();
                        onl_d(1,pageNum);
                    },
                    error:function(e){
                        console.log(e);
                    }
                });
            },function(){
                // return false;
                layer.closeAll();
            })
        }
        //图片查看
        $(document).on('click','#imgSee',function () {
            // var thisa = $(this).attr('openimg')
            var thisa = $(this).parent().children("p").attr('openimg')
            var openNmu = $(this).attr('openNmu')
            var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
            $('.tianErNiu1').append(str3)
            $('#getIndex').val(thisa)
            window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
        })

    </script>
</head>
<body onload="onl_d(2)">

<div class="dingbu">
    <div class="headImg">
        <img src="/img/community/themeSix.png" >
    </div>
    <div class="divTitle"><fmt:message code="community" /></div>
</div>
<br>

<div class="">
    <div>
        <div style="width: 70%;display: inline-block;float: left;">
            <div class="main_left" >
                <ul style="display: block;" class="befor" id="befor">

                </ul>
            </div>
            <div class="M-box3" id="dbgz_page">
            </div>
        </div>
        <div class="main_right" style="border: 1px solid #dbdbdb;position: relative;">
            <span class="spanUser" style="text-align: center;">
                <div class="attrImg" style="margin-top: 35px;width: 100%;"><img class="userImg" style="width: 90px;border-radius: 50px;" src=""/></div>
                <p style="margin-top: 7px;"><span class="zong" style="font-size: 18px;font-weight: bold;color: #22489f;"></span></p>
            </span>
            <div>
                <button style="width: 130px;" id="but_ns" class=" btn_sps b_but b_new">
                    <img style="margin-right: 3px" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="create.dynamic.title" /></button>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    layui.use('form', function(){
        var form = layui.form;
        var upload = layui.upload;
        form.render();
        $('#but_ns').click(function(){
            layer.open({
                type:1,
                title: [
                    '<fmt:message code="create.dynamic.title" />',
                    'background-color:#2b7fe0;color:#fff;'
                ],
                area: ['40%', '60%'],
                shadeClose: true, //点击遮罩关闭
                btn: [
                    '<fmt:message code="create.dynamic.publish" />',
                    '<fmt:message code="create.dynamic.back" />'
                ],
                content: '<div class="type">' +
                    '        <div>' +
                    '            <textarea type="text" class="typeName" style="width: 90%;height: 30%;margin-left: 5%;margin-top: 20px;color: #AAABAF;" >' +
                    '<fmt:message code="create.dynamic.saySomething" />' +
                    '</textarea>' +
                    '        </div>' +
                    ' <form action="/upload?module=wechat" id="datasave">\n' +
                    '<input type="file" onchange="filesTwo(this)" id="picFile"  multiple="multiple" name="file"   style="display: none">' +
                    '    <div class="">\n' +
                    // '<span style="border-bottom: 1px solid #fff;height: 100px;line-height: 100px">多图片上传</span>\n' +
                    '                        <label style="width: 93%;height: 100px;">\n' +
                    '                            <div class="picture prevTwo" style="position: relative">\n' +
                    '                                <input type="hidden" name="attachmentId2">\n' +
                    '                                <img class="fl addPhotos" style="    width: 60px;margin-left: 2%;cursor: pointer;height: 60px;margin-top: 5px;margin-right: 7px;" src="/img/grid/addtupin.png" alt="<fmt:message code="add.photos" />">\n' +
                    '                                <input type="hidden" name="attachmentName2">\n' +
                    '                                <ul class="fl" style="float: right;width: 78%;height: 70px;">\n' +
                    '                                </ul>\n' +
                    '                            </div>\n' +
                    '                        </label>\n' +
                    '    </div>' +
                    '</form>' +
                    '    </div>'
                ,success:function(){
                    $(".typeName").focus(function(){
                        $(this).text("");
                    });
                    $('.addPhotos').click(function () {
                        me=this;
                        $('#picFile').click()
                    })
                }
                ,yes:function(index){
                    if ($('.typeName').val() == '') {
                        layer.msg('<fmt:message code="content.empty.error" />', {icon: 3});
                        return;
                    }
                    if ($('.prevTwo ul li').length > 9) {
                        layer.msg('<fmt:message code="image.video.limit.error" />', {icon: 3});
                        return;
                    }
                    var imgId="";
                    var imgName=""
                    for(var i=0;i<$('.imgId').length;i++){
                        imgId += $('.imgId').eq(i).val()+','
                    }
                    for(var i=0;i<$('.imgName').length;i++){
                        imgName += $('.imgName').val()+'*'
                    }
                    $.ajax({
                        type: "post",
                        url: "/weChat/insertWeChat",
                        dataType: 'json',
                        data:  {
                            message: $('.typeName').val(),
                            fileId:imgId,
                            fileName:imgName,
                        },
                        success: function (obj) {
                            if(obj.flag){
                                layer.msg('发布成功！',{icon:1},function(){
                                    location.reload();
                                });
                            }else {
                                layer.msg('发布失败！', {icon: 2});
                            }

                        }
                    });

                },
                btn2:function(index){
                    layer.close(index);
                }
            })
        })
    });
    //        文件上传
    function filesTwo(mes) {
        var arr=mes.files;
        var bool=true;
        for(var i=0;i<arr.length;i++){
            if( arr[i].name.indexOf('.png')==-1&&arr[i].name.indexOf('.jpg')==-1&&arr[i].name.indexOf('.PNG')==-1&&arr[i].name.indexOf('.JPG')==-1&&arr[i].name.indexOf('.mp4')==-1&&arr[i].name.indexOf('.pdf')==-1){
                bool=false;
                break;
            }
        }
        if(!bool){
            layer.msg('<fmt:message code="upload.format.error" />', {icon: 2});
            return
        }
        // $('#datasave').prop('action','upload?module=wechat')

        $('#datasave').ajaxSubmit({
            type:'post',
            dataType:'json',
            // acceptFileTypes: /(\.|\/)(|mp4|)$/i,
            success:function (json) {
               console.log(json)
                if(json.flag) {
                    var str='';
                    var arr=json.obj;
                    var attStrId='';
                    var attStrName='';
                    for(var i=0;i<arr.length;i++){

                        attStrId+=arr[i].attachId+',';
                        attStrName+=arr[i].attachName+'*';
                        str+='<li>' +
                                function(){
                                    if(arr[i].attachName.indexOf('.mp4') != -1){
                                        return '<video class="big" type="1"  style="cursor:pointer;width: 100%;height: 100%;">' +
                                            ' <source src="/xs?'+arr[i].attUrl+'" type="video/mp4" x5-video-player-fullscreen="true" webkit-playsinline="true">' +
                                            '</video>'
                                    }else if(arr[i].attachName.indexOf('.png')!=-1 || arr[i].attachName.indexOf('.jpg')!=-1||arr[i].attachName.indexOf('.PNG')!=-1||arr[i].attachName.indexOf('.JPG')!=-1){
                                        return '<img src="/xs?'+arr[i].attUrl+'" alt="" onclick="javascript:window.open(this.src)" style="cursor:pointer;width: 100%;height: 100%;margin-top: -5px;">'
                                    }else if(arr[i].attachName.indexOf('.pdf')!=-1 ) {
                                         return '<div class="pdfContainer" data-url='+arr[i].attUrl+' style="width:60px;height:80px;"><img style="height: 40px;" src="/img/pdf.png"/><div style="font-size:12px;width: 100%;height: 100%;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+arr[i].attachName+'</div></div>'
                                    }
                                }()+
                            // '<img src="/xs?'+arr[i].attUrl+'" alt="" onclick="javascript:window.open(this.src)" style="cursor:pointer;width: 100%;height: 100%;">' +
                            '<b class="deleClear">x</b>' +
                            '<input type="hidden" class="imgId"  value="'+arr[i].attachId+'">' +//id
                            '<input type="hidden" class="imgName"  value="'+arr[i].attachName+'">' +//名字
                            '</li>'
                    }
                    $(me).siblings('ul').append(str)
                    $(me).prev('input').val($(me).prev('input').val()+attStrId)
                    $(me).next().val($(me).next().val()+attStrName)
                }else {
                    alert('异常')
                }
            }
        })
    }
    $(document).delegate('.deleClear','click',function () {
        var that=$(this);
        that.parents('.picture').find('input[type="hidden"]').eq(0).val("")
        that.parents('.picture').find('input[type="hidden"]').eq(1).val("")
        $(this).parent().remove()
    })
$(document).on("click",".pdfContainer",function() {
    var url = $(this).attr("data-url");
    window.open('/common/PDFBrowser?'+url)
})
</script>

</body>
</html>

