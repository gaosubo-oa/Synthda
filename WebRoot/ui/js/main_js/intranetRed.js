/**
 * Created by 骆鹏 on 2018/3/1.
 */
if(type=='zh_CN'){
    var main_schedule = '日程安排';
    var no_Data='暂无数据';
    var Please_look_process='请查看流程';
}else if(type=='zh_TW'){
    var main_schedule = '日程安排';
    var no_Data='暂无数据';
    var Please_look_process='请查看流程';
}else if(type=='en_US'){
    var main_schedule = 'Schedule';
    var no_Data='No data';
    var Please_look_process='Please look at the process';
}else {
    var main_schedule = '日程安排';
    var no_Data='暂无数据';
    var Please_look_process='请查看流程';
}




function p(s) {
    return s < 10 ? '0' + s: s;
}
function getNowFormatDate(type) {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + p(date.getHours()) + seperator2 + p(date.getMinutes())
        + seperator2 + p(date.getSeconds());
    if(type==1) {
        return currentdate;
    }else if(type==2){
        return {
            'nian':date.getFullYear(),
            'yue':month,
            'ri':strDate,
            'shi':p(date.getHours()),
            'fen':p(date.getMinutes()),
            'miao':p(date.getSeconds())
        }
    }
}

function news() {

    var obj={
        page:1,
        pageSize:6,
        useFlag:true
    };
    $.get('/news/newsManage',obj,function (json) {
        if(json.flag){
            var datas=json.obj;
            var hsonstrone='';
            var jsonstr='';

            if(datas.length!=0) {
                var imgurl = datas[0].attachment;
                if(imgurl.length!=0){
                    var attachName=imgurl[0].attachName.split('.')[1];
                    if(attachName=='jpg'||attachName=='png'||attachName=='jpeg'){
                        $('.topmainleft .daiban .lt img').prop('src','/xs?'+imgurl[0].attUrl);
                        for(var i=0;i<datas.length;i++){
                            if(i<3) {
                                jsonstr += '<a style="color: #000" href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><li class="clearfix">\
                                    <div class="sor-t">\
                                        <div class="sr-f">' + datas[i].subject + '</div>\
                                        <div class="src-r">' + datas[i].newsDateTime.slice(0, 10) + '</div>\
                                    </div>\
                                    <div class="sor-b">' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</div>\
                            </li></a>'
                            }
                        }
                        $('#sorc').html(jsonstr);
                    }else {
                        for(var i=0;i<datas.length;i++){
                            if(i<3) {
                                jsonstr += '<a style="color: #000" href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><li class="clearfix">\
                                    <div class="sor-t">\
                                        <div class="sr-f">' + datas[i].subject + '</div>\
                                        <div class="src-r">' + datas[i].newsDateTime.slice(0, 10) + '</div>\
                                    </div>\
                                    <div class="sor-b">' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</div>\
                            </li></a>'
                            }else {
                                hsonstrone += '<a style="color: #000" href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><li class="clearfix">\
                                    <div class="sor-t">\
                                        <div class="sr-f">' + datas[i].subject + '</div>\
                                        <div class="src-r">' + datas[i].newsDateTime.slice(0, 10) + '</div>\
                                    </div>\
                                    <div class="sor-b">' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</div>\
                            </li></a>'
                            }




                        }
                        $('#sorc').html(hsonstrone);
                        $('#sorcs').html(jsonstr);
                        $('#sorcs').siblings('img').remove()
                    }
                }else {
                    for(var i=0;i<datas.length;i++){
                        if(i<3) {
                            jsonstr += '<a style="color: #000" href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><li class="clearfix">\
                                    <div class="sor-t">\
                                        <div class="sr-f">' + datas[i].subject + '</div>\
                                        <div class="src-r">' + datas[i].newsDateTime.slice(0, 10) + '</div>\
                                    </div>\
                                    <div class="sor-b">' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</div>\
                            </li></a>'
                        }else {
                            hsonstrone += '<a style="color: #000" href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><li class="clearfix">\
                                    <div class="sor-t">\
                                        <div class="sr-f">' + datas[i].subject + '</div>\
                                        <div class="src-r">' + datas[i].newsDateTime.slice(0, 10) + '</div>\
                                    </div>\
                                    <div class="sor-b">' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</div>\
                            </li></a>'
                        }
                    }
                    $('#sorc').html(hsonstrone);
                    $('#sorcs').html(jsonstr);
                    $('#sorcs').siblings('img').remove()
                }
            }










            if(datas.length==0) {
                $('.lt').remove();
                $('.rt').remove();
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</div>';
                    $('.topmainleft .daiban').append(lis)

            }
        }else {
            $('.lt').remove();
            $('.rt').remove();
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</div>';
            $('.topmainleft .daiban').append(lis)

        }
    },'json')
}
function clearfixClick(element){
    var dataurl = element.attr('dataurl');
    window.open(dataurl);
}
function announcement() {

    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
        documentType:1
    };
    $.get('/document/selWillDocSendOrReceive',obj,function (json) {
        if(json.flag){
            var datas=json.datas;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                if('1' == datas[i].branchCount){
                    var dataurl = '/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId='+datas[i].realPrcsId+'&flowStep='+datas[i].step
                        +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true'
                }else{
                    var dataurl = '/workflow/work/workform?flowId='+datas[i].flowId+'&prcsId='+datas[i].realPrcsId+'&flowStep='+datas[i].step
                        +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true&opFlag='+datas[i].opFlag
                }
                jsonstr+='<li class="clearfix" onclick="clearfixClick($(this))" dataurl="'+ dataurl +'">\
                    <div class="lef"><div style="float: left;margin: 0 4px;width: 40px;"><img style="width: 95%;border-radius: 50%" src="'+function () {
                        if(datas[i].sex==0){
                            return '/img/user/boy.png'
                        }
                        else if(datas[i].sex==1){
                            return '/img/user/girl.png'
                        }
                        // else {
                        //     // return '/img/user/'+datas[i].avater
                        //     return '/img/user/'+datas[i].avatar
                        // }
                    }()+'" alt=""></div><a style="color: #000;position: relative;top: 2px;">'+function () {

                        if(datas[i].createrName==''||datas[i].createrName==undefined){
                            return datas[i].createrName=''
                        } else {
                            return datas[i].createrName
                        }
                    }()+'<div><a style="color: #1b5e8d;line-height: 24px;" href="javascript:void(0)" target="_blank">'+function () {
                        if(datas[i].title==''||datas[i].title==undefined){
                            return datas[i].title=''
                        } else {
                            return datas[i].title.slice(0,5)
                        }
                    }()+'</a></div></div>\
                    </a><div class="rit">'+datas[i].printDate+'</div>\
                </li>'
            }
            $('#witgw').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#witgw').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#witgw').html(lis);
        }
    },'json')
}

