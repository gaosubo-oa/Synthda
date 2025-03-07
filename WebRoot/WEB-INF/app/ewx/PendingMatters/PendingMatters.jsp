<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2023/5/25
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
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
    <title>待阅事宜</title>
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
        .box_bt {
            color: #333;
            font-size: 14px;
            text-align: center;
            width: 94%;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid #d9d9d9;
            height: 38px;
            line-height: 38px;
            background-color: #fff;
            border-radius: 5px;
        }
        #log{
            border-color: #598fde;
            background-color: #598fde;
            color: #fff;
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
<nav class="mui-bar mui-bar-tab" id="nav">
    <a class="mui-tab-item" href="javascript:;" id="jump_draft">
        <div class="box_bt" id="log">待阅</div>
    </a>
    <a class="mui-tab-item" href="javascript:;" id="jump_create">
        <div class="box_bt" id="" >已阅</div>
    </a>
</nav>
</body>
<script scripttype="text/javascript">
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    // var type = $.GetRequest().dataType
var isReadStr = 0;
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
    $("#jump_create").on("click",function (){
        window.location.href='/ewx/PendingRead'
    })
    $('#searchLog').watch(function(value) {
        $.ajax({
            type: 'GET',
            url: '/ToBeReadController/ReadFileIsRead',
            data: {
                page: 1,
                pageSize: 99,
                useFlag:true,
                isReadStr: isReadStr,
                title:value
            },
            dataType: 'json',
            success: function (res) {
                var appele = ''
                var length = res.data.length;
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

                if (res.data.length>0) {
                    for (var i = 0; i < res.data.length; i++) {
                        var display1 = '', display2 = '',display3 = '',display4 = ''
                        appele+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.data[i].flowId+'  prcsId='+res.data[i].realPrcsId+'  flowStep='+res.data[i].step+'   runId='+res.data[i].runId+' tabId='+res.data[i].id+' tableName='+res.data[i].tableName+' opFlag='+res.data[i].opFlag+'>'+
                            '<div class="nav1">'+
                            '<span class="nav2">'+ res.data[i].runName+'</span>'+
                            // '<span class="fs14">'+dmerStatusStr(res.data[i].prFlag)+'</span>'+
                            '</div>'+
                            '<div class="step"><span style="color: #000;">类别：</span>'+function () {
                                if(res.data[i].sortMainType == undefined){
                                    var prcsName = '';
                                }else{
                                    var prcsName = res.data[i].sortMainType;
                                }
                                return '<a class="wenhao"><span>'+res.data[i].sortMainType+'</span><br></a>';
                            }()+'</div>' +
                            '<p class="nav3"><span>发起人：</span>'+res.data[i].userName+'</span></p>'+
                            '<p class="nav3"><span>接收时间：'+res.data[i].createDate+'</span></p>'+
                            '<p style="text-align: right">' +
                            '<button type="button" onclick="clickeDelete($(this));"flowId="'+ res.data[i].flowId +'" runId="'+ res.data[i].runId +'" sortMainType="'+ res.data[i].sortMainType +'" flowStep="'+ res.data[i].prcsId +'" prcsId="'+ res.data[i].flowPrcs +'" runName="'+ res.data[i].runName +'" tableid="'+ res.data[i].tableId +'">已阅</button>' +
                            '<button class="details" onclick="clickRunname($(this))" flowId="'+ res.data[i].flowId +'" runId="'+ res.data[i].runId +'" sortMainType="'+ res.data[i].sortMainType +'" flowStep="'+ res.data[i].prcsId +'" prcsId="'+ res.data[i].flowPrcs +'" runName="'+ res.data[i].runName +'" tableid="'+ res.data[i].tableId +'">查看详情</button>' +
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
                    url: '/ToBeReadController/ReadFileIsRead',
                    data: {
                        page: page,
                        pageSize: 99,
                        useFlag:true,
                        documentType:'1',
                        isReadStr:isReadStr
                    },
                    dataType: 'json',
                    success: function (res) {
                        var length = res.data.length;
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
                            for (var i = 0; i < res.data.length; i++) {
                                var display1 = '', display2 = '',display3 = '',display4 = ''
                                app+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.data[i].flowId+'  prcsId='+res.data[i].realPrcsId+'  flowStep='+res.data[i].step+'   runId='+res.data[i].runId+' tabId='+res.data[i].id+' tableName='+res.data[i].tableName+' opFlag='+res.data[i].opFlag+'>'+
                                    '<div class="nav1">'+
                                    '<span class="nav2">'+ res.data[i].runName+'</span>'+
                                    // '<span class="fs14">'+dmerStatusStr(res.data[i].prFlag)+'</span>'+
                                    '</div>'+
                                    '<div class="step"><span style="color: #000;">类别：</span>'+function () {
                                        if(res.data[i].sortMainType == undefined){
                                            var prcsName = '';
                                        }else{
                                            var prcsName = res.data[i].sortMainType;
                                        }
                                        return '<a class="wenhao"><span>'+res.data[i].sortMainType+'</span><br></a>';
                                    }()+'</div>' +
                                    '<p class="nav3"><span>发起人：</span>'+res.data[i].userName+'</span></p>'+
                                    '<p class="nav3"><span>接收时间：'+res.data[i].createDate+'</span></p>'+
                                    '<p style="text-align: right">' +
                                    '<button type="button" onclick="clickeDelete($(this));"flowId="'+ res.data[i].flowId +'" runId="'+ res.data[i].runId +'" sortMainType="'+ res.data[i].sortMainType +'" flowStep="'+ res.data[i].prcsId +'" prcsId="'+ res.data[i].flowPrcs +'" runName="'+ res.data[i].runName +'" tableid="'+ res.data[i].tableId +'">已阅</button>' +
                                    '<button class="details" onclick="clickRunname($(this))" flowId="'+ res.data[i].flowId +'" runId="'+ res.data[i].runId +'" sortMainType="'+ res.data[i].sortMainType +'" flowStep="'+ res.data[i].prcsId +'" prcsId="'+ res.data[i].flowPrcs +'" runName="'+ res.data[i].runName +'" tableid="'+ res.data[i].tableId +'">查看详情</button>' +
                                    '</p>'+
                                    '</li>'

                            }
                            // 如果没有数据
                            if(res.data.length==0){0
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
    <%--//    查看详情--%>
    function clickRunname(e) {
        var runId = e.attr('runid');
        var sortMainType = e.attr('sortmaintype');
        var flowId = e.attr('flowid');
        var flowstep = e.attr('flowstep');
        var prcsid = e.attr('prcsid');
        var runname = e.attr('runname');
        var tableId = e.attr('tableid');
        if(sortMainType == "工作流"){
            tableId = '0';
        }
        $.ajax({
            url: '/ToBeReadController/updateFileIsRead',
            type: 'get',
            dataType: 'json',
            data: {
                updateStr: runId,
                flowId:flowId,
                flowStep:flowstep,
                prcsId:prcsid,
                runName:runname,
                tableId:tableId
            },
            success: function (obj) {
                if(sortMainType == '工作流'){
                    window.location.href ='/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep=&runId='+runId+'&' +
                        'prcsId=&parent=circulate';
                }else{
                    window.location.href='/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep=&tabId='+tableId+'&tableName=document&runId='+runId+'&' +
                        'prcsId=&isNomalType=false&hidden=true&parent=circulate&ie_open=yes';
                }
            }
        })
    }
    //已阅
    function clickeDelete(e) {
        var tid = e.attr('runid');
        var flowId = e.attr('flowid');
        var flowstep = e.attr('flowstep');
        var prcsid = e.attr('prcsid');
        var runname = e.attr('runname');
        var tableId = e.attr('tableid');
            //删除判断
            layer.confirm('是否标记为已阅？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                //确定删除，调接口
                $.ajax({
                    url: '/ToBeReadController/updateFileIsRead',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        updateStr: tid,
                        flowId:flowId,
                        flowStep:flowstep,
                        prcsId:prcsid,
                        runName:runname,
                        tableId:tableId
                    },
                    success: function (obj) {
                        //第三方扩展皮肤
                        layer.msg('操作成功！', {icon: 6});
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();
            });
    }
</script>

</html>
