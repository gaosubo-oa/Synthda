var userId = $.cookie('userId');
var userName = $.cookie('userName');
if (userName == null || userId == null) {
    $.post('/user/getNowLoginUser', {}, function (json) {
        var obj = json.object;
        if (json.flag) {
            userName = obj.userName;
            userId = obj.userId
        }
    })
}
var zero = '0';
var timer;
var flowID = '';
var myDate = new Date();
//获取当前年
var year = myDate.getFullYear();
//获取当前月
var month = myDate.getMonth() + 1;
if (month >= 10) {
    timer = year + '-' + month;
} else {
    month = zero + month;
    timer = year + '-' + month;
}
$(function () {
    $("#years").val(year);
    $('#month').val(month);
    $("#years1").val(year);
    $('#month1').val(month);
    var arr = [];
$('#datatime').html(moment().format('YYYY-MM-DD dddd'))
    $.ajax({
        type: 'post',
        url: '/attend/selectStartAndEndTime',
        dataType: 'json',
        success: function (res) {
            if(res.flag == true){
                $('#startTime').html('上班时间:'+res.data.startTime)
                $('#endTime').html('下班时间:'+res.data.endTime)
            }
        }
    });
    //打卡
    $("#daka").click(function(){
        $.ajax({
            type:'post',
            url:'/attend/PCaddAttend',
            dataType:'json',
            data:{
                address:'',
                remark:'',
                phoneId:'',
                device:''
            },
            success:function (res) {
                if(res.flag == true){
                    layer.msg(res.msg,{icon: 1,time:2500},function () {
                    window.location.reload()
                    });
                }else{
                    layer.msg(res.msg,{icon: 2,time:1500});
                }
            }
        })
    });
    //考勤日历数据展示
    init(timer);
    // code/GetDropDownBox?CodeNos=KQQJTYPE
    $.ajax({
        type: 'get',
        url: '../code/GetDropDownBox',
        dataType: 'json',
        data: {
            CodeNos: 'KQQJTYPE'
        },
        success: function (res) {
            // if(res.KQQJTYPE){
            //     flowID = res.KQQJTYPE[0].codeNo;
            // }
            var data = res.KQQJTYPE;
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    if (data[i].codeName == '请假申请') {
                        $('#DATA').attr('flowId', data[i].codeNo);
                    } else if (data[i].codeName == '出差申请') {
                        $('#administration').attr('flowId', data[i].codeNo);
                    } else if (data[i].codeName == '外出申请') {
                        $('#statistics').attr('flowId', data[i].codeNo);
                    } else if (data[i].codeName == '加班申请') {
                        $('#jiaban').attr('flowId', data[i].codeNo);
                    }
                }
            }
        }
    });


    //点击右侧箭头
    $('#rightArrow').click(function () {
        var month = $('#month option:checked').val();
        var year = $('#years option:checked').val();
        var num = Number(month) + 1;
        var iNow;
        var iNowY
        if (num >= 10) {
            if(num==13){
                iNow = zero + 1;
            } else {
                iNow = num;
            }
            $("#month").val(iNow);
        } else {
            iNow = zero + num;
            $("#month").val(iNow);
        }
        if (num > 12) {
            iNowY = Number(year) + 1
            $("#month").val('01');
            $("#years").val(iNowY);
        } else {
            iNowY = year;
        }
        // alert(iNowY+'-'+iNow);
        $('.mainList').fullCalendar('removeEventSource', arr);
        $('.mainList').fullCalendar('gotoDate', iNowY + '-' + iNow);
        $.ajax({
            type: 'get',
            url: '../attend/personalAttendance',
            dataType: 'json',
            data: {'date': iNowY + '-' + iNow},
            success: function (res) {
                var datas = res.data;
                var aList = datas.list;
                var arrsarr = [];
                for (var i = 0; i < aList.length; i++) {
                    if (aList[i].attendList[0].attendSetType == 0 || aList[i].attendList[0].attendSetType == 3) {
                        for (var j = 0; j < aList[i].attendList.length; j++) {
                            var Object1 = {
                                id: aList[i].attendList[j].num,
                                title: aList[i].attendList[j].atimestate,
                                title1: aList[i].attendList[j].time,
                                start: aList[i].attendList[j].dateName,
                            }
                            arrsarr.push(Object1);
                        }
                    } else if (aList[i].attendList[0].attendSetType == 1) {
                        var actualWorkHours;
                        var atimestates;
                        var time;
                        for (var j = 0; j < aList[i].attendList.length; j++) {
                            if(aList[i].attendList[0].num<=1) {
                                actualWorkHours='';
                                atimestates='';
                                time='';
                            }else{
                                actualWorkHours=aList[i].attendList[1].actualWorkHours;
                                atimestates=aList[i].attendList[1].atimestate;
                                time=aList[i].attendList[1].time;
                            }
                            var Object2 = {
                                id: aList[i].attendList[j].num,
                                title: aList[i].attendList[0].atimestate,
                                time1: actualWorkHours+'@'+aList[i].attendList[0].atimestate + '@' + aList[i].attendList[0].time,
                                time2: actualWorkHours+'@'+atimestates+'@'+time,
                                start:aList[i].attendList[0].dateName
                            }
                        }

                        arrsarr.push(Object2);
                    }
                }
                $('.mainList').fullCalendar('addEventSource', arrsarr);
                // $('.mainList').fullCalendar( 'addEventSource', arrsarr);
                // $('.mainList').fullCalendar( 'refetchEvents' );
                // $('.mainList').fullCalendar({
                //     //设置头部信息，如果不想显示，可以设置header为false
                //     header: false,
                //     weekends: true,
                //     events: arr,
                //     color:false,
                //     eventRender:function (calEvent, element, view) {
                //         if(calEvent.title == '未签到' || calEvent.title == '上班迟到' || calEvent.title == '下班迟到'){
                //             element[0].innerHTML='<div class="fc-event-inner" style="background-color: #f9f0ee;color: #ec827d;border-color:#f9f0ee !important;height: 26px;line-height: 26px;"><img style="height: 26px;" src="/img/attend/img_redline_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_late_03.png" alt=""><span>'+calEvent.title1+'&nbsp;'+calEvent.title+'</span></div>'
                //         }
                //         if(calEvent.title == '上班正常' || calEvent.title == '下班正常'){
                //             element[0].innerHTML='<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 26px;line-height: 26px;"><img style="height: 26px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>'+calEvent.title1+'&nbsp;'+calEvent.title+'</span></div>'
                //         }
                //     }
                //
                // });

            }
        })

        // $('.mainList').fullCalendar('prev')
    })
    $('#leftArrow').click(function () {
        var month = $('#month option:checked').val();
        var year = $('#years option:checked').val();
        var num = Number(month) - 1;
        var iNow;
        var iNowY;
        if (num >= 10) {
            iNow = num;
            $("#month").val(iNow);
        } else {
            if(num==0){
                iNow = 12;
            } else {
                iNow = zero + num;
            }
            $("#month").val(iNow);
        }
        if (num < 1) {
            iNowY = Number(year) - 1;
            $("#month").val('12');
            $("#years").val(iNowY);
        } else {
            iNowY = year;
        }
        $('.mainList').fullCalendar('removeEventSource', arr);
        $('.mainList').fullCalendar('gotoDate', iNowY + '-' + iNow);
        $.ajax({
            type: 'get',
            url: '../attend/personalAttendance',
            dataType: 'json',
            data: {'date': iNowY + '-' + iNow},
            success: function (res) {
                var datas = res.data;
                var aList = datas.list;
                var arrsarr = [];
                for (var i = 0; i < aList.length; i++) {
                    if (aList[i].attendList[0].attendSetType == 0 || aList[i].attendList[0].attendSetType == 3) {
                        for (var j = 0; j < aList[i].attendList.length; j++) {
                            var Object1 = {
                                id: aList[i].attendList[j].num,
                                title: aList[i].attendList[j].atimestate,
                                title1: aList[i].attendList[j].time,
                                start: aList[i].attendList[j].dateName
                            };
                            arrsarr.push(Object1);
                        }
                    } else if (aList[i].attendList[0].attendSetType == 1) {
                        var actualWorkHours;
                        var atimestates;
                        var time;
                        for (var j = 0; j < aList[i].attendList.length; j++) {
                            if(aList[i].attendList[0].num<=1) {
                                actualWorkHours='';
                                atimestates='';
                                time='';
                            }else{
                                actualWorkHours=aList[i].attendList[1].actualWorkHours;
                                atimestates=aList[i].attendList[1].atimestate;
                                time=aList[i].attendList[1].time;
                            }
                            var Object2 = {
                                id: aList[i].attendList[j].num,
                                title: aList[i].attendList[0].atimestate,
                                time1: actualWorkHours+'@'+aList[i].attendList[0].atimestate + '@' + aList[i].attendList[0].time,
                                time2: actualWorkHours+'@'+atimestates+'@'+time,
                                start:aList[i].attendList[0].dateName
                            }
                        }
                        arrsarr.push(Object2);
                    }
                }
                $('.mainList').fullCalendar('addEventSource', arrsarr);
            }
        })
    })

    //列表模式下点击左右箭头
    $('#rightArrow1').click(function () {
        var month = $('#month1 option:checked').val();
        var year = $('#years1 option:checked').val();
        var num = Number(month) + 1;
        var iNow;
        var iNowY
        if (num >= 10) {
            iNow = num;
            $("#month1").val(iNow);
        } else {
            iNow = zero + num;
            $("#month1").val(iNow);
        }
        if (iNow > 12) {
            iNowY = Number(year) + 1
            $("#month1").val('01');
            $("#years1").val(iNowY);
        } else {
            iNowY = year;
        }
        timer = iNowY + "-" + iNow
        dataList();
        // $('.mainList').fullCalendar('prev')
    })
    $('#leftArrow1').click(function () {
        var month = $('#month1 option:checked').val();
        var year = $('#years1 option:checked').val();
        var num = Number(month) - 1;
        var iNow;
        var iNowY;
        if (num >= 10) {
            iNow = num;
            $("#month1").val(iNow);
        } else {
            iNow = zero + num;
            $("#month1").val(iNow);
        }
        if (iNow < 01) {
            iNowY = Number(year) - 1;
            $("#month1").val('12');
            $("#years1").val(iNowY);
        } else {
            iNowY = year;
        }
        timer = iNowY + "-" + iNow
        dataList();
    })
    //点击列表
    $('#dataList').click(function () {
        $('.attendList').show().siblings().hide();
        dataList()
    })
    //点击日历
    $('#dataWeek').click(function () {
        $('.attendTime').show().siblings().hide();
    })
    //上下班考勤点击
    $('#survey').click(function () {
        $(this).find('.headli').addClass('one');
        $(this).siblings().find('.headli').removeClass('one');
        $('.commuting').show().siblings().hide();
    })
    //请假点击
    $('#DATA').click(function () {
        $(this).find('.headli').addClass('one');
        $(this).siblings().find('.headli').removeClass('one');
        $('.leave').show().siblings().hide();
        $('input[name="kaoqingType"]').val('0')
        ajaxPageLe.page();
    })
    //外出点击
    $('#statistics').click(function () {
        $(this).find('.headli').addClass('one');
        $(this).siblings().find('.headli').removeClass('one');
        $('.goOut').show().siblings().hide();
        $('input[name="kaoqingType"]').val('1')
        ajaxPage.page();
    })
    // 出差点击
    $('#administration').click(function () {
        $(this).find('.headli').addClass('one');
        $(this).siblings().find('.headli').removeClass('one');
        $('.busTravel').show().siblings().hide();
        $('input[name="kaoqingType"]').val('2')
        ajaxPageTr.page();
    })
    // 加班点击
    $('#jiaban').click(function () {
        $(this).find('.headli').addClass('one');
        $(this).siblings().find('.headli').removeClass('one');
        $('.jiabans').show().siblings().hide();
        $('input[name="kaoqingType"]').val('3')
        ajaxPageJiaban.page();
    })

    function init(date) {
        layer.load();
        $.ajax({
            type: 'get',
            url: '../attend/personalAttendance',
            dataType: 'json',
            data: {'date': date},
            success: function (res) {
                if (res.data != undefined){
                    var datas = res.data;
                    var aList = datas.list;
                    var Object = '';
                    if (datas.switchList.length > 0) {
                        if (datas.switchList[(datas.switchList.length - 1)].isLeave == '1') { //请假开关
                            $('#DATA').show();
                        } else {
                            $('#DATA').hide();
                        }
                        if (datas.switchList[(datas.switchList.length - 1)].isGo == '1') { //外出开关
                            $('#statistics').show();
                        } else {
                            $('#statistics').hide();
                        }
                        if (datas.switchList[(datas.switchList.length - 1)].isTrip == '1') { //出差开关
                            $('#administration').show();
                        } else {
                            $('#administration').hide();
                        }
                        // if(datas.switchList[(datas.switchList.length-1)].isLeave == '1'){ //出差开关
                        //     $('#jiaban').show();
                        // }else{
                        //     $('#jiaban').hide();
                        // }
                    }


                    for (var i = 0; i < aList.length; i++) {
                        if (aList[i].attendList[0].attendSetType == 0 || aList[i].attendList[0].attendSetType == 3) {
                            for (var j = 0; j < aList[i].attendList.length; j++) {
                                var Object1 = {
                                    id: aList[i].attendList[j].num,
                                    title: aList[i].attendList[j].atimestate,
                                    title1: aList[i].attendList[j].time,
                                    start: aList[i].attendList[j].dateName,
                                }
                                arr.push(Object1);
                            }
                        } else if (aList[i].attendList[0].attendSetType == 1) {

                            var actualWorkHours;
                            var atimestate;
                            var time;
                            for (var j = 0; j < aList[i].attendList.length; j++) {
                                if(aList[i].attendList[0].num<=1) {
                                    actualWorkHours='';
                                    atimestates='';
                                    time='';
                                }else{
                                    actualWorkHours=aList[i].attendList[1].actualWorkHours;
                                    atimestates=aList[i].attendList[1].atimestate;
                                    time=aList[i].attendList[1].time;
                                }
                                var Object2 = {
                                    id: aList[i].attendList[j].num,
                                    title: aList[i].attendList[0].atimestate,
                                    time1: actualWorkHours+'@'+aList[i].attendList[0].atimestate + '@' + aList[i].attendList[0].time,
                                    time2: actualWorkHours+'@'+atimestates+'@'+time,
                                    start:aList[i].attendList[0].dateName
                                }
                            }
                            arr.push(Object2);

                        }
                    }
                    layer.closeAll();
                }else {
                    layer.closeAll();
                }
                $('.mainList').fullCalendar({
                    //设置头部信息，如果不想显示，可以设置header为false
                    header: false,
                    // header: {
                    //     left: 'prev,next,today',
                    //     center: 'title',
                    //     right: 'month,agendaWeek,agendaDay'
                    // },
                    //设置是否显示周六和周日，设为false则不显示
                    weekends: true,
                    events: arr,
                    color: false,
                    eventRender: function (calEvent, element, view) {
                        if (calEvent.title == '未签到' || calEvent.title == '上班迟到' || calEvent.title == '还未签到' || calEvent.title == '下班迟到' || calEvent.title == '下班早退') {
                            element[0].innerHTML = '<div class="fc-event-inner" style="background-color: #f9f0ee;color: #ec827d;border-color:#f9f0ee !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width: 4px;" src="/img/attend/img_redline_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_late_03.png" alt=""><span>' + calEvent.title1 + '&nbsp;' + calEvent.title + '</span></div>'
                        }
                        if (calEvent.title == '上班正常' || calEvent.title == '下班正常') {
                            element[0].innerHTML = '<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width:4px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>' + calEvent.title1 + '&nbsp;' + calEvent.title + '</span></div>'
                        }
                        if (calEvent.title == '节假日') {
                            element[0].innerHTML = '<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 140px;line-height: 30px;margin-top: 5px;"><img style="height: 140px;width:4px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>' + calEvent.title1 + '&nbsp;' + calEvent.title + '</span></div>'
                        }

                        if (calEvent.title == '第一次签到'||calEvent.title == '还未签到') {

                            if (calEvent.time2=="@@") {
                                var str1 = calEvent.time1.split("@");
                                element[0].innerHTML = '<div class="fc-event-inner" style="background-color: #f9f0ee;color: #ec827d;border-color:#f9f0ee !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width:4px;" src="/img/attend/img_redline_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_late_03.png" alt=""><span>' + str1[2] + '&nbsp;' + str1[1] + '</span></div>'
                            } else {
                                var str1 = calEvent.time1.split("@");
                                var str2 = calEvent.time2.split("@");
                                element[0].innerHTML = '<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width:4px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>' + str1[2] + '&nbsp;' + str1[1] + '</span></div>' +
                                    '<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width:4px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>工作时长 &nbsp;' + str1[0] + '</span></div>' +
                                    '<div class="fc-event-inner" style="background-color: #eef9f2;color: #58cb7d;border-color:#eef9f2 !important;height: 30px;line-height: 30px;margin-top: 5px;"><img style="height: 30px;width:4px;" src="/img/attend/img_line_03.png" alt=""><img style="width: 18px;height: 18px;" src="/img/attend/icon_normal_03.png" alt=""><span>' + str2[2] + '&nbsp;' + str2[1] + '</span></div>'

                            }

                        }

                    }
                });
            }
        })
    }

    //上下班考勤列表
    function dataList() {
        $('.surverData').siblings().remove();
        layer.load();
        $.ajax({
            type: 'get',
            url: '../attend/personalAttendance',
            dataType: 'json',
            data: {'date': timer},
            success: function (res) {
                var datas = res.data;
                var aList = datas.list;
                var str = '';
                for (var i = 0; i < aList.length; i++) {
                    for (var j = 0; j < aList[i].attendList.length; j++) {
                        str += '<tr>' +
                            '<td>' + aList[i].attendList[j].dateName + '</td>' +
                            '<td>' + aList[i].attendList[j].atimestate + '</td>' +
                            '<td>' + aList[i].attendList[j].time + '</td>' +
                            '<td>' + aList[i].attendList[j].address + '</td>' +
                            '<td>' + aList[i].attendList[j].remark + '</td></tr>';
                    }
                }
                $('.surverData').after(str);
                layer.closeAll();
            }
        })
    }


    //删除
    $('.table').on('click', '.deleteBtn', function () {
        var dataId = $(this).attr('data-id');
        var KQtype = $('input[name="kaoqingType"]').val();
        deleteData(dataId, KQtype)
    })


    //新建请假
    $('#newLeave').click(function () {
        var flowId = $('#DATA').attr('flowId');
        layer.open({
            type: 1,
            title: [attend_th_NewLeave, 'background-color:#2b7fe0;color:#fff;'],
            area: ['520px', '280px'],
            shadeClose: true, //点击遮罩关闭
            btn: [attend_th_Establish, cancel],
            content: '<div class="newsAdd" style="padding-left: 5px;">' +
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
            '<tr class="applicant"><td style="width: 95px;padding-left: 59px;">' + sup_th_Applicant + '：</td><td><input type="text" class="inp" name="userName" style="width: 180px;" value="  ' + userName + '" id="leaveUser" readonly="readonly" userId="' + userId + '" ></td></tr>' +
            '<tr><td style="width: 95px;padding-left: 59px;">' + hr_th_RegistrationTime + '：</td><td><input type="text" class="inp"  style="width: 180px;" name="begainTime" id="leaveTime" class="inputTd" readonly="readonly" value="  ' + getNowFormatDate() + '" /></td></tr>' +
            '</table></div>',
            yes: function (index) {
                $.ajax({
                    type: 'get',
                    url: '../attendLeave/addAttendLeave',
                    dataType: 'json',
                    async: false,
                    data: {
                        userId: $('#leaveUser').attr('userId'),
                        recordTime: $('#leaveTime').val()

                    },
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            //$.popWindow('../workflow/work/workform?flowId='+flowId+'&flowStep=1&prcsId=1&runId='+res.data.runId+'&tableName='+res.data.tableName+'&tabId='+res.data.leaveId+'&isNomalType=true','快速新建页面','0','0','1500px','800px');
                            $.popWindow("../workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.data.runId, '快速新建页面', '0', '0', '1150px', '700px');
                            //新建页面
                            //quick(flowId);
                        }
                    }
                });
                layer.close(index);

            },
        });
    })
    function newWorkFlow(flowId, cb) {
        $.ajax({
            url: '../../workflow/work/workfastAdd',
            type: 'get',
            dataType: 'json',
            data: {
                flowId: flowId,
                prcsId: 1,
                flowStep: 1,
                runId: '',
                preView: 0
            },
            async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
            success: function (res) {
                if (res.flag == true) {
                    var data = res.object;
                    cb(data);
                }
            }
        });
    }

    function quick(flowId) {
        $.ajax({
            url: '/userCountPer',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                if (res.flag) {
                    user_id = 'quick';
                    newWorkFlow(flowId, function (data) {
                        $.popWindow("../workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + data.flowRun.runId, '快速新建页面', '0', '0', '1150px', '700px');
                    })
                } else {
                    $.layerMsg({content: '人数达到上限，不能新建', icon: 6})
                }
            }
        })

    };
    //新建外出
    $('#goOutData').click(function () {
        var flowId = $('#statistics').attr('flowId');
        layer.open({
            type: 1,
            title: [attend_th_NewGoOut, 'background-color:#2b7fe0;color:#fff;'],
            area: ['520px', '280px'],
            shadeClose: true, //点击遮罩关闭
            btn: [sure, cancel],
            content: '<div class="newsAdd" style="padding-left: 5px;">' +
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
            '<tr class="applicant" userId="' + userId + '"><td>' + sup_th_Applicant + '：</td><td><input type="text" name="userName" style="width: 180px;" value=" ' + userName + '" ></td></tr>' +
            '<tr><td>' + hr_th_RegistrationTime + '：</td><td><input type="text" style="width: 180px;" name="begainTime" id="start" class="inputTd" value="  ' + getNowFormatDate() + '" /></td></tr>' +
            '</table></div>',
            yes: function (index) {
                // flowID=143;
                $.ajax({
                    type: 'get',
                    url: '../attendOut/addAttendOut',
                    dataType: 'json',
                    async: false,
                    data: {
                        userId: $('#leaveUser').attr('userId'),
                        createDate: $('#start').val(),

                    },
                    success: function (res) {
                        if (res.flag) {
                            $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.outId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                        }
                    }
                });
                layer.close(index);

            },
        });
    })
    //新建出差
    $('#busTravelData').click(function () {
        var flowId = $('#administration').attr('flowId');
        layer.open({
            type: 1,
            title: [attend_th_NewTravel, 'background-color:#2b7fe0;color:#fff;'],
            area: ['520px', '280px'],
            shadeClose: true, //点击遮罩关闭
            btn: [sure, cancel],
            content: '<div class="newsAdd" style="padding-left: 5px;">' +
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
            '<tr class="applicant" userId="' + userId + '"><td>' + sup_th_Applicant + '：</td><td><input type="text" name="userName" style="width: 180px;" value="  ' + userName + '" ></td></tr>' +
            '<tr><td>' + hr_th_RegistrationTime + '：</td><td><input type="text" style="width: 180px;" name="begainTime" id="start" class="inputTd" value=" ' + getNowFormatDate() + '" /></td></tr>' +
            '</table></div>',
            yes: function (index) {
                // flowID=142;
                $.ajax({
                    type: 'get',
                    url: '../attendEvection/addAttendEvection',
                    dataType: 'json',
                    async: false,
                    data: {
                        userId: $('#leaveUser').attr('userId'),
                        createDate: $('#start').val(),

                    },
                    success: function (res) {
                        if (res.flag) {
                            $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                        }
                    }
                });
                layer.close(index);

            },
        });
    })

    //新建加班
    $('#jiabanDate').click(function () {
        var flowId = $('#jiaban').attr('flowId');
        layer.open({
            type: 1,
            title: ['新建加班', 'background-color:#2b7fe0;color:#fff;'],
            area: ['520px', '280px'],
            shadeClose: true, //点击遮罩关闭
            btn: [sure, cancel],
            content: '<div class="newsAdd" style="padding-left: 5px;">' +
            '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
            '<tr id="jiabanUser" class="applicant" userId="' + userId + '"><td>' + sup_th_Applicant + '：</td><td><input type="text" name="userName" style="width: 180px;" value="  ' + userName + '" ></td></tr>' +
            '<tr><td>' + hr_th_RegistrationTime + '：</td><td><input type="text" style="width: 180px;" name="begainTime" id="start" class="inputTd" value=" ' + getNowFormatDate() + '" /></td></tr>' +
            '</table></div>',
            yes: function (index) {
                // flowID=142;
                $.ajax({
                    type: 'get',
                    url: '../attendanceOvertime/addAttendanceOvertime',
                    dataType: 'json',
                    async: false,
                    data: {
                        userId: $('#jiabanUser').attr('userId'),
                        createDate: $('#start').val(),
                    },
                    success: function (res) {
                        if (res.flag) {
                            $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                        }
                    }
                });
                layer.close(index);

            },
        });
    })

})

