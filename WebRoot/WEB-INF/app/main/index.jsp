<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20210312.9"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css?20201119.2"/>
    <%--    <link rel="stylesheet" type="text/css" href="/css/main/theme1/m_reset.css?20200311.1"/>--%>

    <link rel="stylesheet" href="/css/main/intranetBlue.css">
    <%--${sessionScope.InterfaceModel}--%>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script type="text/javascript"  src="/js/xoajq/xoajq3.js" charset="utf-8"></script>
    <script type="text/javascript"  src="/js/jquery/jquery-migrate-3.4.0.js" charset="utf-8"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript"  src="/js/base/base.js?20221026.2"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"  src="/js/main_js/index.js?20230605.1"></script>
    <script type="text/javascript" src="/js/main_js/cont.js?20220920.1"></script>

    <script type="text/javascript"  src="/lib/drag/drag.js?20190709"></script>
    <script type="text/javascript"  src="/js/main_js/indexAll.js?20230604.2"></script>

    <style>
        .header{
            height: auto;
        }
        body{
            padding:0px;
            margin:0px;
        }
        .logo_checks{
            background: none;
        }
        /*显示隐藏按钮*/
        .e_img img, .d_img img, .n_img img{
            max-height: 30px;
        }
        .wenzi{
            color:white;
            position: absolute;
            top:5px;
            left:23px;
        }
        .peopleez{
            font-size: 14px;
            color:white;
            position: absolute;
            top:5px;
            right: 23px;
        }
        .show_off{
            position:absolute;top:5px;left:100px;padding:1px;padding-right: 0;
            width:41px;height:18px;background-image: url("../../../img/main_img/frame.png");
            background-repeat: no-repeat;color:#2b7fe0;font-size:9pt;
            background-size: 100% 100%;
        }
        .show_off span{
            width:18px;height:18px;display: inline-block;  cursor:pointer;
            background-repeat: no-repeat;background-size: 100% 100%;
        }
        .show_off_tag_bg{background-image: url("../../../img/main_img/bold_shadow.png");color:#ffffff;

        }
        .show_on {
            background-image: url("../../../img/main_img/frame1.png");
        }
        .show_on2 {
            background-image: url("../../../img/main_img/frame.png");

        }
        /*滑过一级菜单*/


        .apply_every_logo {
            width:10em;
            text-align: center;
        }
        .contain{
            height: 294px;
        }
        .apply_every_logo:hover {
            background: #e9f3ff;
        }
        .e_title{
            width: 270px!important;
            font-size: 11pt!important;
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
            font-size:11pt;
        }
        .wenjian_list li{
            width:69px !important;
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
            width:60%
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
        .cont_main>ul>li{
            background: #fff!important;
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

        /*#tixing_tab_c ul li {*/
        /*    margin-top: 5px;*/
        /*}*/

        #tixing_tab_c ul li .search_one_all {
            padding: 10px 0px;
            background-color: #e2f0ff;
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
            width: 22px;
            height: 22px;
            margin-left: 17px;
            float: left;
            margin-top: 20px;
        }

        #tixing_tab_c ul li .custom_two > li span {
            height: 40px;
            width: 84%;
            margin-left: 6px;
            overflow: hidden;
            float:right;
            /*white-space: nowrap;*/
            /*text-overflow: ellipsis;*/
            cursor: pointer;
            display: inline-block;
        }

        #tixing_tab_c ul li .custom_two > li label {
            display: inline-block !important;
            margin-bottom: 0px !important;
            font-size: 12px;
            height:20px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        #tixing_tab_c ul li .custom_two > li > span:last-of-type{
            margin-left: 3em;
            height: 20px;
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
        .custom-two-left img{
            margin-top: 0px!important;
        }
        .custom-two-left{
            line-height: 60px!important;

        }
        .custom-two-left img{
            margin-left: 3.8px;
        }
        .mainstyle.blue.actives {
            background: url(/img/replaceImg/replaceThemeskintwo.png) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/skintwo.png',
                    sizingMethod='scale');
        }
        .priv_name{
            margin-left: 0px!important;
        }
        .e_title{
            height:20px;
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
        .e_mail li, .daily li, .tainer li, .new_total li{
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
        .apply_one_all{
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
        .hover{
            background-color: #2B7FE0;
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
        .two_all h1{
            width: 65%;
        }
        #iconCloseAll{
            display: inline-block;
            width: 50px;
            height: 50px;
            background: url("../../img/main_img/icon_closeAll.png") no-repeat;
            position: absolute;
            top: 32px;
            right: 150px;
            cursor: pointer;
            z-index:999999;
        }
        #iconCloseAll:hover{
            background: url("../../img/main_img/icon_closeFloat.png") no-repeat;
        }
        .cont_main ul.total>li{
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2)
        }
        .e_name:hover{
            color: #1b5e8d;
            cursor: pointer;
        }



        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        /*公告*/
        #admin-side0::-webkit-scrollbar,.people_wenjian::-webkit-scrollbar{
            width: 0px;
            height: 16px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        #admin-side0::-webkit-scrollbar-track,.people_wenjian::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        #admin-side0::-webkit-scrollbar-thumb,.people_wenjian::-webkit-scrollbar-thumb{
            width: 0px;
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        /*公告*/
        #admin-side2::-webkit-scrollbar,.people_wenjian::-webkit-scrollbar{
            width: 0px;
            height: 16px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        #admin-side2::-webkit-scrollbar-track,.people_wenjian::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        #admin-side2::-webkit-scrollbar-thumb,.people_wenjian::-webkit-scrollbar-thumb{
            width: 0px;
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
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
        .addOrReduce{
            position:absolute;top:12px;right:6px; width:28px;height:26px;background-size:100% 100%;background-repeat:no-repeat;  cursor:pointer;
        }
        .add_default{  background-image: url('/img/main_img/add_default.png');  }
        .add_click{  background-image: url('/img/main_img/add_click.png');  }
        .add_float{  background-image: url('/img/main_img/add_float.png');  }
        .reduce_click{ background-image: url('/img/main_img/reduce_click.png'); }
        .reduce_default{ background-image: url('/img/main_img/reduce_default.png'); }
        .reduce_float{ background-image: url('/img/main_img/reduce_float.png'); }
        .one_logo{
            margin-top:3%;
        }
        .contain{
            border:none;
        }
        .more{
            top:2px;
            font-size: 12px;
        }
        .sort{
            font-size: 12px;
        }
        .head{
            height: 107px;
            /*background: red;*/
        }
        .choose{
            margin-top:0px;
            margin-left:-8px;
        }
        .gongzuoliu{
            margin-top: 0px;
        }
        .leftSpan{
            top:16px;
        }
        #rightSpan{
            top:16px;
        }
        #iconCloseAll{
            top:3px;
        }
        .header{
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
        .total .bg_head{
            cursor: all-scroll;
        }
        .sort{
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }
        .tab_cone{
            height: 99%!important;
        }
        .he{
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
        .layui-layer-tips{
            box-shadow:1px 1px 14px rgba(000,000,000,0.4);
        }
        .all_ul{
            height:100%!important;
        }
        .s_head, .notice_head, .wenjian_head{
            font-size: 12pt;

        }
        .s_container,.tainer，, .s_cont{
            overflow-y: auto;
            height: 262px;
        }

        .s_container ul li{
            font-size: 11pt;
            padding: 0 5px;
            width: auto;
        }
        /*定义菜单滚动条*/
        .tab_cone::-webkit-scrollbar
        {
            width: 10px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }
        /*定义滚动条轨道 内阴影+圆角*/
        .tab_cone::-webkit-scrollbar-track
        {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        .tab_cone::-webkit-scrollbar-thumb
        {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }

        /*定义菜单滚动条*/
        .tab_ctwo::-webkit-scrollbar
        {
            width: 10px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }
        /*定义滚动条轨道 内阴影+圆角*/
        .tab_ctwo::-webkit-scrollbar-track
        {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        .tab_ctwo::-webkit-scrollbar-thumb
        {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }
        .daily_all li{
            margin-top: 0;
        }
        .total .contain li:hover{
            background: #e8f4fc;
        }
        .custom_num{
            width: 2em !important;
            font-weight: bold;
            color: red;
            font-size: 15px;
        }
        .oneKeyRead{
            float: right;
            margin-top: 5px;
        }
        .cont_rig{
            /*overflow: auto hidden;*/
        }
        .all_content{
            /*min-width: 1100px;*/
            min-width: 1075px;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        #deptOrg::-webkit-scrollbar{
            width: 5px;
            height: 6px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        #deptOrg::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        #deptOrg::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        .chedule_all .chedule_li div{
            font-size: 11pt;
        }
        .three .erji_circle{
            margin-left:47px;
        }
        .er_img{
            margin-left: 0;
        }
        .three .er_img{
            margin-left:0px;
        }
        .siji img{
            margin-left:64px;
        }
        .three_change.activesanji{
            background: rgba(0,0,0,.15)!important;
        }
        .siji .four{

            height: 38px!important;
            line-height: 38px;
            width: 97%!important;
            margin: 0 auto;
            border-radius: 3px;

        }

        .four_change {
            background: url(/img/main_img/theme6/menuchang.png) no-repeat!important;
        }

        .weather{
            position: absolute;
            top: 0px;
            right:9px;
            color:#fff;
            font-size:13pt;
        }
        .weather span{
            padding:0 3px;
        }
        .timeDate span{
            padding:0 6px;
        }
        .time{
            font-size:15pt;
            font-weight:bold;
        }
        .area{
            font-weight:bold;
        }
        .headTitle{
            color:#fff;
            font-size:12pt!important;
            position: absolute;
            left:10px;
            bottom:10px;
            display: none;
            width: 217px;
            overflow: hidden;
            white-space: nowrap;
            line-height: 33px;
        }
        .head_left font{
            padding-left:1%;
            line-height:55px;

            display: inline-block;
            vertical-align: middle;
            margin-top: 5px;
        }
        .daibans{
            height: 262px;
            background: #fff;
            /*box-shadow: 0 2px 6px rgba(0,0,0,0.2)*/
        }
        .daibans li{
            list-style: none;
        }
        .fl{float:left}
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
        .yingy{
            background: none;
            line-height: 23px;
        }
        .top_ul li {
            width: 50px;
            line-height: 23px;
        }
        .QRCode{
            width: 185px;
            height: 185px;
            position: absolute;
            top: 72px;
            right: -89px;
            z-index: 99;
            padding: 5px;
            border: #ccc 1px solid;
            background-color: #fff;
            -webkit-box-shadow:0 0 6px 3px #999;
            -moz-box-shadow:0 0 6px 3px #999;
            box-shadow:6px 6px 16px -3px #20395c;
        }
        .topBar{
            display: inline-block;
            margin: 0px 10px;
        }
        .apply_name{
            font-weight: bold;
            text-align: left;
            margin-left: 10px;
            font-size: 18px;
        }
        .custom-two-mid h1{
            height:50px;
            text-align: left;
            font-size: 17px;
            margin-left: 9px!important;
            color: #0088cc;
            font-weight: bold;

        }
        .custom_two li{
            height: 70px!important;
            width: 100%!important;
        }
        #tixing_tab_c{
            height: 93%;
        }
        .custom-two-left
        {
            width: 10%;
            margin-left: 15px;
        }
        .apply_num{
            width: 2em !important;
            font-weight: bold;
            color: red;
            font-size: 15px;
        }
        #task_center{
            margin-top: 0;
        }
        #sns{
            margin-top: 0;
        }
        #help{
            margin-top: 0;
        }
        #theme{
            margin-top: 0;
        }
        .header ul li{
            margin: 0;
            min-width:0
        }
        .header ul li span:hover{
            /*background: #B3DAFF !important;*/
            border-radius: 4px;
            /*color: #fff !important;*/
            box-shadow: 0 0 5px #47a4fb;
        }
        .head_title{
            margin: 7px 7px;
        }
        .header ul li:first-child{
            margin-left:14px;
        }
        #refurbish,#shezhi{
            background: #0d79ab ;
            padding: 0 3px;
            border: 1px solid #0d79ab ;
            border-radius: 4px;
        }
        .topBars{
            display: inline-block;
            margin: 0px 10px;
        }
        .custom_name{
            font-weight: bold;
            text-align: left;
            margin-left: 10px;
            font-size: 18px;
        }
        .windowopen{
            font-weight: bold;
            font-size: 14px;
        }
        #admin-side0 .search_apply .custom_two li:hover{
            background-color: #e2f0ff;
        }
        #admin-side0 .search_custom .custom_two li:hover{
            background-color: #e2f0ff;
        }
        .overTimeTips{
            width: 500px;
            background: #678fc9;
            position: absolute;
            top: 50%;
            margin: 0 auto;
            /* z-index: 999; */
            right: 0;
            left: 0;
            height: 300px;
            color: white;
            font-size: 16px;
            margin-top: -150px;
        }
        .per_all h1 {
            display: flex;
            justify-content: center;
        }
        .per_all h2 {
            display: flex;
            justify-content: center;
        }
        .per_all h3 {
            display: flex;
            justify-content: center;
        }
        .textSpan {
            width: 60px;
            text-align: left;
        }
        .contentSpan {
            width:170px;
            text-align: left;
        }
    </style>
    <style>
        body .ieTips .layui-layer-title{
            background: #4476A7;
            color: #fff;
            border: none;
        }
        body .ieTips .ieTipsText{
            padding: 20px;
            line-height: 24px;
            word-break: break-all;
            overflow: hidden;
            font-size: 14px;
            overflow-x: hidden;
            overflow-y: auto;
        }
    </style>
    <script>
        $.ajax({
            type:'post',
            url:'/sys/noRegisterInfo',
            dataType:'json',
            success:function(res){
                if (res.flag) {
                    var data = res.object;
                    var diskCapacity = res.data;
                    if(diskCapacity&&diskCapacity<1024){
                        layer.open({
                            title: '<fmt:message code="main.th.diskSpaceInsufficientReminder" />',
                            content: '<fmt:message code="main.th.diskSpaceInsufficientReminderContent" />'
                        });
                        return;
                    }
                    if(data == -1){
                        $('.overTimeTips').css('display','block')
                        $('.fullbody').css('pointer-events','none')
                        $('.countdown').css('display','none')
                    }else if(data > -1 && data != 99999999){
                        $('.residue').text(data)
                        $('.overTimeTips').css('display','block')
                        var myVar = setInterval(function(){
                            var num=$(".countTime").text();
                            num--;
                            $(".countTime").text(num);
                            if(num==0){
                                clearInterval(myVar);
                                $('.overTimeTips').css('display','none')
                            }

                        }, 1000);
                    }
                    // else if(data == 99999999){
                    //     $('.overTimeTips').css('display','none')
                    // }
                }
            }
        })
        initTopUlStyle();
        function initTopUlStyle() {
            var theme = '${sessionScope.InterfaceModel}';
            var str_css = '';
            var style=document.createElement("style");
            style.type="text/css";

            switch (theme) {
                case 'theme1':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #0a6d9d;}.yingy{background-color: #e6aa57;}';
                    break;
                case 'theme2':
                    str_css = '.top_ul{border: 1px solid #a1171e;background-color: #c2333a;}.yingy{background-color: #ffd940;}';
                    break;
                case 'theme3':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #e9f5fb;}.yingy{background-color: #3191e5;}';
                    break;
                case 'theme4':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #e9f5fb;}.yingy{background-color: #24d47e;}';
                    break;
                case 'theme5':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #e9f5fb;}.yingy{background-color: #03682d;}';
                    break;
                case 'theme6':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #0a6d9d;}.yingy{background-color: #eab765;}';
                    break;
                case 'theme7':
                    str_css = '.top_ul{border: 1px solid #a1171e;background-color: #c2333a;}.yingy{background-color: #ffd940;}';
                    break;
                case 'theme20':
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #0a6d9d;}.yingy{background-color: #e6aa57;}';
                    break;
                default:
                    str_css = '.top_ul{border: 1px solid #02557d;background-color: #0a6d9d;}.yingy{background-color: #e6aa57;}';
                    break;
            }
            style.innerHTML=str_css;
            document.getElementsByTagName("head").item(0).appendChild(style);
        }
        function opensload() {

            if($('[src="workflow/work/workList"]').length!=0){
                $('[src="workflow/work/workList"]').prop('src','workflow/work/workList');
            }
            if($('[src="/document/makeADraft"]').length!=0){
                $('[src="/document/makeADraft"]').prop('src','/document/makeADraft');
            }
            if($('[src="document/inAbeyance"]').length!=0){
                $('[src="document/inAbeyance"]').prop('src','document/inAbeyance');
            }
            if($('[src="attendPage/backlogAttendLeave"]').length!=0){
                $('[src="attendPage/backlogAttendLeave"]').prop('src','attendPage/backlogAttendLeave');
            }
        }
        function iebg() {
            if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.split(";")[1].replace(/[ ]/g, "") == "MSIE8.0") {
                $('.mainstyle').css('background', '#fff')
            }
        }
        function urlnewworkflow() {
            $('#tab_cTwo [url="workflow/work/addwork"]').click();
        }



        $(function () {
            $.ajax({
                type:'post',
                url:'/portals/selPortalsById?portalsId=1',
                // url:'/infoCenter/getInfoCenterOrder',
                dataType:'json',

                success:function(res){
                    if (res.flag) {
                        // var data = res.data.split(",");
                        var data = res.object.portalsShow.split(",");
                        for (var i = 0; i < data.length; i++) {
                            if(data[i]!=''){
                                var add = $('#myTableGet').find('#'+data[i])
                                $(".total").append(add);
                            };
                        }
                        $("#myTableGet").remove();


                        $('.total').css('display','block');
                    }
                    $('.total>li').arrangeable({
                        dragSelector: '.bg_head'
                    });
                }
            })
            $('.total>li>.bg_head').css('cursor',' pointer');

//            var sessionTypeStr = $('[name="sessionType"]').val();
//            if (sessionTypeStr.indexOf('1') != -1) {
//                $('.blue').addClass('actives')
//            } else if (sessionTypeStr.indexOf('2') != -1) {
//                $('.reds').addClass('actives')
//            } else if (sessionTypeStr.indexOf('3') != -1) {
//                $('.chenjing').addClass('actives')
//            }else if (sessionTypeStr.indexOf('4') != -1) {
//                $('.green').addClass('actives')
//            }else if (sessionTypeStr.indexOf('5') != -1) {
//                $('.dark_green').addClass('actives')
//            }
            iebg()
//            $('.subjectToUse').click(function () {
//                var typedata = $(this).find('a').attr('data-type')
//                $.get('/users/addAndApplicationUsers', {theme: typedata}, function (json) {
//                    if (json.flag) {
//                        $.layerMsg({content: '修改成功！', icon: 1}, function () {
//                            location.reload()
//                        });
//                    }
//                })
//            })
            $('.register').click(function(){
                window.open('/sys/sysInfo');
            })
            $('.subjectToUse').click(function () {
                var menuExpand=''
                $.ajax({
                    type: "post",
                    url: "/users/getUserTheme",
                    dataType:'json',
                    data:'',
                    async:false,
                    success:function(res){
                        menuExpand=res.object.menuExpand
                    }
                })
                var typedata = $(this).find('a').attr('data-type')
                $.get('/users/addAndApplicationUsers', {theme: typedata,menuExpand:menuExpand}, function (json) {
                    if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="menuSSetting.th.editSuccess" />！', icon: 1}, function () {
                            location.reload()
                        });
                    }
                })
            })
        })

    </script>
    <script src="/lib/audiojs/audio.min.js?20201218.1"></script>

