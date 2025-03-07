<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>快递跟踪</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%--    <meta name="referrer" content="never">--%>
    <meta name="applicable-device" content="pc,mobile">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/express/fastMail.js?20201222"></script>
    <style>
        .mbox {
            padding: 8px;
        }
        .item img {
            height: 35px;
        }
        .layui-form-item .layui-input-inline {
            float: left;
            width: 220px;
            margin-right: 10px;
        }
        .layui-text h3 {
            font-size: 15px;
        }
        h3 {
             color: red;
        }
        .kddh{
            margin-top: 10px;
        }
        #search{
            height: 30px;
            float: right;
            background-color: #009688;
            color: white;
            outline: none;
            margin-right: 20px;
            width: 46px;
            line-height: 30px;
            border: 0 none;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="item">
        <img src="/img/fastMail/kuaidi.png" alt="" style="margin: 4px 5px 0 20px;"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">快递跟踪</span>
    </div>
    <hr class="layui-bg-blue">
    <div class="" style="margin-top: 20px;margin-left: 5%">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 70px;">公司名称</label>
                    <div class="layui-input-inline">
                        <select name="sectionType" id="sectionType" class="sectionType" lay-verify="required" lay-search="" lay-filter="college">
                            <option value="">请选择公司名称</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 70px; padding-left: 10px;">快递单号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="title" id="danhao" lay-verify="title" autocomplete="off" placeholder="请输入单号" class="layui-input danhao">
                    </div>
                </div>
                <div class="layui-inline" id="autoHide" style="display: none">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 70px; padding-left: 10px;">用户手机号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" id="iphoneNum1" lay-verify="title" autocomplete="off" placeholder="请输入寄件人手机号后四位" class="layui-input iphoneNum1">
                        </div>
                    </div><div class="layui-inline">
<%--                        <label class="layui-form-label" style="width: 70px; padding-left: 10px;">用户手机号</label>--%>
                        <div class="layui-input-inline">
                            <input type="text" name="title" id="iphoneNum2" lay-verify="title" autocomplete="off" placeholder="请输入收件人手机号后四位" class="layui-input iphoneNum2">
                        </div>
                    </div>
                </div>
                <button type="button" class="layui-btn search" style="margin-top: -6px;">查询</button>
            </div>
        </form>
    </div>
    <div style=" margin-left: 7%;margin-top: 40px;">
        <ul class="layui-timeline detail" id="detail">
        </ul>
    </div>
</div>
<div class="android" style="display: none ">
    <div class="" style="margin-top: 30px;margin-left: 5%">
        <form class="" action="">
            <div class="">
                <label class="" style="width: 70px;">公司名称</label>
                <div class="" style="display: inline-block;margin-left: 10px;width: 51%;">
                    <select name="sectionType"  class="sectionType" id="sectionTypes" lay-verify="required" lay-search="" style="height: 30px;width: 100%;" lay-filter="college">
                        <option value="">请选择公司名称</option>
                    </select>
                </div>
                <div class="layui-inline" id="autoHide" style="display: none">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 70px; padding-left: 10px;">用户手机号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="title" id="iphoneNum1" lay-verify="title" autocomplete="off" placeholder="请输入寄件人手机号后四位" class="layui-input iphoneNum1">
                        </div>
                    </div><div class="layui-inline">
                    <%--                        <label class="layui-form-label" style="width: 70px; padding-left: 10px;">用户手机号</label>--%>
                    <div class="layui-input-inline">
                        <input type="text" name="title" id="iphoneNum2" lay-verify="title" autocomplete="off" placeholder="请输入收件人手机号后四位" class="layui-input iphoneNum2">
                    </div>
                </div>
                </div>
                <button type="button" class="search" id="search">查询</button>
            </div>
            <div class="kddh">
                <label class="" style="width: 70px; ">快递单号</label>
                <div class="" style="display: inline-block; margin-left: 10px;width: 51%;">
                    <input type="text" name="title" class="danhao" id="danhaos" lay-verify="title" autocomplete="off" placeholder="请输入单号" class="" style="height: 30px;width: 100%;">
                </div>
            </div>
        </form>
    </div>
    <div style=" margin-left: 3%;margin-top: 40px;">
        <ul class="layui-timeline detail" id="details">
        </ul>
    </div>
