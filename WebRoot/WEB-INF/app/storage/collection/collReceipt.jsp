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
        <img src="../img/shou.png" alt="" style="margin: 0 5px 0 20px;"> <span style="font-size: 22px;display: inline-block;vertical-align: middle;">收款单</span>
    </div>
    <hr class="layui-bg-blue">
    <form class="layui-form" action="" style="margin-top: 20px;">
        <div>
            <div class="layui-inline">
                <label class="layui-form-label" >按年查询</label>
                <div class="layui-input-inline" style="width: 170px;">
                    <input type="text" name="date" id="date" lay-verify="date" placeholder="按年查询" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" style="margin-left: 20px">
                <label class="layui-form-label">按月查询</label>
                <div class="layui-input-inline" style="width: 170px;">
                    <input type="text" name="date" id="datemonth" lay-verify="date" placeholder="按年查询" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline"  style="margin-left: 20px">
                <label class="layui-form-label" style="width:30px" >仓库</label>
                <div class="layui-input-inline" style="width:170px">
                    <select id="warehouseIds" lay-verify="required" class="warehouseName"  lay-filter="warehouse">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline"  style="margin-left: 20px">
                <label class="layui-form-label" style="width: 58px;">活动类别</label>
                <div class="layui-input-inline" style="width: 170px;">
                    <select name="modules" lay-verify="required" lay-search="" id="activityType">
                        <option value="">请选择</option>
                        <option value="经营收入">经营收入</option>
                        <option value="日常收入">日常收入</option>
                        <option value="银行存入">银行存入</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn" style="margin-left: 20px;" id="querys">查询</button>
            <button type="button" class="layui-btn adds">新建</button>
        </div>
        <div>
                <div class="layui-inline" style="margin-top: 10px;">
                    <label class="layui-form-label">往来单位</label>
                    <div class="layui-input-inline" style="display: flex; cursor: pointer;">
                        <%--<input type="text" name="customerName" lay-verify="url" autocomplete="off" class="layui-input">--%>
                        <div><input type="text" name="customerName" id="customerName"  readonly="readonly" class="layui-input" style="width: 170px;"/></div>
                        <div style="margin-top: 10px;margin-left: 23px;"> <a class="seled" style="color:#1E9FFF">选择</a>&nbsp;&nbsp;
                            <a id="dels" style="color:#1E9FFF;margin-left: -5px">清空</a>
                        </div>
                        <input type="hidden" id="customerIds" name="customerIds"/>
                    </div>
                </div>
            <div class="layui-inline" style="margin-top: 10px;">
                <label class="layui-form-label" style="margin-left: 25px">经手人员</label>
                <div class="layui-input-inline" style="width: 170px">
                    <input type="text" id="rescueUser" user_id="" lay-verify="url" autocomplete="off" class="layui-input clear">
                </div>
                <div style="float:right;margin: 0px -56px 0px 10px;width: 70px;height: 35px;line-height: 37px">
                    <a href="javascript:;" style="color:#1E9FFF" class="addExecute">添加</a>
                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute">清空</a>
                </div>
            </div>
        </div>
    </form>
    <div>
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
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
            <div class="layui-input-inline" style="width:170px">
                <select lay-verify="required" class="warers" id="wares"  lay-filter="warehouse">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <button type="button" class="layui-btn aa" style="margin-left: 20px;">查询</button>
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
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use(['form', 'layedit', 'laydate','table'], function() {
        var form = layui.form
        var layer = layui.layer
        var layedit = layui.layedit
        var table = layui.table
        var laydate = layui.laydate
        laydate.render({
            elem: '#date',
            type:'year'
        });
        laydate.render({
            elem: '#datemonth',
            type:'month'
        });
        laydate.render({
            elem: '#date1',
            type:'year'
            ,trigger: 'click'//呼出事件改成click
        });
        laydate.render({
            elem: '#datemonth1',
            type:'month'
            ,trigger: 'click'//呼出事件改成click
        });

        $('.seled').on('click',function () {
            window.open("../invWarehouse/addCustomerIds?");
        })

        $('#dels').on('click',function () {
            // $('#customerName').val("")
            // $('#customerIds').val("")
            $('#customerName').removeAttr("value")
            $('#customerIds').removeAttr("value")
        })
        form.render()
        //进货人点击添加的按钮
        $(".addExecute").on("click",function(){
            user_id = "rescueUser";
            $.popWindow("/common/selectUser?0");
        });

        $('.clearExecute').on('click',function () {
            $("#rescueUser").val("");
            $("#rescueUser").attr('username','');
            $("#rescueUser").attr('dataid','');
            $("#rescueUser").attr('user_id','');
            $("#rescueUser").attr('userprivname','');
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
            ,url:'/cusReceipt/selectCusRecepit'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
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
            ,title: '新增'
            ,cols: [[
                {field:'activity', title:'活动名称'}
                ,{field:'activityType', title:'活动类别'}
                ,{field:'customerName', title:'往来单位'}
                ,{field:'userName', title:'经手人'}
                ,{field:'receiptPrice', title:'收款金额'}
                ,{field:'activityTime', title:'活动时间'}
                ,{field:'remark', title:'备注'}
                ,{fixed: '', title:'操作', toolbar: '#barDemo'}
            ]]
            ,page: true,
             limit:5,
            success:function (res) {
                layer.closeAll();
            }
        });
        $('.adds').on('click',function () {
            create(0,'')
        })
        function create(type,receiptId){
            if(type=='0'){
                var title = '新建'
            }else{
                var title = '编辑'
            }
            layer.open({
                type: 1,
                title: title,
                btn:['确定','取消'],
                shade: 0.5,
                area: ['35%', '85%'],
                content:' <form class="layui-form" id="ajaxforms" lay-filter="formsTest" action="">\n' +
                    '        <div class="layui-form-item" style="margin-top: 10px">\n' +
                    '            <div class="layui-block">\n' +
                    '                <label class="layui-form-label"><span style="color:red;width: 63px;margin-left: -3px;">*</span>活动名称</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="activity" lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item" style="margin-top: 10px">\n' +
                    '        <div class="layui-inline">\n' +
                    '                <label class="layui-form-label" style="width: 70px;margin-left: -8px;margin-right: -2px;"><span style="color:red;width: 63px;margin-left: -3px;">*</span>活动类别</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <select name="activityType" lay-verify="required" lay-search="">\n' +
                    '                        <option value="经营收入">经营收入</option>\n' +
                    '                        <option value="日常收入">日常收入</option>\n' +
                    '                        <option value="银行存入">银行存入</option>\n' +
                    '                    </select>\n' +
                    '                </div>\n' +
                    '            </div>'+
                    '</div>'+
                    '        <div class="layui-form-item">\n' +
                    '            <div class="layui-block">\n' +
                    '                <label class="layui-form-label"><span style="color: red;width: 63px;margin-left: -3px;">*</span>活动时间</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="activityTime" id="dateday" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label"><span style="color: red;width: 63px;margin-left: -3px;">*</span>往来单位</label>\n' +
                    '                <div class="layui-input-inline" style="display: flex;width: 300px;">\n' +
                    '                    <div> <input type="text"  id="customerNo" name="customerNo" readonly="readonly" class="layui-input contacts" style="width: 190px;"/></div>\n' +
                    '                    <div style="margin-top: 10px;margin-left: 10px;"><a href="javascript:;" target="_blank" style="color: #1E9FFF;" id="selectd">选择</a>&nbsp;&nbsp; <a id="del_1" style="color: red;">清空</a></div>\n' +
                    '                    <input type="hidden" id="customerId" name="customerId"/>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label"><span style="color: red;width: 63px;margin-left: -3px;">*</span>经手人员</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" id="rescue" user_id="" lay-verify="url" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '                <div style="float:right;margin: 0px -56px 0px 1px;width: 70px;height: 35px;line-height: 37px">\n' +
                    '                    <a href="javascript:;" style="color:#1E9FFF" class="Execute">选择</a>\n' +
                    '                    <a href="javascript:;" style="color:red;margin-left: 7px;" class="delExecute">清空</a>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '         <div class="layui-inline" style="margin-bottom:15px;"> \n' +
                    '                <label class="layui-form-label"><span style="color: red;width: 63px;margin-left: -3px;">*</span>仓库</label>\n' +
                    '                <div class="layui-input-inline" style="width:171px">\n' +
                    '                    <select lay-verify="required" class="waresss"  lay-filter="warhose">\n' +
                    '                        <option value="">请选择</option>\n' +
                    '                    </select>\n' +
                    '                </div>\n' +
                    '            </div>'+
                    '        <div class="layui-form-item">\n' +
                    '            <div class="layui-block">\n' +
                    '                <label class="layui-form-label"><span style="color: red;width: 63px;margin-left: -3px;">*</span>金额</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input type="text" name="receiptPrice" lay-verify="required|phone"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" autocomplete="off" class="layui-input">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div class="layui-form-item">\n' +
                    '            <div class="layui-block">\n' +
                    '                <label class="layui-form-label">备注</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <textarea placeholder="请输入内容" name="remark" class="layui-textarea" style="width: 300px;"></textarea>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </form>',
                success:function(res){
                    form.render()
                    laydate.render({
                        elem: '#dateday'
                        ,type:'datetime'
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                    });
                    $('#selectd').on('click',function () {
                        window.open('/invWarehouse/addCustomerIdsd?')
                    })
                    //进货人点击添加的按钮
                    $(".Execute").on("click",function(){
                        user_id = "rescue";
                        $.popWindow("/common/selectUser?0");
                    });
                    //来往单位清空
                    $('#del_1').on('click',function () {
                        $('#customerNo').removeAttr("value")
                        $('#customerId').removeAttr("value")
                    })
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
                            $('.waresss').append(strs)
                            form.render('select');
                        }
                    })

                    $('.delExecute').on('click',function () {
                        $("#rescue").val("");
                        $("#rescue").attr('username','');
                        $("#rescue").attr('dataid','');
                        $("#rescue").attr('user_id','');
                        $("#rescue").attr('userprivname','');
                    });

                    //编辑回显
                    if(type==1){
                        $('#selectd').on('click',function () {
                            $('#selectd').attr('href','/invWarehouse/addCustomerIdsd?')
                        })
                        //来往单位清空
                        $('#del_1').on('click',function () {
                            $('#customerNo').val("")
                            $('#customerId').removeAttr("value")
                        })
                        $.ajax({
                            url:'/cusReceipt/selectOneCusRecepit',
                            type: 'get',
                            dataType: 'json',
                            data:{receiptId:receiptId},
                            success:function (res) {
                                // $(".contacts").attr('value',res.object.customerNo);
                                $('.contacts').val(res.object.customerNo)
                                $('#rescue').val(res.object.userName)
                                $("#rescue").attr('user_id',res.object.userId);
                                var houpise = $('#ajaxforms .waresss option')  //仓库数据回显
                                for(var i=0;i<houpise.length;i++){
                                    if(houpise.eq(i).val()==res.object.wareHouseId){
                                        houpise.eq(i).prop('selected','selected')
                                    }
                                }
                                form.val("formsTest", res.object);
                            }
                        })
                    }
                },
                yes:function(index){
                    if($('input[name="activity"]').val()==""){
                        layer.msg('请填写活动名称', {icon: 2}); return false
                    }
                    if($('input[name="activityType"]').val()==""){
                        layer.msg('请填写活动类别', {icon: 2}); return false
                    }
                    if($('input[name="activityTime"]').val()==""){
                        layer.msg('请填写活动时间', {icon: 2}); return false
                    }
                    if($('#customerNo').val()==""){
                        layer.msg('请填写往来单位', {icon: 2}); return false
                    }
                    if($('#rescue').val()==""){
                        layer.msg('请填写经手人员', {icon: 2}); return false
                    }
                    if($('select[lay-filter="warhose"]').val() == ""){
                        layer.msg('请填写仓库', {icon: 2}); return false
                    }
                    if($('input[name="receiptPrice"]').val()==""){
                        layer.msg('请填写金额', {icon: 2}); return false
                    }
                    var warehouseId=$('select[lay-filter="warhose"]').val() //仓库
                    var data = {
                        activity : $('input[name="activity"]').val(),
                        activityType : $('select[name="activityType"]').val(),
                        activityTime : $('input[name="activityTime"]').val(),
                        customerId : $('#customerId').val(),
                        userId : $('#rescue').attr('user_id').split(',')[0],
                        receiptPrice : $('input[name="receiptPrice"]').val(),
                        remark : $('[name="remark"]').val(),
                    }
                    if(type == 0){
                        var url = '/cusReceipt/insertCusRecepit'
                        data.wareHouseId = warehouseId;
                    }else{
                        var url = '/cusReceipt/updateCusRecepit'
                        data.receiptId = receiptId;
                        data.wareHouseId = warehouseId;
                    }
                    $.ajax({
                        url:url,
                        data:data,
                        dataType:'json',
                        type:'post',
                        success:function (res) {
                            layer.msg('新增成功')
                            tableInt.reload()
                            layer.closeAll();
                        }
                    })
                }
            })
        }
        $("#querys").on("click",function(){
            var activityType = $("#activityType").val()
            var customerName = $("#customerIds").val()
            var userId =$('#rescueUser').attr('user_id').split(',')[0]
            var warehouseIds=$('#warehouseIds').val()
            var year = $("#date").val()
            var month = $("#datemonth").val()
            tableInt.reload({
                url:'/cusReceipt/selectCusRecepit',
                where: {
                    activityType: activityType,
                    customerId:customerName,
                    userId:userId,
                    wareHouseId:warehouseIds,
                    year:year,
                    month:month
                }
                ,page: {
                    curr: 1
                }
            })
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
           var receiptId=data.receiptId
            if(obj.event === 'del'){
                layer.confirm('真的删除当前数据吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/cusReceipt/deleteCusRecepit?receiptId='+receiptId,
                        dataType: 'json',
                        success: function (res) {
                            if (res.msg == 'ok') {
                                layer.msg('删除成功！', {icon: 1});
                                tableInt.reload()
                                layer.closeAll();
                            }
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                create(1,receiptId)
            }
        });
        var tableInts = table.render({
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
                ,{field:'saleShipPrice2', title:'销售出货'}
                ,{field:'realPrice3', title:'商品利润'}
                ,{field:'jingyinglirun', title:'经营利润'}
                ,{field:'totalEnterPrice', title:' 累积收入'}
            ]]
        });
        $('.aa').on('click',function () {
            tableInts.reload({
                url:'/salesShipment/shipOtherCount',
                where:{
                    year:$('#date1').val(),
                    month:$('#datemonth1').val(),
                    warehouseId:$('.warers').val(),
                }
            })
        })

    })

</script>
