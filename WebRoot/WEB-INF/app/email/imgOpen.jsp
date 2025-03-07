<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2021/2/19
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="chat.th.photo" /></title>
    <link rel="stylesheet" href="/ui/css/email/m/viewer.min.css">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
<%--    <script src="/ui/js/email/viewer.min.js"></script>--%>
    <script src="/ui/js/email/viewer.js?20210315"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
</head>
<style>
    .imgUl img{
        width: 100px;
        height: 100px;
        margin: 10px;
    }
    .imgUl,.imgUl2{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        flex-wrap: wrap;
        width: 80%;
        margin: 0 auto;
    }
    .imgUl2 img{
        width: 200px;
        height: auto;
    }
    /*div[role="button"]{*/
    /*    display: none;*/
    /*}*/

    .viewer-container,.viewer-navbar{background-color:#000;overflow:hidden}.viewer-canvas,.viewer-container,.viewer-footer,.viewer-player{right:0;bottom:0;left:0}.viewer-button,.viewer-canvas,.viewer-container,.viewer-footer,.viewer-list,.viewer-navbar,.viewer-open,.viewer-title,.viewer-toolbar,.viewer-toolbar>li{overflow:hidden}.viewer-close:before,.viewer-flip-horizontal:before,.viewer-flip-vertical:before,.viewer-fullscreen-exit:before,.viewer-fullscreen:before,.viewer-next:before,.viewer-one-to-one:before,.viewer-play:before,.viewer-prev:before,.viewer-reset:before,.viewer-rotate-left:before,.viewer-rotate-right:before,.viewer-zoom-in:before,.viewer-zoom-out:before{font-size:0;line-height:0;display:block;width:20px;height:20px;color:transparent;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARgAAAAUCAYAAABWOyJDAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAQPSURBVHic7Zs/iFxVFMa/0U2UaJGksUgnIVhYxVhpjDbZCBmLdAYECxsRFBTUamcXUiSNncgKQbSxsxH8gzAP3FU2jY0kKKJNiiiIghFlccnP4p3nPCdv3p9778vsLOcHB2bfveeb7955c3jvvNkBIMdxnD64a94GHMfZu3iBcRynN7zAOI7TG15gHCeeNUkr8zaxG2lbYDYsdgMbktBsP03jdQwljSXdtBhLOmtjowC9Mg9L+knSlcD8TNKpSA9lBpK2JF2VdDSR5n5J64m0qli399hNFMUlpshQii5jbXTbHGviB0nLNeNDSd9VO4A2UdB2fp+x0eCnaXxWXGA2X0au/3HgN9P4LFCjIANOJdrLr0zzZ+BEpNYDwKbpnQMeAw4m8HjQtM6Z9qa917zPQwFr3M5KgA6J5rTJCdFZJj9/lyvGhsDvwFNVuV2MhhjrK6b9bFiE+j1r87eBl4HDwCF7/U/k+ofAX5b/EXBv5JoLMuILzf3Ap6Z3EzgdqHMCuF7hcQf4HDgeoHnccncqdK/TvSDWffFXI/exICY/xZyqc6XLWF1UFZna4gJ7q8BsRvgd2/xXpo6P+D9dfT7PpECtA3cnWPM0GXGFZh/wgWltA+cDNC7X+AP4GzjZQe+k5dRxuYPeiuXU7e1qwLpDz7dFjXKRaSwuMLvAlG8zZlG+YmiK1HoFqT7wP2z+4Q45TfEGcMt01xLoNZEBTwRqD4BLpnMLeC1A41UmVxsXgXeBayV/Wx20rpTyrpnWRft7p6O/FdqzGrDukPNtkaMoMo3FBdBSQMOnYBCReyf05s126fU9ytfX98+mY54Kxnp7S9K3kj6U9KYdG0h6UdLbkh7poFXMfUnSOyVvL0h6VtIXHbS6nOP+s/Zm9mvyXW1uuC9ohZ72E9uDmXWLJOB1GxsH+DxPftsB8B6wlGDN02TAkxG6+4D3TWsbeC5CS8CDFce+AW500LhhOW2020TRjK3b21HEmgti9m0RonxbdMZeVzV+/4tF3cBpP7E9mKHNL5q8h5g0eYsCMQz0epq8gQrwMXAgcs0FGXGFRcB9wCemF9PkbYqM/Bas7fxLwNeJPdTdpo4itQti8lPMqTpXuozVRVXPpbHI3KkNTB1NfkL81j2mvhDp91HgV9MKuRIqrykj3WPq4rHyL+axj8/qGPmTqi6F9YDlHOvJU6oYcTsh/TYSzWmTE6JT19CtLTJt32D6CmHe0eQn1O8z5AXgT4sx4Vcu0/EQecMydB8z0hUWkTd2t4CrwNEePqMBcAR4mrBbwyXLPWJa8zrXmmLEhNBmfpkuY2102xxrih+pb+ieAb6vGhuA97UcJ5KR8gZ77K+99xxeYBzH6Q3/Z0fHcXrDC4zjOL3hBcZxnN74F+zlvXFWXF9PAAAAAElFTkSuQmCC);background-repeat:no-repeat}.viewer-zoom-in:before{content:'Zoom In';background-position:0 0}.viewer-zoom-out:before{content:'Zoom Out';background-position:-20px 0}.viewer-one-to-one:before{content:'One to One';background-position:-40px 0}.viewer-reset:before{content:'Reset';background-position:-60px 0}.viewer-prev:before{content:'Previous';background-position:-80px 0}.viewer-play:before{content:'Play';background-position:-100px 0}.viewer-next:before{content:'Next';background-position:-120px 0}.viewer-rotate-left:before{content:'Rotate Left';background-position:-140px 0}.viewer-rotate-right:before{content:'Rotate Right';background-position:-160px 0}.viewer-flip-horizontal:before{content:'Flip Horizontal';background-position:-180px 0}.viewer-flip-vertical:before{content:'Flip Vertical';background-position:-200px 0}.viewer-fullscreen:before{content:'Enter Full Screen';background-position:-220px 0}.viewer-fullscreen-exit:before{content:'Exit Full Screen';background-position:-240px 0}.viewer-close:before{content:'Close';background-position:-260px 0}.viewer-container{font-size:0;line-height:0;position:absolute;top:0;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;background-color:rgba(0,0,0,.5);direction:ltr!important;-ms-touch-action:none;touch-action:none;-webkit-tap-highlight-color:transparent;-webkit-touch-callout:none}.viewer-container ::-moz-selection,.viewer-container::-moz-selection{background-color:transparent}.viewer-container ::selection,.viewer-container::selection{background-color:transparent}.viewer-container img{display:block;width:100%;min-width:0!important;max-width:none!important;height:auto;min-height:0!important;max-height:none!important}.viewer-player,.viewer-tooltip{display:none;position:absolute}.viewer-canvas{position:absolute;top:0}.viewer-canvas>img{width:auto;max-width:90%!important;height:auto;margin:15px auto}.viewer-footer{position:absolute;text-align:center}.viewer-navbar{background-color:rgba(0,0,0,.5)}.viewer-list{-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;height:50px;margin:0;padding:1px 0}.viewer-list>li{font-size:0;line-height:0;float:left;overflow:hidden;width:30px;height:50px;cursor:pointer;opacity:.5;color:transparent;filter:alpha(opacity=50)}.viewer-list>li+li{margin-left:1px}.viewer-list>.viewer-active{opacity:1;filter:alpha(opacity=100)}.viewer-player{top:0;cursor:none;background-color:#000}.viewer-player>img{position:absolute;top:0;left:0}.viewer-toolbar{width:280px;margin:0 auto 5px;padding:3px 0}.viewer-toolbar>li{float:left;width:24px;height:24px;cursor:pointer;border-radius:50%;background-color:#000;background-color:rgba(0,0,0,.5)}.viewer-toolbar>li:hover{background-color:#000;background-color:rgba(0,0,0,.8)}.viewer-toolbar>li:before{margin:2px}.viewer-toolbar>li+li{margin-left:1px}.viewer-toolbar>.viewer-play{width:30px;height:30px;margin-top:-3px;margin-bottom:-3px}.viewer-toolbar>.viewer-play:before{margin:5px}.viewer-tooltip{font-size:12px;line-height:20px;top:50%;left:50%;width:50px;height:20px;margin-top:-10px;margin-left:-25px;text-align:center;color:#fff;border-radius:10px;background-color:#000;background-color:rgba(0,0,0,.8)}.viewer-title{font-size:12px;line-height:1;display:inline-block;max-width:90%;margin:0 5% 5px;white-space:nowrap;text-overflow:ellipsis;opacity:.8;color:#ccc;filter:alpha(opacity=80)}.viewer-title:hover{opacity:1;filter:alpha(opacity=100)}.viewer-button{position:absolute;top:-40px;right:-40px;width:80px;height:80px;cursor:pointer;border-radius:50%;background-color:#000;background-color:rgba(0,0,0,.5)}.viewer-button:before{position:absolute;bottom:15px;left:15px}.viewer-fixed{position:fixed}.viewer-show{display:block}.viewer-hide{display:none}.viewer-invisible{visibility:hidden}.viewer-move{cursor:move;cursor:-webkit-grab;cursor:-moz-grab;cursor:grab}.viewer-fade{opacity:0;filter:alpha(opacity=0)}.viewer-in{opacity:1;filter:alpha(opacity=100)}.viewer-transition{-webkit-transition:all .3s ease-out;-o-transition:all .3s ease-out;transition:all .3s ease-out}@media (max-width:767px){.viewer-hide-xs-down{display:none}}@media (max-width:991px){.viewer-hide-sm-down{display:none}}@media (max-width:1199px){.viewer-hide-md-down{display:none}}
    /*.viewer-container img{*/
    /*    width: 30px !important;*/
    /*    height: 30px !important;*/
    /*    transform: translateX(0px) !important;*/
    /*}*/
</style>
<body>
    <div class="content">
        <p class="imgUl" id="dowebok" style="">

        </p>
<%--        <p class="imgUl2" id="dowebok2" >--%>
<%--            <img class="LookImg" src="" alt="">--%>
<%--        </p>--%>
    </div>
</body>
</html>
<script>

    $(function () {
        getvalue()

    });
    function isIE() { //ie?
        if (!!window.ActiveXObject || "ActiveXObject" in window){
            return  true
        } else
            return false
    }
    function getvalue() {
        //获取父级数据
        var pare=window.opener;
        if(pare!=null)
        {
            var what=pare.document.getElementById("getIndex");

            var openNmu = what.getAttribute('opennum')
            if(what!=null)
            {
                whatFun(what.value,openNmu)
            }
        }
    }
    function whatFun(str,openNmu){
        var thisa = str

        var openNmu = $.GetRequest().openNmu;
        var title = ''
        if(thisa != ''){
            var thisaArr = thisa.split('*')
            var str = ''
            for(var i=0;i<thisaArr.length-1;i++){
                if(isIE()){
                    var img0 = thisaArr[i].split('ATTACHMENT_NAME=')[0]+'ATTACHMENT_NAME='
                    str+='<img id="clickImg'+i+'" src="'+img0+'" openNmu="'+openNmu+'">'
                }else {
                    var img0 = thisaArr[i].split('ATTACHMENT_NAME=')[0]
                    str+='<img id="clickImg'+i+'" src="'+thisaArr[i]+'" openNmu="'+openNmu+'">'
                }

            }
            title = thisaArr[openNmu].split('ATTACHMENT_NAME=')[1]
            if(title.indexOf('&') > -1){
                title = thisaArr[openNmu].split('ATTACHMENT_NAME=')[1].split('&')[0]
            }
            document.title = '<fmt:message code="email.th.picturePreview" /> - '+title;
            $('.imgUl').html(str)
        }
        $('.LookImg').attr('src',thisaArr[openNmu])
        var oDiv = document.getElementById('clickImg'+openNmu);   //获取bai元素div

        oDiv.onclick = function(){   //给元素增加点击事件
            $('#dowebok').viewer();
        };
        document.getElementById('clickImg'+openNmu).click();

        $('#dowebok2').viewer();
        oDiv.click();
        $('.viewer-zoom-in').attr('title','<fmt:message code="email.th.zoomIn" />')
        $('.viewer-zoom-out').attr('title','<fmt:message code="email.th.zoomOut" />')
        $('.viewer-one-to-one').attr('title','100%')
        $('.viewer-reset').attr('title','<fmt:message code="email.th.restore" />')
        $('.viewer-prev').attr('title','<fmt:message code="email.th.previous" />')
        $('.viewer-large').attr('title','<fmt:message code="email.th.fullScreen" />')
        $('.viewer-next').attr('title','<fmt:message code="email.th.next" />')
        $('.viewer-rotate-left').attr('title','<fmt:message code="email.th.rotateCounterclockwise" />90°')
        $('.viewer-rotate-right').attr('title','<fmt:message code="email.th.rotateClockwise" />90°')
        $('.viewer-flip-horizontal').attr('title','<fmt:message code="email.th.flipHorizontally" />')
        $('.viewer-flip-vertical').attr('title','<fmt:message code="email.th.flipVertically" />')
        $('.viewer-next').on('click',function(){
            title1()
        })
        $('.viewer-prev').on('click',function(){
            title2()
        })
        $('#dowebok img').on('click',function(){
            var thiss = $(this)
            var thissStr = thiss.attr('src').split('ATTACHMENT_NAME=')[1]
            //动态改变title
            document.title = '<fmt:message code="email.th.imageViewer" />-'+thissStr;

        })

    }
    // whatFun()
    //下一张
    function title1() {
        var titleStr = $('.viewer-canvas img').attr('src')
        var dialogueDiv = $('.imgUl img')
        for(var k=0;k<dialogueDiv.length;k++){
            if($('.imgUl img').eq(k).attr('src') == titleStr){
               if(k == dialogueDiv.length - 1){
                    var titleStr0 =decodeURI($('.imgUl img').eq(0).attr('src').split('ATTACHMENT_NAME=')[1])
                     titleStr0 =decodeURI($('.imgUl img').eq(0).attr('src').split('ATTACHMENT_NAME=')[1]).split('&')[0]
                }else {
                    var titleStr0 =decodeURI($('.imgUl img').eq(k).next().attr('src').split('ATTACHMENT_NAME=')[1])
                     titleStr0 =decodeURI($('.imgUl img').eq(k).next().attr('src').split('ATTACHMENT_NAME=')[1]).split('&')[0]
                }
            }
        }
        //动态改变title
        document.title = '<fmt:message code="email.th.imageViewer" />-'+titleStr0;
    }
    function title11() {
        var titleStr = $('.viewer-canvas img').attr('src')
        var dialogueDiv = $('.imgUl img')
        var titleStr1 = ''
        for(var v=0;v<dialogueDiv.length;v++){
            if($('.imgUl img').eq(v).attr('src') == titleStr){
                titleStr1 =decodeURI($('.imgUl img').eq(v).attr('src').split('ATTACHMENT_NAME=')[1])
                titleStr1 =decodeURI($('.imgUl img').eq(v).attr('src').split('ATTACHMENT_NAME=')[1]).split('&')[0]
            }
        }


       return titleStr1
    }
    //上一张
    function title2() {
        var titleStr = $('.viewer-canvas img').attr('src')
        var dialogueDiv = $('.imgUl img')
        for(var k=0;k<dialogueDiv.length;k++){
            if($('.imgUl img').eq(k).attr('src') == titleStr){


                if(k == 0){
                    var titleStr0 =decodeURI($('.imgUl img').eq(dialogueDiv.length-1).attr('src').split('ATTACHMENT_NAME=')[1])
                    titleStr0 = decodeURI($('.imgUl img').eq(dialogueDiv.length-1).attr('src').split('ATTACHMENT_NAME=')[1]).split('&')[0]
                }else {
                    var titleStr0 =decodeURI($('.imgUl img').eq(k).prev().attr('src').split('ATTACHMENT_NAME=')[1])
                     titleStr0 =decodeURI($('.imgUl img').eq(k).prev().attr('src').split('ATTACHMENT_NAME=')[1]).split('&')[0]
                }
            }

        }
        document.title = '<fmt:message code="email.th.imageViewer" />-'+titleStr0;

    }


</script>
