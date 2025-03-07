<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html><head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.th.FileDetails"/></title>
    <%--<link rel="stylesheet" type="text/css" href="../css/base.css"/>--%>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js?20200721.2" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>

    <%--<script src="../js/webOffice/fileShow.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/starRating/js/star.js" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            width: 100%;
        }
        a{
            text-decoration: none;
            /*color: #2B7FE0;*/
        }
        /* .detailsContent{width: 100%;overflow: hidden;background-color: #f6f7f9;} */
        .detailsContent {
            width: 80%;
            overflow: hidden;
            margin: 0 auto;
        }

        .detailsContent .title {
            width: 100%;
            text-align: center;
            line-height: 60px;
            color: #2a588c;
            font-size: 25px;
            font-weight: bold;
        }
        .divContent {
            width: 100%;
        }

        /*.divContent .divTxt {*/
            /*border-bottom: 1px solid #dedede;*/
            /*border-top: 1px solid #dedede;*/
        /*}*/

        .divTxt p {
            font-size: 14px;
            color: #444;
            line-height: 25px;
            margin-left: 20px;
        }

        .divContent .keyWord {
            margin: 0 0 10px 50px;
        }

        .divContent .keyWord span {
            margin-right: 10px;
            color: #2b7fe0;
        }
       .Table{
           width: 100%;
           table-layout: fixed;
       }
        .Table tr td{
            /*padding-left: 20px;*/
            font-size: 14px;
            padding: 20px 10px 10px 20px;
        }
        .button_query {
            color: #FFF;
            font-size: 14px;
            width: 50px;
            height: 28px;
            line-height: 28px;
            background-color: rgb(0, 162, 212);
            display: inline-block;
            text-align: center;
            border-radius: 3px;
            margin-left: 10px;
            float: left;
        }
        #closeBtn{
            background-color: #f8f8f8;
            color:#666;
            border:#ccc 1px solid;
        }
        #deleteBtn {
            background-color: #dd6161;
            color: #fff;
            border: #c73d3d;
        }
        #chandReadBtn{
            /*background-color: #dd6161;*/
            color: #fff;
            border: #c73d3d;
        }
        #editBtn{
            border:#0093c1;
        }
        .btn{
            width: 252px;
            position: fixed;
            bottom: 5%;
            right: 5%;
        }
        .commentArea{
            width: 100%;
        }
        ul,li{
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .stararea{
            display: inline;
            float: left;
            width: 260px;
            margin-left: 80px;
        }
        .stararea .pltitle {
            font-size: 11pt;
            float: left;
            line-height: 25px;
            display: inline-block;
            color: #686868;
            font-weight: bold;
        }
        /*.stararea li {*/
            /*float: left;*/
            /*width: 20px;*/
            /*background: url(/img/file/star.png) no-repeat 0px 1px;*/
        /*}*/
        /*.stararea li a {*/
            /*display: inline-block;*/
            /*width: 20px;*/
            /*height: 18px;*/
        /*}*/
        .txtComment{
            width: 100%;
            margin: 10px 0;
        }
        .txtComment textarea{
            width: 100%;
            border-radius: 5px;
        }
        .tijiaoBtn{
            width: 50px;
            height: 28px;
            border-radius: 4px;
            background: #4b8cf7;
            color: #ffffff;
            float: right;
            line-height: 28px;
            text-align: center;
            font-size: 11pt;
            cursor: pointer;
        }
        .pingjiaBox{
            padding: 10px;
            border: #ccc 1px solid;
        }


        .rating{
            float: left;
            position:relative;
            width:100px !important;
            height: 24px;
            background:url(/lib/starRating/images/star.png) repeat-x;
            /*margin:20px;*/
        }
        .rating-disply{
            width:24px;
            height:45px;
            background-position:0 -22px;
            background:url(/lib/starRating/images/star.png) repeat-x 0 -26px;

        }
        .rating-mask{
            position:absolute;
            left:0;
            top:0;
            width:100%;
        }
        .rating-item{
            list-style: none;
            float: left;
            width:24px;
            height:45px;
            cursor:pointer;
        }
        .pingjun{
            display: inline-block;
            position: relative;
            width:100px;
            height: 24px;
            background:url(/lib/starRating/images/star.png) repeat-x;
        }
        .pjdefen{
            width: 0px;
            height: 45px;
            background-position:0 -22px;
            background:url(/lib/starRating/images/star.png) repeat-x 0 -26px;
        }
/*该条数据已被删除*/
        .noData .bgImg {
            width: 360px;
            height: 150px;
            margin: 100px auto;
            background-color: #357ece;
            border-radius: 10px;
            box-shadow: 3px 3px 3px #2F5C8F;
            overflow: hidden;
            text-align: center;
        }
        .noData .bgImg .IMG {
            float: left;
            width: 75px;
            height: 75px;
            margin-top: 37px;
            margin-left: 30px;
        }
        .noData .bgImg .TXT {
            float: left;
            color: #fff;
            font-size: 16pt;
            margin-top: 60px;
            margin-left: 20px;
        }
    </style>
    <script type="text/javascript">
        var typNum=0;
        $(function(){
            var conId=$.getQueryString('contentId');
            var childSortId=$.getQueryString('sortId');
            var deleteNum=$.getQueryString('deleteNum');
            var exportNum=$.getQueryString('exportNum');
            var editNum=$.getQueryString('editNum');
            var isReaderNum=$.getQueryString('riderNum');
            var reviewNum=$.getQueryString('reviewNum');
            $.ajax({
                type:'post',
                url:'/newFileContent/getContentById',
                dataType:'json',
                data:{
                    sortId:childSortId,
                    page:1,
                    pageSize:1,
                    useFlag:true,
                    sortType:5
                },
                async:false,
                success:function(res,fn){
                    if(res.flag){
                        console.log(res,'res')
                        deleteNum = res.object.attributes.DEL_USER;
                        editNum = res.object.attributes.MANAGE_USER;
                        exportNum = res.object.attributes.DOWN_USER;
                        reviewNum = res.object.attributes.REVIEW;
                        isReaderNum = res.object.attributes.SIGN_USER;
                    }
                }
            });
            if(deleteNum == '0'){ //判断删除权限
                $('#deleteBtn').hide();
            }else {
                $('#deleteBtn').show();
            }
            if(editNum == '0'){ //判断编辑权限
                $('#editBtn').hide();
            }else {
                $('#editBtn').show();
            }
            if(exportNum ==undefined || exportNum == '1'){
                $('#printing').show();
            }else{
                $('#printing').hide();
            }
            if(editNum == undefined || editNum == '1'){ //判断编辑权限
                editNum='1';
            }else{
                editNum='0';
            }
            if(reviewNum == undefined || reviewNum == '0'){
                $('.commentArea').hide();
            }else{
                $('.commentArea').show();
            }
            var layerTop=($(window).height()-160)/2
            $(document).find('.layui-layer-dialog').css('top',layerTop+'px');

            $.ajax({
                type:'get',
                url:'/newFileContent/getFilePubContent',
                dataType:'json',
                data:{'contentId':conId},
                success:function(res){
                    var data1=res.data;
                    //如果没有数据，该条记录被删除
                    if(data1==undefined){
                        $(".outMain").html("");
                        $(".outMain").html('<div class="noData" id="noFile" style=""><div class="bgImg"><div class="IMG"><img src="../img/sys/icon64_info.png"> </div> <div class="TXT" id="TXT">该条数据已被删除</div> </div></div>')

                    }
                    var str='';
                    var arrList=data1.attachmentList;
                    $('.title').text('');
                    $('.spanTxt').empty();
                    $('.attachMent').empty();
                    $('.title').text(data1.subject);
                    if(res.content!=''){
                        $('.divTxt').html(data1.content);
                    }else{
                        $('.divTxt').html('<p style="text-align: center;color:#999999;margin: 0px;margin-top: 20px;"><fmt:message code="main.th.TextContent"/></p>');
                    }

                    if(data1.attachmentName.trim()!=""){

                        if(exportNum != undefined){
                            attachView(arrList,$('.attachMent'),'1',editNum,exportNum,'0');
                        }else{
                            attachView(arrList,$('.attachMent'),'1',editNum,'1','0');
                        }
                    }else{

                        $('.attachMent').html("<fmt:message code="file.th.thereAreNoFilesYet" />")
                    }
                   if(data1.attachmentDesc.trim()!=""){
                       $('.attachDesc').text(data1.attachmentDesc)
                   }else{
                       $('.attachDesc').text("<fmt:message code="file.th.thereIsNoContentYet" />")
                   }
                }
            })
            //<a href="/common/ntkoPreview?'+encodeURI(data1[i].attUrl)+'" target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>
            //编辑按钮
            $('#editBtn').click(function(){
                $.popWindow('/newFilePub/newFiles?contentId='+conId+'&sortId='+childSortId+'&ie_open=yes','<fmt:message code="global.lang.edit" />','100','300','860px','500px');
            })
//            打印按钮
            $('#printing').click(function () {
                window.print();
            })
            //删除按钮
            $('#deleteBtn').click(function(){
                var fileId=[];
                fileId.push(conId);
                layer.confirm('<fmt:message code="workflow.th.suredel"/>', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'] //按钮
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/batchDeleteConId',
                        dataType:'json',
                        data:{'fileId':fileId},
                        success:function(){
//                            window.opener.parentajax(childSortId);
<%--                             window.opener.init(childSortId);--%>
<%--                            layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});--%>
<%--                            window.close();--%>
//                            window.opener.location.reload();
                            try {
                                window.opener.init(childSortId);
                            }catch (e) {
                                
                            }finally {
                                layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                                window.close();
                            }
                        }
                    })
                }, function(){
                    layer.closeAll();
                });
            })
            //关闭按钮
            $('#closeBtn').click(function(){
                window.close();
            })
            $('#rating').star({
                modus: 'entire', //点亮模式 （‘half’半颗， ‘entire’整颗）
                total: 5, //默认共几颗星
                num: 0, //默认点亮个数
                readOnly: false, //默认是否只读，
//                chosen: function(count, total) { //点击后事件
//                    $('#rating').star('unbindEvent'); //点击后禁止再选，如不需要可自行删除该函数
//                }
            })
