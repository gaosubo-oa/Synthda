<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="/lib/layui/layuiadmin/layui/css/layui.css?20210319.1" media="all">
    <link rel="stylesheet" href="/lib/layui/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20201106.1"/>
    <script src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js?20230425.1"></script>
    <script src="/js/base/base.js?20221026.2"></script>
    <script src="/lib/audiojs/audio.min.js"></script>
    <script type="text/javascript"  src="/js/main_js/indexAll.js?20230604.2"></script>
    <style>
        select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
            display: inline-block;
            height: 20px;
            padding: 4px 6px;
            margin-bottom: 10px;
            font-size: 14px;
            line-height: 20px;
            color: #555555;
            vertical-align: middle;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
        }

        textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
            background-color: #ffffff;
            border: 1px solid #cccccc;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            -webkit-transition: border linear 0.2s, box-shadow linear 0.2s;
            -moz-transition: border linear 0.2s, box-shadow linear 0.2s;
            -o-transition: border linear 0.2s, box-shadow linear 0.2s;
            transition: border linear 0.2s, box-shadow linear 0.2s;
        }

        /* 美化滚动条样式 */
        ::-webkit-scrollbar {
            width: 7px;
            height: 7px;
            background-color: transparent;
        }

        /*定义滚动条轨道 内阴影+圆角*/
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: transparent;
            background-color: transparent;
        }

        /*定义滑块 内阴影+圆角*/
        ::-webkit-scrollbar-thumb {
            border-radius: 7px;
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
            background-color: #9d9fa1;
        }
        .hover{
            background-color: #2B7FE0;
        }
        body {
            font-family: Helvetica Neue, Helvetica, PingFang SC, Tahoma, Arial, sans-serif;
        }

        .title {
            font-size: 22px;
            letter-spacing: 3px;
            font-weight: 700;
        }

        .layui-side-menu .layui-nav .layui-nav-item .layui-img {
            position: absolute;
            top: 69%;
            left: 20px;
            margin-top: -19px;
            width: 16px;
        }

        .layui-layout-admin .layui-header a {
            text-align: center;
        }

        .layui-layout-admin .layui-layout-left .layui-nav-item {
            margin: 0;
            width: 56px;
        }

        .layui-layout-admin .layui-layout-left .layui-nav-item:nth-child(5) {
            width: auto;
            margin-left: 10px;
        }

        .myMenu:hover {
            background-color: #fff;
        }

        .myMenu:hover a .layui-icon {
            color: #000;
        }

        .myMenuBox {
            display: none;
            position: absolute;
            top: 49px !important;
            left: 0;
            z-index: 1070;
            cursor: auto;
            width: 521px;
            height: auto;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #d9d9d9;
            -webkit-box-shadow: 0 1px 6px rgba(100, 100, 100, 0.2);
            box-shadow: 0 1px 6px rgba(100, 100, 100, 0.2);
            border-radius: 0;
            -webkit-user-select: text;
            -moz-user-select: text;
            -ms-user-select: text;
            user-select: text;
            white-space: normal;
            line-height: 1.5;
            font-weight: normal;
        }

        .myMenuBoxContent {
            width: 520px;
            padding-top: 20px;
            white-space: normal;
            padding-bottom: 10px;
            /*margin: 0 auto;*/
        }

        .clipper {
            overflow: hidden;
            height: 100%;
            width: 100%;
            position: relative;
        }

        .scroller {
            overflow-y: scroll;
            overflow-x: hidden;
            height: 100%;
            margin-left: 12px;
        }

        .myMenuBoxContent .scroller {
            max-height: 480px;
        }

        .menu-items {
            max-height: 330px;
        }

        .menu-item {
            float: left;
            width: 110px;
            height: 110px;
            margin-left: 10px;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .menu-color0 {
            background-color: #66d17a;
        }
        .menu-color1 {
            background-color: #bd1a2d;
        }
        .menu-color3 {
            background-color: #1890ff;
        }
        .menu-color2 {
            background-color: #f7b13f;
        }
        .menu-color4 {
            background-color: #009688;
        }


        .menu-item-cover:hover {
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.2);
        }

        .menu-item-icon {
            width: 100%;
            padding-top: 27px;
            color: #fff;
            text-align: center;
        }

        .layui-nav .menu-item-icon .layui-icon {
            font-size: 35px;
        }

        .menu-item-name {
            font-size: 13px;
            width: 110px;
            padding-top: 5px;
            color: #fff;
            text-align: center;
            /*white-space: nowrap;*/
            overflow: hidden;
            -o-text-overflow: ellipsis;
            text-overflow: ellipsis;
        }

        .side_all {
            height: 100%;
            position: absolute;
            right: 0px;
            top: 50px;
            z-index: 19991018;
            display: none;
        }

        .position {
            z-index: 19991018;
            width: 0px;
            height: 100%;
            position: absolute;
            right: 0px;
            top: 0px;
            background: #fff;
            box-shadow: 1px 1px 50px rgba(0, 0, 0, .3);
        }

        .layadmin-body-shade {
            z-index: 19991017;
            background-color: rgb(0, 0, 0);
            opacity: 0.1;
        }
        .apply_name{
            font-weight: bold;
            text-align: left;
            margin-left: 10px;
            font-size: 18px;
        }
        .priv_name{
            margin-left: 0px!important;
        }
        .search_apply .custom-two-left img{
            margin-top: 20px!important;
            margin-left: 3.9px!important;
        }
        .apply_num{
            width: 2em !important;
            font-weight: bold;
            color: red;
            font-size: 15px;
        }
        .custom-two-mid h1{
            text-align: left;
            font-size: 18px;
            line-height: 60px!important;
            margin-left: 10px!important;
            color: #0088cc;
        }
        .custom-two-left{
            width: 10%;
            line-height:0px!important;
            margin-left: 15px!important;
        }
        .skin {
            width: 100%;
            height: 45.4px;
            background: #fff;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }

        .skin img, .skin h2 {
            float: left;
        }

        #tixing_tab_c {
            height: 93%;
            overflow-y: auto;
        }

        /*#tixing_tab_c ul li {*/
        /*    margin-top: 5px;*/
        /*}*/

        .search_custom {
            width: 100%;
            background: #fff;
            /* height: 40px; */
        }

        #tixing_tab_c ul li .search_one_all {
            padding: 10px 0px;
            background-color: #e2f0ff;
        }

        .search_one_all {
            border-bottom: 1px solid #ccc;
        }

        .custom_photo {
            margin-left: 16px;
        }

        .search_custom h1, .custom_photo, .custom_close, .custom_num, .search_apply h1, .apply_photo, .apply_close, .apply_num {
            float: left;
        }

        .custom_name {
            line-height: 27px;
            width: 8em;
            text-align: center;
        }

        .custom_close, .apply_close {
            float: right;
            margin-right: 1em;
        }

        .custom_close, .apply_close {
            margin-left: 6px;
            margin-top: 8px;
        }

        .custom_num, .apply_num {
            width: 6em;
            overflow: hidden;
            line-height: 24px;
            text-align: right;
            float: right;
        }

        .custom_num {
            width: 3em !important;
        }

        .oneKeyRead {
            float: right;
            margin-top: 5px;
        }

        .custom_two li {
            width: 100%;
            margin: auto;
            height: 70px!important;
            border-bottom: 1px dashed #999;
        }

        #tixing_tab_c ul li .custom_two > li img {
            width: 22px;
            height: 22px;
            float: left;
            margin-top: 20px;
            margin-left: 17px;
        }

        #tixing_tab_c ul li .custom_two > li span {
            height: 40px;
            width: 84%;
            overflow: hidden;
            margin-left: 3.9px;
            /* white-space: nowrap; */
            /* text-overflow: ellipsis; */
            cursor: pointer;
            display: inline-block;
            float:right;
        }

        #tixing_tab_c ul li .custom_two > li > span:last-of-type {
            margin-left: 35px;
            height: 20px!important;
        }

        #tixing_tab_c ul li .custom_two > li label {
            height:20px;
            display: inline-block !important;
            margin-bottom: 0px !important;
            font-size: 12px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        #admin-side1 {
            overflow-y: hidden!important;
            background: #f7f7f7 !important;
        }

        .mainstyle {
            width: 270px;
            height: 117px;
            top: 50px;
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
        .custom_name{
            font-weight: bold;
            text-align: left;
            margin-left: 10px;
            font-size: 18px;
        }
        .custom_num{
            width: 2em !important;
            font-weight: bold;
            color: red;
            font-size: 15px;
        }
        .windowopen{
            font-weight: bold;
            font-size: 14px;
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
            background: url(/img/replaceImg/replaceTheme/20menhu.png?2020041404) no-repeat;;
            background-size: contain;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
                    src='/img/main_img/chenjing.png',
                    sizingMethod='scale');
        }

        .mainstyle.twentyportal.actives {
            background: url(/img/replaceImg/replaceTheme/20menhus.png?2020041402) no-repeat;;
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

            text-align: center;
            border-radius: 4px;
            z-index: -1;
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

        .layui-layout-admin .layui-header .layui-layout-right .layui-nav-child {
            width: 300px;
            top: 49px;
            right: -7px;
            padding: 0;
        }

        .search_one_all:hover {
            background: #ebf9ff;
            cursor: pointer;
        }

        .loadAnimate {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -37px;
            margin-left: -25px;
        }

        .menubox .layui-nav-more {
            display: none;
        }

        .layui-layout-admin .layui-header .layui-nav-img {
            width: 30px;
            height: 30px;
        }

        #admin-side3 button {
            cursor: pointer;
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

        #LockCode, #theLock {
            background: #2069d9;
        }

        #LockCode:hover {
            background: #3981f1;
        }

        #theLock:hover {
            background: #3981f1;
        }

        .headerhover:hover {
            background: #042341;
            color: #f8f8f8 !important;
        }

        .headerhover:hover cite {
            color: #f8f8f8 !important;
        }

        .layuiMore {
            content: '';
            width: 0;
            height: 0;
            border-style: solid dashed dashed;
            border-color: #fff transparent transparent;
            overflow: hidden;
            cursor: pointer;
            transition: all .2s;
            -webkit-transition: all .2s;
            position: absolute;
            top: 50%;
            right: 3px;
            margin-top: -3px;
            border-width: 6px;
            border-top-color: rgba(255, 255, 255, .7);
            border-top-color: #fbfbfb;
        }

        .layuiMored {
            margin-top: -9px;
            border-style: dashed dashed solid;
            border-color: transparent transparent #fff;
        }

        .layui-side-menu .layui-nav .layui-nav-itemed > .layui-nav-child {
            padding: 0;
        }

        .custom-two-mid {
            color: #0088cc;
        }

        .layui-side-menu .layui-nav .layui-nav-item > a {
            padding-top: 0px;
            padding-bottom: 0px;
        }

        .layui-layout-admin .layui-logo {
            height: 50px;
            box-shadow: none;
        }
        .zhcolor{
            color: #393D49;!important;
        }
        .layadmin-pagetabs{
            padding: 0 120px 0 40px;
        }
        .layadmin-pagetabs .layui-tab-title li{
            border-right: 1px solid #d0c9c9;
        }
        .layadmin-pagetabs .layui-tab-title li:hover{
            background-color: #93CEF9;
            color: #fff;
        }
        .layadmin-pagetabs .layui-tab-title li:hover .layui-tab-close{
            color: #fff;
        }
        .layadmin-pagetabs .layui-tab-title li.layui-this{
            background-color: #51B1F7;
            color: #fff;
        }
        .layadmin-pagetabs .layui-tab-title li.layui-this .layui-tab-close{
            color: #fff;
        }
        .layui-side-menu .layui-side-scroll{
            height: 99%;
        }
        .layui-side-menu .layui-side-scroll ul li:hover .newImg{
            opacity: 1;
        }
        .layadmin-pagetabs .layui-icon-refresh{
            right: 40px;
        }
        .layadmin-pagetabs .layui-icon-next{
            right: 80px;
        }
        .newImg{
            opacity: .7;
            margin-left: -24px;
            margin-right: 10px;
            margin-top: -1px;
            width: 16px;
        }
        .topIcon{
            width: 34px;
        }
        #admin-side0 .search_apply .custom_two li:hover{
            /*background-color: #042543;*/
            background-color: #e2f0ff;
        }
        #admin-side0 .search_custom .custom_two li:hover{
            background-color: #e2f0ff;
        }
        /*#shequ:hover{*/
        /*    background: url("/ui/img/community/newTitles.png");*/
        /*}*/
        .overTimeTips{
            width: 500px;
            background: #678fc9;
            position: absolute;
            top: 50%;
            margin: 0 auto;
             z-index: 999;
            right: 0;
            left: 0;
            height: 300px;
            color: white;
            font-size: 16px;
            margin-top: -150px;
        }
        #search_text {
            width: 200px;
            height: 50px;
            margin: 70px auto;
            font-size: 20px;
            text-align: center;
            line-height: 50px;
            color: #fff;
            background: orange;
            cursor: pointer;
        }
        #search_text:hover {
            transition: .3s;
            box-shadow: 1px 1px 5px rgb(169,169,169);
            text-shadow:  1px 1px 1px red;
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
        /^http(s*):\/\//.test(location.href) || alert('<fmt:message code="main.th.pleaseDeployFirst" />');
    </script>
