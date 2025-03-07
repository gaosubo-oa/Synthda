<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>权限管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
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
    <script type="text/javascript" src="/js/gapp/ming.js?20211208.4"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
</head>
<style>
    html,body{
        height: 100%;
        overflow: hidden;
    }
    .cont_left {
        height: 100%;
        border-right: none;
        overflow-y: auto;
        width: 100%;
    }
    .top{
        padding-top: 10px;
        border-bottom: 2px solid rgb(230,230,230);
        height: 50px;
    }
    #search{
        background-color: rgb(16,127,255);
        line-height: 30px;
        margin-left: 10px;
        width: 80px;
        height: 37px;
        font-size: 18px
    }
    #add{
        background-color: rgb(64,147,243);
        line-height: 30px;
        margin-left: 10px;
        width: 100px;height: 37px;
        font-size: 18px;
        float: right;
        margin-right: 50px;
        margin-top: 10px
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
    .layui-layer-btn .layui-layer-btn0{
        background-color: rgb(24,144,255);
        color: white;
        border:1px solid rgb(24,144,255);
        width: 50px;
        text-align: center;
        height: 30px;
        line-height: 30px;
        font-size: 18px;
        border-radius: 8px;
    }
    .layui-layer-btn .layui-layer-btn1{
        background-color: white;
        color: black;
        border:1px solid rgb(233,233,233);
        width: 50px;
        text-align: center;
        height: 30px;
        line-height: 30px;
        font-size: 18px;
        border-radius: 8px;
    }
    .layui-layer-title{
        height: 45px;
        line-height: 45px;
        border-bottom: 1px solid rgb(227,227,227);
        background-color: white;
    }
    .layui-layer-iframe .layui-layer-btn, .layui-layer-page .layui-layer-btn{
        border-top: 1px solid rgb(227,227,227);
    }
    #biao{
        width: 100px;
        height: 100px;
        font-size: 50px;
        display: inline-block;
        text-align: center;
        line-height: 100px;
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
        position: absolute;
        left: 0;
        bottom: 0;
        border-bottom-right-radius: 10px;
        border-bottom-left-radius: 10px;
    }
    .tops{
        width: 100%;
        height: 50px;
        background-color: red;
        position: absolute;
        border-top-right-radius: 7px;
        border-top-left-radius: 7px;
        line-height: 28px;
    }
    .big:hover{
        -webkit-box-shadow: #ccc 0px 10px 10px;
        -moz-box-shadow: #ccc 0px 10px 10px;
        box-shadow: #ccc 0px 10px 10px;  }
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
    .left {
        display: inline-block;
        height: calc(100% - 62px);
        border-right: 1px solid #837f7f;
        float: left;
        width: 260px;
    }
    #tr_td .th {
        background-color: #fff;
        font-size: 9pt;
        color: #2F5C8F;
        font-weight: bold;
        border: 0px;
    }
    table tr td span {
        color: black;
    }
    #abc .layui-form-checkbox span {
        height:auto!important;
    }
    .checkBox .layui-form-checkbox {
        padding-left: 10px!important;
    }
    .layui-form-checkbox[lay-skin="primary"] span {
        margin-left:4px
    }
    .layui-table-cell .layui-form-checkbox[lay-skin=primary]{
        margin-bottom: 5px;
    }
    .sanji h1{
        cursor: pointer;
    }
    .yiji h1{
        cursor: pointer;
    }

</style>
<body>
<div class="top">
    <div style="margin-left: 15px;color:#2f8ae3;display: inline-block;font-width: bold;font-size: 24px;line-height: 38px;height: 38px;" id="ying"><img style="width: 28px;display: inline-block" src="/img/gapp/priv_mage.png" alt="">&nbsp;权限管理</div>
</div>
<div class="left">
    <div class="cont_left">
        <ul class="all_ul">
            <div class="tab_c list">

                <ul class="tab_cone a yiji" style="background: #fff;">

                </ul>
            </div>
        </ul>

    </div>