//            评论显示
            PLdata(conId,$('.pingjiaBox'));
//            点击评论提交
            $('.tijiaoBtn').click(function () {
                var PLnum=$('.rating-disply').width()/20;
                if($('#fileContent').val() == ''){
                    layer.msg('<fmt:message code="file.th.pleaseEnterTheCommentContent" />',{icon:5});
                    return;
                }
                $.ajax({
                    type:'post',
                    url:'/newFileComment/save',
                    dataType:'json',
                    data:{
                        fileId:conId,
                        fileStar:PLnum,
                        fileContent:$('#fileContent').val()
                    },
                    success:function (res) {
                        if(res.flag){
                            layer.msg('<fmt:message code="diary.th.CommentSuccess" />！',{icon:6});
                            $('#fileContent').val('');
                            PLdata(conId,$('.pingjiaBox'));
                        }else{
                            layer.msg('<fmt:message code="file.th.commentFailed" />！',{icon:5});
                        }
                    }
                })
            })
//            评论删除
            $('.pingjiaBox').on('click','.deletePL',function () {
                var daId=$(this).parents('.pingjia').attr('data-id');
                layer.confirm('<fmt:message code="file.th.areYouSureYouWantToDeleteThisComment" />？', {
                    btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="license.cancel" />'], //按钮
                    title:"<fmt:message code="file.th.deleteComment" />"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFileComment/delete',
                        dataType:'json',
                        data:{
                            commentId:daId
                        },
                        success:function(res){
                            if(res.flag){
                                layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                                PLdata(conId,$('.pingjiaBox'));
                            }else{
                                layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:5});
                            }
                        }
                    });

                }, function(){
                    layer.closeAll();
                });
            })
