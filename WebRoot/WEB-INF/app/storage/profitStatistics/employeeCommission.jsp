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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>员工提成</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <style>
        body{
            background: #fff;
        }
        .mbox{
            padding: 8px;
        }
        .items{
            background-color:#f2f2f2;
            /*text-align: center;*/
            height: 30px;
            line-height: 30px;
            margin-bottom:10px;
            padding-left: 10px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="margin-top: 10px">
        <img src="../img/ticheng.png" alt="" style="margin: 0 5px 0 20px;width: 32px"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">员工提成</span>
    </div>
    <hr class="layui-bg-blue">
    <form class="layui-form" action="">
        <div class="items">选择员工提成</div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 35px;">
                <input type="radio" name="flag" value="0" title="按销售金额提成" checked="">
                <input type="radio" name="flag" value="1" title="按已付金额提成">
                <input type="radio" name="flag" value="2" title="按销售利润提成">
                <input type="radio" name="flag" value="3" title="按销售数量提成">
                <input type="radio" name="flag" value="4" title="按还款金额提成">
            </div>
        </div>
        <div class="layui-block" style="margin-bottom:10px">
            <label class="layui-form-label">提成比例</label>
            <div class="layui-input-inline" style="margin-bottom: 10px;">
                <input type="text" name="price" lay-verify="required|number"  oninput = "value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" autocomplete="off" class="layui-input">
            </div>
            <span style="color:#0c8587">如输入"0.05"则按5%的比例进行提成</span>
        </div>
        <div class="items">选择要统计提成的时间段</div>
        <div style="margin: 20px auto;">
            <div class="layui-inline">
                <label class="layui-form-label">按日提成</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="dayQuery" lay-verify="date"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">按月提成</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="monthQuery1" lay-verify="date" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">按年提成</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="yearQuery" lay-verify="date"  autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="items">员工销售业绩提成表</div>
        <div class="layui-block"  style="margin:20px auto;">
            <label class="layui-form-label">仓库</label>
            <div class="layui-input-inline" style="width:171px">
                <select lay-verify="required" class="warers" id="wares"  lay-filter="warehouse">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
    </form>
    <table class="layui-hide" id="test" lay-filter="test"></table>
</div>
</body>
</html>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="commission">产生提成</button>
    </div>
</script>
<script>
    layui.use(['form', 'laydate','table'], function() {
        var form = layui.form
        var layer = layui.layer
        var table =layui.table
        var laydate = layui.laydate;
        form.render()
        laydate.render({
            elem: '#dayQuery' //指定元素
        });
        laydate.render({
            elem: '#monthQuery1' //指定元素
            , type: 'month'
            // , format: 'MM'
        });
        laydate.render({
            elem: '#yearQuery' //指定元素
            , type: 'year'
        });
        $('input[name="price"]').val('0.05')
        /*仓库下拉框的ajax*/
        $.ajax({
            url:'/invWarehouse/selectInvInfo',
            dataType:'json',
            type:'get',
            success:function(res){
                var strs = ''
                for(var i=0;i<res.obj.length;i++){
                    strs += '<option  title="' + res.obj[i].warehouseName + '" value="' + res.obj[i].warehouseId + '">' +  res.obj[i].warehouseName + '</option>'
                }
                $('.warers').append(strs)
                form.render('select');
            }
        })
       var tableInt = table.render({
            elem: '#test'
            ,url:'/profit/employeeCommission'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,
//            处理后台数据格式
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data":res.object,
                    "count": res.totleNum, //解析数据长度
                };
            },
           where:{
               flag:$('input[name="flag"]').val(),
               price:$('input[name="price"]').val(),
           },
           cols: [[
                {field:'userName', title:'员工姓名'}
                ,{field:'SaleCount', title:new Date().getMonth() + 1+'月销售数量合计'}
                ,{field:'SaleMoneyCount', title:new Date().getMonth() + 1+'月销售金额合计',align:'center'}
                ,{field:'AmountMoney', title:new Date().getMonth() + 1+'月已付金额合计',align:'center'}
                ,{field:'realPrice', title:new Date().getMonth() + 1+'月员工业绩',align:'center'}
                ,{field:'RepaymentAmount', title:new Date().getMonth() + 1+'月还款金额',align:'center'}
                ,{field:'tiPrice', title:new Date().getMonth() + 1+'月销售提成金额',align:'center'}
            ]]
            ,page: true,
        });
        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'commission':
                    tableInt.reload({
                        url:'/profit/employeeCommission',
                        where:{
                            flag:$('input[name="flag"]').val(),
                            price:$('input[name="price"]').val(),
                            day:$('#dayQuery').val(),
                            year:$('#yearQuery').val(),
                            month:$('#monthQuery1').val(),
                            warehouseId:$('#wares').val(),
                        }
                    })
                    break;
            };
        });
    })
</script>
