<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(3).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <title></title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <link rel="stylesheet" type="text/css" href="../css/spirit/style.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/note.css">
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../js/spirit/note.js"></script>
    <script>
        var ispirit = "1";
        var MYOA_STATIC_SERVER_JS = "";
        var page = 0;
        var data_type = '1';
        var i_ver = '2';

        function init() {
            jQuery("#body").height(jQuery(window).height() - jQuery("#sub_tabs").outerHeight());
        }
        window.onresize = init;
        function rescroll() {
            var msg = document.getElementById("msg");
            var xoverlay = document.getElementById("xoverlay");
            var body = document.getElementById("body");
            msg.style.top = 0;
            xoverlay.style.height = body.scrollHeight;
            msg.style.marginTop = (body.scrollTop + body.clientHeight / 2 - msg.style.height / 2) + "px";
        }

        function setCookie(name, value, paras) {
            var today = new Date();
            var expires = new Date();
            expires.setTime(today.getTime() + 1000 * 60 * 60 * 24 * 2000);

            var path = null;
            if (typeof(paras) == "object") {
                if (typeof(paras.expires) != "undefined")
                    expires = paras.expires;
                if (typeof(paras.path) != "undefined")
                    path = paras.path;
            }

            document.cookie = name + "=" + escape(value) + "; expires=" + expires.toGMTString() + (path ? '; path=' + path : '');
        }
    </script>
    <style>
    </style>
</head>


<body onload="init();window.setTimeout(init, 1);" marginwidth="0" marginheight="0">
<div id="sub_tabs" class="sub_tabs">
    <ul id="sub_tabs_ul">
        <li><a id="link_1" href="javascript:;" title="便签排序" class="active" module="note"><span
                class="dropdown-containter"><label id="label_smsbox">排序</label><span class="dropdown"></span></span></a>
        </li>
        <li><a id="link_2" href="javascript:new_note();" title="新建便签"><span>新建</span></a></li>
        <li><a id="link_3" href="javascript:export_txt();" title="导出便签"><span>导出</span></a></li>
    </ul>
    <a id="sms_refresh" href="javascript:location.reload();" title="刷新"></a>
</div>
<div id="sub_menu_note" class="sub_menu" style="width:110px;">
    <a href="javascript:window.location=&#39;index.php?ISPIRIT=1&amp;I_VER=2&amp;EDIT=1&#39;"
       class="active">按编辑时间排序</a>
    <a href="javascript:window.location=&#39;index.php?ISPIRIT=1&amp;I_VER=2&amp;EDIT=0&#39;"
        class="">按创建时间排序</a>
</div>
<div id="body" onscroll="rescroll();" style="background: white; height: 549px;">
    <div id="xoverlay"></div>
    <div id="msg"></div>

    <div id="content_box" class="module listColor">
        <div id="item_124" class="module_body left-border-3">
            <div class="content" ><span class="contents">就一个</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年04月11日 11:10</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;124&#39;);" title="分享到邮件"><img
                        src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;124&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;124&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_123" class="module_body left-border-0">
            <div class="content" ><span class="contents">逞异夸能</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年03月29日 10:28</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;123&#39;);" title="分享到邮件"><img
                        src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;123&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;123&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_96" class="module_body left-border-3">
            <div class="content"><span class="contents">和各家各户大家</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年03月06日 17:12</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;96&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;96&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;96&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_117" class="module_body left-border-2">
            <div class="content"><span class="contents">捶捶背哈哈哈</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年03月06日 14:19</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;117&#39;);" title="分享到邮件"><img
                        src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;117&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;117&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_97" class="module_body left-border-1">
            <div class="content" ><span class="contents">对国家机关好的肌肤光滑</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年02月16日 15:57</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;97&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;97&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;97&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_89" class="module_body left-border-4">
            <div class="content" ><span class="contents">感到舒服个大放送感到舒服</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年02月16日 15:52</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;89&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;89&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;89&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_87" class="module_body left-border-1">
            <div class="content" ><span class="contents">的鬼斧神工树大根深地方</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年02月16日 15:52</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;87&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;87&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;87&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_86" class="module_body left-border-2">
            <div class="content" ><span class="contents">g给对方是个大放送</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年02月16日 15:52</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;86&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;86&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;86&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
        <div id="item_84" class="module_body left-border-1">
            <div class="content" ><span class="contents">对方是个大放送感到舒服</span>

                <div class="pubinfo" style="display:">
                    <span class="time" title="">2017年02月16日 15:51</span>
                </div>
            </div>
            <div class="note" style="display:none">
                <span class="dele"><a href="javascript:share_email(&#39;84&#39;);" title="分享到邮件"><img src="images/5.png"></a>
                    <a href="javascript:share_weixun(&#39;84&#39;);" title="分享到微讯"><img src="images/6.png"></a>
                    <a href="javascript:delete_note(&#39;84&#39;);" title="删除"><img src="images/8.png"></a></span>
            </div>

            <div class="clearfix"></div>
        </div>
    </div>
</div>
<script>
    if (window.external && typeof window.external.OA_SMS != 'undefined') {
        window.external.OA_SMS('', '', 'FRESH');
    }
</script>


</body>
</html>