</head>
<body>

<div class="fullbody">
    <div style="display: none" id="callSound">
        <audio src="/lib/audiojs/audio1.MP3"  id="audios" preload="auto" />
    </div>
    <div id="allmap" style="width: 100%;height: 500px;display: none"></div>
    <div class="posifixed" id="fixedBody" style="display: none">
        <div style="position:fixed;width:200px;height:250px;left:50%;margin-left:-100px;top: 50%;margin-top: -229px;">
            <img style="width:100%;height:200px;" src="" class="personSrc" />
            <span style="color: #fff;display: block;text-align: center;line-height: 77px;font-size: 26px;" >
            <img src="/img/main_img/people.png" style="vertical-align: initial;margin-right: 6px;"/>
            <span class="wybzd"></span>
        </span>
        </div>
        <div class="posifixedCenter" style="    margin-top: 65px;margin-left: -119px;">
            <label><input id="theLocks" type="password" style="height:27px;    width: 224px;" placeholder="<fmt:message code="main.th.unlockCode" />" style="margin-right: 10px;">
                <span id="theLock" style=" right: -17px;top: 0px;width: 38px;height: 37px;line-height: 35px;border-radius: 4px;text-align:center;">
                <img src="/img/main_img/icon_lock.png" />
            </span>
            </label>
        </div>
    </div>
    <div class="wrap">

        <div class="head" id="headID" style="position: relative">

            <div class="head_left" style="float: none;height: 61px;width: 100%;position:relative;">
                <input type="hidden" value="${sessionScope.InterfaceModel}" name="sessionType" id="sessionType"/>
                <input type="hidden" name="logosession" value="/img/replaceImg/${sessionScope.InterfaceModel}/LOGOMain.png"/>
                <%--<img src="${LogoImg}" style=" margin-top: 11px;margin-left: 1%;height: 61px"/>--%>
                <%--<font style=""></font>--%>
                <c:choose>

                    <c:when test="${bannerText!=''&&bannerText!=undefined}">
                        <font style="${bannerFont}">${bannerText} <span class="secretText" style="${bannerFont} color: red;font-weight: bold;">机密级★ </span></font>

                    </c:when>
                    <c:otherwise>
                        <img src="${LogoImg}" style=" margin-top: 11px;margin-left: 11px;height: 61px" id="qipilang"/>
                        <span class="secretText" style="vertical-align:middle;display:none;color:red; font-size: 22pt; font-family: Microsoft yahei;font-weight: bold">机密级★ </span>
                    </c:otherwise>
                </c:choose>

            </div>
            <div class="headTitle"></div>
            <div class="head_mid" style="position: relative;float: none;height: 39px;margin-left:206px;margin-top: 7px">
                <span id="leftSpan" class="leftSpan" style="display: none"></span>
                <span id="rightSpan" style="display: none"></span>
                <span id="iconCloseAll" style="display: none;" title="<fmt:message code="main.th.closeAllTabs" />"></span>
                <div class="main_title" style="margin-left:20px;;overflow: hidden;position: relative;text-align: center">
                    <ul style="position: absolute;left: 0px;top: 0px;bottom: 0px">
                        <li class="gongzuoliu" left='0' id='t_0' title='<fmt:message code="global.my.Desktop" />'>
                            <h1><fmt:message code="global.my.Desktop"/></h1>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="weather">
                <div class="timeDate" style="margin-top: 4px;text-align: right">
                    <span class="date"></span>
                    <span class="week"></span>
                    <span class="time"></span>
                </div>
                <div class="weatherC" style="margin-top: -2px;text-align: right">
                    <span class="area"></span>
                    <span class="weatherImg"><img src="" alt="" style="width:27px"></span>
                    <span class="weatherText"></span>
                    <span class="du"></span>
                    <span class="">  <span class="zl"></span><span class="zlNum"></span></span>
                </div>

            </div>


            <!-- 右侧的小logo -->
            <div id="taskbar_right" class="head_rig" style="position: absolute;margin-top: 5px;width: auto;right: 0;top: 30px;height: 72px;z-index: 1001;">
                <div class="topBar AndroidMove " style="position: relative;">
                <span class="iconT" style="display: inline-block;">
                    <a id="Android"   hidefocus="hidefocus" title="<fmt:message code="main.th.androidDownload" />" dataVal="0"
                       data-step="" data-intro=""
                       data-position="left">
                </a>
                </span>
                    <div class="QRCode codeT" style="display: none">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;height: 90%"
                             src="/img/main_img/theme6/AndroidDesk.png"/>
                    </div>
                </div>
                <div class="topBar iosMove " style="position: relative;">
                <span class="iconH" style="display: inline-block;">
                    <a id="ios"   hidefocus="hidefocus" title="<fmt:message code="main.th.iosDownload" />" dataVal="0"
                       data-step="" data-intro=""
                       data-position="left">
                </a>
                </span>
                    <div class="QRCode codeH" style="display: none">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;height: 90%"
                             src="/img/main_img/theme6/iosDesk.png"/>
                    </div>
                </div>
                <div class="topBar topLogo">
                    <a id="task_center"  class="task_centerActive" hidefocus="hidefocus" title="<fmt:message code="workflow.th.sousuo" />" dataVal="0"
                       data-step="5" data-intro=""
                       data-position="left" ></a>
                </div>
                <div class="topBar topLogo location">
                    <a id="sns" style="position: relative" class="task_centerActive" hidefocus="hidefocus" title="<fmt:message code="sms.th.remind" />" data-step="6" dataVal="0"
                       data-intro="" data-position="left"></a>
                </div>
                <%--            <div class="topBar">--%>
                <%--                <a style="position: relative" id="community" class="task_centerActive" hidefocus="hidefocus" title="社区入口" data-step="11" dataVal="0"--%>
                <%--                   data-intro="" data-position="left"></a>--%>
                <%--            </div>--%>
                <div class="topBars" id="shequLogo" lay-filter="layadmin-layout-right">
                    <a class="task_centerActive" id="community" title="<fmt:message code="main.th.community" />" hidefocus="hidefocus" data-step="11" dataVal="0" data-position="left"  >
                    </a>
                </div>


                <div class="topBar topLogo" isTheme="true">
                    <a id="help" class="task_centerActive" hidefocus="hidefocus" title="<fmt:message code="email.th.main" /> " data-step="7" dataVal="0"
                       data-intro="" data-position="left"
                       target="_blank"></a>
                </div>
                <div class="topBar topLogo">
                    <a id="theme" class="task_centerActive" hidefocus="hidefocus" title="<fmt:message code="main.cancellation" />" data-step="9" dataVal="0"
                       data-intro=""
                       data-position="left"></a>
                </div>
                <div class="topBar topLogo">
                    <a id="back" class="task_centerActive" hidefocus="hidefocus" title="" data-step="10" dataType = '0' dataVal="0"
                       data-intro=""
                       data-position="left"></a>
                </div>

            </div>

        </div>



        <div class="cont" id="client" style="position: relative;height:calc(100% - 50px)">
            <ul class="side_all">
                <li class="position" id="admin-side0" style="overflow-y: auto">
                    <div class="skin">
                        <h2 style="width: 90%;height:100%;line-height: 45px;text-align: center;font-size: 16pt;font-weight: bold;">
                            <fmt:message code="workflow.th.sousuo"/>
                        </h2>
                        <img id="go_back" src="img/main_img/close.png" alt=""
                             style="margin-top: 15px;cursor:pointer">
                    </div>
                    <div style="background:#fff;height: 57px;">
                        <input type="text" id="searchText" class="huiqian_inp">
                        <button class="huiqian_send" id="index_find"><fmt:message code="workflow.th.sousuo"/></button>
                    </div>
                    <div class="search_cont">
                        <ul class="search-cont-cus">
                            <li class="search_custom">
                                <div class="search_one_all" style="height: 35px"><img class="custom_photo" src="img/main_img/custom.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="journal.th.user"/></h1>
                                    <img src="img/main_img/cus_open.png" class="custom_close" alt="">
                                    <h2 id="userSearchNum" class="custom_num"></h2>

                                </div>
                                <div class="search_two_all">
                                    <ul class="custom_two">
                                        <%--111--%>
                                    </ul>
                                </div>
                            </li>
                            <li class="search_apply">
                                <div class="apply_one_all"><img class="apply_photo" src="img/main_img/apply.png" alt="">
                                    <h1 class="apply_name"><fmt:message code="global.lang.apply" /></h1>
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
                <li class="position" id="admin-side1">
                    <div class="skin" style="position: relative;">
                        <img class="reloadSide" src="/img/icon_refresh_10.png"
                             style="position: absolute;left: 16px;top: 13px;cursor: pointer" alt="">
                        <h2 style="width: 90%;height:100%;line-height: 45px;text-align: center;font-size: 16pt;font-weight: bold;">
                            <fmt:message code="notice.th.reminder" /></h2>
                        <img id="go_back" src="img/main_img/close.png" alt="" style="margin-top: 15px;">
                    </div>
                    <div id="tixing_tab_c">
                        <ul class="search-cont-cus">

                            <li class="search_custom" id="emailId" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="notice.th.mail"/>
                                    </h1>

                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSease" class="custom_num"></h2>
                                    <img class="oneKeyRead read_1" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="emailAll">

                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom" id="emailPlusId" style="">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.emailIntercommunication" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSeasePlus" class="custom_num"></h2>
                                    <img class="oneKeyRead read_2" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="emailPlusAll">
                                    </ul>
                                </div>
                            </li>

                            <li class="search_custom" id="bbsBoardId" style="">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.createANewDiscussionArea" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSeaseFive" class="custom_num"></h2>
                                    <img class="oneKeyRead read_2" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="bbsBoardAll">

                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="img/newspaper.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.news"/></h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSeasenew" class="custom_num"></h2>
                                    <img class="oneKeyRead read_3" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="newsAll">
                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_announcement.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="notice.th.notice"/></h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSeaseTwo" class="custom_num"></h2>
                                    <img class="oneKeyRead read_4" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="notifyAll">
                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_backlog.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.workflow"/>
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="userSeasethree" class="custom_num"></h2>
                                    <img class="oneKeyRead read_5" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="workFlowAll">
                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom" id="documentToDoObj">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="email.th.document"/>
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="docunmentSeasethree" class="custom_num"></h2>
                                    <img class="oneKeyRead read_6" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="documentToDoList">
                                    </ul>
                                </div>
                            </li>
                            <li class="search_custom" id="toupiao">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/toupiao.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="vote.th.vote"/>
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="toupiao1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_7" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="toupiaourl">
                                    </ul>
                                </div>
                            </li>
                            <%--督察督办--%>
                            <li class="search_custom" id="duchaduban" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/duchaduban.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.supervisionAndFollowUp" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="duchaduban1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_8" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="duchadubanurl">

                                    </ul>
                                </div>
                            </li>
                            <%--工资薪资--%>
                            <li class="search_custom" id="wagesManager"  style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.jobSalary" />
                                    </h1>

                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="wagesManager1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_41" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="worksalary">

                                    </ul>
                                </div>
                            </li>
                            <%--个人考勤--%>
                            <li class="search_custom" id="attendanceManager" >
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.attendance" />
                                    </h1>

                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="attendanceManager1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_42" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="attendance1">

                                    </ul>
                                </div>
                            </li>
                            <%--会议--%>
                            <li class="search_custom" id="huiyi" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/huiyi.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="email.th.meeting" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="huiyi1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_9" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="huiyiurl">

                                    </ul>
                                </div>
                            </li>
                            <%--日程--%>
                            <li class="search_custom" id="richeng" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/richeng.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.schedule" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="richeng1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_10" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="richengurl">

                                    </ul>
                                </div>
                            </li>
                            <%--日志--%>
                            <li class="search_custom" id="rizhi" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.worklog" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="rizhi1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_11" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="rizhiurl">

                                    </ul>
                                </div>
                            </li>
                            <%--领导活动--%>
                            <li class="search_custom" id="leaderActiv" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/leaderActiv.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="event.th.LeadershipActivitiesArrangement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="leaderActiv1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_12" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="leaderActivurl">

                                    </ul>
                                </div>
                            </li>

                            <%--办公用品申领事务提醒--%>
                            <li class="search_custom" id="bangongyongpinshenling" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/bangongyongpinsl.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="work.th.workApply" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="bangongyongpinshenling1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_13" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="bangongyongpinshenlingurl">

                                    </ul>
                                </div>
                            </li>

                            <%--公共文件柜--%>
                            <li class="search_custom" id="publicFile" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/publicFile.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.public" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="publicFile1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_14" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="publicFileurl">

                                    </ul>
                                </div>
                            </li>

                            <%--网络硬盘--%>
                            <li class="search_custom" id="networkDisk" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/networkDisk.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.network" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="networkDisk1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_15" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="networkDiskurl">

                                    </ul>
                                </div>
                            </li>
                            <%--值班管理--%>
                            <li class="search_custom" id="zhiban" style="display: block">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/zhiban.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.dutyManagement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="zhibanS" class="custom_num">2</h2>
                                    <img class="oneKeyRead read_16" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="zhibang">

                                    </ul>
                                </div>
                            </li>
                            <%--人员调度--%>
                            <li class="search_custom" id="dispatcher" style="display: block">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/dispatcher.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.personnelScheduling" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="dispatcherS" class="custom_num"></h2>
                                    <img class="oneKeyRead read_17" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="dispatcherUrl">

                                    </ul>
                                </div>
                            </li>
                            <%--第三方系统--%>
                            <li class="search_custom" id="thirdSystem" style="display: block">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/thirdSystem.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.thirdPartySystem" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="thirdSystemS" class="custom_num"></h2>
                                    <img class="oneKeyRead read_18" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="thirdSystemUrl">

                                    </ul>
                                </div>
                            </li>

                            <%--培训计划管理--%>
                            <li class="search_custom" id="traPlan" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 26px;"
                                         src="/img/schedule/remind.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="event.th.TrainingManagement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="tranPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_19" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="tranPlanList">

                                    </ul>
                                </div>
                            </li>

                            <%--任务管理--%>
                            <li class="search_custom" id="taskManage" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.taskManagement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="taskManagePlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_24" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="taskManageList">

                                    </ul>
                                </div>
                            </li>

                            <%--车辆申请--%>
                            <li class="search_custom" id="carApproval" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.vehicleApplication" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="carApprovalPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_25" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="carApprovalList">

                                    </ul>
                                </div>
                            </li>
                            <%--好视通视频会议--%>
                            <li class="search_custom" id="hstMeeting" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.HSTVideoConference" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="hstMeeting1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_26" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="hstMeetingurl">

                                    </ul>
                                </div>
                            </li>

                            <%--资格证书管理--%>
                            <li class="search_custom" id="crmcertificate" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.qualificationCertificateManagement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="crmcertificate1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_34" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="crmcertificateurl">

                                    </ul>
                                </div>
                            </li>

                            <%--                            系统类型--%>
                            <li class="search_custom" id="sysTypeList" style="display: none;">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;" src="/img/sidebar_icon_remind_email_14.png" alt="">
                                    <h1 class="custom_name">系统类型
                                    </h1>

                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="useSysType" class="custom_num"></h2>
                                    <img class="oneKeyRead read_43" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none;">
                                    <ul class="custom_two" id="sysTypeAll">

                                    </ul>
                                </div>
                            </li>

                            <%--固定资产--%>
                            <li class="search_custom" id="assetsId" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name">固定资产
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="assetsId1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_28" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="assetsIdurl">

                                    </ul>
                                </div>
                            </li>

                            <%--讨论区--%>
                            <li class="search_custom" id="bbscomment" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name">讨论区
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="bbscommentPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_27" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="bbscommentList">

                                    </ul>
                                </div>
                            </li>

                            <%--合同管理--%>
                            <li class="search_custom" id="contractremind" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="hr.th.contractManagement" /></h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="contractremindPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_28" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="contractremindList">

                                    </ul>
                                </div>
                            </li>

                            <%--制度管理--%>
                            <li class="search_custom" id="institutioncontent" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name">制度管理</h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="institutioncontentPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_29" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="institutioncontentList">

                                    </ul>
                                </div>
                            </li>

                            <%--公安局值班管理--%>
                            <li class="search_custom" id="onDuty" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/rizhi.png" alt="">
                                    <h1 class="custom_name">公安局值班管理</h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="onDutyPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_30" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="onDutyList">

                                    </ul>
                                </div>
                            </li>

                            <%--即会通视频会议--%>
                            <li class="search_custom" id="jhtmeeting" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/huiyi.png" alt="">
                                    <h1 class="custom_name">即会通视频会议
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="jhtmeeting1" class="custom_num"></h2>
                                    <img class="oneKeyRead read_31" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="jhtmeetingurl">

                                    </ul>
                                </div>
                            </li>





                            <%--中电建网报事物提醒--%>
                            <li class="search_custom" id="onlineReimbursementSystem" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name">网上报销
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="onlineReimbursementSystemPlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_32" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="onlineReimbursementSystemList">

                                    </ul>
                                </div>
                            </li>

                            <%--计划考核事物提醒--%>
                            <li class="search_custom" id="planManageBox" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name">计划管理
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="planManagePlan" class="custom_num"></h2>
                                    <img class="oneKeyRead read_33" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="planManageList">

                                    </ul>
                                </div>
                            </li>
                            <%--考核模块事务提醒--%>
                            <li class="search_custom" id="assessmentBox" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name">考核
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="assessments" class="custom_num"></h2>
                                    <img class="oneKeyRead read_33" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="assessmentList">

                                    </ul>
                                </div>
                            </li>

                            <%--党建提醒--%>
                            <li class="search_custom" id="partyMemberBox" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                                         src="/img/task/taskremind.png" alt="">
                                    <h1 class="custom_name">智慧党建
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="partyMember" class="custom_num"></h2>
                                    <img class="oneKeyRead read_36" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="partyMemberList">

                                    </ul>
                                </div>
                            </li>

                            <%--证照管理--%>
                            <li class="search_custom" id="zjgl" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/richeng.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="license.management" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="license" class="custom_num"></h2>
                                    <img class="oneKeyRead read_37" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="licenseList">

                                    </ul>
                                </div>
                            </li>

                            <%--EHR待办工作提醒--%>
                            <li class="search_custom" id="dbgz" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/sidebar_icon_remind_backlog.png" alt="">
                                    <h1 class="custom_name">EHR待办工作
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="ehrWork" class="custom_num"></h2>
                                    <img class="oneKeyRead read_38" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="ehrWorkList">

                                    </ul>
                                </div>
                            </li>

                            <%--理论学习管理--%>
                            <li class="search_custom" id="llxx" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/study.png" alt="">
                                    <h1 class="custom_name">理论学习管理
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="study" class="custom_num"></h2>
                                    <img class="oneKeyRead read_38" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="study1">

                                    </ul>
                                </div>
                            </li>
                            <%--密码设置管理--%>
                            <li class="search_custom" id="mmsz" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/psd.png" alt="">
                                    <h1 class="custom_name"><fmt:message code="main.th.passwordSettingManagement" />
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="password" class="custom_num"></h2>
                                    <img class="oneKeyRead read_39" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="password1">

                                    </ul>
                                </div>
                            </li>
                            <%--员工关怀信息--%>
                            <li class="search_custom" id="yggh" style="display: none">
                                <div class="search_one_all">
                                    <img class="custom_photo" style="margin-top: 3px;"
                                         src="/img/mine_heart.png" alt="">
                                    <h1 class="custom_name">员工关怀信息
                                    </h1>
                                    <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                                    <h2 id="staffCare" class="custom_num"></h2>
                                    <img class="oneKeyRead read_40" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                                </div>
                                <div class="search_two_all" style="display: none">
                                    <ul class="custom_two" id="staffCare1">

                                    </ul>
                                </div>
                            </li>
                        </ul>
                        <div class="noReminding" style="text-align: center;width: 100%;display: none;">
                            <img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">
                            <h2 style="text-align: center;color: #666;"><fmt:message code="main.th.noReminderForNow" /></h2>
                        </div>
                    </div>
                </li>
                <%--<li class="position" id="admin-side2" style="overflow-y: auto">--%>
                <li class="position" id="admin-side2" >
                    <div class="skin">
                        <h2 style="width:88%;height:100%;line-height: 45px;text-align: center;font-size: 10pt;font-weight: bold;">
                            <fmt:message code="main.th.Skinpeeler"/>
                        </h2>
                        <img id="go_back" src="img/main_img/close.png" alt="" style="margin-top: 15px;">
                    </div>
                    <div class="mainstyle twentyportal">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="20"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                    <div class="mainstyle bluetwo">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="6"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                    <div class="mainstyle redstwo">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="7"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                    <div class="mainstyle chenjing">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="3"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                    <div class="mainstyle green">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="4"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                    <div class="mainstyle dark_green">
                        <div class="subjectToUse">
                            <a href="javascript:void (0)" data-type="5"><fmt:message code="main.th.immediateUse" /></a>
                        </div>
                    </div>
                </li>
                <li class="position" id="admin-side3" style="z-index: 19991018;display: none">
                    <div class="per_back">
                        <img id="go_back" class="yonghu_img" src="img/main_img/close.png" alt="" style="margin-top: 10px;">
                        <div class="per_all" style="width:100%;">
                            <div style="width: 50px;height:50px;margin:auto;">
                                <img onerror="imgerror(this,1)" class="yonghu_touxiang"  alt="" style="border-radius: 100%;width: 100%;height: 100%;">
                            </div>
                            <h1>s</h1>
                            <h3 id="deptInfo"></h3>
                            <h2 class="juede_suopings" style="margin-top: -12px"></h2>
                            <h2 class="juede_suoping" style="margin-top: -8px;display: none"></h2>
                            <h2 id="zdjShow"></h2>
                            <h3 id="user_secrecy"></h3>
                            <%--<h2 style="width: 255px;margin: 0 auto;"></h2>--%>
                        </div>
                    </div>
                    <button class="per_shezhi">
                        <div class="button_img shezhi_img"></div>
                        <span class="button_span"><fmt:message code="main.th.Set"/></span>
                    </button>
                    <button class="per_suoding">
                        <div class="button_img suoding_img"></div>
                        <span class="button_span"><fmt:message code="main.th.locking"/></span>
                    </button>
                    <label style="display: none">
                        <input type="password" style="margin-left: 44px; width: 160px;border-top-right-radius: 0px;
                    border-bottom-right-radius: 0px;"
                               name="lockCode" placeholder="<fmt:message code="main.th.lockPassword" />">
                        <span id="LockCode" style="vertical-align: top;height: 30px;display: inline-block;width: 31px;text-align: center;line-height: 27px;border-top-right-radius: 6px;border-bottom-right-radius: 6px;">
                        <img src="/img/main_img/locktwos.png" alt="">
                    </span>
                    </label>
                    <button class="per_zhuxiao" id="per_zhuxiao">
                        <div class="button_img zhuxiao_img"></div>
                        <span class="button_span"><fmt:message code="main.cancellation"/></span>
                    </button>
                </li>
            </ul>

            <div class="cont_left" style="box-sizing: border-box;position: relative">

                <ul class="all_ul">
                    <div class="tab_t tab_tTwo" id="tab_tTwo" style="position: relative;">
                        <ul class="top_ul">
                            <li class="yingy" id="use"><fmt:message code="global.lang.apply"/></li>
                            <li id="commonSetting"><fmt:message code="main.th.inCommonUse" /></li>
                            <li id="orgnize" style=""><fmt:message code="global.lang.tissue"/></li>
                        </ul>
                        <div   id="zd_menu" class="addOrReduce reduce_default"  ></div>
                    </div>
                    <div class="tab_c list tab_cTwo" id="tab_cTwo">
                        <ul class="tab_cone a yiji">
                        </ul>
                        <%--<div class="pickCompany">--%>
                        <%--<div style="padding-left: 16px;" class="childdept">--%>
                        <%--<img src="/img/commonTheme/theme6/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">--%>
                        <%--<a href="javascript:void(0)" class="dynatree-title" title="desegf">desegf</a>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                        <ul class="tab_ctwo a" id="deptOrg" style="display:none;min-width:100%;overflow-y:auto;white-space: nowrap;">
                            <div class="pickCompany" style="width: 100%;">
                            <span style="height:30px;margin-top: 5px;line-height:35px;width: 100%;display: inline-block;position: relative;" class="childdept">
                                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="position: absolute;top: 9px;width: 15px;margin-right: 1px;margin-left: 6px;">
                                <a href="javascript:void(0)" class="dynatree-title" title="" style="width: 84%;display: inherit;margin-left: 25px;margin-top: 0;    line-height: 22px;"></a>
                            </span>
                            </div>
                        </ul>
                        <ul class="tab_cthree" id="tab_cthree" style="display: none;overflow-x: hidden">
                            <a  id="refurbish" style="position: absolute;bottom: 4px;right: 50px;margin-right: 10px; margin-top:8px;font-size: 14px;color: white;cursor:pointer;float:right;font-family:Microsoft YaHei;"><fmt:message code="global.lang.refresh" /></a>
                            <a  id="shezhi"  style="position: absolute;bottom: 4px;right: 1px;margin-right: 18px;  margin-top:8px;font-size: 14px;color: white;cursor:pointer;float:right;font-family:Microsoft YaHei;"><fmt:message code="main.th.Set" /></a>
                            <ul class="ceshi" id="ceshi">

                            </ul>
                        </ul>

                        <%--                    <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu"--%>
                        <%--                        lay-filter="layadmin-system-side-menu">--%>

                        <%--                    </ul>--%>
                    </div>
                </ul>
            </div>





















            <div class="cont_rig" style="box-sizing: border-box;padding-bottom: 10px;">
                <div class="all_content" style="width:100%;height:100%;">
                    <!-- 我的桌面 -->
                    <div id='f_0' class="iItem">
                        <!-- <div class="wrapper"> -->
                        <div id="welcome" style="width: 100%;height: 100%;text-align: center">
                        </div>
                        <div class="header">
                            <ul style="width: 92%;float: left;white-space: nowrap;overflow-x: auto;">
                            </ul>
                            <div style="float: right;margin-right: 20px;
                        cursor: pointer;width: 30px;margin-top: 12px;" class="reloads" title="<fmt:message code="main.th.portalRefresh" />">
                                <img src="/img/icon_refresh_10.png" alt="">
                            </div>
                            <div id="setPersonal_ZDJ" style="display: none;float: right; width: 19px;margin: 13px 10px 0 0;cursor: pointer;" title="<fmt:message code="main.th.personalPortalSettings" />">
                                <img src="/img/main_img/index/setting.png" alt="">
                            </div>
                            <div id="setFullScreen_ZDJ" style="display: none;float: right; width: 19px;margin: 13px 10px 0 0;cursor: pointer;" title="<fmt:message code="main.th.clickToEnterFullScreen" />">
                                <img src="/img/main_img/index/full_screen.png" alt="">
                            </div>
                        </div>
                        <div id="myTableGet" style="display:none">

                            <%--公告--%>
                            <li id="01" class="contain middle con_notice">
                                <div class="notice_head bg_head">
                                <span class="s_head_top">
                                </span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/announce.png" alt="">
                                    <span class="model"><fmt:message code="notice.th.notice"/>
                                </span>
                                    <ul class="notice_list" id="notice_listTwo">
                                        <li class="head_title sort active actives" data-bool="" onclick="announcement(this)" id="all_notice" style="width: 38px;">
                                            <fmt:message code="notice.th.all"/>
                                        </li>
                                    </ul>
                                    <span class="more_notice" tid="0116" url="/notice/allNotifications">
                                	<a style="    color: #fff;">
                                		<fmt:message code="email.th.more"/>
                                	</a>
                                </span>
                                </div>
                                <div class="tainer">
                                    <ul class="notify no_read_notice_two">
                                    </ul>
                                </div>
                            </li>
                            <%--新闻--%>
                            <li id="02" class="contain side con_new">
                                <div class="s_head c_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/icon_newsgrid.png" alt="">
                                    <span class="model"><fmt:message code="main.news"/></span>
                                    <div class="richeng_check news_all"
                                         onclick="administrivia(this)">
                                        <fmt:message code="notice.th.all"/>
                                    </div>
                                    <div class="news_noread" onclick="administrivia(this)" data-bool="0">
                                        <fmt:message code="email.th.unread"/>
                                    </div>
                                    <span class="more more_news" tid="0117" url="news/index">
                                	<a><fmt:message code="email.th.more"/>
                                	</a>
                                </span>
                                </div>
                                <div class="s_container c_container new_total">
                                    <ul class="new_all">
                                    </ul>
                                </div>
                            </li>
                            <%--外部新闻--%>
                            <li id="2015" class="contain side con_new">
                                <div class="s_head c_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/icon_newsgrid.png" alt="">
                                    <span class="model">外部新闻</span>
                                    <%--<div class="richeng_check news_all"--%>
                                    <%--onclick="administrivia(this)">--%>
                                    <%--<fmt:message code="notice.th.all"/>--%>
                                    <%--</div>--%>
                                    <%--<div class="news_noread" onclick="administrivia(this)" data-bool="0">--%>
                                    <%--<fmt:message code="email.th.unread"/>--%>
                                    <%--</div>--%>
                                    <%--<span class="more more_news" tid="0117" url="news/index">--%>
                                    <%--<a><fmt:message code="email.th.more"/>--%>
                                    <%--</a>--%>
                                    <%--</span>--%>
                                </div>
                                <div class="s_container c_container new_total">
                                    <ul class="wznew_all">
                                    </ul>
                                </div>
                            </li>
                            <%--邮件箱--%>
                            <li id="03" class="contain middle con_email">
                                <div class="s_head c_head m_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/emailbox.png" alt="">
                                    <span class="model youjianxiang">
                                	<fmt:message code="email.title.mailbox"/>
                                </span>
                                    <ul class="mail_title">
                                        <li class="head_title sort  active" id="all_m">
                                            <fmt:message code="notice.th.all"/>
                                        </li>
                                        <li class="head_title sort " id="weidu">
                                            <fmt:message code="email.th.unread"/>
                                        </li>
                                        <li class="head_title sort " id="yidu">
                                            <fmt:message code="email.th.read"/>
                                        </li>
                                    </ul>

                                    <span style="" class="more more_emil" tid="0101" url="email/index">
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
                                </div>
                                <div class="e_mail">
                                    <ul class="all_mail">
                                    </ul>
                                    <ul class="no_read" style="display:none;">
                                    </ul>
                                    <ul class="read" style="display:none;">
                                    </ul>
                                </div>
                            </li>
                            <%--待办--%>
                            <li id="04" class="contain middle con_daiban">
                                <div class="notice_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/backlog.png" alt="">
                                    <span class="model"><fmt:message code="main.th.TodProcess"/>
                                </span>
                                </div>
                                <div class="tainer">
                                    <ul class="daiban">
                                    </ul>
                                </div>
                            </li>
                            <%--日程安排--%>
                            <li id="06" class="contain side con_schedule">
                                <div class="s_head c_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/schedule.png" alt="">
                                    <span class="model"><fmt:message code="main.schedule"/></span>
                                    <div class="c_all " data-url="/schedule/getAllschedule"
                                         onclick="schedule(this)"><fmt:message code="notice.th.all"/>
                                    </div>
                                    <div class="c_today richeng_check" data-url="/schedule/getscheduleByDay" data-schedule="1"
                                         onclick="schedule(this)"><fmt:message code="notice.th.Today"/>
                                    </div>
                                    <div class="c_tom" data-url="/schedule/getscheduleByDay" data-schedule="2"
                                         onclick="schedule(this)"><fmt:message code="main.th.Tomorrow"/>
                                    </div>
                                    <div class="c_nexttom" data-url="/schedule/getscheduleByDay" data-schedule="3"
                                         onclick="schedule(this)"><fmt:message code="main.th.AfterTomorrow"/>
                                    </div>
                                    <span class="more more_chedule" tid="0124"
                                          url="schedule/index">
											<a><fmt:message code="global.lang.add"/></a>
								</span>
                                </div>
                                <div class="s_container c_container">
                                    <ul class="chedule_all">
                                    </ul>
                                </div>
                            </li>
                            <%--常用功能--%>
                            <li id="07" class="contain side con_function">
                                <div class="s_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img class="changyong_img"
                                         src="img/main_img/${sessionScope.InterfaceModel}/changyong.png" alt="">
                                    <span class="model" style="margin-left: 6px;">
                                	<fmt:message code="main.th.function"/>
                                </span>
                                    <!-- <span class="more"><a>管理</a></span> -->
                                </div>
                                <div class="s_container" id="application">
                                    <%--<div class="every_logo" menu_tid="0116" onclick="getMenuOpen(this)" data-url="notify/show">--%>
                                    <%--<img src="img/main_img/app/0116.png">--%>
                                    <%--<h2><fmt:message code="notice.th.notice"/></h2>--%>
                                    <%--</div>--%>
                                    <%--<div class="every_logo" menu_tid="0101" data-url="email" onclick="getMenuOpen(this)">--%>
                                    <%--<img src="img/main_img/app/0101.png">--%>
                                    <%--<h2><fmt:message code="notice.th.mail"/></h2>--%>
                                    <%--</div>--%>
                                    <%--<div class="every_logo" menu_tid="0124" onclick="getMenuOpen(this)"--%>
                                    <%--data-url="calendar">--%>
                                    <%--<img src="img/main_img/app/0124.png">--%>
                                    <%--<h2><fmt:message code="email.th.agenda"/></h2>--%>
                                    <%--</div>--%>
                                    <%--<div class="every_logo" menu_tid="0117" data-url="news/show" onclick="getMenuOpen(this)">--%>
                                    <%--<img src="img/main_img/app/0117.png">--%>
                                    <%--<h2><fmt:message code="main.news"/></h2>--%>
                                    <%--</div>--%>
                                    <%--<div class="every_logo" menu_tid="3001" data-url="file_folder/index2.php" onclick="getMenuOpen(this)">--%>
                                    <%--<img src="img/main_img/app/0136.png">--%>
                                    <%--<h2><fmt:message code="file.th.file"/></h2>--%>
                                    <%--</div>--%>
                                    <%--<div class="every_logo" menu_tid="0128" data-url="diary/show" onclick="getMenuOpen(this)">--%>
                                    <%--<img src="img/main_img/app/0128.png">--%>
                                    <%--<h2><fmt:message code="email.th.log"/></h2>--%>
                                    <%--</div>--%>
                                </div>
                            </li>
                            <%--日志--%>
                            <li id="08" class="contain side con_daily">
                                <div class="s_head d_head bg_head">
                                    <span class="s_head_top"></span>

                                    <img src="img/main_img/${sessionScope.InterfaceModel}/log.png" alt="">
                                    <span class="model"><fmt:message code="email.th.log"/></span>
                                    <ul class="daily_all">
                                        <li class="my_daily active">
                                            <fmt:message code="diary.th.own"/>
                                        </li>
                                    </ul>
                                    <span class="more_daily">
                                	<a class="daily_more" tid="0128" url="diary/index">
                                		<fmt:message code="email.th.more"/>
                                	</a>
                                </span>
                                </div>
                                <div class="daily">
                                    <ul class="all_daily">
                                    </ul>
                                </div>
                            </li>

                            <%--文件柜--%>
                            <li id="09" class="contain side con_file">
                                <div class="wenjian_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/fliebox.png" alt="">
                                    <span class="model"><fmt:message code="file.th.file"/></span>
                                    <ul class="wenjian_list">
                                        <li class="head_title sort active actives" onclick="fileCabinet(this)"
                                            data-url="/file/writeTree">
                                            <fmt:message code="main.th.PublicFile"/>
                                        </li>
                                        <li class="head_title sort" onclick="fileCabinet(this)"
                                            data-url="/file/writeTreePerson">
                                            <fmt:message code="main.th.PersonalFile"/>
                                        </li>
                                    </ul>

                                    <span class="wenjian_span more_wenjian" tid="3001" url="/newFilePub/fileCabinetHome?0">
                                	<a style="color: #000;">
                                		<fmt:message code="email.th.more"/>
                                	</a>
                                </span>
                                </div>
                                <div class="s_cont">
                                    <ul class="pets_wenjian">
                                    </ul>
                                </div>
                            </li>
                            <%--网络硬盘--%>
                            <li id="10" class="contain side con_net">
                                <div class="wenjian_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="img/main_img/${sessionScope.InterfaceModel}/webdisk.png" alt="">
                                    <span class="model"><fmt:message code="main.network"/></span>
                                    <ul class="wenjian_list">
                                        <%--<li class="head_title sort active actives"><fmt:message code="main.th.public"/></li>--%>
                                        <%--<li class="head_title sort"><fmt:message code="main.th.personal"/></li>--%>
                                    </ul>

                                    <span class="wenjian_span more_wenjian" tid="3010" url="/netdiskSettings/networkHardDisk?0">
                                	<a style="color: #fff;"><fmt:message
                                            code="email.th.more"/></a>
                                </span>
                                </div>
                                <div class="s_cont">
                                    <ul class="pets_yingpan" style="height: 100%;overflow-y: auto;">
                                    </ul>
                                    <ul class="people_yingpan" style="display:none;">
                                    </ul>

                                </div>
                            </li>
                            <%--会议通知--%>
                            <li id="11" class="contain side con_new">
                                <div class="s_head c_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_myMeeting.png" alt="" width="15px" height="15px" style="top: 10px;">
                                    <span class="model"><fmt:message code="dem.th.ConferenceNotice"/></span>

                                    <span class="more more_meeting" tid="8888" url="meeting/meetingList">
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
                                </div>
                                <div class="s_container c_container new_total">
                                    <ul class="meeting">
                                    </ul>
                                </div>
                            </li>
                            <%--待办公文--%>
                            <li id="05" class="contain side con_daily">
                                <div class="s_head d_head bg_head">
                                    <span class="s_head_top"></span>
                                    <img style="width: 18px;height: 18px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/doctment.png" alt="">
                                    <span class="model"><fmt:message code="document.th.To-doList"/></span>
                                    <ul class="daily_all" style="right:9px">
                                        <li class="send my_daily active" documentType="0" onclick="documentFile(0)"><fmt:message code="doc.th.Dispatch"/></li>
                                        <li class="receive my_daily " documentType="1" onclick="documentFile(1)"><fmt:message code="doc.th.In"/></li>
                                    </ul>
                                </div>
                                <div class="daily">
                                    <ul class="gongwen"></ul>
                                </div>
                            </li>
                        </div>
                        <div class="main_2 cont_main " id="contmain_1" data-tabId="1" style="height: calc(100% - 45px);z-index: 0;">
                            <iframe src="/common/myOA?20190710" name="iframeName" id="iframeName" frameborder="0" style="width: 100%;height: 100%;"></iframe>
                        </div>
                    </div>
                    <div id='' class="iItem" style="display: none">
                        <iframe id="every_module" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
                    </div>

                </div>
            </div>
        </div>

        <div class="foot">
            <div style="width: 569px;height: 50px;margin: auto;">
                <label class="wenzi" ><fmt:message code="dem.th.NavigationPanel"/></label>
                <div id="xianyin"  class="show_off">
                    <span id="bottom_show_left" ></span>
                    <span class="show_off_tag_bg" id="bottom_hide_left" ></span>
                </div>
                <iframe id="every_module1" src="lunbo" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize">
                </iframe>
                <div class="peopleez">
                    <span><fmt:message code="main.th.numberOfOnlineUsers" />：</span>
                    <span class="peoplenum">0<fmt:message code="main.th.people" /></span>
                    <span class="zhuce">（<fmt:message code="main.th.notRegistered" />）</span>
                </div>
            </div>
        </div>

    </div>
