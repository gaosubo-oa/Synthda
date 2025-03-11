<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>客户还款</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .mbox {
            padding: 8px;
        }
        .items {
            background-color: #f2f2f2;
            text-align: center;
            height: 30px;
            line-height: 30px;
        }
        .laytable-cell-1-0-0{
            text-align: center;
        }
        .bg{
            background: #f2f2f2;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="items">请在下表中勾上需要还款的记录</div>
    <div class="layui-form">
        <div style="display: flex;margin-top: 15px;">
            <div class="layui-form-item">
            <label class="layui-form-label">欠款客户:</label>
            <div class="layui-input-block"style="width: 215px">
                <select name="customerName" lay-verify="required" lay-filter="customerName">
                    <option value=""></option>
                </select>
            </div>
            </div>
            <div class="layui-form-item" id="customerName" style="display: none">
                <div class="layui-input-block">
                    <input type="text" name="customerName" placeholder="请输入欠款客户" class="layui-input" >
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-sm" id="fuzzyQuery" style="margin-top: 5px;margin-left: 20px;">模糊查询</button>
            <%--<div style="margin-top: 11px;margin-left: 10px;">该客户累计欠款金额:<span>3</span></div>--%>

        </div>
        <div style="display: flex">
            <div class="layui-form-item">
                <label class="layui-form-label" style="padding:9px 0px;width: 100px;">本次还款金额:</label>
                <div class="layui-input-block" style="width: 216px;">
                    <input type="text" name="repaymentAmount" required   class="layui-input">
                </div>
            </div>
            <%--<button type="button" class="layui-btn layui-btn-sm" id="allOver" style="margin-left: 10px;margin-top: 5px;">取消全部还清</button>--%>
            <div class="layui-form-item">
                <label class="layui-form-label">还款日期:</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input" id="test1">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">经手人员:</label>
                <div class="layui-input-block">
                    <%--<select name="user" lay-verify="required">
                        <option value=""></option>
                    </select>--%>
                        <input type="text" name="shipper" lay-verify="url" autocomplete="off" class="layui-input"
                               readonly="readonly">
                </div>
            </div>
        </div>
        <div>
            <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <textarea name="desc" placeholder="请输入备注" class="layui-textarea"></textarea>
            </div>
        </div>
        </div>
        <div >
            <div style="background-color: #f2f2f2;height: 30px;line-height: 30px;"><i class="layui-icon layui-icon-help"></i>操作提示:<br></div>
            <p style="margin-left: 10px;">问：还款时，如果不能全部还清，先还一部分欠款时，该如何操作？</p>
            <p style="margin-left: 10px;">答：先在“欠款客户”下拉选中需要还款的客户，下面点“全部还清”按钮，系统默认将“本次还款金额”显示为全部欠款金额 如“1000”，再手工把“1000”改为本次还款的金额如“200”，然后点界面最下面的“还款”按钮，则系统默认将表格中的欠款记录自动还款200。（本次还款后，系统将显示该客户欠款“800”）
            </p>
        </div>
    </div>
    <%--表格--%>
    <div>
        <table id="test" lay-filter="test"></table>
    </div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="repayment">还款</button>
    </div>
</script>

<script>
    var documentNo
    layui.use(['form','laydate','table'], function(){
        var form = layui.form;
        var laydate = layui.laydate;
        var table = layui.table;
        form.render()
        //执行一个laydate实例
        laydate.render({
            elem: '#test1' //指定元素
        });

        //显示欠款客户
        $.ajax({
            url: "/repayment/selectCustomerId",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var str = '<option value="">请选择欠款客户</option>';
                for (var i = 0; i < data.obj.length; i++) {
                    str += '<option value="' + data.obj[i].customerId + '">' + data.obj[i].customerName + '</option>'
                }
                $('select[name="customerName"]').html(str);
                form.render('select')
            }
        })
        //经手人员
        $.ajax({
            type: 'get',
            url: '/portals/selPortalsUser',
            dataType: 'json',
            success: function (res) {
                $('input[name="shipper"]').val(res.object.userName)
            }
        })
        //第一个实例
        var tableIns=table.render({
            elem: '#test'
            ,url: '/salesShipment/selectAllSales?isArrears=1' //数据接口
            ,page: true //开启分页
            ,toolbar: '#toolbarDemo'
            ,cols: [[ //表头
               {field: 'customerName', title: '客户',}
                ,{field: 'shipmentArrears', title: '欠款金额', }
                ,{field: 'shipmentPaid', title: '已付金额', }
                ,{field: 'shipmentTotal', title: '合计', }
                ,{field: 'enterName', title: '商品名称', }
                ,{field: 'enterSpecs', title: '商品规格', }
                ,{field: 'enterCode', title: '商品编码', }
                ,{field: 'shipmentDateStr', title: '出库日期',}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj, //解析数据列表
                    "count": res.totleNum,
                };
            }
        });
        //监听事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'repayment':
                    var params={
                        documentNo:$('input[name="repaymentAmount"]').attr('documentNo'),
                        repaymentTime:$('#test1').val(),
                        repaymentAmount:$('input[name="repaymentAmount"]').val(),
                        enterId:$('input[name="repaymentAmount"]').attr('enterId'),
                        repaymentRemark:$('textarea[name="desc"]').html(),
                        customerId:$('select[name="customerName"] option:checked').val(),
                        documentNo:documentNo
                    }
                    layer.confirm('确定要还款吗？', function (index) {
                        $.ajax({
                            type: 'get',
                            url: '/repayment/insertCusPayment',
                            dataType: 'json',
                            data:params,
                            success: function (res) {
                                if (res.msg == 'true') {
                                    layer.msg('还款成功！', {icon: 1},function(){
                                        tableIns.reload()
                                    });
                                }else{
                                    layer.msg('请选择还款对象', {icon: 2});
                                }
                            }
                        })
                    });
                    break;
            };
        });
        //监听行单击事件
        table.on('row(test)', function (obj) {
            var data=obj.data
            var tr=obj.tr
            documentNo = data.documentNo
            $(this).addClass('bg').siblings().removeClass('bg')
            var option=$('#ajaxforms .customerName option')  //欠款供货商
            $('select[name="customerName"]').val(data.customerId)
            form.render('select')
            $('input[name="repaymentAmount"]').val(data.shipmentArrears)
            $('input[name="repaymentAmount"]').attr('repaymentAmount',data.shipmentArrears)
            $('input[name="repaymentAmount"]').attr('documentNo',data.documentNo)
            $('input[name="repaymentAmount"]').attr('enterId',data.enterId)

        });
        //监听欠款客户下拉框
        form.on('select(customerName)', function(data){
            tableIns.reload({
                url:'/salesShipment/selectAllSales?customerId='+data.value+'&isArrears=1',
            })
        });
        //监听欠款用户输入框
        $('input[name="customerName"]').on('keyup',function () {
           /* $.ajax({
                type: 'get',
                url: '/repayment/selectCustomerId?customerName='+$('input[name="customerName"]').val(),
                dataType: 'json',
                success: function (res) {

                }
            })*/
            tableIns.reload({
                url:'/repayment/selectCustomerId?customerName='+$('input[name="customerName"]').val()
            })
        })
    });

    $('#fuzzyQuery').on('click',function () {
        $('#customerName').show()
    })
</script>
</body>
</html>