function deleteData(dataId, KQtype) {
    layer.confirm('确定要删除该条数据吗？', {
        btn: ['确定', '取消'], //按钮
        title: "删除"
    }, function () {
        //确定删除，调接口
        $.ajax({
            type: 'get',
            url: '/workflow/work/deleteRunPrcs',
            dataType: 'json',
            data: {
                id: dataId
            },
            success: function (res) {
                if (res.code == '100066'){
                    layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                } else if (res.flag == true) {
                    layer.msg('删除成功！', {icon: 6});
                    if (KQtype == '0') {
                        ajaxPageLe.page();
                    } else if (KQtype == '1') {
                        ajaxPage.page();
                    } else if (KQtype == '2') {
                        ajaxPageTr.page();
                    } else {
                        ajaxPageJiaban.page();
                    }
                } else {
                    layer.msg('删除失败！', {icon: 6});
                }
            }
        });

    }, function () {
        layer.closeAll();
    });
}


//外出列表带分页
var ajaxPage = {
    data: {
        page: 1,//当前处于第几页
        pageSize: 10,//一页显示几条
        useFlag: true,
        // computationNumber:null
    },
    page: function () {
        $('.goOutData').siblings().remove();
        var me = this;
        $.ajax({
            type: 'get',
            url: '../attendOut/queryAllAttendOut',
            dataType: 'json',
            data: me.data,
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<tr>' +
                        '<td>' + data[i].outId + '</td>' +
                        '<td>' + data[i].userName + '</td>' +
                        '<td>' + data[i].deptName + '</td>' +
                        '<td>' + data[i].outTime1 + '</td>' +
                        '<td>' + data[i].outTime2 + '</td>' +
                        '<td>' + data[i].outTime + '</td>' +
                        '<td>' + data[i].outType + '</td>' +
                        '<td>' + data[i].leaderId + '</td>' +
                        '<td>' + data[i].allow + '</td>' +
                        '<td>' + function () {
                            if (data[i].step != 1) {
                                return '<a href="/workflow/work/workformPreView?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&runId=' + data[i].runId + '&prcsId=' + data[i].realPrcsId + '" target="_blank">' + roleAuthorization_th_ViewDetails + '</a>'
                            } else {
                                return '<a href="/workflow/work/workform?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&prcsId=' + data[i].prcsId + '&runId=' + data[i].runId + '&tableName=attend_out&tabId=' + data[i].leaveId + '&isNomalType=true" style="margin-right: 10px;" target="_blank">办理</a><a href="javascript:;" data-id="' + data[i].id + '" class="deleteBtn">删除</a>';
                            }
                        }() + '</td>' +
                        '</tr>';
                }
                $('.goOutData').after(str);
                me.pageTwo(res.totleNum, me.data.pageSize, me.data.page)
            }
        })

    },
    pageTwo: function (totalData, pageSize, indexs) {
        var mes = this;
        $('#outUser').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            homePage: '',
            endPage: '',
            current: indexs || 1,
            callback: function (index) {
                mes.data.page = index.getCurrent();
                mes.page();
            }
        });
    }
}

