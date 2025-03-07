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
        <%--    客户基础信息模块--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title infoTitle"> <i class="layui-icon layui-icon-down"></i>客户基础信息</h2>
            <div class="layui-colla-content layui-show baseDiv">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">客户编号</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" id="exhUserCode" name="exhUserCode" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">姓名</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="exhUserName" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">性别</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="radio" name="gender" value="男" title="男" checked="" lay-filter="radiofilter">
                                <input type="radio" name="gender" value="女" title="女" lay-filter="radiofilter">
                            </div>
                        </div>
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">身份证号</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="cardId" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">注册地址</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="province" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">职称</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="titles" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">注册日期</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" id="registDate" name="registDate" disabled autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label layui-required">是否禁用</div>
                            </div>
                            <div class="layui-col-md9">
                                <select id="enable" title="是否禁用" name="enable" lay-verify="">
                                    <option value="">请选择</option>
                                    <option value="1">是</option>
                                    <option value="0">否</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-col-md4">
                            <div class="layui-col-md3">
                                <div class="layui-form-label">备注</div>
                            </div>
                            <div class="layui-col-md9">
                                <input type="text" name="remark" autocomplete="off" disabled class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <hr id="myField">
                    </div>
                </div>
            </div>
        </div>
            <%--        客户子表信息模块--%>
            <div class="layui-colla-item" style="margin-top: 10px;">
                <h2 class="layui-colla-title infoTitle"> <i class="layui-icon layui-icon-down"></i>客户其他信息</h2>
                <div class="layui-colla-content layui-show baseDiv">
                    <div class="layui-fluid">
                        <div class="layui-row">
                            <table class="layui-hide" id="test" lay-filter="test"></table>
                        </div>
                    </div>
                </div>
            </div>
    </form>
