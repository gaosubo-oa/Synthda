<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String newsId = request.getParameter("newsId");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>新闻详情</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        header {
            height: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.32rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            position: fixed;
            width: 100%;
            z-index: 9999;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        .fs14{
            font-size: 0.33rem;
            color: #646464;
        }
        .cont{
            margin: 0 .4rem;
            margin-top: .32rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .cons{
            margin: 0 .4rem;
            border-bottom: 1px solid #5a8fd5;
            color: #c6c6c6;
            font-size: .32rem;
            line-height: 1rem;
        }
        .conts{
            margin: 0 .4rem;
            margin-top: .32rem;
            padding-bottom:  .32rem;
            font-size: .34rem;
            /*overflow: hidden;*/
        }
        .enclosure{
            height: .7rem;
            background: #eeeeee;
            line-height: .7rem;
            text-indent: 1em;
        }
        .hd{
            height: 0.85rem;
        }
        .conts img{
            max-width:100%;

        }
    </style>
</head>
<body>

<div class="content">

</div>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    var newsId = <%=newsId%>;
    $(function(){
        $.ajax({
            url:'/news/getOneById',
            type:'get',
            data:{
                newsId:newsId
            },
            dataType:'json',
            success:function(res){

                if(res.flag){
                    var app='<div>'+
                        '<h2 class="cont" style="width: 85%;">'+res.object.subject+'</h2>'+
                        '<div class="cont">'+
                        '<span class="fs14" style="margin-right:34px ;">发布人：'+res.object.providerName+'</span>'+
                        '<span class="fs14">类型：<a href="javascript:;" style="color: #5087d0">'+function(){if(res.object.typeName==''){return '所有类型'}else{return  res.object.typeName}}()+'</a></span>'+
                        '</div>'+
                        '<div class="cons">'+res.object.newsDateTime+'</div>'+
                        '</div>'+
                        '<div class="conts" style="line-height: .6rem">'+res.object.content+'</div>'+

                        '<p class="enclosure">附件</p>'+
                        '<div class="conts">'+
                        function(){
                            if(res.object.attachmentName==''){
                                return '暂无附件'
                            }else {
                                var arr = new Array();
                                arr = res.object.attachment
                                if (res.attachmentName != '') {
                                    var src=''
                                    for (var i = 0; i < (arr.length); i++) {
                                        src += '<p style="margin-bottom: 10px;"><a style="color: black;cursor: auto;"  href="javascript:;"><img style="display:inline-block;position: relative;top: 4px;right: 7px;" src="../img/enclosure.png"/><span style="width: 73%;display: inline-block;">' + arr[i].attachName + '</span></a>' +
                                            '<a style="color:#3984ff" href="/download?' + encodeURI(arr[i].attUrl) + '" style="margin-left:10px;"><fmt:message code="file.th.download" /></a></p>';
                                    }
                                }
                                return src
                            }}()
                    '</div>'+
                    '</div>'
                    $('.content').html(app)
                }

            }
        })
    })
</script>
</html>