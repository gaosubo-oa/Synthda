<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>周期性资源安排</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/easyui/easyui.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/layui.all.js"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .addbtn{
        margin: 10px auto 10px 10px;
    }
    .spans{
        font-weight: bold;
        font-size: 16px;
        margin-left:40px;
        color:#124164;
    }
    .layui-form-checkbox[lay-skin=primary]{
        height: 0px !important;
    }
    .layui-table-view .layui-form-checkbox[lay-skin=primary] i{
        margin-top: 6px;
    }
</style>
<style>
    .addbtn{
        margin: 10px auto 10px 10px;
    }
    .spans{
        font-weight: bold;
        font-size: 16px;
        margin-left:40px;
        color:#124164;
    }
    .spans i{
        height: 20px;
        width: 30px;
    }
    .relist .layui-table-page .layui-laypage-limits select{
        width: 70px;
    }
    .div{
        width:100px;
        height:100px;
        /*border:1px red solid;*/
        display:inline; /*<!--块元素转行内元素-->*/
    }
    .layui-form-checked[lay-skin=primary] i , .layui-form-checkbox[lay-skin=primary] i{
        margin-top: -1px;
    }
    .layui-table-cell .layui-form-checkbox[lay-skin=primary]{
        top:0px;
    }
    .sp{
        margin-left: 10px;
    }
    .sp i{
        width: 30px;
        height: 19px;
    }
    .applydiv{
        margin-top: 20px;
    }
    .layui-form-checkbox[lay-skin=primary]{
        height: 0px !important;
    }
    .bitian{
        color: red;
    }
</style>
<body>
<div style="position: relative">
    <span class="spans">周期性资源管理列表</span>
    <%--<button type="button" class="layui-btn layui-btn-sm addbtn">添加资源</button>--%>
    <button type="button" class="layui-btn layui-btn-sm addbtn">新建周期性安排</button>
    <table class="layui-hide" id="test" lay-filter="test"></table>
    <button type="button" id="delxm" class="layui-btn" style="position: absolute;top: 4%;right: 12%;width: 68px;">删除</button>
</div>

