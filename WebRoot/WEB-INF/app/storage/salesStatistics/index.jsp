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
    <title>销售统计</title>
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
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script src="../lib/echarts/echarts.common.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/echarts.min.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
</head>
<style>
    #histogram{
        width:600px;
        height: 400px;
        margin-left: 35px;
    }
    #Graph{
        width:600px;
        height: 400px;
        margin-left: 35px;
    }
    #monthzhu{
        width:750px;
        height: 400px;
        margin-left: 35px;
    }
    #monthqu{
        display: none;
        width:750px;
        height: 400px;
        margin-left: 35px;
    }
    #clientzhu{
        width:600px;
        height: 400px;
        margin-left: 35px;
    }
    #clientbing{
        display: none;
        width:600px;
        height: 400px;
        margin-left: 35px;
    }
    #employeepie{
        width:600px;
        height: 400px;
        margin-left: 35px;
    }
    .searchs{
        margin-top: 22px;
        margin-left: 32px;
        height: 32px;
        line-height: 32px;
    }
    .daysear{
        margin-top: 22px;
        margin-left: 32px;
        height: 32px;
        line-height: 32px;
    }
    .bg{
        background: #f2f2f2;
    }
    .items{
        background-color:#f2f2f2;
        text-align: center;
        height: 30px;
        line-height: 30px;
        margin-bottom:10px;
    }
</style>
<body>
<%--左侧切换得功能--%>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll Tab">
        <ul class="layui-nav layui-nav-tree layui-nav-side" style="background: #f2f2f2;">
            <li class="layui-nav-item" style="border: 1px solid #fff;"><a style="font-weight: bold; color:#000"onclick="show('compile1');" >月销售统计</a></li>
            <li class="layui-nav-item day" style="border: 1px solid #fff;"><a  style="font-weight: bold; color:#000" onclick="show('compile2')" style="overflow: auto">日销售统计</a></li>
            <li class="layui-nav-item employee" style="border: 1px solid #fff;"><a  style="font-weight: bold; color:#000"  onclick="show('compile3')"  >员工销售统计</a></li>
            <li class="layui-nav-item customer" style="border: 1px solid #fff;"><a  style="font-weight: bold; color:#000"  onclick="show('compile4')"  >客户销售统计</a></li>
            <li class="layui-nav-item arrears" style="border: 1px solid #fff;"><a  style="font-weight: bold; color:#000"  onclick="show('compile5')"  >客户欠款统计</a></li>
            <li class="layui-nav-item supplier" style="border: 1px solid #fff;"><a  style="font-weight: bold; color:#000"  onclick="show('compile6')"  >供货商欠款统计</a></li>
        </ul>
    </div>
</div>
<%--所有的主题内容--%>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <%--第一个--%>
    <div id="compile1" class="displayNone">
        <%--头部--%>
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;月销售统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:98%">
            </div>
        </div>
        <%--内容区域--%>
        <form  class="layui-form" action="" style="width: 99%;margin: 0 auto;background-color: #f2f2f2">
            <div class="layui-inline" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label">选择年度</label>
                <div class="layui-input-inline" style="width: 100px">
                    <input type="text" name="date" id="date" lay-verify="date"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline queryStock" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="width:30px">仓库</label>
                <div class="layui-input-inline" style="width: 150px">
                    <select name="warehouse" lay-verify="required" class="warehouseName" lay-filter="warehouse">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn searchs">查询</button>
            <div class="layui-form-item" style="display: inline-block;width: 250px;vertical-align: top;margin-top: 20px">
                <label class="layui-form-label">显示方式</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" lay-filter="histogram" value="0" title="柱状图" checked="">
                    <input type="radio" name="sex" lay-filter="curve"  value="1" title="曲线显示">
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block;width: 250px;vertical-align: top;margin-top: 20px">
                <label class="layui-form-label">显示内容</label>
                <div class="layui-input-block">
                    <input type="checkbox" value="1" lay-skin="primary" title="实际销售金额" lay-filter="actual" name="actual" checked="">
                    <input type="checkbox" value="2" lay-skin="primary" title="销售出货金额" lay-filter="actual" name="actual">
                    <input type="checkbox" value="3"  lay-skin="primary" title="销售退货金额" lay-filter="actual" name="actual">
                </div>
            </div>
        </form>
        <%--表格和图表--%>
        <div style="padding: 8px">
            <%--表格--%>
            <div style="float: left;width:44%;">
                <table class="layui-hide" id="test"></table>
            </div>
                <%--图表--%>
            <div style="float: left;width:55%">
                <div id="histogram"></div>
                <div id="Graph" style="display: none"></div>
            </div>
        </div>
    </div>
    <%--第二个--%>
    <div id="compile2" class="displayNone" style ="display: none;overflow: auto">
        <%--头部--%>
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;日销售统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:111%">
            </div>
        </div>
        <form  class="layui-form" action="" style="width: 109%;margin: 0 auto;background-color: #f2f2f2">
            <div class="layui-inline" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="margin-left: -31px;width:80px">选择年度</label>
                <div class="layui-input-inline" style="width: 150px">
                    <input type="text" name="date" id="date1" lay-verify="date" placeholder="请选择" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="margin-left: -10px;width: 43px">选择月</label>
                <div class="layui-input-inline" style="width: 150px">
                    <input type="text" name="date" id="date4" lay-verify="date"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline query" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="margin-left: -25px;width: 80px">选择仓库</label>
                <div class="layui-input-inline" style="width: 150px">
                    <select name="warehouse" lay-verify="required" class="warehouse" lay-filter="warehouse">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn daysear">查询</button>
            <div class="layui-form-item" style="display: inline-block;width: 250px;vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="width: 80px">显示方式</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" lay-filter="monthhistogram" value="男" title="柱状图" checked="">
                    <input type="radio" name="sex" lay-filter="monthcurve" value="女" title="曲线显示">
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block;width: 250px;margin-left: -54px; vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="width: 80px">显示内容</label>
                <div class="layui-input-block">
                    <input type="checkbox" value="1" name="dayname" lay-filter="dayname"  lay-skin="primary"  title="实际销售金额" checked="">
                    <input type="checkbox" value="2" name="dayname" lay-filter="dayname"  lay-skin="primary"  title="销售出货金额">
                    <input type="checkbox" value="3" name="dayname" lay-filter="dayname"  lay-skin="primary"  title="销售退货金额">
                </div>
            </div>
        </form>
        <%--表格和图表--%>
        <div style="padding: 8px">
            <%--表格--%>
            <div style="float: left;width: 44%">
                <table class="layui-hide" id="test1"></table>
            </div>
            <div style="float: left;width: 55%;">
                <div id="monthzhu"></div>
                <div id="monthqu"></div>
            </div>
        </div>
    </div>
    <%--第三个--%>
    <div id="compile3" class="displayNone" style ="display: none">
        <%--头部--%>
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;员工销售统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:98%" >
            </div>
        </div>
        <%--内容区域--%>
        <form  class="layui-form" action="" style="width: 99%;margin: 0 auto;background-color: #f2f2f2;height: 58px">
            <div class="layui-inline" style="vertical-align: top;margin-top: 10px">
                <label class="layui-form-label">选择年度</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="date2" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" style="vertical-align: top;margin-top: 10px">
                <label class="layui-form-label">选择月</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="date5" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" id="quering" style="vertical-align: top;margin-top: 10px">
                <label class="layui-form-label" style="margin-left: -25px">选择仓库</label>
                <div class="layui-input-inline">
                    <select name="modules" lay-verify="required" lay-search="" class="modules">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn daysear" id="staff" style="margin-top: 13px;">查询</button>
            <%--<input type="text" id="mouths" style="display: none">--%>
        </form>
        <%--表格和图表--%>
        <div style="padding: 8px">
            <%--表格--%>
            <div style="float: left;width:44%;">
                <table class="layui-hide" id="test2"></table>
            </div>
            <div style="float: left;width:55%">
                <div id="employeepie"></div>
            </div>
        </div>
    </div>
    <%--第四个--%>
    <div id="compile4" class="displayNone" style ="display: none">
        <%--头部--%>
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;客户销售统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:98%">
            </div>
        </div>
        <form  class="layui-form" action="" style="width: 99%;margin: 0 auto;background-color: #f2f2f2">
            <div class="layui-inline" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="margin-left: -27px">选择年度</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="date3" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label" style="margin-left: -40px">选择月</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="date6" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline storetoop" style="vertical-align: top;margin-top: 20px">
                <label class="layui-form-label cangku" style="margin-left: -25px">选择仓库</label>
                <div class="layui-input-inline">
                    <select name="modules" lay-verify="required" lay-search="" class="kesales">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn daysear" id="salesperson">查询</button>
            <input type="text" id="mouths" style="display: none">
            <div class="layui-form-item" style="display: inline-block;width: 250px;vertical-align: top;margin-top: 20px">
                <label class="layui-form-label">显示方式</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="男" lay-filter="clientzhu" title="柱状显示" checked="">
                    <input type="radio" name="sex" value="女" lay-filter="clientbing" title="折线图显示">
                </div>
            </div>
        </form>
        <%--表格和图表--%>
        <div style="padding: 8px">
            <%--表格--%>
            <div style="float: left;width:44%;">
                <table class="layui-hide" id="test3"></table>
            </div>
            <div style="float: left;width:55%">
                <div id="clientzhu"></div>
                <div id="clientbing"></div>
            </div>
        </div>
    </div>
    <%--第五个--%>
    <div id="compile5" class="displayNone" style ="display: none">
        <%--头部--%>
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;客户欠款统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:98%" >
            </div>
        </div>
        <%--内容部分--%>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li class="layui-this">欠款统计</li>
                    <li>还款统计</li>
                </ul>
                <div class="layui-tab-content" style="height: 100px;">
                    <div class="layui-tab-item layui-show">
                        <table class="layui-hide" id="kehutest" lay-filter="kehutest"></table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-hide" id="available" lay-filter="available"></table>
                    </div>
                </div>
            </div>

    </div>
    <%--第六个--%>
    <div id="compile6" class="displayNone" style ="display: none">
        <div class="headTop" style="margin-top:7px;">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;供货商还款统计</label>
                </p>
                <hr class="layui-bg-blue" style="margin:10px auto;width:98%" >
            </div>
        </div>
        <%--内容部分--%>
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">欠款统计</li>
                <li>还款统计</li>
            </ul>
            <div class="layui-tab-content" style="height: 100px;">
                <div class="layui-tab-item layui-show">
                    <table class="layui-hide" id="arrs" lay-filter="arrs"></table>
                </div>
                <div class="layui-tab-item">
                    <table class="layui-hide" id="returnmouth" lay-filter="returnmouth"></table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%--客户的头部--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="qiansear">查询</button>
        <%--<button class="layui-btn layui-btn-sm" lay-event="getCheckLength">全部欠款记录</button>--%>
    </div>
