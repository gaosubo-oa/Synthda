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
    <title>会议</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
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
            margin:0.3rem .67rem 0 .4rem;
            color: #646464;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            position: relative;
        }
        .nav3{
            margin: 0 .4rem;
            color: #646464;
            /*border-bottom: 1px solid #5a8fd5;*/
            line-height: 0.7rem;
        }
        .fs14{
            font-size: 0.3rem;
            color: #999;
            float: right;
        }
        .ac{
            color: #5087d0;
            font-size: 0.28rem;
        }
        .ac2{
            color: #666;
            font-size: 0.28rem;
            margin-left: 0.3rem;
        }
        .hd{
            height: 0.85rem;
        }
        .list{
            display: block;
        }
        .content{
            margin-bottom: .38rem;
        }

        .nav-sub{
            position: relative;
        }
        .nav-sub:after {
            position: absolute;
            top: 46px;
            right: 22px;
            left: 12px;
            height: 1px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #ccc;;
        }
    </style>
</head>
<body>
<%--<header>--%>
    <%--<i><a href="/m/getMainddh5" style="color: #fff">返回</a></i>--%>
    <%--<span>公告</span>--%>
    <%--<i style="width: .4rem"></i>--%>
<%--</header>--%>
<%--<div class="hd"></div>--%>
<div class="" style="background: #f4f4f4;">
    <div class="" style="background-color: #f2f2f2;text-align: center;">
        <%--<input id="newAdd" style="" type="button" value="新建申请">--%>
        <a href="/ewx/meetingAdd"><input  type="button" value="新建申请" style="background:blue;color: white;width: 50%;"></a>
    </div>
    <div class="content">

    </div>

</div>
</body>
<script>
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


    function repalceHtml(str){
        var dd=str.replace(/<\/?.+?>/g,"");
        var dds=dd.replace(/ /g,"");//dds为得到后的内容
        return dds;
    }
   /* $('#search').watch(function(value) {
        $.ajax({
            url:'/notice/notifyManage',
            type:'get',
            data:{
                page:1,
                pageSize:999,
                useFlag:false,
                queryField:value,
                typeId:'',
                read:'',
                sendTime:''
            },
            dataType:'json',
            success:function(res){
                if(res.flag){
                    var app="";
                    for(var i=0;i<res.obj.length;i++){
                        var str1=repalceHtml(res.obj[i].content)
                        str1=str1.replace(/&nbsp;/ig, "");
                        app+='<div class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;">'+
                            '<a class="list" href="/ewx/noticeDetail?notifyId='+res.obj[i].notifyId+'&dataType='+$.GetRequest().dataType+'" style="color: #333" notifyId="'+res.obj[i].notifyId+'">'+
                            '<div class="nav1">'+
                            '<span class="nav2">'+res.obj[i].subject+'</span>'+
                            '<span class="fs14">'+res.obj[i].auditDate+'</span>'+
                            '</div>'+
                            '<div style="position: relative;"><div class="nav1" style="width: 70%;display:inline-block;margin-right: 1.7rem;height: 0.4rem;line-height: .4rem;">'+str1+'</div>'+function(){if(res.obj[i].attachmentName!=''){return '<img style="position: absolute;top: .38rem;right: .7rem;" src="../img/enclosure.png" alt="">'}else{return ''}}()+'</div>'+
                            '</a>'+
                            '<p class="nav3"><a href="javascript:;" class="ac">'+function(){if(res.obj[i].typeName==''){return '所有类型'}else{return  res.obj[i].typeName}}()+'</a><span class="ac2">'+res.obj[i].name+'</span></p>'+
                            '</div>'
                    }
                    $('.content').html(app)
                }else{
                    var str='<div style="font-size: .28rem;text-align: center;background-color: #ccc;height: .7rem;line-height: .7rem;margin-top: .1rem;">暂无数据！</div>'
                    $('.content').html(str)
                }

            }
        })


    });*/


    $(function() {
        // 页数
        var page = 0;
        // 每页展示5个
        var size = 6;

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
                    url: '/meeting/queryMeeting',
                    data: {
                        page: page,
                        pageSize: size,
                        useFlag: true,
                        typeId:'',
                        read:'',
                        sendTime:''
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            for (var i = 0; i < res.obj.length; i++) {
                                /*var str1=repalceHtml(res.obj[i].content)
                                str1=str1.replace(/&nbsp;/ig, "");*/
                                app += '<div class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;">' +
                                    '<a class="list" href="/ewx/meetingDetail?sid=' + res.obj[i].sid+ '" style="color: #333" notifyId="' + res.obj[i].notifyId + '">' +
                                    '<div class="nav1">' +
                                    '<span class="nav2">' + res.obj[i].meetName + '</span>' +
                                    '<span class="fs14">' + res.obj[i].statusName+ '</span>' +
                                    '</div>' +
                                    '<div style="position: relative;"><div class="nav1" style="width: 75%;display:inline-block;margin-right: 1.7rem;height: 0.4rem;line-height: .4rem;">'+ res.obj[i].startTime+'------'+res.obj[i].endTime+'</div>'
                                    + '</div>' +
                                    '</a>' +
                                    '<p class="nav3"><a href="javascript:;" class="ac">'
                                    /*+function () {
                                        if (res.obj[i].typeName == '') {
                                            return '所有类型'
                                        } else {
                                            return res.obj[i].typeName
                                        }
                                    }()*/
                                    + '</a><span class="ac2">' + res.obj[i].userName + '</span></p>' +
                                    '</div>'
                            }
                            // 如果没有数据
                            if(res.obj.length==0){
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

</script>

</html>