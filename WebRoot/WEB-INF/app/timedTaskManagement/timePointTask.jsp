<%--
  Created by IntelliJ IDEA.
  User: liran
  Date: 2018/5/18
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"
         language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>定时任务管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base.css">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <%--<link rel="stylesheet" href="/css/officialDocument/rentingList.css">--%>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">

    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/laydate.css"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <%--<script type="text/javascript" charset="utf-8" src="/lib/timing/laydate/laydate.js"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/base/base.js"></script>
    <%--<script src="/js/pzGrid/gridShjzry.js"></script>--%>

    <%--<script src="/js/pzGrid/runPsychosis.js"></script>--%>
    <style>
        .formUl li input[type=radio] {
            width: 16px;
        }

        .formUl li .radiolabel {
            width: 50px;
        }

        .divAdd {
            background-color: rgba(0, 0, 0, 0);
        }

        .clearfix input {
            float: none;
        }

        .importTable {
            width: 90%;
            margin: 20px auto;
        }

        .formUl li input {
            /*width: 100px;*/
            float: none;
        }

        .formUl li span {
            margin: 20px;
            line-height: 33px;
        }

        td {
            font-size: 11pt;
        }

        .headTop {
            border-bottom: none;
            margin: 10px;
            position: relative;
        }

        #demo .layui-table-cell{
            text-align: center;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            text-decoration: none;
        }
        .newTask{
            position: absolute;
            right: 2%;
            top: 7px;
        }
        .deletes{
            color: red;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

</head>
<body>
<div class="headTop">
    <div class="divTitle">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dingshirenwu.png" alt="">
        <fmt:message code="task.management" />
    </div>
<%--    <p class="newTask">新建任务</p>--%>
    <button type="button" class="layui-btn newTask"><fmt:message code="task.create" /></button>
</div>

<div  class="clearfix">

</div>

<div class="pagediv" style="margin: 0 auto;width: 97%;">


    <table>
        <thead>
        <tr>
            <th><fmt:message code="task.id" /></th>
            <th><fmt:message code="user.th.fbds"/></th>
            <th><fmt:message code="user.th.dfsfd"/></th>
            <th><fmt:message code="task.type" /></th>
            <th><fmt:message code="task.interval" /></th>
            <th><fmt:message code="task.execution.time" /></th>
            <th><fmt:message code="user.th.dfswa1"/></th>
            <th><fmt:message code="notice.th.state"/></th>
            <th><fmt:message code="notice.th.operation"/></th>
            <th><fmt:message code="task.type" /></th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr">

    </div>

</div>
</body>
<script type="text/javascript">
    var ajaxPage = {
        data: {
            page: 1,//当前处于第几页
            pageSize: 15,//一页显示几条
            useFlag: true,
//            gridId: null,
//            pName: null,
//            TYPE_MET: 2
        },

        page: function () {
            var me = this;
            $.post('/timedTaskJob/selectAll', me.data, function (json) {
                var arr = json.obj;
                if (arr.length > 0) {
                    function getDate(shijianchuo) {
                        var time = new Date(shijianchuo);
                        var y = time.getFullYear();
                        var m = time.getMonth() + 1;
                        var d = time.getDate();
                        var h = time.getHours();
                        var mm = time.getMinutes();
                        var s = time.getSeconds();
                        var datastr = y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':' + add0(mm) + ':' + add0(s);
                        return datastr.indexOf("NaN")>-1?"":datastr;
                    };
                    function add0(m) {
                        return m < 10 ? '0' + m : m
                    };
                    var str = '';
                    for (var i = 0; i < arr.length; i++) {
                        var status = '', abiao = '', operation = '', executionTime = '';
                        var deletes = '';
                        var taskType ='';
                        if(arr[i].taskName !='资格证书提醒'){
                            abiao = '<a class="liji" href="#"><fmt:message code="user.th.dfsfad" /></a>&nbsp&nbsp';
                        }

                        if (arr[i].executionTimeDate != '') {
                            executionTime = getDate(arr[i].executionTime)
                        }
                        if (arr[i].status == 1) {
                            operation = '<a class="switch" type="0" href="#" ><fmt:message code="task_config.close" /></a>';
                            status = "<p style='color:green'><fmt:message code="task_config.enabled" /></p>";
                        } else {
                            status = "<P style='color: red'><fmt:message code="task_config.disabled" /></p>";
                            operation = '<a class="switch" type="1"  href="#"><fmt:message code="task_config.open" /></a>';
                        }
                        if (arr[i].taskId < 1000) {
                            taskType = "<fmt:message code="task_config.system_built_in" />";
                        } else {
                            taskType = "<fmt:message code="task_config.customized" />";
                        }
                        var methodName = '';
// if(arr[i].methodName=="bakupDataBase"){
//     methodName='<a class="method" href="#">备份路径设置</a>';
// }

                        if (arr[i].isSystemTask == 2) {
                            deletes = '<a class="deletes" type="0" href="#"><fmt:message code="task_config.delete" /></a>';
                        }
                        str += '<tr taskId="' + arr[i].taskId + '"  taskType="' + arr[i].taskType + '">' +
                            '<td>' + arr[i].taskId + '</td>' +
                            '<td>' + arr[i].taskName + '</td>' +
                            '<td>' + arr[i].taskDescription + '</td>' +
                            '<td>' + function () {
                                if (arr[i].taskType == '1') {
                                    return '<fmt:message code="task_config.fixed_point_execution" />';
                                } else if (arr[i].taskType == '2') {
                                    return '<fmt:message code="task_config.custom_cron" />';
                                } else if (arr[i].taskType == '0') {
                                    return '<fmt:message code="task_config.interval_execution" />';
                                }
                            }() + '</td>' +
                            '<td>' + function () {
                                if (arr[i].intervalType == '0') {
                                    return arr[i].intervalTime + '<fmt:message code="task_config.minute" />';
                                } else if (arr[i].intervalType == '1') {
                                    return arr[i].intervalTime + '<fmt:message code="task_config.hour" />';
                                } else if (arr[i].intervalType == '2') {
                                    return arr[i].intervalTime + '<fmt:message code="task_config.day" />';
                                } else if (arr[i].intervalType == '3') {
                                    return arr[i].intervalTime + '<fmt:message code="task_config.week" />';
                                } else if (arr[i].intervalType == '4') {
                                    return arr[i].intervalTime + '<fmt:message code="task_config.month" />';
                                } else {
                                    return '';
                                }
                            }() + '</td>' +
                            '<td>' + function () {
                                if (arr[i].taskType == '1' && arr[i].executionTime!= undefined) {
                                    return arr[i].executionTime;
                                } else {
                                    return '';
                                }
                            }() + '</td>' +
                            '<td>' + function () {
                                if (arr[i].lastTime!= "" && arr[i].lastTime!= undefined) {
                                    return getDate(arr[i].lastTime);
                                } else {
                                    return "";
                                }
                            }() + '</td>' +
                            /*'<td>'+
                            arr[i].cron
                            + '</td>' +*/
                            '<td>' + status + '</td>' +
                            '<td>' +
                            '<a class="edit" href="#" status="' + arr[i].status + '"><fmt:message code="task_config.edit" /></a>&nbsp;&nbsp;' + abiao + operation + '&nbsp;&nbsp;<a class="execute" href="#"><fmt:message code="task_config.execution_log" /></a>&nbsp;&nbsp;' + methodName + '' + deletes + '' +
                            '</td>' +
                            '<td>' + taskType + '</td>' +
                            '</tr>'
                    }
                    $('.pagediv table tbody').html(str)
                    me.pageTwo(json.totleNum, me.data.pageSize, me.data.page)
                }

            }, 'json')
        },
        pageTwo: function (totalData, pageSize, indexs) {
            var mes = this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage: '',
                endPage: '',
                current: indexs,
                callback: function (index) {
                    mes.data.page = index.getCurrent();
                    mes.page();
                }
            });
        }
    }

    var chuzuwuId = null;
    $(function () {
        $('.executionDate').css('visibility','hidden')
        ajaxPage.page();

        setInterval(function () {
            ajaxPage.page();
        }, 120000);

        //查询
        $('.query1').click(function () {
            if ($('#gridId').attr('wanggeid') != '') {
                var gridId = $('#gridId').attr('wanggeid').replace(/,/g, "");
                ajaxPage.data.pGrid = gridId;
            } else {
                ajaxPage.data.pGrid = null;
            }
            ajaxPage.data.pName = $("#pName").val()
            ajaxPage.data.page = 1;
            ajaxPage.page()

        })


        $('#selGrid').click(function () {
            wangge_id = 'gridId';
            $.popWindow('/pzGridPage/selectDeptWG');
        })
        $('#emptyGrid').click(function () {
            $('#gridId').val('');
            $('#gridId').attr('wanggeid', '');
        })

        //刷新
        $('#refresh').click(function () {
            location.reload();
        })
        function taskType(num) {
            $('.executionDate').css('visibility','hidden')
            if (num == 0) {
                $("#dingshi").attr('checked', 'checked');
                $("#units").parent('li').show();
                $("#units").show();
                $("#units1").hide();
                $('#executionTime').parent('li').hide()
                $('#cron').parent('li').hide()
            } else if (num == 1) {
                $("#dingdian").attr('checked', 'checked');
                $("#units").parent('li').show();
                $("#units1").show();
                $("#units").hide();
                $('#executionTime').parent('li').show()
                $('#cron').parent('li').hide()

                if($('#units1').val()==4){
                    $('.executionDate').css('visibility','').html('<input type="text"  style="width: 35px;">日')
                }else if($('#units1').val()==3){
                    $('.executionDate').css('visibility','').html('星期:<input type="text"  style="width: 35px;margin-left: 0">')
                }
            } else {
                $("#dingdian").attr('checked', 'checked');
                $("#units").show();
                $("#units1").hide();
                $('#intwevalTime').parent('li').hide();
                $('#executionTime').parent('li').hide()
                $('#cron').parent('li').show()
            }
        }

        //新建任务
        $(document).on('click', '.newTask', function () {

            layer.open({
                title: '<fmt:message code="task_config.create_task" />',
                area: ['600px', '650px'],
                type: 1,
                content: '<ul class="formUl">' +
                    '<input type="hidden" id="rentId">' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_name" />：</label>' +
                    '<input id="taskname"></input>' +
                    '</li>' +
                    //lr +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.task_type" />：</label>' +
                    '<input  name="taskType"  style="margin-left:12px" type="radio" class="interval" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.interval_execution" /></span>' +
                    '<input  name="taskType"  style="margin-left:12px" type="radio" class="timing" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.fixed_point_execution" /></span>' +
                    '<input name="taskType" style="margin-left:12px" type="radio" class="cron" value="2"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.custom_cron" /></span>' +
                    '</li>' +
                    //+ ↑
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.execution_interval" />：</label>' +
                    '<div style="float: right;margin-right: 60px;" class="executionDate">' +
                    '<input type="text"  style="width: 35px;"><fmt:message code="task_config.day" /></div>' +
                    '<select id="units" style="width: 58px;float: right;">' +
                    '<option value="0"><fmt:message code="task_config.minute" /></option>' +
                    '<option value="1"><fmt:message code="task_config.hour" /></option>' +
                    '</select>' +
                    '<select id="units1" style="width: 60px;float: right;display:none;margin-left: 0;">' +
                    '<option value="2"><fmt:message code="task_config.day" /></option>' +
                    '<option value="3"><fmt:message code="task_config.week" /></option>' +
                    '<option value="4"><fmt:message code="task_config.month" /></option>' +
                    '</select>' +
                    '<input type="text" id="intwevalTime" style="width: 188px;"></span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.execution_time" />：</label> ' +
                    '<input type="text" id="executionTime"  placeholder="<fmt:message code="task_config.please_enter_date" />">' +
                    '</li>' +
                    '<li class="clearfix" style="display:none">' +
                    '<label><fmt:message code="task_config.cron_expression" />：</label>' +
                    '<input type="text" value="<fmt:message code="task_config.example" /> 0 0 2 * *? " id="cron" />' +
                    '</li>' +
                    '<li class="clearfix" >' +
                    '<label><fmt:message code="task_config.allow_synchronization" />：</label>' +
                    '<input  id="syncYn" style="margin-left:12px" type="radio" name="syncYn" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.synchronization" /></span>' +
                    '<input  id="syncYn" style="margin-left:12px" type="radio" name="syncYn" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.asynchronization" /></span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.continue_execution_after_failure" />：</label>' +
                    '<input  id="errContinueYn" style="margin-left:12px" type="radio" name="errContinueYn" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.terminate_task" /></span>' +
                    '<input  id="errContinueYn" style="margin-left:12px" type="radio" name="errContinueYn" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.continue_execution" /></span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_execution_class" />：</label>' +
                    '<input id="classPath"></input>' +
                    '</li>' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_execution_method" />：</label>' +
                    '<input id="methodName"></input>' +
                    '</li>' +


                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.task_description" />：</label>' +
                    '<textarea name="taskDescription" id="taskDescription" style="resize:auto"></textarea>' +
                    '</li>' +
                    '</ul>',
                btn: ['<fmt:message code="task_config.confirm" />', '<fmt:message code="task_config.return" />'],
                success: function () {
                    taskType(0)
                    $(".interval").attr('checked', 'checked');
                    $('[name="taskType"]').click(function () {
                        taskType($(this).val())
                    })

                    layui.use('laydate', function() {
                        var laydate = layui.laydate;
                        laydate.render({
                            elem: '#executionTime'
                            ,type: 'time'
                        });
                    })


                },
                yes:function(index){

                    if(isNaN($('#intwevalTime').val())){
                        $.layerMsg({content:'您输入的执行间隔格式不正确',icon:3,time:4000})
                        return false
                    }
                    var intervalTime = $('#intwevalTime').val();
                    var executionTime = $('#executionTime').val();
                    var taskType = $("input[name='taskType']:checked").val();
                    var syncYn = $("input[name='syncYn']:checked").val();
                    var errContinueYn = $("input[name='errContinueYn']:checked").val();
                    var taskname = $("#taskname").val();

                    var cron = $('#cron').val();
                    var taskDescription = $('#taskDescription').val();
                    var classPath = $('#classPath').val()
                    var methodName = $('#methodName').val()
                    var data={};
                    if (taskType==0){
                        intervalType = $("#units").val();
                    }else if (taskType=1){
                        intervalType = $("#units1").val();
                    }
                    data={
                        executionTime: executionTime,
                        taskType: taskType,
                        syncYn: syncYn,
                        errContinueYn: errContinueYn,
                        taskName: taskname,
                        intervalTime:intervalTime,
                        intervalType:intervalType,
                        taskDescription: taskDescription,
                        methodName : methodName,
                        classPath : classPath
                    }
                    $.ajax({
                        url: '/timedTaskJob/addTimeTask',
                        data:data,
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: '新增成功！', icon: 1})

                                ajaxPage.page();
                                layer.closeAll()
                            } else {
                                $.layerMsg({content: '新增失败！', icon: 2})
                            }
                        }
                    })
                }
            })
        })

        //我的编辑
        $(document).on('click', '.edit', function () {

            var me = this;
            var status = $(me).attr('status');
            var taskId = $(me).parents('tr').attr('taskId');
            layer.open({
                title: '<fmt:message code="user.th.jkn" />',
                area: ['600px', '650px'],
                type: 1,
                content: '<ul class="formUl">' +
                    '<input type="hidden" id="rentId">' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_name" />：</label>' +
                    '<span id="taskname"></span>' +
                    '</li>' +
                    //lr +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.task_type" />：</label>' +
                    '<input  name="taskType"  style="margin-left:12px" type="radio" class="interval" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.interval_execution" /></span>' +
                    '<input  name="taskType"  style="margin-left:12px" type="radio" class="timing" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.fixed_point_execution" /></span>' +
                    '<input name="taskType" style="margin-left:12px" type="radio" class="cron" value="2"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.custom_cron" /></span>' +
                    '</li>' +
                    //+ ↑
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.execution_interval" />：</label>' +
                    '<div style="float: right;margin-right: 60px;" class="executionDate">' +
                    '<input type="text"  style="width: 35px;"><fmt:message code="task_config.day" /></div>' +
                    '<select id="units" style="width: 58px;float: right;">' +
                    '<option value="0"><fmt:message code="task_config.minute" /></option>' +
                    '<option value="1"><fmt:message code="task_config.hour" /></option>' +
                    '</select>' +
                    '<select id="units1" style="width: 60px;float: right;display:none;margin-left: 0;">' +
                    '<option value="2"><fmt:message code="task_config.day" /></option>' +
                    '<option value="3"><fmt:message code="task_config.week" /></option>' +
                    '<option value="4"><fmt:message code="task_config.month" /></option>' +
                    '</select>' +
                    '<input type="text" id="intwevalTime" style="width: 188px;"></span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.execution_time" />：</label> ' +
                    '<input type="text" id="executionTime"  placeholder="<fmt:message code="task_config.please_enter_date" />">' +
                    '</li>' +
                    '<li class="clearfix" style="display:none">' +
                    '<label><fmt:message code="task_config.cron_expression" />：</label>' +
                    '<input type="text" id="cron" />' +
                    '</li>' +
                    '<li class="clearfix" >' +
                    '<label><fmt:message code="task_config.allow_synchronization" />：</label>' +
                    '<input  id="syncYn" style="margin-left:12px" type="radio" name="syncYn" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.synchronization" /></span>' +
                    '<input  id="syncYn" style="margin-left:12px" type="radio" name="syncYn" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.asynchronization" /></span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.continue_execution_after_failure" />：</label>' +
                    '<input  id="errContinueYn" style="margin-left:12px" type="radio" name="errContinueYn" value="0"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.terminate_task" /></span>' +
                    '<input  id="errContinueYn" style="margin-left:12px" type="radio" name="errContinueYn" value="1"><span  style="margin:0;margin-left:3px;"><fmt:message code="task_config.continue_execution" /></span>' +
                    '</li>' +

                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_execution_class" />：</label>' +
                    '<input id="classPath"></input>' +
                    '</li>' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="task_config.task_execution_method" />：</label>' +
                    '<input id="methodName"></input>' +
                    '</li>' +

                    '<li class="clearfix">' +
                    '<label><fmt:message code="task_config.task_description" />：</label>' +
                    '<textarea name="taskDescription" id="taskDescription" style="resize:auto"></textarea>' +
                    '</li>' +
                    '</ul>',
                btn: ['<fmt:message code="task_config.confirm" />', '<fmt:message code="task_config.return" />'],
                btn1: function (index) {
                        if(isNaN($('#intwevalTime').val())){
                            $.layerMsg({content:'您输入的执行间隔格式不正确',icon:3,time:4000})
                            return false
                        }
                        var intervalTime = $('#intwevalTime').val();
                        var executionTime = $('#executionTime').val();
                        var taskType = $("input[name='taskType']:checked").val();
                        var syncYn = $("input[name='syncYn']:checked").val();
                        var errContinueYn = $("input[name='errContinueYn']:checked").val();
                        var taskname = $("#taskname").val();

                        var classPath = $('#classPath').val()
                        var methodName = $('#methodName').val()

                        var cron = $('#cron').val();
                        var taskDescription = $('#taskDescription').val();
                        var url = '';
                        if (status == 0) {
                            url = '/timedTaskJob/editTimedTask'
                        } else {
                            url = '/timedTaskJob/editTimedRunTask'
                        }
                        var data={};
                        if(taskType==2){
                            data={
                                taskId: taskId,
                                taskType: taskType,
                                syncYn: syncYn,
                                errContinueYn: errContinueYn,
                                taskname: taskname,
                                cron: cron,
                                taskDescription: taskDescription,
                                classPath : classPath,
                                methodName : methodName
                            }
                        }else if(taskType==1){
                            data={
                                executionTime: executionTime,
                                taskId: taskId,
                                taskType: taskType,
                                syncYn: syncYn,
                                errContinueYn: errContinueYn,
                                taskname: taskname,
                                intervalTime:intervalTime,
                                intervalType:$('#units1').val(),
                                taskDescription: taskDescription,
                                classPath : classPath,
                                methodName : methodName
                            }
                            if($('#units1').val()==4||$('#units1').val()==3){
                                data['executionDate'] = $('.executionDate input').val()
                            }
                        }else {
                            data={
                                intervalTime: intervalTime,
                                taskId: taskId,
                                taskType: taskType,
                                syncYn: syncYn,
                                errContinueYn: errContinueYn,
                                taskname: taskname,
                                intervalType:$('#units').val(),
                                taskDescription: taskDescription,
                                classPath : classPath,
                                methodName : methodName
                            }

                        }
                        $.ajax({
                            url: url,
                            data:data,
                            type: 'post',
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag) {
                                    $.layerMsg({content: '<fmt:message code="netdisk.th.Editsuccess" />！', icon: 1})

                                    ajaxPage.page();
                                    layer.closeAll()
                                } else {
                                    $.layerMsg({content: '<fmt:message code="event.th.EditFailed" />！', icon: 2})
                                }
                            }
                        })

                },
                success: function () {
                    $('.executionDate').css('visibility','hidden')
                    $('#units1').click(function () {
                        $('.executionDate').css('visibility','hidden')
                        if($(this).val()=='4'){
                            $('.executionDate').css('visibility','').html('<input type="text"  style="width: 35px;">日')
                        }else if($(this).val()=='3'){
                            $('.executionDate').css('visibility','').html('星期:<input type="text"  style="width: 35px;margin-left: 0">')
                        }
                    })
                    layui.use('laydate', function() {
                        var laydate = layui.laydate;
                        laydate.render({
                            elem: '#executionTime'
                            ,type: 'time'
                        });
                    })
                    $.ajax({
                        url: '/timedTaskJob/findTimedTaskById',
                        data: {taskId: taskId},
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            var data = res.object;
                            $("#taskname").val(data.taskName);
                            $("#taskname").text(data.taskName);
                            $("#intwevalTime").val(data.intervalTime);
                            $('#executionTime').val(data.executionTime);
                            taskType(data.taskType)
                            $("#units").val(data.intervalType);

                            classPath = $('#classPath').val(data.classPath)
                            methodName = $('#methodName').val(data.methodName)

                            $('.executionDate').css('visibility','hidden')
                            if(data.intervalType=='4'){
                                $('.executionDate').css('visibility','').html('<input type="text"  value="'+data.executionDate+'" style="width: 35px;">日')
                            }else if(data.intervalType=='3'){
                                $('.executionDate').css('visibility','').html('星期:<input type="text"  value="'+data.executionDate+'" style="width: 35px;margin-left: 0">')
                            }
                            if (data.taskType == '0') {
                                $('.interval').attr('checked', 'checked');
                            } else if (data.taskType == '1') {
                                $("#units1").val(data.intervalType);
                                $('.timing').attr('checked', 'checked');
                            } else if (data.taskType == '2') {
                                $('.cron').attr('checked', 'checked');
                            }
                            if (data.cron != undefined) {
                                $("#cron").val(data.cron);
                            }
                            if (data.taskDescription != undefined) {
                                $("#taskDescription").val(data.taskDescription);
                            }
                            if (data.errContinueYn == '0') {
                                $('[name="errContinueYn"]').eq(0).attr('checked', 'checked');
                            } else if (data.errContinueYn == '1') {
                                $('[name="errContinueYn"]').eq(1).attr('checked', 'checked');
                            }
                            if (data.syncYn == '0') {
                                $('[name="syncYn"]').eq(0).attr('checked', 'checked');
                            } else if (data.syncYn == '1') {
                                $('[name="syncYn"]').eq(1).attr('checked', 'checked');
                            }

                        }
                    })

                    if (status == 0) {
                        $('#taskname').replaceWith('<input id="taskname"></input>')
                        $("input[name=syncYn]").remove("disabled");
                    } else {
                        //开启状态
                        $('#taskname').replaceWith('<span id="taskname"></span>')
                        $("input[name=syncYn]").attr("disabled", "true");
                    }
                    $('[name="taskType"]').click(function () {
                        taskType($(this).val())
                    })


                }
            })
        })
        //立即执行
        $(document).on('click', '.liji', function () {
            var taskId = $(this).parents('tr').attr('taskId')
            var taskType = $(this).parents('tr').attr('taskType')
            layer.open({
                title: '<fmt:message code="user.th.lkjnlk" />',
                area: ['300px', '220px'],
                type: 1,
                content: '<ul class="formUl">' +
                '<li class="clearfix" style="margin-top: 30px;">' +
                '<span style="margin-left: 40px;font-size:15px;"><fmt:message code="user.th.kljlk" />？<span>' +
                '</li>' +
                '</ul>',
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],
                btn1: function () {
                    layer.load(0, {time: 3 * 1000});
                    $.ajax({
                        url: '/timedTaskJob/executeNow',
                        data: {
                            taskId: taskId,
//                            taskType: taskType
                        },
                        type: 'post',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: res.msg, icon: 1}, function () {
                                    ajaxPage.page();
                                    layer.closeAll();
                                })
                            } else {
                                $.layerMsg({content: res.msg, icon: 5})
                            }
                        }


                    })
                }

            })
        })

        //备份路径设置
        $(document).on('click','.method',function () {
            $.ajax({
                url: '/syspara/selectByParaName?paraName=DATABASE_BACKUP_PATH',
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        layer.open({
                            title: '备份路径设置',
                            area: ['400px', '180px'],
                            type: 1,
                            content: '<div style="margin: 10px;">' +
                            '<div style="font-size: 16px;">数据库备份路径:</div>' +
                            '<textarea class="paraValue" style="font-size: 15px;resize: auto;width: 380px;height: 40px;margin-top: 2px;">'+res.object+'</textarea>' +
                            '</div>',
                            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],
                            btn1: function () {
                                layer.load(0, {time: 3 * 1000});
                                $.ajax({
                                    url: '/syspara/updateSysParaPlus',
                                    data: {
                                        paraName: 'DATABASE_BACKUP_PATH',
                                        paraValue: $('.paraValue').val()
                                    },
                                    type: 'post',
                                    dataType: 'json',
                                    success: function (res) {
                                        if (res.flag) {
                                            $.layerMsg({content: '设置成功', icon: 1}, function () {
                                                ajaxPage.page();
                                                layer.closeAll();
                                            })
                                        } else {
                                            $.layerMsg({content: res.msg, icon: 5})
                                        }
                                    }


                                })
                            }

                        })
                    }
                }
            })

        })

        //开启、关闭
        $(document).on('click', '.switch', function () {
            var taskId = $(this).parents('tr').attr('taskId')
            var type = $(this).attr('type')
            var title='确定要'+$(this).text()+'该任务吗？'
            layer.confirm(title, {
                btn: ['确认','取消'], //按钮
                title:'提示信息'
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'/timedTaskJob/taskSwitch',
                    dataType:'json',
                    data:{'taskId':taskId,'type':type},
                    success:function(res){
                        $.layerMsg({content:res.msg,icon:1})
                        location.reload();
                    }
                })
            }, function(){
                layer.closeAll();
            });
        })

        //执行日志
        $(document).on('click', '.execute', function () {
            var taskId = $(this).parents('tr').attr('taskId')
            layer.open({
                title: '<fmt:message code="execution.log" />',
                area: ['1050px', '500px'],
                type: 1,
                content: '<table id="demo" lay-filter="test"></table>',
                btn: ['<fmt:message code="global.lang.ok" />'],
                success:function () {
                    layui.use('table', function(){
                        var table = layui.table;

                        //第一个实例
                        table.render({
                            elem: '#demo'
                            ,url: '/timedTaskJob/findTimedTaskRecord?useFlag=true&pageSize=10&taskId='+taskId //数据接口
                            ,page: true
                            ,cols: [[
                                {field: 'executionBeginTime', width:'180', title: '<fmt:message code="execution.start.time" />'}
                                ,{field: 'executionEndTime', width:'180', title: '<fmt:message code="execution.end.time" />'}
                                ,{field: 'userName', width:'120', title: '<fmt:message code="execution.person" />'}
                                ,{field: 'result',  width:'90',title: '<fmt:message code="execution.status" />',templet:function(d){
                                    if(d.result=='0'){
                                        return '<fmt:message code="execution.in.progress" />'
                                    }else if(d.result=='1'){
                                        return '<fmt:message code="execution.success" />'
                                    }else{
                                        return '<fmt:message code="execution.failure" />'
                                    }
                                }}
                                ,{field: 'resultLog', width:'450', title: '<fmt:message code="execution.details" />',templet:function(d){
                                    if(d.resultLog==undefined){
                                        return ''
                                    }else{
                                        return '<span title="'+d.resultLog+'">'+d.resultLog+'</span>'
                                    }
                                }}
                            ]],parseData: function(res){ //res 即为原始返回的数据
                                return {
                                    "code":0, //解析接口状态
                                    "data": res.obj  , //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            }
                        });

                    });
                }

            })

        })

        //删除任务
        $(document).on('click', '.deletes', function () {
            var taskId = $(this).parents('tr').attr('taskId')

            layer.confirm('确定删除该任务吗？', function (index) {
                $.ajax({
                    type: 'get',
                    url: '/timedTaskJob/deleteTimedTask',
                    data:{
                        taskIds:taskId
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag == true) {
                            layer.msg('删除成功', {icon: 6, time: 1000});
                            ajaxPage.page();
                            layer.closeAll();

                        } else {
                            layer.msg('删除失败', {icon: 2, time: 1000});
                        }
                    }
                })
            });

        })
    })


</script>
</html>
