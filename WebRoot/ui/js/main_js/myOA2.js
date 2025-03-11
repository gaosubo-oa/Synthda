if (!Function.prototype.bind) {//bind方法
    Function.prototype.bind = function (oThis) {
        if (typeof this !== "function") {
            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        }
        var aArgs = Array.prototype.slice.call(arguments, 1),
            fToBind = this,
            fNOP = function () {},
            fBound = function () {
                return fToBind.apply(this instanceof fNOP && oThis
                    ? this
                    : oThis,
                    aArgs.concat(Array.prototype.slice.call(arguments)));
            };
        fNOP.prototype = this.prototype;
        fBound.prototype = new fNOP();
        return fBound;
    };
}
var serverTime = '';
//获取国际语言标志
var type = getCookie("language");
var no_Data="";
if (type == 'zh_CN') {
    no_Data='暂无数据';
    /*    main_schedule = '日程安排';
     main_network = '网络硬盘';
     email_th_news = '新闻';
     ConferenceNotice = '会议通知';
     PleaseCheckMyMail = '请查看我的邮件';
     main_worklog = '工作日志';
     notice_title_notify = '公告通知';
     PublicSchoolAffairs = '校务公开管理';*/
} else if (type == 'en_US') {
    no_Data='No data';
    /*    main_schedule = 'Schedule';
     main_network = 'Network Disk';
     email_th_news = 'News';
     ConferenceNotice = 'Conference notice';
     PleaseCheckMyMail = 'Please check my mail';
     main_worklog = 'Work Log';
     notice_title_notify = 'Notice';
     PublicSchoolAffairs = 'Public administration of school affairs';*/
} else if (type == 'zh_TW') {
    no_Data='暫無數據';
    /* main_schedule = '日程安排';
     main_network = '網路硬碟';
     email_th_news = '新聞';
     ConferenceNotice = '會議通知';
     PleaseCheckMyMail = '請查看我的郵件';
     main_worklog = '工作日志';
     notice_title_notify = '公告通知';
     PublicSchoolAffairs = '校務公開管理';*/
} else {
    no_Data='暂无数据';
    /* main_schedule = '日程安排';
     main_network = '网络硬盘';
     email_th_news = '新闻';
     ConferenceNotice = '会议通知';
     PleaseCheckMyMail = '请查看我的邮件';
     main_worklog = '工作日志';
     notice_title_notify = '公告通知';
     PublicSchoolAffairs = '校务公开管理';*/
}

//当前日期日期计算
var now = null;
var  today_now=null;
function p(s) {
    return s < 10 ? '0' + s: s;
}

function urlHost(url) {
    document.location.href=url;
}


var myDate = new Date();
//获取当前年
var year=myDate.getFullYear();
//获取当前月
var month=myDate.getMonth()+1;
//获取当前日
var date=myDate.getDate();
var h=myDate.getHours();       //获取当前小时数(0-23)
var m=myDate.getMinutes();     //获取当前分钟数(0-59)
var s=myDate.getSeconds();

now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
today_now=year+'-'+p(month)+"-"+p(date);
// 获取某个时间格式的时间戳
var timestamp2 = Date.parse(new Date(now));
timestamp2 = timestamp2 / 1000;//当前时间
/*console.log(now + "的时间戳为：" + timestamp2);*/
//今天时间
var	timestamp1= Date.parse(new Date(today_now));
timestamp1 = timestamp1 / 1000;//当前今天时间
//明天时间
var timestamp3=timestamp1+86400;
// 后天时间
var timestamp4=timestamp3+86400;
//跳转页面
function tiaozhuan(that) {
    $.popWindow($(that).attr('data-url'),'公告详情','20','150','1200px','600px')
}
//跳转机关党建弹窗
function jiguanWin(that){
    $.popWindow($(that).attr('data-url'),'公共文件柜','20','150','1200px','600px')
}
//跳转工作动态弹窗
function statuWin(that){
    $.popWindow($(that).attr('data-url'),'查看工作动态','20','150','1200px','600px')
}
//跳转速卓审批入口页面
function suzhuoOpen(me){
    window.open($(me).attr('data-url'))
}
//公共文件柜详情页面
function publicWin(me){
    var rl = $(me).attr('data-url')
    $.popWindow(rl,'公共文件柜','20','150','1400px','800px')
}
//个人文件柜详情页面
function personWin(me){
    var rl = $(me).attr('data-url')
    $.popWindow(rl,'个人文件柜','20','150','1400px','800px')
}

//今日看板获取时间
function getNowTime() {
    var nowTime = new Date().getTime();
    serverTime = nowTime;
    var date1 = new Date(nowTime).Format('MM月dd日');
    var date2 = new Date(nowTime).Format('hh:mm');
    $('.date').text(date1);
    $('.time').text(date2);
    var date3 = new Date(nowTime).Format('yyyy-MM-dd ');
    var date4 = new Date(nowTime).Format(' hh:mm:ss');
    $('.daibantop .left h3').text(date3);
    $('.daibantop .left h4').text(date4);
}


//今日看板-A(新版)
function dairy(data){
    var str = '<br>';
    $('.daibans .right strong').text(data.userName);

    //若职务为空显示主角色
    if(data.postName==undefined || data.postName ==''){
        $('.daibans .right .zhiwei').text(data.userPrivName);
    }else{
        $('.daibans .right .zhiwei').text(data.postName);
    }

    if (data.diary != undefined) {
        if (data.diary.subject == undefined || data.diary.subject == '') {
            $('.daibanbuttom .buttom').text('天天有个好心情!');
        } else {
            $('.daibanbuttom .buttom').text(data.diary.subject);
        }
    } else {
        $('.daibanbuttom .buttom').text('天天有个好心情!');
    }

    var str = '';
    if (data.avatar != 0 && data.avatar != 1 && data.avatar != '') {
        str = '/img/user/' + data.avatar;
    } else {
        if (data.sex == 0) {
            str = '/img/user/boy.png';
        }
        else if (data.sex == 1) {
            str = '/img/user/girl.png';
        }
    }

    $('.nameurl').removeAttr('src')
    $('.nameurl').attr('src',str)

}
//今日看板-B(旧版)
function dairyOld(data) {
    $('.daibans .rightOld strong').text(data.userName);
    /*if(data.postName && data.deptName){
        $('.daibans .rightOld .zhiwei').text(data.deptName+','+data.postName);
    }
    if(data.postName == undefined){
        $('.daibans .rightOld .zhiwei').text(data.deptName);
    }
    if(data.deptName == undefined){
        $('.daibans .rightOld .zhiwei').text(data.postName);
    }*/
    //若职务为空显示主角色
    if(data.postName==undefined || data.postName ==''){
        $('.zhiweiOld').text(data.userPrivName);
        $('.zhiweiOld').attr('title',data.userPrivName);
    }else{
        $('.zhiweiOld').text(data.postName);
        $('.zhiweiOld').attr('title',data.postName);
    }
    if (data.diary != undefined) {
        if (data.diary.subject == undefined || data.diary.subject == '') {
            $('.daibanbuttom .buttom').text('天天有个好心情!');
        } else {
            $('.daibanbuttom .buttom').text(data.diary.subject);
        }
    } else {
        $('.daibanbuttom .buttom').text('天天有个好心情!');
    }

    var str = '';
    if (data.avatar != 0 && data.avatar != 1 && data.avatar != '') {
        str = '/img/user/' + data.avatar;
    } else {
        if (data.sex == 0) {
            str = '/img/user/boy.png';
        }
        else if (data.sex == 1) {
            str = '/img/user/girl.png';
        }
    }

    $('.nameurlOld').removeAttr('src')
    $('.nameurlOld').attr('src',str)

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
//公告查询方法 未读
function announcement(me){
    $("#sxs").hide()
    $("#sx").show()
    var typeId=''
    if($(me).attr('read')=='noRead'){
        $(me).attr('data-bool',$(me).parent().prev().find('option:selected').attr('data-bool'))
        $(me).parent().siblings('.more_notice').attr('url', '/notice/allNotifications');
        typeId=$(me).attr('data-bool')
    }else{
        $(me).parent().next().next().attr('url', '/notice/allNotifications')
        typeId=$(me).find('option:selected').attr('data-bool')
    }
    var obj={
        read:0,
        page:1,
        pageSize:6,
        useFlag:'true',
        // typeId:$(me).attr('data-bool')
        typeId:typeId
    };
    $.ajax({
        url:"/notice/notifyManage",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {
            var data = obj.obj;
            /*console.log(data);*/
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].notifyDateTime!=undefined){
                        return data[i].notifyDateTime.split(/\s/g)[0]
                    }else {
                        return ''
                    }
                }()

                str_li += '<li style="padding: 0 15px; box-sizing: border-box;white-space: nowrap;margin-bottom: 0px" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                    '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }
                    }()+'" alt="">' +
                    '<h1>' + data[i].name + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看我的公告</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].subject + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';


            }
            $('.no_read_notice_two').html(str_li);
            //console.log(notice_li)
            // console.log($('.right_notice').html())
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">暂无数据，将为您跳到全部消息列表</h2>' +
                    '</div>';
                $('.no_read_notice_two').html(lis);
            }
            if(data == ''){
                announcementsAll()
                $('#all_notice').removeClass('active');
                $('#yidus').removeClass('active');
                $('#yiduAll').addClass('active');
            }
        }
    })
}

