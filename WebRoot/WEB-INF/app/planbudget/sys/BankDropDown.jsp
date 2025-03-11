<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/9/2
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20211229.1"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>
    <script type="text/javascript" src="/ui/js/sys/citys.js" charset=gbk></script>
</head>
<style>

    li {
        list-style: none;
    }

    .form {
        background-color: white;
        width: 100%;
        padding-top: 40px;
        padding-bottom: 25px;
    }

    /*.layui-table-page {*/
    /*    display: none;*/
    /*}*/

    .layui-table-view .layui-form-radio > i {
        margin: 14px 0;
        font-size: 20px;
    }
    #province{
        margin-left: -55px;
    }
    #city{
        margin-left: -100px;
    }
    #bank{
        margin-left: -70px;
    }
    .layui-input-inline>.layui-unselect>.layui-select-title>input{
        width: 70%;
    }
    .layui-input-inline>.layui-unselect>.layui-select-title>i{
        right: 65px;
    }
    #name{
        width: 210px;
    }

</style>
<body>
<div class="form">
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <%--            <p class="layui-form-label" style="display: block">银行名称</p>--%>
            <%--            <div class="layui-input-inline">--%>
            <%--                <select name="quiz1">--%>
            <%--                    <option value="" selected="">请选择银行名称</option>--%>
            <%--                    <option value="浙江">浙江省</option>--%>
            <%--                    <option value="你的工号">江西省</option>--%>
            <%--                    <option value="你最喜欢的老师">福建省</option>--%>
            <%--                </select>--%>
            <%--            </div>--%>
            <p class="layui-form-label" id="province">省份</p>
            <div class="layui-input-inline">
                <select name="province" id="quiz1" lay-filter="quiz1">
                    <option value="" selected>数据加载中</option>
                </select>
            </div>
            <p class="layui-form-label" id="city">城市</p>
            <div class="layui-input-inline">
                <select name="city" id="quiz2" lay-filter="quiz2">
                    <option value="" selected>数据加载中</option>
                </select>
            </div>
            <p class="layui-form-label" id="bank">银行名称</p>
            <div class="layui-input-inline">
                <input name="name" id="name" class="layui-input" type="text" placeholder="分行、支行、网点关键字"
                       autocomplete="off" lay-verify="title">
            </div>

            <div class="layui-btn-container">
                <button id="botton" class="layui-btn layui-btn-normal" type="button" style="margin-left: 20px;">查询</button>
                <button class="layui-btn layui-btn-primary" onclick="reset()" id="reset" type="reset">重置</button>
            </div>
        </div>
    </form>
    <table class="layui-hide" id="test" lay-filter="demo"></table>
</div>
<script>

    var provinces;
   layui.use(['form', 'layedit', 'laydate', 'table'], function () {
        var table = layui.table;
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
       form.render();
        //监听单选框选中
        table.on('radio(demo)',function(data){
            var bankName = data.data.name;
            var bankNumber = data.data.union_number;
            parent.ppp(bankName, bankNumber);
        })



        var tableInt = table.render({
            elem: '#test'
            , url: '/plbBank/getDataByBank?province=&city='
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.data, //解析数据列表，
                    "count": res.totleNum, //解析数据长度
                };
            }
            , cols: [[
                {type: 'radio',}
                , {field: 'name', title: '银行名称',width:300}
                ,{field:'country',title:'国家地区'}
                ,{field: 'union_number', title: '编码', hide:true}
                ,{field:'province',title:'省份'}
                ,{field:'city',title:'城镇'}
            ]]
            ,  page: true
        });

        $(function () {
            $.ajax({
                url: '/plbBank/getProvinceAndCity',
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    provinces=res.data.provinces
                    var provinceList = [];
                    var cityList = []
                    var str = '<option>请选择省份</option>'
                    var str1 = '<option>请先选择省份</option>'
                    for (var i = 0; i < provinces.length; i++) {
                        str += '<option>' + provinces[i].name + '</option>'
                    }
                    $("#quiz1").html(str)
                    $("#quiz2").html(str1)
                    form.render();
                }
            })
        })
        form.on('select(quiz1)', function (data) {
            var value = data.value
            for (var i = 0; i < provinces.length; i++) {
                if (value == provinces[i].name) {
                    var citys = provinces[i].citys;
                    var str2 = '';
                    $("#quiz2").empty();
                    for (var j = 0; j < citys.length; j++) {
                        str2 += "<option value='" + citys[j] + "'>" + citys[j] + "</option>"
                    }
                    $("#quiz2").append(str2);
                    form.render();
                }
            }
        })
        $('#botton').click(function () {
            var province;
            var city;
            if($('#quiz1').val() == '请选择省份'){
                province = ''
            }else{
                province = $('#quiz1').val()
            }
            if($('#quiz2').val() == '请先选择省份'){
                city = ''
            }else{
                city = $('#quiz2').val()
            }
            var tableInt = table.render({
                elem: '#test'
                , url: '/plbBank/getDataByBank'
                ,where: {
                    province: province,
                    city: city,
                    name: $('#name').val(),
                }
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data, //解析数据列表，
                        "count": res.totleNum, //解析数据长度
                    };
                }
                , cols: [[
                    {type: 'radio'}
                    , {field: 'name', title: '银行名称',width:300}
                    ,{field:'country',title:'国家地区'}
                    ,{field: 'union_number', title: '编码', hide:true}
                    ,{field:'province',title:'省份'}
                    ,{field:'city',title:'城镇'}
                ]]
                , page: true
            });
            $('table').css('text-align','center')
            $('th').css('text-align','center')
            $('td').css('text-align','center')
        })

        $('#reset').click(function () {
            $('#quiz2').html('<option>请先选择省份</option>')
        })

    })
    $('table').css('text-align','center')
    $('th').css('text-align','center')
    $('td').css('text-align','center')

</script>
</body>
</html>
