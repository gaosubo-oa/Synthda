<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/2/18
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/UserPriv/roleAuthorization.js?20210721.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .big3{
        margin-left: 5px;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        font-size: 20px;
        color: #494d59;
        FONT-WEIGHT: normal;
    }
    .top{
        margin-top: 60px;
    }
    .newJuese{
        display: inline-block;
        width: 100px;
        height: 28px;
        line-height: 28px;
        border-radius: 3px;
        background: #2b7fe0;
        color: #ffffff;
        text-align: center;
        cursor: pointer;
        float: right;
        margin-right: 38px;
    }
    .biao{
        width: 97%;
        padding-left: 20px;
        padding-right: 20px;
        margin-top: 20px;
    }
    .layui-table th{
        font-weight: bold;
    }
    .layui-table-page{
        text-align: right;
    }
    .head .headli1_2{
        margin-top: -5px;
    }
</style>
<body>
<div id="north" style="display: none;min-width: 1100px;">
    <div class="head w clearfix">
        <ul class="index_head clearfix">
            <li data_id="0">
                <span class="headli1_1">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>

            <%--<li>--%>
            <%--<span class="headli1_1 ">--%>
            <%--<a  href="newRole?0" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
            <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
            <%--</li>--%>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="adjustTheRole" data-Url="" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="modifyThePermissions?0" data-Url="" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1 one">
                <a  href="roleAndClassification" data-Url="" ><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
        </ul>
    </div>
</div>
    <div class="top">
        <img src="/img/icon_rolemanage_06.png"  align="absmiddle" style="margin-left: 25px;">
        <span class="big3"><fmt:message code="roleAuthorization.th.RoleMmanagement" /></span>
        <a class="newJuese"><img style="margin-right: 4px;margin-bottom: 4px;" src="/img/mywork/newbuildworjk.png" alt=""><fmt:message code="global.lang.new" /></a>
        <div id="Confidential" style="display: inline-block"></div>
    </div>
    <div class="biao">
        <table class="layui-hide" id="tests" lay-filter="tests"></table>
    </div>

<script id="barDemos" type="text/html">
    <div class="long">
<%--        <a id="edit" lay-event="edit" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>--%>
<%--        <a id="del" lay-event="del" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>--%>
        <a lay-event="edit" class="layui-btn layui-btn-xs" id="edit"><fmt:message code="global.lang.edit" /></a>
        <a lay-event="userEdit" class="layui-btn layui-btn-xs" id="userEdit"><fmt:message code="roleAuthorization.th.SetBranchRole" /></a>
        <a lay-event="del" class="layui-btn layui-btn-danger layui-btn-xs" id="del" ><fmt:message code="global.lang.delete" /></a>
    </div>

