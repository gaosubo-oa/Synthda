/*document.write(" <script language=\"javascript\" src="\/com\/js/base/base.js \" > <\/script>"); */
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

document.write("<script language=javascript src='/js/base/base.js?20191025.1'></script>");
document.write("<script language=javascript src='/js/jquery/jquery.cookie.js'></script>");
//控制事务提醒音乐
var music
$.ajax({
    type: "post",
    url: "/users/getUserTheme",
    dataType: 'json',
    data: "",
    async:false,
    success: function (obj) {
        if(obj.object.callSound=='1'||obj.object.callSound==''){
            music = 1
        }else{
            music = 0
        }
    }
});

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
var mobileObj={//标签左右移动动画
    mobileWidth:null,
    mobileLiWidth:null,
    liNum:null,//能放几个
    liAllnum:null,//能移动多少个
    counters:0,//计数器
    ULLeft:0,//定位
    timer:null,
    timers:null,
    status:true,
    statusTwo:true,
    init:function () {
        this.mobileWidth=$('.main_title').width()
        this.mobileLiWidth=$('.main_title ul li').width();
        this.liNum=parseInt(this.mobileWidth/this.mobileLiWidth);
        var me=this;
        $('#leftSpan').click(function () {
            if(me.status){
                me.right()
            }

        })
        $('#rightSpan').click(function () {
            if(me.statusTwo){
                me.left()
            }

        })
    },
    left:function (fn) {
        if($('.main_title ul li').length<=this.liNum){
            return
        }
        this.liAllnum=$('.main_title ul li').length-this.liNum;
        if(this.counters==(this.liAllnum-1)){
            $('#rightSpan').hide()
        }
        if(this.counters==this.liAllnum){
            return
        }


        if($('.main_title ul li').length>this.liNum){
            $('#leftSpan').show()
        }
        this.statusTwo=false;

        this.timer = setTimeout(this.movestep.bind(this,fn), 100)
    },
    movestep:function (fn) {
        var me=this;
        me.timers = setInterval(function () {
            if (parseInt(String(me.ULLeft).replace(/-/,'')) < me.mobileLiWidth) {
                me.ULLeft--;
                var num=parseInt($('.main_title ul').css('left'));
                $('.main_title ul').css('left',--num);
            } else {
                clearInterval(me.timers);
                me.timers = null;
                me.ULLeft=0;
                me.counters++;
                me.statusTwo =true;
                if(fn!=undefined){
                    fn()
                }
            }
        }, 1)
    } ,
    right:function (fn) {
        if($('.main_title ul li').length<=this.liNum){
            $('#leftSpan').hide()
            $('#rightSpan').hide()
            fn()
            return
        }



        this.liAllnum=$('.main_title ul li').length-this.liNum;
        if(this.counters==1){
            $('#leftSpan').hide()
        }
        if(this.counters==0){
            return
        }
        if($('.main_title ul li').length>this.liNum){
            $('#rightSpan').show()
        }
        this.status=false;

        this.timer = setTimeout(this.movestepRight.bind(this, fn), 100)


    },
    movestepRight:function (fn) {
        var me=this;
        me.timers = setInterval(function () {
            if (me.ULLeft < me.mobileLiWidth) {
                me.ULLeft++;
                var num=parseInt($('.main_title ul').css('left'));
                $('.main_title ul').css('left',++num);
            } else {
                clearInterval(me.timers);
                me.timers = null;
                me.ULLeft=0;
                me.counters--;
                me.status=true;
                if(fn!=undefined){
                    fn();
                }
            }
        }, 1)
    }
}
var todoListNum=0;
var dataLoad={
    timer:null,
    status:true,
    init:function () {
        var me=this;
        this.timer=setInterval(function () {
            if(me.status){
                me.status=false;
                listTable(function () {
                    me.status=true;
                })
                reloads((function () {
                    me.status=true;
                }));
            }
        },600000)
    }
};
//全局函数
function tiaozhuan(that) {
    $.popWindow($(that).attr('data-url'),'公告详情','20','150','1200px','600px')
}

function ajaxdata() {
    return
}

function clickrenwu(id,el) {
    layer.open({
        type:2,
        title:'',
        shade: 0.3,
        area: ['750px', '450px'],
        content: '/sys/userDetails?uid='+id,
    })
    // window.open('/sys/userDetails?uid='+id)
}
function mOver(me) {
    $(me).attr('class','hover');
}
function mOverout(me) {
    $(me).removeAttr('class','hover');
}

