<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head lang="en">
    <title>社区</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/workLog.css"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/diary/calendar.js/"></script>
    <script type="text/javascript" src="../js/diary/date.js/"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <%-- <script type="text/javascript" src="../js/diary/index.js/"></script>--%>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    .layui-layer-title {
        padding: 0 80px 0 20px;
        height: 42px;
        line-height: 42px;
        border-bottom: 1px solid #eee;
        font-size: 16px;
        color: #fff;
        overflow: hidden;
        background-color: #2b7fe0;
        border-radius: 2px 2px 0 0;
    }
    .displayNone{
        display: none;
    }
    .feed-ext-body-readers{
        border: 1px solid #ddd;
        border-top: 0;
        padding: 8px 30px;
        background: #F8F8F8;
    }
    .feed-cmt-list-item {
        position: relative;
        padding: 5px 0;
        border-top: 1px dashed #CCC;
        margin: 0 20px;
        line-height: 20px;
    }
    .feed-cmt-list-item a {
        color: #2A94CF;
        text-decoration: none;
    }
    .content{
        margin-left: 15%;


    }
    .edui-editor  edui-default{
        height:200px;
    }
    .feed-cmt-content {
        padding: 4px;
        line-height: 1.3;
    }
    .feed-cmt-list-ext {
        position: absolute;
        right: 5px;
        top: 5px;
    }
    .blue_text{
        width:15%;
        padding-left:10px;
        font-weight:bold;
        text-align:right;
        border: 1px #ccc solid;
    }
    .ATTACH_a{
        text-decoration: none;
    }
    /*.controls  textarea.inText{*/
    /*float:none;*/
    /*}*/
    .control-label{
        display:block;
    }
    .controls  div{
        float:left;
        margin-top:68px;
    }
    textarea{
        min-height:85px;
    }
    .step2{
        width:66%;
        margin:0 auto;
        display:block;
        float:none;

    }
    .input-medium{
        width:180px;
    }
    select{
        margin-top:0%;
    }
    .control-group{
        height:auto;
    }

    .newlogHeade{
        height:44px;
        line-height:44px;
    }
    .newlogHeade img{
        margin-top:1%;
    }
    .head .one{
        padding:0px 10px;
    }
    #share_type{
        vertical-align:middle;
        align:right;
    }
    .modular_user{
        display:inline-block;
    }
    .modular_user img{
        width:68px;
        height:68px;
        float:left;
    }
    .head  .titName{
        display:block;
    }
    .newNews {
        border:1px solid #e0e0e0;
    }
    .newNews tr{
        border:1px solid #e0e0e0;
    }
    .title{
        width: 99%;
        height: 50px;
        overflow: hidden;
        margin-left: 10px;
    }
    .title .div_Img{
        float: left;
        width: 23px;
        height: 100%;
        margin-left: 20px;
    }
    .title .new{
        float: left;
        height: 50px;
        line-height: 50px;
        font-size: 22px;
        margin-left: 10px;
        color: #494d59;
    }
    .content_right{
        margin-top:18px;
    }
    .span3{
        margin-top:1.5%;
    }
    .headLog img{
        margin-top: 0.8%;
    }
    .headLog div{
        margin-left: 0.6%;
    }
    .content_right {
        margin-top: -21px;
    }
    .newNews,.newNews tr{
        border:none;
    }

    .btn {
        margin-left: 834px;
        margin-top: 10px;
        background: #1E6DD0;
        margin-right: 44px;
        padding: 5px 11px;
    }


    #rs{
        padding-left:15px;
        line-height:30px;
    }
    .td_s{
        border: 1px #ccc solid;
    }
    .btn div{
        width: 40px;
    }

    .step2{overflow-y: auto;}
    .content_right {
        margin-left: 14%;
        width: 66%;
    }
    .details_modular {
        height: 167px;

    }
</style>

<body>

<%--头部样式--%>
<div class="head w clearfix" style="position: fixed;background: #fff;width:100%;z-index:999;height:42px;">
    <div class="headLog newlogHeade clearfix" style="margin-top:-5px">
        <img src="../img/weChat/wechat.png">
        <div class="log">
            社区
        </div>
    </div>
</div>
<div class="title">
    <div class="div_Img"></div>
    <div class="new">
        社区
    </div>
</div>


<%--新建社区--%>
<div id="logNew" class="clearfix" style="padding-top:0px;">
    <div class="newLog_left">


        <div class="step2"  style="margin-left: 14%;background: #DDEBFF ;height: 192px; margin-top: 32px;"  >
            <div class="btnImg" style="margin-top: 14px;margin-left: 38px;">
                <img src="../img/weChat/topic.png">
            </div>
            <div class ="text" id ="weChat"style="margin-top: 14px;margin-left: 38px;">
                <textarea class="weChatText" name="weChatText"   id="weChatText" style= "width: 95%;"></textarea>
            </div>

            <div class="btn">
                <div id="hd" type="publish" class="btn_send" style="color: #fff;cursor:pointer">发布</div>

            </div>


        </div>
    </div>


