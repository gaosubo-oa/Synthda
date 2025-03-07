
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="censor.th.modulesettings" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .fileDone select{
            width: 160px;
            height:28px;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        .M-box3{
            float: right;
        }
        .newMange input[type="text"]{
            width: 260px;
            height: 30px;
        }
        select{
            width: 260px;
            height: 30px;
        }
        textarea{
            width: 260px;
            height: 50px;
            min-width: 260px;
            min-height: 50px;
            vertical-align: bottom;
        }
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        .divBtn{
            float: right;
            width: 90px;
            height: 28px;
            background: #2b7fe0;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin-right: 4%;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
        }
        .divTable{
            width: 60%;
            margin: 0px auto;
        }
        .divTable table{
            width: 100%;
        }
        .divTable table tr th{
            padding: 8px;
            /*font-size: 11pt;*/
            font-size: 13pt;
            color: #2F5C8F;
            border-right: #ccc 1px solid;
        }

        td{
            font-size: 11pt;
        }

        .divTable table tr td{
            text-align: center;
            border-right: #ccc 1px solid;
            padding: 8px;
        }
        .divLayer{
            width: 100%;
        }
        .divLayer table{
            width: 96%;
            margin: 15px auto;
        }
        .divLayer table tr{
            border: none;
        }
        .divLayer table tr td{
            text-align: left;
            padding: 8px;
        }
        .divLayer table tr td:first-of-type{
            width: 80px;
        }
        .divLayer table tr td input{
            width: 300px;
            height: 30px;
            border-radius: 4px;
            outline: none;
        }
        .divLayer table tr td b{
            margin-left: 5px;
            color: #f00;
        }
    </style>

    <%--<script src="/js/censor/moduleSettings.js"></script>--%>
</head>
<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="atSet" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
            <h2><fmt:message code="censor.th.modulesettings"/></h2>
            <div id="Confidential"style="display: inline-block"></div>
        </div>
    </div>
    <div class="divTable" style="display: block;">
        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
            <thead>
            <tr>
                <th>选择</th>
                <th>模块名称</th>
                <th>启用过滤</th>
                <th>审核人员</th>
                <th>事务提醒</th>
                <th>手机短信提醒</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="trList">

            </tbody>
        </table>
        <div class="right">
            <!-- 分页按钮-->
            <div class="M-box3" id="dbgz_page"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var user_id='';
    $(function () {
        dataList($('#trList'));
//        编辑
        $('#trList').on('click','.editData',function () {
            var modelId=$(this).parents('tr').attr('data-id');
            layer.open({
                type:1,
                title:['修改过滤模块', 'background-color:#2b7fe0;color:#fff;'],
                area: ['630px', '400px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['确定', '取消'],
                content:'<div class="divLayer">' +
                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                '<tr>' +
                '<td>模块名称：</td>' +
                '<td><input type="text" name="moduleName" value="" style="padding-left: 5px;" readonly></td>' +
                '</tr>' +
                '<tr>' +
                '<td>启用过滤：</td>' +
                '<td><label for=""><input type="checkbox" name="useFlag">启用过滤</label></td>' +
                '</tr>' +
                '<tr>' +
                '<td>审核人员：</td>' +
                '<td>' +
                '<textarea name="checkUser" id="checkUser" readonly></textarea>' +
                '<a href="javascript:;" style="margin: 0 10px;" class="addUser">选择</a>' +
                '<a href="javascript:;" class="clearUser">清空</a>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>事务提醒：</td>' +
                '<td><label for=""><input type="checkbox" name="smsRemind">向审核人员发送事务提醒消息</label>' +
                '<label for=""><input type="checkbox" name="sms2Remind" style="margin-left: 10px;">向审核人员发送手机短信提醒</label>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>禁止提示：</td>' +
                '<td>' +
                '<textarea name="bannedHint" id="bannedHint"></textarea>' +
                '<span style="color:#999;font-size: 9pt;"> 内容被禁止时提示的消息，为空则不提示</span>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>审核提示：</td>' +
                '<td>' +
                '<textarea name="modHint" id="modHint"></textarea>' +
                '<span style="color:#999;font-size: 9pt;"> 内容需先审核才可通过时提示的消息，为空则不提示</span>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td>过滤提示：</td>' +
                '<td>' +
                '<textarea name="filterHint" id="filterHint"></textarea>' +
                '<span style="color:#999;font-size: 9pt;"> 内容被过滤时提示的消息，为空则不提示</span>' +
                '</td>' +
                '</tr>' +
                '</table>' +
                '</div>',
                success:function () {
                    $('input[name="useFlag"]').on("click",function () {
                        var state =$(this).prop("checked");
                        if(state == true){
                            $(this).prop("checked",true);
                            $(this).val('1');
                        }else{
                            $(this).prop("checked",false);
                            $(this).val('0');
                        }
                    })
                    $('input[name="smsRemind"]').on("click",function () {
                        var state =$(this).prop("checked");
                        if(state == true){
                            $(this).prop("checked",true);
                            $(this).val('1');
                        }else{
                            $(this).prop("checked",false);
                            $(this).val('0');
                        }
                    })
                    $('input[name="sms2Remind"]').on("click",function () {
                        var state =$(this).prop("checked");
                        if(state == true){
                            $(this).prop("checked",true);
                            $(this).val('1');
                        }else{
                            $(this).prop("checked",false);
                            $(this).val('0');
                        }
                    })
                    $.ajax({
                        type:'get',
                        url:'/censor/getCensorModuleInforById',
                        dataType:'json',
                        data:{
                            moduleId:modelId
                        },
                        success:function (res) {
                            var datas=res.object;
                            $('input[name="moduleName"]').val(datas.moduleName);
                            if(datas.useFlag == '1'){
                                $('input[name="useFlag"]').prop('checked',true);
                                $('input[name="useFlag"]').val('1');
                            }else{
                                $('input[name="useFlag"]').prop('checked',false);
                                $('input[name="useFlag"]').val('0');
                            }
                            $('#checkUser').attr('user_id',datas.checkUser);
                            $('#checkUser').val(datas.checkUserName);
                            if(datas.smsRemind == '1'){
                                $('input[name="smsRemind"]').prop('checked',true);
                                $('input[name="smsRemind"]').val('1');
                            }else{
                                $('input[name="smsRemind"]').prop('checked',false);
                                $('input[name="smsRemind"]').val('0');
                            }
                            if(datas.sms2Remind == '1'){
                                $('input[name="sms2Remind"]').prop('checked',true);
                                $('input[name="sms2Remind"]').val('1');
                            }else{
                                $('input[name="sms2Remind"]').prop('checked',false);
                                $('input[name="sms2Remind"]').val('0');
                            }
                            $('#bannedHint').val(datas.bannedHint);
                            $('#modHint').val(datas.modHint);
                            $('#filterHint').val(datas.filterHint);

                        }
                    })
                },
                yes:function (index) {
                    $.ajax({
                        type:'post',
                        url:'/censor/updateCensorModule',
                        dataType:'json',
                        data:{
                            moduleId:modelId,
                            moduleName:$('input[name="moduleName"]').val(),
                            useFlag:$('input[name="useFlag"]').val(),
                            checkUser:$('#checkUser').attr('user_id'),
                            smsRemind:$('input[name="smsRemind"]').val(),
                            sms2Remind:$('input[name="sms2Remind"]').val(),
                            bannedHint:$('#bannedHint').val(),
                            modHint:$('#modHint').val(),
                            filterHint:$('#filterHint').val(),
                        },
                        success:function (res) {
                            if(res.flag){
                                layer.msg('修改成功！',{icon:1})
                                dataList($('#trList'));
                                layer.close(index);
                            }else{
                                layer.msg('修改失败！',{icon:1})
                            }
                        }
                    })
                }
            })
            $('.addUser').on("click",function () {
                user_id='checkUser';
                $.popWindow("../common/selectUser");
            })
            $('.clearUser').on("click",function () {
                $('#checkUser').attr('user_id','');
                $('#checkUser').attr('userprivname','');
                $('#checkUser').attr('dataid','');
                $('#checkUser').attr('username','');
                $('#checkUser').val('');
            })
        })
//        删除
        $('#trList').on('click','.deleteData',function () {
            var modelId=$(this).parents('tr').attr('data-id');
            layer.confirm('确定要删除吗？', {
                btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                title:"删除"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/censor/delCensorModule',
                    dataType:'json',
                    data:{
                        moduleId:modelId
                    },
                    success:function(res){
                        if(res.flag){
                            layer.msg('删除成功！', { icon:6});
                            dataList($('#trList'));
                        }else{
                            layer.msg('删除失败！', { icon:5});
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })
    })
    function dataList(element){
        var ajaxPage={
            data:{
                page:1,
                pageSize:10,
                useFlag:true,
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/censor/getCensorModule',
                    dataType:'json',
                    data:me.data,
                    success:function (res) {
                        var datas=res.obj;
                        if(res.flag){
                            var str='';
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].moduleId+'">' +
                                    '<td><input type="checkbox" name="tdCheck" value=""></td>' +
                                    '<td>'+datas[i].moduleName+'</td>' +
                                    '<td>'+function () {
                                       if(datas[i].useFlag == '0'){
                                           return '<b style="color: red;">×</b>'
                                       }else {
                                           return '<b style="color: green;">√</b>'
                                       }
                                    }()+'</td>' +
                                    '<td>'+datas[i].checkUserName+'</td>' +
                                    '<td>'+function () {
                                       if(datas[i].smsRemind == '0'){
                                           return '<b style="color: red;">×</b>'
                                       }else {
                                           return '<b style="color: green;">√</b>'
                                       }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].sms2Remind == '0'){
                                            return '<b style="color: red;">×</b>'
                                        }else {
                                            return '<b style="color: green;">√</b>'
                                        }
                                    }()+'</td>' +
                                    '<td><a href="javascript:;" class="editData" style="margin-right: 0px;">编辑</a></td>' +
                                    '</tr>'
                            }  //<a href="javascript:;" class="deleteData">删除</a>
                            element.html(str);
                            me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        }
                    }
                })

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
        };
        ajaxPage.page();
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>