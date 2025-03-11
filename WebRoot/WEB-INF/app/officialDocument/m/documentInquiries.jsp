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
    <title>公文查询</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <script type="text/javascript" src="../../lib/dropload/dropload.js"></script>
    <link href="../../lib/dropload/dropload.css" rel="stylesheet"/>
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
            z-index: 1;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }


        input{
            font-size: 0.34rem;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            height: .62rem;
            border: 0;
            border-radius: 6px;
            outline: 0;
            padding-left: 10px;
            background: #fff;width: 95%;margin: 7px 0 ;

        }
        input::-ms-input-placeholder{text-align: center;}
        input::-webkit-input-placeholder{text-align: center;}

        .nav2{
            color: #333;
            font-size: 0.33rem;
            width: 48%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
            float: left;
        }
        .nav1{
            margin:0rem .3rem 0 .3rem;
            color: #646464;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .nav3{
            margin: 0 .4rem;
            color: #646464;
            border-bottom: 1px solid #5a8fd5;
            line-height: 0.7rem;
        }
        .fs14{
            font-size: 0.3rem;
            color: #999;
            float: right;
            display: inline-block;
        }
        .ac{
            color: #5087d0;
            font-size: .28rem;
        }
        .hd{
            height: .85rem;
        }
        .list{
            display: block;
        }
        .content{
            margin-bottom: .38rem;
            margin: 0 .1rem;
        }
        .fs15{
            text-align: center;
            width: 60px;
            height: 26px;
            line-height: 26px;
            background-color: aliceblue;
            font-size: 0.25rem;
            border-radius: .1rem;
            color: #5a8fd5;
            margin-top: .09rem;
        }
        .cc{
            color:#5a8fd5;
        }
    </style>
</head>
<body>
<header>
    <i><a href="/m/getMainddh5" style="color: #fff">返回</a></i>
    <span>公文查询</span>
    <i style="width: .4rem"></i>
</header>
<div class="hd"></div>
<div class="" style="background: #ffffff;">
    <div class="" style="background-color: #f2f2f2;text-align: center;">
        <input id="search" oninput="OnInput (event)" placeholder="请输入关键字智能搜索" style="" value="">
        <%--<input type="text" oninput="OnInput (event)" value="" />--%>
    </div>
    <div class="content">

    </div>
