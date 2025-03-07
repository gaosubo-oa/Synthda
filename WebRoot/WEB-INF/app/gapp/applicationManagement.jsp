<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/12/6
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>应用管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20220824.2"></script>
</head>
<style>
    html,body{
        height: 100%;
        overflow: hidden;
    }
    .cont_left {
        height: calc(100% - 60px);
        border-right: none;
        overflow-y: auto;
        width: 100%;
    }
    .top{
        padding-top: 10px;
        border-bottom: 2px solid rgb(230,230,230);
        height: 50px;
        display: flex;
    }

    .top>#ying{
        width:20%
    }

    .top>.search-box{
        flex: 1;
    }

    .top>.new-app{
        width: 20%;
    }


    #search{
        background-color: rgb(16,127,255);
        line-height: 30px;
        margin-left: 10px;
        width: 50px;
        height: 37px;
        font-size: 16px
    }
    #add{
        background-color: rgb(64,147,243);
        line-height: 30px;
        margin-left: 10px;
        width: 90px;height: 37px;
        font-size: 16px;
        float: right;
        margin-right: 50px;
    }
    .menu_list {
        width: 268px;
        margin: 0;
    }

    .menu_head {
        height: 47px;
        line-height: 47px;
        padding-left: 38px;
        font-size: 14px;
        color: #525252;
        cursor: pointer;
        border: 1px solid #f1f1f1;
        position: relative;
        margin: 0px;
        font-weight: bold;
    }


    .menu_nva {
        line-height: 38px;
        backguound: #fff;
    }

    .menu_nva a {
        display: block;
        height: 38px;
        line-height: 38px;
        padding-left: 58px;
        color: #777777;
        background: #fff;
        text-decoration: none;

    }

    .menu_nva a:hover {
        text-decoration: none;
    }
    .left{
        display: inline-block;
        height: calc(100% - 62px);
        border-right: 1px solid #837f7f;
        float: left;
        width: 260px;
    }
    .layui-layer-btn .layui-layer-btn0{
        color: white;
        width: 45px;
        text-align: center;
        height: 40px;
        line-height: 40px;
        font-size: 16px;
        border-radius: 8px;
    }
    .layui-layer-btn .layui-layer-btn1{
        color: black;
        width: 45px;
        text-align: center;
        height: 40px;
        line-height: 40px;
        font-size: 16px;
        border-radius: 8px;
    }
    .layui-layer-title{
        height: 60px;
        line-height: 60px;
        border-bottom: 1px solid rgb(227,227,227);
        background-color: white;
    }
    .layui-layer-iframe .layui-layer-btn, .layui-layer-page .layui-layer-btn{
        border-top: 1px solid rgb(227,227,227);
    }
    #biao{
        width: 66px;
        height: 66px;
        font-size: 50px;
        display: inline-block;
        text-align: center;
        line-height: 70px;
        color: white;
        /*border-radius: 37px;*/
        margin-top: 25px;
        margin-left: 30px;
        background-repeat:no-repeat;
        background-size: 100px;
    }
    .bottom{
        width: 100%;
        height: 50px;
    }
    .tops{
        width: 100%;
        background-color: red;
        border-top-right-radius: 7px;
        border-top-left-radius: 7px;
        line-height: 22px;
        margin-top:-1px
    }

    .big{
        transform: scale(1);
        transition: all .2s;
    }

    .big:hover{
        -webkit-box-shadow: #ccc 0px 0px 10px;
        -moz-box-shadow: #ccc 0px 10px 10px;
        box-shadow: #ccc 0px 10px 10px;
        transform: scale(1.01);
    }

    .all_ul{
        width: 100% !important;
        height: 100%;
        margin-left: 0% !important;
        background: #fff;
    }
    .tab_c{
        background: #f5f5f5;
        border-right: 2px solid #e9f0f5;
    }
    .tab_c{
        margin-left: 0% !important;
    }
    .tab_cone{
        color: #111!important;
    }
    .tab_cone .one:nth-child(1) {
        border-top: none;
    }
    .tab_cone li .one_all:hover{
        background: #b6e0ff !important;
    }
    .tab_cone{
        width: 100% !important;
        height:99% !important;
    }
    .yiji::-webkit-scrollbar {
        width: 10px;
    }
    .yiji::-webkit-scrollbar-thumb {
        border-radius: 50px;
        background-color: #bfbfbf;
    }
    .yiji::-webkit-scrollbar-track {
        border-radius: 50px;
        background-color: #ffffff;
    }
    .down_jiao{
        display: inline-block;
        width: 16px;
        position: absolute;
        right: 5px;
        top: 27px;
    }
    .er_img{
        position: absolute;
        margin-left: 0;
        top: 0;
        right: 30px;
        margin-top: 19px;
        width: 16px;
    }
    #administ{
        display: inline-block;
    }
    .person{
        font-size: 8px;
    }
    /*一级菜单移入移出样式的改变*/
    .one_all li:hover{
        background:#ccebff;
        cursor:pointer;
    }
    .one_all li:hover h1{
        color:#2f8ae3;
    }
    .one_all{
        padding: 10px 0 10px 0;
        border: none;
        border-bottom: none;
        background: #f5f7f8 !important;
        border-top: 2px solid #fff!important;
    }
    .one_all{
        height: 40px !important;
        width: 100% !important;
        border-left: none !important;
        border-right: none !important;
    }
    .one_all{
        background: #f0f4f7 !important;
        position: relative;
    }
    .one_all .one_name{
        height: 40px;
        line-height: 40px;
        width: calc(100% - 30px);
    }
    .one_alltwo{
        background: #fff!important;
        height: 40px !important;
        width: 100% !important;
        border-left: none !important;
        border-right: none !important;
        border: none;
        border-bottom: none;
        border-top: 2px solid #fff!important;
        margin-top: 0%;
    }
    .one_alltwo h1{
        font-size: 18px;
        color: #2f8ae3;
    }
    .tab_cone li .one_all:hover{
        background: #b6e0ff !important;
    }
    .two{
        background: none!important;
    }
    .two .two_all:hover{
        color:#2f8ae3;
        background:#ccebff;
        cursor: pointer;
    }
    .two_all{
        width: 100%;

    }
    .two_all h1{
        width: 66%;
        margin-left: 0;
        color: #111;
        text-shadow: none;
        padding-left: 55px;
        height: 45px;
        line-height: 45px;
    }
    .three:hover{
        color:#2f8ae3;
        background:#ccebff;
    }
    .three{
        background: rgb(232, 244, 252);
    }
    .three h1{
        color: #333;
        text-shadow: none;
        height: 40px;
        line-height: 40px;
    }
    .sanji .three:hover{
        background: #ccebff;
    }
    .lists{
        width: 355px;
        background-color: white;
        position: fixed;
        padding: 3px;
        border: 1px solid rgb(239,239,239);
        z-index: 99999;
        display: none;
        height: 179px;
        overflow: auto;
    }
    .list1{
        border: 1px solid rgb(239,239,239);
        padding: 3px;
    }
    .list1 div{
        margin-top: 5px;
    }
    .list1 div:hover{
        background-color: rgb(246,246,246);
        cursor:pointer;
    }
    .list1 div:nth-child(1){
        margin-top: 0px;
    }
    .list1 div:nth-child(2){
        margin-top: 0px;
    }
    .list1 div:nth-child(3){
        margin-top: 0px;
    }
    .list1 div:nth-child(4){
        margin-top: 0px;
    }
    .list1 div:nth-child(5){
        margin-top: 0px;
    }
    #oneDaySalaryRatio{
        background-image: url("/img/gapp/1.png");
        background-repeat:no-repeat;
        background-size: 30px;
        background-position: 10px;
    }
    #userName::-webkit-input-placeholder{
        font-size:22px;
    }
    .tbox {
        margin: 0 auto; /*水平居中*/
        position: relative;
        margin-top:20px;
    }
    .layui-form-item {
        margin-bottom: 5px;
    }
    .tbox .layui-form-item .layui-form-label{
        width: 120px;
        text-align: right;
    }
    .tbox .layui-form-item .layui-input-block{
        margin-left: 170px;
        width: 60%;
    }
    .yiji li{
        cursor: pointer;
    }

    .right{
        margin-bottom: 10px;
    }
    .select {
        background: #98caff !important;
    }
</style>
<body>
    <div class="top">
        <div class="layui-inline" style="margin-left: 15px;color:#2f8ae3;display: inline-block;font-width: bold;font-size: 24px;line-height: 38px;height: 38px;" id="ying"><img style="width: 22px;display: inline-block" src="/img/gapp/app_mage.png" alt="">&nbsp;&nbsp;应用管理</div>
        <div class="search-box" style="margin-left: -20px">
            <div class="layui-inline" style="display: inline-block">
                <input placeholder="输入应用名称"  style="width: 300px;padding-top: 5px" id="userName" name="userName" class="layui-input" type="text">
            </div>
            <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search">搜索</button>
        </div>
        <div clas="new-app"><button type="button" class="layui-btn layui-btn-sm" id="add" lay-event="add">新建应用</button></div>
    </div>
    <div class="left">
        <div style="height: 60px;line-height: 60px;position: relative">
            <div style="display: inline-block;color:#2f8ae3;margin-left: 20px;font-weight: bold;font-size: 20px;cursor:pointer;width: calc(100% - 20px)"><img style="width: 26px;display: inline-block" src="/img/commonTheme/theme6/icon-01.png" alt="">&nbsp;&nbsp;应用分类</div>
            <button class="layui-btn layui-btn-xs setUp" type="button" style="position: absolute; background-color: rgb(16,127,255);width: 50px;top: 15px;right: 8px;height: 30px;line-height: 30px;font-size: 16px">设置</button>

        </div>
        <div class="cont_left">
            <ul class="all_ul">
                <div class="tab_c list">

                    <ul class="tab_cone a yiji" style="background: #fff;">

                    </ul>
                </div>
            </ul>

        </div>
