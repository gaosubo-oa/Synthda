<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>事务提醒</title>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.1"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        .ullist{
            background: #fff;
        }
        .ullist>li{
            display: none;
        }
        .boxts{
            position: relative;
            display: flex;
            align-items: center;
            box-sizing: border-box;
            padding: 0.25rem;
            border-bottom: 1px solid #ccd6eb;
            background: #dfeafe;
        }
        .boxts img{
            width: 0.4rem;
            height: 0.4rem;
            margin: 0 0.4rem;
        }
        .boxts span{
            font-size: 0.3rem;
        }
        .boxts .jt{
            position: absolute;
            width:0.27rem;
            height: 0.27rem;
            right: 0;
        }
        .boxts .nums{
            position: absolute;
            right: 1rem;
            font-size: 0.25rem;
        }
        .custom_two li{
            width: 100%;
            margin: auto;
             /*height: 60px;*/
             border-bottom: 1px solid #eee;
        }
        .custom_two li{
            box-sizing: border-box;
            padding: 0.1rem 0.5rem;
        }
        .custom_two p{
            position: relative;
            box-sizing: border-box;
            padding: 0.1rem;
        }
        .times{
            position: absolute;
            right: 0;
        }
        .search_two_all{
            display: none;
        }
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body style="background: #f7f7f7;">
<div class="mui-content">
    <div class="no_data" style="text-align: center;border: none; display: none;background: #f7f7f7;">
        <img style="padding-top: 62px;display: inline-block;" src="/img/main_img/shouyekong.png" alt="">
        <span style="text-align: center;color: #666;display: block;padding: 5px 0;">暂无数据</span>
    </div>

    <ul class="ullist">
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/swyj.png" alt="">
                <span>邮件</span>
                <span class="mui-badge mui-badge-primary nums yjnums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="">
                <ul class="custom_two yjcont">
                </ul>
            </div>
        </li>
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/gg.png" alt="">
                <span>公告</span>
                <span class="mui-badge mui-badge-primary nums ggnums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="">
                <ul class="custom_two ggcont">
                </ul>
            </div>
        </li>
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/gzl.png" alt="">
                <span>工作流</span>
                <span class="mui-badge mui-badge-primary nums gzlnums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="">
                <ul class="custom_two gzlcont">
                </ul>
            </div>
        </li>
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/swyj.png" alt="">
                <span>日程</span>
                <span class="mui-badge mui-badge-primary nums rcnums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="">
                <ul class="custom_two richeng">
                </ul>
            </div>
        </li>
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/swyj.png" alt="">
                <span>工作日志</span>
                <span class="mui-badge mui-badge-primary nums gzrznums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="display: none">
                <ul class="custom_two gzrz">
                </ul>
            </div>
        </li>
        <li>
            <div class="boxts" type="0">
                <img src="/img/ewx/gg.png" alt="">
                <span>公安值班</span>
                <span class="mui-badge mui-badge-primary nums gazbnums">0</span>
                <img class="jt" src="/img/ewx/close.png" alt="">
            </div>
            <div class="search_two_all" style="display: none">
                <ul class="custom_two gazb">
                </ul>
            </div>
        </li>
    </ul>

