
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>商务资源预定</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    .layui-table-body{overflow-x: hidden;}
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .zxc {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }
    .layui-form-select{
        width: 200px!important;
    }

    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 100px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 20px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }

    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-unselect{
        width: 350px;
    }
    .layui-input{
        width: 200px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
    .layui-table-cell {
        font-size:14px;
        padding:0 5px;
        height:auto;
        overflow:visible;
        text-overflow:inherit;
        white-space:normal;
        word-break: break-all;
    }
</style>
<div style="margin-top: 20px">
    <span class="zxc" style="margin: 30px;font-size: 25px">第二轮资源预定</span>
</div>
<table class="layui-hide" style="margin-top: 10px" id="test1" lay-filter="test1"></table>
<center><button type="button" class="layui-btn layui-btn-sm" id="return" lay-event="return" style="height: 30px;line-height: 30px;">返回</button></center>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="reserve" lay-event="reserve" data-index="2" style="color: blue;cursor:pointer; text-decoration:underline">预定</a>
    </div>

</script>

</body>
<script>
    var param = $.GetRequest();
    var userId = param.userId
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()
        $('#return').click(function () {
            window.location.href='/cdmResource/BusinessResourceReservation'
        })


        // $.ajax({
        //     url:'/cdmResource/selectCdmResourceClassByUserId',
        //     type: "post",
        //     dataType: "json",
        //     success:function (res) {
        //         if(res.flag){
        //             $(".long").hide()
        //             $("#reserve").hide()
        //             classId=res.object.classId
        //         }}
        // })

        var meetTable=table.render({
            elem: '#test1'
            , url: '/cdmResource/selectResourcePackageByUserId?pageSize='+'10'+'&useFlag='+true+'&userId='+userId
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field:'packageName',title:'资源包名称',align:'center'},
                {field:'className',title:'所属分类',align:'center'},
                {field:'packagePrice',title:'资源包价格',align:'center'},
                {field:'packageDesc',title:'资源包描述',width:'25%',align:'center'},
                {field:'packageState',title:'预定状态',align:'center',templet:function (b) {
                        if(b.packageState=='0'){
                            return '未预定'
                        }else if(b.packageState=='1'){
                            return '已预定'
                        }
                    }},
                {title:'操作',toolbar:'#barDemos',align:'center'},
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
            , done: function (res) {
                for(var i=0;i<res.data.length;i++) {
                    var doneres = res.data[i].packageState
                    if(doneres=='1'){
                        $(".long").hide()
                        $("#reserve").hide()
                    }
                }
        }
        })


        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if(obj.event === 'reserve'){

                var titles=data.className
                layer.confirm('请确认是否预订' + titles + '会议资源。', {
                    btn: ['确定', '取消'], //按钮
                    title: "预定",
                    offset:200
                },function () {
                    $.ajax({
                        type: 'post',
                        url: '/cdmResource/updateCdmResourcePackageByUserId',
                        dataType: 'json',
                        data: {
                            packageId:data.packageId,

                        },
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: '预定成功!', icon: 6}, function () {
                                    location.reload();
                                });
                            } else {
                                $.layerMsg({content: '预定失败!'+res.msg, icon: 6}, function () {
                                });
                            }
                        }
                    });
                },function(){
                    layer.closeAll();
                })
            }else if(obj.event === 'check'){
                $.ajax({
                    url:'/cdmResource/selectByClassId',
                    type: "post",
                    dataType: "json",
                    data:{
                        classId:data.classId
                    },
                    success:function (res) {
                        if(res.flag){

                        }
                    }
                })
            }

        })


    });


</script>
</html>


