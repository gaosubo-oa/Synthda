<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(1).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>OA精灵</title>

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
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/index.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../css/spirit/user_online.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ui.dynatree.css">
    <style>
        html, body, body h1, h2, h3, div, span {
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .avatarimg{
            border-radius: 100%;
        }
        #deptOrg li .childdept a{
            font-size: 14px;
            vertical-align: middle;
        }
        #deptOrg2 li .childdept a{
            font-size: 14px;
            vertical-align: middle;
        }

        span.dynatree-checkbox{
            vertical-align: middle;
        }
        /*#modules{*/
        /*margin-left: 0px;*/
        /*}*/
        #deptOrg .childdept{
            display: block;
            line-height: 26px;
        }
        #deptOrg2 .childdept{
            display: block;
            line-height: 26px;
        }
        #deptOrg .childdept:hover{
            background: #abd9fe;
        }
        #deptOrg2 .childdept:hover{
            background: #abd9fe;
        }
        ul.dynatree-container a:hover{
            background: none;
        }
        #modules{
            margin-left: 0px;
            padding:0px;
        }
        ul.dynatree-no-connector > li span.childdept{
            padding-left: 20px;
        }
        .dynatree-checkbox>img{
            width: 20px!important;
            height: 20px!important;
        }
        span.dynatree-checkbox{
            vertical-align: middle;
            width: 20px;
            height: 20px;
        }
        span.dynatree-checkbox.actives{
            vertical-align: middle;
            width: 16px;
            height: 16px;
        }
        span.dynatree-checkbox.actives>img{

            width: 8px!important;
            height: 8px!important;
            margin-top:4px;
        }
        span.dynatree-has-children a{
            font-weight: normal;
        }
        #modules {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Microsoft yahei';
            overflow: hidden;
            float: left;
            clear: both;
            overflow-y: auto;
        }

        .wz {
            background: #d0efc0;
            bottom: 30px;
            border-top: 1px solid #b6d1a8;
            color: #111111;
            width: calc(100% - 30px);
            position: absolute;
            z-index: 1001;
            padding: 0 15px;
            line-height: 30px;
        }
        .moduleContainer{
            overflow-x: hidden;
            overflow-y: auto;
        }
        .people {
            font-weight: 600;
            color: #f03908;
        }
        .wzspan {
            color: #666666;
            float: right;
        }
    </style>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>

    <script type="text/javascript">
        function init() {
            jQuery("#body").height(jQuery(window).height() - jQuery("#sub_tabs").outerHeight());
        }

        window.onresize = init;
    </script>
    <style type="text/css">
        .dynatree-checkbox{
            margin-right:5px;!important;
        }
        #dyna_li:hover{background:#EFEFEF;}
        #dept_li:focus{background:#EFEFEF;}
        .dynatree-title{
            font-weight: normal;
        }
        .ul.dynatree-container ul{
            padding:0!important;
        }
        .tab_ctwo{
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
        .sub_menu{
            position:static;
            width:296px!important;
            background-color: #f8f8f8;

            border:none;
            text-align: right;
        }
        .sub_menu a{
            display: inline-block;
            padding:2px 4px 2px 4px;
            margin:2px 5px;
        }
        .sub_menu a.active{
            background: none;
            color: #368feb;
        }
        .sub_menu a:hover{
            background:#abd9fe;
            border-radius: 4px;
        }
    </style>
</head>


<body onload="init();window.setTimeout(init, 1);" marginwidth="0" marginheight="0">
<%--<div id="sub_tabs" class="sub_tabs">
    <ul id="sub_tabs_ul">
        <li><a href="javascript:;" title="人员" index="1" module="org" class="active"><span
                class="dropdown-containter"><label id="label_org">在线</label><span class="dropdown"></span></span></a>
        </li>
        <li><a href="javascript:;" title="分组" index="2" module="user_group"><span class="dropdown-containter">分组<span
                class="dropdown"></span></span></a></li>
        <li><a href="javascript:;" title="最近联系人" index="3" module="recent"><span>最近</span></a></li>
        <li><a href="javascript:;" title="群组" index="4" module="im_group"><span>群组</span></a></li>
    </ul>
    <a id="org_refresh" href="javascript:;" title="刷新"></a>
</div>--%>
<div id="sub_menu_org" class="sub_menu" style="width: 110px; display:block">
    <a href="javascript:;" index="0" class=""><img src="../img/spirit/circle.png" alt="" style="margin-right:4px;vertical-align: middle;margin-top: -2px;">显示在线人员</a>
    <a href="javascript:;" index="1" class="active"><img src="../img/spirit/circle1.png" alt="" style="margin-right:4px;vertical-align: middle;margin-top: -2px;">显示全部人员</a>
</div>
<div id="sub_menu_user_group" class="sub_menu" style="width:110px;">
    <a href="javascript:;" index="0" class="active">我的自定义组</a>
    <a href="javascript:;" index="1" class="">公共自定义组</a>
</div>
<div id="body" style="width: 296px;height: calc(100% - 40px);position:relative;border-top: 1px solid #e8e8e8;">
    <div id="modules">
        <div id="module_org" class="container moduleContainer" style="display: block;">
            <div class="pickCompany" style="position: fixed;width: 100%;background: #fff;">
                <span style="height:32px;line-height:32px;" class="childdept">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;
                    margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">
                    <a href="javascript:void(0)" class="dynatree-title"
                       title="" style="display: inherit;margin-left: 0;color: #111;font-size: 14px">

                    </a>
                </span>
                <span style="cursor: pointer;position: absolute;width: 18px;height: 16px;top: 5px;left: 260px;" onclick="refresh($(this))"><img src="/img/icon_refresh_10.png" alt=""></span>
            </div>




            <div id="sub_module_org_0" class="module-block sub_module_org_block" style="">
                <ul class="dynatree-container dynatree-no-connector tab_ctwo" id="deptOrg" style="margin-top: 32px;margin-bottom: 30px;">
                </ul>
            </div>
            <div id="sub_module_org_1" class="module-block sub_module_org_block" style="display:none;">
                <ul class="dynatree-container dynatree-no-connector tab_ctwo" id="deptOrg2" style="margin-top: 32px;margin-bottom: 30px;"></ul>
            </div>
        </div>
        <div id="module_user_group" class="container module-block" style="display:none;"></div>
        <div id="module_recent" class="container module-block" style="display:none;"></div>
        <div id="module_im_group" class="container module-block" style="display:none;"></div>
    </div>
    <div class="wz" id="wz">
        <img src="/img/main_img/spirit/spirit/smallgreen.png" alt="" style="margin-top: -1px;">
        <span style="margin-left: 2px">在线</span>
        <span class="people">1</span>
        <span>人</span>
        <span class="wzspan"></span>
    </div>
    <div id="module_user_group_op_menu" class="attach_div small" style="width:80px;">
        <a op="msg" href="javascript:;"><span>微讯</span></a>
        <a op="email" href="javascript:;"><span>邮件</span></a>
    </div>

</div>


<script>
    function autodivheight(){
        var winHeight = 0;
        var winWidth = 0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        document.getElementById("module_org").style.height= winHeight - 20 +"px";
        document.getElementById("sub_module_org_0").style.height= winHeight - 102 +"px";
        document.getElementById("sub_module_org_1").style.height= winHeight - 102 +"px";
        document.getElementById("wz").style.width= winWidth - 30 +"px";

    }
    autodivheight();

    function refresh(e){
        location.reload();
    }

    $('#sub_menu_org a').click(function(){
        var index  = $(this).attr('index');
        $(this).addClass('active').siblings().removeClass('active')
        if(index == 1){
            getChDept($('#deptOrg'),null,0);
            $('#sub_module_org_0').show();
            $('#sub_module_org_1').hide();
        }else{
            getChDept($('#deptOrg2'),null,1);
            $('#sub_module_org_0').hide();
            $('#sub_module_org_1').show();
        }
    })

    var numS=2;
    var onLine=[];
    $(function () {
        $.ajax({
            type:'get',
            url:'/user/getOnlineMap',
            dataType:'json',
            async:true,
            success:function (res) {
                var data=res.object;
                if(res.flag){
                    for(var key in data){
                        var arrKey=[];
                        arrKey.push(key);
                        onLine.push(arrKey)
                    }
                }
                enter();
            }
        });
        setInterval(function(){
            initdept();
        },600000)
    })

    function enter(){
        /**********************在线人数**********************************/
        $.get('/user/getOnlineCount',{},function (json) {
            if(json.flag){
                if(json.object != ''&&json.object != undefined){
                    $('.people').html(json.object);
                }else{
                    $('.people').html(1);
                }
            }
        },'json')
        /**********************事物提醒**********************************/
        /* $.get('/user/getOnlineCount',{},function (json) {
         if(json.flag){
         var data = json.object;
         var e = JSON.stringify(data);
         doQtPer(e)
         }
         },'json')*/
    }
    function doQtDep(uid,datas) {
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(uid,datas,"SEND_MSG");
        });
    }
    //组织
    $('#sub_module_org_0 .tab_ctwo').on('click','.childdept',function(){
        layer.load();
        var that = $(this);
        if(that.attr("drop")=="true"){
            that.attr("drop",false);
            removeChdept(that.next());
            if(that.attr('data-c')==undefined){
                that.find('img').prop('src','/img/sys/dapt_right.png')
            }
            layer.closeAll();
        }else{
            if(that.parent().attr('onclick') == undefined){
                that.attr("drop",true);
                getChDept(that.next(),that.attr('deptid'),0);
            }else{
                layer.closeAll();
            }
            if(that.attr('data-c')==undefined) {
                that.find('img').prop('src', '/img/sys/dapt_down.png');
            }
        }
    });
    $('#sub_module_org_1 .tab_ctwo').on('click','.childdept',function(){
        layer.load();
        var that = $(this);
        if(that.attr("drop")=="true"){
            that.attr("drop",false);
            that.next().hide();
//            removeChdept(that.next());
            if(that.attr('data-c')==undefined){
                that.find('img').prop('src','/img/sys/dapt_right.png')
            }
            layer.closeAll();
        }else{
//            if(that.parent().attr('onclick') == undefined){
                that.attr("drop",true);
                that.next().show();
//                getChDept(that.next(),that.attr('deptid'),1);
//            }else{
                layer.closeAll();
//            }
            if(that.attr('data-c')==undefined) {
                that.find('img').prop('src', '/img/sys/dapt_down.png');
            }
        }
    });
    function removeChdept(target){
        target.html("");
    }
    function buildNode(len,data){  //递归调用
        var str=""
        if(data !=undefined){

            var prefix = 20;
            for(var i=0;i<len;i++){
                prefix +=20;
            }
            $.each(data,function(i,item){
                if(item.deptName){
                    str+='<li >' +
                        '<span  data-num="2" ' +
                        'style="padding-left: '+prefix+'px " deptid="'+item.deptId+'" ' +
                        'class="childdept dynatree-node dynatree-folder ' +
                        'dynatree-expanded dynatree-has-children ' +
                        'dynatree-lastsib dynatree-exp-el ' +
                        'dynatree-ico-ef" drop="true">' +
                        '<span class="dynatree-checkbox actives">' +
                        '<img src="/img/sys/dapt_down.png" alt="" data-type="1">' +
                        '</span>' +
                        '<a href="#" class="dynatree-title" ' +
                        'title="">'+item.deptName+'</a>' +
                        '</span>' +
                        '<ul class="dyna_ul" >'+buildNode(len+1,item.child)+'</ul>' +
                        '</li>';
                }else{
                    str+='<li id="dyna_li" onclick="openwin(this)">' +
                        '<span  ' +
                        'style="padding-left:'+prefix+'px; " ' +
                        'data-c="1" deptid="'+item.deptId+'" ' +
                        'class="childdept dynatree-node dynatree-folder ' +
                        'dynatree-expanded dynatree-has-children ' +
                        'dynatree-lastsib dynatree-exp-el dynatree-ico-ef" >' +
                        '<span class="dynatree-checkbox">' +
                        '<img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                            if(item.avatar=='0'){
                                return '/img/email/icon_head_man_06.png'
                            }else if(item.avatar=='1'){
                                return '/img/email/icon_head_woman_06.png'
                            }else if(item.avatar==''){
                                return '/img/email/icon_head_man_06.png'
                            }else{
                                return '/img/user/'+item.avatar
                            }
                        }()+'" alt="">' +
                        '</span><a href="#" class="dynatree-title" userid="'+ item.userId +'"' +
                        'uid="'+item.uid+'" userPrivName="'+item.userPrivName+'" ' +
                        'sex="'+item.sex+'" id="'+item.mobilNo+'" ' +
                        'birthday="'+item.birthday+'" ' +
                        'title="'+item.userName+'" myStatus="'+ item.mystatus +'">'+item.userName+'</a>' +function () {
//                            if(compareFUN(onLine,item.userId)){
                                return '<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>';
//                            }else {
//                                return '';
//                            }
                        }()+
                        '</span>' +
                        '<ul ></ul>' +
                        '</li>';
                }


            });
            return str;
        }

    }

    function getChDept(target,deptId,type){
        var indexlayer = layer.load();
        var data=''
        if(type==1){
            data={
                deptId:deptId,
                queryType:'online'
            }
        }else{
            data={
                deptId:deptId
            }
        }
        var ajaxTimeOut = $.ajax({    //将网络请求事件赋值给变量ajaxTimeOut
            url: "/getChDeptBai",
            type: "GET",
            dataType: "json",
            data:data,
            timeout: 5000, //通过timeout属性，设置超时时间
            success: function (data) {
                if(type == 0 ){  //显示全部人员
                    if(deptId==undefined){
                        var str = '';
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li >' +
                                    '<span  data-num="2" ' +
                                    'style="padding-left: 20px " deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el ' +
                                    'dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox actives">' +
                                    '<img src="/img/sys/dapt_right.png" alt="" data-type="1">' +
                                    '</span>' +
                                    '<a href="#" class="dynatree-title" ' +
                                    'title="">'+v.deptName+'</a>' +
                                    '</span>' +
                                    '<ul class="dyna_ul" ></ul>' +
                                    '</li>';
                            }else{
                                str+='<li id="dyna_li" onclick="openwin(this)">' +
                                    '<span  ' +
                                    'style="padding-left:20px; " ' +
                                    'data-c="1" deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox">' +
                                    '<img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                        if(v.avatar=='0'){
                                            return '/img/email/icon_head_man_06.png'
                                        }else if(v.avatar=='1'){
                                            return '/img/email/icon_head_woman_06.png'
                                        }else if(v.avatar==''){
                                            return '/img/email/icon_head_man_06.png'
                                        }else{
                                            return '/img/user/'+v.avatar
                                        }
                                    }()+'" alt="">' +
                                    '</span><a href="#" class="dynatree-title" userid="'+ v.userId +'"' +
                                    'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                                    'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                                    'birthday="'+v.birthday+'" ' +
                                    'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +function () {
                                        if(compareFUN(onLine,v.userId)){
                                            return '<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>';
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '</span>' +
                                    '<ul ></ul>' +
                                    '</li>';
                            }
                        });
                    }else{
                        var str = '';
                        var bool=false;
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li >' +
                                    '<span  data-num="'+(parseInt($(target).prev().attr('data-num'))+1)+'" ' +
                                    'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el ' +
                                    'dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox actives">' +
                                    '<img src="/img/sys/dapt_right.png" alt="" data-type="1">' +
                                    '</span>' +
                                    '<a href="#" class="dynatree-title" ' +
                                    'title="">'+v.deptName+'</a>' +
                                    '</span>' +
                                    '<ul class="dyna_ul" ></ul>' +
                                    '</li>';
                            }else{
                                str+='<li id="dyna_li" onclick="openwin(this)">' +
                                    '<span  ' +
                                    'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " ' +
                                    'data-c="1" deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox">' +
                                    '<img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                        if(v.avatar=='0'){
                                            return '/img/email/icon_head_man_06.png'
                                        }else if(v.avatar=='1'){
                                            return '/img/email/icon_head_woman_06.png'
                                        }else if(v.avatar==''){
                                            return '/img/email/icon_head_man_06.png'
                                        }else{
                                            return '/img/user/'+v.avatar
                                        }
                                    }()+'" alt="">' +
                                    '</span><a href="#" class="dynatree-title" userid="'+ v.userId +'"' +
                                    'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                                    'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                                    'birthday="'+v.birthday+'" ' +
                                    'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +function () {
                                        if(compareFUN(onLine,v.userId)){
                                            return '<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>';
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '</span>' +
                                    '<ul ></ul>' +
                                    '</li>';
                            }
                        });
                    }
                }else{//显示在线人员
                    if(deptId==undefined){
                        var str = '';
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li >' +
                                    '<span  data-num="2" ' +
                                    'style="padding-left: 20px " deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el ' +
                                    'dynatree-ico-ef" drop="true">' +
                                    '<span class="dynatree-checkbox actives">' +
                                    '<img src="/img/sys/dapt_down.png" alt="" data-type="1">' +
                                    '</span>' +
                                    '<a href="#" class="dynatree-title" ' +
                                    'title="">'+v.deptName+'</a>' +
                                    '</span>' +
                                    '<ul class="dyna_ul" >'+buildNode(1,v.child)+'</ul>' +
                                    '</li>';

                            }else{
                                str+='<li id="dyna_li" onclick="openwin(this)">' +
                                    '<span  ' +
                                    'style="padding-left:20px; " ' +
                                    'data-c="1" deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox">' +
                                    '<img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                        if(v.avatar=='0'){
                                            return '/img/email/icon_head_man_06.png'
                                        }else if(v.avatar=='1'){
                                            return '/img/email/icon_head_woman_06.png'
                                        }else if(v.avatar==''){
                                            return '/img/email/icon_head_man_06.png'
                                        }else{
                                            return '/img/user/'+v.avatar
                                        }
                                    }()+'" alt="">' +
                                    '</span><a href="#" class="dynatree-title" userid="'+ v.userId +'"' +
                                    'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                                    'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                                    'birthday="'+v.birthday+'" ' +
                                    'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +function () {
                                        if(compareFUN(onLine,v.userId)){
                                            return '<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>';
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '</span>' +
                                    '<ul ></ul>' +
                                    '</li>';
                            }
                        });
                    }else{
                        var str = '';
                        var bool=false;
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li >' +
                                    '<span  data-num="'+(parseInt($(target).prev().attr('data-num'))+1)+'" ' +
                                    'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el ' +
                                    'dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox actives">' +
                                    '<img src="/img/sys/dapt_right.png" alt="" data-type="1">' +
                                    '</span>' +
                                    '<a href="#" class="dynatree-title" ' +
                                    'title="">'+v.deptName+'</a>' +
                                    '</span>' +
                                    '<ul class="dyna_ul" ></ul>' +
                                    '</li>';
                            }else{
                                str+='<li id="dyna_li" onclick="openwin(this)">' +
                                    '<span  ' +
                                    'style="padding-left: '+(parseInt($(target).prev().attr('data-num'))*20)+'px; " ' +
                                    'data-c="1" deptid="'+v.deptId+'" ' +
                                    'class="childdept dynatree-node dynatree-folder ' +
                                    'dynatree-expanded dynatree-has-children ' +
                                    'dynatree-lastsib dynatree-exp-el dynatree-ico-ef" >' +
                                    '<span class="dynatree-checkbox">' +
                                    '<img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                        if(v.avatar=='0'){
                                            return '/img/email/icon_head_man_06.png'
                                        }else if(v.avatar=='1'){
                                            return '/img/email/icon_head_woman_06.png'
                                        }else if(v.avatar==''){
                                            return '/img/email/icon_head_man_06.png'
                                        }else{
                                            return '/img/user/'+v.avatar
                                        }
                                    }()+'" alt="">' +
                                    '</span><a href="#" class="dynatree-title" userid="'+ v.userId +'"' +
                                    'uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" ' +
                                    'sex="'+v.sex+'" id="'+v.mobilNo+'" ' +
                                    'birthday="'+v.birthday+'" ' +
                                    'title="'+v.userName+'" myStatus="'+ v.mystatus +'">'+v.userName+'</a>' +function () {
                                        if(compareFUN(onLine,v.userId)){
                                            return '<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>';
                                        }else {
                                            return '';
                                        }
                                    }()+
                                    '</span>' +
                                    '<ul ></ul>' +
                                    '</li>';
                            }
                        });
                    }
                }



                target.html(str);
                layer.closeAll();
            }.bind(this),
            error: function (xhr, status, err) {
                layer.closeAll();
            }.bind(this),
            complete: function (XMLHttpRequest, status) { //当请求完成时调用函数
                if (status == 'timeout'||status == 'error') {//status == 'timeout'意为超时,status的可能取值：success,notmodified,nocontent,error,timeout,abort,parsererror
                    ajaxTimeOut.abort(); //取消请求
                    layer.closeAll();
                    layer.msg('网络连接失败', {time:5000,icon: 7});
                }
            }
        });
    }
    $.ajax({
        url:'/sys/showUnitManage',
        type:'get',
        dataType:"JSON",
        data : '',
        success:function(obj){
            var data = obj.object.unitName;
            $('.pickCompany .dynatree-title').text(data).attr('title',data);
            layer.load();
            getChDept($('#deptOrg'),null,0);
        },
        error:function(e){

        }
    })

    function initdept(){
        $.ajax({
            type:'get',
            url:'/user/getOnlineMap',
            dataType:'json',
            async:true,
            success:function (res) {
                var data=res.object;
                onLine = [];
                if(res.flag){
                    for(var key in data){
                        var arrKey=[];
                        arrKey.push(key);
                        onLine.push(arrKey)
                    }

                }
                $('.people').html(onLine.length);
                $('#deptOrg').find('span[drop=true]').next().find('a').each(function(i,v){
                    if($(v).attr('userid')!=undefined){
                        if(compareFUN(onLine,$(v).attr('userid'))){
                            if($(v).next().length == 0){
                                $(v).after('<span style="color:#ff0000;margin-left: 5px;font-size: 14px;vertical-align: middle;">在线</span>');
                            }
                        }else {
                            if($(v).next().length != 0){
                                $(v).next().remove();
                            }
                        }
                    }
                })
            }
        });

    }

    function openwin(e){
        var uid = $(e).find("a.dynatree-title").attr("uid");
        var uname = $(e).find("a.dynatree-title").attr("title");
        var userPrivName = $(e).find("a.dynatree-title").attr("userPrivName");
        var sex = $(e).find("a.dynatree-title").attr("sex");
        var birthday = $(e).find("a.dynatree-title").attr("birthday");
        var mobilNo = $(e).find("a.dynatree-title").attr("id");
        var myStatus = $(e).find("a.dynatree-title").attr("myStatus");
        var avatar = $(e).find("span.dynatree-checkbox img").attr("src");
        if(uname == 'undefined'){
            uname = '';
        }
        if(userPrivName == 'undefined'){
            userPrivName = '';
        }
        if(sex == 'undefined'){
            sex = '';
        }
        if(birthday == 'undefined'){
            birthday = '';
        }
        if(mobilNo == 'undefined'){
            mobilNo = '';
        }
        if(myStatus == 'undefined'){
            myStatus = '';
        }
        if(avatar == 'undefined'){
            avatar = '';
        }
        var datas={
            "uname": uname,
            "userPrivName": userPrivName,
            "sex": sex,
            "birthday": birthday,
            "mobilNo": mobilNo,
            "myStatus": myStatus,
            "avatar": avatar
        };
        var datass = JSON.stringify(datas);
        doQtDep(uid, datass);
    }

    function compareFUN(arr,first){
        var length = arr.length;
        var flag = false;
        for(var i=0;i<length;i++){
            if(arr[i][0] == first){
                return true;
            }
        }
        return false;
    }

</script>
</body>
</html>