<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/4/12
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图纸App</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
</head>
<body>
<div style="position: relative">
    <img id="photoimg" width="100%" style="z-index: -1">
    <div id="dv" style="border-radius:50%;width: 20px;height: 20px;background-color: #00FFFF;z-index: 10000;display: none"></div>
</div>

<script>
    function getUrlParam(name) {
        //构造一个含有目标参数的正则表达式对象
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        //匹配目标参数
        var r = window.location.search.substr(1).match(reg);
        //返回参数值
        if (r != null) return unescape(r[2]); return null;
    }
    var securityContentId=getUrlParam("securityContentId");

    initsecurityContent(securityContentId)
    function initsecurityContent(securityContentId) {
        $.ajax({
            url:"/workflow/secirityManager/getDetailsInfoById",
            data:{detailsInfoId:securityContentId},
            dataType:"json",
            type:"post",
            success:function (res) {
                var photourls="/xs?"+res.obj.urls+""
                alert(photourls)
                $("#photoimg").attr("src",photourls)

            }
        })
    }
    var pos=function(o,event){
        var poX=0,poY=0;
        var e=event||window.event;
        if (e.offsetX||e.offsetY){
            poX=e.offsetX;
            poY=e.offsetY;
        }else{
            alert("浏览器不兼容")
        }
        o.style.position = "absolute";
        o.style.left=(poX-10)+"px";
        o.style.top=(poY-10)+"px";
    }

$("#photoimg").click(function(){
    debugger
    $("#dv").css("display","block");
    var dv=document.getElementById("dv");
    pos(dv,event);
})
</script>
</body>
</html>
