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
    <form class="layui-form" action="" id="ajaxforms" lay-filter="formTest">
        <div class="layui-form">
        <div style="display: flex;margin-top: 15px;">
            <div class="layui-form-item">
                <label class="layui-form-label">欠款供货商:</label>
                <div class="layui-input-block">
                    <select name="supplierName" class="supplierName" lay-verify="required" lay-filter="supplierName">
                        <option value=""></option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item" id="supplierName" style="display: none">
                <div class="layui-input-block">
                    <input type="text" name="supplierName" placeholder="请输入欠款客户" class="layui-input">
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-sm" id="fuzzyQuery" style="margin-top: 5px;margin-left: 10px;">模糊查询</button>

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
                    <input type="repaymentTime" class="layui-input" id="test1" autocomplete = "off">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">经手人员:</label>
                <div class="layui-input-block">
                    <input type="text" name="userId" lay-verify="url" autocomplete="off" class="layui-input"
                           readonly="readonly">
                </div>
            </div>
        </div>
        <div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea name="repaymentRemark" placeholder="请输入备注" class="layui-textarea"></textarea>
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
    </form>
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
    var enterId  //表格当前行的id
    var documentNo //获取的是还款记录单号
    layui.use(['form','laydate','table'], function(){
        var form = layui.form;
        var laydate = layui.laydate;
        var table = layui.table;
        form.render()
        //执行一个laydate实例
        laydate.render({
            elem: '#test1' //指定元素
        });

        //显示欠款供货商
        $.ajax({
            url: "/poCommodityEnter/selectSupplier",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var str = '<option value="">请选择欠款供货商</option>';
                for (var i = 0; i < data.obj.length; i++) {
                    str += '<option title="' + data.obj[i].supplierName + '" value="' + data.obj[i].supplierId + '">' + data.obj[i].supplierName + '</option>'
                }
                $('select[name="supplierName"]').html(str);
                form.render('select')
            }
        })
        //经手人员
        $.ajax({
            type: 'get',
            url: '/portals/selPortalsUser',
            dataType: 'json',
            success: function (res) {
                $('input[name="userId"]').val(res.object.userName)
            }
        })
        //第一个实例
        var tableIns=table.render({
            elem: '#test'
            ,url: '/poCommodityEnter/selectProductInfo?isArrears=1' //数据接口
            ,page: true //开启分页
            ,toolbar: '#toolbarDemo'
            ,cols: [[ //表头
                {field: 'supplierName', title: '供货商',}
                ,{field: 'enterArrears', title: '欠款金额', }
                ,{field: 'enterPaid', title: '已付金额', }
                ,{field: 'lowprice', title: '合计', }
                ,{field: 'enterName', title: '商品名称', }
                ,{field: 'enterSpecs', title: '商品规格', }
                ,{field: 'enterCode', title: '商品编码', }
                ,{field: 'enterIndate', title: '入库日期',}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
        });
        //监听表格头部事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'repayment':
                    var params={
                        repaymentTime:$('#test1').val(),
                        repaymentAmount:$('input[name="repaymentAmount"]').val(),
                        enterId:enterId,
                        // userId:$('input[name="userId"]').val(),
                        repaymentRemark:$('textarea[name="repaymentRemark"]').val(),
                        supplierId:$('select[name="supplierName"] option:checked').val(),
                        documentNo:documentNo
                    }
                    layer.confirm('确定要还款吗？', function (index) {
                        $.ajax({
                            type: 'get',
                            url: '/repayment/insertSupPayment',
                            dataType: 'json',
                            data:params,
                            success: function (res) {
                                if (res.msg == 'true') {
                                    layer.msg('还款成功！', {icon: 1},function(){
                                        tableIns.reload()
                                    });
                                }else{
                                    layer.msg('请选择还款对象', {icon: 2})
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
            documentNo = data.documentNo
            enterId = data.enterId;  //获取的是点击当前刚的id
            $(this).addClass('bg').siblings().removeClass('bg')
            $('input[name="repaymentAmount"]').val(data.enterArrears)

            var option=$('#ajaxforms .supplierName option')  //欠款供货商
            $('select[name="supplierName"]').val(data.supplierId)
            form.render('select')

        });
        //监听欠款客户下拉框
        form.on('select(supplierName)', function(data){
            tableIns.reload({
                url:'/poCommodityEnter/selectProductInfo?supplierId='+data.value+'&isArrears=1',
            })
        });

        //监听欠款用户输入框
        $('input[name="supplierName"]').on('keyup',function () {
            tableIns.reload({
                url:'/poCommodityEnter/selectSupplier?supplierName='+$('input[name="supplierName"]').val()
            })
        })
    });

    $('#fuzzyQuery').on('click',function () {
        $('#supplierName').show()
    })
</script>
</body>
</html>