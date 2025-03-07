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
    <title>销售退货</title>
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
    <%--<script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>

    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
</head>
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

    .layui-form-item {
        margin-bottom: 5px;
    }

    .inpWhit {
        width: 300px;
    }

    /*下拉按钮*/
    .dropbtn {
        text-align: left;
        background-color: #009688;
        color: white;
        font-size: 12px;
        border: none;
        cursor: pointer;
        height: 30px;
        width: 90px;
    }

    /* 容器 <div> - 需要定位下拉内容 */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* 下拉内容 (默认隐藏) */
    .dropdown-content {
        margin-left: 0px;
        display: none;
        position: absolute;
        top: 32px;
        background-color: #fff;
        min-width: 115px;
        text-align: center;
        line-height: 36px;
        padding-top: 10px;
        box-shadow: 0px 8px 12px 0px rgba(0, 0, 0, 0.2);
        z-index: 999999999;
    }

    .licon {
        display: inline-block;
        width: 0;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        position: absolute;
        right: 6px;
        top: 52%;
        margin-top: -3px;
        cursor: pointer;
        border-width: 6px;
        border-top-color: #fff;
        border-top-style: solid;
        transition: all .3s;
        -webkit-transition: all .3s;
    }

    * {
        font-family: "Microsoft Yahei" !important;
    }

    b {
        color: red;
    }

    /* 下拉菜单的链接 */
    .dropdown-content a {
        color: black;
        /*padding: 12px 16px;*/
        text-decoration: none;
        display: block;
    }

    /*!* 在鼠标移上去后显示下拉菜单 *!*/
    .icon-on {
        margin-top: -9px;
        -webkit-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .layui-table {
        width: 100% !important;
    }
    .bg{
        background: #f2f2f2;
    }
    td[data-field="productType"]{
        width: 87px;
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
    .share{
        width: calc(90% /3);
    }
</style>
<body>

<div class="mbox">
    <%--<div class="items">销售退货</div>--%>
    <%--按钮--%>
    <div style="margin:10px auto;margin-right: 10px;text-align: right">
        <button type="button" class="layui-btn layui-btn-sm addPerson">新建客户</button>
        <%--<button type="button" class="layui-btn layui-btn-sm">客户管理</button>--%>
        <button type="button" class="layui-btn layui-btn-sm addStock">新建仓库</button>
    </div>
    <%--添加内容--%>
    <div class="ontent">
        <form class="layui-form" action="" id="ajaxform">
            <input type="hidden"  name="returnId"/>
            <%--第一个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label" ><span style="color: red;">*</span>商品编码</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterCode" lay-verify="required|number" autocomplete="off"
                               class="layui-input" disabled>
                        <%--<input type="hidden" name="enterId">--%>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm findStock"><i
                            class="layui-icon layui-icon-search" style="vertical-align: middle;"></i> 查找商品
                    </button>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">商品大类</label>
                    <div class="layui-input-inline">
                        <input type="text" name="productType" readonly="readonly" lay-verify="required|number" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">商品名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterName" readonly="readonly" lay-verify="required|number" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>
            <%--第二个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label">规格</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterSpecs" readonly="readonly" lay-verify="required|number" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">退货人</label>
                    <div class="layui-input-inline">
                        <input type="text" name="shipper" lay-verify="url" autocomplete="off" class="layui-input"
                               readonly="readonly">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>退货日期</label>
                    <div class="layui-input-inline">
                        <%--<input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">--%>
                        <input type="text" class="layui-input" id="outTime" autocomplete="off"  name="returnDate">
                    </div>
                </div>
            </div>
            <%--第三个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>退货数量</label>
                    <div class="layui-input-inline">
                        <input type="text" name="returnNum" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>退货单价</label>
                    <div class="layui-input-inline">
                        <input type="text" name="returnPrice" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">合计</label>
                    <div class="layui-input-inline">
                        <input type="text" name="returnTotal" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>

            </div>
            <%--第四个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label" style="width: 65px;margin-left: 15px;"><span style="color: red;">*</span>客户</label>
                    <div class="layui-input-inline">
                        <input type="text" name="customerName" id="customerNo" readonly="readonly" class="layui-input"/>
                    </div>
                    <a target="_blank" style="display: inline-block;margin-top: 10px" id="selectd">选择</a>
                    <a id="del_1" style="display: inline-block;margin-top: 10px">清空</a>
                    <input type="hidden" id="customerId" name="customerId"/>
                </div>

                <div class="layui-inline share">
                    <label class="layui-form-label" style="width: 65px;margin-left: 15px;"><span style="color: red;">*</span>仓库</label>
                    <div class="layui-input-inline">
                        <input type="text" name="warehouseName" id="warehouseName" readonly="readonly" class="layui-input">
                    </div>
                    <a id="del_3"  style="display: inline-block;margin-top: 10px">选择</a>
                    <a id="del_2" style="display: inline-block;margin-top: 10px">清空</a>
                    <input type="hidden" name="warehouseId" id="warehouseId">
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-inline">
                        <input type="text" name="returnRemark" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第五个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label">库存数</label>
                    <div class="layui-input-inline" >
                        <%--<span >输入商品编码自动显示库存数</span>--%>
                        <%--输入商品编码自动显示库存数--%>
                        <input type="text" id="enterNum"class="layui-input" readonly="readonly" placeholder="输入商品编码自动显示库存数" style="padding-left: 4px;">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div>
        <table id="demo" lay-filter="test"></table>
    </div>
</div>
<%--表格--%>
<script type="text/html" id="toolbarDemo">
    <button type="button" class="layui-btn layui-btn-sm add" lay-event="add">新建</button>
    <button type="button" class="layui-btn layui-btn-sm del" lay-event="del">删除</button>
    <button type="button" class="layui-btn layui-btn-sm exit" lay-event="exit">修改</button>
    <button type="button" class="layui-btn layui-btn-sm query" lay-event="query">查询</button>
</script>

<script type="text/javascript">
    $('#selectd').on('click',function () {
        window.open('/invWarehouse/addCustomerIdsd?')
    })
    //客户
    $('#del_1').on('click',function () {

        $('#customerNo').val("")
        $('#customerId').removeAttr("value")
    })
    //仓库
    $('#del_2').on('click',function () {

        $('#warehouseName').val("")
        $('#warehouseId').removeAttr("value")
    })
    $('#del_3').on("click",function () {
     
        window.open('../salesShipment/wareHouse')
    })
    layui.use(['table', 'form', 'laydate'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var enter
        var enteres
        var storenter
        //执行一个laydate实例
        laydate.render({
            elem: '#outTime' //指定元素
            // ,type: 'datetime'
        });
        //第一个实例
        var tableIns = table.render({
            elem: '#demo'
            , url: '/salesReturn/selectAllSales' //数据接口
            , page: true //开启分页
            , toolbar: '#toolbarDemo'
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                , {field: 'productType', title: '商品大类',}
                , {field: 'enterName', title: '商品名称', }
                , {field: 'enterSpecs', title: '商品规格',}
                , {field: 'enterCode', title: '商品编码'}
                , {field: 'returnDateStr', title: '退货日期',width:120}
                , {field: 'returnNum', title: '退货数量'}
                , {field: 'returnPrice', title: '退货单价'}
                , {field: 'returnTotal', title: '退货合计', }
                , {field: 'customerName', title: '客户'}
                , {field: 'shipper', title: '退货人'}
                , {field: 'returnNum', title: '出库数量',templet:function (d) {
                        return '-'+d.returnNum
                    }}
                , {field: 'returnTotal', title: '合计',templet:function (d) {
                        return '-'+d.returnTotal
                    }}
                , {field: 'warehouseName', title: '仓库',}
                , {field: 'documentNo', title: '单据号', }
                , {field: 'returnRemark', title: '备注', }
                /*  , {title: '操作', align: 'center', toolbar: '#barDemo', width: 150}*/
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj, //解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
            , done: function (res, curr, count) {
            }
        });


        //监听行单击事件

        table.on('row(test)', function (obj) {
            var data=obj.data
            var tr=obj.tr
            storenter = data.enterId
            $(this).addClass('bg').siblings().removeClass('bg')
            $('input[name="returnId"]').val(data.returnId)
            $('input[name="enterCode"]').val(data.enterCode)
            $('input[name="enterId"]').val(data.enterId)
            $('input[name="returnNum"]').val(data.returnNum)
            $('input[name="customerName"]').val(data.customerName)
            $('input[name="customerId"]').val(data.customerId)
            $('input[name="productType"]').val(data.productType)
            $('input[name="returnPrice"]').val(data.returnPrice)
            $('input[name="returnDate"]').val(data.returnDateStr)
            $('input[name="enterName"]').val(data.enterName)
            $('input[name="returnTotal"]').val(data.returnTotal)
            $('input[name="shipper"]').val(data.shipper)
            $('input[name="enterSpecs"]').val(data.enterSpecs)
            // $('input[name="shipmentPaid"]').val(data.shipmentPaid)
            $('input[name="warehouseName"]').val(data.warehouseName)
            $('input[name="warehouseId"]').val(data.warehouseId)
            // $('input[name="shipmentArrears"]').val(data.shipmentArrears)
            $('input[name="returnRemark"]').val(data.returnRemark)
            var enterCode = $('input[name="enterCode"]').val()
            if(enterCode!=''){
                $.ajax({
                    type: 'post',
                    url: '/poCommodityEnter/selectProductInfo',
                    dataType: 'json',
                    data: {enterCode: enterCode},
                    success: function (res) {
                        if(res.flag==true){
                            var data = res.obj[0]
                            /*    $('input[name="productType"]').val(data.productTypeName)
                                $('input[name="enterName"]').val(data.enterName)
                                $('input[name="enterSpecs"]').val(data.enterSpecs)
                                $('input[name="enterId"]').val(data.enterId)*/
                            $('#enterNum').val(data.enterNum)
                        }else{
                            /*$('input[name="productType"]').val('')
                            $('input[name="enterName"]').val('')
                            $('input[name="enterSpecs"]').val('')
                            $('input[name="enterId"]').val('')*/
                            $('#enterNum').val('输入商品编码自动显示库存数')
                        }
                    }
                })
            }
        });

        //新添客户
        $('.addPerson').on('click',function () {
            layer.open({
                type: 1,
                title: '新建客户',
                shade: 0.3,
                area: ['70%', '80%'],
                content: '<div class="layui-form">' +
                    '<form id="ajaxforms" action="/customer/addWorkbench"><div><div class="items">基本信息</div><div style="display: flex;margin-top:10px" >\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户名称:<b>*</b></label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="customerName" id="customerName" required lay-verify="required" placeholder="请输入客户名称"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户经理:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="customerManager" required lay-verify="required" placeholder="请输入客户经理"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户状态:<b>*</b></label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <select name="customerStatus"  id="customerStatus">\n' +
                    '                        <option value="">选择客户状态</option>\n' +
                    '                    </select> </div>\n' +
                    '            </div>\n' +
                    '        </div><div style="display: flex">\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户来源:<b>*</b></label>\n' +
                    '                <div class="layui-input-block"> <select name="customerFrom" id="customerFrom">\n' +
                    '                        <option value="">选择客户来源</option>\n' +
                    '                    </select></div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户级别:<b>*</b></label>\n' +
                    '                <div class="layui-input-block"> <select name="customerLevel" id="customerLevel">\n' +
                    '                        <option value="">选择客户级别</option>\n' +
                    '                    </select></div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">客户行业:<b>*</b></label>\n' +
                    '                <div class="layui-input-block"> ' +
                    '<select name="customerIndustry">\n' +
                    '                        <option value="">选择客户行业</option>\n' +
                    '                    </select></div>\n' +
                    '            </div>\n' +
                    '        </div><div style="display: flex">\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">预计成交额:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="expectPrice" required lay-verify="required" placeholder="请输入预计成交额"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">成交日期:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="expectTime" id="transaction" required lay-verify="required" placeholder="请输入预计成交日期"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">公司地址:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="address" required lay-verify="required" placeholder="请输入公司地址"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div><div style="display: flex">\n' +
                    '            <div class="layui-form-item" style="display:flex">\n' +
                    '                <label class="layui-form-label">所在地区:</label>\n' +
                    '                <div class="layui-input-block" style="width:103px;margin-left:0px"><select name="province" id="sheng" lay-filter="sheng" style="width: 125px">\n' +
                    '                        <option>请选择</option>\n' +
                    '                    </select></div>' +
                    '<div class="layui-input-block" style="width:103px;margin-left: 4px;"><select name="city"  id="city" style="width: 125px">\n' +
                    '                        <option>请选择</option>\n' +
                    '                    </select>'+
                    '</div>\n' +
                    '            </div>\n' +
                    '             <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">电子邮箱:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="linkEmail" id="linkEmail" required lay-verify="required" placeholder="请输入电子邮箱"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">公司网址:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="website" required lay-verify="required" placeholder="请输入公司网址"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div><div style="display: flex">\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">公司规模:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="scale" required lay-verify="required" placeholder="请输入公司规模"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">邮政编码:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="zipCode" required lay-verify="required" placeholder="请输入邮政编码"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">年销售额:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input type="text" name="annualSales" required lay-verify="required" placeholder="请输入年销售额"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div></div>' +
                    '<div><div class="items">联系人信息:</div>' +
                    '<div style="display: flex;margin-top:10px">' +
                    '  <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label" style="width:85px;padding: 9px 12px;">联系人姓名:<b>*</b></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '                    <input type="text" name="linkmanName" id="linkmanName" required lay-verify="required" placeholder="请输入年销售额"\n' +
                    '                           autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '  </div>' +
                    '   <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人性别:</label>' +
                    ' <input type="radio" name="sex" checked="checked"  id="male" title="男" value="1"/>\n' +
                    '  <input type="radio" name="sex"  id="woman" title="女" value="2"/></div>' +
                    ' <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人职务:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="job" required  lay-verify="required" placeholder="请输入联系人职务" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div>' +
                    '<div style="display: flex"><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人部门:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="department" required  lay-verify="required" placeholder="请输入联系人部门" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人手机:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="mobile" required  lay-verify="required" placeholder="请输入联系人手机" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    '<div style="display: flex"> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人邮箱:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="email" required  lay-verify="required" placeholder="请输入联系人邮箱" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人微信:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="wechat" required  lay-verify="required" placeholder="请输入联系人微信" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">联系人QQ:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="qq" required  lay-verify="required" placeholder="请输入联系人QQ" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    '  <div class="layui-form-item layui-form-text" style="width: 900px;">\n' +
                    '    <label class="layui-form-label">备注:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <textarea name="remark" placeholder="请输入备注" class="layui-textarea"></textarea>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div>' +
                    '</form></div>',
                btn: ['保存', '取消'],
                success:function(){
                    laydate.render({
                        elem: '#transaction' //指定元素
                    });
                    form.render()
                    $.ajax({
                        url: "/customer/selectByIndustry",
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            var str = ''
                            for (var i = 0; i < data.obj.length; i++) {
                                str += '<option value="' + data.obj[i].codeNo + '">' + data.obj[i].codeName + '</option>'
                            }
                            $('[name="customerIndustry"]').append(str);
                            form.render('select')
                        }
                    })
                    //select 根据ajax绑定数据 循环显示
                    $.ajax({
                        url: "/customer/selectByStatus",
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            var str = '<option value="">请选择客户状态</option>';
                            for (var i = 0; i < data.object.length; i++) {
                                str += '<option value="' + data.object[i].codeNo + '">' + data.object[i].codeName + '</option>'
                            }
                            $('[name="customerStatus"]').html(str);
                            form.render('select')
                        }
                    })
                    $.ajax({
                        url: "/customer/selectBySource",
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            var str = '<option value="">请选择客户来源</option>';
                            for (var i = 0; i < data.obj.length; i++) {
                                str += '<option value="' + data.obj[i].codeNo + '">' + data.obj[i].codeName + '</option>'
                            }
                            $('[name="customerFrom"]').html(str);
                            form.render('select')
                        }
                    })
                    $.ajax({
                        url: "/customer/selectByLevel",
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            var str = '<option value="">请选择客户级别</option>';
                            for (var i = 0; i < data.object.length; i++) {
                                str += '<option value="' + data.object[i].codeNo + '">' + data.object[i].codeName + '</option>'
                            }
                            $('[name="customerLevel"]').html(str);
                            form.render('select')
                        }
                    })
                    var sheng = '<option value="">请选择</option>';
                    for (var i = 0; i < json.provinces.length; i++) {
                        sheng += '<option value="' + json.provinces[i].name + '">' + json.provinces[i].name + '</option>'
                    }
                    $('#sheng').html(sheng);
                    form.render('select')
                    form.on('select(sheng)', function(data){
                        var prov=data.value
                        // console.log(data.value); //得到被选中的值
                        var citys = '<option value="">请选择</option>';
                        for (var i = 0; i < json.provinces.length; i++) {
                            if (json.provinces[i].name == prov) {
                                if (json.provinces[i].citys != '' && json.provinces[i].citys != undefined) {
                                    for (var j = 0; j < json.provinces[i].citys.length; j++) {
                                        citys += '<option value="' + json.provinces[i].citys[j] + '">' + json.provinces[i].citys[j] + '</option>'
                                    }
                                }
                            }
                        }
                        $('#city').html(citys);
                        form.render('select')
                    });
                },
                yes: function (index) {
                    var email = $('#email').val();
                    var linkEmail = $('#linkEmail').val();
                    var bo = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(email);
                    var ao = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(linkEmail);
                    if ($('#customerName').val() == '') {
                        layer.msg('请输入客户名称 ！', {icon: 2});
                    } else if ($('#customerStatus option:selected').val() == '') {
                        layer.msg('请选择客户状态！', {icon: 2});
                    } else if ($('#customerFrom option:selected').val() == '') {
                        layer.msg('请选择客户来源！', {icon: 2});
                    } else if ($('#customerLeve option:selected').val() == '') {
                        layer.msg('请选择客户级别！', {icon: 2});
                    } else if (linkEmail != '' && ao == false) {
                        layer.msg('电子邮箱格式错误 ！', {icon: 2});
                    } else if ($('#linkmanName').val() == '') {
                        layer.msg('请输入联系人姓名 ！', {icon: 2});
                    } else {
                        $.ajax({
                            url: '/customer/insertCustomer',
                            type: 'post',
                            dataType: 'json',
                            data: $('#ajaxforms').serialize(),
                            success: function (data) {
                                if (data.flag) {
                                    layer.msg('保存成功！', {icon: 1}, function () {
                                        window.close();
                                        window.location.href = '/salesShipment/index'
                                    });
                                    /*添加成功*/
                                } else {
                                    layer.msg('保存失败！', {icon: 2});
                                    /*添加失败*/
                                }
                            },
                            error: function (data) {
                                layer.msg('保存失败！', {icon: 2});
                                /*添加失败*/
                            }
                        })
                    }
                }
            })
        })
        //新添仓库
        $('.addStock').on('click',function () {
            layer.open({
                // title: title,
                shade: 0.3,
                title:'新建仓库',
                area:['550px','350px'],
                content: '<div class="newpop">' +
                    '<div class="list_group">' +
                    '<label for="sortNum" class="toryList">仓库名称:</label>' +
                    '<input type="text" id="warehouseName" class="save_w"></div>' +
                    '<div class="list_group"><label for="catalog" class="toryList">仓库联系人:</label>' +
                    '<input type="text" id="warehousePerson" class="save_w"></div>' +
                    '<div class="list_group"><label for="path" class="toryList">联系人电话:</label>' +
                    '<input type="text" id="warehousePhone" class="save_w">' +
                    '</div>' +

                    '<div class="list_group">' +
                    '<label for="defaultSort" class="toryList">所属省市 :</label>' +
                    '<select name="province" style="width:200px;border-radius: 3px;height: 28px" id="province" class="province">'+
                    '</select>' +
                    '<select name="city" style="width:200px;border-radius: 3px;margin-left: 10px;height: 28px" id="city" class="city">' +
                    '</select>' +
                    '</div>'+
                    '<div class="list_group"><label for="maxcap" class="toryList"> 仓库地址:</label>' +
                    '<input type="text" id="warehouseAdress" class="save_w" value=""></div>' +
                    '<div class="list_group"><label for="maxcap" class="toryList"> 备注:</label>' +
                    '<textarea name="warehouseRemarks" id="warehouseRemarks" style="width: 412px;height: 50px;vertical-align: middle;border-radius: 3px" cols="30" rows="10"></textarea></div>' +
                    '</div>',
                area: ['600px','470px'],
                btn: ['确认', '返回'],
                yes: function () {
                    var data = {
                        warehouseName: $('.list_group #warehouseName').val(),
                        warehousePerson: $('#warehousePerson').val(),
                        warehousePhone: $('#warehousePhone').val(),
                        province: $('#province').val(),
                        city: $('#city').val(),
                        warehouseAdress: $('#warehouseAdress').val(),
                        warehouseRemarks: $('#warehouseRemarks').val()
                    }
                    $.ajax({
                        url: '/invWarehouse/insertInvHouse',
                        type: 'get',
                        dataType: 'json',
                        data: data,
                        success: function (data) {
                            if (data.flag) {
                                layer.msg('添加成功。', {icon: 6})
                                list();
                            }else {
                                $.layerMsg({content:'添加失败',icon:2});
                            }
                        }
                    })
                    window.location.reload();
                }
                ,success:function(){
                    var sheng = '<option value="">请选择</option>'
                    for(var i=0;i<json.provinces.length;i++){
                        sheng += '<option value="'+json.provinces[i].name+'">'+json.provinces[i].name+'</option>'
                    }
                    $('#province').html(sheng);
                    $('#province').on('change',function(){
                        var prov = $(this).val();
                        var citys = '<option value="">请选择</option>'
                        for(var i=0;i<json.provinces.length;i++){
                            if(json.provinces[i].name == prov){

                                if(json.provinces[i].citys!=""&&json.provinces[i].citys!=undefined){
                                    for(var j=0;j<json.provinces[i].citys.length;j++){
                                        citys += '<option value="'+json.provinces[i].citys[j]+'">'+json.provinces[i].citys[j]+'</option>'
                                    }
                                }
                                //
                            }
                        }
                        $('#city').html(citys);
                    })
                }
            })
        })

        //查找商品
        $('.findStock').on('click',function () {
            layer.open({
                type: 1 //Page层类型
                , area: ['100%', '100%']
                , title: '商品编码查询'
                , maxmin: true //允许全屏最小化
                , content: '<div class="layui-form" id="findStock" style="margin-top: 10px">' +
                    '<table class="layui-hide" id="store" lay-filter="store"></table>\n'+
                    '</div>'
                , btn: ['确定', '取消']
                ,success:function(res){
                    //第一个实例
                    var tableIns = table.render({
                        elem: '#store'
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
                                "count": res.totleNum
                            };
                        }
                    });
                    //监听行单击事件
                    table.on('row(store)', function (obj) {
                        var data = obj.data
                        enter = data.enterId
                    })
                }
                , yes: function (index) {
                    var productType = $('#findStock input[name="productType"]').val()
                    var enterName = $('#findStock input[name="enterName"]').val()
                    var enterSpecs = $('#findStock input[name="enterSpecs"]').val()
                    var enterCode = $('#findStock input[name="enterCode"]').val()
                    $.ajax({
                        type: 'post',
                        url: '/poCommodityEnter/selectProductInfo',
                        dataType: 'json',
                        data: {
                            productType: productType,
                            enterName: enterName,
                            enterSpecs: enterSpecs,
                            enterCode: enterCode,
                            enterId:enter
                        },
                        success: function (res) {
                            layer.close(index)
                            var data = res.obj[0]
                            $('input[name="enterCode"]').val(data.enterCode)
                            $('input[name="productType"]').val(data.productTypeName)
                            $('input[name="enterName"]').val(data.enterName)
                            $('input[name="enterSpecs"]').val(data.enterSpecs)
                            if(data.enterNum==undefined){
                                $('#enterNum').val(0)
                            }else{
                                $('#enterNum').val(data.enterNum)
                            }
                            enteres = res.obj[0].enterId
                        }
                    })
                },
            });
        })
        /*监听头部菜单*/
        table.on('toolbar(test)', function(obj) {
            var event = obj.event;
            switch (event) {
                case 'add':
                    var enterCode = $('input[name="enterCode"]').val()
                    if (enterCode == '') {
                        layer.msg('请填写商品编码', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnNum"]').val() == "") {
                        layer.msg('请填写退货数量', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnPrice"]').val() == "") {
                        layer.msg('请填写退货单价', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnDate"]').val() == "") {
                        layer.msg('请填写退货日期', {icon: 2});
                        return false
                    }
                    if ($('input[name="customerName"]').val() == "") {
                        layer.msg('请填写客户', {icon: 2});
                        return false
                    }
                    if ($('input[name="warehouseName"]').val() == "") {
                        layer.msg('请填写仓库', {icon: 2});
                        return false
                    }
                    var ente
                    if (enteres == undefined) {
                        ente = storenter
                    } else {
                        ente = enteres
                    }
                    $.ajax({
                        type: 'get',
                        url: '/salesReturn/insertSales?' + $('#ajaxform').serialize() + '&enterId=' + ente,
                        dataType: 'json',
                        success: function (res) {
                            if (res.msg == 'true') {
                                layer.msg('添加成功！', {icon: 1});
                            }
                            // tableIns.reload()
                            window.location.reload()
                            $('input[name="enterCode"]').val('')
                            $('input[name="returnNum"]').val('')
                            $('input[name="customerName"]').val('')
                            $('input[name="productType"]').val('')
                            $('input[name="returnPrice"]').val('')
                            $('input[name="returnDate"]').val('')
                            $('input[name="enterName"]').val('')
                            $('input[name="returnTotal"]').val('')
                            $('input[name="shipper"]').val('')
                            $('input[name="enterSpecs"]').val('')
                            // $('input[name="shipmentPaid"]').val('')
                            $('input[name="warehouseId"]').val('')
                            $('input[name="warehouseName"]').val('')
                            // $('input[name="shipmentArrears"]').val('')
                            $('input[name="returnRemark"]').val('')
                            $('input[name="enterId"]').val('')
                            $('#enterNum').val('输入商品编码自动显示库存数')
                        }
                    })
                    break;
                case 'del':
                    var returnId = $('input[name="returnId"]').val()
                    if(returnId.length=='0'){
                        layer.msg('请选择一条进行删除');
                        return false;
                    }else{
                        layer.confirm('真的删除当前数据吗？', function (index) {
                        $.ajax({
                            type: 'get',
                            url: '/salesReturn/delOmReturnById?returnId=' + returnId,
                            dataType: 'json',
                            success: function (res) {
                                if (res.msg == 'true') {
                                    layer.msg('删除成功！', {icon: 1}, function () {
                                        // tableIns.reload()
                                       window.location.reload()
                                    });

                                }
                            }
                        })
                    });
                    }
                    break;
                case 'exit':
                    var enterCode = $('input[name="enterCode"]').val()
                    if (enterCode == '') {
                        layer.msg('请填写商品编码', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnNum"]').val() == "") {
                        layer.msg('请填写退货数量', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnPrice"]').val() == "") {
                        layer.msg('请填写退货单价', {icon: 2});
                        return false
                    }
                    if ($('input[name="returnDate"]').val() == "") {
                        layer.msg('请填写退货日期', {icon: 2});
                        return false
                    }
                    if ($('input[name="customerName"]').val() == "") {
                        layer.msg('请填写客户', {icon: 2});
                        return false
                    }
                    if ($('input[name="warehouseName"]').val() == "") {
                        layer.msg('请填写仓库', {icon: 2});
                        return false
                    }
                    var enteridee
                    if (enteres == undefined) {
                        enteridee = storenter
                    } else {
                        enteridee = enteres
                    }
                    $.ajax({
                        type: 'post',
                        url: '/salesReturn/updateReturnById?' + $('#ajaxform').serialize() + '&enterId=' + enteridee,
                        dataType: 'json',
                        success: function (data) {
                            layer.msg('修改成功！', {icon: 1}, function () {
                                // tableIns.reload()
                                window.location.reload()
                            });
                            $('#ajaxform input').val('')
                        }
                    })
                    break;
                case 'query':
                    layer.open({
                        type: 1,//Page层类型
                        area: ['800px', '600px'],
                        title: '按时间查询',
                        maxmin: true,//允许全屏最小化
                        content: '<div class="layui-form chaXun"><div class="shiJian" style="width: 350px;margin: 0px auto"><input lay-filter="day" type="radio" name="time" value="" title="按日查询" checked>' +
                            '<input lay-filter="month" type="radio" name="time" value="" title="按月查询" >\n' +
                            '<input lay-filter="year" type="radio" name="time" value="" title="按年查询" >\n' +
                            /* '<input lay-filter="time" type="radio" name="time" value="" title="按时间段查询" >\n' +
                             '<input lay-filter="allTime" type="radio" name="time" value="" title="所有时间" checked >' +*/
                            '</div>' +
                            '<div>' +
                            '<div style="margin: 10px 0px;" id="day" ><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="dayQuery" id="dayQuery" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            // '<div style="display: none;margin: 10px 0px;"  id="month"><span style="margin-left:17%">请选择(必填)</span><input type="text" class="layui-input" id="monthQuery1" style="display: inline-block;width: 150px;margin-left:5%">月<input type="text" class="layui-input" id="monthQuery2" style="display: inline-block;width: 150px;">年</div>' +
                            '<div style="display: none;margin: 10px 0px;"  id="month"><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="monthQuery1" id="monthQuery1" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            '<div style="display: none;margin: 10px 0px;"id="year"><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="yearQuery" id="yearQuery" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            // '<div style="display: none;margin: 10px 0px;" id="time"><span style="margin-left:17%">请选择(必填)</span><span style="margin-left:5%">从</span><input type="text" class="layui-input" id="timeQuery1" style="display: inline-block;width: 150px;">至<input type="text" class="layui-input" id="timeQuery2" style="display: inline-block;width: 150px;"></div>' +
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
                            '    <label class="layui-form-label">客户</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="customerName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div style="display: flex;margin-left: 30px;"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">商品名称</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="enterName" lay-verify="required" lay-filter="enterName">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label">出货人</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="shipper" lay-verify="required">\n' +
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
                            '    <label class="layui-form-label">仓库</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="warehouseName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div style="display: flex;margin-left: 30px;"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">商品编码</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            /*  '      <select name="enterCode" lay-verify="required">\n' +
                              '      </select>\n' +*/
                            '<input type="text" name="enterCode"  autocomplete="off"  readonly="readonly" class="layui-input">' +
                            '<input type="hidden" name="enterId" class="layui-input">' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item" style="margin-bottom:8px;width:327px">\n' +
                            '    <label class="layui-form-label">单据号</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '<input type="text" name="documentNo" required  lay-verify="required" placeholder="请输入单据号" autocomplete="off" class="layui-input">' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div class="layui-form-item layui-form-text" style="width: 657px;margin-left:27px">\n' +
                            '    <label class="layui-form-label">备注</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <textarea name="returnRemark" placeholder="请输入备注" class="layui-textarea"></textarea>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div class="layui-form-item isArrears">\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="checkbox" name="isArrears" title="查询尚未付清货款的欠款记录" lay-skin="primary">\n' +
                            '    </div>\n' +
                            '  </div>' +
                            ' <div class="layui-form-item">\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="radio" name="record" value="" title="仅显示销售出货记录" checked>\n' +
                            '      <input type="radio" name="record" value="" title="将销售出货记录和销售退货记录一起显示" >\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '<div><p style="text-indent:23px;padding: 0px 32px;color:#666">温馨提示:查询某客户的消费记录，先按时间查询选择“所有时间”，再从“客户”下拉框中选择要查的客户，按“查询”按钮即可，查询该客户一月或一年的消费记录，则将时间改成按月查询或按年查询即可。</p></div>' +
                            '</div>',
                        btn: ['确定', '取消'],
                        success: function (res) {
                            form.render()
                            laydate.render({
                                elem: '#dayQuery' //指定元素
                            });
                            laydate.render({
                                elem: '#monthQuery1' //指定元素
                                , type: 'month'
                                // , format: 'MM'
                            });
                            /*laydate.render({
                                elem: '#monthQuery2' //指定元素
                                , type: 'year'
                            });*/
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
                            });
                            form.on('radio(month)', function (data) {
                                $('#day').hide()
                                $('#month').show()
                                $('#year').hide()
                                $('#time').hide()
                            });
                            form.on('radio(year)', function (data) {
                                $('#day').hide()
                                $('#month').hide()
                                $('#year').show()
                                $('#time').hide()
                            });
                            /* form.on('radio(time)', function (data) {
                                 $('#day').hide()
                                 $('#month').hide()
                                 $('#year').hide()
                                 $('#time').show()
                             });
                             form.on('radio(allTime)', function (data) {
                                 $('#day').hide()
                                 $('#month').hide()
                                 $('#year').hide()
                                 $('#time').hide()
                             });*/
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
                            form.on('select(productType)', function (data) {
                                var productTypeId = data.value
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType=" + productTypeId,
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
                            form.on('select(enterName)', function (data) {
                                var enterName = data.value
                                var productTypeId = $('.chaXun [name="productType"] option:checked').val()
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType=" + productTypeId + '&enterName=' + enterName,
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
                            form.on('select(enterSpecs)', function (data) {
                                var enterName = $('.chaXun [name="enterName"] option:checked').val()
                                var productTypeId = $('.chaXun [name="productType"] option:checked').val()
                                $.ajax({
                                    url: "/poCommodityEnter/selectProductInfo?productType=" + productTypeId + '&enterName=' + enterName,
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

                        },
                        yes: function (index) {
                            var timeQuery = $('.shiJian .layui-form-radio')
                            var type
                            var returnDateStr
                            var isArrears
                            if (timeQuery.eq(0).hasClass("layui-form-radioed")) {
                                type = 1
                                returnDateStr = $('#day input[name="dayQuery"]').val()
                            } else if (timeQuery.eq(1).hasClass("layui-form-radioed")) {
                                type = 2
                                returnDateStr = $('#month input[name="monthQuery1"]').val()
                            } else if (timeQuery.eq(2).hasClass("layui-form-radioed")) {
                                type = 3
                                returnDateStr = $('#year input[name="yearQuery"]').val()
                            }
                            if ($('.isArrears [name="isArrears"]').next().hasClass("layui-form-checked")) {
                                isArrears = 1
                            } else {
                                isArrears = 0
                            }
                            var enterId = $('.chaXun [name="enterId"]').val();
                            var customerName = $('.chaXun select[name="customerName"] option:checked').val()
                            var shipper = $('.chaXun select[name="shipper"] option:checked').val()
                            var warehouseName = $('.chaXun  [name="warehouseName"] option:checked').val()
                            var documentNo = $('.chaXun input[name="documentNo"]').val()
                            var returnRemark = $('.chaXun textarea[name="returnRemark"]').val()
                            layer.close(index)
                            tableIns.reload({
                                url: '/salesReturn/selectAllSales',
                                where: {
                                    type: type,
                                    returnDateStr: returnDateStr,
                                    enterId: enterId,
                                    customerName: customerName,
                                    shipper: shipper,
                                    warehouseName: warehouseName,
                                    documentNo: documentNo,
                                    returnRemark: returnRemark,
                                    isArrears: isArrears
                                }
                            })
                        }
                    });
                    break
            }
        })
    });

    //监听商品编码
    $('input[name="enterCode"]').on('keyup',function () {
        var enterCode = $('input[name="enterCode"]').val()
        if(enterCode!=''){
            $.ajax({
                type: 'post',
                url: '/poCommodityEnter/selectProductInfo',
                dataType: 'json',
                data: {enterCode: enterCode},
                success: function (res) {
                    if(res.flag==true){
                        var data = res.obj[0]
                        $('input[name="productType"]').val(data.productTypeName)
                        $('input[name="enterName"]').val(data.enterName)
                        $('input[name="enterSpecs"]').val(data.enterSpecs)
                        $('input[name="enterId"]').val(data.enterId)
                        $('#enterNum').val(data.enterNum)
                    }else{
                        $('input[name="productType"]').val('')
                        $('input[name="enterName"]').val('')
                        $('input[name="enterSpecs"]').val('')
                        $('input[name="enterId"]').val('')
                        $('#enterNum').val('输入商品编码自动显示库存数')
                    }

                }
            })
        }
    })
    //监听退货数量
    $('input[name="returnNum"]').on('keyup',function () {
        var returnNum = $('input[name="returnNum"]').val()
        var returnPrice = $('input[name="returnPrice"]').val()
        var returnTotal = returnNum*returnPrice
        $('input[name="returnTotal"]').val(returnTotal)
    })
    //监听退货单价
    $('input[name="returnPrice"]').on('keyup',function () {
        var returnNum = $('input[name="returnNum"]').val()
        var returnPrice = $('input[name="returnPrice"]').val()
        var returnTotal = returnNum*returnPrice
        $('input[name="returnTotal"]').val(returnTotal)
    })

    $(function () {
        $('#del_1').on('click',function () {
            $('#customerNo').removeAttr("value")
            $('#customerId').removeAttr("value")
        })
        $('#del_2').on('click',function () {
            $('#warehouseName').val("")
            $('#warehouseId').removeAttr("value")
        })
        //select 根据ajax绑定数据 循环显示
        $.ajax({
            url: "/customer/selectByStatus",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var str = '<option value="">请选择客户状态</option>';
                for (var i = 0; i < data.object.length; i++) {
                    str += '<option value="' + data.object[i].codeNo + '">' + data.object[i].codeName + '</option>'
                }
                $('[name="customerStatus"]').html(str);
            }
        })
        $.ajax({
            url: "/customer/selectBySource",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var str = '<option value="">请选择客户来源</option>';
                for (var i = 0; i < data.obj.length; i++) {
                    str += '<option value="' + data.obj[i].codeNo + '">' + data.obj[i].codeName + '</option>'
                }
                $('[name="customerFrom"]').html(str);
            }
        })
        $.ajax({
            url: "/customer/selectByLevel",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                var str = '<option value="">请选择客户级别</option>';
                for (var i = 0; i < data.object.length; i++) {
                    str += '<option value="' + data.object[i].codeNo + '">' + data.object[i].codeName + '</option>'
                }
                $('[name="customerLevel"]').html(str);
            }
        })
        //退货人
        $.ajax({
            type: 'get',
            url: '/portals/selPortalsUser',
            dataType: 'json',
            success: function (res) {
                $('input[name="shipper"]').val(res.object.userName)
            }
        })
    })
    //下拉
    function selectFn(that) {
        var dis = $(that).next(".dropdown-content").css("display");
        if(dis == "none"){
            if($(that).parents(".dropbox").find(".icon-on").hasClass("icon-on")){
                $(that).parents(".dropbox").find(".icon-on").parent().next(".dropdown-content").fadeOut()
                $(that).parents(".dropbox").find(".icon-on").removeClass("icon-on");
            }
            $(that).next(".dropdown-content").fadeIn();
            $(that).find(".licon").addClass("icon-on");
        }else if(dis == "block"){
            $(that).next(".dropdown-content").fadeOut();
            $(that).find(".licon").removeClass("icon-on");
        }
    }
</script>
</body>
</html>