</head>
<body class="layui-layout-body" style="display: none">
<div style="display: none">
    <audio src="/lib/audiojs/audio1.MP3" id="audios" preload="auto"/>
</div>
<div class="posifixed" id="fixedBody" style="display: none">
    <div style="position:fixed;width:200px;height:250px;left:50%;margin-left:-100px;top: 50%;margin-top: -229px;">
        <img style="width:100%;height:200px;" src="" class="personSrc"/>
        <span style="color: #fff;display: block;text-align: center;line-height: 77px;font-size: 26px;">
            <img src="/img/main_img/people.png" style="    vertical-align: initial;margin-right: 6px;"/>
            <span class="wybzd"></span>
        </span>
    </div>
    <div class="posifixedCenter" style="    margin-top: 65px;margin-left: -119px;">
        <label><input type="password" style="height:27px;    width: 224px;" placeholder="<fmt:message code="main.th.unlockCode" />"
                      style="margin-right: 10px;">
            <span id="theLock"
                  style=" right: -17px;top: 0px;width: 38px;height: 37px;line-height: 35px;border-radius: 4px;text-align:center;">
                <img src="/img/main_img/icon_lock.png"/>
            </span>
        </label>
    </div>
</div>
<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left" style="padding-left: 0;">
                <li class="layui-nav-item layadmin-flexible" lay-unselect>
                    <a class="headerhover" href="javascript:;" layadmin-event="flexible" title="<fmt:message code="main.th.sidebarExpansionAndContraction" />" style="height: 50px;">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"  style=" color: rgba(255,255,255,.7);font-size: 18px;"></i>
                        <%--                        <img src="/img/newTitle/top1.png" id="LAY_app_flexible" style="margin-top: -2px;width: 22px">--%>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs layuiMenuBox" lay-unselect style="width: auto;">
                    <a class="menubox headerhover" href="javascript:void(0)" title="">
                        <%--                        <i class="layui-icon layui-icon-app" style="margin: 0 10px;"></i>--%>
                        <img src="/img/newTitle/top2.png" style="margin: 0 8px;width: 18px">
                        <cite class="menuName" style="position: absolute;width: 57px;top: 1px;"></cite>
                    </a>
                    <div class="myMenuBox">
                        <div class="myMenuBoxContent">
                            <div class="clipper">
                                <div class="scroller">
                                    <div class="menu-items">
                                        <div data-id="00" onclick="menuHome($(this))" class="menu-item menu-color1"
                                             title="<fmt:message code="interfaceSetting.th.portal" />">
                                            <div class="menu-item-cover">
                                                <div class="menu-item-icon"> <img src="/img/newTitle/menhu.png" class="topIcon"></i>
                                                </div>
                                                <div class="menu-item-name"><fmt:message code="interfaceSetting.th.portal" /></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="layui-nav-item lay-unselect" onclick="common()" style="margin-left: 62px;">
                    <a class="headerhover" href="javascript:;" title="<fmt:message code="main.th.yiyong" />">
                        <%--                        <i class="layui-icon layui-icon-component" id=""></i>--%>
                        <img src="/img/newTitle/top3.png" style="width: 18px">
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a class="headerhover" href="javascript:;" layadmin-event="refresh" title="<fmt:message code="global.lang.refresh" />">
                        <%--                        <i class="layui-icon layui-icon-refresh-3"></i>--%>
                        <img src="/img/newTitle/top4.png" style="width: 18px">
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <input type="text" placeholder="<fmt:message code="main.print"/>" autocomplete="off" class="layui-input layui-input-search"
                           layadmin-event="serach" style="margin-bottom: 0px;padding-right: 30px;width: 175px;background: transparent;margin-left: 30px;color: rgba(255,255,255,.7);">
                    <img src="/img/newTitle/top11.png"  onclick="themeFunc(0,$(this))" title="<fmt:message code="workflow.th.sousuo" />" id="searchImg" style="position: absolute;left: 11px;top: 18px;width: 18px">

                </li>
                <li class="layui-nav-item layui-hide-xs secretText" lay-unselect style="width: auto; display: none;">
                    <span style="color:red; font-size: 16pt; font-family: Microsoft yahei;font-weight: bold;">机密级★ </span>
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">

                <%--                <li class="layui-nav-item" lay-unselect>--%>
                <%--                    <a title="消息中心" lay-href="sms/index" layadmin-event="message" lay-text="消息中心">--%>
                <%--                        <i class="layui-icon layui-icon-notice"></i>--%>

                <%--                        <!-- 如果有新消息，则显示小圆点 -->--%>
                <%--                        <span class="layui-badge-dot"></span>--%>
                <%--                    </a>--%>
                <%--                </li>--%>
                <li class="layui-nav-item" lay-unselect>
                    <a class="headerhover" href="javascript:;" onclick="themeFunc(1,$(this))" title="<fmt:message code="main.th.messageCenter" />">
                        <%--                        <i class="layui-icon layui-icon-notice"></i>--%>
                        <img src="/img/newTitle/top5.png" style="width: 18px">
                        <!-- 如果有新消息，则显示小圆点 -->
                        <span class="layui-badge-dot" style="width: 6px;height:6px;margin-left: 2px"></span>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect  id="zuzhi">
                    <a class="headerhover" title="<fmt:message code="global.lang.tissue" />" href="javascript:;" onclick="themeFunc(6,$(this))">
                        <%--                        <i class="layui-icon  layui-icon-group" title="组织"></i>--%>
                        <img src="/img/newTitle/top6.png" style="width: 20px">
                        <span style="display: none"><fmt:message code="global.lang.tissue" /></span>
                    </a>
                </li>

                <li class="layui-nav-item layui-hide-xs" id="shequ" lay-unselect lay-href="common/communityEntry">
                    <a class="headerhover" title="<fmt:message code="main.th.community" />">
                        <%--                        <img class="imgs" src="/ui/img/community/newsWhite.png" style="width: 17px;height: 16px">--%>
                        <%--                        <i class="layui-icon layui-icon-chat" style="font-weight: bold;" title="社区"></i>--%>
                        <img src="/img/newTitle/top7.png" style="width: 20px">
                        <span style="display: none"><fmt:message code="main.th.community" /></span>
                    </a>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a class="headerhover" href="javascript:;" onclick="themeFunc(2,$(this))" title="<fmt:message code="email.th.main" />">
                        <img src="/img/newTitle/top8.png" style="width: 20px">
                        <%--                        <i class="layui-icon layui-icon-theme"></i>--%>
                    </a>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a class="headerhover" href="javascript:;" layadmin-event="theme" title="<fmt:message code="main.th.colorScheme" />">
                        <img src="/img/newTitle/top9.png" style="width: 20px">
                        <%--                        <i class="layui-icon layui-icon-template-1"></i>--%>
                    </a>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a class="headerhover" href="javascript:;" layadmin-event="fullscreen" title="<fmt:message code="email.th.fullScreen" />" style="height: 50px;">
                        <i class="layui-icon layui-icon-screen-full" style=" color: rgba(255,255,255,.7);font-size: 18px;"></i>
                        <%--                        <img src="/img/newTitle/top10.png" style="width: 16px">--%>
                    </a>
                </li>

                <li class="layui-nav-item" lay-unselect style="margin-right: 20px"  id="theme">
                    <a href="javascript:;" onclick="themeFunc(3,$(this))">
                        <cite class="userName"></cite>
                        <span class="layuiMore"></span>
                    </a>
                    <%--                    <dl class="layui-nav-child">--%>
                    <%--                        <dd style="text-align: center;"><a lay-href="controlpanel/index">设置</a></dd>--%>
                    <%--                        &lt;%&ndash;<dd><a lay-href="set/user/password.html">修改密码</a></dd>&ndash;%&gt;--%>
                    <%--                        <hr style="margin: 5px 0">--%>
                    <%--                        <dd style="text-align: center;cursor: pointer" class="out"><a>退出</a></dd>--%>
                    <%--                    </dl>--%>
                    <%--                    <div class="usernameBox layui-nav-child">--%>

                    <%--                    </div>--%>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <%--<a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>--%>
                </li>
                <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
                    <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
            </ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu">
            <div class="layui-side-scroll">
                <div class="layui-logo" style="background: none;">
                    <c:choose>
                        <c:when test="${bannerText!=''&&bannerText!=undefined}">
                            <span style="${bannerFont}">${bannerText}</span>
                        </c:when>
                        <c:otherwise>
                            <img src="${LogoImg}" style="margin-left: 1%;height: 40px"/>
                        </c:otherwise>
                    </c:choose>
                </div>

                <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu" style="z-index:999">

                </ul>
                <div class="leftBoxBakG" style="position: relative"><img src="/img/newTitle/backgroundImg.png" style="height: 300px; width: 220px;position: fixed;bottom: 0px;"></div>
            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>

            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-refresh" layadmin-event="refresh"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect>
                        <a href="javascript:;"></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;"><fmt:message code="main.th.closeTheCurrentTab" /></a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;"><fmt:message code="main.th.closeOtherTabs" /></a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;"><fmt:message code="main.th.closeAllTabs2" /></a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
            <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="" lay-attr="" class="firstmenu layui-this">
                        <i class="layui-icon layui-icon-home" style="font-size: 15px;line-height: 43px;"></i>
                    </li>
                </ul>
            </div>
        </div>


        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="" frameborder="0" id="some_frame_id" class="layadmin-iframe"></iframe>
            </div>
        </div>

        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
