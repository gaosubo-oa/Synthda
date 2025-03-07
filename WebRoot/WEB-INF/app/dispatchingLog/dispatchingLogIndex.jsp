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
    <title>调度日志</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <%--    <script src="/js/base/base.js"></script>--%>
    <style>
        * {font-family: "Microsoft Yahei" !important;}
        b{
            color: red;
        }
        .head_title .title{
            margin-left: 22px;
        }
        .head_title span{
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }
        select{
            width: 250px;
            height: 30px;
        }
        .newTbale tr td {
            border-right: #ccc 1px solid;
            /*padding: 5px 30px;*/
        }
        input[type="text"]{
            width: 80%;
            height: 30px;
        }
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }
        input[type="file"]{
            width: 80%;
        }
        .attachmentId input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .addTd input{
            width: 90%;
        }
        .addTd td{
            padding: 4px;
        }
        .layui-card-body {
            position: relative;
            padding: 0 15px;
            line-height: 24px;
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
        .head-top ul {
            padding-left: 10px;
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
        .head-top ul .head-top-li.active {
            background: #2F8AE3;
            color: #fff;
        }
        .layui-table-cell {
            min-height: 30px;
            height: initial;
        }
        .layui-table-cell, .layui-table-tool-panel li {
            white-space: initial;
            /*为了让字母和数字也换行*/
            word-break: break-word;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="head-top" style="background-color: #eeeeee;">
    <ul class="clearfix">
        <li class="fl head-top-li addLog active privContro" data-type="" style="font-weight:bold;">新增</li>
        <li class="fl head-top-img privContro"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li selectLog" data-type="1" style="font-weight:bold;">日志列表</li>
    </ul>
</div>
<div class="newAdd" style="margin: 90px auto;" id="addFrame">
    <div id="pagediv layui-form" style="width: 90%; margin-left: 0.5%; margin-top: -2%">
        <div class="biwI"  style="">
            <div id="planTableDiv" class="layui-card-body" style="width: 445px">
                <button name="plus" type="button" class="layui-btn layui-btn-normal  layui-btn-sm plusBoat"><i class="layui-icon layui-icon-addition"></i> </button>
                <button name="cut" type="button" class="layui-btn layui-btn-normal  layui-btn-sm plusBoat"><i class="layui-icon layui-icon-subtraction"></i> </button>
                <form action="" id="planTi">
                    <table class="layui-table" id="plan" lay-filter="plan" >
                    </table>
                </form>
            </div>
        </div>
        <div style="width: calc( 90% - 350px);position: absolute;top: 100px;right: 0.2%;">
            <div id="planTableDiv3" class="layui-card-body" >
                <div style="float: right;font-size: 17px;">
                    <label>时间：<span class="nowDate"></span></label>
                    <span class="week"></span>
                </div>
                <form action="" id="planTi3" style="margin-top:-3.3%">
                    <table class="layui-table" id="plan3" lay-filter="plan3" lay-skin="line">
                    </table>
                </form>
                <div style="text-align: center;">
                    <button type="button" class="layui-btn layui-btn-normal baocun"  style="width: 80px; border-radius: 6px;margin-top: 20px">保存</button>
                    <button type="button" class="layui-btn layui-btn-normal fanhui"  style="width: 80px; border-radius: 6px;margin-top: 20px;display: none">返回</button>
                    <label style="float: right">值班：<span class="user"></span></label>
                </div>
            </div>
        </div>
        <div>
            <div id="planTableDiv2" class="layui-card-body" style="width: 445px">
                <form action="" id="planTi2">
                    <table class="layui-table" id="plan2" lay-filter="plan2" >
                    </table>
                </form>
            </div>
            <div>
                <label style="margin-left: 15px;">注：以上气象均由局调告之各施工船舶</label>
            </div>
        </div>

    </div>
</div>
</body>
<%--新建--%>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            //return unescape(r[2]);//会中文乱码
            return decodeURI((r[2]));//解决了中文乱码
        return null;
    }

    var saveType = getQueryString('type')
    var type = getQueryString('type')
    var logId = getQueryString('logId')
    var edit = getQueryString('edit')
    var privType = getQueryString('privType');
    var userName = decodeURI(getQueryString('userName'));
    var laydate,upload,table;
    var planArr = [];
    var tableInt;
    var timeOnes;

    //获取日期
    var date = new Date();
    // var times = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    var year = date.getFullYear();//月份从0~11，所以加一
    var dateArr = [date.getMonth() + 1,date.getDate()];
    for(var i=0;i<dateArr.length;i++){
        if (dateArr[i] >= 1 && dateArr[i] <= 9) {
            dateArr[i] = "0" + dateArr[i];
        }
    }
    var strDate = year+'-'+dateArr[0]+'-'+dateArr[1];
    //获取周几
    var day = date.getDay();
    var weeks = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
    var week = weeks[day];

    if (type !== undefined) {
        $('.nowDate').html(strDate)
        $('.week').html(week)
    }


    //选项卡切换
    $('.addLog').on('click',function () {
        window.location.href= "/dispatchingLog/dispatchingLogIndex"
    })
    $('.selectLog').on('click',function () {
        var url = "/dispatchingLog/dispatchingLogSelect";
        if (privType != null || privType != undefined) url = '/dispatchingLogManage/index';
        window.location.href = url;
    })

    // 日志创建人姓名
    if (userName != null || userName != undefined) {
        $('.user').html(userName)
    } else {
        //获取当前登陆人
        $.ajax({
            url: "/getLoginUser",
            type: 'post',
            dataType: 'json',
            success: function (res) {
                var denglu = res.object.userName;
                $('.user').html(denglu)
            }
        });
    }

    var cols = [[
        // {type: 'checkbox'},
        {field: 'boatCode', align:'center',title: '序号',width:'222',hide:'true'},
        {field: 'boatName', align:'center',title: '船名',width:'121',edit:'true'},
        {field: 'boatLogInfo',align:'center',title: '施工、停泊地',width:'320',edit:'true'}
    ]]
    //获取所有船舶信息
    var tablePlus = [];
    $.ajax({
        url: "/code/getCode?parentNo=BOAT_CODE",
        type: 'post',
        async: false,
        dataType: 'json',
        success: function (res) {
            var data = res.obj;
            var strs = '';
            for(var i=0; i<data.length;i++){
                var obj1 = {};
                obj1.boatName = data[i].codeName;
                obj1.boatCode = data[i].codeNo;
                obj1.boatLogInfo = '';
                tablePlus.push(obj1)
            }
            tablePlus.push({
                boatName:'',
                boatCode:'',
                boatLogInfo:'',
            })
        }
    })
    //加号按钮
    $('button[name="plus"]').on('click',function () {
        var plan = layui.table.cache["plan"];
        plan.push({
            boatCode: ""
            ,boatLogInfo: ''
            ,boatName:''
        });
        table.reload('plan', {
            data: plan
        });
    });
    //减号按钮
    $('button[name="cut"]').on('click',function () {
        var plan = layui.table.cache["plan"];
        plan.pop({
            boatCode: ""
            ,boatLogInfo: ''
            ,boatName:''
        });
        table.reload('plan', {
            data: plan
        });
    });
    var cols2 = [[
        {field:'scene', title: '上海市广播气象', edit:true,width:'173', align : 'center'}
        ,{field:'details', title: '' ,edit:true, width:'268',align : 'center'}
    ]]
    var tablePlus2 = [
        {
            scene:'上海市和长江口区',
            weather1:'',
        },
        {
            scene:'山东南部',
            weather2:'',
        },
        {
            scene:'江苏北部',
            weather3:'',
        },
        {
            scene:'江苏南部',
            weather3:'',
        },
        {
            scene:'上海市',
            weather4:'',
        },
        {
            scene:'浙江北部',
            weather4:'',
        },
        {
            scene:'浙江中部',
            weather5:'',
        },
        {
            scene:'浙江南部',
            weather5:'',
        }
    ]
    var cols3 = [[
        {field:'logInfo', title: '船舶动态 <p style="display: inline-block;margin-left: 50px;"> 调度记录</p>', edit:true,align : 'left'}
    ]]
    var tablePlus3 = [];
    for (var i =0 ; i<21; i ++){
        var obj = {};
        obj.logInfo = '';
        tablePlus3.push(obj)
    }
    //返回按钮
    $('.fanhui').on('click',function(){
        var url = '/dispatchingLog/dispatchingLogSelect';
        if (privType != null || privType != undefined) url = '/dispatchingLogManage/index';
        window.location.href = url;
    })

    var h = date.getHours();
    var min = date.getMinutes();
    var s = date.getSeconds();
    var endTime = (h<10?("0"+h):h)+':'+(min<10?("0"+min):min)+':'+(s<10?("0"+s):s);
    //保存按钮
    $('.baocun').on('click',function () {
        var weather1 = $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='0']").children('td').eq(1).text();
        var weather2 = $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='1']").children('td').eq(1).text();
        var weather3 = $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='2']").children('td').eq(1).text();
        var weather4 = $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='4']").children('td').eq(1).text();
        var weather5 = $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='6']").children('td').eq(1).text();
        var logInfo = '';
        for(var i=0;i<$("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr").length;i++){
            if($("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index="'+ i +'"]').children('td').children('div').text() != ''){
                logInfo += $("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index="'+ i +'"]').children('td').children('div').text()
                logInfo += ','
            }

        }

        if(saveType == '1'){
            var url = '/dispatchingLog/update';
            if (privType == '2') url = '/dispatchingLogManage/edit';
            var url = url;
            var plan2 = layui.table.cache["plan"];
            var arrAnd2 = JSON.stringify(plan2);
            // console.log(plan2)
            var addDate = {
                logId:logId,
                week:$('.week').html(),
                weather1:weather1,
                weather2:weather2,
                weather3:weather3,
                weather4:weather4,
                weather5:weather5,
                logInfo:logInfo,
                dispatchingBoatLogJson:arrAnd2
            }
        }else{
            var plan = layui.table.cache["plan"];
            var arrAnd = JSON.stringify(plan);
            var url = '/dispatchingLog/add';
            var addDate = {
                createDate:strDate,
                week:week,
                weather1:weather1,
                weather2:weather2,
                weather3:weather3,
                weather4:weather4,
                weather5:weather5,
                logInfo:logInfo,
                dispatchingBoatLogJson:arrAnd
            }
        }
        $.ajax({
            url:'/dispatchingLog/checkCanAdd',
            dataType:'json',
            type:'post',
            data:addDate,
            success: function (obj) {
                if(saveType !== '1'){
                    if(obj.data == false){
                        layer.msg('您今日已经新增过日志,可在日志列表中进行修改！', {icon: 1, time: 2000});
                    }else{
                        $.ajax({
                            url:url,
                            dataType:'json',
                            type:'post',
                            data:addDate,
                            success: function (data) {
                                if(data.flag == true){
                                    layer.msg('保存成功！', {icon: 1, time: 2000});
                                    var timeOne = data.time;
                                    timeOnes=timeOne.split(" ");
                                    timeOnes = timeOnes[1]
                                    // $.setCookie(timeOnes);
                                    // var myVar = setInterval(function(){
                                    //     if(timeOnes == '15:50:00'){
                                    //         console.log(endTime +'111')
                                    //         clearInterval(myVar);
                                    //         var banEdit = layui.table.cache["plan"];
                                    //         for(var i=0;i<banEdit.length;i++){
                                    //             $("#planTi>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "white").find('td').data('edit',true)
                                    //         }
                                    //         var banEdit2 = layui.table.cache["plan2"];
                                    //         for(var i=0;i<banEdit2.length;i++){
                                    //             $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "white").find('td').data('edit',true)
                                    //         }
                                    //         var banEdit3 = layui.table.cache["plan3"];
                                    //         for(var i=0;i<banEdit3.length;i++){
                                    //             $("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "white").find('td').data('edit',true)
                                    //         }
                                    //     }else{
                                    //         console.log(endTime+"222")
                                    var banEdit = layui.table.cache["plan"];
                                    for(var i=0;i<banEdit.length;i++){
                                        $("#planTi>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                                    }
                                    var banEdit2 = layui.table.cache["plan2"];
                                    for(var i=0;i<banEdit2.length;i++){
                                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                                    }
                                    var banEdit3 = layui.table.cache["plan3"];
                                    for(var i=0;i<banEdit3.length;i++){
                                        $("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                                    }
                                    //     }
                                    // },1000)
                                    $('button[name="plus"]').attr("disabled","true");
                                    $('button[name="cut"]').attr("disabled","true");
                                }else{
                                    layer.msg('保存失败！', {icon: 5, time: 2000});
                                }
                            }
                        })
                    }
                }else{
                    $.ajax({
                        url:url,
                        dataType:'json',
                        type:'post',
                        data:addDate,
                        success: function (data) {
                            if(data.flag == true){
                                layer.msg('保存成功！', {icon: 1, time: 2000});
                                var url = '/dispatchingLog/dispatchingLogSelect';
                                if (privType != null || privType != undefined) url = '/dispatchingLogManage/index';
                                window.location.href = url;
                            }else{
                                layer.msg('保存失败！', {icon: 5, time: 2000});
                            }
                        }
                    })
                }

            }
        })

    })

    $(function () {
        if (privType != null || privType != undefined) $('.privContro').remove() // 如果有权限就删除
        var rowIndex = undefined; // 回车换行位置
        layui.use(['table','laydate','upload'], function() {
            $ = layui.jquery,
                laydate = layui.laydate
                ,upload = layui.upload
                ,table = layui.table;

            //渲染表格
            tableInt = table.render({
                elem: '#plan',
                // url:'/code/getCode?parentNo=BOAT_CODE'
                data : tablePlus
                ,cellMinWidth: 80
                ,limit:'30'
                // ,page : false
                ,cols: cols
                ,done: function(res, curr, count){
                    if(edit == 'no'){
                        var tableView = this.elem.next(); // 当前表格渲染之后的视图
                        layui.each(res.data, function(i, item){
                            tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                        });
                    }
                    // 设置换行位置undefined
                    $('td[align="center"]').on('click', function(){
                        rowIndex = undefined;
                    })
                }
            });
            table.render({
                elem: '#plan2'
                ,data : tablePlus2
                ,cellMinWidth: 80
                ,page : false
                ,cols: cols2
                ,done: function(doneres, curr, count){
                    merge(doneres)
                    //禁止编辑
                    if(edit == 'no'){
                        var tableView = this.elem.next(); // 当前表格渲染之后的视图
                        layui.each(doneres.data, function(i, item){
                            tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                        });
                    }
                    // 设置换行位置undefined
                    $('td[align="center"]').on('click', function(){
                        rowIndex = undefined;
                    })
                }
            });

            table.render( {
                elem: '#plan3'
                ,data : tablePlus3
                ,cellMinWidth: 80
                // ,page : false
                ,limit:'30'
                ,cols: cols3
                ,done: function (res, curr, count) {
                    if(edit == 'no'){
                        var tableView = this.elem.next(); // 当前表格渲染之后的视图
                        layui.each(res.data, function(i, item){
                            tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                        });
                    }
                    $('td[align="left"]').on('click', function(){
                        rowIndex = parseInt($(this).parents("tr").attr('data-index')) +1;
                    })
                }
            });

            //表格监听工具事件
            table.on('tool(plan)', function(obj){
                var data = obj.data;
                var layEvent = obj.event;
                var tr = obj.tr;

                if(layEvent === 'certStartTime'){ //起始时间
                    var field = $(this).data('field');
                    var index = tr.attr("data-index");
                    laydate.render({
                        elem: this.firstChild
                        ,type: 'datetime'
                        , done: function (value, date) {
                            table.cache["plan"][index][field] = value
                        }
                    });
                }else if(layEvent === 'certEndTime'){ //截止时间
                    var field = $(this).data('field');
                    var index = tr.attr("data-index");
                    laydate.render({
                        elem: this.firstChild
                        ,type: 'datetime'
                        , done: function (value, date) {
                            table.cache["plan"][index][field] = value
                        }
                    });
                } else if (layEvent === 'del2') { //删除
                    var index = tr.attr("data-index");
                    obj.del(tr);
                }
            });
            table.on('edit(plan)', function(obj){
                planArr.push(obj.data)
            });
            //合并单元格
            function merge(res) {
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='0']").children('td').eq(1).css('height','100px');
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='2']").children('td').eq(1).attr('rowspan',2);
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='3']").children('td').eq(1).css('display','none');
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='4']").children('td').eq(1).attr('rowspan',2);
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='5']").children('td').eq(1).css('display','none');
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='6']").children('td').eq(1).attr('rowspan',2);
                $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='7']").children('td').eq(1).css('display','none');
            }
            if(saveType == '1'){
                $('.fanhui').css('display','inline-block');
                $('.addLog').removeClass('active');
                $('.selectLog').addClass('active');
                if(edit == 'no'){
                    $('.plusBoat').css('display','none');
                    $('.baocun').css('display','none');
                    $('.newAdd').css('margin-top','124px');
                }
                var url = '/dispatchingLog/queryById';
                if (privType == '1') url = '/dispatchingLogManage/check';

                // 数据回显
                $.ajax({
                    url: url,
                    type: 'post',
                    dataType: 'json',
                    data:{
                        logId:logId
                    },
                    success: function (res) {
                        var objs = res.data;

                        // 日期回显
                        $('.nowDate').html(objs.createDate)
                        $('.week').html(objs.week)


                        // 表格数据
                        var logInfos = objs.logInfo;
                        var arr=new Array();
                        arr = logInfos.split(",");
                        for (var i = 0; i < arr.length; i++) {
                            $("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index="'+ i +'"]').children('td').children('div').text(arr[i])
                        }
                        var dispatchingLogs = objs.dispatchingBoatLogs;
                        var plsnArr2 = [];
                        if(dispatchingLogs.length != 0){
                            for(var i=0;i<dispatchingLogs.length; i++){
                                plsnArr2.push(dispatchingLogs[i])
                                // $("#planTi>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index="'+ i +'"]').children('td').eq(2).children('div').text(dispatchingLogs[i].boatLogInfo);
                            }
                            //重载表格
                            table.reload('plan', {
                                data:plsnArr2
                            });
                        }
                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='0']").children('td').eq(1).children('div').text(objs.weather1);
                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='1']").children('td').eq(1).children('div').text(objs.weather2);
                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='2']").children('td').eq(1).children('div').text(objs.weather3);
                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='4']").children('td').eq(1).children('div').text(objs.weather4);
                        $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find("tr[data-index='6']").children('td').eq(1).children('div').text(objs.weather5);
                    }
                })
            }

        })

        if (type == undefined) {
            // 提交报告后禁用页面编辑
            $.ajax({
                url: '/dispatchingLog/checkCanAdd',
                dataType: 'json',
                type: 'post',
                success: function (obj) {
                    if (obj.data == false) {
                        var banEdit = layui.table.cache["plan"];
                        for (var i = 0; i < banEdit.length; i++) {
                            $("#planTi>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit', false)
                        }
                        var banEdit2 = layui.table.cache["plan2"];
                        for (var i = 0; i < banEdit2.length; i++) {
                            $("#planTi2>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit', false)
                        }
                        var banEdit3 = layui.table.cache["plan3"];
                        for (var i = 0; i < banEdit3.length; i++) {
                            $("#planTi3>.layui-form>.layui-table-box>.layui-table-body>.layui-table").find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit', false)
                        }
                        $('button[name="plus"]').attr("disabled","true");
                        $('button[name="cut"]').attr("disabled","true");
                    }
                }
            })
        }

        // 阻止在表格内回车刷新页面
        $(document).on('keydown',function (event) {
            if (event.keyCode == 13) {
                $("*").blur();//去掉焦点
            }
        });
        // 调度记录回车换行
        $('body').on('keyup', function(){
            if (event.keyCode == 13 && rowIndex != undefined) {
                $('div[lay-id="plan3"]').find('tr[data-index="'+ rowIndex +'"]').children('td').children('div').trigger('click');
            }
        });
    });

</script>

</html>
