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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
<title><fmt:message code="main.personnel"/></title>
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/file/fileHomePerson.css">
    <link rel="stylesheet" type="text/css" href="../css/aplayer/apalyer.css?20221209">
    <%--<script type="text/javascript" src="../js/easyui/jquery.min.js"></script>--%>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js?20220317.1" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/attachment/attachView.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/dp.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dplayer/renderVideo.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/aplayer/aplayer.js?20220318.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/aplayer/renderAudio.js?20220318.1" type="text/javascript" charset="utf-8"></script>

    <style>
        body{
            overflow: hidden;
        }
        .tree-title{
            color:#333;
            font-size: 14px;
        }
        .deleteFolder{
            width:100px;
        }
        .deleteFolder a{
            margin-left: 14px;
        }
        .editFolder a{
            margin-left: 9px;
        }
        .ss a{
            font-size:11pt;
        }
        .fileBox{
            width:50%;
            height:44px;
            overflow: hidden;
            /*border-bottom: #9e9e9e 1px solid;*/
            float: left;
            box-sizing: border-box;

            cursor: pointer;
            border-bottom: #9e9e9e 1px solid;
        }
        .shareFile{
            border-bottom: none;
            background: #fefefe;
        }
        .divBtns{
            margin-top: 10px;
            width: 100%;
            overflow: hidden;
        }
        .jump-ipt{
            border: #ccc 1px solid;
        }
        .head .one{
            padding: 0;
        }
        .marginDiv{
            margin-left: -15px;
        }


        .TITLE{
            vertical-align: middle;
        }


        @media screen and (max-width:1680px){
            .TITLE{
                width: 177px;
            }
            .fujian{
                width: 290px;
            }
        }
        @media screen and (min-width:1681px){
            .TITLE{
                width: 300px;
            }
            .fujian{
                width: 480px;
            }
        }

        .boto{
            background: #2F8AE3;
        }
        .addBackground{
            background: #bbbbbb !important;
        }

        .head {
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            /*width: 508px;*/
            /*float: right;*/
            width: 100%;
        }
        .divFolder{
            float: left;
            height: 45px;
            line-height: 45px;
            border-bottom: 2px solid #A8C9EA;
            background-color: #F0F4F7;
            width: 400px;
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
        #fileName p{
            font-size: 11pt;
            line-height: 25px;
        }
        #newTable{
            width: 96%;
            margin: 10px auto;
        }
        #newTable tr td{
            border-right: #ccc 1px solid;
        }
        #newTable tr td:first-of-type{
            width: 80px;
        }
        #newTable tr td input{
            width: 300px;
            height: 28px;
            padding-left: 5px;
            margin-right: 5px;
        }
        .bar {
            height: 18px;
            background: green;
        }
        .widthTab tr td:first-of-type{
            width: 150px;
        }
        .layui-layer{
            /*top:200px!important;*/
            z-index: 999999999999;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<script type="text/javascript">
    var domId = 0;
    var publicAndshare='0';
    var genCookie=$.cookie('userId');

//    var ue = UE.getEditor('container',{elementPathEnabled : false});
    var ue;
    var user_id='userDuser';
    var subjectName,contentNo,createrd,contentValue1,contentValue2,contentValue3,atiachmentDesc,atiachmentName,atiachmentCont,crStartDate,crEndDate;
    var subject,sort_no,creaters,keyword1,keyword2,keyword3,attScript,attName,attContain,begainTime,endTime
$(function(){
    var Height=$('body').height()-47;
    $('#fileTransfor').height(Height);
    $('#shareCabinet').height(Height);



    // var cabWidth=$('.contentPage').width()-$('.cabinet_left').width()-3;
    // $('.cabinet_info').width(cabWidth);
//    $('.divFolder').width((cabWidth - 508)+'px');

    //鼠标移入附件名显示附件操作
    $('#file_Tachr').on('mouseover','.divShow',function () {
        $(this).find('.operationDiv').show();
    })
    $('#file_Tachr').on('mouseout','.divShow',function () {
        $(this).find('.operationDiv').hide();
    })

    //鼠标移入附件名显示附件操作
    $('#file_Tachrs').on('mouseover','.divShow',function () {
        $(this).find('.operationDiv').show();
    })
    $('#file_Tachrs').on('mouseout','.divShow',function () {
        $(this).find('.operationDiv').hide();
    })

    //鼠标移入附件名显示附件操作
    $('#file_Tach').on('mouseover','.divShow',function () {
        $(this).find('.operationDiv').show();
    })
    $('#file_Tach').on('mouseout','.divShow',function () {
        $(this).find('.operationDiv').hide();
    })

    reloadTree();
    init(0);
    //新建文件
    $('#contentAdd').on('click',function(){
        if($('.tree-node-selected').attr('authority')=='0'){
            layer.msg('<fmt:message code="workflow.th.NoNewFilePermission" />！',{icon:2})
            return false;
        }
        var sortId=$('.tree-node-selected').attr('node-id');
        var sortText=$('input[name="sortTxt"]').val();
        var text = encodeURI(sortText)
        <%--$.popWindow('${pageContext.request.contextPath }/file/contentAdd?sortId='+sortId+'&text='+sortText,'<fmt:message code="global.lang.new"/>','100','300','960px','750px');--%>
        <%--$.popWindow('/newFilePub/newFiles?range=personal&sortId='+sortId+'&text=&ie_open=yes','<fmt:message code="global.lang.new"/>','100','300','960px','750px');--%>
        <%--没有扫描仪器的则不用ie打开--%>
        $.popWindow('/newFilePub/newFiles?range=personal&sortId='+sortId+'&text=&','<fmt:message code="global.lang.new"/>','100','300','960px','750px');
    })

    //新建并扫描文件ie扫描
    $('#scanning').on('click',function(){
        if($('.tree-node-selected').attr('authority')=='0'){
            layer.msg('<fmt:message code="workflow.th.NoNewFilePermission"/>！',{icon:2})
            return false;
        }
        var sortId=$('.tree-node-selected').attr('node-id');
        var sortText=$('input[name="sortTxt"]').val();
        var text = encodeURI(sortText)
        <%--$.popWindow('${pageContext.request.contextPath }/file/contentAdd?sortId='+sortId+'&text='+sortText,'<fmt:message code="global.lang.new"/>','100','300','960px','750px');--%>
        <%--扫描仪器的则用ie打开--%>
        $.popWindow('/newFilePub/getnew?range=personal&sortId='+sortId+'&text=','<fmt:message code="global.lang.new"/>','100','300','960px','750px');
    })

    $('#public').on('click',function () {
        publicAndshare='0';
        $(this).addClass('shareFile');
        $('#personal').removeClass('shareFile');
        $('#fileTransfor').show();
        $('#shareCabinet').hide();
        $('.floderOperation').show();
        $('.childFolders').show();
        $('.childFolder').hide();
        $('#shareTree li div').removeClass('tree-node-selected')
        reloadTree();
        init(0);
    })
    $('#personal').on('click',function () {
        publicAndshare='1';
        $(this).addClass('shareFile');
        $('#public').removeClass('shareFile');
        $('#shareCabinet').show();
        $('#fileTransfor').hide();
        $('.floderOperation').hide();
        $('#fileTree li div').removeClass('tree-node-selected');
        var str='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="workflow.th.PleaseSelectFolder"/></div></td></tr>';
//        $('.mainContent').find('.bottom').hide();
        $('#file_Tachr').html(str)
        reloadTreeShare();
    })


    //全选点击事件
    $('#checkedAll').on('click',function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChild").prop("checked",true);
            $(".contentTr").addClass('bgcolor');
            $('#copy').removeClass('addBackground');
            $('#shear').removeClass('addBackground');
            $('#deleFile').removeClass('addBackground');
            $('#paste').removeClass('addBackground');
        }else{
            $(this).prop("checked",false);
            $(".checkChild").prop("checked",false);;
            $('.contentTr').removeClass('bgcolor');
            $('#copy').addClass('addBackground');
            $('#shear').addClass('addBackground');
            $('#deleFile').addClass('addBackground');
            $('#paste').addClass('addBackground');
        }
    })
    $('#checkedAlls').on('click',function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChildren").prop("checked",true);
            $(".contentTrs").addClass('bgcolor');
            $('#queryDelete').removeClass('addBackground');
            $('.FiveTow').removeClass('addBackground');
            $('#exportA').removeClass('addBackground');
            $('#deleteAll').removeClass('addBackground');
        }else{
            $(this).prop("checked",false);
            $(".checkChildren").prop("checked",false);;
            $('.contentTrs').removeClass('bgcolor');
            $('#queryDelete').addClass('addBackground');
            $('.FiveTow').addClass('addBackground');
            $('#exportA').addClass('addBackground');
            $('#deleteAll').addClass('addBackground');

        }
    })
    $('#checkedAllY').on('click',function(){
        var state =$(this).prop("checked");
        if(state==true){
            $(this).prop("checked",true);
            $(".checkChildren").prop("checked",true);
            $(".contentT").addClass('bgcolor');
            $('#exportA').removeClass('addBackground');
            $('#deleteAll').removeClass('addBackground');
        }else{
            $(this).prop("checked",false);
            $(".checkChildren").prop("checked",false);;
            $('.contentT').removeClass('bgcolor');
            $('#exportA').addClass('addBackground');
            $('#deleteAll').addClass('addBackground');
        }
    })
    //删除点击事件
    $('#deleFile').on('click',function(){
        if($('#deleFile').hasClass('addBackground')){
            return false;
        }
        var id=$('.w .contentTr').attr('sortId');
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId")
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            dataDelete(fileId,id)
//            $('#paste').addClass('addBackground');
            $('#paste').hide();
        }
    })
    //查询列表删除事件
    $('#queryDelete').on('click',function(){
        if($('#queryDelete').hasClass('addBackground')){
            return false;
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
    $('#deleteAll').on('click',function(){
        if($('#deleteAll').hasClass('addBackground')){
            return false;
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
    //编辑点击事件
    $('.w').on('click','.editBtn',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var contype=$(this).parents('tr').attr('contype');
        <%--$.popWindow('/newFilePub/newFiles?range=personal&contentId='+idT+'&sortId='+sortId+'&contype='+contype+'&ie_open=yes','<fmt:message code="global.lang.edit"/>','100','300','960px','500px');--%>
        <%--编辑的时候不走ie--%>
        $.popWindow('/newFilePub/newFiles?range=personal&contentId='+idT+'&sortId='+sortId+'&contype='+contype,'<fmt:message code="global.lang.edit"/>','100','300','960px','500px');
    })
    //扫描点击事件
    $('.wen').on('click','.scan',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var contype=$(this).parents('tr').attr('contype');
        $.popWindow('/newFilePub/getnew?range=personal&contentId='+idT+'&sortId='+sortId+'&contype='+contype,'<fmt:message code="global.lang.edit"/>','100','300','960px','500px');
    })
    //文件详情点击事件
    $('.wen').on('click','.TITLE',function(){
        var idT=$(this).parents('tr').attr('contentId');
        var sortId=$(this).parents('tr').attr('sortId');
        var manageUser=$('input[name="MANAGE_USER"]').val();
        if(publicAndshare == '0'){
            $.popWindow('/newFilePub/fileDetail?contentId='+idT+'&sortId='+sortId,'<fmt:message code="file.th.detail"/>','100','150','1000px','500px');
        }else{
            $.popWindow('/newFilePub/fileDetail?contentId='+idT+'&sortId='+sortId+'&editNum='+manageUser+'&deleteNum=0','<fmt:message code="file.th.detail"/>','100','150','1000px','500px');
        }
    })

    //弹出一个页面层，查询点击事件
    $('.SEARCH').on('click', function(event){
        event.stopPropagation();
        var sortId=$('.tree-node-selected').attr('node-id');
        layer.open({
            type: 1,
            title:['<fmt:message code="global.lang.query"/>', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '460px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
            content: '<table cellspacing="0" cellpadding="0" class="tab widthTab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
            '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subjectName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="contentNo" class="inputTd" value="" /></td></tr>'+
            <%--'<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="id" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+--%>
            '<tr><td><fmt:message code="file.th.Keywords1"/>：</td><td><input type="text" style="width: 150px;" name="contentValue1" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="contentValue2" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="contentValue3" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentDesc" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="atiachmentCont" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+
            '<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="crStartDate" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="crEndDate" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+
            '</table>',
            yes:function(index){
                var userId=$('#userDuser').attr('user_id');
                if(userId=='id'){
                    userId='';
                }
                subjectName=$('input[name="subjectName"]').val();
                contentNo=$('input[name="contentNo"]').val()
                contentValue1=$('input[name="contentValue1"]').val()
                contentValue2=$('input[name="contentValue2"]').val()
                contentValue3=$('input[name="contentValue3"]').val()
                atiachmentDesc=$('input[name="atiachmentDesc"]').val()
                atiachmentName=$('input[name="atiachmentName"]').val()
                atiachmentCont=$('input[name="atiachmentCont"]').val()
                crStartDate=$('input[name="crStartDate"]').val()
                crEndDate=$('input[name="crEndDate"]').val()

                queryOneData(sortId,userId);
                layer.close(index);
                $('.mainContent').hide();
                $('.details').show();
            }
        });
        $('#selectUser').on('click',function(){
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
            area: ['600px', '460px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.query"/>', '<fmt:message code="global.lang.close"/>'],
            content: '<table cellspacing="0" cellpadding="0" class="tab widthTab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
            '<tr><td><fmt:message code="file.th.TitleContainsText"/>：</td><td><input type="text" style="width: 150px;" name="subject" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.Sort"/>：</td><td><input type="text" style="width: 150px;" name="sort_no" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.builder"/>：</td><td><div class="inPole"><textarea name="txt" id="userDuser" user_id="" value="admin" disabled style="min-width: 300px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add"/></a></span></div></td></tr>'+
            '<tr><td><fmt:message code="file.th.Keywords1"/>：</td><td><input type="text" style="width: 150px;" name="keyword1" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword2"/>：</td><td><input type="text" style="width: 150px;" name="keyword2" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.keyword3"/>：</td><td><input type="text" style="width: 150px;" name="keyword3" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.text"/>：</td><td><input type="text" style="width: 150px;" name="attScript" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.fileName"/>：</td><td><input type="text" style="width: 150px;" name="attName" class="inputTd" value="" /></td></tr>'+
            '<tr><td><fmt:message code="file.th.containsText"/>：</td><td><input type="text" style="width: 150px;" name="attContain" class="inputTd" value="" /><span style="margin-left: 10px;color:#999;font-size:9pt;"><fmt:message code="file.th.Only"/></span></td></tr>'+
            '<tr><td><fmt:message code="global.lang.date"/>：</td><td><input type="text" style="width: 150px;" name="begainTime" id="start" class="inputTd" value="" onclick="laydate(start)" /><span style="font-size:9pt;margin:0 5px;"><fmt:message code="global.lang.to"/></span><input type="text" style="width: 150px;" name="endTime" id="end" class="inputTd" value="" onclick="laydate(end)" /></td></tr>'+
            '</table>',
            yes:function(index){
                var userId=$('#userDuser').attr('user_id');
                if(userId=='id'){
                    userId='';
                }
                subject=$('input[name="subject"]').val();
                sort_no=$('input[name="sort_no"]').val()
                creaters=$('#userDuser').attr('user_id');
                keyword1=$('input[name="keyword1"]').val()
                keyword2=$('input[name="keyword2"]').val()
                keyword3=$('input[name="keyword3"]').val()
                attScript=$('input[name="attScript"]').val()
                attName=$('input[name="attName"]').val()
                attContain=$('input[name="attContain"]').val()
                begainTime=$('input[name="begainTime"]').val()
                endTime=$('input[name="endTime"]').val()
                queryAllData(userId)
                layer.close(index);
                $('.mainContent').hide();
                $('.queryDetail').show();
            }
        });
        $('#selectUser').on('click',function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        })

    });
    //数据列表返回点击事件
    $('.backBtn').on('click',function(){
        $('.contentTrs').remove();
        $('.mainContent').show();
        $('.details').hide();
        $('.queryDetail').hide();
    })

    var conId;
    var data={};
    var copyIds='';
        //复制点击事件

        $('#copy').on('click',function(){
            if($('#copy').hasClass('addBackground')){
                return false;
            }
            copyIds=''
//            conId=$('.bgcolor').attr('contentid');
            $('#copyAndShear').attr('sortId','1');
            $(".checkChild:checkbox:checked").each(function(){
                copyIds+=$(this).attr("conid")+',';
            })
            if(copyIds == undefined){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
            }else{
                $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
                $('#paste').show();
            }
        })


    //剪切点击事件
    var fileIds='';
    $('#shear').on('click',function(){
        if($('#shear').hasClass('addBackground')){
            return false;
        }
        fileIds = '';
        $('#copyAndShear').attr('sortId','2');
        $(".checkChild:checkbox:checked").each(function(){
            fileIds+=$(this).attr("conId")+',';
//            var conId=$(this).attr("conId")
//            fileIds.push(conId);
        })
        if(fileIds == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
        }else{
            $.layerMsg({content:'<fmt:message code="doc.th.SelectedFile"/>！',icon:1});
            $('#paste').show();
        }
    })
    //粘贴点击事件
    $('#paste').on('click',function(){
        if($('#paste').hasClass('addBackground')){
            return false;
        }
        if(copyIds == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:6});
        }else{
            var tId=$('#copyAndShear').attr('sortId');
            var sortId=$('.tree-node-selected').attr('node-id');
            if(tId == '1'){
                data={
                    'witchSortId':sortId,
                    'copyId':copyIds
                }
                copyData('/newFileContent/copyAndParse',data,sortId);
            }else if(tId == '2'){
                data={
                    'sortId':sortId,
                    'contentId':fileIds
                }
                copyData('/newFileContent/fileCut',data,sortId);
            }
            copyIds = '';
            fileIds = '';
        }

    })

    //下载点击事件
    $('.FiveOne').on('click',function(){
        var text=$('input[name="sortTxt"]').val();
        var fileId=[];
        $(".checkChild:checkbox:checked").each(function(){
            var conId=$(this).attr("conId");
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
            return false;
        }else{
            window.location.href='../file/downFileContent?contentId='+fileId+'&sortName='+text;
        }
    })
    //下载点击事件
    $('.FiveTow').on('click',function(){
        if($('.FiveTow').hasClass('addBackground')){
            return false;
        }
        var text=$('input[name="sortTxt"]').val();
        var fileId=[];
        $(".checkChildren:checkbox:checked").each(function(){
            var conId=$('.bgcolor').attr('contentId');
            fileId.push(conId);
        })
        if(fileId == ''){
            $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:2});
            return false;
        }else{
            window.location.href='/newFileContent/downFileContent?contentId='+fileId+'&sortName='+text;
        }
    })
    //新建子文件夹
    $('#newChildFolder').on('click',function(){
        $('.newAddFolder').show().siblings().hide();
        $('input[name="serial"]').val('10');
        $('input[name="polderName"]').focus();
    })
    //根目录新建子文件夹
    $('#newChildFolders').on('click',function(){
        $('.newAddFolder').show().siblings().hide();
        $('input[name="serial"]').val('10');
        $('input[name="polderName"]').focus();
    })


    /**
     * 验证数据 是数字：返回true；不是数字：返回false
     **/
    function Number(val) {
        if (parseFloat(val).toString() == "NaN") {

            return false;
        } else {
            return true;
        }
    }

    //新建子文件夹确定事件
    $('#btnSure').on('click',function(){
        domId = $('.cabinet_left .tree-node-selected').attr("node-id");
        var sortParent=$('.tree-node-selected').attr('node-id');
        var sortNo=$('input[name="serial"]').val();
        if(!Number(sortNo)){
            $.layerMsg({content:'<fmt:message code="workflow.th.pleaseCheck"/>！',icon:2});
            return false;
        }
        var data={
            sortType:4,
            sortParent:sortParent,
            sortNo:sortNo,
            sortName:$('input[name="polderName"]').val()
        }
        if($('input[name="serial"]').val()=='' || $('input[name="polderName"]').val()==''){
            $.layerMsg({content:'<fmt:message code="doc.th.sortNumber"/>！',icon:2});
            return false;
        }
        <%--if (isNaN($('input[name="serial"]').val())) {--%>
            <%--$.layerMsg({content:'<fmt:message code="doc.th.number"/>！',icon:2});--%>
            <%--$('input[name="serial"]').focus();--%>
            <%--return false;--%>
        <%--}--%>
        $.ajax({
            type:'post',
            url:'/newFilePri/getFileCheck',
            dataType:'json',
            data:data,
            success:function(res) {
                if (res.status == false) {
                    $.layerMsg({content:'<fmt:message code="main.th.alreadyExists"/>！',icon:3});
                    return false;
                }else{
                    $.ajax({
                        type:'post',
                        url:'/newFilePri/addPriSort',
                        dataType:'json',
                        data:data,
                        success:function(res){
                            if(res.flag){
                                $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully"/>！',icon:1},function(){
//                                    $('input[name="serial"]').val('');
                                    $('input[name="polderName"]').val('');
                                    $('.details').hide();
                                    $('.queryDetail').hide();
                                    $('.newAddFolder').hide();
                                    $('.editAddFolder').hide();
                                    $('.mainContent').show();
                                    reloadTree();
                                });
                            }else {
                                $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed"/>！',icon:2},function(){
                                });
                            }
                        }
                    })
                }
            }
        });


    })


    //新建子文件夹返回按钮
    $('#btnBack').on('click',function(){
//        $('input[name="serial"]').val('');
        $('input[name="polderName"]').val('')
        $('.mainContent').show();
        $('.newAddFolder').hide();
    })
    //编辑子文件夹按钮
    $('#editFolder').on('click',function(){
        $('.editAddFolder').show().siblings().hide();
        var sortId=$('input[name="folderId"]').val();
        $.ajax({
            type:'get',
            url:'/newFilePri/getPriSort',
            dataType:'json',
            data:{'sortId':sortId},
            success:function(res){
                var datas=res.data;
                $('input[name="edSerial"]').val('');
                $('input[name="edPolderName"]').val('');

                $('input[name="edSerial"]').val(datas.sortNo);
                $('input[name="edPolderName"]').val(datas.sortName);
            }
        })
    })
    //编辑子文件夹确定按钮
    $('#editSure').on('click',function(){
        var sortId=$('input[name="folderId"]').val();
        var data={
            'sortId':sortId,
            'sortNo':$('input[name="edSerial"]').val(),
            'sortName':$('input[name="edPolderName"]').val()
        }

        if($('input[name="edPolderName"]').val() == ''){
            $.layerMsg({content:'<fmt:message code="doc.th.sortNumber"/>！',icon:2});
            return false;
        }
        $.ajax({
            type:'post',
            url:'/newFilePri/updPriSort',
            dataType:'json',
            data:data,
            success:function(res){
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess"/>！',icon:1},function(){
                        $('.details').hide();
                        $('.queryDetail').hide();
                        $('.newAddFolder').hide();
                        $('.editAddFolder').hide();
                        $('.mainContent').show();
                        $('.childFolder').hide();
                        $('.childFolders').show();

                        reloadTree();
                        init('0');
//                        init(sortId);

                    });
                }else{
                    $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed"/>！',icon:2});
                }
            }
        })
    })

    //编辑子文件夹返回按钮
    $('#editBack').on('click',function(){
        $('.mainContent').show();
        $('.editAddFolder').hide();
    })
    //删除子文件夹按钮
    $('#deleteFolder').on('click',function(){
        var sortId=$('input[name="folderId"]').val();
        layer.confirm('<fmt:message code="sys.th.commit"/>！', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/newFilePri/delPriSort',
                dataType:'json',
                data:{'sortId':sortId},
                success:function(res){
                    if(res.flag == true){
                        $('.details').hide();
                        $('.queryDetail').hide();
                        $('.newAddFolder').hide();
                        $('.editAddFolder').hide();
                        $('.mainContent').show();
                        $('.childFolder').hide();
                        $('.childFolders').show();
                        layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                        reloadTree();
                        init(0);
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    })

//    点击共享/取消共享
    $('#shareFolder').on('click',function () {
        var sortId=$('input[name="folderId"]').val();
        layer.open({
            type: 1,
            title:['<fmt:message code="workflow.th.ShareUnsetsSharedFolder"/>', 'background-color:#2b7fe0;color:#fff;'],
            area: ['500px', '260px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="depatement.th.quxiao"/>'],
            content: '<table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse;margin-top: 10px;width: 98%;margin: 5px auto;">' +
            '<tr>' +
            '<td style="width: 80px;"><fmt:message code="diart.th.scope"/>：</td>' +
            '<td>' +
            '<textarea name="shareUserId" id="shareUserId" user_id="" readonly style="min-width:300px;min-height: 50px;"></textarea>'+
            '<a href="javascript:;" class="addUser" style="margin: 0 10px;"><fmt:message code="global.lang.add"/></a>'+
            '<a href="javascript:;" class="clearUser"><fmt:message code="notice.th.delete1"/></a>' +
            '</td>' +
            '</tr>' +
            '<tr>' +
            '<td style="width: 80px;"><fmt:message code="workflow.th.ModifyPermission"/>：</td>' +
            '<td>' +
            '<textarea name="manageUserId" id="manageUserId" user_id="" readonly style="min-width:300px;min-height: 50px;"></textarea>'+
            '<a href="javascript:;" class="editUser" style="margin: 0 10px;"><fmt:message code="global.lang.add"/></a>'+
            '<a href="javascript:;" class="clearEdit"><fmt:message code="notice.th.delete1"/></a>' +
            '</td>' +
            '</tr>' +
            '</table>',
            success:function () {
                $.ajax({
                    type:'get',
                    url:'/newFilePri/getShareUsers',
                    dataType:'json',
                    data:{
                        sortId:sortId
                    },
                    success:function (res) {
                        var datas=res.map;
                        if(res.map != ''){
                            $('#shareUserId').val(datas.shareName);
                            $('#shareUserId').attr('user_id',datas.shareId);
                            $('#manageUserId').val(datas.manageName);
                            if(datas.manageId != undefined){
                                var mangeUserId=datas.manageId.split('|');
                                $('#manageUserId').attr('user_id',mangeUserId[2]);
                            }

                        }
                    }
                })
            },
            yes:function(index){
                var data={
                    shareUserId:$('#shareUserId').attr('user_id'),
                    manageUserId:$('#manageUserId').attr('user_id'),
                    falg:'0',
                    sortId:sortId
                }
                $.ajax({
                    type:'post',
                    url:'/newFilePri/updShareUser',
                    dataType:'json',
                    data:data,
                    success:function (res) {
                        if(res.flag){
                            layer.msg('<fmt:message code="diary.th.modify"/>！', { icon:1});
                            init(sortId);
                            layer.closeAll();
                        }else{
                            layer.msg('<fmt:message code="meet.th.SaveFailed"/>！', { icon:2});
                        }
                    }
                })
            }
        });
        $('.addUser').on('click',function(){
            user_id='shareUserId';
            $.popWindow("../common/selectUser");
        })
        $('.clearUser').on('click',function () {
            $('#shareUserId').attr('user_id','');
            $('#shareUserId').attr('username','');
            $('#shareUserId').attr('dataid','');
            $('#shareUserId').attr('userprivname','');
            $('#shareUserId').val('');
        })
        $('.editUser').on('click',function(){
            user_id='manageUserId';
            $.popWindow("../common/selectUser");
        })
        $('.clearEdit').on('click',function () {
            $('#manageUserId').attr('user_id','');
            $('#manageUserId').attr('username','');
            $('#manageUserId').attr('dataid','');
            $('#manageUserId').attr('userprivname','');
            $('#manageUserId').val('');
        })
    })
    /*------------------------------------------------------------------*/
    //查询列表删除
    function dataDeleteOne(fileId,sortId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/newFileContent/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    queryOneData(sortId,id);
                }
            })

        }, function(){
            layer.closeAll();
        });
    }
    //查询列表方法
    function queryOneData(sortId,id){
        var ajaxPage={
            data:{
                sortId:sortId,
                pageNo:0,
                pageSize:10,
                sortType:'4',
                subjectName:$('input[name="subjectName"]').val(),
                contentNo:$('input[name="contentNo"]').val(),
                contentValue1:$('input[name="contentValue1"]').val(),
                contentValue2:$('input[name="contentValue2"]').val(),
                contentValue3:$('input[name="contentValue3"]').val(),
                atiachmentDesc:$('input[name="atiachmentDesc"]').val(),
                atiachmentName:$('input[name="atiachmentName"]').val(),
                atiachmentCont:$('input[name="atiachmentCont"]').val(),
                crStartDate:$('input[name="crStartDate"]').val(),
                crEndDate:$('input[name="crEndDate"]').val(),
            },
            page:function () {
//                $('.contentTr').remove();
                var me=this;
                $.ajax({
                    type:'post',
                    url:'/newFileContent/queryFile',
                    dataType:'json',
                    data:me.data,
                    success:function(res){
                        $('#file_Tachrs').find('tr').remove();
                        var data1=res.datas;
                        var str='';

                        if(res.flag){
                            for(var i=0;i<data1.length;i++){
                                var stra='';
                                if(data1[i].attachmentName!=''){
                                    var arr=data1[i].attachmentList;

                                    str+="<tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'>" +
                                        "<td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' >" +
                                        "<a class='TITLE' style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>" +
                                        "<td>"+attachView(arr,'','3','1','1','0')+"</td>" +
                                        "<td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td>" +
                                        "<td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                                }else{
                                    str+="<tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'>" +
                                        "<td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' >" +
                                        "<a class='TITLE' style='color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' href='javascript:;'>"+data1[i].subject+ "  </a></td>" +
                                        "<td></td>" +
                                        "<td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td>" +
                                        "<td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                                }
                            }
                        }else {
//                            str='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;">没有查询到对应文件</div></td></tr>';
//                            layer.msg('没有查询到文件',{icon:0});
                        }
                        $('#file_Tachrs').html(str);
                        me.pageTwo(res.total,me.data.pageSize,me.data.page)
                        $(".contentTrs").on('click',function () {
                            var state=$(this).find('.checkChildren').prop("checked");
                            if(state==true){
                                $(this).find('.checkChildren').prop("checked",true);
                                $(this).addClass('bgcolor');
                                $('#queryDelete').removeClass('addBackground');
                                $('.FiveTow').removeClass('addBackground');
                            }else{
                                $('#checkedAlls').prop("checked",false);
                                $(this).find('.checkChildren').prop("checked",false);
                                $(this).removeClass('bgcolor');
                                $('#queryDelete').addClass('addBackground');
                                $('.FiveTow').addClass('addBackground');
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
                        $('.FiveTow').addClass('addBackground');

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

    $(document).on('click','.operationImg',function () {
        var thisa = $(this).next().attr('openimg')
        var openNmu = $(this).next().attr('openNmu')
        var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
        $('#file_Tachr').append(str3)
        $('#getIndex').val(thisa)
        window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
    })
/*-----------------------------------------------------------------------------------*/
    //全局搜索删除列表
    function dataDeleteAll(fileId,id){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/newFileContent/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
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
                sortType:'4',
                page:1,
                pageSize:10,
                useFlag:true,
                'creater':id,
                'serachType':'2',
                'subject':$('input[name="subject"]').val(),
                'sort_no':$('input[name="sort_no"]').val(),
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
                        var data1=res.obj;
                        var str='';
                        var arr=new Array();
                        var arr1=[]
                        if(data1.length > 0){
                            for(var m=0;m<data.length;m++){
                                if(data[m].attachmentList != undefined){
                                    arr1.push(data[m].attachmentList[0]);
                                }
                            }
                            for(var i=0;i<data1.length;i++){
                                var stra='';
                                arr=data1[i].attachmentList;
                                if(data1[i].attachmentName!=''){
                                    str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td>'+attachView(arr,'','3','1','1','0',arr1,'wenjiangui')+'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>';
                                }else {
                                    str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>'
                                }
                            }
                        }else {
                            layer.msg('<fmt:message code="workflow.th.NoFileWasQueried"/>',{icon:0});
                        }

                        $('#file_Tach').html(str);
                        me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        $(".contentT").on('click',function () {
                            var state=$(this).find('.checkChildren').prop("checked");
                            if(state==true){
                                $(this).find('.checkChildren').prop("checked",true);
                                $(this).addClass('bgcolor');
                                $('#exportA').removeClass('addBackground');
                                $('#deleteAll').removeClass('addBackground');
                            }else{
                                $('#checkedAllY').prop("checked",false);
                                $(this).find('.checkChildren').prop("checked",false);
                                $(this).removeClass('bgcolor');
                                $('#exportA').addClass('addBackground');
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
                        $('#exportA').addClass('addBackground');
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

//    var user_id='userDuser';
    $(function(){


        //选人控件
        $("#selectUserDep").on("click",function(){
            user_id='userDuser';
            $.popWindow("../common/selectUser");
        });
        //清空所选人员
        $('.clear').on('click',function(){
            $('#userDuser').val('');
            $('#userDuser').attr('user_id','');
        })

//        $('#uploadimg').on('click', function(ele) {
//            $('#uploadinputimg').click();
//            $(".attach").show();
//
//        })
        $('#uploadinputimg').on('change',function(){
            if($('.tree-node-selected').attr('authority')=='0'){
                layer.msg('<fmt:message code="file.th.youDoNotHaveTheUploadPermission" />！',{icon:2})
                return false;
            }
            var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
            var isOpera = userAgent.indexOf("Opera") > -1;
            $(".attach").show();

            if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){ //判断userAgent字符串中是否包含有compatible或者MSIE
                var src = $(this).target || window.event.srcElement; //获取事件源，兼容chrome/IE
                var filename = src.value;
                var str = filename.substring(filename.lastIndexOf('\\') + 1);
                $('.box').html(str);
            }else {
                var arr =$(this)[0].files;

                var str='';
                for(var i=0;i<arr.length;i++){
                    str+='<p style="margin-left: 10px">'+arr[i].name+'</p>';
                }
                $('.box').html(str);
            }

        })
        $('.box').on('click','.deImgs',function () {
            $(this).parent('p').remove();
        })


        $('#start').on('click',function(){
            var sortId=$('[name="sortId"]').val();
            $('#uploadimgform').ajaxSubmit({
                dataType:'json',
                data:{remind:3,smsDefault:3},
                success:function (res) {
                    if(res.status == true){
                        $('.box').children().remove();
                        $('.attach').hide();
                        init(sortId);
                    }
                    layer.msg(res.msg);
                },
                xhr: function(){
                    myXhr = $.ajaxSettings.xhr();
                    if(myXhr.upload){ //检查upload属性是否存在
                        //绑定progress事件的回调函数
                        myXhr.upload.addEventListener('progress',progressHandlingFunction, false);
                    }
                    return myXhr; //xhr对象返回给jQuery使用
                }
            })
        })

        function progressHandlingFunction(data){
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');
            if(progress >= 100){  //判断滚动条到100%清除定时器
                timer=setTimeout(function () {
                    $('#progress .bar').css(
                        'width',
                        0 + '%'
                    );
                    $('.barText').html('');
                },2000);

            }
        }

        //全部取消点击事件
        $('.cancle').on('click',function(){
            $('.box').children().remove();
            $('.attach').hide();
        })
    })

    function copyData(url,data,sortId){
        $.ajax({
            type:'post',
            url:url,
            dataType:'json',
            data:data,
            success:function(res){
                if(res.flag==true){
                    $.layerMsg({content:'<fmt:message code="file.th.PasteSuccessfully"/>！',icon:1},function(){
                        init(sortId);
                    });
                }else{
                    $.layerMsg({content:'<fmt:message code="file.th.PasteFailed"/>！',icon:2});
                }
            }
        })
    }

    function dataDelete(fileId,id,fileSize){
        layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"<fmt:message code="file.th.removeFolders"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/newFileContent/batchDeleteConId',
                dataType:'json',
                data:{'fileId':fileId},
                success:function(){
                    // 如果删除后的文件上传总大小 小于文件柜限制则将上传按钮显示
                    var folderCapacity = $("#folderCapacity").html() * 1;
                    if (fileSize < folderCapacity) {
                        $("#batch").attr("style","display:block;");
                        $("#batch1").attr("style","display:block;");
                        $("#batch2").attr("style","display:block;");
                    }
                    // 更新个人文件柜文件上传总大小
                    $("#totalFileSize").html(fileSize);
                    layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                    init(id);
                }
            })

        }, function(){
            layer.closeAll();
        });

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
                    url:'/download?'+url
                })
            },
            end:function() {
                if(ap) {
                    ap.destroy();
                }
            }
        })
    })
    //删除附件
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }


    function reloadTree(){
        var dataTr;
        $('#fileTree').tree({
            url: '/newFilePri/getPriFileSort',
            animate: true,
            lines: false,
            loadFilter: function (rows) {
                return convert(rows.datas);
            },
            onClick: function (node) {
                $('.spanFolder').html(node.text);
                $('.spanFolder').attr('title',node.text)
                $('.details').hide();
                $('.queryDetail').hide();
//                $('.queryDetail').hide();
                $('.newAddFolder').hide();
                $('.editAddFolder').hide();
                $('.mainContent').show();
                $('.mainContent').find('.bottom').show();
                if(node.id==0){
                    $('.childFolders').show().siblings().hide();
                }else{
                    $('.childFolder').show().siblings().hide();
                }
                init(node.id);
                $('input[name="sortTxt"]').val('');
                $('input[name="folderId"]').val('');
                $('input[name="sortTxt"]').val(node.text);
                $('input[name="folderId"]').val(node.id);
            },
            onLoadSuccess: function (node, data) {
                $('#fileTree').tree('collapseAll');
                $("#fileTree li").find("div[node-id="+domId+"]").addClass("tree-node-selected marginDiv");   //设置第一个节点高亮
                $("#fileTree li").find("div[node-id="+domId+"]").find('.tree-file').css('background','url("/img/file/icon_directory.png") no-repeat 0px');
                var n = $("#fileTree").tree("getSelected");
                if (n != null) {
                    $("#fileTree").tree("select", n.target);    //相当于默认点击了一下第一个节点，执行onSelect方法
                }


                for(var i=0;i<data.length;i++){

                    var node = $("#fileTree").tree("find",data[i].id);//找到id对应的节点
                    $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                    $(node.target).attr("sortId",data[i].sortId)
                    if(data[i].children!=undefined){
                        buildNode(data[i].children)
                    }

                }
                var param = $.GetRequest();
                var c=Object.keys(param)
                var val=c[0]
                if(val){
                    $('.tree-node[node-id='+ val +']').click();
                }
                for(var m=0;m<100;m++){
                    var node=$('.tree-node').eq(m).attr('node-id')

                    if(node==val){
                        $('.tree-node').eq(m).addClass('tree-node-selected')
                    }
                }
            },

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
    function buildNode2(data){
        $.each(data,function(i,item){

            if(item.children!= undefined && 0 < item.children.length){
                var node = $("#shareTree").tree("find",data[i].id);//找到id对应的节点
                $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                buildNode2(item.children);
            }else{
                var node = $("#shareTree").tree("find",data[i].id);//找到id对应的节点
                $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
            }
        });
    }

//    共享文件柜
    function reloadTreeShare(){
        var dataTr;
        $('#shareTree').tree({
            url: '/newFilePri/getShareFileSort',
            animate: true,
            lines: false,
            loadFilter: function (rows) {
                return convert(rows.setData);
            },
            onClick: function (node) {
                $('.details').hide();
                $('.queryDetail').hide();
//                $('.queryDetail').hide();
                $('.newAddFolder').hide();
                $('.editAddFolder').hide();
                $('.mainContent').show();
                $('.mainContent').find('.bottom').hide();

                $('input[name="sortTxt"]').val('');
                $('input[name="folderId"]').val('');
                $('input[name="sortTxt"]').val(node.text);
                $('input[name="folderId"]').val(node.id);
                $('input[name="MANAGE_USER"]').val(node.attributes.MANAGE_USER);
                init(node.id,node.attributes.MANAGE_USER);
                $('.tree-node-selected').attr('authority',node.attributes.MANAGE_USER)
            },
            onLoadSuccess: function (node, data) {
                $('#shareTree').tree('collapseAll');
                $("#shareTree li").find("div[node-id='-1']").addClass("tree-node-selected");   //设置第一个节点高亮
                var n = $("#shareTree").tree("getSelected");
                if (n != null) {
                    $("#shareTree").tree("select", n.target);    //相当于默认点击了一下第一个节点，执行onSelect方法
                }

                for(var i=0;i<data.length;i++){
                    var node = $("#shareTree").tree("find",data[i].id);//找到id对应的节点
                    $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                    if(data[i].children!=undefined){
                        buildNode2(data[i].children)
                    }
                }
            },
        });
    }

    //处理树结构
    function convert(rows) {
        function exists(rows, parentId) {
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].sortId == parentId) return true;
            }
            return false;
        }
        var nodes = [];
        if(rows != undefined){
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (!exists(rows, row.sortParent)) {
                    nodes.push({
                        id: row.sortId,
                        text: row.sortName,
                        attributes:row.attributes
                    });
                }
            }
        }

        var toDo = [];
        for (var i = 0; i < nodes.length; i++) {
            toDo.push(nodes[i]);
        }
        while (toDo.length) {
            var node = toDo.shift();	// the parent node
            // get the children nodes
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.sortParent == node.id) {
                    var child = {id: row.sortId, text: row.sortName,attributes:row.attributes};
                    if (node.children) {
                        if (node.id != 0) {
                            node.state = "closed"
                        }
                        node.children.push(child);
                    } else {

                        node.children = [child];
                    }
                    toDo.push(child);
                }
            }
        }
        return nodes;
    }

});

    //获取文件夹中的文件列表
    function init(id,abSen) {
        $("#file_Tachr").html('');
        var param = $.GetRequest();
        var c=Object.keys(param);
        var val=c[0];
        var val1
            var node=$('.tree-node-selected').attr('node-id')
        if(node==undefined){
            if(val == undefined||val == 'lang'){
                val = '0'
            }
            node=val

        }
            if(val!=node){
                val1=id
            }else{
                val1=val
            }
        var ajaxPage={
            data:{
                userId:genCookie,
                sortId:val1,
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                useFlag:true
            },
            page:function () {
                $('.contentTr').remove();
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/newFileContent/getFileContentBySortId',
                    dataType:'json',
                    data:me.data,
                    success:function(res){

                        var data=res.datas;
                        var files='';
                        var arr=new Array();
                        var arr1=[]
                        if(data.length > 0 ){

                            for(var m=0;m<data.length;m++){
                                if(data[m].attachmentList != undefined){
                                    arr1.push(data[m].attachmentList[0]);
                                }

                            }
                            for(var i=0;i<data.length;i++){
                                var str1=''
                                arr=data[i].attachmentList;
                                if(data[i].attachmentName!=''){
                                    files+="<tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'>" +
                                        "<td><input class=\"checkChild\" type=\"checkbox\" style='vertical-align:top' conId='"+data[i].contentId+"' name=\"check\" value=\"\" >" +
                                        "<a class='TITLE' href='javascript:;' style='color:#54b6fe;display: inline-block;'>"+data[i].subject+ "  </a></td>" +
                                        "<td>"+attachView(arr,'','3','1','1','0',arr1,'wenjiangui')+"</td> <td> "+data[i].sendTime+ "  </td>" +
                                        "<td> "+data[i].contentNo+ "  </td>" +
                                        "<td>" +function () {
                                            if(abSen == '0'){
                                                return '';
                                            }else{
                                                return "<a href='javascript:;' class='editBtn' style='display:inline-block'><fmt:message code="global.lang.edit"/></a><a class='scan' style='display:inline-block'><fmt:message code="file.th.scan" /></a>"
                                            }
                                        }()+
                                        "</td>" +
                                        "</tr>";
                                }else{
                                    files+="  <tr class='contentTr' sortId='"+data[i].sortId+"' TYPE='"+data[i].fileType+"' contentId='"+data[i].contentId+"' conType='1'>" +
                                        "<td><input class=\"checkChild\" type=\"checkbox\" style='vertical-align:top' conId='"+data[i].contentId+"' name=\"check\" value=\"\" >" +
                                        "<a class='TITLE' href='javascript:;' style='color:#54b6fe;display: inline-block;'>"+data[i].subject+ "  </a></td>" +
                                        "<td><a href='javascript:;'></a></td> <td> "+data[i].sendTime+ "  </td>" +
                                        "<td> "+data[i].contentNo+ "  </td>" +
                                        "<td>" +function () {
                                            if(abSen == '0'){
                                                return '';
                                            }else{
                                                return "<a href='javascript:;' class='editBtn' style='display:inline-block'><fmt:message code="global.lang.edit"/></a><a class='scan' style='display:inline-block'><fmt:message code="file.th.scan" /></a>"
                                            }
                                        }()+
                                        <%--"<a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a>"+--%>
                                        "</td>" +
                                        "</tr>";
                                }
                            }
                        }else{
                            files='<tr><td colspan="5"><div style="margin: 20px 0;width: 100%;text-align: center;"><fmt:message code="file.th.noFiles"/></div></td></tr>';
                        }
                        $("#file_Tachr").html(files);
                        me.pageTwo(res.total,me.data.pageSize,me.data.page)
                        $('[name="sortId"]').val(id);
                        $("#file_Tachr").find(".contentTr").on('click',function () {
                            var state=$(this).find('.checkChild').prop('checked');
                            var len = $('#file_Tachr').find('.checkChild:checked').length;
                            if(state){
                                $(this).find('.checkChild').prop("checked",true);
                                $(this).addClass('bgcolor');
                            }else{
                                $('#checkedAll').prop("checked",false);
                                $(this).find('.checkChild').prop("checked",false);
                                $(this).removeClass('bgcolor');
                            }
                            if(len>0){
                                $('#copy').removeClass('addBackground');
                                $('#shear').removeClass('addBackground');
                                $('#deleFile').removeClass('addBackground');
                                $('#paste').removeClass('addBackground');
                            }else{
                                $('#copy').addClass('addBackground');
                                $('#shear').addClass('addBackground');
                                $('#deleFile').addClass('addBackground');
                                $('#paste').addClass('addBackground');
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
                        $('#copy').addClass('addBackground');
                        $('#shear').addClass('addBackground');
                        $('#deleFile').addClass('addBackground');
//                        $('#paste').addClass('addBackground');
                        $('#checkedAll').prop("checked",false);
                    }

                });
                $.ajax({
                    type:'post',
                    url:'/newFileContent/judgeFileSizeByUserId',
                    dataType:'json',
                    success:function(res) {
                        // 附件上传总大小
                        var totalFileSize = res.data.totalFileSize;
                        if (totalFileSize == undefined) totalFileSize = '0.00';
                        // 用户容量限制
                        var folderCapacity;
                        if(res.data.folderCapacity == 0){
                            folderCapacity = '<fmt:message code="email.th.noLimits" />';
                            $("#MB").attr("style","display:none;");
                        }else {
                            folderCapacity = res.data.folderCapacity;
                        }
                        // var folderCapacity = res.data.folderCapacity
                        $('#totalFileSize').html(totalFileSize)
                        $('#folderCapacity').html(folderCapacity);
                        // 只执行一次，如果第一次进入页面时容量超出，则给出提示
                        if (window.onlyOnce == undefined) {
                            if (totalFileSize > folderCapacity) alert(res.msg);
                            window.onlyOnce = 'yes';
                        }
                        if(res.flag == false) {
                            $("#batch").hide();
                            $("#batch1").hide();
                            $("#batch2").hide();
                            $("#MB").html(' MB。<font style="color:red;"><fmt:message code="workflow.th.NoNewFileCanBeCreated"/></font>');
                        } else {
                            $("#batch").show();
                            $("#batch1").show();
                            $("#batch2").show();
                            $("#MB").html(' MB');
                        }
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
    layer.msg('<fmt:message code="lang.th.Upcoming"/>', {icon: 6});
}

</script>
</head>
<body>
<div class="contentPage" style="height: 100%;">

    <div  class="cabinet_left">
      <div class="fileBox shareFile" id="public"  style="border-right: #9e9e9e 1px solid;">
          <div class="div_Img">
              <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personalFile.png" style="vertical-align: middle;" alt="">
          </div>
          <div class="divP" style="width: 76px;" title="<fmt:message code="main.personnel"/>"><fmt:message code="main.personnel"/></div>
      </div>
       <div class="fileBox" onclick="" id="personal" style="">
           <input type="hidden" name="MANAGE_USER">
           <div class="div_Img">
               <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personalFile.png" style="vertical-align: middle;" alt="">
           </div>
           <div class="divP" style="width: 78px;" title="<fmt:message code="workflow.th.SharedFileCabinet"/>"><fmt:message code="workflow.th.SharedFileCabinet"/></div>
       </div>
        <div style="clear: both;"></div>
        <div id="fileTransfor" style="width:100%;">
            <%--<div class="rootDirectory" style="">根目录</div>--%>
            <ul id="fileTree" class="easyui-tree">
            </ul>
        </div>
        <div id="shareCabinet" style="width:100%;display: none">
            <ul id="shareTree" class="easyui-tree">
            </ul>
        </div>

    </div>
    <div class="cabinet_info" style="width:calc(100% - 263px)">
        <div class="mainContent" style="display:block;">
            <%--<div class="divFolder">--%>
                <%--<img style="margin-left: 20px;vertical-align: middle;margin-top: -5px;" src="/img/file/icon_wenjianjia.png" alt="">--%>
                <%--<span class="spanFolder" style="margin-left: 5px;font-size: 11pt;">根目录</span>--%>
            <%--</div>--%>
            <div class="head w clearfix">
                <div class="divFolder">
                    <img style="margin-left: 20px;vertical-align: middle;margin-top: -5px;" src="/img/file/icon_wenjianjia.png" alt="">
                    <span class="spanFolder" style="margin-left: 5px;font-size: 11pt;"><fmt:message code="workflow.th.RootDirectory"/></span>
                </div>
                <div id="overall" class="ss four" style="margin-right: 12px;"> <a href="javascript:;"><img src="/img/file/icon_globalSearch.png" style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" alt=""><fmt:message code="Email.th.global"/></a></div>

                <div id="SEARCH" class="ss three"> <a  class="SEARCH" href="javascript:;" style="left: 25px;"><img src="/img/file/icon_search.png" style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.query"/></a></div>
                <div id="batch" class="ss two">
                    <form id="uploadimgform" target="uploadiframe"  action="/newFileContent/fileBoxUpload" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="sortId">
                        <input type="file" name="file" id="uploadinputimg" multiple="multiple" class="w-icon5" style="position: absolute;z-index: 99999;width: 89px;opacity:0;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                        <a href="#" id="uploadimg"><img style="margin-right: 3px;margin-left: -18px;margin-bottom: 4px;" src="../../img/mywork/shangchuan.png" alt=""><fmt:message code="notice.th.up"/></a>
                    </form>
                </div>
                <div class="ss one" id="batch1" style="border-radius: 3px;width: 200px;"> <a id="scanning" href="javascript:;"><img style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="workflow.th.CreateAndScanFiles"/></a></div>
                <div class="ss one" id="batch2" style="border-radius: 3px;"> <a id="contentAdd" href="javascript:;"><img style="margin-right: 4px;margin-left: -16px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="file.th.newfile"/></a></div>
            </div>
            <div style="clear: both;"></div>
            <!--middle部分开始-->
            <div class="w" style="margin-top: 10px;">
                <div class="wrap marouto">
                    <input type="hidden" name="sortTxt" value="<fmt:message code="main.th.RootFolder"/>">
                    <table class="w wen">
                        <thead>
                        <tr>
                            <td class="th" width="28%"><fmt:message code="file.th.name"/></td>
                            <td class="th" width="35%"><fmt:message code="email.th.file"/></td>
                            <td class="th" width="20%" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="7%" style="">
                                <fmt:message code="file.th.Sort" />
                                <%--<fmt:message code="file.th.Sort"/>--%>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="10%"><fmt:message code="notice.th.operation"/></td>
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
               <%-- <div class="boto" onclick="clicked()">
                    <a class="ONE" href="javascript:;"><span>签阅</span></a>
                </div>--%>
                <div class="boto addBackground" id="copy">
                    <a class="TWO" href="javascript:;"><img src="/img/file/icon_copy.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.copy"/></a>
                </div>
                <div class="boto addBackground" id="shear">
                    <a class="THREE" href="javascript:;"><img src="/img/file/icon_cut.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="file.th.cut"/></a>
                </div>
                <div class="boto" id="paste" style="display: none;">
                    <a class="SIX" href="javascript:;"><img src="/img/file/icon_paste_s.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="fille.th.paste"/></a>
                </div>
                <div class="boto addBackground" id="deleFile">
                    <a class="FOURs" href="javascript:;"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.delete"/></a>
                </div>
                <%--<div class="boto">--%>
                    <%--<a class="FIVE FiveOne" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>--%>
                <%--</div>--%>

            </div>
            <div class="floderOperation" style="display: block;">
                <input type="hidden" name="folderId" value="">
                <div class="childFolders" style="display: block;">
                    <div class="operation"><fmt:message code="file.th.op"/>：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolders" href="javascript:;"><img style="margin-right: -26px;margin-left: 7px;margin-bottom: 2px;" src="../../img/mywork/newbuildworjk.png" alt=""><span><fmt:message code="file.th.newf"/></span></a>
                    </div>
                </div>
                <div class="childFolder" style="display: none;">
                    <div class="operation"><fmt:message code="file.th.op"/>：</div>
                    <div class="newChildFolder">
                        <a id="newChildFolder" href="javascript:;"><img style="margin-right: 4px;margin-left: 9px;margin-bottom: 3px;" src="../../img/mywork/newbuildworjk.png" alt=""><span style="margin-left: 2px"><fmt:message code="file.th.newf"/></span></a>
                    </div>
                    <div class="editFolder">
                        <a id="editFolder" href="javascript:;"><img src="/img/file/icon_edit.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="global.lang.edit"/></a>
                    </div>
                    <div class="deleteFolder">
                        <a id="deleteFolder" href="javascript:;"><img src="/img/file/icon_fileDelete.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="flie.th.dele"/></a>
                    </div>
                    <div class="shareFolder" style="width:150px;height: 28px;margin-top: 6px;background: #2b7fe0;border-radius: 3px;text-align: center;">
                        <span id="shareFolder" href="javascript:;" style="line-height: 28px;color:#ffffff;cursor:pointer"><img src="/img/file/icon_share.png" style="margin-right: 4px;margin-left: -2px;margin-bottom: 3px;" alt=""><fmt:message code="workflow.th.ShareUnsetsSharedFolder"/></span>
                    </div>
                </div>
            </div>
                <div class="capacityLimitation" style="margin-left: 20px">
                    <span style="font-size: 16px"><fmt:message code="email.th.microSD"/> <span id="totalFileSize"></span> MB，<fmt:message code="email.th.totalCapacityLimit"/> <span id="folderCapacity"></span><span id="MB"> MB</span></span>
                </div>
            <div class="attach" style="display: none;">
                <div style="overflow: hidden;">
                    <div class="progress" id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: -12px;">
                        <div class="bar" style="width: 0%;"></div>
                    </div>
                    <div class="barText" style="float: left;margin-left: 10px;"></div>
                </div>
                <div class="box" id="fileName"></div>
               <%-- <div class="remind">
                    <p>事务提醒：</p>
                    <input type="radio" name="remindUser" value="">
                    <span>手动选择被提醒人员</span>
                    <input type="radio" name="remindUser" value="">
                    <span>提醒全部有权限人员</span>
                </div>
                <div class="inPole">
                    <textarea name="txt" id="userDuser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
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
                <div class="divBtns">
                    <div class="start" id="start"><fmt:message code="file.th.StartUploading"/></div>
                    <div class="cancle"><fmt:message code="file.th.cancelAll"/></div>
                </div>
            </div>
        </div>
        <div class="details" style="display:none;margin-top: 10px">
            <div class="w">
                <div class="wrap marouto">
                    <table class="w">
                        <thead>
                        <tr>
                            <td class="th" width="28%"><fmt:message code="file.th.name"/></td>
                            <td class="th" width="27%"><fmt:message code="email.th.file"/></td>
                            <td class="th" width="20%" style="">
                                <fmt:message code="notice.th.PostedTime"/>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="15%" style="">
                                <fmt:message code="file.th.Sort"/>
                                <%--<fmt:message code="file.th.Sort"/>--%>
                                <%--<img style="position: absolute;margin-left:9px;cursor: pointer;" src="../img/file/cabinet05.png" alt=""/>--%>
                                <%--<img style="position: absolute;margin-top:10px;margin-left:9px;cursor: pointer;" src="../img/file/cabinet06.png " alt=""/>--%>
                            </td>
                            <td class="th" width="10%"><fmt:message code="notice.th.operation"/></td>
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
            <div style="clear:both;"></div>
            <div class="bottom w">
                <div class="checkALL">
                    <input id="checkedAlls" type="checkbox" name="" value="" >
                    <label for="checkedAlls"><fmt:message code="notice.th.allchose"/></label>
                </div>
                <%--<div class="boto" onclick="clicked()">
                    <a class="ONE" href="javascript:;"><span>签阅</span></a>
                </div>--%>
                <div class="boto">
                    <a class="FIVE FiveTow addBackground" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>
                </div>
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
                <div class="wrap marouto">
                    <table class="w">
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
                <div class="boto">
                    <a class="FIVE FiveTow addBackground" id="exportA" href="javascript:;"><span><fmt:message code="file.th.download"/></span></a>
                </div>
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
                    <td style="border-right: #ccc 1px solid"><fmt:message code="file.th.Sort"/></td>
                    <td>
                        <input type="text" name="edSerial" value="">
                    </td>
                </tr>
                <tr>
                    <td style="border-right: #ccc 1px solid"><fmt:message code="file.th.filename"/></td>
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
</div>
<script>
    //查询列表方法
    function queryOneDatasd(sortId){
        var data={
            sortType:'4',
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
                var arr1=[]
                for(var m=0;m<data.length;m++){
                    if(data[m].attachmentList != undefined){
                        arr1.push(data[m].attachmentList[0]);
                    }
                }
                for(var i=0;i<data1.length;i++){
                    var arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;display: inline-block;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td>"+attachView(arr,'','3','1','1','0',arr1,'wenjiangui')+"</td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                    }else{
                        str+="  <tr class='contentTrs' sortId='"+data1[i].sortId+"' contentId='"+data1[i].contentId+"' conType='2'><td><input class='checkChildren' type='checkbox' conId='"+data1[i].contentId+"' name='check' value='' > <a class='TITLE' style='color:#54b6fe;display: inline-block;' href='javascript:;'>"+data1[i].subject+ "  </a></td>  <td></td> <td> "+data1[i].sendTime+ "  </td><td> "+data1[i].contentNo+ "  </td><td><a href='javascript:;' class='editBtn'><fmt:message code="global.lang.edit"/></a></td></tr>"
                    }
                }
                $('#file_Tachrs').append(str);
                $(".contentTrs").on('click',function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAlls').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
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

                $('#checkedAlls').prop("checked",false);
            }
        })
    }

    function queryAllDatasd(){
        var data={
            sortType:'4',
            pageNo:1,
            pageSize:10,
            serachType:'1',
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
            endTime:endTime
        }
        $.ajax({
            type:'post',
            url:'../file/serachAll',
            dataType:'json',
            data:data,
            success:function(res){
                $('#file_Tach').find('tr').remove();
                var data1=res.obj;
                var str='';
                var arr=new Array();
                var arr1=[]
                for(var m=0;m<data.length;m++){
                    if(data[m].attachmentList != undefined){
                        arr1.push(data[m].attachmentList[0]);
                    }

                }
                for(var i=0;i<data1.length;i++){
                    var stra='';
                    arr=data1[i].attachmentList;
                    if(data1[i].attachmentName!=''){
                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;display: inline-block;">'+data1[i].subject+'</a></td><td>'+attachView(arr,'','3','1','1','0',arr1,'wenjiangui')+'</td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>';
                    }else {
                        str+='<tr class="contentT" sortId="'+data1[i].sortId+'" contentId="'+data1[i].contentId+'" conType="3"><td><input class="checkChildren" conId="'+data1[i].contentId+'" type="checkbox" name="check" value="" style="margin-right:15px;" >'+data1[i].filePath+'</td><td><a class="TITLE" href="javascript:;" style="color:#54b6fe;margin-left:0;display: inline-block;">'+data1[i].subject+'</a></td><td></td><td>'+data1[i].attachmentDesc+'</td><td>'+data1[i].sendTime+'</td><td><a href="javascript:;" class="editBtn"><fmt:message code="global.lang.edit"/></a></td></tr>'
                    }
                }
                $('#file_Tach').append(str);
                $(".contentT").on('click',function () {
                    var state=$(this).find('.checkChildren').prop("checked");
                    if(state==true){
                        $(this).find('.checkChildren').prop("checked",true);
                        $(this).addClass('bgcolor');
                    }else{
                        $('#checkedAllY').prop("checked",false);
                        $(this).find('.checkChildren').prop("checked",false);
                        $(this).removeClass('bgcolor');
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

                $('#checkedAllY').prop("checked",false);
            }
        })
    }
</script>

</body>
</html>