</div>
<script>
    // $(function () {
    //     if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
    //         window.location.replace('/express/getExpressH5');
    //     }
    // })
 
    if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
        $('.mbox').css('display','none')
        $('.android').css('display','block')
    }

    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        form.render();
        //公司名称渲染
        $(".sectionType").append(_select(sectionType));
        function _select(type){
            var str= "";
            for(var i=0;i<type.length;i++) {
                str += '<option value="' + type[i].value + '">' + type[i].name + '</option>';
            }
            return str;
        }
        form.render('select');
        // $.ajax({
        //     url:'/express/getAllCompany',
        //     type:'get',
        //     dataType : 'json',
        //     // jsonp:'callback',
        //     success:function(res){
        //         var obj = res.data;
        //         var str = '<option value="">请选择公司名称</option>';
        //         for (var v in obj){
        //             str += '<option value="' + obj[v].no + '">' + obj[v].com + '</option>';
        //         }
        //         $('select[name="sectionType"]').append(str);
        //         form.render('select');
        //     }
        //
        // });
        form.on('select(college)', function (data) {
            var message=$("select[name=sectionType]").val()
                if(message == 'sf'){
                    $('#autoHide').show()
                }else{
                    $('#autoHide').hide()
                }
                form.render('select');
            })

        $('.search').on('click',function(){
            if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                var company = $('#sectionTypes').val();
                var num = $('#danhaos').val();
                var pnum1 = $('#iphoneNum1').val();//寄件人
                var pnum2 = $('#iphoneNum2').val();//收件人
            }else{
                var company = $('select[name="sectionType"]').val();
                var num = $('#danhao').val();
                var pnum1 = $('#iphoneNum1').val();//寄件人
                var pnum2 = $('#iphoneNum2').val();//收件人
            }

            $.ajax({
                url:'/express/getLogisticsInfo',
                type:'get',
                dataType : 'json',
                data:{
                    com:company,
                    no:num,
                    senderPhone:pnum1,
                    receiverPhone:pnum2
                },
                success:function(res){
                    var obj = res.data;
                    if(res.flag = 'true'){
                        if(obj != undefined){
                            if(obj.list != undefined && obj.list.length > 0){
                                var str = '';
                                for(var i=obj.list.length-1; i>=0; i--){
                                    str += '<li class="layui-timeline-item infoDetail">\n' +
                                        '                        <i class="layui-icon layui-timeline-axis"></i>\n' +
                                        '                        <div class="layui-timeline-content layui-text" >\n' +
                                        '                            <h3 class="layui-timeline-title">' + obj.list[i].datetime +'</h3>\n' +
                                        '                            <p>' + obj.list[i].remark + '</p>\n' +
                                        '                        </div>\n' +
                                        '                    </li>'
                                }
                                if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                                    $('#details').html(str)
                                    $("ul li:first div").css("color","red");
                                    $("ul li:first div h3").css("color","red");
                                    $("ul li:first i").css("color","red");
                                }else{
                                    $('#detail').html(str)
                                    $("ul li:first div").css("color","red");
                                    $("ul li:first div h3").css("color","red");
                                    $("ul li:first i").css("color","red");
                                }
                            }
                        }
                        else{
                            if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
                                $('#details').html('')
                            }else{
                                $('#detail').html('')
                            }
                            if(res.msg == 'nu格式不正确'){
                                layer.msg('请输入正确的单号',{icon:0});
                            }else if(res.msg == 'nu长度不符合标准'){
                                layer.msg('快递长度不符合标准',{icon:0});
                            }else {
                                layer.msg(res.msg,{icon:0});
                            }

                        }
                    }
                }

            });

        })

    });
</script>
</body>
</html>
