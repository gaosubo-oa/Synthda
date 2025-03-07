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
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>事务提醒设置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">

    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/laydate.css"/>

    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" charset="utf-8" src="/lib/pagination/js/jquery.pagination.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/base/base.js"></script>
    <%--<script src="/js/pzGrid/gridShjzry.js"></script>--%>

    <%--<script src="/js/pzGrid/runPsychosis.js"></script>--%>
    <style>
        .formUl li input[type=radio]{
            width: 16px;
        }
        .formUl li .radiolabel{
            width: 50px;
        }
        .divAdd{
            background-color:rgba(0,0,0,0);
        }
        .clearfix input{
            float:none;
        }
        .importTable{
            width: 90%;
            margin: 20px auto;
        }
        .formUl li input{
            width: 100px;
            float: none;
        }
        .formUl li span {
            margin: 20px;
            line-height: 33px;
        }
        td{
            font-size: 11pt;
        }
        .headTop{
            border-bottom: none;
        }
        input{
            width: 15px;
        }

        .saveBtn {
            width: 70px;
            height: 28px;
            margin: 30px auto;
            line-height: 28px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            background: url(/img/confirm.png) no-repeat;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

</head>
<body>
<div class="headTop">
    <div class="headTop">
        <div class="headImg">
            <%--<img src="/img/document/icon_agentDispatch.png" alt="">--%>
        </div>
        <div class="divTitle">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dingshirenwu.png" alt="">
            <fmt:message code="transaction.reminder.setting" />
        </div>
    </div>
</div>
<div style="margin: 0 auto;margin-top: 46px;height: 30px;width: 97%;" class="clearfix">

</div>

<div class="pagediv" style="margin: 0 auto;width: 70%;">


    <table >
        <thead>
        <tr>
            <th><fmt:message code="transaction.reminder.module.id" /></th>
            <th><fmt:message code="transaction.reminder.module.name" /></th>
            <th><fmt:message code="transaction.reminder.allow" /></th>
            <th><fmt:message code="transaction.reminder.default" /></th>
            <th><fmt:message code="transaction.reminder.sms.default" /></th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
    <%--<div id="dbgz_page" class="M-box3 fr">--%>

    <%--</div>--%>
    <div class="saveBtn">
        <span style="margin-left: 20px"><fmt:message code="transaction.reminder.save" /></span>
    </div>
</div>

</body>
<script type="text/javascript">

    var ajaxPage={
        data:{
            // page:1,//当前处于第几页
            // pageSize:15,//一页显示几条
            // useFlag:true,
        },

        page:function () {
            var me=this;
            $.post('/code/getCodeRemind',me.data,function (json) {
                var status = '';
                var str='';
                var abiao = '';
                var arr=json.obj;
                var result='';
                var executionTime ='';
                var lang = getCookie('language');
                var codename='';
                for(var i=0;i<arr.length;i++){
                    if(lang=='en_US'){
                        codename=arr[i].codeName1
                    }
                    str+='<tr class="par" codeId="'+arr[i].codeId+'">' +
                        '<td>'+arr[i].codeNo+'</td>' +
                        '<td>'+codename+'</td>' +
                        '<td><input type="checkbox" value="'+arr[i].isCan+'" '+che(arr[i].isCan)+'></td>' +
                        '<td><input type="checkbox" value="'+arr[i].isRemind+'" '+che(arr[i].isRemind)+'></td>' +
                        '<td><input type="checkbox" value="'+arr[i].isIphone+'" '+che(arr[i].isIphone)+'></td>' +
                        '</tr>'
                }

                function che(val){
                    if(val == 1){
                        return 'checked'
                    }else {
                        return ''
                    }
                }
                $('.pagediv table tbody').html(str)
                // me.pageTwo(json.totalNum,me.data.pageSize,me.data.page)
            },'json')
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

    var chuzuwuId=null;
    $(function () {
        ajaxPage.page()

        //查询
        $('.saveBtn').click(function () {
            var arrs = $('.par');
            var ipts = $('input');
            var list= [];
            ipts.each(function (t,p) {
                if($(p).is(':checked')){
                    $(p).val('1');
                }else {
                    $(p).val('0');
                }
            })

            arrs.each(function (v,i) {
                list.push($(i).attr('codeId')+',')
                list.push($(i).find('input').eq(0).val()+',')
                list.push($(i).find('input').eq(1).val()+',')
                list.push($(i).find('input').eq(2).val()+',')
                list.push('|')
            })
            var strs = list.join('')

            $.ajax({
                url:'/code/syscode/addRemind',
                data:{
                    codeIds:strs
                },
                type:'get',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        layer.msg('设置成功', {icon: 1,time: 1000, offset: '300px'}, function () {
                            ajaxPage.page();
                        });
                    }else{
                        $.layerMsg({content:'设置失败！',icon:1})
                    }
                }
            })

        })


        $('#selGrid').click(function(){
            wangge_id='gridId';
            $.popWindow('/pzGridPage/selectDeptWG');
        })
        $('#emptyGrid').click(function(){
            $('#gridId').val('');
            $('#gridId').attr('wanggeid','');
        })

        //刷新
        $('#refresh').click(function(){
            location.reload();
        })

        //我的编辑
        $(document).on('click','.edit',function () {
            var me=this;
            var taskMet=$(this).parents('tr').attr('taskMet');
            if(taskMet==2){
                layer.open({
                    title:'<fmt:message code="user.th.jkn" />',
                    area:['400px','300px'],
                    type:1,
                    content:'<ul class="formUl">' +
                    '<input type="hidden" id="rentId">'+
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="user.th.fbds" />：</label>' +
                    '<span id="taskname"><span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label class="fl clearfix"">' +
                    '<input type="text" id="executionTime" name="printDate" placeholder="请输入日期" style="width: 135px;" onclick="laydate({istime: true, format: \'YYYY-MM-DD hh:mm:ss\'})">' +
                    '</label>' +
                    '</li>' +
                    '<li class="clearfix" >' +
                    '<label><fmt:message code="three.th.Enable" />：</label>' +
                    '<span style="margin:0;margin-left:13px;"><fmt:message code="user.th.kjnf" /></span><input id="qiy" style="margin-left:2px" type="radio" name="available" value="1">' +
                    '<span style="margin:0;margin-left:13px;"><fmt:message code="three.th.Disable" /></span><input id="tingy" style="margin-left:2px" type="radio" name="available" value="0">' +
                    '</li>'+
                    '</ul>',
                    btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="notice.th.return" />'],
                    btn1:function () {
                        if($("#intwevalTime").val()==''){
                            $.layerMsg({content:'<fmt:message code="event.th.Please" />',icon:2});
                            return false;
                        }
                        if($('#intwevalTime').val() == 0){
                            $.layerMsg({content:'间隔时间必须大于0',icon:6,time:2000});
                            return ;
                        }
                        else {
                            var intwevalTime=$('#intwevalTime').value;
                            var execute='';
                            var available=$("input[name='available']");
                            for (var i = 0; i < available.length; i++) {
                                if (available[i].checked) {
                                    execute=$('input')[i].value
                                }
                            }
                            var ttmId=$(me).parents('tr').attr('ttmId')
                            $.ajax({
                                url:'TimedTaskManagementController/updateTimedTaskManagement2',
                                data:{
                                    ttmId:ttmId,
                                    intwevalTime:intwevalTime,
                                    execute:execute
                                },
                                type:'post',
                                dataType:'json',
                                success:function (res) {
                                    if(res.flag){
                                        $.layerMsg({content:'<fmt:message code="netdisk.th.Editsuccess" />！',icon:1})

                                        ajaxPage.page();

                                        layer.closeAll()
                                    }else{
                                        $.layerMsg({content:'<fmt:message code="event.th.EditFailed" />！',icon:1})
                                    }
                                }
                            })
                        }
                        y
                    },
                    success:function () {


                        //    编辑返现
                        $.ajax({
                            url:'/TimedTaskManagementController/selectTimedTaskKey',
                            data:{ttmId:ttmId},
                            type:'get',
                            dataType:'json',
                            success:function(res){
                                var data=res.object;
                                $("#taskname").html(data.taskname);

                                $('#executionTime').val(data.exeDate);

                                if(data.execute==1){
                                    $("#qiy").attr('checked','checked')
                                }else{
                                    $("#tingy").attr('checked','checked')
                                }
                            }
                        })
                    }
                })
            }else {
                layer.open({
                    title: '<fmt:message code="user.th.jkn" />',
                    area: ['400px', '350px'],
                    type: 1,
                    content: '<ul class="formUl">' +
                    '<input type="hidden" id="rentId">' +
                    '<li class="clearfix" style="margin-top: 30px;">' +
                    '<label><fmt:message code="user.th.fbds" />：</label>' +
                    '<span id="taskname"><span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="user.thlkjl" />：</label>' +
                    '<input type="text" id="intwevalTime"><span style="margin:10px;"><fmt:message code="attend.th.today" /></span>' +
                    '</li>' +
                    '<li class="clearfix">' +
                    '<label><fmt:message code="user.th.dfswa" />：</label> ' +
                    '<input type="text" id="executionTime" name="printDate" placeholder="请输入日期" style="width: 135px;" onclick="laydate({istime: true, format: \'YYYY-MM-DD hh:mm:ss\'})">' +
                    '</li>' +
                    '<li class="clearfix" >' +
                    '<label><fmt:message code="three.th.Enable" />：</label>' +
                    '<span style="margin:0;margin-left:13px;"><fmt:message code="user.th.kjnf" /></span><input id="qiy" style="margin-left:2px" type="radio" name="available" value="1">' +
                    '<span style="margin:0;margin-left:13px;"><fmt:message code="three.th.Disable" /></span><input id="tingy" style="margin-left:2px" type="radio" name="available" value="0">' +
                    '</li>' +
                    '</ul>',
                    btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="notice.th.return" />'],
                    btn1: function (index) {
                        if($("#intwevalTime").val()==''){
                            $.layerMsg({content:'<fmt:message code="event.th.Please" />',icon:2});
                            return false;
                        }
                        if($("#executionTime").val()==''){
                            $.layerMsg({content:'<fmt:message code="event.th.Pleasetime" />',icon:2});
                            return false;
                        }
                        if($('#intwevalTime').val() == 0){
                            $.layerMsg({content:'间隔时间必须大于0',icon:6,time:2000});
                            return ;
                        }
                        else {
                            var intwevalTime=$('#intwevalTime').val();
                            var stringTime=$('#executionTime').val();

                            var timestamp2 = new Date(stringTime).getTime();
                            var executionTime = timestamp2;



                            var available=$("input[name='available']");
                            var execute=';'
                            for (var i = 0; i < available.length; i++) {
                                if (available[i].checked) {
                                    execute=available[i].value
                                }
                            }
                            var ttmId=$(me).parents('tr').attr('ttmId')
                            $.ajax({
                                url:'updateDingDianTask',
                                data:{
                                    ttmId:ttmId,
                                    intwevalTime:intwevalTime,
                                    executionTime:executionTime,
                                    execute:execute
                                },
                                type:'post',
                                dataType:'json',
                                success:function (res) {
                                    if(res.flag){
                                        $.layerMsg({content:'<fmt:message code="netdisk.th.Editsuccess" />！',icon:1})

                                        ajaxPage.page();
                                        layer.closeAll()
                                    }else{
                                        $.layerMsg({content:'<fmt:message code="event.th.EditFailed" />！',icon:1})
                                    }
                                }
                            })
                        }

                        layer.closeAll()
                    },
                    success:function () {
//                        laydate.render({
//                            elem: '#executionTime'
//                            ,type: 'time'
//                            ,ready: function(date){
//                                $('#layui-laydate2').css('left','400px')
//                            }
//                        });

                        //    编辑返现
                        var ttmId=$(me).parents('tr').attr('ttmId')
                        $.ajax({
                            url:'/TimedTaskManagementController/selectTimedTaskKey',
                            data:{ttmId:ttmId},
                            type:'post',
                            dataType:'json',
                            success:function(res){
                                var data=res.object;
                                $("#taskname").text(data.taskName);
//                                $("#intwevalTime").val(data.intwevalTime);

                                $("#intwevalTime").val(data.intwevalTime);

                                $('#executionTime').val(data.exeDate);

                                if(data.taskType==1){
                                    $("#qiy").attr('checked','checked')
                                }else{
                                    $("#tingy").attr('checked','checked')
                                }
                            }
                        })
                    }
                    //cccc
                })
            }
        })
        //立即执行
        $(document).on('click','.liji',function(){
            var ttmId=$(this).parents('tr').attr('ttmId')
            var taskType=$(this).parents('tr').attr('taskType')
            layer.open({
                title:'<fmt:message code="user.th.lkjnlk" />',
                area:['300px','220px'],
                type:1,
                content:'<ul class="formUl">' +
                '<li class="clearfix" style="margin-top: 30px;">' +
                '<span style="margin-left: 40px;font-size:15px;"><fmt:message code="user.th.kljlk" />？<span>' +
                '</li>' +
                '</ul>',
                btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                btn1:function () {
                    $.ajax({
                        url:'/TimedTaskManagementController/stactTo',
                        data:{
                            ttmId:ttmId,
                            taskType:taskType
                        },
                        type:'post',
                        dataType:'json',
                        success:function (res) {
                            if(res.flag){
                                $.layerMsg({content:'<fmt:message code="diary.th.implementationSuccess" />！',icon:1},function () {

                                    ajaxPage.page();
                                    layer.closeAll();
                                })
                            }else{
                                $.layerMsg({content:'<fmt:message code="diary.th.failureToExecute" />！',icon:1})
                            }
                        }


                    })
                }

            })
        })


    })



</script>
</html>