</div>
</body>
<script>
    $('textarea').bind('input propertychange', function() {
        $('.msg').html($(this).val().length + ' characters');
    });
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";

    function undefindData(data) {
        if(data == undefined){
            return '';
        }else{
            return data;
        }
    }
    function OnInput (event) {
        $.ajax({
            url:'/document/selDocByTitle',
            type:'get',
            data:{
                title:event.target.value,
            },
            dataType:'json',
            success:function(res){
                if(res.flag){
                    var app="";
                    $.each (res.datas,function(index,item){
                        app+='<div style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);    border-radius: .1rem;background-color: #fff;margin:.25rem .1rem;padding :.2rem 0">'+
                            '<a class="list"  href="javascript:;" style="color: #333;"  flowId="'+item.flowId+'" flowStep="'+item.step+'" tabId="'+item.id+'" tableName="'+item.tableName+'" runId="'+item.runId+'" prcsId="'+item.realPrcsId+'">'+
                            '<div class="nav1" style="border-bottom: 1px solid #b5b0b0;line-height: .7rem;height: .7rem;">'+
                            '<span class="nav2">'+undefindData(item.title)+'</span>'+
                            '<span class="fs14 fs15">'+function(){
                                if(item.documentType==0){
                                    return '发文'
                                }else if(item.documentType==1){
                                    return '收文'
                                }
                            }()+'</span>'+
                            '</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;">创建人：'+undefindData(item.createrName)+'</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">' +
                            '<p class="cc">状态：'+function(){
                                if(item.prFlag==1){
                                    return '未接收'
                                }else if(item.prFlag==2){
                                    return '办理中'
                                }else if(item.prFlag==3){
                                    return '转交下一步，下一步经办人无人接收'
                                }else if(item.prFlag==4){
                                    return '已办结'
                                }else if(item.prFlag==5){
                                    return '自由流程预设步骤'
                                }else if(item.prFlag==6){
                                    return '已挂起'
                                }else if(item.prFlag==undefined){
                                    return ''
                                }
                            }()+'</p>' +
                            '<p style="'+function () {
                                if(item.urgency!=undefined){
                                    return "color:red";
                                }
                            }()+'">'+function () {
                                if(item.urgency!=undefined){
                                    return '紧急程度:'+item.urgency+''
                                }else {
                                    return ""
                                }
                            }()+'</p>'+
                            '<p style="'+function () {
                                if(item.secrecy!=undefined){
                                    return "color:green";
                                }
                            }()+'">'+function () {
                                if(item.secrecy!=undefined){
                                    return '机密等级:'+item.secrecy+''
                                }else {
                                    return ""
                                }
                            }()+'</p>'+
                            '</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">'+item.printDate+'</div>'+
                            '</a>'+
                            '</div>'
                    })
                    $('.content').html(app)
                }else{
                    var str='<div style="border-radius: 0.12rem;font-size: .28rem;text-align: center;background-color: #dddddd;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
                    $('.content').html(str)
                }
            }
        })
    }


    $(function(){
        // 页数
        var page = 0;
        // 每页展示5个
        var size = 5;

        // dropload
        $('.content').dropload({
            scrollArea : window,
            domDown: {
                domClass: 'dropload-down',
                domRefresh: '<div class="dropload-refresh">上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: '<div class="dropload-noData"></div>'
            },
            loadDownFn : function(me){
                page++;
                // 拼接HTML
                var app = '';
                $.ajax({
                    url:'/document/selDocByTitle',
                    type:'get',
                    data:{
                        page:page,
                        pageSize:size,
                        useFlag:true,
                    },
                    dataType: 'json',
                    success: function(res){
                        if(res.flag&&res.datas.length!=0){
                            $.each (res.datas,function(index,item){
                                app+='<div style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);    border-radius: .1rem;background-color: #fff;margin:.25rem .1rem;padding :.2rem 0">'+
                                    '<a class="list"  href="javascript:;" style="color: #333;"  flowId="'+item.flowId+'" flowStep="'+item.step+'" tabId="'+item.id+'" tableName="'+item.tableName+'" runId="'+item.runId+'" prcsId="'+item.realPrcsId+'">'+
                                    '<div class="nav1" style="border-bottom: 1px solid #b5b0b0;line-height: .7rem;height: .7rem;">'+
                                    '<span class="nav2">'+undefindData(item.title)+'</span>'+
                                    '<span class="fs14 fs15">'+function(){
                                        if(item.documentType==0){
                                            return '发文'
                                        }else if(item.documentType==1){
                                            return '收文'
                                        }
                                    }()+'</span>'+
                                    '</div>'+
                                    '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;">创建人：'+undefindData(item.createrName)+'</div>'+
                                    '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">' +
                                    '<p class="cc">状态：'+function(){
                                        if(item.prFlag==1){
                                            return '未接收'
                                        }else if(item.prFlag==2){
                                            return '办理中'
                                        }else if(item.prFlag==3){
                                            return '转交下一步，下一步经办人无人接收'
                                        }else if(item.prFlag==4){
                                            return '已办结'
                                        }else if(item.prFlag==5){
                                            return '自由流程预设步骤'
                                        }else if(item.prFlag==6){
                                            return '已挂起'
                                        }else if(item.prFlag==undefined){
                                            return ''
                                        }
                                    }()+'</p>' +
                                    '<p style="'+function () {
                                        if(item.urgency!=undefined){
                                            return "color:red";
                                        }
                                    }()+'">'+function () {
                                        if(item.urgency!=undefined){
                                            return '紧急程度:'+item.urgency+''
                                        }else {
                                            return ""
                                        }
                                    }()+'</p>'+
                                    '<p style="'+function () {
                                        if(item.secrecy!=undefined){
                                            return "color:green";
                                        }
                                    }()+'">'+function () {
                                        if(item.secrecy!=undefined){
                                            return '机密等级:'+item.secrecy+''
                                        }else {
                                            return ""
                                        }
                                    }()+'</p>'+
                                    '</div>'+
                                    '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">'+item.printDate+'</div>'+
                                    '</a>'+
                                    '</div>'
                            })
                            // 如果没有数据
                        }else {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function(){
                            // 插入数据到页面，放到最后面
                            $('.dropload-down').before(app);
                            // 每次数据插入，必须重置
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            },
            threshold : 50
        });
    });





//
//    //用于监听input的值变化（input的值产生变化才会触发事件）
//    (function ($) {
//        $.fn.watch = function (callback) {
//            return this.each(function () {
//                //缓存以前的值
//                $.data(this, 'originVal', $(this).val());
//
//                //event
//                $(this).on('keyup paste', function () {
//                    var originVal = $.data(this, 'originVal');
//                    var currentVal = $(this).val();
//
//                    if (originVal !== currentVal) {
//                        $.data(this, 'originVal', $(this).val());
//                        callback(currentVal);
//                    }
//                });
//            });
//        }
//    })(jQuery);
//
//    function undefindData(data) {
//        if(data == undefined){
//            return '';
//        }else{
//            return data;
//        }
//    }
//    $('#search').watch(function(value) {
//        $.ajax({
//            url:'/document/selDocByTitle',
//            type:'get',
//            data:{
//                title:value,
//            },
//            dataType:'json',
//            success:function(res){
//                if(res.flag){
//                    var app="";
//                    $.each (res.datas,function(index,item){
//                        app+='<div style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);    border-radius: .1rem;background-color: #fff;margin:.25rem .1rem;padding :.2rem 0">'+
//                            '<a class="list"  href="javascript:;" style="color: #333;"  flowId="'+item.flowId+'" flowStep="'+item.step+'" tabId="'+item.id+'" tableName="'+item.tableName+'" runId="'+item.runId+'" prcsId="'+item.realPrcsId+'">'+
//                            '<div class="nav1" style="border-bottom: 1px solid #b5b0b0;line-height: .7rem;height: .7rem;">'+
//                            '<span class="nav2">'+undefindData(item.title)+'</span>'+
//                            '<span class="fs14 fs15">'+function(){
//                                if(item.documentType==0){
//                                    return '发文'
//                                }else if(item.documentType==1){
//                                    return '收文'
//                                }
//                            }()+'</span>'+
//                            '</div>'+
//                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;">创建人：'+undefindData(item.createrName)+'</div>'+
//                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">' +
//                            '<p class="cc">状态：'+function(){
//                                if(item.prFlag==1){
//                                    return '未接收'
//                                }else if(item.prFlag==2){
//                                    return '办理中'
//                                }else if(item.prFlag==undefined){
//                                    return ''
//                                }
//                            }()+'</p>' +
//                            '<p style="'+function () {
//                                if(item.urgency!=undefined){
//                                    return "color:red";
//                                }
//                            }()+'">'+function () {
//                                if(item.urgency!=undefined){
//                                    return '紧急程度:'+item.urgency+''
//                                }else {
//                                    return ""
//                                }
//                            }()+'</p>'+
//                            '<p style="'+function () {
//                                if(item.secrecy!=undefined){
//                                    return "color:green";
//                                }
//                            }()+'">'+function () {
//                                if(item.secrecy!=undefined){
//                                    return '机密等级:'+item.secrecy+''
//                                }else {
//                                    return ""
//                                }
//                            }()+'</p>'+
//                            '</div>'+
//                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">'+item.printDate+'</div>'+
//                            '</a>'+
//                            '</div>'
//                    })
//                    $('.content').html(app)
//                }else{
//                    var str='<div style="border-radius: 0.12rem;font-size: .28rem;text-align: center;background-color: #dddddd;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
//                    $('.content').html(str)
//                }
//            }
//        })
//    });
   $('.content').on('click','.list',function(){
       var flowId=$(this).attr('flowId');
       var flowStep=$(this).attr('flowStep');
       var tabId=$(this).attr('tabId');
       var tableName=$(this).attr('tableName');
       var runId=$(this).attr('runId');
       var prcsId=$(this).attr('prcsId');
       window.location.href='/document/getWorkformh5PreViews?flowId='+flowId+'&flowStep='+flowStep+'&tabId='+tabId+'&tableName='+tableName+'&runId='+runId+'&prcsId='+prcsId+'&isNomalType=false&hidden=true'
   })
</script>
</html>