</div>
</body>
<script>
    function check(name){
        if(name=='undefined'){
            return ''
        }else{
            return name;
        }
    }

    $('.boxts').click(function () {
        var type =$(this).attr('type');
        if(type == 0){
            $(this).attr('type','1');
            $(this).children('.jt').attr('src','/img/ewx/cus_open.png');
            $(this).next('.search_two_all').show()
        }else {
            $(this).attr('type','0');
            $(this).children('.jt').attr('src','/img/ewx/close.png');
            $(this).next('.search_two_all').hide()
        }
    })



        mui.ajax('/todoList/smsListByType',{
            data:'',
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            success:function(data){
                var nodata_flag = true;
                var data = data.data;
                // 邮件
                if(data.email){
                    $('.yjnums').html(data.email.length);
                    var str = '';
                    if(data.email.length>0){
                        for(var i=0;i<data.email.length;i++){
                            str+='<li url="/ewx/emailDetail?flag=inbox&emailID='+data.email[i].qid+'&dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.email[i].content+'</span></p>'+
                                '<p><span style="color: RdutyManagement/transactionRemind#333">'+data.email[i].userName+'</span> <span class="times">'+data.email[i].sendTimeStr+'</span></p></li>'
                        }

                        $('.yjcont').html(str)
                        $('.yjcont').parents('li').show()

                        nodata_flag = false;
                    }

                }
//                日程
                if(data.calendars){

                    $('.rcnums').html(data.calendars.length);
                    var str = '';
                    if(data.calendars.length>0){
                        for(var i=0;i<data.calendars.length;i++){
                            str+='<li url="/ewx/calendar?dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.calendars[i].content+'</span></p>'+
                                '<p><span style="color: #333">'+data.calendars[i].userName+'</span> <span class="times">'+data.calendars[i].sendTimeStr+'</span></p></li>'
                        }


                        $('.richeng').html(str)
                        $('.richeng').parents('li').show()

                        nodata_flag = false;
                    }

                }
                //公告
                if(data.notify){
                    $('.ggnums').html(data.notify.length);
                    var str = '';
                    if(data.notify.length>0){
                        for(var j=0;j<data.notify.length;j++){
                            str+='<li url="'+data.notify[j].remindUrl.replace('/notice/appprove','/ewx/noticeDetail')+'&dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.notify[j].content+'</span></p>'+
                                '<p><span style="color: #333">'+data.notify[j].userName+'</span> <span class="times">'+data.notify[j].sendTimeStr+'</span></p></li>'
                        }

                        $('.ggcont').html(str)
                        $('.ggcont').parents('li').show()

                        nodata_flag = false;
                    }

                }
                //值班
                if(data.dutypoliceusers){

                    $('.gazbnums').html(data.dutypoliceusers.length);
                    var str = '';
                    if(data.dutypoliceusers.length>0){
                        for(var i=0;i<data.dutypoliceusers.length;i++){
                            str+='<li url="'+data.dutypoliceusers[i].remindUrl.replace('/dutyManagement/transactionRemind','/DutyPoliceUsers/dutyDetails')+'&dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.dutypoliceusers[i].content+'</span></p>'+
                                '<p><span style="color: #333">'+data.dutypoliceusers[i].userName+'</span> <span class="times">'+data.dutypoliceusers[i].sendTimeStr+'</span></p></li>'
                        }


                        $('.gazb').html(str)
                        $('.gazb').parents('li').show()

                        nodata_flag = false;
                    }

                }
                //                工作日志
                if(data.diarys){
                    $('.gzrznums').html(data.diarys.length);
                    var str = '';
                    if(data.diarys.length>0){
                        for(var j=0;j<data.diarys.length;j++){
                            str+='<li url="'+data.diarys[j].remindUrl.replace('/diary/details?ID','/ewx/consult?id')+'&dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.diarys[j].content+'</span></p>'+
                                '<p><span style="color: #333">'+data.diarys[j].userName+'</span> <span class="times">'+data.diarys[j].sendTimeStr+'</span></p></li>'
                        }

                        $('.gzrz').html(str)
                        $('.gzrz').parents('li').show()

                        nodata_flag = false;
                    }

                }

                //  工作流
                if(data.workFlow){
                    $('.gzlnums').html(data.workFlow.length);
                    var str = '';
                    if(data.workFlow.length>0){
                        for(var n=0;n<data.workFlow.length;n++){
                            str+='<li url="'+data.workFlow[n].remindUrl.replace('workform','workformh5')+'&type=EWC&dataType='+check($.GetRequest().dataType)+'"><p><span style="color: #333">主题：</span><span>'+data.workFlow[n].content+'</span></p>'+
                                '<p><span style="color: #333">'+data.workFlow[n].userName+'</span> <span class="times">'+data.workFlow[n].sendTimeStr+'</span></p></li>'
                        }

                        $('.gzlcont').html(str)
                        $('.gzlcont').parents('li').show()

                        nodata_flag = false;
                    }

                }



                // 判断是否现实无数据图标
                if(nodata_flag)
                    $('.no_data').show();

            }
        });

    $('.custom_two').on('click','li',function(){
        var url = $(this).attr('url');
        mui.openWindow({
            url:url
        });
    })


</script>
</html>