//            评论人详细信息
            $('.pingjiaBox').on('click','.userDetail',function () {
                var uId=$(this).attr('data-uid');
                $.popWindow('/sys/userDetails?uid='+uId,'用户信息','50','50','800px','600px');
            })
        })
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.detailsContent').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 50px;"> 机密级★ </p>')
                    }
                }
            }
        })
//      评论显示方法
        function PLdata(id,element) {
            $.ajax({
                type:'get',
                url:'/newFileComment/selComments',
                dataType:'json',
                data:{
                    fileId:id
                },
                success:function (res) {
                    var data=res.datas;
                    var str='';
                    if(res.flag){
                        $('.pjdefen').width((res.object)*20)
                        if(data.length > 0){
                            $('.zanwupingjia').hide();
                            element.show();
                            for(var i=0;i<data.length;i++){
                                str+='<div class="pingjia" data-id="'+data[i].commentId+'">'+
                                    '<span class="userDetail" data-uid="'+data[i].uid+'" style="font-size: 11pt;color: #1687cb;cursor: pointer;">'+data[i].userName+'</span>'+
                                    '<span style="float: right;">' +function(){
                                    if($.cookie('userId')=='admin'){
                                        return '<a href="javascript:;" style="font-size: 11pt;color: #1687cb;margin-right: 10px;" class="deletePL">删除</a>'
                                    }else if($.cookie('userId') == data[i].userId){
                                        return '<a href="javascript:;" style="font-size: 11pt;color: #1687cb;margin-right: 10px;" class="deletePL">删除</a>'
                                    }else{
                                        return ''
                                    }
                                    }()+
                                    '<span>'+new Date(data[i].sendTime).Format('yyyy-MM-dd hh:mm:ss')+'</span>' +
                                    '</span>'+
                                    '<p style="border-bottom: #ccc 1px dashed;padding-bottom: 10px;font-size: 10pt;">'+data[i].content+'</p>'+
                                    '</div>';
                            }

                        }else {
                            $('.zanwupingjia').show();
                            element.hide();
                        }
                        element.html(str);
                    }
                }
            })
        }
    </script>