//公告查询方法 已读
function announcements(me){
    $("#sx").hide()
    $("#sxs").show()
    var typeId=''
    if($(me).attr('read')=='okRead'){
        $(me).attr('data-bool',$(me).parent().prev().find('option:selected').attr('data-bool'))
        $(me).parent().siblings('.more_notice').attr('url', '/notice/InformTheView');
        typeId=$(me).attr('data-bool')
    }else{
        $(me).parent().next().next().attr('url', '/notice/allNotifications')
        typeId=$(me).find('option:selected').attr('data-bool')
    }
    var obj={
        read:1,
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:typeId
    };
    $.ajax({
        url:"/notice/notifyManage",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {

            var data = obj.obj;
            /*console.log(data);*/
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].notifyDateTime!=undefined){
                        return data[i].notifyDateTime.split(/\s/g)[0]
                    }else {
                        return ''
                    }
                }()
                /*var time=data[i].notifyDateTime.slice(0,10);*/
                /*console.log(time);*/
                // str_li += '<li style="height:50px;margin-top:-8px" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '"><div class="n_imgs" style="width: 10px;height: 10px;margin-left: 12px;"><img  onerror="imgerror(this,1)" src="'+function () {
                //         if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                //             return '/img/data_point.png';
                //         }
                //         if(data[i].users.sex == 0){
                //             return '/img/data_point.png';
                //         }
                //         else if(data[i].users.sex == 1){
                //             return '/img/data_point.png';
                //         }
                //     }()+'"></div><div class="n_words" style="margin-top:-8px;margin-left:38px">' +
                //     '<h3 class="n_time" style="margin-left: 45%;margin-top: 0%">' +
                //     '<p style="margin-top: 8%;font-size:11pt">' + strnbsp + '</p>' +
                //     '</h3><a  style="color:#000;" class="public_title" target="_blank"><h2 style="margin-bottom: 0%" class="n_title" data-tid="' + data[i].notifyId + '" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                //     ''+function () {
                //         if(data[i].attachmentId==''){
                //             return ''
                //         } else
                //         {
                //             // return '<img class="n_accessory" src="/img/main_img/accessory.png" alt="">'
                //             return ''
                //         }
                //
                //     }()+'</div></li>'

                str_li += '<li style="padding: 0 15px; box-sizing: border-box;white-space: nowrap;margin-bottom: 0px" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                    '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }
                    }()+'" alt="">' +
                    '<h1>' + data[i].name + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看我的公告</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].subject + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';


            }

            $('.no_read_notice_two').html(str_li);
            //console.log(notice_li)

            // console.log($('.right_notice').html())

            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.no_read_notice_two').html(lis);
            }

        }
    })

}

function announcementsAll() {
    var obj={
        read:'',
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:''
    };
    $.ajax({
        url:"/notice/notifyManage",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {

            var data = obj.obj;
            /*console.log(data);*/
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].notifyDateTime!=undefined){
                        return data[i].notifyDateTime.split(/\s/g)[0]
                    }else {
                        return ''
                    }
                }()

                str_li += '<li style="padding: 0 10px; box-sizing: border-box;white-space: nowrap;margin-bottom: 0px" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                    '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }
                    }()+'" alt="">' +
                    '<h1>' + data[i].name + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看我的公告</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].subject + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';


            }

            $('.no_read_notice_two').html(str_li);
            //console.log(notice_li)

            // console.log($('.right_notice').html())

            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.no_read_notice_two').html(lis);
            }

        }
    })
}