//出差列表带分页
var ajaxPageTr = {
    data: {
        page: 1,//当前处于第几页
        pageSize: 10,//一页显示几条
        useFlag: true,
        // computationNumber:null
    },
    page: function () {
        $('.busTravelData').siblings().remove();
        var me = this;
        $.ajax({
            type: 'get',
            url: '../attendEvection/queryAllAttendEvection',
            dataType: 'json',
            data: me.data,
            success: function (res) {
                var data = res.obj;
                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<tr>' +
                        '<td>' + data[i].evectionId + '</td>' +
                        '<td>' + data[i].userName + '</td>' +
                        '<td>' + data[i].deptName + '</td>' +
                        '<td>' + data[i].beginDate + '</td>' +
                        '<td>' + data[i].endDate + '</td>' +
                        '<td>' + data[i].evectionTime + '</td>' +
                        '<td>' + data[i].reason + '</td>' +
                        '<td>' + data[i].leaderId + '</td>' +
                        '<td>' + data[i].allow + '</td>' +
                        '<td>' + function () {
                            if (data[i].step != 1) {
                                return '<a href="/workflow/work/workformPreView?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&runId=' + data[i].runId + '&prcsId=' + data[i].realPrcsId + '" target="_blank">' + roleAuthorization_th_ViewDetails + '</a>'
                            } else {
                                return '<a href="/workflow/work/workform?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&prcsId=' + data[i].prcsId + '&runId=' + data[i].runId + '&tableName=attend_evection&tabId=' + data[i].leaveId + '&isNomalType=true" style="margin-right: 10px;" target="_blank">办理</a><a href="javascript:;" data-id="' + data[i].id + '" class="deleteBtn">删除</a>';
                            }
                        }() + '</td>' +
                        '</tr>';
                }
                $('.busTravelData').after(str);
                me.pageTwo(res.totleNum, me.data.pageSize, me.data.page)
            }
        })

    },
    pageTwo: function (totalData, pageSize, indexs) {
        var mes = this;
        $('#outTravel').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            homePage: '',
            endPage: '',
            current: indexs || 1,
            callback: function (index) {
                mes.data.page = index.getCurrent();
                mes.page();
            }
        });
    }
}
function check(name) {
    if (name == undefined) {
        return ""
    } else {
        return name;
    }
}


