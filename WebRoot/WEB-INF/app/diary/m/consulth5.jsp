<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>我发起的详情</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
	<link href="../lib/mui/mui/mui.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/diary/m/consult.css">
	<link rel="stylesheet" href="../css/diary/m/diary_base.css" />
	<style>
		.divImg{
			float:left;
		}
		.divCon{
			float:left;
			width:80%;
		}
		pre{
			margin:0;padding:0;
			white-space: pre-wrap!important;
			word-wrap: break-word!important;
			*white-space:normal!important;
		}
	</style>
	<script type="text/javascript" charset="utf-8">
        mui.init();
	</script>
</head>
<body id="iStarted">
<div class="mui-content">
	<div class="tit_con">
		<div class="divImg">
			<img class="portrait" src="../../img/diary/m/head.png" alt="" />
		</div>
		<div class="divCon">
			<div class="clearfix">
				<span class="pull_left subject" id="subject"></span>

			</div>
			<div class="initiator"><span id="pho_init"></span></div>
			<div><span class="pull_right time" id="time"></span></div>
			<div class="clearfix">
				<div class="pull_left score" style="float:left;">
					<img class="fraction" src="../../img/diary/m/icon_score.png" alt="">
					评分：6.0
				</div>
				<div class="pull_right delete_font" id="delete_font">删除</div>
				<div class="pull_right edit_font" id="edit_font">编辑</div>
			</div>
		</div>

	</div>
	<div class="explain_cen"></div>
	<div class="rece_comment" id="comment_a">点评</div>
	<div class="tab clearfix">
		<a class="pull_left line_tab" id="consult_tab">
			<span class="consult">查阅：<span id="con_num">1</span></span>
		</a>
		<a class="pull_right" id="comment_tab">
			<span class="comment">点评：<span id="com_num">0</span></span>
		</a>
	</div>
	<ul class="mui-table-view list" id="list">
		<!-- <li class="mui-table-view-cell">
            <div class="consult_list">
                <img class="people" src="../../img/diary/m/head.png" alt="">
                <div class="clearfix">
                    <span class="pull_left subject">张扬</span>
                    <span class="pull_right time">2017-11-24 12:13</span>
                </div>
                <div class="initiator_list">市场总监</div>
            </div>
        </li>
		 <li class="mui-table-view-cell">
                <div class="comment_list">
                    <img class="people" src="/images/diary/head.png" alt="">
                    <div class="subject">张扬</div>
                    <div class="initiator_list">市场总监</div>
                    <div class="com_con">对，相对来说不算问题</div>
                    <div class="reply">xx回复：好的</div>
                </div>
                <div class="clearfix">
                    <span class="pull_left time">2017-11-24 12:13</span>
                    <span class="pull_right re_bt">回复</span>
                </div>
            </li> -->
	</ul>

