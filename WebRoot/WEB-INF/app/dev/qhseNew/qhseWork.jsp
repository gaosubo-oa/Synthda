<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <title>QHSE工作</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">--%>
    <%--<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>--%>
    <link rel="stylesheet" type="text/css" href="../../css/workflow/work/style.css" />
    <link rel="stylesheet" type="text/css" href="../../css/workflow/work/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/workflow/work/newwork.css" />
    <link rel="stylesheet" type="text/css" href="../../css/workflow/work/new.css">
    <link rel="stylesheet" type="text/css" href="../../css/main/theme1/index.css?20201106.1"/>

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js?20220415.1"></script>
    <style>
        .tab_c{
            background: #f5f5f5;
            border-right: 2px solid #e9f0f5;
        }
        .tab_cone{
            color: #111!important;
        }
        .one_all{
            border: none;
            border-bottom: none;
            background: #f5f7f8 ;
            border-top: 2px solid #fff!important;
        }
        .one_logo {
            margin-left: 0;
            margin-top: 0;
            float: none;
        }
        .tab_cone .one:nth-child(1) {
            border-top: none;
        }
        .cover_scroll{
            position: absolute;
            top: 0;
            right: 1px;
            height: 100%;
            width: 25px;
            z-index: 1;
            background-color: #F7F7F7;
        }
        .content1 li{
            height: 85px;
            border: 1px solid #999;
            margin-bottom: 20px;
            width: 99%;

        }
        .content2 li{
            height: 85px;
            border: 1px solid #999;
            margin-bottom: 20px;
            width: 99%;

        }
        .conImg{
            margin-top: 4px;
            float: left;
        }

        .conh11{
            font-size: 15pt;
            font-weight: normal;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-left: 12px;
            line-height: 35px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>

<script>
    if(window.external && typeof window.external.OA_SMS != 'undefined') //如果从OA精灵打开，则最大化窗口
    {
        var h = Math.min(800, screen.availHeight - 180);
        var w = Math.min(1280, screen.availWidth - 80);
        window.external.OA_SMS(w, h, "SET_SIZE");
    }
    var openRold=parent.opensload;
</script>
<style type="text/css">
    #flow_sort_nav > a{
        text-decoration:none;
        color:#666666;
        font-size: 18px;
        font-weight:bold;
    }
    #flow_sort_nav > a:hover {
        text-decoration: none;
        color: #589Fff;
        font-weight: bold;
    }
</style>
<style type="text/css">
    .container-fluid{
        width: 100%;
        height:100%;
        overflow:hidden;
    }
    .cont_left{
        background: none !important;
        border-right: none;
    }
    .all_ul{
        width: 100% !important;
        height: 100%;
        margin-left: 0% !important;
        background: #fff;
    }
    .tab_c{
        margin-left: 0% !important;
    }
    .one_all{
        height: 40px !important;
        width: 100% !important;
        border-left: none !important;
        border-right: none !important;
    }
    .one_name{
        margin-left: 5px;
        width: 77%;
        line-height: 35px !important;
        text-align: left;
        color: #333;
        padding-left: 10px;
        text-overflow: inherit;
    }
    .one_name img{
        margin-left: 2px;
    }
    .down_jiao{
        margin-left: 0;
        position: absolute;
        right: 5px;
        margin-top: 15px;
        width: 12px;
        height: 7px;
    }
    .two_all{
        width: 100%;
    }
    #title{
        padding-left: 20px;
    }

    .two_all h1{
        width: 66%;
        margin-left: 0;
        color: #111;
        text-shadow: none;
        padding-left: 55px;
    }

    .cont_left{
        width:15%;
    }
    .cont_rig{
        width:85%;
    }
    .rig_all{
        width:96%;
        height:95%;
        margin:auto;
        overflow-y: scroll;
    }
    .rig_cont ul li{
        /*width: 99%;*/
        /*!*height: 80px;*!*/
        /*border: 1px solid #cccccc;*/
        /*border-radius: 2px;*/
        /*background: #f9fbff;*/
        /*margin-top: 10px;*/
    }
    #sort_cont>li{
        width: 99%;
        height: 80px;
        border: 1px solid #cccccc;
        border-radius: 2px;
        background: #f9fbff;
        margin-top: 10px;
    }
    .rig_cont{
        /*overflow-y: scroll;*/
        height: 94%;

    }
    .rig_title img,.rig_title h1{
        float:left;
        margin-top:5px;
    }
    .rig_title img{
        margin-top:10px;
    }
    .rig_title h1{
        font-size: 15pt;
        font-weight: normal;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        margin-left: 12px;
        line-height: 35px;
        margin-top: 9px;
    }
    .rig_left,.rig_mid,.rig_rig{
        float: left;
        height: 100%;
    }
    .rig_left,.rig_rig{
        width:29%;
    }
    .rig_mid{
        width:40%;
    }
    .liucheng,.liucheng1,.liucheng2{
        height:100%;
        float: left;
        margin-right:7%;
    }
    .liucheng img,.liucheng h1,.liucheng1 img,.liucheng1 h1,.liucheng2 img,.liucheng2 h1{
        float:left;
    }
    .rig_rig div{
        width: 33%;
        float: left;
        margin-top: 14px;
    }
    .xinjian_img{
        margin-left: 39%;
        cursor: pointer;
    }
    .xinjian_h1{
        width: 100%;
        height: 20px;
        text-align: center;
    }
    .rig_left h1{
        font-size: 13pt;
        font-weight: bold;
        margin-left: 12px;
        margin-top: 17px;
        width: 90%;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .rig_left h1:hover{
        color: #2b7fe0;
    }
    .rig_left h2{
        margin-left: 12px;
        color: #b7b8b9;
        margin-top: 5px;
        width:90%;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .liucheng h1,.liucheng1 h1,.liucheng2 h1{
        line-height: 80px;
        margin-left: 5px;
    }
    .liucheng img,.liucheng1 img,.liucheng2 img{
        margin-top: 31px;
    }
    .new_work{
        font-size: 22px;
        margin-top: 9px;
    }
    .new-search{
        margin-top:8px !important;
    }
    .one_all{
        background: #f0f4f7 ;
        position: relative;
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
    .tab_cone{
        width: 100% !important;
        height:99% !important;
    }
    .er_img {
        margin-left: 0;
        position: absolute;
        right: 15px;
        margin-top: 15px;
        width: 12px;
        height: 7px;
    }
    #searchbtn,.rig_mid h1,.rig_rig h1{
        cursor: pointer;
    }
    .namenew{
        cursor: pointer;
    }
    /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
    .rig_cont::-webkit-scrollbar{
        width: 0px;
        height: 16px;
        background-color: #f5f5f5;
    }
    /*定义滚动条的轨道，内阴影及圆角*/
    .rig_cont::-webkit-scrollbar-track{
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        border-radius: 10px;
        background-color: #f5f5f5;
    }
    /*定义滑块，内阴影及圆角*/
    .rig_cont::-webkit-scrollbar-thumb{
        /*width: 10px;*/
        height: 20px;
        border-radius: 10px;
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
        background-color: #555;
    }

    #sort_cont li:hover{
        background: #e8f4fc;
    }
    .quick:hover .xinjian_h1{
        color:#2b7fe0;
    }

    .xiangdao:hover h1{
        color:#2b7fe0;
    }
    .displaySctext:hover h1{
        color:#2b7fe0;
    }
    .displaySctext:hover{
        color:#2b7fe0;
        cursor:pointer;
    }
    .xjxd{
        cursor: pointer;
    }
    #form_select{
        height: 28.4px !important;
    }
    /*一级菜单移入移出样式的改变*/
    .one_all li:hover{
        background:#ccebff;
        cursor:pointer;
    }
    .one_all li:hover h1{
        color:#2f8ae3;
    }
    /*二级菜单移入移出样式的改变*/
    /* .two_menu li:hover{
         background:#ccebff;
         cursor:pointer;
     }
     .two_menu li:hover h1{
         color:#2f8ae3;
     }*/
    .two .two_all:hover{
        color:#2f8ae3;
        background:#ccebff !important;
        cursor: pointer;
    }
    .menu_change{
        color:#2f8ae3;
    }
    /*三级菜单移入移出样式的改变*/
    .three:hover{
        color:#2f8ae3;
        background:#ccebff !important;
    }
    .rig_mid h1{
        font-size:16px;
    }
    .rig_mid h1:hover{
        color: #2b7fe0;
    }
    .liucheng img, .liucheng1 img, .liucheng2 img{
        margin-top:35px;
    }
    .sanji_circle{
        display: none;
    }
    .three{
        background: rgb(232, 244, 252);
    }
    .three h1{
        color: #333;
        text-shadow: none;
    }
    .sanji .three:hover{
        background: #ccebff;
    }
    .two{
        background: none!important;
    }

    /*********************左侧滚动条修改******************************/
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
    .one{
        background: #fff!important;
    }
    .toggle{
        width: 80px;
        height: 27px;
        margin-top: 9px;
        margin-left: 20px;
        background: #4d90fe;
        color: white;
        border-radius: 12px;
        border: none;
    }
    .rig_titleAll{
        font-size: 15pt;
        font-weight: normal;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        margin-left: 12px;
        line-height: 35px;
        /*display: flex;*/
        margin-bottom: 10px;
    }
    .rig_titleAll img{
        width: 40px;
        margin-left: -14px;
        padding: 0;
    }
    .shoucang{
        width: 60px !important;
        height: 31px;
        position: relative;
        top: 4px;
        border-radius: 50%;
        text-align: center;
        margin-left: 15px;
    }
    .shoucang .xjxd{
        width: 31px;
        border: 2px solid #999;
        border-radius: 50%;
    }
    .rightCologyUl{
        /*display: flex;*/
        /*flex-wrap: wrap;*/
        /*justify-content: space-between;*/
    }
    .rightCologyUl>li{
        float: left;
        box-shadow: 0 0 5px #999;
        border: 1px solid #cccccc;
    }
    .rightCologyUl li{
        width: 23% !important;
        height: auto;
        margin-bottom: 10px;
        margin-right: 10px;
    }
    .pubuTitle{
        padding: 0;
        background: lightblue;
        width: 100%;
        text-align: center;
        margin: 0;
        color: white;
    }
    .scLiimg,.scLiimg2{
        position: absolute;
        right: -2px;
        width: 23px;
        top: 9px;
    }
    /*奇数*/
    .rightCologyUl .pubuTitle:nth-child(odd){
        background: #0aa3e3;
    }
    .rightCologyUl .pubuTitle:nth-child(even){
        background: cornflowerblue;
    }
