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
    <title>员工销售业绩</title>
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
        .mbox{
            padding: 8px;
        }
        .bg{
            background-color: #e6e6e6;
        }
        .p2 span {
            font-size: 14px;
            background-color: #2b7fe0;
            padding: 4px 18px;
            border-radius: 3px;
            color: #fff;
            cursor: pointer;
        }
        .newpop .list_group {
            margin: 20px 0;
        }
        .list_group .toryList {
            display: inline-block;
            margin-right: 20px;
            width: 100px;
            height: 26px;
        }
        .list_group .save_w {
            width: 412px;
            height: 28px;
            border:1px solid #ccc;
            border-radius: 3px;
        }
        .bg{
            background-color: #e6e6e6;
        }
        .item{
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="item">
        <img src="../img/yeji.png" alt="" style="margin: 0 5px 0 20px;width: 32px"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">员工销售业绩</span>
    </div>
    <hr class="layui-bg-blue">
    <div>
        <table id="subWarehouse" lay-filter="subWarehouse"></table>
    </div>
    <div class="layui-inline" style="display: none">
        <label class="layui-form-label">验证日期</label>
        <div class="layui-input-inline">
            <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>
</div>

<script>
    var warehouseId; //定义当前行得id值
    layui.use(['table','form','laydate'], function(){
        var table = layui.table;
        var form=layui.form;
        var laydate = layui.laydate;
        $('#date').val(nowformat())
        //第一个实例
        var tableInts=table.render({
            elem: '#subWarehouse'
            ,url:'/profit/employeeSales'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,toolbar:'<div style="padding: 10px 0px 6px 13px;">\n' +
                '        <button type="button" class="layui-btn layui-btn-sm" lay-event="search">查询</button>\n' +
                '        <button type="button" class="layui-btn layui-btn-sm"  lay-event="allsear">全部员工销售业绩</button>\n' +
                '        <button type="button" class="layui-btn layui-btn-sm"  lay-event="monthsear">本月员工销售业绩</button>\n' +
                '    </div>'
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data":res.object,
                    "count": res.totleNum, //解析数据长度
                };
            }

            ,title: '用户数据表'
            ,cols: [[ //表头
                {field: 'username', title: '员工名',align:'center'}
                ,{field: 'SaleCount', title: new Date().getMonth() + 1+'月销售数量合计',align:'center'}
                ,{field: 'SaleMoneyCount', title: new Date().getMonth() + 1+'月销售金额合计',align:'center'}
                ,{field: 'saleShipPrice', title: new Date().getMonth() + 1+'月销售成本',align:'center'}
                        ,{field: 'realPrice', title: new Date().getMonth() + 1+'月员工业绩',align:'center'}

            ]]
            ,page: true
        });

        /*点击当前行数据*/
        table.on('row(subWarehouse)', function (obj) {
            var data = obj.data
            warehouseId = data.warehouseId
            $(this).addClass('bg').siblings().removeClass('bg')
        })
        var enterId;
        table.on('toolbar(subWarehouse)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'search':
                    layer.open({
                        type: 1 ,//Page层类型
                        area: ['100%', '100%'],
                        title: '按时间查询'
                        ,btn: ['确定', '取消'],//只是为了演示
                        shadeClose: true, //点击遮罩关闭
                        maxmin: true ,//允许全屏最小化
                        content:'<div class="chaXun" style="margin-top: 20px">\n' +
                            '<form class="layui-form" action="">\n'+
                            '        <div class="layui-inline">\n' +
                            '            <label class="layui-form-label">按日查询</label>\n' +
                            '            <div class="layui-input-inline">\n' +
                            '                <input type="text" name="date" id="dateday" lay-verify="date"  autocomplete="off" class="layui-input">\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '        <div class="layui-inline">\n' +
                            '            <label class="layui-form-label">按月查询</label>\n' +
                            '            <div class="layui-input-inline">\n' +
                            '                <input type="text" name="date" id="datemonth" lay-verify="date"  autocomplete="off" class="layui-input">\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '        <div class="layui-inline">\n' +
                            '            <label class="layui-form-label">按年查询</label>\n' +
                            '            <div class="layui-input-inline">\n' +
                            '                <input type="text" name="date" id="dateyear" lay-verify="date"  autocomplete="off" class="layui-input">\n' +
                            '            </div>\n' +
                            '        </div> \n' +
                            '   <div class="layui-inline">\n' +
                            '    <label class="layui-form-label">客户</label>\n' +
                            '    <div class="layui-input-inline">\n' +
                            '      <select name="customerName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div style="margin-top: 20px">\n' +
                            '<div class="layui-inline">\n' +
                            '    <label class="layui-form-label">仓库</label>\n' +
                            '    <div class="layui-input-inline" style="width: 182px">\n' +
                            '      <select name="warehouseName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +

                            '<div class="layui-inline" style="margin-left: 3px">\n' +
                            '    <label class="layui-form-label">出货人</label>\n' +
                            '    <div class="layui-input-inline" style="width: 183px;">\n' +
                            '      <select name="shipper" id="shipper" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>\n' +
                            '</div>'+

                            '   <div>\n' +
                            '        <table id="demo" lay-filter="test"></table>\n' +
                            '    </div>'+
                            '<form>\n'+
                            '</div>',
                        success: function (res) {
                            laydate.render({
                                elem: '#dateday',
                            });
                            laydate.render({
                                elem: '#datemonth',
                                type:'month'
                            });
                            laydate.render({
                                elem: '#dateyear',
                                type:'year'
                            });
                            //客户回显
                            $.ajax({
                                url: "/customer/potentialCustomer",
                                type: 'get',
                                dataType: "JSON",
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
                                        str += '<option value="' + data.obj[i].customerId + '">' + data.obj[i].customerName + '</option>'
                                    }
                                    $('.chaXun [name="customerName"]').html(str);
                                    form.render()
                                }
                            })
                            //出货人回显
                            $.ajax({
                                url: "/salesShipment/selectUsers",
                                type: 'get',
                                dataType: "JSON",
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
                                        str += '<option value="' + data.obj[i].userId + '">' + data.obj[i].shipper + '</option>'
                                    }
                                    $('.chaXun [name="shipper"]').html(str);
                                    form.render()
                                }
                            })
                            //仓库回显
                            $.ajax({
                                url: "/invWarehouse/selectInvInfo",
                                type: 'get',
                                dataType: "JSON",
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
                                        str += '<option value="' + data.obj[i].warehouseId + '">' + data.obj[i].warehouseName + '</option>'
                                    }
                                    $('.chaXun [name="warehouseName"]').html(str);
                                    form.render()
                                }
                            })
                            //第一个实例
                            var tableIns = table.render({
                                elem: '#demo'
                                , url: '/salesShipment/selectAllSales' //数据接口
                                , page: true //开启分页
                                , cols: [[ //表头
                                    {type:'radio'}
                                    ,{field: 'id', title: '序号' ,hide:true }
                                    ,{field: 'productType', title: '商品大类'  }
                                    , {field: 'enterName', title: '商品名称', }
                                    , {field: 'enterSpecs', title: '商品规格',}
                                    , {field: 'enterCode', title: '商品编码'}
                                    , {field: 'shipmentDateStr', title: '出货日期',width:120}
                                    , {field: 'shipmentNum', title: '出货数量'}
                                    , {field: 'shipmentPrice', title: '出货单价'}
                                    , {field: 'shipmentTotal', title: '合计', }
                                    , {field: 'shipmentPaid', title: '已付金额'}
                                    , {field: 'shipmentArrears', title: '欠款金额'}
                                    , {field: 'customerName', title: '客户'}
                                    , {field: 'shipper', title: '出货人'}
                                    , {field: 'warehouseName', title: '仓库', }
                                    , {field: 'documentNo', title: '单据号', }
                                    , {field: 'shipmentRemark', title: '备注', }
                                    /*  , {title: '操作', align: 'center', toolbar: '#barDemo', width: 150}*/
                                ]]
                                , parseData: function (res) { //res 即为原始返回的数据
                                    return {
                                        "code": 0, //解析接口状态
                                        "data": res.obj, //解析数据列表
                                        "count": res.totleNum, //解析数据长度
                                    };
                                }
                            });
                            //监听行单击事件
                            table.on('row(test)', function (obj) {
                                var data = obj.data
                                enterId =data.enterId
                            })

                        },
                        yes:function (index) {
                            var customerName=$('.chaXun select[name="customerName"] option:checked').val()
                            var shipper=$('.chaXun select[name="shipper"] option:checked').val()
                            var warehouseName=$('.chaXun  [name="warehouseName"] option:checked').val()
                            tableInts.reload({
                                url:'/profit/employeeSales',
                                where:{
                                    year:$('#dateyear').val(),
                                    month:$('#datemonth').val(),
                                    day:$('#dateday').val(),
                                    customerId:customerName,
                                    userId:shipper,
                                    warehouseId:warehouseName,
                                    enterId:enterId
                                }
                            })
                            enterId=''
                            layer.close(index)
                        }
                    });
                    break;
                case 'allsear':
                    tableInts.reload({
                        url:'/profit/employeeSales',
                        where:{}
                    })
                    break;
                case 'monthsear':
                    tableInts.reload({
                        url:'/profit/employeeSales',
                        where:{
                            month:$('#date').val()
                        }
                    })
                    break;
            };
        });
    });
    function nowformat() {
        var  nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        var nmonth = now.getMonth()+1;
        var nday = now.getDate();
        if(nmonth<10){
            nmonth = "0"+nmonth;
        }
        nstr = nyear+"-"+nmonth;
        return nstr;
    }
</script>
</body>
</html>