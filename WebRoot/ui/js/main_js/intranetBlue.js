/**
 * Created by 骆鹏 on 2018/3/1.
 */
if (type == 'zh_CN') {
    var main_schedule = '日程安排';
    var no_Data = '暂无数据';
    var Please_look_process = '请查看流程';
} else if (type == 'zh_TW') {
    var main_schedule = '日程安排';
    var no_Data = '暂无数据';
    var Please_look_process = '请查看流程';
} else if (type == 'en_US') {
    var main_schedule = 'Schedule';
    var no_Data = 'No data';
    var Please_look_process = 'Please look at the process';
} else {
    var main_schedule = '日程安排';
    var no_Data = '暂无数据';
    var Please_look_process = '请查看流程';
}
function p(s) {
    return s < 10 ? '0' + s : s;
}
function getNowFormatDate(type) {
    var date = new Date();
   console.log(date);
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
        + " " + p(date.getHours()) + seperator2 + p(date.getMinutes() + p(date.getSeconds()))
        + seperator2 + p(date.getSeconds());
    if (type == 1) {
        return currentdate;
    } else if (type == 2) {
        return {
            'nian': date.getFullYear(),
            'yue': month,
            'ri': strDate,
            'shi': p(date.getHours()),
            'fen': p(date.getMinutes()),
            'miao': p(date.getSeconds())
        }
    }
}

function tiaozhuan(me) {
    window.open($(me).attr('data-url'))
}
function announcement() {
    var obj = {
        read: '',
        page: 1,
        pageSize: 4,
        useFlag: 'true',
        typeId: ''
    };
    $.get('notice/notifyManage', obj, function (json) {
        if (json.flag) {
            var datas = json.obj;
            var jsonstr = '';
            for (var i = 0; i < datas.length; i++) {
                jsonstr += '\
                <li class="clearfix" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + datas[i].notifyId + '">\
                        <span class="fl">\
                        <img style="width: 38px;" src="' + function () {
                        if (datas[i].users.avatar != 0 && datas[i].users.avatar != 1 && datas[i].users.avatar != '') {
                            return '/img/user/' + datas[i].users.avatar;
                        }
                        if (datas[i].users.sex == 0) {
                            return '/img/user/boy.png';
                        }
                        else if (datas[i].users.sex == 1) {
                            return '/img/user/girl.png';
                        }
                    }() + '" alt="" onerror="imgerror(this,1)">\
                        </span>\
                        <div class="textmains fl" style="width: calc(100% - 38px)">\
                        <p class="top">\
                        <label>' + datas[i].users.userName + '</label>\
                        <a class="fr" href="javascript:void(0)">' +
                    datas[i].notifyDateTime + '</a>\
                    </p>\
                    <p class="buttom">\
                        <span><a href="javascript:void(0)" title="' + datas[i].subject + '">' + datas[i].subject + '</a></span>\
                    ' + function () {
                        if (datas[i].attachmentId == '') {
                            return '';
                        } else {
                            return '<img style="float: right"  class="accessory" src="img/main_img/accessory.png" alt="">'
                        }
                    }() + '\
                        </p>\
                        </div>\
                        </li>';

            }
            $('#buttommaincontent').html(jsonstr);
            if (datas.length == 0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">' + no_Data + '</h2>' +
                    '</li>';
                $('#buttommaincontent').html(lis);
            }
        } else {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">' + no_Data + '</h2>' +
                '</li>';
            $('#buttommaincontent').html(lis);
        }
    }, 'json')
}


var now = null;
var today_now = null;

var myDate = new Date();
//获取当前年
var year = myDate.getFullYear();
//获取当前月
var month = myDate.getMonth() + 1;
//获取当前日
var date = myDate.getDate();
var h = myDate.getHours();       //获取当前小时数(0-23)
var m = myDate.getMinutes();     //获取当前分钟数(0-59)
var s = myDate.getSeconds();

now = year + '-' + p(month) + "-" + p(date) + " " + p(h) + ':' + p(m) + ":" + p(s);
today_now = year + '-' + p(month) + "-" + p(date);
// 获取某个时间格式的时间戳
var timestamp2 = Date.parse(new Date(now));
timestamp2 = timestamp2 / 1000;//当前时间