//业务审批待办
function annount(me) {
    $("#yws").hide()
    $("#yw").show()
    $(me).parent().siblings('.examine').attr('url', '/workflow/work/workList');
    $.ajax({
        url:'/workflow/work/selectWork',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 5,
            useFlag: true,
            userId:$.cookie('userId')
        },
        success:function(res){
            var workFlow = res.obj;
            if(res.totleNum==undefined || res.totleNum==''){
                $('.workflowNum').html('0');
                $('.workflowNumOld').html('0');
            }else{
                $('.workflowNum').html(res.totleNum);
                $('.workflowNumOld').html(res.totleNum);
            }

            //加载门户工作、业务审批
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].receiptTime.replace(/\s/,' ')
                    daiba_li+='<li style="padding: 0 5px;box-sizing: border-box;" onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowRun.flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="n_img" style="margin-right:5px;margin-top: 4px; "><img style="margin-left: 16px;border-radius:50%"  onerror="imgerror(this,1)"  src="'+function () {
                            if (workFlow[m].flowRun.avatar != 0 && workFlow[m].flowRun.avatar != 1 && workFlow[m].flowRun.avatar != '') {
                                return '/img/user/' + workFlow[m].flowRun.avatar;
                            }else{
                                if(workFlow[m].flowRun.sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(workFlow[m].flowRun.sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }

                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].flowRun.userName+'</h1>'+
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+workFlow[m].receiptTime.split(/\s/)[0]+'</p></h3>' +
                        '<a href="javascript:void(0)" style="display: inline-block;width: 65%;" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 100% !important;" title="'+workFlow[m].flowRun.runName+'">'+workFlow[m].flowRun.runName+'<span>&nbsp;</span></h2></a>'+      '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
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


//业务审批已办
function announts(me) {
    $("#yw").hide()
    $("#yws").show()
    $(me).parent().siblings('.examine').attr('url', '/workflow/work/endwork');
    $.ajax({
        url:'/workflow/work/selectEndWord',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 5,
            useFlag: true,
            userId:$.cookie('userId')
        },
        success:function(res){
            var workFlow = res.obj;
            if(res.totleNum==undefined || res.totleNum==''){
                $('.workflowNum').html('0');
                $('.workflowNumOld').html('0');
            }else{
                $('.workflowNum').html(res.totleNum);
                $('.workflowNumOld').html(res.totleNum);
            }
            // //加载门户工作、业务审批
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].deliverTime.replace(/\s/,' ')
                    daiba_li+='<li style="padding: 0 5px;box-sizing: border-box;" onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowRun.flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="n_img" style="margin-right:5px;margin-top: 5px; "><img style="border-radius: 50%;" onerror="imgerror(this,1)"  src="'+function () {
                            if (workFlow[m].flowRun.avatar != 0 && workFlow[m].flowRun.avatar != 1 && workFlow[m].flowRun.avatar != '') {
                                return '/img/user/' + workFlow[m].flowRun.avatar;
                            }else {
                                if(workFlow[m].flowRun.sex == 0){
                                    return '/img/user/boy.png';
                                }
                                if(workFlow[m].flowRun.sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }

                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].flowRun.userName+'</h1>'+
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+workFlow[m].deliverTime.split(/\s/)[0]+'</p></h3>' +
                        '<a href="javascript:void(0)" style="display: inline-block;width: 65%;" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 100% !important;" title="'+workFlow[m].flowRun.runName+'">'+workFlow[m].flowRun.runName+'<span>&nbsp;</span></h2></a>'+      '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
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


/*//待办发文
function amange(me) {
    $("#gw").show()
    $("#gws").hide()
    $("#gl").hide()
    $("#gls").hide()
    $(me).parent().siblings('.more_emild').attr('url', '/document/makeADraft');
    $.ajax({
        url: '/document/selWillDocSendOrReceive?documentType=0 ',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.datas;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
                            if(data[i].createTime.indexOf('.') > -1){
                                if(data[i].createTime.indexOf(' ') > -1){
                                    return data[i].createTime.split(' ')[0];
                                }else{
                                    return data[i].createTime;
                                }
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 65%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }


            $('.gongwen').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.gongwen').html(lis);
            }
        }
    });

}*/
/*//待办收文
function amanges(me) {
    $("#gw").hide()
    $("#gws").show()
    $("#gl").hide()
    $("#gls").hide()
    $(me).parent().siblings('.more_emild').attr('url', '/document/inAbeyance');
    $.ajax({
        url: '/document/selWillDocSendOrReceive?documentType=1',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.datas;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
                            if(data[i].createTime.indexOf('.') > -1){
                                if(data[i].createTime.indexOf(' ') > -1){
                                    return data[i].createTime.split(' ')[0];
                                }else{
                                    return data[i].createTime;
                                }
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 65%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }


            $('.gongwen').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.gongwen').html(lis);
            }
        }
    });

}*/

//已办发文
function amanget(me) {
    $("#gw").hide()
    $("#gws").hide()
    $("#gl").show()
    $("#gls").hide()
    $(me).parent().siblings('.more_emild').attr('url', '/document/IthasBeenDone');
    $.ajax({
        url: '/document/selOverDocSendOrReceive?documentType=0 ',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.datas;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workformPreView?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
                            if(data[i].createTime.indexOf('.') > -1){
                                if(data[i].createTime.indexOf(' ') > -1){
                                    return data[i].createTime.split(' ')[0];
                                }else{
                                    return data[i].createTime;
                                }
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 65%;" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }


            $('.gongwen').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.gongwen').html(lis);
            }
        }
    });
}

//已办收文
function amangets(me) {
    $("#gw").hide()
    $("#gws").hide()
    $("#gl").hide()
    $("#gls").show()
    $(me).parent().siblings('.more_emild').attr('url', '/document/received');
    $.ajax({
        url: '/document/selOverDocSendOrReceive?documentType=1 ',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.datas;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workformPreView?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
                            if(data[i].createTime.indexOf('.') > -1){
                                if(data[i].createTime.indexOf(' ') > -1){
                                    return data[i].createTime.split(' ')[0];
                                }else{
                                    return data[i].createTime;
                                }
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 65%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }


            $('.gongwen').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.gongwen').html(lis);
            }
        }
    });
}

//公文管理更多
function documentMore(me) {
    var url=$(me).prev().find('.active').attr('url');
    var urls=$(me).prev().find('.active').attr('urls');
    var element = $(me).prev().find('.active');
    if(urls == '0'){
        var tid = '650105';
    }else if(urls == '1'){
        var tid = '650505';
    }else if(urls == '2'){
        var tid = '650110';
    }else if(urls == '3'){
        var tid = '650510';
    }
    parent.getUrlMenuOpen(tid,element);
}


//新闻已读
function administrivias(me) {
    $("#xin").hide()
    $("#xins").show()
    var typeId=''
    if($(me).attr('read')=='okRead'){
        $(me).attr('data-bool',$(me).prev().prev().find('option:selected').attr('data-bool'))
        $(me).siblings('.more_news').attr('more_type', '2');
        typeId=$(me).attr('data-bool')
    }else{
        $(me).siblings('.more_news').attr('more_type', '2');
        typeId=$(me).find('option:selected').attr('data-bool')
    }
    $.ajax({
        url: '/news/newsManage',
        type: 'get',
        data:{
            page:'1',
            read:1,
            pageSize:'6',
            useFlag:'true',
            typeId:typeId,
            ismyOA:true,
        },
        dataType: 'json',
        success: function (obj) {

            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
                var isZhiding;
                var divColor;
                if(data[i].top == '0'){
                    isZhiding = 'none';
                    divColor = ''
                }else{
                    isZhiding = 'inline-block'
                    divColor = '#f5f5f5'
                }
                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                    // '<div style="margin-left:12px;">' +
                    // '<img src="/img/data_point.png">' +
                    // '</div>' +
                    '<a><div class="newsDiv" style="width: 92%;margin-left: 4%;position: relative;">' +
                    function(){
                        if(data[i].titlePicAttachment != undefined && data[i].titlePicAttachment != ''){
                            return '<div style="width: 20%">' +
                                '<img src="/xs?'+data[i].titlePicAttachment.attUrl +'" style="height: 68px;margin-top: 0px"></div>'
                        }else{
                            return ''
                        }
                    }() +
                    '<div style="width:80%"><div style="margin-left: 4%;"><img src="/img/main_img/myOA/re.png" style="display: ' + isZhiding +'"></div>' +
                    '<div class="richeng_title" title="' + data[i].subject + '" style="font-size: 17px;color: #0b8aff;width: 50%">' + data[i].subject + '</div>' +
                    '<span style="display: inline-block;margin-top: 8px;position: absolute;right: 10px">' + data[i].newsDateTime + '</span>'+
                    // '<div class="richeng_title nei" title="' + data[i].content + '" style="margin-left: 4%;margin-bottom: 5px;height: 30px!important;">' + data[i].content + '</div>' +
                    '</div></div></a>' +
                    // '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {
                    //
                    //     if(data[i].newsDateTime!=undefined){
                    //         return data[i].newsDateTime.split(/\s/g)[0];
                    //     }else {
                    //         return ''
                    //     }
                    //
                    //
                    // }()  + '</div>' +
                    '</li>'
            }
            $('.new_all').html(li);
            $('#newsMore').children('li').eq(0).find('.newsDiv').css('background','#f5f5f5')
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

//新闻全部
function administriviasAll() {
    $.ajax({
        url: '/news/newsManage',
        type: 'get',
        data:{
            page:'1',
            read:'',
            pageSize:'6',
            useFlag:'true',
            typeId:'',
            ismyOA:true,
        },
        dataType: 'json',
        success: function (obj) {

            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
                var isZhiding;
                var divColor;
                var sub = data[i].content
                var subs = sub.substr(0,25)
                if(data[i].top == '0'){
                    isZhiding = 'none';
                }else{
                    isZhiding = 'inline-block'
                }
                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                    // '<div style="margin-left:12px;">' +
                    // '<img src="/img/data_point.png">' +
                    // '</div>' +
                    '<a><div class="newsDiv" style="width: 92%;margin-left: 4%;position: relative;">' +
                    function(){
                        if(data[i].titlePicAttachment != undefined && data[i].titlePicAttachment != ''){
                            return '<div style="width: 20%">' +
                                '<img src="/xs?'+data[i].titlePicAttachment.attUrl +'" style="height: 68px;margin-top: 0px"></div>'
                        }else{
                            return ''
                        }
                    }() +
                    '<div style="width:80%"><div style="margin-left: 4%;"><img src="/img/main_img/myOA/re.png" style="display: ' + isZhiding +'"></div>' +
                    '<div class="richeng_title" title="' + data[i].subject + '" style="font-size: 17px;color: #0b8aff;width: 50%">' + data[i].subject + '</div>' +
                    '<span style="display: inline-block;margin-top: 8px;position: absolute;right: 10px">' + data[i].newsDateTime + '</span>'+
                    // '<div class="richeng_title nei" title="' + subs + '" style="margin-left: 4%;margin-bottom: 5px;height: 30px!important;">' + data[i].content + '</div>' +
                    '</div></div></a>' +
                    // '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {
                    //
                    //     if(data[i].newsDateTime!=undefined){
                    //         return data[i].newsDateTime.split(/\s/g)[0];
                    //     }else {
                    //         return ''
                    //     }
                    //
                    //
                    // }()  + '</div>' +
                    '</li>'
            }
            $('.new_all').html(li);
            $('#newsMore').children('li').eq(0).find('.newsDiv').css('background','#f5f5f5')
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.new_all').html(lis);
            }


        }
    });
    // console.log($('.new_all').html())
}

//新闻未读
function administrivia(me) {
    $("#xins").hide()
    $("#xin").show()
    var typeId=''
    if($(me).attr('read')=='noRead'){
        $(me).attr('data-bool',$(me).prev().find('option:selected').attr('data-bool'))
        $(me).siblings('.more_news').attr('more_type', '1');
        typeId=$(me).attr('data-bool')
    }else{
        $(me).parent().siblings('.more_news').attr('more_type', '1');
        typeId=$(me).find('option:selected').attr('data-bool')
    }
    $.ajax({
        url: '/news/newsManage',
        type: 'get',
        data:{
            page:'1',
            read:0,
            pageSize:'6',
            useFlag:'true',
            typeId:typeId,
            ismyOA:true,
        },
        dataType: 'json',
        success: function (obj) {
            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
                var isZhiding;
                var divColor;
                if(data[i].top == '0'){
                    isZhiding = 'none';
                    // divColor =
                }else{
                    isZhiding = 'inline-block'
                    // divColor = '#f5f5f5'
                }
                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                    // '<div style="margin-left:12px;">' +
                    // '<img src="/img/data_point.png">' +
                    // '</div>' +
                    '<a><div class="newsDiv" style="width: 92%;margin-left: 4%;position: relative;">' +
                    function(){
                        if(data[i].titlePicAttachment != undefined && data[i].titlePicAttachment != ''){
                            return '<div style="width: 20%">' +
                                '<img src="/xs?'+data[i].titlePicAttachment.attUrl +'" style="height: 68px;margin-top: 0px"></div>'
                        }else{
                            return ''
                        }
                    }() +

                    '<div style="width:80%"><div style="margin-left: 4%;"><img src="/img/main_img/myOA/xin.png" style="margin-right: 5px;"><img src="/img/main_img/myOA/re.png" style="display: ' + isZhiding +'"></div>' +
                    '<div class="richeng_title" title="' + data[i].subject + '" style="font-size: 17px;color: #0b8aff;width: 50%">' + data[i].subject + '</div>' +
                    '<span style="display: inline-block;margin-top: 8px;position: absolute;right: 10px">' + data[i].newsDateTime + '</span>'+
                    // '<div class="richeng_title nei"  style="margin-left: 4%;margin-bottom: 5px;height: 30px!important" title="' + data[i].content + '">' + data[i].content + '</div>' +
                    '</div></div></a>' +
                    // '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {
                    //
                    //     if(data[i].newsDateTime!=undefined){
                    //         return data[i].newsDateTime.split(/\s/g)[0];
                    //     }else {
                    //         return ''
                    //     }
                    //
                    //
                    // }()  + '</div>' +
                    '</li>'
            }
            $('.new_all').html(li);
            $('#newsMore').children('li').eq(0).find('.newsDiv').css('background','#f5f5f5')
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">暂无数据，将为您跳到全部消息列表</h2>' +
                    '</div>';
                $('.new_all').html(lis);
            }
            if(data == ''){
                administriviasAll()
                $('#xinnoRead').removeClass('active');
                $('#xinokRead').removeClass('active');
                $('#xinokReadAll').addClass('active');
            }
        }    });
}

//待阅事宜
//待阅
$.ajax({
    url: '/ToBeReadController/ReadFileIsRead',
    type: 'get',
    data:{
        isReadStr: 0,
        page: 1,
        pageSize: 6,
        useFlag: true
        // read:$(me).attr('data-bool'),

    },
    dataType: 'json',
    success: function (res) {

        var li = '';
        var data = res.data;
        for (var i = 0; i < data.length; i++) {
            li += '<li class="chedule_li" style="white-space: nowrap;height: 41px!important;" onclick="tiaozhuan(this)" data-url="/workflow/work/workformPreView?flowId='+data[i].flowId+'&flowStep=&runId='+data[i].runId+'&prcsId=&parent='+data[i].prcsId+'">' +
                '<div style="margin-left:12px;">' +
                '<img src="/img/data_point.png">' +
                '</div>' +
                '<a><div class="new_title richeng_title" style="width: 50%;" title="' + data[i].runName + '">' + data[i].runName + '</div></a>' +
                '<div class="every_times" style=" font-size: 11px;margin-top: 1px;width: 30%;right: 20px;position: absolute;">' +function () {

                    if(data[i].beginTime!=undefined){
                        return data[i].beginTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                        // return '<p>data[i].beginTime</p>'
                    }else {
                        return ''
                    }


                }()  + '</div>' +
                '<div class="dydiv">' +function () {
                    if(data[i].userName!=undefined){
                        return data[i].userName.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                    }else {
                        return ''
                    }

                }()+ '</div>' +
                '</li>'
        }
        $('.new_alls').html(li);
        if(res.data.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
            $('.new_alls').html(lis);
        }


    }
});
function adminiStrivias(me) {
    $.ajax({
        url: '/ToBeReadController/ReadFileIsRead',
        type: 'get',
        data:{
            isReadStr: 0,
            page: 1,
            pageSize: 6,
            useFlag: true
            // read:$(me).attr('data-bool'),

        },
        dataType: 'json',
        success: function (res) {

            var li = '';
            var data = res.data;
            for (var i = 0; i < data.length; i++) {
                li += '<li class="chedule_li" style="white-space: nowrap;height: 41px!important;" onclick="tiaozhuan(this)" data-url="/workflow/work/workformPreView?flowId='+data[i].flowId+'&flowStep=&runId='+data[i].runId+'&prcsId=&parent='+data[i].prcsId+'">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" style="width: 50%" title="' + data[i].runName + '">' + data[i].runName + '</div></a>' +
                    '<div class="every_times" style=" font-size: 11px;margin-top: 1px;width: 30%;right: 20px;position: absolute;">' +function () {

                        if(data[i].beginTime!=undefined){
                            return data[i].beginTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            // return '<p>data[i].beginTime</p>'
                        }else {
                            return ''
                        }


                    }()  + '</div>' +
                    '<div class="dydiv">' +function () {
                        if(data[i].userName!=undefined){
                            return data[i].userName.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                        }else {
                            return ''
                        }

                    }()+ '</div>' +
                    '</li>'
            }
            $('.new_alls').html(li);
            if(res.data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.new_alls').html(lis);
            }


        }
    });
}

//已阅
function adminiStrivis(me) {
    $.ajax({
        url: '/ToBeReadController/ReadFileIsRead',
        type: 'get',
        data:{
            isReadStr: 1,
            page: 1,
            pageSize: 6,
            useFlag: true
            // read:$(me).attr('data-bool'),

        },
        dataType: 'json',
        success: function (res) {

            var li = '';
            var data = res.data;
            for (var i = 0; i < data.length; i++) {
                li += '<li class="chedule_li" style="white-space: nowrap;height: 41px!important;" onclick="tiaozhuan(this)" data-url="/workflow/work/workformPreView?flowId='+data[i].flowId+'&flowStep=&runId='+data[i].runId+'&prcsId=&parent='+data[i].prcsId+'">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" style="width: 50%;!important;" title="' + data[i].runName + '">' + data[i].runName + '</div></a>' +
                    '<div class="every_times" style=" font-size: 11px;margin-top: 1px;width: 30%;right: 20px;position: absolute;">' +function () {

                        if(data[i].beginTime!=undefined){
                            return data[i].beginTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            // return '<p>data[i].beginTime</p>'
                        }else {
                            return ''
                        }


                    }()  + '</div>' +
                    '<div class="dydiv">' +function () {
                        if(data[i].userName!=undefined){
                            return data[i].userName.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                        }else {
                            return ''
                        }

                    }()+ '</div>' +
                    '</li>'
            }
            $('.new_alls').html(li);
            if(res.data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.new_alls').html(lis);
            }


        }
    });
}







//日程接口
function schedule(me){
    if(me.length == undefined){
        $(me).parent().find("div").removeClass("richeng_check");
        $(me).addClass("richeng_check");
    }

    if($(me).attr('data-url')=='/schedule/getAllschedule') {
        var obj = {userId: $.cookie('userId')}
    }else if($(me).attr('data-url')=='/schedule/getscheduleByDay'){
        var obj = {
            userId: $.cookie('userId')
        }
        if($(me).attr('data-schedule')==1){
            obj.time=timestamp1
        }else if($(me).attr('data-schedule')==2){
            obj.time=timestamp3
        }else {
            obj.time=timestamp4
        }
    }

    $.ajax({
        url: $(me).attr('data-url'),
        type: 'get',
        data:obj,
        dataType: 'json',
        success: function (obj) {
            if(obj.flag) {
                var data = obj.obj;
                var li = '';
                if(data.length < 7){
                    for (var i = 0; i < data.length; i++) {
                        li += '<li class="chedule_li" onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">' +
                            '<h2 style="display: none">日程安排</h2><div style="margin-left:12px;"><img src="/img/data_point.png"></div><div class="richeng_title r_title" title="' + data[i].content + '">' + data[i].content + '</div><div class="richeng_time" style="float: right; color: #a3a3a3;width: 46%">' + data[i].stim.replace(/\s/g, '<i style="margin-right: 10px"></i>') + ' -- ' + data[i].etim.split(" ")[1] + '</div></li>'
                    }
                }else{
                    for (var i = 0; i < 6; i++) {
                        li += '<li class="chedule_li" onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">' +
                            '<h2 style="display: none">日程安排</h2><div style="margin-left:12px;"><img src="/img/data_point.png"></div><div class="richeng_title r_title" title="' + data[i].content + '">' + data[i].content + '</div><div class="richeng_time" style="float: right; color: #a3a3a3;width: 46%">' + data[i].stim.replace(/\s/g, '<i style="margin-right: 10px"></i>') + ' -- ' + data[i].etim.split(" ")[1] + '</div></li>'
                    }
                }

                $('.chedule_all').html(li);
                if(obj.obj.length==0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</div>';
                    $('.chedule_all').html(lis);
                }
            }

        }
    });
}
//会议通知
function meeting(me) {
    $.ajax({
        url: '/meeting/getMeetingNotifyFirstDesktop',
        type: 'get',
        data:{
            page:'1',
            pageSize:'10',
            useFlag:'true'
        },
        dataType: 'json',
        success: function (obj) {

            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {

                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/meeting/detail?meetingId='+data[i].sid+'">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].meetName + '">' + data[i].meetName + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {

                        if(data[i].startTime!=undefined){
                            return data[i].startTime.split(/\s/g)[0];
                        }else {
                            return ''
                        }


                    }()  + '</div>' +
                    '</li>'
            }
            $('.meeting').html(li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.meeting').html(lis);
            }


        }
    });
}

//领导指示精神
//领导指示精神 未读
function lead(me){
    $("#sxslead").hide()
    $("#sxlead").show()
    var typeId=''
    if($(me).attr('read')=='noRead'){
        $(me).attr('data-bool',$(me).parent().prev().find('option:selected').attr('data-bool'))
        $(me).parent().siblings('.more_notice').attr('url', '/notice/leadread');
    }else{
        $(me).parent().next().next().attr('url', '/notice/leadread')
    }
    var obj={
        read:0,
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:'LDZSJS'
    };
    $.ajax({
        url:"/notice/notifyManage",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {
            var data = obj.obj;
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].notifyDateTime!=undefined){
                        return data[i].notifyDateTime.split(/\s/g)[0]
                    }else {
                        return ''
                    }
                }()
                /*var time=data[i].notifyDateTime.slice(0,10);*/
                /*console.log(time);*/
                // str_li += '<li style="height:50px;margin-top:-8px" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '"><div class="n_imgs" style="width: 10px;height: 10px;margin-left: 12px;"><img  onerror="imgerror(this,1)" src="'+function () {
                //         if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                //             return '/img/data_point.png';
                //         }
                //         if(data[i].users.sex == 0){
                //             return '/img/data_point.png';
                //         }
                //         else if(data[i].users.sex == 1){
                //             return '/img/data_point.png';
                //         }
                //     }()+'"></div><div class="n_words" style="margin-top:-8px;margin-left:38px">' +
                //     '<h3 class="n_time" style="margin-left: 45%;">' +
                //     '<p style="margin-top: 8%;font-size:11pt">' + strnbsp + '</p>' +
                //     '</h3><a  style="color:#000;" class="public_title" target="_blank"><h2 class="n_title" data-tid="' + data[i].notifyId + '" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                //     ''+function () {
                //         if(data[i].attachmentId==''){
                //             return ''
                //         } else
                //         {
                //             // return '<img class="n_accessory" src="/img/main_img/accessory.png" alt="">'
                //             return ''
                //         }
                //
                //     }()+'</div></li>'

                str_li += '<li style="padding: 0 10px; box-sizing: border-box;margin-bottom: 0px" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                    '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }
                    }()+'" alt="">' +
                    '<h1>' + data[i].name + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看我的公告</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].subject + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';


            }
            $('.no_read_notice_twoam').html(str_li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.no_read_notice_twoam').html(lis);
            }
        }
    })
}

