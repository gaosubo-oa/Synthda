<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/3/10
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>工作日志</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918.09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
<%--    <script type="text/javascript" src="/lib/mui/mui/mui.min.js" ></script>--%>
<%--    <script src="/lib/mui/mui/showLoading.js"></script>--%>
<%--    <link href="../../lib/mui/mui/mui.css?20190819.1" rel="stylesheet">--%>
</head>
<style>

    .layui-colla-title{
        font-size: 16px;
    }
    .d1{
        position: relative;
    }
    #addbtn1.xsbtn-add,#addbtn2.xsbtn-add{
        height: 26px;
        position: absolute;
        right: 82px;
        margin-top: 7.5px;
        font-size: 16px;
    }
    #delbtn1.xsbtn-del,#delbtn2.xsbtn-del{
        height: 26px;
        position: absolute;
        /*right: 14px;*/
        right: 12px;
        margin-top: 7.5px;
        font-size: 16px;
        background-color: 	#FF0000;
    }
    .xsbtn-cho{
        height: 26px;
        position: absolute;
        right: 14px;
        margin-top: 7.5px;
        font-size: 16px;
        background-color: #787878;
        display: none;
    }
    ol{
        margin-left: 19px;
    }
    li{
        list-style: decimal;
        border-bottom: 1px solid #C0C0C0;
        font-size: 18px;
        margin: 15px auto;
        position: relative;
        left: 14px;
    }
    .i1{
        position: absolute;
        left: 3px;
        /*display: none;*/
    }
    .layui-form-select{
        width: 112px;
        position: absolute;
        top: -6px;
        right: 0px;
    }
    .layui-unselect{
        width: 117px;
        height: 27px;
    }
    .layui-form-checkbox[lay-skin=primary] {
        height: auto!important;
        line-height: normal!important;
        min-width: 18px;
        min-height: 18px;
        border: none!important;
        margin-top: 6px;
    }
    .dvId,  .dvIdTom{
        border: 1px solid #000000;
        position: absolute;
        left: -45px;
        top: 0px;
        width: 20px;
        height: 20px;
        display: none;
    }
</style>
</head>
<body>

<div style="margin-top: 20px;position: relative;">
    <img src="../../img/log2.png" style="position: absolute;left: 21px;top: 2px;width: 25px; "><span
        style="margin-left: 49px;font-size: 20px;">工作日志</span>
    <span type="text"  id="fillingDate" style="position: absolute;right: 50px;top: 10px"></span>
    <span id="water" style="position: absolute;right: 21px;top: 8px"></span>
</div>
<hr class="layui-bg-blue" style="height: 5px">
<div class="layui-collapse" lay-filter="test">
    <form class='layui-form'>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">昨日计划今日完成<i class="layui-icon layui-colla-icon"></i></h2>
            <div class="layui-colla-content" >
                <ol id="l1">

                </ol>
            </div>
        </div>
        <div class="layui-colla-item d1">
            <h2 class="layui-colla-title">今日其他工作
                <i class="layui-icon layui-colla-icon"></i>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-add" id="addbtn1">新增</button>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-del" id="delbtn1" Todytype="0" num="0">删除</button>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-cho" id="choicebtn1"  num="0">全选</button>
            </h2>
            <div class="layui-colla-content" id="demo">
                <div>
                    <ol id="l2">

                    </ol>
                </div>
            </div>
        </div>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">明日工作安排
                <i class="layui-icon layui-colla-icon"></i>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-add" id="addbtn2">新增</button>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-del" id="delbtn2" num="0">删除</button>
                <button type="button" class="layui-btn layui-btn-sm xsbtn-cho" id="choicebtn2" Tomtype="1" num="0">全选</button>
            </h2>
            <div class="layui-colla-content">
                <ol id="l3">

                </ol>
            </div>
        </div>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">资源情况<i class="layui-icon layui-colla-icon"></i></h2>
            <div class="layui-colla-content">
                <table class="layui-hide" id="test" lay-filter="test"></table>
                <script type="text/html" id="toolbarDemo">
                    <h2 style="font-size: 16px">资源情况</h2>
                    <div class="layui-btn-container"  style="position: absolute; right: 10px;top:12px;">
                        <button type="button" class="layui-btn layui-btn-sm" lay-event="getAdd" id="getAddbtn">新增</button>
                        <button type="button" class="layui-btn layui-btn-sm" lay-event="getDel" id="getDelbtn">删除</button>
                        <button type="button" class="layui-btn layui-btn-sm" lay-event="getChange" id="getChangebtn">修改</button>
                    </div>
                </script>
            </div>
        </div>

        <div style="position: relative">
            <textarea style="width: 100%;margin-top: 8px;height: 100px;" id="text"  placeholder="今日总结"></textarea>
            <button type="button" class="layui-btn layui-btn-sm "id="txtBtn" style="position: absolute;top: 74px;right: 12px;">提交</button>
        </div>


    </form>
