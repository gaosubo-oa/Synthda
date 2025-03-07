//待办工作流
function workDaiban(){
    $.ajax({
        url:'/workflow/work/selectWork',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 6,
            useFlag: true,
            userId:$.cookie('userId'),
            myworkconditions:'',
            flowId:245
        },
        success:function(res){
            var workFlow = res.obj;
            //加载门户工作流
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].receiptTime.replace(/\s/,' ')
                    daiba_li+='<li onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowRun.flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="n_img"><img onerror="imgerror(this,1)"  src="'+function () {
                            if(workFlow[m].avater != 0&&workFlow[m].avater != 1&&workFlow[m].avater != ''){
                                return '/img/user/'+workFlow[m].avater;
                            }
                            if(workFlow[m].sex == 0){
                                return '/img/user/boy.png';
                            }
                            else if(workFlow[m].sex == 1){
                                return '/img/user/girl.png';
                            }
                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].userName+'</h1>'+
                        '<h3 class="n_time"><p>'+workFlow[m].receiptTime.replace(/\s/,'<i style="margin: 0px 5px;"></i>')+'</p></h3>' +
                        '<a href="javascript:void(0)" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 92% !important;" title="'+workFlow[m].flowRun.runName+'">'+workFlow[m].flowRun.runName+'<span>&nbsp;</span></h2></a>'+      '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
                        '</li>'
                }
                $('.daiban').html(daiba_li);
            }else{
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.daiban').html(lis);
            }
        }
    })
}
//新闻
function administrivia(me) {
    $.ajax({
        url: '/news/newsManage',
        type: 'get',
        data:{
            page:'1',
            read:$(me).attr('data-bool'),
            pageSize:'5',
            useFlag:'true'
        },
        dataType: 'json',
        success: function (obj) {

            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times">' +function () {

                        if(data[i].newsDateTime!=undefined){
                            return data[i].newsDateTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                        }else {
                            return ''
                        }


                    }()  + '</div>' +
                    '</li>'
            }
            $('.new_all').html(li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.new_all').html(lis);
            }


        }
    });
}
//已办工作流
function workYiban(){
    $.ajax({
        url:'/workflow/work/selectEndWord',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 6,
            useFlag: true,
            userId:$.cookie('userId'),
            myworkconditions:'',
            flowId:245
        },
        success:function(res){
            var workFlow = res.obj;
            //加载门户工作流
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].receiptTime.replace(/\s/,' ')
                    daiba_li+='<li onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowRun.flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="n_img"><img onerror="imgerror(this,1)"  src="'+function () {
                            if(workFlow[m].avater != 0&&workFlow[m].avater != 1&&workFlow[m].avater != ''){
                                return '/img/user/'+workFlow[m].avater;
                            }
                            if(workFlow[m].sex == 0){
                                return '/img/user/boy.png';
                            }
                            else if(workFlow[m].sex == 1){
                                return '/img/user/girl.png';
                            }
                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].userName+'</h1>'+
                        '<h3 class="n_time"><p>'+workFlow[m].deliverTime.replace(/\s/,'<i style="margin: 0px 5px;"></i>')+'</p></h3>' +
                        '<a href="javascript:void(0)" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 92% !important;" title="'+workFlow[m].flowRun.runName+'">'+workFlow[m].flowRun.runName+'<span>&nbsp;</span></h2></a>'+      '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
                        '</li>'
                }
                $('.yiban').html(daiba_li);
            }else{
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.yiban').html(lis);
            }
        }
    })
}
//平台在办工作流
function workZaiban(){
    $.ajax({
        url:'/flowRun/queryFlowRun',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 6,
            useFlag: true,
            userId:'admin',
            runId:'',
            runName:'',
            state:'',
            workLevel:'',
            status:'1',
            beginDate:'',
            endDate:'',
            flowId:245
        },
        success:function(res){
            var workFlow = res.datas;
            //加载门户工作流
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].beginTime.replace(/\s/,' ')
                    daiba_li+='<li onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="n_img"><img onerror="imgerror(this,1)"  src="'+function () {
                            if(workFlow[m].avater != 0&&workFlow[m].avater != 1&&workFlow[m].avater != ''){
                                return '/img/user/'+workFlow[m].avater;
                            }
                            if(workFlow[m].sex == 0){
                                return '/img/user/boy.png';
                            }
                            else if(workFlow[m].sex == 1){
                                return '/img/user/girl.png';
                            }
                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].userName+'</h1>'+
                        '<h3 class="n_time"><p>'+workFlow[m].beginTime.replace(/\s/,'<i style="margin: 0px 5px;"></i>')+'</p></h3>' +
                        '<a href="javascript:void(0)" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 92% !important;" title="'+workFlow[m].runName+'">'+workFlow[m].runName+'<span>&nbsp;</span></h2></a>'+      '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
                        '</li>'
                }
                $('.zaiban').html(daiba_li);
            }else{
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.zaiban').html(lis);
            }
        }
    })
}
//获取我的门户的菜单模块
function getApplication(element) {
    $.ajax({
        type:'get',
        url:'/getMenu',
        dataType:'json',
        success:function (res) {
            var data=res.obj;
            if(res.obj.length > 0){
                var str='';
                if(res.obj.length > 6){
                    for(var i=0;i<6;i++){
                        str+='<div class="every_logo" menu_tid="'+data[i].id+'" onclick="parent.getMenuOpen(this)" data-url="'+data[i].url+'">'+
                            '<img src="/img/main_img/app/' +data[i].id+ '.png">'+
                            '<h2>'+data[i].name+'</h2>'+
                            '</div>'
                    }
                }else{
                    for(var i=0;i<data.length;i++){
                        str+='<div class="every_logo" menu_tid="'+data[i].id+'" onclick="parent.getMenuOpen(this)" data-url="'+data[i].url+'">'+
                            '<img src="/img/main_img/app/' +data[i].id+ '.png">'+
                            '<h2>'+data[i].name+'</h2>'+
                            '</div>'
                    }
                }
                element.html(str);
            }
        }
    })
}
$(function(){
    //待办工作
    workDaiban();
    //新闻(工作动态)
    administrivia($('[data-bool=""]'));
    //新闻(工作动态)tab切换按钮
    $('.c_head').delegate('div', 'click', function () {
        index = $(this).parent().find('div').index($(this));
        $(this).parent().find("div").removeClass("richeng_check");
        $(this).addClass("richeng_check");
    });
    //已办工作
    workYiban();
    //平台在办工作流
    workZaiban();
    //常用功能
    getApplication($('#application'));
})