//领导指示精神 已读
function leads(me){
    $("#sxlead").hide()
    $("#sxslead").show()
    var typeId=''
    if($(me).attr('read')=='okRead'){
        $(me).attr('data-bool',$(me).parent().prev().find('option:selected').attr('data-bool'))
        $(me).parent().siblings('.more_notice').attr('url', '/notice/leadView');
    }else{
        $(me).parent().next().next().attr('url', '/notice/leadread')
    }
    var obj={
        read:1,
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:'LDZSJS'
    };
    $.ajax({
        url:"/notice/notifyManage",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {

            var data = obj.obj;
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].notifyDateTime!=undefined){
                        return data[i].notifyDateTime.split(/\s/g)[0]
                    }else {
                        return ''
                    }
                }()

                str_li += '<li style="padding: 0 10px; box-sizing: border-box;margin-bottom: 0px" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                    '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                    '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }
                    }()+'" alt="">' +
                    '<h1>' + data[i].name + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看我的公告</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].subject + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';


            }

            $('.no_read_notice_twoam').html(str_li);
            //console.log(notice_li)

            // console.log($('.right_notice').html())

            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.no_read_notice_twoam').html(lis);
            }

        }
    })

}
//文件柜
function fileCabinet(me){
    $("#wj").show()
    $("#wjs").hide()
    $.ajax({
        url: $(me).attr('data-url'),
        type:'get',
        dataType:'json',
        success:function(obj){
            /*console.log(obj);*/
            wenjian_li = '';
            var li = '';
            obj = obj.datas;
            if(obj.length  < 7){
                for (var i = 0; i < obj.length; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '3001'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '0136'
                            }
                        }()+'" onclick="publicWin(this)" data-url="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '/newFilePub/fileCabinetHome?sortId='+ obj[i].id
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '/newFilePri/personalFileCabinet?sortId='+ obj[i].id
                            }
                        }()+'"><h2 style="display: none">'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '公共文件柜'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '个人文件柜'
                            }
                        }()+'</h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div><div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }else{
                for (var i = 0; i < 6; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '3001'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '0136'
                            }
                        }()+'" onclick="publicWin(this)" data-url="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '/newFilePub/fileCabinetHome?sortId='+ obj[i].id
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '/newFilePri/personalFileCabinet?sortId='+ obj[i].id
                            }
                        }()+'"><h2 style="display: none">'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '公共文件柜'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '个人文件柜'
                            }
                        }()+'</h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div><div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }
            $('.pets_wenjian').html(li);
            if(obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';

                $('.pets_wenjian').html(lis);
            }
        }



    })
}
function fileCabinets(me){
    $("#wjs").show()
    $("#wj").hide()
    if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
        $('.fileHome').attr({
            'url': '/newFilePub/fileCabinetHome?0',
            'tid': '3001'
        }).find('.hide').text('公共文件柜')
    }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
        $('.fileHome').attr({
            'url': '/newFilePri/personalFileCabinet?0',
            'tid': '0136'
        }).find('.hide').text('个人文件柜')
    }
    $.ajax({
        url: '/newFilePri/getPriFileSort',
        type:'get',
        dataType:'json',
        success:function(obj){
            /*console.log(obj);*/
            wenjian_li = '';
            var li = '';
            obj = obj.datas;
            if(obj.length < 7){
                for (var i = 0; i < obj.length; i++) {
                    if(obj[i].sortParent == -1 || obj[i].sortParent == undefined){
                        obj[i].id = obj[i].sortId, obj[i].text = obj[i].sortName;
                        li += '<li class="chedule_li wenjian"' +
                            'data-num="1" data-id="'+obj[i].id+'" menu_tid="'+function () {
                                if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                    return '3001'
                                }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                    return '0136'
                                }
                            }()+'" onclick="personWin(this)" data-url="'+function () {
                                if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                    return 'knowledge_management'
                                }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                    return '/newFilePri/personalFileCabinet?'+ obj[i].id
                                }
                            }()+'"><h2 style="display: none">'+function () {
                                if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                    return '公共文件柜'
                                }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                    return '个人文件柜'
                                }
                            }()+'</h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div><div class="new_title richeng_title" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                    }
                }
            }else{
                var todo = []
                for (var i = 0; i < obj.length; i++) {
                    if(obj[i].sortParent == -1 || obj[i].sortParent == undefined){
                        todo.push(obj[i])
                    }
                }
                for (var i = 0; i < 6; i++) {
                    todo[i].id = todo[i].sortId, todo[i].text = todo[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+todo[i].id+'" menu_tid="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '3001'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '0136'
                            }
                        }()+'" onclick="personWin(this)" data-url="'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return 'knowledge_management'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '/newFilePri/personalFileCabinet?'+ todo[i].id
                            }
                        }()+'"><h2 style="display: none">'+function () {
                            if($(me).attr('data-url')=='/newFilePub/getNewAllPrivateFile?sortId=0'){
                                return '公共文件柜'
                            }else if($(me).attr('data-url')=='/newFilePri/getPriFileSort'){
                                return '个人文件柜'
                            }
                        }()+'</h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div><div class="new_title richeng_title" title="' + todo[i].text + '">' + todo[i].text + '</div></li>'
                }
            }
            $('.pets_wenjian').html(li);
            if(obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';

                $('.pets_wenjian').html(lis);
            }
        }



    })
}

