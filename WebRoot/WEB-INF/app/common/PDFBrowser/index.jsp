<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2021/1/5
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PDF在线预览</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js" ></script>
    <script type="text/javascript" src="/js/base/base.js" ></script>
</head>
<body>
<span class="subText" style="font-family: Microsoft yahei; font-weight: bolder; font-size: 12pt; color:red; display: none;">机密级★</span>
<div class="grid-content bg-purple" style="height: 100%">
    <iframe  width="100%" height="100%" id="the-canvas" style="border:1px solid black;width:100%;"></iframe>
</div>
<script>
    //判断页面是否需要显示机密级字样
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 1) {
                $(".subText").show()
            }else {
                $(".subText").hide()
            }
        }
    })
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        document.getElementById("the-canvas").style.height= winHeight - 25 +"px";
        //document.getElementById("officialDocument").style.height= winHeight - 98 +"px";
    };
    function test(){
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串,判断是否是pc客户端打开的qt浏览器
        if(location.href.indexOf('diskId') > -1&&location.href.indexOf('path') > -1){
            var path = $("#pathName",window.opener.document).val()||'';
            path = 'path='+ encodeURIComponent(path);
            var diskId = $.GetRequest().diskId||'';
            var pathbase = location.search.split('&pathbase=')[1]||'';
            $.get('/netdisk/selectNetdiskBySearch',{
                path:pathbase,
                diskId:diskId
            },function(json){
                if(json.flag){
                    var name = '';
                    if(json.object&&json.object.list.length != 0){
                        name = json.object.list[0].neName||'';
                    }
                    if(name != ''){
                        $('title').text('PDF 文档预览 - '+name);
                    }else{
                        $('title').text('PDF 文档预览');
                    }
                }
                var pdfurl = location.origin+'/netdisk/download?'+ path +'&diskId='+diskId+'&type=preview';
                if(location.href.indexOf('&downloadpriv') > -1){
                    pdfurl += '&downloadpriv'
                }
                var url ='/lib/pdfjs/web/viewer.html?file='+encodeURIComponent(pdfurl);
                if(userAgent.indexOf('QtWebEngine') > -1){
                    url = '/netdisk/xs?'+ path +'&diskId='+diskId+'&type=preview';
                }
                var userAgent = navigator.userAgent;
                if(userAgent.indexOf('QtWebEngine') > -1){
                   location.href = url;
                   return ;
                }
                $('#the-canvas').attr('src',url);
            })

        }else{
            var pdfurl = location.origin+'/download'+location.search;
            var url ='/lib/pdfjs/web/viewer.html?file='+encodeURIComponent(pdfurl);

            if(userAgent.indexOf('QtWebEngine') > -1){
                url ='/xs' + location.search;
            }
            var AID = $.GetRequest().AID||'';
            var MODULE = $.GetRequest().MODULE||'';
            if(AID != ''&&MODULE != ''){
                $.get('/attachment/findByAid',{
                    aid:AID,
                    module:MODULE
                },function(json){
                    if(json.flag){
                        var name = json.object.attachName||'';
                        if(name != ''){
                            $('title').text('PDF 文档预览 - '+name);
                        }else{
                            $('title').text('PDF 文档预览');
                        }
                    }
                })
            }
            if(userAgent.indexOf('QtWebEngine') > -1){
                location.href = url;
                return ;
            }
            $('#the-canvas').attr('src',url);
        }
    }
    test();
    autodivheight();

</script>

</body>
</html>