</div>
</body>
<script type="text/javascript">
    var   str1 = '<li class="mui-table-view-cell">'+
			'<div class="consult_list">'+
			'<img class="people" src="../../img/diary/m/head.png" alt="">'+
			'<div class="clearfix">'+
			'<span class="pull_left subject">工作日志</span>'+
			'<span class="pull_right time">2018-3-6</span>'+
			'</div>'+
			'<div class="initiator_list initiator_list_change">管理部</div>'+
			'</div>'+
			' </li>';
    jQuery("#list").html(str1);
    var str2="";
    var str3 = '<li class="mui-table-view-cell">暂无数据</li>';
    function  logdiary(did,tabnum){
//        if(tabnum == 2){
//            $("#comment_tab").addClass("line_tab");
//            $("#consult_tab").removeClass("line_tab");
//        }else{
//            $("#consult_tab").addClass("line_tab");
//            $("#comment_tab").removeClass("line_tab");
//        }
        var data = {
            "diaId":did
        };
        mui.ajax('/diary/getConByDiaId',{
            data:data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
//                str1 = "";
//                str2 = "";
//                var imgs='';
//                if(data.CONTENT!=""){
//                    imgs+="<br>";
//                }
//                if(data.DEL_FLAG == 0){
//                    $("#delete_font").hide();
//                    $(".edit_font").hide();
//                }else{
//                    $("#delete_font").show();
//                    $(".edit_font").show();
//                };
//                for(var i=0;i<data.FILE_INFO.length;i++){
//                    imgs+='<img style="width:30%;height:auto" src="'+data.FILE_INFO[i].view+'">';
//                }
                $("#subject").text(data.object.subject);
                $("#time").text(data.object.diaDate);
                $("#pho_init").text(data.object.userName);
                $(".explain_cen").html('<pre>'+data.object.content+'</pre>');
                $("#com_num").text(data.object.comTotal);
//                if(data.CONSULT_ARR.length > 0){
//                    for(var i=0;i<data.CONSULT_ARR.length;i++){
//                        if(data.CONSULT_ARR[i].AVATAR=="" || data.CONSULT_ARR[i].AVATAR==null){
//                            data.CONSULT_ARR[i].AVATAR="/images/diary/head.png";
//                        }
//                        str1 += '<li class="mui-table-view-cell">'+
//                            '<div class="consult_list">'+
//                            '<img class="people" src="'+data.CONSULT_ARR[i].AVATAR+'" alt="">'+
//                            '<div class="clearfix">'+
//                            '<span class="pull_left subject">'+data.CONSULT_ARR[i].CNAME+'</span>'+
//                            '<span class="pull_right time">'+data.CONSULT_ARR[i].CTIME+'</span>'+
//                            '</div>'+
//                            '<div class="initiator_list initiator_list_change">'+data.CONSULT_ARR[i].CPAME+'</div>'+
//                            '</div>'+
//                            ' </li>'
//                    }
//                };
//                var comment_count=0;
//                var comment_num=0;
//                if(data.COMMENT_ARR.length>0){
//                    comment_num=data.COMMENT_ARR.length;
//                    for(var i=0;i<data.COMMENT_ARR.length;i++){
//                        if(data.COMMENT_ARR[i].AVATAR=="" || data.COMMENT_ARR[i].AVATAR==null){
//                            data.COMMENT_ARR[i].AVATAR="/images/diary/head.png";
//                        }
//                        comment_count=parseInt(comment_count)+parseInt(data.COMMENT_ARR[i].GRADE);
//                        var string="";
//                        for(var y=0;y<data.COMMENT_ARR[i].REPLY_ARR.length;y++){
//                            string += '<div class="reply">'+
//                                '<span class="fs">'+data.COMMENT_ARR[i].REPLY_ARR[y].REPLYER_NAME+'</span>&nbsp;&nbsp;回复&nbsp;&nbsp;'+
//                                '<span>'+data.COMMENT_ARR[i].REPLY_ARR[y].TO_NAME+'</span>：'+
//                                '<span class="reply_bt" style="float:right;color:#5077aa;"  COMMENT_ID="'+data.COMMENT_ARR[i].COMMENT_ID+'"  USER_ID="'+data.COMMENT_ARR[i].REPLY_ARR[y].REPLYER_NAME+'"  onclick= "reply_log($(this))">回复</span>'+
//                                '<div>'+data.COMMENT_ARR[i].REPLY_ARR[y].REPLY_COMMENT+'</div>'+
//                                '</div>'
//                        }
//                        str2 +=  '<li class="mui-table-view-cell" id="'+data.COMMENT_ARR[i].COMMENT_ID+'">'+
//                            '<div class="comment_list">'+
//                            '<img class="people" src="'+data.COMMENT_ARR[i].AVATAR+'" alt="">'+
//                            '<div class="subject">'+data.COMMENT_ARR[i].COMMENT_NAME+'</div>'+
//                            '<div class="initiator_list">'+data.COMMENT_ARR[i].COMMENT_PAME+'</div>'+
//                            '<div class="com_con">'+data.COMMENT_ARR[i].CONTENT+'</div>'+
//                            ''+string+''+
//                            '</div>'+
//                            '<div class="clearfix">'+
//                            '<span class="pull_left time">'+data.COMMENT_ARR[i].SEND_TIME+'</span>'+
//                            '<span class="pull_right re_bt reply_bt" COMMENT_ID="'+data.COMMENT_ARR[i].COMMENT_ID+'"  USER_ID="'+data.COMMENT_ARR[i].USER_ID+'"   onclick= "reply_log($(this))">回复</span>'+
//                            '</div>'+
//                            '<div style="display:none;" class="clearfix box_com">'+
//                            '<textarea class="reply_text" style="margin-top: 10px;" rows="5" placeholder="请输入回复内容" id="Messagetext"></textarea>'+
//                            '<span class="btnReg" onclick= "sub($(this))">提交</span>'+
//                            '</div>'+
//                            ' </li>'
//                    }
//                }
//                var comment_img='<img class="fraction" src="/images/diary/icon_score.png" alt="" />评分：';
//                if(comment_count==0){
//                    $(".score").html(comment_img+"0");
//                }else{
//                    $(".score").html(comment_img+(comment_count/comment_num).toFixed(1));
//                }
//                if(tabnum == 2 && str2 != ""){
//                    jQuery("#list").html(str2)
//                }else if(tabnum == 2 && str2 == ""){
//                    jQuery("#list").html(str3)
//                }else if(tabnum == 1 && str1 != ""){
//                    jQuery("#list").html(str1)
//                }else if(tabnum == 1 && str1 == ""){
//                    jQuery("#list").html(str3)
//                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }


    jQuery(function(){
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        did = GetQueryString("id"); //括号里放地址栏传参变量
        type = GetQueryString("type"); //括号里放地址栏传参变量
        logdiary(did,1);
		/*查阅*/
        mui(".tab").on('tap','#consult_tab',function(){
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            jQuery("#list").html(str1);
        })
        //点评
        mui(".tab").on('tap','#comment_tab',function(){
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            click_comment();
        });
        //点击图片
        mui('.explain_cen').on('click','img',function(){
            // var dataSrc=$(this).attr('src');
            showcasing(this)

        })

        mui(".mui-content").on("tap","#comment_a",function(){
            //打开点评页面
            mui.openWindow({
                id:'/diary/diaryCommenth5',
                url:'/diary/diaryCommenth5?id='+did
            });
        });
		/*编辑*/
        mui(".tit_con").on("tap","#edit_font",function(){
            mui.openWindow({
                id:'/diary/diaryCreateh5',
                url:'/diary/diaryCreateh5?id='+did
            });
        });
        //删除
        mui('.tit_con').on('tap', '#delete_font', function(e) {
            var data = {
                "diaId":did
            };
            mui.ajax('/diary/delete',{
                data:data,
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型
                beforeSend: function() {
                    mui.plusReady(function() {
                        plus.nativeUI.showWaiting('正在加载');
                    })
                },
                complete: function() {
                    mui.plusReady(function() {
                        plus.nativeUI.closeWaiting();
                    });
                },
                success:function(data){
                    alert("删除成功！");
                    mui.back(window.reload);
                },
                error:function(xhr,type,errorThrown){
                    //异常处理；
                    console.log(type);
                }
            });
        });


    })

    function showcasing(me) {
        var str='<div id="allamplification" onclick="clearHtml(this)" style="text-align:center;position: fixed;top: 0;z-index: 199910151;left: 0;right: 0;bottom: 0;background-color:rgba(000,000,000,0.5);">' +
            '<img id="showImg" src="'+$(me).attr('src')+'" style="display: inline-block;" alt="">' +
            '</div>'
        $('body').append(str)

        var bodyWith=$('body').width();
        $('#allamplification').find('img').css('width',bodyWith+'px');
        // alert(bodyWith);
        var imgHeight=$('#showImg').height()/2;
        // $('#showImg').css('margin-top',-imgHeight+'px');
    }
    function clearHtml(me) {
        $(me).remove();
    }
</script>
<script>
    var comment_id="";
    var user_id="";
    function reply_log(e){
        var that = e.parents('li').find(".box_com")
        $(that).toggle();
        comment_id=e.attr("comment_id");
        user_id=e.attr("user_id");
    };
    function sub(e){
        mui.ajax('/diary/insertCommentReply',{
            data:{
                replyComment:e.parents('li').find(".reply_text").val(),
                commentId:comment_id,
                toId:user_id
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                $(".box_com").hide();
                click_comment();
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                //console.log(type);
            }
        });
//			})
    }
    //点评
    function click_comment(){

        var data = {
            "diaId":did
        };
        mui.ajax('/diary/getDiaryCommentByDiaId',{
            data:data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
                if(data.obj.length>0){
                    for(var i=0;i<data.obj.length;i++){
                        var string="";
                        for(var y=0;y<data.obj[i].diaryCommentReplyModelList.length;y++){
                            string += '<div class="reply">'+
                                '<span class="fs">'+data.obj[i].diaryCommentReplyModelList[y].replyerName+'</span>&nbsp;&nbsp;回复&nbsp;&nbsp;'+
                                '<span>'+data.obj[i].diaryCommentReplyModelList[y].toName+'</span>：'+
                                '<span class="reply_bt" style="float:right;color:#5077aa;"  COMMENT_ID="'+data.obj[i].commentId+'" replyId="'+data.obj[i].diaryCommentReplyModelList[y].replyId+'"   USER_ID="'+data.obj[i].diaryCommentReplyModelList[y].commentId+'"  onclick= "reply_log($(this))">回复</span>'+
                                '<div>'+data.obj[i].diaryCommentReplyModelList[y].replyComment+'</div>'+
                                '</div>'
                        }
                        str2 +=  '<li class="mui-table-view-cell" id="'+data.obj[i].commentId+'">'+
                            '<div class="comment_list">'+
                            '<img class="people" src="../../img/diary/m/head.png" alt="">'+
                            '<div class="subject">'+data.obj[i].userName+'</div>'+
                            '<div class="initiator_list">'+data.obj[i].userId+'</div>'+
                            '<div class="com_con">'+data.obj[i].content+'</div>'+
                            ''+string+''+
                            '</div>'+
                            '<div class="clearfix">'+
                            '<span class="pull_left time">'+data.obj[i].sendTime+'</span>'+
                            '<span class="pull_right re_bt reply_bt" COMMENT_ID="'+data.obj[i].commentId+'"  USER_ID="'+data.obj[i].userId+'" replyId=""   onclick= "reply_log($(this))">回复</span>'+
                            '</div>'+
                            '<div style="display:none;" class="clearfix box_com">'+
                            '<textarea class="reply_text" style="margin-top: 10px;" rows="5" placeholder="请输入回复内容" id="Messagetext"></textarea>'+
                            '<span class="btnReg" onclick= "sub($(this))">提交</span>'+
                            '</div>'+
                            ' </li>';
                        jQuery("#list").html(str2);
                    }
                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }


</script>
</html>