</div>
<div class="overTimeTips" style="display: none;">
    <div style="width: 76%;margin-left: 12%;margin-top: 20px;">
        <span><fmt:message code="main.th.esteemedUser" />：</span><br>
        <div style="margin-top: 10px"><span style="padding-left: 35px;"><fmt:message code="main.th.thank" /></span><br></div>
        <div style="margin-top: 20px"><span><fmt:message code="main.th.remind1" /><span class="residue" style="color: red">0</span><fmt:message code="main.th.remind2" /></span><br></div>
        <div style="margin-top: 20px"><span><fmt:message code="main.th.contactNumber" /><span style="margin-left: 30px;"><fmt:message code="main.th.qqGroup" /></span></span><br></div>
        <div style="margin-top: 20px">
            <span class="countdown" style="margin-left: 34%"><fmt:message code="main.th.countdown" /><span class="countTime" style="color: red">10</span><fmt:message code="system.th.second" /></span>
            <div class="register" style="display: inline-block;float: right;font-size: 14px;background: red;padding: 2px 5px;cursor: pointer"><fmt:message code="main.th.softwareRegistration" /></div>
        </div>
    </div>
</div>
<ul class="side_all">
    <li class="position" id="admin-side0" style="overflow-y: auto">
        <div class="skin">
            <h2 style="width: 90%;height:100%;line-height: 45px;text-align: center;font-size: 16pt;font-weight: bold;">
                <fmt:message code="workflow.th.sousuo"/>
            </h2>
        </div>
        <div class="search_cont">
            <ul class="search-cont-cus">
                <li class="search_custom">
                    <div class="search_one_all"><img class="custom_photo" src="img/main_img/custom.png" alt=""
                                                     style="margin-top: 8px;margin-bottom: 5px;margin-left: 16px;">
                        <h1 class="custom_name" style="line-height: 39px;"><fmt:message code="journal.th.user"/></h1>
                        <img src="img/main_img/cus_open.png" class="custom_close" alt="" style="margin-top: 15px;">
                        <h2 id="userSearchNum" class="custom_num"
                            style="line-height: 39px!important;"></h2>

                    </div>
                    <div class="search_two_all">
                        <ul class="custom_two">
                        </ul>
                    </div>
                </li>
                <li class="search_apply">

                    <div class="search_one_all" style="border-bottom: 1px solid #ccc;"><img class="apply_photo"
                                                                                           src="img/main_img/apply.png"
                                                                                           alt="">
                        <h1 class="apply_name" style="width: 8em;"><fmt:message code="main.th.function1"/></h1>
                        <img src="img/main_img/cus_open.png" class="custom_close" style="margin-top: 15px;" alt="">
                        <h2 id="applySearchNum" class="apply_num"></h2>
                    </div>
                    <div class="search_two_all">
                        <ul class="custom_two">
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <div id="search_text" data-id="3035" lay-href="/attachPriv/fullTextSearch">
            <p><fmt:message code="main.th.enterFullTextRetrieval" /></p>
        </div>
    </li>
    <li class="position" id="admin-side1">
        <div class="skin" style="position: relative;">
            <img class="reloadSide" src="/img/icon_refresh_10.png"
                 style="position: absolute;left: 16px;top: 13px;cursor: pointer" alt="">
            <h2 style="width: 100%;height:100%;line-height: 45px;text-align: center;font-size: 16pt;font-weight: bold;">
                <fmt:message code="notice.th.reminder" /></h2>

        </div>
        <div class="noReminding" style="text-align: center;width: 100%;display: none;">
            <img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">
            <h2 style="text-align: center;color: #666;"><fmt:message code="main.th.noReminderForNow" /></h2>
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

                <%--速卓审批--%>
                <li class="search_custom" id="suzhuoId" style="display: none">
                    <div class="search_one_all">
                        <img class="custom_photo" style="width: 22px;height: 22px;margin-top: 1px;margin-left: 16px;"
                             src="/img/main_img/app/s0.png" alt="">
                        <h1 class="custom_name" style="margin-left: 7px;">速卓审批
                        </h1>
                        <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                        <h2 id="suzhuoId1" class="custom_num"></h2>
                        <img class="oneKeyRead read_suzhuo" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                    </div>
                    <div class="search_two_all" style="display: none">
                        <ul class="custom_two" id="suzhuoIdurl">

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
                        <h1 class="custom_name">合同管理
                        </h1>
                        <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                        <h2 id="contractremindPlan" class="custom_num"></h2>
                        <img class="oneKeyRead read_contract" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
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
                <%--证照管理--%>
                <%--计划考核事物提醒--%>
                <li class="search_custom" id="zhengzhao" style="display: none">
                    <div class="search_one_all">
                        <img class="custom_photo" style="margin-top: 3px;width: 22px;"
                             src="/img/task/taskremind.png" alt="">
                        <h1 class="custom_name">证照管理
                        </h1>
                        <img src="img/main_img/cus_close.png" class="custom_close" alt="">
                        <h2 id="zzgl" class="custom_num"></h2>
                        <img class="oneKeyRead read_34" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                    </div>
                    <div class="search_two_all" style="display: none">
                        <ul class="custom_two" id="licenselists">

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
                        <img class="oneKeyRead read_35" src="/img/main_img/icon_unread.png" title="<fmt:message code="main.th.oneClickReading" />" alt="">
                    </div>
                    <div class="search_two_all" style="display: none">
                        <ul class="custom_two" id="ehrWorkList">

                        </ul>
                    </div>
                </li>

            </ul>
            <div class="loadAnimate">
                <i class="layui-icon layui-icon-loading layui-icon layui-anim layui-anim-rotate layui-anim-loop" style="font-size: 50px;color: #27ade6;"></i>  </div>
        </div>

    </li>

    <li class="position" id="admin-side6" >   <%-- style="overflow: auto"--%>
        <div class="skin" style="position: relative;">
            <h2 style="width: 100%;height:100%;line-height: 45px;text-align: center;font-size: 10pt;font-weight: bold;">
                <i class="layui-icon  layui-icon-group" title="<fmt:message code="global.lang.tissue" />" style="margin-right: 3px"></i><fmt:message code="global.lang.tissue" /></h2>

        </div>
        <div id="admin-side6s" >

        </div>

    </li>
    <li class="position" id="admin-side2" >  <%--style="overflow-y: auto"--%>
        <div class="skin" style="position: fixed;z-index: 999;">
            <h2 style="width:249px;height:100%;line-height: 45px;text-align: left;font-size: 10pt;font-weight: bold;margin-left: 15px;text-align: center">
                <fmt:message code="interfaceSetting.th.SelectInterface" />
            </h2>

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
    <li class="position usernameBox" id="admin-side3" style="z-index: 19991018;display: none">
        <div class="per_back" style="padding-top: 20px;">

            <div class="per_all" style="width:100%;">
                <div style="width: 50px;height:50px;margin:auto;">
                    <img onerror="imgerror(this,1)" class="yonghu_touxiang" alt=""
                         style="border-radius: 100%;width: 100%;height: 100%;">
                </div>
                <h1></h1>
                <h3 id="deptInfo"></h3>
                <h2 class="juede_suopings" style="margin-top: -12px"></h2>
                <h2 class="juede_suoping" style="margin-top: -8px;display: none"></h2>
                <h2 id="user_secrecy"></h2>

            </div>
        </div>
        <button class="per_shezhi" lay-href="controlpanel/index">
            <a id="layui-nav-childA" style=" background: none;">
                <div class="button_img shezhi_img"></div>
                <span class="button_span"><fmt:message code="main.th.Set"/></span>
            </a>
        </button>
        <button class="per_suoding">
            <div class="button_img suoding_img"></div>
            <span class="button_span"><fmt:message code="main.th.locking"/></span>
        </button>
        <label style="display: none">
            <input type="password" style="margin-left: 44px; width: 160px;border-top-right-radius: 0px;
                                    border-bottom-right-radius: 0px;"
                   name="lockCode" placeholder="<fmt:message code="main.th.lockPassword" />">
            <span id="LockCode"
                  style="vertical-align: top;height: 30px;display: inline-block;width: 31px;text-align: center;line-height: 27px;border-top-right-radius: 6px;border-bottom-right-radius: 6px;">
                                        <img src="/img/main_img/locktwos.png" alt="">
                                    </span>
        </label>
        <button class="per_zhuxiao" id="per_zhuxiao">
            <div class="button_img zhuxiao_img"></div>
            <span class="button_span"><fmt:message code="main.cancellation"/></span>
        </button>
    </li>
