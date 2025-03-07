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
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <title>第三方应用</title>
    <style type="text/css">

    </style>
</head>
<body>
<div class="head">
    <ul class="index_head">
        <li data_id=""  url="/village/selectVillage2">
                <span class="one headli1_1">
                 第三方应用设置
               </span>
            <img class="headli1_2" src="/ui/img/twoth.png" alt=""/>
        </li>
<%--        <li data_id="1"  url="/building/selectBuilding">--%>
<%--                <span class="headli3_1">--%>
<%--                  外部关联OA设置--%>
<%--               </span>--%>
<%--            <img src="/ui/img/twoth.png" alt="" class="headli2_2"/>--%>
<%--        </li>--%>
    </ul>
</div>
<div style="margin-left: 90%;margin-top: 10px">
    <button type="button" class="layui-btn add layui-btn-sm btnR" lay-event="add">
        <i class="layui-icon">&#xe608;</i>
        新建
    </button>

</div>
<div style="margin-top: 8px">
    <table id="demo" lay-filter="test"></table>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail">用户映射</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use(['table', 'form', 'laydate','element','layer'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var internalTable = table.render({
            elem: '#demo'
            , url: '/connect/selectAllAppConnect' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo' //开启头部工具栏
            // ,defaultToolbar:['','','']
            , cols: [[ //表头
                , {field: 'appId',align: 'center', title: '应用内部ID'}
                , {field: 'appName',align: 'center', title: '应用名字'}
                , {field: 'accessToken',align: 'center', title: '调用接口凭证'}
                , {field: 'ip1',align: 'center', title: 'IP段1'}
                ,{field: 'ip2',align: 'center', title: 'IP段2'}
                ,{field: 'appDesc',align: 'center', title: '应用描述'}
                , {title: '操作', align: 'center', toolbar: '#barDemo',width:'190'}
            ]],
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object,//解析数据列表
                    "count": res.totleNum, //解析数据长度
                };
            }
        });
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
                        '                <label class="layui-form-label">应用内部ID：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="APP_ID"  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">应用名字：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="APP_NAME"  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">调用接口凭证：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="ACCESS_TOKEN" disabled  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">IP段1：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="IP1"  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +

                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">IP段2：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                    <input type="text" id="IP2"  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="display: flex;margin-top:15px">\n' +
                        '            <div class="layui-form-item" style="width: 1000px">\n' +
                        '                <label class="layui-form-label">应用描述：<span style="color: red;">*</span></label>\n' +
                        '                <div style="display: inline-block;width: 70%">\n' +
                        '                   <textarea name="desc" id="APP_DESC" placeholder="应用描述" class="layui-textarea"></textarea>\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '   <div class="layui-input-block" style="margin-left:37px">\n' +
                        '                    <input style="display: none" type="text" id="aid"  autocomplete="off" class="layui-input" placeholder="" value="">\n' +
                        '  </div>' +
                        '</div>'
                    , btn: ['提交', '返回']
                    , success: function () {
                        $("#APP_ID      ").val(data.appId);  //应用内部ID
                        $("#APP_NAME    ").val(data.appName);  //应用名字
                        $("#ACCESS_TOKEN").val(data.accessToken);   //调用接口凭证
                        $("#APP_DESC    ").val(data.appDesc);   //应用描述
                        $("#IP1         ").val(data.ip1);   //IP段1
                        $("#IP2         ").val(data.ip2);   //IP段1
                        $("#aid").val(data.aid)//id
                    }
                    ,yes: function (index) {
                        var APP_ID      =$("#APP_ID      ").val();
                        var APP_NAME    =$("#APP_NAME    ").val();
                        var ACCESS_TOKEN= $("#ACCESS_TOKEN").val();
                        var APP_DESC    =$("#APP_DESC    ").val();
                        var IP1         =$("#IP1         ").val();
                        var IP2         =$("#IP2         ").val();
                        var aid=$("#aid").val()
                        console.log(APP_ID,APP_NAME,ACCESS_TOKEN,APP_DESC,aid,IP1,IP2)
                        if(APP_ID!==''&&APP_NAME!=''&&ACCESS_TOKEN!==''&&APP_DESC!==''&&IP1!==''&&IP2!==''){
                            $.ajax({
                                url:'/connect/updateAllAppConnect',
                                dataType:'json',
                                type:'post',
                                data:{
                                    appId:APP_ID ,
                                    appName:APP_NAME   ,
                                    accessToken:ACCESS_TOKEN,
                                    appDesc:APP_DESC,
                                    ip1:IP1 ,
                                    ip2:IP2,
                                    aid:aid
                                },
                                success:function(obj){
                                    console.log(obj)
                                    if (obj.flag) {
                                        $.layerMsg({content: '编辑成功！', icon: 1}, function () {

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

            } else if (layEvent === 'detail') { //用户映射
                console.log(data)
                var code=data.aid
                window.location.href="/connect/selectConnect1?aid="+code;
            }

                    if(layEvent === 'del'){ //删除
                        layer.confirm('确定删除吗？', function(index){
                    obj.del();
                    layer.close(index);

                    $.post('/connect/deleteAllAppConnect', {aid: data.aid}, function(res){
                        if (res.flag) {
                            internalTable.reload();
                            // layer.close(index);
                        }
                    })
                });
            }
        });
        //新建
        $('.add').click(function () {
            layer.open({
                type: 1 //Page层类型
                , area: ['100%','100%']
                , title: '新建'
                // ,msg('',{time:100000})
                , content: '<div class="layui-form" id="ids">' +
                    '        <div style="display: flex;">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label" style="display: flex;width:105px">应用内部ID：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="APP_ID"  autocomplete="off" class="layui-input" placeholder="字母组合，例如 XXX_ERP" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px;margin-left: 25px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">应用名字：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="APP_NAME"  autocomplete="off" class="layui-input" placeholder="应用名字" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label" style="display: flex;width:105px">调用接口凭证：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="ACCESS_TOKEN" disabled  autocomplete="off" class="layui-input" placeholder="调用接口凭证" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px;margin-left: 25px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">IP段1：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="IP1"  autocomplete="off" class="layui-input" placeholder="IP地址段起始于" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +

                    '        <div style="display: flex;margin-top:15px;margin-left: 25px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">IP段2：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                    <input type="text" id="IP2"  autocomplete="off" class="layui-input" placeholder="IP地址段结束于" value="">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="display: flex;margin-top:15px;margin-left: 25px">\n' +
                    '            <div class="layui-form-item" style="width: 1000px">\n' +
                    '                <label class="layui-form-label">应用描述：<span style="color: red;">*</span></label>\n' +
                    '                <div style="display: inline-block;width: 70%">\n' +
                    '                   <textarea name="desc" id="APP_DESC" placeholder="应用描述" class="layui-textarea"></textarea>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '   <div class="layui-input-block" style="margin-left:37px">\n' +
                    '  </div>' +
                    '</div>'
                , btn: ['提交', '返回']
                , success: function () {
                    console.log("woshi ")
                    $.ajax({
                        url:'/connect/getAccessToken',
                        type:'get',
                        success:function(data){
                            console.log(data.object)
                            $("#ACCESS_TOKEN").val(data.object)
                        }
                    })
                }
                ,yes: function (index) {
                    var APP_ID      =$("#APP_ID      ").val();
                    var APP_NAME    =$("#APP_NAME    ").val();
                    var ACCESS_TOKEN= $("#ACCESS_TOKEN").val();
                    var APP_DESC    =$("#APP_DESC    ").val();
                    var IP1         =$("#IP1         ").val();
                    var IP2         =$("#IP2         ").val();
                    if(APP_ID!==''&&APP_NAME!=''&&ACCESS_TOKEN!==''&&APP_DESC!==''&&IP1!==''&&IP2!==''){
                        $.ajax({
                            url:'/connect/insertAllAppConnect',
                            dataType:'json',
                            type:'post',
                            data:{
                                appId:APP_ID ,
                                appName:APP_NAME   ,
                                accessToken:ACCESS_TOKEN,
                                appDesc:APP_DESC,
                                ip1:IP1 ,
                                ip2:IP2
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

    });
</script>
</body>
</html>
