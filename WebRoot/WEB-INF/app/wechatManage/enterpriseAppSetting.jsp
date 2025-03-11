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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.usermanage" /></title>
    <meta name="renderer" content="webkit">
    <meta name="renderer" content="ie-comp">
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css?20210827"/>

    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/lib/layui/layui.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <%--<script type="text/javascript" src="/lib/layui/layui.all.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>

    <script type="text/javascript" src="/lib/layer/layer.js?20210631"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        [class*="span"]{
            float: none;
        }
        .bottom .boto div {
            cursor: pointer;
            color: #2B7FE0;
            font-size: 14px;
            display: block;
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            margin-top: 0;
            margin-left: 0;
        }
        .boto a{

        }
        .colorRed td{
            color: red!important;
        }
        .colorddd td{
            color: #999!important;
        }
        .content .left .collect .liUp:first-of-type{
            border-top:none!important;
        }
        #btn{
            line-height: 28px;
        }
        table  tr td{
            /*text-align: center;*/
        }
        。btn {
            line-height: 28px;
            float: right;
            margin-right: 12px;
            margin-top:4px;
            margin-left:0px;
            border:none;
            top: 46px;
        }
        body{
            background-color: #f5f7f8;
        }
        .content .left{
            width: 350px!important;
        }
        .content .rightMain, .content .right{
            width: calc(100% - 351px)!important;
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }
        .tab table{
            white-space: nowrap;
            word-break: keep-all;
        }
        .content .headDiv{
            background-color: #f5f7f8;
        }

        /*.pickCompany{*/
        /*margin-bottom: 30px;*/
        /*}*/

        td{
            font-size: 11pt;
        }
        .liUp{
            color:#000;
        }
        .content .right{
            overflow-y: inherit;
        }
        #downChild li{
            /*width: 1000px;*/
        }
        .content .left .collect .divUP{
            overflow: auto;
        }
        .childdept{
            min-height: 36px;
            height: auto;
            line-height: 36px;
        }
        #downChild li>span{
            font-size: 14px;
            white-space: nowrap
        }
        .content .left .collect .spanUP{
            color: #000;
            font-size: 14px;
        }
        #downChild li>span{
            font-size: 14px;
        }

        .content .left .collect{
            height: 900px!important;
        }
        .pickCompany a{
            font-size: 14px;
        }
        .pickCompany .childdept img{
            margin-left: 0px!important;
        }
        .liUp{
            background: url(../../img/sys/icon_rightarrow_03.png) no-repeat 85% center;
        }
        .liDown{
            background: url(../../img/sys/icon_downarrow_03.png) no-repeat 85% center;
        }
        ::-webkit-scrollbar{
            width: 5px;
        }
        .w{
            height: 40px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script src="../js/base/base.js?20200119.1" type="text/javascript" charset="utf-8"></script>

    <style>
        .dept_order_box th{
            padding: 10px;
            font-size: 11pt;
        }
        .dept_order_box td {
            padding: 5px;
        }
        .dept_order_box table input {
            width: 40px;
            height: 20px;
        }
        .dept_order_box table select {
            height: 20px;
            padding: 2px;
            box-sizing: content-box;
        }
        .syn_user{
            width: 90px;
            font-size: 13px;
            background-color: #2f80d1;
            height: 30px;
            line-height: 30px;
            color: white;
            border-radius: 5px;
        }
        #deptOrderTable tr td{
            text-align: center;
        }
        .form-horizontal{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        input {
            background-color: #ffffff;
            height: 20px;
            padding: 4px 6px;
            margin-bottom: 10px;
            font-size: 13px;
            line-height: 20px;
            color: #555555;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 2px;
            vertical-align: middle;
            border: 1px solid #ccc;
        }
        legend h5{
            font-size: 13pt;
            margin-left: 20px;
        }

        .type2{
            display: none;
        }
        .type3{
            display: none;
        }
        .type4{
            display: none;
        }
        .type5{
            display: none;
        }
        .type6{
            display: none;
        }

    </style>
</head>
<body>
<div class="content clearfix">
    <input type="hidden" name="hiddenDept">
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userManagement1.png" style="vertical-align: middle;" alt="企业微信应用设置">
        </div>
        <div class="divP">企业微信应用设置</div>

    </div>
    <div class="left" style="background: #f5f7f8;">
        <div class="collect">
            <%--未分配部门人员--%>
            <div style="height: 350px" class="leftData">

            </div></div>
    </div>
    <div class="rightMain clearfix">
        <form class="form-horizontal">

            <fieldset class="type">
                <legend class="type1" ><h5 name="paraValue" value="paraValue">企业微信应用设置 -- <span class="modelName">电子邮件</span></h5></legend>
                <div class="control-group">
                    <label class="control-label" for="inputCorpID">应用密钥（Seret）</label>
                    <div class="controls">
                        <input  id="inputCorpID" value="" name="agentId">

                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputSecret">应用ID（AgentID）</label>
                    <div class="controls">
                        <input  class="span6" id="inputSecret"value="" name="secret">

                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="agentid">应用地址</label>
                    <div class="controls">
                        <input  class="span6" id="agentid" value="" name="url">
                        <p style="display: inline-block">例：/ewx/diaryIndex</p>
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <button type="button" class="btn" >确定</button>
                        <button id="connect-btn" type="button" class="btn btn-warning" style="margin-left: 5px;display: none" v-by=0>测试连接</button>
                        <span id="connect-msg"></span>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</div>
<script type="text/javascript">
    $.ajax({
        url:'/qiyeWeixin/getAllWxAppSetting',
        type:'POST',
        dataType:'json',
        success:function (res) {

            var str = ''
            if(res.flag){
                for(var i=0;i<res.data.length;i++){
                    str += ' <div class="leftClick"  onclick="showRight('+ i +',$(this))" paraValue="'+ res.data[i].paraValue + '" paraName"'+ res.data[i].paraName +'">' +
                        '<span class="spanUP liUp noDept">' +
                        '<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt=""> ' + res.data[i].paraName +
                        '<span>' +
                        '</div>'
                }
                console.log(str)
                //append   在.leftData插入（str）
                $('.leftData').append(str)
                $('.btn').attr('paraValue', res.data[0].paraValue)
                if(res.data.length){
                    getFormData(res.data[0].paraValue)
                }
            }
        }
    })

    $('.btn').click(function() {
        var agentId = $('[name="agentId"]').val();
        var secret = $('[name="secret"]').val();
        var url = $('[name="url"]').val();
        if (agentId == '') {
            layer.msg('请填写agentId', {icon: 2});
            return;
        }
        if (secret == '') {
            layer.msg('请填写secret', {icon: 2});
            return;
        }
        if (url == '') {
            layer.msg('请填写url', {icon: 2});
            return;
        }

        $.ajax({
            url: '/qiyeWeixin/setWxAppSetting',
            type: 'POST',
            data: {
                agentId: agentId,
                secret: secret,
                url: url,

                paraName: $('.btn').attr('paraValue')

            },
            dataType: 'json',
            success: function (res) {

                if (res.flag) {
                    layer.msg("保存成功", {icon: 1})
                } else {
                    layer.msg("保存失败", {icon: 2})
                }
            }
        })
    })

    layui.use(['form', 'layedit', 'laydate','table'], function() {
        var form = layui.form
            , table = layui.table
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        form.render()
    })
    var uidArray = new Array();
    var a;
    var b=0;
    var dimission = 0;
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        //document.getElementById("downChild").style.height= winHeight - 300 +"px";
        $('#downChild').css({'min-height':winHeight - 400 +"px"});

    }
    autodivheight();
    function turnUndefined(data){
        if(data==undefined){
            return ""
        }else{
            return data;
        }
    }
    $('.left').height($(document).height()-46)

    var userstr;
    var user_id;
    var numdept;
    var searchData ={};
    var USER_DEPT_ORDER = false;
    function showRight(num,e){
        //attr(attrName, value) 设置属性
        // 参数 : 属性名称, 对应的值
        // 返回 : h.js 操作对象，可以进行连贯操作
        console.log(e.text())
        $('.btn').attr('paraValue',e.attr('paraValue'))
        var paraValue  = e.attr('paraValue')
        $('.modelName').text(e.text())
        // if(paraValue == 'WEIXINQY_APP_EMAIL'){
        //
        // }
    }

    //    回显数据
    $('.leftData').click(function(e) {
        var dom = e.target;
        var val = $(dom).parent().attr('paravalue');
        getFormData(val)
    })

    // 查询表单数据
    function getFormData(val){
        $.ajax({
            url:"/qiyeWeixin/getWxAppSetting",
            dataType:'json',
            data:{
                paraName: val
            },
            success:function(res) {
                if(res.flag) {
                    $('#inputCorpID').val(res.data.agentId)
                    $('#inputSecret').val(res.data.secret)
                    $('#agentid').val(res.data.url)
                }
            }
        })
    }
</script>
</body>
</html>