function windowOpenNew(me) {
    /* if($(me).attr('data-s')==1){
     /!* window.open('/email/details?id='+$(me).find('.windowopen').attr('data-id'))*!/
     window.open($(me).attr('data-url'))
     }else */
    if($(me).attr('data-s')==2){
        var objGet=$(me).attr('data-url');
        if (objGet.indexOf('runId') > 0){
            var runId = objGet.split('&runId=')[1].split('&prcsId=')[0];
            // var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
            //针对工作查询传阅时，prcsId为undefined时，对prcsId做特殊处理
            if(objGet.split('&prcsId=')[1]==undefined){
               var  prcsId= '0'
            }else{
               var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
            }
            if($(me).parents('.custom_two').attr('id') == 'documentToDoList'){
                $.get('/ToBeReadController/querySmsIsRead',{runId:runId,prcsId:prcsId},function(data){
                    $.popWindow(objGet);
                },'json')
            }else{
                $.popWindow(objGet);
            }
        } else {
            window.open(objGet)
        }

    }else if($(me).attr('data-s')==3){
        window.open('/notice/detail?notifyId='+$(me).attr('data-qid'))
    }else if($(me).attr('data-s')==4){
        // window.open('/news/detail?newsId='+$(me).attr('data-new'))
        var bodyId = $(me).attr('bodyId')
        $.post('/sms/updateRemind', {bodyIds: bodyId, remindFlag: '0'}, function(res){
            if (res.flag) {
                window.open($(me).attr('dataUrl'))
            }
        })
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
    }else if($(me).attr('data-s')==18){
        window.open(encodeURI($(me).attr('data-url')))
    }else if($(me).attr('data-s')==73){
        var bodyId = $(me).attr('bodyId')
        $.post('/sms/updateRemind', {bodyIds: bodyId, remindFlag: '0'}, function(res){
            if (res.flag) {
                window.open($(me).attr('data-url'))
            }
        })
    } else {
        var smsIds = $(me).attr('smsId')
        $.post('/sms/updateRemind', {smsIds: smsIds, remindFlag: '0'}, function(res){
            if (res.flag) {
                window.open($(me).attr('data-url'))
            }
        })
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
//待办
function listTable(fn) {
    var projectId;
    //定制化需求
    $.get('/syspara/selectProjectId',function (res) {
        projectId=res.object
    });
    $.get('/todoList/smsListByType',function (json) {
        if(json.flag){

            var email=json.data.email;
            var emaileStr='';
            var emailPlus = json.data.emailPlus;
            var emailPlusStr="";
            var notify=json.data.notify;
            var notifyStr='';
            //人员调度
            var dispatcher=json.data.dispatcher;
            var dispatcherStr='';
            //第三方系统
            var thirdSystem=json.data.thirdSystem;
            var thirdSystemStr='';
            var workFlow=json.data.workFlow;
            var workFlowStr='';

            var wagesManager=json.data.wagesManager;
            var wagesManager1=''
            var worksalary=''

            var attendanceManager=json.data.attendanceManager;
            var attendanceManager1=''
            var attendance1=''

            var news=json.data.newsList;
            var newsStr='';
            var documentObj = json.data.documentList;
            var documentStr = '';
            var toupiao=json.data.toupiao;
            var toupiaos='';
            var supervisionsObj=json.data.supervisions;
            var supervisionsStr='';

            var meetingObj=json.data.meeting;
            var meetingStr='';

            var richengObj=json.data.calendars;
            var richengStr='';

            var rizhiObj=json.data.diarys;
            var rizhiStr='';

            var leaderObj=json.data.schedules;
            var leaderStr='';

            var publicObj=json.data.publicFiles;
            var publicStr='';

            var netDiskObj=json.data.netDisk;
            var netDiskStr='';

            var zhibanObj=json.data.zhiBan;
            var zhibanStr='';

            var bangongObj=json.data.bangong;

            var bangongStr='';

            var bbsBoard = json.data.bbsBoard||'';
            var bbsBoardStr = '';

            //培训计划
            var addPlanApproval = json.data.addPlanApproval||'';
            var addPlanStr="";

            //任务管理提醒
            var taskManage = json.data.taskManage || '';
            var taskManageStr = '';

            var carApproval = json.data.cheliang || '';
            var carApprovalStr = '';

            //好视通视频
            var hstMeetingObj=json.data.hstMeeting
            var hstMeetingStr='';

            var assetObj=json.data.asset
            var assetStr='';

            //即会通视频会议
            var jhtmeeting = json.data.jhtmeeting||'';
            var jhtmeetingStr = '';

            //资格证书管理
            var crmcertificate = json.data.crmcertificate||'';
            var crmcertificateStr = '';

            var bbscommentObj = json.data.bbscomment || '';
            var bbscommentStr='';

            var contractremindObj = json.data.contractremind || '';
            var contractremindStr='';

            var institutioncontentObj = json.data.institutioncontent || '';
            var institutioncontentStr='';

            //公安局值班管理
            var dutypoliceusersObj = json.data.dutypoliceusers || '';
            var dutypoliceusersStr='';

            // 中电建网报事物提醒
            var onlineReimbursementSystemObj = json.data.onlineReimbursementSystem || '';
            var onlineReimbursementSystemStr = '';

            // 计划管理事务提醒
            var planManageObj = json.data.planManage || '';
            var planManageStr = '';

            // 考核模块
            var assessments = json.data.assessments||'';
            var assessmentsStr = '';

            // 党建
            var partyMember = json.data.partyMember||'';
            var partyMemberStr = '';
            //证照
            var licenseObj=json.data.hrStaffLicense||'';
            var licenseStr='';
            //EHR待办工作提醒
            var ehrAgencyObj=json.data.ehrAgency||'';
            var ehrAgencyStr='';

            //理论学习
            var integralManager=json.data.integralManager||'';
            var integralManagerStr='';

            //密码设置
            var passwordManager=json.data.passwordManager||'';
            var passwordManagerStr='';

            //员工关怀
            var hrStaffCare=json.data.hrStaffCare||'';
            var hrStaffCareStr='';
            //系统类型
            var sysType=json.data.sysType||'';
            var sysTypeStr='';
            if(email.length==0&&emailPlus.length==0&&notify.length==0&&workFlow.length==0&&news.length==0&&documentObj.length==0&&
                toupiao.length==0&&supervisionsObj.length==0&&meetingObj.length==0&&richengObj.length==0&&rizhiObj.length==0&&
                leaderObj.length==0&&publicObj.length==0&&netDiskObj.length==0&&bangongObj.length==0&&taskManage.length==0&&
                carApproval.length==0&&hstMeetingObj.length==0&&bbscommentObj.length==0 && assetObj.length==0 && contractremindObj.length==0 &&
                institutioncontentObj.length==0&&dutypoliceusersObj.length==0 && onlineReimbursementSystemObj.length == 0 && planManageObj.length==0&&partyMember.length==0&&licenseObj.length==0&&
                ehrAgencyObj.length==0 && integralManager.length == 0 && passwordManager.length == 0 && hrStaffCare.length == 0&&wagesManager.length==0&&attendanceManager.length==0
            ){
                $('.tixing_tab_c .search-cont-cus').hide();
                $('.noReminding').show();
            }else{
                $('.tixing_tab_c .search-cont-cus').show();
                $('.noReminding').hide();
            }

            $('#docunmentSeasethree').html(documentObj.length);
            if(documentObj.length==0){
                $('#documentToDoObj').hide()
            }else {
                for(var i=0;i<documentObj.length;i++){
                    documentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="2" data-url="'+documentObj[i].remindUrl+'">' +
                        '<img  style="vertical-align: middle;" src="'+documentObj[i].img+'" alt="">' +
                        '<span  class="windowopen" data-id="'+documentObj[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+documentObj[i].content+'"> '+function(){
                            if(documentObj[i].type=='doctment'){
                                return documentObj[i].content;
                            }else {
                                return documentObj[i].content;
                            }
                        }()+'</span>' +
                        '<span><label style="margin-right: 1em;" title="'+documentObj[i].userName+'">'+documentObj[i].userName+'</label>' +
                        '<label style="color: #999;width: 11em" title="'+documentObj[i].sendTimeStr+'">'+function(){
                            if(documentObj[i].type=='doctment'){
                                return documentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                            }else {
                                return documentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                            }
                        }()+'</label></span>' +
                        '</li>'
                }
                $('#documentToDoList').html(documentStr)
                $('#documentToDoObj').show()
                $('.read_6').attr('dataType',documentObj[0].type);
                if(projectId=='dazu'){
                    $('#documentToDoList .headline').hide()
                }
            }
            //人员调度
            for (var i = 0; i < dispatcher.length; i++) {
                dispatcherStr += '<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="' + dispatcher[i].remindUrl + '">' +
                    '<img style="vertical-align: middle" src="' + dispatcher[i].img + '" alt="">' +
                    '<span  class="windowopen" data-id="'+dispatcher[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+dispatcher[i].content+'"> '+function(){
                        if(dispatcher[i].type=='dispatcher'){
                            return dispatcher[i].content
                        }else {
                            return dispatcher[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+dispatcher[i].userName+'">'+dispatcher[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+dispatcher[i].sendTimeStr+'">'+function(){
                        if(dispatcher[i].type=='dispatcher'){
                            return dispatcher[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return dispatcher[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#dispatcherS').html(dispatcher.length);
            $('#dispatcherUrl').html(dispatcherStr);
            if(dispatcher.length==0){
                $('#dispatcher').hide();
            }else{
                $('.read_43').attr('dataType',dispatcher[0].type);
                $('#dispatcher').show();
            }
            //第三方系统
            for (var i = 0; i < thirdSystem.length; i++) {
                thirdSystemStr += '<li bodyId="'+thirdSystem[i].bodyId+'" onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="200"  data-url="' + thirdSystem[i].remindUrl + '">' +
                    '<img style="vertical-align: middle" src="' + thirdSystem[i].img + '" alt="">' +
                    '<span  class="windowopen" data-id="'+thirdSystem[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+thirdSystem[i].content+'"> '+function(){
                        if(thirdSystem[i].type=='thirdSystem'){
                            return thirdSystem[i].content
                        }else {
                            return thirdSystem[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+thirdSystem[i].userName+'">'+thirdSystem[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+thirdSystem[i].sendTimeStr+'">'+function(){
                        if(thirdSystem[i].type=='thirdSystem'){
                            return thirdSystem[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return thirdSystem[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#thirdSystemS').html(thirdSystem.length);
            $('#thirdSystemUrl').html(thirdSystemStr);
            if(thirdSystem.length==0){
                $('#thirdSystem').hide();
            }else{
                $('.read_18').attr('dataType',thirdSystem[0].type);
                $('#thirdSystem').show();
            }

            //培训计划
            for (var i = 0; i < addPlanApproval.length; i++) {
                addPlanStr += '<li bodyId="'+addPlanApproval[i].bodyId+'" onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="200"  data-url="' + addPlanApproval[i].remindUrl + '">' +
                    '<img style="vertical-align: middle" src="' + addPlanApproval[i].img + '" alt="">' +
                    '<span  class="windowopen" data-id="'+addPlanApproval[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+addPlanApproval[i].content+'">'+function(){
                        if(addPlanApproval[i].type=='addPlanApproval'){
                            return addPlanApproval[i].content
                        }else {
                            return addPlanApproval[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+addPlanApproval[i].userName+'">'+addPlanApproval[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+addPlanApproval[i].sendTimeStr+'">'+function(){
                        if(addPlanApproval[i].type=='addPlanApproval'){
                            return addPlanApproval[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return addPlanApproval[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#tranPlan').html(addPlanApproval.length);
            $('#tranPlanList').html(addPlanStr);
            if(addPlanApproval.length==0){
                $('#traPlan').hide();
            }else{
                $('.read_19').attr('dataType',addPlanApproval[0].type);
                $('#traPlan').show();
            }


            //邮件提醒
            for(var i=0;i<email.length;i++){
                emaileStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1" smsId="'+email[i].smsId+'"  data-url="'+email[i].remindUrl+'&bodyId='+email[i].bodyId+'">' +
                    '<img  style="vertical-align: middle;" src="'+email[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+email[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+email[i].content+'"> '+function(){
                        if(email[i].type=='willdo'){
                            return email[i].content
                        }else {
                            return email[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+email[i].userName+'">'+email[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+email[i].sendTimeStr+'">'+function(){
                        if(email[i].type=='willdo'){
                            return email[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return email[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#userSease').html(email.length)
            $('#emailAll').html(emaileStr)
            if(email.length==0){
                $('#emailId').hide()
            }else{
                $('.read_1').attr('dataType',email[0].type);
                $('#emailId').show()
            }

            //邮件互发提醒
            for(var i=0;i<emailPlus.length;i++){
                emailPlusStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="'+emailPlus[i].remindUrl+'&bodyId='+emailPlus[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+emailPlus[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+emailPlus[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+emailPlus[i].content+'"> '+function(){
                        if(emailPlus[i].type=='willdo'){
                            return emailPlus[i].content
                        }else {
                            return emailPlus[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+emailPlus[i].userName+'">'+emailPlus[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+emailPlus[i].sendTimeStr+'">'+function(){
                        if(emailPlus[i].type=='willdo'){
                            return emailPlus[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return emailPlus[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#userSeasePlus').html(emailPlus.length)
            $('#emailPlusAll').html(emailPlusStr)
            if(emailPlus.length==0){
                $('#emailPlusId').hide()
            }else{
                $('.read_2').attr('dataType',emailPlus[0].type);
                $('#emailPlusId').show()
            }

            //新建讨论区提醒
            for(var i=0;i<bbsBoard.length;i++){
                bbsBoardStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="'+bbsBoard[i].remindUrl+'&bodyId='+bbsBoard[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+bbsBoard[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+bbsBoard[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+bbsBoard[i].content+'"> '+function(){
                        if(bbsBoard[i].type=='willdo'){
                            return bbsBoard[i].content
                        }else {
                            return bbsBoard[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+bbsBoard[i].userName+'">'+bbsBoard[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+bbsBoard[i].sendTimeStr+'">'+function(){
                        if(bbsBoard[i].type=='willdo'){
                            return bbsBoard[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return bbsBoard[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#userSeaseFive').html(bbsBoard.length)
            $('#bbsBoardAll').html(bbsBoardStr)
            if(bbsBoard.length==0){
                $('#bbsBoardId').hide()
            }else{
                $('.read_2').attr('dataType',bbsBoard[0].type);
                $('#bbsBoardId').show()
            }

            //公告提醒
            for(var n=0;n<notify.length;n++){
                notifyStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="5" data-url="'+notify[n].remindUrl+'" data-qid="'+notify[n].qid+'">' +
                    '<img style="vertical-align: middle" src="'+notify[n].img+'" alt="">' +
                    '<span class="windowopen" data-id="'+notify[n].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+notify[n].content+'"> '+function(){
                        if(notify[n].type=='willdo'){
                            return notify[n].content
                        }else {
                            return notify[n].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+notify[n].userName+'">'+notify[n].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+notify[n].sendTimeStr+'">'+function(){
                        if(notify[n].type=='willdo'){
                            return notify[n].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return notify[n].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#notifyAll').html(notifyStr)
            $('#userSeaseTwo').html(notify.length)
            if(notify.length==0){
                $('#notifyAll').parent().parent().hide();
            }else {
                $('.read_4').attr('dataType',notify[0].type);
                $('#notifyAll').parent().parent().show();
            }
            //新闻提醒
            for(var i=0;i<news.length;i++){
                newsStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="4" dataUrl="'+news[i].remindUrl+'" data-new="'+news[i].qid+'" bodyId="'+news[i].bodyId+'">'+
                    '<img  style="vertical-align: middle;" src="/img/main_img/theme3/xinwentishi.png" alt="">' +
                    '<span  class="windowopen" data-id="'+news[i].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+news[i].content+'"> '+function(){
                        if(news[i].type=='willdo'){
                            return news[i].content
                        }else {
                            return news[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+news[i].userName+'">'+news[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+news[i].sendTimeStr+'">'+function(){
                        if(news[i].type=='willdo'){
                            return news[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return news[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#userSeasenew').html(news.length)
            $('#newsAll').html(newsStr)
            if(news.length==0){
                $('#newsAll').parent().parent().hide()
            }else {
                $('.read_3').attr('dataType',news[0].type);
                $('#newsAll').parent().parent().show()
            }

            //工作流提醒
            for(var m=0;m<workFlow.length;m++){
                workFlowStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="2" data-url="'+workFlow[m].remindUrl+'">' +
                    '<img style="vertical-align: middle;" src="'+workFlow[m].img+'" alt="">' +
                    '<span class="windowopen" data-id="'+workFlow[m].uid+'" style="vertical-align: middle;margin-top: 5px;" title="'+workFlow[m].content+'"> '+function(){
                        if(workFlow[m].type=='willdo'){
                            return workFlow[m].content
                        }else {
                            return workFlow[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+workFlow[m].userName+'">'+workFlow[m].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+workFlow[m].sendTimeStr+'">'+function(){
                        if(workFlow[m].type=='willdo'){
                            return workFlow[m].sendTimeStr.replace(/\s/g,'<b style="    margin-left: 0.5em;"></b>')

                        }else {
                            return workFlow[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#workFlowAll').html(workFlowStr)


            $('#userSeasethree').html(workFlow.length)
            if(workFlow.length==0){
                $('#workFlowAll').parent().parent().hide();
            }else {
                $('.read_5').attr('dataType',workFlow[0].type);
                $('#workFlowAll').parent().parent().show();
            }
            if(projectId=='dazu'){
                $('#workFlowAll .headline').hide()
            }



            //理论学习提醒
            for(var m=0;m<integralManager.length;m++){
                integralManagerStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+integralManager[i].bodyId+'" data-s="15" data-url="'+integralManager[m].remindUrl+'">' +
                    '<img style="vertical-align: middle" src="img/meeting/书籍.png" alt="">' +
                    '<span class="windowopen" data-id="'+integralManager[m].uid+'" style="vertical-align: middle;margin-top: 5px;" title="'+integralManager[m].content+'"> '+function(){
                        if(integralManager[m].type=='willdo'){
                            return integralManager[m].content
                        }else {
                            return integralManager[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+integralManager[m].userName+'">'+integralManager[m].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+integralManager[m].sendTimeStr+'">'+function(){
                        if(integralManager[m].type=='willdo'){
                            return integralManager[m].sendTimeStr.replace(/\s/g,'<b style="    margin-left: 0.5em;"></b>')

                        }else {
                            return integralManager[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#study1').html(integralManagerStr)
            $('#study').html(integralManager.length)
            if(integralManager.length==0){
                $('#study1').parent().parent().hide();
            }else {
                $('.read_38').attr('dataType',integralManager[0].type);
                $('#study1').parent().parent().show();
            }
            if(projectId=='dazu'){
                $('#study1 .headline').hide()
            }





            //投票代办查询
            for(var m=0;m<toupiao.length;m++){
                toupiaos+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="11" data-url="'+toupiao[m].remindUrl+'">' +
                    '<img style="vertical-align: middle" src="'+toupiao[m].img+'" alt="">' +
                    '<span class="windowopen" data-id="'+toupiao[m].qid+'" style="vertical-align: middle;margin-top: 5px;" title="'+toupiao[m].content+'"> '+function(){
                        if(toupiao[m].type=='toupiao'){
                            return toupiao[m].content
                        }else {
                            return toupiao[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+toupiao[m].userName+'">'+toupiao[m].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+toupiao[m].sendTimeStr+'">'+function(){
                        if(toupiao[m].type=='toupiao'){
                            return toupiao[m].sendTimeStr.replace(/\s/g,'<b style="    margin-left: 0.5em;"></b>')

                        }else {
                            return toupiao[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#toupiaourl').html(toupiaos)
            $('#toupiao1').html(toupiao.length)
            if(toupiao.length==0){
                $('#toupiao').hide()
            }else {
                $('.read_7').attr('dataType',toupiao[0].type);
                $('#toupiao').show()
            }

            //督察督办事务提醒
            for(var i=0;i<supervisionsObj.length;i++){
                supervisionsStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="10" data-url="'+supervisionsObj[i].remindUrl+'&bodyId='+supervisionsObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+supervisionsObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+supervisionsObj[i].content+'"> '+function(){
                        if(supervisionsObj[i].type=='supervisions'){
                            return supervisionsObj[i].content
                        }else {
                            return supervisionsObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+supervisionsObj[i].userName+'">'+supervisionsObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+supervisionsObj[i].sendTimeStr+'">'+function(){
                        if(supervisionsObj[i].type=='supervisions'){
                            return supervisionsObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return supervisionsObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#duchadubanurl').html(supervisionsStr);
            $('#duchaduban1').html(supervisionsObj.length);
            if(supervisionsObj.length == 0){
                $('#duchaduban').hide();
            }else{
                $('.read_8').attr('dataType',supervisionsObj[0].type);
                $('#duchaduban').show();
            }

            //会议提醒
            for(var i=0;i<meetingObj.length;i++){
                meetingStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="15" data-url="'+meetingObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+meetingObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+meetingObj[i].content+'"> '+function(){
                        if(meetingObj[i].type=='meeting'){
                            return meetingObj[i].content
                        }else {
                            return meetingObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+meetingObj[i].userName+'">'+meetingObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+meetingObj[i].sendTimeStr+'">'+function(){
                        if(meetingObj[i].type=='meeting'){
                            return meetingObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return meetingObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#huiyiurl').html(meetingStr);
            $('#huiyi1').html(meetingObj.length);
            if(meetingObj.length == 0){
                $('#huiyi').hide();
            }else{
                $('.read_9').attr('dataType',meetingObj[0].type);
                $('#huiyi').show();
            }

            //日程提醒
            for(var i=0;i<richengObj.length;i++){
                richengStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+richengObj[i].remindUrl+'&bodyId='+richengObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+richengObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+richengObj[i].content+'"> '+function(){
                        if(richengObj[i].type=='calendars'){
                            return richengObj[i].content
                        }else {
                            return richengObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+richengObj[i].userName+'">'+richengObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+richengObj[i].sendTimeStr+'">'+function(){
                        if(richengObj[i].type=='calendars'){
                            return richengObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return richengObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#richengurl').html(richengStr);
            $('#richeng1').html(richengObj.length);
            if(richengObj.length == 0){
                $('#richeng').hide();
            }else{
                $('.read_10').attr('dataType',richengObj[0].type);
                $('#richeng').show();
            }

            //工作日志
            for(var i=0;i<rizhiObj.length;i++){
                rizhiStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="16" data-url="'+rizhiObj[i].remindUrl+'&bodyId='+rizhiObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle;" src="'+rizhiObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+rizhiObj[i].content+'"> '+function(){
                        if(rizhiObj[i].type=='diarys'){
                            return rizhiObj[i].content
                        }else {
                            return rizhiObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+rizhiObj[i].userName+'">'+rizhiObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+rizhiObj[i].sendTimeStr+'">'+function(){
                        if(rizhiObj[i].type=='diarys'){
                            return rizhiObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return rizhiObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#rizhiurl').html(rizhiStr);
            $('#rizhi1').html(rizhiObj.length);
            if(rizhiObj.length == 0){
                $('#rizhi').hide();
            }else{
                $('.read_11').attr('dataType',rizhiObj[0].type);
                $('#rizhi').show();
            }

            //领导活动安排
            for(var i=0;i<leaderObj.length;i++){
                leaderStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+leaderObj[i].remindUrl+'&bodyId='+leaderObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+leaderObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+leaderObj[i].content+'"> '+function(){
                        if(leaderObj[i].type=='schedules'){
                            return leaderObj[i].content
                        }else {
                            return leaderObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+leaderObj[i].userName+'">'+leaderObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+leaderObj[i].sendTimeStr+'">'+function(){
                        if(leaderObj[i].type=='schedules'){
                            return leaderObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return leaderObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#leaderActivurl').html(leaderStr);
            $('#leaderActiv1').html(leaderObj.length);
            if(leaderObj.length == 0){
                $('#leaderActiv').hide();
            }else{
                $('.read_12').attr('dataType',leaderObj[0].type);
                $('#leaderActiv').show();
            }

            //公共文件柜
            for(var i=0;i<publicObj.length;i++){
                publicStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="24" data-url="'+publicObj[i].remindUrl+'&bodyId='+publicObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle;" src="'+publicObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;;font-weight: bold;font-size: 13px" title="'+publicObj[i].content+'">'+function(){
                        if(publicObj[i].type=='publicFiles'){
                            return publicObj[i].content
                        }else {
                            return publicObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+publicObj[i].userName+'">'+publicObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+publicObj[i].sendTimeStr+'">'+function(){
                        if(publicObj[i].type=='publicFiles'){
                            return publicObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return publicObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#publicFileurl').html(publicStr);
            $('#publicFile1').html(publicObj.length);
            if(publicObj.length == 0){
                $('#publicFile').hide();
            }else{
                $('.read_14').attr('dataType',publicObj[0].type);
                $('#publicFile').show();
            }

            // 任务管理提醒
            for (var i = 0; i < taskManage.length; i++) {
                taskManageStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="24" data-url="'+taskManage[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+taskManage[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+taskManage[i].content+'"> '+function(){
                        if(taskManage[i].type=='taskManage'){
                            return taskManage[i].content
                        }else {
                            return taskManage[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+taskManage[i].userName+'">'+taskManage[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+taskManage[i].sendTimeStr+'">'+function(){
                        if(taskManage[i].type=='taskManage'){
                            return taskManage[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return taskManage[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }

            $('#taskManageList').html(taskManageStr);
            $('#taskManagePlan').html(taskManage.length);
            if(taskManage.length == 0){
                $('#taskManage').hide();
            }else{
                $('.read_24').attr('dataType',taskManage[0].type);
                $('#taskManage').show();
            }

            // 车辆申请提醒
            for (var i = 0; i < carApproval.length; i++) {
                carApprovalStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="25" data-url="'+carApproval[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+carApproval[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+carApproval[i].content+'"> '+function(){
                        if(carApproval[i].type=='carApproval'){
                            return carApproval[i].content
                        }else {
                            return carApproval[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+carApproval[i].userName+'">'+carApproval[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+carApproval[i].sendTimeStr+'">'+function(){
                        if(carApproval[i].type=='carApproval'){
                            return carApproval[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return carApproval[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#carApprovalList').html(carApprovalStr);
            $('#carApprovalPlan').html(carApproval.length);
            if(carApproval.length == 0){
                $('#vehicleApplication').hide();
            }else{
                $('.read_25').attr('dataType',carApproval[0].type);
                $('#carApproval').show();
            }

            //网络硬盘
            for(var i=0;i<netDiskObj.length;i++){
                netDiskStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="18" data-url="'+netDiskObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle;" src="'+netDiskObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+netDiskObj[i].content+'"> '+function(){
                        if(netDiskObj[i].type=='netDisk'){
                            return netDiskObj[i].content
                        }else {
                            return netDiskObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+netDiskObj[i].userName+'">'+netDiskObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+netDiskObj[i].sendTimeStr+'">'+function(){
                        if(netDiskObj[i].type=='netDisk'){
                            return netDiskObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return netDiskObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#networkDiskurl').html(netDiskStr);
            $('#networkDisk1').html(netDiskObj.length);
            if(netDiskObj.length == 0){
                $('#networkDisk').hide();
            }else{
                $('.read_15').attr('dataType',netDiskObj[0].type);
                $('#networkDisk').show();
            }
            //值班管理
            for(var i=0; i<zhibanObj.length;i++){
                zhibanStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="/dutyManagement/transactionRemind?dutyId='+zhibanObj[i].dutyId+'">' +
                    '<img  style="vertical-align: middle" src="'+zhibanObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+zhibanObj[i].qid+'" style="vertical-align: middle;margin-top: 5px;">'
                    +'</span>' +
                    '<label style="color: #999;width: 12em" title="'+zhibanObj[i].sendTimeStr+'">'+function(){
                        if(zhibanObj[i].type=='zhibanguanli'){
                            return zhibanObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return zhibanObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#zhibang').html(zhibanStr);
            $('#zhibanS').html(zhibanObj.length);
            if(zhibanObj.length == 0){
                $('#zhiban').hide();
            }else{
                $('.read_16').attr('dataType',zhibanObj[0].type);
                $('#zhiban').show();
            }


            //办公用品申领事务提醒
            for(var i=0;i<bangongObj.length;i++){
                bangongStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="10" data-url="'+bangongObj[i].remindUrl+'&bodyId='+bangongObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+bangongObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+bangongObj[i].content+'"> '+function(){
                        if(bangongObj[i].type=='supervisions'){
                            return bangongObj[i].content
                        }else {
                            return bangongObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+bangongObj[i].userName+'">'+bangongObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+bangongObj[i].sendTimeStr+'">'+function(){
                        if(bangongObj[i].type=='supervisions'){
                            return bangongObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return bangongObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#bangongyongpinshenlingurl').html(bangongStr);
            $('#bangongyongpinshenling1').html(bangongObj.length);
            if(bangongObj.length == 0){
                $('#bangongyongpinshenling').hide();
            }else{
                $('.read_13').attr('dataType',bangongObj[0].type);
                $('#bangongyongpinshenling').show();
            }

            //好视通视频会议提醒
            for(var i=0;i<hstMeetingObj.length;i++){
                hstMeetingStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="73" bodyId="'+hstMeetingObj[i].bodyId+'" data-url="'+hstMeetingObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+hstMeetingObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+hstMeetingObj[i].content+'"> '+function(){
                        if(hstMeetingObj[i].type=='hstmeeting'){
                            return hstMeetingObj[i].content
                        }else {
                            return hstMeetingObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+hstMeetingObj[i].userName+'">'+hstMeetingObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+hstMeetingObj[i].sendTimeStr+'">'+function(){
                        if(hstMeetingObj[i].type=='hstmeeting'){
                            return hstMeetingObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return hstMeetingObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#hstMeetingurl').html(hstMeetingStr);
            $('#hstMeeting1').html(hstMeetingObj.length);
            if(hstMeetingObj.length == 0){
                $('#hstMeeting').hide();
            }else{
                $('.read_26').attr('dataType',hstMeetingObj[0].type);
                $('#hstMeeting').show();
            }


            //资格证书管理提醒
            for(var i=0;i<crmcertificate.length;i++){
                var url=crmcertificate[i].remindUrl+'&bodyId='+crmcertificate[i].bodyId
                crmcertificateStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="15" bodyId="'+crmcertificate[i].bodyId+'" data-url="'+url+'">' +
                    '<img  style="vertical-align: middle" src="'+crmcertificate[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+crmcertificate[i].content+'"> '+function(){
                        if(crmcertificate[i].type=='crmcertificate'){
                            return crmcertificate[i].content
                        }else {
                            return crmcertificate[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+crmcertificate[i].userName+'">'+crmcertificate[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+crmcertificate[i].sendTimeStr+'">'+function(){
                        if(crmcertificate[i].type=='hstmeeting'){
                            return crmcertificate[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return crmcertificate[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#crmcertificateurl').html(crmcertificateStr);
            $('#crmcertificate1').html(crmcertificate.length);
            if(crmcertificate.length == 0){
                $('#crmcertificate').hide();
            }else{
                $('.read_34').attr('dataType',crmcertificate[0].type);
                $('#crmcertificate').show();
            }


            //固定资产事务提醒
            for(var i=0;i<assetObj.length;i++){
                assetStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="28" data-url="'+assetObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+assetObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+assetObj[i].content+'"> '+function(){
                        if(assetObj[i].type=='hstmeeting'){
                            return assetObj[i].content
                        }else {
                            return assetObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+assetObj[i].userName+'">'+assetObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+assetObj[i].sendTimeStr+'">'+function(){
                        if(assetObj[i].type=='asset'){
                            return assetObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return assetObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#assetsIdurl').html(assetStr);
            $('#assetsId1').html(assetObj.length);
            if(assetObj.length == 0){
                $('#assetsId').hide();
            }else{
                $('.read_28').attr('dataType',assetObj[0].type);
                $('#assetsId').show();
            }




            //讨论区
            for(var i=0;i<bbscommentObj.length;i++){
                bbscommentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+bbscommentObj[i].remindUrl+'&bodyId='+bbscommentObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+bbscommentObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+bbscommentObj[i].content+'"> '+function(){
                        if(bbscommentObj[i].type=='calendars'){
                            return bbscommentObj[i].content
                        }else {
                            return bbscommentObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+bbscommentObj[i].userName+'">'+bbscommentObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+bbscommentObj[i].sendTimeStr+'">'+function(){
                        if(bbscommentObj[i].type=='calendars'){
                            return bbscommentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return bbscommentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#bbscommentList').html(bbscommentStr);
            $('#bbscommentPlan').html(bbscommentObj.length);
            if(bbscommentObj.length == 0){
                $('#bbscomment').hide();
            }else{
                $('.read_27').attr('dataType',bbscommentObj[0].type);
                $('#bbscomment').show();
            }

            //合同管理
            for(var i=0;i<contractremindObj.length;i++){
                contractremindStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+contractremindObj[i].remindUrl+'&bodyId='+contractremindObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+contractremindObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+contractremindObj[i].content+'"> '+function(){
                        if(contractremindObj[i].type=='contractremind'){
                            return contractremindObj[i].content
                        }else {
                            return contractremindObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+contractremindObj[i].userName+'">'+contractremindObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+contractremindObj[i].sendTimeStr+'">'+function(){
                        if(contractremindObj[i].type=='contractremind'){
                            return contractremindObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return contractremindObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#contractremindList').html(contractremindStr);
            $('#contractremindPlan').html(contractremindObj.length);
            if(contractremindObj.length == 0){
                $('#contractremind').hide();
            }else{
                $('.read_28').attr('dataType',contractremindObj[0].type);
                $('#contractremind').show();
            }

            //制度管理
            for(var i=0;i<institutioncontentObj.length;i++){
                institutioncontentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+institutioncontentObj[i].remindUrl+'?bodyId='+institutioncontentObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+institutioncontentObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+institutioncontentObj[i].content+'"> '+function(){
                        if(institutioncontentObj[i].type=='institutioncontent'){
                            return institutioncontentObj[i].content
                        }else {
                            return institutioncontentObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+institutioncontentObj[i].userName+'">'+institutioncontentObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+institutioncontentObj[i].sendTimeStr+'">'+function(){
                        if(institutioncontentObj[i].type=='institutioncontent'){
                            return institutioncontentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return institutioncontentObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#institutioncontentList').html(institutioncontentStr);
            $('#institutioncontentPlan').html(institutioncontentObj.length);
            if(institutioncontentObj.length == 0){
                $('#institutioncontent').hide();
            }else{
                $('.read_29').attr('dataType',institutioncontentObj[0].type);
                $('#institutioncontent').show();
            }

            //公安局值班管理
            for(var i=0;i<dutypoliceusersObj.length;i++){
                dutypoliceusersStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="19" data-url="'+dutypoliceusersObj[i].remindUrl+'&bodyId='+dutypoliceusersObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+dutypoliceusersObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+dutypoliceusersObj[i].content+'"> '+function(){
                        if(dutypoliceusersObj[i].type=='dutypoliceusers'){
                            return dutypoliceusersObj[i].content
                        }else {
                            return dutypoliceusersObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+dutypoliceusersObj[i].userName+'">'+dutypoliceusersObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+dutypoliceusersObj[i].sendTimeStr+'">'+function(){
                        if(dutypoliceusersObj[i].type=='dutypoliceusers'){
                            return dutypoliceusersObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return dutypoliceusersObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#onDutyList').html(dutypoliceusersStr);
            $('#onDutyPlan').html(dutypoliceusersObj.length);
            if(dutypoliceusersObj.length == 0){
                $('#onDuty').hide();
            }else{
                $('.read_30').attr('dataType',dutypoliceusersObj[0].type);
                $('#onDuty').show();
            }

            //即会通视频会议事务提醒
            for(var i=0;i<jhtmeeting.length;i++){
                var url=jhtmeeting[i].remindUrl+'?bodyId='+jhtmeeting[i].bodyId
                jhtmeetingStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="15" data-url="'+url+'">' +
                    '<img  style="vertical-align: middle" src="'+jhtmeeting[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+jhtmeeting[i].content+'"> '+function(){
                        if(jhtmeeting[i].type=='hstmeeting'){
                            return jhtmeeting[i].content
                        }else {
                            return jhtmeeting[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+jhtmeeting[i].userName+'">'+jhtmeeting[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+jhtmeeting[i].sendTimeStr+'">'+function(){
                        if(jhtmeeting[i].type=='hstmeeting'){
                            return jhtmeeting[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return jhtmeeting[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#jhtmeetingurl').html(jhtmeetingStr);
            $('#jhtmeeting1').html(jhtmeeting.length);
            if(jhtmeeting.length == 0){
                $('#jhtmeeting').hide();
            }else{
                $('.read_31').attr('dataType',jhtmeeting[0].type);
                $('#jhtmeeting').show();
            }

            // 中电建网报事物提醒
            for (var i = 0; i < onlineReimbursementSystemObj.length; i++) {
                onlineReimbursementSystemStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="32" data-url="'+onlineReimbursementSystemObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+onlineReimbursementSystemObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+onlineReimbursementSystemObj[i].content+'"> '+function(){
                        if(onlineReimbursementSystemObj[i].smsType=='powerchina'){
                            return onlineReimbursementSystemObj[i].content
                        }else {
                            return onlineReimbursementSystemObj[i].content
                        }
                    }()+'</span>' +
                    '<span>' +
                    // '<label style="margin-right: 1em;" title="'+onlineReimbursementSystemObj[i].userName+'">'+onlineReimbursementSystemObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+onlineReimbursementSystemObj[i].sendTimeStr+'">'+function(){
                        if(onlineReimbursementSystemObj[i].smsType=='powerchina'){
                            return onlineReimbursementSystemObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return onlineReimbursementSystemObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#onlineReimbursementSystemList').html(onlineReimbursementSystemStr);
            $('#onlineReimbursementSystemPlan').html(onlineReimbursementSystemObj.length);
            if(onlineReimbursementSystemObj.length == 0){
                $('#onlineReimbursementSystem').hide();
            }else{
                $('.read_32').attr('dataType',onlineReimbursementSystemObj[0].type);
                $('#onlineReimbursementSystem').show();
            }

            // 计划管理提醒
            for (var i = 0; i < planManageObj.length; i++) {
                planManageStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+planManageObj[i].bodyId+'" data-s="33" data-url="'+planManageObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+planManageObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+planManageObj[i].content+'"> '+function(){
                        if(planManageObj[i].type=='planManage'){
                            return planManageObj[i].content
                        }else {
                            return planManageObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+planManageObj[i].userName+'">'+planManageObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+planManageObj[i].sendTimeStr+'">'+function(){
                        if(planManageObj[i].type=='planManage'){
                            return planManageObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return planManageObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#planManageList').html(planManageStr);
            $('#planManagePlan').html(planManageObj.length);
            if(planManageObj.length == 0){
                $('#planManageBox').hide();
            }else{
                $('.read_33').attr('dataType',planManageObj[0].type);
                $('#planManageBox').show();
            }

            // 考核模块提醒
            for (var i = 0; i < assessments.length; i++) {
                assessmentsStr +='<li onclick="windowOpenNew(this)" bodyId="'+assessments[i].bodyId+'" data-s="33" data-url="'+assessments[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+assessments[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+assessments[i].content+'"> '+function(){
                        if(assessments[i].type=='planManage'){
                            return assessments[i].content
                        }else {
                            return assessments[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+assessments[i].userName+'">'+assessments[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+assessments[i].sendTimeStr+'">'+function(){
                        if(assessments[i].type=='assessment'){
                            return assessments[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return assessments[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#assessmentList').html(assessmentsStr);
            $('#assessments').html(assessments.length);
            if(assessments.length == 0){
                $('#assessmentBox').hide();
            }else{
                $('.read_33').attr('dataType',assessments[0].type);
                $('#assessmentBox').show();
            }
            // 党建
            for (var i = 0; i < partyMember.length; i++) {
                partyMemberStr +='<li onclick="windowOpenNew(this)" bodyId="'+partyMember[i].bodyId+'" data-s="33" data-url="'+partyMember[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+partyMember[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+partyMember[i].content+'"> '+function(){
                        if(partyMember[i].type=='planManage'){
                            return partyMember[i].content
                        }else {
                            return partyMember[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+partyMember[i].userName+'">'+partyMember[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+partyMember[i].sendTimeStr+'">'+function(){
                        if(partyMember[i].type=='assessment'){
                            return partyMember[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return partyMember[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#partyMemberList').html(partyMemberStr);
            $('#partyMember').html(partyMember.length);
            if(partyMember.length == 0){
                $('#partyMemberBox').hide();
            }else{
                $('.read_36').attr('dataType',partyMember[0].type);
                $('#partyMemberBox').show();
            }


            //证照管理实务提醒
            for(var i=0;i<licenseObj.length;i++){
                richengStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1" data-url="'+licenseObj[i].remindUrl+'&bodyId='+licenseObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+licenseObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+licenseObj[i].content+'"> '+function(){
                        if(licenseObj[i].type=='calendars'){
                            return licenseObj[i].content
                        }else {
                            return licenseObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+licenseObj[i].userName+'">'+licenseObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+licenseObj[i].sendTimeStr+'">'+function(){
                        if(licenseObj[i].type=='calendars'){
                            return licenseObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return licenseObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#licenseList').html(richengStr);
            $('#license').html(licenseObj.length);
            if(licenseObj.length == 0){
                $('#zjgl').hide();
            }else{
                $('.read_37').attr('dataType',licenseObj[0].type);
                $('#zjgl').show();
            }
            //EHR待办工作提醒
            for (var i = 0; i < ehrAgencyObj.length; i++) {
                ehrAgencyStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+ehrAgencyObj[i].bodyId+'" data-s="33" data-url="'+ehrAgencyObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+ehrAgencyObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+ehrAgencyObj[i].content+'"> '+function(){
                        if(ehrAgencyObj[i].type=='ehrAgency'){
                            return ehrAgencyObj[i].content
                        }else {
                            return ehrAgencyObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+ehrAgencyObj[i].userName+'">'+ehrAgencyObj[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+ehrAgencyObj[i].sendTimeStr+'">'+function(){
                        if(ehrAgencyObj[i].type=='ehrAgency'){
                            return ehrAgencyObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return ehrAgencyObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#ehrWorkList').html(ehrAgencyStr);
            $('#ehrWork').html(ehrAgencyObj.length);
            if(ehrAgencyObj.length == 0){
                $('#dbgz').hide();
            }else{
                $('.read_38').attr('dataType',ehrAgencyObj[0].type);
                $('#dbgz').show();
            }
            //工作薪资提醒
            for (var i = 0; i < wagesManager.length; i++) {
                worksalary+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+wagesManager[i].bodyId+'" data-s="200" data-url="'+wagesManager[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+wagesManager[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+wagesManager[i].content+'"> '+function(){
                        if(wagesManager[i].type=='wagesManager'){
                            return wagesManager[i].content
                        }else {
                            return wagesManager[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+wagesManager[i].userName+'">'+wagesManager[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+wagesManager[i].sendTimeStr+'">'+function(){
                        if(wagesManager[i].type=='wagesManager'){
                            return wagesManager[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return wagesManager[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#worksalary').html(worksalary);
            $('#wagesManager1').html(wagesManager.length);
            if(wagesManager.length == 0){
                $('#wagesManager').hide();
            }else{
                $('.read_41').attr('dataType',wagesManager[0].type);
                $('#wagesManager').show();
            }
            //个人考勤提醒
            for (var i = 0; i < attendanceManager.length; i++) {
                attendance1+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+attendanceManager[i].bodyId+'" data-s="33" data-url="'+attendanceManager[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+attendanceManager[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+attendanceManager[i].content+'"> '+function(){
                        if(attendanceManager[i].type=='attendanceManager'){
                            return attendanceManager[i].content
                        }else {
                            return attendanceManager[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+attendanceManager[i].userName+'">'+attendanceManager[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+attendanceManager[i].sendTimeStr+'">'+function(){
                        if(attendanceManager[i].type=='attendanceManager'){
                            return attendanceManager[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return attendanceManager[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';

            }

            $('#attendance1').html(attendance1);
            $('#attendanceManager1').html(attendanceManager.length);
            if(attendanceManager.length == 0){
                $('#attendanceManager').hide();
            }else{
                $('.read_42').attr('dataType',attendanceManager[0].type);
                $('#attendanceManager').show();
            }
            //密码设置提醒
            for(var m=0;m<passwordManager.length;m++){
                passwordManagerStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+passwordManager[m].bodyId+'" data-s="15" data-url="'+passwordManager[m].remindUrl+'">' +
                    '<img style="vertical-align: middle" src="img/meeting/修改密码.png" alt="">' +
                    '<span class="windowopen" data-id="'+passwordManager[m].uid+'" style="vertical-align: middle;margin-top: 5px;" title="'+passwordManager[m].content+'"> '+function(){
                        if(passwordManager[m].type=='willdo'){
                            return passwordManager[m].content
                        }else {
                            return passwordManager[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+passwordManager[m].userName+'">'+passwordManager[m].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+passwordManager[m].sendTimeStr+'">'+function(){
                        if(passwordManager[m].type=='willdo'){
                            return passwordManager[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')

                        }else {
                            return passwordManager[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }

            $('#password1').html(passwordManagerStr)
            $('#password').html(passwordManager.length)
            if(passwordManager.length==0){
                $('#password1').parent().parent().hide();
            }else {
                $('.read_39').attr('dataType',passwordManager[0].type);
                $('#password1').parent().parent().show();
            }
            if(projectId=='dazu'){
                $('#password1 .headline').hide()
            }

            //员工关怀信息
            for(var m=0;m<hrStaffCare.length;m++){
                hrStaffCareStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+hrStaffCare[m].bodyId+'" data-s="15" data-url="'+hrStaffCare[m].remindUrl+'">' +
                    '<div style="display: flex"><img style="vertical-align: middle" src="img/meeting/yggh.png" alt="">' +
                    '<span class="windowopen" data-id="'+hrStaffCare[m].uid+'" style="vertical-align: middle;margin-top: 5px" title="'+hrStaffCare[m].content+'" '+function(){
                        if(hrStaffCare[m].type=='willdo'){
                            return hrStaffCare[m].content
                        }else {
                            return hrStaffCare[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+hrStaffCare[m].userName+'">'+hrStaffCare[m].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+hrStaffCare[m].sendTimeStr+'">'+function(){
                        if(hrStaffCare[m].type=='willdo'){
                            return hrStaffCare[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')

                        }else {
                            return hrStaffCare[m].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span></div>' +
                    '</li>'
            }

            $('#staffCare1').html(hrStaffCareStr)
            $('#staffCare').html(hrStaffCare.length)
            if(hrStaffCare.length==0){
                $('#staffCare1').parent().parent().hide();
            }else {
                $('.read_40').attr('dataType',hrStaffCare[0].type);
                $('#staffCare1').parent().parent().show();
            }
            if(projectId=='dazu'){
                $('#staffCare1 .headline').hide()
            }

            //系统类型
            for(var i = 0; i < sysType.length; i++) {
                sysTypeStr += '<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="24" data-url="'+sysType[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+sysType[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px;" title="'+sysType[i].content+'"> '+function(){
                        if(sysType[i].type=='systype'){
                            return sysType[i].content
                        }else {
                            return sysType[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;" title="'+sysType[i].userName+'">'+sysType[i].userName+'</label>' +
                    '<label style="color: #999;width: 11em" title="'+sysType[i].sendTimeStr+'">'+function(){
                        if(sysType[i].type=='systype'){
                            return sysType[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return sysType[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }

            $('#useSysType').html(sysType.length);
            $('#sysTypeAll').html(sysTypeStr);
            if(sysType.length==0){
                $('#sysTypeList').css("display","none");
            }else{
                $('#sysTypeList').css("display","block");
                $('.read_43').attr('dataType',sysType[0].type);
            }


            var $he=$('#sns .he').text();
            //投票代办、邮件互发、公文、工作流、新建讨论区、公告、新闻、邮件、督察督办等
            var he = parseInt($('#crmcertificate1').text()) + parseInt($('#toupiao1').text()) + parseInt($('#userSeasePlus').text()) + parseInt($('#docunmentSeasethree').text()) +
                parseInt($('#userSeasethree').text()) + parseInt($('#userSeaseFive').text()) + parseInt($('#userSeaseTwo').text()) +
                parseInt($('#userSeasenew').text()) + parseInt($('#userSease').text()) + parseInt($('#duchaduban1').text()) + parseInt($('#huiyi1').text()) +
                parseInt($('#richeng1').text()) + parseInt($('#rizhi1').text()) + parseInt($('#leaderActiv1').text()) + parseInt($('#publicFile1').text()) +
                parseInt($('#networkDisk1').text()) + parseInt($('#zhibanS').text()) + parseInt($('#bangongyongpinshenling1').text()) + parseInt($('#dispatcherS').text()) +
                parseInt($('#thirdSystemS').text()) + parseInt($('#tranPlan').text()) + parseInt($('#taskManagePlan').text()) + parseInt($('#carApprovalPlan').text()) +
                parseInt($('#hstMeeting1').text()) + parseInt($('#bbscommentPlan').text()) + parseInt($('#assetsId1').text()) + parseInt($('#contractremindPlan').text()) +
                parseInt($('#institutioncontentPlan').text()) + parseInt($('#onDutyPlan').text()) + parseInt($('#onlineReimbursementSystemPlan').text()) +
                parseInt($('#planManagePlan').text())+ parseInt($('#assessments').text())+parseInt($('#partyMember').text())+parseInt($('#license').text()) +
                parseInt($('#ehrWork').text())+parseInt($('#study').text())+parseInt($('#password').text())+parseInt($('#staffCare').text())+parseInt($('#wagesManager1').text());+parseInt($('#attendanceManager1').text());
            if(he >= 100){
                he = '99+';
            }
            todoListNum=he;
            $('#sns').html('<div class="he">'+ he +'</div>');

            if(he==0){
                $('#sns .he').hide()
            }else {
                $('#sns .he').show()
            }
            if($he==undefined){
                //控制事务提醒音乐
                if(music == 1){
                    try{
                        as[0].element.play();
                    }catch(e){
                        console.log('事物提醒音乐执行!')
                    }
                }

                layer.tips('<p style="color: #000;">'+new_task_reminder+'</p>','#sns',{
                    tips: [1, '#fff'],
                    time:10000,
                    tipsMore: true
                })
            }
            if(he>$he){
                //控制事务提醒音乐
                if(music == 1){
                    try{
                        as[0].element.play();
                    }catch(e){
                        console.log('事物提醒音乐执行!')
                    }
                }
                layer.tips('<p style="color: #000;">'+new_task_reminder+'</p>','#sns',{
                    tips: [1, '#fff'],
                    time:10000,
                    tipsMore: true
                })
            }
            if(typeof fn=='function'){
                fn()
            }
        }
    },'json')
}
//应用门户跳转
function getMenuOpen(me,type){
    if($(me).attr('data-num')==1){
        var wangpanId = '?'+$(me).attr('data-id');
    }else if($(me).attr('data-num')==undefined){
        var wangpanId = '';
    }
    var url=$(me).attr('data-url')||$(me).attr('url');
    var menu_tid=$(me).attr('menu_tid')||$(me).attr('tid');
    if(menu[url.replace(/\//g,'_')]){
        url = menu[url.replace(/\//g,'_')]+wangpanId;
    }else{
        url=url;
    }

    if ($(me).attr('more_type')) {
        url += '?moreType=' + $(me).attr('more_type');
    }

    if(type == 3){
        url += '?search='+$(me).attr('data-id');
    }
    if($('#f_'+menu_tid).length>0){
        //页面一打开，切换显示
        $('.all_content .iItem').hide();
        $('#f_'+menu_tid).show();
        if($(me).attr('data-num')==1 || $(me).attr('more_type')){
            $('#f_'+menu_tid).find('iframe').attr('src',url)
        }
        $('#t_'+menu_tid).css({
            'background':'url(img/main_img/title_yes.png) 0px 4px no-repeat',
            'color':'#2a588c',
            'position':'relative',
            'z-index':99999
        })
        $('#t_'+menu_tid).siblings().css({
            'background':'url(img/main_img/'+$('[name="sessionType"]').val()+'/title_no.png) 0px 4px no-repeat',
            'color':'#fff',
            'position':'relative',
            'z-index':999
        })
    }else{
        //页面不存在，新增 title和iframe
        var iframeTitle = $(me).find('h2').html()||'打开页面';
        var titlestr = '<li class="choose" index="0;" url="'+url+'" id="t_'+menu_tid+'" title="'+iframeTitle+'"><h1>'+iframeTitle+'</h1><div class="img" style="display:none;"><img class="close"  src="/img/main_img/icon.png"></div></li>';

        var iframestr = '<div id="f_'+menu_tid+'" class="iItem" ><iframe id="every_module" src="'+url+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';

        $('.main_title ul').append(titlestr);


        $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/theme1/title_no.png) 0px 4px no-repeat;');
        $('#t_'+menu_tid).siblings().css('color','#fff');
        /* console.log($('#t_'+menu_tid).siblings()); */
        $('.all_content').append(iframestr);
        $('.all_content .iItem').hide();
        $('#f_'+menu_tid).show();

             $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/'+$('[name="sessionType"]').val()+'/title_no.png) 0px 4px no-repeat;');
            $('#t_'+menu_tid).siblings().css('color','#fff');
            /* console.log($('#t_'+menu_tid).siblings()); */
            $('.all_content').append(iframestr);
            $('.all_content .iItem').hide();
            $('#f_'+menu_tid).show();

        mobileObj.left()

    }
}
function getUrlMenuOpen(tid,element){
    var menu_tid = tid;
    var url = element.attr('oldmenuUrl')||'';
    if($('.two_menu li[menu_tid='+ tid +']').length == 0){
        $('.two_menu li[url='+ url +']').click();
    }else{
        $('.two_menu li[menu_tid='+ tid +']').click();
    }
}
//播放事务提醒音乐

var as;
$(function(){
    try{
        audiojs.events.ready(function() {
            as = audiojs.createAll();
            listTable();
            dataLoad.init();
        });
    }catch(e){
        console.log(e)
        listTable();
        dataLoad.init();
    }

    var names = $('input[name=sessionType]').val();//获取当前皮肤字段
    $.get('/code/GetDropDownBox?CodeNos=NOTIFY',function (json) {
        var str='';
        var arr=json.NOTIFY;
        for(var i=0;i<3;i++){
            str+='<li class="weidu_notice head_title sort" style="width: 38px;" onclick="announcement(this)" data-bool="'+arr[i].codeNo+'">'+arr[i].codeName+'</li>'
        }
        $('#notice_listTwo').append(str)
    },'json')
    mobileObj.init();
    //首页右侧提醒页面里的功能
    //点击用户，展开用户中的内容
    $('.search_one_all').on('click',function(){
        /*alert('111');*/
        /*		alert($('.search_two_all').css('display')==none)*/
        if($(this).siblings('.search_two_all').css('display')=='none'){
            $(this).siblings('.search_two_all').show();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_open.png');
        }else{
            $(this).siblings('.search_two_all').hide();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_close.png');
        }
    });
    $('.apply_one_all').on('click',function(){
        /*alert('111');*/
        /*		alert($('.search_two_all').css('display')==none)*/
        if($(this).siblings('.search_two_all').css('display')=='none'){
            $(this).siblings('.search_two_all').show();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_open.png');
        }else{
            $(this).siblings('.search_two_all').hide();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_close.png');
        }
    });
    //搜索的接口
    $('#index_find').on('click',function(){

        var text = $('#searchText').val();
        $.ajax({
            url: '/todoList/queryUserByUserId',
            type: 'get',
            data:{
                userName:text
            },
            dataType: 'json',
            success: function (obj) {
                var str='';
                var data=obj.obj;
                $('#userSearchNum').text(data.length);
                for(var i=0;i<data.length;i++){
                    if(data[i].mobilNo==undefined){
                        data[i].mobilNo=''
                    }
                    str+='<li style="height:60px;"><a class="bulletFrame" uid ='+data[i].uid+'>' +
                        '<div class="custom-two-left" style="width:50px;margin-right:10px">' +
                        '<img onerror="imgerror(this,1)" style="width: 50px;border-radius: 50%;margin-top: 5px!important" src="'+function () {

                            if(data[i].avatar==0){
                                return '/img/user/boy.png'
                            }
                            else if(data[i].avatar==1){
                                return '/img/user/girl.png'
                            }else {
                                return '/img/user/'+data[i].avatar
                            }

                        }()+'" alt="">' +
                        '</div>' +
                        '<div class="custom-two-mid">' +
                        '<h2 style="font-size: 15px;width: 300px;padding-top: 10px;white-space: nowrap;">姓名：'+data[i].userName+'</h2>' +
                        '<span style="font-size: 15px;color: #0088cc;" class="priv_name">角色：'+data[i].userPrivName+'</span>' +
                        '<h2 style="font-size: 15px;">电话：<span>'+data[i].mobilNo+'</span>' +
                        '</h2>' +
                        '</div>' +
                        '<div class="custom-two-right">' +
                        '</div>' +
                        '</a></li>'//<div class="two-right-all"><img src="/img/main_img/cus_email.png" alt=""><h1>邮件</h1></div>
                }

                $('.search_custom .custom_two').html(str);
                $('.bulletFrame').click(function () {
                    layer.open({
                        type:2,
                        title:'',
                        shade: 0.3,
                        area: ['750px', '450px'],
                        content: '/sys/userDetails?uid='+$(this).attr('uid'),
                    })
                })
            }
        });
        $.ajax({
            url: '/todoList/getSysFunctionByName',
            type: 'get',
            data:{
                funName:text
            },
            dataType: 'json',
            success: function (obj) {
                var str='';
                var data=obj.obj;
                // $('#apply_num').text(data.length);
                $('#applySearchNum').text(data.length);
                for(var i=0;i<data.length;i++){
                    var name1=data[i].name1
                    if(name1==undefined||name1==''){
                        name1='morentupian'
                    }
                    if(data[i].url.indexOf('@') == -1){

                        str+='<li style="cursor: pointer;height: 50px!important;" onclick="getMenuOpen(this)" data-url="'+data[i].url+'" menu_tid="'+data[i].id+'">' +
                            '<h2 style="display: none">'+data[i].name+'</h2><div class="custom-two-left">' +
                            '<img style="width: 25px;height: 25px;margin-top: -12px!important;" src="/img/menu/'+name1+'.png" alt=""></div>' +
                            '<div class="custom-two-mid" style="height:59%;"><h1 style="line-height: 50px!important;">'+data[i].name+'</h1></div>' +
                            '<div class="custom-two-right"></div></li>'//<div class="two-right-all"><img src="/img/main_img/cus_email.png" alt=""><h1>邮件</h1></div>

                    }
                    if(data[i].url.indexOf('@') == 0){
                        str+='<li style="cursor: pointer;height: 50px!important;" data-url="'+data[i].url+'" menu_tid="'+data[i].id+'">' +
                            '<h2 style="display: none">'+data[i].name+'</h2><div class="custom-two-left">' +
                            '<img style="width: 25px;height: 25px;margin-top: -12px!important;" src="/img/menu/'+name1+'.png" alt=""></div>' +
                            '<div class="custom-two-mid" style="height:59%;"><h1 style="line-height: 50px!important;">'+data[i].name+'</h1></div>' +
                            '<div class="custom-two-right"></div></li>'//<div class="two-right-all"><img src="/img/main_img/cus_email.png" alt=""><h1>邮件</h1></div>

                    }
                }
                $('.search_apply .custom_two').html(str);
            }
        });

    })

    $('#searchText').bind('keypress',function(event){
        if(event.keyCode == "13")
        {
            $('#index_find').click()
        }
    });

    //            点击一键阅读
    $('.oneKeyRead').click(function (ev) {
        var oEvent = ev || event;
        oEvent.stopPropagation();
        var modelType=$(this).attr('dataType');
        var _this=$(this)
        layer.confirm('确定标记为已阅读吗？', {
            btn: ['确定','取消'], //按钮
            title:"一键阅读"
        }, function(){
            $.ajax({
                type:'post',
                url:'/todoList/readHaveList',
                dataType:'json',
                data:{
                    classification:modelType,
                    userId:$.cookie('userId')
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('已全阅成功！', { icon:6});
                        listTable();
                    }else{
                        layer.msg('已全阅失败！', { icon:6});
                    }

                }
            })
            //判断是计划系统
            if(_this.attr('datatype')=='planManage'){
                var $planManage=_this.parent('.search_one_all').next('.search_two_all').find('li')
                var bodyIds=''
                $planManage.each(function (i,v) {
                    bodyIds+=$(v).attr('bodyId')+','
                })
                $.post('/sms/updateRemind', {bodyIds: bodyIds, remindFlag: '0'}, function(res){
                    if(res.flag){
                        layer.msg('已全阅成功！', { icon:6});
                        listTable();
                    }else{
                        layer.msg('已全阅失败！', { icon:6});
                    }
                })
            }

        }, function(){
            layer.closeAll();
        });
    })


    $('.oneKeyRead').mouseover(function () {
        $(this).attr('src','/img/main_img/icon_read.png');
    })
    $('.oneKeyRead').mouseout(function () {
        $(this).attr('src','/img/main_img/icon_unread.png');
    })
})
