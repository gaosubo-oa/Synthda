<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <title><fmt:message code="main.public"/></title>
    <style>
        html {
            height:100%;
        }
        body {
            height:100%;
            overflow: hidden;
        }
        .cabinet_left {
            width: 20%;
            float: left;
            /*overflow: auto ;*/
            overflow-x: auto;
            overflow-y: auto;
            height: 100%;
            background-color: #F0F4F7;
            border:1px solid #d9d9d9;
            box-sizing: border-box;
        }
        .cabinet_right {
            width:79.8%;
            height:100%;
            border-left-width: 0px;
            border-right-width: 0px;
            border-top-width: 0px;
        }
        .cabinet_info{
            overflow-y: auto;
            width:79.7%;
            height:100%;
            float: right;
        }
        .noData{
            width: 100%;
        }
        .noData .bgImg{
            width: 360px;
            height: 150px;
            margin: 100px auto;
            background-color: #357ece;
            border-radius: 10px;
            box-shadow: 3px 3px 3px #2F5C8F;
            overflow: hidden;
        }
        .noData .bgImg .IMG{
            float: left;
            width: 75px;
            height: 75px;
            margin-top: 37px;
            margin-left: 30px;
        }
        .noData .bgImg .IMG img{
            width: 100%;
        }
        .noData .bgImg .TXT{
            float: left;
            color: #fff;
            font-size: 14px;
            margin-top: 60px;
            margin-left: 20px;
        }
        .noData .bgImg .TXTa{
            color: #fff;
            font-size: 14px;
            margin-top: 60px;
            margin-left: 20px;
            text-align: center;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        .cabinet_left ::-webkit-scrollbar{
            width: 4px;
            height: 16px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .cabinet_left ::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .cabinet_left ::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        .div_Img{
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .div_Img img{
            width: 23px;
            height: 23px;
            margin-top: 11px;
        }
        .divP{
            float: left;
            height: 40px;
            line-height: 40px;
            font-size: 22px;
            margin-left: 10px;
            color:#494d59;
        }
        .tree-title{
            color:#333;
            font-size: 14px;
        }
        .contentTr td:first-of-type{
            display: block;
            width: 300px;
            word-wrap: break-word;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/aplayer/apalyer.css?20221209">
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../lib/easyui/tree.js" ></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js?20230110.1"></script>
    <script src="/lib/laydate/laydate.js"></script>

    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/attachment/attachView.js?20230110.8" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/dp.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/renderVideo.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/aplayer/aplayer.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/aplayer/renderAudio.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <style>
        input {border: none;outline: none;display: inline-block;background: #fff;}
        .ss{margin-top:9px;position: relative;border-radius: 3px;}
        .ss a{font-size: 11pt;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 0px;color: #fff;}
        .ss span{line-height: 28px;cursor: pointer;font-size: 11pt;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 0px;color: #fff;}

        .one{width:100px;height: 28px;}
        .one a{height: 28px;  line-height: 28px;}
        .two{width:140px;height: 28px;}
        .two a{height: 28px;  line-height: 28px;}
        .three{width: 90px;height: 28px;}
        .three a{height: 28px;  line-height: 26px;color:#ffffff;left:26px;}
        .four{width: 120px;height: 28px;}
        .four a{height: 28px;  line-height: 26px;color:#ffffff;}
        .four span{height: 28px;  line-height: 26px;color:#ffffff;}

        .editBtn{margin-right: 10px;}
        .boto{margin-top: 6px;width: 70px;height:28px;border-radius: 3px;line-height: 28px;text-align: center;font-size: 11pt;}
        .boto a{
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
        }

        .TITLE{margin-left: 10px;color: #2B7FE0;}
        .attach{margin-top: 20px;padding-left: 5px;}
        .remind,.share,.inPole{margin-top: 5px;}
        .divBtns{margin-top: 10px;width: 100%;overflow: hidden;}
        .start,.cancle{float: left;width: 90px;padding: 5px;border-radius: 5px;color:#000;margin-left: 10px;cursor: pointer;}
        .floderOperation{width:100%;}
        .selected{margin-top: 10px;width: 120px;height: 28px;line-height: 28px;text-align: center;position: relative;border-radius: 3px;}
        .selected .doTitle{cursor: pointer;color:#ffffff;}

        .tree-title{
            color:#333;
            font-size: 14px;
        }
        .jump-ipt{
            border: #ccc 1px solid;
        }
        .head .one{
            padding: 0;
        }
        .head li{
            float: none;
        }
        .hideDiv li{
            padding-left: 0;
        }
        .wrap{
            width: 98%;
            margin: 0 auto;
        }
        .bottom{
            width: 97%;
        }
        @media screen and (max-width:1600px){
            .TITLE{
                width: 180px;
            }
            .fujian{
                width: 300px;
            }
        }
        @media screen and (min-width:1601px){
            .TITLE{
                width: 330px;
            }
            .fujian{
                width: 420px;
            }
        }
        .addBackground{
            background: #bbbbbb !important;
        }
        .head {
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            /*width: 660px;*/
            /*float: right;*/
            width: 100%;
        }
        .divFolder{
            float: left;
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            width: 356px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .head .ss{
            float: right;
        }
        .head span {
            float: none;
        }

        /*定义菜单滚动条*/
        .cabinet_info::-webkit-scrollbar
        {
            width: 0px;
            /*height: 16px;*/
            /*background-color: #F5F5F5;*/
        }
        /*定义滚动条轨道 内阴影+圆角*/
        .cabinet_info::-webkit-scrollbar-track
        {
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
            border-radius: 50px;
            background-color: #ffffff;
        }

        /*定义滑块 内阴影+圆角*/
        .cabinet_info::-webkit-scrollbar-thumb
        {
            border-radius: 50px;
            /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
            background-color: #c0c0c0;
        }
        #fileName{
            margin-left: 10px;
        }
        #fileName p{
            font-size: 11pt;
            line-height: 25px;
        }
        .operationDiv{
            position: absolute;
            width: 150px;
            border: #ccc 1px solid;
            border-radius: 4px;
            background-color: #ffffff;
            z-index: 99999999;
        }
        .operation{
            display: block;
            /*width: 100%;*/
            margin-left: 0px !important;
            height: 28px;
            padding-left: 10px;
            background: #fff;
            line-height: 28px;
        }
        .operation:hover{
            background-color: #cae1f7;
            color: #000000;
        }
        @media screen and (max-width: 1366px){
            .head>div{
                margin-left:3px;
            }
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?20220922.5"/>
    <script type="text/javascript">
        var newdate=new Date()
        var user_id='userDuser';
        var ireaeders;
        var editdatas;
        var subjectName,contentNo,createrd,contentValue1,contentValue2,contentValue3,atiachmentDesc,atiachmentName,atiachmentCont,crStartDate,crEndDate;
        var subject,sort_no,creaters,keyword1,keyword2,keyword3,attScript,attName,attContain,begainTime,endTime;

        $(function(){
            var deptId = $.cookie('deptId')||'';
            var userAgent = navigator.userAgent;
            if(userAgent.indexOf('QtWebEngine') > -1){
                $.ajax({
                    url: '/Meetequipment/getuser',
                    type: 'get',
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        $.setCookie(res.object);
                    }
                })
            }
            // 查询提醒权限
            $.ajax({
                type:'get',
                url:'/smsRemind/getRemindFlag',
                dataType:'json',
                data:{
                    type:16
                },
                success:function (res) {
                    if(res.flag){
                        if(res.obj.length>0){
                            var data = res.obj[0];
                            // 是否默认发送
                            if(data.isRemind=='0'){
                                $('.remindCheck').prop("checked", false);
                            }else if(data.isRemind=='1'){
                                $('.remindCheck').prop("checked", true);
                            }
                            // 是否手机短信默认提醒
                            if(data.isIphone=='0'){
                                $('.smsDefault').prop("checked", false);
                            } else if (data.isIphone=='1'){
                                $('.smsDefault').prop("checked", true);
                            }
                            // 是否允许发送事务提醒
                            if(data.isCan=='0'){
                                $('.remindCheck').prop("checked", false);
                                $('.smsDefault').prop("checked", false);
                                $('.remindCheck').parent('div').hide();
                            }

                        }
                    }
                }
            })
            var index = true;
            reloadTree(function(){
                var id = location.href.split('?')[1]||'';
                if(id != ''){
                    if(id.indexOf('search=') > -1){
                        subject='';
                        sort_no='';
                        creaters='';
                        keyword1='';
                        keyword2='';
                        keyword3='';
                        attScript='';
                        attName='';
                        attContain='';
                        begainTime='';
                        endTime='';
                        contentId=id.split('search=')[1];
                        queryAllData('');
                        $('.queryDetail').show().siblings().hide();
                    }else if(id.indexOf('sortId=') > -1){
                        sortId=id.split('sortId=')[1];
                        $('.tree-node[node-id='+ sortId +']').click();
                    }else{
                        if($('.tree-node-selected').attr('node-id') != id){
                            $('.tree-node[node-id='+ id +']').click();
                        }
                        $('.tree-node[node-id='+ id +']').next().show();
                    }
                }
            });
            var Height=$('body').height()-2;
            $('.cabinet_left').height(Height);

            // var cabWidth=$('.contentPage').width()-$('.cabinet_left').width()-3;
            //
            // $('.cabinet_info').width(cabWidth);

//            $('.divFolder').width((cabWidth - 660)+'px');

            //鼠标移入附件名显示附件操作
            $('#file_Tachr').on('mouseover','.divShow',function () {
                $(this).find('.operationDiv').show();
            })
            $('#file_Tachr').on('mouseout','.divShow',function () {
                $(this).find('.operationDiv').hide();
            })
            $('#file_Tachrs').on('mouseover','.divShow',function () {
                $(this).find('.operationDiv').show();
            })
            $('#file_Tachrs').on('mouseout','.divShow',function () {
                $(this).find('.operationDiv').hide();
            })
            $('#file_Tach').on('mouseover','.divShow',function () {
                $(this).find('.operationDiv').show();
            })
            $('#file_Tach').on('mouseout','.divShow',function () {
                $(this).find('.operationDiv').hide();
            })


            getIntnet()

            //新建文件
            $('#contentAdd').on("click",function(){
                var sortId=$('input[name="folderId"]').val();
                var sortText=$('input[name="sortTxt"]').val();
                var idea=$('input[name="folderId"]').attr('ireader');
                $.popWindow('/newFilePub/newFiles?range=public&sortId='+sortId+'&text='+encodeURI(sortText)+'&idea='+idea,'<fmt:message code="global.lang.new"/>','100','300','960px','700px');
            })

            //全选点击事件
            $('#checkedAll').on("click",function(){
                var state =$(this).prop("checked");
                if(state==true){
                    $(this).prop("checked",true);
                    $(".checkChild").prop("checked",true);
                    $(".contentTr").addClass('bgcolor');
                    $('#singReading').removeClass('addBackground');
                    $('#copy').removeClass('copyfile');
                    $('#shear').removeClass('copyfile');
                    $('#paste').removeClass('copyfile');
                    $('#deletebtn').removeClass('addBackground');
                }else{
                    $(this).prop("checked",false);
                    $(".checkChild").prop("checked",false);;
                    $('.contentTr').removeClass('bgcolor');
                    $('#singReading').addClass('addBackground');
                    $('#copy').addClass('copyfile');
                    $('#shear').addClass('copyfile');
                    $('#paste').addClass('copyfile');
                    $('#deletebtn').addClass('addBackground');
                }
            })
            $('#checkedAlls').on("click",function(){
                var state =$(this).prop("checked");
                if(state==true){
                    $(this).prop("checked",true);
                    $(".checkChildren").prop("checked",true);
                    $(".contentTrs").addClass('bgcolor');
                    $('#queryDelete').removeClass('addBackground');

                }else{
                    $(this).prop("checked",false);
                    $(".checkChildren").prop("checked",false);;
                    $('.contentTrs').removeClass('bgcolor')
                    $('#queryDelete').addClass('addBackground');
                }
            })
            $('#checkedAllY').on("click",function(){
                var state =$(this).prop("checked");
                if(state==true){
                    $(this).prop("checked",true);
                    $(".checkChildren").prop("checked",true);
                    $(".contentT").addClass('bgcolor');
                    $('#deleteAll').removeClass('addBackground');
                }else{
                    $(this).prop("checked",false);
                    $(".checkChildren").prop("checked",false);;
                    $('.contentT').removeClass('bgcolor');
                    $('#deleteAll').addClass('addBackground');
                }
            })

            //处理特殊字符转码
            // function myEncodeURI(str) {
            //     return encodeURI(str).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
            // }


            var pathss = []

            function norepeat(arr) {
                for(var i = 0; i < arr.length-1; i++){
                    for(var j = i+1; j < arr.length; j++){
                        if(arr[i]==arr[j]){
                            arr.splice(j,1);
                            j--;
                        }
                    }
                }
                return arr;
            }
            var pathres =[]
            var strarr = []
            //批量下载
            $('#downloads').on("click",function(){
                var arr2 = norepeat(fileTime1);
                strarr = []
                pathres =[]
                pathss = []
                //路径
                $.ajax({
                    type:'post',
                    url:'/newFilePub/getAttachments',
                    dataType:'json',
                    async: false, // 同步
                    data:{
                        dateArray:JSON.stringify(arr2),
                    },
                    success:function(res){
                        for(var i=0;i<res.object.list.length;i++){
                            pathss.push(res.object.list[i])
                        }
                    }
                })
                $('#file_Tachr input[type="checkbox"]:checked').each(function (i,n) {
                    var fujiansLength = $(this).parent().parent().find($('.fujian'));
                    //单条数据多个附件的下载
                    for(var j=0; j<fujiansLength.length; j++){
                        strarr.push($(this).parent().parent().find($('.fujian')).eq(j).attr('title').split('   ',1))
                    }
                });
                for(var i=0;i<strarr.length;i++){
                    for(var k=0;k<pathss.length;k++){
                        if(strarr[i] == pathss[k].neName || fileNamesArr[i] == pathss[k].neName){
                            pathres.push(encodeURI(pathss[k].path))
                        }
                    }
                }
                if(pathres.length==0){
                    layer.msg('<fmt:message code="workflow.th.NoDownload"/>', { icon:6, time: 5000});
                }else {
                    var diskId = $('.tree-node-selected').attr('node-id');
                    // window.location.href='/newFilePub/downLoadZipFile?paths='+pathres+'&zipName='+encodeURI(Nowadays);
                    window.open('/newFilePub/downLoadZipFile?paths='+pathres);
                }
            })

            //删除点击事件
            $('#deletebtn').on("click",function(){
                if($('#deletebtn').hasClass('addBackground')){
                    return false
                }
                //var TYPE=$('.w .trBtn').attr('TYPE');
                var id=$('.w .contentTr').attr('sortId');
                var idea=$('input[name="folderId"]').attr('ireader');
                var fileId=[];
                $(".checkChild:checkbox:checked").each(function(){
                    var conId=$(this).attr("conId")
                    fileId.push(conId);
                })
                if(fileId == ''){
                    $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                }else{
                    dataDelete(fileId,id,idea)
                    $('#paste').addClass('addBackground');
                }
            })
            //查询列表删除事件
            $('#queryDelete').on("click",function(){
                if($('#queryDelete').hasClass('addBackground')){
                    return false
                }
                var sortId=$('.w .contentTr').attr('sortId');
                var userId=$('#userDuser').attr('user_id');
                var fileId=[];
                $(".checkChildren:checkbox:checked").each(function(){
                    var conId=$(this).attr("conId")
                    fileId.push(conId);
                })
                if(fileId == ''){
                    $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                }else{
                    $('.details').show().siblings().hide();
                    dataDeleteOne(fileId,sortId,userId)
                }
            })
            //全局搜索列表删除事件
            $('#deleteAll').on("click",function(){
                if($('#deleteAll').hasClass('addBackground')){
                    return false
                }
                var userId=$('#userDuser').attr('user_id');
                var fileId=[];
                $(".checkChildren:checkbox:checked").each(function(){
                    var conId=$(this).attr("conId")
                    fileId.push(conId);
                })
                if(fileId == ''){
                    $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                }else{
                    $('.queryDetail').show().siblings().hide();
                    dataDeleteAll(fileId,userId)
                }
            })
            //文件详情点击事件
            $('.fileCabinet').on('click','.TITLE',function(){
                var that=$(this);
                var idT=$(this).parents('tr').attr('contentId');
                var sortId=$(this).parents('tr').attr('sortId');
                var dataIsRead=$(this).parents('tr').attr('data-isread');
                var deleteNum=$('input[name="deleteQuanxian"]').val();
                var exportNum=$('input[name="exportQuanxian"]').val();
                var editNum=$('input[name="editQuanxian"]').val();
                var riderNum=$('input[name="qianyueQuanxian"]').val();
                var reviewNum=$('input[name="reviewQuanxian"]').val()
                if(dataIsRead == '0'){
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/readFile',
                        dataType:'json',
                        data:{'contentId':idT},
                        success:function(res){
                            if(res.flag){
                                that.siblings('img').remove();
                            }else{
                                $.layerMsg({content:'<fmt:message code="workflow.th.SignFailure"/>！',icon:2});
                            }
                        }
                    })
                }
                $(this).children('img').hide();
                $.popWindow('/newFilePub/fileDetail?contentId='+idT+'&sortId='+sortId,'<fmt:message code="file.th.detail"/>','100','150','1000px','500px');

            })

            //签阅情况点击事件
            $('#file_Tachr').on('click','.signReading',function(){
                var idT=$(this).parents('tr').attr('contentId');
                $.popWindow('/newFilePub/signReading?contentId='+idT,'<fmt:message code="global.lang.edit"/>','50','100','1000px','700px');
            })

            //全局查询-签阅情况点击事件
            $('#file_Tach').on('click','.signReading',function(){
                var idT=$(this).parents('tr').attr('contentId');
                $.popWindow('/newFilePub/signReading?contentId='+idT,'<fmt:message code="global.lang.edit"/>','50','100','1000px','700px');
            })
            //查询-编辑点击事件
            $('#file_Tach').on('click','.editBtn',function(){
                var idT=$(this).parents('tr').attr('contentId');
                var sortId=$(this).parents('tr').attr('sortId');
                var contype=$(this).parents('tr').attr('conType');
                var idea=$('input[name="folderId"]').attr('ireader');
                $.popWindow('/newFilePub/newFiles?range=public&contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&idea='+idea,'<fmt:message code="global.lang.edit"/>','0','0','1500px','800px');
            })
            //查询-签阅情况点击事件
            $('#file_Tachrs').on('click','.signReading',function(){
                var idT=$(this).parents('tr').attr('contentId');
                $.popWindow('/newFilePub/signReading?contentId='+idT,'<fmt:message code="global.lang.edit"/>','50','100','1000px','700px');
            })

            //查询-编辑点击事件
            $('#file_Tachrs').on('click','.editBtn',function(){
                var idT=$(this).parents('tr').attr('contentId');
                var sortId=$(this).parents('tr').attr('sortId');
                var contype=$(this).parents('tr').attr('conType');
                var idea=$('input[name="folderId"]').attr('ireader');
                $.popWindow('/newFilePub/newFiles?range=public&contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&idea='+idea,'<fmt:message code="global.lang.edit"/>','0','0','1500px','800px');
            })
            //弹出一个页面层，查询点击事件
            $('.SEARCH').on('click', function(event){
                event.stopPropagation();
                var sortId=$('.contentTr').attr('sortId');
                var idea=$('input[name="folderId"]').attr('ireader');
                layer.open({
                    type: 1,
                    title:['<fmt:message code="global.lang.query"/>', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '320px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
                    content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 98%;">' +
                        '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subjectName" class="inputTd" value="" /></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="contentNo" class="inputTd" value="" /></td></tr>'+--%>
                        '<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+
                        '<tr><td><fmt:message code="notice.th.content" />：</td><td><input type="text" style="width: 150px;" name="contentValue1" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.separateMultipleKeywordsWithSpaces" /></span></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="contentValue2" class="inputTd" value="" /></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="contentValue3" class="inputTd" value="" /></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentDesc" class="inputTd" value="" /></td></tr>'+--%>
                        '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentName" class="inputTd" value="" /></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentCont" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="crStartDate" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="crEndDate" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+--%>
                        '</table>',
                    yes:function(index){
                        var userId=$('#userDuser').attr('user_id');
                        if(userId=='id'){
                            userId='';
                        }
                        subjectName=$('input[name="subjectName"]').val();
                        // contentNo=$('input[name="contentNo"]').val()
                        createrd=$('#userDuser').attr('user_id');
                        contentValue1=$('input[name="contentValue1"]').val()
                        // contentValue2=$('input[name="contentValue2"]').val()
                        // contentValue3=$('input[name="contentValue3"]').val()
                        atiachmentDesc=$('input[name="atiachmentDesc"]').val()
                        atiachmentName=$('input[name="atiachmentName"]').val()
                        // atiachmentCont=$('input[name="atiachmentCont"]').val()
                        // crStartDate=$('input[name="crStartDate"]').val()
                        // crEndDate=$('input[name="crEndDate"]').val()
                        queryOneData(sortId,userId,idea);
                        layer.close(index);
                        $('.mainContent').hide();
                        $('.details').show();
                    },
                });
                $('#selectUser').on("click",function(){
                    user_id='userDuser';
                    $.popWindow("../common/selectUser");
                })

            });

            //点击全局搜索按钮
            $('#overall').on('click', function(event){
                event.stopPropagation();
                var sortId=$('.contentTr').attr('sortId');
                layer.open({
                    type: 1,
                    title:['<fmt:message code="Email.th.global"/>', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '320px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
                    content: '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                        '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subject" class="inputTd" value="" /></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="sort_no" class="inputTd" value="" /></td></tr>'+--%>
                        '<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+
                        '<tr><td><fmt:message code="notice.th.content" />：</td><td><input type="text" style="width: 150px;" name="keyword1" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.separateMultipleKeywordsWithSpaces" /></span></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="keyword2" class="inputTd" value="" /></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="keyword3" class="inputTd" value="" /></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="attScript" class="inputTd" value="" /></td></tr>'+--%>
                        '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="attName" class="inputTd" value="" /></td></tr>'+
                        <%--'<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="attContain" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+--%>
                        <%--'<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="begainTime" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="endTime" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+--%>
                        '</table>',
                    success:function(){

                    },
                    yes:function(index){
                        var userId=$('#userDuser').attr('user_id');
                        if(userId=='id'){
                            userId='';
                        }
                        subject=$('input[name="subject"]').val();
                        // sort_no=$('input[name="sort_no"]').val()
                        creaters=$('#userDuser').attr('user_id');
                        keyword1=$('input[name="keyword1"]').val()
                        // keyword2=$('input[name="keyword2"]').val()
                        // keyword3=$('input[name="keyword3"]').val()
                        // attScript=$('input[name="attScript"]').val()
                        attName=$('input[name="attName"]').val()
                        // attContain=$('input[name="attContain"]').val()
                        // begainTime=$('input[name="begainTime"]').val()
                        // endTime=$('input[name="endTime"]').val();
                        sortId='';
                        contentId='';
                        queryAllData(userId);
                        layer.close(index);
                        $('.mainContent').hide();
                        $('.queryDetail').show();
                    },
                });
                $('#selectUser').on("click",function(){
                    user_id='userDuser';
                    $.popWindow("../common/selectUser");
                })

            });
            //数据列表返回点击事件
            $('.backBtn').on("click",function(){
                $('.contentTrs').remove();
                $('.mainContent').show();
                $('.details').hide();
                $('.queryDetail').hide();
                $('#noFile').hide();
            })
//    var conId;
            var copyIds='';
            var copyfileId = "";
            var state="";
            var copyCon = 0;
            //复制点击事件
            $('#copy').on("click",function(){
                copyIds=""
                if($('#copy').hasClass('copyfile')){
                    copyfileId = $('.tree-node-selected').attr('node-id');
                    state = 'one'
                }else{
                    //        conId=$('.bgcolor').attr('contentid');
                    copyCon = 1;
                    $('#copyAndShear').attr('sortId','1');
                    var zhantieVal=$('input[name="zhantieQuanxian"]').val();
                    $(".checkChild:checkbox:checked").each(function(){
                        copyIds+=$(this).attr("conid")+',';
                    })
                    if(copyIds == ''){
                        $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                    }else{
                        $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
                    }
                }

            })
            //剪切点击事件
            var fileIds='';
            var orgSortId='';
            $('#shear').on("click",function(){
                fileIds = '';
                orgSortId=$('.spanFolder').attr('data-id');
                if($('#shear').hasClass('copyfile')){
                    copyfileId = $('.tree-node-selected').attr('node-id');
                    state = 'two'
                }else{
                    copyCon = 1;
                    $('#copyAndShear').attr('sortId','2');
                    $(".checkChild:checkbox:checked").each(function(){
                        fileIds+=$(this).attr("conId")+',';
                    })
                    if(fileIds == ''){
                        $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                    }else{
                        $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
                        $('#paste').show();
                    }
                }

            })
            //粘贴点击事件
            $('#paste').on("click",function(){
                if(copyCon == 0&&$('#paste').hasClass('copyfile')){
                    if(copyIds == ''){
                        $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile" />！',icon:6});
                    }else{
                        var arr=copyfileId+','+$('.tree-node-selected').attr('node-id')
                        $.ajax({
                            url:'/newFilePri/copyFolder',
                            dataType:'json',
                            type:'get',
                            data:{
                                sortId:arr,
                                state:state
                            },
                            success:function(res){
                                if(res.flag){
                                    $.layerMsg({content:'<fmt:message code="file.th.PasteSuccessfully"/>',icon:1});
                                    reloadTree();
                                }else{
                                    $.layerMsg({content:'<fmt:message code="file.th.PasteFailed"/>',icon:1})
                                }
                            }
                        })
                    }
                }else{
                    var tId=$('#copyAndShear').attr('sortId');
                    var sortId=$('.tree-node-selected').attr('node-id');
                    var idea=$('input[name="folderId"]').attr('ireader');
                    if(tId == '1'){
                        if(copyIds == ''){
                            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                        }else{
                            data={
                                witchSortId:sortId,
                                copyId:copyIds,
                                sortType:'5'
                            }
                            copyData('/newFileContent/copyAndParse',data,sortId,idea);
                        }

                    }else if(tId == '2'){
                        if(fileIds == ''){
                            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                        }else{
                            data={
                                sortId:sortId,
                                contentId:fileIds,
                                sortType:'5',
                                orgSortId:orgSortId
                            }
                            copyData('/newFileContent/fileCut',data,sortId,idea);
                        }
                    }else{
                        $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                    }
                }
                fileIds = '';
                copyIds = '';
            })
            //签阅点击事件
            $('#singReading').on("click",function(){
                if($('#singReading').hasClass('addBackground')){
                    return false
                }
                var sortId=$('.tree-node-selected').attr('node-id');
                var idea=$('input[name="folderId"]').attr('ireader');

                var fileId='';
                $(".checkChild:checkbox:checked").each(function(){
                    fileId+=$(this).attr("conid")+',';
                })

                if(fileId.length == 0){
                    $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
                }else {
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/readFile',
                        dataType:'json',
                        data:{'contentId':fileId},
                        success:function(res){
                            if(res.flag){
                                init(sortId,idea);
                            }else{
                                $.layerMsg({content:'<fmt:message code="workflow.th.SignFailure"/>！',icon:2});
                            }
                        }
                    })
                }
            })
            //下载点击事件
            $('.FiveOne').on("click",function(){
                var text=$('input[name="sortTxt"]').val();
                var fileId=[];
                $(".checkChild:checkbox:checked").each(function(){
                    var conId=$(this).attr("conId");
                    fileId.push(conId);
                })
                if(fileId == ''){
                    $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
                    return false;
                }else{
                    window.location.href='../file/downFileContent?contentId='+fileId+'&sortName='+text;
                }
            })
            //文件操作
            $('#TitleOne').on("click",function(e){
                e.stopPropagation();
                var pid=$('input[name="paid"]').val();
                $('#classA').toggle();
                if(pid != 0){
                    $('.second').show();
                }else{

                    $('.second').hide();
                }
            })
            $(document).on('click',function(){
                if($('#classA').css('display')=='block'){
                    $('#classA').css('display','none');
                }
            })
            //新建子文件夹页面显示
            $('#newChild').on("click",function(){
                $('.newAddFolder').show().siblings().hide();
                $('input[name="polderName"]').focus();
            })
            //新建子文件夹页面确定按钮
            $('#btnSure').on("click",function(){
                var sortParent=$('input[name="folderId"]').val();
                var idea=$('input[name="folderId"]').attr('ireader');
                var editData=$('input[name="folderId"]').attr('editdata');
                if($('input[name="polderName"]').val() != ''){
                    var data={
                        'sortType':5,
                        'sortParent':sortParent,
                        'sortNo':$('input[name="serial"]').val(),
                        'sortName':$('input[name="polderName"]').val()
                    }
                    if($('input[name="serial"]').val() == '' || $('input[name="polderName"]').val() == ''){
                        $.layerMsg({content:'<fmt:message code="doc.th.sortNumber"/>！',icon:2});
                        return false;
                    }
                    if (isNaN($('input[name="serial"]').val())) {
                        $.layerMsg({content:'<fmt:message code="doc.th.number"/>！',icon:2});
                        $('input[name="serial"]').focus();
                        return false;
                    }
                    $.ajax({
                        type:'post',
                        url:'/newFilePub/addPubSort',
                        dataType:'json',
                        data:data,
                        success:function(res){
                            if(res.flag){
                                layer.confirm('<fmt:message code="file.th.creationSuccessfulSetPermissions" />',{icon:0},function(index){
                                    window.open('/newFilePub/tempHome?sortId='+res.obj)
                                    layer.close(index)
//                        $('input[name="serial"]').val('');
                                    $('input[name="polderName"]').val('');
                                    $('.mainContent').show();
                                    $('.newAddFolder').hide();
//                                     // reloadTree();
//                                     // $("#li_parent").tree("reload",$(".tree-node-selected"))
                                    var idss = $(".tree-node-selected").attr("node-id")
                                    var selectNode = $("#li_parent").tree('find',idss);
                                    $("#li_parent").tree('reload',selectNode.target);
                                    // $('.tree-node[node-id='+ idss +']').click();
                                    // init(sortParent,idea,editData);
                                },function(index){
                                    //                        $('input[name="serial"]').val('');
                                    $('input[name="polderName"]').val('');
                                    $('.mainContent').show();
                                    $('.newAddFolder').hide();
//                                     // reloadTree();
//                                     // $("#li_parent").tree("reload",$(".tree-node-selected"))
                                    var idss = $(".tree-node-selected").attr("node-id")
                                    var selectNode = $("#li_parent").tree('find',idss);
                                    $("#li_parent").tree('reload',selectNode.target);
                                    // $('.tree-node[node-id='+ idss +']').click();
                                    // init(sortParent,idea,editData);
                                });
                            }else {
                                $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed"/>！',icon:2});
                            }
                        }
                    })
                }else{
                    alert('<fmt:message code="workflow.th.folderNameCannotBeEmpty"/>！')
                }
            })
            /*------------------------------------------------------------------*/
            //查询列表删除
            function dataDeleteOne(fileId,sortId,id){
                layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                    title:"<fmt:message code="notice.th.DeleteFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/batchDeleteConId',
                        dataType:'json',
                        data:{'fileId':fileId},
                        success:function(res){
                            if(res.flag){
                                layer.msg(res.msg, { icon:1});
                            }else{
                                layer.msg(res.msg, { icon:0});
                            }

                            queryOneData(sortId,id);
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            }
            //查询列表方法
            function queryOneData(sortId,id,iReder){
                var ajaxPage={
                    data:{
                        'sortId':sortId,
                        'pageNo':0,
                        'pageSize':10,
                        'subjectName':$('input[name="subjectName"]').val(),
                        'contentNo':$('input[name="contentNo"]').val(),
                        'creater':id,
                        'contentValue1':$('input[name="contentValue1"]').val(),
                        'contentValue2':$('input[name="contentValue2"]').val(),
                        'contentValue3':$('input[name="contentValue3"]').val(),
                        'atiachmentDesc':$('input[name="atiachmentDesc"]').val(),
                        'atiachmentName':$('input[name="atiachmentName"]').val(),
                        'atiachmentCont':$('input[name="atiachmentCont"]').val(),
                        'crStartDate':$('input[name="crStartDate"]').val(),
                        'crEndDate':$('input[name="crEndDate"]').val(),
                        'sortType':'5'
                    },
                    page:function () {
                        var me=this;
                        $.ajax({
                            type:'post',
                            url:'/newFileContent/queryFile',
                            dataType:'json',
                            data:me.data,
                            success:function(res){
                                $('#file_Tachrs').find('tr').remove();
                                var data1=res.datas;
                                var str = '';
                                var files = '';
                                var downUser=$('input[name="down-user"]').val();
                                var arr1=[]
                                for(var m=0;m<data1.length;m++){
                                    if(data1[m].attachmentList != 'undefined'){
                                        arr1.push(data1[m].attachmentList[0]);
                                    }

                                }
                                for(var i=0;i<data1.length;i++){
                                    var arr=data1[i].attachmentList;
                                    if(data1[i].attachmentList!='' && data1[i].attachmentList!= undefined){

//                                        var str1='';
                                        <%--for(var j=0;j<arr.length;j++){--%>
                                        <%--//                                            var iconType='';--%>
                                        <%--//                                            if(GetFileExt(arr[j].attachName) == '.docx' || GetFileExt(arr[j].attachName) == '.doc' || GetFileExt(arr[j].attachName) == '.DOC' || GetFileExt(arr[j].attachName) == '.DOCX' || GetFileExt(arr[j].attachName) == '.word' || GetFileExt(arr[j].attachName) == '.WORD'){--%>
                                        <%--//                                                iconType='word';--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.pptx' || GetFileExt(arr[j].attachName) == '.ppt'){--%>
                                        <%--//                                                iconType='ppt';--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.xlsx' || GetFileExt(arr[j].attachName) == '.xls'){--%>
                                        <%--//                                                iconType='excel';--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.pdf'){--%>
                                        <%--//                                                iconType='pdf';--%>
                                        <%--////                                            iconType=GetFileExt(arr[j].attachName).replace('.', "")--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.exe'){--%>
                                        <%--//                                                iconType='exe';--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.jpg' || GetFileExt(arr[j].attachName) == '.png'){--%>
                                        <%--//                                                iconType='pic';--%>
                                        <%--//                                            }else if(GetFileExt(arr[j].attachName) == '.rar' || GetFileExt(arr[j].attachName) == '.zip'){--%>
                                        <%--//                                                iconType='zip';--%>
                                        <%--//                                            }else {--%>
                                        <%--//                                                iconType='file';--%>
                                        <%--//                                            }--%>

                                        <%--//                                            var attUrl_s = arr[j].attUrl;--%>
                                        <%--//--%>
                                        <%--//                                            var attName = encodeURI(arr[j].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26");--%>
                                        <%--//--%>
                                        <%--//                                            attUrl_s = attUrl_s.substring(0,attUrl_s.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName;--%>
                                        <%--&lt;%&ndash;if(downUser == '1'){&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;&lt;%&ndash;if(GetFileExt(arr[j].attachName) == '.pdf' || GetFileExt(arr[j].attachName) == '.PDF'){&ndash;%&gt;&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;&lt;%&ndash;str1+='<a href="/download?'+encodeURI(arr[j].attUrl)+'" class="fujian" style="display:block;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a>';&ndash;%&gt;&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;&lt;%&ndash;}&ndash;%&gt;&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;str1+='<a href="/download?'+encodeURI(attUrl_s)+'" class="fujian" style="display:block;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a>';&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;}else{&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;str1+='<a href="javascript:;" class="fujian" style="display:block;color:#000;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title="'+arr[j].attachName+'"><img style="width:18px;height:22px;margin-right:5px;" src="../img/attachmentIcon/'+iconType+'.png"/>'+arr[j].attachName+'</a>';&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;}&ndash;%&gt;--%>
                                        <%--}--%>
                                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td>"+attachView(arr,'','3',$('input[name="editQuanxian"]').val(),$('input[name="exportQuanxian"]').val(),'0',arr1,'wenjiangui')+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td>";
                                        if(iReder == '1'){
                                            str+="<a href='javascript:;' class='signReading' style='margin-right: 10px;'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                        }
                                        if(data1[i].attributes.MANAGE_USER == 1){ //编辑权限
                                            str+="<a href='javascript:;' class='editBtn'><fmt:message code='global.lang.edit'/></a></td></tr>"
                                        }

                                    }else{
                                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE'  style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td>";
                                        if(iReder == '1'){
                                            str+="<a href='javascript:;' class='signReading' style='margin-right: 10px;'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                        }
                                        <%--str+="<a href='javascript:;' class='editBtn'><fmt:message code='global.lang.edit'/></a></td></tr>"--%>
                                    }
                                }
                                $('#file_Tachrs').html(str);
                                me.pageTwo(res.total,me.data.pageSize,me.data.page)
                                $(".contentTrs").click(function () {
                                    var state=$(this).find('.checkChildren').prop("checked");
                                    if(state==true){
                                        $(this).find('.checkChildren').prop("checked",true);
                                        $(this).addClass('bgcolor');
                                        $('#queryDelete').removeClass('addBackground');
                                    }else{
                                        $('#checkedAlls').prop("checked",false);
                                        $(this).find('.checkChildren').prop("checked",false);
                                        $(this).removeClass('bgcolor');
                                        $('#queryDelete').addClass('addBackground');
                                    }
                                    var child =   $(".checkChildren");
                                    for(var i=0;i<child.length;i++){
                                        var childstate= $(child[i]).prop("checked");
                                        if(state!=childstate){
                                            return
                                        }
                                    }
                                    $('#checkedAlls').prop("checked",state);
                                })
                                $('#queryDelete').addClass('addBackground');

                                $('#checkedAlls').prop("checked",false);
                            }
                        })

                    },
                    pageTwo:function (totalData, pageSize,indexs) {
                        var mes=this;
                        $('#dbgz_pages').pagination({
                            totalData: totalData,
                            showData: pageSize,
                            jump: true,
                            coping: true,
                            homePage:'',
                            endPage: '',
                            current:indexs||1,
                            callback: function (index) {
                                mes.data.page=index.getCurrent();
                                mes.page();
                            }
                        });
                    }
                }
                ajaxPage.page();
            }
            /*-----------------------------------------------------------------------------------*/
            //全局搜索删除列表
            function dataDeleteAll(fileId,id){
                layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                    title:"<fmt:message code="notice.th.DeleteFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/batchDeleteConId',
                        dataType:'json',
                        data:{'fileId':fileId},
                        success:function(res){
                            if(res.flag){
                                layer.msg(res.msg, { icon:1});
                            }else{
                                layer.msg(res.msg, { icon:0});
                            }
                            sortId='';
                            queryAllData(id);
                        }
                    })

                }, function(){
                    layer.closeAll();
                });

            }
            //全局搜索列表方法
            function queryAllData(id){
                var ajaxPage={
                    data:{
                        contentId:contentId,
                        sortType:'5',
                        page:1,
                        pageSize:10,
                        useFlag:true,
                        'serachType':'2',
                        'subject':$('input[name="subject"]').val(),
                        'sort_no':$('input[name="sort_no"]').val(),
                        'creater':id,
                        'keyword1':$('input[name="keyword1"]').val(),
                        'keyword2':$('input[name="keyword2"]').val(),
                        'keyword3':$('input[name="keyword3"]').val(),
                        'attScript':$('input[name="attScript"]').val(),
                        'attName':$('input[name="attName"]').val(),
                        'attContain':$('input[name="attContain"]').val(),
                        'begainTime':$('input[name="begainTime"]').val(),
                        'endTime':$('input[name="endTime"]').val(),
                    },
                    page:function () {
                        var me=this;
                        $.ajax({
                            type:'post',
                            url:'/newFileContent/serachAll',
                            dataType:'json',
                            data:me.data,
                            success:function(res){
                                $('#file_Tach').find('tr').remove();
                                var data1=res.obj;
                                var str='';
                                var arr=new Array();
                                for(var i=0;i<data1.length;i++){
                                    var stra='';
                                    arr=data1[i].attachmentList;
                                    if(data1[i].attachmentName!=''){
                                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;"  style="color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td>'+ attachView(data1[i].attachmentList, '', '3', data1[i].mapPriv.MANAGE_USER, data1[i].mapPriv.DOWN_USER, '0', data1[i].attachmentList, 'wenjiangui') +'</td><td>'+function () {
                                            if(data1[i].attachmentDesc != undefined){
                                                return data1[i].attachmentDesc;
                                            }else {
                                                return '';
                                            }
                                        }()+'</td><td>'+data1[i].sendTime+'</td><td>';
                                        if(data1[i].mapPriv.MANAGE_USER == 1){
                                            str+='<a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                                        }
                                        if(data1[i].mapPriv.SIGN_USER == 1){
                                            str+='<a href="javascript:;" class="signReading"><fmt:message code="meet.th.ReadingStatus"/></a>';
                                        }
                                        str+='</td></tr>';
                                    }else {
                                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;"   style="color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td></td><td>'+function () {
                                            if(data1[i].attachmentDesc != undefined){
                                                return data1[i].attachmentDesc;
                                            } else{
                                                return '';
                                            }
                                        }()+'</td><td>'+data1[i].sendTime+'</td><td>';
                                        if(data1[i].mapPriv.MANAGE_USER == 1){
                                            str+='<a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                                        }
                                        if(data1[i].mapPriv.SIGN_USER == 1){
                                            str+='<a href="javascript:;" class="signReading"><fmt:message code="meet.th.ReadingStatus"/></a>';
                                        }
                                        str+='</td></tr>';
                                    }
                                }
                                $('#file_Tach').html(str);
                                me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                                $(".contentT").on("click",function () {
                                    var state=$(this).find('.checkChildren').prop("checked");
                                    if(state==true){
                                        $(this).find('.checkChildren').prop("checked",true);
                                        $(this).addClass('bgcolor');
                                    }else{
                                        $('#checkedAllY').prop("checked",false);
                                        $(this).find('.checkChildren').prop("checked",false);
                                        $(this).removeClass('bgcolor');
                                    }
                                    if($('#file_Tach .checkChildren:checked').length != 0){
                                        $('#deleteAll').removeClass('addBackground');
                                    }else{
                                        $('#deleteAll').addClass('addBackground');
                                    }
                                    var child =   $(".checkChildren");
                                    for(var i=0;i<child.length;i++){
                                        var childstate= $(child[i]).prop("checked");
                                        if(state!=childstate){
                                            return
                                        }
                                    }
                                    $('#checkedAllY').prop("checked",state);
                                })
                                $('#deleteAll').addClass('addBackground');

                                $('#checkedAllY').prop("checked",false);
                            }
                        })
                    },
                    pageTwo:function (totalData, pageSize,indexs) {
                        var mes=this;
                        $('#dbgz_pagesd').pagination({
                            totalData: totalData,
                            showData: pageSize,
                            jump: true,
                            coping: true,
                            homePage:'',
                            endPage: '',
                            current:indexs||1,
                            callback: function (index) {
                                mes.data.page=index.getCurrent();
                                mes.page();
                            }
                        });
                    }
                }
                ajaxPage.page();
            }
            /*-------------------------------------------------------------------------------*/

            //新建子文件夹页面返回按钮
            $('#btnBack').on("click",function(){
//        $('input[name="serial"]').val('');
                $('input[name="polderName"]').val('');
                $('.mainContent').show();
                $('.newAddFolder').hide();
            })
            //编辑页面显示
            $('#editFile').on("click",function(){
                $('.editAddFolder').show().siblings().hide();
                var sortId=$('input[name="folderId"]').val();
                $.ajax({
                    type:'get',
                    url:'../file/fileGetOne',
                    dataType:'json',
                    data:{'sortId':sortId},
                    success:function(res){
                        var data=res.object;
                        $('input[name="edSerial"]').val('');
                        $('input[name="edPolderName"]').val('');

                        $('input[name="edSerial"]').val(data.sortNo);
                        $('input[name="edPolderName"]').val(data.sortName);
                    }
                })
            })
            //编辑页面确定按钮
            $('#editSure').on("click",function(){
                var sortId=$('input[name="folderId"]').val();
                var idea=$('input[name="folderId"]').attr('ireader');
                var editData=$('input[name="folderId"]').attr('editdata');
                if($('input[name="edPolderName"]').val() == ''){
                    alert('文件夹名称不得为空！');
                }else{
                    var data={
                        'sortId':sortId,
                        'sortNo':$('input[name="edSerial"]').val(),
                        'sortName':$('input[name="edPolderName"]').val()
                    }
                    $.ajax({
                        type:'post',
                        url:'/newFilePub/updPubSort',
                        dataType:'json',
                        data:data,
                        success:function(res){
                            if(res.flag){
                                $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                                    $('.editAddFolder').hide();
                                    $('.mainContent').show();
                                    init(sortId,idea,editData);
                                    reloadTree();
                                });
                            }else{
                                $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed"/>！',icon:2},function(){

                                });
                            }
                        }
                    })
                }
            })
            //设置权限按钮
            $('#setting').on("click",function(){
                var sortId=$('.tree-node-selected').attr('node-id');
                $.popWindow('/newFilePub/tempHome?sortId='+sortId+'','<fmt:message code="netdisk.th.PermissionSetting"/>','0','0','1500px','800px');
            })
            //编辑页面返回按钮
            $('#editBack').on("click",function(){
                $('input[name="edSerial"]').val('');
                $('input[name="edPolderName"]').val('');
                $('.editAddFolder').hide();
                $('.mainContent').show();
            })
            //删除子文件夹按钮
            $('#deleteFile').on("click",function(){
                var sortId=$('input[name="folderId"]').val();
                var idea=$('input[name="folderId"]').attr('ireader');
                var editData=$('input[name="folderId"]').attr('editdata');
                layer.confirm('<fmt:message code="sys.th.commit"/>！', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                    title:"<fmt:message code="notice.th.DeleteFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFilePub/delPubSort',
                        dataType:'json',
                        data:{'sortId':sortId},
                        success:function(res){
                            if(res.flag == true){
//                        $('.details').hide();
//                        $('.newAddFolder').hide();
//                        $('.editAddFolder').hide();
//                        $('.mainContent').show();
                                layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                                // init(1,idea,editData);
                                // reloadTree();
                                var idss = $(".tree-node-selected").parent().parent().siblings().attr("node-id")
                                var selectNode = $("#li_parent").tree('find',idss);
                                $("#li_parent").tree('reload',selectNode.target);
                            }else{
                                layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:5});
                            }
                        }
                    });

                }, function(){
                    layer.closeAll();
                });
            })
            var user_id='dePsenduser';
            $(function(){
                //选人控件
                $("#selectUserDep").on("click",function(){
                    user_id='dePsenduser';
                    $.popWindow("../common/selectUser");
                });
                //清空所选人员
                $('.clear').on("click",function(){
                    $('#dePsenduser').val('');
                    $('#dePsenduser').attr('user_id','');
                })

                $('#uploadinputimg').change(function(){
                    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
                    var isOpera = userAgent.indexOf("Opera") > -1;
                    $(".attach").show();
                    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){
                        var src = $(this).target || window.event.srcElement; //获取事件源，兼容chrome/IE
                        var filename = src.value;
                        var str = filename.substring(filename.lastIndexOf('\\') + 1);
                        $('.box').html(str);
                    }else{
                        var arr=$(this)[0].files;
                        var length = arr.length;
                        var str='';
                        for(var i=0;i<arr.length;i++){
                            str+='<p>'+arr[i].name+'</p>';
                        }
                        $('.box').html(str);
                    }

                })


                $('#start').on("click",function(){
                    var index = layer.load(3, {
                        shade: [0.1,'#fff'] //0.1透明度的白色背景
                    });
                    var sortId=$('[name="sortId"]').val();
                    var idea=$('input[name="folderId"]').attr('ireader');
                    var editData=$('input[name="folderId"]').attr('editdata');
                    var remindVal=0;
                    if($('.remindCheck').is(":checked")){
                        remindVal=1;
                    }
                    var smsDefault =1;
                    if($('.smsDefault').is(":checked")){
                        smsDefault=0;
                    }
                    $('#uploadimgform').ajaxSubmit({
                        dataType:'json',
                        data:{
                            sortType:'5',
                            remind:remindVal,//事务提醒
                            smsDefault:smsDefault //手机提醒
                        },
                        success:function (res) {
                            if(res.flag == true){
                                $('.box').children().remove();
                                $('.attach').hide();
                                init(sortId,idea,editData);
                                layer.close(index);
                            }else {
                                if(res.msg == 'notEnough'){
                                    layer.msg('<fmt:message code="workflow.th.InsufficientFolderCapacity"/>！', {icon: 2});
                                    $('.box').children().remove();
                                    $('.attach').hide();
                                    layer.close(index);
                                }else{
                                    layer.msg('<fmt:message code="file.th.uploadFailed" />！'+res.msg+'<fmt:message code="file.th.emptyFileHasNotBeenUploaded" />', {icon: 2});
                                    $('.box').children().remove();
                                    $('.attach').hide();
                                    layer.close(index);
                                }
                            }
                        }
                    })
                })
                // 文件编辑
                $("#file_Tachr").on('click','.editBoxBtn',function(){
                    var idT=$(this).parents('tr').attr('contentId');
                    var sortId=$(this).parents('tr').attr('sortId');
                    <%--$.popWindow('/file/contentAdd?contentId='+idT+'&sortId='+sortId,'编辑','100','300','860px','500px');--%>
                    var contype=$(this).parents('tr').attr('conType');
                    var idea=$('input[name="folderId"]').attr('ireader');
                    $.popWindow('/newFilePub/newFiles?range=public&contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&idea='+idea,'<fmt:message code="global.lang.edit"/>','0','0','1500px','800px');
                })

                //全部取消点击事件
                $('.cancle').on("click",function(){
                    $('.box').children().remove();
                    $('.attach').hide();
                })

            })

            function reloadTree(fn) {
                $('#li_parent').tree({
                    url: '/newFilePub/getNewAllPrivateFile?sortId=0',
                    animate:true,
                    lines: false,
                    loadFilter: function(rows){
                        var arr = convert(rows.datas);
                        return arr;
                    },
                    onLoadSuccess: function (row, data) {
                        for(var i=0;i<data.length;i++){
                            var node = $("#li_parent").tree("find",data[i].id);//找到id对应的节点
                            $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                            if(data[i].children!=undefined){
                                buildNode(data[i].children)
                            }
                        }

                        if(typeof fn != undefined&&index){
                            index = false;
                            fn();
                        }
                    },
                    onClick:function(node){
                        $('.spanFolder').html(node.text);
                        $('.spanFolder').attr('data-id',node.id);
                        $('.spanFolder').attr('title',node.text);
                        $('#noFile').hide();
                        $('.details').hide();
                        $('.queryDetail').hide();
                        $('.mainContent').show();
                        $('.editAddFolder').hide();
                        init(node.id);
                        $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                        node.state = node.state === 'closed' ? 'open' : 'closed';
                        $('input[name="sortTxt"]').val('');
                        $('input[name="folderId"]').val('');
                        $('input[name="paid"]').val('');


                    },
                    onBeforeExpand:function(node,param){
                        $('#li_parent').tree('options').url = '/newFilePub/getNewAllPrivateFile?sortId='+node.id;// change the url
                        $.ajax({
                            type:'post',
                            url:'/newFilePub/downloadRights',
                            dataType:'json',
                            data:{sortId:node.id},
                            success:function(res){
                                if(res.totleNum > 0){
                                    $(".download").hide();
                                }
                            }
                        })
                    }

                });
            }

            function buildNode(data){
                $.each(data,function(i,item){

                    if(item.children!= undefined && 0 < item.children.length){
                        var node = $("#fileTree").tree("find",data[i].id);//找到id对应的节点
                        $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                        buildNode(item.children);
                    }else{
                        var node = $("#fileTree").tree("find",data[i].id);//找到id对应的节点
                        $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                    }
                });
            }

            function TreeNode(id,text,state,children){
                this.id = id;
                this.text = text;
                this.state = state;
                this.children = children;
            }

            function convert(data){
                var arr = [];
                data.forEach(function(v,i){
                    if(v.sortName){
                        var node = new TreeNode(v.sortId,v.sortName,"closed")
                        arr.push(node);
                    }
                });
                return arr;
            }

            function copyData(url,data,sortId,iReader,editdatas){
//        var sortId=$('.tree-node-selected').attr('node-id');
                $.ajax({
                    type:'post',
                    url:url,
                    dataType:'json',
                    data:data,
                    success:function(res){
                        if(res.flag==true){
                            $.layerMsg({content:'<fmt:message code="file.th.PasteSuccessfully"/>！',icon:1},function(){
                                init(sortId,iReader,editdatas);
                            });
                        }else{
                            if(res.msg == 'notEnough'){
                                layer.msg('<fmt:message code="workflow.th.InsufficientFolderCapacity"/>！', {icon: 2});
                            }else{
                                layer.msg('<fmt:message code="file.th.PasteFailed"/>！', {icon: 2});
                            }
                        }
                    }
                })
            }

            function dataDelete(fileId,id,iReader,editdatas){
                layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                    title:"<fmt:message code="notice.th.DeleteFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/batchDeleteConId',
                        dataType:'json',
                        data:{
                            'fileId':fileId,
                            sortType:'5'
                        },
                        success:function(res){
                            if(res.flag){
                                layer.msg(res.msg, { icon:1});
                            }else{
                                layer.msg(res.msg, { icon:0});
                            }
                            init(id,iReader,editdatas);
                        }
                    })

                }, function(){
                    layer.closeAll();
                });

            }



        });
        //当窗口变大或变小时，重置高度
        $(window).resize(function() {
            var Height=$('body').height()-2;
            $('.cabinet_left').height(Height);
        });

        var fileNamesArr = new Array();//文件名数组
        var fileTime1 = []
        function init(id,iReder,editData) {
            var ajaxPage={
                data:{
                    sortId:id,
                    page:1,//当前处于第几页
                    pageSize:10,//一页显示几条
                    useFlag:true,
                    sortType:5
                },
                page:function () {
                    $('.contentTr').remove();
                    fileTime1 = []
                    var me=this;
                    $.ajax({
                        type:'post',
                        url:'/newFileContent/getContentById',
                        dataType:'json',
                        data:me.data,
                        page:1,//当前处于第几页
                        pageSize:10,//一页显示几条
                        useFlag:true,
                        success:function(res){
                            var deptn = $.cookie('deptId');
                            var rolen = $.cookie('userPriv');
                            var usern = $.cookie('userId');
                            //有新权限的dept,role,user（没有新权限不展示：新建文件，批量上传，粘贴按钮）

                            //OWNER所有者(新建，编辑，删除，下载)
                            if(res.object.attributes.NEW_USER==1 || res.object.attributes.OWNER == 1){//新建权限
                                $('#newsAdd').show();//新建
                                $('#batch').show();
                            }else{
                                $('#newsAdd').hide();//新建
                                $('#batch').hide();
                            }
                            if(res.object.attributes.NEW_USER==1){//新建权限（新建文件，批量上传，粘贴）
                                $('#batch').show();
                                $('#paste').show();
                                $('#newChild').show();//新建子文件夹
                            }else{
                                $('#batch').hide();
                                $('#paste').hide();
                                $('#newChild').hide();//新建子文件夹
                            }

                            if(res.object.attributes.MANAGE_USER==1 || res.object.attributes.OWNER == 1){//编辑权限
                                $('#copy').show(); // 显示复制按钮
                                $('#editFile').show();
                                $('input[name="editQuanxian"]').val('1');
                            }else{
                                $('#copy').hide(); // 隐藏复制按钮
                                $('#editFile').hide();
                                $('input[name="editQuanxian"]').val('0');
                            }
                            var privId = $.cookie("userPriv");
                            if((res.object.attributes.DEL_USER==1 && privId == 1)|| res.object.attributes.OWNER == 1) {
                                $('#deleteFile').show();
                            }else {
                                $('#deleteFile').hide();
                            }
                            if(res.object.attributes.DEL_USER==1 || res.object.attributes.OWNER == 1){//删除权限
                                $('#deletebtn').show();
                                $('#shear').show();
                                $('input[name="deleteQuanxian"]').val('1');
                            }else{
                                $('#deletebtn').hide();
                                $('#shear').hide();
                                $('input[name="deleteQuanxian"]').val('0');
                            }
                            if(res.object.attributes.DOWN_USER == 1 || res.object.attributes.OWNER == 1){ //下载权限
                                $('#downloads').show();
                                $('input[name="exportQuanxian"]').val('1');
                            }else{
                                $('#downloads').hide();
                                $('input[name="exportQuanxian"]').val('0');
                            }
                            if(res.object.attributes.SIGN_USER == 1){  //签阅权限
                                $('#singReading').show();
                                $('input[name="qianyueQuanxian"]').val('1');
                            }else{
                                $('#singReading').hide();
                                $('input[name="qianyueQuanxian"]').val('0');
                            }

                            if(res.object.attributes.REVIEW == 1){ //评论权限
                                $('input[name="reviewQuanxian"]').val('1');
                            }else{
                                $('input[name="reviewQuanxian"]').val('0');
                            }

                            var roleold = res.object.newUser1.role.substring(0, res.object.newUser1.role.lastIndexOf(',')).split(",");
                            var userold = res.object.newUser1.user.substring(0, res.object.newUser1.user.lastIndexOf(',')).split(",");
                            //当前登录人的dept,role,user
                            var userAgent = navigator.userAgent;
                            if(userAgent.indexOf('QtWebEngine') > -1){
                                $.ajax({
                                    url: '/Meetequipment/getuser',
                                    type: 'get',
                                    dataType: 'json',
                                    async: false,
                                    success: function (res) {
                                        $.setCookie(res.object);
                                    }
                                })
                            }

                            var roleold = res.object.newUser1.role.substring(0, res.object.newUser1.role.lastIndexOf(',')).split(",");
                            var userold = res.object.newUser1.user.substring(0, res.object.newUser1.user.lastIndexOf(',')).split(",");
                            //当前登录人的dept,role,user
                            var userAgent = navigator.userAgent;
                            if(userAgent.indexOf('QtWebEngine') > -1){
                                $.ajax({
                                    url: '/Meetequipment/getuser',
                                    type: 'get',
                                    dataType: 'json',
                                    async: false,
                                    success: function (res) {
                                        $.setCookie(res.object);
                                    }
                                })
                            }

                            var data=res.object.contentList;
                            var nodeData=res.object;
                            var files='';
                            var arr=new Array();
                            var datasArr = new Array();

                            for(var i=0;i<data.length;i++){
                                fileTime1.push(data[i].sendTime.split(' ')[0])
                                // console.log(typeof(data[i].attachmentList) != 'undefined')
                                if(data[i].attachmentList != undefined && data[i].attachmentList!=''){
                                    datasArr.push(data[i].attachmentList);
                                }
                            }
                            datasArr.forEach((elem, index) => {
                                for(var j=0; j<elem.length; j++){
                                    fileNamesArr.push(elem[j].attachId+ '.' +elem[j].attachName);
                                }
                            });
                            // console.log(fileNamesArr)



                            $('input[name="sortTxt"]').val(nodeData.text);
                            // console.log("111111111111111111111111");
                            // console.log(nodeData);
                            $('input[name="paid"]').val(nodeData.attributes.pid);
                            nodeData.attributes.pid == "0" ? $('.second').hide() : $('.second').show();

                            $('input[name="folderId"]').val(nodeData.sortId);
                            ireaeders=$('input[name="folderId"]').attr('iReader',nodeData.attributes.SIGN_USER);
                            editdatas=$('input[name="folderId"]').attr('editdata',nodeData.attributes.MANAGE_USER);
                            var downUser=nodeData.attributes.DOWN_USER;
                            var arr1=[];
                            if(data.length > 0 ){
                                for(var m=0;m<data.length;m++){
                                    if(data[m].attachmentList != undefined){
                                        arr1.push(data[m].attachmentList[0]);
                                    }
                                }
                                for(var i=0;i<data.length;i++){

                                    var str1='';
                                    var editBox='';
                                    var attachId = ''
                                    if($('input[name="editQuanxian"]').val() == '1'){
                                        editBox='<a href="javascript:;" class="editBoxBtn" style="margin-left: 10px;"><fmt:message code="global.lang.edit"/></a>';
                                    }else{
                                        editBox='';
                                    }
                                    if(data[i].attachmentName!=''){
                                        arr=data[i].attachmentList;
                                        if(data[i].isRead == 0){
                                            if(data[i].attachmentList.length != 0) {
                                                if (nodeData.attributes.OWNER == 1) {
                                                    files += "  <tr class='contentTr' sortId='" + data[i].sortId + "' TYPE='" + data[i].fileType + "' contentId='" + data[i].contentId + "' data-isread='" + data[i].isRead + "' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='" + data[i].contentId + "' path ='" + data[i].attachmentList[0].attachName + "' name=\"check\" value=\"\" ><a class='TITLE' href='javascript:;' title='" + data[i].attachmentList[0].attachName + "'  style='color:#54b6fe;'> <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 4px;margin-top:3px;vertical-align: top;'>" + data[i].subject + "  </a></td>  <td>" + attachView(arr, '', '3', '1', '1', '0', arr1, 'wenjiangui') + "</td> <td> " + data[i].sendTime + "  </td><td> " + data[i].contentNo + "  </td><td>";
                                                }else {
                                                    files += "  <tr class='contentTr' sortId='" + data[i].sortId + "' TYPE='" + data[i].fileType + "' contentId='" + data[i].contentId + "' data-isread='" + data[i].isRead + "' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='" + data[i].contentId + "' path ='" + data[i].attachmentList[0].attachName + "' name=\"check\" value=\"\" ><a class='TITLE' href='javascript:;' title='" + data[i].attachmentList[0].attachName + "'  style='color:#54b6fe;'> <img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 4px;margin-top:3px;vertical-align: top;'>" + data[i].subject + "  </a></td>  <td>" + attachView(arr, '', '3', nodeData.attributes.MANAGE_USER, nodeData.attributes.DOWN_USER, '0', arr1, 'wenjiangui') + "</td> <td> " + data[i].sendTime + "  </td><td> " + data[i].contentNo + "  </td><td>";
                                                }
                                            }
                                            if(nodeData.attributes.SIGN_USER == 1){
                                                files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                            }
                                            files+=editBox+"</td></tr>"
                                        }else{
                                            if(data[i].attachmentList.length != 0) {
                                                if (nodeData.attributes.OWNER == 1) {
                                                    files += "  <tr class='contentTr' sortId='" + data[i].sortId + "' TYPE='" + data[i].fileType + "' contentId='" + data[i].contentId + "' data-isread='" + data[i].isRead + "' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='" + data[i].contentId + "' path ='" + data[i].attachmentList[0].attachName + "' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;'   title ='" + data[i].attachmentList[0].attachName + "' style='color:#54b6fe;'>" + data[i].subject + "  </a></td>  <td>" + attachView(arr, '', '3', '1', '1', '0', arr1, 'wenjiangui') + "</td> <td> " + data[i].sendTime + "  </td><td> " + data[i].contentNo + "  </td><td>";
                                                }else {
                                                    files += "  <tr class='contentTr' sortId='" + data[i].sortId + "' TYPE='" + data[i].fileType + "' contentId='" + data[i].contentId + "' data-isread='" + data[i].isRead + "' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='" + data[i].contentId + "' path ='" + data[i].attachmentList[0].attachName + "' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;'   title ='" + data[i].attachmentList[0].attachName + "' style='color:#54b6fe;'>" + data[i].subject + "  </a></td>  <td>" + attachView(arr, '', '3', nodeData.attributes.MANAGE_USER, nodeData.attributes.DOWN_USER, '0', arr1, 'wenjiangui') + "</td> <td> " + data[i].sendTime + "  </td><td> " + data[i].contentNo + "  </td><td>";
                                                }
                                            }
                                            if(nodeData.attributes.SIGN_USER == 1){
                                                files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                            }
                                            files+=editBox+"</td></tr>"
                                        }
                                    }else{
                                        if(data[i].isRead == 0){
                                            if(data[i].attachmentList != undefined){
                                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' data-isread='"+data[i].isRead+"' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='"+data[i].contentId+"' path ='"+data[i].attachmentList[0].attachName+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' title ='"+data[i].attachmentList[0].attachName+"'  style='color:#54b6fe;'><img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 4px;margin-top: 3px;vertical-align: top;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td>";
                                            }else{
                                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' data-isread='"+data[i].isRead+"' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;'  style='color:#54b6fe;'><img src='../img/file/icon_notread_1_03.png' style='width: 16px;height: 16px;margin-left: 4px;margin-top: 3px;vertical-align: top;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td>";
                                            }
                                            if(nodeData.attributes.SIGN_USER == 1){
                                                files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                            }
                                            files+=editBox+"</td></tr>"
                                        }else{
                                            if(data[i].attachmentList != undefined) {
                                                files += "  <tr class='contentTr' sortId='" + data[i].sortId + "' TYPE='" + data[i].fileType + "' contentId='" + data[i].contentId + "' data-isread='" + data[i].isRead + "' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='" + data[i].contentId + "' path ='" + data[i].attachmentList[0].attachName + "' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;' title ='" + data[i].attachmentList[0].attachName + "' style='color:#54b6fe;'>" + data[i].subject + "  </a></td>  <td><a href='javascript:;'></a></td> <td> " + data[i].sendTime + "  </td><td> " + data[i].contentNo + "  </td><td>";
                                            }else{
                                                files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' data-isread='"+data[i].isRead+"' conType='1'><td><input class=\"checkChild\" style='margin-top: -2px;vertical-align: top' type=\"checkbox\" conId='"+data[i].contentId+"' name=\"check\" value=\"\" > <a class='TITLE' href='javascript:;'  style='color:#54b6fe;'>"+data[i].subject+ "  </a></td>  <td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td><td> "+data[i].contentNo+ "  </td><td>";
                                            }
                                            if(nodeData.attributes.SIGN_USER == 1){
                                                files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                                            }
                                            files+=editBox+"</td></tr>"
                                        }
                                    }
                                }
                            }else{
                                files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';
                            }
                            $("#file_Tachr").html(files);
                            me.pageTwo(res.total,me.data.pageSize,me.data.page)
                            $('[name="sortId"]').val(id)
                            $(".contentTr").on("click",function () {
                                var state=$(this).find('.checkChild').prop("checked");
                                var len = $('#file_Tachr').find('.checkChild:checked').length;
                                if(state==true){
                                    $(this).find('.checkChild').prop("checked",true);
                                    $(this).addClass('bgcolor');

                                }else{
                                    $('#checkedAll').prop("checked",false);
                                    $(this).find('.checkChild').prop("checked",false);
                                    $(this).removeClass('bgcolor');

                                }
                                if(len>0){
                                    $('#singReading').removeClass('addBackground');
                                    $('#copy').removeClass('addBackground').removeClass('copyfile');
                                    $('#shear').removeClass('addBackground').removeClass('copyfile');
                                    $('#paste').removeClass('addBackground').removeClass('copyfile');
                                    $('#deletebtn').removeClass('addBackground');
                                }else{
                                    $('#singReading').addClass('addBackground');
                                    $('#copy').addClass('copyfile');
                                    $('#shear').addClass('copyfile');
                                    $('#paste').addClass('copyfile');
                                    $('#deletebtn').addClass('addBackground');
                                }
                                var child =   $(".checkChild");
                                for(var i=0;i<child.length;i++){
                                    var childstate= $(child[i]).prop("checked");
                                    if(state!=childstate){
                                        return
                                    }
                                }
                                $('#checkedAll').prop("checked",state);
                            })
                            $('#singReading').addClass('addBackground');
                            $('#copy').addClass('copyfile').removeClass('addBackground');
                            $('#shear').addClass('copyfile').removeClass('addBackground');
                            $('#paste').addClass('copyfile').removeClass('addBackground');
                            $('#deletebtn').addClass('addBackground');

                            $('#checkedAll').prop("checked",false);
                        }
                    });

                },
                pageTwo:function (totalData, pageSize,indexs) {
                    var mes=this;
                    $('#dbgz_page').pagination({
                        totalData: totalData,
                        showData: pageSize,
                        jump: true,
                        coping: true,
                        homePage:'',
                        endPage: '',
                        current:indexs||1,
                        callback: function (index) {
                            mes.data.page=index.getCurrent();
                            mes.page();
                        }
                    });
                }
            }
            ajaxPage.page();
        }


        $(document).on('click','.operationImg',function () {
            var thisa = $(this).next().attr('openimg')
            var openNmu = $(this).next().attr('openNmu')
            var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
            $('#file_Tachr').append(str3)
            $('#getIndex').val(thisa)
            window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
        })
        //取文件后缀名
        function GetFileExt(filepath) {
            if (filepath != "") {
                var pos = "." + filepath.replace(/.+\./, "");
                return pos;
            }
        }

        //时间控件调用
        var start = {
            format: 'YYYY/MM/DD hh:mm:ss',
            /* min: laydate.now(), //设定最小日期为当前日期*/
            /* max: '2099-06-16 23:59:59', //最大日期*/
            istime: true,
            istoday: false,
            choose: function(datas){
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        var end = {
            format: 'YYYY/MM/DD hh:mm:ss',
            /*min: laydate.now(),*/
            /*max: '2099-06-16 23:59:59',*/
            istime: true,
            istoday: false,
            choose: function(datas){
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };

        //正在开发中
        function clicked(){
            layer.msg('<fmt:message code="lang.th.Upcoming"/>！', {icon: 6});
        }
        //        查询网址
        function getIntnet() {
            $.ajax({
                type:'get',
                url:'/sysTasks/selectPreview',
                dataType:'json',
                success:function (res) {
                    if(res.flag){

                    }
                }
            })
        }
    </script>
</head>
<body>
<div class="contentPage" style="height: 100%">

    <div  class="cabinet_left">
        <!--  <div onclick="cabinet('1')" id="personal" style="width:49%;height:30px;line-height:30px;   float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.public"/></div>
       <div onclick="cabinet('2')" id="public"  style="width:49%;height:30px;line-height:30px;  float: left;border:1px solid #c0c0c0;text-align: center;"><fmt:message code="main.personnel"/></div> -->

        <div onclick="" id="personal" style="width:100%;height:44px;line-height:44px;border-bottom: #9e9e9e 1px solid;">
            <div class="div_Img">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_publicFile.png" style="vertical-align: middle;" alt="">
            </div>
            <div class="divP"><fmt:message code="main.public"/></div>
        </div>
        <%-- <div onclick="cabinet('2')" id="public"  style="width:50%;height:40px;line-height:40px;  float: left;text-align: center;"><fmt:message code="main.personnel"/></div>
        <%--&ndash;%&gt;fileTransfor--%>
        <div id="li_parent" class="ul_all tree" style="width:100%;">
            <%--<ul id="fileTree" class="easyui-tree" data-options="url:'writeTree',method:'get',animate:true" >--%>
            <%--</ul>--%>
        </div>
    </div>
    <div class="cabinet_info"  style="width:calc(100% - 20%)">
        <input type="hidden" name="down-user" value="">
        <div class="noData" id="noFile" style="display: block;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXT"><fmt:message code="Email.th.PleaseSelect"/></div>
            </div>
        </div>
        <div class="noData" id="noJurisdiction" style="display: none;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXTa"><fmt:message code="file.th.NotPermission"/>！</div>
            </div>
        </div>
        <div class="mainContent" style="display:none;">
            <input type="hidden" name="editQuanxian" value="">
            <input type="hidden" name="qianyueQuanxian" value="">
            <input type="hidden" name="exportQuanxian" value="">
            <input type="hidden" name="deleteQuanxian" value="">
            <input type="hidden" name="zhantieQuanxian" value="">
            <input type="hidden" name="fileQuanxian" value="0">
            <input type="hidden" name="ownerQuanxian" value="0">
            <input type="hidden" name="reviewQuanxian" value="0">
            <%--<div class="divFolder">--%>
            <%--<img style="margin-left: 20px;vertical-align: middle;margin-top: -5px;" src="/img/file/icon_wenjianjia.png" alt="">--%>
            <%--<span class="spanFolder" data-id="" style="margin-left: 5px;font-size: 11pt;"></span>--%>
            <%--</div>--%>
            <div class="head w clearfix">
                <input type="hidden" name="paid" id="paid" value="">
                <div class="divFolder">
                    <img style="margin-left: 20px;vertical-align: middle;margin-top: -5px;" src="/img/file/icon_wenjianjia.png" alt="">
                    <span class="spanFolder" data-id="" style="margin-left: 5px;font-size: 11pt;"></span>
                </div>
                <div class="ss selected" id="one_selected" style="display: block;margin-right: 12px;margin-top:8px;">
                    <div id="TitleOne" class="doTitle"><img src="/img/file/icon_fileCabinet.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.op"/><img src="/img/file/icon_triangle.png" style="margin-left: 5px;margin-bottom: 3px;" alt=""></div>
                    <div id="classA" class="hideDiv" style="display: none;">
                        <ul>
                            <li id="newChild"><fmt:message code="file.th.newf"/></li>
                            <li id="setting"><fmt:message code="roleAuthorization.th.SetPermissions"/></li>
                        </ul>
                        <ul class="second">
                            <li id="deleteFile"><fmt:message code="flie.th.dele"/></li>
                            <li id="editFile"><fmt:message code="global.lang.edit"/></li>
                        </ul>
                    </div>
                </div>

                <div id="overall" class="ss four"> <span><img src="/img/file/icon_globalSearch.png" style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" alt=""><fmt:message code="Email.th.global"/></span></div>
                <div id="SEARCH" class="ss three"> <span  class="SEARCH" ><img src="/img/file/icon_search.png" style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.query"/></span></div>
                <div id="batch" class="ss two" style="position: relative">
                    <form id="uploadimgform" target="uploadiframe"  action="/newFileContent/fileBoxUpload" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="sortId">
                        <input type="file" name="file" id="uploadinputimg" multiple="multiple" class="w-icon5"
                               style="position: absolute;z-index: 99999;width: 89px;opacity:0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        <a href="#" id="uploadimg"><img style="margin-right: 3px;margin-left: -18px;margin-bottom: 4px;" src="../../img/mywork/shangchuan.png" alt=""><fmt:message code="notice.th.up"/></a>
                    </form>
                </div>
                <div class="ss one" id="newsAdd" style="border-radius: 3px;"><img style="margin-right: -26px;margin-left: 7px;margin-bottom: 2px;margin-top: 7px;" src="../../img/mywork/newbuildworjk.png" alt=""> <a id="contentAdd" href="javascript:;"><fmt:message code="file.th.newfile"/></a></div>
                <%--<div class="selected" id="two_selected" style="display: none;">
                    &lt;%&ndash;<select id="fileDone">
                        <option value="0">文件夹操作</option>
                        <option value="1">新建子文件夹</option>
                        <option value="2">设置权限</option>
                        <option value="3">编辑</option>
                        <option value="4">删除</option>
                    </select>&ndash;%&gt;
                        <div id="TitleTwo" class="doTitle">文件夹操作</div>
                        <div id="second" class="hideDiv" style="display: none;">
                            <ul>
                                <li id="">新建子文件夹</li>
                                <li>设置权限</li>
                                <li>删除目录</li>
                                <li>编辑</li>
                            </ul>
                        </div>
                </div>--%>
            </div>
            <div style="clear:both;"></div>
            <!--middle部分开始-->
            <div class="w" style="margin-top: 10px;">
                <div class="wrap">
                    <input type="hidden" name="sortTxt" value="">
                    <input type="hidden" name="folderId" value="">
                    <table class="w fileCabinet">
                        <thead>
                        <tr>
                            <td class="th" width="30%"><fmt:message code="file.th.name"/></td>
                            <td class="th" width="31%"><fmt:message code="email.th.file"/></td>
                            <td class="th" width="20%" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="6%" style="">
                                <fmt:message code="file.th.Sort" />
                                <%--<fmt:message code="file.th.Sort"/>--%>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" id="hiddenTd" width="15%" style=""><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tachr">
                        </tbody>
                    </table>
                    <div class="right">
                        <!-- 分页按钮-->
                        <div class="M-box3" id="dbgz_page"></div>
                    </div>
                </div>

            </div>
            <div style="clear:both;"></div>
            <!--bottom 部分开始-->
            <div class="bottom w">
                <input type="hidden" name="" id="copyAndShear" sortId="">
                <div class="checkALL">
                    <input id="checkedAll" type="checkbox" name="" value="" >
                    <label for="checkedAll"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <div class="boto addBackground" id="singReading">
                    <a class="ONE" href="javascript:;"><img src="/img/file/icon_checkRead.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.SignReading"/></a>
                </div>
                <div class="boto addBackground" id="copy">
                    <a class="TWO" href="javascript:;"><img src="/img/file/icon_copy.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.copy"/></a>
                </div>
                <div class="boto addBackground" id="shear">
                    <a class="THREE" href="javascript:;"><img src="/img/file/icon_cut.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.cut"/></a>
                </div>
                <div class="boto addBackground" id="paste" style="display: none;">
                    <a class="SIX" href="javascript:;"><img src="/img/file/icon_paste_s.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="fille.th.paste"/></a>
                </div>
                <div class="boto addBackground" id="deletebtn">
                    <a class="FOURs" href="javascript:;"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.delete"/></a>
                </div>
                <%--<div class="boto" id="download">--%>
                <%--<a class="FiveOne" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>
                <div class="boto addBackground download" id="downloads" style="background: #2b7fe0 !important;color: white;">
                    <fmt:message code="file.th.batchDownload" />
                </div>
            </div>
            <%--<div class="floderOperation" style="display: block;">
                <input type="hidden" name="folderId" value="">
                <div class="childFolders" style="display: block;">
                    <div class="operation">文件夹操作：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolders" href="javascript:;"><span>新建子文件夹</span></a>
                    </div>
                </div>
                <div class="childFolder" style="display: none;">
                    <div class="operation">文件夹操作：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolder" href="javascript:;"><span>新建子文件夹</span></a>
                    </div>
                    <div class="editFolder">
                        <a id="editFolder" href="javascript:;"><span>编辑</span></a>
                    </div>
                    <div class="deleteFolder">
                        <a id="deleteFolder" href="javascript:;"><span>删除目录</span></a>
                    </div>
                </div>
            </div>--%>
            <div class="attach" style="display: none;">
                <div class="box" id="fileName"></div>
                <%--<div class="remind">
                    <p>事务提醒：</p>
                    <input type="radio" name="remindUser" value="">
                    <span>手动选择被提醒人员</span>
                    <input type="radio" name="remindUser" value="">
                    <span>提醒全部有权限人员</span>
                </div>
                <div class="inPole">
                    <textarea name="txt" id="dePsenduser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
                    <span class="add_img" style="margin-left: 10px">
                        <a href="javascript:;" id="selectUserDep" class="Add " style="color:#207bd6;">添加</a>
                    </span>
                    <span class="add_img">
						<a href="javascript:;" class="clear" style="color:#207bd6;">清除</a>
					</span>
                </div>
                <div class="share">
                    <input type="checkbox" name="share" value="">
                    <span>分享到企业社区</span>
                </div>--%>
                <div>
                    <input type="checkbox" name="remind" class="remindCheck" value="0" checked>
                    <fmt:message code="notice.th.remindermessage" />&nbsp;
                    <input type="checkbox" name="smsDefault"  class="smsDefault" value="1" >
                    <span class="hideSpan" ><fmt:message code="vote.th.UseRemind" /></span>
                </div>
                <div class="divBtns">
                    <div class="start" id="start"><fmt:message code="file.th.StartUploading"/></div>
                    <div class="cancle"><fmt:message code="file.th.cancelAll"/></div>
                </div>
            </div>
        </div>
        <div class="details" style="display:none;width: 95%;margin: 0 auto; margin-top: 10px;">
            <div class="w">
                <div class="wrap">
                    <table class="w fileCabinet">
                        <thead>
                        <tr>
                            <td class="th"><fmt:message code="file.th.name"/></td>
                            <td class="th"><fmt:message code="email.th.file"/></td>
                            <td class="th" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" style="position: relative">
                                <fmt:message code="url.th.safeLogNo"/>
                                <%--<fmt:message code="file.th.Sort"/>--%>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th"><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tachrs">
                        </tbody>
                    </table>
                    <div class="right">
                        <!-- 分页按钮-->
                        <div class="M-box3" id="dbgz_pages"></div>
                    </div>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div class="bottom w">
                <div class="checkALL">
                    <input id="checkedAlls" type="checkbox" name="" value="" >
                    <label for="checkedAlls"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <%--<div class="boto" onclick="clicked()">
                    <a class="ONE" href="javascript:;"><span>签阅</span></a>
                </div>--%>
                <%--<div class="boto">--%>
                <%--<a class="FiveTow" href="javascript:;"><span>下载</span></a>--%>
                <%--</div>--%>
                <div class="boto">
                    <a class="queryDelete addBackground" id="queryDelete" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>

            </div>
            <div class="button">
                <div class="backBtn"><span style="margin-left: 33px;"><fmt:message code="notice.th.return"/></span></div>
            </div>
        </div>
        <div class="queryDetail" style="display:none;margin-top: 10px">
            <div class="w">
                <div class="wrap">
                    <table class="w fileCabinet">
                        <thead>
                        <tr>
                            <td class="th"><fmt:message code="news.th.file"/></td>
                            <td class="th"><fmt:message code="file.th.name"/></td>
                            <td class="th"><fmt:message code="email.th.file"/></td>
                            <td class="th"><fmt:message code="doc.th.AppendixDescription"/></td>
                            <td class="th" style="position: relative">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th"><fmt:message code="notice.th.operation"/></td>
                        </tr>
                        </thead>
                        <tbody id="file_Tach">
                        </tbody>
                    </table>
                    <div class="right">
                        <!-- 分页按钮-->
                        <div class="M-box3" id="dbgz_pagesd"></div>
                    </div>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div class="bottom w">
                <div class="checkALL">
                    <input id="checkedAllY" type="checkbox" name="" value="" >
                    <label for="checkedAllY"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <%--<div class="boto">--%>
                <%--<a class="FiveTow" id="exportA" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>
                <div class="boto">
                    <a class="queryDelete addBackground" id="deleteAll" href="javascript:;"><span><fmt:message code="global.lang.delete"/></span></a>
                </div>
            </div>
            <div class="button">
                <div class="backBtn"><span style="margin-left: 33px;"><fmt:message code="notice.th.return"/></span></div>
            </div>
        </div>
        <div class="newAddFolder" style="display: none;">
            <div class="addHeader">
                <div class="addiv_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" style="vertical-align: middle;" alt="<fmt:message code="file.th.newf"/>">
                </div>
                <div class="divP"><fmt:message code="file.th.newf"/></div>
            </div>
            <table cellspacing="0" cellpadding="0" class="tab myTab" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.Sort"/></td>
                    <td><input type="text" name="serial" value="10"></td>
                </tr>
                <tr>
                    <td style="border-right: #ccc 1px solid;"><fmt:message code="file.th.filename"/></td>
                    <td><input type="text" name="polderName" value=""></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="typeButton">
                            <div id="btnSure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></div>
                            <div id="btnBack"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="editAddFolder" style="display: none;">
            <div class="addHeader">
                <div class="addiv_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSettings.png" style="vertical-align: middle;" alt="<fmt:message code="file.th.edit"/>">
                </div>
                <div class="divP"><fmt:message code="file.th.edit"/></div>
            </div>
            <table cellspacing="0" cellpadding="0" class="tab myTab" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <th><fmt:message code="file.th.Sort"/></th>
                    <th><fmt:message code="file.th.filename"/></th>
                </tr>
                <tr>
                    <td>
                        <input type="text" name="edSerial" value="">
                    </td>
                    <td>
                        <input type="text" name="edPolderName" value="">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="typeButton">
                            <div id="editSure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok"/></span></div>
                            <div id="editBack"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--<div style="height: 100% ;">

    </div>--%>
</div>
<script>

    function queryOneDatasd(sortId,iReder){
        var data={
            sortType:'5',
            sortId:sortId,
            pageNo:0,
            pageSize:10,
            subjectName:subjectName,
            contentNo:contentNo,
            creater:createrd,
            contentValue1:contentValue1,
            contentValue2:contentValue2,
            contentValue3:contentValue3,
            atiachmentDesc:atiachmentDesc,
            atiachmentName:atiachmentName,
            atiachmentCont:atiachmentCont,
            crStartDate:crStartDate,
            crEndDate:crEndDate
        }
        $.ajax({
            type:'post',
            url:'../file/queryBySearchValue',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tachrs').find('tr').remove();
                var data1=res.datas;
                var str='';
                var files='';
                var attachId = ''
                var arr1 = []
                for(var m=0;m<data1.length;m++){
                    if(data1[m].attachmentList != 'undefined'){
                        arr1.push(data1[m].attachmentList[0]);
                    }

                }
                for(var i=0;i<data1.length;i++){

                    var arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        attachId = data1[i].attachmentList[0].attachId
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' attachId ='"+attachId+"'  > <a class='TITLE' style='color:#54b6fe;display: inline-block;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td>"+attachView(arr,'','3','1','1','0',arr1,'wenjiangui')+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value=''  path ='"+data[i].attachmentList[0].attachName+"' > <a class='TITLE' title ='"+data[i].attachmentList[0].attachName+"' style='color:#54b6fe;display: inline-block;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>";
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }
                }
                $('#file_Tachrs').append(str);
                $(".contentTrs").on("click",function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                        $('#queryDelete').removeClass('addBackground');
                    }else{
                        $('#checkedAlls').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                        $('#queryDelete').addClass('addBackground');
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAlls').prop("checked",state);
                })
                $('#queryDelete').addClass('addBackground');

                $('#checkedAlls').prop("checked",false);
            }
        })
    }
    //播放视频按钮点击
    $(document).on('click','#bf',function() {
        var url = $(this).attr('attrurl');
        renderVideo({
            url:'/download?'+url,
            width: 800,
            height: 500
        })
    })
    //播放音频按钮点击
    $(document).on('click','#bfyp',function() {
        var ap = null;
        var url = $(this).attr('attrurl');
        layer.open({
            type:1,
            title:"<fmt:message code="workflow.th.PlayAudio"/>",
            area:['600px','400px'],
            content:"<div id=player></div>",
            success:function() {
                ap = renderAudio({
                    container: document.getElementById("player"),
                    url:'/download?'+url,
                })
            },
            end:function() {
                if(ap) {
                    ap.destroy();
                }
            }
        })
    })

    function queryAllDatasd(iReder){
        var data={
            sortId:sortId,
            sortType:'5',
            pageNo:1,
            pageSize:10,
            serachType:'2',
            subject:subject,
            sort_no:sort_no,
            creater:creaters,
            keyword1:keyword1,
            keyword2:keyword2,
            keyword3:keyword3,
            attScript:attScript,
            attName:attName,
            attContain:attContain,
            begainTime:begainTime,
            endTime:endTime,
        }
        $.ajax({
            type:'post',
            url:'/newFileContent/serachAll',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tach').find('tr').remove();
                var data1=res.obj;
                var str='';
                var arr=new Array();
                var files ='';
                for(var i=0;i<data1.length;i++){
                    var stra='';
                    arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;"  style="color:#54b6fe;">'+data1[i].subject+'</a></td><td>'+ attachView(data[i].attachmentList, '', '3', data[i].mapPriv.MANAGE_USER, data[i].mapPriv.DOWN_USER, '0', data[i].attachmentList, 'wenjiangui') +'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>'
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }else {
                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a>';
                        if(iReder == '1'){
                            files+="<a href='javascript:;' class='signReading'><fmt:message code="meet.th.ReadingStatus"/></a>"
                        }
                        files+="</td></tr>"
                    }
                }
                $('#file_Tach').append(str);
                $(".contentT").on("click",function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                        $('#deleteAll').removeClass('addBackground')
                    }else{
                        $('#checkedAllY').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
                        $('#deleteAll').addClass('addBackground')
                    }
                    var child =   $(".checkChildren");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(state!=childstate){
                            return
                        }
                    }
                    $('#checkedAllY').prop("checked",state);
                })
                $('#deleteAll').addClass('addBackground')

                $('#checkedAllY').prop("checked",false);
            }
        })


    }
</script>
</body>
</html>