//加班列表带分页
var ajaxPageJiaban = {
    data: {
        page: 1,//当前处于第几页
        pageSize: 10,//一页显示几条
        useFlag: true,
        // computationNumber:null
    },
    page: function () {
        $('.jiabanDate').siblings().remove();
        var me = this;
        $.ajax({
            type: 'get',
            url: '../attendanceOvertime/queryAllAttendOut',
            dataType: 'json',
            data: me.data,
            success: function (res) {
                var data = res.obj;

                var str = '';
                for (var i = 0; i < data.length; i++) {
                    str += '<tr>' +
                        '<td>' + data[i].userName + '</td>' +
                        '<td>' + data[i].deptName + '</td>' +
                        '<td>' + check(data[i].startTime) + '</td>' +
                        '<td>' + check(data[i].endTime) + '</td>' +
                        '<td>' + data[i].reason + '</td>' +
                        '<td>' + data[i].approveId + '</td>' +
                        '<td>' + data[i].allow + '</td>' +
                        '<td>' + function () {
                            if (data[i].step != 1) {
                                return '<a href="/workflow/work/workformPreView?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&runId=' + data[i].runId + '&prcsId=' + data[i].realPrcsId + '" target="_blank">' + roleAuthorization_th_ViewDetails + '</a>'
                            } else {
                                return '<a href="/workflow/work/workform?flowId=' + data[i].flowId + '&flowStep=' + data[i].step + '&prcsId=' + data[i].prcsId + '&runId=' + data[i].runId + '&tableName=attend_evection&tabId=' + data[i].leaveId + '&isNomalType=true" style="margin-right: 10px;" target="_blank">办理</a><a href="javascript:;" data-id="' + data[i].id + '" class="deleteBtn">删除</a>';
                            }
                        }() + '</td>' +
                        '</tr>';
                }

                $('.jiabanList').html(str);
                me.pageTwo(res.totleNum, me.data.pageSize, me.data.page)
            }
        })

    },
    pageTwo: function (totalData, pageSize, indexs) {
        var mes = this;
        $('#jiabanPage').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            homePage: '',
            endPage: '',
            current: indexs || 1,
            callback: function (index) {
                mes.data.page = index.getCurrent();
                mes.page();
            }
        });
    }
}