</div>
<div class="content_right clearfix">

    <div class="details clearfix" id="details" style="zoom:0">
        <%--第一板块--%>
    </div>
    <!-- 分页按钮-->
    <div class="M-box3">
    </div>
</div>




</body>
<script type="text/javascript">
    //var ue = UE.getEditor('container');
    var data= {
        page: 1,
        pageSize: 5,
        useFlag: true,
    };
    $(document).ready(function () {
        initPageList_zj(function (pageCount) {
            initPagination_zj(pageCount, data.pageSize);
        });
    })
    $(function () {

        //  小箭头切换类名
//        if ($("#diary-adv-search-box").css('display') == 'none') {
//            $("#triangle").addClass("icon-chevron-down").removeClass("icon-chevron-up");
//            document.getElementById("diary-search-box").style.borderTop = "1px solid #dbdbdb";
//
//        } else {
//            $("#triangle").addClass("icon-chevron-up").removeClass("icon-chevron-down");
//            document.getElementById("diary-search-box").style.borderTop = "none"; //高级编辑的时候上边框为空
//
//        }


        //  评论的显示和隐藏
        $(".commentNumber").on('click', function () {
            $("#comment").toggle();
            if ($("#comment").css('display') == 'block') {
                document.getElementById("commentNumber").style.color = "#1687cb";
                document.getElementById("commentNumber").style.textDecoration = "underline";
            } else {
                document.getElementById("commentNumber").style.color = "#b4b4b4";
                document.getElementById("commentNumber").style.textDecoration = "none";
            }
        });



//        initPageList_zj(function (pageCount) {
//            initPagination_zj(pageCount, data.pageSize);
//        });


        // 删除评论
        $('.feed-cmt-del-handle').click(function () {

        })
    });
    //新建接口
    $("#hd").on("click",function(){
        var content = $('.weChatText').val();
        var data = {

            "message": content  ,//（社区内容）

        };

        if(content == null || content =="" ){
            $.layerMsg({content:"内容不能为空",icon:2},function(){
                return false;
            });
        }else{
            add_log(data);
        }
        //新建保存的数据接口
        function add_log(data){
            $.ajax({
                type: "post",
                url: "/weChat/insertWeChat",
                dataType: 'json',
                data: data,
                success: function (obj) {
                    if(obj.flag){
                        $.layerMsg({content:'<fmt:message code="diary.th.modify"/>！',icon:1},function(){

                            location.reload();
                        });
                    }else {
                        $.layerMsg({content: '发布失败！', icon: 2});
                    }

                }
            });
        };

    })
    //列表
    function initPageList_zj(cb) {
        $("#details").html("");
        $.ajax({
            url: "/weChat/selectWeChat",
            type: 'get',
            dataType: "JSON",
            data:data,

            success: function (obj) {
                if (obj.obj.length == 0) {

                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        var src_sex ="";
                        if(obj.obj[i].userSex == '0'){
                            src_sex='/img/workLog/basichead_man.png';
                        }else{
                            src_sex='/img/workLog/portrait3.png';
                        }

                        str += '<div class="tianErNiu1" dailId="'+obj.obj[i].wid+'">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
//                            ' <div class="modular_user"></div>' +
                            ' <div class="modular_user"  style="float:left"><img src="'+src_sex+'"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info" >' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="javascript:;">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + obj.obj[i].time + '</div>' +
                            ' </div>' +
                            '<p>' + obj.obj[i].message + '</p>' +
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><img src="../img/weChat/comment.png"></li>'+
                            '<li style="margin-top: 2px;"><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + obj.obj[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="news.th.comment"/>('+obj.obj[i].commentNum+')</a></li>' +
                            '<li style="margin-left: 20px;"><img src="../img/weChat/like.png"></li>'+
                            '<li style="margin-top: 2px;"><a href="javascript:;" class="likeNumber' + i + '" onclick= "like(' + obj.obj[i].wid + ')" style = "color:#6A9CCE">点赞('+obj.obj[i].likeNum+')</a></li>' +
                            '<li style="margin-left: 20px;" ><img src="../img/weChat/delete.png" class="'+function(){ if(obj.obj[i].isSend==1){ return " displayNone " } }() + '"></li>'+
                            '<li style="margin-top: 2px;"><a href="javascript:;" del='+obj.obj[i].wid+' class="'+function(){ if(obj.obj[i].isSend==1){ return " displayNone " } }()+'delete' + i + '" onclick= "delete_log(' + obj.obj[i].wid + ')" style = "color:#6A9CCE"><fmt:message code="global.lang.delete"/></a></li>' +
                            '</ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" class="btn btn-primary feed-submit-cmt-btn" style="cursor:pointer" cutId="" onclick="commentDia($(this),' + i +','+obj.obj[i].wid+ ')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op">' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment">' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +
                            '</div>'
                    }


                    $("#details").html(str);
                    if (cb) {
                        cb(obj.totleNum);
                    }

                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //分页函数
    function initPagination_zj(totalData, pageSize) {

        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: data.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                data.page = index.getCurrent();
                console.log(index.getCurrent());
                initPageList_zj(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_zj(pageCount, data.pageSize);
                });
            }
        });
    }
    //查看评论
    function details(i,wid) {
        $('.btn-primary').attr('btnType','2');
        if ($("#comment" + i).css('display') == 'block') {
            $("#comment" + i).hide();
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
        var val=that.siblings('.feed-submit-cmt-context').val();
        if(that.siblings('.feed-ext-add-comment-to').css('display') == 'none'){
            commentEvent(num,wid);
        }else if(that.siblings('.feed-ext-add-comment-to').css('display') == 'block'){
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
            $.layerMsg({content:"内容不能为空",icon:2},function(){
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
                        $.layerMsg({content:'<fmt:message code="diary.th.CommentSuccess" />！',icon:6});/*评论成功*/
                        $('.feed-submit-cmt-context').val('');
                        disComment(num,wid)
                    }
                }
            });
        }

    }
    //回复接口
    function replayCommetTo(cmtTpe,val,num,wid){
        if(val == null || val =="" ){
            $.layerMsg({content:"内容不能为空",icon:2},function(){
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
                        $.layerMsg({content: '<fmt:message code="doc.th.ReplySuccessfully" />！', icon: 1});
                        /*回复成功*/
                        disComment(num, wid)
                        $('.feed-submit-cmt-context').val('');
                        $('.feed-ext-add-comment-to').hide();
                    }
                }
            })

        }
    }

    //回复
    $('.details').on('click','.feed-cmt-reply-handle',function(){
        var uName=$(this).attr('data-to-text');
        var comId=$(this).attr('data-cmt-type');
        $('.btn-primary').attr('btnType','1');
        $('.btn-primary').attr('cutId',comId);
        $('.feed-ext-add-comment-to').toggle();
        $('.feed-ext-add-comment-to').text(uName);
    })
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
                                stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].weChatCommentReplyList[i].userName+'</a>&nbsp; &nbsp;<span><fmt:message code="email.th.reply" /></span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].weChatCommentReplyList[i].toName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].weChatCommentReplyList[i].time+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].weChatCommentReplyList[i].rid+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle" data-cmd="replyComment" data-to-id="" data-cmt-type="" data-to-text="" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].weChatCommentReplyList[i].message+'</div> ' +
                                    '</li></ul>';
                            }
                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                '   <div class="feed-cmt-list-ext">' +
                                '       <span>'+res.obj[j].time+'</span>' +
                                '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].cid+'" data-to-id="'+res.obj[j].uid+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].cid+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].uid+'" data-cmt-type="'+res.obj[j].cid+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                '      <span class="feed-cmt-list-time" title="'+res.obj[j].time+'" > </span>' +
                                '   </div>    ' +
                                '   <div class="feed-cmt-content">'+res.obj[j].message+'</div> ' +
                                '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                '</li>';
                        }else{
                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                '   <div class="feed-cmt-list-ext">' +
                                '       <span>'+res.obj[j].time+'</span>' +
                                '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].cid+'" data-to-id="'+res.obj[j].uid+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].cid+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].uid+'" data-cmt-type="'+res.obj[j].cid+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="email.th.reply" /></a>' +
                                '   </div>    ' +
                                '   <div class="feed-cmt-content">'+res.obj[j].message+'</div> ' +
                                '</li>';
                        }

                    }
                    $(".comment" + num+" ul").html(str);
                }
            }
        });
    }

    // ----删除评论接口
    function deleteCmt(num,cmtId) {
        var cid = cmtId;
        layer.confirm('<fmt:message code="diary.th.removeComment" />？', {/*确定删除该条评论*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定  取消*/
            title:'<fmt:message code="notice.th.DeleteFile" />' /*删除文件*/
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
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }

    //回复删除
    function deleteReplayCom(that){
        var rid=that.attr('data-cmt-id');
        layer.confirm('<fmt:message code="diary.th.removeComment" />？', {  /*确定删除该条评论*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定 取消*/
            title:'<fmt:message code="notice.th.DeleteFile" />' /*删除文件*/
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
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            })
        }, function(){
            layer.closeAll();
        });

    }

    //点赞社区
    function like(id) {
        data = {
            wid : id,
        };
        $.ajax({
            url: "/weChat/updateWeChatByPrimaryKey",
            type: 'get',
            dataType: "JSON",
            data:data,

            success: function (obj) {
                location.reload();
            }
        });
    }
    //删除社区
    function delete_log(i,type){
        var data1={
            'wid':i
        };
        $.layerConfirm({title:'<fmt:message code="workflow.th.suredel"/>',content:'<fmt:message code="workflow.th.que"/>',icon:0},function(){
            $.ajax({
                url:"/weChat/deleteByPrimaryKey",
                type:'get',
                dataType:"JSON",
                data : data1,
                success:function(dataResult){
                    location.reload();
                },
                error:function(e){
                    console.log(e);
                }
            });
        },function(){
            return false;
        })
    }


</script>



</html>