</style>
<script type="text/javascript">
    var loading='<div class="loading"><fmt:message code="workflow.th.doing" /></div>';
    var load_error = '<div class="message"><fmt:message code="workflow.th.dataerr" /></div>';
    var quick_flow_tips = '<fmt:message code="workflow.th.alert" />';
</script>
<body>

<input id="cur_user" type="hidden" value="1">
<div class="container-fluid">
    <%--    --%>
    <div class="row-fluid title-row" style="background-color:#f8f8f8;z-index:99;border-bottom:1px solid #999;height:51px;">

        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">全部工作</li>
                <%--<li>常用工作</li>
                <li>我的收藏</li>--%>
            </ul>
            <div class="layui-tab-content" style="">
                <div class="layui-tab-item layui-show">
                    <div id="title" class="date" style="display: none">
                        <img class="title_img" src="/img/commonTheme/${sessionScope.InterfaceModel}/new_work.png"><h3 class="new_work" style="margin-bottom:0px;"><fmt:message code="main.newwork" /> </h3>
                        <%--<button class="toggle">切换视图</button>--%>
                    </div>
                    <div class="cont" id="client">
                        <div class="cont_left">
                            <ul class="all_ul">
                                <div class="tab_c list">

                                    <ul class="tab_cone a yiji" style="background: #fff;">

                                    </ul>
                                </div>
                            </ul>

                        </div>
                        <div class="cont_rig">
                            <div class="rig_all">
                                <div class="rig_titleAll">
                                    <div class="rig_title">
                                        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/ofen_workss.png" alt="">
                                        <h1 class="title_name" style="color:rgb(18,141,255)">全部工作</h1>
                                    </div>
                                </div>
                                <div class="rig_cont" style="">
                                    <ul id="sort_cont" style="height: 100%;display: none;">

                                    </ul>

                                    <%--        泛微展示效果--%>
                                    <div class="rightCology" style="height: 100%">
                                        <ul class="rightCologyUl" style="height: 90%;position: relative;margin-bottom: 5%">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-tab-item content1" style="height: 90vh;overflow-y: auto">
                </div>
                <div class="layui-tab-item content2" style="height: 90vh;overflow-y: auto">

                </div>
            </div>
        </div>
        <%--        查询--%>
        <div class="abs-right" style="position:fixed;">
            <div class="search_area form-search">
                <div class="input-append new-search">
                    <%--<input type="text" class="search-query" id="form_select" name="form_select" placeholder="<fmt:message code="workflow.th.flowname" />">--%>
                    <input type="text" class="search-query" id="form_select" name="form_select" placeholder="<fmt:message code="workflow.th.flowname" />">
                    <button  class="btn btn-primary" id="searchbtn" >查询结果</button>
                    <div class="btn-group" style="margin-left:8px;display: none;">
                        <a class="btn" style="zoom:1;font-weight:normal;" id="w_list_view" href="javascript:;" onclick=""><span><fmt:message code="workflow.th.view" /></span></a>
                    </div>
                    <div class="btn-group" style="margin-left:-1px;display: none;" >
                        <button class="btn" style="font-weight:normal;" id="w_task_view" onclick="to_old_new_work()" ><span><fmt:message code="workflow.th.listview" /></span></button>
                    </div>
                </div>

            </div>
        </div>


    </div>


</div>

</body>
</html>
<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
<script>

