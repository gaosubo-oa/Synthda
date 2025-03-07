<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2021/1/29
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>快递跟踪</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/express/fastMail.js?20201222"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
<%--    <link href="../../css/H5/default.css" rel="stylesheet"/>--%>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .kddh{
            margin-top: 10px;
        }
        .search{
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
        .layui-text h3 {
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="" style="margin-top: 30px;margin-left: 5%">
    <form class="" action="">
        <div class="">
            <label class="" style="width: 70px;">公司名称</label>
            <div class="" style="display: inline-block;margin-left: 10px;width: 51%;">
                <select name="sectionType" id="sectionType" lay-verify="required" lay-search="" style="height: 30px;width: 100%;">
                    <option value="">请选择公司名称</option>
                </select>
            </div>
            <button type="button" class="search">查询</button>
        </div>
        <div class="kddh">
            <label class="" style="width: 70px; ">快递单号</label>
            <div class="" style="display: inline-block; margin-left: 10px;width: 51%;">
                <input type="text" name="title" id="danhao" lay-verify="title" autocomplete="off" placeholder="请输入单号" class="" style="height: 30px;width: 100%;">
            </div>
        </div>
    </form>
</div>
<div style=" margin-left: 3%;margin-top: 40px;">
    <ul class="layui-timeline" id="detail">
    </ul>
</div>
<script>
    //公司名称渲染
    $("#sectionType").append(_select(sectionType));
    function _select(type){
        var str= "";
        for(var i=0;i<type.length;i++) {
            str += '<option value="' + type[i].value + '">' + type[i].name + '</option>';
        }
        return str;
    }
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        form.render();
        $('.search').on('click',function(){
            var company = $('select[name="sectionType"]').val();
            var num = $('#danhao').val();
            $.ajax({
                url:'/express/getLogisticsInfo',
                type:'get',
                dataType : 'json',
                data:{
                    com:company,
                    no:num,
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
                                $('#detail').html(str)
                                $("ul li:first div").css("color","red");
                                $("ul li:first div h3").css("color","red");
                                $("ul li:first i").css("color","red");
                            }
                        }
                        else{
                            $('#detail').html('')
                            layer.msg(res.msg,{icon:0});
                        }
                    }
                }

            });

        })

    });
</script>
</body>
</html>
