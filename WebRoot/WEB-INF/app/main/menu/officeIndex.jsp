    <%--
      Created by IntelliJ IDEA.
      User: zhangyuan
      Date: 2020-04-09
      Time: 9:50
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>办公门户</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <%--<meta http-equiv="refresh" content="60">--%>
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
        <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script src="/js/jquery/jquery.cookie.js"></script>
        <script src="/js/HSTmeeting/base64.js" type="text/javascript"></script>
        <script src="/js/HSTmeeting/entermeeting.js?sid=2b2f9c37241432a91dc2f9343f5e4053" type="text/javascript"></script>
        <script src="../js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
        <style>
        html , body{
            height: 100%;
            font-family: "Microsoft Yahei" !important;
        }
        body{
        background: #F6F7F7;
        color: #666;
        }
        .top , .bottom{
        overflow: hidden;
        }
        .topLeft , .topRight , .bottomLeft , .bottomRight{
        width:50%;
        background: white;
        float: left;
        box-sizing: border-box;
        }
        .topLeft{
        border-top: 1px solid #0588c7;
        border-left: 1px solid #0588c7;
        }
        .topRight{
        border-top: 1px solid #0588c7;
        border-left: 1px solid #0588c7;
        border-right: 1px solid #0588c7;
        }
        .bottomLeft{
        border-top: 1px solid #0588c7;
        border-left: 1px solid #0588c7;
        border-bottom: 1px solid #0588c7;
        }
        .bottomRight{
        border-top: 1px solid #0588c7;
        border-left: 1px solid #0588c7;
        border-bottom: 1px solid #0588c7;
        border-right: 1px solid #0588c7;
        }
        .title{
        /*background: #51b9ec;*/
        background: #4aa7e2;
        padding: 5px 17px;
        font-size: 14px;
        /*font-weight: 700;*/
        position: relative;
        color: white;
        }
        li{
        /*list-style: disc;*/
        margin: 8px 30px 8px 10px;
        font-size: 9pt;
        position: relative;
        }
        li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        ul{
        overflow-y: auto;
        }
        .noData{
        position: relative;
        top: 50%;
        transform: translateY(-50%);
        }
        .more , .weidu ,.yidu ,.daiban , .yiban ,.huiyi,.shenpi,.news_doAuditing{
        position: absolute;
        top: 8px;
        font-size: 13px;
        cursor: pointer;
        font-weight: inherit;
        width: 50px;
        }
        .daiban , .yiban{
        top: 6px;
        }
        .bottom .more{
        top: 6px;
        }
        .more{
        right: -4px;
        }
        .weidu, .daiban{
        right: 130px;
        text-align: center;
        }
        .yidu,.yiban{
        right: 66px;
        width: 50px;
        text-align: center;
        }
        .huiyi{
        right: 190px;
        text-align: center;
        }
            .shenpi {
            display: none;
            right: 260px;
    text-align: center;
            }
            .news_doAuditing{
            display: none;
            right: 200px;
    text-align: center;
            }
        .activeShow{
        background: white;
        color: #000;
        width: 50px;
        text-align: center;
        border-radius: 5px;
        }
        .dateShow{
        float: right;
        }
        .cover_scroll {
        position: absolute;
        top: 0;
        right: 0px;
        height: 100%;
        width: 25px;
        z-index: 1;
        background-color: #fff;
        }
        .selectTy {
        width: 18%;
        height: 20px;
        font-size: 7.5pt;
        margin: 1px 5px;
        }
        .ellipsis{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 78%;
        display: inline-block;
        }
        .daibanNum, .daibanNumJ,.shenpiNumJ,.news_doAuditingNum{
        position: absolute;
        top: -7px;
        right: -10px;
        background: #ff3816;
        color: #fff;
        border-radius: 100%;
        padding: 3px;
        /*opacity: 0.9;*/
        height: 11px;
        width: 11px;
        display: none;
        font-size: 9px;
        line-height: 11px;
        }
        .circle{
        display: inline-block;
        background: #666666;
        width: 4px;
        height: 4px;
        border-radius: 100%;
        margin-right: 5px;
        margin-bottom: 4px;
        }
            .oneKeyRead{
                position: absolute;
            top: -5px;
            right: -7px;
            }
        </style>
        </head>
        <body>
        <iframe id="myiframe" name="myiframe" style="display:none;" src=""></iframe>
        <div class="office" style="padding:0px  8px;height: 100%;">
        <%--上面--%>
        <div class="top">
        <div class="topLeft">
        <div class="title">
        <span>新闻</span>
        <select name="newTypes" class="selectTy"></select>
            <div class="news_doAuditing isRead" onclick="parent.getMenuOpen(this)" tid="2015" url="/news/doAuditing"><h2 style="display: none">新闻审核</h2><div style="position: relative"><span>审批</span><div class="news_doAuditingNum"></div></div></div>
        <div class="weidu activeShow isRead" read="noRead" data-bool="" onclick="administrivia(this)"><div style="position: relative"><span>未读</span><img new="true" class="oneKeyRead" src="/img/main_img/zdj_icon_read.png" title="一键阅读" ></div></div>
        <div class="yidu isRead" read="okRead" data-bool="" onclick="administrivias(this)" >已读</div>
        <span class="more" onclick="parent.getMenuOpen(this)" tid="0117" more_type="1" url="news/index">更多<h2 style="display: none">新闻</h2></span>
        </div>
        <div class="content" style="position: relative">
        <div class="cover_scroll"></div>
        <ul class="new"></ul>
        </div>
        </div>
        <div class="topRight">
        <div class="title">
        <span>通知公告</span>
        <select name="noticeTypes" class="selectTy"></select>
            <div class="shenpi isRead" onclick="parent.getMenuOpen(this)" tid="2008" url="/notice/appprove"><h2 style="display: none">公告通知审批</h2><div style="position: relative"><span>审批</span><div class="shenpiNumJ"></div></div></div>
        <div class="huiyi  isRead"  onclick="huiyiShow()">会议</div>
        <div class="weidu activeShow isRead" read="noRead" data-bool="" onclick="announcement(this)"><div style="position: relative"><span>未读</span><img notice="true" class="oneKeyRead" src="/img/main_img/zdj_icon_read.png" title="一键阅读" ></div></div>
        <div class="yidu isRead" read="okRead" data-bool="" onclick="announcements(this)">已读</div>
        <span class="more"  onclick="parent.getMenuOpen(this)" tid="0116" url="/notice/allNotifications" >更多<h2 style="display: none">通知公告</h2></span>
        </div>
        <div class="content" style="position: relative">
        <div class="cover_scroll"></div>
        <ul class="notice"></ul>
        </div>
        </div>
        </div>
        <%--下面--%>
        <div class="bottom">
        <div class="bottomLeft">
        <div class="title"><span>业务审批</span>
        <div class="yiban isBan" style="right:195px"  onclick="annount(this,1)" ><div style="position: relative"><span>经/交办</span><div class="daibanNumJ"></div></div></div>
        <div class="daiban activeShow isBan" ban="noBan" onclick="annount(this)" ><div style="position: relative"><span>待办</span><div class="daibanNum"></div></div></div>
        <div class="yiban isBan" ban="okBan" onclick="announts(this)" >已办</div>
        <span class="more"  onclick="parent.getMenuOpen(this)" tid="1020" url="/workflow/work/workList" >更多<h2 style="display: none">业务审批</h2></span>
        </div>
        <div class="content" style="position: relative">
        <div class="cover_scroll"></div>
        <ul class="work"></ul>
        </div>
        </div>
        <div class="bottomRight">
        <div class="title"><span>公文管理</span>
        <div class="yiban isBan"  style="right:195px"   onclick="amange(this,1)" ><div style="position: relative"><span>经/交办</span><div class="daibanNumJ"></div></div></div>
        <div class="daiban activeShow isBan" ban="noBan" onclick="amange(this)"><div style="position: relative"><span>待办</span><div class="daibanNum"></div></div></div>
        <div class="yiban isBan" ban="okBan" onclick="amanges(this)" >已办</div>
        <span class="more" id="documentTid"  onclick="parent.getMenuOpen(this)" tid="" url="/document/documentDispatchReceive">更多<h2 style="display: none">公文收发</h2></span>
        </div>
        <div class="content" style="position: relative">
        <div class="cover_scroll"></div>
        <ul class="document"></ul>
        </div>
        </div>
        </div>
        </div>
        <script>
        window.onresize=function (){
            $('ul').height($(window).height()/2-33)
        }
        //公文收发的tid
        $.get('/documentDispatchReceive',function(res) {
            $('#documentTid').attr('tid',res.data.id)
        })
            //点击一键已读按钮
            $(document).on('click','.oneKeyRead',function(event) {
                var str=''
                    //新闻
                if($(this).attr('new')){
                        if($('.new .newRead').length>0){
                    $('.new .newRead').each(function() {
                    str+=$(this).attr('newsid')+','
                    })
                    $.get('/news/readNews',{newsIds:str},function(res) {
                    if(res.flag){
                    administrivia(this)
                    }
                    })
                 }
                }
                //公告
                else{
                    if($('.notice .noticeRead').length>0){
                    $('.notice .noticeRead').each(function() {
                    str+=$(this).attr('notifyId')+','
                    })
                    $.get('/notice/readNotify',{notifyIds:str},function(res) {
                    if(res.flag){
                    announcement(this)
                    }
                    })
                    }
                }
            })
        //定时刷新业务审批和公文管理
        setInterval(function() {
        shenPi()
        gongwen()
        },600000)
        var address
        $('ul').height($(window).height()/2-33)
        //新闻下拉框
        $.ajax({
        url: "/code/GetDropDownBox",
        type: 'get',
        dataType: "JSON",
        data: {"CodeNos": "NEWS"},
        success: function (data) {
        var str = '<option data-bool="">全部</option>';
        for (var proId in data) {
        for (var i = 0; i < data[proId].length; i++) {
        str += '<option data-bool="' + data[proId][i].codeNo + '">' + data[proId][i].codeName + '</option>'
        }
        }
        $('[name="newTypes"]').html(str);
        }
        })
        $('[name="newTypes"]').change(function () {
        if ($(this).siblings('.activeShow').find('span').html() == '未读') {
        administrivia(this)
        } else {
        administrivias(this)
        }
        })
        //新闻未读、已读切换显示
        $('.topLeft .isRead').click(function() {
            if (!$(this).hasClass('news_doAuditing')) {
                $('.topLeft .isRead').removeClass('activeShow')
        $(this).addClass('activeShow')
        }
        })
        //公告下拉框
        $.ajax({
        url: "/sys/getNotifyTypeList?CodeNos=NOTIFY",
        type: 'get',
        dataType: "JSON",
        success: function (data) {
        var arr = data.obj;
        var str = '<option data-bool="">全部</option>';
        for (var i = 0; i < arr.length; i++) {
        str += '<option data-bool="' + arr[i].codeNo + '">' + arr[i].codeName + '</option>'
        }
        $('[name="noticeTypes"]').html(str)
        }
        })
        $('[name="noticeTypes"]').change(function () {
        if ($(this).siblings('.activeShow').find('span').html() == '未读') {
        announcement(this)
        } else {
        announcements(this)
        }
        })
        //公告未读、已读切换显示
        $('.topRight .isRead').click(function() {
            if (!$(this).hasClass('shenpi')) {
                $('.topRight .isRead').removeClass('activeShow')
        $(this).addClass('activeShow')
        }
        })
        //业务审批待办、已办切换显示
        $('.bottomLeft .isBan').click(function() {
        $('.bottomLeft .isBan').removeClass('activeShow')
        $(this).addClass('activeShow')
        })
        //公文管理待办、已办切换显示
        $('.bottomRight .isBan').click(function() {
        $('.bottomRight .isBan').removeClass('activeShow')
        $(this).addClass('activeShow')
        })
        //新闻展示
        $.ajax({
        url: '/news/newsManagePlus',
        type: 'get',
        data:{
        page:'1',
        read:0,
        // pageSize:7,
        pageSize:15,
        useFlag:'true',
        typeId:'',
        },
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li class="newRemove newRead" newsId="'+data[i].newsId+'" onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="/news/detail?newsId='+data[i].newsId+'">'+'<span class="circle"></span>'+'<span class="ellipsis">'+function()
        {
        if(data[i].typeName){
        return '['+data[i].typeName+']'+data[i].subject
        }else{
        return  data[i].subject
        }
        }()+'</span>'+'<span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].newsDateTime!=undefined){
        return data[i].newsDateTime.split(/\s/g)[0];
        }else {
        return ''
        }
        }() +'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.new').html(str)
        }
        });
        //公告展示
        $.ajax({
        url: '/notice/findNotifyandMeeting',
        type: 'get',
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        // console.log(data)
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        if(data[i].url!=undefined){
        str+='<li class="'+function() {
                if(data[i].subject.substring(0,6)=='[视频会议]' || data[i].subject.substring(0,4)=='[会议]'){
                        return ''
                }else{
                        return 'noticeRemove noticeRead'
            }
            }()+'" onclick="tiaozhuan(this)" title="'+data[i].subject+'" notifyId="'+function() {
                return  data[i].url.split('=')[1]
            }()+'"  data-url="'+data[i].url+'">'+'<span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span>'+'<span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }else{
        str+='<li onclick="canHui($(this))" title="'+data[i].subject+'" meetingId="'+data[i].mps.meetingId+'" roomNo="'+data[i].mps.roomNo+'" roomPwd="'+data[i].mps.roomPwd+'" userNameString="'+data[i].mps.userNameString+'" roomAddr="'+data[i].mps.roomAddr+'">'+'<span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span>'+'<span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }

        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.notice').html(str)
        }
        });
        // 新闻-审批
            $.get('/news/approveNew', function(res){
                    if (res.flag && res.object == '0') {
                        if (res.totleNum > 0) {
                                $('.news_doAuditingNum').text(res.totleNum).show();
            } else {
                                $('.news_doAuditingNum').hide();
            }
                    $('.news_doAuditing').show();
                } else {
                            $('.news_doAuditing').hide();
            }
            })
        // 公告通知-审批
            $.get('/notice/approveNotify', function(res){
                if (res.flag && res.object == '0') {
                        if (res.totleNum > 0) {
                                $('.shenpiNumJ').text(res.totleNum).show();
            } else {
                                $('.shenpiNumJ').hide();
            }
                    $('.shenpi').show();
                } else {
                        $('.shenpi').hide();
            }
            });
        //业务审批展示
        function shenPi(){
        $.ajax({
        url: '/workflow/work/getAssignData',
        type: 'get',
        data:{
        page: 1,
        pageSize: 7,
        // useFlag: true,
        useFlag: false,
        // userId:$.cookie('userId')
        },
        dataType: 'json',
        success: function (res) {
            var str=''
            if(res.object && res.object.commonData){
            var data=res.object.commonData
            if(data.length>0){
            for(var i=0;i<data.length;i++){
            str+='<li style="'+function(){ if (data[i].timeOutFlag && data[i].timeOutFlag == '1') { return 'color: red;'; } }()+'" onclick="windowOpenNew(this)" title="'+data[i].flowRun.runName+'" daiBan="true" data-s="2"  data-url="/workflow/work/workform?opFlag='+data[i].opFlag+'&flowId='+data[i].flowRun.flowId+'&flowStep='+data[i].prcsId+'&runId='+data[i].runId+'&prcsId='+data[i].flowPrcs+'">'
            +'<span class="circle"></span>' +
            /*'<span style="position:relative;top: -3px;">'+function() {
            var type=''
            if(data[i].handleType=='1'){
            type='[主办--'+data[i].handles+']'
            }else if(data[i].handleType=='2'){
            type='[经办--'+data[i].handles+']'
            }else if(data[i].handleType=='3'){
            type='[交办--'+data[i].handles+']'
            }
            return type
            }()+'</span>'+*/
            '<span class="ellipsis" style="width: 57%;">'+data[i].flowRun.runName+'</span>'+
            '<span style=" position: absolute;'+
            ' right: 15.5%;'+
            ' top: -1px;">'+data[i].flowRun.userName+'</span>'+
            '<span class="dateShow">'+function () {
            if(data[i].createTime!=undefined){
            return data[i].createTime.split(/\s/)[0];
            }else {
            return ''
            }
            }()+'</span>'+'</li>'
            }
            }else{
            str += '<div class="noData" style="text-align: center;border: none;">' +
            '<img  src="/img/main_img/shouyekong.png" alt="">' +
            '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
            '</div>';
            }
            $('.work').html(str)
            if(res.object.commonData.length>0){
            $('.bottomLeft .daibanNum').css('display','block')
            $('.bottomLeft .daibanNum').html(res.object.commonData.length)
            }else{
            $('.bottomLeft .daibanNum').css('display','none')
            }
            if(res.object.assignData.length>0){
            $('.bottomLeft .daibanNumJ').css('display','block')
            $('.bottomLeft .daibanNumJ').html(res.object.assignData.length)
            }else{
            $('.bottomLeft .daibanNumJ').css('display','none')
            }
            }else{
            str += '<div class="noData" style="text-align: center;border: none;">' +
            '<img  src="/img/main_img/shouyekong.png" alt="">' +
            '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
            '</div>';
            $('.work').html(str)
            }
        }
        });
        }
        shenPi()
        //公文展示
        function gongwen(){
        $.ajax({
        url: '/document/getAssignDocData',
        type: 'get',
        data:{
        page:1,
        // pageSize:7,
        pageSize:66,
        // useFlag:true,
        useFlag:false,
        printDate:'',
        dispatchType:'',
        title:'',
        docStatus:'',
        flowId:'',
        documentType:''
        },
        dataType: 'json',
        success: function (res) {
        var data=res.object.commonData
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
        str+='<li style="'+function(){ if (data[i].timeOutFlag && data[i].timeOutFlag == '1') { return 'color: red;'; } }()+'" onclick="tiaozhuan(this)" title="'+function() {
        if(data[i].documentType=='0'){
        return '[发文]'+data[i].title
        }else{
        return '[收文]'+data[i].title
        }
        }()+'" daiBan="ture" data-url="'+url+'"><span class="circle"></span><span class="ellipsis">'+function() {
        if(data[i].documentType=='0'){
        return '[发文]'+data[i].title
        }else{
        return '[收文]'+data[i].title
        }
        }()+'</span><span class="dateShow">'+function () {
        if(data[i].createTime.indexOf('.') > -1){
        if(data[i].createTime.indexOf(' ') > -1){
        return data[i].createTime.split(' ')[0];
        }else{
        return data[i].createTime;
        }
        }else{
        return '';
        }
        }()+'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.document').html(str)
            if(res.object.commonData.length>0){
                $('.bottomRight .daibanNum').css('display','block')
                $('.bottomRight .daibanNum').html(res.object.commonData.length)
            }else{
                 $('.bottomRight .daibanNum').css('display','none')
            }
            if(res.object.assignData.length>0){
                $('.bottomRight .daibanNumJ').css('display','block')
                $('.bottomRight .daibanNumJ').html(res.object.assignData.length)
            }else{
                $('.bottomRight .daibanNumJ').css('display','none')
            }
        }
        });
        }
        gongwen()
        //新闻未读
        function administrivia(me) {
        var typeId=''
        if($(me).attr('read')=='noRead'){
        $(me).attr('data-bool',$(me).siblings().find('option:selected').attr('data-bool'))
        typeId=$(me).attr('data-bool')
        }else{
        typeId=$(me).find('option:selected').attr('data-bool')
        }
        $.ajax({
        url: '/news/newsManagePlus',
        type: 'get',
        data:{
        page:'1',
        read:0,
        // pageSize:'7',
        pageSize:'15',
        useFlag:'true',
        typeId:typeId,
        },
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li class="newRemove newRead" newsId="'+data[i].newsId+'" onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="/news/detail?newsId='+data[i].newsId+'"><span class="circle"></span>'+'<span class="ellipsis">'+function()
        {
        if(data[i].typeName){
        return '['+data[i].typeName+']'+data[i].subject
        }else{
        return data[i].subject
        }
        }()+'</span><span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].newsDateTime!=undefined){
        return data[i].newsDateTime.split(/\s/g)[0];
        }else {
        return ''
        }
        }() +'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.new').html(str)
        }
        });
        }
        //新闻已读
        function administrivias(me) {
        var typeId=''
        if($(me).attr('read')=='okRead'){
        $(me).attr('data-bool',$(me).siblings().find('option:selected').attr('data-bool'))
        typeId=$(me).attr('data-bool')
        }else{
        typeId=$(me).find('option:selected').attr('data-bool')
        }
        $.ajax({
        url: '/news/newsManagePlus',
        type: 'get',
        data:{
        page:'1',
        read:1,
        // pageSize:'7',
        pageSize:'15',
        useFlag:'true',
        typeId:typeId,
        },
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="/news/detail?newsId='+data[i].newsId+'"><span class="circle"></span>'+'<span class="ellipsis">'+function()
        {
        if(data[i].typeName){
        return '['+data[i].typeName+']'+data[i].subject
        }else{
        return data[i].subject
        }
        }()+'</span><span class="dateShow" >'+function () {
        if(data[i].newsDateTime!=undefined){
        return data[i].newsDateTime.split(/\s/g)[0];
        }else {
        return ''
        }
        }() +'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.new').html(str)
        }
        });
        }
        //会议显示
        function huiyiShow() {
        $('select[name="noticeTypes"]').css('visibility','hidden')
        $.ajax({
        url: '/notice/findNotifyandMeeting',
        type: 'get',
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        if(data[i].subject.substring(0,6)=='[视频会议]' || data[i].subject.substring(0,4)=='[会议]'){
        if(data[i].url!=undefined){
        str+='<li onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="'+data[i].url+'"><span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span><span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }else{
        str+='<li  onclick="canHui($(this))" title="'+data[i].subject+'" meetingId="'+data[i].mps.meetingId+'" roomNo="'+data[i].mps.roomNo+'" roomPwd="'+data[i].mps.roomPwd+'" userNameString="'+data[i].mps.userNameString+'" roomAddr="'+data[i].mps.roomAddr+'"><span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span><span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }
        }
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.notice').html(str)
        if($('.notice').html()==''){
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        $('.notice').html(str)
        }
        }
        });
        }
        //公告查询方法 未读
        function announcement(me){
        $('select[name="noticeTypes"]').css('visibility','visible')
        var typeId=''
        if($(me).attr('read')=='noRead'){
        $(me).attr('data-bool',$(me).siblings().find('option:selected').attr('data-bool'))
        typeId=$(me).attr('data-bool')
        }else{
        typeId=$(me).find('option:selected').attr('data-bool')
        }
        //通知公告如果为全部未读，则走公告和会议接口
        if(!typeId){
        $.ajax({
        url: '/notice/findNotifyandMeeting',
        type: 'get',
        dataType: 'json',
        success: function (res) {
        var data=res.obj
        var str=''
        // console.log(data)
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        if(data[i].url!=undefined){
        str+='<li class="'+function() {
            if(data[i].subject.substring(0,6)=='[视频会议]' || data[i].subject.substring(0,4)=='[会议]'){
                    return ''
            }else{
                    return 'noticeRemove noticeRead'
            }
            }()+'" onclick="tiaozhuan(this)" title="'+data[i].subject+'" notifyId="'+function() {
            return  data[i].url.split('=')[1]
            }()+'" data-url="'+data[i].url+'">'+'<span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span>'+'<span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }else{
        str+='<li onclick="canHui($(this))" title="'+data[i].subject+'" meetingId="'+data[i].mps.meetingId+'" roomNo="'+data[i].mps.roomNo+'" roomPwd="'+data[i].mps.roomPwd+'" userNameString="'+data[i].mps.userNameString+'" roomAddr="'+data[i].mps.roomAddr+'">'+'<span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span>'+'<span class="dateShow" style="margin-right: 18px;">'+function () {
        if(data[i].sendTime!=undefined){
        return format(data[i].sendTime);
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }

        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.notice').html(str)
        }
        });
        }else{
        var obj={
        read:0,
        page:1,
        // pageSize:7,
        // pageSize:10,
        pageSize:15,
        useFlag:'true',
        typeId:typeId
        };
        $.ajax({
        url:"/notice/notifyManagePlus",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li class="noticeRemove noticeRead" onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="/notice/detail?notifyId=' + data[i].notifyId + '"><span class="ellipsis">'+data[i].subject+'</span><span class="dateShow">'+function () {
        if(data[i].notifyDateTime!=undefined){
        return data[i].notifyDateTime.split(/\s/g)[0];
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.notice').html(str)
        }
        })
        }
        }
        //公告查询方法 已读
        function announcements(me){
        $('select[name="noticeTypes"]').css('visibility','visible')
        var typeId=''
        if($(me).attr('read')=='okRead'){
        $(me).attr('data-bool',$(me).siblings().find('option:selected').attr('data-bool'))
        typeId=$(me).attr('data-bool')
        }else{
        typeId=$(me).find('option:selected').attr('data-bool')
        }
        var obj={
        read:1,
        page:1,
        // pageSize:7,
        // pageSize:10,
        pageSize:15,
        useFlag:'true',
        typeId:typeId
        };
        $.ajax({
        url:"/notice/notifyManagePlus",
        type:'get',
        data:obj,
        dataType:'json',
        success:function(res) {
        var data=res.obj
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li onclick="tiaozhuan(this)" title="'+data[i].subject+'" data-url="/notice/detail?notifyId=' + data[i].notifyId + '"><span class="circle"></span><span class="ellipsis">'+data[i].subject+'</span><span class="dateShow" >'+function () {
        if(data[i].notifyDateTime!=undefined){
        return data[i].notifyDateTime.split(/\s/g)[0];
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img   src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.notice').html(str)
        }
        })

        }
        //业务审批待办、经办
        function annount(me,type) {
        $('.bottomLeft .more').attr('url','/workflow/work/workList')
        $.ajax({
        url:'/workflow/work/getAssignData',
        type:'get',
        dataType:'json',
        data:{
        page: 1,
        pageSize: 6,
        // useFlag: true,
        useFlag: false,
        // userId:$.cookie('userId')
        },
        success:function(res){
        var data
        if(type==1 && res.object && res.object.assignData){
        data=res.object.assignData
        }else if(res.object && res.object.commonData){
        data=res.object.commonData
        }else{
            data=''
            }
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        str+='<li onclick="windowOpenNew(this)" can="'+data[i].comment+'" runId="'+data[i].runId+'" flowPrcs="'+data[i].prcsId+'" prcsId="'+data[i].flowPrcs+'" removeRed="'+function() {
            if(type==1){
                return true
            }else{
                return ''
            }
        }()+'"  title="'+function() {
        if(data[i].handles){
        var asend=''
        var ason=''
        var faon=''
        var faend=''
        if(data[i].handles.asend){
        asend=data[i].handles.asend+'\n'
        }
        if(data[i].handles.ason){
        ason=data[i].handles.ason+'\n'
        }
        if(data[i].handles.faon){
        faon=data[i].handles.faon+'\n'
        }
        if(data[i].handles.faend){
        faend=data[i].handles.faend+'\n'
        }
        return asend+ason+faon+faend
        }else{
        return data[i].flowRun.runName
        }
        }()+'" style="'+function() {
        if ((data[i].comment && type==1) || (data[i].timeOutFlag && data[i].timeOutFlag == '1' && type != 1)) {
        return 'color: red;'
        }
        }()+'" daiBan="true" data-s="2"  data-url="/workflow/work/workform?opFlag='+data[i].opFlag+'&flowId='+data[i].flowRun.flowId+'&flowStep='+data[i].prcsId+'&runId='+data[i].runId+'&prcsId='+data[i].flowPrcs+'">' +
        '<span class="circle"></span>' +
        /*'<span style="position:relative;top: -3px;">'+function() {
        var type=''
        if(data[i].handleType=='1'){
        type='[主办--'+data[i].handles+']'
        }else if(data[i].handleType=='2'){
        type='[经办--'+data[i].handles+']'
        }else if(data[i].handleType=='3'){
        type='[交办--'+data[i].handles+']'
        }
        return type
        }()+'</span>'+*/
        '<span class="ellipsis" style="width: 57%">'+data[i].flowRun.runName+
        '</span><span style=" position: absolute;'+
        ' right: 15.5%;'+
        ' top: -1px;">'+data[i].flowRun.userName+'</span>'+
        '<span class="dateShow">'+function () {
        if(data[i].createTime!=undefined){
        return data[i].createTime.split(/\s/)[0];
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }

        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.work').html(str)
        if(data.length>0){
        if(type==1){
        $('.bottomLeft .daibanNumJ').css('display','block')
        $('.bottomLeft .daibanNumJ').html(res.object.assignData.length)
        }else{
        $('.bottomLeft .daibanNum').css('display','block')
        $('.bottomLeft .daibanNum').html(res.object.commonData.length)
        }
        }else{
        if(type==1){
        $('.bottomLeft .daibanNumJ').css('display','none')
        }else{
        $('.bottomLeft .daibanNum').css('display','none')
        }
        }
        }
        })
        }
        //业务审批已办
        function announts(me) {
        $('.bottomLeft .more').attr('url','/workflow/work/endwork')
        $.ajax({
        url:'/workflow/work/selectEndWord',
        type:'get',
        dataType:'json',
        data:{
        page: 1,
        // pageSize: 6,
        pageSize: 15,
        useFlag: true,
        userId:$.cookie('userId')
        },
        success:function(res){
        var data=res.obj
        var str=''
        var style=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        /* if(data[i].isHidden==1){
        style='style="padding-left:17px"'
        }else{
        style=''
        }*/
        str+='<li '+style+' title="'+data[i].flowRun.runName+'" data-s="2"  data-url="/workflow/work/workformPreView?flowId='+data[i].flowRun.flowId+'&flowStep='+data[i].prcsId+'&runId='+data[i].runId+'&prcsId='+data[i].flowPrcs+'">' +
        '<span class="circle"></span><input type="hidden" class="hidden"  isHidden="'+ data[i].isHidden +'" name="'+ data[i].runId +'"/>'+
        function() {
        if(data[i].havaSon !=undefined){
        if(data[i].havaSon == 0&&data[i].isHidden == 0){
        return '<img src="../../img/mywork/addlogo.png" style="margin-right: 3px;margin-bottom: 7px;cursor: pointer" title="点击展开" runId="'+ data[i].runId +'" onclick="openthis($(this))">';
        }else{
        return '<div style="width: 19px;display: inline-block"></div>';
        }
        }else{
        return '<div style="width: 19px;display: inline-block"></div>';
        }
        }()+
        '<span style="width: 70%" class="ellipsis hide" onclick="windowOpenNew(this)" data-s="2" data-url="/workflow/work/workformPreView?flowId='+data[i].flowRun.flowId+'&flowStep='+data[i].prcsId+'&runId='+data[i].runId+'&prcsId='+data[i].flowPrcs+'" isHidden='+data[i].isHidden+' >'+data[i].flowRun.runName+
        '</span><span style=" position: absolute;'+
        ' right: 15%;'+
        ' top: -1px;">'+data[i].flowRun.userName+'</span>'+
        '<span class="dateShow" style="margin-right: 15px;">'+function () {
        if(data[i].deliverTime!=undefined){
        return data[i].deliverTime.split(/\s/)[0];
        }else {
        return ''
        }
        }()+'</span>'+'</li>'
        }

        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.work').html(str)
        //判断默认展开哪些流程
        var length = $('.work .hide').length;
        for(var i=0;i<length;i++){
        var ishidden = $('.work .hide').eq(i).attr('ishidden');
        if(ishidden == 1){
        $('.work .hide').eq(i).parent().hide();
        }else{
        $('.work .hide').eq(i).parent().addClass('tableopen');
        }
        }
        }
        })
        }
        //业务审批展开折叠
        function openthis(e){
        var runid = e.attr('runid');
        if(e.hasClass('active')){
        // $('.work .hidden[name='+ runid +']').parent().hide()
        for(var i=0;i<$('.work .hidden[name='+ runid +']').length;i++){
        if($('.work .hidden[name='+ runid +']').eq(i).attr('ishidden')==1){
        $('.work .hidden[name='+ runid +']').eq(i).parent().hide()
        }
        }
        e.attr({
        'title':'点击展开',
        'src':'../../img/mywork/addlogo.png'
        }).removeClass('active')
        }else{
        $('.work .hidden[name='+ runid +']').parent().show()
        e.addClass('active').attr({
        'title':'点击收起',
        'src':'../../img/mywork/deletelogo.png'
        })
        }
        }
        //公文管理待办
        function amange(me,type) {
        // $('.bottomRight .more').attr('url','/document/inAbeyance')
        $.ajax({
        url: '/document/getAssignDocData',
        type: 'get',
        data:{
            page:1,
            // pageSize:7,
            pageSize:66,
            // useFlag:true,
            useFlag:false,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:'',
            documentType:''
        },
        dataType: 'json',
        success: function (res) {
            var data
            if(type==1){
                data=res.object.assignData
            }else{
                data=res.object.commonData
            }
            var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
        str+='<li onclick="tiaozhuan(this)" data-s="2" can="'+data[i].comment+'" runId="'+data[i].runId+'" flowPrcs="'+data[i].step+'" prcsId="'+data[i].realPrcsId+'" removeRed="'+function() {
            if(type==1){
                return true
            }else{
                return ''
            }
        }()+'" title="'+function() {
        if(data[i].handles){
            var asend=''
            var ason=''
            var faon=''
            var faend=''
            if(data[i].handles.asend){
            asend=data[i].handles.asend+'\n'
            }
            if(data[i].handles.ason){
            ason=data[i].handles.ason+'\n'
            }
            if(data[i].handles.faon){
            faon=data[i].handles.faon+'\n'
            }
            if(data[i].handles.faend){
            faend=data[i].handles.faend+'\n'
            }
            return asend+ason+faon+faend
        }else{
            if(data[i].documentType=='0'){
                return '[发文]'+data[i].title
            }else{
                return '[收文]'+data[i].title
            }
        }
        }()+'" style="'+function() {
            if ((data[i].comment && type==1) || (data[i].timeOutFlag && data[i].timeOutFlag == '1' && type != 1) ) {
                return 'color: red;'
            }
        }()+'" daiBan="ture" data-url="'+url+'"><span class="circle"></span><span class="ellipsis">'+function() {
        if(data[i].documentType=='0'){
        return '[发文]'+data[i].title
        }else{
        return '[收文]'+data[i].title
        }
        }()+'</span><span class="dateShow">'+function () {
        if(data[i].createTime.indexOf('.') > -1){
        if(data[i].createTime.indexOf(' ') > -1){
        return data[i].createTime.split(' ')[0];
        }else{
        return data[i].createTime;
        }
        }else{
        return '';
        }
        }()+'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.document').html(str)
        if(data.length>0){
        if(type==1){
        $('.bottomRight .daibanNumJ').css('display','block')
        $('.bottomRight .daibanNumJ').html(res.object.assignData.length)
        }else{
        $('.bottomRight .daibanNum').css('display','block')
        $('.bottomRight .daibanNum').html(res.object.commonData.length)
        }
        }else{
        if(type==1){
        $('.bottomRight .daibanNumJ').css('display','none')
        }else{
        $('.bottomRight .daibanNum').css('display','none')
        }
        }

        }
        });
        }
        //公文管理已办
        function amanges(me,type) {
        // $('.bottomRight .more').attr('url','/document/received')
        $.ajax({
        url: '/document/selOverDocSendOrReceive',
        type: 'get',
        data:{
        page:1,
        // pageSize:7,
        pageSize:15,
        useFlag:true,
        printDate:'',
        dispatchType:'',
        title:'',
        docStatus:'',
        flowId:'',
        documentType:''
        },
        dataType: 'json',
        success: function (res) {
        var data=res.datas
        var str=''
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        var url = '/workflow/work/workformPreView?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
        +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
        str+='<li onclick="tiaozhuan(this)" title="'+function() {
        if(data[i].documentType=='0'){
        return '[发文]'+data[i].title
        }else{
        return '[收文]'+data[i].title
        }
        }()+'" data-url="'+url+'"><span class="circle"></span><span class="ellipsis">'+function() {
        if(data[i].documentType=='0'){
        return '[发文]'+data[i].title
        }else{
        return '[收文]'+data[i].title
        }
        }()+'</span><span class="dateShow" style="margin-right: 15px;">'+function () {
        if(data[i].createTime.indexOf('.') > -1){
        if(data[i].createTime.indexOf(' ') > -1){
        return data[i].createTime.split(' ')[0];
        }else{
        return data[i].createTime;
        }
        }else{
        return '';
        }
        }()+'</span>'+'</li>'
        }
        }else{
        str += '<div class="noData" style="text-align: center;border: none;">' +
        '<img  src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.document').html(str)
        }
        });
        }
        //待办工作点击事件
        function windowOpenNew(me) {
        /* if($(me).attr('data-s')==1){
        /!* window.open('/email/details?id='+$(me).find('.windowopen').attr('data-id'))*!/
        window.open($(me).attr('data-url'))
        }else */
        if($(me).attr('data-s')==2){
        if($(me).attr('removeRed') && $(me).attr('runId')){
            $.get('/workflow/work/updateComment',{runId:$(me).attr('runId'),flowPrcs:$(me).attr('flowPrcs'),prcsId:$(me).attr('prcsId')},function(res) {
                if(res.flag){
                    annount(this,1)
                }
        })
        }
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
        /* if($(me).attr('daiBan')){
        $(me).remove();
        }*/
        /*var type1=$(me).attr("type1");
        if(type1==undefined||type1!="daiban"){
        // $(me).remove();
        // todoListNum--;
        }*/
        /* if(todoListNum<99){
        $('#sns').html('<div class="he">'+todoListNum+'</div>');
        }*/

        /*if(todoListNum == 0){
        $('#sns').find('.he').hide();
        }*/



        /* if($('.daiban').find('li').length==0) {
        var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
        '<h2 style="text-align: center;color: #666;">'+'暂无数据'+'</h2>' +
        '</div>';
        $('.daiban').html(lis);
        }*/
        }
        //跳转页面
        function tiaozhuan(that) {
        if($(that).hasClass('newRemove') || $(that).hasClass('noticeRemove')){
                $(that).remove()
        }
        // $.popWindow($(that).attr('data-url'),'公告详情','20','150','1200px','600px')
        // $.popWindow($(that).attr('data-url'),'公告详情','60','170','1200px','600px')
        if($(that).attr('data-s')==2){
        if($(that).attr('removeRed') &&  $(that).attr('runId')){
            $.get('/workflow/work/updateComment',{runId:$(that).attr('runId'),flowPrcs:$(that).attr('flowPrcs'),prcsId:$(that).attr('prcsId')},function(res) {
            if(res.flag){
                amange(this,1)
            }
        })
        }
        }
        window.open($(that).attr('data-url'))
        /* if($(that).attr('daiBan')){
        $(that).remove()
        }*/
        }
        //时间戳转换
        function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
        }
        /*  function canHui(me) {
        huiyiDetali(me.attr('meetingId'))
        layer.confirm('确定要参加会议吗？', function(index){
        address=me.attr('roomAddr')
        entermeeting(me.attr('roomNo'),me.attr('roomPwd'),me.attr('userNameString'))
        layer.close(index);
        });
        }*/
        //会议详情、参会
        function canHui(me) {
        $.ajax({
        url:'/hstMeetingRoom/queryHstMeetingById',
        type: "post",
        dataType: "json",
        data:{meetId:me.attr('meetingId')},
        success:function (res) {
        var data=res.object
        layer.open({
        type: 1,
        title: '会议详情',
        shade: 0.5,
        area: ['50%', '85%'],
        content:'<form class="layui-form" id="ajaxforms" lay-filter="formsTest" style="width:90%;margin-left:5%;margin-top: 3%;">' +
        '<table class="layui-table">\n' +
        '  <tbody>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap" style="width:20%">会议名称:</td>\n' +
        '      <td class="meetName">'+data.meetName+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">会议主题:</td>\n' +
        '      <td class="subject">'+data.subject+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">参会人员:</td>\n' +
        '      <td class="userIdsName">'+data.userIdsName.substring(0,data.userIdsName.length-1)+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">开始时间:</td>\n' +
        '      <td class="startTime">'+data.startTime+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">结束时间:</td>\n' +
        '      <td class="endTime">'+data.endTime+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">审批人:</td>\n' +
        '      <td class="managerIdName">'+data.managerIdName.substring(0,data.managerIdName.length-1)+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">提前进入会议室时间:</td>\n' +
        '      <td class="advanceMin">'+function () {
        if(data.advanceMin==0){
        return  '按时进入会议'
        }else {
        return data.advanceMin+'分钟'
        }
        }()+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">附件:</td>\n' +
        '      <td class="Table">'+function () {
        }()+'</td>\n' +
        '    </tr>\n' +
        '    <tr>\n' +
        '      <td nowrap="nowrap">会议描述:</td>\n' +
        '      <td class="meetDesc">'+data.meetDesc+'</td>\n' +
        '    </tr>\n' +
        '  </tbody>\n' +
        '</table>'+
        '<div style="text-align: center"><button type="button" class="layui-btn  layui-btn-sm" id="canhui">参加会议</button></div>'+
        '</form>',
        success:function(){
        var arr=res.object.attachmentList
        attachmentShow_news(arr,$('.Table'));
        for(var i=0;i<$('.font_').length;i++){
        $('.font_').eq(i).children(":first").remove()
        }
        $('.font_ .file_a  span').css('margin-left','12px')
        //点击参加会议
        $('#canhui').on('click',function() {
        layer.confirm('确定要参加会议吗？', function(index){
        address=me.attr('roomAddr')
        entermeeting(me.attr('roomNo'),me.attr('roomPwd'),me.attr('userNameString'))
        layer.close(index);
        });
        })
        }
        })
        }
        })
        }
        //PC客户端自动下载地址
        var clientForPCDownloadAddr = "http://www.hst.com/download/FMDesktop.exe";
        //登录会议室主函数
        function entermeeting(roomNo,roomPwd,nickName){
        var roomId = roomNo;
        var roomPwd = roomPwd;
        var userName = '';
        var userPwd = '';
        var nickName = nickName;
        var url = getURLForPC(roomId, roomPwd, userName, userPwd, nickName);
        if (isAndroid) {
        url = getURLForAndroid(roomId, roomPwd, userName, userPwd, nickName);
        }else if(isiOS) {
        url = getURLForIphone(roomId, roomPwd, userName, userPwd, nickName);
        }
        if(its.x.isIE() || its.x.isChrome() || its.x.isSafari()){
        setTimeout(function(){
        window.location.href = url;
        }, 1);
        }else{
        document.getElementById("myiframe").src = url;
        }
        }
        function getUserType(){
        var userType;
        var obj = document.getElementsByName("userType");
        for(var i = 0; i < obj.length; i++){
        if(obj[i].checked)
        userType = obj[i].value;
        }
        return userType;
        }

        function openRold(){
        // window.location.reload(true)
        //只刷新业务审批和公文管理
        shenPi()
        gongwen()
        $('.daiban ').addClass('activeShow').siblings().removeClass('activeShow')
        parent.listTable()
        }
        </script>
        </body>
        </html>
