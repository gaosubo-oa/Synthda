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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>收款单</title>
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
</head>
<style>
    .mbox{
        padding:8px
    }
    .item{
        margin-top: 10px;
    }
    .layui-form-label{
        width:60px
    }
    #del_1:hover{
        cursor: pointer;
    }
</style>
<body>
<div class="mbox">
    <div class="item">
        <img src="../img/qita.png" alt="" style="margin: 0 5px 0 20px;width: 32px"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">其他收支</span>
    </div>
    <hr class="layui-bg-blue">
    <form class="layui-form" action="" style="margin-top: 20px;">
        <div class="layui-inline">
            <label class="layui-form-label" >按年查询</label>
            <div class="layui-input-inline" style="width: 170px;">
                <input type="text" name="date"  id="date1" lay-verify="date" placeholder="按年查询" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">按月查询</label>
            <div class="layui-input-inline" style="width: 170px;">
                <input type="text" name="date" id="datemonth1" lay-verify="date" placeholder="按年查询" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">仓库</label>
            <div class="layui-input-inline" style="width:171px">
                <select lay-verify="required" class="warers" id="wares"  lay-filter="warehouse">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <button type="button" class="layui-btn  aa" style="margin-left: 20px;">查询</button>
    </form>
    <div style="    margin-left: 16px;margin-top: 15px;color: #666;">
        累计收入=经营收入+销售出货+采购退货;  累计支出=经营支出+采购进货+销售退货; 最终受益=累计收入-累计支出
    </div>
    <div>
        <table class="layui-hide" id="testreceipt" lay-filter="testreceipt"></table>
    </div>
</div>
</body>
</html>
<script>
    layui.use(['form', 'layedit', 'laydate','table'], function() {
        var form = layui.form
        var layer = layui.layer
        var layedit = layui.layedit
        var table = layui.table
        var laydate = layui.laydate
        laydate.render({
            elem: '#date1',
            type:'year'
        });
        laydate.render({
            elem: '#datemonth1',
            type:'month'
        });

        form.render()
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
            elem: '#testreceipt'
            ,url:'/salesShipment/shipOtherCount'
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }],
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.object  , //解析数据列表，
                    "count": res.totleNum, //解析数据长度
                };
            }
            ,cols: [[
                {field:'outPrice', title:'采购退货'}
                ,{field:'receiptPrice', title:'经营收入'}
                ,{field:'saleShipPrice2', title:'销售总计'}
                ,{field:'saleReturnPrice2', title:' 销售退货'}
                ,{field:'realPrice3', title:'商品利润'}
                ,{field:'jingyinglirun', title:'经营利润'}
                ,{field:'paymentPrice', title:' 经营支出'}
                ,{field:'enterPrice', title:' 采购进货'}
                ,{field:'totalEnterPrice', title:' 累积收入'}
                ,{field:'totalOutPrice', title:' 累积支出'}
                ,{field:'endPrice', title:' 最终收益'}
            ]]
            ,page: true
        });
        $('.aa').on('click',function () {
            tableInt.reload({
                url:'/salesShipment/shipOtherCount',
                where:{
                    year:$('#date1').val(),
                    month:$('#datemonth1').val(),
                    warehouseId:$('#wares').val(),
                }
            })
        })
    })

</script>