<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String notifyId = request.getParameter("notifyId");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title><fmt:message code="news.th.newsDetail" /></title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
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
            z-index: 99999;
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
            width:100% !important;
            height:100% !important;
        }
    </style>
</head>
<body>
<header>
    <i><a href="/news/newsh5" style="color: #fff"><fmt:message code="license.return" /></a></i>
    <span><fmt:message code="news.th.newsDetail" /></span>
    <i style="width: .4rem"></i>
</header>
<div class="hd"></div>
<div class="content">
</div>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    var notifyId = <%=notifyId%>;
    $(function(){
        $.ajax({
            url:'/news/getOneById',
            type:'get',
            data:{
                newsId:notifyId
            },
            dataType:'json',
            success:function(res){
                if(res.flag){
                    var app='<div>'+
                        '<h2 class="cont"  style="width: 85%;">'+res.object.subject+'</h2>'+
                        '<div class="cont">'+
                        '<span class="fs14" style="margin-right:34px ;"><fmt:message code="notice.th.publisher" />：'+res.object.providerName+'</span>'+
                        '<span class="fs14"><fmt:message code="notice.th.type" />：<a href="javascript:;" style="color: #5087d0">'+function(){if(res.object.typeName==''){return '<fmt:message code="news.th.none" />'}else{return  res.object.typeName}}()+'</a></span>'+
                        '</div>'+
                        '<div class="cons">'+res.object.newsDateTime+'</div>'+
                        '</div>'+
                        '<div class="conts" style="line-height: .6rem">'+res.object.content+'</div>'+
                        '<div>'+
                        '<p class="enclosure"><fmt:message code="email.th.file" /></p>'+
                        '<div class="conts">' +
//                        ''+function(){if(res.object.attachmentName==''){return '暂无附件'}else
//                            {
//                                var str = res.object.attachmentName
//                                var strs = []
//                                strs = str.split("*");
//                                var app = ''
//                                var str1=res.object.attachmentId
//                                var str2=[]
//                                str2=str1.split(",")
//                                strs.pop()
//                                $.each(strs,function (index,item) {
//                                    app += '<span style="width: 4.6rem;display: inline-block;line-height: .65rem;">' +item + '</span>'+
//                                        '<a style="margin-left: .8rem;color: #5087d0;" href="/download" atm=' +str2[index] + '>下载</a>'
//                                })
//                                return app
//                            }}()+''
//                    ' </div>'+
//                    '</div>'
                        ''+function(){
                            if(res.object.attachmentName==''){
                                return '<fmt:message code="main.th.Enclosure" />'
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
                            }}()+''
                    '</div>'+
                    '</div>'
                    $('.content').html(app)
                }

            }
        })
    })
</script>
</html>