function getNowFormatDate() {

    return new Date().Format('yyyy-MM-dd hh:mm:ss');
}

//新建保存方法
function newAddBtnData(url, data) {
    $.ajax({
        type: 'post',
        url: url,
        dataType: 'json',
        data: data,
        success: function (res) {
            $.layerMsg({content: save, icon: 1}, function () {

            });
        }
    })
}

//table模式日期被选中
function changeDate() {
    //console.log($("#years").val()+"-"+$("#month").val())
    $('.mainList').fullCalendar('removeEventSource');
    $('.mainList').fullCalendar('gotoDate', $("#years").val() + "-" + $("#month").val());
    $.ajax({
        type: 'get',
        url: '../attend/personalAttendance',
        dataType: 'json',
        data: {'date': $("#years").val() + "-" + $("#month").val()},
        success: function (res) {
            var datas = res.data;
            var aList = datas.list;
            var arrsarr = [];
            for (var i = 0; i < aList.length; i++) {

                for (var j = 0; j < aList[i].attendList.length; j++) {
                    var Object = {
                        id: aList[i].attendList[j].num,
                        title: aList[i].attendList[j].atimestate,
                        title1: aList[i].attendList[j].time,
                        start: aList[i].attendList[j].dateName,
                    }
                    arrsarr.push(Object);
                }
            }
            $('.mainList').fullCalendar('addEventSource', arrsarr);

        }
    })

}


//列表模式日期被选中

function changeDate1() {

    timer = $("#years1").val() + "-" + $("#month1").val()
    dataList();
}


//上下班考勤列表
function dataList() {
    $('.surverData').siblings().remove();
    layer.load();
    $.ajax({
        type: 'get',
        url: '../attend/personalAttendance',
        dataType: 'json',
        data: {'date': timer},
        success: function (res) {
            var datas = res.data;
            var aList = datas.list;
            var str = '';
            for (var i = 0; i < aList.length; i++) {
                for (var j = 0; j < aList[i].attendList.length; j++) {
                    str += '<tr>' +
                        '<td>' + aList[i].attendList[j].dateName + '</td>' +
                        '<td>' + aList[i].attendList[j].atimestate + '</td>' +
                        '<td>' + aList[i].attendList[j].time + '</td>' +
                        '<td>' + aList[i].attendList[j].address + '</td>' +
                        '<td>' + aList[i].attendList[j].remark + '</td></tr>';

                }
            }
            $('.surverData').after(str);
            layer.closeAll();
        }
    })
}