<%--        <div id="firstpaneDiv" class="menu_list">--%>
<%--            <h3 class="menu_head current">一级菜单</h3>--%>
<%--            <div style="display:block" class="menu_nva">--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--                <a href="#">二级菜单</a>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
    <div style="height: calc(100% - 62px);width: calc(100% - 270px);float: right;overflow: auto;">
        <div style="margin-top: 10px;height: 40px;position: relative;">
            <div id="titleBoxs" style="height: 100%;">
                <img style="display: inline-block;position: absolute;top: 6px;left: 20px;height: 25px;" src="/img/commonTheme/theme20/gongzuo.png" alt="">
                <h2 class="title_name" style="display: inline-block;margin-left: 60px;height: 40px;line-height: 40px;"></h2>
            </div>
        </div>
        <div class="right"></div>
    </div>
    <script type="text/html" id="barOperation">
        {{# if(d.typeName == '<fmt:message code="sys.th.Undefined" />') { }}
        {{# } else { }}
        <a class="layui-btn  layui-btn-xs" lay-event="edit" id="edit">编辑</a>
        <a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
        {{# } }}
    </script>
</body>
<script>
    var gappType;
    var gappTypes;
    var xhr = null
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table;
        var form = layui.form;
        var element = layui.element;
        var layedit = layui.layedit;
        var upload = layui.upload;
        var eleTree = layui.eleTree;
        form.render()
        var el;

        // $(document).on('click','.oneDayPerDiem',function(e){
        //     e.stopPropagation();
        //         $.get('/gappType/selectAllGappType', function (res) {
        //             //layer.close(loadingIndex);
        //             if (res.flag) {
        //                 el = layui.eleTree.render({
        //                     elem: '.ele2',
        //                     data: res.obj,
        //                     expandOnClickNode: false,
        //                     highlightCurrent: true,
        //                     showLine: true,
        //                     showCheckbox: false,
        //                     checked: false,
        //                     lazy: true,
        //                     //defaultExpandAll: false,
        //                     request: {
        //                         name: 'typeName',
        //                         id:'typeId',
        //                         isLeaf:false
        //                         //children: "plbProjList",
        //                     },
        //                     load: function(data,callback) {
        //                         $.post('/gappType/selectGappTypeByParentGtypeId?parentGtypeId='+data.typeId,function (res) {
        //                             callback(res.obj);//点击节点回调
        //                         })
        //                     },
        //                     done: function(res){
        //                         if(res.data.length == 0){
        //                             $(".ele2").html('<div style="text-align: center">暂无数据</div>');
        //                         }
        //                     }
        //                 });
        //
        //             }
        //         });
        //     $(".ele2").slideDown();
        // })
        // $("[name='oneDayPerDiem']").on("click",function (e) {
        //
        // })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        function init(){
            $.ajax({
                dataType:'json',
                type:"get",
                url:'/gappType/selectAllGappType',
                success:function(json) {
                    var data = json.obj
                    var str='';
                    for(var i=0;i<data.length;i++){
                        var er='';
                        if(data[i].childs != undefined){
                            for(var j=0;j<data[i].childs.length;j++){
                                if(data[i].childs[j].childs != undefined){
                                    if(data[i].childs[j].childs.length>0){
                                        var three='';
                                        for(var k=0;k<data[i].childs[j].childs.length;k++){
                                            three +='<li class="three checked" menu_tid='+data[i].childs[j].childs[k].typeId+' url='+data[i].childs[j].childs[k].url+' title="'+data[i].childs[j].childs[k].typeName+'"><div class="work_sanji"  style="margin-left:18px;"><h1 style="margin-left:50px;"><img style="margin-left: 0;margin-top: 0;vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].childs[k].typeName+'</h1></div></li>' ;
                                        }
                                        er += '<li class="two"  ><div style="position: relative" menu_tid='+data[i].childs[j].typeId+'  class="two_all click_erji  checked"  title="'+data[i].childs[j].typeName+'"><h1 style="width: 53%;"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].typeName+'</h1><img class="er_img" src="../../img/workflow/work/add_work/icon-03.png"></div><ul class="sanji" style="display:none;">'+three+'</ul></li>';

                                    }
                                }else{
                                    er += '<li class="two" ><div menu_tid='+data[i].childs[j].typeId+' class="two_all  checked" title="'+data[i].childs[j].typeName+'"><h1 class="erji_h1"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].typeName+'</h1></div></li>';
                                }

                            }
                        }
                        if(data[i].childs=='' || data[i].childs == undefined){
                            str+='<li class="one person">' +
                                '<div class="one_all checked" title="'+data[i].typeName+'" ' +
                                'menu_tid='+data[i].typeId+'>' +
                                '<h1 class="one_name" style="width: 88%;">' +
                                '<img style="vertical-align: text-bottom;\
                    margin-left: 20px;width:24px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/gongzuo.png" />&nbsp;&nbsp;'+data[i].typeName+'</h1>' +
                                '</div>' +
                                '<div class="two_menu">' +
                                '<ul class="erji b"  style="width:100%;display:none;">' +
                                '<li class="two">' +
                                '<div class="two_all">'+er+'</div>' +
                                '</li>' +
                                '</ul>' +
                                '</div>' +
                                '</li>';
                        }else{
                            str+='<li class="one person">' +
                                '<div class="one_all checked" ' +
                                'title="'+data[i].typeName+'" ' +
                                'menu_tid='+data[i].typeId+'>' +
                                '<h1 class="one_name" ' +
                                'id="administ"><img style="vertical-align: text-bottom;\
                    margin-left: 20px;width:24px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/gongzuo.png" />&nbsp;&nbsp;'+data[i].typeName+'</h1>' +
                                '<img class="down_jiao" ' +
                                'src="../../img/workflow/work/add_work/icon-03.png">' +
                                '</div>' +
                                '<div class="two_menu">' +
                                '<ul class="erji b"  style="width:100%;display:none;">' +
                                '<li class="two">' +
                                '<div class="two_all">'+er+'</div>' +
                                '</li>' +
                                '</ul>' +
                                '</div>' +
                                '</li>';
                        }

                    }
                    var stt='<li class="one person" style="border-bottom: 1px solid #2f8ae3;display:none">\
                        <div class="checked one_alltwo" data-type="1">\
                        <h1 class="one_name" style="width: 88%;"><img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-02.png">\
                       <fmt:message code="workflow.th.QuickNew" /></h1>\
                        </div>\
                        </li>\
                        <li class="one person" style="display:none">' +
                        '<div class="one_all checked commonwork">' +
                        '<h1 class="one_name" style="width: 84%;"><img style="vertical-align: text-bottom;\
                    margin-right: 4px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/ofen_works.png" />\
                        <fmt:message code="workflow.th.Commonwork" /></h1>\
                        </div>\
                        </li>\
                        <li class="one person " style="display:none">\
                        <div class="one_all checked allWorkShow">\
                        <h1 class="one_name" style="width: 84%;"><img style="vertical-align: text-bottom;margin-right: 4px;" \
                        src="/img/commonTheme/${sessionScope.InterfaceModel}/all_works.png" />\
                        <fmt:message code="workflow.th.allwork" /></h1>\
                        </div>\
                        </li>';
                    <%-- <li class="one person ulNone" style="border-bottom: 1px solid #2f8ae3;">\--%>
                    <%-- <div class="checked one_alltwo " data-type="1">\--%>
                    <%-- <h1 class="one_name" style="width: 88%;"><img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-01.png">\--%>
                    <%--<fmt:message code="workflow.th.New" /></h1>\--%>
                    <%-- </div>\--%>
                    <%-- </li>';--%>
                    $(".tab_cone").html(stt+str);
                    //点击一级菜单。显示二级
                    $('.one_all').on('click',function () {
                        gappType = $(this).attr('menu_tid')
                        gappTypes = $(this).attr('menu_tid')
                        var names = $(this).attr('title');
                        $('#titleBoxs .title_name').html(names);
                        $("#ying").attr('gappType',gappType)
                        right(gappType)
                        if($(this).attr('data-type')==1){
                            return;
                        }
                        var top_one=$(this).parent().next('li').find('.one_all');
                        if ($(this).siblings().find('.erji').css('display')=='none') {
                            $(this).find('.down_jiao').attr('src','../../img/workflow/work/add_work/icon-04.png');
                            $(this).siblings().find('.erji').show();
                            $(this).siblings().find('.erji').css('background','#e8f4fc');

                            /*top_one.css('border-top','1px solid #999');*/
                        }else{
                            $(this).find('.down_jiao').attr('src','../../img/workflow/work/add_work/icon-03.png');
                            $(this).siblings().find('.erji').hide();
                            /* top_one.css('border-top','none');*/
                        }
                        if($(this).siblings('.two_menu')){
//                            $(this).find('h1').css({
//                                'color':'#000'
//                            });
                        }else{
                            $(this).css('background','#ccebff');
                        }

                        if($(this).find('h1').find('img').prop('src').indexOf('gongzuo')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/gongzuos.png')
                        }else  if($(this).find('h1').find('img').prop('src').indexOf('all_works')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/all_wosrkstwo.png')
                        }else  if($(this).find('h1').find('img').prop('src').indexOf('ofen_works')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/ofen_workss.png')
                        }


                    });

                    //点击二级，出现三级
                    $('.click_erji').on('click',function () {
                        var san= $(this).siblings().html();
                        if ($(this).siblings('.sanji').css('display')=='none') {
                            $(this).find('.er_img').attr('src','../../img/workflow/work/add_work/icon-04.png');
                            $(this).siblings('.sanji').show();

                        }else{
                            $(this).find('.er_img').attr('src','../../img/workflow/work/add_work/icon-03.png');
                            $(this).siblings('.sanji').hide();
                        }
                    });

                    //点击二级菜单
                    $('.two_menu li').on('click','.two_all',function(){
                        gappType = $(this).attr('menu_tid')
                        gappTypes = $(this).attr('menu_tid')
                        var names = $(this).attr('title');
                        $('#titleBoxs .title_name').html(names);
                        $("#ying").attr('gappType',gappType)
                        right(gappType)
                        var url=$(this).attr('url');
                        var menu_tid=$(this).parent().attr('menu_tid');
                        //样式的 改变
//                        $(this).parent().siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
//                        $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
//                        $(this).parent('.two').siblings().find('.three').removeClass('menu_change');//同层级的三级文字
//                        $(this).parents('.one').siblings().find('.three').removeClass('menu_change');//不同层级的三级文字
//                        $(this).addClass('menu_change');

                        //判断标题id与iframeid是否相同
                        if($('#f_'+menu_tid).length>0){
                            //页面一打开，切换显示
                            $('.all_content .iItem').hide();
                            $('#f_'+menu_tid).show();

                            $('#t_'+menu_tid).css({
                                'color':'#2a588c',
                                'position':'relative',
                                'z-index':99999
                            })
                            $('#t_'+menu_tid).siblings().css({
                                'color':'#fff',
                                'position':'relative',
                                'z-index':999
                            });
                        }else{
                            if($(this).siblings('.sanji').length>0){

                            }else{
                                //页面不存在，新增 title和iframe
                                var titlestr = '<li class="choose" index="0;" id="t_'+menu_tid+'" title="'+$(this).find('h1').html()+'"><h1>'+$(this).find('h1').html()+'</h1><div class="img" style="display:none;"><img class="close"  src="img/main_img/icon.png"></div></li>';
                                var iframestr = '<div id="f_'+menu_tid+'" class="iItem" ><iframe id="every_module" src="'+url+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';
                                $('.main_title ul').append(titlestr);
                                $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/title_no.png) 0px 4px no-repeat;');
                                $('#t_'+menu_tid).siblings().css('color','#fff');
                                $('.all_content').append(iframestr);
                                $('.all_content .iItem').hide();
                                $('#f_'+menu_tid).show();
                            }
                        }
                    });
                    //点击三级菜单，跳转页面。
                    $('.sanji').on('click','li',function(){
                        gappType = $(this).attr('menu_tid')
                        gappTypes = $(this).attr('menu_tid')
                        var names = $(this).attr('title');
                        $('#titleBoxs .title_name').html(names);
                        $("#ying").attr('gappType',gappType)
                        right(gappType)
                        var url=$(this).attr('url');
                        var menu_tid=$(this).attr('menu_tid');
                        //样式改变
//                        $(this).parents('.two').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
//                        $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
//                        $(this).siblings().removeClass('menu_change');//同层级的三级文字
//                        $(this).parents('.one').siblings().find('.three').removeClass('menu_change');//不同层级的三级文字
//                        $(this).addClass('menu_change');
                        if($('#f_'+menu_tid).length>0){
                            //页面一打开，切换显示
                            $('.all_content .iItem').hide();
                            $('#f_'+menu_tid).show();

                            $('#t_'+menu_tid).siblings().css({
                                'color':'#fff',
                                'position':'relative',
                                'z-index':999
                            });
                            $('#t_'+menu_tid).css({
                                /* 'background':'url(img/main_img/title_yes.png) 0px 4px no-repeat',*/
                                'color':'#2a588c',
                                'position':'relative',
                                'z-index':99999
                            })
                        }else{
                            //页面不存在，新增 title和iframe
                            var titlestrs = '<li class="choose " index="0;" id="t_'+menu_tid+'" title="'+$(this).find('h1').html()+'"><h1>'+$(this).find('h1').html()+'</h1><div class="img" style="display:none;"><img class="close" src="img/main_img/icon.png"></div></li>';
                            var iframestr = '<div id="f_'+menu_tid+'" class="iItem"><iframe id="every_module" src="'+url+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';
                            $('.main_title ul').append(titlestrs);
                            $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/title_no.png) 0px 4px no-repeat;');
                            $('#t_'+menu_tid).siblings().css('color','#fff');
                            $('.all_content').append(iframestr);
                            $('.all_content .iItem').hide();
                            $('#f_'+menu_tid).show();
                        }

                    });

                    $('.one_all')[0].click();
                    $("#ying").attr('gappType',data[0].typeId);
                    $('#titleBoxs .title_name').html(data[0].typeName);
                    right(data[0].typeId);
                    // for(var i=0;i<$('.yiji').find('li').length;i++){
                    //     if($('.yiji').find('li').eq(i).css('display') != 'none'){
                    //         $('.yiji').find('li').eq(i).find('.down_jiao').attr('src','../../img/workflow/work/add_work/icon-04.png');
                    //         return false;
                    //     }
                    // }
                }
            })

        };
        init()
        $('ul').on("click","li.two",function() {
            $('.two').removeClass("select");
            $(this).addClass("select");
        })
        //节点点击事件
        layui.eleTree.on("nodeClick(data2)",function(d) {
            var parData1 = d.data.currentData;
            $("[name='parentGtypeId']").val(parData1.typeName);
            // $("[name='orderNo']").attr("orderNo",parData1.orderNo);
            $("[name='parentGtypeId']").attr("parentGtypeId",parData1.typeId);
        })

        // $("#oneDaySalaryRatio").click(function(){
        //     event.stopPropagation();
        // });
        // $(document).on('click',function(){
        //     $('.lists').hide()
        // })


        $(document).on('click','.setUp',function(){
            layer.open({
                type: 1,
                area: ['58%', '80%'], //宽高
                title: ['分类管理','font-size:20px'],
                maxmin: false,
                btn: ['取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="padding: 20px">\n' +
                            '<div style="width: 100%;height: 50px;line-height: 50px">' +
                            '   <button type="button" class="layui-btn layui-btn-sm" id="addss" style="float: right" lay-event="adds">新建分类</button>' +
                            '</div>' +
                            '<table class="layui-table" style="margin: 0;" lay-size="sm" id="table" lay-filter="tableFilter"></table>'+
                        '</div>',
                success: function () {

                    $(function () {
                        // var screenwidth = document.documentElement.clientWidth;
                        // if (screenwidth  > 2200) {
                        //     var nums = screenwidth * 0.97;
                        //     var sumwidth = screenwidth * 0.97 + 'px';
                        // } else {
                        //     var nums = 1000;
                        //     var sumwidth = '1000px';
                        // }
                        // var width1 = nums * 0.055 + 'px';
                        // var width2 = nums * 0.075 + 'px';
                        // var width3 = nums * 0.025 + 'px';
                        // //表格数据初始化展示
                        // var pageObj = $.tablePage('#pagediv',sumwidth, [
                        //     {
                        //         width:'400px',
                        //         title: '序号',
                        //         name: 'orderNo',
                        //         // selectFun:function (n,obj) {
                        //         //     if(obj.orderNo==undefined){
                        //         //         return "";
                        //         //     }else{
                        //         //         return obj.userName;
                        //         //     }
                        //         // }
                        //     },
                        //     {
                        //         width:'400px',
                        //         title: '名称',
                        //         name: 'typeId',
                        //         selectFun:function (n,obj) {
                        //             if(obj.typeId==undefined){
                        //                 return "";
                        //             }else{
                        //                 return obj.typeName;
                        //             }
                        //
                        //         }
                        //     },
                        //     {
                        //         width:'250px',
                        //         title:'操作',
                        //         name:'orgAddress'
                        //     }
                        // ], function (me) {
                        //     me.data.pageSize = 10;
                        //     me.init('/gappType/selectAllGappType',[
                        //         {name:'编辑'},
                        //         {name:'删除'}
                        //     ])
                        // })
                        $.ajax({
                            url:'/gappType/selectAllGappType',
                            type:'get',
                            dataType:'json',
                            success:function(obj){
                                if(obj.flag){
                                    var data=obj.obj;
                                    // var str_li='';
                                    // str_li=queryChild_flow(data,str_li,0);
                                    var str_lis=[];
                                    var dataArr = queryChild_flows(data,str_lis,0);
                                    flowdata={};
                                    flowdata=data;
                                    layui.table.render({
                                        elem: '#table'
                                        ,data: dataArr //数据接口
                                        // ,where:data
                                        ,page: false//开启分页
                                        // ,toolbar:'#toolbar'
                                        ,cols: [[ //表头
                                            {field: 'orderNo', title: '序号',width:150,templet: function(d){
                                                if(d.level == 0){
                                                    return d.orderNo
                                                }else{
                                                    return '<span style="color:#666;padding-left: '+15*Number(d.level)+'">'+ d.orderNo+'</span>'
                                                }
                                                // return '<span >'+ format(d.attachmentDate)+'</span>'
                                            }}
                                            ,{field: 'typeName', title: '分类名称',templet: function(d){
                                                    if(d.level == 0){
                                                        return d.typeName
                                                    }else{
                                                        return '<span style="color:#666;padding-left: '+15*Number(d.level)+'">'+ d.typeName+'</span>'
                                                    }
                                                    // return '<span >'+ format(d.attachmentDate)+'</span>'
                                                }}
                                            ,{field: 'flowcounts',width:120, title: '应用数量'}
                                            ,{fixed: 'right',width:140, title: '操作',align:'center',templet: function(d){
                                                    if(d.orderNo == '0'){
                                                        return ''
                                                    }else{
                                                        return '<a class="layui-btn  layui-btn-xs" lay-event="edit" id="edit">编辑</a><a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="del">删除</a>'
                                                    }
                                                }}
                                        ]]
                                        ,limit:10000
                                        ,done:function(res) {

                                        }
                                    });
                                    // $('#j_tb').html("");
                                    // $('#j_tb').html(str_li);
                                }
                            }
                        });
                        table.on('tool(tableFilter)', function (obj) {
                            var events = obj.event;
                            var data = obj.data;
                            var typeId = data.typeId;
                            if (events == 'edit') {
                                layer.open({
                                    type: 1,
                                    area: ['531px', '372px'], //宽高
                                    title: ['编辑分类','font-size:20px'],
                                    maxmin: false,
                                    btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                                    content: '<div style="margin: 30px auto;">' +
                                    '<form class="layui-form" action="">\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                                    '         <label class="layui-form-label" style="font-size: 18px">父分类</label>\n' +
                                    '         <div class="layui-input-inline" style="width:70%">\n' +
                                    '<select name="parentGtypeId" id="parentGtypeId" class="oneDayPerDiem"></select>' +
                                    // '             <input type="text" name="parentGtypeId"  lay-verify="required|phone" autocomplete="off" class="layui-input oneDayPerDiem">\n' +
                                    // '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 9999;width: 204px;"></div>\n\n'+
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    '</div>\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                                    '         <label class="layui-form-label" style="font-size: 18px">分类排序号</label>\n' +
                                    '         <div class="layui-input-inline" style="width:70%">\n' +
                                    '             <input type="text" name="orderNo"  lay-verify="number" autocomplete="off" class="layui-input">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    '</div>\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                                    '         <label class="layui-form-label" style="font-size: 18px">分类名称</label>\n' +
                                    '         <div class="layui-input-inline" style="width:70%">\n' +
                                    '             <input type="text" name="typeName"  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    '</div>\n' +
                                    '</form>' +
                                    '</div>',
                                    success: function (layero, index) {
                                        var parentGtypeId = '';
                                        // 添加form标识
                                        layero.addClass('layui-form');
                                        // 将保存按钮改变成提交按钮
                                        layero.find('.layui-layer-btn0').attr({
                                            'lay-filter': 'formDemo',
                                            'lay-submit': ''
                                        });
                                        $.ajax({
                                            type:'post',
                                            url:'/gappType/selectGappTypeByTypeId',
                                            dataType:'json',
                                            async:false,
                                            data:{'typeId':typeId},
                                            success: function (res) {
                                                var data = res.object
                                                parentGtypeId = res.object.parentGtypeId
                                                $("[name='parentGtypeId']").val(data.parentGtypeName)
                                                $("[name='parentGtypeId']").attr('typeId',data.typeId)
                                                $("[name='parentGtypeId']").attr('parentGtypeId',data.parentGtypeId)
                                                $("[name='orderNo']").val(data.orderNo)
                                                $("[name='typeName']").val(data.typeName)
                                            }
                                        })
                                        $.ajax({
                                            url:'/gappType/selectAllGappType',
                                            type:'get',
                                            dataType:'json',
                                            async:false,
                                            success:function(obj){
                                                if(obj.flag){
                                                    var formdata = obj.obj
                                                    //父表单（表单）
                                                    var opt_li = '<option value="0"  class="levelleft0"></option>';
                                                    // if ($(me).attr('data-numtrue') == 1) {
                                                    //     opt_li = Child(formdata, opt_li, 0, -1);
                                                    // } else {
                                                    //     opt_li = Child(flowdata, opt_li, 0, -1);
                                                    // }
                                                    opt_li = Child(flowdata, opt_li, 0, -1);
                                                    $("select[name='parentGtypeId']").html(opt_li);
                                                    form.render()
                                                }
                                                if(parentGtypeId != '' || parentGtypeId != undefined){
                                                    $("#parentGtypeId option[value="+parentGtypeId+"]").prop("selected",true)
                                                }
                                            }
                                        });

                                        form.render()
                                    },
                                    yes: function (index, layero) {
                                        var orderNo = $("[name='orderNo']").val()
                                        var parentGtypeId = $("[name='parentGtypeId']").attr('parentGtypeId')
                                        var typeId = $("[name='parentGtypeId']").attr('typeId')

                                        if(parentGtypeId == undefined){
                                            parentGtypeId = 0
                                        }
                                        var typeName = $("[name='typeName']").val()
                                        form.on('submit(formDemo)', function (data) {
                                            // layer.msg(JSON.stringify(data.field));
                                            $.ajax({
                                                dataType: 'json',
                                                type: "get",
                                                url: '/gappType/updateGappType',
                                                data:{
                                                    orderNo:orderNo,
                                                    parentGtypeId:parentGtypeId,
                                                    typeName:typeName,
                                                    typeId:typeId
                                                },
                                                success:function(res){
                                                    layer.msg('修改成功', {icon: 1});
                                                    location.reload();
                                                }
                                            })
                                            return false;
                                        })

                                    },
                                    btn2:function(index){
                                        layer.close(index);

                                    }
                                });
                            }else if(events=='del'){
                                var attendancePriv=0
                                layer.confirm(qued,{
                                    // btn: [sure,cancel], //按钮
                                    btn:['确定','取消'],
                                    title:'删除',
                                    yes:function(){
                                        $.ajax({
                                            type:'get',
                                            url:'/gappType/deleteGappType',
                                            dataType:'json',
                                            data:{'typeId':typeId},
                                            success: function (json) {
                                                //第三方扩展皮肤
                                                layer.msg('删除成功', {icon: 1});
                                                location.reload();
                                            }
                                        })
                                    },
                                    btn2:function(){
                                        layer.closeAll();
                                    }
                                })
                            }
                        })
                        //       根据id修改数据
                        // $(document).on('click','.edit_biaodan',function(that){
                        //     var typeId = $(this).attr('typeId')
                        //     // location.href = '/wages/attendancePermissionsSettings?type=1&attendancePriv='+attendancePriv;
                        //     layer.open({
                        //         type: 1,
                        //         area: ['531px', '372px'], //宽高
                        //         title: ['编辑分类','font-size:20px'],
                        //         maxmin: false,
                        //         btn: ['取&nbsp&nbsp消','确&nbsp&nbsp定'], //可以无限个按钮
                        //         content: '<div style="margin: 30px auto;">' +
                        //             '<form class="layui-form" action="">\n' +
                        //             ' <div class="layui-form-item" >\n' +
                        //             '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        //             '         <label class="layui-form-label" style="font-size: 18px">父分类</label>\n' +
                        //             '         <div class="layui-input-inline" style="width:70%">\n' +
                        //             '<select name="parentGtypeId" id="parentGtypeId" class="oneDayPerDiem"></select>' +
                        //             // '             <input type="text" name="parentGtypeId"  lay-verify="required|phone" autocomplete="off" class="layui-input oneDayPerDiem">\n' +
                        //             // '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 9999;width: 204px;"></div>\n\n'+
                        //             '         </div>\n' +
                        //             '     </div>\n' +
                        //             '</div>\n' +
                        //             ' <div class="layui-form-item" >\n' +
                        //             '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        //             '         <label class="layui-form-label" style="font-size: 18px">分类排序号</label>\n' +
                        //             '         <div class="layui-input-inline" style="width:70%">\n' +
                        //             '             <input type="text" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        //             '         </div>\n' +
                        //             '     </div>\n' +
                        //             '</div>\n' +
                        //             ' <div class="layui-form-item" >\n' +
                        //             '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        //             '         <label class="layui-form-label" style="font-size: 18px">分类名称</label>\n' +
                        //             '         <div class="layui-input-inline" style="width:70%">\n' +
                        //             '             <input type="text" name="typeName"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        //             '         </div>\n' +
                        //             '     </div>\n' +
                        //             '</div>\n' +
                        //             '</form>' +
                        //             '</div>',
                        //         success: function () {
                        //             var parentGtypeId
                        //             $.ajax({
                        //                 type:'post',
                        //                 url:'/gappType/selectGappTypeByTypeId',
                        //                 dataType:'json',
                        //                 async:false,
                        //                 data:{'typeId':typeId},
                        //                 success: function (res) {
                        //                     var data = res.object
                        //                     parentGtypeId = res.object.parentGtypeId
                        //                     $("[name='parentGtypeId']").val(data.parentGtypeName)
                        //                     $("[name='parentGtypeId']").attr('typeId',data.typeId)
                        //                     $("[name='parentGtypeId']").attr('parentGtypeId',data.parentGtypeId)
                        //                     $("[name='orderNo']").val(data.orderNo)
                        //                     $("[name='typeName']").val(data.typeName)
                        //                 }
                        //             })
                        //             $.ajax({
                        //                 url:'/gappType/selectAllGappType',
                        //                 type:'get',
                        //                 dataType:'json',
                        //                 async:false,
                        //                 success:function(obj){
                        //                     if(obj.flag){
                        //                         var formdata = obj.obj
                        //                         //父表单（表单）
                        //                         var opt_li = '<option value="0"  class="levelleft0"></option>';
                        //                         // if ($(me).attr('data-numtrue') == 1) {
                        //                         //     opt_li = Child(formdata, opt_li, 0, -1);
                        //                         // } else {
                        //                         //     opt_li = Child(flowdata, opt_li, 0, -1);
                        //                         // }
                        //                         opt_li = Child(flowdata, opt_li, 0, -1);
                        //                         $("select[name='parentGtypeId']").html(opt_li);
                        //                         form.render()
                        //                     }
                        //                     if(parentGtypeId != '' || parentGtypeId != undefined){
                        //                         $("#parentGtypeId option[value="+parentGtypeId+"]").prop("selected",true)
                        //                     }
                        //                 }
                        //             });
                        //
                        //             form.render()
                        //         },
                        //         yes: function (index, layero) {
                        //             layer.close(index);
                        //         },
                        //         btn2:function(){
                        //             var orderNo = $("[name='orderNo']").val()
                        //             var parentGtypeId = $("[name='parentGtypeId']").attr('parentGtypeId')
                        //             var typeId = $("[name='parentGtypeId']").attr('typeId')
                        //
                        //             if(parentGtypeId == undefined){
                        //                 parentGtypeId = 0
                        //             }
                        //             var typeName = $("[name='typeName']").val()
                        //             $.ajax({
                        //                 dataType: 'json',
                        //                 type: "get",
                        //                 url: '/gappType/updateGappType',
                        //                 data:{
                        //                     orderNo:orderNo,
                        //                     parentGtypeId:parentGtypeId,
                        //                     typeName:typeName,
                        //                     typeId:typeId
                        //                 },
                        //                 success:function(res){
                        //                     //第三方扩展皮肤
                        //                     layer.msg('修改成功', {icon: 1});
                        //                     location.reload();
                        //                 }
                        //             })
                        //         }
                        //     });
                        // });
                        //ajax 根据orgId 删除数据
                        // $(document).on('click','.delete_biaodan',function(){
                        //     var attendancePriv=0
                        //         var typeId = $(this).attr('typeId')
                        //     layer.confirm(qued,{
                        //         btn: [sure,cancel], //按钮
                        //         title:'确定删除？'
                        //     }, function(){
                        //         $.ajax({
                        //             type:'post',
                        //             url:'/gappType/deleteGappType ',
                        //             dataType:'json',
                        //             data:{'typeId':typeId},
                        //             success: function (json) {
                        //                 //第三方扩展皮肤
                        //                 layer.msg('删除成功', {icon: 1});
                        //                 location.reload();
                        //             }
                        //         })
                        //     }, function () {
                        //         layer.closeAll();
                        //
                        //     })
                        // });
                    });

                },
                yes: function (index, layero) {
                    layer.close(index);
                },
                btn2:function(){

                }
            });
        });

        $(document).on('click','#addss',function(){
            layer.open({
                type: 1,
                area: ['600px', '372px'], //宽高
                title: ['新建分类','font-size:20px'],
                maxmin: false,
                btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="margin: 30px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    ' <div class="layui-form-item" >\n' +
                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '         <label class="layui-form-label" style="font-size: 18px">父分类</label>\n' +
                    '         <div class="layui-input-inline" style="width:70%">\n' +
                    // '             <input type="text" name="parentGtypeId"  lay-verify="required|phone" autocomplete="off" class="layui-input oneDayPerDiem">\n' +
                    '<select name="parentGtypeId" id="parentGtypeId" class="oneDayPerDiem"></select>' +
                   // '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 9999;width: 204px;"></div>\n\n'+
                    '         </div>\n' +
                    '     </div>\n' +
                    '</div>\n' +
                    ' <div class="layui-form-item" >\n' +
                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '         <label class="layui-form-label" style="font-size: 18px">分类排序号</label>\n' +
                    '         <div class="layui-input-inline" style="width:70%">\n' +
                    '             <input type="text" name="orderNo"  lay-verify="number" autocomplete="off" class="layui-input">\n' +
                    '         </div>\n' +
                    '     </div>\n' +
                    '</div>\n' +
                    ' <div class="layui-form-item" >\n' +
                    '     <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '         <label class="layui-form-label" style="font-size: 18px">分类名称</label>\n' +
                    '         <div class="layui-input-inline" style="width:70%">\n' +
                    '             <input type="text" name="typeName"  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                    '         </div>\n' +
                    '     </div>\n' +
                    '</div>\n' +
                    '</form>' +
                    '</div>',
                success: function (layero, index) {
                    // 添加form标识
                    layero.addClass('layui-form');
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter': 'formDemo',
                        'lay-submit': ''
                    });
                    $.ajax({
                        url:'/gappType/selectAllGappType',
                        type:'get',
                        dataType:'json',
                        success:function(obj){
                            if(obj.flag){
                                var formdata = obj.obj
                                //父表单（表单）
                                var opt_li = '<option value="0"  class="levelleft0"></option>';
                                // if ($(me).attr('data-numtrue') == 1) {
                                //     opt_li = Child(formdata, opt_li, 0, -1);
                                // } else {
                                //     opt_li = Child(flowdata, opt_li, 0, -1);
                                // }
                                opt_li = Child(flowdata, opt_li, 0, -1);
                                $("select[name='parentGtypeId']").html(opt_li);
                                form.render()
                            }
                        }
                    });
                    form.render()
                },
                yes: function (layer_index) {
                    var orderNo = $("[name='orderNo']").val()
                    var parentGtypeId = $("[name='parentGtypeId']").val()
                    if(parentGtypeId == undefined){
                        parentGtypeId = 0
                    }
                    var typeName = $("[name='typeName']").val()
                    form.on('submit(formDemo)', function (data) {
                        // layer.msg(JSON.stringify(data.field));
                        $.ajax({
                            dataType: 'json',
                            type: "get",
                            url: '/gappType/insertGappType',
                            data:{
                                orderNo:orderNo,
                                parentGtypeId:parentGtypeId,
                                typeName:typeName
                            },
                            success:function(res){
                                layer.msg('创建成功', {icon: 1});
                                location.reload();
                            }
                        })
                        return false;
                    })
                },
                btn2:function(index, layero){
                    layer.close(index);
                }
            });
        })
        function queryChild_flow(datas,str_li,level){

            for(var i=0;i<datas.length;i++){

                var className="levelleft"+level;
                var pad = parseInt(level)*50;
                if(datas[i].typeName=='<fmt:message code="sys.th.Undefined" />'){

                    str_li+='<tr ><td><div class="img"></div><a  notifyId="" class="sort windowOpen '+className+'" style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].orderNo+'</a></td>'+
                        '<td><a notifyId=""  style="padding-left:'+pad+'px;text-align:left!important" class="windowOpen '+className+'">'+datas[i].typeName+'</a></td>'+
                        '<td><a notifyId="" class="windowOpen ">'+datas[i].formcounts+'</a></td>'+
                        '<td><a notifyId="" class="windowOpen ">'+datas[i].departName+'</a></td>'+
                        '<td class="tds"></td></tr>'
                }else{
                    str_li+='<tr class="trs" ><td class="xuhao"><div class="img "></div><a  notifyId="" class="sort windowOpen '+className+'"  style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].orderNo+'</a></td>'+
                        '<td class="mingcheng"><a notifyId="" class="biao_name windowOpen '+className+'"  style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].typeName+'</a></td>'+
                        '<td class="mingchengs"><a notifyId="" class="biao_name windowOpen '+className+'"  style="padding-left:40px;text-align:left!important">'+datas[i].flowcounts+'</a></td>'+
                        '<td class="tds"><a notifyId="" style="margin-right: 20px;" typeId="'+datas[i].typeId+'" class="edit_biaodan" name="111">编辑</a><span class="spanlow"></span><a notifyId="" typeId="'+datas[i].typeId+'" class="delete_biaodan" name="222">删除</a></td></tr>'
                }

                if(datas[i].childs!=null){
                    str_li = queryChild_flow(datas[i].childs,str_li,level+1);
                }
            }
            return str_li;
        }

        function queryChild_flows(datas,str_lis,level){
            var arr = str_lis
            for(var i=0;i<datas.length;i++){
                datas[i].level = level;
                arr.push(datas[i])
                <%--var className="levelleft"+level;--%>
                <%--var pad = parseInt(level)*50;--%>
                <%--if(datas[i].typeName=='<fmt:message code="sys.th.Undefined" />'){--%>

                    <%--str_li+='<tr ><td><div class="img"></div><a  notifyId="" class="sort windowOpen '+className+'" style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].orderNo+'</a></td>'+--%>
                        <%--'<td><a notifyId=""  style="padding-left:'+pad+'px;text-align:left!important" class="windowOpen '+className+'">'+datas[i].typeName+'</a></td>'+--%>
                        <%--'<td><a notifyId="" class="windowOpen ">'+datas[i].formcounts+'</a></td>'+--%>
                        <%--'<td><a notifyId="" class="windowOpen ">'+datas[i].departName+'</a></td>'+--%>
                        <%--'<td class="tds"></td></tr>'--%>
                <%--}else{--%>
                    <%--str_li+='<tr class="trs" ><td class="xuhao"><div class="img "></div><a  notifyId="" class="sort windowOpen '+className+'"  style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].orderNo+'</a></td>'+--%>
                        <%--'<td class="mingcheng"><a notifyId="" class="biao_name windowOpen '+className+'"  style="padding-left:'+pad+'px;text-align:left!important">'+datas[i].typeName+'</a></td>'+--%>
                        <%--'<td class="mingchengs"><a notifyId="" class="biao_name windowOpen '+className+'"  style="padding-left:40px;text-align:left!important">'+datas[i].flowcounts+'</a></td>'+--%>
                        <%--'<td class="tds"><a notifyId="" style="margin-right: 20px;" typeId="'+datas[i].typeId+'" class="edit_biaodan" name="111">编辑</a><span class="spanlow"></span><a notifyId="" typeId="'+datas[i].typeId+'" class="delete_biaodan" name="222">删除</a></td></tr>'--%>
                <%--}--%>

                if(datas[i].childs!=null){
                    str_lis = queryChild_flows(datas[i].childs,str_lis,level+1);
                }
            }
            return str_lis;
        }
        function Child(datas,opt_li,level,parentId,id){

            for(var i=0;i<datas.length;i++){
                if(id != undefined&&id == datas[i].sortId){

                }else{
                    if(level==0&&i==0) continue;
                    var String="";
                    var space=""
                    for(var j=0;j<level;j++){
                        space+="├&nbsp;&nbsp;&nbsp;";
                    }
                    if(i==0){
                        String=space+"┌";
                    }
                    if(i!=0){
                        String=space+"├";
                    }
                    if(i==datas.length-1){
                        String=space+"└";
                    }
                    if(parentId==datas[i].typeId){
                        opt_li+='<option value="'+datas[i].typeId+'" selected="selected" parentGtypeId="'+datas[i].parentGtypeId+'">'+String+datas[i].typeName+'</option>';
                    }else{
                        opt_li+='<option value="'+datas[i].typeId+'" parentGtypeId="'+datas[i].parentGtypeId+'">'+String+datas[i].typeName+'</option>';
                    }
                    if(datas[i].childs!=null){
                        opt_li = Child(datas[i].childs,opt_li,level+1,parentId,id);
                    }
                }
            }

            return opt_li;
        }
        $(document).on('click','#add',function(){
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title: ['新建应用','font-size:20px'],
                maxmin: false,
                btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                        '   <form class="layui-form" action="">\n' +
                        '       <div class="layui-form-item" >\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px">应用名称</label>\n' +
                        '               <div class="layui-input-inline" style="width:70%">\n' +
                        '                   <input type="text" name="oneDayPerDiem" placeholder="请输入2到15个字" maxlength="15" lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '                   <p class="name" id="name" style="color: red;position:fixed;">请输入应用名称</p>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" >\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px">排序号</label>\n' +
                        '               <div class="layui-input-inline" style="width:70%">\n' +
                        '                   <input type="number" onblur="checkNumber(this)" name="gappNo" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="margin-top: 20px;">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px">应用图标</label>\n' +
                        '               <div class="layui-input-inline" style="width:70%;">\n' +
                        '                   <input type="text" style="width: 15%;display: inline-block" readOnly name="oneDaySalaryRatio" id="oneDaySalaryRatio" lay-verify="required|phone" autocomplete="off" class="layui-input"">\n' +
                        '                   <button type="button" class="layui-btn layui-btn-sm" id="logo" lay-event="logo" style="display: inline-block;margin-left: 30px;">选择图标</button>\n' +
                        '                   <div class="lists">' +
                        '                       <div class="list1">' +
                        '                       </div>' +
                        '                   </div>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '   </form>' +
                        '</div>',
                success: function () {
                    $('.name').hide()
                    // var list = json.list[0]
                    // console.log(list)
                    // var strs=''
                    // for(var a=0;a<3;a++){
                    //     strs += '<option>'+list[a]+'</option>'
                    // }
                    // $("select[name='schoolType']").html(strs)
                    var str=''
                    for(var i=1;i<=100;i++){
                        str += '<div class="bImg" style="display: inline-block; width: 13%;border: 1px solid rgb(239,239,239);text-align: center;margin-left: 9px" value="'+i+'"><img style="width: 40px;display: inline-block" src="/img/gapp/'+i+'.png" alt=""></div>'
                    }
                    $('.list1').html(str)
                    form.render()
                },
                yes: function (index) {
                    if($("input[name='oneDayPerDiem']").val().length<2){
                        layer.msg('应用名称不可少于两个字', {icon: 5});
                        return false
                    }
                    var gappName = $("input[name='oneDayPerDiem']").val()
                    var gappNo = $("input[name='gappNo']").val()
                    var gappType = $("#ying").attr('gappType')
                    var gappPicId = $('#oneDaySalaryRatio').attr('gappPicId')
                    if(gappPicId == undefined){
                        gappPicId = 1
                    }
                    if(gappName == ''){
                        $('.name').show()
                        return false
                    }else{
                        $.ajax({
                            url:'/gapp/insertGapp',
                            type:'post',
                            data:{
                                gappNo:gappNo,
                                gappName:gappName,
                                gappType:gappType,
                                gappPicId:gappPicId,
                            },
                            dataType:'json',
                            success:function(obj){
                                //第三方扩展皮肤
                                layer.close(index);
                                layer.msg('创建成功', {icon: 1});
                                // location.reload();
                                right(gappType)
                            }
                        });
                    }
                },
                btn2:function(){
                    // layer.close(index);

                }
            });
        })
        $(document).on('click','.bImg',function(){
            var img = document.getElementById('oneDaySalaryRatio');
            var imgs = ($(this).find('img').attr('src'))
            var imgss = imgs.replace(/[^0-9]/ig,"");
            $("#oneDaySalaryRatio").attr('gappPicId',imgss)
            img.style.backgroundImage = 'url("'+imgs+'")';
            $('.lists').hide()
        })
        $(document).on('click','#search',function(){
            var gappName = $("#userName").val()
            $.ajax({
                type:'get',
                url:'/gapp/selectGappByGappName',
                dataType:'json',
                data:{'gappName':gappName},
                success: function (json) {
                    var data = json
                    var str=''
                    for(var i=0;i<data.obj.length;i++){
                        str+='<div class="rightCologyUl pubuTitle big" gappType="'+ data.obj[i].gappType +'" data-gappId="'+data.obj[i].gappId+'" onclick="openDesigns($(this))" style="display:inline-block;cursor:pointer;border:1px solid rgb(216,216,216);border-radius:10px;width: 320px;margin-left: 20px;margin-top: 10px;margin-bottom: 10px">' +
                            '<div class="tops" style="padding: 7px 0">' +
                            '<p class="hou" style="color: white; border-left: 5px solid white;font-size: 22px;font-weight: 900;margin-left:15px;padding-left: 8px">'+data.obj[i].gappName+'</p>' +
                            '</div>' +

                            '<div>'+

                            '<div style="width: 60%;display: inline-block;margin-top: -10px">' +
                            '<span id="biao" style="background-size:100%;background-image: url(/img/gapp/' + data.obj[i].gappPicId + '.png);"></span>' +
                            '<p class="creatUser" style="margin-left: 30px;margin-top: 10px;font-size: 18px">创建人:&nbsp&nbsp'+data.obj[i].createUserName+'</p>' +
                            '</div>' +

                            '<div style="display: inline-block;width: 40%">' +
                            '<div class="shus" style="font-size: 50px;height:60px;color: #107fff;text-align: center;margin-bottom: 12px">'+data.obj[i].dataCounts+'</div>' +
                            '<p class="shu" style="position:relative;top: 0px;text-align: center;font-size: 18px">数据条目</p>' +
                            '</div>' +


                            // '<div style="width: 100px;height: 100px;display: none;padding-left: 15px;position: absolute;top: 80px">' +
                            // '<span class="leis" style="font-size: 18px;">'+data.obj[i].applicationType+'</span>' +
                            // '<p class="lei" style="position:relative;top: 40px;font-size: 18px">应用类型</p>' +
                            // '</div>' +


                            '</div>'+
                            '<div class="bottom" style="cursor:pointer;"><span onclick="openUaeApps($(this))" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 5px;margin-left:30px;">打开应用</span><span onclick="publishUaeApps($(this))" gappId="'+data.obj[i].gappId+'" applicationType="'+data.obj[i].applicationType+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 7px;">发布应用</span><span onclick="editFun($(this))" id="edit" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 7px;">编辑</span><span onclick="delFun($(this))" id="del" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 10px 0 10px;">删除</span></div>' +
                            '</div>'
                    }
                    $('.right').html(str)
                    $('#titleBoxs .title_name').html('查询后的应用');
                    var $boxs = $( ".rightCologyUl" );
                    var $er3 = $(".er3")
                    var $boxTitle = $( ".tops" );
                    var $boxTitles = $( ".big" );
                    var $creatUser = $( ".creatUser" );
                    var $lei = $( ".lei" );
                    var $leis = $( ".leis" );
                    var $shu = $( ".shu" );
                    var $shus = $( ".shus" );
                    //用于存储 每列中的所有块框相加的高度。
                    var hArr=[];
                    var lLen = $boxs.length
                    // var liC = ["#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)","#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)"]
                    var liC = ["#039AEB","#6DB944","#963991","#F38020","#DA353C","#FBB826","#039AEB","#6DB944"]
                    for(var j=0;j<lLen;j++){
                        var liColor=liC[j%liC.length];
                        $boxTitle.eq(j).css('background-color',liColor);
                        $boxTitles.eq(j).css('border','1px solid '+liColor+'');
                        $creatUser.eq(j).css('color',liColor);
                        $lei.eq(j).css('color',liColor);
                        $leis.eq(j).css('color',liColor);
                        $shu.eq(j).css('color',liColor);
                        $shus.eq(j).css('color',liColor);
                    }
                }
            })
        })
        // $(document).on('click','#del',function(){
        //     var gappId = $(this).attr('gappId')
        //     layer.confirm(qued,{
        //         btn: [sure,cancel], //按钮
        //         title:'确定删除？'
        //     }, function(){
        //         $.ajax({
        //             type:'post',
        //             url:'/gapp/deleteGappByGappId',
        //             dataType:'json',
        //             data:{'gappId':gappId},
        //             success: function (json) {
        //                 //第三方扩展皮肤
        //                 layer.msg('删除成功', {icon: 1});
        //                 right(gappType)
        //             }
        //         })
        //     }, function () {
        //         layer.closeAll();
        //
        //     })
        //
        //
        // })
        // $(document).on('click','#edit',function(){
        //     var gappId = $(this).attr('gappId')
        //     layer.open({
        //         type: 1,
        //         area: ['531px', '372px'], //宽高
        //         title: ['编辑应用','font-size:20px'],
        //         maxmin: false,
        //         btn: ['取&nbsp&nbsp消','确&nbsp&nbsp定'], //可以无限个按钮
        //         content: '<div style="margin: 43px auto;">' +
        //             '   <form class="layui-form" action="">\n' +
        //             '       <div class="layui-form-item" >\n' +
        //             '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
        //             '               <label class="layui-form-label" style="font-size: 18px">应用名称</label>\n' +
        //             '               <div class="layui-input-inline" style="width:70%">\n' +
        //             '                   <input type="text" name="oneDayPerDiem" placeholder="请输入2到15个字"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
        //             '                   <p class="name" id="name" style="color: red;position:fixed;">请输入应用名称</p>\n' +
        //             '               </div>\n' +
        //             '           </div>\n' +
        //             '       </div>\n' +
        //             '       <div class="layui-form-item" >\n' +
        //             '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
        //             '               <label class="layui-form-label" style="font-size: 18px">排序号</label>\n' +
        //             '               <div class="layui-input-inline" style="width:70%">\n' +
        //             '                   <input type="text" name="gappNo" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
        //             '               </div>\n' +
        //             '           </div>\n' +
        //             '       </div>\n' +
        //             '       <div class="layui-form-item" style="margin-top: 20px;">\n' +
        //             '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
        //             '               <label class="layui-form-label" style="font-size: 18px">应用图标</label>\n' +
        //             '               <div class="layui-input-inline" style="width:70%;">\n' +
        //             '                   <input type="text" style="width: 15%;display: inline-block" readOnly name="oneDaySalaryRatio" id="oneDaySalaryRatio" lay-verify="required|phone" autocomplete="off" class="layui-input"">\n' +
        //             '                   <button type="button" class="layui-btn layui-btn-sm" id="logo" lay-event="logo" style="display: inline-block;margin-left: 30px;">选择图标</button>\n' +
        //             '                   <div class="lists">' +
        //             '                       <div class="list1">' +
        //             '                       </div>' +
        //             '                   </div>\n' +
        //             '               </div>\n' +
        //             '           </div>\n' +
        //             '       </div>\n' +
        //             '   </form>' +
        //             '</div>',
        //         success: function () {
        //             $.ajax({
        //                 url:'/gapp/selectGappByGappId',
        //                 type:'get',
        //                 data:{
        //                     gappId:gappId
        //                 },
        //                 dataType:'json',
        //                 success:function(obj){
        //                     var img = document.getElementById('oneDaySalaryRatio');
        //                     $("input[name='oneDayPerDiem']").val(obj.object.gappName)
        //                     $("input[name='gappNo']").val(obj.object.gappNo)
        //                     img.style.backgroundImage = 'url("/img/gapp/'+obj.object.gappPicId+'.png")';
        //                 }
        //             });
        //             $('.name').hide()
        //             var list = json.list[0]
        //             console.log(list)
        //             var strs=''
        //             for(var a=0;a<3;a++){
        //                 strs += '<option>'+list[a]+'</option>'
        //             }
        //             $("select[name='schoolType']").html(strs)
        //             var str=''
        //             for(var i=1;i<=100;i++){
        //                 str += '<div class="bImg" style="display: inline-block; width: 13%;border: 1px solid rgb(239,239,239);text-align: center;margin-left: 9px" value="'+i+'"><img style="width: 40px;display: inline-block" src="/img/gapp/'+i+'.png" alt=""></div>'
        //             }
        //             $('.list1').html(str)
        //             form.render()
        //         },
        //         yes: function (index, layero) {
        //             layer.close(index);
        //         },
        //         btn2:function(){
        //             var gappName = $("input[name='oneDayPerDiem']").val()
        //             var gappNo = $("input[name='gappNo']").val()
        //             var gappType = $("#ying").attr('gappType')
        //             var gappPicId = $('#oneDaySalaryRatio').attr('gappPicId')
        //             if(gappName == ''){
        //                 $('.name').show()
        //                 return false
        //             }else{
        //                 $.ajax({
        //                     url:'/gapp/updateGappByGappId',
        //                     type:'get',
        //                     data:{
        //                         gappNo:gappNo,
        //                         gappName:gappName,
        //                         gappType:gappType,
        //                         gappPicId:gappPicId,
        //                         gappId:gappId
        //                     },
        //                     dataType:'json',
        //                     success:function(obj){
        //                         //第三方扩展皮肤
        //                         layer.msg('修改成功', {icon: 1});
        //                         right(gappType)
        //                     }
        //                 });
        //             }
        //         }
        //     });
        // })
    })
    //
    // var str = '            <h3 class="menu_head">一级菜单</h3>\n' +
    //     '            <div style="display:none" class="menu_nva">\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '                <a href="#">二级菜单</a>\n' +
    //     '            </div>'
    // function left(){
    //     for(var i=0;i<6;i++){
    //         $('#firstpaneDiv').append(str)
    //     }
    // }
    // left()
    // 删除
    function delFun(e) {
        stopPropagation();
        var gappId = e.attr('gappId')

        layui.layer.open({
            type: 0,
            content: '删除',
            move:false,
            btn:['确定','取消'],
            yes: function(index, layero){
                $.ajax({
                    type:'get',
                    url:'/gapp/deleteGappByGappId',
                    dataType:'json',
                    data:{'gappId':gappId},
                    success: function (json) {
                        if(json.flag){
                            //第三方扩展皮肤
                            layui.layer.msg('删除成功', {icon: 1});
                            e.parents('div.rightCologyUl').remove();
                            // right(gappType)
                        }else{
                            layui.layer.msg(json.msg, {icon: 1});
                        }

                    }
                })
            }
            ,btn2: function(index, layero){
                layui.layer.closeAll();
            }
        });
    }
    // 编辑
    function editFun(e,gappType) {
        stopPropagation();
        var gappId = e.attr('gappId')
        layui.layer.open({
            type: 1,
            area: ['531px', '372px'], //宽高
            title: ['编辑应用','font-size:20px'],
            maxmin: false,
            btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
            content: '<div style="margin: 43px auto;">' +
            '   <form class="layui-form" action="">\n' +
            '       <div class="layui-form-item" >\n' +
            '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
            '               <label class="layui-form-label" style="font-size: 18px">应用名称</label>\n' +
            '               <div class="layui-input-inline" style="width:70%">\n' +
            '                   <input type="text" name="oneDayPerDiem" placeholder="请输入2到15个字"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
            '                   <p class="name" id="name" style="color: red;position:fixed;">请输入应用名称</p>\n' +
            '               </div>\n' +
            '           </div>\n' +
            '       </div>\n' +
            '       <div class="layui-form-item" >\n' +
            '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
            '               <label class="layui-form-label" style="font-size: 18px">排序号</label>\n' +
            '               <div class="layui-input-inline" style="width:70%">\n' +
            '                   <input type="text" name="gappNo" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
            '               </div>\n' +
            '           </div>\n' +
            '       </div>\n' +
            '       <div class="layui-form-item" style="margin-top: 20px;">\n' +
            '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
            '               <label class="layui-form-label" style="font-size: 18px">应用图标</label>\n' +
            '               <div class="layui-input-inline" style="width:70%;">\n' +
            '                   <input type="text" style="width: 15%;display: inline-block" readOnly name="oneDaySalaryRatio" id="oneDaySalaryRatio" lay-verify="required|phone" autocomplete="off" class="layui-input"">\n' +
            '                   <button type="button" class="layui-btn layui-btn-sm" id="logo" lay-event="logo" style="display: inline-block;margin-left: 30px;">选择图标</button>\n' +
            '                   <div class="lists">' +
            '                       <div class="list1">' +
            '                       </div>' +
            '                   </div>\n' +
            '               </div>\n' +
            '           </div>\n' +
            '       </div>\n' +
            '   </form>' +
            '</div>',
            success: function () {
                $.ajax({
                    url:'/gapp/selectGappByGappId',
                    type:'get',
                    data:{
                        gappId:gappId
                    },
                    dataType:'json',
                    success:function(obj){
                        var img = document.getElementById('oneDaySalaryRatio');
                        $("input[name='oneDayPerDiem']").val(obj.object.gappName)
                        $("input[name='gappNo']").val(obj.object.gappNo)
                        img.style.backgroundImage = 'url("/img/gapp/'+obj.object.gappPicId+'.png")';
                    }
                });
                $('.name').hide()
                // var list = json.list[0]
                // var strs=''
                // for(var a=0;a<3;a++){
                //     strs += '<option>'+list[a]+'</option>'
                // }
                // $("select[name='schoolType']").html(strs)
                var str=''
                for(var i=1;i<=100;i++){
                    str += '<div class="bImg" style="display: inline-block; width: 13%;border: 1px solid rgb(239,239,239);text-align: center;margin-left: 9px" value="'+i+'"><img style="width: 40px;display: inline-block" src="/img/gapp/'+i+'.png" alt=""></div>'
                }
                $('.list1').html(str)
                layui.form.render()
            },
            yes: function (index, layero) {
                var gappName = $("input[name='oneDayPerDiem']").val()
                var gappNo = $("input[name='gappNo']").val()
                var gappType = $("#ying").attr('gappType') ? $("#ying").attr('gappType') : 0
                var gappPicId = $('#oneDaySalaryRatio').attr('gappPicId')
                if(gappName == ''){
                    $('.name').show()
                    return false
                }else{
                    $.ajax({
                        url:'/gapp/updateGappByGappId',
                        type:'post',
                        data:{
                            gappNo:gappNo,
                            gappName:gappName,
                            gappType:gappType,
                            gappPicId:gappPicId,
                            gappId:gappId
                        },
                        dataType:'json',
                        success:function(obj){
                            //第三方扩展皮肤
                            layui.layer.msg('修改成功', {icon: 1});
                            layui.layer.close(index);
                            right(gappType)
                        }
                    });
                }
            },
            btn2:function(index, layero){
                layui.layer.close(index);
            }
        });
    }
    $(document).ready(function(){
        $("#firstpaneDiv .menu_nva:eq(0)").show();
        $("#firstpaneDiv h3.menu_head").on('click',function(){
            $(this).addClass("current").next("div.menu_nva").slideToggle(200).siblings("div.menu_nva").slideUp("slow");
            $(this).siblings().removeClass("current");
        });
        $("#secondpane .menu_nva:eq(0)").show();
        $("#secondpane h3.menu_head").on('mouseover',function(){
            $(this).addClass("current").next("div.menu_nva").slideDown(400).siblings("div.menu_nva").slideUp("slow");
            $(this).siblings().removeClass("current");
        });
    });
    var aaa = '0'
    function liste(){
            $('.lists').show()
    }
    $(document).on('click','#logo',function(){
        liste()
    })
    function right(gappType){
        if(gappType == 0){
            gappType = 0
        }
        // console.log(xhr)
        // if(xhr && xhr.readyState != 4){
        //     xhr&&xhr.abort()
        // }
        var loadingIndex = layer.load(1, {shade: [0.5,'#ffffff']})
        xhr = $.ajax({
            type:'get',
            url:'/gapp/selectGappByGappType',
            dataType:'json',
            data:{'gappType':gappType},
            success: function (json) {
                layer.close(loadingIndex)
                var data = json
                var str=''
                for(var i=0;i<data.obj.length;i++){
                    str+='<div class="rightCologyUl pubuTitle big" gappType="'+ data.obj[i].gappType +'"  data-gappId="'+data.obj[i].gappId+'" onclick="openDesigns($(this))" style="display:inline-block;cursor:pointer;border:1px solid rgb(216,216,216);border-radius:10px;width: 320px;margin-left: 20px;margin-top: 10px;margin-bottom: 10px">' +
                        '<div class="tops" style="padding: 7px 0">' +
                        '<p class="hou" style="color: white; border-left: 5px solid white;font-size: 22px;font-weight: 900;margin-left:15px;padding-left: 8px">'+data.obj[i].gappName+'</p>' +
                        '</div>' +

                        '<div>'+

                        '<div style="width: 60%;display: inline-block;margin-top: -10px">' +
                        '<span id="biao" style="background-size:100%;background-image: url(/img/gapp/' + data.obj[i].gappPicId + '.png);"></span>' +
                        '<p class="creatUser" style="margin-left: 30px;margin-top: 10px;font-size: 16px">创建人:&nbsp&nbsp'+data.obj[i].createUserName+'</p>' +
                        '</div>' +

                        '<div style="display: inline-block;width: 40%">' +
                        '<div class="shus" style="font-size: 50px;height:60px;color: #107fff;text-align: center;margin-bottom: 12px">'+data.obj[i].dataCounts+'</div>' +
                        '<p class="shu" style="position:relative;top: 0px;text-align: center;font-size: 16px">数据条目</p>' +
                        '</div>' +


                        // '<div style="width: 100px;height: 100px;display: none;padding-left: 15px;position: absolute;top: 80px">' +
                        // '<span class="leis" style="font-size: 18px;">'+data.obj[i].applicationType+'</span>' +
                        // '<p class="lei" style="position:relative;top: 40px;font-size: 18px">应用类型</p>' +
                        // '</div>' +


                        '</div>'+
                        '<div class="bottom" style="cursor:pointer;"><span onclick="openUaeApps($(this))" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 5px;margin-left:30px;">打开应用</span><span onclick="publishUaeApps($(this))" gappId="'+data.obj[i].gappId+'" applicationType="'+data.obj[i].applicationType+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 7px;">发布应用</span><span onclick="editFun($(this))" id="edit" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 7px;">编辑</span><span onclick="delFun($(this))" id="del" gappId="'+data.obj[i].gappId+'" style="color: rgb(0,0,241);font-size: 18px;line-height: 50px;margin:0 10px 0 10px;">删除</span></div>' +
                        '</div>'
                }
                $('.right').html(str)
                var $boxs = $( ".rightCologyUl" );
                var $er3 = $(".er3")
                var $boxTitle = $( ".tops" );
                var $boxTitles = $( ".big" );
                var $creatUser = $( ".creatUser" );
                var $lei = $( ".lei" );
                var $leis = $( ".leis" );
                var $shu = $( ".shu" );
                var $shus = $( ".shus" );
                //用于存储 每列中的所有块框相加的高度。
                var hArr=[];
                var lLen = $boxs.length
                // var liC = ["#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)","#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)"]
                var liC = ["#039AEB","#6DB944","#963991","#F38020","#DA353C","#FBB826","#039AEB","#6DB944"]
                for(var j=0;j<lLen;j++){
                    var liColor=liC[j%liC.length];
                    $boxTitle.eq(j).css('background-color',liColor);
                    $boxTitles.eq(j).css('border','1px solid '+liColor+'');
                    $creatUser.eq(j).css('color',liColor);
                    $lei.eq(j).css('color',liColor);
                    $leis.eq(j).css('color',liColor);
                    $shu.eq(j).css('color',liColor);
                    $shus.eq(j).css('color',liColor);
                }
            }
        })

    }
    // 打开表单设计
    function openDesigns(e){
        var gappId = e.attr('data-gappId');
        var gappType = e.attr('gappType');
        window.open('/gapp/formDesign?gappId='+ gappId+"&typeId="+gappType);
    }
    // 打开应用
    function openUaeApps(e){
        var gappId = e.attr('gappId');
        window.open('/gapp/openApp?gappId='+ gappId);
        stopPropagation();
    }
    // 发布应用
    function publishUaeApps(e){
        var gappId = e.attr('gappId');
        var gappName  =e.attr('gappName');
        // window.open('?gappId='+ gappId);
        layer.open({
            type:1,
            title:'发布应用',
            area: ['55%','75%'],
            btn:['发布','取消'],
            content:'<div class="tbox">\n' +
            '        <form class="layui-form" action="" style="width: 80%;margin: auto;">\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label">子菜单项ID</label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text"  name="addfId" id="addfId"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span>上级菜单</label>\n' +
            '\n' +
            '                <div class="layui-input-block">\n' +
            '                    <select name="addParentId" id="addParentId" lay-filter="addParentId" lay-verify="required"  class="layui-input-block">\n' +
            '                        <option></option>\n' +
            '                    </select>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span>子菜单项代码</label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addId"  id="addId" lay-verify="title" autocomplete="off" class="layui-input">\n' +
                '            <div>说明：在同一父菜单下的平级菜单，代码不可重复,(注:此代码为俩位,用来排序)\n'+
        '                </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label"><span class="red">*</span>子菜单名称</label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addName"  id="addName" style="border: 1px solid #c0c0c0" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item">\n' +
            '                <label class="layui-form-label">子菜单模块路径</label>\n' +
            '                <div class="layui-input-block">\n' +
            '                    <input type="text" name="addUrl"  id="addUrl"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" id="userBox" style="position:relative;">\n' +
            '                <label class="layui-form-label"><span class="red">*</span>授权角色</label>\n' +
            '                <div class="layui-input-block">\n' +
            '                        <textarea  style="float: left;border: 1px solid #c0c0c0;background-color: #e7e7e7;" id="privDuser"  readonly="readonly" class="layui-textarea"></textarea>\n' +
                '             <div>\n'+
            '                    <a style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;cursor: pointer;" onclick="selectUser($(this))">选择</a>\n' +
            '                    <a style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;margin-left:40px;cursor: pointer;" onclick="reset1()">清空</a>\n' +
            '                </div>\n' +
                '                </div>\n' +
            '            </div>\n' +
            '        </form>\n' +
            '    </div>\n'
            ,success: function(layero){
                $("#addName").val(gappName);
                $("#addUrl").val('/gapp/openApp?gappId=' + gappId)
                //获取子菜单项ID
                $.ajax({
                    url: '/getMenuId',
                    dataType: 'json',
                    type: 'post',
                    success: function (res) {
                        $("#addfId").val(res.object)
                    }
                })
                selectMenu($('#addParentId'));
                // //获取上级菜单类型
                // $.ajax({
                //     type: 'get',
                //     url: '/showNewMenu',
                //     dataType: 'json',
                //     success: function (res) {
                //         if (res.datas.length > 0) {
                //             var $select1 = $("select[name='addParentId']");
                //             var optionStr = '';
                //             for (var i = 0; i < res.datas.length; i++) {
                //                 var select1option = res.datas[i];
                //                 optionStr += '<option class="fwlb" value="' + select1option.id + '">' + select1option.name + '</option>'
                //             }
                //             $select1.append(optionStr);
                //         }
                //         layui.form.render('select')
                //     }
                // })
            },
            yes: function (index, layero) {
                //发布应用
                var privDuser = $("#privDuser").val();//授权角色
                var privDuserids =$("#privDuser").attr('privid');//授权角色id
                var fId =$("#addfId").val();
                var parentIdn = $("#addParentId").val();
                var idss =$("#addId").val();
                var names = $("#addName").val();
                var urls =$("#addUrl").val()
                if(fId=='' || parentIdn=='' || idss=='' ||names=='' || urls=='' ||privDuser==''){
                    layui.layer.msg("必填项不能为空");
                    return false;
                }
                $.ajax({
                    url: '/addFunction',
                    data:{
                        fId: fId,
                        parentId: parentIdn,
                        id: idss,
                        name: names,
                        url: urls,
                        isopenNew: 0,
                        isShowFunc: 0
                    },
                    type: 'post',
                    success: function (res) {
                        if(res.flag){
                            layer.msg(res.msg, {icon: 1});
                            $.ajax({
                                url: '/updateUserPrivfuncIdStr',
                                data:{
                                    privids: privDuserids,
                                    funcId: fId
                                },
                                type: 'post',
                                success: function (res) {
                                    if(res.flag){
                                        layui.layer.msg("发布成功", {icon: 1})

                                        $.ajax({
                                            url: '/gtable/selectGtableByGappId',
                                            type: 'post',
                                            data:{
                                                gappId:gappId
                                            },
                                            success: function (res) {
                                                if(res.flag){
                                                    $.ajax({
                                                        url: '/gappLogs/addGappLogs',
                                                        type: 'post',
                                                        data:{
                                                            opObject:"0",
                                                            opTyep:"2",
                                                            opApp:res.object.tabId,
                                                            opDesc:"发布应用["+res.object.tabName+"]"
                                                        },
                                                        success: function (res) {
                                                        }
                                                    })
                                                }
                                            }
                                        })

                                    }
                                }
                            })
                        }else{
                            layer.msg(res.msg, {icon: 5})
                        }
                    }
                })
                layui.layer.close(index);
            },
            btn2:function(index,layer){
                //取消
                layui.layer.close(index);
            }
        })
        stopPropagation();
    }
    // 阻止冒泡
    function stopPropagation(e) {
        e = e || window.event;
        if(e.stopPropagation) { //W3C阻止冒泡方法
            e.stopPropagation();
        } else {
            e.cancelBubble = true; //IE阻止冒泡方法
        }
    }
    function reset1(){
        $('#userBox').find('textarea').val('');
        $('#userBox').find('textarea').attr('privid','');
        $('#userBox').find('textarea').attr('userpriv','');
    }
    function selectUser(e){
        var privDuser = e.parents('div#userBox').find('textarea').attr('id')
        priv_id = privDuser;
        $.popWindow("../common/selectPriv?1");
    }
    function selectMenu(element) {
        $.ajax({
            type: 'get',
            url: '/showMenu',
            dataType: 'json',
            success: function (rsp) {
                var data = rsp.obj;
                var str = '';
                str = queryMenuT(data, str)
                element.append(str);
                layui.form.render('select')
            }
        })
    }

    function queryMenuT(data, str) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].id.length==2){
                str += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
            }else{
                str += '<option value="' + data[i].id + '">' +"&nbsp;&nbsp;├"+data[i].name + '</option>';
            }

            if (data[i].child) {
                if (data[i].child.length > 0) {
                    str = queryMenuT(data[i].child, str);
                }
            }

        }
        return str;
    }

    function checkNumber(e){
        e.value = Number.parseInt(e.value)
    }

</script>
</html>
