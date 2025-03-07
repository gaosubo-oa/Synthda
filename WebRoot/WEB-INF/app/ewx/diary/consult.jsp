<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>我发起的详情</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <link href="../lib/mui/mui/mui.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/diary/m/consult.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />
    <style>
        html, body{
            background: none;
        }
        .divImg{
            float:left;
        }
        .divCon{
            float:left;
            width:80%;
        }
        pre{
            margin:0;padding:0;
            white-space: pre-wrap!important;
            word-wrap: break-word!important;
            *white-space:normal!important;
        }
        .consult_list{
            height:22px;
            /*font-size:16px;*/
        }
        .consult_list .clearfix, .consult_list .initiator_list {
            margin-left: 33px;
        }
        .top-rt img {
            width: 24px;
            height: 24px;
            display: block;
        }
        .shade {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.3) !important;
            display: none;
            width: 100%;
            height: 100%;
            z-index: 11;
        }
        .edit {
            width: 95px;
            position: absolute;
            display: none;
            top: 23px;
            z-index: 66;
            background: #fff;
            font-size: 16px;
            left: -65px;
            box-sizing: border-box;
            border: 1px solid rgba(0, 0, 0, .15);
            border-radius: 4px;
            padding: 0px 4px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
        }
        .top-rt .e_imgs {
            width: 23px;
            height: 21px;
            display: block;
        }
        .e_box {
            display: flex;
            align-items: center;
            padding: 15px 13px;
            border-top: 1px solid #e5e5e5;
            color: grey;
        }
        .explain_cen{
            margin-top: 100px;
            user-select: text !important;
        }
        .explain_cen span {
            user-select: text !important;
        }
        .explain_cen p {
            user-select: text !important;
        }
        .explain_cen * {
            user-select: text !important;
        }
        /*ul#list {*/
        /*    bottom: 40px;*/
        /*    overflow-y: auto;*/
        /*}*/
    </style>
    <style>
        .main{
            background-color: #fff;
            margin-bottom: 50px;
        }

        .main .part {
            padding: 0.2rem 50px 0.2rem 0;
        }

        .main .part input[type=checkbox] {
            top: 0px;
        }

        .main .person {
            padding: 0.4rem 50px 0.4rem 0;
        }

        .main .person input[type=checkbox] {
            top: -1.6px;
        }

        .main .userPerson {
            padding: 0.4rem 50px 0.4rem 0;
        }

        .main .userPerson input[type=checkbox] {
            top: -3px;
        }

        .main .mui-checkbox input[type=checkbox]:before {
            width: 0.3rem;
            height: 0.3rem;
            line-height: 30px;
            text-align: center;
            display: block;
            font-size: 30px;
        }

        .main h3{
            font-size: 14px;
            border-bottom: 1px solid #dcdcdc;
            font-weight: normal;
        }

        .main .users {
            margin-left: 1rem;
        }

        .main .department {
            margin-left: 1rem;
        }

        .selectFile {
            display: inline-block;
            background: url(/ui/img/diary/m/regular_election.png) no-repeat 0 0;
            background-size: 100% 100%;
            height: 2.25rem;
            width: 2.25rem;
            vertical-align: middle;
            margin-right: 0.27rem;
        }

        .file {
            display: inline-block;
            background: url(/ui/img/diary/m/wen.png) no-repeat 0 0;
            background-size: 100% 100%;
            height: 2.25rem;
            width: 2.25rem;
            vertical-align: middle;
            margin-right: 0.27rem;
        }

        .box_confirm {
            background-color: #5890D7;
            height: 40px;
            line-height: 40px;
            color: #fff;
            border-radius: 5px;
        }
    </style>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>
