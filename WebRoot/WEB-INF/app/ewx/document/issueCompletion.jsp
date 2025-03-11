<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>办结收文</title>
    <link href="../../lib/dropload/dropload.css" rel="stylesheet"/>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <link href="../../lib/mui/mui/mui.css" rel="stylesheet">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../../lib/dropload/dropload.js"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
    <style>
        header {
            height: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.32rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            position: fixed;
            width: 100%;
            z-index: 9999;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }

        .nav2{
            color: #333;
            font-size: 0.33rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
        }
        .nav1{
            margin: 0px 20px 0px 12px;
            color: #646464;
            text-overflow: ellipsis;
            white-space: nowrap;
            position: relative;
            font-size: 15px;
            border-bottom: 1px solid #ccc;
        }
        .nav3{
            margin: 0 18px;
            color: #646464;
            line-height: 0.4rem;
            font-size: 12px;
        }
        .fs14{
            font-size: 0.3rem;
            color: #999;
            float: right;
        }
        .ac2{
            color: #547dbf;
            margin-left: 0.3rem;
        }
        .list{
            display: block;
        }
        .content{
            margin-bottom: .38rem;
        }
        a:hover{
            cursor:pointer
        }
        .step{
            width: 70%;
            display:inline-block;
            margin-right: 1.7rem;
            height: 0.4rem;
            line-height: .4rem;
            color: #547dbf;
            font-size: 14px;
            margin: 5px 20px;
        }
        button{
            border: none;
            border-radius: 3px;
            background-color: #3b87f5;
            font-size: 13px;
            height: 25px;
            line-height: 25px;
            margin-right: 5px;
            padding: 0px 11px;
            color: #fff;
        }
        .circulation,.withdrawal,.takeBack,.Issue{
            display: none;
        }
        .mui-search input[type='search']{
            margin: 5px 10px 0px 6px;
            width: 97%;
            background-color: #ffffff;
        }
        .mui-search .mui-placeholder{
            line-height: 43px;
        }
        .title{
            word-break: break-all;
            white-space: initial;
        }
    </style>
</head>
<body>
<div class="" style="background: #f4f4f4;padding-top: .07rem;box-sizing: border-box;">
    <div class="mui-input-row mui-search">
        <input id="searchLog" type="search" class="mui-input-clear" placeholder="搜索">
    </div>
    <ul class="content">

    </ul>