//待办工作流
function workDaiban(){
/*    if(menuChosseID.indexOf('05') == -1){
        // 我的门户没有设置公文模块， 待办公文的数量则需要自己请求下接口获取
        $.ajax({
            url:'/document/selWillDocSendOrReceive',
            type:'get',
            dataType:'json',
            data:{
                documentType: 0,
                page: 1,
                pageSize: 10,
                useFlag: true
            },
            success:function(res) {
                if(res.total==undefined || res.total==''){
                    $('.workNum').html('0');
                }else{
                    $('.workNum').html(res.total);
                }
            }
        })
    }*/

/*    //收文
    $.ajax({
        url:'/document/selWillDocSendOrReceive',
        type:'get',
        dataType:'json',
        data:{
            documentType: 1,
            page: 1,
            pageSize: 10,
            useFlag: true
        },
        success:function(res) {
            if(res.total==undefined || res.total==''){
                $('.workNums').html('0');
            }else{
                $('.workNums').html(res.total);
            }

        }
    })*/
    if(menuChosseID.indexOf('03') == -1){
        // 我的门户没有设置邮件模块， 未读邮件的数量则需要自己请求下接口获取
        $.ajax({
            url:'/email/newShowEmail',
            type:'get',
            dataType:'json',
            data:{
                flag: 'inboxNoRead',
                page:1,
                pageSize:15,
                useFlag:true

            },
            success:function(res) {
                if(res.noReadCount == undefined || res.noReadCount == ''){
                    // 未读邮件数量的div
                    $('.worknums').html('0');
                }else{
                    $('.worknums').html(res.noReadCount);
                }

            }
        })
    }


    $.ajax({
        url:'/workflow/work/selectWork',
        type:'get',
        dataType:'json',
        data:{
            page: 1,
            pageSize: 5,
            useFlag: true,
            userId:$.cookie('userId')
        },
        success:function(res){
            var workFlow = res.obj;
            if(res.totleNum==undefined || res.totleNum==''){
                $('.workflowNum').html('0');
                $('.workflowNumOld').html('0');
            }else{
                $('.workflowNum').html(res.totleNum);
                $('.workflowNumOld').html(res.totleNum);
            }
            //加载门户工作、业务审批
            if(res.flag && workFlow.length>0){
                var daiba_li = '';
                for(var m=0;m<workFlow.length;m++){
                    var time = workFlow[m].receiptTime.replace(/\s/,' ')
                    daiba_li+='<li style="padding: 0 5px;box-sizing: border-box;" onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag='+workFlow[m].opFlag+'&flowId='+workFlow[m].flowRun.flowId+'&flowStep='+workFlow[m].prcsId+'&runId='+workFlow[m].runId+'&prcsId='+workFlow[m].flowPrcs+'"  data-s="2" class="clearfix">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="n_img" style="margin-right:5px;margin-top: 5px; "><img style="margin-left: 16px;border-radius:50%" onerror="imgerror(this,1)"  src="'+function () {
                            if (workFlow[m].flowRun.avatar != 0 && workFlow[m].flowRun.avatar != 1 && workFlow[m].flowRun.avatar != '') {
                                return '/img/user/' + workFlow[m].flowRun.avatar;
                            }else{
                                if(workFlow[m].flowRun.sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(workFlow[m].flowRun.sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'"></div>' +
                        '<div class="n_word">' +
                        '<h1 class="n_name">'+workFlow[m].flowRun.userName+'</h1>'+
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+workFlow[m].receiptTime.split(/\s/)[0]+'</p></h3>' +
                        '<a href="javascript:void(0)" style="display: inline-block;width: 65%;" data-id="'+workFlow[m].qid+'" class="windowopen">' +
                        '<h2 class="n_title" style="width: 100% !important;" title="'+workFlow[m].flowRun.runName+'">'+workFlow[m].flowRun.runName+'<span>&nbsp;</span></h2></a>'+
                        '<span style="position: absolute;right: 10px;top: 21px;color: #999;"></span>'+
                        '</div>' +
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
/*// 待办发文
function documentFile(me) {
    $.ajax({
        url: '/document/selWillDocSendOrReceive',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str = '';
            var data = obj.datas;
            if(obj.total == undefined || obj.total == ''){
                $('.workNum').html('0');
            }else{
                $('.workNum').html(obj.total);
            }
            if(data.length > 0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding:15px 3px 15px 10px;"><p>'+function(){
                            if(data[i].createTime.indexOf('.') > -1){
                                if(data[i].createTime.indexOf(' ') > -1){
                                    return data[i].createTime.split(' ')[0];
                                }else{
                                    return data[i].createTime;
                                }
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 65%;" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color:#0b8aff;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }


            $('.gongwen').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.gongwen').html(lis);
            }
        }
    });
}*/
//网络硬盘的接口
function wangluoyingpan() {
    $.ajax({
        url: '/netdisk/getNetDiskMenu',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            var flag = false;
            if(obj.flag){
                var data = obj.datas||"";
                var li = '';

                for(var i = 0; i < data.length; i++) {
                    var text = '';
                    var t = 0;
                    var title = data[i].text;
                    for (var j = 0; j <= 6;j++) {
                        if ((title.slice(t,t+1)>= '0' && title.slice(t,t+1) <= '9') || (title.slice(t,t+1) >= 'a' && title.slice(t,t+1) <= 'z')
                            || (title.slice(t,t+1) >= 'A' && title.slice(t,t+1) <= 'Z')) {

                        } else {
                            j++;

                        }
                        text += title.slice(t,t+1);
                        t++;

                    }
                    if(title.slice(t,t+1)!=''){
                        text += '...';
                    }
                    li += '<li class="all_li" onclick="parent.getMenuOpen(this)"' +
                        ' data-url="netdisk" data-num="1" data-id="' + data[i].id + '"  menu_tid="3010"><h2 style="display: none">网络硬盘</h2>' +
                        '<div class="total_wenjian"  tid="3001" url="netdisk" style="display: inline-block"><img src="/img/main_img/myOA/wenjian.png" ></div>' +
                        '<h1 title="' + title + '" style="display: inline-block;margin-left: 20px;font-size: 15px;color: #383838" >' + text + '</h1></li>'
                    flag = true;
                }
                $('.pets_yingpan').html(li);
            }
            if(!flag){
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.pets_yingpan').html(lis);
            }
        }
    });
}
//日志接口
function rizhis() {
    $.ajax({
        url:'/diary/getIndex',
        type:'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:'true',
            userId:$.cookie('userId')
        },
        dataType:'json',
        success:function(obj){

            var data = obj.obj;
            /*	console.log(data);*/
            var str_li = '';
            for (var i = 0; i < data.length; i++) {
                /*console.log(data[0].userName);*/
                str_li += '<li onclick="tiaozhuan(this)" data-url="/diary/details?id=' + data[i].diaId + '" style="box-sizing: border-box;"><div style="margin: 0;width: 100%;">' +
                    '<div class="d_img" style="margin-right:5px;margin-top: 5px;">' +
                    '<img onerror="imgerror(this,1)" src="'+function () {
                        if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                            return '/img/user/'+data[i].avatar;
                        }else{
                            if(data[i].sex == 0){
                                return '/img/user/boy.png';
                            }
                            else if(data[i].sex == 1){
                                return '/img/user/girl.png';
                            }
                        }
                    }()+'">' +
                    '</div><div class="d_word">' +
                    '<h1 class="d_name">' + data[i].userName + '</h1>' +
                    '<h3 class="d_time" style="height: 25px;line-height: 28px;">' +function () {
                        if(data[i].diaDate!=undefined){
                            return data[i].diaDate
                        }else {
                            return ''
                        }
                    }()  + '</h3>' +
                    '<a style="color:#000;" class="public_title" target="_blank"><h2 class="d_title">' + data[i].subject + '</h2></a>' +
                    ''+function () {
                        if(data[i].attachmentId==''){
                            return ''
                        }else {
                            return '<img class="d_accessory" src="/img/main_img/accessory.png" alt="">'
                        }
                    }()+'</div></div></li>'
                /*console.log(str_li);*/
            }

            $('.all_daily').html(str_li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.all_daily').html(lis);
            }

        }
    })
}
// 邮件接口-已读和全部
function youjian() {
    $.ajax({
        url:'/email/newShowEmail',
        type:'get',
        data:{
            flag:'inbox',
            page:1,
            pageSize:5,
            useFlag:'true',
        },
        dataType:'json',
        success:function(obj){
            if(obj.flag) {
                var data = obj.obj;
                var li = '';
                var read_li = '';
                var all_li = '';
                var email_li = '';
                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < data[i].emailList.length; j++) {
                        if(data[i].users != undefined){
                            var sendTime = data[i].sendTimes
                            if (data[i].emailList[j].readFlag == 1) {
                                var sendTime =data[i].sendTimes
                                read_li += '<li onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div style="margin: 0;width: 100%;">' +
                                    '<div class="e_img" style="margin-top: 5px;">' +
                                    '<img onerror="imgerror(this,1)" src="'+function () {
                                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                                            return '/img/user/'+data[i].users.avatar;
                                        }else {
                                            if(data[i].users.sex == 0){
                                                return '/img/user/boy.png';
                                            }
                                            else if(data[i].users.sex == 1){
                                                return '/img/user/girl.png';
                                            }
                                        }
                                    }()+'" ></div>' +
                                    '<div class="e_word">' +
                                    '<h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' + data[i].users.userName + '</h1>' +
                                    '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
                                    '<a style="color:#383838;" class="public_title" target="_blank">' +
                                    '<h2 style="font-size: 8px; color: #0b8aff;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                                    ''+function () {
                                        if(data[i].attachmentId==''){
                                            return ''
                                        }else {
                                            return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                        }
                                    }()+'</div></div></li>'
                            }
                            var sendTimews = data[i].sendTimes
                            all_li += '<li onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '" ><div style="margin: 0;width: 100%;">' +
                                '<div class="e_img" style="margin-top: 5px;">' +
                                '<img onerror="imgerror(this,1)" src="'+function () {
                                    if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                                        return '/img/user/'+data[i].users.avatar;
                                    }
                                    if(data[i].users.sex == 0){
                                        return '/img/user/boy.png';
                                    }
                                    else if(data[i].users.sex == 1){
                                        return '/img/user/girl.png';
                                    }
                                }()+'">' +
                                '</div><div class="e_word">' +
                                '<h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' +data[i].users.userName + '</h1>' +
                                '<h3 class="e_time">' + sendTimews.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
                                '<a style="color:#383838;" class="public_title" target="_blank">' +
                                '<h2 style="font-size: 8px; color: #0b8aff;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                                ''+function () {
                                    if(data[i].attachmentId==''){
                                        return ''
                                    }else {
                                        return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                    }
                                }()+'</div></div></li>'

                            email_li += '	<li class="tixing_one_all" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div class="tixing_every"><div class="company">' +
                                '<img onerror="imgerror(this,1)" src="'+function () {
                                    if(data[i].users.avater != 0&&data[i].users.avater != 1&&data[i].users.avater != ''){
                                        return '/img/user/'+data[i].users.avater;
                                    }
                                    if(data[i].users.sex == 0){
                                        return '/img/user/boy.png';
                                    }
                                    else if(data[i].users.sex == 1){
                                        return '/img/user/girl.png';
                                    }
                                }()+'" alt=""><h1>' + data[i].emailList[j].toName + '</h1><h2 class="company_time" style="margin-left: 88px;">' + sendTime + '</h2>' +
                                '</div><a style="color:#383838;" class="public_title" target="_blank"><h1 class="thing">请查看我的邮件</h1><div class="liushuihao"><h1>主题：</h1><span>' + data[i].subject + '</span></div></a>' +
                                '</div></li>';
                        }
                    }
                }
                $('.all_mail').html(all_li);
                $('.read').html(read_li);
                if(all_li=='') {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</div>';
                    $('.all_mail').html(lis);
                }
            }else {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.all_mail').html(lis);
                $('.read').html(lis);
            }
        }
    })
}
// 邮件-未读
function youjianUnread(){
    $.ajax({
        url:'/email/newShowEmail',
        type:'get',
        data:{
            flag:'inboxNoRead',
            page:1,
            pageSize:5,
            useFlag:'true',
        },
        dataType:'json',
        success:function(obj){
            if(obj.noReadCount == undefined || obj.noReadCount == ''){
                // 未读邮件数量的div
                $('.worknums').html('0');
            }else{
                $('.worknums').html(obj.noReadCount);
            }
            if(obj.flag) {
                var data = obj.obj;
                var li = '';
                for (var i = 0; i < data.length; i++) {
                    if (data[i].users != undefined) {
                        var sendTime = data[i].sendTimes
                        li += '<li class="no_read" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[0].emailId + '"><div class="e_img"><img onerror="imgerror(this,1)" src="' + function () {
                                if (data[i].users.avatar != 0 && data[i].users.avatar != 1 && data[i].users.avatar != '') {
                                    return '/img/user/' + data[i].users.avatar;
                                }
                                if (data[i].users.sex == 0) {
                                    return '/img/user/boy.png';
                                } else if (data[i].users.sex == 1) {
                                    return '/img/user/girl.png';
                                }
                            }() + '"></div><div class="e_word"><h1 class="e_name" data-userId="' + data[i].users.userId + '">' + data[i].users.userName + '</h1>' +
                            '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
                            '<a style=" color:#1b5e8d;" class="public_title" target="_blank">' +
                            '<h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[0].emailId + '" ' +
                            'class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                            '' + function () {
                                if (data[i].attachmentId == '') {
                                    return ''
                                } else {
                                    return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                }
                            }() + '</div></li>'
                    }
                    $('.no_read').html(li);
                    if (li == '') {
                        var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                            '<h2 style="text-align: center;color: #666;">暂无数据，将为您跳到全部消息列表</h2>' +
                            '</div>';
                        $('.no_read').html(lis);
                        youjian()
                        $('#yidu').trigger('click')
                    }
                }
            }else {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">暂无数据，将为您跳到全部消息列表</h2>' +
                    '</div>';
                youjian()
                $('.no_read').html(lis);
                $('#yidu').trigger('click')
            }
        }
    })
}
//待办工作点击事件
function windowOpenNew(me) {
    /* if($(me).attr('data-s')==1){
     /!* window.open('/email/details?id='+$(me).find('.windowopen').attr('data-id'))*!/
     window.open($(me).attr('data-url'))
     }else */
    if($(me).attr('data-s')==2){
        var objGet=$(me).attr('data-url');
        var runId = objGet.split('&runId=')[1].split('&prcsId=')[0];
        var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
        if($(me).parents('.custom_two').attr('id') == 'documentToDoList'){
            $.get('/ToBeReadController/querySmsIsRead',{runId:runId,prcsId:prcsId},function(data){
                window.open(objGet);
            },'json')
        }else{
            window.open(objGet);
        }
    }else if($(me).attr('data-s')==3){
        window.open('/notice/detail?notifyId='+$(me).attr('data-qid'))
    }else if($(me).attr('data-s')==4){
        window.open('/news/detail?newsId='+$(me).attr('data-new'))
    }else if($(me).attr('data-s')==5){
        var rl = $(me).attr('data-url')
        $.popWindow(rl,'公告详情','20','150','1200px','600px')
    }else if($(me).attr('data-s')==200){
        var bodyId = $(me).attr('bodyId')
        $.ajax({
            type: "post",
            url: "/sms/setRead",
            dataType: 'JSON',
            data: {"bodyId":bodyId},
            success: function () {
                window.open($(me).attr('data-url'))
            }
        });
    }else {
        window.open($(me).attr('data-url'))
    }
    if($(me).parent().parent().prev().find('.custom_num')!=undefined){
        var todoNum=$(me).parent().parent().prev().find('.custom_num').text();
        $(me).parent().parent().prev().find('.custom_num').text(--todoNum)
    }
    var type1=$(me).attr("type1");
    if(type1==undefined||type1!="daiban"){
        $(me).remove();
        todoListNum--;
    }
    if(todoListNum<99){
        $('#sns').html('<div class="he">'+todoListNum+'</div>');
    }

    if(todoListNum == 0){
        $('#sns').find('.he').hide();
    }



    if($('.daiban').find('li').length==0) {
        var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
            '</div>';
        $('.daiban').html(lis);
    }
}


