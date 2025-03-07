<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title><fmt:message code="news.th.newscomment"/></title>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/comment.css?20220824"/>
    <script src="/js/common/language.js"></script>

<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        body{
            overflow: scroll;
            height: 100%;
            width: 100%;
            position: absolute;
        }
        .total .table_b div{
            float:none;
        }
        .total .table_b .bt{
            margin-left:0px;
        }
    </style>
</head>
<body>
<div class="sumNumber"><fmt:message code="workflow.th.RelatedComments"/><span id="sumNumber">0</span><fmt:message code="workflow.th.strip"/></div>
<table class="clearfix total">
    <tbody>
    <tr>
        <td colspan="2" class="query_title">
            <fmt:message code="workflow.th.Comment1"/>
        </td>
    </tr>

    <tr>
        <td class="size_color td_w"><fmt:message code="notice.th.content"/>:</td>
        <td>
            <textarea class="SmallStatic" id="add_text" name="to_name" style="margin: 0px;width: 98%;height: 85px;"></textarea>
        </td>
    </tr>
    <tr class="operation">
        <td class="size_color"><fmt:message code="workflow.th.Signature"/>:</td>
        <td>
            <div id="system_personnel">
                <input id="operation1_name_" type="radio" name="radio" value="1" checked>
                <div class="operation1" id="operation1_name"></div>
            </div>
            <div id="anonymous_personnel">
           <input id="personnel_nm_"  type="radio" name="radio" value="2"><fmt:message code="workflow.th.nickname"/>
                <input id="personnel_nm" type="text">
            </div>

            <!--  <input type="radio" name="radio"></input>
            <input type="radio" name="radio">删除</input> -->
        </td>
    </tr>
    <tr class="table_b">
        <td colspan="2" style="text-align: center">
                <div class="bt determine" id="determine"><fmt:message code="workflow.th.Publish"/></div>
                <%--<div class="exportNew" id="look_comment">查看所有评论</div>--%>
                <div onclick="close_w()"><fmt:message code="global.lang.close"/></div>
        </td>
    </tr>

    </tbody>
</table>
<div class="Rendering">
    <%--<table class="clearfix reply">--%>
        <%--<tbody>--%>
        <%--<tr>--%>
            <%--<td class="comment_title">--%>
                <%--<div class="title_left">田二牛</div>--%>
                <%--<div class="title_right">发表时间：2017-07-07 10：41：12</div>--%>
            <%--</td>--%>
        <%--</tr>--%>

        <%--<tr>--%>
            <%--<td class="card">--%>
                <%--<div class="comment_card">--%>
                    <%--评论内容原帖--%>
                    <%--百度新闻是包含海量资讯的新闻服务平台,真实反映每时每刻的新闻热点。您可以搜索新闻事件、热点话题、人物动态、产品资讯等,快速了解它们的最新进展。--%>
                <%--</div>--%>
                <%--<img class="" src="../img/news/newCard.png" alt=""/>--%>

            <%--</td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td>--%>
                <%--<div>评论内容回复</div>--%>
                <%--<div class="reply_footer">--%>
                    <%--<div class="reply_img">--%>
                        <%--<img src="../img/news/commentimg.png" alt="">--%>
                        <%--回复本贴--%>
                    <%--</div>--%>
                    <%--<div class="delete">--%>
                        <%--<img src="../img/news/newDelete.png" alt="">--%>
                        <%--删除--%>
                    <%--</div>--%>
                    <%--<div class="number">回复数：<span>0</span></div>--%>
                <%--</div>--%>
            <%--</td>--%>
        <%--</tr>--%>

        <%--</tbody>--%>
    <%--</table>--%>
</div>





