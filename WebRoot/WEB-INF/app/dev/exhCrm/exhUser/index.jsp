<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>客户数据管理</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <style>
        html,body{
            background: rgb(245,245,245);
        }
        .header {
            margin-top: 15px;
            height: 78px;
            margin: 20px;
        }

        .header .title {
            margin-left: 10px;
        }
        .header span {
            float: none;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }

        .openFile input[type=file] {
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

        #ajaxforms .layui-form-item .layui-inline {
            margin-bottom: -5px !important;
        }

        .addExecute {
            display: inline-block;
            margin-top: 10px;
        }

        .adduser {
            display: inline-block;
            margin-top: 37px;
        }

        #ajaxforms .layui-form-label {
            width: 107px;
        }

        .layui-btn + .layui-btn {
            margin-left: 6px;
        }
        .layui-table td, .layui-table th {
            text-align: center;
        }
        .layui-form-label {
            float: left;
            display: block;
            padding: 9px 0px;
            font-weight: 400;
            line-height: 20px;
            text-align: right;
            padding-right: 10px;
        }
        .container .layui-row {
            height: 50px;
            line-height: 50px;
            margin-left: 30px;
        }
        .layui-form-label {
            text-align: left;
            padding-right: 0px;
        }
        .layui-table-page {
            text-align: right !important;
        }
        td,th {
            line-height: 38px;
        }
        .layui-table-cell {
            line-height: 38px;
        }
        .layui-form-select .layui-input {
            padding-right: 0px;
        }
        .layui-form-item {
            width: 65%;
            margin-left: 6%;
        }
        img[src=""],img:not([src]){
            opacity:0;
        }
        #importBox .layui-form-item{
            width: 75%;
        }
        .layui-input-inline {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="title">
        <img src="/img/mycount.png"><span style="font-size: 22px;">客户数据管理</span>
        <hr style="background-color: black"/>
    </div>
    <div style="margin: 20px 10px">
        <form class="layui-form" action="">
            <div class="queryBox layui-row" style="padding: 2px 0 9px 0px;">
                <%--                &lt;%&ndash;            下拉选择框&ndash;%&gt;--%>
                <div class="layui-inline">
                    <label class="layui-form-label">客户编号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="exhUserCode" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="exhUserName" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <%--    输入框--%>
                <div class="layui-inline">
                    <label class="layui-form-label" style="">手机号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="mobile" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <button type="button" class="layui-btn search" style="margin-left: 10px;">查询</button>
                <button type="button" class="layui-btn export" id="export">导出</button>
                <button type="button" class="layui-btn export" id="import">导入</button>
                <button type="button" class="layui-btn layui-btn-normal add" id="add">新增</button>
            </div>
            <div class="queryBox layui-row" style="">
                <div class="layui-inline">
                    <label class="layui-form-label" style="">身份证号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="cardId" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="">邮箱</label>
                    <div class="layui-input-inline">
                        <input type="text" name="email" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <%--    表格--%>
    <div class="tab" style="margin: auto 10px">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
</div>
<script>
    var flags=false;
    layui.use(['form','table','layer','laydate','upload'],function() {
        const form = layui.form;
        const table = layui.table;
        const layer = layui.layer;
        const laydate = layui.laydate;
        const upload = layui.upload;
        laydate.render({
            elem:"#startTime",
            type:"date",
            trigger:"click"
        })
        laydate.render({
            elem:"#endTime",
            type:"date",
            trigger:"click"
        })
        const dataTable = table.render({
            elem:"#test",
            url:"/exhUser/select",
            page:true,
            limit: 20,
            limits:[20,30,40,50],
            parseData:function(res) {
                return {
                    "code": res.flag?0:400,
                    "msg": res.msg,
                    "count": res.totleNum,
                    "data": res.obj
                }
            },
            where: {
                useFlag:true,
                Export:false
            },
            request:{
                pageName:'page',
                limitName:'pageSize'
            },
            cols:[[
                {field:"exhUserCode",title:'客户编号'},
                {field:"exhUserName",title:'姓名'},
                {field:"gender",title:'性别'},
                {field:"cardId",title:'身份证号'},
                // {field:"nickName",title:'昵称'},
                {field:"province",title:'省份'},
                {field:"titles",title:'职称'},
                {field:"registDate",title:'注册日期'},
                {field:"from",title:'来源'},
                {field:"remark",title:'备注'},
                {field:"creatorname",width:95,title:'创建人'},
                {field:"createTime",width:115,title:'创建时间'},
                {title:'操作',width:235,templet:function(d) {
                        return '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="addUserMsg">添加客户信息</button><button class="layui-btn layui-btn-xs" lay-event="detail">详情</button><button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</button><button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</button>'
                    }},
            ]]
        });
        //表格按钮点击事件
        table.on('tool(test)',function(obj) {
            var data = obj.data;
            var exhUserId = data.exhUserId;
            if(obj.event == 'addUserMsg') {
                layer.open({
                    type: 1,
                    title: '添加客户信息',
                    btn:['确定','取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['60%', '80%'],
                    content:'<form class="layui-form" id="ajaxforms" lay-filter="formsTest">' +
                        '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">昵称<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="nickName" required  lay-verify="required" placeholder="请输入昵称" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">住址<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="address" required  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">单位<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="unit" id="unit" required  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">职务<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="job" id="job" required  lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item" style="margin-top: 15px;">\n' +
                        '    <label class="layui-form-label">手机号<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="mobile" required  lay-verify="required|phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">电子邮箱<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="email" required lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">座机<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="phone" required lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">微信账号<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="openId" required lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label" style="width: 90px;padding: 5px;">支付宝账号<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="alipayId" required lay-verify="required" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '<div class="layui-form-item">\n' +
                        '    <label class="layui-form-label">上传照片:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="file" id="file" name="file" style="cursor:pointer;size=1" hideFocus="" title="">\n'+
                                '                                <div id="img" name="img" style="">\n' +
                            '                                    <img class="uploads" src="" style="width: 100px;margin-top: 10px;"/>\n' +
                            '                                </div>'+
                        '    </div>\n' +
                        '  </div>'+
                        '</form>',
                    success:function(){
                        form.render();
                        photoChange();
                        form.render()
                    },
                    yes:function (index) {
                        var mobile = $('#ajaxforms input[name="mobile"]').val()
                        var reg =/^[0-9]*$/; //数字
                        if(!reg.test(mobile)){
                            layer.msg('手机号只能输入数字',{time:1000,icon:2})
                            return false;
                        }
                        if( $('#ajaxforms input[name="nickName"]').val()==''){
                            layer.msg('请填写昵称', {icon: 2});
                        }else if($('#ajaxforms input[name="address"]').val()==''){
                            layer.msg('请填写住址', {icon: 2});
                        }else if($('#ajaxforms #mobile').val() == ""){
                            layer.msg('请填写手机号', {icon: 2});
                        }else if($('#ajaxforms input[name="email"]').val() == ""){
                            layer.msg('请填写电子邮箱', {icon: 2});
                        }else if($('#ajaxforms #unit').val() == ""){
                            layer.msg('请填写单位', {icon: 2});
                        }else if($('#ajaxforms #job').val() == ""){
                            layer.msg('请填写职务', {icon: 2});
                        }else if($('#ajaxforms #phone').val() == ""){
                            layer.msg('请填写座机', {icon: 2});
                        }else if($('#ajaxforms #openId').val() == ""){
                            layer.msg('请填写微信账号', {icon: 2});
                        }else if($('#ajaxforms #alipayId').val() == ""){
                            layer.msg('请填写支付宝账号', {icon: 2});
                        }else{
                            var formData = new FormData($('#ajaxforms')[0])
                            formData.append('exhUserId', exhUserId);
                            var imgSrc = $("#img img").attr("src")
                            if(!imgSrc){
                                formData.delete('file');
                            }
                            $.ajax({
                                url:'/exhUserAttribute/insert',
                                type: "post",
                                dataType: "json",
                                data:formData,
                                async: false,
                                processData: false,
                                contentType : false,
                                success:function (res) {
                                    if(res.flag){
                                        layer.msg('新建成功',{icon:1});
                                        layer.close(index);
                                    }else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                }
                            })
                        }
                    }
                })
            }else if(obj.event=='detail') {
                layer.open({
                    type:2,
                    title:'详情',
                    area:['100%','100%'],
                    content: '/exhUser/exhUserDetail?code=1&type=1&exhUserId='+exhUserId,
                    end:function() {
                        dataTable.reload();
                    }
                })
            }else if(obj.event == 'edit') {
                layer.open({
                    type:2,
                    title:'编辑',
                    area:['100%','100%'],
                    content: '/exhUser/exhUserDetail?code=2&exhUserId='+exhUserId,
                    end:function() {
                        dataTable.reload();
                    }
                })
            }else if(obj.event=='del') {
                layer.confirm('确定删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/exhUser/delete",
                        data:{
                            exhUserId:exhUserId
                        },
                        success:function(res) {
                            if(res.flag) {
                                layer.msg('删除成功',{icon:1},function() {
                                    dataTable.reload();
                                })
                            }
                        }
                    })
                })

            }
        })
        //    新建按钮点击
        $('#add').click(function() {
            layer.open({
                type: 1
                ,shade: 0.5
                ,maxmin: true
                ,title: ['新建客户', 'font-size:18px;']
                ,area: ['60%', '80%']
                ,content:'<form class="layui-form" id="form1">\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">姓名<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="exhUserName"  placeholder="请输入客户姓名" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '                <label class="layui-form-label" style="width: 90px;padding: 5px;">性别<span style="color:red;">*</span></label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="radio" name="gender" value="男" title="男" checked="" lay-filter="radiofilter">\n' +
                    '                    <input type="radio" name="gender" value="女" title="女" lay-filter="radiofilter">\n' +
                    '                </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">身份证号<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="cardId"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">注册地址<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="province"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">职称<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input  type="text" name="titles"  placeholder="" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">注册日期<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input type="text" id="registDate" name="registDate" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">是否禁用<span style="color:red;">*</span></label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <select id="enable" title="是否禁用" name="enable" lay-verify="">' +
                    '                   <option value="">请选择</option>' +
                    '                   <option value="1">是</option>' +
                    '                   <option value="0">否</option>' +
                    '</select>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 15px;">\n' +
                    '            <label class="layui-form-label" style="width: 90px;padding: 5px;">备注</label>\n' +
                    '            <div class="layui-input-block">\n' +
                    '                <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form>'
                ,btn: ['确定','取消']
                ,success:function(){
                    form.render();
                    //渲染时间选择框
                    laydate.render({
                        elem:"#registDate",
                        type:"date",
                        value:new Date(),
                        format:"yyyy-MM-dd",
                        // trigger:"click"
                    })
                }
                ,yes: function(index){
                    var data = getData();
                    if(data) {
                        $.ajax({
                            type: "post",
                            url: "/exhUser/insert",
                            data: data,
                            async: false,
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('新建成功', {icon: 1})
                                    layer.close(index);
                                    dataTable.reload();
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            },
                            error: function (res) {
                                console.log(res)
                            }
                        });
                    }
                }
            });
        })
        function getData() {
            var exhUserName = $('#form1 input[name=exhUserName]').val();
            if(!exhUserName) {
                layer.msg("客户姓名为必填项",{icon: 2})
                return
            }
            var gender = $('#form1 input[name=gender]:checked').val();
            if(!gender) {
                layer.msg("性别为必选项",{icon: 2})
                return
            }
            var cardId = $('#form1 input[name=cardId]').val();
            if(!cardId) {
                layer.msg("身份证号为必填项",{icon: 2})
                return
            }
            //校验身份证是否重复
            $.ajax({
                url:"/exhUser/selectCount",
                data: {
                    cardId: cardId
                },
                async: false,
                success:function(res) {
                    if(res != 0) {
                        layer.msg('身份证号重复',{icon: 2})
                        return
                    }
                },
                error:function (res) {
                    console.log(res)
                }
            });
            var province = $('#form1 input[name=province]').val();
            if(!province) {
                layer.msg("省份为必填项",{icon:2})
                return
            }
            var titles = $('#form1 input[name=titles]').val();
            if(!titles) {
                layer.msg("职称为必填项",{icon:2})
                return
            }
            var registDate = $('#form1 input[name=registDate]').val();
            if(!registDate) {
                layer.msg("注册日期为必填项",{icon:2})
                return
            }
            var enable = $('#form1 select[name=enable]').val();
            if(enable=='' || enable==undefined) {
                layer.msg("请选择是否禁用",{icon:2})
                return
            }
            var remark = $('#form1 input[name=remark]').val();
            return {
                exhUserName:exhUserName,
                gender:gender,
                cardId:cardId,
                province:province,
                titles:titles,
                registDate:registDate,
                enable:enable,
                remark:remark
            }

        }
        $('#import').on("click",function(){
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title:'导入数据',
                maxmin:true,
                btn: ['确定'], //可以无限个按钮
                content: '<div id="importBox" style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue; cursor: pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls、xlsx格式</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success:function () {
                    // 下载模板
                    $('#load').on('click',function () {
                        window.location.href = encodeURI("/file/exhCrm/客户信息管理导入模板.xls")
                    })
                    //上传
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/exhUser/insertImport' //上传接口
                        ,accept:'file'
                        ,auto:false
                        ,bindAction: '.layui-layer-btn0'
                        // ,data:{tableName:data.dName}
                        ,choose: function(obj){
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function(index, file, result) {
                                console.log(index); //得到文件索引
                                console.log(file); //得到文件对象
                                console.log(result); //得到文件base64编码，比如图片
                                $("#textfilter").text(file.name);
                            });
                            console.log(files);
                        }
                        ,done: function(res){
                            //上传完毕回调
                            if(res.flag) {
                                layer.msg('导入成功',{icon:1})
                                dataTable.reload();
                            }else {
                                layer.msg(res.msg,{icon:2})
                            }
                        }
                        ,error: function(){
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function(index, layero){
                    layer.close(index);
                }
            });
        });
        $('#export').on("click",function(){
            if(flags){
                window.location.href ='/exhUser/select?Export=true&exhUserName='+exhUserName+'&from='+from;
            }else{
                window.location.href ='/exhUser/select?Export=true';
            }
        });
        //    查询事件
        var exhUserCode,exhUserName, mobile,cardId,email
        $('.search').click(function() {
            exhUserCode = $('#queryBox input[name=exhUserCode]').val();
            exhUserName = $('.queryBox input[name=exhUserName]').val();
            mobile = $('.queryBox input[name=mobile]').val();
            cardId = $('.queryBox input[name=cardId]').val();
            email = $('.queryBox input[name=email]').val();
            dataTable.reload({
                url: '/exhUser/select',
                page:true,
                limit: 10,
                limits:[10,20,30,40,50],
                where: {
                    exhUserCode:exhUserCode,
                    exhUserName:exhUserName,
                    mobile:mobile,
                    cardId:cardId,
                    email:email,
                    page: 1,
                    pageSize: 20,
                    useFlag:true,
                    Export:false
                },
                request:{
                    pageName:'page',
                    limitName:'pageSize'
                },
                page: {
                    curr: 1
                },
                done:function(res){    //渲染完成后回调
                    flags = true;
                }
            });
        })
    })
    function photoChange() {
        if (typeof FileReader == 'undefined') {
            $("#photo").on('change',function (event) {
                var src = event.target.value;
                var pathLength = src.length;
                var additionName = src.substring(pathLength - 3, pathLength);
                if (additionName == "jpg" || additionName == "png" || additionName == "gif" || additionName == "JPG" || additionName == "PNG" || additionName == "GIF") {
                    var img = '<img src="' + src + '" style="width:170px;height:175px;" />';
                    $("#img").empty().append(img);
                } else {
                    var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                    $("#img").empty().append(img);
                }
            });
        } else {
            $("#photo").on('change',function (e) {
                for (var i = 0; i < e.target.files.length; i++) {
                    var file = e.target.files.item(i);
                    if (!(/^image\/.*$/i.test(file.type))) {
                        var img = "<font color=red><fmt:message code="adding.th.contav" /></font>";
                        $("#img").empty().append(img);
                        continue;
                    }

                    //实例化FileReader API
                    var freader = new FileReader();
                    freader.readAsDataURL(file);
                    freader.onload = function (e) {
                        var img = '<img src="' + e.target.result + '" style="width:170px;height:175px;"/>';
                        $("#img").empty().append(img);
                    }
                }
            });
        }
    }
</script>
</body>
</html>