</div>
<%--            客户子表详情弹窗--%>
<div id="contactPop" style="width:86%;display: none;margin-top: 20px;">
    <form id="formAjax">
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>昵称:</label>
            <div class="layui-input-block">
                <input  type="text" name="nickName" required lay-verify="required" placeholder="请输入昵称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>住址:</label>
            <div class="layui-input-block">
                <input type="text" name="address" required  lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>单位:</label>
            <div class="layui-input-block">
                <input type="text" name="unit" id="unit" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>职务:</label>
            <div class="layui-input-block">
                <input type="text" name="job" id="job" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>手机号:</label>
            <div class="layui-input-block">
                <input type="text" name="mobile" required  lay-verify="required|phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>电子邮箱:</label>
            <div class="layui-input-block">
                <input type="text" name="email" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>座机:</label>
            <div class="layui-input-block">
                <input type="text" name="phone" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>微信账号:</label>
            <div class="layui-input-block">
                <input type="text" name="openId" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>支付宝账号:</label>
            <div class="layui-input-block">
                <input type="text" name="alipayId" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="margin-top: 15px;">
            <label class="layui-form-label" style="width: 90px;padding: 5px;"><span style="color: red; font-size: 15px;">*</span>上传照片:</label>
            <div class="layui-input-block">
                <input type="file" id="file" name="file" style="cursor:pointer;" size='1' hideFocus='' title=""/>
                <div id="img" name="img" style="">
                    <img class="uploads" src="" style="width: 100px;margin-top: 10px;"/>
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
    var icon,firstLogo,logo;
    var url = new URL(location.href).searchParams;
    var exhUserId = +url.get('exhUserId')|| "";
    var code = +url.get("code");
    $("#exhUserCode").prop({disabled:true}).css('backgroundColor',"#ebebeb")
    function setDisabled() {
        if(code == 1) {
            $('.footer').css('display','none')
            $('.container input').prop({disabled:true}).css('backgroundColor',"#ebebeb")
            $('.container select').prop({disabled:true}).css('backgroundColor',"#ebebeb")
            $('.container textarea').prop({disabled:true}).css('backgroundColor',"#ebebeb")
        }else if(code == 2){
            $('.footer').css('display','block')
            $('.container input').not('#exhUserCode').prop({disabled:false}).css('backgroundColor',"#ffffff")
            $('.container select').prop({disabled:false}).css('backgroundColor',"#ffffff")
            $('.container textarea').prop({disabled:false}).css('backgroundColor',"#ffffff")
        }
    }
    var form,layer,laydate,layedit,table,upload,element;
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
                tabName:'exh_user'
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
                        identyId:exhUserId,
                        tabName:'exh_user'
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
        //渲染时间选择框
        laydate.render({
            elem:"#registDate",
            type:"date",
            value:new Date(),
            format:"yyyy-MM-dd",
            trigger:"click"
        })
        //渲染客户基础信息
        $.ajax({
            url:"/exhUser/selectByPrimaryKey?exhUserId="+exhUserId,
            type: "get",
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    var data = res.object;
                    $('input[name=exhUserCode]').val(data.exhUserCode);
                    $('input[name=exhUserName]').val(data.exhUserName);
                    $('input[name=gender]').val(data.gender);
                    $('input[name=cardId]').val(data.cardId);
                    $('input[name=province]').val(data.province);
                    $('input[name=titles]').val(data.titles);
                    $('input[name=registDate]').val(data.registDate);
                    // $("#selector option[value='1']").prop("selected", true);
                    $('select[name=enable]').val(data.enable);
                    $('input[name=remark]').val(data.remark);
                    form.render();
                }
            }
        })
        //渲染客户子表信息
        const dataTable = table.render({
            elem:"#test",
            url:"/exhUserAttribute/selectExhUserAttribute?exhUserId="+exhUserId+"&Export=false",
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
                {field:"nickName",title:'昵称'},
                {field:"address",title:'住址'},
                {field:"photo",title:'照片',event: 'viewPhoto', templet: function(d) {
                        logo = (d.photo || "");
                        if(logo){
                            var firstLogo=logo.substr(0,logo.lastIndexOf('.'))
                            firstLogo=firstLogo.substr(0,firstLogo.length-1);
                            var lastLogo=logo.substr(logo.lastIndexOf('.')+1);
                            logo = firstLogo+'.'+lastLogo
                            return '<img src="../ui/img/exhCrm/'+logo+'" ' + 'alt="" width="30px" height="30px">';
                        }else{
                            return '暂无图片';
                        }
                    }},
                {field:"mobile",title:'手机号'},
                {field:"email",title:'电子邮箱'},
                {field:"unit",title:'单位'},
                {field:"job",title:'职务'},
                {field:"phone",title:'座机'},
                {field:"openId",title:'微信账号'},
                {field:"alipayId",title:'支付宝账号'},
                {title:'操作',width:200,templet:function(d) {
                        if(code == 1){
                            return '<button type="button" class="layui-btn layui-btn-xs layui-btn-warm" lay-event="details">查看详情</button>'
                        }else if(code == 2){
                            return '<button type="button" class="layui-btn layui-btn-xs layui-btn-warm" lay-event="details">查看详情</button><button type="button" class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edits">修改</button><button type="button" class="layui-btn layui-btn-xs layui-btn-danger" lay-event="dels">删除</button>'
                        }
                    }},
            ]]
        })
        //客户子表信息操作按钮
        table.on('tool(test)',function(obj) {
            var data = obj.data;
            let exhUserAttributeId = data.attributeId;
            if(obj.event=='details') {
                layer.open({
                    type: 1,
                    title: ['查看信息', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '520px'],
                    btn: ['确定', '取消'],
                    content: $("#contactPop"),
                    success: function (obj) {
                        $("#contactPop").css('display',"block")
                        $('#contactPop input').prop({disabled:true}).css('backgroundColor',"#ebebeb")
                        $.ajax({
                            url:"/exhUserAttribute/selectByPrimaryKey",
                            async: false,
                            data:{
                                exhUserAttributeId:exhUserAttributeId
                            },
                            success:function(res) {
                                if(res.flag) {
                                    var data=res.object
                                    // 子表数据回显
                                    msgInit(data)
                                }
                            }
                        });
                    }
                });
            }else if(obj.event == 'edits') {
                layer.open({
                    type: 1,
                    title: ['修改信息', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['700px', '520px'],
                    btn: ['确定', '取消'],
                    content: $("#contactPop"),
                    success: function (obj) {
                        $("#contactPop").css('display',"block")
                        $('#contactPop input').prop({disabled:false}).css('backgroundColor',"#ffffff");
                        $.ajax({
                            url:"/exhUserAttribute/selectByPrimaryKey",
                            async: false,
                            data:{
                                exhUserAttributeId:exhUserAttributeId
                            },
                            success:function(res) {
                                if(res.flag) {
                                    var data=res.object;
                                    // 子表数据回显
                                    msgInit(data);
                                }
                            }
                        });
                    },
                    yes: function (index, layero) {
                        // 编辑保存子表数据
                        getEditData(exhUserAttributeId);
                        layer.close(index);
                    }
                });
            }else if(obj.event=='viewPhoto'){
                var t = $(this).find("img");
                //页面层
                layer.open({
                    type: 1,
                    title: '图片预览',
                    skin: 'layui-layer-rim', //加上边框
                    area: ['50%', '60%'], //宽高 t.width() t.height()
                    shadeClose: true, //开启遮罩关闭
                    end: function (index, layero) {
                        return false;
                    },
                    content: '<div style="margin:10px auto;text-align:center;"><img src="' + $(t).attr('src') + '" /></div>'
                });
            }else if(obj.event=='dels') {
                layer.confirm('确定删除吗',{icon: 3, title:'提示'},function(index) {
                    $.ajax({
                        url:"/exhUserAttribute/deleteByPrimaryKey",
                        data:{
                            exhUserAttributeId:exhUserAttributeId
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
                    });
                });
            }
        })
        //保存按钮
        $("#saveBtn").click(function() {
            var data = getData();
            if(data) {
                $.ajax({
                    url:"/exhUser/updateByPrimary",
                    data: data,
                    async: false,
                    success:function(res) {
                        if(res.flag) {
                            customField(exhUserId);
                            layer.msg("修改成功",{icon:1});
                        }else {
                            layer.msg(res.msg,{icon: 2})
                            return
                        }
                    },
                    error:function (res) {
                        console.log(res)
                    }
                });
            }
        })
        function getData() {
            var exhUserCode = $('input[name=exhUserCode]').val();
            var exhUserName = $('input[name=exhUserName]').val();
            if(!exhUserName) {
                layer.msg("客户名称为必填项",{icon: 2})
                return
            }
            var gender = $('input[name=gender]:checked').val();
            if(!gender) {
                layer.msg("性别为必选项",{icon: 2})
                return
            }
            var cardId = $('input[name=cardId]').val();
            if(!cardId) {
                layer.msg("身份证号为必填项",{icon: 2})
                return
            }
            //校验身份证是否重复
            $.ajax({
                url:"/exhUser/selectCount",
                data: {
                    cardId: cardId,
                    exhUserId:exhUserId
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
            var province = $('input[name=province]').val();
            if(!province) {
                layer.msg("省份为必填项",{icon:2})
                return
            }
            var titles = $('input[name=titles]').val();
            if(!titles) {
                layer.msg("职称为必填项",{icon:2})
                return
            }
            var registDate = $('input[name=registDate]').val();
            if(!registDate) {
                layer.msg("注册日期为必填项",{icon:2})
                return
            }
            var remark = $('input[name=remark]').val();
            // var projectName = $("#projectName option:selected").text() === '请选择'?"":$("#projectName option:selected").text();
            return {
                exhUserId:exhUserId,
                exhUserCode:exhUserCode,
                exhUserName:exhUserName,
                gender:gender,
                cardId:cardId,
                province:province,
                titles:titles,
                registDate:registDate,
                remark:remark
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
                    tabName: 'exh_user'
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
                            tabName: 'exh_user',
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
        function getEditData(id){
            var mobile = $('input[name="mobile"]').val()
            var reg =/^[0-9]*$/; //数字
            if(!reg.test(mobile)){
                layer.msg('手机号只能输入数字',{time:1000,icon:2})
                return false;
            }
            if( $('input[name="nickName"]').val()==''){
                layer.msg('请填写昵称', {icon: 2});
            }else if($('input[name="address"]').val()==''){
                layer.msg('请填写住址', {icon: 2});
            }else if($('#mobile').val() == ""){
                layer.msg('请填写手机号', {icon: 2});
            }else if($('input[name="email"]').val() == ""){
                layer.msg('请填写电子邮箱', {icon: 2});
            }else if($('#unit').val() == ""){
                layer.msg('请填写单位', {icon: 2});
            }else if($('#job').val() == ""){
                layer.msg('请填写职务', {icon: 2});
            }else if($('#phone').val() == ""){
                layer.msg('请填写座机', {icon: 2});
            }else if($('#openId').val() == ""){
                layer.msg('请填写微信账号', {icon: 2});
            }else if($('#alipayId').val() == ""){
                layer.msg('请填写支付宝账号', {icon: 2});
            }else{
                var formData = new FormData($('#formAjax')[0])
                formData.append('attributeId', id);
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
                $.ajax({
                    url:'/exhUserAttribute/updateByPrimary',
                    type: "post",
                    dataType: "json",
                    data:formData,
                    async: false,
                    processData: false,
                    contentType : false,
                    success:function (res) {
                        if(res.flag) {
                            layer.msg("修改成功", {icon: 1,time:3000},function(){
                                dataTable.reload();
                            });
                        }else{
                            layer.msg(res.msg, {icon: 2});
                            return false;
                        }
                    }
                });
            }
        }
        // 子表数据回显
        function msgInit(data){
            logo = (data.photo || "");
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
            $('input[name="nickName"]').val(data.nickName)
            $('input[name=address]').val(data.address);
            $('input[name=mobile]').val(data.mobile);
            $('input[name=email]').val(data.email);
            $('input[name=unit]').val(data.unit);
            $('input[name=job]').val(data.job);
            $('input[name=phone]').val(data.phone);
            $('input[name=openId]').val(data.openId);
            $('input[name=alipayId]').val(data.alipayId);
        }
        //关闭按钮
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

    });
</script>

</body>
</html>