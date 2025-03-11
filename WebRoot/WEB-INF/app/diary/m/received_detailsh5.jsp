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
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>工作日志</title>
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
				<span class="pull_left subject" id="subject"  @click="click_reply()"></span>
			</div>
			<div class="initiator" id="pho_init"></div>
			<div><span class="pull_right time" id="time"></span></div>
			<div class="clearfix">
				<div class="pull_left score">
					<img class="fraction" src="../../img/diary/m/icon_score.png" alt="">
					评分：6.0
				</div>
				<div class="pull_right edit_font" id="subordinate">查看TA的下属</div>
			</div>
		</div>
	</div>
	<div class="explain_cen"></div>
	<div class="rece_comment" id="comment_a">点评</div>
	<div class="tab clearfix">
		<a class="pull_left line_tab" id="consult_tab">
			<span class="consult">查阅：<span id="con_num">0</span></span>
		</a>
		<a class="pull_right" id="comment_tab">
			<span class="comment">点评：<span id="com_num">0</span></span>
		</a>
	</div>
	<ul class="mui-table-view list" id="list" style="padding-bottom:50px;">
		<!--<li class="mui-table-view-cell">
            <div class="consult_list">
                <img class="people" src="/images/diary/head.png" alt="">
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
        </li>-->
	</ul>
</div>
<nav class="mui-bar mui-bar-tab ">
	<a class="mui-tab-item" href="#">
		<div class="box_bt" id="up">
			上一篇
		</div>
	</a>
	<a class="mui-tab-item" href="javascript:;" @click="jump_create">
		<div class="box_bt log" id="down">
			下一篇
		</div>
	</a>
</nav>
<div id="modal" class="mui-modal">
	<header class="mui-bar mui-bar-nav" id="header2">
		<a class="mui-icon mui-icon-close mui-pull-left" href="#modal" style="color: #fff;"></a>
		<h1 class="mui-title">回复</h1>
		<a class="mui-btn-link mui-pull-right" id="re_mail" style="color: #fff;">发送</a>
	</header>
	<div class="mui-content" style="height: 100%;">
		<textarea style="margin-top: 10px;" rows="5" placeholder="请输入回复内容" id="Messagetext"></textarea>
	</div>
</div>
</body>
<script type="text/javascript">
    var str1="";
    var str2="";
    var str3 = '<li class="mui-table-view-cell">暂无数据</li>';
    function  logdiary(did,tabnum){
        // console.log(did);
        if(tabnum == 2){
            $("#comment_tab").addClass("line_tab");
            $("#consult_tab").removeClass("line_tab");
        }else{
            $("#consult_tab").addClass("line_tab");
            $("#comment_tab").removeClass("line_tab");
        }
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
                $("#subject").text(data.object.subject);
                $("#time").text(data.object.diaDate);
                $("#pho_init").text(data.object.userName);
                $(".explain_cen").html('<pre>'+data.object.content+'</pre>');
                $("#com_num").text(data.object.comTotal);
//                str1 = "";
//                str2 = "";
//                var imgs='';
//                if(data.CONTENT!=""){
//                    imgs+="<br>";
//                }
//                for(var i=0;i<data.FILE_INFO.length;i++){
//                    imgs+='<img style="width:30%;height:auto" src="'+data.FILE_INFO[i].view+'">';
//                }
//                $("#subject").text(data.SUBJECT);
//                $("#time").text(data.DIA_DATE);
//                $("#pho_init").text(data.USER_DEPT);
//                $(".explain_cen").html(data.CONTENT+imgs);
//                $("#con_num").text(data.CONSULT);
//                $("#com_num").text(data.COMMENT);
//                var USER_ID=data.USER_ID;
//                $("#subordinate").attr("USER_ID",USER_ID);
//                var STATE=data.STATE;
//                $("#subordinate").attr("STATE",STATE);
//                $(".portrait").attr("src",data.AVATAR);
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
//                            '<div class="initiator_list">'+data.CONSULT_ARR[i].CPAME+'</div>'+
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
//
//                var comment_img='<img class="fraction" src="/images/diary/icon_score.png" alt="" />评分：';
//                if(comment_count==0){
//                    $(".score").html(comment_img+"0");
//                }else{
//                    $(".score").html(comment_img+(comment_count/comment_num).toFixed(1));
//                }
//
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
        if(type == "share"){
            $("#subordinate").hide();
        }
        logdiary(did,1);
		/*查阅*/
        mui(".tab").on('tap','#consult_tab',function(){
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            if(str1 != ""){
                jQuery("#list").html(str1);
            }else{
                jQuery("#list").html(str3);
            }
        })
        //点评
        mui(".tab").on('tap','#comment_tab',function(){
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            if(str2 != ""){
                jQuery("#list").html(str2);
            }else{
                jQuery("#list").html(str3);
            }


        });
        mui(".mui-content").on("tap","#comment_a",function(){
            //打开点评页面
            mui.openWindow({
                id:'/diary/diaryCommenth5',
                url:'/diary/diaryCommenth5?id='+did
            });
        });
        mui(".mui-content").on("tap","#subordinate",function(){
            var user_id = this.getAttribute("USER_ID");
            var STATE = this.getAttribute("STATE");
            if(STATE=="error"){
                alert("没有直属下属!")
            }else{
                mui.openWindow({
                    id:'ireceived.php',
                    url:'ireceived.php?user_id='+user_id
                });

            }
        });
        //点击图片
        mui('.explain_cen').on('click','img',function(){
            // var dataSrc=$(this).attr('src');
            showcasing(this)

        })
        //上一篇
        mui("nav").on('tap','#up',function(){
            var data = {
                "flag":9, //查看路径
                "DIA_ID":did,
                "ptype":"A",
                "TYPE":type


            };
            mui.ajax('data/data.php',{
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
                    did=data.dia_id;
                    logdiary(did,1);
                },
                error:function(xhr,type,errorThrown){
                    //异常处理；
                    console.log(type);
                }
            });
        });
        //下一篇
        mui("nav").on('tap','#down',function(){
            var data = {
                "flag":9, //查看路径
                "DIA_ID":did,
                "ptype":"B",
                "TYPE":type

            };
            mui.ajax('data/data.php',{
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
                    did=data.dia_id;
                    logdiary(did,1);
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
        $(that).show();
        comment_id=e.attr("comment_id");
        user_id=e.attr("user_id");
    };
    function sub(e){
        mui.ajax('data/data.php',{
            data:{
                flag:8,
                COMMENT_ID:comment_id,
                CONTENT:e.parents('li').find(".reply_text").val(),
                TO_ID:user_id
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                if(data.state=='ok'){
                    $(".box_com").hide();
                    logdiary(did,2);
//							plus.nativeUI.toast('回复成功！','500') ;
//							mui.back();
                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                //console.log(type);
            }
        });
//			})
    }


</script>
</html>
