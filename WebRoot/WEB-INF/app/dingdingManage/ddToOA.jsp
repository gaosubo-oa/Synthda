<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>

<html lang="en" class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <title>钉钉设置</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <script type="text/javascript" >
            var MYOA_JS_SERVER = "";
            var MYOA_STATIC_SERVER = "";
        </script>
        <link rel="stylesheet" href="/css/base/base.css?20201106.1">
        <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    </head>
<body>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>

<style>

    body,html{
        font: 14px "微软雅黑";
        height: 100%;
    }
    body a{
        color:#3b474d;
    }
    i{ font-style:normal;font-weight: bold;float: right;}
    li:hover i{
        color: #00a0e9;
    }
    .container{
        margin: 0;
    }
    #homepage{
        padding: 0;
        width: 100%;
    }
    li{
       background-color:  #f5f7f8;

    }
    a img{
        float: right;
        margin-top: 8px;
    }
    .row{
        height: 100%;
    }
    ul li{
        font-size: 13pt;
        line-height: 28px;
    }

</style>
<div style="margin-top:46px;">

    <div style="margin: 10px">
        <button id="all_btn" >一键同步钉钉部门和用户到OA系统</button><span style="color:red"  id="all_span"></span>
    </div>

    <div style="margin: 10px">
        <button id="dept_btn" >单独同步钉钉部门到OA</button><span style="color:red"  id="dept_span"></span>
    </div>

    <div style="margin: 10px">
        <button id="user_btn" >单独同步钉钉用户到OA</button><span style="color:red" id="user_span"></span>
    </div>

    <div style="margin: 10px">
        <button id="syn_user_btn" >批量同步绑定钉钉用户</button><span style="color:red" id="syn_user_span"></span>
    </div>
</div>
<div style="margin-top: 10px">
    <p>注意：</p>
    <p>1.初次同步可以直接使用一键同步，系统会自动同步部门到OA系统后再同步用户数据。</p>
    <p>2.单独同步部门为只把部门最新数据同步到OA系统中。</p>
    <p>3.单独同步用户为只把用户同步到OA系统中，请在单独同步用户到时候，确保OA中的部门数据是最新的，即OA部门架构和钉钉中一致。如果不一致系统会自动同步部门后再同步用户。</p>
    <p>4.上面三个同步都为增量同步，即不会删除数据。【删除数据风险较高】</p>
    <p>5.批量同步绑定功能判断用户是根据手机号进行判断匹配的。请确保手机号一致</p>
</div>
</body>
<script type="text/javascript">
    $(function(){

        $('#all_btn').click(function(){
            $.ajax({
                url: '/dingding/dingdingUserToOA',
                type: 'post',
                data:{
                    synType:1
                },
                dataType: 'json',
                success: function (res) {
                    if(res){
                        $('#all_span').html("同步成功!");
                        $('#all_span').css("color","green")
                    } else {
                        $('#all_span').html("同步失败!");
                    }
                }
            })
        })

        $('#dept_btn').click(function(){
            $.ajax({
                url: '/dingding/dingdingUserToOA',
                type: 'post',
                data:{
                    synType:2
                },
                dataType: 'json',
                success: function (res) {
                    if(res){
                        $('#dept_span').html("同步成功!");
                        $('#all_span').css("color","green")
                    } else {
                        $('#dept_span').html("同步失败!");
                    }
                }
            })
        });

        $('#user_btn').click(function(){
            $.ajax({
                url: '/dingding/dingdingUserToOA',
                type: 'post',
                data:{
                    synType:1
                },
                dataType: 'json',
                success: function (res) {
                    if(res){
                        $('#user_span').html("同步成功!");
                        $('#all_span').css("color","green")
                    } else {
                        $('#user_span').html("同步失败!");
                    }
                }
            })
        })

        $('#syn_user_btn').click(function(){
            $.ajax({
                url: '/dingding/batchBind',
                type: 'post',
                dataType: 'json',
                success: function (res) {
                    if(res.flag){
                        $('#syn_user_span').html("同步成功!");
                        $('#syn_user_span').css("color","green")
                    } else {
                        $('#syn_user_span').html("同步失败!");
                    }
                }
            })
        })
    });
</script>
</html>