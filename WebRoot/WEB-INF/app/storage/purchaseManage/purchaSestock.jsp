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
    <title>采购进货</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <%--<link rel="stylesheet" type="text/css" href="../css/base.css"/>--%>
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
    .layui-form-item{
        margin-bottom: 5px;
    }
    .spans .layui-form-checked span{
        height: auto;
    }
    .inpWhit{
        width: 300px;
    }
    .layui-form-checkbox span{
        height: auto;
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
        top:32px;
        background-color: #fff;
        min-width: 115px;
        text-align: center;
        line-height: 36px;
        padding-top: 10px;
        box-shadow: 0px 8px 12px 0px rgba(0,0,0,0.2);

    }
    .licon{
        display: inline-block;
        width: 0;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        position: absolute;
        right: 13px;
        top: 42%;
        margin-top: -3px;
        cursor: pointer;
        border-width: 6px;
        border-top-color: #fff;
        border-top-style: solid;
        transition: all .3s;
        -webkit-transition: all .3s;
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
    .top{
        margin-bottom: 10px;
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
    .share{
        width: calc(95% /3);
    }
    .padd{
        margin-left: 5%;
    }
    .addExecute{
        display: inline-block;
        margin-top: 10px
    }
</style>
<body>
<div class="mbox">
    <%--按钮--%>
    <div style="margin:10px auto;text-align: right">
        <button type="button" class="layui-btn layui-btn-sm addwarehouse">新建仓库</button>
        <button type="button" class="layui-btn layui-btn-sm addsupplier">新建供货商</button>
        <button type="button" class="layui-btn layui-btn-sm category">新建商品类别</button>
    </div>
    <%--添加内容--%>
    <div class="content">
        <form class="layui-form" action="" id="ajaxforms" lay-filter="formTest">
            <%--第一个--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label padd"><span style="color: red;">*</span>商品大类</label>
                    <div class="layui-input-inline">
                        <select lay-verify="required" class="productType" lay-filter="college">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>进货数量</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterNum" oninput = "value=value.replace(/[^\d]/g,'')" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>仓库</label>
                    <div class="layui-input-inline">
                        <select lay-verify="required" class="warehouseName"  lay-filter="warehouse">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--&lt;%&ndash;第二个&ndash;%&gt;--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label padd"><span style="color: red;">*</span>商品名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterName" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>进货单价</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterInprice" id="enterInprice" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>供货商</label>
                    <div class="layui-input-inline">
                        <select lay-verify="required" class="supplierId"  lay-filter="supplier">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--&lt;%&ndash;第三个&ndash;%&gt;--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label" style="margin-left: 5%;"><span style="color: red;">*</span>规格</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterSpecs" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>合计</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterTotal" id="enterTotal"  autocomplete="off" class="layui-input" disabled="disabled" style="color: #000">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">进货日期</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterIndate" lay-verify="url" autocomplete="off" class="layui-input" id="stockDate">
                    </div>
                </div>
            </div>
            <%--&lt;%&ndash;第四个&ndash;%&gt;--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label padd"><span style="color: red;">*</span>商品编码</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterCode" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>进货人</label>
                    <div class="layui-input-inline">
                        <input type="text" id="rescueUser" user_id="" lay-verify="url" autocomplete="off" class="layui-input" disabled>
                    </div>
                    <a href="javascript:;" style="color:#1E9FFF" class="addExecute">添加</a>
                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute">清空</a>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-inline">
                        <input type="text" name="remark" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--&lt;%&ndash;第五个&ndash;%&gt;--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label padd"><span style="color: red;">*</span>已付金额</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterPaid" id="enterPaid" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>欠付金额</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterArrears" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label">库存预警</label>
                    <div class="layui-input-inline">
                        <input type="text" name="enterWarning"  oninput = "value=value.replace(/[^\d]/g,'')" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--&lt;%&ndash;第六个&ndash;%&gt;--%>
            <div class="layui-form-item">
                <div class="layui-inline share">
                    <label class="layui-form-label padd"><span style="color: red;">*</span>计量单位</label>
                    <div class="layui-input-inline">
                        <input type="text" name="meteringUnit" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline share">
                    <label class="layui-form-label"><span style="color: red;">*</span>最低售价</label>
                    <div class="layui-input-inline">
                        <input type="text" name="lowprice"  autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <%--表格--%>
    <div>
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="updata">修改</button>
        <button class="layui-btn layui-btn-sm" lay-event="search"><i class="layui-icon layui-icon-search" style="vertical-align: middle;"></i>查询</button>
        <button class="layui-btn layui-btn-sm" lay-event="searchAll">全部记录</button>
        <div class="dropbox" style="display: inline-block">
            <div class="dropdown">
                <button class="layui-btn layui-btn-sm dropbtn" onclick="selectFn(this)">还供货贷款<i class="licon"></i></button>
                <div class="dropdown-content ">
                    <div>
                        <authority:auto target="UPDATE_AUTH_ROLE_STATE">
                            <a lay-event="inner_menu" style="width:70px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:1px">还供货商款</a>
                        </authority:auto>
                    </div>
                    <div> <authority:auto target="MENU_ROLE_INNER" >
                        <a  lay-event="dell" style="width:114px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:1px">供货商欠款还款统计</a>
                    </authority:auto></div>
                </div>
            </div>
        </div>
    </div>
</script>
<script type="text/javascript">
    layui.use(['form', 'table','laydate','element','layer'], function(){
        var table = layui.table;
        var form = layui.form;
        var layer =layui.layer
        var laydate = layui.laydate
        var productTypeId; //商品大类的id
        var warehouseId  //仓库的id
        var supplierId;  //供货商的id
        var enterId; //获取的是表格行数据的id
        form.render()   //刷新表单
        //日期选择器(日)
        $('input[name="enterPaid"]').val('0')
        $('input[name="enterNum"]').val('0')
        $('input[name="enterInprice"]').val('0.00')
        $('input[name="enterTotal"]').val('0')
        $('input[name="enterArrears"]').val('0')
        $('input[name="lowprice"]').val('0')
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
        laydate.render({
            elem: '#stockDate'
            ,type:'datetime'
            ,trigger: 'click'//呼出事件改成click
            ,format: 'yyyy-MM-dd HH:mm:ss'
        });  //进货日期

        $('#stockDate').val(timestampToTime1())
        //监听进货数量
        $('input[name="enterNum"]').on('keyup',function () {
            var enterNum = $('input[name="enterNum"]').val()
            var enterInprice = $('input[name="enterInprice"]').val()
            var enterTotal = enterNum*enterInprice
            $('input[name="enterTotal"]').val(enterTotal)
            $('input[name="enterArrears"]').val(enterTotal)
        })
        $("#enterInprice").on('blur',function() {
         var aa =  $('#enterTotal').val()+"";
         if(aa.indexOf(".") != '-1'){
             var ente=aa.substring(0,aa.indexOf(".") + 3)
         }else{
             var ente = aa;
         }
            $('#enterTotal').val(ente) //合计
            $('input[name="enterArrears"]').val(ente) //已付金额
        })
        //监听进货单价
        $('input[name="enterInprice"]').on('keyup',function () {
            var enterNum = $('input[name="enterNum"]').val()
            var enterInprice = $('input[name="enterInprice"]').val()
            var enterPaid = $('input[name="enterPaid"]').val()
            var enterTotal =enterNum*enterInprice
            var enterArrears =Math.abs(enterNum*enterInprice-enterPaid)
            $('input[name="enterTotal"]').val(enterTotal)
            $('input[name="enterArrears"]').val(enterArrears)
        })

           //监听已付金额
        $('#enterPaid').on('keyup',function () {
                var enterTotal = $('input[name="enterTotal"]').val() //合计
                var enterPaid = $('#enterPaid').val()
            if(parseInt(enterPaid)>parseInt(enterTotal)){
               $('input[name="enterArrears"]').val('0')
            }else{
                var enterArrears=enterTotal-enterPaid
                $('input[name="enterArrears"]').val(enterArrears)
            }
        })
        $('#enterPaid').on('blur',function(){
           var abx = $('input[name="enterArrears"]').val()+""
            if(abx.indexOf(".") != '-1'){
                var enteas = abx.substring(0,abx.indexOf(".") + 3)
            }else{
                var enteas = abx;
            }
            $('input[name="enterArrears"]').val(enteas)

        })
        //监听合计
        $('#enterTotal').on('keyup',function () {
            var enterTotal = $('input[name="enterTotal"]').val()
            var enterPaid = $('input[name="enterPaid"]').val()
            if(parseInt(enterPaid)>parseInt(enterTotal)){
                $('input[name="enterArrears"]').val('0')
            }else{
                var enterArrears=enterTotal-enterPaid
                $('input[name="enterArrears"]').val(enterArrears)
            }

        })
        //监听进货单价
        $(document).on('ready',function(){
            $("#enterInprice").on('blur',function(){
                var price =  $('input[name="enterInprice"]').val()
                if(!isNaN(price)){
                    var dot = price.indexOf(".");
                    if(dot != -1){
                        var dotCnt = price.substring(dot+1,price.length);
                        if(dotCnt.length >=2){
                            $('input[name="enterInprice"]').val(Math.floor(price*100)/100)

                        }else if(dotCnt.length =1) {
                            $('input[name="enterInprice"]').val($('input[name="enterInprice"]').val()+'0')
                        }
                    }else{
                        $('input[name="enterInprice"]').val($('input[name="enterInprice"]').val()+'.00')
                    }
                }


            });
            $("input").on('blur',function(){
                $(this).removeClass("bor");
            });
        });
        /*主表格的数据*/
        var tableInt=table.render({
            elem: '#test'
            ,url:'/poCommodityEnter/selectProductInfo'
            ,page: true
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'print', 'exports', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,cols: [[
                {field:'productTypeName', title:'商品大类'}
                ,{field:'enterName', title:'商品名称'}
                ,{field:'enterSpecs', title:'商品规格'}
                ,{field:'enterCode', title:'商品编码'}
                ,{field:'enterIndate', title:'进货日期'}
                ,{field:'enterNum', title:'进货数量'}
                ,{field:'enterInprice', title:'进货单价'}
                ,{field:'enterTotal', title:'合计'}
                ,{field:'enterPaid', title:'已付金额'}
                ,{field:'enterArrears', title:'欠款金额'}
                ,{field:'supplierName', title:'供货商'}
                ,{field:'userName', title:'进货人'}
                ,{field:'warehouseName', title:'仓库'}
                ,{field:'documentNo', title:'单据号'}
                ,{field:'remark', title:'备注'}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.obj, //解析数据列表，
                    "count": res.totleNum, //解析数据长度
                };
            }
        });
        /*商品大类下拉框的ajax*/
        $.ajax({
            url:'/productType/selectProductTypeInfo',
            dataType:'json',
            type:'get',
            success:function(res){
                var strs = ''
                for(var i=0;i<res.obj.length;i++){
                    strs += '<option title="' + res.obj[i].productTypeName + '" value="' + res.obj[i].productTypeId + '">' +  res.obj[i].productTypeName + '</option>'
                }
                $('.productType').append(strs)
                form.render('select');
            }
        })
        // 监听的商品大类的下拉框的值
        form.on('select(college)', function (data) {
            productTypeId = $('.productType').val()  //获取下拉框的value值
        });

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
                $('.warehouseName').append(strs)
                form.render('select');
            }
        })
        // 监听的商品大类的下拉框的值
        form.on('select(warehouse)', function (data) {
            warehouseId = $('.warehouseName').val()  //获取下拉框的value值
        });

        /*供货商的下拉ajax*/
        $.ajax({
            url:'/supplier/selectByCount',
            dataType:'json',
            type:'get',
            success:function(res){
                var strs = ''
                for(var i=0;i<res.obj.length;i++){
                    strs += '<option title="' +res.obj[i].supplierName + '" value="' + res.obj[i].supplierId + '">' +  res.obj[i].supplierName + '</option>'
                }
                $('.supplierId').append(strs)
                form.render('select');
            }
        })
        // 监听的供货商的下拉框的值
        form.on('select(supplier)', function (data) {
            supplierId = $('.supplierId').val()  //获取下拉框的value值
        });

        //进货人点击添加的按钮
        $(".addExecute").on("click",function(){
            user_id = "rescueUser";
            $.popWindow("/common/selectUser");
        });

        $('.clearExecute').on('click',function () {
            $("#rescueUser").val("");
            $("#rescueUser").attr('username','');
            $("#rescueUser").attr('dataid','');
            $("#rescueUser").attr('user_id','');
            $("#rescueUser").attr('userprivname','');
        });

        /*新增仓库*/
        $(".addwarehouse").on('click',function () {
            layer.open({
                title: '新建仓库',
                shade: 0.3,
                area: ['600px','470px'],
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
                btn: ['确认', '返回'],
                yes: function () {
                    var data = {
                        warehouseName: $('#warehouseName').val(),
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
                },success:function(){
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

        /*新添供货商页面*/
        $('.addsupplier').on('click',function () {
            layer.open({
                type:1,
                title: '新建供货商',
                shade: 0.3,
                area:['80%','80%'],
                content:'<div style="padding:8px"> ' +
                    '<form class="layui-form" action="" id="addition">\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline" style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>供应商名称</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="supplierName"  autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">邮政编码</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="zipCode" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline" style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>供应商电话</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="phone"  autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">传真号码</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="fax" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">供应商网址</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="website" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>电子邮箱</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="email" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>供应商地址</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="address" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%;display:flex">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">所在地区</label>\n' +
                    '                <div class="layui-input-block" style="width:95px;margin-left:0px">' +
                    '                   <select name="province" id="sheng" lay-filter="sheng" style="width: 125px">\n' +
                    '                        <option>请选择</option>\n' +
                    '                    </select>' +
                    '                   </div>\n' +
                    '           <div class="layui-input-block" style="width:94px;margin-left: 4px;">' +
                    '                   <select name="city"  id="city1" style="width: 125px">\n' +
                    '                        <option>请选择</option>\n' +
                    '                    </select>'+
                    '             </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">开户行</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="registerBank" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">银行账号</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="bankAccount" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">户名</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="accountName" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-inline"  style="width: 50%">\n' +
                    '                <label class="layui-form-label" style="width: 112px;">备注</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="remark" lay-verify="required|number" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form></div>',
                btn: ['保存', '取消'],
                success:function(){
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
                        $('#city1').html(citys);
                        form.render('select')
                    });
                },
                yes:function (index, layero) {
                    var email=$('[name="email"]').val();
                    var bo = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(email);
                    if($('[name="supplierName"]').val() == ''){
                        layer.msg('请输入供应商名称 ！',{icon:2});
                        return '';
                    }else if($('[name="phone"] option:selected').val() == ''){
                        layer.msg('请选择供应商电话！',{icon:2});
                        return '';
                    }else if($('[name="email"] option:selected').val() == ''){
                        layer.msg('请选择电子邮箱！',{icon:2});
                        return '';
                    } else if(bo == false){
                        layer.msg('邮箱格式错误 ！',{icon:2});
                        return '';
                    }else if($('[name="address"] option:selected').val() == ''){
                        layer.msg('请选择供应商地址！',{icon:2});
                        return '';
                    }else{
                        $.ajax({
                            url: '/supplier/insertSupplier',
                            type: 'post',
                            dataType: 'json',
                            data: $('#addition').serialize(),
                            success: function (data) {
                                if (data.flag) {
                                    layer.open({
                                        type: 1
                                        , offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                                        , id: 'layerDemo' + type //防止重复弹出
                                        , content: '<div style="padding: 20px 100px;">' + "保存成功!" + '</div>'
                                        , btn: '确定'
                                        , btnAlign: 'c' //按钮居中
                                        , shade: 0 //不显示遮罩
                                        , yes: function () {
                                            layer.closeAll();
                                            location.reload();
                                        }
                                    });
                                } else {
                                    layer.open({
                                        type: 1
                                        , offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                                        , id: 'layerDemo' + type //防止重复弹出
                                        , content: '<div style="padding: 20px 100px;">' + "保存失败!" + '</div>'
                                        , btn: '确定'
                                        , btnAlign: 'c' //按钮居中
                                        , shade: 0 //不显示遮罩
                                        , yes: function () {
                                            layer.closeAll();
                                            location.reload();

                                        }
                                    });
                                }
                            },
                            error: function (data) {
                                layer.open({
                                    type: 1
                                    , offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                                    , id: 'layerDemo' + type //防止重复弹出
                                    , content: '<div style="padding: 20px 100px;">' + "保存失败!" + '</div>'
                                    , btn: '确定'
                                    , btnAlign: 'c' //按钮居中
                                    , shade: 0 //不显示遮罩
                                    , yes: function () {
                                        layer.closeAll();
                                        location.reload();
                                    }
                                });
                            }
                        })
                    }
                }
            })
        })


        /*商品类别*/
        $('.category').on('click',function (){
            layer.open({
                type: 1,
                title: '新建商品类别',
                area: ['40%', '60%'],
                offset:['20%','30%'],
            content:'<form class="layui-form" action="" id="equipmen" style="margin-left: 10%">\n' +
                    '<div class="layui-block top" style="margin-top: 10px;">\n' +
                    '        <label class="layui-form-label" style="width: 100px">商品类型名称:</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <input type="text" name="productTypeName" style="width: 250px" lay-verify="url" autocomplete="off" class="layui-input">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-block top">\n' +
                    '        <label class="layui-form-label" style="width: 100px">商品类型编号:</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <input type="text" name="productTypeNo" style="width: 250px" oninput = "value=value.replace(/[^\\d]/g,\'\')" lay-verify="url" autocomplete="off" class="layui-input">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-block top">\n' +
                    '        <label class="layui-form-label" style="width: 100px">备注</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <textarea  name="remark" style="height: 100px;width: 250px" lay-verify="url" autocomplete="off" class="layui-input"></textarea>\n' +
                    '        </div>\n' +
                    '    </div>' +
                    '</form>',
                btn: ['确定','取消'],
                yes:function (index, layero) {
                    $.ajax({
                        url:'/productType/insertProductType',
                        type:'post',
                        dataType:'json',
                        data:$('#equipmen').serialize(),
                        success:function (data) {
                            if (data.msg == 'ok') {
                                layer.msg('新建商品类别成功！', {icon: 1});
                                layer.close(index);
                                window.location.reload();
                            }else{
                                layer.msg('新建商品类别失败！', {icon: 1});
                            }
                        }
                    })
                }


            })
        })

        /*监听头部菜单*/
        table.on('toolbar(test)', function(obj) {
            var event = obj.event;
            switch (event) {
                case 'inner_menu':
                    layer.open({
                        type:2,
                        title: '还供货商款',
                        shade: 0.3,
                        area: ['100%', '100%'],
                        content:'/poCommodityEnter/newRepayment',
                        success:function(res){
                            $('.dropdown-content').hide()
                        }
                        // btn: ['保存', '取消'],
                    })
                    break;
                case 'dell':
                    layer.open({
                        type:2,
                        title: '供货商欠款还款统计',
                        shade: 0.3,
                        area: ['100%', '100%'],
                        content:'/poCommodityEnter/arrearsStatistics',
                        // btn: ['保存', '取消'],
                    })
                    break;
                case 'add':    //添加的接口
                    var supplierId=$('select[lay-filter="supplier"]').val(),  //供货商
                        warehouseId=$('select[lay-filter="warehouse"]').val(), //仓库
                        productTypeId=$('select[lay-filter="college"]').val(), //大类
                        enterName = $('input[name="enterName"]').val(),   //商品名称
                        meteringUnit = $('input[name="meteringUnit"]').val(),  //单位
                        enterCode = $('input[name="enterCode"]').val(), //编码
                        enterPaid = $('input[name="enterPaid"]').val(),  //已付金额
                        enterNum = $('input[name="enterNum"]').val(),  //进货数量
                        enterSpecs = $('input[name="enterSpecs"]').val(),  //规格
                        enterInprice = $('input[name="enterInprice"]').val(), //进货单价
                        enterTotal = $('input[name="enterTotal"]').val(),  //合计
                        rescueUser = $('#rescueUser').val(),  //进货人
                        enterArrears = $('input[name="enterArrears"]').val(), //欠款金额
                        lowprice = $('input[name="lowprice"]').val() //最低售价
                    if(supplierId==""){ layer.msg('请填写供货商', {icon: 2}); return false}
                    if(warehouseId==""){ layer.msg('请填写仓库', {icon: 2}); return false}
                    if(productTypeId==""){ layer.msg('请填写商品大类', {icon: 2}); return false}
                    if(enterName==""){ layer.msg('请填写商品名称', {icon: 2}); return false}
                    if(meteringUnit==""){ layer.msg('请填写计量单位', {icon: 2}); return false}
                    if(enterCode==""){ layer.msg('请填写商品编码', {icon: 2}); return false}
                    if(enterPaid==""){ layer.msg('请填写已付金额', {icon: 2}); return false}
                    if(enterNum==""){ layer.msg('请填写进货数量', {icon: 2}); return false}
                    if(enterInprice==""){ layer.msg('请填写进货单价', {icon: 2}); return false}
                    if(enterTotal==""){ layer.msg('请填写合计', {icon: 2}); return false}
                    if(rescueUser==""){ layer.msg('请填写进货人', {icon: 2}); return false}
                    if(enterArrears==""){ layer.msg('请填写欠付金额', {icon: 2}); return false}
                    if(lowprice==""){ layer.msg('请填写最低售价', {icon: 2}); return false}
                    if(enterSpecs==""){ layer.msg('请填写规格', {icon: 2}); return false}


                    $.ajax({
                        url:'/poCommodityEnter/insertProduct',
                        dataType:'json',
                        type:'post',
                        data:$('#ajaxforms').serialize()+'&productType='+ productTypeId+'&warehouseId='+ warehouseId+'&supplierId='+ supplierId+'&enterTotal='+ enterTotal+'&userId='+$('#rescueUser').attr('user_id'),
                        success:function (data) {
                            tableInt.reload()
                        }
                    })
                    $('#ajaxforms input').val('')
                    break;
                case 'searchAll':
                    $.ajax({
                        url:'/poCommodityEnter/selectProductInfo',
                        type: 'get',
                        dataType:'json',
                        success:function(res){
                            tableInt.reload()
                        }
                    })
                    break;
                case 'search':
                    layer.open({
                        type: 1 ,//Page层类型
                        area: ['800px', '85%'],
                        title: '按时间查询',
                        maxmin: true ,//允许全屏最小化
                        content: '<div class="layui-form chaXun"><div class="shiJian" style="width: 350px;margin: 0px auto"><input lay-filter="day" type="radio" name="time" value="" title="按日查询" checked>' +
                            '<input lay-filter="month" type="radio" name="time" value="" title="按月查询" >\n' +
                            '<input lay-filter="year" type="radio" name="time" value="" title="按年查询" >\n' +
                            '</div>' +
                            '<div>' +
                            '<div style="margin: 10px 0px;" id="day" ><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="dayQuery" id="dayQuery" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            // '<div style="display: none;margin: 10px 0px;"  id="month"><span style="margin-left:17%">请选择(必填)</span><input type="text" class="layui-input" id="monthQuery1" style="display: inline-block;width: 150px;margin-left:5%">月<input type="text" class="layui-input" id="monthQuery2" style="display: inline-block;width: 150px;">年</div>' +
                            '<div style="display: none;margin: 10px 0px;"  id="month"><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="monthQuery1" id="monthQuery1" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
                            '<div style="display: none;margin: 10px 0px;"id="year"><span style="margin-left:28%">请选择(必填)</span><input type="text" class="layui-input" name="yearQuery" id="yearQuery" style="display: inline-block;width: 150px;margin-left:5%"></div>' +
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
                            '    <label class="layui-form-label">进货人</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <select name="userName" lay-verify="required">\n' +
                            '      </select>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            '</div>' +
                            '<div style="display: flex;margin-left: 30px;"><div class="layui-form-item" style="margin-bottom:8px">\n' +
                            '    <label class="layui-form-label" style="padding: 9px 0px;width:100px">规格</label>\n' +
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
                            '      <textarea name="shipmentRemark" placeholder="请输入备注" class="layui-textarea"></textarea>\n' +
                            '    </div>\n' +
                            '  </div>' +
                            /* '<div class="layui-form-item isArrears">\n' +
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
                             '<div><p style="text-indent:23px;padding: 0px 32px;color:#666">温馨提示:查询某客户的消费记录，先按时间查询选择“所有时间”，再从“客户”下拉框中选择要查的客户，按“查询”按钮即可，查询该客户一月或一年的消费记录，则将时间改成按月查询或按年查询即可。</p></div>' +*/
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
                                    console.log(data.obj)
                                    var str = '<option value="">请选择</option>';
                                    for (var i = 0; i < data.obj.length; i++) {
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
                            var timeQuery=$('.shiJian .layui-form-radio')
                            var type
                            var enterIndates
                            var isArrears
                            if(timeQuery.eq(0).hasClass("layui-form-radioed")){
                                type=1
                                enterIndates=$('#day input[name="dayQuery"]').val()
                            }else if(timeQuery.eq(1).hasClass("layui-form-radioed")){
                                type=2
                                enterIndates=$('#month input[name="monthQuery1"]').val()
                            }else if(timeQuery.eq(2).hasClass("layui-form-radioed")){
                                type=3
                                enterIndates=$('#year input[name="yearQuery"]').val()
                            }
                            if($('.isArrears [name="isArrears"]').next().hasClass("layui-form-checked")){
                                isArrears=1
                            }else{
                                isArrears=0
                            }
                            var enterId=$('.chaXun [name="enterId"]').val();
                            var customerName=$('.chaXun select[name="customerName"] option:checked').val()
                            var userId=$('.chaXun select[name="userName"] option:checked').val()
                            var warehouseName=$('.chaXun  [name="warehouseName"] option:checked').val()
                            var documentNo=$('.chaXun input[name="documentNo"]').val()
                            var shipmentRemark=$('.chaXun textarea[name="shipmentRemark"]').val()
                            layer.close(index)
                            tableInt.reload({
                                url:'/poCommodityEnter/selectProductInfo',
                                where:{
                                    type:type,
                                    enterIndates:enterIndates,
                                    enterId:enterId,
                                    customerName:customerName,
                                    userId:userId,
                                    warehouseName:warehouseName,
                                    documentNo:documentNo,
                                    shipmentRemark:shipmentRemark,
                                    isArrears:isArrears
                                }
                            })
                        }
                    });
                    break;
                case 'delete':
                    goods(0)
                    break;
                case 'updata':
                    goods(1)
                    $('#ajaxforms input').val('')
                    break;

            }
        })

        //监听行单击事件
        table.on('row(test)', function (obj) {
            var data=obj.data
            var tr=obj.tr
            enterId= data.enterId //获取当前的行数据的id值
            var option=$('#ajaxforms .productType option')  //商品大类回显
            for(var i=0;i<option.length;i++){
                if(option.eq(i).attr('title')==data.productTypeName){
                    option.eq(i).prop('selected','selected')
                }
            }
            var houpise = $('#ajaxforms .warehouseName option')  //仓库数据回显
            for(var i=0;i<houpise.length;i++){
                if(houpise.eq(i).attr('title')==data.warehouseName){
                    houpise.eq(i).prop('selected','selected')
                }
            }

            var supp = $('#ajaxforms .supplierId option')  //供货商回显
            for(var i=0;i<supp.length;i++){
                if(supp.eq(i).attr('title')==data.supplierName){
                    supp.eq(i).prop('selected','selected')
                }
            }

            $('#rescueUser').val(data.userName)
            $("#rescueUser").attr('user_id',data.userId);
            form.val("formTest", obj.data);
            $(this).addClass('bg').siblings().removeClass('bg')
        });

        //删除和修改公用函数
        function goods(type) {
            if(type==0){
                // var  enterId=$('input[name="enterId"]').val()
                layer.confirm('真的删除当前数据吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/poCommodityEnter/deleteProductById?enterId='+enterId,
                        dataType: 'json',
                        success: function (res) {
                            if (res.msg == 'ok') {
                                layer.msg('删除成功！', {icon: 1});
                                tableInt.reload()
                            }
                        }
                    })
                });
            }else if(type==1){
                var supplierId=$('select[lay-filter="supplier"]').val(),
                    warehouseId=$('select[lay-filter="warehouse"]').val(),
                    productTypeId=$('select[lay-filter="college"]').val(),
                    enterName = $('input[name="enterName"]').val(),
                    enterInprice = $('input[name="enterInprice"]').val(),
                    enterCode = $('input[name="enterCode"]').val(),
                    enterPaid = $('input[name="enterPaid"]').val();
                if(productTypeId==""){ layer.msg('请填写商品大类', {icon: 2}); return false}
                if(enterName==""){ layer.msg('请填写商品名称', {icon: 2}); return false}
                if(enterInprice==""){ layer.msg('请填写进货单价', {icon: 2}); return false}
                if(enterCode==""){ layer.msg('请填写商品编码', {icon: 2}); return false}
                if(enterPaid==""){ layer.msg('请填写已付金额', {icon: 2}); return false}
                $.ajax({
                    type: 'post',
                    url: '/poCommodityEnter/updateProduct',
                    dataType: 'json',
                    data:$('#ajaxforms').serialize()+'&productType='+ productTypeId+'&warehouseId='+ warehouseId+'&supplierId='+ supplierId+'&userId='+$('#rescueUser').attr('user_id')+'&enterId='+enterId,
                    success: function (res) {
                        if (res.msg == 'ok') {
                            layer.msg('修改成功！', {icon: 1});
                            tableInt.reload()
                        }
                    }
                })
            }
        }
    })
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
    //将毫秒数转为yyyy-MM-dd格式时间
    function date(t){
        var date=new Date();
        var year=date.getFullYear(); //获取当前年份
        var mon=date.getMonth()+1; //获取当前月份
        var da=date.getDate(); //获取当前日
        var h=date.getHours(); //获取小时
        var m=date.getMinutes(); //获取分钟
        var s=date.getSeconds(); //获取秒
        if (mon < 10) mon = "0" + mon;
        if (da < 10) da = "0" + da;
        if (h < 10) hour = "0" + h;
        if (m < 10) minu = "0" + m;
        if (s < 10) sec = "0" + s;
        // var d=document.getElementById('Date');
        return year+'-'+mon+'-'+da+' '+h+':'+m+':'+s;
    }
    //时间戳转变日期格式 年-月-日 时-分-秒
    function timestampToTime1() {
        var date = new Date();//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
        var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
        return Y+M+D+h+m+s;
    }
</script>
</body>
</html>