//党务公开查询方法
function dangwuopen(me){
    var obj={
        read:'',
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:$(me).attr('data-bool')
    };
    $.ajax({
        url:"/partaffairs/selectPeople?partyaffairsType=党务",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {
            var data = obj.obj;
            /*console.log(data);*/
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].partyaffairsSendtime!=undefined){
                        return data[i].partyaffairsSendtime.replace(/\s/g, '<i style="margin-right: 10px"></i>')
                    }else {
                        return ''
                    }
                }()
                /*var time=data[i].notifyDateTime.slice(0,10);*/
                /*console.log(time);*/
                str_li += '<li onclick="dangwutiaozhuan(this)" data-url="/partaffairsjsp/AffairsDetail?id=' + data[i].id + '">' +
                    '<div class="n_img"><img onerror="imgerror(this,1)" src="'+function () {
                        /*if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }*/
                        return '/img/user/boy.png';
                    }()+'"></div><div class="n_word">' +
                    '<h1 class="n_name">' + data[i].partyaffairsSendpeoplename + '</h1><h3 class="n_time">' +
                    '<p>' + strnbsp + '</p>' +
                    '</h3><a  style="color:#000;" class="public_title" target="_blank">' +
                    '<h2 class="n_title" data-tid="' + data[i].id + '" title="' + data[i].partyaffairsTittle + '">' + data[i].partyaffairsTittle + '</h2></a>' +
                    ''+function () {
                        if(data[i].partyaffairsAttachmentid==''){
                            return ''
                        } else {
                            return '<img class="n_accessory" src="/img/main_img/accessory.png" alt="">'
                        }
                    }()+'</div></li>'

                notice_li += '<a href="/partaffairsjsp/AffairsDetail?id=' + data[i].id + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        /*if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }*/
                        return '/img/user/boy.png';
                    }()+'" alt="">' +
                    '<h1>' + data[i].partyaffairsSendpeoplename + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + data[i].partyaffairsSendtime + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看党务</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].partyaffairsTittle + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';
            }
            $('.dangwuopen').html(str_li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+obj.msg+'</h2>' +
                    '</div>';
                $('.dangwuopen').html(lis);
            }

        }
    })
}
//校务公开查询方法
function xiaowuOpen(me){
    var obj={
        read:'',
        page:1,
        pageSize:6,
        useFlag:'true',
        typeId:$(me).attr('data-bool')
    };
    $.ajax({
        url:"/partaffairs/selectPeople?partyaffairsType=校务",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(obj) {
            var data = obj.obj;
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                    if(data[i].partyaffairsSendtime!=undefined){
                        return data[i].partyaffairsSendtime.replace(/\s/g, '<i style="margin-right: 10px"></i>')
                    }else {
                        return ''
                    }
                }()
                /*var time=data[i].notifyDateTime.slice(0,10);*/
                /*console.log(time);*/
                str_li += '<li onclick="dangwutiaozhuan(this)" data-url="/partaffairsjsp/SchoolAffairsDetail?id=' + data[i].id + '">' +
                    '<div class="n_img"><img onerror="imgerror(this,1)" src="'+function () {
                        /*if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }*/
                        return '/img/user/boy.png';
                    }()+'"></div><div class="n_word">' +
                    '<h1 class="n_name">' + data[i].partyaffairsSendpeoplename + '</h1><h3 class="n_time">' +
                    '<p>' + strnbsp + '</p>' +
                    '</h3><a  style="color:#000;" class="public_title" target="_blank">' +
                    '<h2 class="n_title" data-tid="' + data[i].id + '" title="' + data[i].partyaffairsTittle + '">' + data[i].partyaffairsTittle + '</h2></a>' +
                    ''+function () {
                        if(data[i].partyaffairsAttachmentid==''){
                            return ''
                        } else {
                            return '<img class="n_accessory" src="/img/main_img/accessory.png" alt="">'
                        }
                    }()+'</div></li>'

                notice_li += '<a href="/partaffairsjsp/SchoolAffairsDetail?id=' + data[i].id + '" style="color:#000;" class="public_title" target="_blank">' +
                    '	<li class="tixing_one_all">' +
                    '<div class="tixing_every">' +
                    '<div class="company">' +
                    '<img onerror="imgerror(this,1)"  src="'+function () {
                        /*if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                            return '/img/user/'+data[i].users.avatar;
                        }
                        if(data[i].users.sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].users.sex == 1){
                            return '/img/user/girl.png';
                        }*/
                        return '/img/user/boy.png';
                    }()+'" alt="">' +
                    '<h1>' + data[i].partyaffairsSendpeoplename + '</h1>' +
                    '<h2 class="company_time" style="margin-left: 57px;">' + data[i].partyaffairsSendtime + '</h2>' +
                    '</div>' +
                    '<h1 class="thing">请查看校务</h1>' +
                    '<div class="liushuihao">' +
                    '<h1>主题：</h1><' +
                    'span>' + data[i].partyaffairsTittle + '</span>' +
                    '</div>' +
                    '</div>' +
                    '</li></a>';
            }
            $('.xiaowuOpen').html(str_li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+obj.msg+'</h2>' +
                    '</div>';
                $('.xiaowuOpen').html(lis);
            }

        }
    })
}
//讨论区查询方法
function talkAbout(){
    $.ajax({
        url:'/system/bbs/selAll',
        type:'get',
        data:{
            page:1,
            limit:6,
            purview:'true',
        },
        dataType:'json',
        success:function(obj){
            var data = obj.obj;
            var str_li = '';
            for (var i = 0; i < data.length; i++) {
                str_li += '<li style="padding: 0 5px; box-sizing: border-box;white-space: nowrap;margin-bottom: 0px" class="chedule_li" menu_tid="3020" onclick="tiaozhuan(this)" data-url="/bbs/theme?boardId=' + data[i].boardId + '&isCheck='+ data[i].needCheck +'">' +
                    '<div style="margin-left:12px;">' +
                    '<img src="/img/data_point.png">' +
                    '</div>' +
                    '<a><div class="new_title taolunqu_title" title="' + data[i].boardName + '">' + data[i].boardName + '</div></a>' +
                    '<div class="submit_times" style="float: right;padding-right: 10px;height: 20px;text-align: right;line-height: 20px;color: #898989;margin-top: 12px">' +function(){
                        if(data[i].lastRelease!=undefined){
                            if (data[i].lastRelease["submitTime"]==undefined){
                                data[i].lastRelease["submitTime"]="";
                            }
                            return data[i].lastRelease["submitTime"].replace(/\s/g, '<i style="margin-right: 10px"></i>')
                        }else{
                            return ''
                        }
                    }() + '</div>' +
                    '</li>'
            }

            $('.new_talk').html(str_li);
            if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.new_talk').html(lis);
            }

        }
    })
}

