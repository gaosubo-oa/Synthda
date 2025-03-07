<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/4/14
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志查看</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/workLog.css?2019101712.55"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar1.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/details.css"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/diary/calendar1.js/"></script>
    <script type="text/javascript" src="../js/diary/date.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <%-- <script type="text/javascript" src="../js/diary/index.js/"></script>--%>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <!-- kindeditor文本编辑器 -->
    <script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>
</head>
<style>
    body{
        background-color: rgb(233,234,235);
    }
    .main{
        width: 720px;
        margin-right: auto;
        margin-left: auto;
        margin-top: 70px;
        z-index: 9999;
        position: relative;
    }
    .shang{
        background-color: rgb(55,155,185);
        width: 100%;
        height: 200px;
        position: fixed;
        z-index: 99;
        top: 0;
    }
    .zmain{
        width: 100%;
        margin-top: 10px;
    }
    .feed-bd .feed-title{
        margin: 12px 0 0 !important;
    }
    .shangxia{
        width: 100%;
        height: 30px;
        line-height: 30px;
        font-size: 10px;
        color: #999;
        border-bottom: 1px solid rgb(230,230,230);
    }
    .yuelan{
        width: 100%;
        line-height: 30px;
        font-size: 10px;
        border-bottom: 1px solid rgb(230,230,230);
        height: 30px;
    }
    .feed-cmt-list-ext a{
        padding-left: 10px;
    }
    .feed a{
        color: #333 !important;
    }
    .feed-cmt-list-ext a{
        color: #39c !important;
        cursor: pointer;
    }
    .feed-cmt-list-user{
        cursor: default;
    }
</style>
<body>
<div class="shang">