</body>
<script type="text/javascript">
    function commentsShow(data){
        var nid = $.getQueryString('newsId');
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('table').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-bottom: 10px;margin-left: 40px;"> 机密级★ </p>')
                    }
                }
            }
        })
        $.ajax({
            url: "/news/getNewsCommentInfo",
            type:'get',
            dataType:"JSON",
            data : {"news_id":nid},
            success:function(obj){
                var str = "";
                var arr =obj.obj;
                var isAdmin = '';
                if(arr.length > 0){
                    isAdmin = arr[0].ifAdmin;
                }
                if(isAdmin=="ok") {
                    for (var i = 0; i < obj.obj.length; i++) {
                        var date = new Date(obj.obj[i].re_time);
                        var Y = date.getFullYear() + '-';
                        var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
                        var D = date.getDate() + ' ';
                        var h = date.getHours() + ':';
                        var m = date.getMinutes() + ':';
                        var s = date.getSeconds();
                        var re_time = Y + M + D + h + m + s;
                        var originalnewsComment = "";
                        var Reply = "";
                        if (obj.obj[i].originalnewsComment == undefined) {
                            originalnewsComment = obj.obj[i].content;
                            Reply = "";

                        } else {
                            originalnewsComment = obj.obj[i].originalnewsComment.content;
                            Reply = obj.obj[i].content;

                        }
                        ;
                        var user_id = ""
                        if (obj.obj[i].nick_name == "" || obj.obj[i].nick_name == undefined) {
                            user_id = obj.obj[i].user_id
                        } else {
                            user_id = obj.obj[i].nick_name
                        }
                        str += '<table class="clearfix reply">' +
                            '<tbody>' +
                            '<tr>' +
                            '<td class="comment_title">' +
                            '<div class="title_left">' + user_id + '</div>' +
                            '<div class="title_right"><fmt:message code="workflow.th.PublicationTime"/>：' + re_time + '</div>' +
                            '</td>' +
                            '</tr>' +
                            ' <tr>' +
                            ' <td class="card">' +
                            '<div class="comment_card">' + originalnewsComment + '</div>' +
                            '<img class="" src="../img/news/newCard.png" alt=""/>' +

                            '</td>' +
                            '</tr>' +
                            '<tr>' +
                            '<td>' +
                            '<div>' + Reply + '</div>' +
                            '<div class="reply_footer">' +
                            ' <div class="reply_img windowOpen_reply" parent_id=' + obj.obj[i].comment_id + '>' +
                            '<img src="../img/news/commentimg.png" alt="">' +
                            '<fmt:message code="workflow.th.Replypost"/>' +
                            '</div>' +
                            '<div class="delete" id="deleteComment' + i + '" del=' + obj.obj[i].comment_id + ' onclick= "delete_comment(' + i + ')">' +
                            '<img src="../img/news/newDelete.png" alt="">' +
                            ' <fmt:message code="global.lang.delete"/>' +
                            '</div>' +
                            '<div class="number" parent_id=' + obj.obj[i].comment_id + '><fmt:message code="workflow.th.RecoveryNumber"/>：<span class="numbersum">' + obj.obj[i].count + '</span></div>' +
                            '</div>' +
                            '</td>' +
                            '</tr>' +
                            '</tbody>' +
                            '</table>';

                    }
                    ;
                }else{
                    for (var i = 0; i < obj.obj.length; i++) {
                        var date = new Date(obj.obj[i].re_time);
                        var Y = date.getFullYear() + '-';
                        var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
                        var D = date.getDate() + ' ';
                        var h = date.getHours() + ':';
                        var m = date.getMinutes() + ':';
                        var s = date.getSeconds();
                        var re_time = Y + M + D + h + m + s;
                        var originalnewsComment = "";
                        var Reply = "";
                        if (obj.obj[i].originalnewsComment == undefined) {
                            originalnewsComment = obj.obj[i].content;
                            Reply = "";

                        } else {
                            originalnewsComment = obj.obj[i].originalnewsComment.content;
                            Reply = obj.obj[i].content;

                        }
                        ;
                        var user_id = ""
                        if (obj.obj[i].nick_name == "" || obj.obj[i].nick_name == undefined) {
                            user_id = obj.obj[i].user_id
                        } else {
                            user_id = obj.obj[i].nick_name
                        }
                       if(obj.obj[i].type=="ok") {
                           str += '<table class="clearfix reply">' +
                               '<tbody>' +
                               '<tr>' +
                               '<td class="comment_title">' +
                               '<div class="title_left">' + user_id + '</div>' +
                               '<div class="title_right"><fmt:message code="workflow.th.PublicationTime"/>：' + re_time + '</div>' +
                               '</td>' +
                               '</tr>' +
                               ' <tr>' +
                               ' <td class="card">' +
                               '<div class="comment_card">' + originalnewsComment + '</div>' +
                               '<img class="" src="../img/news/newCard.png" alt=""/>' +

                               '</td>' +
                               '</tr>' +
                               '<tr>' +
                               '<td>' +
                               '<div>' + Reply + '</div>' +
                               '<div class="reply_footer">' +
                               ' <div class="reply_img windowOpen_reply" parent_id=' + obj.obj[i].comment_id + '>' +
                               '<img src="../img/news/commentimg.png" alt="">' +
                               '<fmt:message code="workflow.th.Replypost"/>' +
                               '</div>' +
                               '<div class="delete" id="deleteComment' + i + '" del=' + obj.obj[i].comment_id + ' onclick= "delete_comment(' + i + ')">' +
                               '<img src="../img/news/newDelete.png" alt="">' +
                               ' <fmt:message code="global.lang.delete"/>' +
                               '</div>' +
                               '<div class="number" parent_id=' + obj.obj[i].comment_id + '><fmt:message code="workflow.th.RecoveryNumber"/>：<span class="numbersum">' + obj.obj[i].count + '</span></div>' +
                               '</div>' +
                               '</td>' +
                               '</tr>' +
                               '</tbody>' +
                               '</table>';
                       }else{
                           str += '<table class="clearfix reply">' +
                               '<tbody>' +
                               '<tr>' +
                               '<td class="comment_title">' +
                               '<div class="title_left">' + user_id + '</div>' +
                               '<div class="title_right"><fmt:message code="workflow.th.PublicationTime"/>：' + re_time + '</div>' +
                               '</td>' +
                               '</tr>' +
                               ' <tr>' +
                               ' <td class="card">' +
                               '<div class="comment_card">' + originalnewsComment + '</div>' +
                               '<img class="" src="../img/news/newCard.png" alt=""/>' +

                               '</td>' +
                               '</tr>' +
                               '<tr>' +
                               '<td>' +
                               '<div>' + Reply + '</div>' +
                               '<div class="reply_footer">' +
                               ' <div class="reply_img windowOpen_reply" parent_id=' + obj.obj[i].comment_id + '>' +
                               '<img src="../img/news/commentimg.png" alt="">' +
                               '<fmt:message code="workflow.th.Replypost"/>' +
                               '</div>' +
                               '<div class="number" parent_id=' + obj.obj[i].comment_id + '><fmt:message code="workflow.th.RecoveryNumber"/>：<span class="numbersum">' + obj.obj[i].count + '</span></div>' +
                               '</div>' +
                               '</td>' +
                               '</tr>' +
                               '</tbody>' +
                               '</table>';
                       }

                    }
                    ;
                }
                $(".Rendering").html(str);
            },
            error:function(e){
//                console.log(e);
            }
        });

    }
    //评论中删除评论
    function delete_comment(i){
        var data={
            'comment_id':$("#deleteComment"+i).attr("del")
        };
//        alert(data.comment_id);
        $.layerConfirm({title:'<fmt:message code="workflow.th.suredel"/>',content:'<fmt:message code="workflow.th.que"/>',icon:0},function(){
            $.ajax({
                url:"/news/deleteComment",
                type:'get',
                dataType:"JSON",
                data : data,
                success:function(data){
                    if(data.msg == '<fmt:message code="workflow.th.deletePosted"/>'){
                        $.layerMsg({content:'<fmt:message code="workflow.th.deleteComments"/>',icon:5});
                        return;
                    }else if(data.msg == '<fmt:message code="workflow.th.Success"/>'){
                        location.reload();
                    }
                },
                error:function(e){
//                    console.log(e);
                }
            });
        },function(){
            return false;
        })
    }
    function close_w(){
        window.close();
    }
    function sl(){
        var nid = $.getQueryString('newsId');
        $.ajax({
            url: "/news/getNewsCount",
            type:'get',
            dataType:"JSON",
            data : {
                news_id:nid
            },
            success:function(data){
                $("#sumNumber").html(data.object)
            },
            error:function(e){
//                console.log(e);
            }
        });
    };
    $(function () {
        commentsShow();
        sl();
        var nid = $.getQueryString('newsId');
        var comment = $.getQueryString('comment');
        if(comment==0){
            $("#anonymous_personnel").hide();
        }else{
            $("#system_personnel").show();
            $("#operation1_name_").removeAttr("checked")
            $("#personnel_nm_").attr("checked","checked")
            $("#anonymous_personnel").show()
        };
        /* 获取署名的那个接口 */
        $.ajax({
            url: "/news/getUser",
            type:'get',
            dataType:"JSON",
            success:function(data){
                $("#operation1_name").html(data.object.userName)
            },
            error:function(e){
//                console.log(e);
            }
        });
        // 发表评论
        $("#determine").on("click",function(){
//            alert(nid);
//            alert($("#operation1_name").html());
            var data = {
                'news_id':nid, //新闻ID
                "content": $("#add_text").val(),  // 评论/回复内容
                "user_id": $("#operation1_name").html(),  //  发表评论/回复的用户
                "nick_name": $("#personnel_nm").val()   //  昵称
            };

            if( $("#add_text").val()==""){
                layer.msg('<fmt:message code="workflow.th.FillContent"/>', { icon:6});
                return false;
            };
//            alert($("#add_text").val());

            if($("#operation1_name_").is(":checked")) {
//                alert(1);
                data.user_id=$("#operation1_name").html();
                data.nick_name="";
            }else if($("#personnel_nm_").is(":checked")){
//                alert(2);
                data.user_id="";

                if($("#personnel_nm").val()==""){
                    layer.msg('<fmt:message code="new.th.theNicknameCannotBeEmpty" />', { icon:6});
                    return
                }else{
                    data.nick_name= $("#personnel_nm").val()
                }
            };
            $.ajax({
                url: "/news/AddNewsComment",
                type:'post',
                dataType:"JSON",
                data : data,
                success:function(data){
                    $("#add_text").val("");
                    commentsShow(data);
                    sl(data);
                    $("#personnel_nm").val("")
                    window.opener.location.reload();
                },
                error:function(e){
//                    console.log(e);
                }
            })

        });
        /* 回复本帖评论页 */
        $(".Rendering").on('click', '.windowOpen_reply', function () {
            var parent_id = $(this).attr('parent_id');
            $.popWindow('replyComment?newsId='+ nid +'&comment='+ comment +'&parent_id='+ parent_id +'');
        });






    });
</script>


</html>