function richeng(time) {
    $.get('/schedule/getscheduleByDay', {
        userId: $.cookie('userId'),
        time: time
    }, function (json) {
        if (json.flag) {
            var arr = json.obj;
            var str = '';
            for (var i = 0; i < arr.length; i++) {
                str += '<li>\
                    <img style="margin-right: 5px" src="img/main_img/naozhong.png" alt="">\
                    <span class="overhides">' + arr[i].content + '</span>\
                    <div class="fr"\
                    onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">\
                    <img style="margin: 0 10px;cursor: pointer" src="img/main_img/xiugaia.png" alt="">\
                    <h2 class="hide">' + main_schedule + '</h2>\
                     </div>\
                     <div class="fr"\
                    onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">\
                    <img  style="cursor: pointer" src="img/main_img/chakana.png" alt="">\
                    <h2 class="hide">' + main_schedule + '</h2>\
                    </div>\
                    </li>'
            }
            $('.topmainright .topmainright-main').html(str)
            if (arr.length == 0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;margin-top: 0px;    line-height: 110px;">' +
                    '' +
                    '<p style="text-align: center;color: #666;font-size: 11pt">暂无日程安排</p>' +
                    '</li>';
                $('.topmainright .topmainright-main').html(lis);
            }
        }
    }, 'json')
}

var serverTime = '';
function getNowTime() {
    // $.ajax({
    //     url: '/getDate',
    //     type: 'get',
    //     dataType: 'json',
    //     success: function (reg) {
            var nowTime = new Date().getTime();
            serverTime = nowTime;
            var date1 = new Date(nowTime).Format('yyyy-MM-dd ');
            var date2 = new Date(nowTime).Format(' hh:mm:ss');
                $('.daibantop .left h3').text(date1);
                $('.daibantop .left h4').text(date2);

    //     }
    // });
}
setInterval(function () {
    serverTime = serverTime + 1000;
    var nowTime = serverTime;
    var date1 = new Date(nowTime).Format('yyyy-MM-dd ');
    var date2 = new Date(nowTime).Format(' hh:mm:ss');
    $('.daibantop .left h3').text(date1);
    $('.daibantop .left h4').text(date2);
},1000);

