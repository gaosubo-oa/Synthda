<%@ page import="com.xoa.model.alidaas.SysUser" %>
<%@ page import="com.xoa.util.CookiesUtil" %>
<%@ page import="com.xoa.model.users.Users" %>
<%@ page import="com.xoa.util.common.session.SessionUtils" %>
<%@ page import="com.xoa.model.department.Department" %>
<%@ page import="com.xoa.model.department.Department" %>
<%@ page import="com.xoa.service.department.DepartmentService" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
    Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
    String deptName = users.getDeptName();
%>
<html>
<head>
    <title>新建申请</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script src="/js/base/base.js"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: rgb(245,245,245);
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
            box-sizing: border-box;
        }

        .footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff;
        }

        .query_module .layui-input {
            height: 35px;
        }

        .layer_wrap .layui_col {
            width: 20% !important;
            padding: 0 5px;
        }

        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }

        .layui-fluid {
            padding: 0;
        }
        .layui-required:after{
            content:'*';
            color:red;
            position: absolute;
            top: 10px;
            left: 100px;
        }

        .tableInfo td {
            padding: 0;
        }
        .layui-col-md3 {
            width: 23%;
        }
        .layui-col-md9 {
            width: 73%;
        }
        .redTitle {
            color: red;
        }
        .layui-row {
            margin-top: 20px;
        }
        input:focus {
            border: 4px solid red;
        }
        img[src=""],img:not([src]){
            opacity:0;
        }
        .layui-icon {
            margin-right: 10px;
        }
        .labelStyle{
            position: relative;
            left: 6px;
        }
        .selfStyle{
            margin-top: 15px;
            float: left;
        }
        .layui-form-checkbox span{
            height: auto;
        }
        .layui-form-label {
            width: 85px;
            padding: 9px 15px 9px 6px;
        }
        .layui-required:after {
            /*content: '*';*/
            /*color: red;*/
            /*position: absolute;*/
            /*top: 10px;*/
            left: 95px;
        }
    </style>
</head>
<body>
<div class="container">
    <form class="layui-form" id="form1">
        <%--    企业信息模块--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title infoTitle"> <i class="layui-icon layui-icon-down"></i>企业信息</h2>
            <div class="layui-colla-content layui-show baseDiv">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业编号</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" id="companyCode" name="companyCode" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业名称</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="companyName" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业简称</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="shortName" autocomplete="off"  disabled class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业税号</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="taxIdNumber" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业法人</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="holder" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">注册地址</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="regAddress" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业官网</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="website" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">级别</div>
                            </div>
                            <div class="layui-col-md9">
                                <select name="rank" id="rank" lay-filter="project" lay-search></select>
<%--                                <input type="text" name="rank" autocomplete="off" disabled class="layui-input">--%>
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">企业性质</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="enterpriseType" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label">企业LOGO</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type='file' id="photo" name="file"
                                       style="cursor:pointer;"
                                       size='1' hideFocus='' title=""/>
                                <div id="img" name="img" style="">
                                    <img class="uploads" src="" style="width: 100px;margin-top: 10px;"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <hr id="myField">
                    </div>
                </div>
            </div>
        </div>
<%--        企业联系人信息模块--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title infoTitle"> <i class="layui-icon layui-icon-down"></i>企业联系人信息</h2>
            <div class="layui-colla-content layui-show baseDiv">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <table class="layui-hide" id="test" lay-filter="test"></table>
                    </div>
                </div>
            </div>
        </div>
        <div id="contactPop" style="display: none;margin-top: 20px;">
            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-left: 6%; padding: 9px 15px; width: 80px; font-weight: 400; line-height: 20px;">姓名<span style="color:red;">*</span></label>
                <div class="layui-input-inline">
                    <input  type="text" name="contactName"  placeholder="请输入联系人姓名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-left: 6%; display: block; padding: 9px 15px; width: 80px; font-weight: 400; line-height: 20px;">联系电话<span style="color:red;">*</span></label>
                <div class="layui-input-inline">
                    <input lay-verify="required|phone" name="contactMobile" placeholder="请输入联系电话" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-left: 6%; display: block; padding: 9px 15px; width: 80px; font-weight: 400; line-height: 20px;">办公地点<span style="color:red;">*</span></label>
                <div class="layui-input-inline">
                    <input  type="text" name="officeAddress"  placeholder="请输入办公地点" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
    </form>