</script>
<script>

    function runWorkListPage() {
        var searchText = $.GetRequest().runName;
        var menu_tid = $.GetRequest().menu_tid;
        if(searchText){
            parent.changeMenuTab(menu_tid);
        }else{
            parent.changeMenuTab(1020);

        }
    }
    $(function () {

        layui.use('element', function() {
            var $ = layui.jquery
                , element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

            element.on('tab(docDemoTabBrief)', function(data){
                // console.log(this); //当前Tab标题所在的原始DOM元素
                // console.log(data.index); //得到当前Tab的所在下标
                // console.log(data.elem); //得到当前的Tab大容器
                if(data.index == 1){
                    $.ajax({
                        url:'../../flow/flowAuthOrSearchCommonWork',
                        type:'get',
                        dataType:'json',
                        data:{
                            type:1
                        },
                        success:function(obj){
                            var data=obj.obj;
                            var str='';
                            renderData(data,1);

                        }
                    })
                }else if(data.index == 0){
                    $('.rightCology').show()
                    $('#sort_cont').hide()
                    init();//调用init()方法
                    $('.title_name').html('全部工作')
                } else {
                    $.ajax({
                        url:'/workflow/work/getFlowFavorites',
                        type:'get',
                        dataType:'json',
                        success:function(obj){
                            var data=obj.obj;
                            var str='';
                            renderData(data,2);

                        }
                    })
                }
            });
        })
        var newType = 0;

        function init(){
            var flowByAuthObj;
            var layload = layer.load();
            $.ajax({
                url:'/coesStaffRegister/flowByAuth',
                type:'get',
                dataType:'json',
                async: false,
                success:function(obj){
                    if (obj.flag){
                        var data = obj.datas;
                        flowByAuthObj = data;
                        var str = '';
                        for(var i = 0; i < data.length; i++){
                            var er='';
                            for(var j = 0; j < data[i].childs.length; j++){

                                if(data[i].childs[j].childs.length > 0){
                                    var three = '';
                                    for(var k = 0; k < data[i].childs[j].childs.length; k++){
                                        three += '<li class="three checked" menu_tid=' + data[i].childs[j].childs[k].sortId + ' url=' + data[i].childs[j].childs[k].url + ' title="' + data[i].childs[j].childs[k].sortName + '"><div class="work_sanji"  style="margin-left:18px;"><h1 style="margin-left:50px;"><img style="margin-left: 0;margin-top: 0;vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">' + data[i].childs[j].childs[k].sortName + '</h1></div></li>' ;
                                    }
                                    er += '<li class="two"  ><div style="position: relative" menu_tid='+data[i].childs[j].sortId+'  class="two_all click_erji  checked"  title="'+data[i].childs[j].sortName+'"><h1 style="width: 53%;"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">' + data[i].childs[j].sortName + '</h1><img class="er_img" src="../../img/workflow/work/add_work/icon-03.png"></div><ul class="sanji" style="display:none;">' + three + '</ul></li>';

                                }else{
                                    er += '<li class="two" ><div menu_tid='+data[i].childs[j].sortId+' class="two_all  checked" title="'+data[i].childs[j].sortName+'"><h1 class="erji_h1"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].sortName+'</h1></div></li>';
                                }
                            }
                            if(data[i].childs==''){
                                str+='<li class="one person">' +
                                    '<div class="one_all checked" title="'+data[i].sortName+'" ' +
                                    'menu_tid='+data[i].sortId+'>' +
                                    '<h1 class="one_name" style="width: 88%;">' +
                                    '<img style="vertical-align: text-bottom;\
                        margin-right: 2px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/gongzuo.png" />'+data[i].sortName+'</h1>' +
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
                                    'title="'+data[i].sortName+'" ' +
                                    'menu_tid='+data[i].sortId+'>' +
                                    '<h1 class="one_name" ' +
                                    'id="administ"><img style="vertical-align: text-bottom;\
                        margin-right: 2px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/gongzuo.png" />'+data[i].sortName+'</h1>' +
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
                        </li>\
                        <li class="one person ulNone" style="border-bottom: 1px solid #2f8ae3;">\
                        <div class="checked one_alltwo " data-type="1">\
                        <h1 class="one_name" style="width: 88%;"><img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-01.png">\
                       <fmt:message code="workflow.th.New" /></h1>\
                        </div>\
                        </li>';
                        // console.log("stt+str");
                        // console.log(stt+str);
                        console.log(str);

                        $(".tab_cone").html(stt+str);//这一步给左边赋值

                        //点击一级菜单。显示二级
                        $('.one_all').on('click',function () {
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
//                            $(this).find('h1').css({
//                                'color':'#2f8ae3'
//                               /* 'cursor':'pointer'*/
//                            });
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

                    }
                }
            });


            var data = flowByAuthObj;
            var str2 = '';
            var str3 = '';
            if (data != null && data != undefined ){
                console.log(data);
                for(var i = 0; i<data.length; i++) {
                    var er2='';
                    var dadaer = data[i].flowTypes;
                    if(dadaer.length>0){
                        for(var a=0;a<dadaer.length;a++){
                            var displaySca1 = ''
                            var displaySc21 = ''
                            if(dadaer[a].flowFavorites == 1){
                                displaySca1 = 'none'
                                displaySc21 = 'block'
                            }else {
                                displaySc1 = 'block'
                                displaySc21 = 'none'
                            }
                            er2+='<li class="scImg"   style="cursor:pointer;    margin: 0;    width: 100% !important;padding: 8px 0;position:relative;" flowTypes="'+dadaer[a].flowFavorites+'" flowId='+dadaer[a].flowId+' relationid="'+dadaer[a].relationid+'"  newType ="'+dadaer[a].newType+'" forcePreSet="'+dadaer[a].forcePreSet+'" freepreset="'+dadaer[a].freePreset+'" >' +
                                '<span style="padding-left: 10px;display:inline-block;width: 90%">'+dadaer[a].flowName+'</span>' +
                                '<span title="收藏" flowId="'+dadaer[a].flowId+'" style="display:none;z-index: 999;" alt="" class="scLiimg scLiimg1" onclick="scImgXx($(this))"><svg style="height: 16px;width: 16px" t="1610938186847" class="icon" viewBox="0 0 1067 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3291" width="16" height="16"><path d="M224.484689 1022.862437a33.454805 33.454805 0 0 1-33.454805-39.142772l56.53967-328.530081L10.035941 421.000951a33.454805 33.454805 0 0 1 18.734891-56.873667l328.196083-47.840721L503.50206 18.535302a33.454805 33.454805 0 0 1 59.88465 0l146.869142 298.755255 326.858091 48.175719a33.454805 33.454805 0 0 1 18.734891 56.874668L818.315221 656.527576l56.204672 328.531081a33.454805 33.454805 0 0 1-48.509717 35.127795L535.284874 863.950365 240.208597 1018.84746a33.454805 33.454805 0 0 1-15.723908 4.013977z m310.800185-230.171656a33.454805 33.454805 0 0 1 15.723908 4.013976l249.241545 131.479233-47.506723-279.016371a33.454805 33.454805 0 0 1 9.701943-29.440828l200.731828-197.720845-278.682372-40.815762a33.454805 33.454805 0 0 1-25.091854-18.399893l-124.119275-253.591519L409.157611 362.791291a33.454805 33.454805 0 0 1-25.090854 18.399893L105.049387 422.005946l200.731827 197.720845a33.454805 33.454805 0 0 1 9.701944 29.439828l-47.840721 279.018371 249.241544-131.479233a33.454805 33.454805 0 0 1 18.399893-4.014976z" fill="#8a8a8a" p-id="3292"></path></svg></span>' +
                                '<span title="取消收藏" flowId="'+dadaer[a].flowId+'" class="scLiimg scLiimg2" style="display: '+displaySc21+'" onclick="scImgXx2($(this))"><svg style="height: 16px;width: 16px" t="1610937522302" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2570" width="16" height="16"><path d="M1024.049737 393.508571a36.571429 36.571429 0 0 0-29.257143-24.868571l-311.588571-44.617143L544.232594 42.422857a37.302857 37.302857 0 0 0-64.365714 0l-138.971429 281.6L30.769737 365.714286a36.571429 36.571429 0 0 0-29.257143 24.868571 36.571429 36.571429 0 0 0 9.508572 36.571429l224.548571 219.428571-53.394286 311.588572a36.571429 36.571429 0 0 0 14.628572 35.108571 35.108571 35.108571 0 0 0 21.211428 6.582857 33.645714 33.645714 0 0 0 16.091429-4.388571l277.942857-146.285715 277.942857 146.285715a34.377143 34.377143 0 0 0 37.302857 0 36.571429 36.571429 0 0 0 14.628572-35.108572l-53.394286-309.394285 224.548572-219.428572a36.571429 36.571429 0 0 0 10.971428-38.034286z" p-id="2571" fill="#8a8a8a"></path></svg></span>'+
                                '</li>'
                        }

                    }

                    if(er2 != ''){
                        str2+=
                            '<li class="one person" >' +
                            '<div class="" ' +
                            'title="'+data[i].sortName+'" ' +
                            'menu_tid='+data[i].sortId+'>' +
                            '<h1 class="one_name pubuTitle" id="administ" style="text-align: left;    width: 101%;    margin-left: -1px;height:35px"><span style=" font-weight: bold;   margin-left: 8px;">\
                            <img style="vertical-align: text-bottom;margin-right: 2px;" src="/ui/img/workflow/m/gongzuobai.png" />'+data[i].sortName+'</span></h1>' +
                            '</div>' +
                            '<div class="">' +
                            '<ul class=""  style="width:100%;    background: #f9fbff;">'+er2+'</ul>' +
                            '</div>' +
                            '</li>';
                    }

                    var str3 = '';
                    var childser =  data[i].childs;
                    console.log("childser--------------------");
                    console.log(childser);
                    if(childser.length >0){
                        for(var b= 0;b<childser.length;b++){

                            //二级下的子级
                            var er3 = '';
                            if(childser[b].flowTypes.length>0){
                                for(var c=0;c<childser[b].flowTypes.length;c++){

                                    var displaySca1 = ''
                                    var displaySc21 = ''
                                    if(childser[b].flowTypes[c].flowFavorites == 1){
                                        displaySca1 = 'none'
                                        displaySc21 = 'block'
                                    }else {
                                        displaySc1 = 'block'
                                        displaySc21 = 'none'
                                    }

                                    er3+='<li class="scImg"   style=" cursor:pointer;   margin: 0;    width: 100% !important;padding: 8px 0;position:relative;" flowTypes="'+childser[b].flowTypes[c].flowFavorites+'" flowId="'+childser[b].flowTypes[c].flowId+'" relationid="'+childser[b].flowTypes[c].relationid+'"  newType ="'+childser[b].flowTypes[c].newType+'"  forcePreSet="'+childser[b].flowTypes[c].forcePreSet+'" freepreset="'+childser[b].flowTypes[c].freePreset+'">' +  //onclick="newAdd($(this))
                                        '<span style="padding-left: 24px;display:inline-block;width: 85%">'+childser[b].flowTypes[c].flowName+'</span>' +
                                        // '<img flowId='+dadaer[a].flowId+' src="../../img/workflow/work/add_work/shoucang.png" style="display: none;z-index: 999" alt="" class="scLiimg scLiimg1" onclick="scImgXx($(this))">' +
                                        '<span title="收藏" flowId="'+childser[b].flowTypes[c].flowId+'" style="display: none;z-index:999" alt="" class="scLiimg scLiimg1" onclick="scImgXx($(this))"><svg style="height: 16px;width: 16px" t="1610938186847" class="icon" viewBox="0 0 1067 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3291" width="16" height="16"><path d="M224.484689 1022.862437a33.454805 33.454805 0 0 1-33.454805-39.142772l56.53967-328.530081L10.035941 421.000951a33.454805 33.454805 0 0 1 18.734891-56.873667l328.196083-47.840721L503.50206 18.535302a33.454805 33.454805 0 0 1 59.88465 0l146.869142 298.755255 326.858091 48.175719a33.454805 33.454805 0 0 1 18.734891 56.874668L818.315221 656.527576l56.204672 328.531081a33.454805 33.454805 0 0 1-48.509717 35.127795L535.284874 863.950365 240.208597 1018.84746a33.454805 33.454805 0 0 1-15.723908 4.013977z m310.800185-230.171656a33.454805 33.454805 0 0 1 15.723908 4.013976l249.241545 131.479233-47.506723-279.016371a33.454805 33.454805 0 0 1 9.701943-29.440828l200.731828-197.720845-278.682372-40.815762a33.454805 33.454805 0 0 1-25.091854-18.399893l-124.119275-253.591519L409.157611 362.791291a33.454805 33.454805 0 0 1-25.090854 18.399893L105.049387 422.005946l200.731827 197.720845a33.454805 33.454805 0 0 1 9.701944 29.439828l-47.840721 279.018371 249.241544-131.479233a33.454805 33.454805 0 0 1 18.399893-4.014976z" fill="#8a8a8a" p-id="3292"></path></svg></span>' +
                                        '<span title="取消收藏" flowId="'+childser[b].flowTypes[c].flowId+'" class="scLiimg scLiimg2" style="display: '+displaySc21+'" onclick="scImgXx2($(this))"><svg style="height: 16px;width: 16px" t="1610937522302" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2570" width="16" height="16"><path d="M1024.049737 393.508571a36.571429 36.571429 0 0 0-29.257143-24.868571l-311.588571-44.617143L544.232594 42.422857a37.302857 37.302857 0 0 0-64.365714 0l-138.971429 281.6L30.769737 365.714286a36.571429 36.571429 0 0 0-29.257143 24.868571 36.571429 36.571429 0 0 0 9.508572 36.571429l224.548571 219.428571-53.394286 311.588572a36.571429 36.571429 0 0 0 14.628572 35.108571 35.108571 35.108571 0 0 0 21.211428 6.582857 33.645714 33.645714 0 0 0 16.091429-4.388571l277.942857-146.285715 277.942857 146.285715a34.377143 34.377143 0 0 0 37.302857 0 36.571429 36.571429 0 0 0 14.628572-35.108572l-53.394286-309.394285 224.548572-219.428572a36.571429 36.571429 0 0 0 10.971428-38.034286z" p-id="2571" fill="#8a8a8a"></path></svg></span>'+
                                        '</li>'
                                }

                            }

                            if(er3 != ""){
                                str2+=
                                    '<li class="one person" >' +
                                    '<div class="" ' +
                                    'title="'+childser[b].sortName+'" ' +
                                    'menu_tid='+childser[b].sortId+'>' +
                                    '<h1 class="one_name pubuTitle" id="administ" style="text-align: left;    width: 101%;    margin-left: -1px;height:35px"><span style=" font-weight: bold;   margin-left: 8px;">\
                                    <img style="vertical-align: text-bottom;margin-right: 2px;" src="/ui/img/workflow/m/gongzuobai.png" />'+childser[b].sortName+'</span></h1>' +
                                    '</div>' +
                                    '<div class="">' +
                                    '<ul class=""  style="width:100%;    background: #f9fbff;">'+er3+'</ul>' +
                                    '</div>' +
                                    '</li>';
                            }






                            //三级
                            var str4 = '';
                            var childser3 =  childser[b].childs;
                            if(childser3.length >0){
                                for(var d= 0;d<childser3.length;d++){
                                    //三级下的子级
                                    var er4 = '';
                                    if(childser3[d].flowTypes.length>0){
                                        for(var e=0;e<childser3[d].flowTypes.length;e++){

                                            var displaySca1 = '';
                                            var displaySc21 = '';
                                            if(childser3[d].flowTypes[e].flowFavorites == 1){
                                                displaySca1 = 'none'
                                                displaySc21 = 'block'
                                            }else {
                                                displaySc1 = 'block'
                                                displaySc21 = 'none'
                                            }

                                            er4+='<li class="scImg"   style=" cursor:pointer;   margin: 0;    width: 100% !important;padding: 8px 0;position:relative;" flowTypes="'+childser3[d].flowTypes[e].flowFavorites+'" flowId='+childser3[d].flowTypes[e].flowId+' relationid="'+childser3[d].flowTypes[e].relationid+'"  newType ="'+childser3[d].flowTypes[e].newType+'"  forcePreSet="'+childser3[d].flowTypes[e].forcePreSet+'" freepreset="'+childser3[d].flowTypes[e].freePreset+'">' +  //onclick="newAdd($(this))
                                                '<span style="padding-left: 38px;display:inline-block;width: 85%">'+childser3[d].flowTypes[e].flowName+'</span>' +
                                                // '<img flowId='+dadaer[a].flowId+' src="../../img/workflow/work/add_work/shoucang.png" style="display: none;z-index: 999" alt="" class="scLiimg scLiimg1" onclick="scImgXx($(this))">' +
                                                '<span title="收藏" flowId="'+childser3[d].flowTypes[e].flowId+'" style="display: none;z-index:999" alt="" class="scLiimg scLiimg1" onclick="scImgXx($(this))"><svg style="height: 16px;width: 16px" t="1610938186847" class="icon" viewBox="0 0 1067 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3291" width="16" height="16"><path d="M224.484689 1022.862437a33.454805 33.454805 0 0 1-33.454805-39.142772l56.53967-328.530081L10.035941 421.000951a33.454805 33.454805 0 0 1 18.734891-56.873667l328.196083-47.840721L503.50206 18.535302a33.454805 33.454805 0 0 1 59.88465 0l146.869142 298.755255 326.858091 48.175719a33.454805 33.454805 0 0 1 18.734891 56.874668L818.315221 656.527576l56.204672 328.531081a33.454805 33.454805 0 0 1-48.509717 35.127795L535.284874 863.950365 240.208597 1018.84746a33.454805 33.454805 0 0 1-15.723908 4.013977z m310.800185-230.171656a33.454805 33.454805 0 0 1 15.723908 4.013976l249.241545 131.479233-47.506723-279.016371a33.454805 33.454805 0 0 1 9.701943-29.440828l200.731828-197.720845-278.682372-40.815762a33.454805 33.454805 0 0 1-25.091854-18.399893l-124.119275-253.591519L409.157611 362.791291a33.454805 33.454805 0 0 1-25.090854 18.399893L105.049387 422.005946l200.731827 197.720845a33.454805 33.454805 0 0 1 9.701944 29.439828l-47.840721 279.018371 249.241544-131.479233a33.454805 33.454805 0 0 1 18.399893-4.014976z" fill="#8a8a8a" p-id="3292"></path></svg></span>' +
                                                '<span title="取消收藏" flowId="'+childser3[d].flowTypes[e].flowId+'" class="scLiimg scLiimg2" style="display: '+displaySc21+'" onclick="scImgXx2($(this))"><svg style="height: 16px;width: 16px" t="1610937522302" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2570" width="16" height="16"><path d="M1024.049737 393.508571a36.571429 36.571429 0 0 0-29.257143-24.868571l-311.588571-44.617143L544.232594 42.422857a37.302857 37.302857 0 0 0-64.365714 0l-138.971429 281.6L30.769737 365.714286a36.571429 36.571429 0 0 0-29.257143 24.868571 36.571429 36.571429 0 0 0 9.508572 36.571429l224.548571 219.428571-53.394286 311.588572a36.571429 36.571429 0 0 0 14.628572 35.108571 35.108571 35.108571 0 0 0 21.211428 6.582857 33.645714 33.645714 0 0 0 16.091429-4.388571l277.942857-146.285715 277.942857 146.285715a34.377143 34.377143 0 0 0 37.302857 0 36.571429 36.571429 0 0 0 14.628572-35.108572l-53.394286-309.394285 224.548572-219.428572a36.571429 36.571429 0 0 0 10.971428-38.034286z" p-id="2571" fill="#8a8a8a"></path></svg></span>'+
                                                '</li>'
                                        }

                                    }

                                    if (er4 != ''){
                                        str2+='<li class="one person" >' +
                                            '<div class="" ' +
                                            'title="'+childser3[d].sortName+'" ' +
                                            'menu_tid='+childser3[d].sortId+'>' +
                                            '<h1 class="one_name pubuTitle" id="administ" style="text-align: left;    width: 101%;    margin-left: -1px;height:35px"><span style=" font-weight: bold;   margin-left: 8px;">\
                                            <img style="vertical-align: text-bottom;margin-right: 2px;" src="/ui/img/workflow/m/gongzuobai.png" />'+childser3[d].sortName+'</span></h1>' +
                                            '</div>' +
                                            '<div class="">' +
                                            '<ul class=""  style="width:100%;    background: #f9fbff;">'+er4+'</ul>' +
                                            '</div>' +
                                            '</li>';
                                    }



                                    // //三级
                                    // str4 +='<li class="er3" style="width: 100% !important;background:#F2F2F2;margin-bottom: 0;"><span style="font-size: 45px;vertical-align: text-bottom;margin-right: 12px;margin-left:5%;position: relative;top: -14px;left:8px;color: #999;">.</span>'+
                                    //     '<span sstyle="display: inline-block;height: 30px;line-height: 30px;">'+childser3[d].sortName+'</span>'+
                                    //     '<ul clas=""  style="width:100%;    background: #f9fbff;">'+er4+'</ul>' +
                                    //     '</li>'
                                }
                            }

                            // console.log("er3-------------------------");
                            // console.log(er3);
                            // console.log("str4-----------------------");
                            // console.log(str4);

                            //             //二级
                            //             str3 +='<li class="er3" style="width: 100% !important;background:#e9e8e9;margin-bottom: 0;"><img style="vertical-align: text-bottom;\
                            // margin-right: 5px;margin-left:5%;position: relative;top: -7px" src="/img/commonTheme/theme6/icon-05.png" />'+
                            //                 '<span style="display: inline-block;height: 30px;line-height: 30px;">'+childser[b].sortName+'</span>'+
                            //                 '<ul class=""  style="width:100%;    background: #f9fbff;">'+str4+'</ul>' +
                            //                 '</li>'


                        }
                    }



                }

            }
            // console.log("str2-------------");
            // console.log(str2);
            $('.rightCologyUl').html(str2)
            $('.rightCologyUl').find('.ulNone').css('display','none')
            $('#sort_cont').css('margin-bottom','0%')

            imgBox()
            $(".scImg").mouseover(function() {
                if($(this).attr('flowTypes') == '1'){
                    $(this).find('.scLiimg1').css('display','none')
                    $(this).find('.scLiimg2').css('display','block')
                    // $(this).find('.scLiimg2').attr('display','取消收藏')
                }else {
                    $(this).find('.scLiimg2').css('display','none')
                    $(this).find('.scLiimg1').css('display','block')
                    // $(this).find('.scLiimg1').attr('display','收藏')
                }

                $(this).css('background','#e8e8e8')
            });

            $(".scImg").mouseleave(function() {
                if($(this).attr('flowTypes') == '1'){
                    $(this).find('.scLiimg1').css('display','none')
                    $(this).find('.scLiimg2').css('display','block')
                    $(this).css('background','none')
                }else {
                    $(this).find('.scLiimg').css('display','none')
                    $(this).css('background','none')
                }

            });
            layer.close(layload);

        }//init方法结束













        function imgBox() {
            var $boxs = $( ".rightCologyUl>li" );
            var $er3 = $(".er3")
            var $boxTitle = $( ".rightCologyUl .pubuTitle" );
            // 一个块框的宽
            var w = $boxs.eq( 0).width();

            //每行中能容纳的展示框个数【窗口宽度除以一个块框宽度】
            var cols = Math.floor( ($( window ).width()-300) / w );
            //li背景颜色
            //给最外围的main元素设置宽度和外边距
            $('#main').width(w*cols).css('margin','o auto');

            //用于存储 每列中的所有块框相加的高度。
            var hArr=[];
            var lLen = $boxs.length
            // var liC = ["#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)","#60b9e3","#95c59b","#e0887a","rgb(240, 222, 136)","#e49dab","rgb(238, 154, 73)"]
            var liC = ["#039AEB","#6DB944","#963991","#F38020","#DA353C","#FBB826","#039AEB","#6DB944"]

            for(var j=0;j<lLen;j++){
                var liColor=liC[j%liC.length];
                $boxTitle.eq(j).css('background-color',liColor);
            }



            $boxs.each( function( index, value ){
                var h = $boxs.eq( index).height();
                // $boxs.eq( index).css('border-top','7px solid '+getRandomColor()+'');

                // $boxTitle.eq( index).css('background',getRandomColor());
                if( index < cols ){
                    hArr[ index ] = h; //第一行中的num个块框 先添加进数组HArr
                }else{
                    var minH = Math.min.apply( null, hArr );//数组HArr中的最小值minH
                    var minHIndex = $.inArray( minH, hArr );

                    minH = minH+10
                    $( value).css({
                        'position':'absolute',
                        'top':minH+'px',
                        // 'left':minHIndex*w + 'px'
                        left:$boxs.eq(minHIndex).position().left
                    });
                    //数组 最小高元素的高 + 添加上的展示框[i]块框高
                    hArr[ minHIndex ] += $boxs.eq(index).height()+10;//更新添加了块框后的列高
                }
            });
        }
        //随机颜色
        function getRandomColor(){
            // var rgb='rgb('+Math.floor(Math.random()*255)+','
            //     +Math.floor(Math.random()*255)+','
            //     +Math.floor(Math.random()*255)+')';
            // var arr = ["#e49dab","#95c59b","#60b9e3","#a3a5cc","#e0887a","#8999ca","#cd99bf","#e7a89f"]
            var arr = ["#039AEB","#6DB944","#963991","#F38020","#DA353C","#039AEB","#6DB944"]
            var rgb = arr[Math.round(Math.random()*6)+1]
            return rgb;
        }
        window.scImgXx = function(scImg){
            var scImgXx = scImg
            var scFlowId = $(scImgXx).attr('flowId')
            $.ajax({
                url: '/workflow/work/addFlowFavorites',
                type: 'get',
                dataType: 'json',
                data:{
                    flowId:scFlowId,
                    flag:1
                },
                success: function (obj) {
                    $(scImgXx).css('z-index','0')
                    $(scImgXx).css('display','none')
                    $(scImgXx).parent().attr('flowTypes','1')
                    $(scImgXx).next().css('display','block')
                    $(scImgXx).next().css('z-index','999')
                    $(scImgXx).parents('li').find('.displaySctext').html('取消收藏')
                }
            })
            window.event? window.event.cancelBubble = true : e.stopPropagation();
        }
        window.scImgXx2 = function(scImg,acnum){
            var scImgXx = scImg
            var scFlowId = $(scImgXx).attr('flowId')
            $.ajax({
                url: '/workflow/work/addFlowFavorites',
                type: 'get',
                dataType: 'json',
                data:{
                    flowId:scFlowId,
                    flag:0
                },
                success: function (obj) {
                    $(scImgXx).css('z-index','0')
                    $(scImgXx).css('display','none')
                    $(scImgXx).parent().attr('flowTypes','0')
                    $(scImgXx).prev().css('display','block')
                    $(scImgXx).prev().css('z-index','999')
                    $(scImgXx).parents('li').find('.displaySctext').html('收藏')
                    if(acnum == 1){
                        // $(".content2").load(location.href + " .content2")
                        $.ajax({
                            url:'/workflow/work/getFlowFavorites',
                            type:'get',
                            dataType:'json',
                            success:function(obj){
                                var data=obj.obj;
                                var str='';
                                renderData(data,2);

                            }
                        })
                    }


                }
            })
            window.event? window.event.cancelBubble = true : e.stopPropagation();
        }

        //点击名称快速新建页面
        $(document).on('click','.scImg',function(){
            debugger
            var _this = $(this);
            var forcePreSet = _this.attr('forcePreSet')||'';
            var freepreset = _this.attr('freepreset')||'';
            var tableName = _this.attr('tableName')||'';
            var relationid = _this.attr('relationid')||'';


            if(freepreset == '1'&&(forcePreSet == '2'||forcePreSet == '3'||forcePreSet == '4')){
                if(forcePreSet == '2'){
                    var calc = '此工作要求强制输入前缀，确定进入新建向导？';
                }else if(forcePreSet == '3'){
                    var calc = '此工作要求强制输入后缀，确定进入新建向导？';
                }else if(forcePreSet == '4'){
                    var calc = '此工作要求强制输入前缀和后缀，确定进入新建向导？';
                }
                $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            var flowId=_this.attr('flowId');
                            if(tableName == 'BUDGETTYPE'){
                                $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&tableName=budget&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                            }else{
                                $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                            }

                        }else{
                            $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                        }
                    }
                })
            }else{
                $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            var flowId= _this.attr('flowId');
                            user_id='quick';
                            newWorkFlow(flowId,function (data) {
                                if(relationid != 'undefined' && relationid!=0 ) {
                                    if(data.sortMainType=='BUDGETTYPE'){
                                        $.popWindow("/workapp/work/workformApp?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }else{
                                        $.popWindow("/workapp/work/workformApp?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }
                                }else{
                                    if(data.sortMainType=='BUDGETTYPE'){
                                        $.popWindow("/workflow/work/workform?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }else{
                                        $.popWindow("/workflow/work/workform?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=flowRun&runId='+data.flowRun.runId+'&tabId='+data.flowRun.rid,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }
                                }

                            })

                        }else{
                            $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                        }
                    }
                })
            }


        });
        init();//调用init()方法



        //右侧内容接口对接
        $('.tab_cone').on('click','.checked',function(){

            var sortId=$(this).attr('menu_tid');
            $('.rightCology').css('display','none')
            $('#sort_cont').css('margin-bottom','5%')
            $('#sort_cont').show()
            $('.title_name').html($(this).find('h1').text());
            if($(this).hasClass('commonwork')){
                // $.ajax({
                //     url:'../../flow/flowAuthOrSearchCommonWork',
                //     type:'get',
                //     dataType:'json',
                //     data:{
                //         type:1
                //     },
                //     success:function(obj){
                //         var data=obj.obj;
                //         var str='';
                //         renderData(data);
                //
                //     }
                // })
            }else if($(this).hasClass('allWorkShow')){
                var str='<iframe id="dept-iframe" class="iframes" src="/workflow/work/switchWork" frameborder="0" height="100%" width="100%"></iframe>'
                // '<div class="cover_scroll"></div>'
                console.log(str);
                $('#sort_cont').html(str)
                // console.log(document.body.clientHeight)
                $('#dept-iframe').height(document.body.clientHeight-100)
                //$('#sort_cont').css('position','relative')
            }
            else{


                $.ajax({
                    url:'../../coesStaffRegister/flowAuthOrSearch',
                    type:'get',
                    dataType:'json',
                    data:{
                        sortId:sortId
                    },
                    success:function(obj){
                        var data=obj.obj;
                        var str='';
                        renderData(data);

                    }
                })
            }
        })
        var searchText = $.GetRequest().runName;
        if(searchText){
            $('body').hide()
            searchText = decodeURI(searchText);
            $('#form_select').val(searchText);
            $('.title_name').html('全部工作');
            $('.abs-right').hide();
            $('.yiji').hide();
            $.ajax({
                url:'../../coesStaffRegister/flowAuthOrSearch',
                type:'get',
                dataType:'json',
                data:{
                    searchValue:searchText
                },
                success:function(obj){
                    if(obj.flag){
                        var data=obj.obj;
                        if(data.length == 0){
                            $.layerMsg({content:'没有子流程或未设置新建权限！',icon:6},function(){
                            });
                        };
                        var str='';
                        if(searchText == '南彩镇便民电话转办流程'){
                            $.ajax({
                                url:'../../flow/flowAuthOrSearch',
                                type:'get',
                                dataType:'json',
                                data:{
                                    searchValue:'区工单受理'
                                },
                                async:false,
                                success:function(obj){
                                    data.push(obj.obj[0]);
                                }
                            })
                        }
                        $('.layui-tab-title').hide();
                        $('.cont_left').hide().next().css('width', '100%')
                        $('body').show()
                        renderData(data, 'searchbtn');
                    }else{
                        $('body').show()
                        renderData('');
                    }
                },
                error: function(err){
                    $('body').show()
                }
            })
        }else{
            // $.ajax({
            //     url:'../../flow/flowAuthOrSearchCommonWork',
            //     type:'get',
            //     dataType:'json',
            //     success:function(obj){
            //         var data=obj.obj;
            //         renderData(data);
            //     }
            // })
            $('.rightCology').css('display','block')
        }




        $(document).keyup(function (e) {
            if(e.keyCode==13){
                $('#searchbtn').click()
            }
        })
        //查询按钮接口
        $('#searchbtn').on('click',function(){
            $('.title_name').html('<fmt:message code="workflow.th.allwork" />');
            var text=$(this).siblings('#form_select').val();
            if($('.layui-this').text() == '全部工作'){
                var url = '/coesStaffRegister/flowAuthOrSearch'
            } if($('.layui-this').text() == '常用工作'){
                var url = '/flow/flowAuthOrSearchCommonWork?type=1'
            } if($('.layui-this').text() == '我的收藏'){
                var url = '/workflow/work/getFlowFavorites'
            }
            $.ajax({
                url: url,
                type:'get',
                dataType:'json',
                data:{
                    searchValue:text
                },
                success:function(obj){
                    if(obj.flag){
                        var data=obj.obj;
                        if(data.length == 0){
                            $.layerMsg({content:'没有子流程或未设置新建权限！',icon:6},function(){
                            });
                        };
                        var str='';
                        if($('.layui-this').text() == '全部工作'){
                            renderData(data,'searchbtn');
                        } if($('.layui-this').text() == '常用工作'){
                            renderData(data,'1');
                        } if($('.layui-this').text() == '我的收藏'){
                            renderData(data,'2');
                        }

                    }else{
                        renderData('');
                    }
                }
            })
        });

        //点击名称快速新建页面
        $(document).on('click','.namenew',function(){
            var _this = $(this);
            var forcePreSet = _this.parents('.sort_new').attr('forcePreSet')||'';
            var freepreset = _this.parents('.sort_new').attr('freepreset')||'';
            var tableName = _this.parents('.sort_new').attr('tableName')||'';
            var relationid = _this.parents('.sort_new').attr('relationid')||'';


            if(freepreset == '1'&&(forcePreSet == '2'||forcePreSet == '3'||forcePreSet == '4')){
                if(forcePreSet == '2'){
                    var calc = '此工作要求强制输入前缀，确定进入新建向导？';
                }else if(forcePreSet == '3'){
                    var calc = '此工作要求强制输入后缀，确定进入新建向导？';
                }else if(forcePreSet == '4'){
                    var calc = '此工作要求强制输入前缀和后缀，确定进入新建向导？';
                }
                $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            var flowId=_this.attr('flowId');
                            if(tableName == 'BUDGETTYPE'){
                                $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&tableName=budget&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                            }else{
                                $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                            }

                        }else{
                            $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                        }
                    }
                })
            }else{
                $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            var flowId= _this.attr('flowId');
                            user_id='quick';
                            newWorkFlow(flowId,function (data) {
                                if(relationid != 'undefined' && relationid!=0 ) {
                                    if(data.sortMainType=='BUDGETTYPE'){
                                        $.popWindow("/workapp/work/workformApp?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }else{
                                        $.popWindow("/workapp/work/workformApp?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }
                                }else{
                                    if(data.sortMainType=='BUDGETTYPE'){
                                        $.popWindow("/workflow/work/workform?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }else{
                                        $.popWindow("/workflow/work/workform?flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=flowRun&runId='+data.flowRun.runId+'&tabId='+data.flowRun.rid,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                    }
                                }

                            })

                        }else{
                            $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                        }
                    }
                })
            }


        });



        //点击新建向导
        // $('#sort_cont').on('click','.xiangdao',function(){
        $(document).on('click','.xiangdao',function(){
            var _this = $(this);
            var tableName = _this.parents('.sort_new').attr('tableName')||'';
            $.ajax({
                url:'/userCountPer',
                dataType:'json',
                type:'get',
                success:function(res){
                    if(res.flag){
                        var flowId=_this.attr('flowId');
                        if(tableName == 'BUDGETTYPE'){
                            $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&tableName=budget&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                        }else{
                            $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                        }
                    }else{
                        $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                    }
                }
            })

        })
        //点击流程设计图
        // $('#sort_cont').on('click','.liucheng',function(){
        $(document).on('click','.liucheng',function(){
            var flowId=$(this).attr('flowId');
            window.open('/flowSetting/processDesignToolsT?flowId='+flowId+'&type=0','流程设计器预览','width='+(window.screen.availWidth)+',height='+(window.screen.availHeight)+',top=0,left=0,scrollbars=no,resizable=no');
        })
        //点击流程表单
        // $('#sort_cont').on('click','.liucheng1',function(){
        $(document).on('click','.liucheng1',function(){
            var flowId= $(this).attr('flowId');
            var formId=$(this).parents('.sort_new').attr('formid');
            user_id='quick';
            $.popWindow('/workflow/work/workform1?formId='+formId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
        })
        //点击流程说明
        // $('#sort_cont').on('click','.liucheng2',function(){
        $(document).on('click','.liucheng2',function(){
            var flowId=$(this).parents('.sort_new').attr('tid');
            var formId=$(this).parents('.sort_new').attr('formid');
            var word=$(this).parent().siblings('.rig_left').find('h1').text();
            $.popWindow("/workflow/work/processSpeak?flowId="+flowId+'&formId='+formId,'流程说明-'+word+'','0','0','1150px','700px');
        })

    })
    function renderData(data,num) {

        var str='';
        var displaySc = 'block'
        var displaySc2 = 'none'
        var displaySctext = '';
        if(data != undefined){
            for(var i=0;i<data.length;i++){
                if(data[i].flowFavorites == 1){
                    displaySc = 'none'
                    displaySctext = '取消收藏'
                    displaySc2 = 'block'
                }else {
                    displaySc = 'block'
                    displaySc2 = 'none'
                    displaySctext = '收藏'
                }
                if(num == 2){
                    displaySc = 'none'
                    displaySctext = '取消收藏'
                    displaySc2 = 'block'
                }

                if(data[i].runName){
                    str+='<li class="sort_new" tid='+data[i].flowId+' tableName="'+data[i].sortMainType+'" formId='+data[i].formId+' relationId='+data[i].relationId+'  sortId='+data[i].flowSort+' freePreset="'+ data[i].freePreset +'" forcePreSet="'+ data[i].forcePreSet +'"><div class="rig_left">'+
                        '<h1 flowId='+data[i].flowId+' class="namenew" title="'+data[i].flowName+'">'+data[i].flowName+'</h1><h2 class="runName">'+data[i].runName.replace(/\s/g,'<i style="margin: 0 2px;"></i>')+'</h2></div>'+
                        '<div class="rig_mid">'+
                        '<div class="liucheng" flowId='+data[i].flowId+'><img src="../../img/workflow/work/add_work/sheji.png" alt=""><h1><fmt:message code="newWork.th.ProcessDesign" /></h1></div>'+
                        '<div class="liucheng1" flowId='+data[i].flowId+'><img src="../../img/workflow/work/add_work/liucheng.png" alt=""><h1><fmt:message code="newWork.th.FlowForm" /></h1></div>'+
                        '<div class="liucheng2"><img src="../../img/workflow/work/add_work/speak.png" alt=""><h1><fmt:message code="workflow.th.Processdes" /></h1></div></div>'+
                        '<div class="rig_rig">'+
                        function(){
                            if( data[i].newType == undefined || data[i].newType == '' || ( data[i].newType != undefined && data[i].newType.indexOf('0') > -1 ) ){
                                return '<div class="quick" onclick="quick($(this))" tableName="'+data[i].sortMainType+'" flowId='+data[i].flowId+'><img class="xinjian_img"  src="../../img/workflow/work/add_work/xinjian.png" alt=""><h1 class="xinjian_h1" id="quick_new" ><fmt:message code="newWork.th.QuickBuild" /></h1></div>'
                            }

                            return ""
                        }()+
                        function(){
                            if(data[i].newType==undefined || data[i].newType == '' || ( data[i].newType != undefined && data[i].newType.indexOf('1') > -1 )  ){
                                return '<div class="xiangdao" flowId='+data[i].flowId+' tableName="'+data[i].sortMainType+'" style="text-align: center;"><img src="../../img/workflow/work/add_work/xiangdao.png" style="margin-left: -2%;" alt="" class="xjxd"><h1><fmt:message code="newWork.th.NewWizard" /></h1></div>'+
                                    '<div class="shoucang">' +
                                    '<span onclick="scImgXx($(this))" flowId='+data[i].flowId+' style="    position: absolute;    top: -4px;left: 18px;display:'+displaySc+'" alt="" class="xjxd"><svg style="height: 24px;width: 27px;" t="1610097286731" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2546" width="16" height="16"><path d="M327.728136 804.301276l150.60509-60.966537 33.721009-13.627369 33.721009 13.627369 150.609183 60.914348-4.484128-166.562527-0.907673-32.985252 20.663622-25.711592 96.563266-120.353089L652.842749 411.574776l-30.030967-9.081843-17.825994-25.716708-92.931552-134.033669-92.871177 134.033669-17.825994 25.716708-30.033014 9.081843-155.490354 47.120181 96.566336 120.29476 20.663622 25.711592-0.907673 32.985252L327.728136 804.301276M789.940197 939.129031 512.054235 826.727031 234.17339 939.129031l8.115841-303.886125L62.389956 411.175687l282.879696-85.667102L512.054235 84.869946l166.843936 240.638639 282.711873 85.667102L781.766027 635.243929 789.940197 939.129031 789.940197 939.129031 789.940197 939.129031z" p-id="2547" fill="#bfbfbf"></path></svg></span>' +
                                    '<span  style="    position: absolute;    top: -4px;left: 19px;display:'+displaySc2+'" flowId='+data[i].flowId+' class="scLiimg scLiimg2 xjxd" style="display: none" onclick="scImgXx2($(this),1)"><svg style="height: 24px;width: 20px;" t="1610950611438" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2570" width="16" height="16"><path d="M1024.049737 393.508571a36.571429 36.571429 0 0 0-29.257143-24.868571l-311.588571-44.617143L544.232594 42.422857a37.302857 37.302857 0 0 0-64.365714 0l-138.971429 281.6L30.769737 365.714286a36.571429 36.571429 0 0 0-29.257143 24.868571 36.571429 36.571429 0 0 0 9.508572 36.571429l224.548571 219.428571-53.394286 311.588572a36.571429 36.571429 0 0 0 14.628572 35.108571 35.108571 35.108571 0 0 0 21.211428 6.582857 33.645714 33.645714 0 0 0 16.091429-4.388571l277.942857-146.285715 277.942857 146.285715a34.377143 34.377143 0 0 0 37.302857 0 36.571429 36.571429 0 0 0 14.628572-35.108572l-53.394286-309.394285 224.548572-219.428572a36.571429 36.571429 0 0 0 10.971428-38.034286z" p-id="2571" fill="#707070"></path></svg></span>'+
                                    '<p style="    position: absolute;    bottom: -18px;width: 70px;" class="displaySctext">'+displaySctext+'</p>' +
                                    '</div>'
                            }
                            return "";
                        }()+
                        '</div></li>'
                }else{
                    str+='<li class="sort_new" tid='+data[i].flowId+' tableName="'+data[i].sortMainType+'" formId='+data[i].formId+' relationId='+data[i].relationId+'  sortId='+data[i].flowSort+' freePreset="'+ data[i].freePreset +'" forcePreSet="'+ data[i].forcePreSet +'"><div class="rig_left">'+
                        '<h1 flowId='+data[i].flowId+' class="namenew"  title="'+data[i].flowName+'">'+data[i].flowName+'</h1><h2 class="runName"><fmt:message code="newWork.th.Process" /></h2></div>'+
                        '<div class="rig_mid">'+
                        '<div class="liucheng" flowId='+data[i].flowId+'><img src="../../img/workflow/work/add_work/sheji.png" alt=""><h1><fmt:message code="newWork.th.ProcessDesign" /></h1></div>'+
                        '<div class="liucheng1"><img src="../../img/workflow/work/add_work/liucheng.png" alt=""><h1><fmt:message code="newWork.th.FlowForm" /></h1></div>'+
                        '<div class="liucheng2"><img src="../../img/workflow/work/add_work/speak.png" alt=""><h1><fmt:message code="workflow.th.Processdescription" /></h1></div></div>'+
                        '<div class="rig_rig">'+
                        function(){
                            if( data[i].newType == undefined || data[i].newType == '' ||  (data[i].newType != undefined && data[i].newType.indexOf('0')>-1)   ) {
                                return '<div class="quick" onclick="quick($(this))" tableName="' + data[i].sortMainType + '" flowId=' + data[i].flowId + '><img class="xinjian_img"  src="../../img/workflow/work/add_work/xinjian.png" alt=""><h1 class="xinjian_h1" id="quick_new" ><fmt:message code="newWork.th.QuickBuild" /></h1></div>'
                            }
                            return ""
                        }()+
                        function(){
                            if( data[i].newType == undefined || data[i].newType == '' || (data[i].newType != undefined && data[i].newType.indexOf('1')>-1)  ){
                                return '<div class="xiangdao" flowId='+data[i].flowId+' tableName="'+data[i].sortMainType+'" style="text-align: center;"><img src="../../img/workflow/work/add_work/xiangdao.png" style="margin-left: -2%;" alt="" class="xjxd"><h1><fmt:message code="newWork.th.NewWizard" /></h1></div>'+
                                    '<div class="shoucang">' +
                                    '<span onclick="scImgXx($(this))" flowId='+data[i].flowId+' style="    position: absolute;    top: -4px;left: 18px;display:'+displaySc+'" alt="" class="xjxd"><svg style="height: 24px;width: 27px;" t="1610097286731" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2546" width="16" height="16"><path d="M327.728136 804.301276l150.60509-60.966537 33.721009-13.627369 33.721009 13.627369 150.609183 60.914348-4.484128-166.562527-0.907673-32.985252 20.663622-25.711592 96.563266-120.353089L652.842749 411.574776l-30.030967-9.081843-17.825994-25.716708-92.931552-134.033669-92.871177 134.033669-17.825994 25.716708-30.033014 9.081843-155.490354 47.120181 96.566336 120.29476 20.663622 25.711592-0.907673 32.985252L327.728136 804.301276M789.940197 939.129031 512.054235 826.727031 234.17339 939.129031l8.115841-303.886125L62.389956 411.175687l282.879696-85.667102L512.054235 84.869946l166.843936 240.638639 282.711873 85.667102L781.766027 635.243929 789.940197 939.129031 789.940197 939.129031 789.940197 939.129031z" p-id="2547" fill="#bfbfbf"></path></svg></span>' +
                                    '<span  style="    position: absolute;    top: -4px;left: 19px;display:'+displaySc2+'" flowId='+data[i].flowId+' class="scLiimg scLiimg2 xjxd" style="display: none" onclick="scImgXx2($(this),1)"><svg style="height: 24px;width: 20px;" t="1610950611438" class="icon" viewBox="0 0 1025 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2570" width="16" height="16"><path d="M1024.049737 393.508571a36.571429 36.571429 0 0 0-29.257143-24.868571l-311.588571-44.617143L544.232594 42.422857a37.302857 37.302857 0 0 0-64.365714 0l-138.971429 281.6L30.769737 365.714286a36.571429 36.571429 0 0 0-29.257143 24.868571 36.571429 36.571429 0 0 0 9.508572 36.571429l224.548571 219.428571-53.394286 311.588572a36.571429 36.571429 0 0 0 14.628572 35.108571 35.108571 35.108571 0 0 0 21.211428 6.582857 33.645714 33.645714 0 0 0 16.091429-4.388571l277.942857-146.285715 277.942857 146.285715a34.377143 34.377143 0 0 0 37.302857 0 36.571429 36.571429 0 0 0 14.628572-35.108572l-53.394286-309.394285 224.548572-219.428572a36.571429 36.571429 0 0 0 10.971428-38.034286z" p-id="2571" fill="#707070"></path></svg></span>'+
                                    '<p style="    position: absolute;    bottom: -18px;width: 70px;" class="displaySctext">'+displaySctext+'</p>' +
                                    '</div>'
                            }
                            return "";
                        }()+
                        '</div></li>'
                }
            }
        }
        if(num == 1){
            var str2 = '  <div class=" ">\n' +
                '                        <img class="conImg" src="/img/commonTheme/${sessionScope.InterfaceModel}/ofen_workss.png" alt="">\n' +
                '                        <h1 class="conh11"><fmt:message code="workflow.th.Commonwork" /></h1>\n' +
                '                    </div>'

            if(data == ''){
                var str6 = '<div style="display: flex;flex-direction: column;justify-content: center;align-items: center;">' +
                    '<img src="/img/main_img/shouyekong.png">' +
                    '<p style="margin-top: 10px;">暂无数据</p>' +
                    '</div>'
                $('.content1 ').html(str2+str6)
            }else {
                $('.content1').html(str2+str)
            }

        }
        if(num == 2){
            var str3 = '  <div class=" ">\n' +
                '                        <img class="conImg" src="/img/commonTheme/${sessionScope.InterfaceModel}/ofen_workss.png" alt="">\n' +
                '                        <h1 class="conh11">我的收藏</h1>\n' +
                '                    </div>'
            if(data == ''){
                var str7 = '<div style="display: flex;flex-direction: column;justify-content: center;align-items: center;">' +
                    '<img src="/img/main_img/shouyekong.png">' +
                    '<p style="margin-top: 10px;">暂无数据</p>' +
                    '</div>'
                $('.content2 ').html(str3+str7)
            }else {
                $('.content2').html(str3+str)
            }


        }else {
            $('#sort_cont').html(str);
        }

        if(num == 'searchbtn'){
            $('.rightCology').css('display','none');
            $('#sort_cont').css('display','block');
        }


    }
    //点击出现快速新建页面
    function quick(e){

        //新建
        var _this = e;
        var forcePreSet = _this.parents('.sort_new').attr('forcePreSet')||'';
        var freepreset = _this.parents('.sort_new').attr('freepreset')||'';
        var tableName = _this.parents('.sort_new').attr('tableName')||'';
        //lims产品，修改目的，获取关联应用标记
        var sortid = _this.parents('.sort_new').attr('sortid')||'';
        var relationid = _this.parents('.sort_new').attr('relationid')||'';


        if(freepreset == '1'&&(forcePreSet == '2'||forcePreSet == '3'||forcePreSet == '4')){
            if(forcePreSet == '2'){
                var calc = '<fmt:message code="workflow.th.alertprefix" />';
            }else if(forcePreSet == '3'){
                var calc = '<fmt:message code="workflow.th.alertSuffix" />';
            }else if(forcePreSet == '4'){
                var calc = '<fmt:message code="workflow.th.alertprefixSuffix" />';
            }
            //var r = confirm(calc);
            layer.open({
                title:'<fmt:message code="global.lang.new" />'
                ,content: calc
                ,btn: ['<fmt:message code="menuSSetting.th.menusetsure" />'
                    , '<fmt:message code="depatement.th.quxiao" />']
                ,yes: function(index, layero){
                    //按钮【按钮一】的回调
                    $.ajax({
                        url:'/userCountPer',
                        dataType:'json',
                        type:'get',
                        success:function(res){
                            if(res.flag){
                                var flowId=_this.attr('flowId');
                                if(tableName == 'BUDGETTYPE'){
                                    $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&tableName=budget&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }else{
                                    $.popWindow("/workflow/work/newflowguider?flowId="+flowId+'&flowStep=1&prcsId=1','<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }

                            }else{
                                $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                            }
                        }
                    })
                }
                ,btn2: function(index, layero){
                    //按钮【按钮二】的回调

                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });

        }else{
            $.ajax({
                url:'/userCountPer',
                dataType:'json',
                type:'get',
                success:function(res){
                    if(res.flag){
                        var flowId= _this.attr('flowId');
                        user_id='quick';
                        newWorkFlow(flowId,function (data) {
                            //修改目的，判断是否是关联应用
                            if(relationid != 'undefined' && relationid != 0){
                                if(data.sortMainType=='BUDGETTYPE'){
                                    $.popWindow("/workapp/work/workformApp?opflag=1&flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }else{
                                    $.popWindow("/workapp/work/workformApp?opflag=1&flowId="+flowId+'&type=new&flowStep=1&prcsId=1&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }
                            }else {
                                if(data.sortMainType=='BUDGETTYPE'){
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=budget&runId='+data.flowRun.runId,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }else{
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId="+flowId+'&type=new&flowStep=1&prcsId=1&tableName=flowRun&runId='+data.flowRun.runId+'&tabId='+data.flowRun.rid,'<fmt:message code="newWork.th.Quick" />','0','0','1150px','700px');
                                }
                            }
                        })
                    }else{
                        $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                    }
                }
            })
        }


    };

    function newWorkFlow(flowId,cb){
        $.ajax({
            url:'../../workflow/work/workfastAdd',
            type:'get',
            dataType:'json',
            data:{
                flowId:flowId,
                prcsId : 1,
                flowStep : 1,
                runId:'',
                preView:0
            },
            async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
            success:function(res){
                if(res.flag){
                    var data = res.object;
                    cb(data);
                }
            }
        });
    }
    //点击切换视图
    /*$(document).on('click','.toggle',function () {
        window.location.href='/document/add_workOther'
    })*/
    $(document).on('click','.one_all',function(res){
        $('.one_all').css({"background-color": "rgb(240,244,247)"});
        $('.two_all').css({"background-color": "rgb(232,244,252)"});
        $('.three').css({"background-color": "rgb(232,244,252)"});
        var index = $(this)
        $(index).css({"background-color": "rgb(182,224,255)"});
    })
    $(document).on('click','.two_all',function(res){
        $('.one_all').css({"background-color": "rgb(240,244,247)"});
        $('.two_all').css({"background-color": "rgb(232,244,252)"});
        $('.three').css({"background-color": "rgb(232,244,252)"});
        var index = $(this)
        $(index).css({"background-color": "rgb(182,224,255)"});
    })
    $(document).on('click','.three',function(res){
        $('.one_all').css({"background-color": "rgb(240,244,247)"});
        $('.two_all').css({"background-color": "rgb(232,244,252)"});
        $('.three').css({"background-color": "rgb(232,244,252)"});
        var index = $(this)
        $(index).css({"background-color": "rgb(182,224,255)"});
    })
</script>
<script>
    autodivheight();
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        document.getElementById("client").style.height= winHeight - 45 +"px";
        document.getElementById("client").style.width= winWidth  +"px";

    }
    window.onresize = autodivheight;

    // window.onresize = function(){
    //     window.location.reload()
    // };
</script>
