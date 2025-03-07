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
    <title>商品利润</title>
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
    <style>
        .mbox{
            padding: 8px;
        }
        .item img{
            width: 40px;
        }
        .items{
            background-color: #f2f2f2;
            text-align: center;
            height: 30px;
            line-height: 30px;
        }
        .layui-form-checkbox[lay-skin=primary]{
            margin-top: 7px;
            margin-left: 13px;
        }
        .layui-table-cell{
            height:auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
        }
        .layui-form-item{
            margin-bottom: 0px;
        }
        #table1 .layui-table-view .layui-table td, .layui-table-view .layui-table th {
            padding: 0px 0px;
            border-top: none;
            border-left: none;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="item">
        <img src="../img/lirun.png" alt="" style="margin: 0 5px 0 20px;width: 32px;"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">商品利润</span>
    </div>
    <hr class="layui-bg-blue">
    <div id="ajaxforms" style="margin-top: 10px;">
        <div class="layui-form" style="display: flex">
            <div class="layui-form-item queryStock">
                <label class="layui-form-label" style="width: 146px;padding: 9px 0px">请选择您要查询的仓库:</label>
                <div class="layui-input-block" style="margin-left: 155px;">
                    <select name="warehouse" lay-verify="required" class="warehouseName" lay-filter="warehouse">
                        <%--<option value="">请选择</option>--%>
                    </select>
                </div>
            </div>
            <div style="margin-left: 18px;">
                <button type="button" class="layui-btn layui-btn-sm sure" style="margin-top: 5px;">确定</button>
                <%--<input type="checkbox" name="" title="是否设置库存报警数量" lay-skin="primary" checked>--%>
            </div>
        </div>
        <div class="layui-inline" style="display: none;">
            <label class="layui-form-label">验证日期</label>
            <div class="layui-input-inline">
                <input type="text" name="date" id="date" lay-verify="date"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline" style="display: none">
            <label class="layui-form-label">验证日期</label>
            <div class="layui-input-inline">
                <input type="text" name="date" id="date1" lay-verify="date"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div id="table1">
        <table id="stock" lay-filter="stock" ></table>
    </div>
    <%--头部--%>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button type="button" class="layui-btn  layui-btn-sm" lay-event="query" >查询</button>
            <button type="button" class="layui-btn  layui-btn-sm" lay-event="yearAll">全部商品本年统计</button>
            <button type="button" class="layui-btn  layui-btn-sm" lay-event="monthAll">全部商品本月统计</button>
        </div>
    </script>
</div>