</div>
<div class="right" style="height: calc(100% - 62px);width: calc(100% - 270px);float: right;overflow: auto;">
    <div style="margin-top: 10px;height: 40px;position: relative;">
        <div id="titleBoxs" style="height: 100%;">
            <img style="display: inline-block;position: absolute;top: 6px;left: 20px;height: 25px;" src="/img/gapp/priv_action.png" alt="">
            <h2 class="title_name" style="display: inline-block;margin-left: 60px;height: 40px;line-height: 40px;"></h2>
        </div>
        <a  class="layui-btn layui-btn-sm"  id="adddata" style="position:absolute;right: 20px;top: 10px;display: inline-block;width: 80px;font-size: 14px;background-color: rgb(64,147,243)" >新建权限</a>
    </div>
    <%--<div style="margin-left: 10px;display: inline-block;font-weight: bold;font-size: 20px;margin-top: 15px;" >应用权限设置</div>--%>

    <div style="padding:0px 20px 0px 10px">
        <table class="layui-table" style="margin-top:0px;" lay-skin="line" id="Settlement" lay-size="sm" lay-filter="SettlementFilter"></table>
    </div>

</div>

</body>
<script type="text/html" id="barOperation">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    var gappType;
    var gappTypes;
    var tprivId = '';//自增id
    var tabId = '';//所属表单
    var typeId;//应用分类
    var meetTable;
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var upload = layui.upload;
        var laydate = layui.laydate
        var eleTree = layui.eleTree;
        form.render()
        var el;

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

                        if(data[i].childs=='' || data[i].childs==undefined){
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
                        $('#titleBoxs .title_name').html(names + '&nbsp;-&nbsp;权限设置');
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
                        $('#titleBoxs .title_name').html(names + '&nbsp;-&nbsp;权限设置');
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
                        $('#titleBoxs .title_name').html(names + '&nbsp;-&nbsp;权限设置');
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
                    // $('.one_all')[0].click()
                    $('#titleBoxs .title_name').html(data[0].typeName + '&nbsp;-&nbsp;权限设置');
                    right(data[0].typeId)

                }
            })

        };
        init()

        function right(gappType) {
            if (gappType == 0) {
                gappType = 0
                typeId =0
            }
            typeId =gappType
             meetTable=table.render({
                elem: '#Settlement'
                , url: '/gtablePriv/selectGtablePriv'
                , page: true
                 ,method:'post'
                ,where:{
                     page:1,
                     limit:10,
                     useFlag:true,
                     typeId:gappType,
                }
                , title: '用户数据表'
                , cols:
                    [[
                        {field: 'gappName', title: '应用名称',  width:130}
                        ,{field: 'tabButtonPriv', title: '表单权限',width:200, templet: function (d) {
                                var str = '';
                            if(d.tabButtonPriv !='' && d.tabButtonPriv != undefined && d.tabButtonPriv !="undefined"){
                                if(d.tabButtonPriv.indexOf("BUT_FORM_TEMP") != -1){
                                    str += '暂存&nbsp;'
                                }
                                if(d.tabButtonPriv.indexOf("BUT_FORM_SAVE") != -1){
                                    str += '保存&nbsp;'
                                }
                                if(d.tabButtonPriv.indexOf("BUT_FORM_EDIT") != -1){
                                    str += '编辑&nbsp;'
                                }
                                if(d.tabButtonPriv.indexOf("BUT_FORM_SUBMIT") != -1){
                                    str += '提交&nbsp;'
                                }
                                if(d.tabButtonPriv.indexOf("BUT_FORM_DEL") != -1){
                                    str += '删除&nbsp;'
                                }
                            }
                            return str
                            // return '<div style="position: relative;height:100%;width: 100%;">' +str+'</div>';
                        }}
                        , {field: 'listButtonPriv', title: '列表权限',width:160, templet: function (d) {
                                var str = '';
                                if(d.listButtonPriv !='' && d.listButtonPriv != undefined && d.listButtonPriv !="undefined"){
                                    if(d.listButtonPriv.indexOf("BUT_LIST_ADD") != -1){
                                        str += '新增&nbsp;'
                                    }
                                    if(d.listButtonPriv.indexOf("BUT_LIST_IN") != -1){
                                        str += '导入&nbsp;'
                                    }
                                    if(d.listButtonPriv.indexOf("BUT_LIST_OUT") != -1){
                                        str += '导出&nbsp;'
                                    }
                                    if(d.listButtonPriv.indexOf("BUT_LIST_DEL") != -1){
                                        str += '删除&nbsp;'
                                    }
                                }
                                return str
                                // return '<div style="position: relative;height:100%;width: 100%;">' +str+'</div>';
                            }}
                        , {field: 'createUserId', title: '数据权限（创建人）',width:170,templet: function (d) {
                                if(d.createUserId !='' && d.createUserId != "undefined" && d.createUserId != undefined){
                                    if(d.createUserId==1){
                                        return '是';
                                    }else if(d.createUserId==0){
                                        return '否';
                                    }
                                }else{
                                    return ''
                                }
                            }}
                        , {field: 'allUsers', title:'数据权限(全部)',width:160,templet: function (d) {
                                if(d.allUsers !='' && d.allUsers != "undefined" && d.allUsers != undefined){
                                    if(d.allUsers==1){
                                        return '是';
                                    }else if(d.allUsers==0){
                                        return '否';
                                    }
                                }else{
                                    return ''
                                }
                            }}
                        , {field: 'ownerUserId', title: '数据权限（拥有者）',width:170,templet: function (d) {
                                if(d.ownerUserId !='' && d.ownerUserId != "undefined" && d.ownerUserId != undefined){
                                    if(d.ownerUserId==1){
                                        return '是';
                                    }else if(d.ownerUserId==0){
                                        return '否';
                                    }
                                }else{
                                    return ''
                                }
                            }}
                        , {field: 'ownerDeptId', title: '数据权限（所属部门）',width:170,templet: function (d) {
                                if(d.ownerDeptId !='' && d.ownerDeptId != "undefined" && d.ownerDeptId != undefined){
                                    if(d.ownerDeptId==1){
                                        return '是';
                                    }else if(d.ownerDeptId==0){
                                        return '否';
                                    }
                                }else{
                                    return ''
                                }
                            }}
                        , {field: 'deptIdRpivsName', title: '授权部门', width:120,templet: function (d) {
                                if(d.deptIdRpivsName !='' && d.deptIdRpivsName!=undefined && d.deptIdRpivsName!="undefined"){
                                    return d.deptIdRpivsName;
                                }else{
                                    return '';
                                }
                            }}
                        , {field: 'rpivIdRpivsName', title: '授权角色', width:120,templet: function (d) {
                                if(d.rpivIdRpivsName !='' && d.rpivIdRpivsName!=undefined && d.rpivIdRpivsName!="undefined"){
                                    return d.rpivIdRpivsName;
                                }else{
                                    return '';
                                }
                            }}
                        , {field: 'userIdRpivsName', title: '授权用户', width:120,templet: function (d) {
                                if(d.userIdRpivsName !='' && d.userIdRpivsName!=undefined && d.userIdRpivsName!="undefined"){
                                    return d.userIdRpivsName;
                                }else{
                                    return '';
                                }
                            }}
                        ,{title: '操作', fixed:'right', width:120, toolbar: '#barOperation'}
                    ]]
                , parseData: function (res) { //res 即为原始返回的数据
                    // var data = json.obj
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                }
                ,done:function(res){
                     if(res.data.length > 0){
                         $('.layui-table-header').eq(0).css('overflow','hidden');
                     }else{
                         $('.layui-table-header').eq(0).css('overflow-x','auto');
                     }
                }


            })

        }

        table.on('tool(SettlementFilter)',function(res){
            var data = res.data
            var height = $(window).height();
            var h = (Number(height) - 60)/Number(height);
            var ah = Math.round(h * 100) + "%";
            if(res.event == 'edit'){
                var openPage = layer.open({
                    type: 1,
                    title: "权限修改",
                    shadeClose: true,
                    btn: ['确定','取消'],
                    // shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['55%', '80%'],
                    content: ' <form id="abc"><div class="layui-form" >' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width:30%;">表单权限:</label>\n' +
                        '<input type="checkbox" name="butFormTemp"   id="butFormTemp" title="暂存" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butFormSave" id="butFormSave" title="保存" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butFormEdit" id="butFormEdit" title="编辑" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butFormSubmit"  id="butFormSubmit" title="提交" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butFormDel" id="butFormDel"  title="删除" lay-skin="primary">\n'+
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width: 30%;">列表权限:</label>\n' +
                        '<input type="checkbox" name="butListAdd"  id="butListAdd" title="新增" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butListIn"  id="butListIn" title="导入" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butListOut" id="butListOut"  title="导出" lay-skin="primary">\n'+
                        '<input type="checkbox" name="butListDel"  id="butListDel" title="删除" lay-skin="primary">\n'+
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width:30%;">数据权限(创建人):</label>\n' +
                        '<input type="radio" name="createUserId" value="1" title="是">\n'+
                        '<input type="radio" name="createUserId"  checked value="0" title="否">\n'+
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width:30%;">数据权限(全部):</label>\n' +
                        '<input type="radio" name="allUsers" value="1" title="是">\n'+
                        '<input type="radio" name="allUsers"  checked value="0" title="否">\n'+
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width: 30%;">数据权限(拥有者):</label>\n' +
                        '<input type="radio" name="ownerUserId" value="1" title="是">\n'+
                        '<input type="radio" name="ownerUserId"  checked value="0" title="否">\n'+
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                        '    <label class="layui-form-label" style="width:30%;">数据权限(所属部门):</label>\n' +
                        '<input type="radio" name="ownerDeptId" value="1" title="是">\n'+
                        '<input type="radio" name="ownerDeptId" checked value="0" title="否">\n'+
                        '  </div>' +

                        '<div class="layui-form-item" style="width: 100%;">\n' +
                        '    <label class="layui-form-label" style="width: 30%;">授权部门:</label>\n' +
                        '    <span style="float:left;width: 65%;">\n' +
                        '                        <textarea  style="float: left;width: 300px;" id="deptInputId" disabled class="layui-textarea"></textarea>\n' +
                        '           <div style="margin-top: 84px;">\n'+
                        '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                       <a href="javascript:;" id="selectPriv" class="Add" onclick="selectDep($(this))">添加</a>\n '+
                        '                       </span>\n'+
                        '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                  <a href="javascript:;" class="clearPriv" onclick="reset1(1)">清除</a>\n'+
                        '    </span>\n' +
                        '    </span>\n' +
                        '  </div>' +
                        '  </div>' +

                        '<div class="layui-form-item" style="width: 100%;">\n' +
                        '    <label class="layui-form-label" style="width: 30%;">授权角色:</label>\n' +
                        '    <span style="float:left;width: 65%;">\n' +
                        '                        <textarea  style="float: left;width: 300px;" id="privDuser2" disabled class="layui-textarea"></textarea>\n' +
                        '           <div style="margin-top: 84px;">\n'+
                        '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                       <a href="javascript:;" id="selectPriv2" class="Add" onclick="selectUser($(this))">添加</a>\n '+
                        '                       </span>\n'+
                        '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                  <a href="javascript:;" class="clearPriv" onclick="reset1(2)">清除</a>\n'+
                        '    </span>\n' +
                        '    </span>\n' +
                        '  </div>' +
                        '  </div>' +

                        '<div class="layui-form-item" style="width: 100%;">\n' +
                        '    <label class="layui-form-label" style="width: 30%;">授权用户:</label>\n' +
                        '    <span style="float:left;width: 65%;">\n' +
                        '                        <textarea  style="float: left;width: 300px;" id="privDuser3" disabled class="layui-textarea"></textarea>\n' +
                        '           <div style="margin-top: 84px;">\n'+
                        '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                       <a href="javascript:;" id="selectPriv3" class="Add" onclick="selectPeo($(this))">添加</a>\n '+
                        '                       </span>\n'+
                        '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                        '                  <a href="javascript:;" class="clearPriv"  onclick="reset1(3)">清除</a>\n'+
                        '    </span>\n' +
                        '    </span>\n' +
                        '  </div>' +
                        '  </div>' +
                        '</div></form>',
                    success: function () {
                        $.ajax({
                            url:'/gtablePriv/selectGtablePriv',
                            type:'post',
                            data:{
                                typeId:data.typeId,
                                page:1,
                                limit:10,
                                useFlag:true,
                                tprivId:data.tprivId
                            },
                            dataType:'json',
                            success:function(res){
                                var datas = res.obj[0]
                                if(datas != '' && datas != "undefined" && datas != undefined){
                                    tprivId = datas.tprivId;
                                    tabId = datas. tabId;
                                    typeId = datas.typeId;
                                    var a  =datas.tabButtonPriv.indexOf("BUT_FORM_TEMP") != -1
                                    $("#butFormSave").prop("checked", datas.tabButtonPriv.indexOf("BUT_FORM_SAVE") != -1)
                                    $("#butFormSubmit").prop("checked", datas.tabButtonPriv.indexOf("BUT_FORM_SUBMIT") != -1)
                                    $("#butFormEdit").prop("checked", datas.tabButtonPriv.indexOf("BUT_FORM_EDIT") != -1)
                                    $("#butFormTemp").prop("checked", datas.tabButtonPriv.indexOf("BUT_FORM_TEMP") != -1)
                                    $("#butFormDel").prop("checked", datas.tabButtonPriv.indexOf("BUT_FORM_DEL") != -1)
                                    $("#butListAdd").prop("checked", datas.listButtonPriv.indexOf("BUT_LIST_ADD") != -1)
                                    $("#butListIn").prop("checked", datas.listButtonPriv.indexOf("BUT_LIST_IN") != -1)
                                    $("#butListOut").prop("checked",datas.listButtonPriv.indexOf("BUT_LIST_OUT") != -1)
                                    $("#butListDel").prop("checked", datas.listButtonPriv.indexOf("BUT_LIST_DEL") != -1)
                                    if(datas.createUserId== '1'){
                                        $('input[name="createUserId"][title="是"]').prop("checked", true);
                                    }else{
                                        $('input[name="createUserId"][title="否"]').prop("checked", true);
                                    }
                                    if(datas.allUsers== '1'){
                                        $('input[name="allUsers"][title="是"]').prop("checked", true);
                                    }else{
                                        $('input[name="allUsers"][title="否"]').prop("checked", true);
                                    }
                                    if(datas.ownerUserId== '1'){
                                        $('input[name="ownerUserId"][title="是"]').prop("checked", true);
                                    }else{
                                        $('input[name="ownerUserId"][title="否"]').prop("checked", true);
                                    }
                                    if(datas.ownerDeptId== '1'){
                                        $('input[name="ownerDeptId"][title="是"]').prop("checked", true);
                                    }else{
                                        $('input[name="ownerDeptId"][title="否"]').prop("checked", true);
                                    }
                                    //部门
                                    $("#deptInputId").attr("deptid",datas.deptIdRpivs)
                                    $("#deptInputId").attr("deptname",datas.deptIdRpivsName)
                                    $("#deptInputId").val(datas.deptIdRpivsName)
                                    //角色
                                    $("#privDuser2").attr("privid",datas.rpivIdRpivs)
                                    $("#privDuser2").attr("userpriv",datas.rpivIdRpivs)
                                    $("#privDuser2").val(datas.rpivIdRpivsName)
                                    //用户
                                    $("#privDuser3").attr("dataid",datas.userIdRpivs)
                                    $("#privDuser3").attr("user_id",datas.userIdRpivs)
                                    $("#privDuser3").attr("userprivname",datas.userIdRpivsName)
                                    $("#privDuser3").attr("username",datas.userIdRpivsName)
                                    $("#privDuser3").val(datas.userIdRpivsName)
                                }
                                layui.form.render();
                            }
                        })
                    },
                    btn2:function(){
                        layer.close(openPage)

                    },
                    yes:function(){
                        var tabButtonPrivs =''
                        var listButtonPrivs =''
                        if($("#butFormTemp").prop("checked")){
                            tabButtonPrivs += "BUT_FORM_TEMP"+","
                        }
                        if($("#butFormSave").prop("checked")){
                            tabButtonPrivs += "BUT_FORM_SAVE"+","
                        }
                        if($("#butFormEdit").prop("checked")){
                            tabButtonPrivs += "BUT_FORM_EDIT"+","
                        }
                        if($("#butFormSubmit").prop("checked")){
                            tabButtonPrivs += "BUT_FORM_SUBMIT"+","
                        }
                        if($("#butFormDel").prop("checked")){
                            tabButtonPrivs += "BUT_FORM_DEL"+","
                        }

                        if($("#butListAdd").prop("checked")){
                            listButtonPrivs += "BUT_LIST_ADD"+","
                        }
                        if($("#butListIn").prop("checked")){
                            listButtonPrivs += "BUT_LIST_IN"+","
                        }
                        if($("#butListOut").prop("checked")){
                            listButtonPrivs += "BUT_LIST_OUT"+","
                        }
                        if($("#butListDel").prop("checked")){
                            listButtonPrivs += "BUT_LIST_DEL"+","
                        }


                        if($('input[name="createUserId"][title="是"]').prop("checked") == true){
                            var createUserIds =1
                        }else if($('input[name="createUserId"][title="否"]').prop("checked") == true){
                            var createUserIds =0
                        }
                        if($('input[name="allUsers"][title="是"]').prop("checked") == true){
                            var allUserss =1
                        }else if($('input[name="allUsers"][title="否"]').prop("checked") == true){
                            var allUserss =0
                        }
                        if($('input[name="ownerUserId"][title="是"]').prop("checked") == true){
                            var ownerUserIds =1
                        }else if($('input[name="ownerUserId"][title="否"]').prop("checked") == true){
                            var ownerUserIds =0
                        }

                        if($('input[name="ownerDeptId"][title="是"]').prop("checked") == true){
                            var ownerDeptIds =1
                        }else if($('input[name="ownerDeptId"][title="否"]').prop("checked") == true){
                            var ownerDeptIds =0
                        }
                        $.ajax({
                            url:'/gtablePriv/updateGtablePriv',
                            type:'post',
                            data:{
                                tprivId:tprivId,
                                tabId: tabId,
                                tabButtonPriv:tabButtonPrivs,
                                listButtonPriv:listButtonPrivs,
                                createUserId:createUserIds,
                                allUsers:allUserss,
                                ownerUserId:ownerUserIds,
                                ownerDeptId:ownerDeptIds,
                                deptIdRpivs:$("#deptInputId").attr("deptid"),//部门
                                rpivIdRpivs:$("#privDuser2").attr("userpriv"),//角色
                                userIdRpivs:$("#privDuser3").attr("user_id"),//用户
                                typeId:typeId
                            },
                            dataType:'json',
                            success:function(res){
                                if(res.flag){
                                    layer.msg(res.msg)
                                    layer.closeAll();
                                    meetTable.reload();
                                }

                            }
                        })
                    }
                })
            }
            else if(res.event == 'del'){
                layer.confirm('确认要删除吗?', {
                    btn: ['确认', '取消'],
                    icon: 7,
                    title: "系统提示"
                }, function () {
                    $.ajax({
                        url:'/gtablePriv/deleteGtablePriv',
                        data:{tprivId: res.data.tprivId},
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            layer.closeAll();
                            layui.layer.msg("删除成功");
                            meetTable.reload();
                        }
                    })
                }, function () {
                    layer.closeAll();
                });



            }
        })
    })
    //角色
    function selectUser(e){
        priv_id = "privDuser2";
        $.popWindow("../common/selectPriv");
    }
    //部门
    function selectDep(e){
        dept_id = "deptInputId";
        $.popWindow("/common/selectDept");
    }
    //用户
    function selectPeo(e){
        user_id = 'privDuser3';
        $.popWindow("../common/selectUser");
    }
    function reset1(a){
        if(a=="1"){
            $('#deptInputId').val('');
            $('#deptInputId').attr('deptid','');
            $('#deptInputId').attr('deptname','');
        }
        if(a=="2"){
            $('#privDuser2').val('');
            $('#privDuser2').attr('privid','');
            $('#privDuser2').attr('userpriv','');
        }
        if(a=="3"){
            $('#privDuser3').val('');
            $('#privDuser3').attr('dataid','');
            $('#privDuser3').attr('user_id','');
            $('#privDuser3').attr('userprivname','');
            $("#privDuser3").attr("username",'')
        }
    }
    $("#adddata").on('click',function(){
        layer.open({
            type: 1,
            title: "新增权限",
            shadeClose: true,
            btn: ['确定', '取消'],
            // shade: 0.5,
            maxmin: true, //开启最大化最小化按钮
            area: ['55%', '80%'],
            content: ' <form id="abc"><div class="layui-form" >' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width:30%;">选择应用:</label>\n' +
                '    <span style="float:left;width: 65%;">\n' +
                '<div class="layui-input-block" style="width:60%;margin-left: 4px;"><select name="application"  id="application" >\n' +
                '                        <option>请选择</option>\n' +
                '                    </select>\n'+
                '  </div>\n' +
                '    </span>\n' +
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width:30%;">表单权限:</label>\n' +
                '<input type="checkbox" name="butFormTemp"   id="butFormTemp" title="暂存" lay-skin="primary">\n'+
                '<input type="checkbox" name="butFormSave" id="butFormSave" title="保存" lay-skin="primary">\n'+
                '<input type="checkbox" name="butFormEdit" id="butFormEdit" title="编辑" lay-skin="primary">\n'+
                '<input type="checkbox" name="butFormSubmit"  id="butFormSubmit" title="提交" lay-skin="primary">\n'+
                '<input type="checkbox" name="butFormDel" id="butFormDel"  title="删除" lay-skin="primary">\n'+
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width: 30%;">列表权限:</label>\n' +
                '<input type="checkbox" name="butListAdd"  id="butListAdd" title="新增" lay-skin="primary">\n'+
                '<input type="checkbox" name="butListIn"  id="butListIn" title="导入" lay-skin="primary">\n'+
                '<input type="checkbox" name="butListOut" id="butListOut"  title="导出" lay-skin="primary">\n'+
                '<input type="checkbox" name="butListDel"  id="butListDel" title="删除" lay-skin="primary">\n'+
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width:30%;">数据权限(创建人):</label>\n' +
                '<input type="radio" name="createUserId" value="1" title="是">\n'+
                '<input type="radio" name="createUserId"  checked value="0" title="否">\n'+
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width:30%;">数据权限(全部):</label>\n' +
                '<input type="radio" name="allUsers" value="1" title="是">\n'+
                '<input type="radio" name="allUsers"  checked value="0" title="否">\n'+
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width: 30%;">数据权限(拥有者):</label>\n' +
                '<input type="radio" name="ownerUserId" value="1" title="是">\n'+
                '<input type="radio" name="ownerUserId"  checked value="0" title="否">\n'+
                '  </div>' +
                '<div class="layui-form-item"style="width: 100%;margin-top: 5px;">\n' +
                '    <label class="layui-form-label" style="width:30%;">数据权限(所属部门):</label>\n' +
                '<input type="radio" name="ownerDeptId" value="1" title="是">\n'+
                '<input type="radio" name="ownerDeptId" checked value="0" title="否">\n'+
                '  </div>' +

                '<div class="layui-form-item" style="width: 100%;">\n' +
                '    <label class="layui-form-label" style="width: 30%;">授权部门:</label>\n' +
                '    <span style="float:left;width: 65%;">\n' +
                '                        <textarea  style="float: left;width: 300px;" id="deptInputId" disabled class="layui-textarea"></textarea>\n' +
                '           <div style="margin-top: 84px;">\n'+
                '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                       <a href="javascript:;" id="selectPriv" class="Add" onclick="selectDep($(this))">添加</a>\n '+
                '                       </span>\n'+
                '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                  <a href="javascript:;" class="clearPriv" onclick="reset1(1)">清除</a>\n'+
                '    </span>\n' +
                '    </span>\n' +
                '  </div>' +
                '  </div>' +

                '<div class="layui-form-item" style="width: 100%;">\n' +
                '    <label class="layui-form-label" style="width: 30%;">授权角色:</label>\n' +
                '    <span style="float:left;width: 65%;">\n' +
                '                        <textarea  style="float: left;width: 300px;" id="privDuser2" disabled class="layui-textarea"></textarea>\n' +
                '           <div style="margin-top: 84px;">\n'+
                '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                       <a href="javascript:;" id="selectPriv2" class="Add" onclick="selectUser($(this))">添加</a>\n '+
                '                       </span>\n'+
                '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                  <a href="javascript:;" class="clearPriv" onclick="reset1(2)">清除</a>\n'+
                '    </span>\n' +
                '    </span>\n' +
                '  </div>' +
                '  </div>' +

                '<div class="layui-form-item" style="width: 100%;">\n' +
                '    <label class="layui-form-label" style="width: 30%;">授权用户:</label>\n' +
                '    <span style="float:left;width: 65%;">\n' +
                '                        <textarea  style="float: left;width: 300px;" id="privDuser3" disabled class="layui-textarea"></textarea>\n' +
                '           <div style="margin-top: 84px;">\n'+
                '                        <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                       <a href="javascript:;" id="selectPriv3" class="Add" onclick="selectPeo($(this))">添加</a>\n '+
                '                       </span>\n'+
                '                <span class="add_img" style="margin-left: 10px;float: left">\n'+
                '                  <a href="javascript:;" class="clearPriv"  onclick="reset1(3)">清除</a>\n'+
                '    </span>\n' +
                '    </span>\n' +
                '  </div>' +
                '  </div>' +
                '</div></form>',
            success: function () {
                $.ajax({
                    url:'/gtable/selectGtableByTypeId',
                    data:{typeId: typeId},
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        var $select = $("#application");
                        var str = '';
                        for(var i=0;i<res.obj.length;i++){
                            str += '<option  value=' + res.obj[i].tabId + '>' + res.obj[i].tabName + '</option>';
                        }
                        $select.html(str);
                         layui.form.render();
                    }
                })
                layui.form.render();
            },
            yes:function(){
                var tabButtonPrivs =''
                var listButtonPrivs =''
                if($("#butFormTemp").prop("checked")){
                    tabButtonPrivs += "BUT_FORM_TEMP"+","
                }
                if($("#butFormSave").prop("checked")){
                    tabButtonPrivs += "BUT_FORM_SAVE"+","
                }
                if($("#butFormEdit").prop("checked")){
                    tabButtonPrivs += "BUT_FORM_EDIT"+","
                }
                if($("#butFormSubmit").prop("checked")){
                    tabButtonPrivs += "BUT_FORM_SUBMIT"+","
                }
                if($("#butFormDel").prop("checked")){
                    tabButtonPrivs += "BUT_FORM_DEL"+","
                }

                if($("#butListAdd").prop("checked")){
                    listButtonPrivs += "BUT_LIST_ADD"+","
                }
                if($("#butListIn").prop("checked")){
                    listButtonPrivs += "BUT_LIST_IN"+","
                }
                if($("#butListOut").prop("checked")){
                    listButtonPrivs += "BUT_LIST_OUT"+","
                }
                if($("#butListDel").prop("checked")){
                    listButtonPrivs += "BUT_LIST_DEL"+","
                }
               var seltSpplication= $('select[name="application"]').next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
                if($('input[name="createUserId"][title="是"]').prop("checked") == true){
                    var createUserIds =1
                }else if($('input[name="createUserId"][title="否"]').prop("checked") == true){
                    var createUserIds =0
                }
                if($('input[name="allUsers"][title="是"]').prop("checked") == true){
                    var allUserss =1
                }else if($('input[name="allUsers"][title="否"]').prop("checked") == true){
                    var allUserss =0
                }
                if($('input[name="ownerUserId"][title="是"]').prop("checked") == true){
                    var ownerUserIds =1
                }else if($('input[name="ownerUserId"][title="否"]').prop("checked") == true){
                    var ownerUserIds =0
                }

                if($('input[name="ownerDeptId"][title="是"]').prop("checked") == true){
                    var ownerDeptIds =1
                }else if($('input[name="ownerDeptId"][title="否"]').prop("checked") == true){
                    var ownerDeptIds =0
                }
                $.ajax({
                    url:'/gtablePriv/addGtablePrivDate',
                    type:'post',
                    data:{
                        tabId: seltSpplication,
                        tabButtonPriv:tabButtonPrivs,
                        listButtonPriv:listButtonPrivs,
                        createUserId:createUserIds,
                        allUsers:allUserss,
                        ownerUserId:ownerUserIds,
                        ownerDeptId:ownerDeptIds,
                        deptIdRpivs:$("#deptInputId").attr("deptid"),//部门
                        rpivIdRpivs:$("#privDuser2").attr("userpriv"),//角色
                        userIdRpivs:$("#privDuser3").attr("user_id"),//用户
                        typeId:typeId
                    },
                    dataType:'json',
                    success:function(res){
                        if(res.flag){
                            layer.msg(res.msg)
                            layer.closeAll();
                            meetTable.reload();
                        }

                    }
                })
            }
        })
    })
</script>
</html>