<body id="iStarted">
<div class="shade" style="height: 667px; background: rgba(0, 0, 0, 0.3); display: none;"></div>
<div class="details">
    <div class="mui-content" style="background: none">
        <div class="tit_con" style="overflow: inherit">
            <div class="divImg">

            </div>
            <div class="divCon">
                <div class="clearfix">
                    <span class="pull_left subject" id="subject"></span>
                    <div class="top-rt" style="position:relative;float:right">
                        <img style="z-index: 22" class="still" src="../../img/diary/m/xial.png" alt="">
                        <div class="edit" style="display: none;">
                            <div class="e_box" id="edit_font" style="border-top: none;">
                                <img class="e_imgs" src="../../img/diary/m/edit.png" alt="">
                                <span>编辑</span>
                            </div>
                            <div class="e_box" id="delete_font">
                                <img class="e_imgs" src="../../img/diary/m/delete.png" alt="">
                                <span>删除</span>
                            </div>
                            <div class="e_box" id="bot_font">
                                <img class="e_imgs" src="../../img/diary/m/subordinate.png" alt="">
                                <span>下属</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="initiator"><span id="pho_init"></span></div>
                <div><span class="pull_right time" id="time"></span></div>
                <div class="clearfix">
                    <%--<div class="pull_left score" style="float:left;">--%>
                    <%--<img class="fraction" src="../../img/diary/m/icon_score.png" alt="">--%>
                    <%--评分：6.0--%>
                    <%--</div>--%>
                    <%--                <div class="pull_right delete_font" id="delete_font">删除</div>--%>
                    <%--                <div class="pull_right edit_font" id="edit_font">编辑</div>--%>
                </div>
            </div>

        </div>
        <button id="click"class="layui-btn layui-btn-primary" style="float: right; margin-right: 20px;">一键复制</button>
        <div class="explain_cen" id="copyDom"></div>
        <div style="padding: 0 20px 10px 20px;font-size: 13px;">
            <div id="pre_diary" style="margin: 5px 0;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;display:none;">
                上一篇：<a style="color: #21759b;text-decoration: underline;"></a>
            </div>
            <div id="next_diary" style="margin: 5px 0;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;display:none;">
                下一篇：<a style="color: #21759b;text-decoration: underline;"></a>
            </div>
        </div>
        <div class="tab clearfix">
            <a class="pull_right line_tab" id="comment_tab">
                <span class="comment">点评：<span id="com_num"></span></span>
            </a>
            <a class="pull_left" id="consult_tab">
                <span class="consult">查阅：<span id="con_num"></span></span>
            </a>

        </div>
        <ul class="mui-table-view list" id="list" style="padding-bottom: 50px;">
        </ul>

    </div>
    <div id="divCom" style="position: fixed;bottom: 10px;left: 0px;z-index: 10;width: 100%;background: #fff;height: 40px;">
        <input type="text" name="dContent" style="width: 50%; margin-left: 5%;" placeholder="请输入点评内容">
        <div class="rece_comment" id="comment_a" style="display: inline-block;width: 15%;margin-left: 5%">点评</div>
        <div style="float: right; display: flex;margin-right: 5%" id="divBtmCom" >
            <span id="btnShare" style="width: 40px;height: 40px;margin-left: 15px;background: url('../../img/diary/m/fxgw.png');background-repeat: round;"></span>
        </div>
    </div>
</div>

<%--选择人员控件--%>
<div class="mui-content"  style="display: none" id="userMain">
    <a style="visibility:hidden;height:0px;" id="to" href=""></a>
    <div class="main">
        <div class="users" id="userss" style="display: block;">
            <h3 id="users" class="mui-input-row mui-checkbox mui-right">
                <label>
                    <i class="selectFile"></i>
                    <span>常选人员</span>
                </label>
            </h3>
        </div>
    </div>
    <nav class="mui-bar mui-bar-tab ">
        <a class="mui-tab-item" href="#" style="padding:0px 10px;" id="save_share">
            <div class="box_confirm" id="com_submit">
                确定
            </div>
        </a>
    </nav>
