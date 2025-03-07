<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--/*
* 创建作者:   廉立深
* 创建日期:   13:35 2019/11/13
* 方法介绍:   资源申请与管理
* 参数说明:
* @return
*/--%>
<html>
<head>
    <title>资源申请与管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/easyui/easyui.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layer/mobile/layer.js?20201106"></script>
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
    .spans i{
        height: 20px;
        width: 30px;
    }
    .layui-form .we input[type=checkbox], .layui-form input[type=radio], .layui-form select{
        /*display: inline-block;*/
        width:17px;
        height:17px;
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
        top:6px;
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
    .layui-layer-btn {
        text-align: center;
    }
</style>
<body>
<div>
    <%--头部标题按钮--%>
    <div class="head div" id="addResource">
        <span class="spans">可申请资源列表</span>
        <button type="button" class="layui-btn layui-btn-sm addbtn" >添加资源</button>
    </div>

    <%--搜索--%>
    <div class="forms">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">检索名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="searchtitle" required  lay-verify="required" placeholder="请输入搜索的内容" autocomplete="off" class="layui-input" style="width:200px">
                </div>
                <button type="button" name="search" class="layui-btn" style="margin-left: 30px;height: 37px;">搜索</button>
            </div>
        </form>
    </div>

</div>

<%-- style="width:80%;margin-left:20px"  数据表格--%>
<div class="relist">
    <table class="layui-hide" id="test" lay-filter="test" ></table>
</div>

<%--操作的按钮--%>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="upd">用户权限</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="role">角色权限</a>
    <a class="layui-btn layui-btn-xs" lay-event="set">设置管理员</a>
    <a class="layui-btn layui-btn-xs" lay-event="clear">清空</a>
    <a class="layui-btn layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    var userPrivNo;//当前登录人
    //获取当前登录人
    $.ajax({
        url: '/getLoginUser',
        type: 'get',
        dataType: 'json',
        anysc:false,
        success: function (json) {
            userPrivNo = json.object.userPrivNo;
            if(userPrivNo!=1){
                var t = document.getElementById('addResource');
                t.style.display = 'none';
            }
        }
    });

    var htmlpoen='<div>' +
        '<form class="layui-form" action="">\n' +
        '<div class="layui-form-item" style="margin-top:10px">\n' +
        '<label class="layui-form-label">资源序号</label>\n' +
        '<div class="layui-input-block">\n' +
        '<input type="text" name="sourceno" id="information" required  lay-verify="required" autocomplete="off" class="layui-input" style="width:50%">\n' +
        '</div>\n' +
        '</div>' +
        '<div class="layui-form-item" style="margin-top:10px">\n' +
        '<label class="layui-form-label">资源名称</label>\n' +
        '<div class="layui-input-block">\n' +
        '<input type="text" name="sourcename" id="inforname" required  lay-verify="required" autocomplete="off" class="layui-input" style="width:50%">\n' +
        '</div>\n' +
        '</div>'+
        '<div class="layui-form-item">\n' +
        '<label class="layui-form-label">预约天数</label>\n' +
        '<div class="layui-input-block" style="margin-bottom:"15px">\n' +
        '<input type="text" name="dayLimit"  id="days" required  lay-verify="required"  autocomplete="off" class="layui-input" style="width:50%">\n' +
        '</div>'+
        '</div>\n'+
        '<div class="layui-form-item">\n' +
        '<label class="layui-form-label">星期设定</label>\n' +
        '<div class="wk">'+
        '<input type="checkbox" name="weekdaySet" value="1" title="星期一" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="2" title="星期二" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="3" title="星期三" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="4" title="星期四" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="5" title="星期五" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="6" title="星期六" lay-filter="checkfilter" lay-skin="primary" >'+
        '<input type="checkbox" name="weekdaySet" value="0" title="星期日" lay-filter="checkfilter" lay-skin="primary" >'+
        '</div>'+
        '</div>\n'+
        '<div class="layui-form-item layui-form-text">\n' +
        '<label class="layui-form-label">时间段</label>\n' +
        '<div class="layui-input-block">\n' +
        '<textarea name="timeTitle"  id="times" class="layui-textarea" style="width:81%"></textarea>\n' +
        '<p style="font-size:12px">请用英文逗号隔开</p>\n'+
        '</div>\n' +
        '</div>\n' +
        '<div class="layui-form-item layui-form-text">\n' +
        '<label class="layui-form-label">备注</label>\n' +
        '<div class="layui-input-block">\n' +
        '<textarea name="remark"  id="describe" class="layui-textarea" style="width:81%"></textarea>\n' +
        '</div>\n' +
        '</div>\n' +
        '</form>' +
        '</div>';
    var  timeTitle="09:00-09:30,09:30-10:00,10:00-10:30,10:30-11:00,11:00-11:30,11:30-12:00,12:00-12:30,12:30-13:00,13:00-13:30,13:30-14:00,14:00-14:30,14:30-15:00,15:00-15:30,15:30-16:00,16:00-16:30,16:30-17:00,17:00-17:30,17:30-18:00,18:00-21:00";
    var splitday=['1','2','3','4','5']; //默认星期设定五天


    var Applyres='<div class="applydiv" style="width:95%;margin:0 auto ">' +
        '<div class="applydiv"><span>图例说明：</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color: #5FB878"></i>申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm" style="background-color:#FF33FF"></i>撤销</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-red"></i>他人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-blue"></i>本人已经申请</span>'+
        '<span class="sp"><i class="layui-btn layui-btn-sm layui-bg-orange"></i>管理员周期安排</span>' +
        '<div class="div" style="display: none" name="Identity">' +
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
            ,btn: ['<button style="background:none;border:none; margin:4px auto;" >提交</button> ', '关闭']
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
        // layer.close(index)
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

    //编辑
    function enit(data) {
        layer.open({
            type: 1 //Page层类型
            , area: ['900px', '600px']
            , title: '编辑资源'
            , shade: 0.6 //遮罩透明度
            , maxmin: true //允许全屏最小化
            , content: htmlpoen
            , btn: ['保存', '取消']
            ,yes: function(index, layero){
                var infoma = $('#information').val();
                var infona = $('#inforname').val();
                var dayed = $('#days').val();
                var time = $('#times').val();
                var des = $('#describe').val();

                var weekdaySet=''; //星期设定
                for (var key in splitday){
                    weekdaySet+=splitday[key]+",";
                }
                param={
                    sourceid:data.sourceid,
                    sourceno:infoma,
                    sourcename:infona,
                    dayLimit:dayed,
                    timeTitle:time,
                    remark:des,
                    weekdaySet:weekdaySet
                }
                //编辑
                var res=baseAjax('/source/update',param);
                if (res.code==='0'){
                    tableIns.reload()
                    layer.closeAll()
                }
            }
            ,success:function (re) {
                $.ajax({
                    url:'/source/selectById',
                    data:{sourceid:data.sourceid},
                    type: 'get',
                    dataType: 'json',
                    success:function(res){
                        splitday.length = 0; //先清空

                        $('#information').val(res.data.sourceno)
                        $('#inforname').val(res.data.sourcename)
                        $('#days').val(res.data.dayLimit)
                        $('#times').val(res.data.timeTitle)
                        $('#describe').val(res.data.remark)
                        var data= res.data;
                        var splitday2=data.weekdaySet.split(',');  //循环复选框并截取字段
                        $('.wk input[name="weekdaySet"]').each(function(index,element){
                            for (var i=0;i<splitday2.length;i++) {
                                if($(this).val()==splitday2[i]){
                                    splitday.push(splitday2[i]); //已选
                                    //$(this).prop("checked",true);
                                    $(this).attr("checked",'true');
                                }
                            }
                        })
                        form.render();
                    }
                })
            }
        })
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

    //点击添加资源的按钮点击事件
    $('.addbtn').click(function(){
        layer.open({
            type: 1
            , area: ['80%', '90%']
            , title: '添加资源'
            , shade: 0.6 //遮罩透明度
            , maxmin: true //允许全屏最小化
            , content: htmlpoen
            , btn: ['<button style="background:none;border:none; margin-top:4px;"  lay-submit lay-filter="subadd">保存</button> ', '取消']
            ,yes: function(index, layero){

            }
            ,success:function (re) {
                $('#times').val(timeTitle); //默认时间段
                $('#days').val("7"); //默认预约天数七天
                $('.wk input[name="weekdaySet"]').each(function(index,element){
                    for (var i=0;i<splitday.length;i++) {
                        if($(this).val()==splitday[i]){
                            //$(this).prop("checked",true);
                            $(this).attr("checked",'true');
                        }
                    }
                })
                form.render();
            }

        })
    })

    //主页搜索点击事件
    $('button[name="search"]').click(function () {
        var srarchtitle= $('input[name="searchtitle"]').val();
        tableIns.reload({ //其它参数省略
            where:{
                sourcename: srarchtitle
            }
        });
    });
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

    //用户权限；角色权限；设置管理员
    function permission(data,type) {
        var title;
        if (type===1){
            title='指定资源申请用户权限';
        }else if (type===2){
            title='指定资源申请角色权限';
        }else if (type===3){
            title='指定资源管理员';
        }
        layer.open({
            type: 2
            ,area: ['900px', '538px']
            ,title: title
            ,shade: 0.6 //遮罩透明度
            ,maxmin: true //允许全屏最小化
            ,content: '/source/managetypeDetail?type='+type+'&id='+data.sourceid
            ,btn: ['确定', '取消']
            ,yes: function (index, layero) {
                // 父调用子页面的方法
                $(layero).find("iframe")[0].contentWindow.getStr();
            }
            ,success: function (re) {

            }
        });
    }

    //获取子页面的数据，进行渲染
    var getChildData = function (getData,type,id) {
        var getdata = getData;
        // 封装一个函数 获取一个数组
        function getArr(str){
            var arr = [];
            var ar = str.split(",");
            for(var key in ar){
                arr.push(ar[key]);
            }
            // 数组去掉最后一项
            var carr = arr.slice(0,-1);
            return carr;
        }
        // 获取子页面下的某元素的id值 拼接成字符串
        var ss = "";
        for(var i=0;i<getdata.length;i++){
            ss += getdata[i].value + ",";
        }
        //获得一个数组
        var sarr = getArr(ss);

        // 获取子页面下的某元素的id值对应的名字 拼接成字符串
        var nn = "";
        for(var i=0;i<getdata.length;i++){
            nn += getdata[i].title + ",";
        }
        //获得一个数组
        var narr = getArr(nn);

        var param;
        if(type==='1'){
            param={
                sourceid:id
                ,visitUser:ss
            }
        }else if(type==='2'){
            param={
                sourceid:id
                ,visitPriv:ss
            }
        }else if(type==='3'){
            param={
                sourceid:id
                ,manageUser:ss
            }
        }
        var res= baseAjax('/source/update',param);
        if (res.code==0){
            layer.closeAll()
            layer.alert('修改成功');
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
        var userPrivNo;//当前登录人
        var toobals=false;
        //获取当前登录人
        $.ajax({
            url: '/getLoginUser',
            type: 'get',
            dataType: 'json',
            anysc:false,
            success: function (json) {
                userPrivNo = json.object.userPrivNo;
                if(userPrivNo!=1){
                    var t = document.getElementById('addResource');
                    t.style.display = 'none';
                    toobals = true;
                    tableIns=table.render({
                        elem: '#test'
                        ,url:'/source/select'
                        ,title: '可申请资源列表'
                        ,page: true
                        ,async:false
                        ,cols: [[
                            {type: 'checkbox'}
                            ,{field:'sourceno', title:'序号'}
                            ,{field:'sourcename', title:'资源名称', event:'sName',templet:'#titleTipl'}
                            ,{title:'操作', toolbar: '#barDemo',hide:toobals}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.totleNum, //解析数据长度
                                "data": res.data //解析数据列表
                            };
                        }
                    });
                }else{
                    tableIns=table.render({
                        elem: '#test'
                        ,url:'/source/select'
                        ,title: '可申请资源列表'
                        ,page: true
                        ,async:false
                        ,cols: [[
                            {type: 'checkbox'}
                            ,{field:'sourceno', title:'序号'}
                            ,{field:'sourcename', title:'资源名称', event:'sName',templet:'#titleTipl'}
                            ,{title:'操作', toolbar: '#barDemo',hide:toobals}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.totleNum, //解析数据长度
                                "data": res.data //解析数据列表
                            };
                        }
                    });
                }
            }
        });


        //监听工具事件
        table.on('tool(test)', function(obj){
            var data=obj.data; //当前行
            //点击编辑的按钮
            if(obj.event === 'edit'){
                enit(data);
            }else if(obj.event =="del"){
                //删除
                var result =  baseAjax('/source/delete',{sourceIds:data.sourceid});
                layer.msg(result.msg)
                table.reload("test");
            }else if(obj.event =="clear"){
                //清空
                var result =   baseAjax('/source/deleteUsedSourceId',{sourceid:data.sourceid});
                layer.msg(result.msg)
            }else if (obj.event=="sName"){
                //资源名称
                sName(data);
            }else if (obj.event=="upd"){
                //用户权限
                permission(data,1);
            }else if (obj.event=="role"){
                //角色权限
                permission(data,2);
            }else if (obj.event=="set"){
                //设置管理员
                permission(data,3);
            }
        })

        //复选框监听事件
        form.on('checkbox(checkfilter)', function(data){
            if (data.elem.checked){
                splitday.push(data.value);
            }else {
                deleteItem(data.value,splitday);
            }
        });

        //添加提交监听事件
        form.on('submit(subadd)', function(data){
            var sourceno=$("input[name='sourceno']").val(); //资源序号
            var sourcename=$("input[name='sourcename']").val(); //资源名称
            var dayLimit=$("input[name='dayLimit']").val(); //预约天数
            var weekdaySet=''; //星期设定
            var timeTitle=$("textarea[name='timeTitle']").val(); //时间段
            var remark=$("textarea[name='remark']").val(); //备注

            for (var key in splitday){
                weekdaySet+=splitday[key]+",";
            }
            var param={
                sourceno:sourceno
                ,sourcename:sourcename
                ,dayLimit:dayLimit
                ,weekdaySet:weekdaySet
                ,timeTitle:timeTitle
                ,remark:remark
            }

            if(sourceno==undefined || sourceno==''){
                layer.msg("资源序号不可为空");
                return false;
            }else{
                if( sourcename==undefined || sourcename==''){
                    layer.msg("资源名称不可为空");
                    return false;
                }else{
                    var res=baseAjax( '/source/insert',param);
                    if (res.code==='0'){
                        tableIns.reload()
                        layer.closeAll()
                        layer.msg("添加成功")
                    }
                }
            }
        });

        //资源申请表格监听工具事件
        table.on('tool(applyfilter)', function(obj){
            var data=obj.data; //当前行
            //点击编辑的按钮
            if(obj.event === 'edit'){
                enit(data);
            }
        })

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
                    }else if (back==='background-color: #5FB878'){
                        $(this).removeAttr("style");
                        deleteItem(timedataseg,SelectedArray); //移除数组
                    }
                }
            }

        })
    });

</script>
<script type="text/html" id="titleTipl">
    <a href="javascript:;" data-d="{{d.descript}}" style=" text-decoration:none;">{{d.sourcename}}</a>
</script>
</body>
</html>