</head>
<body style="overflow: hidden;">
<div class="outMain" style="height: 100%;overflow-y: auto;">
    <div class="detailsContent">
        <div class="title"></div>
        <div class="divContent">
            <div class="divTxt"></div>
            <div class="divContent1" style="padding-top:10px;margin-top: 65px;margin-bottom: 70px;">
                <table class="Table" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width: 72px;;vertical-align: top;padding-right: 0px;font-weight: bold;color: #2a588c;"><fmt:message code="main.th.AttachmentFile"/>：</td>
                        <td class="attachMent" style="padding-left: 0px"></td>
                    </tr>
                    <tr>
                        <td style="width: 90px;padding-right: 0px;font-weight: bold;color: #2a588c;"><fmt:message code="doc.th.AppendixDescription"/>：</td>
                        <td class="attachDesc" style="padding-left: 0px"></td>
                    </tr>

                </table>
            </div>
        </div>
        <div class="btn">
            <%--<a href="javascript:;" id="chandReadBtn" class="button_query" style="display: none;">签阅</a>--%>
            <a href="javascript:;" id="editBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.edit"/></a>
            <a href="javascript:;" id="printing" class="button_query" style="display: block;"><fmt:message code="global.lang.print"/></a>
            <a href="javascript:;" id="deleteBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.delete"/></a>
            <a href="javascript:;" id="closeBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.close"/></a>
        </div>
        <div class="commentArea" style="display: none;">
            <span style="display:block;float: left;font-size: 11pt;font-weight: bold;color: #686868;"><fmt:message code="file.th.score" />：</span>
            <div class="rating" id="rating"></div>
            <div class="stararea" id="averstar">
                <span class="pltitle" style="width: 90px;"><fmt:message code="file.th.averageScore" />：</span>
                <div class="pingjun">
                    <div class="pjdefen"></div>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div class="txtComment">
                <textarea name="fileContent" id="fileContent" rows="5"></textarea>
            </div>
            <div class="operation">
                <%--<input type="checkbox" name="" id="ss" value="">--%>
                <%--<span>发送事务提醒消息</span>--%>
                <div class="tijiaoBtn"><span><fmt:message code="diary.th.remand" /></span></div>
            </div>
            <div style="clear: both;"></div>
            <div class="contentBox" style="display: block;margin-top: 20px;margin-bottom: 20px;">
                <div class="zanwupingjia" style="display: none;">
                    <p><fmt:message code="file.th.userEvaluation" /></p>
                    <p><fmt:message code="file.th.thereAreNoEvaluationsYet" /></p>
                </div>
                <div class="pingjiaBox">
                    <%--<div class="pingjia">--%>
                    <%--<span style="font-size: 11pt;color: #1687cb;">系统管理员</span>--%>
                    <%--<span style="float: right;"><a href="javascript:;" style="font-size: 11pt;color: #1687cb;margin-right: 10px;">删除</a><span>2018-07-30 14:39:12</span></span>--%>
                    <%--<p style="border-bottom: #ccc 1px dashed;padding-bottom: 10px;font-size: 10pt;">hkashd</p>--%>
                    <%--</div>--%>
                    <%--<div class="pingjia">--%>
                    <%--<span style="font-size: 11pt;color: #1687cb;">系统管理员</span>--%>
                    <%--<span style="float: right;"><a href="javascript:;" style="font-size: 11pt;color: #1687cb;margin-right: 10px;">删除</a><span>2018-07-30 14:39:12</span></span>--%>
                    <%--<p style="border-bottom: #ccc 1px dashed;padding-bottom: 10px;font-size: 10pt;">dsfkksdf</p>--%>
                    <%--</div>--%>
                </div>

            </div>
        </div>

    </div>
</div>

<script>
    function openerShow(){
        window.opener.queryAllDatasd();
    }
    // $('.operationImg').click(function(){
        $(document).on('click','.operationImg',function () {
        var thisa = $(this).next().attr('openimg')
        var openNmu = $(this).next().attr('openNmu')
        var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
        $('.Table').append(str3)
        $('#getIndex').val(thisa)
        console.log(openNmu)
        event.stopPropagation()
        window.open("/email/imgOpen?openNmu="+openNmu,"_blank");

    })
</script>
</body></html>