</script>
</body>
<script>
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var laydate = layui.laydate
        table.render({
            elem: '#tests'
            , url: '/userPrivType/queryUserPrivType'
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'privTypeNo',title: '<fmt:message code="vote.th.SortNumber" />', align:'center',width:'20%' }
                ,{field: 'privTypeName',title: '<fmt:message code="sup.th.CategoryName" />', align:'center',width:'60%' }
                , {field: '', title: '<fmt:message code="notice.th.operation" />',width:'20%', toolbar: '#barDemos',align:'center'}
            ]]
            ,done: function (res, curr, count) {
                $('tbody tr').eq(0).hide()
            }
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
        })
        $(document).on('click','.newJuese',function(){
            layer.open({
                type: 1,
                area: ['370px', '300px'], //宽高
                title: '新建分类',
                maxmin: true,
                btn: ['确定','取消'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    ' <div class="layui-form-item" >\n' +
                    '     <div class="layui-inline" >\n' +
                    '         <label class="layui-form-label" >分类排序号</label>\n' +
                    '         <div class="layui-input-inline">\n' +
                    '             <input type="text" name="privTypeNo"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                    '         </div>\n' +
                    '     </div>\n' +
                    ' <div class="layui-form-item" >\n' +
                    '     <div class="layui-inline" >\n' +
                    '         <label class="layui-form-label" style="margin-top: 15px" >分类名称</label>\n' +
                    '         <div class="layui-input-inline">\n' +
                    '             <input style="margin-top: 15px"  type="text" name="privTypeName"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                    '         </div>\n' +
                    '     </div>\n' +
                    ' </div>\n' +
                    ' </div>\n' +
                    '</form>' +
                    '</div>',
                success: function () {

                    form.render()

                },
                yes: function (index, layero) {
                    var privTypeNo = $("input[name='privTypeNo']").val()
                    var privTypeName = $("input[name='privTypeName']").val()
                    $.ajax({
                        type: 'post',
                        url: '/userPrivType/addUserPrivType',
                        data:{
                            privTypeNo:privTypeNo,
                            privTypeName:privTypeName,
                        },
                        dataType: 'json',
                        success: function (json) {
                            if(json.flag){
                                layer.close(index);
                                layer.msg('添加成功！',{icon:1});
                                table.reload('tests')
                            }
                        }
                    })
                }
            });
        })
        table.on('tool(tests)',function(obj){
            var privTypeId = obj.data.privTypeId
            if(obj.event == 'edit'){
                layer.open({
                    type: 1,
                    area: ['370px', '300px'], //宽高
                    title: '修改',
                    maxmin: true,
                    btn: ['确定','取消'], //可以无限个按钮
                    content: '<div style="margin: 43px auto;">' +
                        '<form class="layui-form" action="">\n' +
                        ' <div class="layui-form-item" >\n' +
                        '     <div class="layui-inline" >\n' +
                        '         <label class="layui-form-label" >分类排序号</label>\n' +
                        '         <div class="layui-input-inline">\n' +
                        '             <input type="text" name="privTypeNo"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                        '         </div>\n' +
                        '     </div>\n' +
                        ' <div class="layui-form-item" >\n' +
                        '     <div class="layui-inline" >\n' +
                        '         <label class="layui-form-label" style="margin-top: 15px" >分类名称</label>\n' +
                        '         <div class="layui-input-inline">\n' +
                        '             <input style="margin-top: 15px"  type="text" name="privTypeName"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                        '         </div>\n' +
                        '     </div>\n' +
                        ' </div>\n' +
                        ' </div>\n' +
                        '</form>' +
                        '</div>',
                    success: function () {

                        form.render()
                        $.ajax({
                            type: 'post',
                            url: '/userPrivType/selUserPrivType',
                            data:{
                                privTypeId:privTypeId
                            },
                            dataType: 'json',
                            success: function (json) {
                                if(json.flag){
                                    $("input[name='privTypeNo']").val(json.object.privTypeNo)
                                    $("input[name='privTypeNo']").attr('privTypeId',json.object.privTypeId)
                                    $("input[name='privTypeName']").val(json.object.privTypeName)
                                }
                            }
                        })
                    },
                    yes: function (index, layero) {
                        var privTypeNo = $("input[name='privTypeNo']").val()
                        var privTypeName = $("input[name='privTypeName']").val()
                        var privTypeId = $("input[name='privTypeNo']").attr('privTypeId')
                        $.ajax({
                            type: 'post',
                            url: '/userPrivType/updateUserPrivType',
                            data:{
                                privTypeId:privTypeId,
                                privTypeName:privTypeName,
                                privTypeNo:privTypeNo
                            },
                            dataType: 'json',
                            success: function (json) {
                                if(json.flag){
                                    layer.close(index);
                                    layer.msg('修改成功！',{icon:1});
                                    table.reload('tests')
                                }else{
                                    layer.msg('修改失败！',{icon:0});
                                }
                            }
                        })
                    }
                });
            }else if(obj.event == 'del'){
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/userPrivType/delUserPrivType',
                        dataType: 'json',
                        data: {
                            privTypeId:privTypeId
                        },
                        success: function (json) {
                            if(json.flag){
                                layer.closeAll();
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                table.reload('tests')
                                })
                            }else{
                                layer.msg('该分类下存在角色，不能删除！',{icon:0});
                            }
                        }
                    })
                })
            }else if(obj.event == 'userEdit'){
                // window.open('modifyThePermissions?privTypeId='+privTypeId)
                window.location.href='modifyThePermissions?privTypeId='+privTypeId+''
            }
        })
        // $(document).on('click','#edit',function(){
        //     layer.open({
        //         type: 1,
        //         area: ['531px', '372px'], //宽高
        //         title: '修改',
        //         maxmin: true,
        //         btn: ['确定','取消'], //可以无限个按钮
        //         content: '<div style="margin: 43px auto;">' +
        //             '<form class="layui-form" action="">\n' +
        //             ' <div class="layui-form-item" >\n' +
        //             '     <div class="layui-inline" >\n' +
        //             '         <label class="layui-form-label" >分类排序号</label>\n' +
        //             '         <div class="layui-input-inline">\n' +
        //             '             <input type="text" name="privTypeNo"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //             '         </div>\n' +
        //             '     </div>\n' +
        //             ' <div class="layui-form-item" >\n' +
        //             '     <div class="layui-inline" >\n' +
        //             '         <label class="layui-form-label" style="margin-top: 15px" >分类名称</label>\n' +
        //             '         <div class="layui-input-inline">\n' +
        //             '             <input style="margin-top: 15px"  type="text" name="privTypeName"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //             '         </div>\n' +
        //             '     </div>\n' +
        //             ' </div>\n' +
        //             ' </div>\n' +
        //             '</form>' +
        //             '</div>',
        //         success: function () {
        //
        //             form.render()
        //             $.ajax({
        //                 type: 'post',
        //                 url: 'http://kele.yanshi.xtdoa.cn/userPrivType/selUserPrivType',
        //                 data:{
        //                     privTypeId:privTypeId
        //                 },
        //                 dataType: 'json',
        //                 success: function (json) {
        //                     if(json.flag){
        //                         layer.close(index);
        //                         layer.msg('添加成功！',{icon:1});
        //                         table.reload('tests')
        //                     }
        //                 }
        //             })
        //         },
        //         yes: function (index, layero) {
        //
        //         }
        //     });
        // })
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</html>
