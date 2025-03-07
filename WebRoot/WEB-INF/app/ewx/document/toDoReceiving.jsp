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
    <title>待办收文</title>
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
            margin-bottom: 0;
        }
        input::-ms-input-placeholder{text-align: center;}
        input::-webkit-input-placeholder{text-align: center;}

        .nav2{
            color: #333;
            font-size: 0.33rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
            width: 50%;
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
            margin: 0 0.1rem;
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
            margin-right: 10px;
            padding: 0px 11px;
            color: #fff;
        }
        .delet{
            display: none;
            background-color: #ec5959;
        }
        .mui-search input[type='search']{
            margin: 5px 10px 0px 6px;
            width: 97%;
            background-color: #ffffff;
        }
        .mui-search .mui-placeholder{
            line-height: 43px;
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
            url: '/document/selWillDocSendOrReceive',
            type:'get',
            data: {
                page:1,
                pageSize:999,
                useFlag:false,
                documentType:'1',
                title:value
            },
            dataType:'json',
            success:function(res){
                var appele = ''
                if(res.datas.length>0){
                    for (var i = 0; i < res.datas.length; i++) {
                        var display = ''
                        if (res.datas[i].step == '1') {
                            display = 'display:inline-block';
                        }else{
                            display = 'none'
                        }
                        appele+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.datas[i].flowId+'  prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+'   runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>'+
                            '<div class="nav1">'+
                            '<span class="nav2">'+ title(res.datas[i].title,res.datas[i].workLevel)+'</span>'+
                            '<span class="fs14">'+dmerStatusStr(res.datas[i].prFlag)+'</span>'+
                            '</div>'+
                            '<div class="step" style="">'+res.datas[i].step+'步：'+res.datas[i].prcsName +'</div>' +
                            '<p class="nav3"><span class="ac2">'+res.datas[i].createrName+'</span></p>'+
                            '<p class="nav3"><span class="ac2">'+issue(res.datas[i].createTime)+'</span></p>'+
                            '<p style="text-align: right"><button class="details" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>查看详情</button>' +
                            '<button class="delet" style="'+display+'" frpId='+res.datas[i].frpId+'>删除</button></p>'+
                            '</li>'
                    }
                    $('.content').html(appele)
                }else{
                    var str='<div style="font-size: .4rem;text-align: center;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
                    $('.content').html(str)
                }

            }
        })


    });

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
            return '<a href="javascript:;" style="display: inline-block;margin-bottom: 7px">'+str+title+'</a>'
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
                    url: '/document/selWillDocSendOrReceive',
                    data: {
                        page: page,
                        pageSize: size,
                        useFlag:true,
                        documentType:'1',

                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            for (var i = 0; i < res.datas.length; i++) {
                                var display = ''
                                if (res.datas[i].step == '1') {
                                    display = 'display:inline-block';
                                }else{
                                    display = 'none'
                                }
                                app+='<li class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;" flowId='+res.datas[i].flowId+'  prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+'   runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>'+
                                    '<div class="nav1">'+
                                    '<span class="nav2">'+ title(res.datas[i].title,res.datas[i].workLevel)+'</span>'+
                                    '<span class="fs14">'+dmerStatusStr(res.datas[i].prFlag)+'</span>'+
                                    '</div>'+
                                    '<div class="step" style="">'+res.datas[i].step+'步：'+res.datas[i].prcsName +'</div>' +
                                    '<p class="nav3"><span class="ac2">'+res.datas[i].createrName+'</span></p>'+
                                    '<p class="nav3"><span class="ac2">'+issue(res.datas[i].createTime)+'</span></p>'+
                                    '<p style="text-align: right"><button class="details" flowId='+res.datas[i].flowId+' prcsId='+res.datas[i].realPrcsId+'  flowStep='+res.datas[i].step+' runId='+res.datas[i].runId+' tabId='+res.datas[i].id+' tableName='+res.datas[i].tableName+' opFlag='+res.datas[i].opFlag+'>查看详情</button>' +
                                    '<button class="delet" style="'+display+'" frpId='+res.datas[i].frpId+'>删除</button></p>'+
                                    '</li>'

                            }
                            // 如果没有数据
                            if(res.datas.length==0){
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
    mui("ul").on("tap","li",function(){
        var flowId=$(this).attr('flowId')
        var prcsId=$(this).attr('prcsId')
        var flowStep=$(this).attr('flowStep')
        var runId=$(this).attr('runId')
        var tabId = $(this).attr('tabId')
        var tableName = $(this).attr('tableName')
        var opFlag = $(this).attr('opFlag')
        mui.openWindow({
            url: '/workflow/work/workformh5?&flowId='+flowId+'&prcsId='+prcsId+'&flowStep='+flowStep+'&runId='+runId+'&tabId='+tabId+'&tableName='+tableName+'&isNomalType=false&hidden=true&opFlag='+opFlag+'&type=EWC'
        });
    });
    //删除
    mui("ul").on("tap","li .delet",function(){
        event.stopPropagation();
        var frpId=$(this).attr('frpId')
        //删除判断
        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '../../workflow/work/deleteRunPrcs',
                type: 'get',
                dataType: 'json',
                data: {
                    id: frpId
                },
                success: function (obj) {
                    if (obj.code == '100066'){
                        layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                    } else {
                        //第三方扩展皮肤
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                    }
                    location.reload();
                }
            })
        }, function () {
            layer.closeAll();

        });
    })
    //    查看详情
    mui("ul").on("tap","li .details",function(){
        event.stopPropagation();
        var flowId=$(this).attr('flowId')
        var prcsId=$(this).attr('prcsId')
        var flowStep=$(this).attr('flowStep')
        var runId=$(this).attr('runId')
        var tabId = $(this).attr('tabId')
        var tableName = $(this).attr('tableName')
        var opFlag = $(this).attr('opFlag')
        mui.openWindow({
            url: '/workflow/work/workformh5PreView?flowId='+flowId+'&flowStep='+flowStep+'' +
                '&tabId='+tabId+'&tableName='+tableName+'&runId='+runId+'&' +
                'prcsId='+prcsId+'&isNomalType=false&hidden=true'+'&type=EWC'
        });

    })

</script>

</html>
