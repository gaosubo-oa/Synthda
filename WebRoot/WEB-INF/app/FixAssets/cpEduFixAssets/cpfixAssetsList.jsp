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
    <title>资产清单</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
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

    .bg {
        background: #f2f2f2;
    }

    nav div {
        float: left !important;
        margin: 15px;
    }

    nav {
        height: 50px;
        border-bottom: 1px solid #cfdbe2;
        background-color: #fafbfc;
        border-radius: 0;
    }

    .time {
        width: 90px;
        margin-left: 0px;
        display: inline;
    }

    .input {
        margin-left: 130px;
    }


</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul id="searchul" class="layui-tab-title" lay-filter="searchul">
                <li class="layui-this" value="6">全部</li>
                <li id="shenhe" value="0">在库资产</li>
                <li id="shenpi" value="3">已退库资产</li>
                <li id="tongguo" value="4">到期未退库资产</li>
            </ul>
            <%--<div class="layui-tab-content" style="height: 100px;display: none">--%>
            <%--<div class="layui-tab-item layui-show" style="display: none">内容1</div>--%>
            <%--<div class="layui-tab-item" style="display: none">内容2</div>--%>
            <%--<div class="layui-tab-item" style="display: none">内容3</div>--%>
            <%--<div class="layui-tab-item" style="display: none">内容4</div>--%>
            <%--<div class="layui-tab-item" style="display: none">内容5</div>--%>
            <%--</div>--%>
        </div>
        <div>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">

            </div>
            <div>
                <table id="demo" lay-filter="test"></table>
            </div>
        </div>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
        </script>
    </form>

    <%--添加内容--%>
</div>
</div>
<%--表格--%>
<%--<script type="text/html" id="barDemo">--%>
<%--<a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>--%>
<%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>
<script type="text/javascript">
    layui.use(['table', 'form', 'laydate', 'element'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var element = layui.element
        //执行一个laydate实例
        laydate.render({
            elem: '#outTime' //指定元素
        });
        laydate.render({
            elem: '#test1'
        });

        //第一个实例
        var tableIns = table.render({
            elem: '#demo'
            , url: '/eduFixAssets/getFixAssetsApply?flag=1' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo'
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                {field: 'assetsName', align: 'center', title: '资产名称'}
                , {field: 'assetsId', align: 'center', title: '资产编码'}
                , {
                    field: 'status', align: 'center', title: '状态', templet: function (d) {
                        if (d.status == 0) {
                            return '待审核'
                        } else if (d.status == 1) {
                            return '已通过'
                        } else if (d.status == 2) {
                            return '未通过'
                        } else if (d.status == 3) {
                            return '已归还'
                        } else if (d.status == 4) {
                            return '超期未归还'
                        } else if (d.status == 5) {
                            return '已验收'
                        }
                    }
                }
                , {field: 'applyType', align: 'center', title: '所属分类'}
                , {field: 'remainingMonths', align: 'center', title: '剩余使用时长(月)'}
                , {field: 'returnAt', align: 'center', title: '到期时间'}
                , {title: '详情', align: 'center', toolbar: '#barDemo'}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'object',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });


        $('#searchul').on('click', 'li', function (data) {
            var status = this.value
            $.get('/eduFixAssets/getFixAssetsApply?flag=1', function (res) {
                if (res.flag) {
                    tableIns.reload({
                        where: {
                            status: status
                        }
                        , page: {
                            curr: 1
                        }
                    });
                }
            });
        })

        //详情
        function edit(data) {
            layer.open({
                type: 1 //Page层类型
                , area: ['650px', '500px']
                , title: '详情'
                , content: '<div class="layui-form">' +
                    '<form id="ajaxforms" action="/customer/addWorkbench"><div><div style="margin-top:10px" >\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">登记单号:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="bill" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">资产名称:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="assetsName" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">资产分类:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="applyType"  type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">资产编码:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="assetsId" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">使用时长(月):</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="useMonths" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">生产日期:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="returnAt" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div></div>' +
                    '<div>' +
                    '<div style="margin-top:10px">' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">产品价格:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="cptlVal" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '<div ><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">预计净残值:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="assetsIds" type="text" name="department" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> \n' +
                    ' </div>' +
                    '<div > <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">管理员:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="keeper" type="text"  required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  </div>\n' +
                    ' <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">使用部门:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="deptName" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> \n' +
                    ' <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">使用人员:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="applyUser" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">登记操作员:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="approver" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">登记时间:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="approvelTime" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">备注:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="remark" type="text" name="qq" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '</div>' +
                    '</div>' +
                    '</form></div>'
                , btn: ['返回']
                , success: function (res) {
                    var result = data;
                    var results = data.eduFixAssets
                    $("#bill").val(result.bill);
                    if (result.assetsName) {
                        $("#assetsName").val(result.assetsName);
                    }else {
                        $("#assetsName").val("----------");
                    }
                    if (result.applyType) {

                        $("#applyType").val(result.applyType);
                    }else {
                        $("#applyType").val("------------");
                    }
                    if (result.assetsId) {

                        $("#assetsId").val(result.assetsId);
                    }else {
                        $("#assetsId").val("------------");

                    }
                    if (result.useMonths) {

                        $("#useMonths").val(result.useMonths);
                    }else {
                        $("#useMonths").val("------------");
                    }
                    if (result.realReturnAt) {

                        $("#realReturnAt").val(result.realReturnAt);
                    }else {
                        $("#realReturnAt").val("-----------");
                    }
                    if (result.cptlVal) {
                        $("#cptlVal").val(result.cptlVal);
                    }else {
                        $("#cptlVal").val("-------------");
                    }
                    if (result.cptlBalVal) {
                        $("#assetsIds").val(result.cptlBalVal);
                    }else {
                        $("#assetsIds").val("-------------");
                    }
                    if (result.approver) {
                        $("#keeper").val(result.approver);
                    }else {
                        $("#keeper").val("-----------");
                    }
                    if (result.returnAt) {
                        $("#returnAt").val(result.returnAt);
                    }else {
                        $("#returnAt").val("-------------");
                    }
                    if (result.applyUser) {
                        $("#applyUser").val(result.applyUser);
                    }else {
                        $("#applyUser").val("--------------");
                    }
                    if (result.deptName) {
                        $("#deptName").val(result.deptName);
                    }else {
                        $("#deptName").val("-------------");
                    }
                    if (result.approver) {
                        $("#approver").val(result.approver);
                    }else {
                        $("#approver").val("-------------");
                    }
                    if (results){
                        $("#approvelTime").val(results.createrTime);
                        $("#remark").val(results.remark);
                    }else {
                        $("#approvelTime").val("-------------");
                        $("#remark").val("------------");
                    }




                    // $("#receiveAt").val(result.receiveAt);


                }
                , yes: function (index) {
                    layer.close(index)
                }
            });
        }

        //监听工具条
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            console.log(data)
            if (layEvent === 'edit') { //详情
                //do something
                edit(data);
                //同步更新缓存对应的值
                /*    obj.update({
                        username: '123'
                        , title: 'xxx'
                    });*/
            } else if (layEvent === 'LAYTABLE_TIPS') {
                layer.alert('Hi，头部工具栏扩展的右侧图标。');
            }
        });

        //新增
    });

</script>
</body>
</html>