<script>
    var warehouseName
    var val = ""
    var month = ""
    var year = ""
    var waText
    var qqq
    layui.use(['form', 'table','laydate'],function(){
        var form = layui.form;
        var table=layui.table;
        var laydate = layui.laydate;

        var productTypeId; //商品大类的id
        var warehouseId  //仓库的id
        var supplierId;  //供货商的id
        var enterId; //获取的是表格行数据的id
        form.render()
        laydate.render({
            elem: '#date',
            type: 'month'
        });
        laydate.render({
            elem: '#date1',
            type: 'year'
        });
        $('#date').val(nowformat)
        $('#date1').val(yearformat)

        var datas
        $(function() {
            //第一个
            var valuenone='';

            //仓库的ajax
            $.ajax({
                url:'/invWarehouse/selectInvInfo',
                dataType:'json',
                type:'get',
                success:function(res){
                    valuenone=res.obj[0].warehouseId;
                    var strs = ''
                    for(var i=0;i<res.obj.length;i++){
                        datas = res.obj[i].warehouseName
                        strs += '<option  title="' + res.obj[i].warehouseName + '" value="' + res.obj[i].warehouseId + '">' +  res.obj[i].warehouseName + '</option>'
                    }
                    $('.warehouseName').append(strs);
                    $('select[name="warehouse"]').val(valuenone);
                    waText=$('select[name="warehouse"]').find("option:selected").text();
                    form.render('select');
                    warehouseName = $('.warehouseName').val()
                    set(warehouseName,month)
                }
            })
        });

        month = $('#date').val()
        year = $('#date1').val()

        $('.sure').on('click',function () {
            waText=$('select[name="warehouse"]').find("option:selected").text();
            qqq = $(".queryStock select[name='warehouse']").val()
            set(qqq,month)
        })
        waText=$('select[name="warehouse"]').find("option:selected").text();
        $('.queryStock select[title=""]')
        //第一个实例
        function set(val,month,data){
            if (data===undefined){
                data= {
                    warehouseId:val,
                    enterIndates:month
                }
            }
            var table1=table.render({
                elem: '#stock'
                ,url: '/poCommodityEnter/CommodityStocks' //数据接口
                ,toolbar: '#toolbarDemo'
                ,where:data
                ,page: true //开启分页
                ,width:$(window).width()+160
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.obj,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,cols: [[ //表头
                    {field: 'productTypeName', title: '商品大类',rowspan:2,width:90}
                    ,{field: 'enterName', title: '商品名称',rowspan:2,width:90}
                    ,{field: 'enterSpecs', title: '商品规格',rowspan:2,width:90}
                    ,{field: 'enterCode', title: '商品编码',rowspan:2,width:90 }
                    ,{field: 'sign', title: '进货统计',colspan:4}
                    ,{field: 'score', title: '销售统计',colspan:4}
                    ,{field: 'classify', title: '销售成本统计',colspan:2}
                    ,{field: 'wealth', title: '库存统计',colspan:2}
                ],
                    [ //表头
                        {field: 'enterPurchase', title: waText+'进货数',templet:function(d){
                                return d.map.Enter_Purchase
                            }}
                        ,{field: 'enterMonthPurchase', title: new Date().getMonth() + 1+'月进货数',templet:function(d){
                            return d.map.Enter_month_Purchase
                        }}
                        ,{field: 'enterPrice', title: waText+'进货金额',templet:function (d) {
                            if(d.map.Enter_price == undefined||d.map.Enter_price==''){
                                return ''
                            }else{
                                return d.map.Enter_price
                            }
                        }}
                        ,{field: 'enterPriceMonth', title: waText+(new Date().getMonth() + 1) +'月进金额',templet:function(d){
                            if(d.map.Enter_price_month == undefined || d.map.Enter_price_month == ''){
                                return ''
                            }else{
                                return d.map.Enter_price_month
                            }
                        }}
                        ,{field: 'enterTransfer', title: waText+'出货数',templet:function(d){
                            if( d.map.Enter_Transfer == '' ||  d.map.Enter_Transfer == undefined){
                                return ''
                            }else{
                                 return d.map.Enter_Transfer
                            }
                        }}
                        ,{field: 'enterMonthTransfer', title: waText+(new Date().getMonth() + 1)+'月出货数',templet:function(d){
                            if(d.map.Enter_month_Transfer == undefined || d.map.Enter_month_Transfer==''){
                                return ''
                            }else{
                               return d.map.Enter_month_Transfer
                            }
                        }}
                        ,{field: 'outPrice', title: waText+'出货金额',templet:function (d) {
                            if(d.map.Out_price == undefined || d.map.Out_price==''){
                                return ''
                            }else{
                                return d.map.Out_price
                            }
                        }}
                        ,{field: 'outPriceMonth', title: waText+(new Date().getMonth() + 1)+'月出货金额',templet:function (d) {
                            if(d.map.Out_price_month == undefined || d.map.Out_price_month== ''){
                                return ''
                            }else{
                                return d.map.Out_price_month
                            }
                        }}
                        ,{field: 'enterAllPrice', title: waText+'仓库累计销售成本',templet:function (d) {
                            if(d.map.Enter_all_price == undefined || d.map.Enter_all_price == ''){
                                return ''
                            }else{
                                return d.map.Enter_all_price
                            }
                        }}
                        ,{field: 'enterAllPriceMonth', title: waText+(new Date().getMonth() + 1)+'月销售成本',templet:function (d) {
                            if(d.map.Enter_all_price_month == undefined || d.map.Enter_all_price_month == ''){
                                return ''
                            }else{
                                return d.map.Enter_all_price_month
                            }
                        }}
                        ,{field: 'enterTotal', title: waText+'库存数',templet:function (d) {
                            if(d.map.Enter_total == undefined || d.map.Enter_total==''){
                                return ''
                            }else{
                                return  d.map.Enter_total
                            }

                        }}
                        ,{field: 'enterAllTotalPrice', title: waText+'库存金额',templet:function (d) {
                            if(d.map.Enter_all_total_price == undefined || d.map.Enter_all_total_price == ''){
                                return ''
                            }else{
                                return d.map.Enter_all_total_price
                            }
                        }}
                    ],
                ]
            });
        }

        /*监听第一个表格得头部*/
        table.on('toolbar(stock)', function(obj) {
            var event = obj.event;
            switch (event) {
                case 'query':
                    layer.open({
                        type: 1 ,//Page层类型
                        area: ['800px', '90%'],
                        title: '按时间查询',
                        maxmin: true ,//允许全屏最小化
                        content: '<div class="layui-form chaXun">' +
                            '<div class="shiJian" style="width: 530px;margin: 0px auto">' +
                            '<input lay-filter="day" type="radio" name="time" value="" title="按日查询" checked>' +
                            '<input lay-filter="month" type="radio" name="time" value="" title="按月查询" >\n' +
                            '<input lay-filter="year" type="radio" name="time" value="" title="按年查询" >\n' +
                            '<input lay-filter="time" type="radio" name="time" value="" title="按时间段查询" >\n' +
                            '</div>' +
                            '<div id="bidates">' +
                            '<div style="margin: 10px 0px;" id="day"><span style="margin-left:28%">请选择(必填)</span>' +
                            '<input type="text" class="layui-input" name="enterIndates" autocomplete="off" id="dayQuery" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            '<div style="display: none;margin: 10px 0px;"  id="month">' +
                            '<span style="margin-left:28%">请选择(必填)</span>' +
                            '<input type="text" class="layui-input" name="enterIndates" id="monthQuery1" autocomplete="off" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            '<div style="display: none;margin: 10px 0px;"id="year"><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="enterIndates" id="yearQuery" autocomplete="off" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            '<div style="display: none;margin: 10px 0px;" id="time"><span style="margin-left:17%">请选择(必填)</span><span style="margin-left:5%">从</span><input type="text" class="layui-input" autocomplete="off" id="timeQuery1" name="enterIndate" style="display: inline-block;width: 150px;">至<input type="text" class="layui-input" id="timeQuery2"  name="enterIndates" autocomplete="off" style="display: inline-block;width: 150px;"></div>'+
                            '</div>' +
                            '<div class="items">按商品内容查询:</div>' +
                            '<div style="display: flex;margin-left: 30px;margin-top: 8px;"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label">商品大类</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="productType" lay-verify="required" class="aaaa" lay-filter="productType">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">商品名称</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="enterName" lay-verify="required" lay-filter="enterName">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div style="display: flex;margin-left: 30px;"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">规格(型号颜色)</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="enterSpecs" lay-verify="required" lay-filter="enterSpecs">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">商品编码</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '<input type="text" name="enterCode"  autocomplete="off"  readonly="readonly" class="layui-input">' +
                            '<input type="hidden" name="enterId" class="layui-input">' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div class="items">按人员查询:</div>\n' +
                            '<div style="display: flex;margin-left: 30px;margin-top: 10px"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label">客户</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="customerName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label">进货人</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="userName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div><div class="items">按仓库查询:</div>' +
                            '<div style="display: flex;margin-left: 30px;margin-top: -4px;margin-bottom: 11px"><div class="layui-form-item" style="margin-top:18px">\n' +
                            '    <label class="layui-form-label" >仓库</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="warehouseName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>'+
                            // '<div style="width: 333px;margin-left:44px"><input type="radio" name="situation" value="" title="只显示该仓库情况" checked>\n' +
                            // '<input type="radio" name="situation" value="" title="显示所有仓库汇总和该仓库情况(以便比对)" >' +
                            // '</div>'+
                            '</div>' +
                            '</div>'+
                            '<div>' +
                            '<div class="items">按库存数量查询(以下2个全勾上将显示所有商品)</div>' +
                            '<div class="check" style="margin-left:52px;margin-top: 25px;">' +
                            '<input type="checkbox" name="Judge" value=">" title="查询库存数量大于零的所有商品" lay-skin="primary" >\n' +
                            '<input type="checkbox"  name="Judge" value=""  title="查询库存数为零的所有商品" lay-skin="primary"> \n' +
                            '</div>'+
                            '</div>'+
                            '</div>',
                        btn: ['确定', '取消'],
                        success: function (res) {
                            form.render()
                            laydate.render({
                                elem: '#dayQuery' //按日查询
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
                            laydate.render({
                                elem: '#timeQuery1' //指定元素
                            })
                            laydate.render({
                                elem: '#timeQuery2' //指定元素
                            });
                            form.on('radio(day)', function (data) {
                                $('#day').show()
                                $('#month').hide()
                                $('#year').hide()
                                $('#time').hide()
                                $('#monthQuery1').val('')
                                $('#yearQuery').val('')
                                $('#timeQuery1').val('')
                                $('timeQuery2').val('')

                            });
                            form.on('radio(month)', function (data) {
                                $('#day').hide()
                                $('#month').show()
                                $('#year').hide()
                                $('#time').hide()
                                //清楚点过的input的值
                                $('#dayQuery').val('')
                                $('#yearQuery').val('')
                                $('#timeQuery1').val('')
                                $('timeQuery2').val('')
                            });
                            form.on('radio(year)', function (data) {
                                $('#day').hide()
                                $('#month').hide()
                                $('#year').show()
                                $('#time').hide()
                                //清楚点过的input的值
                                $('#dayQuery').val('')
                                $('#monthQuery1').val('')
                                $('#timeQuery1').val('')
                                $('timeQuery2').val('')
                            });
                            form.on('radio(time)', function(data){
                                $('#day').hide()
                                $('#month').hide()
                                $('#year').hide()
                                $('#time').show()
                                //清楚点过的input的值
                                $('#dayQuery').val('')
                                $('#monthQuery1').val('')
                                $('#yearQuery').val('')
                            });
                            laydate.render({
                                elem: '#timeQuery1' //指定元素
                            })
                            laydate.render({
                                elem: '#timeQuery2' //指定元素
                            });
                            //商品大类回显
                            $.ajax({
                                url: "/productType/selectProductTypeInfo",
                                type: 'get',
                                dataType: "JSON",
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
                                        str += '<option value="' + data.obj[i].productTypeId + '">' + data.obj[i].productTypeName + '</option>'
                                    }
                                    $('.chaXun [name="productType"]').html(str);
                                    form.render()
                                }
                            })
                            //商品名称回显
                            form.on('select(productType)', function(data){
                                var productTypeId=data.value
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType="+productTypeId,
                                    type: 'get',
                                    dataType: "JSON",
                                    success: function (data) {
                                        var str = '<option value="">请选择</option>';
                                        for (var i = 0; i < data.obj.length; i++) {
                                            str += '<option value="' + data.obj[i].enterName + '">' + data.obj[i].enterName + '</option>'
                                        }
                                        $('.chaXun [name="enterName"]').html(str);
                                        form.render()
                                    }
                                })
                            });
                            //规格(型号颜色)回显
                            form.on('select(enterName)', function(data){
                                var enterName=data.value
                                var productTypeId=$('.chaXun [name="productType"] option:checked').val()
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType="+productTypeId+'&enterName='+enterName,
                                    type: 'get',
                                    dataType: "JSON",
                                    success: function (data) {
                                        var str = '<option value="">请选择</option>';
                                        for (var i = 0; i < data.obj.length; i++) {
                                            str += '<option value="' + data.obj[i].enterSpecs + '">' + data.obj[i].enterSpecs + '</option>'
                                        }
                                        $('.chaXun [name="enterSpecs"]').html(str);
                                        form.render()
                                    }
                                })
                            });
                            //商品编码回显
                            form.on('select(enterSpecs)', function(data){
                                var enterName=$('.chaXun [name="enterName"] option:checked').val()
                                var productTypeId=$('.chaXun [name="productType"] option:checked').val()
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType="+productTypeId+'&enterName='+enterName,
                                    type: 'get',
                                    dataType: "JSON",
                                    success: function (data) {
                                        $('.chaXun [name="enterCode"]').val(data.obj[0].enterCode);
                                        $('.chaXun [name="enterId"]').val(data.obj[0].enterId);
                                    }
                                })
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
                                url: "/poCommodityEnter/selectUsers",
                                type: 'get',
                                dataType: "JSON",
                                success: function (data) {
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
                                        console.log(data.obj[i].userId)
                                        str += '<option value="' + data.obj[i].userId + '">' + data.obj[i].userName + '</option>'
                                    }
                                    $('.chaXun [name="userName"]').html(str);
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

                        },
                        yes:function (index) {
                            var showday;
                            var endday;
                            var checkeds = "";
                            //判断时间的
                            if($('#dayQuery').parent('div').css('display')=='block'){
                                if($('#dayQuery').val()==""){
                                    layer.msg('请选择按日查询', {icon: 2}); return false
                                }else{
                                    showday = $('#dayQuery').val()
                                }
                            }else if($('#monthQuery1').parent('div').css('display')=='block'){
                                if($('#monthQuery1').val() == ""){
                                    layer.msg('请选择按月查询', {icon: 2}); return false
                                }else{
                                    showday = $('#monthQuery1').val()
                                }
                            }else if($('#yearQuery').parent('div').css('display')=='block'){
                                if($('#yearQuery').val() == ""){
                                    layer.msg('请选择按年查询', {icon: 2}); return false
                                }else{
                                    showday = $('#yearQuery').val()
                                }
                            }else if($('#timeQuery1').parent('div').css('display')=='block'){
                                if($('#timeQuery1').val() == "" || $('#timeQuery2').val()==""){
                                    layer.msg('请选择按时间段查询', {icon: 2}); return false
                                }else{
                                    endday = $('#timeQuery1').val()
                                    showday = $('#timeQuery2').val()
                                }
                            }
                            //判断复选框是否被选中
                            if($('.check input[type=checkbox]:checked').val() == ">"){
                                checkeds = $('.check input[type=checkbox]:checked').val()
                            }else if($('.check input[type=checkbox]:checked').val() == "<"){
                                checkeds = $('.check input[type=checkbox]:checked').val()
                            }else{
                                checkeds = $('.check input[type=checkbox]:checked').val()
                            }
                            var productType = $('.chaXun select[name="productType"] option:checked').val()//大类
                            var enterName = $('.chaXun select[name="enterName"] option:checked').val() //名称
                            var enterSpecs = $('.chaXun select[name="enterSpecs"] option:checked').val() //颜色
                            var enterCode = $('.chaXun input[name="enterCode"]').val()
                            // var enterId=$('.chaXun [name="enterId"]').val();
                            var customerName=$('.chaXun select[name="customerName"] option:checked').val() //客户
                            var userId=$('.chaXun select[name="userName"] option:checked').val() //进货人
                            var warehouseName=$('.chaXun  [name="warehouseName"] option:checked').val() //仓库
                            layer.close(index)
                            set('','',{
                                enterIndates:showday,
                                enterIndate:endday,
                                productType:productType,
                                enterName:enterName,
                                enterSpecs:enterSpecs,
                                enterCode:enterCode,
                                enterIndates:showday,  //时间
                                enterId:enterId,
                                customerName:customerName,
                                userId:userId,
                                warehouseName:warehouseName,
                                enterNum:0,
                                Judge:checkeds,
                                warehouseId:$(".queryStock select[name='warehouse']").val()
                            });
                        }
                    });
                    break;
                case 'yearAll':
                    set('',year);
                    break;
                case 'monthAll':
                    set('',month)
                    break;
            }
        })
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
    function yearformat() {
        var  nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        nstr = nyear;
        return nstr;
    }
</script>

</body>
</html>