function yiReveice() {
    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
        documentType:1
    };
    $.get('/document/selOverDocSendOrReceive',obj,function (json) {
        if(json.flag){
            var datas=json.datas;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                jsonstr+='<li class="clearfix" onclick="clearfixClick($(this))" dataurl="/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId=&flowStep='
                    +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true">\
                    <div class="lef"><div style="float: left;margin: 0 4px;width: 40px;"><img style="width: 95%;border-radius: 50%" src="'+function () {
                        if(datas[i].sex==0){
                            return '/img/user/boy.png'
                        }
                        else if(datas[i].sex==1){
                            return '/img/user/girl.png'
                        }else {
                            return '/img/user/'+datas[i].avatar
                            // return '/img/user/boy.png'
                        }
                    }()+'" alt=""></div><a style="color: #000;position: relative;top: 2px;">'+function () {

                        if(datas[i].createrName==''||datas[i].createrName==undefined){
                            return datas[i].createrName=''
                        } else {
                            return datas[i].createrName
                        }
                    }()+'<div><a style="color: #1b5e8d;line-height: 24px;" href="/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId=&flowStep='
                    +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true" target="_blank">'+function () {
                        if(datas[i].title==''||datas[i].title==undefined){
                            return datas[i].title=''
                        } else {
                            return datas[i].title.slice(0,5)
                        }
                    }()+'</a></div></div>\
                    </a><div class="rit">'+datas[i].printDate+'</div>\
                </li>'
            }
            $('#witgw').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#witgw').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#witgw').html(lis);
        }
    },'json')
}


