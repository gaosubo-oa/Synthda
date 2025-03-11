//控制事务提醒音乐
var music;
var getUserThemeJson;
$.ajax({
    type: "post",
    url: "/users/getUserTheme",
    dataType: 'json',
    data: "",
    async:false,
    success: function (obj) {
        getUserThemeJson = obj;
        if(obj.object.callSound=='1'||obj.object.callSound==''){
            music = 1
        }else{
            music = 0
        }
    }
});
//右侧待办消息、主题切换
function themeFunc(type,e){
    $('.side_all').css('display','block')
    var dom = $(".layui-layer-shade");
    dom && dom.remove();
        $('body').append('<div class="layui-layer-shade" onclick="shadeFun($(this),'+ type +')" id="layui-layer-shade100000" times="100000" style="z-index: 19991016; background-color: rgb(0, 0, 0); opacity: 0.1;"></div>');

    if($('#admin-side'+type).width() != 300){
        $('#admin-side'+type).css({"overflow":"auto"});
        $('#admin-side'+type).animate({width: "300px"}).siblings().width(0);
    }else{
        $('#admin-side'+type).animate({width: "0px"});
    }
    if(type == 1){
        $('.layui-badge-dot').hide();
    }else if(type == 3){
        e.find('.layuiMore').addClass('layuiMored');
    }else if(type == 0){
        //搜索的接口
        var text = $('.layui-input-search').val();
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
                    str+='<li style="height:60px;"><a href="/sys/userDetails?uid='+data[i].uid+'" target="_blank">' +
                        '<div class="custom-two-left">' +
                        '<img onerror="imgerror(this,1)" style="width: 50px;border-radius: 50%;margin-top: 10px!important;margin-left: 1px" src="'+function () {

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
                        '<div class="custom-two-mid" style="margin-left: 31px">' +
                        '<h2 style="font-size: 15px;width: 300px;margin-top: 10px;">姓名：'+data[i].userName+'</h2>' +
                        '<span style="display: inline-block; width: 300px; font-size: 15px;color: #0088cc;" class="priv_name">角色：'+data[i].userPrivName+'</span>' +
                        '<h2 style="font-size: 15px;">电话：<span>'+ function(){
                            if(data[i].mobilNo != undefined){
                                return data[i].mobilNo
                            }else{
                                return ''
                            }
                        }()+'</span>' +
                        '</h2>' +
                        '</div>' +
                        '<div class="custom-two-right" style="width: auto">' +
                        '</div>' +
                        '</a></li>'//<div class="two-right-all"><img src="/img/main_img/cus_email.png" alt=""><h1>邮件</h1></div>
                }

                $('#admin-side0 .search_custom .custom_two').html(str);
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
                        var url = data[i].url;
                        if (menu[url.replace(/\//g, '_')]){
                            url = menu[url.replace(/\//g, '_')];
                        }
                        str+='<li style="cursor: pointer;height: 50px!important;" lay-href="'+url+'" menu_tid="'+data[i].id+'">' +
                            '<div class="custom-two-left">' +
                            '<img style="width: 25px;height: 25px;margin-top: 13px!important;" src="/img/menu/'+name1+'.png" alt=""></div>' +
                            '<div class="custom-two-mid" style="height:59%;"><h1 style="line-height: 50px!important;white-space: nowrap;">'+data[i].name+'</h1></div>' +
                            '<div class="custom-two-right"></div></li>'//<div class="two-right-all"><img src="/img/main_img/cus_email.png" alt=""><h1>邮件</h1></div>

                    }
                }
                $('#admin-side0 .search_apply .custom_two').html(str);
            }
        });
    }

}
//隐藏弹出层
function shadeFun(e,type){
    e.hide();
    $('#admin-side'+type).css({"overflow":"hidden"});
    $('#admin-side'+type).animate({width: "0px"});
    if(type == 3){
        $('.layuiMore').removeClass('layuiMored');
    }
}
//待办各模块消息显示
function listTable(fn,type) {
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

            //即会通视频会议
            var jhtmeeting = json.data.jhtmeeting||'';
            var jhtmeetingStr = '';

            var carApproval = json.data.cheliang || '';
            var carApprovalStr = '';

            var hstMeetingObj=json.data.hstMeeting
            var hstMeetingStr=''

            var wagesManager=json.data.wagesManager;
            var wagesManager1=''
            var worksalary=''

            var attendanceManager=json.data.attendanceManager;
            var attendanceManager1=''
            var attendance1=''
            var assetObj=json.data.asset
            var assetStr=''
            //速卓审批
            var rapidZhuoObj = json.data.rapidZhuo||'';
            var rapidZhuoStr = '';

            //资格证书管理
            var crmcertificate = json.data.crmcertificate||'';
            var crmcertificateStr = '';

            var bbscommentObj = json.data.bbscomment || '';
            var bbscommentStr=''

            var contractremindObj = json.data.contractremind || '';
            var contractremindStr='';

            var institutioncontentObj = json.data.institutioncontent || '';
            var institutioncontentStr='';

            var crashDispAtch = json.data.crashDispAtch

            var passwordManager=json.data.passwordManager||'';
            var passwordManagerStr='';

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

            //证照
            var licensemenObj=json.data.hrStaffLicense||'';
            var licensemenStr='';

            //EHR待办工作提醒
            var ehrAgencyObj=json.data.ehrAgency||'';
            var ehrAgencyStr='';

            $('.loadAnimate').hide();
            if(zhibanObj.length==0&&thirdSystem.length==0&&dispatcher.length==0&&crashDispAtch.length==0&&bbsBoard.length==0&&addPlanApproval.length==0&&
                email.length==0&&emailPlus.length==0&&notify.length==0&&workFlow.length==0&&news.length==0&&documentObj.length==0&&toupiao.length==0&&
                supervisionsObj.length==0&&meetingObj.length==0&&richengObj.length==0&&rizhiObj.length==0&&leaderObj.length==0&&publicObj.length==0&&
                netDiskObj.length==0&&bangongObj.length==0&&taskManage.length==0&&carApproval.length==0&&hstMeetingObj.length==0&&bbscommentObj.length==0&&
                assetObj.length==0&&rapidZhuoObj.length==0&&contractremindObj.length==0 && institutioncontentObj.length==0&&dutypoliceusersObj.length==0&&onlineReimbursementSystemObj.length==0&&
                planManageObj.length==0&&licensemenObj.length==0 && passwordManager.length == 0 &&ehrAgencyObj.length==0&&wagesManager.length==0&&attendanceManager.length==0&&assessments.length==0){
                $('#tixing_tab_c .search-cont-cus').hide();
                $('.noReminding').show();
            }else{
                $('#tixing_tab_c .search-cont-cus').show();
                $('.noReminding').hide();
            }

            $('#docunmentSeasethree').html(documentObj.length);
            if(documentObj.length==0){
                $('#documentToDoObj').hide()
            }else {
                for(var i=0;i<documentObj.length;i++){
                    documentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="2" data-url="'+documentObj[i].remindUrl+'">' +
                        '<img  style="vertical-align: middle" src="'+documentObj[i].img+'" alt="">' +
                        '<span  class="windowopen" data-id="'+documentObj[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+documentObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                            if(documentObj[i].type=='doctment'){
                                return documentObj[i].content;
                            }else {
                                return documentObj[i].content;
                            }
                        }()+'</span>' +
                        '<span><label style="margin-right: 1em;width: 70px;" title="'+documentObj[i].userName+'">'+documentObj[i].userName+'</label>' +
                        '<label style="color: #999;" title="'+documentObj[i].sendTimeStr+'">'+function(){
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
            }
//工作薪资提醒
            for (var i = 0; i < wagesManager.length; i++) {
                worksalary+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+wagesManager[i].bodyId+'" data-s="200" data-url="'+wagesManager[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+wagesManager[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;;margin-top: 5px" title="'+wagesManager[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(wagesManager[i].type=='wagesManager'){
                            return wagesManager[i].content
                        }else {
                            return wagesManager[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+wagesManager[i].userName+'">'+wagesManager[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+wagesManager[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+attendanceManager[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(attendanceManager[i].type=='attendanceManager'){
                            return attendanceManager[i].content
                        }else {
                            return attendanceManager[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+attendanceManager[i].userName+'">'+attendanceManager[i].userName+'</label>' +
                    '<label style="color: #999" title="'+attendanceManager[i].sendTimeStr+'">'+function(){
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
            //人员调度
            for (var i = 0; i < dispatcher.length; i++) {
                dispatcherStr += '<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="' + dispatcher[i].remindUrl + '">' +
                    '<img style="vertical-align: middle" src="' + dispatcher[i].img + '" alt="">' +
                    '<span  class="windowopen" data-id="'+dispatcher[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+dispatcher[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(dispatcher[i].type=='dispatcher'){
                            return dispatcher[i].content
                        }else {
                            return dispatcher[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+dispatcher[i].userName+'">'+dispatcher[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+dispatcher[i].sendTimeStr+'">'+function(){
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
                $('.read_17').attr('dataType',dispatcher[0].type);
                $('#dispatcher').show();
            }

            //第三方系统
            for (var i = 0; i < thirdSystem.length; i++) {
                thirdSystemStr += '<li bodyId="'+thirdSystem[i].bodyId+'" onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="200"  data-url="' + thirdSystem[i].remindUrl + '">' +
                    '<img style="vertical-align: middle" src="' + thirdSystem[i].img + '" alt="">' +
                    '<span  class="windowopen" data-id="'+thirdSystem[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+thirdSystem[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(thirdSystem[i].type=='thirdSystem'){
                            return thirdSystem[i].content
                        }else {
                            return thirdSystem[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+thirdSystem[i].userName+'">'+thirdSystem[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+thirdSystem[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="'+addPlanApproval[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+addPlanApproval[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(addPlanApproval[i].type=='addPlanApproval'){
                            return addPlanApproval[i].content
                        }else {
                            return addPlanApproval[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+addPlanApproval[i].userName+'">'+addPlanApproval[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+addPlanApproval[i].sendTimeStr+'">'+function(){
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
                emaileStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="'+email[i].remindUrl+'&bodyId='+email[i].bodyId+'">' +
                    '<img  style="vertical-align: middle;" src="'+email[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+email[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+email[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(email[i].type=='willdo'){
                            return email[i].content
                        }else {
                            return email[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+email[i].userName+'">'+email[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+email[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="'+emailPlus[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+emailPlus[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(emailPlus[i].type=='willdo'){
                            return emailPlus[i].content
                        }else {
                            return emailPlus[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+emailPlus[i].userName+'">'+emailPlus[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+emailPlus[i].sendTimeStr+'">'+function(){
                        if(emailPlus[i].type=='willdo'){
                            return emailPlus[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return emailPlus[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
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
                    '<span  class="windowopen" data-id="'+bbsBoard[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+bbsBoard[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(bbsBoard[i].type=='willdo'){
                            return bbsBoard[i].content
                        }else {
                            return bbsBoard[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+bbsBoard[i].userName+'">'+bbsBoard[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+bbsBoard[i].sendTimeStr+'">'+function(){
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
                    '<span class="windowopen" data-id="'+notify[n].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+notify[n].content+'"><b style="font-size: 14px;font-weight: bold;">标题：</b> '+function(){
                        if(notify[n].type=='willdo'){
                            return notify[n].content
                        }else {
                            return notify[n].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+notify[n].userName+'">'+notify[n].userName+'</label>' +
                    '<label style="color: #999;" title="'+notify[n].sendTimeStr+'">'+function(){
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
                newsStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)"  dataUrl="'+news[i].remindUrl+'" data-s="4" data-new="'+news[i].qid+'">'+
                    '<img  style="vertical-align: middle;" src="/img/main_img/theme3/xinwentishi.png" alt="">' +
                    '<span  class="windowopen" data-id="'+news[i].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+news[i].content+'"><b style="font-size: 14px;font-weight: bold;">标题：</b> '+function(){
                        if(news[i].type=='willdo'){
                            return news[i].content
                        }else {
                            return news[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+news[i].userName+'">'+news[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+news[i].sendTimeStr+'">'+function(){
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
                workFlowStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="2" data-url="'+workFlow[m].remindUrl+'">' +
                    '<img style="vertical-align: middle;" src="'+workFlow[m].img+'" alt="">' +
                    '<span class="windowopen" data-id="'+workFlow[m].uid+'" style="vertical-align: middle;margin-top: 5px" title="'+workFlow[m].content+'"><b style="font-size: 14px;font-weight: bold;">标题：</b> '+function(){
                        if(workFlow[m].type=='willdo'){
                            return workFlow[m].content
                        }else {
                            return workFlow[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+workFlow[m].userName+'">'+workFlow[m].userName+'</label>' +
                    '<label style="color: #999;" title="'+workFlow[m].sendTimeStr+'">'+function(){
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

            //投票代办查询
            for(var m=0;m<toupiao.length;m++){
                toupiaos+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="11" data-url="'+toupiao[m].remindUrl+'">' +
                    '<img style="vertical-align: middle" src="'+toupiao[m].img+'" alt="">' +
                    '<span class="windowopen" data-id="'+toupiao[m].qid+'" style="vertical-align: middle;margin-top: 5px" title="'+toupiao[m].content+'"><b style="font-size: 14px;font-weight: bold;">标题：</b> '+function(){
                        if(toupiao[m].type=='toupiao'){
                            return toupiao[m].content
                        }else {
                            return toupiao[m].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+toupiao[m].userName+'">'+toupiao[m].userName+'</label>' +
                    '<label style="color: #999;" title="'+toupiao[m].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+supervisionsObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(supervisionsObj[i].type=='supervisions'){
                            return supervisionsObj[i].content
                        }else {
                            return supervisionsObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+supervisionsObj[i].userName+'">'+supervisionsObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+supervisionsObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+meetingObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(meetingObj[i].type=='meeting'){
                            return meetingObj[i].content
                        }else {
                            return meetingObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+meetingObj[i].userName+'">'+meetingObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+meetingObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+richengObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(richengObj[i].type=='calendars'){
                            return richengObj[i].content
                        }else {
                            return richengObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+richengObj[i].userName+'">'+richengObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+richengObj[i].sendTimeStr+'">'+function(){
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
                rizhiStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)"  data-s="16" data-url="'+rizhiObj[i].remindUrl+'&bodyId='+rizhiObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle;" src="'+rizhiObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+rizhiObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(rizhiObj[i].type=='diarys'){
                            return rizhiObj[i].content
                        }else {
                            return rizhiObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+rizhiObj[i].userName+'">'+rizhiObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+rizhiObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+leaderObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(leaderObj[i].type=='schedules'){
                            return leaderObj[i].content
                        }else {
                            return leaderObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+leaderObj[i].userName+'">'+leaderObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+leaderObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+publicObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(publicObj[i].type=='publicFiles'){
                            return publicObj[i].content
                        }else {
                            return publicObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+publicObj[i].userName+'">'+publicObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+publicObj[i].sendTimeStr+'">'+function(){
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
            //即会通视频会议事务提醒
            for(var i=0;i<jhtmeeting.length;i++){
                var url=jhtmeeting[i].remindUrl+'?bodyId='+jhtmeeting[i].bodyId
                jhtmeetingStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="15" data-url="'+url+'">' +
                    '<img  style="vertical-align: middle" src="'+jhtmeeting[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+jhtmeeting[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(jhtmeeting[i].type=='hstmeeting'){
                            return jhtmeeting[i].content
                        }else {
                            return jhtmeeting[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+jhtmeeting[i].userName+'">'+jhtmeeting[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+jhtmeeting[i].sendTimeStr+'">'+function(){
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
            // 任务管理提醒
            for (var i = 0; i < taskManage.length; i++) {
                taskManageStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="24" data-url="'+taskManage[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+taskManage[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+taskManage[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(taskManage[i].type=='taskManage'){
                            return taskManage[i].content
                        }else {
                            return taskManage[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+taskManage[i].userName+'">'+taskManage[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+taskManage[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+carApproval[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(carApproval[i].type=='carApproval'){
                            return carApproval[i].content
                        }else {
                            return carApproval[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+carApproval[i].userName+'">'+carApproval[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+carApproval[i].sendTimeStr+'">'+function(){
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
                $('#carApproval').hide();
            }else{
                $('.read_25').attr('dataType',carApproval[0].type);
                $('#carApproval').show();
            }

            //网络硬盘
            for(var i=0;i<netDiskObj.length;i++){
                netDiskStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="18" data-url="'+netDiskObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle;" src="'+netDiskObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+netDiskObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(netDiskObj[i].type=='netDisk'){
                            return netDiskObj[i].content
                        }else {
                            return netDiskObj[i].content
                        }
                    }()+'</span >' +
                    '<span style="display: flex"><label  title="'+netDiskObj[i].userName+'">'+netDiskObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+netDiskObj[i].sendTimeStr+'">'+function(){
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
                zhibanStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="1"  data-url="'+zhibanObj[i].remindUrl+'&bodyId='+zhibanObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+zhibanObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="'+zhibanObj[i].qid+'" style="vertical-align: middle;margin-top: 5px"><b style="font-size: 14px;font-weight: bold;">主题：'+zhibanObj[i].content+'</b>'
                    +'</span>' +
                    '<label style="color: #999;" title="'+zhibanObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+bangongObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(bangongObj[i].type=='supervisions'){
                            return bangongObj[i].content
                        }else {
                            return bangongObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+bangongObj[i].userName+'">'+bangongObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+bangongObj[i].sendTimeStr+'">'+function(){
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
                hstMeetingStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="15" data-url="'+hstMeetingObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+hstMeetingObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+hstMeetingObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(hstMeetingObj[i].type=='hstmeeting'){
                            return hstMeetingObj[i].content
                        }else {
                            return hstMeetingObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+hstMeetingObj[i].userName+'">'+hstMeetingObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+hstMeetingObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+crmcertificate[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(crmcertificate[i].type=='crmcertificate'){
                            return crmcertificate[i].content
                        }else {
                            return crmcertificate[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+crmcertificate[i].userName+'">'+crmcertificate[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+crmcertificate[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+assetObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(assetObj[i].type=='hstmeeting'){
                            return assetObj[i].content
                        }else {
                            return assetObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+assetObj[i].userName+'">'+assetObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+assetObj[i].sendTimeStr+'">'+function(){
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

            //速卓审批事务提醒
            for(var i=0;i<rapidZhuoObj.length;i++){
                rapidZhuoStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="28" data-url="'+rapidZhuoObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+rapidZhuoObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+rapidZhuoObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(rapidZhuoObj[i].type=='hstmeeting'){
                            return rapidZhuoObj[i].content
                        }else {
                            return rapidZhuoObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+rapidZhuoObj[i].userName+'">'+rapidZhuoObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+rapidZhuoObj[i].sendTimeStr+'">'+function(){
                        if(rapidZhuoObj[i].type=='asset'){
                            return rapidZhuoObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return rapidZhuoObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>'
            }
            $('#suzhuoIdurl').html(rapidZhuoStr);
            $('#suzhuoId1').html(rapidZhuoObj.length);
            if(rapidZhuoObj.length == 0){
                $('#suzhuoId').hide();
            }else{
                $('.read_suzhuo').attr('dataType',rapidZhuoObj[0].type);
                $('#suzhuoId').show();
            }


            //讨论区
            for(var i=0;i<bbscommentObj.length;i++){
                bbscommentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+bbscommentObj[i].remindUrl+'&bodyId='+bbscommentObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+bbscommentObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+bbscommentObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(bbscommentObj[i].type=='calendars'){
                            return bbscommentObj[i].content
                        }else {
                            return bbscommentObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+bbscommentObj[i].userName+'">'+bbscommentObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+bbscommentObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+contractremindObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(contractremindObj[i].type=='contractremind'){
                            return contractremindObj[i].content
                        }else {
                            return contractremindObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+contractremindObj[i].userName+'">'+contractremindObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+contractremindObj[i].sendTimeStr+'">'+function(){
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
                $('.read_contract').attr('dataType',contractremindObj[0].type);
                $('#contractremind').show();
            }


            //制度管理
            for(var i=0;i<institutioncontentObj.length;i++){
                institutioncontentStr+='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="17" data-url="'+institutioncontentObj[i].remindUrl+'?bodyId='+institutioncontentObj[i].bodyId+'">' +
                    '<img  style="vertical-align: middle" src="'+institutioncontentObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+institutioncontentObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(institutioncontentObj[i].type=='institutioncontent'){
                            return institutioncontentObj[i].content
                        }else {
                            return institutioncontentObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+institutioncontentObj[i].userName+'">'+institutioncontentObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+institutioncontentObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+dutypoliceusersObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(dutypoliceusersObj[i].type=='dutypoliceusers'){
                            return dutypoliceusersObj[i].content
                        }else {
                            return dutypoliceusersObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+dutypoliceusersObj[i].userName+'">'+dutypoliceusersObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+dutypoliceusersObj[i].sendTimeStr+'">'+function(){
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

            // 中电建网报事物提醒
            for (var i = 0; i < onlineReimbursementSystemObj.length; i++) {
                onlineReimbursementSystemStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" data-s="32" data-url="'+onlineReimbursementSystemObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+onlineReimbursementSystemObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+onlineReimbursementSystemObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(onlineReimbursementSystemObj[i].smsType=='powerchina'){
                            return onlineReimbursementSystemObj[i].content
                        }else {
                            return onlineReimbursementSystemObj[i].content
                        }
                    }()+'</span>' +
                    '<span>' +
                    // '<label style="margin-right: 1em;" title="'+onlineReimbursementSystemObj[i].userName+'">'+onlineReimbursementSystemObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+onlineReimbursementSystemObj[i].sendTimeStr+'">'+function(){
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
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+planManageObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(planManageObj[i].type=='planManage'){
                            return planManageObj[i].content
                        }else {
                            return planManageObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+planManageObj[i].userName+'">'+planManageObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+planManageObj[i].sendTimeStr+'">'+function(){
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

            //证照管理实务提醒
            for (var i = 0; i < licensemenObj.length; i++) {
                licensemenStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+licensemenObj[i].bodyId+'" data-s="33" data-url="'+licensemenObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+licensemenObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+licensemenObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(licensemenObj[i].type=='planManage'){
                            return licensemenObj[i].content
                        }else {
                            return licensemenObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+licensemenObj[i].userName+'">'+licensemenObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+licensemenObj[i].sendTimeStr+'">'+function(){
                        if(licensemenObj[i].type=='planManage'){
                            return licensemenObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }else {
                            return licensemenObj[i].sendTimeStr.replace(/\s/g,'<b style="margin-left: 0.5em;"></b>')
                        }
                    }()+'</label></span>' +
                    '</li>';
            }
            $('#licenselists').html(licensemenStr);
            $('#zzgl').html(licensemenObj.length);
            if(licensemenObj.length == 0){
                $('#zhengzhao').hide();
            }else{
                $('.read_34').attr('dataType',licensemenObj[0].type);
                $('#zhengzhao').show();
            }
            //EHR待办工作提醒
            for (var i = 0; i < ehrAgencyObj.length; i++) {
                ehrAgencyStr +='<li onclick="windowOpenNew(this)" onmouseover="mOver(this)" onmouseout="mOverout(this)" bodyId="'+ehrAgencyObj[i].bodyId+'" data-s="33" data-url="'+ehrAgencyObj[i].remindUrl+'">' +
                    '<img  style="vertical-align: middle" src="'+ehrAgencyObj[i].img+'" alt="">' +
                    '<span  class="windowopen" data-id="" style="vertical-align: middle;margin-top: 5px" title="'+ehrAgencyObj[i].content+'"><b style="font-size: 14px;font-weight: bold;">主题：</b> '+function(){
                        if(ehrAgencyObj[i].type=='ehrAgency'){
                            return ehrAgencyObj[i].content
                        }else {
                            return ehrAgencyObj[i].content
                        }
                    }()+'</span>' +
                    '<span><label style="margin-right: 1em;width: 70px;" title="'+ehrAgencyObj[i].userName+'">'+ehrAgencyObj[i].userName+'</label>' +
                    '<label style="color: #999;" title="'+ehrAgencyObj[i].sendTimeStr+'">'+function(){
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
                $('.read_35').attr('dataType',ehrAgencyObj[0].type);
                $('#dbgz').show();
            }


            //投票代办、邮件互发、公文、工作流、新建讨论区、公告、新闻、邮件、督察督办等
            var he = parseInt($('#toupiao1').text()) + parseInt($('#userSeasePlus').text()) + parseInt($('#docunmentSeasethree').text()) + parseInt($('#userSeasethree').text()) +
                parseInt($('#userSeaseFive').text()) + parseInt($('#userSeaseTwo').text()) + parseInt($('#userSeasenew').text()) + parseInt($('#userSease').text()) +
                parseInt($('#duchaduban1').text()) + parseInt($('#huiyi1').text()) + parseInt($('#richeng1').text()) + parseInt($('#rizhi1').text()) + parseInt($('#leaderActiv1').text()) +
                parseInt($('#publicFile1').text()) + parseInt($('#networkDisk1').text()) + parseInt($('#zhibanS').text()) + parseInt($('#bangongyongpinshenling1').text() ) +
                parseInt($('#dispatcherS').text()) + parseInt($('#thirdSystemS').text()) + parseInt($('#tranPlan').text()) + parseInt($('#taskManagePlan').text()) +
                parseInt($('#carApprovalPlan').text()) + parseInt($('#hstMeeting1').text()) + parseInt($('#bbscommentPlan').text()) + parseInt($('#assetsId1').text()) + parseInt($('#suzhuoId1').text()) +
                parseInt($('#contractremindPlan').text()) + parseInt($('#institutioncontentPlan').text()) + parseInt($('#onDutyPlan').text()) + parseInt($('#onlineReimbursementSystemPlan').text()) +
                parseInt($('#planManagePlan').text()) + parseInt($('#ehrWork').text())+parseInt($('#wagesManager1').text());+parseInt($('#attendanceManager1').text());
            if(he == 0){
                $('.layui-badge-dot').hide();
            }else {
                $('.layui-badge-dot').show();
            }
            if(he > $he){
                //控制事务提醒音乐
                if(music == 1){
                    try{
                        as[0].element.play();
                    }catch(e){
                        console.log('事物提醒音乐执行!')
                    }
                }
                $('.layui-badge-dot').show();
            }else{
                if(type != 2){
                    $('.layui-badge-dot').hide();
                }
            }
            $he = he;
            if(typeof fn=='function'){
                fn()
            }
        }

    },'json')
}
//刷新我的门户最新消息
function reloads(fn){
    if($('#LAY_app_tabsheader .layui-this').attr('lay-id').indexOf('/common/myOA2') > -1){
        $('#LAY_app_body .layui-show').find('iframe').attr('src', '/common/myOA2');
    }
    if(typeof fn=='function'){
        fn()
    }
}

function mOver(me) {
    $(me).attr('class','hover');
}
function mOverout(me) {
    $(me).removeAttr('class','hover');
}
//待办各模块消息打开
function windowOpenNew(me) {
    if ($(me).attr('data-s') == 2) {
        var objGet = $(me).attr('data-url');
        if (objGet.indexOf('runId') > 0) {
            var runId = objGet.split('&runId=')[1].split('&prcsId=')[0];
            // var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
            //针对工作查询传阅时，prcsId为undefined时，对prcsId做特殊处理
            if (objGet.split('&prcsId=')[1] == undefined) {
                var prcsId = '0'
            } else {
                var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
            }
            if ($(me).parents('.custom_two').attr('id') == 'documentToDoList') {
                $.get('/ToBeReadController/querySmsIsRead', {runId: runId, prcsId: prcsId}, function (data) {
                    $.popWindow(objGet);
                }, 'json')
            } else {
                $.popWindow(objGet);
            }
        } else {
            window.open(objGet)
        }

    } else if ($(me).attr('data-s') == 3) {
        window.open('/notice/detail?notifyId=' + $(me).attr('data-qid'))
    } else if ($(me).attr('data-s') == 4) {
        // window.open('/news/detail?newsId=' + $(me).attr('data-new'))
        window.open($(me).attr('dataUrl'))
    } else if ($(me).attr('data-s') == 5) {
        var rl = $(me).attr('data-url')
        $.popWindow(rl, '公告详情', '20', '150', '1200px', '600px')
    } else if ($(me).attr('data-s') == 200) {
        var bodyId = $(me).attr('bodyId')
        $.ajax({
            type: "post",
            url: "/sms/setRead",
            dataType: 'JSON',
            data: {"bodyId": bodyId},
            success: function () {
                window.open($(me).attr('data-url'))
            }
        });
    } else if ($(me).attr('data-s') == 18) {
        window.open(encodeURI($(me).attr('data-url')))
    } else {
        window.open($(me).attr('data-url'))
    }
    if ($(me).parent().parent().prev().find('.custom_num') != undefined) {
        var todoNum = $(me).parent().parent().prev().find('.custom_num').text();
        $(me).parent().parent().prev().find('.custom_num').text(--todoNum)
    }
    var type1 = $(me).attr("type1");
    if (type1 == undefined || type1 != "daiban") {
        $(me).remove();
    }
}
//左上角操作框-菜单模块点击事件
function menuItem(e){
    var id = e.attr('data-id')||'';
    var name = e.attr('title')||'门户';
    $('.menuName').html(name);
    $('.menubox').attr('title',name);
    if(!$('a[data-id='+ id +']').parent().hasClass('layui-nav-itemed')){
        $('a[data-id='+ id +']').click();
    }
    $('a[data-id='+ id +']').parent().show().siblings().hide();
    $('.myMenuBox').hide();
}
//左上角操作框-常用菜单点击事件
function common() {
    $('#LAY-system-side-menu .layui-nav-item').hide();
    $('.common').show()
}
//左上角操作框-门户点击事件
function menuHome(e){
    var name = e.attr('title')||'门户';
    $('.menuName').html(name);
    $('.menubox').attr('title',name);
    if(e.attr('data-id') == 'all'){
        $('li[data-name=home]').hide();
        $('.menuLite').show();

    }else{
        $('li[data-name=home]').hide();
        $('.menuLi').show();
        $('.menuLi').eq(0).find('a').click();

    }
    $('.myMenuBox').hide();
}
function getMenuOpen(e,type){
    var id = $(e).attr('tid')|| $(e).attr('menu_tid')||'';
    if(type == 2){
        var knowid = $(e).attr('data-id');
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').attr('lay-href','newFilePub/fileCabinetHome?'+knowid).text('公共文件');
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').click();
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').attr('lay-href','newFilePub/fileCabinetHome').text('公共文件柜');
    }else if(type == 3){
        var knowid = $(e).attr('data-id');
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').attr('lay-href','newFilePub/fileCabinetHome?search='+knowid).text('最新文件');
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').click();
        $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').attr('lay-href','newFilePub/fileCabinetHome').text('公共文件柜');
    }else{
        if(id == '3010'){
            var knowid = $(e).attr('data-id');
            $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').attr('lay-href','netdiskSettings/networkHardDisk?'+knowid);
            $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').click();
        }else{
            $('#LAY-system-side-menu .hrefmenu[data-id='+ id +']').click();
        }
    }
}
function getUrlMenuOpen(tid,element){
    var url = element.attr('url')||'';
    if($('#LAY-system-side-menu .hrefmenu[data-id='+ tid +']').length == 0){
        $('#LAY-system-side-menu .hrefmenu[lay-href='+ url +']').click();
    }else{
        $('#LAY-system-side-menu .hrefmenu[data-id='+ tid +']').click();
    }

}
function locationReload() {
    location.reload()
}
var $he = 0;
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
                },2)
                reloads((function () {
                    me.status=true;
                }));
            }
        },600000)
    }
};
$(function(){
    //点击返回按钮，右边内容收回开始
    $('.position').on('click', '#go_back', function () {
        $(this).parents('.position').animate({width: "0px"});
    });
    //点击返回按钮，右边内容收回结束

    //点击待办消息，刷新按钮开始
    $('.reloadSide').on('click', function () {
        $('.loadAnimate').show().siblings().hide();
        listTable()
    });
    //点击待办消息，刷新按钮结束

    //首页右侧提醒页面里的功能开始
    $('.search_one_all').on('click',function(){
        if($(this).siblings('.search_two_all').css('display')=='none'){
            $(this).siblings('.search_two_all').show();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_open.png');
        }else{
            $(this).siblings('.search_two_all').hide();
            $(this).find('.custom_close').attr('src','/img/main_img/cus_close.png');
        }
    });
    //            点击一键阅读
    $('.oneKeyRead').on('click', function (ev) {
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

    $('.oneKeyRead').on('mouseover', function () {
        $(this).attr('src','/img/main_img/icon_read.png');
    })
    $('.oneKeyRead').on('mouseout', function () {
        $(this).attr('src','/img/main_img/icon_unread.png');
    })

    //注销文字的标题的接口
    $.ajax({
        url: '/sys/getIndexInfo',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            if (obj.flag == true) {
                zhuxiao = obj.object.logOutText;

            }
        }
    });
    //首页右侧提醒页面里的功能结束
    $('.per_zhuxiao').on('click', function () {
        $(".layui-layer-shade").trigger("click");
        $.layerConfirm({
            title: '<fmt:message code="main.cancellation" />',
            content: zhuxiao,
            icon: 0
        }, function () {
            var href = '/';
            $.ajax({
                url: 'logOut',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag == true) {
                        location.href = href;
                    }
                }
            });
        });

    });

    $('.per_suoding ').on('click', function () {
        $(this).next().show();
        $(this).next().find('input').val('')
    });
    $(document).on('keyup', function (e) {
        if (e.keyCode == 13&&!$('#fixedBody').is(':hidden')) {
            $('#theLock').click()
        }
    })
    $('#LockCode').on('click', function (e) {
        var element = document.documentElement;
        if ($('[name="lockCode"]').val() == '') {
            $.layerMsg({content: mainlockempty+'！', icon: 2});
            return
        }
        $('#layui-layer-shade100000').click();
        $.cookie('lockCode', $('[name="lockCode"]').val())
        if(!$('.fullbody').hasClass('full-screen')) {
            $('.fullbody').addClass('full-screen');
            // 判断浏览器设备类型
            if(element.requestFullscreen) {
                element.requestFullscreen();
            } else if (element.mozRequestFullScreen){	// 兼容火狐
                element.mozRequestFullScreen();
            } else if(element.webkitRequestFullscreen) {	// 兼容谷歌
                element.webkitRequestFullscreen();
            } else if (element.msRequestFullscreen) {	// 兼容IE
                element.msRequestFullscreen();
            }
        }
        if ($('.yonghu_touxiang').prop('src').indexOf('boy.png') != -1) {
            $('.personSrc').attr('src','/img/main_img/nantouxiang.png')
        } else if ($('.yonghu_touxiang').prop('src').indexOf('girl.png') != -1) {
            $('.personSrc').attr('src','/img/main_img/nvtouxiang.png')
        } else {
            $('.personSrc').attr('src',$('.yonghu_touxiang').prop('src'))
        }
        $.cookie('personSrc',$('.personSrc').attr('src'))
        $('.wybzd').text($('.juede_suoping').text())
        $('.posifixedCenter').find('input[type="password"]').val('')
        $('.posifixed').show()
        document.onkeydown = function (e) {
            var ev = window.event || e;
            var code = ev.keyCode || ev.which;
            //
            if (code == 116) {
                if (ev.preventDefault) {
                    ev.preventDefault();
                } else {
                    ev.keyCode = 0;
                    ev.returnValue = false;
                }
            }
        }
        document.oncontextmenu = function () {
            return false;
        }
    })

    $(document).on('click', '#theLock', function () {
        if ($(this).prev().val() == $.cookie('lockCode')) {
            $.layerMsg({content: mainlockUnlockSuccessfully+'!', icon: 1}, function () {
                $('.posifixed').hide();
                $('#LockCode').parent().hide()
                $.cookie('lockCode', '')
                document.onkeydown = function (e) {
                    return true
                }
                if(document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.webkitCancelFullScreen) {
                    document.webkitCancelFullScreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                }
            });

        } else {
            $.layerMsg({content: mainlockPasswordError+'！', icon: 2});

        }
    });

})
