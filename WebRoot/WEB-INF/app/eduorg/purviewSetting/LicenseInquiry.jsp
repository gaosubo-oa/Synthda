<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/10/13
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>证照统计</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" href="static/layui/css/layui.css" rel="external nofollow" >
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
        margin-top: 35px;
        display: block;
        margin-right: 10px;
    }
    ..layui-table-cell{
        height: 28px!important;
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
        text-align: center;
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
        width: 350px;
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
    .list1 tr th {
        border: 1px solid #cccccc;
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
</style>
<body>
<div id="box" style="display: block">




    <div class="box2">


    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this" id="shan">按机构</li>
            <li>按类别</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form class="layui-form" action="">
                    <div>
                        <div class="layui-inline">
                            <label class="layui-form-label">机构名称</label>
                            <div class="layui-input-inline">
                                <input  style="width: 200px" id="organName" name="organName" class="layui-input" type="text">
                            </div>
                        </div>

                        <button type="button" class="layui-btn layui-btn-sm" id="search2" lay-event="search2" style="height: 30px;line-height: 30px;">查询</button>
                    </div>


                </form>

                <table class="layui-hide" id="test2" lay-filter="test2"></table>
            </div>
            <div>




            </div>
            <div class="layui-tab-item two">
                <form class="layui-form" action="">
                    <div>
                        <div class="layui-inline">
                            <label class="layui-form-label">机构名称</label>
                            <div class="layui-input-inline">
                                <input  style="width: 200px" id="organName2" name="organName2" class="layui-input" type="text">
                            </div>
                        </div>

                        <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;">查询</button>
                    </div>


                </form>

                <table class="layui-table" id="taskBody" lay-filter="taskBody">
                    <%--                    <thead class="list1">--%>
                    <%--                    </thead>--%>
                    <%--                    <tbody id="taskBody">--%>
                    <%--                    </tbody>--%>
                </table>
            </div>
        </div>
    </div>

</div>


</table>
<%--<script id="barDemo" type="text/html">--%>
<%--    <div class="long">--%>
<%--        <a id="detail" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>--%>
<%--        <a lay-event="edit" id="edit" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>--%>
<%--        <a lay-event="del" id="delete" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>--%>
<%--    </div>--%>

<%--</script>--%>
<%--<script id="barDemos" type="text/html">--%>
<%--    <div class="long">--%>
<%--        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>--%>
<%--    </div>--%>

<%--</script>--%>

</body>
<script>
    var orgId;
    $.ajax({
        type: 'post',
        url: '/license/selectAllEduorg',
        dataType: 'json',
        async:false,
        data:{
            page:1,
            pageSize:10,
            useFlag:true
        },
        success: function (json) {
            if(json.flag){
                orgId=json.obj[0].orgId;
            }
        }
    })
    var arr=[];
    var data=[];
    var id=[];
    // var cols=[[
    //     {field: 'orgFullname',width:'25%', title: '机构名称',},
    // ]]; //表头

    $.ajax({
        type: 'post',
        url: '/license/selectAllLicenceTypeStatistics',
        dataType: 'json',
        async:false,
        data:{
            useFlag:true,
            pageSize:'10',
            page:1
        },
        success: function (json) {
            fu(json)
        }
    })




    $('#aaa').click(function(){
        $('#top').toggle()
    })
    $('#bbb').click(function(){
        $('#bottom').toggle()

    })
    $('#tianjia').on('click',function(){
        var a = $('#name').val()
        var b = $('#ziduan').val()
        var c = a+','+c
        var d = c.split(',')
        var str = ''
        for(var i = 0; i < d.length-1; i++) {
            str +="<tr><td>"+a+"</td><td>"+b+"</td>"
        }
        $(".nt").append(str)
        $('#name').val('')
        $('#ziduan').val('')
    })

    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()

        var el;
        $("[name='orgDeptId']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                $.get('/orgDepartment/queryByDepIdList?deptId=0', function (res) {
                    //layer.close(loadingIndex);
                    if (res.flag) {
                        el = layui.eleTree.render({
                            elem: '.ele2',
                            data: res.obj,
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine: true,
                            showCheckbox: false,
                            checked: false,
                            lazy: true,
                            //defaultExpandAll: false,
                            request: {
                                name: 'orgDeptName',
                                id:'orgDeptId',
                                isLeaf:false
                                //children: "plbProjList",
                            },
                            load: function(data,callback) {
                                $.post('/orgDepartment/queryByDepIdList?deptId='+data.deptId,function (res) {
                                    callback(res.obj);//点击节点回调
                                })
                            },
                            done: function(res){
                                if(res.data.length == 0){
                                    $(".ele2").html('<div style="text-align: center">暂无数据</div>');
                                }
                            }
                        });

                    }
                });
            }
            $(".ele2").slideDown();
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })

        $('#search2').click(function () {

            var organName=$('#organName').val()
            table.render({
                elem: '#test2'
                , url: '/license/statisticsByOrgan?useFlag=true&pageSize=10&orgFullname='+organName
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [[
                    {field: 'organName',width:'25%',  title: '机构名称',}
                    , {field: 'totalCount',width:'25%',  title: '证照数量', }
                    , {field: 'overdueCount',width:'25%',  title: '过期数量', }
                    , {field: 'effectiveCount',width:'25%',  title: '有效期数量', }
                    // , {field: '', title: '操作', toolbar: '#barDemo',minWidth:200}
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
            })

        });

        $('#search1').click(function () {
            var organName2=$('#organName2').val()
            $.ajax({
                type: 'post',
                url: '/license/selectAllLicenceTypeStatistics',
                dataType: 'json',
                async:false,
                data:{
                    likeOrgFullname:organName2,
                    useFlag:true,
                    pageSize:'10',
                    page:1
                },
                success: function (json) {
                    $(' #layui-laypage-2 > .layui-laypage-count').text("共 "+json.totleNum+" 条")
                    if(json.flag){
                        for (var i = 0; i < json.object.length; i++) {
                            arr1= json.object[i].licenseTypeName;
                            arr.push(arr1);
                        }
                        for (var j = 0; j < json.object.length; j++) {
                            var  data1= json.object[j].licenseTypeId;
                            data.push(data1);
                        }
                        //每一行机构
                        var acc = "";
                        acc += '<tr><th data-field="orgFullname" data-key="1-0-0" class=""><div class="layui-table-cell laytable-cell-1-0-0"><span>机构名称</span></div></th>';
                        var licenseTypeId = "";
                        var licenseTypeName = "";
                        var data_field = "";
                        var data_key = "";
                        for (var n = 0; n < json.object.length; n++){
                            data_field = json.object[n].licenseTypeId;
                            licenseTypeName = json.object[n].licenseTypeName;
                            data_key = n + 1;
                            acc += '<th data-field="'+data_field+'" data-key="1-0-'+data_key+'" class=""><div class="layui-table-cell laytable-cell-1-0-'+data_key+'"><span>'+licenseTypeName+'</span></div></th>'
                        }
                        acc += '</tr>'
                        for (var z = 0; z < json.obj.length; z++) {
                            var orgFullname = json.obj[z].orgFullname;
                            acc += '<tr data-index="' + z + '" class=""><td data-field="orgFullname" data-key="1-0-0" >' +
                                '<div class="layui-table-cell laytable-cell-1-0-0">'+ orgFullname +'</div></td>'

                            //这一行机构的类别列
                            for (var b = 0; b < json.object.length; b++) {
                                var count = "";
                                var typeId = json.object[b].licenseTypeId;
                                //机构这一个类别里面的数量
                                for (var x = 0; x < json.obj[z].list.length; x++){
                                    if (typeId == json.obj[z].list[x].licenseTypeId){
                                        count = json.obj[z].list[x].count;
                                    }
                                }
                                data_field = json.object[b].orgId;
                                data_key = b + 1;
                                acc += '<td data-field="'+data_field+'" data-key="1-0-'+data_key+'" class=""><div class="layui-table-cell laytable-cell-1-0-'+data_key+'">' + count + '</div></td>'
                            }
                            acc += '</tr>'
                        }
                        $('#taskBody').html(acc);
                    }
                }
            })
            // table.render({
            //     elem: '#taskBody'
            //     , url: '/license/statisticsByLicenseType?useFlag=true&pageSize=10&organName2='+organName2
            //     , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            //     , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            //         title: '提示'
            //         , layEvent: 'LAYTABLE_TIPS'
            //         , icon: 'layui-icon-tips'
            //     }]
            //     , title: '用户数据表'
            //     // , cols:cols
            //     , parseData: function (res) { //res 即为原始返回的数据
            //         return {
            //             "code": 0, //解析接口状态
            //             "msg": res.msg, //解析提示文本
            //             "count": res.totleNum, //解析数据长度
            //             "data": res.obj, //解析数据列表
            //         };
            //     }
            //     , page: true
            // })
        });

        // for (var i=1;arr.length>i;i++){
        //     var obj2={
        //         title: arr[i],
        //         field:''
        //     }
        //     cols[0].push(obj2);
        // }

        table.render({
            elem: '#taskBody'
            , url: '/license/selectAllLicenceTypeStatistics?useFlag=true&pageSize=10'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            ,cols:[[

            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                fu(res)
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
        })


        table.render({

            elem: '#test2'
            ,async:false
            , url: '/license/statisticsByOrgan?useFlag=true&pageSize=10'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'organName',width:'25%',  title: '机构名称',}
                , {field: 'totalCount',width:'25%',  title: '证照数量', }
                , {field: 'overdueCount',width:'25%',  title: '过期数量', }
                , {field: 'effectiveCount',width:'25%',  title: '有效期数量', }
                // , {field: '', title: '操作', toolbar: '#barDemo',minWidth:200}
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
        })



    });

    function fu(json){
        if(json.flag){
            for (var i = 0; i < json.object.length; i++) {
                arr1= json.object[i].licenseTypeName;
                arr.push(arr1);
            }
            for (var j = 0; j < json.object.length; j++) {
                var  data1= json.object[j].licenseTypeId;
                data.push(data1);
            }
            //每一行机构
            var acc = "";
            acc += '<tr><th data-field="orgFullname" data-key="1-0-0" class=""><div class="layui-table-cell laytable-cell-1-0-0"><span>机构名称</span></div></th>';
            var licenseTypeId = "";
            var licenseTypeName = "";
            var data_field = "";
            var data_key = "";
            for (var n = 0; n < json.object.length; n++){
                data_field = json.object[n].licenseTypeId;
                licenseTypeName = json.object[n].licenseTypeName;
                data_key = n + 1;

                acc += '<th data-field="'+data_field+'" data-key="1-0-'+data_key+'" class=""><div class="layui-table-cell laytable-cell-1-0-'+data_key+'"><span>'+licenseTypeName+'</span></div></th>'
            }
            acc += '</tr>'
            for (var z = 0; z < json.obj.length; z++) {
                var orgFullname = json.obj[z].orgFullname;
                acc += '<tr data-index="' + z + '" class=""><td data-field="orgFullname" data-key="1-0-0" >' +
                    '<div class="layui-table-cell laytable-cell-1-0-0">'+ orgFullname +'</div></td>'

                //这一行机构的类别列
                for (var b = 0; b < json.object.length; b++) {
                    var count = "";
                    var typeId = json.object[b].licenseTypeId;
                    //机构这一个类别里面的数量
                    for (var x = 0; x < json.obj[z].list.length; x++){
                        if (typeId == json.obj[z].list[x].licenseTypeId){
                            count = json.obj[z].list[x].count;
                        }
                    }
                    data_field = json.object[b].licenseTypeId;
                    data_key = b + 1;
                    if(data_field==undefined){
                        data_field=''
                    }
                    acc += '<td data-field="'+data_field+'" data-key="1-0-'+data_key+'" class=""><div class="layui-table-cell laytable-cell-1-0-'+data_key+'">' + count + '</div></td>'
                }
                acc += '</tr>'
            }
            $('#taskBody').html(acc);
        }
    }
</script>
</html>