function dbsend() {

    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
        documentType:0,
    };
    $.get('/document/selWillDocSendOrReceive',obj,function (json) {
        if(json.flag){
            var datas=json.datas;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                if('1' == datas[i].branchCount){
                    var dataurl = '/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId='+datas[i].realPrcsId+'&flowStep='+datas[i].step
                        +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true'
                }else{
                    var dataurl = '/workflow/work/workform?flowId='+datas[i].flowId+'&prcsId='+datas[i].realPrcsId+'&flowStep='+datas[i].step
                        +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true&opFlag='+datas[i].opFlag+''
                }
                jsonstr+='<li class="clearfix" onclick="clearfixClick($(this))" dataurl="'+ dataurl +'">\
                    <div class="lef"><div style="float: left;margin: 0 4px;width: 40px;"><img style="width: 95%;border-radius: 50%" src="'+function () {
                        if(datas[i].sex==0){
                            return '/img/user/boy.png'
                        }
                        else if(datas[i].sex==1){
                            return '/img/user/girl.png'
                        }
                        debugger;
                        // else {
                        //     return '/img/user/'+datas[i].avatar
                        //     // return '/img/user/boy.png'
                        // }
                    }()+'" alt=""></div><a style="color: #000;position: relative;top:2px;">'+function () {

                        if(datas[i].createrName==''||datas[i].createrName==undefined){
                            return datas[i].createrName=''
                        } else {
                            return datas[i].createrName
                        }
                    }()+'<div><a style="color: #1b5e8d;line-height: 24px;" href="javascript:void(0)" target="_blank">'+function () {
                        if(datas[i].title==''||datas[i].title==undefined){
                            return datas[i].title=''
                        } else {
                            return datas[i].title.slice(0,5)
                        }
                    }()+'</a></div></div>\
                    </a><div class="rit">'+datas[i].printDate+'</div>\
                </li>'
            }
            $('#dbsend').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#dbsend').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#dbsend').html(lis);
        }
    },'json')
}

function yisend() {

    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
        documentType:0,
    };
    $.get('/document/selOverDocSendOrReceive',obj,function (json) {
        if(json.flag){
            var datas=json.datas;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                jsonstr+='<li class="clearfix" onclick="clearfixClick($(this))" dataurl="/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId=&flowStep='
                    +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true">\
                    <div class="lef"><div style="float: left;margin: 0 4px;width: 40px;"><img style="width: 95%;border-radius: 50%" src="'+function () {
                        if(datas[i].avater==0){
                            return '/img/user/boy.png'
                        }
                        else if(datas[i].avater==1){
                            return '/img/user/girl.png'
                        }else {
                            return '/img/user/'+datas[i].avatar
                            // return '/img/user/boy.png'
                        }
                    }()+'" alt=""></div><a style="color: #000;position: relative;top:2px;">'+function () {

                        if(datas[i].createrName==''||datas[i].createrName==undefined){
                            return datas[i].createrName=''
                        } else {
                            return datas[i].createrName.slice(0,5)
                        }
                    }()+'<div><a style="color: #1b5e8d;line-height: 24px;" href="/workflow/work/workformPreView?flowId='+datas[i].flowId+'&prcsId=&flowStep='
                    +'&runId='+datas[i].runId+'&tabId='+datas[i].id+'&tableName='+datas[i].tableName+'&isNomalType=false&hidden=true" target="_blank">'+function () {
                        if(datas[i].title==''||datas[i].title==undefined){
                            return datas[i].title=''
                        } else {
                            return datas[i].title
                        }
                    }()+'</a></div></div>\
                    </a><div class="rit">'+datas[i].printDate+'</div>\
                </li>'
            }
            $('#dbsend').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#dbsend').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#dbsend').html(lis);
        }
    },'json')
}

function meti() {

    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
    };
    $.get('/meeting/getMeetingNotify',obj,function (json) {
        if(json.flag){
            var datas=json.obj;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                jsonstr+='<li class="clearfix">\
                    <div class="lef" style="margin-top: 7px;font-size: 14px"><div style="float: left;margin: 0 8px"><img src="/img/data_point.png" alt=""></div><a style="color: #1b5e8d" href="meeting/detail?meetingId='+datas[i].sid+'" target="_blank">'+function () {
                        if(datas[i].meetName==''||datas[i].meetName==undefined){
                            return datas[i].meetName=''
                        } else {
                            return datas[i].meetName
                        }
                    }()+'</a></div>\
                    <div class="rit">'+function () {

                        if(datas[i].startTime!=undefined){
                            return datas[i].startTime.slice(0,10)
                        }else {
                            return ''
                        }


                    }()+'</div>\
                </li>'
            }
            $('#huiyi').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#huiyi').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#huiyi').html(lis);
        }
    },'json')
}