<%--操作的按钮--%>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    var Applyres='<div class="applydiv" style="width:95%;margin:0 auto ">' +
        '<div class="applydiv"><span>图例说明：</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color: #5FB878"></i>申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color:#FF33FF"></i>撤销</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-red"></i>他人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-blue"></i>本人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-orange"></i>管理员周期安排</span>' +
        '<div class="div" >'+
        '<span class="sp">身份：<span>管理员</span></span>'+
        '<a onclick="his(this)" name="his" class="sp his" style="color: blue">查看历史记录</a>' +
        '</div>'+
        '</div>'+
        '<div class="applydiv"><span>资源申请：</span><input type="text" style="border:none;" /></div>'+
        '<div class="applydiv"><table class="layui-hide" id="applyfilter" lay-filter="applyfilter"></table></div>' +
        '</div>';
    var t = new Date();//获取当前时间
    var year = t.getFullYear();//获取当前时间年份
    var hisres='<div class="applydiv" style="width:95%;margin:0 auto ">' +
        '<div class="layui-form applydiv"><span>查询日期：</span>'+
        '<input type="text" class="layui-input" id="test1" style="width: 100px; height: 30px; display:inline; margin-right: 10px;">至' +
        '<input type="text" class="layui-input" id="test2" style="width: 100px; height: 30px;display:inline; margin-left: 10px; margin-right: 10px;">' +
        '<button type="button" class="layui-btn layui-btn-sm" name="recordingsearch" onclick="recordingsearch(this)">搜索</button>' +
        '</div>' +
        '<div class="applydiv"><span>图例说明：</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color: #5FB878"></i>申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color:#FF33FF"></i>撤销</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-red"></i>他人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-blue"></i>本人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-orange"></i>管理员周期安排</span>' +
        '</div>' +
        '<div class="applydiv"><span>'+year+'年度资源申请历史记录：</span><input name="sname" type="text" style="border:none;" /></div>'+
        '<div class="applydiv"><table class="layui-hide" id="hisfilter" lay-filter="hisfilter" ></table></div>' +
        '</div>';

    var modify='<form  class="layui-form">' +
        '<div class="layui-form-item" style="margin-top:18px">'+
        '<label class="layui-form-label">日期</label>'+
        '<div class="layui-input-block" style="width: 180px;">'+
        '<select name="date" id="date">'+
        '</select>'+
        '</div>'+
        '</div>'+
        '<div class="layui-form-item">'+
        '<label class="layui-form-label">时间段</label>'+
        '<div class="layui-input-block" style="width: 180px;">'+
        '<select name="timeSlot" id="timeSlot" >'+
        '</select>'+
        '</div>'+
        '</div>'+
        '</form>'
    var form,table,laydate,tableIns;
    var sNameData;  ///source/findresUsed接口的返回值
    var segmentList;  //列头和要显示数据

    var SelectedArray=[]; //选中的资源申请对象

    //通用接口ajax,同步ajax
    function baseAjax(url,data) {
        var rews;
        $.ajax({
            url:url,
            type:'post',
            data:data,
            dataType: 'json',
            async:false,
            success:function (res) {
                rews=res
            }
        })
        return rews;
    }
    //资源申请
    function sName(data) {
        layer.open({
            type: 1
            ,area: ['900px', '538px']
            ,title: '资源申请'
            ,shade: 0.6 //遮罩透明度
            ,maxmin: true //允许全屏最小化
            ,content: Applyres
            ,btn: ['<button style="background:none;border:none; margin-top:4px;" lay-submit lay-filter="subadd">确定</button> ', '取消']
            ,yes: function (index, layero) {
                ressubmit(sNameData,index);
            }
            ,success:function (re) {
                $('.applydiv').find('input').val(data.sourcename);

                var UserId=getCookie("userId"); //当前登录人
                $.post('/source/findresUsed',{sourceid:data.sourceid},function (res) {
                    sNameData=res.data
                    var manageUser=res.data.manageUser.split(','); //管理员
                    for (var i=0;i<manageUser.length;i++){
                        if (UserId===manageUser[i]){
                            $('div[name="Identity"]').removeAttr("style");
                        }
                    }
                    tableapply(res.data,undefined,'#applyfilter'); //渲染表格
                    tableecho(res.data); //回显表格

                })
            }
        })
    }
    //资源申请提交
    function ressubmit(data,index) {
        var arrays=[]; //存放申请记录对象
        //周期
        var setweeks=data.weeks;
        for (var i=0;i<setweeks.length;i++){
            var obj=new Object();
            obj["sourceid"]=data.sourceid;
            obj["applyDatestr"]=setweeks[i];
            var tedstr=containstr(SelectedArray,setweeks[i]); //判断是否包含
            var tedindex=arrayindex(tedstr,segmentList); //获取要添加的下标
            obj["userId"]=zerolength(segmentList.length,tedindex);
            arrays.push(obj);
        }

        var json=JSON.stringify(arrays);
        var res=baseAjax('/source/addSourceUse',{json:json});
        layer.close(index)
        SelectedArray.length=0;
    }

    //根据长度获取0的拼接字符串
    function zerolength(length,index) {
        //获取当前登录人
        var userid=getCookie("userId");
        var zero='';
        A:for (var i=0;i<length;i++){
            for (var j=0;j<index.length;j++){
                if (i===index[j]){
                    zero+=userid+',';
                    continue A;
                }
            }
            zero+='0'+',';
        }
        return zero;
    }

    //判断某个数组里是否包含某个字符,返回数组本身
    function containstr(array,arrayitem) {
        var arraystr=[];
        if (array.length>0){
            for(var j=0;j<array.length;j++){
                if (array[j].indexOf(arrayitem)>=0){
                    arraystr.push(array[j]);
                }
            }
        }
        return arraystr;
    }

    //判断在某个数组中是否包含某个字符，返回数组下标
    function arrayindex(array,strarray) {
        var indexarray=[];
        for (var i = 0; i < array.length; i++) {
            for (var j=0;j<strarray.length;j++){
                if (array[i].indexOf(strarray[j]) >= 0) {
                    indexarray.push(j);
                }
            }
        }
        return indexarray;
    }

    //获取cookie的某个值
    function getCookie(cname){
        var name = cname + "=";
        var ca = document.cookie.split(';'); //获取所有cookie值
        for(var i=0; i<ca.length; i++)
        {
            var c = ca[i].trim();
            if (c.indexOf(name)==0) return c.substring(name.length,c.length);
        }
        return "";
    }

    //资源申请动态渲染表格
    function tableapply(data,data2,elem) {
        segmentList=data.segmentList; //列头和要显示数据
        var weekLits=data.weekLits; //日期
        if (data2 != '' && data2!=undefined){
            weekLits=data2
        }
        var cols=[[]];
        var datatab=[];
        //列头
        cols[0].push({field: 'timedata', title: '日期',width:149});
        for(var i=0;i<segmentList.length;i++){
            var key=segmentList[i];
            var clos={field: key, title: key ,width:106,event:'segment'+i}
            cols[0].push(clos);
        }
        //显示日期
        for (var i=0;i<weekLits.length;i++){
            var object = {};
            //先添加日期
            if (data2 != '' && data2!=undefined){
                object['timedata']=weekLits[i].applyDateWeek
            }else {
                object['timedata'] = weekLits[i];
            }
            //每天的时间
            for(var j=0;j<segmentList.length;j++){
                object[segmentList[j]] = segmentList[j];
            }
            datatab.push(object);
        }

        if (data2 != '' && data2!=undefined){
            //渲染
            var tableapply=table.render({
                elem: elem
                ,page: false
                ,data:datatab
                ,cols: cols
                ,limit:datatab.length
            });
        }else {
            //渲染
            var tableapply=table.render({
                elem: elem
                ,page: false
                ,data:datatab
                ,cols: cols
            });
        }

    }
    //资源申请动态回显表格
    function tableecho(data) {
        var day = datatime(); //当前时间
        var param = {
            sourceid: data.sourceid,
            bApplyTimes: day,
            eApplyTimes: day
        }
        var cycresobj = baseAjax('/cyclesource/findcyclesourceall', param); //用来判断是否在周期性里
        var res = baseAjax('/source/cancelSourceUse', {
            sourceid: data.sourceid,
            startingtime: data.weeks[0],
            endtime: data.weeks[data.weeks.length - 1]
        });
        if (res.code === '0' && res.data.length > 0) {
            var datas = res.data;
            var cycres=cycresobj.obj;
            var userId=getCookie('userId');
            $('table[lay-filter="applyfilter"]').next().find('tr').each(function (index, item) { //遍历tr
                var timedateday = $(item).find('td[data-field="timedata"]').find('div').text(); //时间日期加周期

                //先判断当前时间管理员是否安排周期性事务   显示#ff9966 管理员周期安排
                if (cycres.length>0){
                    for (var k=0;k<cycres.length;k++){
                        for(var m=0;m<cycres[k].times.length;m++){
                            if (timedateday.indexOf(cycres[k].times[m]) >= 0) {
                                $(item).find('td').each(function (index, itemtd) { //遍历td
                                    var datafield=$(itemtd).attr("data-field");
                                    var timeTitles=cycres[k].timeTitle.split(',');
                                    for (var n=0;n<timeTitles.length;n++){
                                        if (datafield===timeTitles[n]){
                                            $(itemtd).attr("style", "background-color: #FFB800"); //黄色
                                        }
                                    }
                                });
                            }
                        }
                    }
                }
                for (var i = 0; i < datas.length; i++) { //遍历数据
                    var applydate = datatime(datas[i].applyDate);
                    if (timedateday.indexOf(applydate) >= 0) {
                        var userid = datas[i].userId.split(',');
                        for (var j = 0; j < userid.length; j++) { //遍历时间段
                            if (userid[j] != 0 && userid[j]===userId) {
                                $(item).find('td[lay-event="segment' + j + '"]').attr("style", "background-color: #01AAED"); //蓝色
                                var strend = $(item).find('td[lay-event="segment' + j + '"]').attr('data-field');
                                SelectedArray.push(timedateday + strend);
                            }else if (userid[j] != 0){
                                $(item).find('td[lay-event="segment' + j + '"]').attr("style", "background-color: #FF5722"); //他人申请
                            }
                        }
                    }
                }

            })
        }

    }

    //时间戳转年月日
    function datatime(time) {
        var d=new Date(time);
        if (time===undefined){
            d=new Date();
        }
        var Y = d.getFullYear() + '-';
        var M = (d.getMonth()+1 < 10 ? '0'+(d.getMonth()+1) : d.getMonth()+1) + '-';
        var D = d.getDate();
        return Y+M+D;
    }
    //指定某个元素数组删除
    function deleteItem (item, list) {
        // 先遍历list里面的每一个元素，对比item与每个元素的id是否相等，再利用splice的方法删除
        for (var key in list) {
            if (list[key] === item) {
                list.splice(key, 1)
            }
        }
    }
    //查看历史记录
    function his(thisdata) {
        layer.open({
            type: 1
            , area: ['900px', '538px']
            , title: '资源申请历史记录'
            , shade: 0.6 //遮罩透明度
            , maxmin: true //允许全屏最小化
            , content: hisres
            , btn: ['确定']
            ,yes: function(index, layero){
                layer.close(index);
            }
            ,success:function (re) {
                $('.applydiv').find('input[name="sname"]').val(sNameData.sourcename);

                recordingsearch();

                //日期
                form.render();
                laydate.render({
                    elem: '#test1' //指定元素
                });
                laydate.render({
                    elem: '#test2' //指定元素
                });
            }
        });
    }

    //申请记录搜索单击事件
    function recordingsearch(o) {
        var StartData=$('#test1').val(); //开始时间
        var EndData=$('#test2').val(); //结束时间

        var param = {
            sourceid: sNameData.sourceid
        }
        var cycresobj = baseAjax('/cyclesource/findcyclesourceall', param); //用来判断是否在周期性里


        var res=baseAjax('/source/cancelSourceUse',{sourceid:sNameData.sourceid,startingtime:StartData,endtime:EndData});
        if (res.code === '0' && res.data.length > 0 ) {
            var datas=res.data;
            var cycres=cycresobj.obj;
            var userId=getCookie('userId');

            //渲染表格
            tableapply(sNameData,datas,'#hisfilter');
            tableecho(sNameData);
            $('table[lay-filter="hisfilter"]').next().find('tr').each(function (index, item) { //遍历tr
                var timedateday = $(item).find('td[data-field="timedata"]').find('div').text(); //时间日期加周期

                //先判断当前时间管理员是否安排周期性事务   显示#ff9966 管理员周期安排
                if (cycres.length>0){
                    for (var k=0;k<cycres.length;k++){
                        for(var m=0;m<cycres[k].times.length;m++){
                            if (timedateday.indexOf(cycres[k].times[m]) >= 0) {
                                $(item).find('td').each(function (index, itemtd) { //遍历td
                                    var datafield=$(itemtd).attr("data-field");
                                    var timeTitles=cycres[k].timeTitle.split(',');
                                    for (var n=0;n<timeTitles.length;n++){
                                        if (datafield===timeTitles[n]){
                                            $(itemtd).attr("style", "background-color: #FFB800"); //黄色
                                        }
                                    }
                                });
                            }
                        }
                    }
                }
                for (var i = 0; i < datas.length; i++) { //遍历数据
                    var applydate = datatime(datas[i].applyDate);
                    if (timedateday.indexOf(applydate) >= 0) {
                        var userid = datas[i].userId.split(',');
                        for (var j = 0; j < userid.length; j++) { //遍历时间段
                            if (userid[j] != 0 && userid[j]===userId) {
                                $(item).find('td[lay-event="segment' + j + '"]').attr("style", "background-color: #01AAED"); //蓝色
                                var strend = $(item).find('td[lay-event="segment' + j + '"]').attr('data-field');
                                SelectedArray.push(timedateday + strend);
                            }else if (userid[j] != 0){
                                $(item).find('td[lay-event="segment' + j + '"]').attr("style", "background-color: #FF5722"); //他人申请
                            }
                        }
                    }
                }

            })
        }else{
            layer.msg('暂无数据');
        }
    }

    //修改系统管理员的预定时间
    $(document).on('dblclick','td',function(){
        if($(this).attr('style')=='background-color: #01AAED'|| $(this).attr('style')=='background-color: #FFB800'){
            var shijianhui=$(this).attr('data-field') //时间段
            var riqihui =$(this).parent().children(":first").children(":first").text() // 日期
            layer.open({
                type: 1 //Page层类型
                , area: ['600px', '300px']
                , title: '修改系统管理员的预定时间'
                , shade: 0.6 //遮罩透明度
                , maxmin: true //允许全屏最小化
                , content: modify
                , btn: ['保存', '取消']
                ,yes: function(index, layero){
                    var cDate=$("#date").val()
                    var cTime=$('#timeSlot').val()
                    var cTimeDate=cDate+cTime;//新
                    var JTimeDate=riqihui+shijianhui// 旧
                    deleteItem(JTimeDate,SelectedArray); //移除数组
                    SelectedArray.push(cTimeDate); //添加数组
                    ressubmit(sNameData,index);
                    layer.close(index);
                    var UserId=getCookie("userId"); //当前登录人
                    $.post('/source/findresUsed',{sourceid:sNameData.sourceid},function (res) {
                        sNameData=res.data
                        var manageUser=res.data.manageUser.split(','); //管理员
                        for (var i=0;i<manageUser.length;i++){
                            if (UserId===manageUser[i]){
                                $('div[name="Identity"]').removeAttr("style");
                            }
                        }
                        tableapply(res.data,undefined,'#applyfilter'); //渲染表格
                        tableecho(res.data); //回显表格

                    })
                }
                ,success:function () {
                    timeSlot();
                    //回显
                    $("#date").val(riqihui)
                    $('#timeSlot').val(shijianhui)
                    form.render('select')
                }
            })
        }
    });

    function timeSlot(){
        var dateT=sNameData.weekLits
        var timeT=sNameData.segmentList
        var str=''
        var str1=''
        for(var i=0;i<dateT.length;i++){
            str+='<option value="'+dateT[i]+'">'+dateT[i]+'</option>'
        }
        for(var i=0;i<timeT.length;i++){
            str1+='<option value="'+timeT[i]+'">'+timeT[i]+'</option>'
        }
        $("#date").html(str); //日期
        $('#timeSlot').html(str1)//时间段
    }



    layui.use(['form', 'table','laydate'], function(){
        form = layui.form;
        table = layui.table;
        laydate = layui.laydate;
        tableIns = table.render({
            elem: '#test'
            ,url:'/cyclesource/findcyclesourceall'
            ,cols: [[
                {type: 'checkbox', title:'选择',fixed: 'left'}
                ,{field:'sname', title:'资源名称', fixed: 'left',event:'sName'}
                ,{field:'bApplyTime', title:'开始日期', templet: function(d){
                        return  timestampToTime(d.bApplyTime)
                    }}
                ,{field:'eApplyTime', title:'结束日期 ', templet: function(d){
                        return  timestampToTime(d.eApplyTime)
                    }}
                ,{field:'userName', title:'使用人 '}
                ,{field: 'type',title: '操作', toolbar: '#barDemo'}
            ]]
            ,page: true
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj, //解析数据列表
                    "msg": res.msg,//解析数据列表
                    "count": res.totleNum,
                };
            }
        });


        //监听工具事件;资源申请
        table.on('tool(applyfilter)', function(obj){
            var data=obj.data; //当前行
            var event=obj.event;
            //时间段
            for(var i=0;i<segmentList.length;i++){
                if (event=='segment'+i){
                    var back=$(this).attr("style");
                    var timeseg=$(this).find("div").html(); //选中的时间段
                    var timedataseg=data.timedata+timeseg; //日期加时间段
                    if(back===undefined){
                        $(this).attr("style","background-color: #5FB878"); //绿色
                        SelectedArray.push(timedataseg); //添加数组
                    }else if(back==='background-color: #01AAED'){
                        $(this).attr("style","background-color: #FF33FF"); //粉色
                        deleteItem(timedataseg,SelectedArray); //移除数组
                    }else if(back==='background-color: #FF33FF'){
                        $(this).attr("style","background-color: #01AAED"); //蓝色
                    }else if (back!='background-color: #FFB800'){
                        $(this).removeAttr("style");
                        deleteItem(timedataseg,SelectedArray); //移除数组
                    }
                }
            }

        })

        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            var cycid=data.cycid
            var sourceid=data.sourceid
            if(layEvent === 'detail'){ //查看
                layer.open({
                    type: 1 //Page层类型
                    , area: ['900px', '500px']
                    , title: '周期性资源申请'
                    , shade: 0.6 //遮罩透明度
                    , maxmin: true //允许全屏最小化
                    , content: '<form class="layui-form" action=""><table class="layui-table">\n' +
                    '  <colgroup>\n' +
                    '    <col width="80" >\n' +
                    '    <col width="200">\n' +
                    '    <col>\n' +
                    '  </colgroup>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">资源名称</td>\n' +
                    '      <td>'+data.sname+'</td>\n' +
                    '    </tr> \n' +
                    '  <tbody>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">开始日期</td>\n' +
                    '      <td>'+timestampToTime(data.bApplyTime)+'</td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">结束日期</td>\n' +
                    '      <td>'+timestampToTime(data.eApplyTime)+'</td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">星期设定</td>\n' +
                    '      <td>'+
                    '<div class="layui-form-item">'+function(){
                        var ar = data.weekdaySet
                        if(ar.substring(ar.length-1,ar.length)==','){
                            ar = ar.substring(0,ar.length-1);
                        }
                        var warr=ar.split(',')
                        var str1 = "";
                        var weekvalue=''
                        for(var j=0;j<warr.length;j++){
                            if(warr[j]=="1" || warr[j]==1){
                                warr[j]="星期一";
                                weekvalue=1
                            }
                            else if(warr[j]=="2" || warr[j]==2){
                                warr[j]="星期二";
                                weekvalue=2
                            }
                            else if (warr[j]=="3" || warr[j]==3) {
                                warr[j] = "星期三";
                                weekvalue=3
                            }
                            else if (warr[j]=="4" || warr[j]==4) {
                                warr[j] = "星期四";
                                weekvalue=4
                            }
                            else if (warr[j]=="5" || warr[j]==5) {
                                warr[j] = "星期五";
                                weekvalue=5
                            }
                            else if (warr[j]=="6" || warr[j]==6) {
                                warr[j] = "星期六";
                                weekvalue=6
                            }
                            else if (warr[j]=="0" || warr[j]==0) {
                                warr[j] = "星期日";
                                weekvalue=0
                            }
                            str1 += '<input checked type="checkbox" name="" title="'+warr[j]+'" lay-skin="primary"  value="'+weekvalue+'" disabled/>'
                        }
                        return str1;
                    }()+'</div>' +
                    '       </td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">时间段设定</td>\n' +
                    '      <td>'+data.timeTitle+'</td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">备注</td>\n' +
                    '      <td>'+data.remark+'</td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">使用人</td>\n' +
                    '      <td>'+data.userName+'</td>\n' +
                    '    </tr>\n' +
                    '    <tr>\n' +
                    '      <td style="text-align: center">操作时间</td>\n' +
                    '      <td>'+timestampToTime1(data.applyTime)+'</td>\n' +
                    '    </tr>\n' +
                    '  </tbody>\n' +
                    '</table></form>'
                    ,success:function () {
                        form.render()
                    }
                });

            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该数据吗？', function(index){
                    $.ajax({
                        type: 'get',
                        url: '/cyclesource/deleteIds?ids='+cycid,
                        dataType: 'json',
                        success: function (res) {
                            // form.render()
                            layer.msg('删除成功', {icon: 6});
                        }
                    })
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    // layer.close(index);
                    // //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){ //编辑
                layer.open({
                    type: 1 //Page层类型
                    , area: ['900px', '500px']
                    , title: '周期性资源申请'
                    , shade: 0.6 //遮罩透明度
                    , maxmin: true //允许全屏最小化
                    , btn: ['保存', '取消']
                    , content: '<div>' +
                    '<form class="layui-form" action="">\n' +
                    '<div class="layui-form-item" style="margin-top: 10px">\n'+
                    '<label class="layui-form-label">资源名称<span class="bitian">*</span></label>\n'+
                    '<div class="layui-input-block"   style="width: 300px;">\n'+
                    '<select name="school" id="sName" lay-verify="required" lay-filter="resour" >\n'+
                    '</select>\n'+
                    '</div>\n'+
                    '</div>\n'+
                    '<div class="layui-inline">\n' +
                    '<label class="layui-form-label" style="margin-bottom:15px">开始日期<span class="bitian">*</span></label>\n' +
                    '<div class="layui-input-inline">\n' +
                    '<input type="datetime" name="happenTime" id="yzdata"  autocomplete="off" class="layui-input ">\n' +
                    '</div>\n'+
                    '</div>' +
                    '<div class="layui-block">\n' +
                    '<label class="layui-form-label" style="margin-bottom:15px">结束日期<span class="bitian">*</span></label>\n' +
                    '<div class="layui-input-inline">\n' +
                    '<input type="datetime" name="happenTime" id="endtime"  autocomplete="off" class="layui-input">\n' +
                    '</div>\n'+
                    '</div>' +
                    '<div class="layui-form-item" style="margin-top: 10px">\n'+
                    '<label class="layui-form-label">使用设定<span class="bitian">*</span></label>\n'+
                    '<div class="layui-input-block" >\n'+
                    '<p style="font-size:16px">使用人:</p>\n'+
                    '<div style="width: 300px">'+
                    '<select name="user" id="user" lay-verify="required" >\n'+
                    '</select>\n'+
                    '</div>'+
                    '<p style="font-size:16px">星期设定:</p>\n'+
                    '<div class="layui-form-item" id="week">'+
                    '</div>'+
                    '<p style="font-size:16px">时间段:</p>\n'+
                    '<div class="layui-form-item" id="time">'+
                    '</div>'+
                    '</div>\n'+
                    '</div>\n'+
                    '<div class="layui-form-item layui-form-text">\n' +
                    '<label class="layui-form-label">备注</label>\n' +
                    '<div class="layui-input-block">\n' +
                    '<textarea name="eventDescribe"  id="infoms" class="layui-textarea" style="width:81%"  placeholder="请输入内容"></textarea>\n' +
                    '</div>\n' +
                    '</div>\n' +
                    '</form>' +
                    '</div>'
                    ,success:function () {
                        //显示时间
                        laydate.render({
                            elem: '#yzdata'
                        });
                        laydate.render({
                            elem: '#endtime'
                        });
                        //监听资源名称显示使用人
                        form.on('select(resour)', function(data){
                            x(data);
                            x1(data)
                            x2(data)
                        });
                        //显示资源名称下拉框
                        $.ajax({
                            type: 'get',
                            url: '/source/select',
                            dataType: 'json',
                            success: function (res) {
                                var data=res.data
                                var str=''
                                for(var i=0;i<data.length;i++){
                                    str+='<option timeTitle="'+data[i].timeTitle+'"  weekdaySet="'+data[i].weekdaySet+'" value="'+data[i].sourceid+'">'+data[i].sourcename+'</option>'
                                }
                                $('#sName').html(str)
                                x(data);
                                //编辑页面数据回显
                                $.ajax({
                                    type: 'get',
                                    url: '/cyclesource/findcyclesourcebyid?cycid='+cycid,
                                    dataType: 'json',
                                    success: function (res) {
                                        var data=res.obj1
                                        console.log(data)
                                        //回显开始日期
                                        $('#yzdata').val(timestampToTime(data.bApplyTime))
                                        //回显结束日期
                                        $('#endtime').val(timestampToTime(data.eApplyTime))
                                        //回显星期设定
                                        var ar = data.weekdaySet
                                        if(ar.substring(ar.length-1,ar.length)==','){
                                            ar = ar.substring(0,ar.length-1);
                                        }
                                        var warr=ar.split(',')
                                        var str1 = "";
                                        var weekvalue=''
                                        for(var j=0;j<warr.length;j++){
                                            if(warr[j]=="1" || warr[j]==1){
                                                warr[j]="星期一";
                                                weekvalue=1
                                            }
                                            else if(warr[j]=="2" || warr[j]==2){
                                                warr[j]="星期二";
                                                weekvalue=2
                                            }
                                            else if (warr[j]=="3" || warr[j]==3) {
                                                warr[j] = "星期三";
                                                weekvalue=3
                                            }
                                            else if (warr[j]=="4" || warr[j]==4) {
                                                warr[j] = "星期四";
                                                weekvalue=4
                                            }
                                            else if (warr[j]=="5" || warr[j]==5) {
                                                warr[j] = "星期五";
                                                weekvalue=5
                                            }
                                            else if (warr[j]=="6" || warr[j]==6) {
                                                warr[j] = "星期六";
                                                weekvalue=6
                                            }
                                            else if (warr[j]=="0" || warr[j]==0) {
                                                warr[j] = "星期日";
                                                weekvalue=0
                                            }
                                            str1 += '<input checked type="checkbox" name="" title="'+warr[j]+'"  value="'+weekvalue+'" lay-skin="primary" />'
                                        }
                                        $('#week').html(str1)
                                        //回显时间段
                                        var time=data.timeTitle
                                        if(time.substring(time.length-1,time.length)==','){
                                            time = time.substring(0,time.length-1);
                                        }
                                        var tt=time.split(',')
                                        var str=''
                                        for(var i=0;i<tt.length;i++){
                                            str+='<input checked type="checkbox" name="" title="'+tt[i]+'" value="'+tt[i]+'" lay-skin="primary">'
                                        }
                                        $('#time').html(str)
                                        //回显备注
                                        $('#infoms').html(data.remark)
                                        //回显资源名称
                                        $('#sName').val(data.sourceid)
                                        // console.log(data.sourceid)
                                        //回显使用人
                                        huixian(data,data.userId)
                                        // console.log(data.userId)
                                        // $('#user').val(data.userId)
                                        form.render('select')
                                        form.render()
                                    }
                                })

                            }
                        })
                    }
                    ,yes: function(index, layero){
                        var sourcename=$('#sName').find('option:checked').val()
                        var bApplyTimes=$('#yzdata').val()
                        var eApplyTimes=$('#endtime').val()
                        var  username=$('#user').find('option:checked').val()
                        var weekT=toWeek()
                        console.log(weekT)
                        var weekTit=weekT.join(',')
                        console.log(weekTit)
                        var timeT=toTime()
                        var timeTit=timeT.join(',')
                        var remark=$('#infoms').val()
                        if (bApplyTimes==''){
                            layer.msg('请选择开始时间', {icon: 5});
                            return false
                        }
                        if (eApplyTimes==''){
                            layer.msg('请选择结束时间', {icon: 5});
                            return false
                        }
                        if (weekTit==''){
                            layer.msg('请选择星期设定', {icon: 5});
                            return false
                        }
                        if (timeTit==''){
                            layer.msg('请选择时间段', {icon: 5});
                            return false
                        }
                        var param={
                            cycid:cycid,
                            sourceid:sourcename,
                            bApplyTimes:bApplyTimes,
                            eApplyTimes:eApplyTimes,
                            userId:username,
                            weekdaySet:weekTit,
                            timeTitle:timeTit,
                            remark:remark
                        }
                        $.ajax({
                            type: 'post',
                            url: '/cyclesource/updateCylesource',
                            data:param,
                            dataType: 'json',
                            success: function (res) {
                                tableIns.reload()
                            }
                        })
                        layer.close(index);
                    }
                });
            }else if (obj.event=="sName"){
                //资源名称
                sName(data);
            }
        });
    });
    //点击新建周期性安排
    $('.addbtn').click(function () {
        layer.open({
            type: 1 //Page层类型
            , area: ['900px', '500px']
            , title: '新建周期性资源申请'
            , shade: 0.6 //遮罩透明度
            , maxmin: true //允许全屏最小化
            , content: '<div>' +
            '<form class="layui-form" action="">\n' +
            '<div class="layui-form-item" class="select" style="margin-top: 10px">\n'+
            '<label class="layui-form-label">资源名称<span class="bitian">*</span></label>\n'+
            '<div class="layui-input-block" style="width: 170px;">\n'+
            '<select name="school"  id="sName" lay-verify="required" lay-filter="resour" >\n'+
            '</select>\n'+
            '</div>\n'+
            '</div>\n'+
            '<div class="layui-inline">\n' +
            '<label class="layui-form-label" style="margin-bottom:15px">开始时间<span class="bitian">*</span></label>\n' +
            '<div class="layui-input-inline">\n' +
            '<input type="datetime" name="happenTime" id="yzdata"  autocomplete="off" class="layui-input ">\n' +
            '</div>\n'+
            '</div>' +
            '<div class="layui-block">\n' +
            '<label class="layui-form-label" style="margin-bottom:15px">结束时间<span class="bitian">*</span></label>\n' +
            '<div class="layui-input-inline">\n' +
            '<input type="datetime" name="happenTime" id="endtime"  autocomplete="off" class="layui-input">\n' +
            '</div>\n'+
            '</div>' +
            '<div class="layui-form-item" style="margin-top: 10px">\n'+
            '<label class="layui-form-label">使用设定<span class="bitian">*</span></label>\n'+
            '<div class="layui-input-block" >\n'+
            '<p style="font-size:16px">使用人:</p>\n'+
            '<div style="width: 170px">'+
            '<select name="user"  id="user" lay-verify="required"  style="display: none">\n'+
            '</select>\n'+
            '</div>'+
            '<p style="font-size:16px">星期设定:</p>\n'+
            '<div class="layui-form-item" id="week">'+
            '</div>'+
            '<p style="font-size:16px">时间段:</p>\n'+
            '<div class="layui-form-item" id="time">'+
            '</div>'+
            '</div>\n'+
            '</div>\n'+
            '<div class="layui-form-item layui-form-text">\n' +
            '<label class="layui-form-label">备注</label>\n' +
            '<div class="layui-input-block">\n' +
            '<textarea name="eventDescribe"  id="infoms" class="layui-textarea" style="width:81%"  placeholder="请输入内容"></textarea>\n' +
            '</div>\n' +
            '</div>\n' +
            '</form>' +
            '</div>'
            , btn: ['保存', '取消']
            , success: function () {
                //显示时间
                laydate.render({
                    elem: '#yzdata'
                });
                laydate.render({
                    elem: '#endtime'
                });
                //显示资源名称下拉框
                $.ajax({
                    type: 'get',
                    url: '/source/select',
                    dataType: 'json',
                    success: function (res) {
                        var data=res.data
                        if(data.length>0){
                            var str='<option timeTitle="'+data[0].timeTitle+'"  weekdaySet="'+data[0].weekdaySet+'" value="'+data[0].sourceid+'">'+data[0].sourcename+'</option>'
                            for(var i=1;i<data.length;i++){
                                str+='<option timeTitle="'+data[i].timeTitle+'"  weekdaySet="'+data[i].weekdaySet+'" value="'+data[i].sourceid+'">'+data[i].sourcename+'</option>'
                            }
                            $('#sName').html(str)
                        }
                        x(data);
                        x1(data[0])
                        x2(data[0]);
                        form.render()
                    }
                })
                //监听资源名称显示使用人
                form.on('select(resour)', function(data){
                    x(data);
                    x1(data)
                    x2(data)
                });
            }
            ,yes: function(index, layero){
                var sourcename=$('#sName').find('option:checked').val()
                var bApplyTimes=$('#yzdata').val()
                var eApplyTimes=$('#endtime').val()
                var  username=$('#user').find('option:checked').val()
                var weekT=toWeek()
                var weekTit=weekT.join(',')
                var timeT=toTime()
                var timeTit=timeT.join(',')
                var remark=$('#infoms').val()
                if (bApplyTimes==''){
                    layer.msg('请选择开始时间', {icon: 5});
                    return false
                }
                if (eApplyTimes==''){
                    layer.msg('请选择结束时间', {icon: 5});
                    return false
                }
                if (weekTit==''){
                    layer.msg('请选择星期设定', {icon: 5});
                    return false
                }
                if (timeTit==''){
                    layer.msg('请选择时间段', {icon: 5});
                    return false
                }
                var param={
                    sourceid:sourcename,
                    bApplyTimes:bApplyTimes,
                    eApplyTimes:eApplyTimes,
                    userId:username,
                    weekdaySet:weekTit,
                    timeTitle:timeTit,
                    remark:remark
                }
                $.ajax({
                    type: 'post',
                    url: '/cyclesource/insert',
                    data:param,
                    dataType: 'json',
                    success: function (res) {
                        tableIns.reload()
                    }
                })
                layer.close(index);
            }
        });
    })
    //批量删除功能
    $("#delxm").click(function () {
        var data = layui.table.checkStatus('test').data;
        console.log(data)
        if (data.length < 0 || data.length == 0) {
            layer.msg("请至少选择一条记录！");
            return false;
        }
        var ids = '';
        for (var i = 0; i < data.length; i++) {
            ids += data[i].cycid + ",";
        }
        layer.confirm('确认要删除吗？', {
            btn: ['确认', '取消'],
            icon: 7,
            title: "系统提示"
        }, function () {
            $.ajax({
                url: "/cyclesource/deleteIds",
                type: "post",
                data: {
                    ids: ids,
                },
                dataType: "json",
                traditional: true,
                success: function (res) {
                    if (res.flag) {
                        layui.layer.msg('删除成功！',{icon:6});
                    }
                    tableIns.reload('test')
                }
            });
        });
    })
    //回显使用人
    function huixian(data,val) {
        var sourceid;
        sourceid=data.sourceid
        $.ajax({
            type: 'get',
            url: '/source/findSourceVisitUser',
            data:{sourceid:sourceid},
            dataType: 'json',
            success: function (res) {
                var data=res.data
                var str='';
                if(data!=undefined){
                    str=''
                    // for(var i=0;i<data.length;i++){
                    //     str+='<option value="'+data[i].userid+'">'+data[i].username+'</option>'
                    // }
                    Object.keys(data).map(function (key) {
                        str+='<option value="'+key+'">'+data[key]+'</option>'
                    })
                }
                $('#user').html(str)
                if(val!=undefined){
                    $('#user').val(val)
                }
                form.render()
            }
        })

    }
    //根据资源名称展示使用人
    function x(data) {
        var  sourceid;
        if (data.value!=undefined){
            sourceid=data.value
        }else {
            sourceid=data[0].sourceid;
        }
        $.ajax({
            type: 'get',
            url: '/source/findSourceVisitUser',
            data:{sourceid:sourceid},
            dataType: 'json',
            success: function (res) {
                var data=res.data
                var str='';
                if(data!=undefined){
                    str=''
                    // for(var i=0;i<data.length;i++){
                    //     str+='<option value="'+data[i].userid+'">'+data[i].username+'</option>'
                    // }
                    Object.keys(data).map(function (key) {
                        str+='<option value="'+key+'">'+data[key]+'</option>'
                    })
                }
                $('#user').html(str)
                form.render()
            }
        })
    }
    //根据资源名称展示星期设定
    function x1(data) {
        var weekdaySet
        if (data.value!=undefined){
            $('#sName option').each(function(index,item){
                var value=$(this).attr("value");
                if (data.value==value) {
                    weekdaySet=$(this).attr("weekdaySet")
                }
            });
        }else{
            weekdaySet=data.weekdaySet
        }
        var weekday=weekdaySet.split(',').slice(0,-1)
        var str=''
        var weekvalue=''
        for(var i=0;i<weekday.length;i++){
            if(weekday[i]=='1'){weekday[i]='星期一';weekvalue=1}
            else if(weekday[i]=='2'){weekday[i]='星期二';weekvalue=2}
            else if(weekday[i]=='3'){weekday[i]='星期三';weekvalue=3}
            else if(weekday[i]=='4'){weekday[i]='星期四';weekvalue=4}
            else if(weekday[i]=='5'){weekday[i]='星期五';weekvalue=5}
            else if(weekday[i]=='6'){weekday[i]='星期六';weekvalue=6}
            else if(weekday[i]=='0'){weekday[i]='星期日';weekvalue=0}
            str+='<input type="checkbox"  title="'+weekday[i]+'" lay-skin="primary" value="'+weekvalue+'">'
        }
        $('#week').html(str)
    }
    //根据资源名称展示时间段
    function x2(data) {
        var timeTitle;
        if (data.value!=undefined){
            $('#sName option').each(function(index,item){
                var value=$(this).attr("value");
                if (data.value==value) {
                    timeTitle=$(this).attr("timetitle")

                }
            });
        }else {
            timeTitle=data.timeTitle;
        }
        var timeTit=timeTitle.split(',')
        // console.log(timeTit)
        var tt=''
        for(var i=0;i<timeTit.length;i++){
            tt+='<input type="checkbox" name="one" title="'+timeTit[i]+'" lay-skin="primary" value="'+timeTit[i]+'">'
        }
        $('#time').html(tt)
    }
    //时间戳转变日期格式 年-月-日
    function timestampToTime(timestamp) {
        var date = new Date(timestamp );//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        // var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
        // var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        // var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
        return Y+M+D;
    }
    //时间戳转变日期格式 年-月-日 时-分-秒
    function timestampToTime1(timestamp) {
        var date = new Date(timestamp );//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
        var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
        return Y+M+D+h+m+s;
    }
    //获取星期几
    function toWeek(){
        var weekList = [];
        $('#week input:checkbox').each(function(){
            if($(this).is(':checked')==true){
                weekList.push($(this).val());
            }
        })
        return weekList;
    }
    //获取时间段
    function toTime(){
        var timeList = [];
        $('#time input:checkbox').each(function(){
            if($(this).is(':checked')==true){
                timeList.push($(this).val());
            }
        })
        return timeList;
    }
</script>
</body>
</html>
