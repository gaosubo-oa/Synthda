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
    <title>车辆审批</title>
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
        .btn{
            width: 1rem;
            height: 0.45rem;
            float: right;
            background-color: #009688;
            border: 0;
            color: #fff;
            margin-right: 0.2rem;
            border-radius: 0.05rem;
            font-size: 0.2rem;
            line-height: .4rem;
        }
        a:hover{
            cursor:pointer
        }
        .no-data-msg{
            font-size: 15px;
            line-height: 24px;
        }
    </style>
</head>
<body>
<div class="" style="background: #f4f4f4;padding-top: .07rem;box-sizing: border-box;">
    <%--<div class="" style="background-color: #f2f2f2;text-align: center;height: .75rem">--%>
        <%--&lt;%&ndash;<button class="btn">新建</button>&ndash;%&gt;--%>
        <%--<a href="/ewx/carAdd"><input  type="button" value="新建" style="background:blue;color: white;width: 50%;"></a>--%>

    <%--</div>--%>
    <div class="content">

    </div>

</div>
</body>
<script>
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
                var  nstr = "";
                var now = new Date();
                var nyear = now.getFullYear();
                var nmonth = now.getMonth()+1;
                if(nmonth<10){
                    nmonth = "0"+nmonth;
                }
                nstr = nyear+"-"+nmonth;
                $.ajax({
                    type: 'GET',
                    url: '/veHicleUsage/deptApproval',
                    data: {
                        // data:nstr,
                        page: page,
                        pageSize: size,
                        dmerStatus:0,
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            for (var i = 0; i < res.obj.length; i++) {
                                app+='<div class="nav-sub" style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);border-radius: .1rem;background-color: #fff;margin: .24rem .1rem;padding: .1rem 0;">'+
                                    '<a class="list" href="/ewx/carApprovalDetail?vuId='+res.obj[i].vuId+'" style="color: #333" vuId="'+res.obj[i].vuId+'">'+
                                    '<div class="nav1">'+
                                    '<span class="nav2">'+res.obj[i].vIdNum+'</span>'+
                                    '</div>'+
                                    '<div style="position: relative;">' +
                                    '<div class="nav1" style="width: 70%;display:inline-block;margin-right: 1.7rem;height: 0.4rem;line-height: .4rem;">'+res.obj[i].vuStart+'-----'+res.obj[i].vuStart+'</div>' +
                                    '</div>'+
                                    '</a>'+
                                    '<p class="nav3"><span class="ac2">'+res.obj[i].vuUserName+'</span></p>'+
                                    '</div>'
                            }
                            // 如果没有数据
                            if(res.obj.length==0){
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                                //app='<div style="text-align: center;"><span class="no-data-msg">暂无更多数据</span></div>'
                            }
                        } else {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                            //app='<div style="text-align: center;"><span class="no-data-msg">暂无数据</span></div>'
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