</script>
<script type="text/html" id="toolbartab">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="repayment">查询</button>
        <%--<button class="layui-btn layui-btn-sm" lay-event="getCheckLength">全部欠款记录</button>--%>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength" id="delRecord">删除历史还款记录</button>
    </div>
</script>

<%--供货商--%>
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="shares">查询</button>
    </div>
</script>
<script type="text/html" id="tool">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="ghearch">查询</button>
        <button class="layui-btn layui-btn-sm" lay-event="ghDelect">删除历史还款记录</button>
    </div>
</script>
<script>
   var ware
   var repaymentId

    layui.use(['form', 'element','layedit', 'laydate','table'], function() {
        var form = layui.form;
        var element = layui.element;
        layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,table = layui.table
        $('#date').val(yearformat()) //默认显示当前年份
        $('#date1').val(yearformat()) //默认显示当前年份
        $('#date2').val(yearformat()) //默认显示当前年份
        $('#date3').val(yearformat()) //默认显示当前年份
        $('#date4').val(nowformat())//默认显示当前月份
        $('#date5').val(nowformat())
        $('#date6').val(nowformat())

        laydate.render({
            elem: '#date',
            type: 'year',
        });
        laydate.render({
            elem: '#date1',
            type: 'year'
        });
        laydate.render({
            elem: '#date2',
            type: 'year'
        });
        laydate.render({
            elem: '#date3',
            type: 'year'
        });
        laydate.render({
            elem: '#date4',
            type: 'month'
        });
        laydate.render({
            elem: '#date5',
            type: 'month'
        });
        laydate.render({
            elem: '#date6',
            type: 'month'
        });
        form.render()
        //仓库的ajax
        $(function() {
            //仓库的ajax
            $.ajax({
                url:'/invWarehouse/selectInvInfo',
                dataType:'json',
                type:'get',
                success:function(res){
                    valuenone=res.obj[0].warehouseId;
                    var strs = ''
                    var flag = 0;
                    for(var i=0;i<res.obj.length;i++){
                        datas = res.obj[i].warehouseName
                        for(var j=0;j<=i-1;j++){
                            if(res.obj[i].warehouseName == res.obj[j].warehouseName){
                                flag = 1;
                                break;
                            }
                            flag = 0;
                        }
                        if(flag == 0)
                        {
                            strs += '<option  title="' + res.obj[i].warehouseName + '" value="' + res.obj[i].warehouseId + '">' +  res.obj[i].warehouseName + '</option>'
                        }
                        flag = 0;
                    }
                    $('.warehouseName').append(strs);
                    form.render('select');
                }
            })
        });
         //点击搜索的功能
        $('.searchs').on('click',function(){
            ware = $(".queryStock select[name='warehouse']").val()
            var dates = $('#date').val()
            month(ware,dates)
            check('1',ware,dates,1)
        })
        month('', yearformat())
        function month(warehouseId,year){
            table.render({
                elem: '#test'
                ,url:'/salesShipment/shipCount',
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.object //解析数据列表
                    };
                },
                where:{
                    warehouseId:warehouseId,
                    year:year
                },
                width:500
                ,cols: [[
                    {field:'returnMonth',title: '月份'}
                    ,{field:'realPrice', title: '实际销售金额'}
                    ,{field:'saleShipPrice', title: '销售出货金额'}
                    ,{field:'saleReturnPrice' ,title: '销售退货金额'}
                ]]
            });
        }
        //月销售------------------------------------------显示图表
        check('1','',yearformat())
        function check(arr_box,warehouseId,year){
            var realPrice  //实际销售金额
            var saleShipPrice//销售出货金额
            var saleReturnPrice//销售退货金额
            $.ajax({
                url:'/salesShipment/shipCount',
                type: 'get',
                dataType: "JSON",
                data:{
                    warehouseId:warehouseId,
                    year:year
                },
                success:function (res) {
                     realPrice =[] //实际销售金额
                     saleShipPrice =[]//销售出货金额
                     saleReturnPrice =[] //销售退货金额
                    var mon = res.object;
                    console.log(mon);
                     if(mon == undefined || mon == "undefined" || mon == ""){

                     }else{
                         if(mon.length>0){
                             for(var i=0;i<mon.length;i++){
                                 if(arr_box.indexOf('1')>-1){
                                     realPrice.push(mon[i].realPrice)
                                 }
                                 if(arr_box.indexOf('2')>-1){
                                     saleShipPrice.push(mon[i].saleShipPrice)
                                 }
                                 if(arr_box.indexOf('3')>-1){
                                     saleReturnPrice.push(mon[i].saleReturnPrice)
                                 }
                             }
                         }
                     }


                    //月的柱状图
                    var chart = Highcharts.chart('histogram',{
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: '月份'
                        },
                        xAxis: {
                            categories: [
                                '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
                            ],
                            crosshair: true
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: '金额'
                            }
                        },
                        tooltip: {
                            // head + 每个 point + footer 拼接成完整的 table
                            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                            footerFormat: '</table>',
                            shared: true,
                            useHTML: true
                        },
                        plotOptions: {
                            column: {
                                borderWidth: 0
                            }
                        },
                        credits: {
                            enabled: false
                        },
                        series: [{
                            name: '实际销售金额',
                            data: realPrice
                        }, {
                            name: '销售出货金额',
                            data: saleShipPrice
                        }, {
                            name: '销售退货金额',
                            data: saleReturnPrice
                        }]
                    });
                    //月销售-显示方式曲线图
                    var chart = Highcharts.chart('Graph', {
                        chart: {
                            type: 'line'
                        },
                        title: {
                            text: '月份'
                        },
                        xAxis: {
                            categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                        },
                        yAxis: {
                            title: {
                                text: '金额'
                            }
                        },
                        plotOptions: {
                            line: {
                                dataLabels: {
                                    // 开启数据标签
                                    enabled: true
                                },
                                // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                                enableMouseTracking: false
                            }
                        },
                        series: [{
                            name: '实际销售金额',
                            data: realPrice
                        }, {
                            name: '销售出货金额',
                            data: saleShipPrice
                        }, {
                            name: '销售退货金额',
                            data: saleReturnPrice
                        }]
                    });
                }
            })
        }
        //判断--------------------------------------------月销售统计的单选按钮
        form.on('radio(histogram)', function(data){
            $('#histogram').show()
            $('#Graph').hide()
        });
        form.on('radio(curve)',function(data){
            $('#histogram').hide()
            $('#Graph').show()
        })
        //判断-----------------------------------------月销售统计的复选框
        form.on('checkbox(actual)', function(data){
            //将页面全部复选框选中的值拼接到一个数组中
            var arr_box = [];
            $('input[name="actual"]:checked').each(function() {
                arr_box.push($(this).val());
            });
            //数组
            check(arr_box)
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        
        /*********************************日销售统计***********************/
        $('.day').on('click',function(){
            $('#mouths').val(now())
            $(function() {
                //仓库的ajax
                $.ajax({
                    url:'/invWarehouse/selectInvInfo',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        var strs = ''
                        for(var i=0;i<res.obj.length;i++){
                            datas = res.obj[i].warehouseName
                            strs += '<option  title="' + res.obj[i].warehouseName + '" value="' + res.obj[i].warehouseId + '">' +  res.obj[i].warehouseName + '</option>'
                        }
                        $('.warehouse').append(strs);
                        form.render('select');
                    }
                })
            });
            // 日销售统计的表格
            $('.daysear').on('click',function () {
               var  wares = $(".query select[name='warehouse']").val()
                var dates = $('#date1').val()
                var date4 = $('#date4').val().split('-')[1]
                day(wares,dates,date4)
                daycheck('',dates,date4,wares)
            })
            day()
           function day(year,month,warehouseId){
               table.render({
                   elem: '#test1'
                   ,url:'/salesShipment/shipDayCount',
                   parseData: function(res){ //res 即为原始返回的数据
                       return {
                           "code":0, //解析接口状态
                           "data": res.object //解析数据列表
                       };
                   },
                   where:{
                       warehouseId:warehouseId,
                       year:year,
                       month:month
                   },
                   width:500
                   ,cols: [[
                       {field:'returnMonth',title: '日'}
                       ,{field:'realPrice',title: '实际销售金额'}
                       ,{field:'saleShipPrice',title: '销售出货金额'}
                       ,{field:'saleReturnPrice',title: '销售退货金额'}
                   ]]
               });
           }

            //日销售---------------------------------显示方式柱状图
            daycheck('1')
            function daycheck(arr_day,year,month,warehouseId){
                var returnMonth
                var real
                var saleShip
                var saleReturns
                $.ajax({
                    url:'/salesShipment/shipDayCount',
                    type: 'get',
                    dataType: "JSON",
                    data:{
                        warehouseId:warehouseId,
                        year:year,
                        month:month
                    },
                    success:function (res) {
                        var mon = res.object;
                        returnMonth =[]
                        real=[]
                        saleShip=[]
                        saleReturns=[]
                        console.log(mon);
                        if(mon == undefined || mon == "undefined" || mon == ""){

                        }else{
                            if(mon.length>0){
                                for(var i=0;i<mon.length;i++){
                                    if(arr_day.indexOf('1')>-1 ||year!=undefined){
                                        real.push(mon[i].realPrice)
                                    }
                                    if(arr_day.indexOf('2')>-1||year!=undefined){
                                        saleShip.push(mon[i].saleShipPrice)
                                    }
                                    if(arr_day.indexOf('3')>-1||year!=undefined){
                                        saleReturns.push(mon[i].saleReturnPrice)
                                    }
                                    returnMonth.push(mon[i].returnMonth)
                                }
                            }
                        }

                        //日的柱状图
                        var chart = Highcharts.chart('monthzhu',{
                            chart: {
                                type: 'column'
                            },
                            title: {
                                text: '月份'
                            },
                            xAxis: {
                                categories:returnMonth,
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: '金额'
                                }
                            },
                            tooltip: {
                                // head + 每个 point + footer 拼接成完整的 table
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },
                            plotOptions: {
                                column: {
                                    borderWidth: 0
                                }
                            },
                            credits: {
                                enabled: false
                            },
                            series: [{
                                name: '实际销售金额',
                                data: real
                            }, {
                                name: '销售出货金额',
                                data: saleShip
                            }, {
                                name: '销售退货金额',
                                data: saleReturns
                            }]
                        });
                        //月销售-显示方式曲线图
                        var chart = Highcharts.chart('monthqu', {
                            chart: {
                                type: 'line'
                            },
                            title: {
                                text: '月份'
                            },
                            xAxis: {
                                categories: returnMonth
                            },
                            yAxis: {
                                title: {
                                    text: '金额'
                                }
                            },
                            plotOptions: {
                                line: {
                                    dataLabels: {
                                        // 开启数据标签
                                        enabled: true
                                    },
                                    // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                                    enableMouseTracking: false
                                }
                            },
                            series: [{
                                name: '实际销售金额',
                                data: real
                            }, {
                                name: '销售出货金额',
                                data: saleShip
                            }, {
                                name: '销售退货金额',
                                data: saleReturns
                            }]
                        });

                        //判断柱状图和折线图的隐藏和显示
                        form.on('radio(monthhistogram)', function(data){
                            $('#monthzhu').show()
                            $('#monthqu').hide()
                        });
                        form.on('radio(monthcurve)',function(data){
                            $('#monthzhu').hide()
                            $('#monthqu').show()
                        })
                    }
                })
            }

            //判断-----------------------------------------月销售统计的复选框
            //监听复选框
            form.on('checkbox(dayname)', function(data){
                //将页面全部复选框选中的值拼接到一个数组中
                var arr_day = [];
                $('input[name="dayname"]:checked').each(function() {
                    arr_day.push($(this).val());
                });
                //数组
                daycheck(arr_day)
                return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
            });
        })
        
        /*********************************员工销售统计***********************/
        $('.employee').on('click',function () {
            var userName;
            var saleShipper;
            // 员工售统计的表格
            $(function() {
                //仓库的ajax
                $.ajax({
                    url:'/invWarehouse/selectInvInfo',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        var strs = ''
                        for(var i=0;i<res.obj.length;i++){
                            datas = res.obj[i].warehouseName
                            strs += '<option  title="' + res.obj[i].warehouseName + '" value="' + res.obj[i].warehouseId + '">' +  res.obj[i].warehouseName + '</option>'
                        }
                        $('.modules').append(strs);
                        form.render('select');
                    }
                })
            });
            //查询按钮
            $('#staff').on('click',function () {
                var data2 = $('#date2').val()
                var selas = $("#quering select[name='modules']").val()
                var date5 = $('#date5').val().split('-')[1]
                ygpeson(data2,date5,selas)
                histogram(data2,date5,selas)

            })
            ygpeson()
            histogram()

           function ygpeson(year,month,warehouseId){
               table.render({
                   elem: '#test2'
                   ,url:'/salesShipment/shipEmployeeCount',
                   parseData: function(res){ //res 即为原始返回的数据
                       return {
                           "code":0, //解析接口状态
                           "data": res.object //解析数据列表
                       };
                   },
                       where:{
                           warehouseId:warehouseId,
                           year:year,
                           month:month
                       }
                   ,cols: [[
                       {field:'userName',width:160,title: '员工'}
                       ,{field:'sumShipMent',width:160, title: '销售金额'}
                       ,{field:'saleShipper',width:160, title: '所占百分比'}
                   ]]
               });
           }
           function histogram (year,month,warehouseId){
               $.ajax({
                   url:'/salesShipment/shipEmployeeCount',
                   type: 'get',
                   dataType: "JSON",
                   data:{
                       warehouseId:warehouseId,
                       year:year,
                       month:month
                   },
                   success:function (res) {
                       var yuan = res.object
                       userName=[]
                       saleShipper=[]
                       for(var i=0;i<yuan.length;i++){
                           userName.push(parseInt(yuan[i].sumShipMent))
                           saleShipper.push(yuan[i].userName)
                       }
                       var chart = Highcharts.chart('employeepie',{
                           chart: {
                               type: 'column'
                           },
                           title: {
                               text: '客户'
                           },
                           xAxis: {
                               categories: saleShipper,
                               crosshair: true
                           },
                           yAxis: {
                               min: 0,
                               title: {
                                   text: '金额'
                               }
                           },
                           tooltip: {
                               // head + 每个 point + footer 拼接成完整的 table
                               headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                               pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                   '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                               footerFormat: '</table>',
                               shared: true,
                               useHTML: true
                           },
                           plotOptions: {
                               column: {
                                   borderWidth: 0
                               }
                           },
                           credits: {
                               enabled: false
                           },
                           series: [{
                               name: '销售金额',
                               data: userName
                           }]
                       });
                   }
               })
           }
        })

        /********************************客户销售统计************************/
        $('.customer').on('click',function () {
            $(function() {
                //第一个
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
                        $('.kesales').append(strs);
                        form.render('select');
                    }
                })
            });
            // 客户销售统计的表格
            $('#salesperson').on('click',function(){
                var date3 = $('#date3').val()
                var date6 = $('#date6').val().split('-')[1]
                var cangku = $(".storetoop select[name='modules']").val()
                customer(date3,date6,cangku)
                aa(date3,date6,cangku)
            })
            customer()
            aa()
            function customer (year,month,warehouseId){
                table.render({
                    elem: '#test3'
                    ,url:'/salesShipment/shipCustomerCount'
                    ,cellMinWidth: 80,//全局定义常规单元格的最小宽度，layui 2.2.1 新增
                    parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code":0, //解析接口状态
                            "data": res.object //解析数据列表
                        };
                    },
                    where:{
                        warehouseId:warehouseId,
                        year:year,
                        month:month
                    }
                    ,cols: [[
                        {field:'userName',width:160,title: '客户'}
                        ,{field:'sumShipMent',width:160, title: '销售金额'}
                        ,{field:'saleShipper',width:160, title: '所占百分比'}
                    ]],
                });
            }
            function aa(year,month,warehouseId){
                $.ajax({
                    url:'/salesShipment/shipCustomerCount',
                    type: 'get',
                    dataType: "JSON",
                    data:{
                        warehouseId:warehouseId,
                        year:year,
                        month:month
                    },
                    success:function(res){
                        var obj = res.object
                        var sums = []
                        var use = []
                        for(var i=0;i<obj.length;i++){
                            sums.push(parseInt(obj[i].sumShipMent))
                            use.push(obj[i].userName)
                        }
                        //柱状图
                        var chart = Highcharts.chart('clientzhu',{
                            chart: {
                                type: 'column'
                            },
                            title: {
                                text: '客户'
                            },
                            xAxis: {
                                categories: use,
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: '金额'
                                }
                            },
                            tooltip: {
                                // head + 每个 point + footer 拼接成完整的 table
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },
                            plotOptions: {
                                column: {
                                    borderWidth: 0
                                }
                            },
                            credits: {
                                enabled: false
                            },
                            series: [{
                                name: '销售金额',
                                data: sums
                            }]
                        });
                        //折线图
                        var chart = Highcharts.chart('clientbing', {
                            chart: {
                                type: 'line'
                            },
                            title: {
                                text: '月份'
                            },
                            xAxis: {
                                categories: use
                            },
                            yAxis: {
                                title: {
                                    text: '金额'
                                }
                            },
                            plotOptions: {
                                line: {
                                    dataLabels: {
                                        // 开启数据标签
                                        enabled: true
                                    },
                                    // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                                    enableMouseTracking: false
                                }
                            },
                            series: [{
                                name: '实际销售金额',
                                data: sums
                            }]
                        });
                    }
                })

            }

            form.on('radio(clientzhu)', function(data){
                $('#clientzhu').show()
                $('#clientbing').hide()
            });
            form.on('radio(clientbing)', function(data){
                $('#clientzhu').hide()
                $('#clientbing').show()
            });

        })

        /********************************客户欠款销统计************************/
        $('.arrears').on('click',function(){
            //第一个表格
            var tableIns= table.render({
                elem: '#kehutest'
                ,url:'/salesShipment/selectAllSales?isArrears=1'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,cols: [[
                    {field:'customerName', title:'客户',}
                    ,{field:'enterName', title:'商品名称',}
                    ,{field:'shipmentTotal', title:'合计',}
                    ,{field:'shipmentPaid', title:'已付金额',}
                    ,{field:'shipmentArrears', title:'欠款金额',}
                ]]
                ,page: true
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
            });
            //表格
            var tableIns2=table.render({
                elem: '#available'
                ,url:'/repayment/selectCusPayment'
                ,toolbar: '#toolbartab' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,cols: [[
                    ,{field:'customerName', title:'客户'}
                    ,{field:'repaymentTimeStr', title:'还款日期',}
                    ,{field:'repaymentAmount', title:'还款金额',}
                    ,{field:'userName', title:'经手人',}
                    ,{field:'enterName', title:'商品名称',}
                    ,{field:'enterSpecs', title:'商品规格',}
                    ,{field:'enterCode', title:'商品编码',}
                    ,{field:'shipmentDateStr', title:'出货日期'}
                    ,{field:'repaymentRemark', title:'备注',}
                ]]
                ,page: true
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
            });

            //头工具栏事件
            table.on('toolbar(kehutest)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'qiansear':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['750px', '450px'],
                            content:' <div style="padding: 8px">\n' +
                                '            <form class="layui-form qianKuan" action="">\n' +
                                '                <div class="items">按时间查询</div>\n' +
                                '                <div class="layui-form-item shiJian" style="margin-left:-29px">\n' +
                                '                    <div class="layui-input-block">\n' +
                                '                        <input type="radio" name="search" value="按日查询" title="按日查询"  lay-filter="level1" checked class="radio1">\n' +
                                '                        <input type="radio" name="search" value="按月查询" title="按月查询"   lay-filter="level2" class="radio2">\n' +
                                '                        <input type="radio" name="search" value="按年查询" title="按年查询"  lay-filter="level3"  class="radio3">\n' +
                                // '                        <input type="radio" name="search" value="按时间段查询" title="按时间段查询"  lay-filter="level4"   class="radio4">\n' +
                                // '                        <input type="radio" name="search" value="所有时间" title="所有时间"   lay-filter="level5"  class="radio5">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <%--时间选择--%>\n' +
                                '                <div>\n' +
                                '                    <%--日--%>\n' +
                                '                    <div class="layui-form-item datatimes1" style="display: flex;width: 100%">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="dayQuery"  class="layui-input" id="day" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--月--%>\n' +
                                '                    <div class="layui-form-item datatimes2" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="monthQuery1" lay-verify="required|number" autocomplete="off" class="layui-input" id="month" >\n' +
                                '                            </div>\n' +
                                // '                            <span style="display: inline-block;margin-top: 12px;">月</span>\n' +
                                '                        </div>\n' +
                                // '                        <div class="layui-inline">\n' +
                                // '                            <div class="layui-input-inline">\n' +
                                // '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="year" placeholder="请选择年">\n' +
                                // '                            </div>\n' +
                                // '                            <span style="display: inline-block;margin-top: 12px;">年</span>\n' +
                                // '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--年--%>\n' +
                                '                    <div class="layui-form-item datatimes3" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="yearQuery" lay-verify="required|number" autocomplete="off" class="layui-input" id="years" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--按时间段--%>\n' +
                                '                    <div class="layui-form-item datatimes4" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline" style="width: 50%;">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;margin-top: 2px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">从</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="datetime"  placeholder="请选择月份" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">至</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="data" placeholder="请选择年" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="items">按客户查询</div>\n' +
                                '                <div class="layui-form-item" style="display: flex;width: 100%;margin-top:17px">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">客户</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                // '                            <input type="text" name="customerName" lay-verify="required|number" autocomplete="off" class="layui-input" >\n' +
                                '      <select name="customerName" lay-verify="required">\n' +
                                '      </select>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </form>\n' +
                                '        </div>',
                            btn: ['确定','取消', ],
                            success:function (res) {
                                form.render()
                                laydate.render({
                                    elem: '#day'
                                });
                                laydate.render({
                                    elem: '#month'
                                    ,type: 'month'
                                });
                                laydate.render({
                                    elem: '#year'
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#datetime'
                                });
                                laydate.render({
                                    elem: '#data'
                                });
                                laydate.render({
                                    elem: '#years'
                                    ,type: 'year'
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
                                        $('.qianKuan [name="customerName"]').html(str);
                                        form.render()
                                    }
                                })
                            },
                            yes:function (index) {
                                var timeQuery=$('.qianKuan .shiJian .layui-form-radio')
                                var type
                                var shipmentDateStr
                                if(timeQuery.eq(0).hasClass("layui-form-radioed")){
                                    type=1
                                    shipmentDateStr=$('.datatimes1 input[name="dayQuery"]').val()
                                }else if(timeQuery.eq(1).hasClass("layui-form-radioed")){
                                    type=2
                                    shipmentDateStr=$('.datatimes2 input[name="monthQuery1"]').val()
                                }else if(timeQuery.eq(2).hasClass("layui-form-radioed")){
                                    type=3
                                    shipmentDateStr=$('.datatimes3 input[name="yearQuery"]').val()
                                }
                                var customerId=$('.qianKuan select[name="customerName"] option:checked').val()
                                layer.close(index)
                                tableIns.reload({
                                    url:'/salesShipment/selectAllSales',
                                    where:{
                                        type:type,
                                        shipmentDateStr:shipmentDateStr,
                                        customerId:customerId,
                                        isArrears:1
                                    }
                                })
                            }
                        })
                        break;
                };
            });
            //头工具栏事件
            table.on('toolbar(available)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                console.log(obj)
                switch(obj.event){
                    case 'repayment':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['750px', '500px'],
                            content:' <div style="padding: 8px">\n' +
                                '            <form class="layui-form huanKuan" action="">\n' +
                                '                <div class="items">按时间查询</div>\n' +
                                '                <div class="layui-form-item shiJian" style="margin-left:-29px">\n' +
                                '                    <div class="layui-input-block">\n' +
                                '                        <input type="radio" name="search" value="按日查询" title="按日查询"  lay-filter="level1" checked class="radio1">\n' +
                                '                        <input type="radio" name="search" value="按月查询" title="按月查询"   lay-filter="level2" class="radio2">\n' +
                                '                        <input type="radio" name="search" value="按年查询" title="按年查询"  lay-filter="level3"  class="radio3">\n' +
                                // '                        <input type="radio" name="search" value="按时间段查询" title="按时间段查询"  lay-filter="level4"   class="radio4">\n' +
                                // '                        <input type="radio" name="search" value="所有时间" title="所有时间"   lay-filter="level5"  class="radio5">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <%--时间选择--%>\n' +
                                '                <div>\n' +
                                '                    <%--日--%>\n' +
                                '                    <div class="layui-form-item datatimes1" style="display: flex;width: 100%">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="dayQuery" lay-verify="required|number" autocomplete="off" class="layui-input" id="day" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--月--%>\n' +
                                '                    <div class="layui-form-item datatimes2" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="monthQuery1" lay-verify="required|number" autocomplete="off" class="layui-input" id="month" >\n' +
                                '                            </div>\n' +
                                // '                            <span style="display: inline-block;margin-top: 12px;">月</span>\n' +
                                '                        </div>\n' +
                                // '                        <div class="layui-inline">\n' +
                                // '                            <div class="layui-input-inline">\n' +
                                // '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="year" placeholder="请选择年">\n' +
                                // '                            </div>\n' +
                                // '                            <span style="display: inline-block;margin-top: 12px;">年</span>\n' +
                                // '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--年--%>\n' +
                                '                    <div class="layui-form-item datatimes3" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="yearQuery" lay-verify="required|number" autocomplete="off" class="layui-input" id="years" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--按时间段--%>\n' +
                                '                    <div class="layui-form-item datatimes4" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline" style="width: 50%;">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;margin-top: 2px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">从</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="datetime"  placeholder="请选择月份" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">至</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="data" placeholder="请选择年" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="items">按客户查询</div>\n' +
                                '                <div class="layui-form-item" style="width: 100%;margin-top:17px">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">客户</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                // '                            <input type="text" name="customerName" lay-verify="required|number" autocomplete="off" class="layui-input" >\n' +
                                '      <select name="customerName" lay-verify="required">\n' +
                                '      </select>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-form-item" style="width: 100%;margin-top:17px">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">备注</label>\n' +
                                '                        <div class="layui-input-inline" style="width:500px">\n' +
                                '      <textarea name="shipmentRemark" placeholder="请输入备注" class="layui-textarea"></textarea>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </form>\n' +
                                '        </div>',
                            btn: ['确定','取消', ],
                            success:function (res) {
                                form.render()
                                laydate.render({
                                    elem: '#day'
                                });
                                laydate.render({
                                    elem: '#month'
                                    ,type: 'month'
                                });
                                laydate.render({
                                    elem: '#year'
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#datetime'
                                });
                                laydate.render({
                                    elem: '#data'
                                });
                                laydate.render({
                                    elem: '#years'
                                    ,type: 'year'
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
                                        $('.huanKuan [name="customerName"]').html(str);
                                        form.render()
                                    }
                                })
                            },
                            yes:function (index) {
                                var timeQuery=$('.huanKuan .shiJian .layui-form-radio')
                                var type
                                var repaymentTimeStr
                                if(timeQuery.eq(0).hasClass("layui-form-radioed")){
                                    type=1
                                    repaymentTimeStr=$('.datatimes1 input[name="dayQuery"]').val()
                                }else if(timeQuery.eq(1).hasClass("layui-form-radioed")){
                                    type=2
                                    repaymentTimeStr=$('.datatimes2 input[name="monthQuery1"]').val()
                                }else if(timeQuery.eq(2).hasClass("layui-form-radioed")){
                                    type=3
                                    repaymentTimeStr=$('.datatimes3 input[name="yearQuery"]').val()
                                }
                                var customerId=$('.huanKuan select[name="customerName"] option:checked').val()
                                layer.close(index)
                                tableIns2.reload({
                                    url:'/repayment/selectCusPayment',
                                    where:{
                                        type:type,
                                        repaymentTimeStr:repaymentTimeStr,
                                        customerId:customerId,
                                    }
                                })
                            }
                        })
                        break;
                    case 'getCheckLength':
                        if($('#delRecord').attr('repaymentId')!=undefined){
                            layer.confirm('真的删除当前数据吗？', function (index) {
                                $.ajax({
                                    type: 'get',
                                    url: '/repayment/delCusPaymentById?repaymentId='+ $('#delRecord').attr('repaymentId'),
                                    dataType: 'json',
                                    success: function (res) {
                                        if (res.msg == 'true') {
                                            layer.msg('删除成功！', {icon: 1},function(){
                                                tableIns2.reload()
                                            });
                                        }
                                    }
                                })
                            });
                            break;
                        }else{
                            layer.msg('请选择要删除的数据！', {icon: 0});
                        }

                };
            });
            //监听行单击事件
            table.on('row(kehutest)', function (obj) {
                var data=obj.data
                var tr=obj.tr
                /*  console.log(tr) //得到当前行元素对象
                  console.log(data) //得到当前行数据*/
                $(this).addClass('bg').siblings().removeClass('bg')
                layer.open({
                    type: 1 //Page层类型
                    , area: ['1100px', '250px']
                    , title: '详情信息'
                    , maxmin: true //允许全屏最小化
                    , content: '<div class="mbox"><table class="layui-table" id="qianDetalis">\n' +
                        '  <colgroup>\n' +
                        '    <col width="80">\n' +
                        '    <col width="110">\n' +
                        '    <col width="130">\n' +
                        '    <col width="130">\n' +
                        '    <col width="130">\n' +
                        '    <col width="120">\n' +
                        '    <col width="120">\n' +
                        '    <col width="120">\n' +
                        '    <col width="90">\n' +
                        '    <col width="120">\n' +
                        '    <col width="120">\n' +
                        '    <col width="100">\n' +
                        '    <col width="80">\n' +
                        '  </colgroup>\n' +
                        '  <thead>\n' +
                        '    <tr>\n' +
                        '      <th>客户</th>\n' +
                        '      <th>出货日期</th>\n' +
                        '      <th>商品大类</th>\n' +
                        '      <th>商品名称</th>\n' +
                        '      <th>商品规格</th>\n' +
                        '      <th>商品编码</th>\n' +
                        '      <th>出货数量</th>\n' +
                        '      <th>出货单价</th>\n' +
                        '      <th>合计</th>\n' +
                        '      <th>已付金额</th>\n' +
                        '      <th>欠款金额</th>\n' +
                        '      <th>出货人</th>\n' +
                        '      <th>备注</th>\n' +
                        '    </tr> \n' +
                        '  </thead>\n' +
                        '  <tbody>\n' +
                        '  </tbody>\n' +
                        '</table></div>'
                    ,success: function (res) {
                        var str= '    <tr>\n' +
                            '      <td>'+data.customerName+'</td>\n' +
                            '      <td>'+data.shipmentDateStr+'</td>\n' +
                            '      <td>'+data.productType+'</td>\n' +
                            '      <td>'+data.enterName+'</td>\n' +
                            '      <td>'+data.enterSpecs+'</td>\n' +
                            '      <td>'+data.enterCode+'</td>\n' +
                            '      <td>'+data.shipmentNum+'</td>\n' +
                            '      <td>'+data.shipmentPrice+'</td>\n' +
                            '      <td>'+data.shipmentTotal+'</td>\n' +
                            '      <td>'+data.shipmentPaid+'</td>\n' +
                            '      <td>'+data.shipmentArrears+'</td>\n' +
                            '      <td>'+data.shipper+'</td>\n' +
                            '      <td>'+data.shipmentRemark+'</td>\n' +
                            '    </tr>'
                        $('#qianDetalis tbody').append(str)
                    }
                });
            });
            //监听行单击事件
            table.on('row(available)', function (obj) {
                var data=obj.data
                var tr=obj.tr
                /* console.log(tr) //得到当前行元素对象
                 console.log(data) //得到当前行数据*/
                $(this).addClass('bg').siblings().removeClass('bg')
                $('#delRecord').attr('repaymentId',data.repaymentId)
            });
            // //监听单选框的方法
            form.on('radio(level1)', function(data){
                $('.datatimes1').show()
                $('.datatimes2').hide()
                $('.datatimes3').hide()
                $('.datatimes4').hide()
                $('.datatimes5').hide()
            });
            form.on('radio(level2)', function(data){
                $('.datatimes1').hide()
                $('.datatimes2').show()
                $('.datatimes3').hide()
                $('.datatimes4').hide()
                $('.datatimes5').hide()
            });
            form.on('radio(level3)', function(data){
                $('.datatimes1').hide()
                $('.datatimes2').hide()
                $('.datatimes3').show()
                $('.datatimes4').hide()
                $('.datatimes5').hide()
            });
        })

        /********************************供货商欠款统计************************/
        $('.supplier').on('click',function(){
            //第一个表格
            var tableIns=table.render({
                elem: '#arrs'
                ,url:'/poCommodityEnter/selectProductInfo?isArrears=1',
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.obj,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,cols: [[
                    {field:'enterName', title:'商品名称'}
                    ,{field:'supplierName', title:'供货商'}
                    ,{field:'enterPaid', title:'已付金额'}
                    ,{field:'enterArrears', title:'欠款金额'}
                    ,{field:'enterTotal', title:'合计'}
                ]],
                page: true
            });
            //还款统计表格
            var tableIns2=table.render({
                elem: '#returnmouth'
                ,url:'/repayment/selectSupPayment'
                ,toolbar: '#tool',//开启头部工具栏，并为其绑定左侧模板
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.obj,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,cols: [[
                    {field:'supplierName', title:'供货商'}
                    ,{field:'enterIndates', title:'还款日期'}
                    ,{field:'repaymentAmount', title:'还款金额'}
                    ,{field:'userName', title:'经手人'}
                    ,{field:'enterName', title:'商品名称'}
                    ,{field:'enterCode', title:'商品编码'}
                    ,{field:'enterIndates', title:'进货日期'}
                    ,{field:'repaymentRemark', title:'备注'}
                ]]
                ,page: true
            });
            //监听第一个表格的头部监听事件
            table.on('toolbar(arrs)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'shares':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['750px', '450px'],
                            content:' <div style="padding: 8px">\n' +
                                '            <form class="layui-form qianKuan" action="">\n' +
                                '                <div class="items">按时间查询</div>\n' +
                                '                <div class="layui-form-item shiJian" style="margin-left:-29px">\n' +
                                '                    <div class="layui-input-block">\n' +
                                '                        <input type="radio" name="search" value="按日查询" title="按日查询"  lay-filter="level1" checked class="radio1">\n' +
                                '                        <input type="radio" name="search" value="按月查询" title="按月查询"   lay-filter="level2" class="radio2">\n' +
                                '                        <input type="radio" name="search" value="按年查询" title="按年查询"  lay-filter="level3"  class="radio3">\n' +
                                // '                        <input type="radio" name="search" value="按时间段查询" title="按时间段查询"  lay-filter="level4"   class="radio4">\n' +
                                // '                        <input type="radio" name="search" value="所有时间" title="所有时间"   lay-filter="level5"  class="radio5">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <%--时间选择--%>\n' +
                                '                <div>\n' +
                                '                    <%--日--%>\n' +
                                '                    <div class="layui-form-item datatimes1" style="display: flex;width: 100%">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="dayQuery"  class="layui-input" id="day" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--月--%>\n' +
                                '                    <div class="layui-form-item datatimes2" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="monthQuery1" lay-verify="required|number" autocomplete="off" class="layui-input" id="month" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--年--%>\n' +
                                '                    <div class="layui-form-item datatimes3" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="yearQuery" lay-verify="required|number" autocomplete="off" class="layui-input" id="years" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--按时间段--%>\n' +
                                '                    <div class="layui-form-item datatimes4" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline" style="width: 50%;">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;margin-top: 2px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">从</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="datetime"  placeholder="请选择月份" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">至</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="data" placeholder="请选择年" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="items">按客户查询</div>\n' +
                                '                <div class="layui-form-item" style="display: flex;width: 100%;margin-top:17px">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">供货商</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '      <select name="supplierName" lay-verify="required">\n' +
                                '      </select>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </form>\n' +
                                '        </div>',
                            btn: ['确定','取消', ],
                            success:function (res) {
                                form.render()
                                laydate.render({
                                    elem: '#day'
                                });
                                laydate.render({
                                    elem: '#month'
                                    ,type: 'month'
                                });
                                laydate.render({
                                    elem: '#year'
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#datetime'
                                });
                                laydate.render({
                                    elem: '#data'
                                });
                                laydate.render({
                                    elem: '#years'
                                    ,type: 'year'
                                });
                                //供货商回显
                                $.ajax({
                                    url: "/poCommodityEnter/selectSupplier",
                                    type: 'get',
                                    dataType: "JSON",
                                    success: function (data) {
                                        var str = '<option value="">请选择</option>';
                                        for (var i = 0; i < data.obj.length; i++) {
                                            str += '<option value="' + data.obj[i].supplierId + '">' + data.obj[i].supplierName + '</option>'
                                        }
                                        $('.qianKuan [name="supplierName"]').html(str);
                                        form.render()
                                    }
                                })
                            },
                            yes:function (index) {
                                var timeQuery=$('.qianKuan .shiJian .layui-form-radio')
                                var type
                                var shipmentDateStr
                                if(timeQuery.eq(0).hasClass("layui-form-radioed")){
                                    type=1
                                    shipmentDateStr=$('.datatimes1 input[name="dayQuery"]').val()
                                }else if(timeQuery.eq(1).hasClass("layui-form-radioed")){
                                    type=2
                                    shipmentDateStr=$('.datatimes2 input[name="monthQuery1"]').val()
                                }else if(timeQuery.eq(2).hasClass("layui-form-radioed")){
                                    type=3
                                    shipmentDateStr=$('.datatimes3 input[name="yearQuery"]').val()
                                }
                                var supplierId=$('.qianKuan select[name="supplierName"] option:checked').val()
                                layer.close(index)
                                tableIns.reload({
                                    url:'/poCommodityEnter/selectProductInfo',
                                    where:{
                                        type:type,
                                        shipmentDateStr:shipmentDateStr,
                                        supplierId:supplierId,
                                        isArrears:1
                                    }
                                })
                            }
                        })
                        break;

                };

            });
            //监听行单击事件
            table.on('row(arrs)', function(obj){
                var data=obj.data  //获取当前行的数据
                layer.open({
                    type: 1 //Page层类型
                    , area: ['1200px', '250px']
                    , title: '详情信息'
                    , maxmin: true //允许全屏最小化
                    , content: '<div class="mbox"><table class="layui-table" id="qianDetalis">\n' +
                        '  <colgroup>\n' +
                        '    <col width="80">\n' +
                        '    <col width="110">\n' +
                        '    <col width="130">\n' +
                        '    <col width="130">\n' +
                        '    <col width="130">\n' +
                        '    <col width="250">\n' +
                        '    <col width="120">\n' +
                        '    <col width="120">\n' +
                        '    <col width="90">\n' +
                        '    <col width="120">\n' +
                        '    <col width="120">\n' +
                        '    <col width="100">\n' +
                        '    <col width="80">\n' +
                        '  </colgroup>\n' +
                        '  <thead>\n' +
                        '    <tr>\n' +
                        '      <th>供货商</th>\n' +
                        '      <th>商品大类</th>\n' +
                        '      <th>商品名称</th>\n' +
                        '      <th>商品规格</th>\n' +
                        '      <th>商品编码</th>\n' +
                        '      <th>进货日期</th>\n' +
                        '      <th>进货数量</th>\n' +
                        '      <th>进货单价</th>\n' +
                        '      <th>合计</th>\n' +
                        '      <th>已付金额</th>\n' +
                        '      <th>欠款金额</th>\n' +
                        '      <th>进货人</th>\n' +
                        '      <th>备注</th>\n' +
                        '    </tr> \n' +
                        '  </thead>\n' +
                        '  <tbody>\n' +
                        '  </tbody>\n' +
                        '</table></div>'
                    ,success: function (res) {
                        var str= '    <tr>\n' +
                            '      <td>'+data.supplierName+'</td>\n' +
                            '      <td>'+data.productTypeName+'</td>\n' +
                            '      <td>'+data.enterSpecs+'</td>\n' +
                            '      <td>'+data.enterName+'</td>\n' +
                            '      <td>'+data.enterCode+'</td>\n' +
                            '      <td>'+data.enterIndate+'</td>\n' +
                            '      <td>'+data.enterNum+'</td>\n' +
                            '      <td>'+data.enterInprice+'</td>\n' +
                            '      <td>'+data.lowprice+'</td>\n' +
                            '      <td>'+data.enterPaid+'</td>\n' +
                            '      <td>'+data.enterArrears+'</td>\n' +
                            '      <td>'+data.userName+'</td>\n' +
                            '      <td>'+data.remark+'</td>\n' +
                            '    </tr>'
                        $('#qianDetalis tbody').append(str)
                    }
                });
            });

            //监听第二个表格的头部监听事件
            table.on('toolbar(returnmouth)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'ghearch':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['750px', '450px'],
                            content:' <div style="padding: 8px">\n' +
                                '            <form class="layui-form qianKuan" action="">\n' +
                                '                <div class="items">按时间查询</div>\n' +
                                '                <div class="layui-form-item shiJian" style="margin-left:-29px">\n' +
                                '                    <div class="layui-input-block">\n' +
                                '                        <input type="radio" name="search" value="按日查询" title="按日查询"  lay-filter="level1" checked class="radio1">\n' +
                                '                        <input type="radio" name="search" value="按月查询" title="按月查询"   lay-filter="level2" class="radio2">\n' +
                                '                        <input type="radio" name="search" value="按年查询" title="按年查询"  lay-filter="level3"  class="radio3">\n' +
                                // '                        <input type="radio" name="search" value="按时间段查询" title="按时间段查询"  lay-filter="level4"   class="radio4">\n' +
                                // '                        <input type="radio" name="search" value="所有时间" title="所有时间"   lay-filter="level5"  class="radio5">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <%--时间选择--%>\n' +
                                '                <div>\n' +
                                '                    <%--日--%>\n' +
                                '                    <div class="layui-form-item datatimes1" style="display: flex;width: 100%">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="dayQuery" autocomplete="off"  class="layui-input" id="day" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--月--%>\n' +
                                '                    <div class="layui-form-item datatimes2" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="monthQuery1" lay-verify="required|number" autocomplete="off" class="layui-input" id="month" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--年--%>\n' +
                                '                    <div class="layui-form-item datatimes3" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="yearQuery" lay-verify="required|number" autocomplete="off" class="layui-input" id="years" >\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--按时间段--%>\n' +
                                '                    <div class="layui-form-item datatimes4" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline" style="width: 50%;">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;margin-top: 2px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">从</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="datetime"  placeholder="请选择月份" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <div class="layui-input-inline" style="width: 197px">\n' +
                                '                                <span style="display: inline-block;margin-top: 12px;margin-right:5px">至</span>\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="data" placeholder="请选择年" style="display: inline-block;width: 172px;">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="items">按客户查询</div>\n' +
                                '                <div class="layui-form-item">\n' +
                                '                    <div class="layui-block">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">供货商</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '                           <select name="supplierName" lay-verify="required">\n' +
                                '                           </select>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                   <div class="layui-inline" id="beizhu">\n' +
                                '                   <label class="layui-form-label">备注</label>\n' +
                                '                   <div class="layui-input-inline">\n' +
                                '                       <input type="text" name="repaymentRemark" id="repaymentRemark" lay-verify="url" autocomplete="off" class="layui-input">\n' +
                                '                   </div>\n' +
                                '                   </div>\n' +
                                '                </div>\n' +
                                '            </form>\n' +
                                '        </div>',
                            btn: ['确定','取消', ],
                            success:function (res) {
                                form.render()
                                laydate.render({
                                    elem: '#day'
                                });
                                laydate.render({
                                    elem: '#month'
                                    ,type: 'month'
                                });
                                laydate.render({
                                    elem: '#year'
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#datetime'
                                });
                                laydate.render({
                                    elem: '#data'
                                });
                                laydate.render({
                                    elem: '#years'
                                    ,type: 'year'
                                });
                                //供货商回显
                                $.ajax({
                                    url: "/poCommodityEnter/selectSupplier",
                                    type: 'get',
                                    dataType: "JSON",
                                    success: function (data) {
                                        var str = '<option value="">请选择</option>';
                                        for (var i = 0; i < data.obj.length; i++) {
                                            str += '<option value="' + data.obj[i].supplierId + '">' + data.obj[i].supplierName + '</option>'
                                        }
                                        $('.qianKuan [name="supplierName"]').html(str);
                                        form.render()
                                    }
                                })
                            },
                            yes:function (index) {
                                var timeQuery=$('.qianKuan .shiJian .layui-form-radio')
                                var type
                                var shipmentDateStr
                                if(timeQuery.eq(0).hasClass("layui-form-radioed")){
                                    type=1
                                    shipmentDateStr=$('.datatimes1 input[name="dayQuery"]').val()
                                }else if(timeQuery.eq(1).hasClass("layui-form-radioed")){
                                    type=2
                                    shipmentDateStr=$('.datatimes2 input[name="monthQuery1"]').val()
                                }else if(timeQuery.eq(2).hasClass("layui-form-radioed")){
                                    type=3
                                    shipmentDateStr=$('.datatimes3 input[name="yearQuery"]').val()
                                }
                                var supplierId=$('.qianKuan select[name="supplierName"] option:checked').val()
                                var repaymentRemark=$('#repaymentRemark').val()
                                layer.close(index)
                                tableIns2.reload({
                                    url:'/repayment/selectSupPayment',
                                    where:{
                                        type:type,
                                        repaymentTimeStr:shipmentDateStr,
                                        supplierId:supplierId,
                                        repaymentRemark:repaymentRemark,
                                    }
                                })
                            }
                        })
                        break;
                    case 'ghDelect':
                        layer.confirm('真的删除当前数据吗？', function (index) {
                            $.ajax({
                                type: 'get',
                                url: '/repayment/delSupPaymentById',
                                data:{supRepaymentId:repaymentId},
                                dataType: 'json',
                                success: function (res) {
                                    if (res.msg == 'true') {
                                        layer.msg('删除成功！', {icon: 1},function(){
                                            tableIns2.reload()
                                        });
                                    }
                                }
                            })
                        });
                        break;

                };

            });
            //监听第二行单击事件
            table.on('row(returnmouth)', function(obj){
                var data=obj.data  //获取当前行的数据
                $(this).addClass('bg').siblings().removeClass('bg')
                repaymentId = data.repaymentId
            });
        })
    })

   //左侧tab图的方法
    function show(id){
        $(".displayNone").hide();
        $("#"+id).show()
    }
    //查询当前的年份
    function yearformat() {
        var  nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        nstr = nyear;
        return nstr;
    }
    //查询当前的月份
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
   //查询当前的月份
   function now() {
       var  nstr = "";
       var now = new Date();
       var nyear = now.getFullYear();
       var nmonth = now.getMonth()+1;
       var nday = now.getDate();
       if(nmonth<10){
           nmonth =nmonth;
       }
       nstr = nyear+"-"+nmonth;
       return nstr;
   }

</script>