</div>
<script>
    layui.use(['element','layer','transfer','form','table','laydate'],function () {
        var layer=layui.layer;
        var form = layui.form;
        var table=layui.table;
        var laydate=layui.laydate
        laydate.render({
            elem: '#fillingDate',// input里时间的Id
            value: new Date(),
            trigger:'',
            done: function (value, date) {
            }
        });
        $.get('/sys/getInterfaceInfo', function (json){
            if (json.flag) {
                if(json.object.weatherCity!=1){
                    window.onload = loadScript;
                }
            }
        }, 'json')
        function loadScript() {
            var script = document.createElement("script");
            script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
            document.body.appendChild(script);
        }


        //渲染数据
        initWorkLogContent(workPlanId)

        var tableint;
        //资源数据表
        tableint=table.render({
            elem: '#test'
            // ,url:'/workflow/workLog/getResources'
            ,data:resourcesData
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '资源情况数据表'
            ,cols: [[
                {field:'detailsId', title:'ID', fixed:'left',resize:true}
                ,{field:'resourceName', title:'名称',  edit: 'text'}
                ,{field:'resourceTypeName',  title:'类型'}
                ,{field:'resourcesNumber',  title:'数量'}
                ,{field:'explain',  title:'说明'}
            ]]
            // ,page: true fixed: 'left',resize: true, sort: true
        });
        //行监听事件
        var  tabdata;
        table.on('row(test)', function(obj){
            tabdata = obj.data;

            //标注选中样式
            obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){


            switch(obj.event){
                case 'getAdd':
                    window.location.href="/workflow/workLog/toWorkLogResources?resourcestype=1&workPlanId="+workPlanId+"";
                    break;
                case 'getDel':
                    var ids=tabdata.detailsId;
                    deleteLog(ids,workPlanId)
                    break;
                case 'getChange':
                    window.location.href="/workflow/workLog/toWorkLogResources?detailsId="+tabdata.detailsId+"&resourcestype=2&workPlanId="+workPlanId+"";
                    break;
            };
        });



        //解决button冒泡事件
        $(document.body).find('.layui-colla-title').on('click','.layui-btn',function (e) {
            $(this).parent('.layui-colla-title').siblings('.layui-colla-content').hasClass('layui-show');
            layui.stope(e);
        })
        //新增按钮页面跳转
        $("#addbtn1").click(function () {
            window.location.href="/workflow/workLog/content1?type=3&workType=1&workPlanId="+workPlanId+"&datatype="+datatype+"";
        })
        $("#addbtn2").click(function () {
            window.location.href="/workflow/workLog/content1?type=4&workType=2&workPlanId="+workPlanId+"&datatype="+datatype+"";
        })


        form.on('select(workstate)', function(data){
            var x=$(data.elem[data.elem.selectedIndex]).attr("logId");
            updatecompletionStatus(x,data.value);
        });
        //判断datatype
        judge(datatype);

    })



    //使用正则表达式获取url中的参数
    function getUrlParam(name) {
        //构造一个含有目标参数的正则表达式对象
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        //匹配目标参数
        var r = window.location.search.substr(1).match(reg);
        //返回参数值
        if (r != null) return unescape(r[2]); return null;
    }
    var workPlanId=getUrlParam("workPlanId");
    var datatype=getUrlParam("datatype");
    var resourcesData='';
    function initWorkLogContent(workPlanId) {
        $.ajax({
            url:'/workflow/workLog/getWorkPlanById',
            data:{workPlanId:workPlanId},
            dataType:"json",
            type:"post",
            async:false,
            success:function(res){
                var yesterdayhtm='';
                var todayhtm='';
                var tomorrowhtm='';

                //昨日计划数据渲染
                if (res.object.yestDay==undefined){
                    yesterdayhtm="<p>暂无数据</p>"
                    $("#l1").html(yesterdayhtm);
                }else if (res.object.yestDay.length==0){
                    yesterdayhtm="<p>暂无数据</p>"
                    $("#l1").html(yesterdayhtm);
                }else {
                    for (var i = 0; i < res.object.yestDay.length; i++) {
                        yesterdayhtm += "<li>" +
                            "<a href='/workflow/workLog/content1?logID="+res.object.yestDay[i].logId+"&type=0&workPlanId="+workPlanId+"&datatype="+datatype+"'>" + res.object.yestDay[i].jobContent + "</a>" +
                            "<select name='selecttype1' id='select1" + i + "' lay-filter='workstate'>" +
                            "<option value=''>请选择</option>" +
                            "<option value='0' logId="+res.object.yestDay[i].logId+">完成</option>" +
                            "<option value='1' logId="+res.object.yestDay[i].logId+">部分完成</option>" +
                            "<option value='10'logId="+res.object.yestDay[i].logId+">未启动</option>" +
                            "</select>" +
                            "</li>"
                    }
                    $("#l1").html(yesterdayhtm);
                    for (var i =0;i<res.object.yestDay.length;i++) {
                        $('#select1'+i).find('option[value="'+res.object.yestDay[i].completionStatus+'"]').prop('selected','selected');
                    }
                }

                //今日计划数据渲染
                if (res.object.toDay==undefined){
                    todayhtm="<p>暂无数据</p>"
                    $("#l2").html(todayhtm);
                }else if(res.object.toDay.length==0){
                    todayhtm="<p>暂无数据</p>"
                    $("#l2").html(todayhtm);
                }else {
                    for(var i=0;i<res.object.toDay.length;i++){
                        todayhtm += "<li>" +
                            "<div  divId='divId" + res.object.toDay[i].logId + "' id='" + res.object.toDay[i].logId + "' dvnum='0' class='dvId'><i class='layui-icon layui-icon-ok di divId" + res.object.toDay[i].logId + "'name='i1'  style='position: absolute;left: 3px;display: none'></i></div>" +
                            "<a href='/workflow/workLog/content1?logID=" + res.object.toDay[i].logId + "&type=1&workType=1&workPlanId="+workPlanId+"&datatype="+datatype+"'>" + res.object.toDay[i].jobContent + "</a>" +
                            "<select  name='selecttype2' id='select2" + i + "'  lay-filter='workstate'>" +
                            "<option value=''>请选择</option>" +
                            "<option value='0' logId=" + res.object.toDay[i].logId + ">完成</option>" +
                            "<option value='1' logId=" + res.object.toDay[i].logId + ">部分完成</option>" +
                            "<option value='10' logId=" + res.object.toDay[i].logId + ">未启动</option>" +
                            "</select>" +
                            "</li>";
                    }
                    $("#l2").html(todayhtm);
                    for (var i =0;i<res.object.toDay.length;i++) {
                        $('#select2'+i).find('option[value="'+res.object.toDay[i].completionStatus+'"]').prop('selected','selected');
                    }
                }

                //明日计划数据渲染
                if(res.object.tomorrow==undefined){
                    tomorrowhtm="<p>暂无数据</p>"
                    $("#l3").html(tomorrowhtm);
                }else if(res.object.tomorrow.length==0){
                    tomorrowhtm="<p>暂无数据</p>"
                    $("#l3").html(tomorrowhtm);
                }else{
                    for(var i=0;i<res.object.tomorrow.length;i++){
                        tomorrowhtm+= "<li>" +
                            "<div  divIdTom='divIdTom"+res.object.tomorrow[i].logId+"' id='"+res.object.tomorrow[i].logId+"' dvnumTom='0' class='dvIdTom'><i class='layui-icon layui-icon-ok diTom divIdTom"+res.object.tomorrow[i].logId+"'name='i1'  style='position: absolute;left: 3px;display: none'></i></div>" +
                            "<a href='/workflow/workLog/content1?logID="+res.object.tomorrow[i].logId+"&type=2&workType=2&workPlanId="+workPlanId+"&datatype="+datatype+"'>"+ res.object.tomorrow[i].jobContent +"</a>"+
                            "</li>";
                    }
                    $("#l3").html(tomorrowhtm);
                }

                //今日总结数据渲染
                $("#text").val(res.obj.planSummary);

                //资源列表数据渲染
                if(res.object.resources==undefined){
                    resourcesData=[]
                }else {
                    resourcesData=res.object.resources;
                }
               layui.table.render({
                    elem: '#test'
                    // ,url:'/workflow/workLog/getResources'
                    ,data:resourcesData
                    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,defaultToolbar: []
                    ,title: '资源情况数据表'
                    ,cols: [[
                        {field:'detailsId', title:'ID', fixed:'left',resize:true}
                        ,{field:'resourceName', title:'名称',  edit: 'text'}
                        ,{field:'resourceTypeName',  title:'类型'}
                        ,{field:'resourcesNumber',  title:'数量'}
                        ,{field:'explain',  title:'说明'}
                    ]]
                    // ,page: true fixed: 'left',resize: true, sort: true
                });
                layui.form.render();
            }
        })
    }
    $("#delbtn1").click(function(){
        var delIdStr="";
        $(".dvId").each(function(){
            var dvnum = $(this).attr("dvnum");
            if(dvnum===1||dvnum==="1"){
                delIdStr+= $(this).attr("id")+","
            }
        })
        if(delIdStr!=""){
            var btntype=$("#delbtn1").attr("Todytype");
            deleteLogContent(delIdStr,btntype,workPlanId);
        }
        var  btnnum =$("#delbtn1").attr("num");
        if(btnnum=="0"){
            $("#addbtn1.xsbtn-add").css("right","132px");
            $("#delbtn1.xsbtn-del").css("right","72px");
            $(".dvId").show();
            $("#choicebtn1").show();
            $("#delbtn1").attr("num","1");
        }else {
            $(".dvId").hide();
            $("#choicebtn1").hide();
            $("#delbtn1").attr("num","0");
            $("#addbtn1.xsbtn-add").css("right","82px");
            $("#delbtn1.xsbtn-del").css("right","12px");
        }

    })
    $("#choicebtn1").click(function(){
        var choicenum= $(this).attr("num");
        if(choicenum=="0"){
            $(".dvId").css("background","#7CFC00");
            $(".di").show();
            $(".dvId").attr("dvnum","1");
            $(this).attr("num","1")
        }else {
            $(".dvId").css("background","#FFFFFF");
            $(".di").hide();
            $(".dvId").attr("dvnum","0");
            $(this).attr("num","0")
        }

    })

    $("#delbtn2").click(function(){

        var delIdStr="";

        $(".dvIdTom").each(function(){
            var dvnumTom = $(this).attr("dvnumTom");
            if(dvnumTom===1||dvnumTom==="1"){
                delIdStr+= $(this).attr("id")+","
            }
        })
        if(delIdStr!=""){
            var btntype=$("#delbtn2").attr("Tomtype");
            deleteLogContent(delIdStr,btntype,workPlanId);
        }
        var  btnnum =$("#delbtn2").attr("num");
        if(btnnum=="0"){
            $("#addbtn2.xsbtn-add").css("right","132px");
            $("#delbtn2.xsbtn-del").css("right","72px");
            $(".dvIdTom").show();
            $("#choicebtn2").show();
            $("#delbtn2").attr("num","1");
        }else {
            $(".dvIdTom").hide();
            $("#choicebtn2").hide();
            $("#delbtn2").attr("num","0");
            $("#addbtn2.xsbtn-add").css("right","82px");
            $("#delbtn2.xsbtn-del").css("right","12px");
        }

    })
    $("#choicebtn2").click(function(){
        var choicenum= $(this).attr("num");
        if(choicenum=="0"){
            $(".dvIdTom").css("background","#7CFC00");
            $(".diTom").show();
            $(".dvIdTom").attr("dvnumTom","1");
            $(this).attr("num","1")
        }else {
            $(".dvIdTom").css("background","#FFFFFF");
            $(".diTom").hide();
            $(".dvIdTom").attr("dvnumTom","0");
            $(this).attr("num","0")
        }

    })

    function deleteLog(id,workPlanId){
        //删除资源列表
        layui.layer.confirm(' 确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除",
            offset: '120px'
        },function(){
            if(id==""){
                layer.msg("请点击一行进行删除")
            }else{
                $.ajax({
                    url:"/workflow/workLog/delResources",
                    data:{ids:id,workPlanId:workPlanId},
                    dataType:"json",
                    type:"post",
                    success:function(res){
                        layui.layer.msg(res.msg)
                        initWorkLogContent(workPlanId)
                    }
                })
            }
        }, function () {
            layui.layer.closeAll();
        })
    }
    function deleteLogContent(id,btntype,workPlanId){
        //删除列表
        layui.layer.confirm(' 确定要删除吗', {
            btn: ['确定', '取消'], //按钮
            title: " 删除",
            offset: '120px',
            cancel:function(){
                if(btntype=="0"){
                    $("#addbtn1.xsbtn-add").css("right","132px");
                    $("#delbtn1.xsbtn-del").css("right","72px");
                    $(".dvId").show();
                    $("#choicebtn1").show();
                    $("#delbtn1").attr("num","1");
                }else {
                    $("#addbtn2.xsbtn-add").css("right","132px");
                    $("#delbtn2.xsbtn-del").css("right","72px");
                    $(".dvIdTom").show();
                    $("#choicebtn2").show();
                    $("#delbtn2").attr("num","1");
                }
            }
        },function(){
            $.ajax({
                url:"/workflow/workLog/delDanger",
                data:{ids:id,workPlanId:workPlanId},
                dataType:"json",
                type:"post",
                success:function(res){
                    layui.layer.msg(res.msg);
                    initWorkLogContent(workPlanId)
                    if(btntype=="0"){
                        $("#addbtn1.xsbtn-add").css("right","132px");
                        $("#delbtn1.xsbtn-del").css("right","72px");
                        $(".dvId").show();
                        $("#choicebtn1").show();
                        $("#delbtn1").attr("num","1");
                    }else {
                        $("#addbtn2.xsbtn-add").css("right","132px");
                        $("#delbtn2.xsbtn-del").css("right","72px");
                        $(".dvIdTom").show();
                        $("#choicebtn2").show();
                        $("#delbtn2").attr("num","1");
                    }
                    layui.form.render();
                }
            })
        }, function () {
            layui.layer.closeAll();
            if(btntype=="0"){
                $("#addbtn1.xsbtn-add").css("right","132px");
                $("#delbtn1.xsbtn-del").css("right","72px");
                $(".dvId").show();
                $("#choicebtn1").show();
                $("#delbtn1").attr("num","1");
            }else {
                $("#addbtn2.xsbtn-add").css("right","132px");
                $("#delbtn2.xsbtn-del").css("right","72px");
                $(".dvIdTom").show();
                $("#choicebtn2").show();
                $("#delbtn2").attr("num","1");
            }
        })
    }



    $(document).on("click",".dvId",function(){
        var dvnum=$(this).attr("dvnum");
        var divId=$(this).attr("divId");
        if (dvnum=="0"){
            $(this).css("background","#7CFC00");
            $(this).attr("dvnum","1");
            $("."+divId).show()
        }else {
            $(this).css("background","#FFFFFF");
            $("."+divId).hide()
            $(this).attr("dvnum","0");

        }
    })

    $(document).on("click",".dvIdTom",function(){
        var dvnum=$(this).attr("dvnumTom");
        var divIdTom=$(this).attr("divIdTom");
        if (dvnum=="0"){
            $(this).css("background","#7CFC00");
            $(this).attr("dvnumTom","1");
            $("."+divIdTom).show()
        }else {
            $(this).css("background","#FFFFFF");
            $("."+divIdTom).hide()
            $(this).attr("dvnumTom","0");

        }
    })

    $("#txtBtn").click(function () {

        var txtdata=$("#text").val();

        updateWork(workPlanId,txtdata);
    })
    function updateWork(workPlanId,txtdata) {
        $.ajax({
            url:"/workflow/workLog/updateWorkPlan",
            data:{workPlanId:workPlanId,planSummary:txtdata},
            dataType:"json",
            type:"post",
            success:function (res) {
                layui.layer.msg(res.msg,{time:1000,offset:"500px",icon:1})
                window.history.go(-1)
            }
        })
    }


    function updatecompletionStatus(id,status,workPlanId){
        //工作状态数据渲染
        $.ajax({
            url:"/workflow/workLog/updateManager",
            data:{logId:id,completionStatus:status,workPlanId:workPlanId},
            dataType:"json",
            type:"post",
            success:function(res){

            }
        })
    }
    function getweatherBefore(){
        var area="";
        var areaText = "";
        //获取地理位置
        if(BMap!=undefined) {
            var map = new BMap.Map("allmap");
            var point = new BMap.Point(108.95, 34.27);
            // map.centerAndZoom(point, 18);
            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    // var mk = new BMap.Marker(r.point);
                    // map.addOverlay(mk);//标出所在地
                    // map.panTo(r.point);//地图中心移动
                    //alert('您的位置：'+r.point.lng+','+r.point.lat);
                    var point = new BMap.Point(r.point.lng, r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
                    var gc = new BMap.Geocoder();
                    gc.getLocation(point, function (rs) {
                        var addComp = rs.addressComponents; //地址信息
                        area = rs.addressComponents.city;
                        $.ajax({
                            type:'get',
                            url:'/widget/getWeatherNew',
                            dataType:'json',
                            data:{cityName:area},
                            success:function(res){
                                if(res.flag && res.object){
                                    $("#water").text(res.object.weather)
                                }
                            }
                        })
                    });
                } else {
                    alert('failed' + this.getStatus());
                }

            }, {enableHighAccuracy: true})

        }
    }
    function judge(datatype) {
        if(datatype!="0"){
            $("#addbtn1").hide();
            $("#addbtn2").hide();
            $("#delbtn1").hide();
            $("#delbtn2").hide();
            $("#getAddbtn").hide();
            $("#getDelbtn").hide();
            $("#getChangebtn").hide();
            $("[name='selecttype1']").attr("disabled","disabled")
            $("[name='selecttype2']").attr("disabled","disabled")
            layui.form.render();
        }
    }
</script>
</body>
</html>
