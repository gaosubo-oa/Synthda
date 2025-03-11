<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>教育机构管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <style>
        .mbox{
            padding: 8px;
        }
        html {
            background: white;
            color: #666;
        }
        .item1{
            margin-left: 5%;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .item2{
            width: 90%;
            margin: 2px auto;
            margin-top: 5px;
        }
        .num{
            color: #2F7CE7;
        }
        .nums{
            color: red;
        }
        .itemTotal{
            margin: 13px 0px;
        }
        #ajaxforms .layui-input{
            /*width: 90%;*/
            /*margin: 2px auto;*/
            height: 30px;
            border-radius: 5px;
            line-height: 30px;
        }
        .fieldName{
            margin-left: 1%;
        }
        .layui-form-radio>i{
            font-size: 18px;
        }
        .layui-form-radio{
            margin: 0px 10px 0px 0px;
        }
        #uploadButton{
            height: 30px;
            line-height: 30px;
            position: absolute;
            top: 5px;
            right: 710px;
        }
        .fieldHover:hover{
            background: #eeeeee;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="margin:10px auto">
        <form class="layui-form"  action="" style="display: inline-block">
            <div style="margin-bottom: 10px; " >
                <%--机构全称--%>
                <div class="layui-inline" >
                    <label class="layui-form-label" style="margin-left: -31px">机构全称</label>
                    <div class="layui-input-inline" style="width: 213px;">
                        <input type="text" name="orgFullname"  lay-verify="required|phone" autocomplete="off" class="layui-input" id="">
                    </div>
                </div>
                <%--机构简称--%>
                <div class="layui-inline" >
                    <label class="layui-form-label" style="margin-left: -31px">机构简称</label>
                    <div class="layui-input-inline" style="width: 213px;">
                        <input type="text" name="deptName"  lay-verify="required|phone" autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <%--机构编码--%>
                <div class="layui-inline" style="margin-left: 50px;">
                    <label class="layui-form-label" style="width: 60px;">机构编码</label>
                    <div class="layui-input-inline" style="width: 140px;">
                        <input type="text" name="orgNum"  lay-verify="required|phone" autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <%--教育部编码--%>
                <div class="layui-inline" style="margin-left: 62px;">
                    <label class="layui-form-label" style="width: 80px;">教育部编码</label>
                    <div class="layui-input-inline" style="width: 125px;">
                        <input type="text" name="educationNum" lay-verify="required|phone" autocomplete="off" class="layui-input" id="">
                    </div>
                </div>
                <%--管理类型--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width:84px;margin-left: 8px">管理类型</label>
                    <div class="layui-input-inline" style="width: 170px;">
                        <select class="schoolManageType" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <%--办别--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width:60px;padding: 9px 9px;">办别</label>
                    <div class="layui-input-inline" style="width: 105px;">
                        <select name="statePrivateId" class="statePrivateId" lay-verify="required" lay-search="" lay-filter="statePrivateId">
                        </select>
                    </div>
                    <div class="layui-input-inline" style="width: 105px;">
                        <select name="statePrivateId2" class="statePrivateId2" lay-verify="required" lay-search="">
                        </select>
                    </div>
                </div>
                <%--学段--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width:80px;">学段</label>
                    <div class="layui-input-inline" style="width: 170px;">
                        <select name="studyPart" class="studyPart" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline" style="margin-top: 10px;">
                    <button type="button" class="layui-btn layui-btn-sm" style="height: 32px;line-height: 32px;margin-left: 90px;" id="insert">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm setNum" style="height: 32px;line-height: 32px">导出</button>
                    <button type="button" class="layui-btn layui-btn-sm tong"  style="height: 32px;line-height: 32px;float: right">同步</button>
                </div>
                <button type="button" class="layui-btn layui-btn-sm add" style="height: 32px;line-height: 32px;float: right;margin-top: 10px;" id="newAdd">新建</button>
            </div>
        </form>
    </div>
    <%--表格--%>
    <div class="tables">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>

    <script type="text/html" id="barDemo">
        {{#  if(d.privType == '1'){ }}
        <a class="layui-btn layui-btn-xs privateLook" lay-event="detail">查看</a>
        {{#  } else { }}
        <a class="layui-btn layui-btn-xs privateLook" lay-event="detail">查看</a>
        <a class="layui-btn layui-btn-xs privateDel" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs privateDel" lay-event="del">删除</a>
        {{#  } }}
    </script>

    <script>

        var fieldLength;
        var attachids=[];
        var attachName=[];
        var attname;
        var ids;
        var form,table,laydate,upload;
        var tableIns;

        //导出
        $('.setNum').click(function () {
            window.location.href="/EduorgMessage/export";
        })
        // 获取地址栏参数值
        function getQueryString(name){
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if(r!=null)return  unescape(r[2]); return null;
        }
        var retrunType = getQueryString('retrunType')
        if(retrunType == '1'){
            var currPage = getQueryString('pageNum');
        }else{
            var currPage ='1'
        }
        //查询
        $('#insert').click(function(){
            var orgFullname = $('input[name="orgFullname"]').val()
            var orgNum = $('input[name="orgNum"]').val()
            var educationNum = $('input[name="educationNum"]').val()
            var schoolManageType = $('.schoolManageType').val()
            var statePrivateId = $('select[name="statePrivateId"]').val()
            var statePrivateId2 = $('select[name="statePrivateId2"]').val()
            var studyPart = $('select[name="studyPart"]').val()
            var deptName = $('input[name="deptName"]').val()
            tableIns.reload({
                where: {
                    orgFullname:orgFullname,
                    orgNum:orgNum,
                    educationNum:educationNum,
                    schoolManageType:schoolManageType,
                    statePrivateId:statePrivateId,
                    statePrivateId2:statePrivateId2,
                    studyPart:studyPart,
                    deptName:deptName
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
            });
        });

        layui.use(['form', 'table','laydate','upload','laypage'], function(){
            form = layui.form
                ,table = layui.table
                ,laydate=layui.laydate
                ,upload = layui.upload;
            var laypage = layui.laypage;
            form.render()
            //同步
            $('.tong').click(function () {
                var loading = layer.load(2, {
                    shade: false,
                    content:'<span class="loadss">同步中</span>',
                    success: function (layero) {
                        layero.find('.layui-layer-content').css({
                            'padding-top': '40px',//图标与样式会重合，这样设置可以错开
                            'width': '200px', //文字显示的宽度
                        });
                        layero.find('.loadss').css({
                            'padding-top': '40px',//图标与样式会重合，这样设置可以错开
                            'width': '200px', //文字显示的宽度
                            'color': '#000000',
                            'font-weight': 'bolder'
                        });
                    }
                });
                $.ajax({
                    type:'get',
                    url:'/EduorgLegal/updateLegalInfo',
                    dataType:'json',
                    success:function (res) {
                        layer.close(loading);
                        if(res.flag){
                            layer.msg('法人库同步成功', {
                                icon: 6,
                                btn: ['确定'],
                                yes: function(index, layero){ // 默认的是 按钮一
                                    layer.closeAll()
                                },
                                title: ['同步完成', 'font-size:18px;'],
                                shade: [0.8, '#393D49'],
                                time: false});
                        }else{
                            layer.msg('法人库同步失败', {
                                icon: 6,
                                btn: ['确定'],
                                yes: function(index, layero){ // 默认的是 按钮一
                                    layer.closeAll()
                                },
                                title: ['同步失败', 'font-size:18px;'],
                                shade: [0.8, '#393D49'],
                                time: false});
                        }

                    }
                })
            });
            //管理类型下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=SCHOOL_MANAGE_TYPE',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var schoolManageType = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                schoolManageType += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.schoolManageType').append(schoolManageType);
                        form.render();
                    }
                }
            })
            // 办别级联下拉选
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=STATE_PRIVATE_ID',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var statePrivateId = '<option value="">请选择</option>';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                statePrivateId += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.statePrivateId').append(statePrivateId);
                        form.render();
                    }
                }
            })
            //学段下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=STUDY_PART',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var studyPart = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                studyPart += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.studyPart').append(studyPart);
                        form.render();
                    }
                }
            })
            //办别二级下拉选
            form.on('select(statePrivateId)',function(){
                $('.statePrivateId2').html('')
                var statePrivateId1 = $('.statePrivateId').val()
                $.ajax({
                    type:'get',
                    url:'/code/getCode?parentNo=STATE_PRIVATE_ID2'+ '_' + statePrivateId1,
                    dataType:'json',
                    success:function (res) {
                        var data = res.obj;
                        var statePrivateId2 = '<option value="">请选择</option>';
                        if(res.flag){
                            if(data.length>0){
                                for(var i=0;i<data.length;i++){
                                    statePrivateId2 += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                                }
                            }
                            $('.statePrivateId2').append(statePrivateId2);
                            form.render()
                        }
                    }
                })
            })

            tableIns=table.render({
                elem: '#test'
                ,url: '/EduorgMessage/selectAll?pageSize=10&useFlag=true'
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,title: '用户数据表'
                ,cols: [[
                    {field:'deptName', title:'机构简称',align:'center',width:'8%'}
                    ,{field:'orgFullname', title:'机构全称',align:'center',width:'8%'}
                    ,{field:'orgNum', title:'机构编码',align:'center',width:'8%'}
                    ,{field:'educationNum', title:'教育部编码',align:'center',width:'8%'}
                    ,{field:'unifiedCreditCode', title:'统一社会信用代码',align:'center',width:'10%'}
                    ,{field:'sPIName', title:'学校办别',align:'center',width:'16%'}
                    ,{field:'schoolTypeNmae', title:'办学类型',align:'center',width:'8%'}
                    ,{field:'schoolManageTypeName', title:'管理类型',align:'center',width:'8%'}
                    ,{field:'studyPartName', title:'学段',align:'center',width:'8%'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo',align:'center'}
                ]],
                done: function(res,curr){
                    // pageNum = $('.layui-laypage-default').find('em').eq(1).text();
                    // currPage = curr;
                    //判斷权限
                    $.ajax({
                        url:'/EduorgMessage/selectAll?pageSize=10&useFlag=true',
                        dataType:'json',
                        success:function(res){
                            if(res.flag){
                                var data = res.data;
                                if(data.privRange != undefined && data.privRange != ''){
                                    if(data.privRange == '全部机构'){
                                        $('#newAdd').show()
                                    }else{
                                        $('#newAdd').hide()
                                    }
                                }else{
                                    $('#newAdd').hide()
                                }
                            }else{
                                $('#newAdd').hide()
                            }
                        }

                    })
                },
                page:{
                    curr: currPage,//currPage是全局变量，后面会给出它在哪里定义以及赋值
                }

            });
            table.on('tool(test)', function(obj){
                var data = obj.data;
                var orgId = data.orgId;
                // console.log(data)
                if(obj.event === 'del'){
                    layer.confirm('确定要删除该数据吗？', function(index){
                        $.ajax({
                            url:'/EduorgMessage/deleteByOrgId',
                            data:{
                                orgId:data.orgId,
                            },
                            dataType:'json',
                            type:'get',
                            success:function(res){
                                if(res.flag){
                                    layer.msg('删除成功',{icon:1});
                                    tableIns.reload()
                                }
                            }
                        })
                        layer.close(index);

                    });
                } else if(obj.event === 'edit'){
                   var currPage=tableIns.config.page.curr;
                    window.location.href='/EduorgMessage/addEduAgency?type=1&orgId=' + orgId +'&pageNum=' +currPage;
                }else if(obj.event=='detail'){
                    window.location.href='/EduorgMessage/addEduAgency?type=2&orgId='+ orgId +'&pageNum=' +currPage;
                }
            });
            $('.add').click(function () {
                window.location.href='/EduorgMessage/addEduAgency'
            })
            var oneClick=false
            $('.search').click(function () {
                var phone= $('input[name="phone"]').val()
                var keyWork=$('input[name="keyWork"]').val()
                var returnTime= $('input[name="returnTime"]').val()
                // var endReturnTime= $('input[name="endReturnTime"]').val()
                var createTime= $('#times5').val()
                var expectReturnTime= $('input[name="expectReturnTime"]').val()
                // var endExpectReturnTime= $('input[name="endExpectReturnTime"]').val()
                var schoolManageType = $('select[name="schoolManageType"]').val()
                var liveStreet = $('select[name="liveStreet"]').val()
                var dayStatus = $('select[name="dayStatus"]').val()
                var healthStatus = $('select[name="healthStatus"]').val()
                var isolation = $('select[name="isolation"]').val()
                if(createTime==''){
                    layer.msg('请填写数据填报日期！', {icon: 0});
                    return false
                }
                if(oneClick){
                    table.reload('test',{
                        where:{

                            keyWork:keyWork,
                            returnTime:returnTime,
                            // endReturnTime:endReturnTime,
                            expectReturnTime:expectReturnTime,
                            // endExpectReturnTime:endExpectReturnTime,
                            schoolManageType:schoolManageType,
                            liveStreet:liveStreet,
                            dayStatus:dayStatus,
                            createTime:createTime,
                            healthStatus:healthStatus,
                            isolation:isolation,
                        }
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                    })
                }else{
                    tableIns=table.render({
                        elem: '#test'
                        ,url:'/HealthyInfo/findHealthyInfo'
                        ,where:{
                            keyWork:keyWork,
                            returnTime:returnTime,
                            // endReturnTime:endReturnTime,
                            expectReturnTime:expectReturnTime,
                            // endExpectReturnTime:endExpectReturnTime,
                            schoolManageType:schoolManageType,
                            liveStreet:liveStreet,
                            dayStatus:dayStatus,
                            createTime:createTime,
                            healthStatus:healthStatus,
                            isolation:isolation,
                            // page:1
                        }
                        ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                        ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                            title: '提示'
                            ,layEvent: 'LAYTABLE_TIPS'
                            ,icon: 'layui-icon-tips'
                        }]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj, //解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        }
                        ,title: '用户数据表'
                        ,cols: [[
                            {type:'numbers', title:'序号'}
                            ,{field:'schoolName', title:'学校简称'}
                            // ,{field:'identityType', title:'身份类型'}
                            ,{field:'userName', title:'姓名(性别)',templet: function(d){
                                    return d.userName+'('+function () {
                                        if(d.sex=='1'){
                                            return  '男'
                                        }else if(d.sex=='2'){
                                            return  '女'
                                        }
                                    }()+')'
                                }}
                            ,{field:'identityType', title:'对象类型',templet:function(d){
                                    if(d.identityType == "1"){
                                        return '学生'
                                    }else{
                                        return '教职员工'
                                    }
                                }}
                            ,{field:'returnTime', title:'返沪日期'}
                            // ,{field:'passportNo', title:'护照号'}
                            ,{field:'expectReturnTime', title:'拟返沪时间'}
                            ,{field:'healthStatus', title:'个人健康状态',templet: function(d){
                                    if(d.healthStatus=='1'){
                                        return  '正常'
                                    }else if(d.healthStatus=='2'){
                                        return  '异常'
                                    }else if(d.healthStatus=='3'){
                                        return  '疑似'
                                    }else if(d.healthStatus=='5'){
                                        return '密切接触未过隔离期'
                                    }else if(d.healthStatus=='4'){
                                        return '确诊'
                                    }else if(d.healthStatus==''){
                                        return ''
                                    }
                                }}
                            ,{field:'isolation', title:'隔离情况',templet:function(d){
                                    if(d.isolation == "1"){
                                        return '集中隔离'
                                    }else if(d.isolation == "2"){
                                        return '居家隔离'
                                    }else if(d.isolation == "3"){
                                        return '健康观察'
                                    }else if(d.isolation == "4"){
                                        return '解除隔离'
                                    }else if(d.isolation == "5"){
                                        return '未隔离'
                                    }
                                    else{
                                        return ''
                                    }
                                }}
                            ,{fixed: 'right', title:'操作', toolbar: '#barDemo',align:'center'}
                        ]],
                        page:true

                    });
                    oneClick=true
                }

            })
        });


        // function getAttachIds(obj) {
        //     return obj.aid+"@"+obj.ym+"_"+obj.attachId;
        // }
        function delFeled(obj){
            $("#"+obj).val('');
            // $("."+obj).html('');
            $("."+obj).hide()
        }
        //获取当前时间  年月日
        function nowformat() {
            var  nstr = "";
            var now = new Date();
            var nyear = now.getFullYear();
            var nmonth = now.getMonth()+1;
            var nday = now.getDate();
            if(nmonth<10){
                nmonth = "0"+nmonth;
            }
            if(nday<10){
                nday = "0"+nday;
            }
            nstr = nyear+"-"+nmonth+"-"+nday;
            return nstr;
        }
        //获取当日前一天
        function yesterday() {
            var day1 = new Date();
            day1.setTime(day1.getTime()-24*60*60*1000);
            var yesterday = day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();
            return yesterday
        }
    </script>
</div>
</body>
</html>