</div>
</body>
<script scripttype="text/javascript">
    var vuId
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    // var type = $.GetRequest().dataType

    //用于监听input的值变化（input的值产生变化才会触发事件）
    (function ($) {
        $.fn.watch = function (callback) {
            return this.each(function () {
                //缓存以前的值
                $.data(this, 'originVal', $(this).val());

                //event
                $(this).on('keyup paste', function () {
                    var originVal = $.data(this, 'originVal');
                    var currentVal = $(this).val();

                    if (originVal !== currentVal) {
                        $.data(this, 'originVal', $(this).val());
                        callback(currentVal);
                    }
                });
            });
        }
    })(jQuery);

    $('#searchLog').watch(function(value) {
        $.ajax({
            type: 'GET',
            url: '/document/selOverDocSendOrReceive',
            data: {
                page: 1,
                pageSize: 999,
                useFlag:false,
                documentType:'1',
                title:value
            },
            dataType: 'json',
            success: function (res) {
                var appele = ''
                var length = res.datas.length;
                //获取cookie里面的key值
                function getCookie(cookieName) {
                    var strCookie = document.cookie;
                    var arrCookie = strCookie.split("; ");
                    for(var i = 0; i < arrCookie.length; i++){
                        var arr = arrCookie[i].split("=");
                        if(cookieName == arr[0]){
                            return arr[1];
                        }
                    }
                    return "";
                }
                var access_token = getCookie("userId")   //在cookie里面的key值

                if (res.datas.length>0) {
                    for (var i = 0; i < res.datas.length; i++) {
                        var display1 = '', display2 = '',display3 = '',display4 = ''
                        //判断的下发
                        var maps = res.datas[i].map.userid
                        if(length > 1 ){
                            if(res.datas[i].endTime!=undefined&&res.datas[i].endTime!='' && maps==access_token){
                                display1 = 'display:inline-block';
                            }else if(maps!=access_token && maps==undefined){
                                display1 = 'none'
                            }
                        }
                        //判断传阅情况
                        if(res.datas[i].viewUser== ","||res.datas[i].viewUser== ""){
                            display2 = 'none'
                        }else {
                            display2 = 'display:inline-block';
                        }
                        //判断传阅撤回
                        if(res.datas[i].viewUser== ","||res.datas[i].viewUser== ""){
                            display3 = 'none'
                        }else {
                            display3 = 'display:inline-block';
                        }
                        //收回
                        if(res.datas[i].prFlag=="3"&&res.datas[i].state != '已结束' ){
                            display4 = 'display:inline-block';
                        }else {
                            display4 = 'none'

                        }
                        appele+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.datas[i].flowId+'  prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+'   runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>'+
                            '<div class="nav1">'+
                            '<span class="nav2">'+ title(res.datas[i].title,res.datas[i].workLevel)+'</span>'+
                            // '<span class="fs14">'+dmerStatusStr(res.datas[i].prFlag)+'</span>'+
                            '</div>'+
                            '<div class="step"><span style="color: #000;">我经办的步骤：</span>'+function () {
                                if(res.datas[i].prcsName == undefined){
                                    var prcsName = '';
                                }else{
                                    var prcsName = res.datas[i].prcsName;
                                }
                                if(res.datas[i].state1 == '已办结'){
                                    var color = "red"; //37aa43
                                }else{
                                    var color = '#2b7fe0'
                                }
                                return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'"><span>第'+res.datas[i].step+'<fmt:message code="workflow.th.step" />:'+prcsName+'</span><br><span><span style="color:'+color+'">'+ res.datas[i].state1 +'</span></span></a>';
                            }()+'</div>' +
                            '<div class="step"><span style="color: #000;">当前步骤：</span>'+function () {
                                if(res.datas[i].state == '已结束'){
                                    return '<span style="color:red">已结束</span>'
                                }else{
                                    if(res.datas[i].state2 == 1){
                                        return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'">并发<br>并发</a>';
                                    }else{
                                        if(res.datas[i].currentPeople == undefined){
                                            res.datas[i].currentPeople = '';
                                        }
                                        return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'">'+ res.datas[i].bz +'<br>'+ res.datas[i].currentPeople +'</a>';
                                    }
                                }
                            }()+'</div>'+
                            '<p class="nav3"><span>发文人：</span>'+res.datas[i].createrName+'</span></p>'+
                            '<p class="nav3"><span>办结时间：'+issue(res.datas[i].createTime)+'</span></p>'+
                            '<p style="text-align: right">' +
                            '<button class="details" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>查看详情</button>' +
                            '<button class="circulation" style="'+display2+';" runId='+res.datas[i].runId+' prcsId='+res.datas[i].step+' flowPrcs='+res.datas[i].realPrcsId+'>传阅情况</button>' +
                            '<button class="withdrawal" style="background:#ec5959;'+display3+'" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].step+'  flowPrcs='+res.datas[i].realPrcsId+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>传阅撤回</button>' +
                            '<button class="takeBack" style="background:#ec5959;'+display4+'" flowPrcs='+res.datas[i].realPrcsId+' prcsId='+res.datas[i].step+'  userId='+res.datas[i].curUserId+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>收回</button>' +
                            '<button class="Issue" style="'+display1+'" tabId='+res.datas[i].id+'>下发'+'</button>' +
                            '</p>'+
                            '</li>'

                    }
                    $('.content').html(appele)
                } else {
                    var str='<div style="font-size: .4rem;text-align: center;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
                    $('.content').html(str)
                }
            }
        });
    })

    //判断办理的状态
    function dmerStatusStr(prFlag){
        if(prFlag==1){
            return '<fmt:message code="sup.th.NotReceived"/>'
        }else if(prFlag==2){
            return '<fmt:message code="lang.th.Process"/>'
        } else if(prFlag==3){
            return '<fmt:message code="doc.th.ToReceive"/>'
        }else {
            return '<fmt:message code="lang.th.HaveThrough"/>'
        }
    }
    //判断发文时间的方法
    function issue (createTime){
        if(createTime.indexOf('.') > -1){
            return createTime.split('.')[0]
        }else {
            return createTime
        }
    }
    //判断标题的紧急程度
    function title(title,workLevel){
        if(title!=undefined){
            if(workLevel == 0|| workLevel == undefined){
                var str = '<span style="color: green;">【普通】</span>';
            }else if(workLevel == 1){
                var str = '<span style="color: red;">【紧急】</span>';
            }else if(workLevel == 2){
                var str = '<span style="color: red;">【特急】</span>';
            }
            return '<a href="javascript:;" style="display: inline-block;margin-bottom: 7px">'+str+'<span class="title">'+title+'</span></a>'
        }else {
            return ""
        }
    }

    $(function() {
        // 页数
        var page = 0;
        // 每页展示5个
        var size = 10;

        // dropload
        $('.content').dropload({
            scrollArea: window,
            domDown: {
                domClass: 'dropload-down',
                domRefresh: '<div class="dropload-refresh">上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: '<div class="dropload-noData">暂无更多数据</div>'
            },
            loadDownFn: function (me) {
                page++;
                // 拼接HTML
                var app = '';
                $.ajax({
                    type: 'GET',
                    url: '/document/selOverDocSendOrReceive',
                    data: {
                        page: page,
                        pageSize: size,
                        useFlag:true,
                        documentType:'1',

                    },
                    dataType: 'json',
                    success: function (res) {
                        var length = res.datas.length;
                        //获取cookie里面的key值
                        function getCookie(cookieName) {
                            var strCookie = document.cookie;
                            var arrCookie = strCookie.split("; ");
                            for(var i = 0; i < arrCookie.length; i++){
                                var arr = arrCookie[i].split("=");
                                if(cookieName == arr[0]){
                                    return arr[1];
                                }
                            }
                            return "";
                        }
                        var access_token = getCookie("userId")   //在cookie里面的key值

                        if (res.flag) {
                            for (var i = 0; i < res.datas.length; i++) {
                                var display1 = '', display2 = '',display3 = '',display4 = ''
                                //判断的下发
                                var maps = res.datas[i].map.userid
                                if(length > 1 ){
                                    if(res.datas[i].endTime!=undefined&&res.datas[i].endTime!='' && maps==access_token){
                                        display1 = 'display:inline-block';
                                    }else if(maps!=access_token && maps==undefined){
                                        display1 = 'none'
                                    }
                                }
                                //判断传阅情况
                                if(res.datas[i].viewUser== ","||res.datas[i].viewUser== ""){
                                    display2 = 'none'
                                }else {
                                    display2 = 'display:inline-block';
                                }
                                //判断传阅撤回
                                if(res.datas[i].viewUser== ","||res.datas[i].viewUser== ""){
                                    display3 = 'none'
                                }else {
                                    display3 = 'display:inline-block';
                                }
                                //收回
                                if(res.datas[i].prFlag=="3"&&res.datas[i].state != '已结束' ){
                                    display4 = 'display:inline-block';
                                }else {
                                    display4 = 'none'

                                }


                                app+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.datas[i].flowId+'  prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+'   runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>'+
                                    '<div class="nav1">'+
                                    '<span class="nav2">'+ title(res.datas[i].title,res.datas[i].workLevel)+'</span>'+
                                    // '<span class="fs14">'+dmerStatusStr(res.datas[i].prFlag)+'</span>'+
                                    '</div>'+
                                    '<div class="step"><span style="color: #000;">我经办的步骤：</span>'+function () {
                                        if(res.datas[i].prcsName == undefined){
                                            var prcsName = '';
                                        }else{
                                            var prcsName = res.datas[i].prcsName;
                                        }
                                        if(res.datas[i].state1 == '已办结'){
                                            var color = "red"; //37aa43
                                        }else{
                                            var color = '#2b7fe0'
                                        }
                                        return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'"><span>第'+res.datas[i].step+'<fmt:message code="workflow.th.step" />:'+prcsName+'</span><br><span><span style="color:'+color+'">'+ res.datas[i].state1 +'</span></span></a>';
                                    }()+'</div>' +
                                    '<div class="step"><span style="color: #000;">当前步骤：</span>'+function () {
                                        if(res.datas[i].state == '已结束'){
                                            return '<span style="color:red">已结束</span>'
                                        }else{
                                            if(res.datas[i].state2 == 1){
                                                return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'">并发<br>并发</a>';
                                            }else{
                                                if(res.datas[i].currentPeople == undefined){
                                                    res.datas[i].currentPeople = '';
                                                }
                                                return '<a class="wenhao" style="cursor: pointer;" onclick="bzlct($(this))" runid="'+ res.datas[i].runId +'" flowid="'+ res.datas[i].flowId +'">'+ res.datas[i].bz +'<br>'+ res.datas[i].currentPeople +'</a>';
                                            }
                                        }
                                    }()+'</div>'+
                                    '<p class="nav3"><span>发文人：</span>'+res.datas[i].createrName+'</span></p>'+
                                    '<p class="nav3"><span>办结时间：'+issue(res.datas[i].createTime)+'</span></p>'+
                                    '<p style="text-align: right">' +
                                    '<button class="details" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>查看详情</button>' +
                                    '<button class="circulation" style="'+display2+';" runId='+res.datas[i].runId+' prcsId='+res.datas[i].step+' flowPrcs='+res.datas[i].realPrcsId+'>传阅情况</button>' +
                                    '<button class="withdrawal" style="background:#ec5959;'+display3+'" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].step+'  flowPrcs='+res.datas[i].realPrcsId+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>传阅撤回</button>' +
                                    '<button class="takeBack" style="background:#ec5959;'+display4+'" flowPrcs='+res.datas[i].realPrcsId+' prcsId='+res.datas[i].step+'  userId='+res.datas[i].curUserId+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+'>收回</button>' +
                                    '<button class="Issue" style="'+display1+'" tabId='+res.datas[i].id+'>下发'+'</button>' +
                                    '</p>'+
                                    '</li>'

                            }
                            // 如果没有数据
                            if(res.datas.length==0){0
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                            }
                        } else {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function () {
                            // 插入数据到页面，放到最后面
                            $('.dropload-down').before(app);
                            // 每次数据插入，必须重置
                            me.resetload();
                        }, 1000);
                    },
                    error: function (xhr, type) {
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            },
            threshold: 50
        });
    })
    function bzlct(e) {
        eventas = e;
        window.location.href='/flowSetting/processDesignToolTwo?flowId=' + e.attr('flowid') + '&rilwId=' + e.attr('runid')+'&LucType=1', '';
    }

    <%--//    查看详情--%>
    mui("ul").on("tap","li .details",function(){
        event.stopPropagation();
        var flowId=$(this).attr('flowId')
        var prcsId=$(this).attr('prcsId')
        var flowStep=$(this).attr('flowStep')
        var runId=$(this).attr('runId')
        var tabId = $(this).attr('tabId')
        var tableName = $(this).attr('tableName')
        mui.openWindow({
            url: '/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+flowStep+'' +
                '&tabId='+tabId+'&tableName='+tableName+'&runId='+runId+'&' +
                'prcsId='+prcsId+'&isNomalType=false&hidden=true'+'&type=EWC'
        });

    })
    //收回
    mui("ul").on("tap","li .takeBack",function(){
        $.ajax({
            type: "get",
            url: "/workflow/work/workBack",
            dataType: 'JSON',
            data: {
                prcsId: $(this).attr('prcsId'),
                runId: $(this).attr('runId'),
                flowPrcs: $(this).attr('flowPrcs'),
                userId:$(this).attr('userId'),
                tabId:$(this).attr('tabId'),
                tableName:$(this).attr('tableName')
            },
            success: function (res) {
                if(res.flag){
                    $.layerMsg({content:'收回成功！',icon:1});
                    location.reload();
                }else{
                    $.layerMsg({content:'收回失败！',icon:2});
                    location.reload();
                }
            }
        });
    })
    //传阅情况
    mui("ul").on("tap","li .circulation",function(){
        window.location.href='/ToBeReadController/ReadFileInfo?&runId='+$(this).attr('runId')+'&prcsId='+$(this).attr('prcsId')+'&flowPrcs='+$(this).attr('flowPrcs');
    })

    //   传阅撤回
    mui("ul").on("tap","li .withdrawal",function(){
        var _this =  $(this)
        $.layerConfirm({title:'传阅撤回',content:'确认将该公文传阅撤回吗？',icon:0,offset:"200px"},function(){
            $.ajax({
                type: "get",
                url: "/ToBeReadController/withdrawFileRead",
                dataType: 'JSON',
                data: {
                    prcsId: _this.attr('prcsId'),
                    runId: _this.attr('runId'),
                    flowPrcs: _this.attr('flowPrcs'),
                    tabId:_this.attr('tabId'),
                    tableName:_this.attr('tableName'),
                    flowId:_this.attr('flowId')
                },
                success: function (res) {
                    if(res.flag){
                        $.layerMsg({content:'传阅撤回成功！',icon:1});
                        location.reload();
                    }else{
                        $.layerMsg({content:'传阅撤回失败！',icon:2});
                    }
                }
            });
        });
    })

    //   下发
    mui("ul").on("tap","li .Issue",function(){
        var tabId = $(this).attr('tabId')
        layer.open({
            title: '下发公文',
            btn: ['确定', '取消'],
            area: ['100%', '400px'],
            content: '<ul id="xiafagongwen" class="clearfix"></ul>',
            success:function () {
                $.get('/documentOrg/getCompanyAll',{locales:tabId},function (json) {
                    if(json.flag){
                        var str='';
                        var arr=json.obj;
                        for(var i=0;i<arr.length;i++){
                            str+='<li style="margin: 5px 10px;float: left">' +
                                '<label><input style="vertical-align: middle" type="checkbox" value="'+arr[i].oid+'">'+arr[i].name+'</label></li>'
                        }
                        $('#xiafagongwen').html(str);
                    }
                },'json')
            },
            yes:function (index) {
                var transferReceiveOrg='';
                $('#xiafagongwen li [type=checkbox]:checked').each(function (i,n) {
                    transferReceiveOrg+=$(this).val()+','
                })
                $.post('/documentOrg/save',{transferReceiveOrg:transferReceiveOrg,id:tabId},function (json) {
                    if(json.flag){
                        $.layerMsg({content:'下发成功',icon:1})
                    }
                },'json')
            }
        })
    })
</script>

</html>
