<%--
  Created by IntelliJ IDEA.
  User: Machenike
  Date: 2020/6/10
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <title>用户映射</title>
    <style type="text/css">
        html {
            overflow-y: scroll;
        }

        :root {
            overflow-y: auto;
            overflow-x: hidden;
        }

        :root body {
            position: absolute;
        }

        body {
            width: 100vw;
            overflow: hidden;
        }
        .head{
            width: 100%;
            height: 25px;
            padding: 15px;
            padding-top: 17px;
        }
        .head h1{
            font-size: 20px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .head div{
            width: 200px;
            height: 35px;
            float: left;
            padding: 40px 20px 5px 70px;
            border-right:1px solid #ccc;
        }
        #tab{
            width: 75%;
            margin: 30px auto;
        }
        .a{
            width: 200px !important;
            height: 35px;
            padding-left: 30px;
        }
        .a3{
            width: 200px !important;
            height: 35px;
            padding-left: 60px;
        }
        .a1{
            width: 200px !important;
            height: 35px;
            padding-left: 60px;
        }
        .d span{
            padding-right:10px;
        }
        .f{
            padding-right: 15px;
        }
        a{
            text-decoration: none;
            color: #2F8AE3;
        }
        .barcon{
            position: absolute;
            right: 5%;
            bottom: 5%;
        }
        /*新建弹窗*/
        .modal {
            display: none; /* 默认隐藏 */
            position: fixed; /* 固定定位 */
            z-index: 1; /* 设置在顶层 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        /*编辑弹窗*/
        .modal1 {
            display: none; /* 默认隐藏 */
            position: fixed; /* 固定定位 */
            z-index: 1; /* 设置在顶层 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        /* 弹窗内容 */
        .modal-content {
            background-color: #fefefe;
            margin: 8% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 60%;
        }
        .modal-content p{
            padding: 20px;
            font-size: 18px;
        }
        /* 新建关闭按钮 */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        /* 编辑关闭按钮 */
        .close1 {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close1:hover,
        .close1:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="head">
    <h1 style="color:#494d59 ">用户映射</h1>
</div>

<div style="height: 25px;padding-left: 80px;position: absolute;top: 8px;right: 1%">
    <button type="button" class="layui-btn add layui-btn-sm btnR" lay-event="add" id="add">
        <i class="layui-icon">&#xe608;</i>
        新建
    </button>
    <button type="button" class="layui-btn add layui-btn-sm btnR" lay-event="add" id="add2">
        <i class="layui-icon">&#xe65c;</i>
        返回
    </button>
</div>
<div style="margin-top: 8px">
    <table id="demo" lay-filter="test"></table>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use(['table', 'form', 'laydate','element','layer'], function () {
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var element = layui.element;
        var layer = layui.layer;
        console.log(window.location.href)
        var internalTable = table.render({
            elem: '#demo'
            , url: '/connect/selectAllAppUserConnect' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            , cols: [[ //表头
                // , {field: 'auid',align: 'center', title: '应用ID'}
                , {field: 'appName',align: 'center', title: '应用名称'}
                , {field: 'appUser',align: 'center', title: '应用用户名'}
                , {field: 'userId',align: 'center', title: 'OA用户名'}
                ,{field: 'userName',align: 'center', title: 'OA用户姓名'}
                , {title: '操作', align: 'center', toolbar: '#barDemo'}
            ]],
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
        });
        internalTable.reload();
        //删除，编辑，修改
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if (layEvent === 'edit') { //编辑
                layer.open({
                    type: 1 //Page层类型
                    , area: ['100%','100%']
                    , title: '编辑'
                    // ,msg('',{time:100000})
                    , content: '<div class="layui-form" id="ids">' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">应用ID：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="aid"  disabled autocomplete="off" class="layui-input" placeholder="字母组合，例如 XXX_ERP" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">应用用户名：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="appUser"  autocomplete="off" class="layui-input" placeholder="应用用户名" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">OA用户名：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="userId"  autocomplete="off" class="layui-input" placeholder="OA用户名" value="">\n' +
                        '                    <a href="javascript:;" style="color:#1E9FFF;margin-top:10px;" class="addExecute3">添加</a>\n' +
                        '                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute9">清空</a>' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +

                        '   <div class="layui-input-block" style="margin-left:37px">\n' +
                        '  </div>' +
                        '</div>'
                    , btn: ['提交', '返回']
                    , success: function () {
                        // var test=window.location.href
                        // var code=test.split("?aid=")[1];
                        // console.log(code)
                        // $('#aid').val(code)
                        $(".addExecute3").on("click",function(){
                            user_id = "userId";
                            $.popWindow("/common/selectUser");
                        });
                        $('.clearExecute9').click(function () {
                            console.log($("#userId").val(""))
                            $("#userId").val("");
                            $("#userId").attr('username','');
                            $("#userId").attr('dataid','');
                            $("#userId").attr('user_id','');
                            $("#userId").attr('userprivname',data.userId);
                        });
                         $("#aid      ").val(data.auid); //应用id
                        $("#appUser    ").val(data.appUser); //应用用户名
                        $("#userId").val(data.userName);    //OA用户名
                        $('#userId').attr('user_id',data.userId) //admin

                    }
                    ,yes: function (index) {
                        var aid      =$("#aid      ").val(); //应用id    这个有问题
                        var appUser    =$("#appUser    ").val(); //应用用户名
                        var userId= $("#userId").val();    //OA用户名
                        var userId1  =$('#userId').attr('user_id')  //admin
                        var a= userId1.replace(/[\s|\~|`|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g,"");//正则表达式去逗号

                        console.log(aid,appUser,userId1,a)
                        if(aid!==''&&appUser!=''&&userId!==''){
                            $.ajax({
                                url:'/connect/updateAllAppUserConnect',
                                dataType:'json',
                                type:'post',
                                data:{
                                    auid:aid ,
                                    appUser:appUser ,
                                    userId :a
                                },
                                success:function(obj){
                                    console.log(obj)
                                    if (obj.flag) {
                                        $.layerMsg({content: '新增成功！', icon: 1}, function () {

                                        })
                                        internalTable.reload();
                                        layer.close(index);
                                    }else{
                                        alert(obj.msg);
                                    }

                                }
                            })
                        }else{
                            layui.use('layer',function(){
                                var layer = layui.layer;
                                layer.open({
                                    title:'提示信息',
                                    content:'带*的选项不能为空'
                                })
                            })
                        }
                    }
                })

            }
            if(layEvent === 'del'){ //删除
                layer.confirm('确定删除吗？', function(index){
                    obj.del();
                    layer.close(index);

                    $.post('/connect/deleteAllAppUserConnect', {auid: data.auid}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                            // layer.close(index);
                        }
                    })
                });
            }
        });
        //新建
        $('#add').click(function () {
            layer.open({
                type: 1 //Page层类型
                , area: ['100%','100%']
                , title: '新建'
                // ,msg('',{time:100000})
                , content: '<div class="layui-form" id="ids">' +
                    '        <div style="display: flex;margin-top:15px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">应用ID：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="aid" disabled  autocomplete="off" class="layui-input" placeholder="字母组合，例如 XXX_ERP" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">应用用户名：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="appUser"  autocomplete="off" class="layui-input" placeholder="应用用户名" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">OA用户名：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="userId"  autocomplete="off" class="layui-input" placeholder="OA用户名" value="">\n' +
                    '                    <a href="javascript:;" style="color:#1E9FFF;margin-top:10px;" class="addExecute3">添加</a>\n' +
                    '                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute9">清空</a>' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +

                    '   <div class="layui-input-block" style="margin-left:37px">\n' +
                    '  </div>' +
                    '</div>'
                , btn: ['提交', '返回']
                , success: function () {
                    // layer.alert(router.search.aid);
                    //获取id
                    var test=window.location.href
                    var code=test.split("?aid=")[1];
                    console.log(code)
                    $('#aid').val(code)
                    $(".addExecute3").on("click",function(){
                        user_id = "userId";
                        $.popWindow("/common/selectUser");
                    });
                    $('.clearExecute9').click(function () {
                        console.log($("#userId").val(""))
                        $("#userId").val("");
                        $("#userId").attr('username','');
                        $("#userId").attr('dataid','');
                        $("#userId").attr('user_id','');
                        $("#userId").attr('userprivname','');
                    });
                }
                ,yes: function (index) {
                    var aid      =$("#aid      ").val(); //应用id
                    var appUser    =$("#appUser    ").val(); //应用用户名
                    var userId= $("#userId").val();    //OA用户名
                    var userId1  =$('#userId').attr('user_id')  //admin
                    var a= userId1.replace(/[\s|\~|`|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g,"");//正则表达式去逗号

                    console.log(aid,appUser,userId1,a)
                    if(aid!==''&&appUser!=''&&userId!==''){
                        $.ajax({
                            url:'/connect/insertAllAppUserConnect',
                            dataType:'json',
                            type:'post',
                            data:{
                                aid:aid ,
                                appUser:appUser ,
                                userId :a
                            },
                            success:function(obj){
                                console.log(obj)
                                if (obj.flag) {
                                    $.layerMsg({content: '新增成功！', icon: 1}, function () {

                                    })
                                    internalTable.reload();
                                    layer.close(index);
                                }else{
                                    alert(obj.msg);
                                }

                            }
                        })
                    }else{
                        layui.use('layer',function(){
                            var layer = layui.layer;
                            layer.open({
                                title:'提示信息',
                                content:'带*的选项不能为空'
                            })
                        })
                    }
                }
            })
        });
        $('#add2').click(function(){
            window.location.href='/connect/selectConnect'
        })

    });
</script>
</body>
</html>


