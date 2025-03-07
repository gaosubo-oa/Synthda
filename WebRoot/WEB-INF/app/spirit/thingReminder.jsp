<%--
  Created by IntelliJ IDEA.
  User: 高速波办公
  Date: 2021/12/23
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(1).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>事务提醒</title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <link rel="stylesheet" type="text/css" href="${path}/css/spirit/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/main/theme1/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/main/theme1/index.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="${path}/css/spirit/user_online.css">
    <link rel="stylesheet" type="text/css" href="${path}/css/spirit/ui.dynatree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.11.1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/main_js/cont.js?20210811.9"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="${path}/js/spirit/qwebchannel.js"></script>
    <style>
        .header {
            height: auto;
        }

        body {
            padding: 0px;
            margin: 0px;
        }

        .logo_checks {
            background: none;
        }

        /*显示隐藏按钮*/
        .e_img img, .d_img img, .n_img img {
            max-height: 30px;
        }

        .wenzi {
            color: white;
            position: absolute;
            top: 5px;
            left: 23px;
        }

        .peopleez {
            font-size: 14px;
            color: white;
            position: absolute;
            top: 5px;
            right: 23px;
        }

        .show_off {
            position: absolute;
            top: 5px;
            left: 100px;
            padding: 1px;
            padding-right: 0;
            width: 41px;
            height: 18px;
            background-image: url("../../../img/main_img/frame.png");
            background-repeat: no-repeat;
            color: #2b7fe0;
            font-size: 9pt;
            background-size: 100% 100%;
        }

        .show_off span {
            width: 18px;
            height: 18px;
            display: inline-block;
            cursor: pointer;
            background-repeat: no-repeat;
            background-size: 100% 100%;
        }

        .show_off_tag_bg {
            background-image: url("../../../img/main_img/bold_shadow.png");
            color: #ffffff;

        }

        .show_on {
            background-image: url("../../../img/main_img/frame1.png");
        }

        .show_on2 {
            background-image: url("../../../img/main_img/frame.png");

        }

        /*滑过一级菜单*/


        .apply_every_logo {
            width: 10em;
            text-align: center;
        }

        .contain {
            height: 294px;
        }

        .apply_every_logo:hover {
            background: #e9f3ff;
        }

        .e_title {
            width: 270px !important;
            font-size: 11pt !important;
        }

        .two_menu {
            color: #0f3b6d;
        }

        .clearfix:after {
            content: '';
            display: block;
            clear: both;
        }

        .richeng_title {
            width: 43%;
            line-height: 28px;
            margin-left: 4px;

            overflow: hidden; /*内容超出后隐藏*/
            text-overflow: ellipsis; /* 超出内容显示为省略号*/
            white-space: nowrap; /*文本不进行换行*/
            /*font-size: 11pt;*/
        }

        .r_title {
            width: 32% !important;
            color: #1b5e8d;
        }

        .every_times {
            width: 50%;
            line-height: 27px;
            color: #919191;
            text-align: right;
        }

        /*点中状态下的一级class名*/

        .chedule_li {
            width: 100%;
            height: 41px !important;
            cursor: pointer;
            /*font-size: 11pt;*/
        }

        .chedule_li div {
            float: left;
            margin-top: 7px;
            font-size: 11pt;
        }

        .wenjian_list li {
            width: 69px !important;
        }

        /*		.richeng_title{

                }*/
        .sanji .three {
            width: 100%;
            height: 30px;
        }

        /*	.sanji{
                background:#d5ebfa;
            }*/

        .three h1 {
            margin-left: 6%;
            width: 60%
        }

        .side_all {
            /*width:0px;*/
            height: 100%;
            /*background: red;*/
            position: absolute;
            right: 0px;
            top: 0px;
            z-index: 9999999;
        }

        .checks {
            background: #fff;
        }

        .position {
            width: 0px;
            height: 100%;
            position: absolute;
            right: 0px;
            top: 0px;
            background: #fff;
            box-shadow: -2px 0 20px 0px #c4c4c4;
        }

        .cont_main > ul > li {
            background: #fff !important;
        }

        .button_img, .button_span {
            float: left;
        }

        .button_img {
            width: 15px;
            height: 20px;
            margin-left: 40%;
        }

        .shezhi_img {
            background: url(img/main_img/per_shezhi.png) 0px 3px no-repeat;
        }

        .suoding_img {
            background: url(img/main_img/per_suoding.png) 0px 3px no-repeat;
        }

        .zhuxiao_img {
            background: url(img/main_img/per_zhuxiao.png) 0px 3px no-repeat;
        }

        .button_chacked {
            background: #154d76;
        }

        .button_chacked span {
            color: #fff;
        }

        /*点击更换图片*/
        .button_chacked .shezhi_img {
            background: url(img/main_img/button_shezhi.png) 0px 3px no-repeat;
        }

        .button_chacked .suoding_img {
            background: url(img/main_img/button_suoding.png) 0px 3px no-repeat;
        }

        .button_chacked .zhuxiao_img {
            background: url(img/main_img/button_zhuxiao.png) 0px 3px no-repeat;
        }

        /*滑动更换图片*/
        #admin-side3 button:hover {
            background: #154d76;
        }

        #admin-side3 button:hover span {
            color: #fff;
        }

        #admin-side3 button:hover .shezhi_img {
            background: url(img/main_img/button_shezhi.png) 0px 3px no-repeat;
        }

        #admin-side3 button:hover .suoding_img {
            background: url(img/main_img/button_suoding.png) 0px 3px no-repeat;
        }

        #admin-side3 button:hover .zhuxiao_img {
            background: url(img/main_img/button_zhuxiao.png) 0px 3px no-repeat;
        }

        .c_head a {
            display: block;
        }


        /*			.more_chedule{
                        margin-top: 3px;
                    }*/
        .c_all {
            width: 35px;
            height: 20px;
            /*		background: #009;
                    color: #fff;*/
            background: #f0f0f0;
            color: #666;
            text-align: center;
            line-height: 20px;
            margin-top: 5px;
            border-radius: 4px;
            position: absolute;
            right: 169px;
            top: 2px;
        }

        /*新闻全部按钮的调整*/


        .c_head img {
            position: absolute;
            left: 7px;
            top: 8px;
        }

        .apply_all {
            padding-bottom: 6%;
        }


        .c_today {
            position: absolute;
            right: 129px;
            top: 2px;
        }

        .c_tom {
            position: absolute;
            right: 89px;
            top: 2px;
        }

        .c_nexttom {
            position: absolute;
            right: 49px;
            top: 2px;
        }

        .no_notice > img {
            margin-top: 2%;
        }

        .company {
            height: 41px;
            line-height: 41px;
            width: 97%;
        }

        .company img {
            width: 10%;
        }



        #tixing_tab_c ul li {
            margin-bottom: 8px;
        }

        #tixing_tab_c ul li .search_one_all {
            padding: 10px 0px;
        }

        #tixing_tab_c ul li .search_one_all img.custom_photo {
            /*width: 29px;*/
            /*height: 29px;*/
        }

        #tixing_tab_c ul li .custom_two > li {
            /*height: 40px;*/
            /*padding: 7px 0px;*/
        }

        #tixing_tab_c ul li .custom_two > li img {
            width: 30px;
            height: 30px;
            margin-left: 0px;
            float: left;
            margin-top: 10px;
        }

        #tixing_tab_c ul li .custom_two > li span {
            height: 40px;
            width: 84%;
            margin-left: 1em;
            overflow: hidden;
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
            cursor: pointer;
            display: inline-block;
        }

        #tixing_tab_c ul li .custom_two > li label {
            display: inline-block !important;
            margin-bottom: 0px !important;
            font-size: 12px;

            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        #tixing_tab_c ul li .custom_two > li > span:last-of-type {
            margin-left: 4em;
            /*margin-left: 43px;*/
        }

        .custom_close, .apply_close {
            float: right;
            margin-right: 1em;
        }

        .close {
            opacity: 1 !important;
        }

        img[src=""] {
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }

        .mainstyle {
            width: 270px;
            height: 117px;
            margin-top: 20px;
            margin-left: 17px;
            position: relative;
        }

        .mainstyle:hover .subjectToUse {
            z-index: 1000;
        }

        .mainstyle.blue {
            background: url(/img/replaceImg/replaceTheme/skin.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/skin.png',
                    sizingMethod='scale');
        }

        .mainstyle.blue.actives {
            background: url(/img/replaceImg/replaceThemeskintwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/skintwo.png',
                    sizingMethod='scale');
        }

        .e_title {
            height: 20px;
        }

        .mainstyle.reds {
            background: url(/img/replaceImg/replaceTheme/redzhengwu.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/redzhengwu.png',
                    sizingMethod='scale');
        }

        .mainstyle.reds.actives {
            background: url(/img/replaceImg/replaceTheme/redzhengwutwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/redzhengwutwo.png',
                    sizingMethod='scale');
        }

        .mainstyle.chenjing {
            background: url(/img/replaceImg/replaceTheme/chenjing.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjing.png',
                    sizingMethod='scale');
        }

        .mainstyle.chenjing.actives {
            background: url(/img/replaceImg/replaceTheme/chenjingtwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjingtwo.png',
                    sizingMethod='scale');
        }

        .mainstyle.green {
            background: url(/img/replaceImg/replaceTheme/green.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjing.png',
                    sizingMethod='scale');
        }

        .mainstyle.green.actives {
            background: url(/img/replaceImg/replaceTheme/greentwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjingtwo.png',
                    sizingMethod='scale');
        }

        .mainstyle.dark_green {
            background: url(/img/replaceImg/replaceTheme/dark_green.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjing.png',
                    sizingMethod='scale');
        }

        .mainstyle.dark_green.actives {
            background: url(/img/replaceImg/replaceTheme/dark_greentwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjingtwo.png',
                    sizingMethod='scale');
        }

        .mainstyle.twentyportal {
            background: url(/img/replaceImg/replaceTheme/20menhu.png?20200415) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjing.png',
                    sizingMethod='scale');
        }

        .mainstyle.twentyportal.actives {
            background: url(/img/replaceImg/replaceTheme/20menhu.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjingtwo.png',
                    sizingMethod='scale');
        }

        .mainstyle.bluetwo {
            background: url(/img/replaceImg/replaceTheme/bluetwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/skin.png',
                    sizingMethod='scale');
        }

        .mainstyle.bluetwo.actives {
            background: url(/img/replaceImg/replaceTheme/bluetwos.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/skintwo.png',
                    sizingMethod='scale');
        }


        .mainstyle.redstwo {
            background: url(/img/replaceImg/replaceTheme/redstwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/redzhengwu.png',
                    sizingMethod='scale');
        }

        .mainstyle.redstwo.actives {
            background: url(/img/replaceImg/replaceTheme/redstwos.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/redzhengwutwo.png',
                    sizingMethod='scale');
        }


        .subjectToUse {
            position: absolute;
            top: 4px;
            left: 7px;
            right: 6px;
            bottom: 10px;
            background: rgba(000, 000, 000, .3);
            text-align: center;
            border-radius: 4px;
            z-index: -1;
            cursor: pointer;
        }

        .e_mail li, .daily li, .tainer li, .new_total li {
            cursor: pointer;
        }

        .subjectToUse a {
            color: #fff;
            padding: 3px 15px;
            border-radius: 4px;
            display: inline-block;
            margin-top: 40px;
            background: #3c60e4;
        }

        .one_all:hover {
            cursor: pointer;
        }

        .apply_one_all:hover {
            cursor: pointer;
        }

        .apply_one_all {
            border-bottom: 2px solid #999;
        }

        .search_one_all:hover {
            cursor: pointer;
        }

        .tab_c {
            overflow-y: auto;
        }

        .tab_cone {
            overflow-y: auto;
        }

        .cont {
            padding-bottom: 30px;
        }

        .every_logo {
            height: 117px;
        }

        .tab_ctwo a {
            font-size: 11pt;
        }

        #LockCode, #theLock {
            background: #2069d9;
        }

        #LockCode:hover {
            background: #3981f1;
        }

        #theLock:hover {
            background: #3981f1;
        }

        #xiaoWuLi li {
            float: left;
            display: inline-block;
            height: 20px;
            border-radius: 4px;
            line-height: 20px;
            margin: 4px;
            padding: 0;
            background: #e9e9e9;
            cursor: pointer;
            font-size: 8pt;
            color: #666;
        }

        #xiaoWuLi .strList {
            padding: 0px 3px;
        }

        .more_edu {
            float: left;
            position: absolute;
            right: 10px;
            width: 34px !important;
            height: 20px !important;
            border-radius: 3px;
            line-height: 20px;
            margin: 4px;
            padding: 0;
            background: #f3f3f3;
            cursor: pointer;
            font-size: 8pt;
            color: #666;
            cursor: pointer;
            text-align: center;
        }

        .two_all h1 {
            width: 65%;
        }

        #iconCloseAll {
            display: inline-block;
            width: 50px;
            height: 50px;
            background: url("../../img/main_img/icon_closeAll.png") no-repeat;
            position: absolute;
            top: 32px;
            right: 110px;
            cursor: pointer;
            z-index: 999999;
        }

        #iconCloseAll:hover {
            background: url("../../img/main_img/icon_closeFloat.png") no-repeat;
        }

        .cont_main ul.total > li {
            background: #fff;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2)
        }

        .e_name:hover {
            color: #1b5e8d;
            cursor: pointer;
        }


        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        /*公告*/
        #admin-side0::-webkit-scrollbar, .people_wenjian::-webkit-scrollbar {
            width: 0px;
            height: 16px;
            background-color: #f5f5f5;
        }

        /*定义滚动条的轨道，内阴影及圆角*/
        #admin-side0::-webkit-scrollbar-track, .people_wenjian::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }

        /*定义滑块，内阴影及圆角*/
        #admin-side0::-webkit-scrollbar-thumb, .people_wenjian::-webkit-scrollbar-thumb {
            width: 0px;
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            background-color: #555;
        }

        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        /*公告*/
        #admin-side2::-webkit-scrollbar, .people_wenjian::-webkit-scrollbar {
            width: 0px;
            height: 16px;
            background-color: #f5f5f5;
        }

        /*定义滚动条的轨道，内阴影及圆角*/
        #admin-side2::-webkit-scrollbar-track, .people_wenjian::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }

        /*定义滑块，内阴影及圆角*/
        #admin-side2::-webkit-scrollbar-thumb, .people_wenjian::-webkit-scrollbar-thumb {
            width: 0px;
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            background-color: #555;
        }

        #rightSpan {
            width: 0;
            height: 0;
            border-top: 7px solid transparent;
            border-left: 8px solid #fff;
            border-bottom: 7px solid transparent;
            position: absolute;
            top: 41px;
            right: 20px;
            cursor: pointer;
            z-index: 111111;
        }

        .addOrReduce {
            position: absolute;
            top: 12px;
            right: 6px;
            width: 28px;
            height: 26px;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            cursor: pointer;
        }

        .add_default {
            background-image: url('/img/main_img/add_default.png');
        }

        .add_click {
            background-image: url('/img/main_img/add_click.png');
        }

        .add_float {
            background-image: url('/img/main_img/add_float.png');
        }

        .reduce_click {
            background-image: url('/img/main_img/reduce_click.png');
        }

        .reduce_default {
            background-image: url('/img/main_img/reduce_default.png');
        }

        .reduce_float {
            background-image: url('/img/main_img/reduce_float.png');
        }

        .one_logo {
            margin-top: 3%;
        }

        .contain {
            border: none;
        }

        .more {
            top: 2px;
            font-size: 12px;
        }

        .sort {
            font-size: 12px;
        }

        .head {
            height: 107px;
            /*background: red;*/
        }

        .choose {
            margin-top: 0px;
            margin-left: -8px;
        }

        .gongzuoliu {
            margin-top: 0px;
        }

        .leftSpan {
            top: 16px;
        }

        #rightSpan {
            top: 16px;
        }

        #iconCloseAll {
            top: 3px;
        }

        .header {
            position: relative;
            /*z-index:99999;*/
        }

        .header ul::-webkit-scrollbar {
            /*滚动条整体样式*/
            width: 10px;
            /*高宽分别对应横竖滚动条的尺寸*/
            height: 6px;
        }

        .header ul::-webkit-scrollbar-thumb {
            /*滚动条里面小方块*/
            border-radius: 50px;
            background-color: #c0c0c0;
        }

        .header ul::-webkit-scrollbar-track {
            /*滚动条里面轨道*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        .total .bg_head {
            cursor: all-scroll;
        }

        .sort {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .tab_cone {
            height: 99% !important;
        }

        .he {
            position: absolute;
            top: -3px;
            right: -6px;
            background: #ff3816;
            color: #fff;
            border-radius: 100%;
            height: 20px;
            padding: 0 5px;
            opacity: 0.9;
            filter: Alpha(opacity=90);
        }

        .layui-layer-tips {
            box-shadow: 1px 1px 14px rgba(000, 000, 000, 0.4);
        }

        .all_ul {
            height: 100% !important;
        }

        .s_head, .notice_head, .wenjian_head {
            font-size: 12pt;

        }

        .s_container, .tainer，, .s_cont {
            overflow-y: auto;
            height: 262px;
        }

        .s_container ul li {
            font-size: 11pt;
            padding: 0 5px;
            width: auto;
        }

        /*定义菜单滚动条*/
        .tab_cone::-webkit-scrollbar {
            width: 10px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }

        /*定义滚动条轨道 内阴影+圆角*/
        .tab_cone::-webkit-scrollbar-track {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        .tab_cone::-webkit-scrollbar-thumb {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }

        /*定义菜单滚动条*/
        .tab_ctwo::-webkit-scrollbar {
            width: 10px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }

        /*定义滚动条轨道 内阴影+圆角*/
        .tab_ctwo::-webkit-scrollbar-track {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        .tab_ctwo::-webkit-scrollbar-thumb {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }

        .daily_all li {
            margin-top: 0;
        }

        .total .contain li:hover {
            background: #e8f4fc;
        }

        .custom_num {
            width: 3em !important;
        }

        .oneKeyRead {
            float: right;
            margin-top: 5px;
        }

        .cont_rig {
            /*overflow: auto hidden;*/
        }

        .all_content {
            /*min-width: 1100px;*/
            min-width: 1075px;
        }

        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        #deptOrg::-webkit-scrollbar {
            width: 5px;
            height: 6px;
            background-color: #f5f5f5;
        }

        /*定义滚动条的轨道，内阴影及圆角*/
        #deptOrg::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }

        /*定义滑块，内阴影及圆角*/
        #deptOrg::-webkit-scrollbar-thumb {
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            background-color: #555;
        }

        .chedule_all .chedule_li div {
            font-size: 11pt;
        }

        .three .erji_circle {
            margin-left: 47px;
        }

        .er_img {
            margin-left: 0;
        }

        .three .er_img {
            margin-left: 0px;
        }

        .siji img {
            margin-left: 64px;
        }

        .three_change.activesanji {
            background: rgba(0, 0, 0, .15) !important;
        }

        .siji .four {

            height: 38px !important;
            line-height: 38px;
            width: 97% !important;
            margin: 0 auto;
            border-radius: 3px;

        }

        .four_change {
            background: url(/img/main_img/theme6/menuchang.png) no-repeat !important;
        }

        .weather {
            position: absolute;
            top: 0px;
            right: 9px;
            color: #fff;
            font-size: 13pt;
        }

        .weather span {
            padding: 0 3px;
        }

        .timeDate span {
            padding: 0 6px;
        }

        .time {
            font-size: 15pt;
            font-weight: bold;
        }

        .area {
            font-weight: bold;
        }

        .headTitle {
            color: #fff;
            font-size: 12pt !important;
            position: absolute;
            left: 10px;
            bottom: 10px;
            display: none;
            width: 217px;
            overflow: hidden;
            white-space: nowrap;
            line-height: 33px;
        }

        .head_left font {
            padding-left: 1%;
            line-height: 55px;

            display: inline-block;
            vertical-align: middle;
            margin-top: 10px;
        }

        .daibans {
            height: 262px;
            background: #fff;
            /*box-shadow: 0 2px 6px rgba(0,0,0,0.2)*/
        }

        .daibans li {
            list-style: none;
        }

        .fl {
            float: left
        }

        .richengHover:hover, .daibanHover:hover, .personInfo:hover, .rizhiHover:hover, .emailHover:hover {
            /* border: #fea8a8 1px solid; */
            box-shadow: 0 0 10px #47a4fb;
            z-index: 99;
        }

        .daibantop {
            height: 131px;
        }

        .daibanbuttom {
            height: 131px;
        }

        /*.sort{*/
        /*width: auto!important;*/
        /*padding: 0 5px;*/
        /*}*/

        .top_ul {
            width: 158px;
            padding: 2px;
            box-sizing: border-box;
            background: none;
            left: 10px;
        }

        .yingy {
            background: none;
            line-height: 23px;
        }

        .top_ul li {
            width: 50px;
            line-height: 23px;
        }

        .QRCode {
            width: 185px;
            height: 185px;
            position: absolute;
            top: 72px;
            right: -89px;
            z-index: 99;
            padding: 5px;
            border: #ccc 1px solid;
            background-color: #fff;
            -webkit-box-shadow: 0 0 6px 3px #999;
            -moz-box-shadow: 0 0 6px 3px #999;
            box-shadow: 6px 6px 16px -3px #20395c;
        }

        .topBar {
            display: inline-block;
            margin: 0px 10px;
        }

        .apply_name {
            width: 8em;
        }

        #task_center {
            margin-top: 0;
        }

        #sns {
            margin-top: 0;
        }

        #help {
            margin-top: 0;
        }

        #theme {
            margin-top: 0;
        }

        .header ul li {
            margin: 0;
            min-width: 0
        }

        .header ul li span:hover {
            /*background: #B3DAFF !important;*/
            border-radius: 4px;
            /*color: #fff !important;*/
            box-shadow: 0 0 5px #47a4fb;
        }

        .head_title {
            margin: 7px 7px;
        }

        .header ul li:first-child {
            margin-left: 14px;
        }

        #refurbish, #shezhi {
            background: #0d79ab;
            padding: 0 3px;
            border: 1px solid #0d79ab;
            border-radius: 4px;
        }

        .topBars {
            display: inline-block;
            margin: 0px 10px;
        }
    </style>

    <script type="text/javascript">
        function init() {
            jQuery("#body").height(jQuery(window).height() - jQuery("#sub_tabs").outerHeight());
        }

        window.onresize = init;
    </script>
    <style type="text/css">
        .dynatree-checkbox {
            margin-right: 5px;
        !important;
        }

        #dyna_li:hover {
            background: #EFEFEF;
        }

        #dept_li:focus {
            background: #EFEFEF;
        }

        .dynatree-title {
            font-weight: normal;
        }

        .ul.dynatree-container ul {
            padding: 0 !important;
        }

        .tab_ctwo {
            background: #fff;
            overflow: auto;
        }

        .tab_ctwo::-webkit-scrollbar {
            width: 10px;
        }

        .tab_ctwo::-webkit-scrollbar-corner {
            background-color: #fff;
        }

        .tab_ctwo::-webkit-scrollbar-thumb {
            background-color: #c0c0c0;
            border-radius: 50px;
        }

        .sub_menu {
            position: static;
            width: 296px !important;
            background-color: #f8f8f8;

            border: none;
            text-align: right;
        }

        .sub_menu a {
            display: inline-block;
            padding: 2px 4px 2px 4px;
            margin: 2px 5px;
        }

        .sub_menu a.active {
            background: none;
            color: #368feb;
        }

        .sub_menu a:hover {
            background: #abd9fe;
            border-radius: 4px;
        }
    </style>
    <style>
        body {
            padding: 0px;
            margin: 0px;

        }

        .side_all {
            /*width:0px;*/
            height: 100%;
            /*background: red;*/
            position: absolute;
            right: 0px;
            top: 0px;
            z-index: 9999999;
        }

        #tixing_tab_d ul li {
            margin-bottom: 8px;
        }

        #tixing_tab_d ul li .search_one_all {
            padding: 10px 0px;
        }

        #tixing_tab_d ul li .search_one_all img.custom_photo {
            /*width: 29px;*/
            /*height: 29px;*/
        }

        #tixing_tab_d ul li .custom_two > li {
            /*height: 40px;*/
            /*padding: 7px 0px;*/
        }

        #tixing_tab_d ul li .custom_two > li img {
            width: 30px;
            height: 30px;
            margin-left: 0px;
            float: left;
            margin-top: 10px;
        }

        #tixing_tab_d ul li .custom_two > li span {
            height: 40px;
            width: 84%;
            margin-left: 1em;
            overflow: hidden;
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
            cursor: pointer;
            display: inline-block;
        }

        #tixing_tab_d ul li .custom_two > li label {
            display: inline-block !important;
            margin-bottom: 0px !important;
            font-size: 12px;

            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        #tixing_tab_d ul li .custom_two > li > span:last-of-type {
            margin-left: 4em;
            /*margin-left: 43px;*/
        }

        .search_one_all:hover {
            cursor: pointer;
        }

        .tab_c {
            flow-y: auto;
        }

        .tab_cone {
            overflow-y: auto;
        }

    </style>


