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
    <title>采购欠款和还款统计</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/lib/layui/layui.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .mbox{
        padding: 8px;
    }
    .items{
        background-color:#f2f2f2;
        text-align: center;
        height: 30px;
        line-height: 30px;
        margin-bottom:10px;
    }
    .bg{
        background-color: #e6e6e6;
    }
</style>
<body>
    <div class="mbox">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">欠款统计</li>
                <li>还款统计</li>
            </ul>
            <div class="layui-tab-content" style="height: 100px;">
                <div class="layui-tab-item layui-show">
                    <table class="layui-hide" id="arrears" lay-filter="arrears"></table>
                </div>
                <div class="layui-tab-item">
                    <table class="layui-hide" id="stext" lay-filter="stext"></table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="search">查询</button>
        </div>
    </script>
    <script type="text/html" id="toolbartab">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="repaySearch">查询</button>
            <button class="layui-btn layui-btn-sm" lay-event="getDelect">删除历史还款记录</button>
        </div>
    </script>
    <script>
        var repaymentId
        layui.use(['form', 'table','element','laydate'], function(){
            var element =layui.element;
            var table = layui.table;
            var form = layui.form;
            var laydate = layui.laydate
            //第一个表格
            var tableIns=table.render({
                elem: '#arrears'
                ,url:'/poCommodityEnter/selectProductInfo?isArrears=1',
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
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
                elem: '#stext'
                ,url:'/repayment/selectSupPayment'
                ,toolbar: '#toolbartab',//开启头部工具栏，并为其绑定左侧模板
                parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0, //解析接口状态
                        "data": res.obj, //解析数据列表
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
            table.on('toolbar(arrears)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'search':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['40%', '60%'],
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
                    case 'repayment':
                        layer.open({
                            type:1,
                            title: '供货商欠款还款统计',
                            shade: 0.3,
                            area: ['40%', '50%'],
                            content:'<div style="padding: 8px;">\n' +
                                '           <form class="layui-form" action="">\n'+
                                '                <div class="items">按时间查询</div>\n' +
                                '                <div class="layui-form-item" style="margin-left:-29px">\n' +
                                '                    <div class="layui-input-block">\n' +
                                '                        <input type="radio" name="search" value="按日查询" title="按日查询"  lay-filter="level1" checked class="radio1">\n' +
                                '                        <input type="radio" name="search" value="按月查询" title="按月查询"   lay-filter="level2" class="radio2">\n' +
                                '                        <input type="radio" name="search" value="按年查询" title="按年查询"  lay-filter="level3"  class="radio3">\n' +
                                '                        <input type="radio" name="search" value="按时间段查询" title="按时间段查询"  lay-filter="level4"   class="radio4">\n' +
                                '                        <input type="radio" name="search" value="所有时间" title="所有时间"   lay-filter="level5"  class="radio5">\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <%--时间选择--%>\n' +
                                '                <div>\n' +
                                '                    <%--日--%>\n' +
                                '                    <div class="layui-form-item datatimes1" style="display: flex;width: 100%">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="day" placeholder="请选择日份">\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--月--%>\n' +
                                '                    <div class="layui-form-item datatimes2" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="month"  placeholder="请选择月份">\n' +
                                '                            </div>\n' +
                                '                            <span style="display: inline-block;margin-top: 12px;">月</span>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="year" placeholder="请选择年">\n' +
                                '                            </div>\n' +
                                '                            <span style="display: inline-block;margin-top: 12px;">年</span>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                    <%--年--%>\n' +
                                '                    <div class="layui-form-item datatimes3" style="display: flex;width: 100%;display: none">\n' +
                                '                        <div class="layui-inline">\n' +
                                '                            <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>请选择</label>\n' +
                                '                            <div class="layui-input-inline">\n' +
                                '                                <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" id="years" placeholder="请选择年份">\n' +
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
                                '                <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">供货商</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '                            <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" >\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '                <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                '                    <div class="layui-inline">\n' +
                                '                        <label class="layui-form-label" style="width: 112px;">备注</label>\n' +
                                '                        <div class="layui-input-inline">\n' +
                                '                            <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input" >\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </form>\n' +
                                '        </div>',
                            btn: ['查询','取消', '全部还款记录'],
                            success:function (res) {
                                form.render();
                                laydate.render({
                                    elem: '#day'
                                    ,trigger: 'click'//呼出事件改成click
                                });
                                laydate.render({
                                    elem: '#month'
                                    ,trigger: 'click'//呼出事件改成click
                                    ,type: 'month'
                                });
                                laydate.render({
                                    elem: '#year'
                                    ,trigger: 'click'//呼出事件改成click
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#years'
                                    ,trigger: 'click'//呼出事件改成click
                                    ,type: 'year'
                                });
                                laydate.render({
                                    elem: '#datetime'
                                    ,trigger: 'click'//呼出事件改成click
                                });
                                laydate.render({
                                    elem: '#data'
                                    ,trigger: 'click'//呼出事件改成click
                                });
                                //日期选择器(日)
                            }
                        })
                        break;

                };

            });

            //监听第二个表格的头部监听事件
            table.on('toolbar(stext)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'repaySearch':
                        layer.open({
                            type:1,
                            title:'按时间查询',
                            shade: 0.3,
                            area: ['40%', '60%'],
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
                    case 'getDelect':
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
            //监听行单击事件
            table.on('row(arrears)', function(obj){
                var data=obj.data  //获取当前行的数据
                console.log(data)
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

            //监听第二行单击事件
            table.on('row(stext)', function(obj){
                var data=obj.data  //获取当前行的数据
                $(this).addClass('bg').siblings().removeClass('bg')
                repaymentId = data.repaymentId
            });
        })
    </script>
</body>
</html>