</div>
<div class="main">
    <div class="top">
        <div class="topleft">
            <span class="shoutest" style="font-size: 24px;font-weight: bold;color:white"></span>
            <p class="diary-detail-priv" style="color:white;"></p>
        </div>
        <div class="topright">

        </div>
        <div class="returnUp" style="position: absolute;right: 0px;top: 18px;cursor: pointer">
            <span id="return" style="font-size: 14px;color:white">|  返回</span>
        </div>
    </div>
    <div class="zmain">
        <div id="diary-detail-content" class="feed">
            <div class="pop-content clearfix">
                <div class="feed-hd" style="display: inline-block;float: right">

                    <span class="feed-time" title="">6月09 10：12</span>

                    <%--                        <div class="feed-act" style="float:right;display: inline-block;">--%>
                    <%--                            <a href="javascript:void(0)" onclick= "share_details($(this))"><fmt:message code="diary.th.Share"/></a>--%>
                    <%--                        </div>--%>
                </div>
                <div class="feed-bd" style="display: inline-block;margin-bottom: 50px;">
                    <h4 class="feed-title">2017-05-12 <fmt:message code="Friday"/>  <fmt:message code="main.worklog"/></h4>
                    <div class="feed-ct">
                        <div class="feed-txt-full rich-content">
                            <div class="feed-txt-summary">
                                <div class="jjl_body"><fmt:message code="log.th.Logcontent"/></div>
                            </div>
                        </div>
                    </div>
                    <div class="feed-attachments">

                    </div>

                </div>
            </div>
            <div class="shangxia">
                <span id="last" style="padding-left: 10px;cursor:pointer">上一篇</span>
                <span id="next" style="padding-right: 10px;float: right;cursor:pointer">下一篇</span>
            </div>
            <div class="yuelan">
                <div class="feed-ext-readers">
                    <span id="yuelan"></span>
                </div>
            </div>
            <div class="pinglun">
                <ul class="feed-ext-list">

                </ul>
                <div class="feed-ext-body comment" id="comment" style="display: block;height: 260px">
                    <div class="feed-ext-add-comment">
                        <form target="" action="" name="feed-comment-form">
                            <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>
                            <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context" style="width: 100%;"></textarea>

                            <input type="hidden" name="comment-to" value="">
                            <input type="hidden" name="comment-id" value="">
                            <input type="hidden" name="comment-type" value="">
                            <input type="hidden" name="diary-id" value="11">
                            <div class="feed-ext-comment-sms-op" name="fa" style="margin-top:80px">
                                <label class="sms-remind-label">
                                    <input type="checkbox" name="" id="SMS_REMIND_11" checked="">发送事务提醒</label>
                            </div>
                            <div class="feed-ext-comment-sms-advcomment" name="gao" id="feed-ext-comment-sms-advcomment" style="margin-top:80px">
                                <label> <input type="checkbox" name="advcomment" class="advcomment">高级评论</label>
                            </div>
                            <button type="button" style="margin-top:80px" name="tijiao" id="tijiao" class="btn btn-primary feed-submit-cmt-btn">提交</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var types = getQueryString('type');
    var diaId = getQueryString('diaId');
    var startTime = getQueryString('startTime');
    var endTime = getQueryString('endTime');
    var userId = getQueryString('userId');
    var deptId = getQueryString('deptId');
    var userTopId = getQueryString('userTopId');
    var userTopName = getQueryString('userTopName');
    var userName = getQueryString('userName');
    var deptName = getQueryString('deptName');
    var diaType = getQueryString('diaType');
    var commentStatus = getQueryString('commentStatus');
    var attach = [];
    var isComment = getQueryString('isComment');
    layui.use(['form', 'table', 'element', 'layedit','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit


        var uName;
        var comId;
        var replyId;
        var replyComId;
        var toId;
        if(types == 'noCommentLog'){
            $('.returnUp').css('top','-30px')
        }
        //返回
        $('#return').on('click',function () {
            if(types == 'index'){
                window.location.href = '/diary/index';
            } else if(types == 'logQuery'){
                window.location.href = '/diary/logQuery?returnTpe=1&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                    deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+commentStatus;
            } else if(types == 'noCommentLog'){
                window.location.href = '/diary/noCommentLog?returnTpe=1&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
            } else if(types == 'tongji'){
                window.location.href = '/diary/reportStatistics';
            } else{
                window.location.href = '/diary/logQuery?returnTpe=1&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                    deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+commentStatus;
            }

        })
        var ue;
        var kindEditorOption = {
            themeType: 'simple', // 定义编辑器为简洁模式
            filterMode: false, // 开启过滤
            allowFileManager: true, // 开启文件空间
            uploadJson: '/ueditor/upload?module=ueditor', // 上传接口
            filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
            afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
            afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
            afterUploadErrorMsg: 'msg', // 定义上传失败后提示信息的参数名（默认为 message）
            afterUpload: function (url, data, name) {
                console.log(url);
                console.log(data);
                console.log(name);
            }
        }
        ue= UE.getEditor('word_container',{elementPathEnabled : false});
        autodivheight();
        function autodivheight() {
            var winHeight = 0;
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;
            if (document.documentElement && document.documentElement.clientHeight)
                winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
            // document.getElementById("lognewBox").style.height = winHeight - 46  + "px";
            // document.getElementById("logInfo").style.height = winHeight - 46  + "px";
        }
        window.onresize = autodivheight;
        $('.advcomment').on('click',function(){//显示富文本
            //$(".feed-ext-add-comment .feed-submit-cmt-context").css('height',87);
            //console.log('478')
            $(".edui-editor").show();
            // var ischecked = $(this).find("[name='advcomment']").prop('checked');
            var ischecked = $(this).prop('checked');
            var ue;
            if(ischecked){
                $textarea= $(this).parents().children('.feed-submit-cmt-context');
                var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';
                $($textarea).prop('id',$id);
                ue = UE.getEditor($id);
                $("div[name='fa']").css({"margin-top": 140 + "px"});
                $("div[name='gao']").css({"margin-top": 140 + "px"});
                $("button[name='tijiao']").css({"margin-top": 140 + "px"});
            }else{

                $textarea= $(this).parents().children('.feed-submit-cmt-context');
                var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';

                $($textarea).removeProp('id');

                UE.getEditor($id).destroy();

                $("div[name='fa']").css({"margin-top": 80 + "px"});
                $("div[name='gao']").css({"margin-top": 80 + "px"});
                $("button[name='tijiao']").css({"margin-top": 80 + "px"});
            }
        })

        $.ajax({
            type:'get',
            url:'/diary/getConByDiaId',
            dataType:'json',
            data:{'diaId':diaId},
            success:function(data){
                attach =  data.object.attachment;
                if(data.flag){
                    $.ajax({
                        type:'get',
                        url:'/diary/getReaders',
                        dataType:'json',
                        data:{'diaId':diaId},
                        success:function(data){
                            var readersName = data.object.readersName
                            if(readersName == '暂无浏览'){
                                $("#yuelan").html(readersName)
                            }else{
                                $("#yuelan").html(readersName+'已阅览')
                            }

                        }
                    })
                }
            }
        })

        main()
        function main(){
            if(types == 'noCommentLog'){
                $.ajax({
                    type:'get',
                    url:'/diary/notCommentDiary',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId,
                        'isComment':isComment
                    },
                    success:function(data){
                        if(data.flag){
                            var name=data.obj[0].userName;//用户
                            var feed_time=data.obj[0].diaTime;//时间
                            var feed_title=data.obj[0].subject;//标题
                            var jjl_body=data.obj[0].content;//内容
                            var dept_name=data.obj[0].deptName;//部门
                            var user_role=data.obj[0].userPrivName;//角色
                            $('.shoutest').html(name);//用户
                            $('.feed-time').html(feed_time);//时间
                            $('.feed-title').html(feed_title);//标题
                            $('.jjl_body').html(jjl_body);//内容
                            $('.pingNum').html('('+data.obj[0].comTotal+')')
                            $('.diary-detail-dept').html(dept_name);//部門
                            $('.diary-detail-priv').html(user_role);//角色

                            if(data.obj[0].diaType==1){
                                $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                            }else{
                                $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                            };// diaType(日志类型(1-工作日志,2-个人日志)
                            //附件下载
                            var str1 = "";
                            var arr = new Array();
                            arr = attach;
                            var imgs;
                            if(data.obj[0].avatar!=''){
                                if(data.obj[0].avatar == '0'){
                                    imgs='/img/workLog/basichead_man.png';
                                }else if(data.obj[0].avatar == '1'){
                                    imgs='/img/workLog/portrait3.png';
                                }else{
                                    imgs='/img/user/'+data.obj[0].avatar;
                                }
                            }else{
                                if(data.obj[0].sex == '0'){
                                    imgs='/img/workLog/basichead_man.png';
                                }else{
                                    imgs='/img/workLog/portrait3.png';
                                }
                            }
                            $('.userImg').attr('src',imgs);
                            if (data.attachmentName != '') {
                                attachView(arr,$('.feed-attachments'),'1','0','1','0');
                            }
                        }else{
                            layer.msg(data.msg);
                        }
                    }
                });
            }else{
                $.ajax({
                    type:'get',
                    url:'/diary/diaryQuery',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId
                    },
                    success:function(data){
                        var name=data.obj[0].userName;//用户
                        var feed_time=data.obj[0].diaTime;//时间
                        var feed_title=data.obj[0].subject;//标题
                        var jjl_body=data.obj[0].content;//内容
                        var dept_name=data.obj[0].deptName;//部门
                        var user_role=data.obj[0].userPrivName;//角色
                        $('.shoutest').html(name);//用户
                        $('.feed-time').html(feed_time);//时间
                        $('.feed-title').html(feed_title);//标题
                        $('.jjl_body').html(jjl_body);//内容
                        $('.pingNum').html('('+data.obj[0].comTotal+')')
                        $('.diary-detail-dept').html(dept_name);//部門
                        $('.diary-detail-priv').html(user_role);//角色

                        if(data.obj[0].diaType==1){
                            $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                        }else{
                            $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                        };// diaType(日志类型(1-工作日志,2-个人日志)
                        //附件下载
                        var str1 = "";
                        var arr = new Array();
                        arr = attach;
                        var imgs;
                        if(data.obj[0].avatar!=''){
                            if(data.obj[0].avatar == '0'){
                                imgs='/img/workLog/basichead_man.png';
                            }else if(data.obj[0].avatar == '1'){
                                imgs='/img/workLog/portrait3.png';
                            }else{
                                imgs='/img/user/'+data.obj[0].avatar;
                            }
                        }else{
                            if(data.obj[0].sex == '0'){
                                imgs='/img/workLog/basichead_man.png';
                            }else{
                                imgs='/img/workLog/portrait3.png';
                            }
                        }
                        $('.userImg').attr('src',imgs);
                        if (data.attachmentName != '') {
                            <%--for (var i = 0; i < (arr.length); i++) {--%>
                            <%--str1 += '<div class="font_"><a download="'+ arr[i].attUrl+'" href="/download?'+ arr[i].attUrl + '"><img class="img_" src="../img/enclosure.png"/>' + arr[i].attachName + '</a>' +--%>
                            <%--'<a target="_blank" style="margin: 0 10px 0 30px;" href="'+function () {--%>
                            <%--var importUrl = encodeURI(arr[i].attUrl);--%>
                            <%--var d = /\.[^\.]+$/.exec(importUrl);--%>
                            <%--var ds= d[0].slice(1,d[0].length).toLowerCase()--%>
                            <%--if(ds=='pdf'){--%>
                            <%--return '/pdfPreview'--%>
                            <%--}else {--%>
                            <%--return '/xs'--%>
                            <%--}--%>

                            <%--}()+'?' + encodeURI(arr[i].attUrl) + '">阅读</a>' +--%>
                            <%--'<a download="'+ arr[i].attUrl+'" href="/download?'+ arr[i].attUrl  + '" style="margin-left:10px;"><fmt:message code="file.th.download" /></a>'+--%>
                            <%--'</div>'+--%>
                            <%--'<input type="hidden" class="inHidden" NAME="'+arr[i].attachName+'*" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',">';--%>
                            <%--}--%>
                            // $('.feed-attachments').append(str1);
                            attachView(arr,$('.feed-attachments'),'1','0','1','0');
                        }
                        // if($.cookie('userId')== data.object.userId){
                        //     $('.feed-act').append('<a href="javascript:void(0)" data-cmd="del" hidefocus="hidefocus"  onclick= "delete_details()">删除 </a>');
                        //     $('.feed-act').append('<a href="javascript:void(0)" data-cmd="edit" hidefocus="hidefocus"  onclick= "deleteEdit()">编辑 </a>');
                        // }
                    }
                });
            }

        }

        $.ajax({
            url: "/diary/getDiaryCommentByDiaId",
            type: 'get',
            dataType: "JSON",
            data: {
                diaId:diaId
            },
            async: false,
            success: function (res) {
                var str = "";
                if(res.flag){
                    for (var j = 0; j < res.obj.length; j++) {
                        var stra='';
                        if(res.obj[j].diaryCommentReplyModelList != ''){
                            if(res.obj[j].myDiaryComment == true){
                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext">' +
                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                        '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                        '</li></ul>';
                                }
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                    '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                    '</li>';
                            }else{
                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext">' +
                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                        '</li></ul>';
                                }
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                    '</li>';
                            }

                        }else{
                            if(res.obj[j].myDiaryComment == true){
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                    '       <a>编辑</a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '</li>';
                            }else{
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '</li>';
                            }

                        }

                    }
                    $(".feed-ext-list").html(str);
                    var liLength=$('.feed-cmt-list-item ').length;
                }
            }
        });
        $(document).on('click','#last',function(){
            if(types == 'noCommentLog'){
                $.ajax({
                    type:'get',
                    url:'/diary/notCommentDiary',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'last',
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到头了')
                            return false
                        }
                        if(data.flag){
                            diaId = data.obj[0].diaId
                            $.ajax({
                                type:'get',
                                url:'/diary/notCommentDiary',
                                dataType:'json',
                                data:{
                                    'diaId':diaId,
                                    'startTime':startTime,
                                    'endTime':endTime,
                                    'userId':userId,
                                    'deptId':deptId
                                },
                                success:function(data){
                                    diaId = data.obj[0].diaId
                                    var name=data.obj[0].userName;//用户
                                    var feed_time=data.obj[0].diaTime;//时间
                                    var feed_title=data.obj[0].subject;//标题
                                    var jjl_body=data.obj[0].content;//内容
                                    var dept_name=data.obj[0].deptName;//部门
                                    var user_role=data.obj[0].userPrivName;//角色
                                    $('.shoutest').html(name);//用户
                                    $('.feed-time').html(feed_time);//时间
                                    $('.feed-title').html(feed_title);//标题
                                    $('.jjl_body').html(jjl_body);//内容
                                    $('.pingNum').html('('+data.obj[0].comTotal+')')
                                    $('.diary-detail-dept').html(dept_name);//部門
                                    $('.diary-detail-priv').html(user_role);//角色

                                    if(data.obj[0].diaType==1){
                                        $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                    }else{
                                        $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                    };// diaType(日志类型(1-工作日志,2-个人日志)
                                    //附件下载
                                    var str1 = "";
                                    var arr = new Array();
                                    arr = data.obj[0].attachment;
                                    var imgs;
                                    if(data.obj[0].avatar!=''){
                                        if(data.obj[0].avatar == '0'){
                                            imgs='/img/workLog/basichead_man.png';
                                        }else if(data.obj[0].avatar == '1'){
                                            imgs='/img/workLog/portrait3.png';
                                        }else{
                                            imgs='/img/user/'+data.obj[0].avatar;
                                        }
                                    }else{
                                        if(data.obj[0].sex == '0'){
                                            imgs='/img/workLog/basichead_man.png';
                                        }else{
                                            imgs='/img/workLog/portrait3.png';
                                        }
                                    }
                                    $('.userImg').attr('src',imgs);

                                }
                            });

                            $.ajax({
                                type:'get',
                                url:'/diary/getConByDiaId',
                                dataType:'json',
                                data:{'diaId':diaId},
                                success:function(data){
                                    if(data.flag){
                                        $.ajax({
                                            type:'get',
                                            url:'/diary/getReaders',
                                            dataType:'json',
                                            data:{'diaId':diaId},
                                            success:function(data){
                                                var readersName = data.object.readersName
                                                if(readersName == '暂无浏览'){
                                                    $("#yuelan").html(readersName)
                                                }else{
                                                    $("#yuelan").html(readersName+'已阅览')
                                                }

                                            }
                                        })
                                    }
                                }
                            })

                            $.ajax({
                                url: "/diary/getDiaryCommentByDiaId",
                                type: 'get',
                                dataType: "JSON",
                                data: {
                                    diaId:diaId
                                },
                                async: false,
                                success: function (res) {
                                    var str = "";
                                    if(res.flag){
                                        for (var j = 0; j < res.obj.length; j++) {
                                            var stra='';
                                            if(res.obj[j].diaryCommentReplyModelList != ''){
                                                if(res.obj[j].myDiaryComment == true){
                                                    for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                        stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                            '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                            '   <div class="feed-cmt-list-ext">' +
                                                            '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                            '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                            '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                            '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                            '   </div>    ' +
                                                            '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                            '</li></ul>';
                                                    }
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                        '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                        '</li>';
                                                }else{
                                                    for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                        stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                            '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                            '   <div class="feed-cmt-list-ext">' +
                                                            '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                            '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                            '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                            '   </div>    ' +
                                                            '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                            '</li></ul>';
                                                    }
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                        '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                        '</li>';
                                                }

                                            }else{
                                                if(res.obj[j].myDiaryComment == true){
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                        '       <a>编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '</li>';
                                                }else{
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '</li>';
                                                }

                                            }

                                        }
                                        $(".feed-ext-list").html(str);
                                        var liLength=$('.feed-cmt-list-item ').length;
                                    }
                                }
                            });
                        }else{
                            layer.msg(data.msg)
                        }

                    }
                });
            }else if(types == 'index'){
                $.ajax({
                    type:'get',
                    url:'/diary/diaryQuery',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'last',
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到头了')
                            return false
                        }
                        diaId = data.obj[0].diaId
                        $.ajax({
                            type:'get',
                            url:'/diary/diaryQuery',
                            dataType:'json',
                            data:{
                                'diaId':diaId,
                            },
                            success:function(data){
                                diaId = data.obj[0].diaId
                                var name=data.obj[0].userName;//用户
                                var feed_time=data.obj[0].diaTime;//时间
                                var feed_title=data.obj[0].subject;//标题
                                var jjl_body=data.obj[0].content;//内容
                                var dept_name=data.obj[0].deptName;//部门
                                var user_role=data.obj[0].userPrivName;//角色
                                $('.shoutest').html(name);//用户
                                $('.feed-time').html(feed_time);//时间
                                $('.feed-title').html(feed_title);//标题
                                $('.jjl_body').html(jjl_body);//内容
                                $('.pingNum').html('('+data.obj[0].comTotal+')')
                                $('.diary-detail-dept').html(dept_name);//部門
                                $('.diary-detail-priv').html(user_role);//角色

                                if(data.obj[0].diaType==1){
                                    $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                }else{
                                    $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                };// diaType(日志类型(1-工作日志,2-个人日志)
                                //附件下载
                                var str1 = "";
                                var arr = new Array();
                                arr = data.obj[0].attachment;
                                var imgs;
                                if(data.obj[0].avatar!=''){
                                    if(data.obj[0].avatar == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else if(data.obj[0].avatar == '1'){
                                        imgs='/img/workLog/portrait3.png';
                                    }else{
                                        imgs='/img/user/'+data.obj[0].avatar;
                                    }
                                }else{
                                    if(data.obj[0].sex == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else{
                                        imgs='/img/workLog/portrait3.png';
                                    }
                                }
                                $('.userImg').attr('src',imgs);

                            }
                        });

                        $.ajax({
                            type:'get',
                            url:'/diary/getConByDiaId',
                            dataType:'json',
                            data:{'diaId':diaId},
                            success:function(data){
                                if(data.flag){
                                    $.ajax({
                                        type:'get',
                                        url:'/diary/getReaders',
                                        dataType:'json',
                                        data:{'diaId':diaId},
                                        success:function(data){
                                            var readersName = data.object.readersName
                                            if(readersName == '暂无浏览'){
                                                $("#yuelan").html(readersName)
                                            }else{
                                                $("#yuelan").html(readersName+'已阅览')
                                            }

                                        }
                                    })
                                }
                            }
                        })

                        $.ajax({
                            url: "/diary/getDiaryCommentByDiaId",
                            type: 'get',
                            dataType: "JSON",
                            data: {
                                diaId:diaId
                            },
                            async: false,
                            success: function (res) {
                                var str = "";
                                if(res.flag){
                                    for (var j = 0; j < res.obj.length; j++) {
                                        var stra='';
                                        if(res.obj[j].diaryCommentReplyModelList != ''){
                                            if(res.obj[j].myDiaryComment == true){
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }else{
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }

                                        }else{
                                            if(res.obj[j].myDiaryComment == true){
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '       <a>编辑</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }else{
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }

                                        }

                                    }
                                    $(".feed-ext-list").html(str);
                                    var liLength=$('.feed-cmt-list-item ').length;
                                }
                            }
                        });
                    }
                });
            }else{
                $.ajax({
                    type:'get',
                    url:'/diary/diaryQuery',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'last',
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到头了')
                            return false
                        }
                        diaId = data.obj[0].diaId
                        $.ajax({
                            type:'get',
                            url:'/diary/diaryQuery',
                            dataType:'json',
                            data:{
                                'diaId':diaId,
                                'startTime':startTime,
                                'endTime':endTime,
                                'userId':userId,
                                'deptId':deptId
                            },
                            success:function(data){
                                diaId = data.obj[0].diaId
                                var name=data.obj[0].userName;//用户
                                var feed_time=data.obj[0].diaTime;//时间
                                var feed_title=data.obj[0].subject;//标题
                                var jjl_body=data.obj[0].content;//内容
                                var dept_name=data.obj[0].deptName;//部门
                                var user_role=data.obj[0].userPrivName;//角色
                                $('.shoutest').html(name);//用户
                                $('.feed-time').html(feed_time);//时间
                                $('.feed-title').html(feed_title);//标题
                                $('.jjl_body').html(jjl_body);//内容
                                $('.pingNum').html('('+data.obj[0].comTotal+')')
                                $('.diary-detail-dept').html(dept_name);//部門
                                $('.diary-detail-priv').html(user_role);//角色

                                if(data.obj[0].diaType==1){
                                    $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                }else{
                                    $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                };// diaType(日志类型(1-工作日志,2-个人日志)
                                //附件下载
                                var str1 = "";
                                var arr = new Array();
                                arr = data.obj[0].attachment;
                                var imgs;
                                if(data.obj[0].avatar!=''){
                                    if(data.obj[0].avatar == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else if(data.obj[0].avatar == '1'){
                                        imgs='/img/workLog/portrait3.png';
                                    }else{
                                        imgs='/img/user/'+data.obj[0].avatar;
                                    }
                                }else{
                                    if(data.obj[0].sex == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else{
                                        imgs='/img/workLog/portrait3.png';
                                    }
                                }
                                $('.userImg').attr('src',imgs);

                            }
                        });

                        $.ajax({
                            type:'get',
                            url:'/diary/getConByDiaId',
                            dataType:'json',
                            data:{'diaId':diaId},
                            success:function(data){
                                if(data.flag){
                                    $.ajax({
                                        type:'get',
                                        url:'/diary/getReaders',
                                        dataType:'json',
                                        data:{'diaId':diaId},
                                        success:function(data){
                                            var readersName = data.object.readersName
                                            if(readersName == '暂无浏览'){
                                                $("#yuelan").html(readersName)
                                            }else{
                                                $("#yuelan").html(readersName+'已阅览')
                                            }

                                        }
                                    })
                                }
                            }
                        })

                        $.ajax({
                            url: "/diary/getDiaryCommentByDiaId",
                            type: 'get',
                            dataType: "JSON",
                            data: {
                                diaId:diaId
                            },
                            async: false,
                            success: function (res) {
                                var str = "";
                                if(res.flag){
                                    for (var j = 0; j < res.obj.length; j++) {
                                        var stra='';
                                        if(res.obj[j].diaryCommentReplyModelList != ''){
                                            if(res.obj[j].myDiaryComment == true){
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }else{
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }

                                        }else{
                                            if(res.obj[j].myDiaryComment == true){
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '       <a>编辑</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }else{
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }

                                        }

                                    }
                                    $(".feed-ext-list").html(str);
                                    var liLength=$('.feed-cmt-list-item ').length;
                                }
                            }
                        });
                    }
                });
            }

        })
        $(document).on('click','#next',function(){
            if(types == 'noCommentLog'){
                $.ajax({
                    type:'get',
                    url:'/diary/notCommentDiary',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'next',
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到底了')
                            return false
                        }
                        if(data.flag){
                            diaId = data.obj[0].diaId
                            $.ajax({
                                type:'get',
                                url:'/diary/notCommentDiary',
                                dataType:'json',
                                data:{
                                    'diaId':diaId,
                                    'startTime':startTime,
                                    'endTime':endTime,
                                    'userId':userId,
                                    'deptId':deptId
                                },
                                success:function(data){
                                    diaId = data.obj[0].diaId
                                    var name=data.obj[0].userName;//用户
                                    var feed_time=data.obj[0].diaTime;//时间
                                    var feed_title=data.obj[0].subject;//标题
                                    var jjl_body=data.obj[0].content;//内容
                                    var dept_name=data.obj[0].deptName;//部门
                                    var user_role=data.obj[0].userPrivName;//角色
                                    $('.shoutest').html(name);//用户
                                    $('.feed-time').html(feed_time);//时间
                                    $('.feed-title').html(feed_title);//标题
                                    $('.jjl_body').html(jjl_body);//内容
                                    $('.pingNum').html('('+data.obj[0].comTotal+')')
                                    $('.diary-detail-dept').html(dept_name);//部門
                                    $('.diary-detail-priv').html(user_role);//角色

                                    if(data.obj[0].diaType==1){
                                        $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                    }else{
                                        $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                    };// diaType(日志类型(1-工作日志,2-个人日志)
                                    //附件下载
                                    var str1 = "";
                                    var arr = new Array();
                                    arr = data.obj[0].attachment;
                                    var imgs;
                                    if(data.obj[0].avatar!=''){
                                        if(data.obj[0].avatar == '0'){
                                            imgs='/img/workLog/basichead_man.png';
                                        }else if(data.obj[0].avatar == '1'){
                                            imgs='/img/workLog/portrait3.png';
                                        }else{
                                            imgs='/img/user/'+data.obj[0].avatar;
                                        }
                                    }else{
                                        if(data.obj[0].sex == '0'){
                                            imgs='/img/workLog/basichead_man.png';
                                        }else{
                                            imgs='/img/workLog/portrait3.png';
                                        }
                                    }
                                    $('.userImg').attr('src',imgs);

                                }
                            });

                            $.ajax({
                                type:'get',
                                url:'/diary/getConByDiaId',
                                dataType:'json',
                                data:{'diaId':diaId},
                                success:function(data){
                                    if(data.flag){
                                        $.ajax({
                                            type:'get',
                                            url:'/diary/getReaders',
                                            dataType:'json',
                                            data:{'diaId':diaId},
                                            success:function(data){
                                                var readersName = data.object.readersName
                                                if(readersName == '暂无浏览'){
                                                    $("#yuelan").html(readersName)
                                                }else{
                                                    $("#yuelan").html(readersName+'已阅览')
                                                }

                                            }
                                        })
                                    }
                                }
                            })

                            $.ajax({
                                url: "/diary/getDiaryCommentByDiaId",
                                type: 'get',
                                dataType: "JSON",
                                data: {
                                    diaId:diaId
                                },
                                async: false,
                                success: function (res) {
                                    var str = "";
                                    if(res.flag){
                                        for (var j = 0; j < res.obj.length; j++) {
                                            var stra='';
                                            if(res.obj[j].diaryCommentReplyModelList != ''){
                                                if(res.obj[j].myDiaryComment == true){
                                                    for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                        stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                            '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                            '   <div class="feed-cmt-list-ext">' +
                                                            '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                            '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                            '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                            '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                            '   </div>    ' +
                                                            '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                            '</li></ul>';
                                                    }
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                        '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                        '</li>';
                                                }else{
                                                    for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                        stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                            '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                            '   <div class="feed-cmt-list-ext">' +
                                                            '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                            '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                            '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                            '   </div>    ' +
                                                            '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                            '</li></ul>';
                                                    }
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                        '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                        '</li>';
                                                }

                                            }else{
                                                if(res.obj[j].myDiaryComment == true){
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                        '       <a>编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '</li>';
                                                }else{
                                                    str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].sendTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                        '</li>';
                                                }

                                            }

                                        }
                                        $(".feed-ext-list").html(str);
                                        var liLength=$('.feed-cmt-list-item ').length;
                                    }
                                }
                            });
                        }else{
                            layer.msg(data.msg)
                        }

                    }
                });
            }else if(types == 'index'){
                $.ajax({
                    type:'get',
                    url:'/diary/diaryQuery',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'next',
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到头了')
                            return false
                        }
                        diaId = data.obj[0].diaId
                        $.ajax({
                            type:'get',
                            url:'/diary/diaryQuery',
                            dataType:'json',
                            data:{
                                'diaId':diaId,
                            },
                            success:function(data){
                                diaId = data.obj[0].diaId
                                var name=data.obj[0].userName;//用户
                                var feed_time=data.obj[0].diaTime;//时间
                                var feed_title=data.obj[0].subject;//标题
                                var jjl_body=data.obj[0].content;//内容
                                var dept_name=data.obj[0].deptName;//部门
                                var user_role=data.obj[0].userPrivName;//角色
                                $('.shoutest').html(name);//用户
                                $('.feed-time').html(feed_time);//时间
                                $('.feed-title').html(feed_title);//标题
                                $('.jjl_body').html(jjl_body);//内容
                                $('.pingNum').html('('+data.obj[0].comTotal+')')
                                $('.diary-detail-dept').html(dept_name);//部門
                                $('.diary-detail-priv').html(user_role);//角色

                                if(data.obj[0].diaType==1){
                                    $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                }else{
                                    $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                };// diaType(日志类型(1-工作日志,2-个人日志)
                                //附件下载
                                var str1 = "";
                                var arr = new Array();
                                arr = data.obj[0].attachment;
                                var imgs;
                                if(data.obj[0].avatar!=''){
                                    if(data.obj[0].avatar == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else if(data.obj[0].avatar == '1'){
                                        imgs='/img/workLog/portrait3.png';
                                    }else{
                                        imgs='/img/user/'+data.obj[0].avatar;
                                    }
                                }else{
                                    if(data.obj[0].sex == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else{
                                        imgs='/img/workLog/portrait3.png';
                                    }
                                }
                                $('.userImg').attr('src',imgs);

                            }
                        });

                        $.ajax({
                            type:'get',
                            url:'/diary/getConByDiaId',
                            dataType:'json',
                            data:{'diaId':diaId},
                            success:function(data){
                                if(data.flag){
                                    $.ajax({
                                        type:'get',
                                        url:'/diary/getReaders',
                                        dataType:'json',
                                        data:{'diaId':diaId},
                                        success:function(data){
                                            var readersName = data.object.readersName
                                            if(readersName == '暂无浏览'){
                                                $("#yuelan").html(readersName)
                                            }else{
                                                $("#yuelan").html(readersName+'已阅览')
                                            }

                                        }
                                    })
                                }
                            }
                        })

                        $.ajax({
                            url: "/diary/getDiaryCommentByDiaId",
                            type: 'get',
                            dataType: "JSON",
                            data: {
                                diaId:diaId
                            },
                            async: false,
                            success: function (res) {
                                var str = "";
                                if(res.flag){
                                    for (var j = 0; j < res.obj.length; j++) {
                                        var stra='';
                                        if(res.obj[j].diaryCommentReplyModelList != ''){
                                            if(res.obj[j].myDiaryComment == true){
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }else{
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }

                                        }else{
                                            if(res.obj[j].myDiaryComment == true){
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '       <a>编辑</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }else{
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }

                                        }

                                    }
                                    $(".feed-ext-list").html(str);
                                    var liLength=$('.feed-cmt-list-item ').length;
                                }
                            }
                        });
                    }
                });
            }else{
                $.ajax({
                    type:'get',
                    url:'/diary/diaryQuery',
                    dataType:'json',
                    data:{
                        'diaId':diaId,
                        'lastNextDiary':'next',
                        'startTime':startTime,
                        'endTime':endTime,
                        'userId':userId,
                        'deptId':deptId
                    },
                    success:function(data){
                        if(data.msg == '暂无数据'){
                            layer.msg('到底了')
                            return false
                        }
                        diaId = data.obj[0].diaId
                        $.ajax({
                            type:'get',
                            url:'/diary/diaryQuery',
                            dataType:'json',
                            data:{
                                'diaId':diaId,
                                'startTime':startTime,
                                'endTime':endTime,
                                'userId':userId,
                                'deptId':deptId
                            },
                            success:function(data){
                                diaId = data.obj[0].diaId
                                var name=data.obj[0].userName;//用户
                                var feed_time=data.obj[0].diaTime;//时间
                                var feed_title=data.obj[0].subject;//标题
                                var jjl_body=data.obj[0].content;//内容
                                var dept_name=data.obj[0].deptName;//部门
                                var user_role=data.obj[0].userPrivName;//角色
                                $('.shoutest').html(name);//用户
                                $('.feed-time').html(feed_time);//时间
                                $('.feed-title').html(feed_title);//标题
                                $('.jjl_body').html(jjl_body);//内容
                                $('.pingNum').html('('+data.obj[0].comTotal+')')
                                $('.diary-detail-dept').html(dept_name);//部門
                                $('.diary-detail-priv').html(user_role);//角色

                                if(data.obj[0].diaType==1){
                                    $("#feed-type").html('<fmt:message code="main.worklog" />');/*工作日志*/
                                }else{
                                    $("#feed-type").html('<fmt:message code="diary.th.personLog" />');/*个人日志*/
                                };// diaType(日志类型(1-工作日志,2-个人日志)
                                //附件下载
                                var str1 = "";
                                var arr = new Array();
                                arr = data.obj[0].attachment;
                                var imgs;
                                if(data.obj[0].avatar!=''){
                                    if(data.obj[0].avatar == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else if(data.obj[0].avatar == '1'){
                                        imgs='/img/workLog/portrait3.png';
                                    }else{
                                        imgs='/img/user/'+data.obj[0].avatar;
                                    }
                                }else{
                                    if(data.obj[0].sex == '0'){
                                        imgs='/img/workLog/basichead_man.png';
                                    }else{
                                        imgs='/img/workLog/portrait3.png';
                                    }
                                }
                                $('.userImg').attr('src',imgs);

                            }
                        });

                        $.ajax({
                            type:'get',
                            url:'/diary/getConByDiaId',
                            dataType:'json',
                            data:{'diaId':diaId},
                            success:function(data){
                                if(data.flag){
                                    $.ajax({
                                        type:'get',
                                        url:'/diary/getReaders',
                                        dataType:'json',
                                        data:{'diaId':diaId},
                                        success:function(data){
                                            var readersName = data.object.readersName
                                            if(readersName == '暂无浏览'){
                                                $("#yuelan").html(readersName)
                                            }else{
                                                $("#yuelan").html(readersName+'已阅览')
                                            }

                                        }
                                    })
                                }
                            }
                        })

                        $.ajax({
                            url: "/diary/getDiaryCommentByDiaId",
                            type: 'get',
                            dataType: "JSON",
                            data: {
                                diaId:diaId
                            },
                            async: false,
                            success: function (res) {
                                var str = "";
                                if(res.flag){
                                    for (var j = 0; j < res.obj.length; j++) {
                                        var stra='';
                                        if(res.obj[j].diaryCommentReplyModelList != ''){
                                            if(res.obj[j].myDiaryComment == true){
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '       <a href="javascript:;" onclick="editReplayCom($(this))" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'">编辑</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '       <a href="javascript:;" data-cmt-id="'+res.obj[j].commentId+'">编辑</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }else{
                                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span>回复</span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                                        '   <div class="feed-cmt-list-ext">' +
                                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))">删除</a> ' +
                                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;">回复</a>' +
                                                        '   </div>    ' +
                                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                                        '</li></ul>';
                                                }
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;">回复</a>' +
                                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                                    '</li>';
                                            }

                                        }else{
                                            if(res.obj[j].myDiaryComment == true){
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '       <a>编辑</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }else{
                                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                                    '   <div class="feed-cmt-list-ext">' +
                                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus" onclick="deleteCmt('+j+','+res.obj[j].commentId+')">删除</a> ' +
                                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus">回复</a>' +
                                                    '   </div>    ' +
                                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                                    '</li>';
                                            }

                                        }

                                    }
                                    $(".feed-ext-list").html(str);
                                    var liLength=$('.feed-cmt-list-item ').length;
                                }
                            }
                        });
                    }
                });
            }

        })
        //回复
        $(document).on('click','.feed-cmt-reply-handle',function(){

            uName=$(this).attr('data-to-text');
            comId=$(this).attr('data-cmt-type');
            replyId = $(this).attr('data-cmt-id');
            toId = $(this).attr('data-to-id');
            $('.btn-primary').attr('btnType','1');
            $('.btn-primary').attr('cutId',comId);
            $('.btn-primary').attr('replyId',replyId);
            $('.btn-primary').attr('toId',toId);
            $('.feed-ext-add-comment-to').toggle();

            $('.feed-ext-add-comment-to').text(uName);


        })
        //评论保存
        $(document).on('click','#tijiao',function(){
            $.ajax({
                type:'get',
                url:'/diary/getConByDiaId',
                dataType:'json',
                data:{
                    'diaId':diaId
                },
                success:function(data){
                    if(data.object.allowComment == 0){
                        layer.msg('评论功能已关闭')
                        return false
                    }else{
                        var content = $('#comment textarea').val();
                        if(content.trim()==""){
                            $.layerMsg({content:'评论内容不能为空！',icon:2},function(){

                            });
                            return
                        }
                        var isRemind = "";
                        if($("#SMS_REMIND_11").is(":checked")){
                            isRemind = "true";
                        }
                        if($('.feed-ext-add-comment-to').css('display') == 'none'){
                            $.ajax({
                                url: "/diary/insertDiaryComment",
                                type: 'post',
                                dataType: "JSON",
                                data: {
                                    diaId:diaId,
                                    content:content,
                                    isRemind:isRemind
                                },
                                async: false,
                                success: function (res) {
                                    if(res.flag){
                                        if(types == 'index'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=index';
                                        } else if(types == 'logQuery'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                                        } else if(types == 'noCommentLog'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=noCommentLog&isComment=true'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
                                        } else if(types == 'tongji'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=tongji';
                                        } else{
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                                        }

                                        $.layerMsg({content:'评论成功！',icon:6});/*评论成功*/
                                        $('.feed-submit-cmt-context').val('');

                                        //清除富文本编辑框内容

//                    UE.getEditor("comment"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_rl"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_query"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_qt"+num+"s").execCommand('cleardoc');
//                     var ischecked = $('.feed-ext-comment-sms-advcomment').find("[name='advcomment']").prop('checked');
//                     if (ischecked) {
//
//                         if(str==1){
//                             UE.getEditor("comment"+num+"s").execCommand('cleardoc');
//                         }else if(str==2){
//                             UE.getEditor("comment_sy"+num+"s").execCommand('cleardoc');
//                         }else if(str==3){
//                             UE.getEditor("comment_qt"+num+"s").execCommand('cleardoc');
//                         }else if(str==4){
//                             UE.getEditor("comment_query"+num+"s").execCommand('cleardoc');
//                         }else{
//                             UE.getEditor("comment_rl"+num+"s").execCommand('cleardoc');
//                         }
//                     }
                                    }
                                }
                            });
                        }else if($('.feed-ext-add-comment-to').css('display') == 'block'){
                            var that = $(this)
                            var replyComment = $('.feed-submit-cmt-context').val();
                            var commentId = comId;
                            var toId = that.attr('toid')
                            var replyComId = replyId;
                            $.ajax({
                                type:'post',
                                url:'/diary/insertCommentReply',
                                dataType:'json',
                                data:{'replyComment':replyComment,
                                    'commentId':commentId,
                                    'toId':toId,
                                    'replyComId':replyComId
                                },
                                success:function(res){
                                    if(res.flag){
                                        if(types == 'index'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=index';
                                        } else if(types == 'logQuery'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                                        } else if(types == 'noCommentLog'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=noCommentLog&isComment=true'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
                                        } else if(types == 'tongji'){
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=tongji';
                                        } else{
                                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                                        }

                                        $.layerMsg({content:'回复成功！',icon:1});/*回复成功*/

                                        $('.feed-submit-cmt-context').val('');
                                        $('.feed-ext-add-comment-to').hide();
                                    }
                                }
                            })
                        }
                    }
                }
            })





        })
    })
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  decodeURI(r[2]); return null;
    }
    // 删除评论接口
    function deleteCmt(num,cmtId) {
        var cmtId = cmtId;
        layer.confirm('确定删除该条评论？', {/*确定删除该条评论*/
            btn: ['确定','取消'], //按钮  /*确定  取消*/
            title:'删除评论' /*删除文件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/diary/delDiaryCommentByCommentId",
                type: 'post',
                dataType: "JSON",
                data: "commentId="+cmtId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        if(types == 'index'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=index';
                        } else if(types == 'logQuery'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                        } else if(types == 'noCommentLog'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=noCommentLog&isComment=true'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
                        } else if(types == 'tongji'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=tongji';
                        } else{
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                        }
                        layer.msg("删除评论成功！",{icon:1});/*删除评论成功*/
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
    //回复删除接口
    function deleteReplayCom(that){
        var repId=that.attr('data-cmt-id');
        layer.confirm('确定删除该条评论？', {/*确定删除该条评论*/
            btn: ['确定','取消'], //按钮  /*确定 取消*/
            title:'删除评论' /*删除文件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/diary/delCommentReplyByReplyId',
                dataType:'json',
                data:{'replyId':repId},
                success:function(res){
                    if(res.flag){
                        if(types == 'index'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=index';
                        } else if(types == 'logQuery'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                        } else if(types == 'noCommentLog'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=noCommentLog&isComment=true'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
                        } else if(types == 'tongji'){
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=tongji';
                        } else{
                            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=logQuery'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+userName+'&deptId='+
                                deptId+'&deptName='+deptName+'&userTopId='+userTopId+'&userTopName='+userTopName+'&diaType='+diaType+'&commentStatus='+ commentStatus;
                        }
                        layer.msg("删除评论成功！",{icon:1});/*删除评论成功*/
                    }
                }
            })
        }, function(){
            layer.closeAll();
        });

    }
</script>
</html>