</head>
<script>

</script>


<body marginwidth="0" marginheight="0" ;>
<div id="body" class="wrap"
     style="width: 300px;height: calc(100% - 40px);position:relative;border-top: 1px solid #e8e8e8; overflow-y: hidden">
    <div class="cont" id="client" style="position: relative;height: 100%">
        <ul class="side_all">
            <li class="position" id="admin-side0" style="width: 0px; display: none; overflow-y: auto;">
                <div class="skin">
                    <h2 style="width: 90%;height:100%;line-height: 45px;text-align: center;font-size: 10pt;font-weight: bold;">
                        搜索
                    </h2>
                    <img id="go_back" src="img/main_img/close.png" alt="" style="margin-top: 15px;cursor:pointer">
                </div>
                <div style="background:#fff;height: 57px;">
                    <input type="text" id="searchText" class="huiqian_inp">
                    <button class="huiqian_send" id="index_find">搜索</button>
                </div>
                <div class="search_cont">
                    <ul class="search-cont-cus">
                        <li class="search_custom">
                            <div class="search_one_all"><img class="custom_photo" src="img/main_img/custom.png" alt="">
                                <h1 class="custom_name">用户</h1>
                                <img src="/img/main_img/cus_open.png" class="custom_close" alt="">
                                <h2 id="userSearchNum" class="custom_num"></h2>

                            </div>
                            <div class="search_two_all" style="">
                                <ul class="custom_two">

                                </ul>
                            </div>
                        </li>
                        <li class="search_apply">
                            <div class="apply_one_all"><img class="apply_photo" src="img/main_img/apply.png" alt="">
                                <h1 class="apply_name">应用</h1>
                                <img src="img/main_img/cus_open.png" class="apply_close" alt="">
                                <h2 id="applySearchNum" class="apply_num"></h2>
                            </div>
                            <div class="search_two_all">
                                <ul class="custom_two">

                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>

            </li>
            <li class="position" id="admin-side1" style="width: 310px;">
                <div class="skin" style="position: relative;">
                    <img class="reloadSide" src="/img/icon_refresh_10.png"
                         style="position: absolute;left: 16px;top: 13px;cursor: pointer" alt="">
                    <h2 style="width: 90%;height:100%;line-height: 45px;text-align: center;font-size: 10pt;font-weight: bold;">
                        事务提醒</h2>
                    <img id="go_back" src="img/main_img/close.png" alt="" style="margin-top: 15px;">
                </div>

                <div id="tixing_tab_c" style="overflow-y: auto">
                    <ul class="search-cont-cus">
                        <li class="search_custom" onclick="fun()">
                            <div class="search_one_all" >
                                <img class="custom_photo" style="margin-top: 3px;"
                                     src="/img/sidebar_icon_remind_backlog.png" alt="">
                                <h1 class="custom_name">工作流
                                </h1>
                                <img src="/img/main_img/cus_close.png" class="custom_close" alt="" id="img1">
                                <h2 id="userSeasethree" class="custom_num">8</h2>
                                <img class="oneKeyRead read_5" src="/img/main_img/icon_unread.png" title="一键阅读" alt=""
                                     datatype="willdo" id="">
                            </div>
                            <div class="search_two_all" id="newsAll" style="display: none">
                                <ul class="custom_two" id="workFlowAll">
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000140"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：18462，工作名称/文号：费用报销申请(2021-12-03 15:54:04)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：18462，工作名称/文号：费用报销申请(2021-12-03 15:54:04)</span><span><label
                                            style="margin-right: 1em;" title="黄珊珊">黄珊珊</label><label
                                            style="color: #999;width: 11em" title="2021-12-06 10:20:24">2021-12-06<b
                                            style="    margin-left: 0.5em;"></b>10:20:24</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000139"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：7228，工作名称/文号：付款申请(2019-11-27 15:37:21)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：7228，工作名称/文号：付款申请(2019-11-27 15:37:21)</span><span><label
                                            style="margin-right: 1em;" title="聂雪莲">聂雪莲</label><label
                                            style="color: #999;width: 11em" title="2021-12-06 10:15:21">2021-12-06<b
                                            style="    margin-left: 0.5em;"></b>10:15:21</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                                                                                                       data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                    <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                         alt=""><span class="windowopen" data-id="2010000629"
                                                      style="vertical-align: middle;margin-top: 10px"
                                                      title="您有新的工作需要办理，流水号：18381，工作名称/文号：公司用章申请(2021-11-29 15:57:36)"><b
                                        class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：18381，工作名称/文号：公司用章申请(2021-11-29 15:57:36)</span><span><label
                                        style="margin-right: 1em;" title="王凯宇">王凯宇</label><label
                                        style="color: #999;width: 11em" title="2021-11-29 16:24:54">2021-11-29<b
                                        style="    margin-left: 0.5em;"></b>16:24:54</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000106"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：15204，工作名称/文号：离职申请(2021-04-12 10:24:11)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：15204，工作名称/文号：离职申请(2021-04-12 10:24:11)</span><span><label
                                            style="margin-right: 1em;" title="王成">王成</label><label
                                            style="color: #999;width: 11em" title="2021-11-23 15:28:06">2021-11-23<b
                                            style="    margin-left: 0.5em;"></b>15:28:06</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000629"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：18196，工作名称/文号：付款申请(2021-11-11 11:56:38)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：18196，工作名称/文号：付款申请(2021-11-11 11:56:38)</span><span><label
                                            style="margin-right: 1em;" title="王凯宇">王凯宇</label><label
                                            style="color: #999;width: 11em" title="2021-11-11 12:09:46">2021-11-11<b
                                            style="    margin-left: 0.5em;"></b>12:09:46</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000127"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：13888，工作名称/文号：公司用章申请(2021-02-04 17:25:33)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：13888，工作名称/文号：公司用章申请(2021-02-04 17:25:33)</span><span><label
                                            style="margin-right: 1em;" title="张傲">张傲</label><label
                                            style="color: #999;width: 11em" title="2021-11-05 11:09:06">2021-11-05<b
                                            style="    margin-left: 0.5em;"></b>11:09:06</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000355"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：18141，工作名称/文号：基金分红申请(2021-11-04 19:54:46)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：18141，工作名称/文号：基金分红申请(2021-11-04 19:54:46)</span><span><label
                                            style="margin-right: 1em;" title="蔡蓓霖">蔡蓓霖</label><label
                                            style="color: #999;width: 11em" title="2021-11-04 19:55:14">2021-11-04<b
                                            style="    margin-left: 0.5em;"></b>19:55:14</label></span></li>
                                    <li onclick="windowOpenNew(this)" data-s="2"
                                        data-url="/workflow/work/workform?opflag=1&flowId=331&flowStep=2&tableName=document&tabId=2660&runId=11206&prcsId=2&isNomalType=false">
                                        <img style="vertical-align: middle" src="/img/workflow/daibanliucheng.png"
                                             alt=""><span class="windowopen" data-id="2010000158"
                                                          style="vertical-align: middle;margin-top: 10px"
                                                          title="您有新的工作需要办理，流水号：17979，工作名称/文号：付款申请(2021-10-21 10:45:38)"><b
                                            class="headline" style="font-size: 14px;font-weight: bold;">标题：</b> 您有新的工作需要办理，流水号：17979，工作名称/文号：付款申请(2021-10-21 10:45:38)</span><span><label
                                            style="margin-right: 1em;" title="谢国健">谢国健</label><label
                                            style="color: #999;width: 11em" title="2021-11-04 08:22:15">2021-11-04<b
                                            style="    margin-left: 0.5em;"></b>08:22:15</label></span></li></ul>

                            </div>
                        </li>

                        <li class="search_custom" id="mmsz" style="">
                            <div class="search_one_all" onclick="funb()">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/psd.png" alt="">
                                <h1 class="custom_name">密码设置管理
                                </h1>
                                <img src="/img/main_img/cus_close.png" class="custom_close" alt="" id="img2">
                                <h2 id="password" class="custom_num">6</h2>
                                <img class="oneKeyRead read_39" src="/img/main_img/icon_unread.png" title="一键阅读" alt=""
                                     datatype="passwordManager">
                            </div>
                            <div class="search_two_all" style="display: none;" id="pwd">
                                <ul class="custom_two" id="password1">
                                    <li onclick="windowOpenNew(this)" bodyid="60690" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 13:19:53">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>13:19:53</label></span></li>
                                    <li onclick="windowOpenNew(this)" bodyid="60689" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 13:18:43">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>13:18:43</label></span></li>
                                    <li onclick="windowOpenNew(this)" bodyid="60688" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 13:17:37">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>13:17:37</label></span></li>
                                    <li onclick="windowOpenNew(this)" bodyid="60687" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 13:00:00">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>13:00:00</label></span></li>
                                    <li onclick="windowOpenNew(this)" bodyid="60686" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 11:36:45">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>11:36:45</label></span></li>
                                    <li onclick="windowOpenNew(this)" bodyid="60685" data-s="15"
                                        data-url="/controlpanel/modifyInfo"><img style="vertical-align: middle"
                                                                                 src="/img/meeting/修改密码.png" alt=""><span
                                            class="windowopen" data-id="1"
                                            style="vertical-align: middle;margin-top: 10px"
                                            title="您的登录密码为空，存在风险，请尽快修改！"><b class="headline"
                                                                            style="font-size: 14px;font-weight: bold;">标题：</b> 您的登录密码为空，存在风险，请尽快修改！</span><span><label
                                            style="margin-right: 1em;" title="系统管理员">系统管理员</label><label
                                            style="color: #999;width: 11em" title="2021-12-24 11:05:49">2021-12-24<b
                                            style="margin-left: 0.5em;"></b>11:05:49</label></span></li>
                                </ul>
                            </div >
                        </li>


                        <li class="search_custom" id="rizhi" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/rizhi.png" alt="">
                                <h1 class="custom_name">工作日志
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="rizhi1" class="custom_num">0</h2>
                                <img class="oneKeyRead read_11" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="rizhiurl"></ul>
                            </div>
                        </li>

                        <li class="search_custom" id="leaderActiv" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/leaderActiv.png" alt="">
                                <h1 class="custom_name">领导活动安排
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="leaderActiv1" class="custom_num">0</h2>
                                <img class="oneKeyRead read_12" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="leaderActivurl"></ul>
                            </div>
                        </li>


                        <li class="search_custom" id="networkDisk" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/networkDisk.png" alt="">
                                <h1 class="custom_name">网络硬盘
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="networkDisk1" class="custom_num">0</h2>
                                <img class="oneKeyRead read_15" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="networkDiskurl"></ul>
                            </div>
                        </li>

                        <li class="search_custom" id="zhiban" style="display: none;">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/zhiban.png" alt="">
                                <h1 class="custom_name">值班管理
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="zhibanS" class="custom_num">0</h2>
                                <img class="oneKeyRead read_16" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="zhibang"></ul>
                            </div>
                        </li>

                        <li class="search_custom" id="dispatcher" style="display: none;">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/dispatcher.png" alt="">
                                <h1 class="custom_name">人员调度
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="dispatcherS" class="custom_num">0</h2>
                                <img class="oneKeyRead read_17" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="dispatcherUrl"></ul>
                            </div>
                        </li>

                        <li class="search_custom" id="thirdSystem" style="display: none;">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;" src="/img/thirdSystem.png" alt="">
                                <h1 class="custom_name">第三方系统
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="thirdSystemS" class="custom_num">0</h2>
                                <img class="oneKeyRead read_18" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="thirdSystemUrl"></ul>
                            </div>
                        </li>


                        <li class="search_custom" id="traPlan" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;width: 26px;"
                                     src="/img/schedule/remind.png" alt="">
                                <h1 class="custom_name">培训计划管理
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="tranPlan" class="custom_num">0</h2>
                                <img class="oneKeyRead read_19" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="tranPlanList"></ul>
                            </div>
                        </li>


                        <li class="search_custom" id="taskManage" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                     src="/img/task/taskremind.png" alt="">
                                <h1 class="custom_name">任务管理
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="taskManagePlan" class="custom_num">0</h2>
                                <img class="oneKeyRead read_24" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="taskManageList"></ul>
                            </div>
                        </li>


                        <li class="search_custom" id="carApproval" style="display: none">
                            <div class="search_one_all">
                                <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                     src="/img/task/taskremind.png" alt="">
                                <h1 class="custom_name">车辆申请
                                </h1>
                                <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                <h2 id="carApprovalPlan" class="custom_num">0</h2>
                                <img class="oneKeyRead read_25" src="/img/main_img/icon_unread.png" title="一键阅读" alt="">
                            </div>
                            <div class="search_two_all" style="display: none">
                                <ul class="custom_two" id="carApprovalList"></ul>
                            </div>
                        </li>


                    </ul>
                    <div class="noReminding" style="text-align: center;width: 100%;display: none;">
                        <img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">
                        <h2 style="text-align: center;color: #666;">暂无提醒</h2>
                    </div>
                </div>
            </li>

        </ul>

    </div>
</div>


<script>
    function fun() {
        if ($('#newsAll').css('display') == 'none') {
            $('#newsAll').css('display', 'block');
            $("#img1").attr("src","/img/main_img/cus_open.png");
        } else {
            $('#newsAll').css('display', 'none');
            $("#img1").attr("src","/img/main_img/cus_close.png");
        }

    }
    function funb() {
        if ($('#pwd').css('display') == 'none') {
            $('#pwd').css('display', 'block');
            $("#img2").attr("src","/img/main_img/cus_open.png");
        } else {
            $('#pwd').css('display', 'none');
            $("#img2").attr("src","/img/main_img/cus_close.png");
        }

    }
</script>
</body>
</html>