</ul>

<script src="/lib/layui/layuiadmin/layui/layui.js"></script>
<script src="/js/main_js/index20.js?20230425.1"></script>
<script>
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            if(res.object[0].paraValue == 1) {
                $(".secretText").show()
            }else {
                $(".secretText").hide()
            }
        }
    })
    var uid = $.cookie("uid");
    $.ajax({
        url:"/userFunciton/getMenuByUid",
        data: {
            uid: uid
        },
        success:function(res) {
             const hasFullText = res.object.userFunCidStr.split(",").includes("321");
             if(hasFullText) {
                 $('#search_text').css("display","block")
             }else {
                 $('#search_text').css("display","none")
             }
        }
    })
<%--    全文检索按钮点击事件--%>
$("#search_text").on("click",function() {
    var id = $(this).attr("data-id");
    $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').trigger('click');
})
    //回车事件
    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            themeFunc(0,$('#searchImg'))
        }
    });
    var loginInterface = 1;
    $.ajax({
        url: '/sys/getInterfaceInfo',
        method: 'GET',
        async: false,
        success: function(json){
            if (json.flag) {
                document.title = json.object.ieTitle;
                if(json.object.loginInterface != ''&&json.object.loginInterface == 0){
                    loginInterface = json.object.loginInterface;
                }

            }
        }
    });

    layui.config({
        base: '/lib/layui/layuiadmin/', //静态资源所在路径
        version: '20230425.1'
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index');
</script>

<!-- 百度统计 -->
<script>
    // 如果是IE浏览器就提示
    if(BrowserisIE() || myBrowser()== 'IE11'){
        layui.use('layer', function(){
            var layer = layui.layer;
            setTimeout(function(){
                layer.open({
                    type: 1,
                    title: '<fmt:message code="main.th.FriendshipTips" />',
                    time: 12000,
                    offset: 'auto',
                    area: ['360px', '160px'],
                    skin: 'ieTips',
                    closeBtn: 0, //不显示关闭按钮
                    anim: 2,
                    shadeClose: true, //开启遮罩关闭
                    content: '<div class="ieTipsText"><fmt:message code="main.th.browserisIERemindContent" /></div>'
                });
            }, 1500)

        });
    }
    $('.per_shezhi').on('click', function () {
        $(".layui-layer-shade").trigger("click");
    });
    var menuflag = false;
    $('.layuiMenuBox').on('mouseenter', function(){
        $('.myMenuBox').show(200);
        menuflag = true
    }).on('mouseleave', function(){
        menuflag = false;
        setTimeout(function(){
            if(!menuflag){
                $('.myMenuBox').hide(200);
            }
        },500);
    });
    //判断是否开启分支机构
    var paraValues = "";
    $.ajax({
        url:"/syspara/queryOrgScope",
        dataType: 'json',
        success:function(res) {
            paraValues = res.object.paraValue;
        }
    })
    $.ajax({
        url: '/getChDeptBai',
        type: 'get',
        // data: data,
        dataType: 'json',
        success: function (data) {
            var str = '';
            data.obj.forEach(function (v, i) {
                if (v.deptName) {
                    str += '<li style="margin-top:20px;font-size: 13px;" ><span data-types="1"  data-numtrue="1" ' +
                        'onclick= "imgDownsd(' + v.deptId + ',this)"   deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                        '<img id="image" src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                        '<a href="javascript:void(0)" class="dynatree-title zhcolor" title="' + v.deptName + '">' + v.deptName +
                        function () {
                            if (paraValues == 1 && v.classifyOrg == 1) {
                                return '<img  style="width: 25px" src="/img/common/branch.png"alt="<fmt:message code="main.th.affiliatedAgency" />"title="<fmt:message code="main.th.affiliatedAgency" />">'
                            } else {
                                return "";
                            }
                        }()+
                        '</a></span>' +
                        '<ul id="rightDept_' + v.deptId + '"  style="display:none;" class="dpetWhole0" ></ul></li>';
                }
            })
            $('#admin-side6s').html(str);
        }
    })

    function imgDownsd(deptid,me) {
        if ($(me).attr('data-types') == undefined) {
            $(me).find('#image').attr('src', $(me).find('#image').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#image').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#image').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('#image').width(8);
                $(me).find('#image').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('#image').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#image').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('#image').width(14);
                $(me).find('#image').height(9);
                $(me).next().show();
            }
        }
        else {
            $(me).find('#image').attr('src', $(me).find('#image').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#image').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#image').width(8);
                $(me).find('#image').height(14);
            } else if ($(me).find('#image').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#image').width(14);
                $(me).find('#image').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                // $('.dpetWhole0').empty();
                $("#rightDept_" + deptid + "").empty();
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {

                $(me).next().hide();
                $(me).attr('data-types', '1')
            }
        }
        $.ajax({
            // url: '/getUserByCondition',
            url: '/department/getChDeptfq',
            type: 'get',
            data: {
                deptId: deptid
            },
            dataType: 'json',
            success: function (data) {

                var str1 = '';
                var str2 = '';
                if ($('.dpetWhole0',this).children('li').length == 0) {
                    for (var i = 0; i < data.object.length; i++) {
                        str1 += '<li style="margin-top: 10px"><span onclick="clickrenwus(' + data.object[i].uid + ')" userId="'+data.object[i].userId+'" data-uid="' + data.object[i].uid + '" data-numString="1"  class="childdept role"><span></span>' +
                            '<img  src="' + function () {
                                var avatar = data.object[i].avatar;
                                if (avatar == undefined || avatar == "") {
                                    avatar = data.object[i].sex;
                                    if(avatar == undefined || avatar == ""){
                                        return '/img/email/icon_head_man_06.png'
                                    }
                                }
                                if (avatar == 0) {
                                    return '/img/email/icon_head_man_06.png'
                                } else if (avatar == 1) {
                                    return '/img/email/icon_head_woman_06.png'
                                } else {
                                    return '/img/user/' + data.object[i].avatar
                                }
                            }() + '" onerror="imgerror(this,1)" style="width: 25px;height:25px;margin-top:3px;margin-left:25px;border-radius: 50%;" alt="">&nbsp;' +
                            '<a href="javascript:void(0)" style="font-size: 13px;margin-left: 15px;margin-top: 0px;padding-top: -26px;display: inline-block;" class="dynatree-title zhcolor" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';

                    }
                    // $('.dpetWhole0').html(str1);
                    $("#rightDept_" + deptid + "").append(str1);

                    // $('.dpetWhole0').html(str1);
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            str2 += '<div id="str2" style="margin-top: -5px;">' +
                                '<li id="deptNames" style="margin-top:20px;font-size: 13px;" ><span data-types="1"  data-numtrue="1" ' +
                                'onclick= "imgDownsds(' + v.deptId + ',this)"   deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                                '<img id="images" src="/img/sys/dapt_right.png" alt="" style="margin-left: 42px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                '<a style="margin-left: 65px" href="javascript:void(0)" class="dynatree-title zhcolor" title="' + v.deptName + '">' + v.deptName +
                                function () {
                                    if (paraValues == 1 && v.classifyOrg == 1) {
                                        return '<img  style="width: 25px" src="/img/common/branch.png"alt="<fmt:message code="main.th.affiliatedAgency" />"title="<fmt:message code="main.th.affiliatedAgency" />">'
                                    } else {
                                        return "";
                                    }
                                }()+
                                '</a></span>' +
                                '<ul id="rightDept_' + v.deptId + '" style="display:none;" class="dpetWhole0s" ></ul></li>' +
                                '</div>'
                        }
                    })
                    // $('.dpetWhole0').append(str2);
                    $("#rightDept_" + deptid + "").append(str2);
                }

            }
        })

    }

    function imgDownsds(deptid,me) {
        if ($(me).attr('data-types') == undefined) {
            $(me).find('#images').attr('src', $(me).find('#images').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#images').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#images').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('#images').width(8);
                $(me).find('#images').height(14);
                // $(me).next().hide();
                // $('.dpetWhole0s').hide();
                $('.dpetWhole0s').html('');
                // $(me).next().html('')

            } else if ($(me).find('#images').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#images').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('#images').width(14);
                $(me).find('#images').height(9);
                // $(me).next().show();
                // $('.dpetWhole0s').show();


            }
        }
        else {
            $(me).find('#images').attr('src', $(me).find('#images').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#images').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#images').width(8);
                $(me).find('#images').height(14);
            } else if ($(me).find('#images').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#images').width(14);
                $(me).find('#images').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $("#rightDept_" + deptid + "").empty();
                // $('.dpetWhole0s').empty();
                // $('.dpetWhole0s').show();
                $(me).next().show();
                $(me).attr('data-types', '2')

            } else if ($(me).attr('data-types') == '2') {

                // $('.dpetWhole0s').hide();
                $(me).next().hide();
                $(me).attr('data-types', '1')

            }
        }
        $.ajax({
            // url: '/getUserByCondition',
            url: '/department/getChDeptfq',
            type: 'get',
            data: {
                deptId: deptid
            },
            dataType: 'json',
            success: function (data) {

                var str3 = '';
                var str3s = '';
                if ($('.dpetWhole0s',this).children('li').length == 0) {
                    for (var i = 0; i < data.object.length; i++) {
                        str3 += '<li style="margin-top: 10px;margin-left: 35px;"><span onclick="clickrenwus(' + data.object[i].uid + ')" userId="'+data.object[i].userId+'" data-uid="' + data.object[i].uid + '" data-numString="1"  class="childdept role"><span></span>' +
                            '<img onerror="imgerror(this,1)" src="' + function () {
                                var avatar = data.object[i].avatar;
                                if (avatar == undefined || avatar == "") {
                                    avatar = data.object[i].sex;
                                }
                                if (avatar == 0) {
                                    return '/img/email/icon_head_man_06.png'
                                } else if (avatar == 1) {
                                    return '/img/email/icon_head_woman_06.png'
                                } else {
                                    return '/img/user/' + data.object[i].avatar
                                }
                            }() + '" style="width: 25px;height:25px;margin-top:3px;margin-left:25px;border-radius: 50%;" alt="">&nbsp;<a href="javascript:void(0)" style="margin-left: 15px;margin-top: 0px;padding-top: -26px;display: inline-block;" class="dynatree-title zhcolor" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>' ;

                    }
                    // $('#'+deptid+'').append(str3);
                    $("#rightDept_" + deptid + "").append(str3);
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            str3s += '<div id="str3s" style="margin-left: 30px;margin-top: -5px;">' +
                                '<li id="deptNames3" style="margin-top:20px;font-size: 13px;" ><span data-types="1"  data-numtrue="1" ' +
                                'onclick= "imgDownsds(' + v.deptId + ',this)"   deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                                '<img src="/img/sys/dapt_right.png" alt="" style="margin-left: 42px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                '<a style="margin-left: 65px" href="javascript:void(0)" class="dynatree-title zhcolor" title="' + v.deptName + '">' + v.deptName +
                                function () {
                                    if (paraValues == 1 && v.classifyOrg == 1) {
                                        return '<img  style="width: 25px" src="/img/common/branch.png"alt="<fmt:message code="main.th.affiliatedAgency" />"title="<fmt:message code="main.th.affiliatedAgency" />">'
                                    } else {
                                        return "";
                                    }
                                }()+
                                '</a></span>' +
                                '<ul id="rightDept_' + v.deptId + '" style="display:none;" class="dpetWhole0s" ></ul></li>' +
                                '</div>'
                        }
                    })
                    // $('.dpetWhole0').append(str2);
                    $("#rightDept_" + deptid + "").append(str3s);

                }

            }
        })

    }

    function clickrenwus(uid){
        layer.open({
            type:2,
            title:'',
            shade: 0.3,
            area: ['750px', '450px'],
            content: '/sys/userDetails?uid='+uid,
        })
        // window.open('/sys/userDetails?uid=' + uid  )
    }

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
    var _hmt = _hmt || [];
    var storage = window.localStorage;
    //20门户，在不同颜色主题下控制头部header十字分割线是否准确的效果和搜索框样式随主题颜色变化而变化的效果
    if ($.cookie('color') == undefined || $.cookie('color') == 0 || $.cookie('color') == 1 || $.cookie('color') == 2 || $.cookie('color') == 3 || $.cookie('color') == 4 || $.cookie('color') == 5 || $.cookie('color') == 6 || $.cookie('color') == 7 || $.cookie('color') == 8) {
        $('style').append('.layui-layout-admin .layui-header{border: none;}.layui-layout-admin .layui-input-search{border: none;}')
    } else {
        $('style').append('.layui-layout-admin .layui-header{border-bottom: 1px solid #f6f6f6;}')
    }
    //end
    storage.clear();
    (function () {
        $('.side_all').height($(window).height() - 50);
        $('.usernameBox').height($(window).height() - 50);
      
        try{
            //新消息声音功能开启
            audiojs.events.ready(function () {
                as = audiojs.createAll();
                listTable();
                dataLoad.init();
            });
            //新消息声音功能结束
        }catch(e){
            console.log(e);
            listTable();
            dataLoad.init();
        }

        layui.use(['element', 'layer'], function () {
            var layer = layui.layer;
            //var indexload = layer.load();
            $('.subjectToUse').on('click', function () {
                var menuExpand = '';
                var index = layer.load(1);
                $.ajax({
                    type: "post",
                    url: "/users/getUserTheme",
                    dataType: 'json',
                    data: '',
                    async: false,
                    success: function (res) {
                        menuExpand = res.object.menuExpand
                    }
                })
                var typedata = $(this).find('a').attr('data-type')
                $.get('/users/addAndApplicationUsers', {theme: typedata, menuExpand: menuExpand}, function (json) {
                    if (json.flag) {
                        layer.msg('<fmt:message code="menuSSetting.th.editSuccess" />！', {icon: 1}, function (index) {
                            location.reload()
                            layer.close(index);
                        });
                    } else {
                        layer.msg('<fmt:message code="depatement.th.modifyfailed" />！', {icon: 2}, function (index) {
                            layer.close(index);
                        });
                    }

                })
            });
            $.ajax({
                url: 'showMenu',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    var data = obj.obj;
                    var str = '', str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var er = '';
                        for (var j = 0; j < data[i].child.length; j++) {
                            if (data[i].child[j].child.length > 0) {
                                var three = '';
                                for (var k = 0; k < data[i].child[j].child.length; k++) {
                                    three += '<dd data-name="console"><a class="hrefmenu" data-id="' + data[i].child[j].child[k].id + '" lay-href="' + function () {
                                        return data[i].child[j].child[k].url;

                                    }() + '" title="' + data[i].child[j].child[k].name + '">' + data[i].child[j].child[k].name + '</a></dd>';
                                }
                                er += '<dd data-name="console"><a href="javascript:;" title="' + data[i].child[j].name + '">' + data[i].child[j].name + '</a><dl class="layui-nav-child">' + three + '</dl></dd>';
                            } else {
                                er += '<dd data-name="console"><a class="hrefmenu" data-id="' + data[i].child[j].id + '" lay-href="' + function () {
                                    return data[i].child[j].url;
                                }() + '"  title="' + data[i].child[j].name + '">' + data[i].child[j].name + '</a></dd>';
                            }
                        }
                        str += '<li data-name="home" class="layui-nav-item menuLite" id="LeftMenu_'+data[i].id+'" style="display: none;"><a href="javascript:;" data-id="' + data[i].id + '" title="' + data[i].name + '"  lay-direction="' + data[i].id + '">' +
                                '<img class="newImg" src="/img/menu/20/little_pic/'+ data[i].id +'.png" />'+
                            '<cite>' + data[i].name + '</cite>' +
                            '</a><dl class="layui-nav-child">' + er + '</dl></li>';

                        str1 += '<div data-id="' + data[i].id + '" id="allMenu_'+data[i].id+'" onclick="menuItem($(this))" class="menu-item menu-color' + i%5 + '" title="' + data[i].name + '"><div class="menu-item-cover"><div class="menu-item-icon">' +
                                '<img class="topIcon" src="/img/menu/20/middle_pic/'+ data[i].id +'.png"/>'+
                            '</div><div class="menu-item-name">' + data[i].name + '</div></div></div>\n'

                    }
                    $("#LAY-system-side-menu").append(str);
                    var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
                    element.init();
                    if(loginInterface == 0){
                        var str2 = '<div data-id="all" onclick="menuHome($(this))" class="menu-item menu-color3" title="<fmt:message code="main.allInUse"/>">\n' +
                            '                                            <div class="menu-item-cover">\n' +
                            '                                                <div class="menu-item-icon"><img src="/img/newTitle/quanbu.png" class="topIcon"></img>\n' +
                            '                                                </div>\n' +
                            '                                                <div class="menu-item-name"><fmt:message code="main.allInUse"/></div>\n' +
                            '                                            </div>\n' +
                            '                                        </div><div data-id="00" onclick="menuHome($(this))" class="menu-item menu-color2" title="<fmt:message code="interfaceSetting.th.portal" />">\n' +
                            '                                            <div class="menu-item-cover">\n' +
                            '                                                <div class="menu-item-icon"> <img src="/img/newTitle/menhu.png" class="topIcon"></i>\n' +
                            '                                                </div>\n' +
                            '                                                <div class="menu-item-name"><fmt:message code="interfaceSetting.th.portal" /></div>\n' +
                            '                                            </div>\n' +
                            '                                        </div>'
                        $('.myMenuBox .menu-items').html(str2);
                        $('.menuName').html('<fmt:message code="main.allInUse"/>');
                        $('.menubox').attr('title','<fmt:message code="main.allInUse"/>')
                        $('.menuLite').show();
                        $('.menuLi').hide();
                        // $('.menuLite').eq(0).find('a').eq(0).trigger('click');
                    }else{
                        $('.menuName').html('<fmt:message code="interfaceSetting.th.portal" />');
                        $('.menubox').attr('title','<fmt:message code="interfaceSetting.th.portal" />')

                    }
                    $('.myMenuBox .menu-items').append(str1);
                    //浏览器标题和注销文字的标题的接口

                    //判断默认展示菜单

                    var data = getUserThemeJson.object;
                    var menu = data.menuExpand;
                    if (data.userExt.menuPanel == '1'){
                        $('#LAY_app_flexible').trigger('click');
                    }
                    $('#LAY_app_flexible').attr('url','/userExt/userExtMenuPanel');

                    $(".menuLite").each(function(){
                        if($(this).attr("id") == menu){
                            if(!$('a[data-id='+ $(this).attr("id") +']').parent().hasClass('layui-nav-itemed')){
                                $('a[data-id='+ $(this).attr("id") +']').trigger('click');
                            }
                        }
                    });

                }
            });//ajax传入应用数据结束括号
            //左侧门户数据获取
            $.ajax({
                url: '/portals/selIndexPortals',
                type: 'get',
                dataType: 'json',
                success: function (json) {
                    var str = '';
                    if (json.flag) {
                        var data = json.obj;
                        var firststr = '';
                        var firstIframe = '';
                        for (var i = 0; i < data.length; i++) {
                            var href = '';
                            var menhuclass = 'layui-icon-layer';

                            //启用标记(0-停用,1-启用) ,这里只显示已经启用
                            if (data[i].useFlag == 1){
                                // 处理时尚全能主题菜单-门户使用的icon
                                if (data[i].moduleId == "/common/myOA2") {
                                    menhuclass = 'layui-icon-username';
                                } else if (data[i].moduleId == "/common/applyOA") {
                                    menhuclass = 'layui-icon-app';
                                } else if (data[i].moduleId == "/document/companyPortal") {
                                    menhuclass = 'layui-icon-layouts';
                                } else if (data[i].moduleId == "/portal/flowIndex") {
                                    menhuclass = 'layui-icon-user';
                                } else if (data[i].moduleId == "/document/documentIndex") {
                                    menhuclass = 'layui-icon-file';
                                } else if (data[i].moduleId == "/document/knowledgeIndex") {
                                    menhuclass = 'layui-icon-read';
                                } else if (data[i].moduleId == "/document/humanResource") {
                                    menhuclass = 'layui-icon-group';
                                } else if (data[i].moduleId == "/document/marketIndex") {
                                    menhuclass = 'layui-icon-tabs';
                                } else if (data[i].moduleId == "/document/financialIndex") {
                                    menhuclass = 'layui-icon-rmb';
                                } else if (data[i].moduleId == "/document/reportFormIndex") {
                                    menhuclass = 'layui-icon-date';
                                } else if (data[i].moduleId == "/document/managementIndex") {
                                    menhuclass = 'layui-icon-table';
                                } else {
                                    if (data[i].portalType == 2) {
                                        href = '/cmsPub/portal?siteId=' + data[i].moduleId;
                                    }
                                }

                                //加这个判断是为了从数据库里面查，如果找不到用默认的
                                if (data[i].portalType != 2 && data[i].moduleId != ''){
                                    href = data[i].moduleId;
                                }

                                if (i == 0) {
                                    var classnew = 'layui-this';
                                    $('.firstmenu').attr({
                                        'lay-id': href,
                                        'lay-attr': href
                                    }).find('i').eq(0).after('<span style="margin-left: 5px;">'+data[i].portalName+'</span>');
                                    $('.layadmin-iframe').attr('src', href);
                                } else {
                                    var classnew = '';

                                    firstIframe += '<div class="layadmin-tabsbody-item"><iframe src="" frameborder="0" class="layadmin-iframe" willsrc="'+ href +'"></iframe></div>';
                                    firststr += '<li lay-id="'+ href +'" lay-attr="'+ href +'" class=""><span>'+ data[i].portalName +'</span></li>'
                                }
                                var hide = '';
                                if(loginInterface == 0){
                                    hide = 'display: none;'
                                }
                                str += '<li data-name="home" class="layui-nav-item menuLi ' + classnew + '" style="'+ hide +'">' +
                                    '<a href="javascript:;"  lay-href="' + href + '" title="' + data[i].portalName + '">' +
                                    '<i class="layui-icon ' + menhuclass + '"></i>' +
                                    '<cite>' + data[i].portalName + '</cite>' +
                                    '</a></li>';
                            }
                        }
                        if(loginInterface == 0){
                            $('.firstmenu').after(firststr);
                            $('#LAY_app_body').append(firstIframe);
                        }

                        $("#LAY-system-side-menu").append(str);
                    }
                }
            });
            //传入用户个人资料的数据
            $.ajax({
                url: '/user/findUserByuid',
                type: 'get',
                data: {
                    uid: $.cookie('uid')
                },
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag == true) {
                        var data = obj.object;
                        var img = data.avatar;
                        var name = data.userName;
                        var userPrivOtherName = data.userPrivOtherName;
                        var dept = data.deptName;
                        var postName = data.postName;
                        var userPrivName = data.userPrivName;
                        var userSecrecyCode = data.userSecrecy;
                        //判断当前人员是否属于三员人员
                        var secrecyAdm = data.secrecyAdm;
                    }
                    if (data.sex == 0) {
                        var src = '/img/user/boy.png';
                    }
                    else if (data.sex == 1) {
                        var src = '/img/user/girl.png';
                    }
                    if (data.avatar != 0 && data.avatar != 1 && data.avatar != '') {
                        var src = '/img/user/' + data.avatar;
                    }
                    $('.userName').html(name).before('<img src="' + src + '" class="layui-nav-img">');
                    $('.yonghu_touxiang').attr('src', src);
                    $.ajax({
                        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                        success:function(res) {
                            var data = res.object[0];
                            //开启了三员管理
                            if(data.paraValue == 0) {
                                $("#shequ").hide()
                                //这种情况下需要展示 部门 职务密 级别
                                if(!secrecyAdm || secrecyAdm != 1) {
                                    $('.per_all').find('h1').html('<span class="textSpan"><fmt:message code="userDetails.th.name" />:</span><span class="contentSpan">'+name+'</span>');

                                    if (postName && userPrivName) {
                                        // $('.per_all').find('h2').html(userPrivName+','+postName);
                                        $('.per_all').find('.juede_suoping').html(userPrivName)
                                        $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+postName+'</span>')
                                    }
                                    if (userPrivName && postName == undefined) {
                                        $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+userPrivName+'</span>')
                                    }
                                    if (postName && userPrivName == undefined) {
                                        $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+postName+'</span>')
                                    }
                                    var userPriv = userPrivOtherName;
                                    if (userPriv !== undefined) {
                                        if (userPriv.length > 20) {
                                            $('.per_all').find('h2').eq(1).html(userPriv.substring(0, 20) + "...");
                                            $('.per_all').find('h2').eq(1).mouseout(function () {
                                                $('.per_all').find('h2').eq(1).attr('title', userPriv.substring(0, userPriv.length - 1));
                                            });
                                        } else {
                                            $('.per_all').find('h2').eq(1).html(userPriv.substring(0, userPriv.length - 1));
                                        }
                                        if (dept != undefined) {
                                            $('.per_all').find('h3').html('<span class="textSpan"><fmt:message code="userManagement.th.department" />:</span><span class="contentSpan">'+dept+'</span>');
                                        }


                                    } else {
                                        if (dept != undefined) {
                                            $('.per_all').find('h3').html('<span class="textSpan"><fmt:message code="userManagement.th.department" />:</span><span class="contentSpan">'+dept+'</span>');
                                        }
                                    }
                                }else {
                                    $("#user_secrecy").hide();
                                    $(".juede_suopings").hide();
                                    $("#deptInfo").hide();

                                }
                            }else {
                                $("#shequ").show()
                            //    进入此处，说明没有开启三员管理,展示所有信息
                                $('.per_all').find('h1').html('<span class="textSpan"><fmt:message code="userDetails.th.name" />:</span><span class="contentSpan">'+name+'</span>');

                                if (postName && userPrivName) {
                                    // $('.per_all').find('h2').html(userPrivName+','+postName);
                                    $('.per_all').find('.juede_suoping').html(userPrivName)
                                    $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+postName+'</span>')
                                }
                                if (userPrivName && postName == undefined) {
                                    $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+userPrivName+'</span>')
                                }
                                if (postName && userPrivName == undefined) {
                                    $('.per_all').find('.juede_suopings').html('<span class="textSpan"><fmt:message code="userManagement.th.role" />:</span><span class="contentSpan">'+postName+'</span>')
                                }
                                var userPriv = userPrivOtherName;
                                if (userPriv !== undefined) {
                                    if (userPriv.length > 20) {
                                        $('.per_all').find('h2').eq(1).html(userPriv.substring(0, 20) + "...");
                                        $('.per_all').find('h2').eq(1).mouseout(function () {
                                            $('.per_all').find('h2').eq(1).attr('title', userPriv.substring(0, userPriv.length - 1));
                                        });
                                    } else {
                                        $('.per_all').find('h2').eq(1).html(userPriv.substring(0, userPriv.length - 1));
                                    }
                                    if (dept != undefined) {
                                        $('.per_all').find('h3').html('<span class="textSpan"><fmt:message code="userManagement.th.department" />:</span><span class="contentSpan">'+dept+'</span>');
                                    }


                                } else {
                                    if (dept != undefined) {
                                        $('.per_all').find('h3').html('<span class="textSpan"><fmt:message code="userManagement.th.department" />:</span><span class="contentSpan">'+dept+'</span>');
                                    }
                                }
                                $.ajax({
                                    url:"/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET",
                                    success:function(res) {
                                        var data = res.object[0];
                                        if(data.paraValue == 1) {
                                            if(userSecrecyCode){
                                                //查询系统代码人员密级
                                                $.ajax({
                                                    url: '/code/getCode?parentNo=USER_SECRECY',
                                                    type: 'get',
                                                    dataType: 'json',
                                                    success: function (res) {
                                                        var data=res.obj;
                                                        for(var i=0; i<data.length; i++){
                                                            if (data[i].codeNo == userSecrecyCode) {
                                                                $("#user_secrecy").html('<span class="textSpan"><fmt:message code="dem.th.Dense" />:</span><span class="contentSpan">'+data[i].codeName+'</span>');
                                                            }
                                                        }
                                                    }
                                                })
                                            }else {
                                                $("#user_secrecy").html('<span class="textSpan"><fmt:message code="dem.th.Dense" />:</span><span class="contentSpan">无</span>');
                                            }
                                        }
                                    }
                                })
                            }
                        }
                    })


                    $('.personSrc').attr('src', $.cookie('personSrc'))
                    $('.wybzd').text($('.juede_suoping').text())
                }
            })
            //左侧常用菜单数据获取
            $.get('/getUsuallyMenu', function (res) {
                if (res.flag) {
                    var str;
                    var data = res.obj;
                    for (var i = 0; i < data.length; i++) {
                        var url = data[i].url

                        if (data[i].id == '3010') {
                            url += '?muType=0'
                        }
                        if (data[i].id == '3001' || data[i].id == '0136') {
                            url += '?0'
                        }
                        str += '<li data-name="home" class="layui-nav-item common" style="display: none">' +
                            '<a href="javascript:;" title="' + data[i].name + '" data-id="' + data[i].id + '"  lay-href="' + url + '">' +
                            //                            '<i class="layui-icon ' + menhuclass + '"></i>' +
                            '<cite>' + data[i].name + '</cite>' +
                            '</a></li>';
                    }
                    str += '<li data-name="home" class="layui-nav-item common" style="display: none">' +
                        '<a href="javascript:;"  lay-href="/controlpanel/commonSettings">' +
                        '<i class="layui-icon layui-icon-set-sm"></i>' +
                        '<cite><fmt:message code="url.th.commonApplicationSettings" /></cite>' +
                        '</a></li>';
                    $("#LAY-system-side-menu").append(str);
                }
            })
            //未注册用户30天限制提醒
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
                            $('#LAY_app').css('pointer-events','none')
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
        });


    })();
    $('.register').on('click',function(){
        window.open('/sys/sysInfo');
    })
    $('#LAY-system-side-menu').on('click', 'a', function(){
        $('.leftBoxBakG img').css('width', '220px')
        var href = $(this).attr('lay-href')||'';
        if(href != ''){
            if($('#LAY_app_tabsheader li[lay-id="'+ href +'"]').length > 0){
                if($('#LAY_app_body iframe[src="'+ href +'"]').length == 0){
                    $('#LAY_app_body iframe[willsrc="'+ href +'"]').attr('src', href);
                }else{
                    $('#LAY_app_body iframe[src="'+ href +'"]').attr('src', href);
                }
            }
        }
    })
    $("#LAY_app_tabsheader").on('click','li',function(){
        var $this = $(this)
        var id = $this.attr('lay-id')
        if(id == '/common/myOA2' || id == '/common/applyOA'
            || id == '/document/managementIndex'|| id == '/portals/officePortal'
            || id == '/document/companyPortal'|| id == '/portal/flowIndex'
            || id == '/document/documentIndex'|| id == '/document/knowledgeIndex'
            || id == '/document/humanResource'|| id == '/document/gateway'
            || id == '/document/marketIndex'|| id == '/document/financialIndex'
            || id == '/document/reportFormIndex'|| id == '/portalSite/pwegDeptSite'
            || id == '/governmentPortal'|| id == '/portals/officeIndex'
            || id == '/portals/dazueduIndex'|| id == '/cdmResource/MemberPortal'
            || id == '/document/personIndex' || id == '/portals/myWorkPortal'
            || (id.indexOf('/cmsPub/portal') != -1) ){
            $('#LAY_app_body iframe[willsrc="'+ id +'"]').attr('src', id);

        }else{

        }
    })
</script>
</body>
</html>
