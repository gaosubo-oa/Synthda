<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0079)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource.html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <style>
        #nav_menu{
            height:36px!important;
            line-height:36px!important;
        }
        #nav_menu a{
            line-height: 36px!important;
        }
    </style>
    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <%--<script type="text/javascript" src="../js/jquery/jquery.min.js"></script>--%>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
   <!--  <script src="../js/spirit/ispirit.js"></script> -->
    <!-- <script src="../js/spirit/index_ispirit.js"></script> -->
    <script>
        var doQtPerss = parent.doQtPers;
        var fuacQt=parent.doQtFunc;
        var doQtDep=parent.doQtDep;
        var doQtPer=parent.doQtPer;
        var menu_id = "1";
        var org_updated = false;
        var ispirit = "1";
        var i_ver = "2";
        var cur_uid = "1";
        var cur_pwd = "e60266ac02274b66";
        var cur_sid = "aaice7qefidm31ika2ig2jti10";
        function view_menu(id) {
            if (id == menu_id) {
                return;
            }

            jQuery('#panels_container .panel').hide();
            if (id == "1") {
                jQuery('#panel_menu').show();
                if (frames['menu'].location == 'about:blank' || !frames['menu'].location) {
                    frames['menu'].location = "/general/ipanel/menu.php?ISPIRIT=1&I_VER=2&MENU_UI_HIDE=";
                }
            }
            else if (id == "2") {
                jQuery('#panel_org').show();
                if (org_updated || frames['org'].location == 'about:blank' || !frames['org'].location) {
                    frames['org'].location = "/general/ipanel/user/?ISPIRIT=1&I_VER=2";
                    org_updated = false;
                }

                if (typeof(frames['org'].onshow) == "function") {
                    frames['org'].onshow();
                }
            }
            else if (id == "3") {
                jQuery('#panel_smsbox').show();
                if (frames['smsbox'].location == 'about:blank' || !frames['smsbox'].location) {
                    frames['smsbox'].location = "/general/ipanel/smsbox/?ISPIRIT=1&I_VER=2";
                }
            }
            else if (id == "4") {
                jQuery('#panel_note').show();
                if (frames['note'].location == 'about:blank' || !frames['note'].location) {
                    frames['note'].location = "/general/ipanel/note/?ISPIRIT=1&I_VER=2";
                }

                if (typeof(frames['note'].konfocus) == "function") {
                    frames['note'].konfocus();
                }
            }


            jQuery('#menu_' + menu_id).removeClass('active');
            jQuery('#menu_' + id).addClass('active');
            menu_id = id;
        }

        //更新组织机构
        function ispirit_update_org() {
            org_updated = true;
            if (menu_id == 2)
                view_menu(menu_id);
        }

        //发送消息
        function send_msg(uid, user_name) {
            if (window.top.bIMLogin && typeof(window.external.OA_SMS) != 'undefined')
                window.external.OA_SMS(uid, user_name, "SEND_MSG");
            else
                send_sms(uid, user_name);
        }

        function callback_ispirit(param1, param2, param3) {
            if (window.external && typeof(window.external.OA_SMS) != 'undefined') {
                window.external.OA_SMS(param1, param2, param3);
            }
        }

        function wb_set_hidden_value(param1) {
            if (typeof(frames['smsbox'].WB.sharebox.hdset) == 'function') {
                if (param1.indexOf('+OK ') != "-1") {
                    param1 = param1.substring(4);
                    frames['smsbox'].WB.sharebox.hdset(param1);
                }
            }

            if (typeof(frames['smsbox'].WB.getNew) == 'function') {
                frames['smsbox'].WB.getNew();
            }
        }

        //新建保存便签，jQuery.ajax POST
        function add_note(app, key, content, color, show_flag) {
            //ajax保存，调用ipanel/note/action.php，ACTION变量为 add
            jQuery.ajax({
                type: 'POST',
                url: './note/action.php',
                data: {'app': app, 'action': 'add', 'content': content, 'color': color, 'show_flag': show_flag},
                dataType: 'json',
                success: function (data) {
                    if (data.code == '1') {

                        var note_id = data.data;

                        //回调便签页面接口，将新建的标签放在最上边
                        if (typeof(frames['note'].add_note_block) == 'function') {
                            frames['note'].add_note_block(note_id, content, color);
                        }

                        callback_ispirit("add", (data.code + ':' + note_id + ':' + key), "NOTES");
                    }
                    else {
                       // //(data.data);
                        callback_ispirit("add", ('0:0:' + key), "NOTES");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    ////(textStatus);
                    callback_ispirit("add", ('0:0:' + key), "NOTES");
                }
            });
        }
        //编辑保存便签，jQuery.ajax POST
        function update_note(app, note_id, content, color, show_flag) {
            //ajax保存，调用ipanel/note/action.php，ACTION变量为 update
            jQuery.ajax({
                type: 'POST',
                url: './note/action.php',
                data: {
                    'app': app,
                    'action': 'update',
                    'note_id': note_id,
                    'content': content,
                    'color': color,
                    'show_flag': show_flag
                },
                dataType: 'json',
                success: function (data) {
                    if (data.code == '1') {
                        //回调便签页面接口，调整修改过的标签位置，并更新内容和颜色
                        if (typeof(frames['note'].update_note_block) == 'function') {
                            frames['note'].update_note_block(note_id, content, color);
                        }

                        callback_ispirit("update", (data.code + ':' + note_id), "NOTES");
                    }
                    else {
                       // //(data.data);
                        callback_ispirit("update", ('0:' + note_id), "NOTES");
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    //(textStatus);
                    callback_ispirit("update", ('0:' + note_id), "NOTES");
                }
            });
        }
        //删除便签，jQuery.ajax GET
        function delete_note(note_id_str) {
            //ajax删除，调用ipanel/note/action.php，ACTION变量为 delete
            jQuery.ajax({
                type: 'GET',
                url: './note/action.php',
                data: {'action': 'delete', 'note_id_str': note_id_str},
                dataType: 'json',
                success: function (data) {
                    if (data.code == '1') {
                        //回调便签页面接口，根据ID删除对应的标签块
                        if (typeof(frames['note'].delete_note_block) == 'function') {
                            frames['note'].delete_note_block(note_id_str);
                        }
                    }
                    else {
                        //(data.data);
                    }
                },
                error: function (request, textStatus, errorThrown) {
                    //(textStatus);
                }
            });
        }
        function update_note_color(note_id, color) {
            if (typeof(frames['note'].update_note_color) == 'function') {
                frames['note'].update_note_color(note_id, color);
            }
        }
        //修正IE6下窗口大小变化时ipanel及其下层iframe不响应resize事件的问题
        function resizeLayoutByParent() {
            jQuery(window).resize();
        }

        jQuery.noConflict();
        (function ($) {
            function resizeLayout() {
                // 主操作区域高度
                var wHeight = $(window).height();//(window.document.documentElement.clientHeight || window.document.body.clientHeight || window.innerHeight);
                var tHeight = $('#tabs').outerHeight();
                var bHeight = $('#bottom').outerHeight();
                //console.log(wHeight , tHeight , bHeight);
                $('#panels_container').height(wHeight - tHeight - bHeight);
                $('#panels_container iframe').height(wHeight - tHeight - bHeight);

                var bWidth = $('#bottom').width();
                var lWidth = $('#bottom_left').outerWidth();
                var rWidth = $('#bottom_right').outerWidth();
                $('#bottom_center').width(bWidth - lWidth - rWidth);

                //修正IE6下窗口大小变化时ipanel及其下层iframe不响应resize事件的问题
//                if ($.browser.msie && $.browser.version == '6.0') {
//                    $('#panels_container iframe').each(
//                        function () {
//                            if (typeof(frames[this.id].init) == 'function')
//                                frames[this.id].init();
//                        }
//                    );
//                }
            };
            function frameLazeload() {
                $('#panels_container #menu[src="about:blank"][data-src]').each(function () {
                    this.src = this.getAttribute('data-src');
                });
            }

            $(window).resize(function () {
                resizeLayout();
            });

            $(document).ready(function ($) {
                //调整iframe大小
                resizeLayout();
                setTimeout(frameLazeload, 1000);
            });
        })(jQuery);




    </script>
<script type="text/javascript">

    (function($){

        $("a").click(function () {
            var id=$(this).parent("li").attr("id");

            if(id=='li_1'){
                $(".yy_icon").css("background","url(../../img/spirit/menu/yingyong_xuanzhong.png) no-repeat center");
                $(".yy_icon").css("background-size","cover");
                $(".yy_span").css("color","#FFFFFF");
                $(".bq_icon").css("background","url(../../img/spirit/menu/huihua.png) no-repeat center");
                $(".bq_icon").css("background-size","cover");
                $(".huihua_span").css("color","#006ca0");
                $(".zz_icon").css("background","url(../../img/spirit/menu/zuzhi.png) no-repeat center");
                $(".zz_icon").css("background-size","cover");
                $(".zz_span").css("color","#006ca0");
            }
            if(id=='li_2'){
                $(".yy_icon").css("background","url(../../img/spirit/menu/yingyong1.png) no-repeat center");
                $(".yy_icon").css("background-size","cover");
                $(".yy_span").css("color","#006ca0");
                $(".bq_icon").css("background","url(../../img/spirit/menu/huihua.png) no-repeat center");
                $(".bq_icon").css("background-size","cover");
                $(".huihua_span").css("color","#006ca0");
                $(".zz_icon").css("background","url(../../img/spirit/menu/zuzhi_xuanzhong.png) no-repeat center");
                $(".zz_icon").css("background-size","cover");
                $(".zz_span").css("color","#FFFFFF");
            }
            if(id=='li_4'){
                $(".yy_icon").css("background","url(../../img/spirit/menu/yingyong1.png) no-repeat center");
                $(".yy_icon").css("background-size","cover");
                $(".yy_span").css("color","#006ca0");
                $(".bq_icon").css("background","url(../../img/spirit/menu/huihua_xuanzhong.png) no-repeat center");
                $(".bq_icon").css("background-size","cover");
                $(".huihua_span").css("color","#FFFFFF");
                $(".zz_icon").css("background","url(../../img/spirit/menu/zuzhi.png) no-repeat center");
                $(".zz_icon").css("background-size","cover");
                $(".zz_span").css("color","#006ca0");
            }
        })

    })(jQuery)
</script>



    <style>

        html, body {
            overflow: hidden;
        }

        #bottom {
            height: 0px;
        }
    </style>
</head>


<body marginwidth="0" marginheight="0">
<%--<div id="tabs">
    <ul id="nav_menu" >
        <li id="li_1" ><a id="menu_1" href="javascript:view_menu(&#39;1&#39;);" hidefocus="hidefocus"  title="导航菜单"
                         class="active"><span class="yy_icon"></span><span style="color:#FFFFFF" class="yy_span">应用</span></a></li>
        <li id="li_4"><a id="menu_4" href="javascript:view_menu(&#39;4&#39;);" hidefocus="hidefocus" title="会话"
                         class=""><span class="bq_icon"></span><span style="color:#006ca0" class="huihua_span">会话</span></a></li>
        <li id="li_2"><a id="menu_2" href="javascript:view_menu(&#39;2&#39;);" hidefocus="hidefocus" title="组织机构及人员"
                         class=""><span class="zz_icon"></span><span style="color:#006ca0" class="zz_span">组织</span></a></li>
        <!-- <li id="li_3"><a id="menu_3" href="javascript:view_menu(&#39;3&#39;);" hidefocus="hidefocus" title="微讯" class=""><span>微讯</span></a></li>-->

    </ul>
</div>--%>
<div id="panels_container" style="height: 531px;">
    <div id="panel_menu" class="panel" style="height: 100%; display: block;">
        <iframe id="menu" name="menu" src="/spirit/menu"
                data-src="/general/ipanel/menu.php?ISPIRIT=1&amp;I_VER=2&amp;MENU_UI_HIDE=" allowtransparency="true"
                border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0"
                style="width: 100%; height: 531px;"></iframe>
    </div>
    <div id="panel_note" class="panel" style="display: none;">
        <iframe id="note" name="note" src="messageList"
                data-src="/general/ipanel/note/?ISPIRIT=1&amp;I_VER=2" allowtransparency="true" border="0"
                frameborder="0" framespacing="0" marginheight="0" marginwidth="0"
                style="width: 100%; height: 531px;"></iframe>
    </div>

    <div id="panel_org" class="panel" style="display: none;">
        <iframe id="org" name="org" src="zz"
                data-src="/general/ipanel/user/?ISPIRIT=1&amp;I_VER=2" allowtransparency="true" border="0"
                frameborder="0" framespacing="0" marginheight="0" marginwidth="0"
                style="width: 100%; height: 531px;"></iframe>
    </div>
    <!--
       <div id="panel_smsbox" class="panel" style="display: none;">
           <iframe id="smsbox" name="smsbox" src="./saved_resource(2).html" data-src="/general/ipanel/smsbox/?ISPIRIT=1&amp;I_VER=2" allowtransparency="true" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" style="width: 100%; height: 531px;"></iframe>
       </div>
       -->

</div>

<div id="bottom">
    <span id="bottom_left"></span>
    <span id="bottom_center" style="width: 0px;"></span>
    <span id="bottom_right"></span>
</div>

</body>
</html>