// 工作流待办
function wait(){
    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
    };
    $.get('/workflow/work/selectWork',obj,function (json) {
        if(json.flag){
            var datas=json.obj;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                jsonstr+='<li class="clearfix"  dataurl="/workflow/work/workform?opflag=' + datas[i].opFlag + '&flowId=' + datas[i].flowRun.flowId + '&prcsId=' + datas[i].flowProcess.prcsId + '&flowStep=' + datas[i].prcsId+'&runId=' + datas[i].runId+'">\
                    <div class="lef" style="margin-top: 7px;font-size: 14px"><div style="float: left;margin: 0 8px"><img src="/img/data_point.png" alt=""></div><a style="color: #1b5e8d" href="/workflow/work/workform?opflag=' + datas[i].opFlag + '&flowId=' + datas[i].flowRun.flowId + '&prcsId=' + datas[i].flowProcess.prcsId + '&flowStep=' + datas[i].prcsId+'&runId=' + datas[i].runId+'" title="'+datas[i].flowRun.runName+'" target="_blank">'+function () {
                    if(datas[i].flowRun.runName==''||datas[i].flowRun.runName==undefined){
                        return datas[i].flowRun.runName=''
                    } else {
                        return datas[i].flowRun.runName
                    }
                }()+'</a></div>'+
                '</li>'
            }
            $('#huiyi').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#huiyi').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#huiyi').html(lis);
        }
    },'json')
}
//已办
function yiban(){
    var obj={
        page:1,
        pageSize:4,
        useFlag:true,
    };
    $.get('/workflow/work/selectEndWord',obj,function (json) {
        if(json.flag){
            var datas=json.obj;
            var jsonstr='';
            for(var i=0;i<datas.length;i++){
                jsonstr+='<li class="clearfix" onclick="clearfixClick($(this))" dataurl="/workflow/work/workformPreView?flowId='+datas[i].flowRun.flowId+'&prcsId=&flowStep=&runId='+datas[i].runId+'" style="display:'+function(){
                               if(datas[i].isHidden == '0'){
                                    return 'block'
                               }else{
                                    return 'none'
                                }
                            }()+'">\
                            <div class="lef" style="margin-top: 7px;font-size: 14px;"><div style="float: left;margin: 0 8px"><img src="/img/data_point.png" alt=""></div><a style="color: #1b5e8d" href="/workflow/work/workformPreView?flowId='+datas[i].flowRun.flowId+'&prcsId=&flowStep=&runId='+datas[i].runId+'" title="'+datas[i].flowRun.runName+'" target="_blank">'+function () {
                        if(datas[i].flowRun.runName==''||datas[i].flowRun.runName==undefined){
                                return datas[i].flowRun.runName=''
                            } else {
                                return datas[i].flowRun.runName
                            }
                        }()+'</a></div>'+
                    '</li>'
            }
            $('#huiyi').html(jsonstr);
            if(datas.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#huiyi').html(lis);
            }
        }else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                '</li>';
            $('#huiyi').html(lis);
        }
    },'json')
}


var now = null;
var  today_now=null;

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


function richeng(time) {
    $.get('/schedule/getscheduleByDay',{
        userId: $.cookie('userId'),
        time: time
    },function (json) {
        if(json.flag){
            var arr=json.obj;
            var str='';
            for(var i=0;i<arr.length;i++){/*日程安排*/
                str+='<li>\
                    <img style="margin-right: 5px" src="/img/main_img/naozhong.png" alt="">\
                    <span class="overhides">'+arr[i].content+'</span>\
                    <div class="fr"\
                    onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">\
                    <img style="margin: 0 10px;cursor: pointer" src="/img/main_img/xiugaia.png" alt="">\
                    <h2 class="hide">'+main_schedule+'</h2>\
                     </div>\
                     <div class="fr"\
                    onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">\
                    <img  style="cursor: pointer" src="/img/main_img/chakana.png" alt="">\
                    <h2 class="hide">'+main_schedule+'</h2>\
                    </div>\
                    </li>'
            }
            $('.topmainright .topmainright-main').html(str)
            if(arr.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;margin-top: 0px;line-height:107px;">' +

                    '<p style="height:0;text-align: center;color: #666;font-size: 11pt">暂无待办日程</p>' +/*暂无数据*/
                    '</li>';
                $('.topmainright .topmainright-main').html(lis);
            }
        }
    },'json')
}