</div>

<div class="footer">
    <button type="button" class="layui-btn layui-btn-normal savaBtnClass" id="saveBtn">保存</button>
    <button type="button" class="layui-btn layui-btn-primary" id="closeBtn">关闭</button>
</div>
<script>
    // var url = window.location.search;
    // if(url.indexOf('companyId')){
    //     companyId = url.split('=')[1]
    // }
    var url = new URL(location.href).searchParams;
    var companyId = +url.get('companyId')|| "";
    var code = +url.get("code");
    $("#companyCode").prop({disabled:true}).css('backgroundColor',"#ebebeb")
    function setDisabled() {
        if(code == 1) {
            $('.footer').css('display','none')
            $('.container input').prop({disabled:true}).css('backgroundColor',"#ebebeb")
            $('.container select').prop({disabled:true}).css('backgroundColor',"#ebebeb")
            $('.container textarea').prop({disabled:true}).css('backgroundColor',"#ebebeb")
        }else if(code == 2){
            $('.footer').css('display','block')
            $('.container input').not('#companyCode').prop({disabled:false}).css('backgroundColor',"#ffffff")
            $('.container select').prop({disabled:false}).css('backgroundColor',"#ffffff")
            $('.container textarea').prop({disabled:false}).css('backgroundColor',"#ffffff")
        }
    }
    var form,layer,laydate,layedit,table,upload,element;
    var icon;
    var firstLogo
    var logo
    layui.use(['element','form', 'layedit', 'laydate', 'table', 'upload'], function () {
        form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit
            , table = layui.table
            , upload = layui.upload
            , element = layui.element;
        form.render();//建立编辑器
        var indexs = layedit.build('texPart');
        //自定义字段填充
        $.ajax({  //填充状态下拉框
            type:'get',
            url:'/fieldSet/selectFieldSetAndData',
            dataType:'json',
            data:{
                tabName:'exh_company'
            },
            success:function(res){
                var titleStr='<label class="layui-col-md3" style="margin-left: 15px;font-weight: bold;">自定义字段：</label><br>'
                var str=''
                var stype=''
                var obj=res.obj;
                var str1='';
                var s2 = 0;
                var s3 = 0;
                var s1 = '';
                var objects = new Array();
                var itemData = new Array(),
                    fieldNo = new Array();
                if(obj.length>0){
                    for(var i=0;i<obj.length;i++){
                        stype = obj[i].stype;
                        if(stype == 'T'){
                            str+='<div class="layui-col-md4 selfStyle"><div class="layui-col-md3"><label class="layui-form-label labelStyle">'+obj[i].fieldName+'</label></div>' +
                                '<div class="layui-col-md9">' +
                                '<input type="text" class="layui-input layui-input-inline" id="'+obj[i].fieldNo+'">' +
                                '</div></div></div>'
                        }
                        else if(stype=='MT'){
                            str+='<div class="layui-col-md4 selfStyle" style="width: 100%;height: 75px;"><div class="layui-col-md3"><label class="layui-form-label labelStyle">'+obj[i].fieldName+'</label></div>' +
                                '<div class="layui-col-md9">' +
                                '<textarea class="layui-input" style="width: 329px;position: absolute;right: 88%;height: 75px;padding: 5px;"  type="text" id="'+obj[i].fieldNo+'"></textarea>' +
                                '</div></div></div>'
                        }
                        else if(stype=='S'){
                            str+='<div class="layui-col-md4 selfStyle"><div class="layui-col-md3"><label class="layui-form-label labelStyle">'+obj[i].fieldName+'</label></div>' +
                                '<div class="layui-col-md9"><select id="'+obj[i].fieldNo+'">';
                            var s1 = obj[i].fieldNo;
                            if(obj[i].codeType == 2){
                                var s2 = obj[i].typeName.split(',')//用来存储自定义选项 选项名称
                                var s3 = obj[i].typeValue.split(',')//用来存储自定义选项 选项的值
                                var str1 = ''
                                for(j=0;j<=s2.length-1;j++){
                                    str+='<option value="'+s3[j]+'">'+s2[j]+'</option>'
                                }
                            }
                            else if(obj[i].codeType == 1){
                                $.ajax({
                                    url:'/code/getCode?parentNo='+obj[i].typeCode+'',
                                    dataType: 'json',
                                    type: 'get',
                                    async:false,
                                    data:{
                                    },
                                    success: function (data) {
                                        if (data.flag) {
                                            for(var j=0;j<data.obj.length;j++){
                                                var codeNo=data.obj[j].codeNo;
                                                var codeName=data.obj[j].codeName
                                                str+='<option value="'+codeNo+'">'+codeName+'</option>'
                                            }
                                        }
                                    }
                                })
                            }
                            str+='</select></div></div></div>'
                        }
                        else if(stype=='R'){
                            str+='<div class="layui-col-md4 selfStyle"><div class="layui-col-md3"><label class="layui-form-label labelStyle">'+obj[i].fieldName+' </label></div><div class="layui-col-md9">'
                            if(obj[i].codeType == 2){
                                var s2 = obj[i].typeName.split(',')//用来存储自定义选项 选项名称
                                var s3 = obj[i].typeValue.split(',')//用来存储自定义选项 选项的值
                                var str1 = ''
                                for(j=0;j<=s2.length-1;j++){
                                    str += '<input type="radio" id="'+obj[i].fieldNo+'"  name="e" value="'+s3[j]+'" title="'+s2[j]+'" >'
                                }
                            }
                            else if(obj[i].codeType == 1){
                                $.ajax({
                                    url:'/code/getCode?parentNo='+obj[i].typeCode+'',
                                    dataType: 'json',
                                    async:false,
                                    type: 'get',
                                    data:{
                                    },
                                    success: function (data) {
                                        if (data.flag) {
                                            for(var j=0;j<data.obj.length;j++){
                                                str += '<input type="radio" id="'+obj[i].fieldNo+'" name="'+obj[i].fieldNo+'"value="'+data.obj[j].codeNo+'" title="'+data.obj[j].codeName+'" >'
                                            }
                                        } else {
                                            $.layerMsg({content: data.msg, icon: 1});
                                        }
                                    }
                                })
                            }
                            str+='</div></div>'
                        }
                        else if(stype=='C'){
                            str+='<div class="layui-col-md4 selfStyle"><div class="layui-col-md3"><label class="layui-form-label labelStyle">'+obj[i].fieldName+'</label></div><div class="layui-col-md9" style="position: relative;top: 10px">'
                            if(obj[i].codeType == 2){
                                var s2 = obj[i].typeName.split(',')//用来存储自定义选项 选项名称
                                var s3 = obj[i].typeValue.split(',')//用来存储自定义选项 选项的值
                                var str1 = ''
                                for(j=0;j<=s2.length-1;j++){
                                    str += '<input type="checkbox"  id="'+obj[i].fieldNo+'" value="'+s3[j]+'" title="'+s2[j]+'" name="checkbox'+ [i] +'" lay-skin="primary">'
                                }
                            }
                            else if(obj[i].codeType == 1){
                                $.ajax({
                                    url:'/code/getCode?parentNo='+obj[i].typeCode+'',
                                    dataType: 'json',
                                    async:false,
                                    type: 'get',
                                    data:{
                                    },
                                    success: function (data) {
                                        if (data.flag) {
                                            for(var j=0;j<data.obj.length;j++){
                                                str += '<input type="checkbox" id="'+obj[i].fieldNo+'" value="'+data.obj[j].codeNo+'" title="'+data.obj[j].codeName+'" name="n'+ [i] +'" lay-skin="primary">'
                                            }
                                        } else {
                                            $.layerMsg({content: data.msg, icon: 1});
                                        }
                                    }
                                })
                            }
                            str +='</div></div>'
                        }
                    }
                }
                else{
                    str+='</tr>'
                }
                $('#myField').before(titleStr)
                $('#myField').after(str);
                form.render();
                setDisabled();
                $.ajax({
                    url: '/fieldData/selectFieldDataByidentyId',
                    type: 'get',
                    async:true,
                    dataType: 'json',
                    data: {
                        identyId:companyId,
                        tabName:'exh_company'
                    },
                    success: function (res) {
                        if(res.flag && res.object.length > 0) {
                            for(var i = 0; i < res.object.length; i++) {
                                var dom = $('#' + res.object[i].fieldNo)
                                if(dom.attr('type') != 'radio' && dom.attr('type') != 'checkbox' && dom.tagName != 'SELECT') {
                                    $('#' + res.object[i].fieldNo).val(res.object[i].itemData)
                                }else if(dom.attr('type') == 'checkbox'){
                                    var dataItem = res.object[i].itemData.split(',');
                                    if(dataItem.length == 1) {
                                        var domVal = $(dom).val();
                                        if(domVal == res.object[i].itemData) {
                                            $(dom).prop('checked',true);
                                        }
                                    }else {
                                        //    存在复选框多个选项
                                        renderChecked(dataItem,$(dom))
                                    }
                                }else if(dom.attr('type') == 'radio') {
                                    var dataItem = res.object[i].itemData;
                                    var domVal = $(dom).val();
                                    renderChecked(dataItem,$(dom))
                                } else {
                                    var domVal = $(dom).val();
                                    if(domVal == res.object[i].itemData) {
                                        $(dom).prop('checked',true);
                                    }
                                }
                            }
                        }
                    }
                });
            }
        })
        //渲染复选框
        function renderChecked(data,dom) {
            var nameVal = $(dom).prop('name');
            if(nameVal) {
                var doms = $('input[name='+nameVal+']');
                for(var i = 0; i < doms.length; i++) {
                    var flag = false;
                    for(var j = 0; j < data.length; j++) {
                        if(doms[i].value == data[j]) {
                            flag = true
                        }
                    }
                    if(flag) {
                        $(doms[i]).prop('checked',true)
                        // $(doms[i]).prop("disabled",true)
                    }
                }
                layui.use('form',function () {
                    var form = layui.form;
                    form.render();
                })
            }
        }
        //渲染企业信息
        $.ajax({
            url:"/exhCompany/selectByPrimaryKey?exhCompanyId="+companyId,
            type: "get",
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    var data = res.object;
                    logo = (data.logo || "");
                    if(logo){
                        firstLogo=logo.substr(0,logo.lastIndexOf('.'))
                        firstLogo=firstLogo.substr(0,firstLogo.length-1);
                        var lastLogo=logo.substr(logo.lastIndexOf('.')+1);
                        logo = firstLogo+'.'+lastLogo
                        icon = '../ui/img/exhCrm/'+logo;
                    }else{
                        icon = "";
                    }
                    $("#img img").attr("src",icon);
                    $('input[name=companyCode]').val(data.companyCode);
                    $('input[name=companyName]').val(data.companyName);
                    $('input[name=shortName]').val(data.shortName);
                    $('input[name=taxIdNumber]').val(data.taxIdNumber);
                    $('input[name=holder]').val(data.holder);
                    $('input[name=regAddress]').val(data.regAddress);
                    $('input[name=website]').val(data.website);
                    $('input[name=rank]').val(data.rank);
                    $('input[name=enterpriseType]').val(data.enterpriseType);
                    //渲染级别下拉框
                    $.ajax({
                        url:"/code/getCode?parentNo=COMPANY",
                        success:function(res) {
                            if(res.flag && res.obj.length > 0) {
                                var datas = res.obj;
                                var str = "<option value=''>请选择</option>"
                                for(var i = 0; i < datas.length; i++) {
                                    if(data.rank == datas[i].codeName) {
                                        str += '<option selected codeId='+datas[i].codeId+' codeNo='+datas[i].codeNo+'>'+datas[i].codeName+'</option>'
                                    }else {
                                        str += '<option codeId='+datas[i].codeId+' codeNo='+datas[i].codeNo+'>'+datas[i].codeName+'</option>'
                                    }
                                }
                                $("#rank").html(str);
                                form.render("select")
                            }
                        }
                    })
                }
            }
        })
        //企业联系人信息
        const dataTable = table.render({
            elem:"#test",
            url:"/exhCompanyContact/select?companyId="+companyId+"&Export=false",
            page:true,
            limit: 10,
            limits:[10,20,30,40,50],
            parseData:function(res) {
                return {
                    "code": res.flag?0:400,
                    "msg": res.msg,
                    "count": res.totleNum,
                    "data": res.obj
                }
            },
            where: {
                useFlag:true
            },
            request:{
                pageName:'page',
                limitName:'pageSize'
            },
            cols:[[
                {field:"contactName",title:'联系人姓名'},
                {field:"contactMobile",title:'联系电话'},
                {field:"officeAddress",title:'办公地点'},
                {title:'操作',width:200,templet:function(d) {
                        if(code == 1){
                            return '<button type="button" class="layui-btn layui-btn-xs layui-btn-warm" lay-event="details">查看详情</button>'
                        }else if(code == 2){
                            return '<button type="button" class="layui-btn layui-btn-xs layui-btn-warm" lay-event="details">查看详情</button><button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edits">修改</button><button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="dels">删除</button>'
                        }
                    }},
            ]]
        })
        //表格按钮点击事件
        table.on('tool(test)',function(obj) {
            var data = obj.data;
            let companyId = data.companyId;
            let contactId = data.contactId;
            let contactMobile = data.contactMobile
            let contactName = data.contactName;;
            let officeAddress = data.officeAddress;
            if(obj.event=='details') {
                layer.open({
                    type: 1,
                    title: ['联系人详情', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['500px', '320px'],
                    btn: ['确定', '取消'],
                    content: $("#contactPop"),
                    success: function (obj) {
                        $("#contactPop").css('display',"block")
                        $('#contactPop input').prop({disabled:true}).css('backgroundColor',"#ebebeb")
                        $.ajax({
                            url:"/exhCompanyContact/selectByPrimaryKey",
                            async: false,
                            data:{
                                exhCompanyContactId:contactId
                            },
                            success:function(res) {
                                if(res.flag) {
                                    var data=res.object
                                    $('input[name=contactName]').val(data.contactName);
                                    $('input[name=contactMobile]').val(data.contactMobile);
                                    $('input[name=officeAddress]').val(data.officeAddress);
                                }
                            }
                        });
                    }
                })
            }else if(obj.event == 'edits') {
                layer.open({
                    type: 1,
                    title: ['编辑联系人', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['500px', '320px'],
                    btn: ['确定', '取消'],
                    content: $("#contactPop"),
                    success: function (obj) {
                        $("#contactPop").css('display',"block")
                        $('#contactPop input').prop({disabled:false}).css('backgroundColor',"#ffffff");
                        $.ajax({
                            url:"/exhCompanyContact/selectByPrimaryKey",
                            async: false,
                            data:{
                                exhCompanyContactId:contactId
                            },
                            success:function(res) {
                                if(res.flag) {
                                    var data=res.object
                                    $('input[name=contactName]').val(data.contactName);
                                    $('input[name=contactMobile]').val(data.contactMobile);
                                    $('input[name=officeAddress]').val(data.officeAddress);
                                }
                            }
                        });
                    },
                    yes: function (obj) {
                        getContactData(contactId);
                        layer.closeAll();
                    }
                })
            }else if(obj.event=='dels') {
                layer.confirm('确定删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/exhCompanyContact/deleteByPrimaryKey",
                        data:{
                            exhCompanyContactId:contactId
                        },
                        success:function(res) {
                            if(res.flag) {
                                layer.msg('删除成功',{icon:1},function() {
                                    dataTable.reload();
                                })
                            }else{
                                layer.msg('删除失败',{icon:2})
                            }
                        }
                    })
                })
            }
        })
        //保存按钮点击事件
        $("#saveBtn").click(function() {
            var formData = new FormData($('#form1')[0])
            formData.append('companyId', companyId);
            var img = new Image();
            img.src=icon;
            var base64 = getBase64Img(img)
            var logoFile = changeBase64ToBlob(base64, firstLogo)
            let isFile = formData.get('file')
            if(!isFile.name){
                formData.delete('file');
                formData.append('file',logoFile)
                // console.log(isFile.name)
            }
            getData();
            //修改企业信息
            $.ajax({
                type:'post',
                url:"/exhCompany/updateByPrimary",
                data: formData,
                async: false,
                processData : false,
                contentType : false,
                success:function(res) {
                    if(res.flag) {
                        customField(companyId);
                        layer.msg("修改成功",{icon:1});
                    }else {
                        layer.msg(res.msg,{icon: 2})
                    }
                },
                error:function (res) {
                    console.log(res)
                }
            });
        })
        function getData() {
            var companyCode = $('input[name=companyCode]').val();
            var companyName = $('input[name=companyName]').val();
            if(!companyName) {
                layer.msg("企业名称为必填项",{icon: 2});
                return
            }
            var shortName = $('input[name=shortName]').val();
            if(!shortName) {
                layer.msg("企业简称为必填项",{icon: 2});
                return
            }
            var taxIdNumber = $('input[name=taxIdNumber]').val();
            if(!taxIdNumber) {
                layer.msg("企业税号为必填项",{icon: 2})
                return
            }
            var holder = $('input[name=holder]').val();
            if(!holder) {
                layer.msg("企业法人为必填项",{icon:2})
                return
            }
            var regAddress = $('input[name=regAddress]').val();
            if(!regAddress) {
                layer.msg("注册地址为必填项",{icon:2})
                return
            }
            var website = $('input[name=website]').val();
            if(!website) {
                layer.msg("企业官网为必填项",{icon:2})
                return
            }
            var rank = $('#rank').val();
            if(!rank) {
                layer.msg("级别为必填项",{icon:2})
                return
            }
            var enterpriseType = $('input[name=enterpriseType]').val();
            if(!enterpriseType) {
                layer.msg("企业性质为必填项",{icon:2})
                return
            }

        }
        //获取复选框的值
        function getChecked(dom) {
            var nameVal = $(dom).prop('name');
            if(nameVal) {
                var doms = $('input[name='+nameVal+']');
                var arr = [];
                for(var i = 0; i < doms.length; i++) {
                    if($(doms[i]).prop('checked')) {
                        arr.push(doms[i].value)
                    }
                }
                return arr.join(',')
            }
            return "aaa"
        }
        //保存自定义字段
        function customField(contractNo) {
            $.ajax({
                type: 'get',
                url: '/fieldSet/selectFieldSetAndData',
                dataType: 'json',
                data: {
                    tabName: 'exh_company'
                },
                success: function (res) {
                    var obj = res.obj;
                    var objList = []
                    if (obj.length > 0) {
                        for (var i = 0; i < obj.length; i++) {
                            var obj1 = {}
                            obj1.fieldNo = obj[i].fieldNo;
                            if(obj[i].stype == "C") {
                                var val = getChecked($('#' + obj[i].fieldNo))
                                obj1.itemData = val;
                            }else if(obj[i].stype == 'R') {
                                var val = getChecked($('#' + obj[i].fieldNo))
                                obj1.itemData = val;
                            } else {
                                obj1.itemData = $('#' + obj[i].fieldNo).val();
                            }
                            objList.push(obj1)
                        }
                    }
                    //编辑保存自定义字段
                    $.ajax({
                        url: '/fieldData/updateFieldData',
                        dataType: 'json',
                        type: 'post',
                        data: {
                            tabName: 'exh_company',
                            identyId: contractNo,
                            strJson: JSON.stringify(objList)
                        },
                        success: function (data) {
                            if (data.flag) {
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index); //再执行关
                            } else {

                            }
                        }
                    })
                }
            })
        }
        function getContactData(contactId){
            var contactName = $('input[name=contactName]').val();
            if(!contactName) {
                layer.msg("联系人姓名为必填项",{icon:2})
                return
            }
            var contactMobile = $('input[name=contactMobile]').val();
            if(!contactMobile) {
                layer.msg("联系人电话为必填项",{icon:2})
                return
            }
            var officeAddress = $('input[name=officeAddress]').val();
            if(!officeAddress) {
                layer.msg("办公地点为必填项",{icon:2})
                return
            }
            $.ajax({
                url:"/exhCompanyContact/updateByPrimary",
                data:{
                    contactId:contactId,
                    contactName:contactName,
                    contactMobile:contactMobile,
                    officeAddress:officeAddress
                },
                success:function(res) {
                    if(res.flag) {
                        layer.msg("修改成功", {icon: 1});
                        dataTable.reload();
                    }else{
                        layer.msg(res.msg,{icon: 2})
                        return false;
                    }
                }
            });
        }
        //关闭按钮点击事件
        $('#closeBtn').click(function() {
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        })
    })
    /**
     * 将本地图片转为base64格式
     */
    function getBase64Img(img) {
        var canvas = document.createElement("canvas");
        canvas.width = img.width;
        canvas.height = img.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, img.width, img.height);
        var dataURL = canvas.toDataURL("image/png");
        return dataURL;
    }
    /**
     * 将base64转为blob
     * @param base64 图片base64编码
     * @param name 图片名称
     * @returns {Blob}
     */
    function changeBase64ToBlob(base64, name) {
        let base64Arr = base64.split(',');
        let imgType = '';
        let base64String = '';
        if (base64Arr.length > 1) {
            base64String = base64Arr[1];
            imgType = base64Arr[0].substring(base64Arr[0].indexOf(':') + 1, base64Arr[0].indexOf(';')); // 获取图片类型
        }
        let bytes = atob(base64String);
        let bytesCode = new ArrayBuffer(bytes.length);
        let byteArray = new Uint8Array(bytesCode);
        for (let i = 0; i < bytes.length; i++) {
            byteArray[i] = bytes.charCodeAt(i);
        }
        let blobData = new Blob([bytesCode], {type: imgType});
        let imgSuffix ='.' + imgType.split('/')[1]
        let imageFile = new File([blobData], name+ imgSuffix,{type:imgType}) // 将blob转换为file类型
        return imageFile
    }
    <%--    点击的时候下面的内容显示--%>
    $('.infoTitle').on("click",function() {
        const dom = $(this).next('.baseDiv');
        const hasClass = dom.hasClass('layui-hide');
        if(hasClass) {
            dom.addClass('layui-show').removeClass('layui-hide');
            $(this).find('.layui-icon').removeClass('layui-icon-right').addClass('layui-icon-down');
        }else {
            dom.removeClass('layui-show').addClass('layui-hide')
            $(this).find('.layui-icon').removeClass('layui-icon-down').addClass('layui-icon-right');
        }
    })
    $(document).ready(function () {
        if (typeof FileReader == 'undefined') {
            $("#photo").on('change',function (event) {
                var src = event.target.value;
                var pathLength = src.length;
                var additionName = src.substring(pathLength - 3, pathLength);
                if (additionName == "jpg" || additionName == "png" || additionName == "gif" || additionName == "JPG" || additionName == "PNG" || additionName == "GIF") {
                    var img = '<img src="' + src + '" style="width: 100px;margin-top: 10px;" />';
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
                        var img = '<img src="' + e.target.result + '" style="width: 100px;margin-top: 10px;"/>';
                        $("#img").empty().append(img);
                    }
                }
            });
        }

    });
</script>

</body>
</html>