$(function () {
    getNowTime();
    richeng(today_now)
    // var dates=getNowFormatDate(2);
    // $('.daibantop .left h4').text(dates.shi+':'+dates.fen+':'+dates.miao)
    // $('.daibantop .left span').text(dates.nian+'-'+dates.yue+'-'+dates.ri)
    announcement();
    $.get('email/showEmail', {
        flag: 'inbox',
        page: 1,
        pageSize: 4,
        useFlag: 'true'
    }, function (json) {
        // if(json.flag){
        var data = json.obj;
        if (data != undefined) {
            var all = '';
            var yidu = '';
            var weidu = '';
            for (var i = 0; i < data.length; i++) {
                for (var m = 0; m < data[i].emailList.length; m++) {
                    if (data[i].users != undefined) {
                        all += ' <li class="clearfix" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[m].emailId + '">\
                        <span class="fl">\
                        <img style="width: 38px;" src="' + function () {
                                if (data[i].users.avatar != 0 && data[i].users.avatar != 1 && data[i].users.avatar != '') {
                                    return '/img/user/' + data[i].users.avatar;
                                }
                                if (data[i].users.sex == 0) {
                                    return '/img/user/boy.png';
                                }
                                else if (data[i].users.sex == 1) {
                                    return '/img/user/girl.png';
                                }
                            }() + '" alt="" onerror="imgerror(this,1)">\
                        </span>\
                        <div class="textmains fl" style="width: calc(100% - 38px)">\
                        <p class="top">\
                        <label>' + data[i].users.userName + '</label>\
                        <a class="fr" href="javascript:void(0)">20' +
                            new Date((data[i].sendTime) * 1000).Format('yy-MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</a>\
                    </p>\
                    <p class="buttom">\
                        <span><a  href="javascript:void(0)" title="' + data[i].subject + '">' + data[i].subject + '</a></span>\
                    ' + function () {
                                if (data[i].attachmentId == '') {
                                    return ''
                                } else {
                                    return '<img style="float: right"  class="accessory" src="img/main_img/accessory.png" alt="">'
                                }
                            }() + '\
                        </p>\
                        </div>\
                        </li>'
                        if (data[i].emailList[m].readFlag == 0) {
                            weidu += '<li class="clearfix" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[m].emailId + '">\
                            <span class="fl">\
                            <img style="width: 38px;" src="' + function () {
                                    if (data[i].users.avatar != 0 && data[i].users.avatar != 1 && data[i].users.avatar != '') {
                                        return '/img/user/' + data[i].users.avatar;
                                    }
                                    if (data[i].users.sex == 0) {
                                        return '/img/user/boy.png';
                                    }
                                    else if (data[i].users.sex == 1) {
                                        return '/img/user/girl.png';
                                    }
                                }() + '" alt="" onerror="imgerror(this,1)">\
                            </span>\
                            <div class="textmains fl" style="width: calc(100% - 38px)">\
                            <p class="top">\
                            <label>' + data[i].users.userName + '</label>\
                            <a class="fr" href="javascript:void(0)">20' +
                                new Date((data[i].sendTime) * 1000).Format('yy-MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</a>\
                        </p>\
                        <p class="buttom">\
                            <span><a  href="javascript:void(0)">' + data[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '</a></span>\
                        ' + function () {
                                    if (data[i].attachmentId == '') {
                                        return ''
                                    } else {
                                        return '<img  class="accessory" src="img/main_img/accessory.png" alt="">'
                                    }
                                }() + '\
                            </p>\
                            </div>\
                            </li>'
                        }
                        else if (data[i].emailList[m].readFlag == 1) {
                            yidu += ' <li class="clearfix" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[m].emailId + '">\
                        <span class="fl">\
                        <img style="width: 38px;" src="' + function () {
                                    if (data[i].users.avatar != 0 && data[i].users.avatar != 1 && data[i].users.avatar != '') {
                                        return '/img/user/' + data[i].users.avatar;
                                    }
                                    if (data[i].users.sex == 0) {
                                        return '/img/user/boy.png';
                                    }
                                    else if (data[i].users.sex == 1) {
                                        return '/img/user/girl.png';
                                    }
                                }() + '" alt="" onerror="imgerror(this,1)">\
                        </span>\
                        <div class="textmains fl" style="width: calc(100% - 38px)">\
                        <p class="top">\
                        <label>' + data[i].users.userName + '</label>\
                        <a class="fr" href="javascript:void(0)">20' +
                                new Date((data[i].sendTime) * 1000).Format('yy-MM-dd hh:mm:ss').replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</a>\
                    </p>\
                    <p class="buttom">\
                        <span><a  href="javascript:void(0)" title="' + data[i].subject + '">' + data[i].subject + '</a></span>\
                    ' + function () {
                                    if (data[i].attachmentId == '') {
                                        return ''
                                    } else {
                                        return '<img style="float: right"  class="accessory" src="img/main_img/accessory.png" alt="">'
                                    }
                                }() + '\
                        </p>\
                        </div>\
                        </li>'
                        }
                    }

                }
            }

            $('[data-t="all"]').html(all)
            $('[data-t="weidu"]').html(weidu)
            $('[data-t="yidu"]').html(yidu)
            if (all == '') {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">' + no_Data + '</h2>' +
                    '</li>';
                $('[data-t="all"]').html(lis);
            }
            if (weidu == '') {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">' + no_Data + '</h2>' +
                    '</li>';
                $('[data-t="weidu"]').html(lis);
            }
            if (yidu == '') {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;    font-size: 14px;">' + no_Data + '</h2>' +
                    '</li>';
                $('[data-t="yidu"]').html(lis);
            }

        }

        // }
    }, 'json')


    $.get('todoList/smsListByType?dataid=1', function (json) {
        var daiban = '';
        var data = json.data;
        if (!json.flag) {
            var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;font-size: 14px">' + no_Data + '</h2>' +
                '</li>';
            $('#liucheng').html(lis);
        }
        if (data.workFlow != undefined) {
            for (var i = 0; i < data.workFlow.length; i++) {
                daiban += '<li class="clearfix" onclick="parent.windowOpenNew(this)"\
                data-url="' + data.workFlow[i].remindUrl + '" data-s="2" style="cursor: pointer">\
                <span class="fl">\
                <img style="width: 38px;" src="' + function () {
                        if (data.workFlow[i].avater != 0 && data.workFlow[i].avater != 1 && data.workFlow[i].avater != '') {
                            return '/img/user/' + data.workFlow[i].avater;
                        }
                        if (data.workFlow[i].sex == 0) {
                            return '/img/user/boy.png';
                        }
                        else if (data.workFlow[i].sex == 1) {
                            return '/img/user/girl.png';
                        }
                    }() + '" alt="" onerror="imgerror(this,1)">\
                </span>\
                <div class="textmains fl" style="width: calc(100% - 38px)">\
                <p class="top">\
                <label>' + data.workFlow[i].userName + '</label>\
                <a class="fr" href="javascript:void(0)">' + data.workFlow[i].sendTimeStr.replace(/\s/, '<i style="margin: 0px 5px;"></i>') + '</a>\
            </p>\
            <p class="buttom">\
                <span title="' + data.workFlow[i].content + '">' + data.workFlow[i].content + '</span>\
            <a href="javascript:void(0)" style="float: right;color: #3c92e5;">' + Please_look_process + '</a>\
                </p>\
                </div>\
                </li>'
            }
            $('#liucheng').html(daiban);
            if (data.workFlow.length == 0) {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">' + no_Data + '</h2>' +
                    '</li>';
                $('#liucheng').html(lis);

            }


        }
    }, 'json')

    $.get('/portals/selPortalsUser', function (json) {
        if (json.flag) {
            var data = json.object;
            $('.daibantop .right strong').text(data.userName);
            $('.daibantop .right .zhiwei').text(data.userPrivName);
            if (data.diary != undefined) {
                if (data.diary.subject == undefined || data.diary.subject == '') {
                    $('.daibanbuttom .buttom').text('天天有个好心情!');
                } else {
                    $('.daibanbuttom .buttom').text(data.diary.subject);
                }
            } else {
                $('.daibanbuttom .buttom').text('天天有个好心情!');
            }

            if (data.toDoCount != '') {
                $($('.daibanbuttom .left p')[0]).find('span').text(data.toDoCount);
            }
            if (data.doneCount != '') {
                $($('.daibanbuttom .left p')[1]).find('span').text(data.doneCount);
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

            $('#nameurl').attr({
                'src': str,
                'onerror': 'imgerror(this,1)'
            });
        }
    }, 'json')


    $.get('/news/newsManage', {
        page: '1',
        read: '',
        pageSize: '4',
        useFlag: 'true'
    }, function (json) {
        // if(json.flag){
        var datas = json.obj;
        var str = '';

        if (datas.length != 0) {
            var imgurl = datas[0].attachment;
            if (imgurl.length != 0) {
                var attachName = imgurl[0].attachName.split('.')[1];
                if (attachName == 'jpg' || attachName == 'png' || attachName == 'jpeg') {
                    $('.topmaincenter img').prop('src', '/xs?' + imgurl[0].attUrl)
                    for (var i = 0; i < datas.length; i++) {
                        if (i < 2) {
                            str += ' <div class="textmain">\
                                    <p class="title">\
                                    <a href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><strong>' + datas[i].subject + '</strong></a>\
                                    <a class="fr" href="javascript:void(0)">' + datas[i].newsDateTime.split(/\s/)[0] + '</a>\
                                </p>\
                                <p class="pmain">\
                                ' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '\
                                </p>\
                                </div>'
                        }
                    }
                    $('.topmaincenter').append(str);
                } else {
                    for (var i = 0; i < datas.length; i++) {

                        str += ' <div class="textmain">\
                                    <p class="title">\
                                    <a href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><strong>' + datas[i].subject + '</strong></a>\
                                    <a class="fr" href="javascript:void(0)">' + datas[i].newsDateTime.split(/\s/)[0] + '</a>\
                                </p>\
                                <p class="pmain">\
                                ' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '\
                                </p>\
                                </div>'

                    }
                    $('.topmaincenter').append(str);
                    $('.topmaincenter img').remove();
                }
            } else {
                for (var i = 0; i < datas.length; i++) {

                    str += ' <div class="textmain">\
                                    <p class="title">\
                                    <a href="/news/detail?newsId=' + datas[i].newsId + '" target="_blank"><strong>' + datas[i].subject + '</strong></a>\
                                    <a class="fr" href="javascript:void(0)">' + datas[i].newsDateTime.split(/\s/)[0] + '</a>\
                                </p>\
                                <p class="pmain">\
                                ' + datas[i].content.replace(/<\/?.+?>/g, "").replace(/ /g, "") + '\
                                </p>\
                                </div>'

                }
                $('.topmaincenter').append(str);
                $('.topmaincenter img').remove();
            }
        }

        if (str == '') {
            $('.topmaincenter img').remove();
            str = '<div class="no_notice" style="text-align: center;border: none;    margin-top: 97px;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;    font-size: 14px;">' + no_Data + '</h2>' +
                '</div>';
            $('.topmaincenter').append(str);

        }

        // }
    }, 'json')


    $('.navigations span').click(function () {
        $(this).siblings('span').removeClass('active');
        $(this).addClass('active')
        $(this).parent().parent().siblings('ul').hide()
        $(this).parent().parent().siblings('[data-t="' + $(this).attr('data-type') + '"]').show();
    })


})