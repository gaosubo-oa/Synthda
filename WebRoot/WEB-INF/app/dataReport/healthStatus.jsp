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
    <title>健康状态</title>
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
                <%--管理类型--%>
                <div class="layui-inline" >
                    <label class="layui-form-label" style="margin-left: -37px">管理类型</label>
                    <div class="layui-input-inline" style="width: 162px;">
                        <select name="schoolManageType" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <option value="1">机关与直属单位</option>
                            <option value="2">托育机构</option>
                            <option value="3">公办幼儿园</option>
                            <option value="4">民办幼儿园</option>
                            <option value="5">民办三级幼儿园</option>
                            <option value="6">外籍幼儿园</option>
                            <option value="7">公办小学</option>
                            <option value="8">公办中学</option>
                            <option value="9">随迁学校 </option>
                            <option value="10">民办中小学</option>
                            <option value="11">外籍中小学</option>
                            <option value="12">局管中职校</option>
                            <option value="13">行业中职校</option>
                            <option value="14">市属中职校</option>
                            <option value="15">成教中心社区学校老年大学</option>
                            <option value="16">全日制培训机构</option>
                        </select>
                    </div>
                </div>
                <%--所在街镇--%>
                <div class="layui-inline" style="margin-left: 50px;">
                    <label class="layui-form-label" style="width: 60px;">所在街镇</label>
                    <div class="layui-input-inline" style="width: 125px;">
                        <select name="liveStreet" lay-verify="required" lay-search="">
                            <option value="">请选择</option>\n' +
                            <option value="1">江川路街道</option>
                            <option value="2">新虹街道</option>
                            <option value="3">古美路街道</option>
                            <option value="4">浦锦街道</option>
                            <option value="5">莘庄镇</option>
                            <option value="6">七宝镇</option>
                            <option value="7">浦江镇</option>
                            <option value="8">梅陇镇</option>
                            <option value="9">虹桥镇</option>
                            <option value="10">马桥镇</option>
                            <option value="11">吴泾镇</option>
                            <option value="12">华漕镇</option>
                            <option value="13">颛桥镇</option>
                            <option value="14">莘庄工业区</option>
                            <option value="15">外区街镇 </option>
                        </select>
                    </div>
                </div>
                <%--当日状态--%>
                <div class="layui-inline" style="margin-left: 62px;">
                    <label class="layui-form-label" style="width: 60px;">当日状态</label>
                    <div class="layui-input-inline" style="width: 125px;">
                        <select name="dayStatus" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <option value="1">当日在沪</option>
                            <option value="2">当日在重点地区（湖北武汉）</option>
                            <option value="3">当日在重点地区（湖北其他地区）</option>
                            <option value="4">当日在国内其他地区</option>
                            <option value="5">当日在境外（含中国港澳台地区）</option>
                            <option value="6">返校途中</option>
                        </select>
                    </div>
                </div>
                <%--个人健康状况--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width:84px;margin-left: -6px">个人健康状况</label>
                    <div class="layui-input-inline" style="width: 170px;">
                        <select name="healthStatus" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <option value="1">正常</option>
                            <option value="2">异常</option>
                            <option value="3">疑似</option>
                            <option value="4">确诊</option>
                            <option value="5">密切接触未过隔离期</option>
                        </select>
                    </div>
                </div>
                <%--隔离情况--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width:60px;padding: 9px 9px;">隔离情况</label>
                    <div class="layui-input-inline" style="width: 105px;">
                        <select name="isolation" lay-verify="required" lay-search="">
                            <option value="">请选择</option>
                            <option value="1">集中隔离</option>
                            <option value="2">居家隔离</option>
                            <option value="3">健康观察</option>
                            <option value="4">解除隔离</option>
                            <option value="5">未隔离</option>
                        </select>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 10px;">
                <%--<div class="layui-inline">
                    <label class="layui-form-label" style="width: 127px;margin-left: -14px;">返沪日期结束时间</label>
                    <div class="layui-input-inline" style="width: 120px;">
                        <input type="text"  name="endReturnTime" placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="times2">
                    </div>
                </div>--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 84px">数据填报日期</label>
                    <div class="layui-input-inline" style="width: 120px;">
                        <input type="text" name="createTime" placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="times5">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;">返沪日期</label>
                    <div class="layui-input-inline" style="width: 125px;">
                        <input type="text" name="returnTime"  placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="times1">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 121px;">拟返沪日期</label>
                    <div class="layui-input-inline" style="width: 125px;">
                        <input type="text"  name="expectReturnTime" placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="times3">
                    </div>
                </div>
                <%-- <div class="layui-inline">
                     <label class="layui-form-label" style="width: 127px">拟返沪日期结束时间</label>
                     <div class="layui-input-inline" style="width: 120px;">
                         <input type="text" name="endExpectReturnTime" placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="times4">
                     </div>
                 </div>--%>
                <%--关键字--%>
                <div class="layui-inline" style="margin-left: 19px;" >
                    <label class="layui-form-label" style="width:44px;">关键字</label>
                    <div class="layui-input-inline" style="width: 186px;">
                        <input type="text"  placeholder="姓名/身份证/在沪居住地址" name="keyWork" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <button type="button" class="layui-btn layui-btn-sm search" style="height: 32px;line-height: 32px;margin-left: 15px;margin-top: 3px;">查询数据</button>
                <button type="button" class="layui-btn layui-btn-sm " style="height: 32px;line-height: 32px;margin-top:3px;" id="Export">导出Excel</button>
                <%--<button type="button" class="layui-btn layui-btn-sm search" style="height: 32px;line-height: 32px;margin-left: 10px;margin-top: 3px;">查询数据</button>--%>
                <%--<button type="button" class="layui-btn layui-btn-sm " style="height: 32px;line-height: 32px;margin-top:3px;" id="Export">导出Excel</button>--%>
            </div>
            <div>
                <button type="button" class="layui-btn layui-btn-sm add" style="display:none;height: 32px;line-height: 32px;margin-left: 15px;" id="newAdd">新建</button>
                <button type="button" class="layui-btn layui-btn-sm " style="display:none;height: 32px;line-height: 32px" onclick="Import(1)" id="daoru">导入Excel</button>
                <button type="button" class="layui-btn layui-btn-sm" style="display:none; height: 32px;line-height: 32px" onclick="Import(2)" id="HWImport">华为数据导入</button>
                <button type="button" class="layui-btn layui-btn-sm" style="display:none; height: 32px;line-height: 32px" onclick="Import(3)" id="NumImport">导入人数</button>
                <button type="button" class="layui-btn layui-btn-sm setNum" style="height: 32px;line-height: 32px">设置人员数量</button>
            </div>
        </form>
    </div>
    <%--表格--%>
    <div class="tables">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>

    <script type="text/html" id="barDemo">

    </script>

    <script>

        var fieldLength;
        var attachids=[];
        var attachName=[];
        var attname;
        var ids;
        var form,table,laydate,upload;
        var tableIns;


        //判断是否 显示导入按钮
        $(function () {
            $.get('/HealthyInfo/isEducationBureau',function (res) {
                if (res.object===1){
                    $('#HWImport').css("display","inline-block");
                    $('#NumImport').css("display","inline-block");
                    $('#newAdd').css("display","inline-block");
                    $('#daoru').css("display","inline-block");
                    $('#barDemo').html('<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>\n' +
                        '        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>\n' +
                        '        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>');
                }else{
                    $('#barDemo').html('<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>');
                }
            });
        });

        //导出
        $('#Export').click(function(){
            var keyWork=$('input[name="keyWork"]').val()
            var returnTime= $('input[name="returnTime"]').val()
            var createTime= $('input[name="createTime"]').val()
            var expectReturnTime= $('input[name="expectReturnTime"]').val()
            var schoolManageType = $('select[name="schoolManageType"]').val()
            var liveStreet = $('select[name="liveStreet"]').val()
            var dayStatus = $('select[name="dayStatus"]').val()
            var healthStatus = $('select[name="healthStatus"]').val()
            var isolation = $('select[name="isolation"]').val();

            window.location.href="/HealthyInfo/ExportHealthyInfo?" +
                "keyWork="+keyWork+
                "&returnTime="+returnTime+
                "&createTime="+createTime+
                "&expectReturnTime="+expectReturnTime+
                "&schoolManageType="+schoolManageType+
                "&liveStreet="+liveStreet+
                "&dayStatus="+dayStatus+
                "&healthStatus="+healthStatus+
                "&isolation="+isolation;
        });

        //导入
        function Import(is) {
            var title='导入数据';
            if (is===3){
                title='导入人数';
            }
            var str = '' ;
            if(is===2){
                str += '<div class="layui-form-item" style="margin-left:6px">\n'+
                    '     <label class="layui-form-label" style="width: 112px;">填报日期</label>\n'+
                    '         <div class="layui-input-inline" style="width: 125px;">\n'+
                    '              <input type="text" name="fillDate" placeholder="请选择" lay-verify="required|phone" autocomplete="off" class="layui-input" id="huaweiTime" >\n'+
                    '         </div>\n'+
                    '    </div>';
            }
            layer.open({
                type: 1,
                area: ['531px', '400px'], //宽高
                title:title,
                maxmin:true,
                btn: ['确定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item" name="template">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" href="/file/schoolHealthy/师生健康管理模块数据导入模板.xls" style="text-decoration: underline; color: blue;">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>' +str +
                    '  <div class="layui-form-item">\n'+
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n'+
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls文件</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success:function () {
                    laydate.render({
                        elem: '#huaweiTime' //指定元素
                    });
                    //华为导入数据默认当日的前一天
                    $('input[name="fillDate"]').val(yesterday())
                    //上传
                    var strurl="";
                    // var fillDate = "";
                    if (is===1){ //导入
                        strurl='/HealthyInfo/ImportHealthyInfo';
                    }else if(is===2){ //华为数据导入
                        strurl='/HealthyInfo/ImportEducationBureau';
                        // fillDate = $('input[name="fillDate"]').val()
                    }else if(is===3){ //人数导入
                        strurl='/HealthyInfo/ImportNumDept';
                        $('div[name="template"]').remove();
                    }
                    //执行实例
                    // console.log($('input[name="fillDate"]').val())
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: strurl //上传接口
                        ,accept:'file'
                        // ,data: {"fillDate":fillDate}
                        ,auto:false
                        ,bindAction: '.layui-layer-btn0'
                        ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                            layer.load(); //上传loading
                            this.data={"fillDate":$('input[name="fillDate"]').val()}
                        }
                        ,choose: function(obj){
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function(index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        ,done: function(res){
                            var data=res.object
                            if(data!=undefined){
                                var listMsg=res.object.listMsg
                                layer.confirm( '<div class="daoInfor" style="font-size: 16px;"><div style="color:green ">导入成功'+data.trueNum+'条</div>'+
                                    function () {
                                        var str = "";
                                    //重复
                                        if (data.repeat!=undefined) {
                                            str+='<div style="color:red ">重复'+data.repeat+'条记录</div>';
                                        }
                                            //失败
                                        if (data.falseNum!=undefined){
                                            var errS = data.schoolErr;
                                            if(errS != undefined){
                                                    for(var key in errS){
                                                        str+='<div style="color:red ">'+key+'失败'+errS[key]+'条记录</div>';
                                                    }
                                            }
                                                str+='<div style="color:red ">导入失败'+data.falseNum+'条</div>';
                                            for(var i=0;i<listMsg.length;i++){
                                                str+='<li>'+'第'+listMsg[i].row+'行'+','+function () {
                                                    var strs=''
                                                    for(var key in listMsg[i]){
                                                        if(key!='row'){
                                                            strs+=listMsg[i][key]+'、'
                                                        }
                                                    }
                                                    return strs
                                                }()+'</li>'
                                            }
                                            return str;
                                        }
                                        return str;
                                    }()+
                                    '</div>', {
                                    area:['52%','60%'],
                                    btn: ['确定'] //按钮
                                    ,yes:function (index) {
                                        layer.close(index);
                                        tableIns.reload({
                                            url:'/HealthyInfo/findHealthyInfo',
                                            where:{
                                                createTime:$('#times5').val()
                                            }
                                        });
                                    }
                                });
                            }else {
                                layer.msg("请上传正确的附件信息",{icon:0});
                            }
                            layer.closeAll('loading'); //关闭loading
                        }
                        ,error: function(){
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                            layer.closeAll('loading'); //关闭loading
                        }
                    });

                },
                yes: function(index, layero){
                    layer.close(index);
                }
            });
        }

        layui.use(['form', 'table','laydate','upload','laypage'], function(){
            form = layui.form
                ,table = layui.table
                ,laydate=layui.laydate
                ,upload = layui.upload;
            var laypage = layui.laypage;
            form.render()
            //监听行工具事件
            laydate.render({
                elem: '#times1' //指定元素
            });
            laydate.render({
                elem: '#times3' //指定元素
            });
            laydate.render({
                elem: '#times4' //指定元素
            });
            laydate.render({
                elem: '#times5' //指定元素
            });
            $('#times5').val(nowformat)
            tableIns=table.render({
                elem: '#test'
                ,url:'/HealthyInfo/findHealthyInfo'
                ,where:{
                    createTime:$('#times5').val()
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
            table.on('tool(test)', function(obj){
                var data = obj.data;
                // console.log(data)
                if(obj.event === 'del'){
                    layer.confirm('确定要删除该数据吗？', function(index){
                        $.ajax({
                            url:'/HealthyInfo/deleteHealthyInfo',
                            data:{
                                healId:data.healId,
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
                    creat(1,data.healId)
                }else if(obj.event=='detail'){
                    creat(2,data.healId)
                }
            });
            $('.add').click(function () {
                creat(0)
            })
            $('.setNum').click(function () {
                layer.open({
                    type: 1,
                    title: '设置人员数量',
                    btn:['确定','取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['40%', '60%'],
                    content:'<form class="layui-form" id="setNum" lay-filter="setNum">'+
                        '<div class="layui-form-item one" style="width: 70%;margin-left: 12%;margin-top:35px;">' +
                        '    <label class="layui-form-label">学生总数:</label>' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="STUDENT_NUM" required  lay-verify="required"  autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item" style="width: 70%;margin-left: 12%;">' +
                        '    <label class="layui-form-label">教师总数:</label>' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="TEACHER_NUM" required  lay-verify="required"  autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item" style="width: 70%;margin-left: 12%;">' +
                        '    <label class="layui-form-label" style="padding: 9px 3px;width: 90px;">学生失联人数:</label>' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="STUDENT_LOST_NUM" required  lay-verify="required"  autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item" style="width: 70%;margin-left: 12%;">' +
                        '    <label class="layui-form-label" style="padding: 9px 3px;width: 90px;">教师失联人数:</label>' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="TEACHER_LOST_NUM" required  lay-verify="required"  autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '</form>',
                    success:function () {
                        if($(window).width()<768){
                            $('.layui-layer').width('90%')
                            $('.layui-layer .one').css('margin-top','50px')
                            $('.layui-layer').css('left','20px')
                        }else if($(window).width()>=768&&$(window).width()<=992){
                            $('.layui-layer').width('80%')
                        }else if($(window).width()>=992&&$(window).width()<=1200){
                            $('.layui-layer').width('70%')
                        }else if($(window).width()>=1200){
                            $('.layui-layer').width('40%')
                        }
                        $.ajax({
                            url:'/department/getschoolDeptById',
                            data:{deptId:-1},
                            dataType:'json',
                            type:'get',
                            success:function(res){
                                form.val("setNum", res.object);
                            }
                        })
                    },
                    yes:function (index) {
                        var STUDENT_NUM=$('input[name="STUDENT_NUM"]').val()
                        var TEACHER_NUM=$('input[name="TEACHER_NUM"]').val()
                        var STUDENT_LOST_NUM=$('input[name="STUDENT_LOST_NUM"]').val()
                        var TEACHER_LOST_NUM=$('input[name="TEACHER_LOST_NUM"]').val()
                        if($('input[name="STUDENT_NUM"]').val()==''){
                            STUDENT_NUM='0'
                        }
                        if($('input[name="TEACHER_NUM"]').val()==''){
                            TEACHER_NUM='0'
                        }
                        if($('input[name="STUDENT_LOST_NUM"]').val()==''){
                            STUDENT_LOST_NUM='0'
                        }
                        if($('input[name="TEACHER_LOST_NUM"]').val()==''){
                            TEACHER_LOST_NUM='0'
                        }
                        var data={
                            DEPT_ID:'-1',
                            STUDENT_NUM:STUDENT_NUM,
                            TEACHER_NUM:TEACHER_NUM,
                            STUDENT_LOST_NUM:STUDENT_LOST_NUM,
                            TEACHER_LOST_NUM:TEACHER_LOST_NUM,
                        }
                        $.ajax({
                            url:'/department/editschoolDept',
                            data:{jsonStr:JSON.stringify(data)},
                            dataType:'json',
                            type:'post',
                            success:function(res){
                                if(res.flag){
                                    layer.msg('修改成功',{icon:1});
                                    layer.close(index)
                                }
                            }
                        })
                    }
                })
            })
            function creat(type,healId) {
                if(type=='0'){
                    var title = '新建'
                    var url = '/HealthyInfo/insertHealthyInfo'
                }else if(type=='1'){
                    var title = '编辑'
                    var url = '/HealthyInfo/updateHealthyInfo'
                }else if(type=='2'){
                    var title = '查看'
                    var url = '/HealthyInfo/updateHealthyInfo'
                }
                layer.open({
                    type: 1,
                    title: title,
                    btn:['确定','取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['60%', '90%'],
                    content:'<form class="layui-form" id="ajaxforms" lay-filter="formsTest" >' +
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">学校编码</span></div>\n' +
                        ' <div class="item2"><input type="text" name="organNum" autocomplete="off" class="layui-input requiredempty organNum bitian jinyong" readonly="readonly"  fieldname="学校编码"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">学校简称</span></div>\n' +
                        ' <div class="item2"><input type="text" name="schoolName" required  lay-verify="required"   autocomplete="off"  readonly="readonly"  class="layui-input requiredempty schoolName bitian jinyong" fieldname="学校简称"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">对象类型</span></div>\n' +
                        ' <div class="item2 radio " fieldName="对象类型">' +
                        '<div><input  type="radio" class="jinyong" name="identityType" lay-filter="identityType"  value="1" title="学生"></div>'+
                        '<div><input  type="radio" class="jinyong"  name="identityType"  lay-filter="identityType" value="2" title="教职员工"></div>'+
                        '</div> '+
                        ' </div>\n'+
                        //   学生开始
                        '<div id="xue" >\n'+

                        ' </div>'+
                        // 学生结束
                        // 教职员工开始
                        '<div class="faculty" id="jiao" >\n'+

                        ' </div>\n'+
                        //   教职员工结束
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">姓名</span></div>\n' +
                        ' <div class="item2"><input type="text" name="userName" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty bitian jinyong" fieldname="姓名"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="fieldName">性别</span></div>\n' +
                        ' <div class="item2 radio" fieldName="性别">' +
                        '<div><input  type="radio" class="requiredempty jinyong" name="sex" value="1" title="男"></div>'+
                        '<div><input  type="radio" class="requiredempty jinyong" name="sex" value="2" title="女"></div>'+
                        '</div> '+
                        ' </div>'+
                        // ' <div class="itemTotal">\n' +
                        // ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">国籍</span></div>\n' +
                        // ' <div class="item2"><input  type="text" name="nationality" required  lay-verify="required"   autocomplete="off" class="layui-input  requiredempty nationality bitian" fieldname="国籍"></div>\n' +
                        // ' </div>'+
                        // ' <div class="itemTotal">\n' +
                        // ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">国籍</span></div>\n' +
                        // ' <div class="item2">\n' +
                        // '<select name="nationality" lay-verify="required" lay-filter="nationality"  lay-search="" fieldname="国籍" class="requiredempty selectbixuan">\n' +
                        // '          <option value="1" selected>中国大陆</option>\n' +
                        // '          <option value="2">中国港澳台</option>\n' +
                        // '          <option value="3">外籍</option>\n' +
                        // '        </select>\n' +
                        // ' </div>\n'+
                        // ' </div>\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">国籍</span></div>\n' +
                        ' <div class="item2"><input type="text" name="nationality" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty bitian jinyong"  fieldname="国籍"  placeholder="填写国籍"></div>\n' +
                        ' </div>'+
                        //身份证号
                        '<div id="identityNo">' +
                        // ' <div class="itemTotal crad" >\n' +
                        // ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">身份证号</span></div>\n' +
                        // ' <div class="item2"><input  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" type="text" name="identityNo" required  lay-verify="required" autocomplete="off" class="layui-input  requiredempty bitian" fieldname="身份证号"></div>\n' +
                        // ' </div>'+
                        '</div>'+
                        //护照号码
                        '<div id="passportNo">' +

                        '</div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">手机号</span></div>\n' +
                        ' <div class="item2"><input  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" type="text" name="phone" required  lay-verify="required"   autocomplete="off" class="layui-input phone requiredempty bitian jinyong"   fieldname="手机号"></div>\n' +
                        ' </div>'+
                        // '<div class="itemTotal">\n' +
                        // ' <div class="item1"><span class="num">14</span><span class="fieldName">家庭成员</span>' +
                        // ' <button type="button" class="layui-btn layui-btn-sm familyadd" style="float:right;margin-right: 47px">添加</button>' +
                        // ' </div>\n' +
                        // ' </div>'+
                        // '<div class="itemTotal" id="index-div1">\n' +
                        // '</div>\n'
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">当日状态</span></div>\n' +
                        ' <div class="item2">\n' +
                        '<select name="dayStatus" lay-verify="required" lay-search="" fieldname="当日状态" class="requiredempty selectbixuan jinyong">\n' +
                        '          <option value="">请选择</option>\n' +
                        '          <option value="1">当日在沪</option>\n' +
                        '          <option value="2">当日在重点地区（湖北武汉）</option>\n' +
                        '          <option value="3">当日在重点地区（湖北其他地区）</option>\n' +
                        '          <option value="4">当日在国内其他地区</option>\n' +
                        '          <option value="5">当日在境外（含中国港澳台地区）</option>\n' +
                        '          <option value="6">返校途中</option>\n' +
                        '        </select>\n' +
                        ' </div>\n'+
                        ' </div>\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">留校情况</span></div>\n' +
                        ' <div class="item2 radio" fieldName="留校情况">' +
                        '<div><input  type="radio" class="requiredempty jinyong" name="detention" value="1" title="未留校"  checked></div>'+
                        '<div><input  type="radio" class="requiredempty jinyong" name="detention" value="2" title="留校"></div>'+
                        '</div> '+
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">离开湖北境内日期</span></div>\n' +
                        ' <div class="item2"><input name="departureTime" type="text" class="layui-input requiredempty jinyong" fieldname="离开湖北境内日期" id="test1"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">返沪前居住地址</span></div>\n' +
                        ' <div class="item2"><input type="text" name="homeAddress" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty jinyong"  placeholder="填写省-市-详细地址"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">返沪日期</span></div>\n' +
                        ' <div class="item2"><input name="returnTime"  type="text" class="layui-input requiredempty jinyong"  id="test2"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">拟返沪日期</span></div>\n' +
                        ' <div class="item2"><input name="expectReturnTime"  type="text" class="layui-input requiredempty jinyong"  id="test9"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">在沪居住地所在街镇</span></div>\n' +
                        ' <div class="item2"> ' +
                        '<select name="liveStreet" lay-verify="required" class="requiredempty selectbixuan jinyong" fieldname="在沪居住地所在街镇">\n' +
                        '        <option value="">请选择</option>\n' +
                        '        <option value="1">江川路街道</option>\n' +
                        '        <option value="2">新虹街道</option>\n' +
                        '        <option value="3">古美路街道</option>\n' +
                        '        <option value="4">浦锦街道</option>\n' +
                        '        <option value="5">莘庄镇</option>\n' +
                        '        <option value="6">七宝镇</option>\n' +
                        '        <option value="7">浦江镇</option>\n' +
                        '        <option value="8">梅陇镇</option>\n' +
                        '        <option value="9">虹桥镇</option>\n' +
                        '        <option value="10">马桥镇</option>\n' +
                        '        <option value="11">吴泾镇</option>\n' +
                        '        <option value="12">华漕镇</option>\n' +
                        '        <option value="13">颛桥镇</option>\n' +
                        '        <option value="14">莘庄工业区</option>\n' +
                        '        <option value="15">外区街镇 </option>\n' +
                        '      </select></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">在沪居住地址</span></div>\n' +
                        ' <div class="item2"><input type="text" name="livePlace" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty bitian jinyong" fieldname="在沪居住地址" placeholder="本区填写小区名+详细地址，外区填写所在地+街镇+小区名+详细地址"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">个人健康状态</span></div>\n' +
                        ' <div class="item2">\n' +
                        '<select name="healthStatus"  lay-filter="healthStatus"  fieldname="个人健康状态" lay-verify="required" class="requiredempty selectbixuan jinyong">\n' +
                        '          <option value="1" selected>正常</option>\n' +
                        '          <option value="2">异常</option>\n' +
                        '          <option value="3">疑似</option>\n' +
                        '          <option value="4">确诊</option>\n' +
                        '          <option value="5">密切接触未过隔离期</option>\n' +
                        '        </select>\n' +
                        ' </div>\n'+
                        ' </div>\n'+
                        //确诊和疑似开始
                        '<div class="suspect" style="display:none">\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“疑似病例”确认日期</span></div>\n' +
                        ' <div class="item2"><input name="ebIllTime"  type="text" class="layui-input jinyong" id="test5"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“疑似病例”就诊医院</span></div>\n' +
                        ' <div class="item2"><input type="text" name="diagnosis" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“疑似病例”解除日期</span></div>\n' +
                        ' <div class="item2"><input name="cureTime"  type="text" class="layui-input jinyong" id="test6"></div>\n' +
                        ' </div>'+
                        '</div>\n'+
                        //确诊和疑似结束
                        '<div class="quezhen" style="display:none">\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“确诊病例”确认日期</span></div>\n' +
                        ' <div class="item2"><input name="conEbIllTime"  type="text" class="layui-input requiredempty jinyong" id="test8"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“确诊病例”就诊医院</span></div>\n' +
                        ' <div class="item2"><input name="conDiagnosis"  type="text" class="layui-input requiredempty jinyong"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">“确诊病例”出院日期</span></div>\n' +
                        ' <div class="item2"><input name="conCureTime"  type="text" class="layui-input requiredempty jinyong" id="test10"></div>\n' +
                        ' </div>'+
                        '</div>\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">是否注册健康云每日体温监测</span></div>\n' +
                        ' <div class="item2 radio" fieldName="是否注册健康云每日体温监测">' +
                        '<div><input  type="radio" class="jinyong"  name="temperatureYn"  lay-filter="temperatureYn"  value="1" title="是" checked></div>'+
                        '<div><input  type="radio" class="jinyong" name="temperatureYn"  lay-filter="temperatureYn" value="0" title="否"></div>'+
                        '</div> '+
                        ' </div>\n'+
                        ' <div class="itemTotal geli">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">隔离情况</span></div>\n' +
                        ' <div class="item2">\n' +
                        '<select name="isolation" lay-verify="required" class="jinyong"  lay-filter="isolation" id="selector">\n' +
                        '          <option>请选择</option>\n' +
                        '          <option value="1" >集中隔离</option>\n' +
                        '          <option value="2">居家隔离</option>\n' +
                        '          <option value="3" selected>健康观察</option>\n' +
                        '          <option value="4">解除隔离</option>\n' +
                        '          <option value="5">未隔离</option>\n' +
                        '        </select>\n' +
                        ' </div>\n'+
                        ' </div>\n'+
                        //隔离情况开始
                        '<div class="isolationes" style="display:none">\n'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">隔离日期</span></div>\n' +
                        ' <div class="item2"><input name="isolationTime"  type="text" class="layui-input jinyong" id="test3"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">隔离地点</span></div>\n' +
                        ' <div class="item2"><input type="text" name="isolationPlace" required  lay-verify="required"   autocomplete="off" class="layui-input jinyong"></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">解除隔离的日期</span></div>\n' +
                        ' <div class="item2"><input name="remIsolationTime"  type="text" class="layui-input jinyong" id="test4"></div>\n' +
                        ' </div>'+
                        ' </div>'+
                        //    隔离情况结束
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">病例基本情况</span></div>\n' +
                        // ' <div class="item2"><input type="text" name="ebIllDesc" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty"></div>\n' +
                        ' <div class="item2"> <textarea name="ebIllDesc"  class="layui-textarea textbase jinyong"></textarea></div>\n' +
                        ' </div>'+
                        ' <div class="itemTotal">\n' +
                        ' <div class="item1"><span class="num"></span><span class="fieldName">备注</span></div>\n' +
                        ' <div class="item2"><textarea name="remark"  class="layui-textarea requiredempty jinyong"></textarea></div>\n' +
                        ' </div>'+
                        // '<div class="layui-form-item">\n'+
                        // ' <div class="inbox" style="margin-bottom:10px">\n'+
                        // ' <div class="item1"><span class="num"></span><span class="fieldName">附件上传</span></div>\n' +
                        // '<div class="layui-input-block" id="fieldInfo" style="margin-left: 48px;margin-top: 15px">\n'+
                        // '<button type="button" class="layui-btn" id="but_chose">\n'+
                        // '<i class="layui-icon">&#xe67c;</i>上传附件\n'+
                        // ' </button>\n'+
                        // '<div id="attachmentName">\n'+
                        //
                        // '</div>\n'+
                        // '</div>\n'+
                        // '</div>\n'+
                        // '</div>\n'+
                        // '<div class="buttonbottom">\n'+
                        // '<button id="add-file-submit" class="layui-btn layui-btn-sm"lay-submit lay-filter="formDemo" style="display: none"></button>\n'+
                        // ' </div>\n'+
                        '</form>',
                    success:function(){
                        if(type==0){
                            $.ajax({
                                url:'/HealthyInfo/getSchool',
                                dataType:'json',
                                type:'get',
                                success:function(res){
                                    $('input[name="organNum"]').val(res.object.SCHOOL_NO.substr(res.object.SCHOOL_NO.length-4))
                                    $('input[name="schoolName"]').val(res.object.SCHOOL_NAME)
                                }
                            })
                        }else {
                            $.ajax({
                                url:'/HealthyInfo/findHealthyInfoById',   //编辑页面根据id页面回显的接口
                                type:'get',
                                data:{healId:healId},
                                dataType:'json',
                                success:function(res){
                                    var data=res.object.membersList
                                    form.val("formsTest", res.object);
                                    if($('select[name="healthStatus"]').val()==3){
                                        $('.suspect').show()
                                        $('.geli').hide()
                                    }else if($('select[name="healthStatus"]').val()==4){
                                        $('.quezhen').show()
                                        $('.geli').hide()
                                    }else if($('select[name="healthStatus"]').val()==5){
                                        $('.isolationes').show()
                                    }

                                    if(res.object.isolation =="1" ||res.object.isolation =="4"){
                                        $('.isolationes').show()
                                    }else{
                                        $('.isolationes').hide()
                                    }

                                    // var str=''
                                    // for(var i=0;i<data.length;i++){
                                    //     str+='<div class="homeTotal"><div class="item1"><span class="nums">1</span><span class="fieldName">成员关系</span></div>' +
                                    //         ' <div class="item2 radio1">' +
                                    //         function () {
                                    //             if(data[i].memdType==1){
                                    //                 return   '<div><input class="memdType" type="radio" name="'+i+100+'"  value="1" title="家人" checked></div>' +
                                    //                     '<div><input class="memdType" type="radio"  name="'+i+100+'" value="2" title="室友"></div>' +
                                    //                     '<div><input class="memdType" type="radio" name="'+i+100+'"  value="3" title="同事"></div>'
                                    //             }else if(data[i].memdType==2){
                                    //                 return   '<div><input class="memdType" type="radio" name="'+i+100+'"  value="1" title="家人" ></div>' +
                                    //                     '<div><input class="memdType" type="radio"  name="'+i+100+'" value="2" title="室友" checked></div>' +
                                    //                     '<div><input class="memdType" type="radio" name="'+i+100+'"  value="3" title="同事"></div>'
                                    //             }else if(data[i].memdType==3){
                                    //                 return   '<div><input class="memdType" type="radio" name="'+i+100+'"  value="1" title="家人" ></div>' +
                                    //                     '<div><input class="memdType" type="radio"  name="'+i+100+'" value="2" title="室友" ></div>' +
                                    //                     '<div><input class="memdType" type="radio" name="'+i+100+'"  value="3" title="同事" checked></div>'
                                    //             }
                                    //         }()+
                                    //         '</div>' +
                                    //         '<div class="itemTotal">' +
                                    //         '<div class="item1"><span class="nums">2</span><span class="fieldName">姓名</span></div>' +
                                    //         '<div class="item2"><input memdId="'+data[i].memdId+'" value="'+data[i].memdName+'" type="text" required  lay-verify="required"   autocomplete="off" class="layui-input  usernames home"></div>' +
                                    //         '</div>' +
                                    //         '<div class="itemTotal">' +
                                    //         '<div class="item1"><span class="nums">3</span><span class="fieldName">性别</span></div>' +
                                    //         '<div class="item2 radio2">' +
                                    //         function () {
                                    //             if(data[i].sex==0){
                                    //                 return  '<div><input  type="radio" name="'+i+1000+'"  value="1" title="男" class="sex"></div>' +
                                    //                     '<div><input  type="radio" name="'+i+1000+'"value="0" title="女" class="sex" checked></div>'
                                    //             }else if(data[i].sex==1){
                                    //                 return   '<div><input  type="radio" name="'+i+1000+'"  value="1" title="男" class="sex"></div>' +
                                    //                     '<div><input  type="radio" name="'+i+1000+'"value="0" title="女" class="sex" checked></div>'
                                    //             }
                                    //         }()+
                                    //         '</div>' +
                                    //         '</div>' +
                                    //         '<div class="itemTotal">' +
                                    //         '<div class="item1"><span class="nums">4</span><span class="fieldName">身份证号</span></div>' +
                                    //         '<div class="item2"><input value="'+data[i].identityNo+'" type="text" required  lay-verify="required"   autocomplete="off" class="layui-input identityNo identity home"></div>' +
                                    //         '</div>' +
                                    //         '<div class="itemTotal">' +
                                    //         '<div class="item1"><span class="nums">5</span><span class="fieldName">健康状态</span></div>' +
                                    //         '<div class="item2"><input value="'+data[i].healthStatus+'" type="text" required  lay-verify="required"   autocomplete="off" class="layui-input healthStatus home"></div>' +
                                    //         '</div></div>'
                                    // }
                                    // $("#index-div1").append(str);
                                    //判断中国
                                    if(res.object.nationality == "1"){
                                        var zhongguomo= ' <div class="itemTotal crad" >\n' +
                                            ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">身份证号</span></div>\n' +
                                            ' <div class="item2"><input  type="text" name="identityNo" required  lay-verify="required"  autocomplete="off" class="layui-input  requiredempty bitian bizhon jinyong" fieldname="身份证号" ></div>\n' +
                                            ' </div>'
                                        $('#identityNo').html(zhongguomo)
                                        $('.bizhon').val(res.object.identityNo)

                                    }else{
                                        $('#identityNo').html('')
                                        $('#passportNo').html('')
                                    }
                                    $(function(){
                                        //输入框的值改变时触发
                                        $(".nationality").on("input",function(e){
                                            //获取input输入的值
                                            if(e.delegateTarget.value == "中国"){
                                                $('.passport').hide()
                                                $('.crad').show()
                                            }else if(e.delegateTarget.value == "" ||e.delegateTarget.value == undefined){
                                                $('.crad').hide()
                                                $('.passport').hide()
                                            }else{
                                                $('.crad').hide()
                                                $('.passport').show()
                                            }

                                        });
                                    });
                                    //教职工
                                    if(res.object.identityType =="1"){
                                        if($('#xue').children("div").hasClass('xuexian')){
                                            return false
                                        }
                                        if($('#jiao').children("div").html()!=''){
                                            $('#jiao').children("div").remove()
                                        }
                                        var xx=' <div class="xuexian"><div class="itemTotal">\n' +
                                            ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">年级</span></div>\n' +
                                            ' <div class="item2">\n' +
                                            '<select name="stuGrade" lay-verify="required" lay-search="" fieldname="年级" class="requiredempty selectbixuan sele jinyong">\n' +
                                            '          <option value="">请选择</option>\n' +
                                            '          <option value="1">托育0-3</option>\n' +
                                            '          <option value="2">幼儿园托班</option>\n' +
                                            '          <option value="3">小班</option>\n' +
                                            '          <option value="4">中班</option>\n' +
                                            '          <option value="5">大班</option>\n' +
                                            '          <option value="6">一年级</option>\n' +
                                            '          <option value="7">二年级</option>\n' +
                                            '          <option value="8">三年级</option>\n' +
                                            '          <option value="9">四年级</option>\n' +
                                            '          <option value="10">五年级</option>\n' +
                                            '          <option value="11">六年级</option>\n' +
                                            '          <option value="12">七年级</option>\n' +
                                            '          <option value="13">八年</option>\n' +
                                            '          <option value="14">九年</option>\n' +
                                            '          <option value="15">十年级</option>\n' +
                                            '          <option value="16">十一年级</option>\n' +
                                            '          <option value="17">十二年级</option>\n' +
                                            '          <option value="18">中职校一年级</option>\n' +
                                            '          <option value="19">中职校二年级</option>\n' +
                                            '          <option value="20">中职校三年级</option>\n' +
                                            '          <option value="21">中职校四年级</option>\n' +
                                            '          <option value="22">成教中心社区学校老年大学</option>\n' +
                                            '          <option value="23">全日制培训机构</option>\n' +
                                            '        </select>\n' +
                                            ' </div>'+
                                            ' </div>'+
                                            ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">班级</span></div>\n' +
                                            ' <div class="item2"><input type="text" name="stuClass" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty bitian classban jinyong" fieldname="班级"></div>\n' +
                                            ' </div></div>'
                                        $('#xue').html(xx)
                                        $('.classban').val(res.object.stuClass)
                                        $('.sele').val(res.object.stuGrade)
                                        form.render()
                                    }else{
                                        if($('#jiao').children("div").hasClass('jiaoxian')){
                                            return false
                                        }
                                        if($('#xue').children("div").html()!=''){
                                            $('#xue').children("div").remove()
                                        }
                                        var jj=' <div class="jiaoxian"><div class="itemTotal">\n' +
                                            ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">教师职务</span></div>\n' +
                                            ' <div class="item2">\n' +
                                            '<select name="teaPost" lay-verify="required" lay-search="" fieldname="教师职务" class="requiredempty selectbixuan jiaosele jinyong" >\n' +
                                            '          <option value="">请选择</option>\n' +
                                            '          <option value="1">校级领导</option>\n' +
                                            '          <option value="2">中层干部</option>\n' +
                                            '          <option value="3">教师</option>\n' +
                                            '          <option value="4">外聘教师</option>\n' +
                                            '          <option value="5">教辅人员</option>\n' +
                                            '          <option value="6">施工人员</option>\n' +
                                            '        </select>\n' +
                                            ' </div>\n'+
                                            ' </div></div>\n'
                                        $('#jiao').html(jj)
                                        $('.jiaosele').val(res.object.teaPost)
                                        form.render()
                                    }
                                    if(res.object.healthStatus== "3"){
                                        $('.suspect').show()
                                        $('.quezhen').hide()
                                    }else if(res.object.healthStatus == '4'){
                                        $('.suspect').hide()
                                        $('.quezhen').show()
                                    }else{
                                        $('.suspect').hide()
                                        $('.quezhen').hide()
                                    }
                                    form.render()
                                    if(type=='2'){
                                        for(var i=0;i<$('.jinyong').length;i++){
                                            $('.jinyong').eq(i).attr('disabled',true)
                                            form.render()
                                        }
                                    }
                                }
                            })
                        }
                        if(type=='2'){
                            $('.layui-layer-btn').hide()
                            for(var i=0;i<$('.jinyong').length;i++){
                                $('.jinyong').eq(i).attr('disabled',true)
                                form.render()
                            }
                        }
                        if($(window).width()<768){
                            $('.layui-layer').width('90%')
                            $('.layui-layer').css('left','20px')
                        }else if($(window).width()>=768&&$(window).width()<=992){
                            $('.layui-layer').width('80%')
                        }else if($(window).width()>=992&&$(window).width()<=1200){
                            $('.layui-layer').width('70%')
                        }else if($(window).width()>=1200){
                            $('.layui-layer').width('60%')
                            $('.layui-layer').css('left','250px')
                        }
                        //判断学生和教职员工
                        form.on('radio(identityType)', function(data){
                            var identityType = data.value
                            if(identityType == '1'){
                                if($('#xue').children("div").hasClass('xuexian')){
                                    return false
                                }
                                if($('#jiao').children("div").html()!=''){
                                    $('#jiao').children("div").remove()
                                }
                                var xx=' <div class="xuexian"><div class="itemTotal">\n' +
                                    ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">年级</span></div>\n' +
                                    ' <div class="item2">\n' +
                                    '<select name="stuGrade" lay-verify="required" lay-search="" fieldname="年级" class="requiredempty selectbixuan">\n' +
                                    '          <option value="">请选择</option>\n' +
                                    '          <option value="1">托育0-3</option>\n' +
                                    '          <option value="2">幼儿园托班</option>\n' +
                                    '          <option value="3">小班</option>\n' +
                                    '          <option value="4">中班</option>\n' +
                                    '          <option value="5">大班</option>\n' +
                                    '          <option value="6">一年级</option>\n' +
                                    '          <option value="7">二年级</option>\n' +
                                    '          <option value="8">三年级</option>\n' +
                                    '          <option value="9">四年级</option>\n' +
                                    '          <option value="10">五年级</option>\n' +
                                    '          <option value="11">六年级</option>\n' +
                                    '          <option value="12">七年级</option>\n' +
                                    '          <option value="13">八年级</option>\n' +
                                    '          <option value="14">九年级</option>\n' +
                                    '          <option value="15">十年级</option>\n' +
                                    '          <option value="16">十一年级</option>\n' +
                                    '          <option value="17">十二年级</option>\n' +
                                    '          <option value="18">中职校一年级</option>\n' +
                                    '          <option value="19">中职校二年级</option>\n' +
                                    '          <option value="20">中职校三年级</option>\n' +
                                    '          <option value="21">中职校四年级</option>\n' +
                                    '          <option value="22">成教中心社区学校老年大学</option>\n' +
                                    '          <option value="23">全日制培训机构</option>\n' +
                                    '        </select>\n' +
                                    ' </div>'+
                                    ' </div>'+
                                    ' <div class="itemTotal">\n' +
                                    ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">班级</span></div>\n' +
                                    ' <div class="item2"><input type="text" name="stuClass" required  lay-verify="required"   autocomplete="off" class="layui-input requiredempty bitian" fieldname="班级"></div>\n' +
                                    ' </div></div>'
                                $('#xue').html(xx)
                                form.render()
                                // $('#xue').show()
                                // $('.faculty').hide()
                            }else{
                                if($('#jiao').children("div").hasClass('jiaoxian')){
                                    return false
                                }
                                if($('#xue').children("div").html()!=''){
                                    $('#xue').children("div").remove()
                                }
                                var jj=' <div class="jiaoxian"><div class="itemTotal">\n' +
                                    ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">教师职务</span></div>\n' +
                                    ' <div class="item2">\n' +
                                    '<select name="teaPost" lay-verify="required" lay-search="" fieldname="教师职务" class="requiredempty selectbixuan">\n' +
                                    '          <option value="">请选择</option>\n' +
                                    '          <option value="1">校级领导</option>\n' +
                                    '          <option value="2">中层干部</option>\n' +
                                    '          <option value="3">教师</option>\n' +
                                    '          <option value="4">外聘教师</option>\n' +
                                    '          <option value="5">教辅人员</option>\n' +
                                    '          <option value="6">施工人员</option>\n' +
                                    '        </select>\n' +
                                    ' </div>\n'+
                                    ' </div></div>\n'
                                $('#jiao').html(jj)
                                form.render()
                                // $('#xue').hide()
                                // $('.faculty').show()
                                // var strs = ""
                                // $('#xue').remove()
                            }
                        });

                        //判断国籍
                        form.on('select(nationality)', function (data) {
                            var nationality = data.value
                            if(nationality == '1'){
                                var zhongguomo= ' <div class="itemTotal crad" >\n' +
                                    ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">身份证号</span></div>\n' +
                                    ' <div class="item2"><input  type="text" name="identityNo" required  lay-verify="required"  autocomplete="off" class="layui-input  requiredempty bitian" fieldname="身份证号" ></div>\n' +
                                    ' </div>'
                                $('#identityNo').html(zhongguomo)
                            }else{
                                $('#identityNo').html('')
                            }
                        });
                        //监听本人健康状况
                        form.on('select(healthStatus)', function (data) {
                            var healthStatus = data.value
                            if(healthStatus == '1'){
                                $('select[name="isolation"]').val('3')
                                $('.quezhen').hide()
                                $('.suspect').hide()
                                $('.geli').show()
                                $('.isolationes').hide()
                                form.render()
                            }else if(healthStatus == '2'){
                                $('select[name="isolation"]').val('3')
                                $('.geli').show()
                                $('.quezhen').hide()
                                $('.suspect').hide()
                                $('.isolationes').hide()
                                form.render()
                            }else if(healthStatus == '3'){
                                $('.suspect').show()
                                $('.quezhen').hide()
                                $('.geli').hide()
                                $('.isolationes').hide()
                            }else if(healthStatus == '4'){
                                $('.suspect').hide()
                                $('.quezhen').show()
                                $('.geli').hide()
                                $('.isolationes').hide()
                            }else if(healthStatus == '5'){
                                // $("#selector option[value='1']").prop("selected", true);
                                $('.quezhen').hide()
                                $('.geli').show()
                                $('select[name="isolation"]').val('1')
                                form.render()
                                $('.suspect').hide()
                                $('.isolationes').hide()
                                $('.isolationes').show()
                            }
                        });
                        //隔离情况
                        form.on('select(isolation)', function (data) {
                            var isolation = data.value
                            if(isolation == '1' || isolation == '4'){
                                $('.isolationes').show()
                            }else{
                                $('.isolationes').hide()
                            }
                        });
                        if($('.nationality').val('中国')){
                            var zhongguomo= ' <div class="itemTotal crad" >\n' +
                                ' <div class="item1"><span style="color: red;">*</span><span class="num"></span><span class="fieldName">身份证号</span></div>\n' +
                                ' <div class="item2"><input   type="text" name="identityNo" required  lay-verify="required"  autocomplete="off" class="layui-input  requiredempty bitian" fieldname="身份证号" ></div>\n' +
                                ' </div>'
                            $('#identityNo').html(zhongguomo)
                        }

                        var num=0
                        var num1=100
                        // $('.familyadd').click(function(){
                        //     var html = ""
                        //     num++
                        //     num1++
                        //     //第一个
                        //     html += "<div class='homeTotal'><div class=\"item1\"><span class=\"nums\">1</span><span class=\"fieldName\">成员关系</span></div>"
                        //     html += " <div class=\"item2 radio1\">"
                        //     html += "<div><input class=\"memdType\" type=\"radio\" name='"+num+"'   value=\"1\" title=\"家人\"></div>"
                        //     html += "<div><input class=\"memdType\" type=\"radio\"  name='"+num+"'value=\"2\" title=\"室友\"></div>"
                        //     html += "<div><input class=\"memdType\" type=\"radio\" name='"+num+"'  value=\"3\" title=\"同事\"></div>"
                        //     html+="</div>"
                        //     //第二个姓名
                        //     html +="<div class=\"itemTotal\">"
                        //     html +="<div class=\"item1\"><span class=\"nums\">2</span><span class=\"fieldName\">姓名</span></div>"
                        //     html +="<div class=\"item2\"><input type=\"text\" required  lay-verify=\"required\"   autocomplete=\"off\" class=\"layui-input  usernames home\"></div>"
                        //     html +="</div>"
                        //     // 性别
                        //     html += "<div class=\"itemTotal\">"
                        //     html +="<div class=\"item1\"><span class=\"nums\">3</span><span class=\"fieldName\">性别</span></div>"
                        //     html +="<div class=\"item2 radio2\">"
                        //     html += "<div><input  type=\"radio\" name='"+num1+"'  value=\"1\" title=\"男\" class=\"sex\"></div>"
                        //     html += "<div><input  type=\"radio\" name='"+num1+"'value=\"0\" title=\"女\" class=\"sex\"></div>"
                        //     html += "</div>"
                        //     html += "</div>"
                        //     //身份证号
                        //     html += "<div class=\"itemTotal\">"
                        //     html += "<div class=\"item1\"><span class=\"nums\">4</span><span class=\"fieldName\">身份证号</span></div>"
                        //     html += "<div class=\"item2\"><input type=\"text\" required  lay-verify=\"required\"   autocomplete=\"off\" class=\"layui-input identityNo home\"></div>"
                        //     html += "</div>"
                        //     //健康状态
                        //     html += "<div class=\"itemTotal\">"
                        //     html += "<div class=\"item1\"><span class=\"nums\">5</span><span class=\"fieldName\">健康状态</span></div>"
                        //     html += "<div class=\"item2\"><input type=\"text\" required  lay-verify=\"required\"   autocomplete=\"off\" class=\"layui-input healthStatus home\"></div>"
                        //     html += "</div></div>"
                        //     $("#index-div1").append(html);
                        //     form.render()
                        //
                        // })
                        form.render()
                        //执行一个laydate实例
                        laydate.render({
                            elem: '#test1' //指定元素
                        });
                        laydate.render({
                            elem: '#test2' //指定元素
                        });
                        laydate.render({
                            elem: '#test3' //指定元素
                        });
                        laydate.render({
                            elem: '#test4' //指定元素
                        });
                        laydate.render({
                            elem: '#test5' //指定元素
                        });
                        laydate.render({
                            elem: '#test6' //指定元素
                        });
                        laydate.render({
                            elem: '#test7' //指定元素
                        });
                        laydate.render({
                            elem: '#test8' //指定元素
                        });
                        laydate.render({
                            elem: '#test9' //指定元素
                        });
                        laydate.render({
                            elem: '#test10' //指定元素
                        });
                        //上传图片
                        fieldLength = $(".fieldHover").length;
                        var uploadInst = upload.render({
                            elem: '#but_chose' //绑定元素
                            , url: '../upload?module=dataReport'
                            , accept: 'file'  //文件格式
                            , auto: true
                            , bindAction: '#uploadButton'
                            , multiple: false
                            , choose: function (obj) {   //选择文件的回调函数
                                obj.preview(function (index, file) {
                                    // if(fieldLength==0){
                                    //     fieldLength=1
                                    // }
                                    var i ="'attachId"+fieldLength+"'";
                                    //$('#fileName').val(file.name);//显示文件名
                                    var ht = "<div style='width: 240px;border-bottom: 1px solid darkgray;' class='layui-icon layui-icon-link fieldHover attachId"+fieldLength+"'><input type='hidden'  id='attachId"+fieldLength+"'> <label id='attachName"+fieldLength+"'></label> <a href="+'javascript:delFeled('+i+')'+" class='layui-icon-close' style='cursor: pointer;float:right;'></a></div>";
                                    $("#fieldInfo").append(ht)

                                    $('#attachName'+fieldLength).html(file.name);//显示文件名
                                });
                            }
                            , done: function (res) {
                                var attid = res.obj[0].attachId
                                var aid =res.obj[0].aid
                                var ym =res.obj[0].ym
                                var arr = aid+"@"+ym+"_"+attid
                                attachids.push(arr)
                                ids =attachids.toString()   //定义得id上传附件得串
                                var names =res.obj[0].attachName
                                attachName.push(names)
                                attname = attachName.toString()//定义得姓名d上传附件得串
                                $("#attachId"+fieldLength).val(getAttachIds(res.obj[0]))
                                ++fieldLength;
                            }
                        });
                    },
                    yes:function (index) {
                        //判断单行输入框必填
                        for(var i=0;i<$('.bitian').length;i++){
                            if($('.bitian').eq(i).val()==''){
                                layer.msg($('.bitian').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                return false
                            }
                        }
                        //判断单选是否没选
                        for (var i=0;i<$('.radio ').length;i++) {
                            if(!$('.radio').eq(i).find('div').hasClass('layui-form-radioed')){
                                layer.msg($('.radio').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                return false
                            }
                        }
                        //判断下拉框是否没选
                        for(var i=0;i<$('.selectbixuan').length;i++){
                            if($('.selectbixuan').eq(i).val()==''){
                                layer.msg($('.selectbixuan').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                return false
                            }
                        }

                        if($('select[name="nationality"]').val()==1){
                            var identityNo = $.trim($('input[name="identityNo"]').val())
                            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
                            if(reg.test(identityNo) === false){
                                layer.msg("身份证输入不合法");
                                return false
                            }
                        }

                        for(var i=0;i<fieldLength;i++){
                            if($("#attachId"+i).val()!=''&&$("#attachId"+i).val()!=undefined&&$("#attachName"+i).text()!=''&&$("#attachName"+i).text()!=undefined){
                                attachId+= $("#attachId"+i).val()+","
                                attachName+=$("#attachName"+i).text()+","
                            }else{
                                continue;
                            }

                        }
                        for(var r=0;r<$('.radio1 input').length;r++){
                            if($('.radio1 input').eq(r).next().hasClass('layui-form-radioed')){
                                $('.radio1 input').eq(r).addClass('home')
                            }
                        }
                        for(var r=0;r<$('.radio2 input').length;r++){
                            if($('.radio2 input').eq(r).next().hasClass('layui-form-radioed')){
                                $('.radio2 input').eq(r).addClass('home')
                            }
                        }
                        var membersList=[]
                        var dd=$('.homeTotal')
                        for(var i=0;i<dd.length;i++){
                            var obj={}
                            if(type==0){
                                obj.memdType=dd.eq(i).find('.home').eq(0).val()
                                obj.memdName=dd.eq(i).find('.home').eq(1).val()
                                obj.sex=dd.eq(i).find('.home').eq(2).val()
                                obj.identityNo=dd.eq(i).find('.home').eq(3).val()
                                obj.healthStatus=dd.eq(i).find('.home').eq(4).val()
                            }else{
                                obj.memdType=dd.eq(i).find('.home').eq(0).val()
                                obj.memdName=dd.eq(i).find('.home').eq(1).val()
                                obj.sex=dd.eq(i).find('.home').eq(2).val()
                                obj.identityNo=dd.eq(i).find('.home').eq(3).val()
                                obj.healthStatus=dd.eq(i).find('.home').eq(4).val()
                                obj.memdId=dd.eq(i).find('.home').eq(1).attr('memdId')
                            }

                            membersList.push(obj)
                        }

                        var datas = {};
                        var t = $('#ajaxforms').serializeArray();
                        $.each(t, function() {
                            datas [this.name] = this.value;
                        });
                        datas.membersList = membersList;

                        var phone = $('.phone').val()
                        if(!(/^1\d{10}$/.test(phone))){
                            layer.msg("手机号码有误，请重填");
                            $(".phone").val("");
                            return false
                        }

                        if(type==1){
                            datas.healId=healId
                        }
                        if(type==0){
                            $.ajax({
                                url:url,
                                contentType: 'application/json;charset=utf-8',
                                data:JSON.stringify(datas),
                                dataType:'json',
                                type:'post',
                                success:function(res){
                                    if(res.flag){
                                        layer.msg('新增成功！',{icon:1});
                                        layer.close(index)
                                        tableIns.reload()
                                    }
                                }
                            })
                        }else {
                            $.ajax({
                                url:url,
                                contentType: 'application/json;charset=utf-8',
                                data:JSON.stringify(datas),
                                dataType:'json',
                                type:'post',
                                success:function(res){
                                    if(res.flag){
                                        layer.msg('修改成功！',{icon:1});
                                        layer.close(index)
                                        tableIns.reload()
                                    }
                                }
                            })
                        }

                    }
                })
            }
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