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
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <title>工作日志设置</title>
    <style>
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
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
        .header {
            height: 43px;
            border-bottom: 1px solid #9E9E9E;
            overflow: hidden;
            margin-bottom: 10px;
            position: fixed;
            top: 0px;
            width: 100%;
            background-color: #fff;
            z-index: 1099;
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
        .select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 20px;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            -o-border-radius: 20px;
            -ms-border-radius: 20px;
        }
        .pad {
            padding: 6px 14px;
            line-height: 28px;
        }
        .space {
            width: 2px;
            margin-left: 16px;
        }
        #save2 {
            background: url(../../img/vote/saveBlue.png) no-repeat;
            color: #fff;
            line-height: 30px;
            font-size: 16px;
            width: 91px;
            height: 30px;
            cursor: pointer;
            padding-left: 11px;
        }
        .release3 {
            display: inline-block;
            font-size: 14px;
            color: #207bd6;
            margin-left: 10px;
            cursor: pointer;
            margin-top: 0px;
            margin-right: 20px;
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
        <li class="fl head-top-li" data-type="">日志设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li active" data-type="0">汇报设置</li>
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
            <div class="nav_t2" class="news">汇报设置</div>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
        <div></div>
        <table class="newNews">
            <tbody>
            <tr>
                <td class="blue_text">
                    白名单（人员）:
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="userList" disabled style="background-color: #e0e0e0"/>
                    <div class="release3" id="user_add">添加</div>
                    <label class="" style="display: inline-block;color: #c3bfbf;">白名单内的人员无需汇报</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    白名单（角色）：
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="privList" disabled style="background-color: #e0e0e0"/>
                    <div class="release3" id="priv_add">添加</div>
                    <label class="" style="display: inline-block;color: #c3bfbf;">白名单内的人员无需汇报</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    白名单（部门）：
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="deptList" disabled style="background-color: #e0e0e0"/>
                    <div class="release3" id="dept_add">添加</div>
                    <label class="" style="display: inline-block;color: #c3bfbf;">白名单内的人员无需汇报</label>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    汇报时间:
                </td>
                <td>
                    <input class="td_title1 layui-input"  type="text"  id="startTime" style="float:none;"/>至
                    <input class="td_title1" type="text" placeholder="" id="endTime" style="float:none"  /><br>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    汇报提醒时间:
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="reportTime"  />
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    周报截至时间:
                </td>
                <td>
                    <select class="td_title1" style="box-sizing: border-box;width: 206px" id="weekly" >
                        <option value="周一">周一</option>
                        <option value="周二">周二</option>
                        <option value="周三">周三</option>
                        <option value="周四">周四</option>
                        <option value="周五">周五</option>
                        <option value="周六">周六</option>
                        <option value="周日">周日</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    月报时间设置:
                </td>
                <td>
                    <input class="td_title1" type="text" placeholder="" id="monthReport"/>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    日志评论:
                </td>
                <td>
                    <label for="">
                        <input type="radio" name="comment" value="1" checked>
                        <span>开启</span>
                    </label>
                    <label for="">
                        <input type="radio" name="comment" value="0">
                        <span>关闭</span>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    是否提醒:
                </td>
                <td>
                    <label for="">
                        <input type="radio" name="whetherRemind" value="1" checked>
                        <span>提醒</span>
                    </label>
                    <label for="">
                        <input type="radio" name="whetherRemind" value="0">
                        <span>不提醒</span>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    假期设置:
                </td>
                <td>
                    <input type="checkbox" name="holidaySetting"  value="sunday">
                    <label class="" style="display: inline-block;">休息日不汇报</label>
                    <input type="checkbox" name="holidaySetting"  value="vacations">
                    <label class="" style="display: inline-block;">节假日不汇报</label>
                </td>
            </tr>
            <tr>
                <td class="td_w blue_text">
                    节假日期：
                </td>
                <td>
                    <textarea type="checkbox" name="" id="holidayDate" value="1" style="width: 200px;min-height: 70px"></textarea><br>
                    <label class="" style="display: inline-block;">文本框内的日期当天不进行汇报提醒！日期格式为：01-01|10-01|10-02（用|分隔）</label>
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
    $("#user_add").on("click", function () {
        user_id = "userList";
        $.popWindow("../common/selectUser");
    });
    //选部门
    $('#dept_add').on("click",function () {
        dept_id = 'deptList';
        $.popWindow("../common/selectDept?allDept=1");
    });
    //选角色
    $('#priv_add').on("click",function () {
        priv_id = 'privList';
        $.popWindow("../common/selectPriv?1");
    });
    layui.use(['form','laydate','eleTree'],function(){
        var form=layui.form,
            laydate=layui.laydate,
            eleTree=layui.eleTree;
        laydate.render({
            elem:'#startTime',
            trigger:'click',
            type:'time',
            format: 'HH:mm'
        })
        laydate.render({
            elem:'#endTime',
            trigger:'click',
            type:'time',
            format: 'HH:mm'
        })
        laydate.render({
            elem:'#reportTime',
            trigger:'click',
            type:'time',
            format: 'HH:mm'
        })
        laydate.render({
            elem:'#monthReport',
            trigger:'click',
            format: 'dd'
        })
        form.render();
    })
    $(function () {
        //回显
        showCas();
        //保存
        function save(){
            var str = ''
            $('input[name="holidaySetting"]:checked').each(function(){
                str += $(this).val()+','
            })
            if($('input[name="whetherRemind"]:checked').val() == 1 && $('#reportTime').val() == "" ){
                layer.msg("请设置汇报提醒时间！",{time:1500,icon:2});
                return false;
            }
            if($("#startTime").val() > $("#endTime").val()){
                layer.msg("汇报时间开始时间不能大于结束时间",{time:1500,icon:2});
                return false;
            }
            var data={
                whiteListUser:$('#userList').attr('user_id'),
                whiteListPriv:$('#privList').attr('privid'),
                whiteListDept:$('#deptList').attr('deptid'),
                reportBegins:$("#startTime").val(),
                reportEnd:$("#endTime").val(),
                weekly:$("#weekly").val(),
                monthlyReport:$("#monthReport").val(),
                comment:$('input[name="comment"]:checked').val(),
                whetherRemind:$('input[name="whetherRemind"]:checked').val(),
                holidaySetting:str,
                holidayData:$('#holidayDate').val(),
                reportReminder:$("#reportTime").val(),
            };
            $.ajax({
                type: 'post',
                url: '/diarySetting/saveDiarySetting',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if(res.flag){
                        layer.msg('保存成功',{time:1000,icon:1},function () {
                            //刷新
                            window.location.reload();
                        });
                    }else{
                        layer.msg('保存失败',{time:1500,icon:2});
                    }

                }
            })


        }

        function showCas(){
            $.ajax({
                type: 'get',
                url: '/diarySetting/selectDiarySetting',
                dataType: 'json',
                success: function (res) {
                    if(res.flag){
                        var object=res.object;
                        if(object!=undefined){
                            $(":radio[name='comment'][value='" + object.comment + "']").prop("checked", "checked");
                            $(":radio[name='whetherRemind'][value='" + object.whetherRemind + "']").prop("checked", "checked");
                            $("#startTime").val(object.reportBegins || '');
                            $("#endTime").val(object.reportEnd || '');
                            $("#reportTime").val(object.reportReminder || '');
                            $("#monthReport").val(object.monthlyReport || '');
                            $("#weekly").val(object.weekly)
                            $("#userList").val(object.whiteListUserName || '');
                            $("#userList").attr('user_id',object.whiteListUser || '');
                            $("#privList").val(object.whiteListPrivName || '');
                            $("#privList").attr('privid',object.whiteListPriv || '');
                            $("#deptList").val(object.whiteListDeptName || '');
                            $("#deptList").attr('deptid',object.whiteListDept || '');
                            $("#holidayDate").val(object.holidayData || '');
                            if(object.holidaySetting != undefined && object.holidaySetting != ''){
                                var holidaySetting = object.holidaySetting.split(',')
                                for(var i=0; i<holidaySetting.length; i++){
                                    $('input[name="holidaySetting"]').each(function(){
                                        if($(this).val() == holidaySetting[i]){
                                            $(this).attr('checked',true)
                                        }
                                    })
                                }
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