</div>
</body>
<script type="text/javascript">
    var id = $.GetRequest().id;
    $.ajax({
        url: "/diary/getConByDiaId",
        type: 'get',
        dataType: "JSON",
        data:{
            diaId:id
        },
        success: function (obj) {
            var src_sex ="";
                if(obj.object.avatar != undefined && obj.object.avatar!=''){
                    if(obj.object.avatar == '0'){
                        src_sex='/img/workLog/basichead_man.png';
                    }else if(obj.object.avatar == '1'){
                        src_sex='/img/workLog/portrait3.png';
                    }else{
                        src_sex='/img/user/'+obj.object.avatar;
                    }
                }else{
                    if(obj.object.sex == '0'){
                        src_sex='/img/user/boy.png';
                    }else{
                        src_sex='/img/user/girl.png';
                    }
                }
                $(".divImg").append("<img style='width: 60px;margin-right: 8px;' src="+src_sex+">")

        }
    })
    var type = $.GetRequest().type;
    var userId;
    if(type == 'shareMy'){
        $('.top-rt').css('display','none')
        $('#divBtmCom').css('display','none')
        $('#comment_a').css('width','15%')
    }
    $('#bot_font').on('click',function(){
        location.href = "/ewx/iStartedList?type=detailBranch&userTopId=" + userId ;
    })

    $('.still').click(function(e) {
        var id = $.GetRequest().id;
        $.ajax({
            type: 'get',
            url: '/getLoginUser',
            dataType: 'json',
            success: function (res) {
                if(res.flag) {
                    var id1 = res.object.uid;
                    $.ajax({
                        url:"/diary/getConByDiaId",
                        data:{
                            diaId:id
                        },
                        dataType:"json",
                        success:function(res) {
                            if(res.flag) {
                                var id2 = res.object.uid;
                                if(id1 === id2) {
                                    $('.shade').css('height', document.body.offsetHeight);
                                    $('.shade').css('background', 'rgba(0,0,0,0.3)');
                                    $('.shade').show();
                                    $('.cont').css('overflow', 'hidden');
                                    $(".edit").fadeIn();
                                }else {
                                    $('.shade').css('height', document.body.offsetHeight);
                                    $('.shade').css('background', 'rgba(0,0,0,0.3)');
                                    $('.shade').show();
                                    $('.cont').css('overflow', 'hidden');
                                    $(".edit").fadeIn();
                                    $('.edit #edit_font').css('display', 'none');
                                    $('.edit #delete_font').css('display', 'none');
                                }
                            }
                        }
                    })
                }
            }
        })

    })

    $('.shade').click(function() {
        $('.shade').hide();
        $(".edit").hide();
        $('.cont').css('overflow', 'auto');
    })
    // var   str1 = '<li class="mui-table-view-cell">'+
    //     '<div class="consult_list">'+
    //     '<img class="people" src="../../img/diary/m/head.png" alt="">'+
    //     '<div class="clearfix">'+
    //     '<span class="pull_left subject">工作日志</span>'+
    //     '<span class="pull_right time">2018-3-6</span>'+
    //     '</div>'+
    //     '<div class="initiator_list initiator_list_change">管理部</div>'+
    //     '</div>'+
    //     ' </li>';
    // jQuery("#list").html(str1);
    var str = '<li class="mui-table-view-cell">暂无数据</li>'
    var str2="";
    var str3 = '<li class="mui-table-view-cell">暂无数据</li>';
    function timestampToTime(timestamp) {
        var date = new Date(timestamp);
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
        var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());

        strDate = Y+M+D+h+m+s;
        return strDate;

    }
    function seeConut(id){
        mui.ajax('/diary/getReaders',{
            data:{diaId:id},
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
                var arr=[];
                str = ''
                if(data.object.readersName!=''&&data.object.readersName.indexOf(',')<0){
                    arr.push(data.object.readersName)
                    $('#con_num').text('1')
                }else if(data.object.readersName!=''&&data.object.readersName.indexOf(',')>=0){
                    arr=data.object.readersName.split(',')
                    $('#con_num').text(data.object.readersName.split(',').length)
                }else{
                    $('#con_num').text('0')
                }
                for(var i=0;i<arr.length;i++){
                    if(data.object.diaryReferList != undefined && data.object.diaryReferList.length != 0){
                        var ctime = data.object.diaryReferList[i].ctime;
                        var ctimes = timestampToTime(ctime)
                        str += '<li class="mui-table-view-cell">' +
                            '<div class="consult_list">' +
                            '<img class="people" src="' + function(){
                                if(data.object.diaryReferList[i].user.photoName != ''){
                                    return data.object.diaryReferList[i].user.photoName
                                }else{
                                    return '../../img/diary/m/head.png'
                                }
                            }() + '" alt="">' +
                            '<div class="clearfix">' +
                            '<span class="pull_left subject">' + data.object.diaryReferList[i].user.userName + '</span>' +
                            '<span class="pull_right time">' + ctimes + '</span>' +
                            '</div>' +
                            '<div class="initiator_list initiator_list_change">' + data.object.diaryReferList[i].user.userPrivName + '</div>' +
                            '</div>' +
                            ' </li>'
                    }
                }
                $('#list').html(str)


            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }
    //和移动端交互
    function btn(attrUrl,attrName) {
        // console.log(attrUrl,attrName)
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.overLookFile.postMessage(attrUrl,attrName);
            }catch(err){
                overLookFile(attrUrl,attrName);
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            Android.overLookFile(attrUrl,attrName);
        }
    }
    $('.explain_cen').click(function(e) {
        var dom = e.target;
        if($(dom).hasClass('item')) {
            var url = $(dom).attr('it_url');
            var name = $(dom).attr('it_name');
            var attUrl = location.origin + '/download?'+ url;
            btn(attUrl,name)
        }
    })
    function  logdiary(did,tabnum){
//        if(tabnum == 2){
//            $("#comment_tab").addClass("line_tab");
//            $("#consult_tab").removeClass("line_tab");
//        }else{
//            $("#consult_tab").addClass("line_tab");
//            $("#comment_tab").removeClass("line_tab");
//        }
        var data = {
            "diaId":did
        };
        mui.ajax('/diary/getConByDiaId',{
            data:data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
                userId = data.object.userId;
                var info = data.object.attachment;
                var imgs = '';
                var file = '';
                if (data.object.content != "") {
                    imgs += "<br>";
                }
                if(data.object.attachment != ''){
                    // onclick='+btn(info[0].attachName,info[0].attUrl)+'
                    for (var i = 0; i < data.object.attachment.length; i++) {
                        var attachName = data.object.attachment[i].attachName.split('.')[1];
                        if(attachName == 'jpg' || attachName == 'png' || attachName == 'jpeg'){
                            imgs += '<img style="width:30%;height:auto;margin-right: 5px;" src="/xs?' + data.object.attachment[i].attUrl +'">';
                        }else{
                            file += '<a href="/download?' + data.object.attachment[i].attUrl + '" is_image="0" class="pda_attach" style="display: block">' +
                                '<span class="item" it_url='+info[0].attUrl+' it_name='+info[0].attachName+'>'+  data.object.attachment[i].attachName +  '</span>' +
                                '<em  style="color: #808080;font-style: normal;font-size: 14px;margin-left: 10px;">'+ data.object.attachment[i].size +'</em>' +
                                '<div class="ui-icon-rarrow"></div></a>';
                        }
                    }
                }
                $(".details").attr("diaId", data.object.diaId);
                $("#subject").text(data.object.subject);
                $("#time").text(data.object.diaDate);
                $("#pho_init").text(data.object.userName);
                $(".explain_cen").html(data.object.content + imgs + file);
                $("#com_num").text(data.object.comTotal);

                $("#btnShare").attr("toUserId", data.object.toId);
                $("#btnShare").attr("sFlag", data.object.sFlag);
                //获取当前登陆用户的部门
                deptId = data.object.deptId;

                //查询本部门的所有上级
                $.ajax({
                    type:'get',
                    url:'/department/selectDepartmentTop',
                    data: {
                        deptId: deptId
                    },
                    dataType:'json',
                    success:function(res){
                        if(res.flag && res.object != null){
                            deptTop = res.object.deptTop;
                        }
                    }
                });

                if (data.object.diaPreId != "" && data.object.diaPreId != undefined) {
                    var nod = $('#pre_diary');
                    var noda = nod.find('a').eq(0);
                    noda.attr('href',"/ewx/consult?id=" + data.object.diaPreId);
                    noda.html(data.object.diaPreTitle);
                    nod.show();
                }
                if (data.object.diaNextId != "" && data.object.diaNextId != undefined) {
                    var nod = $('#next_diary');
                    var noda = nod.find('a').eq(0);
                    noda.attr('href',"/ewx/consult?id=" + data.object.diaNextId);
                    noda.html(data.object.diaNextTitle);
                    nod.show();
                }

            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }


    jQuery(function(){
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        did = GetQueryString("id"); //括号里放地址栏传参变量
        type = GetQueryString("type"); //括号里放地址栏传参变量
        if(type=='other'){
            $('#edit_font').hide();
            $('#delete_font').hide();
        }
        logdiary(did,1);
        // seeConut(did);
        click_comment();
        /*查阅*/
        mui(".tab").on('tap','#consult_tab',function(){
            seeConut(did);
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            jQuery("#list").html(str);
        })
        //点评
        mui(".tab").on('tap','#comment_tab',function(){
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            click_comment();
        });
        //点击图片
        mui('.explain_cen').on('click','img',function(){
            // var dataSrc=$(this).attr('src');
            showcasing(this)

        })

        $("#comment_a").on("click",function(){
            var did=$.GetRequest().id;
            var val = $('input[name=dContent]').val();
            if(!val.trim()) {
                mui.toast('请输入点评内容');
                return
            }
            // $('.pull_left').addClass('line_tab');
            // $('.pull_right').removeClass('line_tab');
            mui.ajax('/diary/insertDiaryComment',{
                data: {
                    "diaId":did,
                    "content":val,
                    "isRemind": true
                },
                dataType:"json",
                type:"get",
                success:function(res) {
                    if(res.flag) {
                        $('input[name=dContent]').val('')
                        click_comment();
                        logdiary(did,1);
                    }
                }
            })
            //打开点评页面
            // mui.openWindow({
            //     id:'/diary/diaryCommenth5',
            //     url:'/ewx/comment?id='+did+'&dataType='+$.GetRequest().dataType
            // });

        //
        });
        /*编辑*/
        mui(".tit_con").on("tap","#edit_font",function(){
            var dataType = $.GetRequest().dataType == undefined ? "" : $.GetRequest().dataType;
            mui.openWindow({
                id:'/diary/diaryCreateh5',
                url:'/ewx/diaryCreate?type=edit&id='+did+'&dataType='+dataType
            });
        });
        //删除
        mui('.tit_con').on('tap', '#delete_font', function(e) {
            var data = {
                "diaId":did
            };
            var btnArray = ['确认'];
            mui.confirm('确认要删除吗?', ' ', btnArray, function(e) {
                mui.ajax('/diary/delete',{
                    data:data,
                    dataType:'json',//服务器返回json格式数据
                    type:'get',//HTTP请求类型
                    beforeSend: function() {
                        mui.plusReady(function() {
                            plus.nativeUI.showWaiting('正在加载');
                        })
                    },
                    complete: function() {
                        mui.plusReady(function() {
                            plus.nativeUI.closeWaiting();
                        });
                    },
                    success:function(data){
                        if(type == 'draft'){
                            mui.openWindow({
                                id:'/diary/iStartedListh5',
                                url:'/ewx/diaryList?type=' + type
                            });
                        }else{
                            mui.openWindow({
                                id:'/diary/iStartedListh5',
                                url:'/ewx/iStartedList?type=' + type
                            });
                        }

                        // mui.back(window.reload);
                    },
                    error:function(xhr,type,errorThrown){
                        //异常处理；
                        console.log(type);
                    }
                });
            })

        });


    })

    function showcasing(me) {
        var str='<div id="allamplification" onclick="clearHtml(this)" style="text-align:center;position: fixed;top: 0;z-index: 199910151;left: 0;right: 0;bottom: 0;background-color:rgba(000,000,000,0.5);">' +
            '<img id="showImg" src="'+$(me).attr('src')+'" style="display: inline-block;" alt="">' +
            '</div>'
        $('body').append(str)

        var bodyWith=$('body').width();
        $('#allamplification').find('img').css('width',bodyWith+'px');
        // alert(bodyWith);
        var imgHeight=$('#showImg').height()/2;
        // $('#showImg').css('margin-top',-imgHeight+'px');
    }
    function clearHtml(me) {
        $(me).remove();
    }
</script>
<script>
    var comment_id="";
    var user_id="";
    function reply_log(e){
        var that = e.parents('li').find(".box_com")
        $(that).toggle();
        comment_id=e.attr("comment_id");
        user_id=e.attr("user_id");
    };
    function sub(e){
        mui.ajax('/diary/insertCommentReply',{
            data:{
                replyComment:e.parents('li').find(".reply_text").val(),
                commentId:comment_id,
                toId:user_id,
                isRemind: true
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            success:function(data){
                $(".box_com").hide();
                click_comment();
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                //console.log(type);
            }
        });
//			})
    }
    //点评
    function click_comment(){
        $('.list').html('')

        var data = {
            "diaId":did
        };
        mui.ajax('/diary/getDiaryCommentByDiaId',{
            data:data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
                if(data.obj.length>0){
                    str2=''
                    for(var i=0;i<data.obj.length;i++){
                        var string="";
                        for(var y=0;y<data.obj[i].diaryCommentReplyModelList.length;y++){
                            string += '<div class="reply">'+
                                '<span class="fs">'+data.obj[i].diaryCommentReplyModelList[y].replyerName+'</span>&nbsp;&nbsp;回复&nbsp;&nbsp;'+
                                '<span>'+data.obj[i].diaryCommentReplyModelList[y].toName+'</span>：'+
                                '<span class="reply_bt" style="float:right;color:#5077aa;"  COMMENT_ID="'+data.obj[i].commentId+'" replyId="'+data.obj[i].diaryCommentReplyModelList[y].replyId+'"   USER_ID="'+data.obj[i].diaryCommentReplyModelList[y].toId+'"  onclick= "reply_log($(this))">回复</span>'+
                                function(){
                                    if(data.obj[i].myDiaryComment){
                                        return  '<span class="pull_right re_bt reply_bt"   onclick= "delete_log('+ data.obj[i].diaryCommentReplyModelList[y].replyId +',1)" style="float: right;color: #5077aa;margin-right: 10px">删除</span>'
                                    }
                                }()+
                                '<div>'+data.obj[i].diaryCommentReplyModelList[y].replyComment+'</div>'+
                                '</div>'
                        }
                        str2 +=  '<li class="mui-table-view-cell" id="'+data.obj[i].commentId+'">'+
                            '<div class="comment_list">'+
                            '<img class="people" src="../../img/diary/m/head.png" alt="">'+
                            '<div class="subject">'+data.obj[i].userName+'</div>'+
                            '<div class="initiator_list">'+data.obj[i].userId+'</div>'+
                            '<div class="com_con">'+data.obj[i].content+'</div>'+
                            ''+string+''+
                            '</div>'+
                            '<div class="clearfix">'+
                            '<span class="pull_left time">'+data.obj[i].sendTime+'</span>'+
                            '<span class="pull_right re_bt reply_bt" COMMENT_ID="'+data.obj[i].commentId+'"  USER_ID="'+data.obj[i].userId+'" replyId=""   onclick= "reply_log($(this))">回复</span>'+
                            function(){
                                if(data.obj[i].myDiaryComment){
                                    return  '<span class="pull_right re_bt reply_bt" COMMENT_ID="'+data.obj[i].commentId+'"   onclick= "delete_log('+ data.obj[i].commentId +')" style="color: red">删除</span>' +
                                        '<span class="pull_right re_bt reply_bt" COMMENT_ID="'+data.obj[i].commentId+'"  USER_ID="'+data.obj[i].userId+'" replyId=""   onclick= "edit_log('+ data.obj[i].commentId +')">编辑</span>'
                                } else {
                                    return ''
                                }
                            }()+
                            '</div>'+
                            '<div style="display:none;" class="clearfix box_com">'+
                            '<textarea class="reply_text" style="margin-top: 10px;" rows="5" placeholder="请输入回复内容" id="Messagetext"></textarea>'+
                            '<span class="btnReg" onclick= "sub($(this))">提交</span>'+
                            '</div>'+
                            ' </li>';

                        $(".list").html(str2);
                    }
                }else{
                    $(".list").html('<li class="mui-table-view-cell">暂无数据</li>');
                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    }
    //编辑
    function edit_log(id) {
        var dataType = $.GetRequest().dataType == undefined ? "" : $.GetRequest().dataType;
        mui.openWindow({
            id:'/diary/diaryCommenth5',
            url:'/ewx/comment?typeName=edit&id='+did+'&dataType='+dataType + '&commentId='+id
        });
    }
    //删除
    function delete_log(id,num) {
        layer.confirm("确认删除本条评论?", {
            icon: 3,
            title: '提示'
        }, function(index) {
            if(num == '1'){
                var data = {
                    replyId:id
                }
                var url = '/diary/delCommentReplyByReplyId'
            }else{
                var data = {
                    commentId:id
                }
                var url = '/diary/delDiaryCommentByCommentId'
            }
            $.ajax({
                url: url,
                data: data,
                type: "POST",
                success: function(data) {
                    if (data.flag) {
                        layer.msg('删除成功！', {
                            time: 800,
                            end: function() {
                                location.reload();
                            }
                        });
                    } else {
                        layer.msg('删除失败！', {
                            time: 800
                        })
                    }
                },
                error: function() {
                    layer.msg('删除失败！', {
                        time: 800
                    })
                }
            });
        });
    }

    function copyUrl(){
        if(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )){
            //ios系统
            window.getSelection().removeAllRanges();//这段代码必须放在前面否则无效
            let inputDom =document.createElement('input');
            let copyDom=document.getElementById("copyDom");//要复制文字的节点
            copyDom.appendChild(inputDom);// 把标签添加给body
            inputDom.style.opacity = 0;//设置input标签设置为透明(不可见)
            inputDom.value = $("#copyDom").text(); // 修改文本框的内容
            let range = document.createRange();
            // 选中需要复制的节点
            range.selectNode(inputDom);
            // 执行选中元素
            window.getSelection().addRange(range);
            inputDom.select();
            inputDom.setSelectionRange(0,inputDom.value.length);//适配高版本ios
            // 执行 copy 操作
            let successful = document.execCommand('copy');
            let messageText =successful?'苹果复制成功':''
            alert(messageText)
            // 移除选中的元素
            window.getSelection().removeAllRanges();
            copyDom.removeChild(inputDom)
        }else{
            //其他系统
            let inputDom =document.createElement('input');
            let copyDom = document.getElementById('copyDom')
            copyDom.appendChild(inputDom);// 把标签添加给body
            inputDom.style.opacity = 0;//设置input标签设置为透明(不可见)
            inputDom.value = $("#copyDom").text();; // 修改文本框的内容
            inputDom.select(); // 选中文本
            // 执行选中元素
            let successful = document.execCommand("copy"); // 执行浏览器复制命令
            let messageText =successful?'安卓复制成功':''
            alert(messageText)
            copyDom.removeChild(inputDom)
        }
    }
    var clickDom =document.getElementById('click')
    clickDom.onclick=function(){
        copyUrl()
    }
</script>
<script type="text/javascript">
    //定义全局变量
    var deptId = 1;//当前用户所在部门
    var deptTop = "";
    var index = 1;
    var toUserIds = "";
    var toDeptIds = "";

    //点击事件
    $('#btnShare').on('click',function(){
        //隐藏主页面 显示选人控件页面
        $('.details').hide();
        $('#userMain').show();

        //给全局变量赋值已选择人员userId
        if ($("#btnShare").attr("toUserId") != undefined){
            toUserIds = $("#btnShare").attr("toUserId");
        } else {
            toUserIds = "";
        }
        if ($("#btnShare").attr("toDeptId") != undefined){
            toDeptIds = $("#btnShare").attr("toDeptId");
        } else {
            toDeptIds = "";
        }

        //常选人员
        users("fenxiang");
        init("fenxiang");
    })

    // 转换字符串到元素
    function strToDom(str) {
        var $div = $('<div></div>');
        $div.html(str);
        return $div.children().unwrap();
    }
    // 是否全部选中
    function isAllChecked(arr) {
        var select = true;
        for (var i = 0, len = arr.length; i < len; i++) {
            if (arr[i].checked === false) {
                select = false;
            }
        }
        return select;
    }
    // 创建部门元素
    function createPart(res, checked, upDepId, flag) {
        if (toDeptIds != '') {
            var deptid = toDeptIds.substring(0, toDeptIds.length - 1).split(',');
        }
        if (res.data && res.data.length) {
            var data = res.data;
            var str = '';
            var checkedStr = checked ? 'checked=true' : '';
            for (var i = 0, len = data.length; i < len; i++) {
                str += '<div class="department">' +
                    '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right part" id="dept' + data[i].DEPT_ID + '" data-dept-id=' + data[i].DEPT_ID + ' data-up-deptid=' + upDepId + ' >' +
                    '<i class="file"></i>' +
                    '<span>' + data[i].DEPT_NAME + '</span>' +
                    '<input type="checkbox" name="part" id="" ' + checkedStr + ' ' +
                    function() {
                        if (toDeptIds != '') {
                            for (var j = 0; j < deptid.length; j++) {
                                if (deptid.indexOf(data[i].DEPT_ID) >= 0) {
                                    return 'checked'
                                }
                            }
                        }
                    }() + ' /></h3>' +
                    '</div>'
            }
            return strToDom(str);
        } else {
            return "";
        }
    }
    //创建人员元素
    function createPerson(res, checked, upDepId, flag) {
        if (toUserIds != '') {
            var udid = toUserIds.substring(0, toUserIds.length - 1).split(',');
        }
        if (res.item && res.item.length) {
            var data = res.item;
            var str = '';
            var checkStr = checked ? 'checked=true' : '';
            for (var i = 0, len = data.length; i < len; i++) {
                str += '<div class="department">' +
                    '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right person" data-up-deptid=' + upDepId + ' data-user-id=' + data[i].USER_ID + '>' +
                    '<span>' + data[i].USER_NAME + '</span>' +
                    '<input type="checkbox" name="person" ' +
                    function() {
                        if (toUserIds != '') {
                            for (var j = 0; j < udid.length; j++) {
                                if (udid.indexOf(data[i].USER_ID) >= 0) {
                                    return 'checked'
                                }
                            }
                        }
                    }() + ' id="" ' + checkStr + ' /></h3>' +
                    '</div>'
            }
            return strToDom(str);
        } else {
            return "";
        }
    }

    //常选人员
    function users(flag) {
        if (flag == null){
            flag = ""
        }
        $("#userss").attr("flag", flag);
        if (toUserIds != '') {
            var udid = toUserIds.substring(0, toUserIds.length - 1).split(',');
        }
        $.ajax({
            url: '/user/regularElection',
            type: 'get',
            data: {
                userIds: toUserIds
            },
            dataType: 'json',
            success: function(res) {
                if (res.flag && res.obj != null) {
                    var str = '';
                    for (var i = 0; i < res.obj.length; i++) {
                        if (res.obj[i].USER_NAME != "") {
                            str += '<div class="users">' +
                                '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right userPerson" data-user-id=' + res.obj[i].USER_ID + '>' +
                                '<span>' + res.obj[i].USER_NAME + '</span>' +
                                '<input type="checkbox" name="userPerson" ' +
                                function() {
                                    if (toUserIds) {
                                        for (var j = 0; j < udid.length; j++) {
                                            if (udid.indexOf(res.obj[i].USER_ID) >= 0) {
                                                return 'checked=true'
                                            }
                                        }
                                    }
                                }() + ' id="" /></h3>' +
                                '</div>'
                        }
                    }
                    $('.users').append(str)
                }
            }
        })
    }

    // 初始化页面
    function init(flag) {
        if (flag == null){
            flag = ""
        }
        index = 1;
        clicked = {};
        $.ajax({
            url: '/user/getUserStructure',
            datatype: 'json',
            type: 'get',
            data: {
                deptId: ''
            },
            success: function(res) {
                var parts = createPart(res.object, false, 0, flag);
                var persons = createPerson(res.object, false, 0, flag);
                $('.main').append(parts);
                $('.main').append(persons);
                var dept_top = deptTop;
                if (dept_top != "") {
                    var arr = dept_top.split(',');
                    if (arr.length > 1) {
                        var arr2 = arr.reverse();
                        $('[data-dept-id=' + arr2[1] + ']').trigger('click');
                        index++;
                        if (arr.length <= 2) {

                        }
                    }
                }
            }
        })
    }

    function uniq(array) {
        var temp = []; //一个新的临时数组
        for (var i = 0; i < array.length; i++) {
            if (temp.indexOf(array[i]) == -1) {
                temp.push(array[i]);
            }
        }
        return temp;
    }

    // 缓存部门点击事件是否点击
    var clicked = {};

    $(function() {
        //常用人员点击事件
        $('.main').on('click', 'input[type=checkbox]', function() {
            var userId = $(this).parent().attr('data-user-id');
            if (!$(this).is(':checked')) {
                if (toUserIds != '') {
                    var uid = toUserIds.split(',')
                    for (var i = 0; i < uid.length; i++) {
                        if (uid[i] == userId) {
                            uid.splice(i, 1)
                        }
                    }
                    var uuid = uid.join(',')

                    toUserIds = uuid;
                }
                $('[data-user-id="' + userId + '"]').find('input').prop('checked', false)
            } else {
                toUserIds += userId + ','
                $('[data-user-id="' + userId + '"]').find('input').prop('checked', true)
            }
        });

        var flag = true;
        $('#users').click(function(e) {
            if (flag) {
                $('#userss').find('.users').hide();
                flag = false;
            } else {
                $('#userss').find('.users').show();
                flag = true;
            }
        });

        // 部门点击事件
        $('.main').on('click', '[data-dept-id]', function(e) {
            var checked = $(this).find('>[type=checkbox]').prop('checked');
            var curEle = $(this);
            curEle.nextAll().toggle();
            var depid = curEle.attr('data-dept-id');
            var flag = curEle.attr("flag");
            if (!clicked["deptid" + depid]) {
                clicked["deptid" + depid] = true;
                $.ajax({
                    url: "/user/getUserStructure",
                    data: {
                        deptId: depid
                    },
                    type: 'get',
                    success: function(res) {
                        var personEle = createPerson(res.object, checked, depid, flag);
                        var partEle = createPart(res.object, checked, depid, flag);
                        curEle.parent().append(personEle).append(partEle);

                        var dept_top = deptTop;
                        if (dept_top != "") {
                            var arr = dept_top.split(',');
                            if (index <= arr.length) {
                                var arr2 = arr.reverse();
                                if (arr2[index] != undefined && arr2[index] != "") {
                                    $('[data-dept-id=' + arr2[index] + ']').trigger('click');
                                    index++;
                                }
                            }
                        }
                    }
                })
            }
        });

        // 复选款的点击事件
        $('.main').on('click', '[type=checkbox]', function(e) {
            // 全部选中
            var selectVal = $(this).prop('checked');
            $(this).parent().parent().find('[type=checkbox]').prop('checked', selectVal)
            totalCheck(this);
            e.stopPropagation();
        });

        // 部门总体点击按钮是否点击
        function totalCheck(el) {
            // 获取总的input框
            var $parent = $(el).parent().parent().parent();
            var totalCheckbox = $parent.find('>h3.mui-input-row>[type=checkbox]')
            // 获取当前同等级的checkbox
            var equalCheckbox = $parent.find('>div.department>.mui-input-row>[type=checkbox]');
            // 下一级菜单选中之后，上一级菜单是否全选中
            totalCheckbox.prop('checked', isAllChecked(equalCheckbox));
            // 下一个
            var upLevelCatalog = $parent.parent().find('>h3.mui-input-row>[type=checkbox]');
            if (upLevelCatalog.length) {
                totalCheck(totalCheckbox)
            }
        }

        // 点击选择人员控件 确定按钮
        $('#save_share').on('click', function() {
            let $checkboxs = $('.department input[type=checkbox]');
            let $checkboxs2 = $('#userss input[type=checkbox]');

            var USER_ID = "";
            var DEPT_ID = "";
            var userDeptName = "";
            var depId, userId;

            var userArr = [];
            for (var i = 0, len = $checkboxs.length; i < len; i++) {
                if ($checkboxs[i].checked === true) {
                    var parent = $($checkboxs[i]).parent();
                    depId = parent.attr('data-dept-id');
                    userDeptName += parent.find("span").html() + ",";
                    if (depId !== '' && depId != undefined) {

                        DEPT_ID += depId + ','
                    }
                    userId = parent.attr('data-user-id');
                    if (userId !== '' && userId != undefined) {
                        userArr.push(userId)
                    }
                }
            }

            for (var j = 0, len2 = $checkboxs2.length; j < len2; j++) {
                if ($checkboxs2[j].checked === true) {
                    var parent = $($checkboxs2[j]).parent();

                    userId = parent.attr('data-user-id');
                    if (userId !== '' && userId != undefined) {
                        userArr.push(userId)
                    }
                }
            }
            var arrUsers = uniq(userArr);
            for (var m = 0; m < arrUsers.length; m++) {
                USER_ID += arrUsers[m] + ','
            }

            // 获取已选择人员的用户名称
            $.ajax({
                url: '/user/regularElection',
                type: 'get',
                data: {
                    userIds: USER_ID
                },
                dataType: 'json',
                success: function (res) {
                    if (res.flag && res.object != null){
                        $("#btnShare").attr("toUserId", USER_ID);
                        $("#btnShare").val(res.object.userNames);
                        $("#btnShare").attr("toDeptId", DEPT_ID);

                        $('.details').show();
                        $('#userMain').hide();

                        $('.main').html(
                            '<div class="users" id="userss" style="display: block;"> '
                            + '<h3 id="users" class="mui-input-row mui-checkbox mui-right">'
                            + '<label><i class="selectFile"></i><span>常选人员</span></label>'
                            + '</h3>'
                            + '</div>'
                        );

                        // 滚动到页面顶部
                        $(window).scrollTop(0);
                    }
                }
            });

            //进行分享
            $.ajax({
                url: '/diary/shareMyDiary',
                type: 'get',
                data: {
                    diaId: $(".details").attr("diaId"),
                    toId: USER_ID,
                    sFlag: $("#btnShare").attr("sFlag"),
                    sendRemind: 1
                },
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        layer.msg("分享成功");
                    } else {
                        layer.msg(res.msg);
                    }
                }
            });

        });
    })
</script>
</html>