//机关党建
function organPartyBuilding(me){
    $.ajax({
        url: $(me).attr('data-url'),
        type:'get',
        dataType:'json',
        success:function(obj){
            /*console.log(obj);*/
            wenjian_li = '';
            var li = '';
            obj = obj.datas;
            if(obj.length  < 7){
                for (var i = 0; i < obj.length; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="3001" onclick="jiguanWin(this)" data-url="/newFilePub/DefineMenu?sortId='+obj[i].id+'">' +
                        '<h2 style="display: none"></h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }else{
                for (var i = 0; i < 6; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="3001" onclick="jiguanWin(this)" data-url="/newFilePub/DefineMenu?sortId='+obj[i].id+'">'+
                        '<div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }
            $('.jiguan').html(li);
            if(obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';

                $('.jiguan').html(lis);
            }
        }
    })
}
//工作动态
function dynamicState(me){
    $.ajax({
        url: $(me).attr('data-url'),
        type:'get',
        dataType:'json',
        success:function(obj){
            /*console.log(obj);*/
            wenjian_li = '';
            var li = '';
            var obj = obj.obj;
            if(obj.length  < 7){
                for (var i = 0; i < obj.length; i++) {
                    obj[i].id = obj[i].notifyId,  obj[i].text = obj[i].subject, obj[i].time = obj[i].begin;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="0119" onclick="statuWin(this)" data-url="/myNotice/detail?notifyId='+ obj[i].id +'&specifyTable=3">' +
                        '<h2 style="display: none"></h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '（' +obj[i].time+'）</div></li>'
                }
            }else{
                for (var i = 0; i < 6; i++) {
                    obj[i].id = obj[i].notifyId,  obj[i].text = obj[i].subject, obj[i].time = obj[i].begin;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="0119" onclick="statuWin(this)" data-url="/myNotice/detail?notifyId='+ obj[i].id +'&specifyTable=3">'+
                        '<div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '（' +obj[i].time+ '）</div></li>'
                }
            }
            $('.dynamic_state').html(li);
            if(obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';

                $('.dynamic_state').html(lis);
            }
        }
    })
}
//办公管理
function officeManage(me){
    $.ajax({
        url: $(me).attr('data-url'),
        type:'get',
        dataType:'json',
        success:function(obj){
            /*console.log(obj);*/
            wenjian_li = '';
            var li = '';
            var obj = obj.datas;
            if(obj.length  < 7){
                for (var i = 0; i < obj.length; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="0119" onclick="jiguanWin(this)" data-url="/newFilePub/DefineMenu?sortId='+ obj[i].id +'">' +
                        '<h2 style="display: none"></h2><div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }else{
                for (var i = 0; i < 6; i++) {
                    obj[i].id = obj[i].sortId,  obj[i].text = obj[i].sortName;
                    li += '<li class="chedule_li wenjian"' +
                        'data-num="1" data-id="'+obj[i].id+'" menu_tid="0119" onclick="jiguanWin(this)" data-url="/newFilePub/DefineMenu?sortId='+ obj[i].id +'">' +
                        '<div style="margin-left:19px;"><img src="/img/data_point.png"></div>' +
                        '<div class="new_title richeng_title" style="width:85%" title="' + obj[i].text + '">' + obj[i].text + '</div></li>'
                }
            }
            $('.office_manage').html(li);
            if(obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';

                $('.office_manage').html(lis);
            }
        }
    })
}
//速卓平台待办
function suzhuoStay() {
    $("#stayIcon").show();
    $("#doneIcon").hide();
    $.ajax({
        url: '/gappflow/selectDealRunPrcs?page=1&limit=5&useFlag=true&isCompletion=0',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.obj;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    // var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                    //     +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="suzhuoOpen(this)" data-url="/gapp/accraditation?tabId='+ data[i].tabId +'dataId='+ data[i].dataId +'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].createUserName == ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name" style="width: 51%">'+data[i].dealUserName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 0px;"><p>'+function(){
                            // var timesss = "2023-01-3118:43:46"
                            // return timesss.slice(0,10) + '<i style="margin-right:10px;"></i>' + timesss.slice(10);
                            if(data[i].receiveTimeStr != undefined && data[i].receiveTimeStr != ''){
                                return data[i].receiveTimeStr.slice(0,10) + '<i style="margin-right:10px;"></i>' + data[i].receiveTimeStr.slice(10);
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 51%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].prcsName+'" class="e_title" title="'+data[i].prcsName+'">'+data[i].prcsName+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }

            $('.suzhuo').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.suzhuo').html(lis);
            }
        }
    });

}
//速卓平台已办
function suzhuoDone() {
    $("#doneIcon").show();
    $("#stayIcon").hide();
    // $(me).parent().siblings('.more_emild').attr('url', '/document/makeADraft');
    $.ajax({
        url: '/gappflow/selectDealRunPrcs?page=1&limit=5&useFlag=true&isCompletion=1',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.obj;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    // var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                    //     +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="suzhuoOpen(this)" data-url="/gapp/accraditation?tabId='+ data[i].tabId +'dataId='+ data[i].dataId +'">' +
                        '<div class="" style="margin: 0;width: 100%;">' +
                        '<div class="e_img" style="margin-right: 5px;margin-top: 5px">' +
                        '<img style="margin-left: 16px;" onerror="imgerror(this,1)" src="'+ function () {
                            if(data[i].createUserName == ''){
                                return '/img/user/'+data[i].avatar;
                            }else{
                                if(data[i].sex == 0){
                                    return '/img/user/boy.png';
                                }
                                else if(data[i].sex == 1){
                                    return '/img/user/girl.png';
                                }
                            }
                        }()+'">' +
                        '</div>' +
                        '<div class="e_word">' +
                        '<h1 class="n_name" style="width: 51%">'+data[i].dealUserName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 0px;"><p>'+function(){
                            // var timesss = "2023-01-3118:43:46"
                            // return timesss.slice(0,10) + '<i style="margin-right:10px;"></i>' + timesss.slice(10);
                            if(data[i].receiveTimeStr != undefined && data[i].receiveTimeStr != ''){
                                return data[i].receiveTimeStr.slice(0,10) + '<i style="margin-right:10px;"></i>' + data[i].receiveTimeStr.slice(10);
                            }else{
                                return '';
                            }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 51%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #0b8aff;width: 300px" emil-tid="'+data[i].prcsName+'" class="e_title" title="'+data[i].prcsName+'">'+data[i].prcsName+'</h2>' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</li>'
                }
            }

            $('.suzhuo').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                    '</div>';
                $('.suzhuo').html(lis);
            }
        }
    });

}