</div>
<div class="overTimeTips" style="display: none">
    <div style="width: 76%;margin-left: 12%;margin-top: 20px;">
        <span><fmt:message code="main.th.esteemedUser" /></span><br>
        <div style="margin-top: 10px"><span style="padding-left: 35px;"><fmt:message code="main.th.thank" /></span><br></div>
        <div style="margin-top: 20px"><span><fmt:message code="main.th.remind1" /><span class="residue" style="color: red">0</span><fmt:message code="main.th.remind2" /></span><br></div>
        <div style="margin-top: 20px"><span><fmt:message code="main.th.contactNumber" /><span style="margin-left: 30px;"><fmt:message code="main.th.qqGroup" /></span></span><br></div>
        <div style="margin-top: 20px">
            <span class="countdown" style="margin-left: 34%"><fmt:message code="main.th.countdown" /><span class="countTime" style="color: red">10</span><fmt:message code="system.th.second" /></span>
            <div class="register" style="display: inline-block;float: right;font-size: 14px;background: red;padding: 2px 5px;cursor: pointer"><fmt:message code="main.th.softwareRegistration" /></div>
        </div>
    </div>
</div>

<script>
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            if(res.object[0].paraValue == 1) {
                var textFontSize = $("font").css("fontSize");
                if(textFontSize) {
                    $(".secretText").css("fontSize",textFontSize);
                }
                $(".secretText").show()
            }else {
                $(".secretText").hide()
            }
        }
    })
    // 判断是否开启三员管理
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {//开启了三员管理
                $("#shequLogo").hide()
            }else {
                $("#shequLogo").show()
            }
        }
    })
    // 如果是IE浏览器就提示
    if(BrowserisIE() || myBrowser()== 'IE11'){
        layer.open({
            type: 1,
            title: '<fmt:message code="main.th.FriendshipTips" />',
            time: 12000,
            area: ['360px', '160px'],
            offset: 'auto',
            skin: 'ieTips',
            closeBtn: 0, //不显示关闭按钮
            anim: 2,
            shadeClose: true, //开启遮罩关闭
            content: '<div class="ieTipsText"><fmt:message code="main.th.browserisIERemindContent" /></div>'
        });
    }
    <%--    判断是否为七匹狼项目--%>
    $.get('/syspara/selectTheSysPara?paraName=MYPROJECT', function (res) {
        if(res.flag){
            qiParaValue = res.object[0].paraValue
            if(qiParaValue == 'septwolves' ){
                $.ajax({
                    type:'post',
                    url:'/users/getUserTheme',
                    dataType:'json',
                    success:function(res){
                        if(res.flag && res.object != null) {
                            if (res.object.theme == 5) {
                                $("#qipilang").css({"margin-top":"0px","margin-left":"0px","height":"107px"});
                                $("body").css("padding-top","0px");
                                jQuery('head').append('<link>');
                                a = jQuery('head').children(':last');
                                a.attr({
                                    rel: 'stylesheet',
                                    type: 'text/css',
                                    href: '/css/main/intranegreen.css?20220918'
                                });
                            }
                        }
                    }
                });
            }
        }
    });

    var str1=''
    $.ajax({
        url: '/users/getUserTheme',
        dataType: 'json',
        type: 'post',
        success: function (data) {
            str1 += '<em><div style="color:#2a588c;font-size: 40px;font-family:楷体;margin-top: 20%"><fmt:message code="main.th.welcome" />！' + data.object.userName + '</div></em>'
            $("#welcome").html(str1);
            $('#welcome').hide()
            if (data.object.simpleInterface == 1) {
                $('#welcome').show()
                $('.header').hide()
                $('#task_center').hide()
                $('#community').hide()
                $('#help').hide()
                $('#commonSetting').hide()
                $('#orgnize').hide()
                $('#contmain_1').hide()
                $('.top_ul').css('background-color','#eab765')
                $('#sns').css('margin-left','100%')
                $('.yingy').css('margin-left','50px')
                $('#back').css('margin-left','50%')
                $('.location').css('margin-left','100px')
            } else if (data.object.simpleInterface == 0) {
                $('#welcome').hide()
                $('.header').show()
                $('#task_center').show()
                $('#community').show()
                $('#help').show()
                $('#commonSetting').show()
                $('#orgnize').show()
                $('#contmain_1').show()
            }

        }
    })

    var menu = {
        "email": "email/index",
        "emailPlus": "emailPlus/index",
        "email_eamilStatis": "email/eamilStatis",
        "notify_show": "notice/allNotifications",
        "news_show": "news/index",
        "file_folder/index2.php": "fileHome",
        "system/file_folder": "showFileBySort_id",
        "diary_show": "diary/index",
        "news_manage": "news/manage",
        "notify_manage": "notice/noticeManagement",
        "knowledge_management": "newFilePub/fileCabinetHome",
        "system_file_folder": "newFilePub/cabinetSet",
        "system_workflow_flow_guide": "flow/type/index",
        "system_workflow_flow_form": "workflow/formtype/index",
        "file_folder_index2.php": "newFilePri/personalFileCabinet",
        "system_workflow_flow_sort": "workflow/flowclassify/index",
        "system_unit": "sys/companyInfo",
        "system_dept": "common/deptManagement",
        "system_org_manage": "sys/organizational",
        "workflow_new": "workflow/work/addwork",
        "workflow_list": "workflow/work/workList",
        "system_user": "common/userManagement",
        "system_crossDept": "common/userManagementPlus",
        "system_status_text": "sys/statusBar",
        "system_interface": "sys/interfaceSettings",
        "system_reg_view": "sys/sysInfo",
        "system_menu": "sys/menuSetting",
        "system_log": "sys/journal",
        "system_code": "common/systemCode",
        "info_unit": "sys/unitInfor",
        "info_dept": "department/deptQuery",
        "info_user": "sys/userInfor",
        "calendar": "schedule/index",
        "system_user_priv": "roleAuthorization",
        "system_netdisk": "netdiskSettings/netdisksetting",
        "document_mine": "document/mine",
        "person_info": "controlpanel/index",
        "system_workflow_self-motion": "/workflow/work/automaticNumbering",
        "system_workflow_business": "/workflow/work/businessApplications",
        "netdisk": "netdiskSettings/networkHardDisk",
        "calendar_info": "schedule/query",
        "deleteDatePage": "deleteDatePage",
        "attendance_personal": "/attendPage/myAttendance",
        "hr_manage_staff_info": "hr/page/hrindex",
        "hr_manage_staff_contract": "hr/page/contractIndex",
        "document_send_draft": "/document/draftArticlesOfCommunication",
        "document_send_backlog": "/document/makeADraft",
        "document_send_have": "/document/IthasBeenDone",
        "document_send_mine": "/document/ISentAMessage",
        "meeting_apply": "/MeetingCommon/MeetingApply",
        "meeting_query": "/MeetingCommon/selectMeeting",
        "meeting_mymeeting": "/MeetingCommon/selectMyMeeting",
        "meeting_summary": "/MeetingCommon/selectMeetingMinutes",
        "meeting_management": "/MeetingCommon/selectMeetingMange",
        "meeting_equipment": "/MeetingCommon/MeetingDeviceMange",
        "meeting_meetingroom": "/MeetingCommon/MeetingRoom",
        "meeting_admin_settings": "/MeetingCommon/MeetingMange",
        "supervise_task": "SupervCommon/MySupervision",
        "supervise_management": "SupervCommon/SupervisionManage",
        "supervise_classify": "SupervCommon/SupervisionType",
        "supervise_statistics": "SupervCommon/Supervisionstatistic",
        "document_recv_register": "document/addresseeRegistrationForm",
        "document_recv_backlog": "document/inAbeyance",
        "document_recv_have": "document/received",
        "document_recv_mine": "document/myInReply",
        "document_query": "document/theOfficialDocumentQuery",
        "document_statistics": "document/theOfficialStatistics",
        "document_supervise": "document/documentsSupervisor",
        "document_setting": "document/officialDocumentSet",
        "sms_index": "sms/index",
        "document_template_setting": 'document/officialDocumentSet',
        "attendance_manage_confirm": "attendPage/backlogAttendLeave",
        "attendance_manage_query": "attendPage/attendance",
        "system_secure_rule": "sys/secureIndex",
        "workflow_query": "flowRunPage/queryFlowRun",
        "document_seal_management": "document/SealIndex",
        "syn_data": "synData/page",
        "workflow_rule": "workflow/work/workDelegate",
        "hierarchical_setting": "hierarchical/common/setting",
        "hierarchical_deptManager": "hierarchical/common/deptManager",
        "hierarchical_userManager": "hierarchical/common/userManager",
        "timeLineConmon_timeLineEvent": "timeLineConmon/timeLineEvent",
        "timeLineConmon_eventManage": "timeLineConmon/eventManage",
        "edu_fixAssets_manager": "eduFixAssets/index",
        "edu_exam": "eduExam/index",
        "edu_school_calendar": "eduSchoolCalendar/showSchoolCalendar",
        "edu_gradeclass": "eduDepartment/eduDeptManagement",
        "eduPrize_index": "eduPrize/goIndex",
        "edu_course": "eduCourse/index",
        "edu_exam_xj": "eduExam/editExam",
        "edu_exam_cx": "eduExam/queryExam",
        "edu_exam_dr": "eduExam/insertExam",
        "hr_training_plan": "eduTrainPlan/goIndex",
        "edu_arrangeCourse": "eduArrangeCourse/arrangeCourse",
        "hr_training_approval": "eduTrainPlan/assessIndex",
        "eduTeacher_index": "eduTeacher/index",
        "workPlan_queryIndex": "workPlan/workPlanQueryIndex",
        "workPlan_planManager": "workPlan/index",
        "workPlan_typeSetting": "workPlan/workPlanTypeSetting",
        "edu_student": "edu/student/eduStudentIndex",
        "hr_training_record": "record/trainRecord",
        "vote_manage": "vote/manage/vote",
        "vote_show": "vote/manage/voteIndex",
        "vehicle_vehicleindex": "veHicle/veHicleIndex",
        "vehicle_vehicleuseageindex": "veHicle/veHicleUseageIndex",
        "vehicle_vehicleUseQuery_Index": "veHicleUsage/index",
        "vehicle_vehicleDeptApprove_index": "veHicle/vehicleDeptApproveIndex",
        "vehicle_vehicleMaintenance_index": "tenance/index",
        "vehicle_vehicleoperator_Index": "veHicle/operatorIndex",
        "edu_system_para_setting": "syspara/eduSetParamIndex",
        "vehicle_vehicleOperatormanage": "veHicle/OperatorMange",
        "edu_elective_sys_elective_count": "eduElectiveStudentCount/StatisticsIndex",
        "edu_elective_sys_elective_course": "eduElectivePublish/EduElectIndex",
        "address_index": "address/index",
        "officeDepository_index": "officeDepository/goDepositoryindex",
        "leaderActivity_leaderActivity": "leaderschedule/leaderActivity",
        "leaderActivity_query": "leaderschedule/query",
        "notes_index": "Notes/index",
        "officedepository_index": "officeDepository/goDepositoryindex",
        "officetransHistory_productRelease": "officetransHistory/productRelease",
        "officetransHistory_approvalIndex": "officetransHistory/approvalIndex",
        "officeProduct_OfficeProductApplyIndex": "officetransHistory/OfficeProductApplyIndex",
        "officetransHistory_stockIndex": "officetransHistory/stockIndex",
        "edu_importUser": "user/goImportEduUsers",
        "officetransHistory_OfficeProductApplyIndex": "officetransHistory/OfficeProductApplyIndex",
        "officeSupplies_goInfomationHome": "officeSupplies/goInfomationHome",
        "edu_eduSchoolBusiness": "eduSchoolBusiness/eduSchoolIndex",
        "book_bookManager_inputIndex": "bookManager/inputIndex",
        "book_bookManager_queryIndex": "bookManager/queryIndex",
        "book_bookManager_replayIndex": "bookManager/replayIndex",
        "book_bookManager_setIndex": "bookManager/setIndex",
        "edu_eduSchoolOpen": "eduSchoolBusiness/noticeIndex",
        "system_notify": "notice/notificAtion",
        "notify_auditing": "notice/appprove",
        "smsSettings_index": "smsSettings/index",
        "timed_management": "timedTaskJob/imedTaskManagement",
        "workflow_workMonitoring": "workflow/work/workMonitoring",
        "spirit_webChatRecord": "spirit/webChatRecord",
        "footprint_index": "footprint/index",
        "rmsRoll_index": "rmsRoll/index",
        "rmsFile_index": "rmsFile/index",
        "rmsFile_toDestroyed": "rmsFile/toDestroyed",
        "salary_lclb": "/salary/lclb",
        "sys_getPostmanagement": "/sys/getPostmanagement",
        "duties_dutiesjsp": "/duties/dutiesjsp",
        "system_remind": "/serviceReminding/InformationReminding",
        "schoolRoll_schoolQuery": "/schoolRoll/schoolQuery",
        "schoolRoll_index": "/schoolRoll/index",
        "schoolRoll_schoolSeting": "/schoolRoll/mange",
        "teachering_teacherQuery": "/teachering/teacherQuery",
        "teachering_index": "/teachering/index",
        "teachering_teacherSeting": "/teachering/teacherSeting",
        "eduYear_schoolYearManagement": "/eduYear/schoolYearManagement",
        "eduTerm_termManagement": "/eduTerm/termManagement",
        "eduLearnPhase_studySectionManagement": "/eduLearnPhase/studySectionManagement",
        "eduGrade_index": "/eduGrade/index",
        "teachering_substituteManage": "teachering/substituteManage",
        "eduAttend_index": "eduAttend/index",
        "eduAttend_registrationStatistics": "eduAttend/registrationStatistics",
        "eduAttend_Index": 'eduAttend/Index',
        "eduSubject_subjectManagement": 'eduSubject/subjectManagement',
        "eduTeacherManage_theList": 'eduTeacherManage/theList',
        "edu_student_index": '/edu/student/index',
        "eduStudentManage_schoolManagement": '/eduStudentManage/schoolManagement',
        "schoolRoll/informationEntry": '/schoolRoll/informationEntry',
        "eduTimeManagement_index": '/eduTimeManagement/index',
        "eduSal_importeduSalIndex": 'eduSal/importeduSalIndex',
        "eduSalType_listEduSalType": "eduSalType/listEduSalType",
        "eduSal_selectEduSal": "eduSal/selectEduSal",
        "outDocument_index": "outDocument/index",
        "eduDxfw_index": "/eduDxfw/index",
        "sysTasks_sysTaskIndex": "sysTasks/sysTaskIndex",
        "censor_management": "/censor/wordFiltering",
        "attendance_manage_leaveStatistics": '/manage/leaveStatistics',
        "hr_manage_staff_incentive": '/Hr/Incentive/bonpenManagement',
        "hr_manage_staff_learn_experience": '/learningExperience/navigationBar',
        "dutyManagement_pageJumpDutyManagement": 'dutyManagement/pageJumpDutyManagement',
        "system_workflow_flow_log": '/workflow/work/DiaryIndex',
        "workflow_destroy": '/workflow/work/workDestruction',
        "eduSchoolInfo_index": "eduSchoolInfo/index",
        "eduCode_index": "eduCode/index",
        "eduStudentInfo_index": "eduStudentInfo/index",
        "parentInfo_index": "parentInfo/index",
        "eduArticle_index": "eduArticle/index",
        "eduCourseInfo_index": "eduCourseInfo/index",
        "hr_analysis": "hr/manage/staff_analysis",
        "hr_manage_staff_labor_skills": "hr/manage/staff_labor_skills",
        "hr_setting_hr_code": "common/hrSystemCode",
        "infomation_goAddInfomation": 'infomation/goAddInfomation',
        "infomation_HandleIndex": 'infomation/HandleIndex',
        "infomation/submitQuery": 'infomation/submitQuery',
        "infomation/statisticsIndex": 'infomation/statisticsIndex',
        "system_workflow_flow_report": 'reportSettings/index',
        "workflow_report": '/workflow/work/flowReportMain',
        "schoolRoll_tongji": "/schoolRoll/statisticalChart",
        "SmartySchool_index": "/SmartySchool/index",
        "SmartyStudent_manager": "/SmartyStudent/manager"
    };
    //点击社区图标
    $('#community').on('click',function(){
        var common = '<li class="choose" url="common/communityEntry" index="0;" id="t_0001" title="<fmt:message code="main.th.community" />" >\n' +
            '                        <h1><fmt:message code="main.th.community" /></h1>\n' +
            '                        <div class="img" style="display:none;" id="close"><img class="close" src="img/main_img/icon.png"></div>\n' +
            '                    </li>'
        if($('.main_title ul').find('#t_0001').length == 0){
            $('.main_title ul').append(common);
            $('#t_0001').siblings().css({
                'background':'url(img/main_img/'+$('[name="sessionType"]').val()+'/title_no.png) 0px 4px no-repeat',
                'color':'#fff',
                'position':'relative',
                'z-index':999
            })
            $('.all_content .iItem').hide();
            var iframestr = '<div id="f_0001" class="iItem">' +
            '                <iframe id="00" src="common/communityEntry" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>' +
            '                </div>'
            $('.all_content').append(iframestr);
        }else{
            $('.all_content .iItem').hide();
            $('#f_0001').show();
            // $('#00').contentWindow.location.reload();
            $('#00').attr('src', $('#00').attr('src'));
        }
    })
    $.ajax({
        type:'get',
        url:'/ShowDownLoadQrCode',
        dataType:'json',
        success:function(res){
            if(res.flag){
                if(res.object=='0'){
                    $('.AndroidMove').hide()
                    $('.iosMove').hide()
                    $('#zdjShow').hide()
                    
                }else{
                    $('.AndroidMove').show()
                    $('.iosMove').show()
                    $('#zdjShow').show()
                    $('.per_all h3').hide()
                    $('.per_all .juede_suopings').hide()
                    $('.per_all .juede_suoping').hide()
                    // 自动折叠
                    $('#back').trigger('click');
                    $('.QRCode').css('top','36px')
                }
            }
        }
    })
    $('.iconT').mouseover(function () {
        $('.codeT').show()
    })
    $('.codeT').mouseover(function () {
        $('.codeT').show()
    })
    $('.codeT').mouseover(function () {
        $('.codeT').show()
    })
    $('.AndroidMove').mouseout(function () {
        $('.codeT').hide()
    })
    $('.iconH').mouseover(function () {
        $('.codeH').show()
    })
    $('.codeH').mouseover(function () {
        $('.codeH').show()
    })
    $('.iosMove').mouseout(function () {
        $('.codeH').hide()
    })
    $(function(){
        if($.cookie("lockCode")!=''&&$.cookie("lockCode")!=undefined){
            $('.posifixedCenter').find('input[type="password"]').val('')
            $('#fixedBody').show()
        }else{
            $('#fixedBody').hide()
        }
        enter();
        setInterval(function(){
            enter();
        },120000)

    })
    $('.gongzuoliu').click(function(){
        $('#contmain_1').show();
        var url = $('#f_0 .header ul li .active').parent().attr('iframesrc')||"/common/myOA";
        $('#contmain_1').find('iframe').attr('src',url);
        //$('#f_0 .header ul li').eq(0).find('.head_title').addClass('active').parent().siblings().find('.head_title').removeClass('active')
    })
    //左侧常用菜单数据获取
    //refurbish
    $("#refurbish").click(function(){
        $.get('/getUsuallyMenu', function (res) {
            if (res.flag) {
              var str=''
              var data=res.obj
               for(var i=0;i<data.length;i++){
                   var url = data[i].url

                    str+='<div class="c_menu" style="cursor:pointer;" data-er="0" data-url="'+url+' " menu_tid="'+data[i].id+'"  title=" '+data[i].name+' ">' +
                            '<div class="two_all">' +
                                '<img class="erji_circle" src="img/main_img/theme6/hei.png"></img>'+
                                    '<h1 class="erji_h1" title=" '+data[i].name+' " style="width:56%" >'+data[i].name+'</h1>'+
                            '</div>' +
                        '</div>'
               }
                $("#ceshi").html(str);
                $("#tab_cthree li").css("display","none")
            }
        })
    })

</script>
</body>
</html>


