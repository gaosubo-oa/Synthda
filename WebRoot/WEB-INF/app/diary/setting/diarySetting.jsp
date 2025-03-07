<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <title>工作日志设置</title>
    <style>
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .close_but{
            width:50px;
            height: 37px;
            margin-left:0px;
            line-height: 28px;
            border-radius: 4px;
            padding-left: 4px;
            cursor: pointer;
            /*color:#fff;*/
        }
        .success span{
            width: 132px;
            height: 35px;
            background-color: rgba(224, 224, 224, 0.61);
            font-size: 16px;
            border-radius: 5px;
            padding-left:8px;
            cursor:pointer;

            line-height: 30px;
            display: inline-block;
        }
        #save{
            background:url(../../img/vote/saveBlue.png) no-repeat;
            color:#fff;
            line-height:30px;
            font-size:16px;
            width:91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;

        }
        #refull{
            color:#000;
            width: 87px;
            line-height:30px;
            height: 30px;
            cursor: pointer;
            font-size:16px;
            background: url("../../img/vote/new.png") no-repeat;
            padding-left: 12px;

        }
        #addItem,#addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
            width: 142px;
        }
        #addChild{
            background:url(../../img/vote/save.png) no-repeat;
            color:#fff;
        }

        #back {
            display: inline-block;
            width: 78px;
            height: 38px;
            line-height: 30px;
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/edu/eduSchoolCalendar/back.png) no-repeat;
            padding-left: 7px;
            font-size: 14px;
        }
        .laydate-footer-btns{
            position: absolute;
            right: 69px;
            top: 10px;
        }
        .layui-laydate-content{
            margin-left: 33px;
        }
        table tbody tr td{
            font-size: 11pt !important;
        }
        .nav li {
            height: 33px;
            line-height: 32px;
            float: left;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 6px;
            cursor: pointer;
        }
        .head-top {
            width: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            height: 45px;
            border-bottom: 1px solid #999;
            background: #fff;
            overflow: hidden;
            z-index: 9999999;
        }
        .head-top ul .head-top-li.active {
            background: #2F8AE3;
            color: #fff;
        }
        .head-top ul .head-top-li {
            height: 26px;
            line-height: 26px;
            margin: 10px 11px 0px 11px;
            padding: 1px 20px;
            font-size: 14px;
            border-radius: 20px;
            cursor: pointer;
        }

    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" data-type="">日志设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="0">汇报设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="1">层级关系</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="2">日志查询权限设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="3">移动端模板设置</li>
    </ul>
</div>
<div class="step1" style="display: block;margin-left: 10px;">
    <div class="dandianLogin">
        <div class="nav_box clearfix" style="margin-top: 40px;">
            <div class="nav_t2" class="news">工作日志设置</div>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
        <table class="newNews">
            <tbody>
            <tr>
                <td class="blue_text">
                    锁定以下时间范围的日志:
                </td>
                <td>
                    <label class="" style="display: inline-block;">设置锁定时间范围</label>
                    <input class="td_title1" type="text" placeholder="" id="startTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" style="float:none;width: 150px"/>至
                    <input class="td_title1" type="text" placeholder="" id="endTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" style="float:none;width: 150px"/><br>
                    <label class="" style="display: inline-block;">说明：都为空表示不锁定，也可以只填写其中一个</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    锁定指定天数以前的日志：
                </td>
                <td>
                    <label class="" style="display: inline-block;">锁定</label>
                    <input class="td_title1" type="text" placeholder="" id="lockDay" style="width: 25px;float: none;"/>天前的日志
                    <label class="" style="display: inline-block;">说明：0或空表示不锁定</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    可否对其他人的日志给予点评：
                </td>
                <td>
                    <input type="checkbox" name="" id="isComments" value="1">
                    <label class="" style="display: inline-block;">允许对其他人的日志给予点评</label>
                    <label class="" style="display: inline-block;">说明：选中为允许对所有人点评</label>
                </td>
            </tr>

            <tr>
                <td class="td_w blue_text">
                    锁定日志后是否允许共享：
                </td>
                <td>
                    <input type="checkbox" name="" id="lockShare" value="1">
                    <label class="" style="display: inline-block;">允许共享</label>
                    <label class="" style="display: inline-block;">说明：选中为允许共享</label>
                </td>
            </tr>

            <tr style="display: none">
                <td class="td_w blue_text">
                    是否允许设置默认对所有人共享：
                </td>
                <td>
                    <input type="checkbox" name="" id="allShare" value="1">
                    <label class="" style="display: inline-block;">允许对所有人共享</label>
                    <label class="" style="display: inline-block;">说明：选中为允许对所有人共享</label>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    默认工作日志模板：
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;" id="workModel" name="workModel">
                    </select>
                    <label class="" style="display: inline-block;">说明：选择默认的工作日志模板</label>
                </td>
            </tr>
            </tbody>

            <div>
                <tr style="text-align:center">
                    <td colspan="2">
                        <button type="button" class="close_but" id="save"><fmt:message code="global.lang.save" /></button>
                    </td>
                </tr>
            </div>
        </table>
    </div>