//自定义告示栏1
function billboard(){
    $.ajax({
        url:'/syspara/selectSysParaAtPortal',
        type:'get',
        data:{
            title:'PORTAL_NOTICE1_TITLE',
            content:'PORTAL_NOTICE1_CONTENT'
        },
        dataType:'json',
        success:function(obj){
            var html = obj.object.title||'';
            if(html == ''){
                html = '告示栏'
            }
            $('.rigitem1').html(html)
            $('.divTxt').html('<p>' + obj.object.content + '</p>');
        }
    })
}
//自定义告示栏1
function billboard2(){
    $.ajax({
        url:'/syspara/selectSysParaAtPortal',
        type:'get',
        data:{
            title:'PORTAL_NOTICE2_TITLE',
            content:'PORTAL_NOTICE2_CONTENT'
        },
        dataType:'json',
        success:function(obj){
            var html = obj.object.title||'';
            if(html == ''){
                html = '告示栏'
            }
            $('.rigitem2').html(html)
            $('.divTxt2').html('<p>'+obj.object.content+'</p>');
        }
    })
}
//自定义告示栏1
function billboard3(){
    $.ajax({
        url:'/syspara/selectSysParaAtPortal',
        type:'get',
        data:{
            title:'PORTAL_NOTICE3_TITLE',
            content:'PORTAL_NOTICE3_CONTENT'
        },
        dataType:'json',
        success:function(obj){
            var html = obj.object.title||'';
            if(html == ''){
                html = '告示栏'
            }
            $('.rigitem3').html(html)
            $('.divTxt3').html('<p>' + obj.object.content + '</p>');
        }
    })
}

setInterval(function () {
    serverTime = parseInt(serverTime) + 1000;
    var nowTime = serverTime;
    var date1 = new Date(nowTime).Format('MM月dd日');
    var date2 = new Date(nowTime).Format('hh:mm');
    $('.date').text(date1);
    $('.time').text(date2);
    var date3 = new Date(nowTime).Format('yyyy-MM-dd ');
    var date4 = new Date(nowTime).Format(' hh:mm:ss');
    $('.daibantop .left h3').text(date3);
    $('.daibantop .left h4').text(date4);
},1000);
var menuChosseID = '';
$(function(){
    //处理我的门户的菜单模块展示
    $.ajax({
        url:'/infoCenter/getInfoCenterOrder',
        dataType:'json',
        type:'get',
        async: false,
        success:function (datas) {
            menuChosseID = datas.data;
            if(datas.data!=''){
                var dataArr = datas.data.split(",");
                var arr=[];
                var strNum=[]
                for(var m=0;m<$('#myTableGet .contain').length;m++){
                    strNum.push($('#myTableGet .contain').eq(m).attr('id'))

                }

                for(var n=0;n<strNum.length;n++){
                    for(var j=0;j<dataArr.length;j++){
                        if(dataArr[j]!=''&&dataArr[j]!='todayBox'&&strNum[n]==dataArr[j]){
                            arr.push(dataArr[j])
                        }
                    }
                }
                if(arr.length>0){
                    if(arr.indexOf('00')>=0){
                        $(".total").html('')
                    }

                    for(var k=0;k<dataArr.length;k++){
                        if(dataArr[k]!=''&&dataArr[k]!='todayBox'){
                            var add = $('#myTableGet').find('#'+dataArr[k])
                            $(".total").append(add);
                        }

                    }

                    $("#myTableGet").remove();
                    $('.total #00').show();
                    $('.total').css('display','block');
                    if($('.total>li').length > 0){
                        $('.total>li').arrangeable({
                            dragSelector: '.bg_head'
                        });
                    }
                }else{
                    $.ajax({
                        type:'post',
                        url:'/portals/selPortalsById?portalsId=1',
                        dataType:'json',

                        success:function(res){
                            if (res.flag) {
                                var data = res.object.portalsShow.split(",");
                                if(data.indexOf('00')>=0){
                                    $(".total").html('')
                                }
                                for (var i = 0; i < data.length; i++) {
                                    if(data[i]!=''){
                                        var add = $('#myTableGet').find('#'+data[i])
                                        $(".total").append(add);
                                    };
                                }
                                $("#myTableGet").remove();
                                $('.total #00').show();
                                $('.total').css('display','block');
                            }
                            if($('.total>li').length > 0){
                                $('.total>li').arrangeable({
                                    dragSelector: '.bg_head'
                                });
                            }
                        }
                    })
                }

            }else{
                $.ajax({
                    type:'post',
                    url:'/portals/selPortalsById?portalsId=1',
                    dataType:'json',

                    success:function(res){
                        if (res.flag) {
                            var data = res.object.portalsShow.split(",");
                            if(data.indexOf('00') >= 0){
                                $(".total").html('')
                            }
                            for (var i = 0; i < data.length; i++) {
                                if(data[i] != ''){
                                    var add = $('#myTableGet').find('#'+data[i])
                                    $(".total").append(add);
                                };
                            }
                            $("#myTableGet").remove();
                            $('.total #00').show();
                            $('.total').css('display','block');
                        }
                        if($('.total>li').length > 0){
                            $('.total>li').arrangeable({
                                dragSelector: '.bg_head'
                            });
                        }
                    }
                })
            }
        }
    })
    getNowTime();

    if(menuChosseID.indexOf('00') > -1 || menuChosseID.indexOf('0b') > -1){
        $.get('/portals/selPortalsUser', function (json) {
            if (json.flag) {
                //今日看板-A(新版)
                dairy(json.object);
                //今日看板-B(旧版)
                dairyOld(json.object);
            }
        }, 'json')
    }
    if(menuChosseID.indexOf('01') > -1){
        //默认查询全部
        announcement('#all_notice');
    }
    if(menuChosseID.indexOf('02') > -1){
        //新闻
        administrivia('#xinWen .news_all');
    }
    if(menuChosseID.indexOf('03') > -1){
        //邮件
        youjianUnread()
    }
    if(menuChosseID.indexOf('04') > -1){
        //待办工作
        workDaiban();
    }
    if(menuChosseID.indexOf('05') > -1){
        //待办公文接口
        documentFile(1);
    }
    if(menuChosseID.indexOf('06') > -1){
        //日程
        schedule($('[data-url="/schedule/getscheduleByDay"]'));
    }
    if(menuChosseID.indexOf('07') > -1){
        //常用功能
        getApplication($('#application'));
    }
    if(menuChosseID.indexOf('08') > -1){
        //日志
        rizhis();
    }
    if(menuChosseID.indexOf('09') > -1){
        //文件柜
        fileCabinet($('[data-url="/newFilePub/getNewAllPrivateFile?sortId=0"]'));
    }
    if(menuChosseID.indexOf('10') > -1){
        //网络硬盘
        wangluoyingpan()
    }
    if(menuChosseID.indexOf('11') > -1){
        //会议通知
        meeting();
    }
    if(menuChosseID.indexOf('14') > -1){
        //讨论区
        talkAbout()
    }
    if(menuChosseID.indexOf('17') > -1){
        //自定义告示栏1
        billboard()
    }
    if(menuChosseID.indexOf('18') > -1){
        //自定义告示栏2
         billboard2()
    }
    if(menuChosseID.indexOf('19') > -1){
        //自定义告示栏3
        billboard3()
    }
    if(menuChosseID.indexOf('21') > -1){
        //1机关党建
        organPartyBuilding($('[data-url="/newFilePub/getNewAllPrivateFile?sortId=1119"]'))
    }
    if(menuChosseID.indexOf('20') > -1){
        //2工作动态
        dynamicState($('[data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=0&read=&sendTime=&_=1672310541585"]'))
    }
    if(menuChosseID.indexOf('22') > -1){
        //3办公管理
        officeManage($('[data-url="/newFilePub/getNewAllPrivateFile?sortId=797"]'))
    }
    if(menuChosseID.indexOf('23') > -1){
        //速卓
        suzhuoStay()
    }
    if(menuChosseID.indexOf('am') > -1){
        //领导指示精神
        lead()
    }

    $('.total>li>.bg_head').css('cursor',' pointer');
    //日程安排tab切换按钮
    $('.c_head').delegate('div', 'click', function () {
        index = $(this).parent().find('div').index($(this));
        $(this).parent().find("div").removeClass("richeng_check");
        $(this).addClass("richeng_check");
    });
    //邮件tab切换
    $('.s_head').on('click','li',function(){
        $(this).parent().find(" li").removeClass("active");
        $(this).addClass('active');
        if($(this).attr('id')=='all_m'){
            /* init(); */
            $('.all_mail').css("display","block");
            $('.no_read').css("display","none");
            $('.read').css("display","none");
        }else if($(this).attr('id')=='weidu'){
            $('.no_read').css("display","block");
            $('.all_mail').css("display","none");
            $('.read').css("display","none");
            $('.read').css("display","none");
            youjianUnread()
        } else if($(this).attr('id')=='yidu'){
            $('.read').css("display","block");
            $('.no_read').css("display","none");
            $('.all_mail').css("display","none");
        }
    });
    //公告tab切换
    $('.notice_head').on('click','li',function(){
        $(".notice_head li").removeClass("active");
        $(this).addClass('active');
    })
    //公告按钮类型切换
    $('#01 .tainer .notice_list').on('click','li',function(){
        $(".tainer .notice_list li").removeClass("active");
        $(this).addClass('active');
    })

    //领导指示精神tab切换
    $('.notice_head').on('click','li',function(){
        $(".notice_head li").removeClass("active");
        $(this).addClass('active');
    })
    //领导指示精神类型切换
    $('#am .tainerlead .notice_list').on('click','li',function(){
        $(".tainerlead .notice_list li").removeClass("active");
        $(this).addClass('active');
    })
    //新闻按钮类型切换
    $('#02 .new_total .notice_list').on('click','li',function(){
        $(".new_total .notice_list li").removeClass("active");
        $(this).addClass('active');
    })
    //文件柜tab切换
    $('.wenjian_head').on('click','li',function(){
        $(this).parent().find("li").removeClass("active");
        $(this).addClass('active');
    })
    //机关党建tab切换
    $('.tab_active').on('click','li',function(){
        $(this).parent().find("li").removeClass("active");
        $(this).addClass('active');
    })
    //办公管理tab切换
    $('.wenjian_head').on('click','li',function(){
        $(this).parent().find("li").removeClass("active");
        $(this).addClass('active');
    })
    //速卓待办切换
    $('#23 .suzhuoTainer .notice_list').on('click','li',function(){
        $(".suzhuoTainer .notice_list li").removeClass("active");
        $(this).addClass('active');
    })
})