$(function () {
    $('.topmainright .r-top h4').text(getNowFormatDate(2).nian+'-'+getNowFormatDate(2).yue+'-'+getNowFormatDate(2).ri)
    $('.topmainright .r-top h3').text(getNowFormatDate(2).shi+':'+getNowFormatDate(2).fen)

    richeng(today_now)
    var dates=getNowFormatDate(2);
    $('.daibantop .left h4').text(dates.shi+':'+dates.fen)
    $('.daibantop .left span').text(dates.nian+'-'+dates.yue+'-'+dates.ri)

    announcement()
    dbsend()
    // meti()
    wait();
    news()
    $('.flowBtn').click(function () {
        var type = $(this).attr('datatype');
        $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
        if(type == '0'){
            wait()
        }else{
            yiban();
        }
    })

    $('.reveiveBtn').click(function(){
        var type = $(this).attr('datatype');
        $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
        if(type == '0'){
            announcement();
            $(this).siblings('.more').attr({
                'menu_tid':"650505",
                "data-url":"document/recv/backlog"
            }).find('h2').html('待办收文');
        }else{
            yiReveice();
            $(this).siblings('.more').attr({
                'menu_tid':"650510",
                "data-url":"document/recv/have"
            }).find('h2').html('已办收文');
        }
    })
    $('.sendBtn').click(function(){
        var type = $(this).attr('datatype');
        $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
        if(type == '0'){
            dbsend();
            $(this).siblings('.more').attr({
                'menu_tid':"650105",
                "data-url":"document/send/backlog"
            }).find('h2').html('待办发文');
        }else{
            yisend();
            $(this).siblings('.more').attr({
                'menu_tid':"650110",
                "data-url":"document/send/have"
            }).find('h2').html('已办发文');
        }
    })
    $.get('/email/showEmail',{
            flag:'inbox',
            page:1,
            pageSize:5,
            useFlag:'true'
    },function (json) {
        if(json.flag){
            var data=json.obj;
            var all='';
            var yidu='';
            var weidu='';
            for(var i=0;i<data.length;i++){
                for(var m=0;m<data[i].emailList.length;m++){
                    all+=' <li class="clearfix">\
                        <span class="fl">\
                        <img style="width: 38px;" src="'+function () {
                            if(data[i].users.avatar==0){
                                return '/img/user/boy.png'
                            }
                            else if(data[i].users.avatar==1){
                                return '/img/user/girl.png'
                            }else {
                                return '/img/user/'+data[i].users.avatar
                            }
                        }()+'" alt="">\
                        </span>\
                        <div class="textmains fl" style="width: calc(100% - 38px)">\
                        <p class="top">\
                        <label>'+data[i].users.userName+'</label>\
                        <a class="fr" href="javascript:void(0)">'+
                        new Date((data[i].sendTime) * 1000).Format('MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>')+'</a>\
                    </p>\
                    <p class="buttom">\
                        <span><a target="_blank" href="/email/details?id=' + data[i].emailList[m].emailId + '">'+data[i].subject+'</a></span>\
                    '+function () {
                            if(data[i].attachmentId==''){
                                return ''
                            }else {
                                return '<img style="float: right"  class="accessory" src="/img/main_img/accessory.png" alt="">'
                            }
                        }()+'\
                        </p>\
                        </div>\
                        </li>'




                    if (data[i].emailList[m].readFlag == 0) {
                        weidu+='<li class="clearfix">\
                            <span class="fl">\
                            <img style="width: 38px;" src="'+function () {
                                if(data[i].users.avatar==0){
                                    return '/img/user/boy.png'
                                }
                                else if(data[i].users.avatar==1){
                                    return '/img/user/girl.png'
                                }else {
                                    return '/img/user/'+data[i].users.avatar
                                }
                            }()+'" alt="">\
                            </span>\
                            <div class="textmains fl" style="width: calc(100% - 38px)">\
                            <p class="top">\
                            <label>'+data[i].users.userName+'</label>\
                            <a class="fr" href="javascript:void(0)">'+
                            new Date((data[i].sendTime) * 1000).Format('MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>')+'</a>\
                        </p>\
                        <p class="buttom">\
                            <span><a target="_blank" href="/email/details?id=' + data[i].emailList[m].emailId + '">'+data[i].content.replace(/<\/?.+?>/g,"").replace(/ /g,"")+'</a></span>\
                        '+function () {
                                if(data[i].attachmentId==''){
                                    return ''
                                }else {
                                    return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                }
                            }()+'\
                            </p>\
                            </div>\
                            </li>'
                    }
                    else if(data[i].emailList[m].readFlag == 1){
                        yidu+=  ' <li class="clearfix">\
                        <span class="fl">\
                        <img style="width: 38px;" src="'+function () {
                                if(data[i].users.avatar==0){
                                    return '/img/user/boy.png'
                                }
                                else if(data[i].users.avatar==1){
                                    return '/img/user/girl.png'
                                }else {
                                    return '/img/user/'+data[i].users.avatar
                                }
                            }()+'" alt="">\
                        </span>\
                        <div class="textmains fl" style="width: calc(100% - 38px)">\
                        <p class="top">\
                        <label>'+data[i].users.userName+'</label>\
                        <a class="fr" href="javascript:void(0)">'+
                            new Date((data[i].sendTime) * 1000).Format('MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>')+'</a>\
                    </p>\
                    <p class="buttom">\
                        <span><a target="_blank" href="/email/details?id=' + data[i].emailList[m].emailId + '">'+data[i].subject+'</a></span>\
                    '+function () {
                                if(data[i].attachmentId==''){
                                    return ''
                                }else {
                                    return '<img style="float: right"  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                }
                            }()+'\
                        </p>\
                        </div>\
                        </li>'
                    }
                }
            }

            $('[data-t="all"]').html(all)
            $('[data-t="weidu"]').html(weidu)
            $('[data-t="yidu"]').html(yidu)
            if(all==''){
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('[data-t="all"]').html(lis);
            }
            if(weidu==''){
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('[data-t="weidu"]').html(lis);
            }
            if(yidu==''){
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('[data-t="yidu"]').html(lis);
            }


        }
    },'json')



    $.get('/todoList/smsListByType',function (json) {
        var daiban='';
        var data=json.data;
        if(data.workFlow!=undefined) {
            for (var i = 0; i < data.workFlow.length; i++) {
                daiban += '<li class="clearfix" onclick="parent.windowOpenNew(this)"\
                data-url="'+data.workFlow[i].remindUrl+'" data-s="2" style="cursor: pointer">\
                <span class="fl">\
                <img style="width: 38px;" src="'+function () {
                        if(data.workFlow[i].avater==0){
                            return '/img/user/boy.png'
                        }
                        else if(data.workFlow[i].avater==1){
                            return '/img/user/girl.png'
                        }else {
                            return '/img/user/'+data.workFlow[i].avater
                        }
                    }()+'" alt="">\
                </span>\
                <div class="textmains fl" style="width: calc(100% - 38px)">\
                <p class="top">\
                <label>'+data.workFlow[i].userName+'</label>\
                <a class="fr" href="javascript:void(0)">'+data.workFlow[i].sendTimeStr.replace(/\s/,'<i style="margin: 0px 5px;"></i>')+'</a>\
            </p>\
            <p class="buttom">\
                <span>'+data.workFlow[i].content+'</span>\
            <a href="javascript:void(0)" style="float: right;color: #3c92e5;">'+Please_look_process+'</a>\
                </p>\
                </div>\
                </li>'
            }/*请查看流程*/
            $('#liucheng').html(daiban);
            if(data.workFlow.length==0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#liucheng').html(lis);

            }

        }
    },'json')


    $.get('/news/newsManage',{
        page:'1',
        read:'',
        pageSize:'2',
        useFlag:'true'
    },function (json) {
        if(json.flag){
            var datas=json.obj;
            var str='';
            for(var i=0;i<datas.length;i++){
                str+=' <div class="textmain">\
                    <p class="title">\
                    <strong>'+datas[i].subject+'</strong>\
                    <a class="fr" href="javascript:void(0)">'+datas[i].newsDateTime.split(/\s/)[0]+'</a>\
                </p>\
                <p class="pmain">\
                '+datas[i].content.replace(/<\/?.+?>/g,"").replace(/ /g,"")+'\
                </p>\
                </div>'
            }
            $('.topmaincenter').append(str);
            if(str==''){

                     str = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;    font-size: 14px;">'+no_Data+'</h2>' +/*暂无数据*/
                        '</div>';
                    $('.topmaincenter').append(str);

            }

        }
    },'json')





    
    
    
    $('.navigations span').click(function () {
        $(this).siblings('span').removeClass('active');
        $(this).addClass('active')
        $(this).parent().parent().siblings('ul').hide()
        $(this).parent().parent().siblings('[data-t="'+$(this).attr('data-type')+'"]').show();
    })







})