</div>

</body>

<script type="text/javascript">
    $('.head-top li').on("click",function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')==''){
            window.location.href = "/diarySetting/index"
        }else if($(this).attr('data-type')=='0'){
            window.location.href = "/diarySetting/logSetting"
        }else if($(this).attr('data-type')=='1'){
            window.location.href = "/diarySetting/hierarchy"
        }else if($(this).attr('data-type')=='2'){
            window.location.href = "/diaryReadPriv/readPrivIndex"
        }else if($(this).attr('data-type')=='3'){
            window.location.href = "/diarySetting/mobileTemplate"
        }
    })
    //默认模板
    modelType();
    function modelType() {
        $.ajax({
            type: 'get',
            url: '/htmlModel/selectAllHtmlModel?modelType=3',
            dataType: 'json',
            success: function (res) {
                var str = '';
                if(res.msg == "暂无数据" || res.flag == 'error'){
                    str += '<option value="不使用模板">不使用模板</option>';
                }else{
                    var data = res.obj;
                    str = '<option value="不使用模板">不使用模板</option>';
                    for (var i = 0; i < data.length; i++) {
                        str += '<option value="' + data[i].modelId + '">' + data[i].modelName + '</option>';
                    }
                }
                $('select[name="workModel"]').append(str);
            }
        })
    }
    $(function () {
        //回显
        showCas();
        //保存
        function save(){
            if($('#isComments').is(":checked")){
                var isComments = 1
            }else{
                var isComments = 0
            }
            if($('#lockShare').is(":checked")){
                var lockShare = 1
            }else{
                var lockShare = 0
            }
            if($('#allShare').is(":checked")){
                var allShare = 1
            }else{
                var allShare = 0
            }
            var lockTime = $("#startTime").val()+','+$("#endTime").val()+','+$("#lockDay").val()
            var data={
                lockTime:lockTime,
                isComments:isComments,
                lockShare:lockShare,
                allShare:allShare,
                diaryWorkLogFormat:$('#workModel').val()
            };
            $.ajax({
                type: 'post',
                url: '/diarySetting/saveSetting',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg(res.msg,{time:1000,icon:1},function () {
                            //刷新
                            window.location.reload();
                        });
                    }else{
                        layer.msg(res.msg,{time:1500,icon:2});
                    }

                }
            })


        }

        function showCas(){
            var paraName = 'LOCK_TIME,IS_COMMENTS,LOCK_SHARE,ALL_SHARE,DIARY_WORK_LOG_FORMAT'
            $.ajax({
                type: 'get',
                url: '/sysTasks/getSysParaList',
                dataType: 'json',
                data:{
                    paraName:paraName
                },
                success: function (res) {
                    if(res.flag){
                        var o=res.obj;
                        if(o!=undefined){
                            if(o[0].paraValue == '0'){
                                $('#allShare').prop('checked',false)
                            }else{
                                $('#allShare').prop('checked',true)
                            }
                            if(o[2].paraValue == '1'){
                                $('#isComments').prop('checked',true)
                            }else{
                                $('#isComments').prop('checked',false)
                            }
                            if(o[3].paraValue == '1'){
                                $('#lockShare').prop('checked',true)
                            }else{
                                $('#lockShare').prop('checked',false)
                            }
                            var lockTime = o[4].paraValue.split(',')
                            $("#startTime").val(lockTime[0]);
                            $("#endTime").val(lockTime[1]);
                            $("#lockDay").val(lockTime[2]);
                            if(o[1].paraValue != ''){
                                $("#workModel option").each(function(){
                                    if($(this).val() == o[1].paraValue){
                                        $(this).attr("selected", true);
                                    }
                                });
                            }
                        }
                    }
                }
            })
        }

        $('#save').on("click",function () {
            save();
        });
    });


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
</html>
