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
    <title>资产审批</title>
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
    .bg{
        background: #f2f2f2;
    }

    nav div{
        float: left !important;
        margin: 15px;
    }
    nav{
        height: 50px;
        border-bottom: 1px solid #cfdbe2;
        background-color: #fafbfc;
        border-radius: 0;
    }
    .time{
        width: 90px;
        margin-left: 0px;
        display: inline;
    }
    .input{
        margin-left: 130px;
    }



</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul id="searchul" class="layui-tab-title" lay-filter="searchul">
                <li class="layui-this" value="6">全部</li>
                <li id="dsh" value="0">待审核</li>
                <li id="ytg" value="1">已通过</li>
                <li id="wtg" value="2">未通过</li>
                <li id="ygh" value="3">已归还</li>
                <li id="ygh" value="5">已验收</li>
                <li id="wgh" value="4">超期未归还</li>
                <%--<li class="query">更多筛选</li>--%>
                <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary add" style="float: right;margin-right: 5px" >新增</button>--%>
            </ul>
        </div>
        <div>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">

            </div>
            <div>
                <table id="demo" lay-filter="test"></table>
            </div>
        </div>
        <script type="text/html" id="barDemo">
            {{# if(d.status ==0){ }}
            <a class="layui-btn layui-btn-xs" lay-event="approval">批准</a>
            <a class="layui-btn layui-btn-xs" lay-event="approvalno">不批准</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>

            {{# } }}
            {{# if(d.status ==3){ }}
            <a class="layui-btn layui-btn-xs" lay-event="norecover">验收</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
            {{# } }}
            {{# if(d.status ==1){ }}
            <%--<a class="layui-btn layui-btn-xs" lay-event="recover">归还</a>--%>
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
            {{# } }}
            {{# if(d.status ==4){ }}
            <%--<a class="layui-btn layui-btn-xs" lay-event="recover">归还</a>--%>
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
            {{# } }}
            {{# if(d.status ==2){ }}
            <a class="layui-btn layui-btn-xs" lay-event="approval">批准</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            {{# } }}
            {{# if(d.status ==5){ }}
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            {{# } }}
        </script>
    </form>

</div>

</div>




<%--<script type="text/html" id="barDemo">--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>--%>
    <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>

<script type="text/javascript">
    layui.use(['table', 'form', 'laydate','element'], function () {
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
        var internalTable = table.render({
            elem: '#demo'
            , url: '/eduFixAssets/getFixAssetsApply?flag=2' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                  {field: 'assetsName',align: 'center', title: '资产名称'}
                , {field: 'assetsId',align: 'center', title: '资产编码'}
                , {field: 'applyType',align: 'center', title: '资产分类'}
                , {field: 'status',align: 'center', title: '当前状态',templet:function(d){
                        if(d.status==0){
                            return '待审核'
                        }else if(d.status==1){
                            return '已通过'
                        }else if(d.status==2){
                            return '未通过'
                        }else if(d.status==3){
                            return '已归还'
                        }else if(d.status==4){
                            return '超期未归还'
                        }else if(d.status==5){
                            return '已验收'
                        }
                    }}
                , {field: 'applyUser',align: 'center', title: '申请人'}
                , {field: 'receiveAt',align: 'center', title: '领用日期'}
                , {field: 'returnAt',align: 'center', title: '归还日期'}
                , {field: 'realReturnAt',align: 'center', title: '实际归还时间'}
                , {title: '操作', align: 'center', toolbar: '#barDemo',width:230}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'object',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });

        $('#searchul').on('click','li',function(data){
            var status = this.value
            $.get('/eduFixAssets/getFixAssetsApply?flag=2', function(res){
                if (res.flag) {
                    internalTable.reload({
                        where: {
                            status: status
                        }
                        ,page: {
                            curr: 1
                        }
                    });
                }
            });
        })

        function edit(data) {
            layer.open({
                type: 1 //Page层类型
                , area: ['700px', '500px']
                , title: '详情'
                , content: '<div class="layui-form">' +
                    '<form id="ajaxforms" action="/customer/addWorkbench"><div><div class="items">审批信息</div><div style="margin-top:10px" >\n' +

                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">申请单号:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="bill" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">审批人:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="approver"  type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">审批时间:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="approvelTime" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">归还审批人:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="returnApprover" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">归还时间:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="returnAt" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +

                    '        </div></div>' +
                    '<div><div class="items">资产信息</div>' +
                    '<div style="margin-top:10px">' +
                    '            <div class="layui-form-item" style="width: 320px;">\n' +
                    '                <label class="layui-form-label">资产名称:</label>\n' +
                    '                <div class="layui-input-block">\n' +
                    '                    <input id="assetsName" type="text" name="customerManager" required lay-verify="required" placeholder=""\n' +
                    '                           autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '   <div class="layui-form-item" style="width: 320px;">\n' +
                    ' <input type="radio" name="sex" checked="checked"  id="male" title="男" value="1"/>\n' +
                    '  <input type="radio" name="sex"  id="woman" title="女" value="2"/></div>' +
                    '</div>' +
                    '<div ><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">资产编码:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="assetsId" type="text" name="department" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;display: none">\n' +
                    '    <label class="layui-form-label">管理员:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="keeper" type="text" name="mobile" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    '<div > <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">领用日期:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="receiveAt" type="text" name="email" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">归还日期:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="realReturnAt" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">申请人:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="applyUser" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div> <div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">所属部门:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="deptName" type="text" name="wechat" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +

                    '  </div><div class="layui-form-item" style="width: 320px;">\n' +
                    '    <label class="layui-form-label">备注:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input id="remark" type="text"  required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: 0">\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    '</div>' +
                    '</form></div>'
                ,btn:['返回']
                , success: function (res) {
                    var result = data;
                    $("#bill").val(result.bill);
                    $("#approver").val(result.approver);
                    $("#approvelTime").val(result.approvelTime);//审批时间
                    $("#returnApprover").val(result.returnApprover);
                    $("#realReturnAt").val(result.returnAt);
                    $("#assetsName").val(result.assetsName);
                    $("#assetsId").val(result.assetsId);
                    $("#keeper").val(result.keeper);
                    $("#receiveAt").val(result.receiveAt);
                    $("#returnAt").val(result.returnAt);
                    $("#applyUser").val(result.applyUser);
                    $("#deptName").val(result.deptName);
                    $("#remark").val(result.remark);

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
            }
            if(layEvent === 'approval'){ //批准
                layer.confirm('确定批准吗？', function(index){
                    layer.close(index);
                    $.post('/eduFixAssets/approveFixAssetsApply', {applyId: data.applyId,status:1}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                        }
                    })
                });
            }
            if(layEvent === 'approvalno'){ //不批准
                layer.confirm('确定不批准吗？', function(index){
                    layer.close(index);
                    $.post('/eduFixAssets/approveFixAssetsApply', {applyId: data.applyId,status:2}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                        }
                    })
                });
            }
            if(layEvent === 'recover'){ //归还
                layer.confirm('确定归还吗？', function(index){
                    layer.close(index);
                    $.post('/eduFixAssets/returnFixAssetsApply', {applyId: data.applyId,status:3}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                        }
                    })
                });
            }
            if(layEvent === 'norecover'){ //验收
                layer.confirm('确定验收吗？', function(index){
                    layer.close(index);
                    $.post('/eduFixAssets/receiveFixAssetsApply', {applyId: data.applyId,status:5}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                        }
                    })
                });
            }
            if(layEvent === 'del'){ //删除
                layer.confirm('确定删除吗？', function(index){
                    obj.del();
                    layer.close(index);
                    $.post('/eduFixAssets/delFixAssetsApply', {applyId: data.applyId}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                        }
                    })
                });
            }
        });



    });




</script>
</body>
</html>

