<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/10/13
  Time: 13:35
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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>证照分类管理</title>
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
        width: 30%;
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
</style>
<body>
<div id="box" style="display: block">




    <div class="box2">


    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this" id="shan">新建证照分类</li>
            <li>证照分类管理</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <span class="asd">新建分类</span>
                <div id="aaa" style="width: 100%;height: 40px;background-color: #dcdfdf"></div>
                <div id="top">
                    <form class="layui-form" action="">
                        <div class="layui-inline" style="margin-left: 10%">
                            <label class="layui-form-label">序号</label>
                            <div class="layui-input-inline">
                                <input id="licenseTypeNum" name="licenseTypeNum" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 10%">
                            <label class="layui-form-label">分类名称</label>
                            <div class="layui-input-inline">
                                <input id="licenseTypeName" name="licenseTypeName" class="layui-input" type="text">
                            </div>
                        </div>
<%--                        <div class="layui-inline" style="margin-left: 10%;margin-top: 20px;">--%>
<%--                            <label class="layui-form-label">父级分类</label>--%>
<%--                            <div class="layui-input-inline">--%>
<%--                                <select name="parentTypeId" lay-verify="orgDeptId" style="width: 350px">--%>
<%--                                    <option value="" class="layui-this">请选择</option>--%>
<%--                                </select>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </form></div>
                <div id="bbb" style="margin-top: 50px;width: 100%;height: 40px;background-color: #dcdfdf"></div>
                <div id="bottom">
                    <form class="layui-form" action="">
                          <div class="layui-form">
                          <table class="layui-table" style="margin-left: 200px;">
                              <colgroup>
                                  <col width="150">
                                  <col width="150">
                                  <col width="200">
                                  <col>
                                  </colgroup>
                              <thead>
                              <tr>
                                  <th>属性名称</th>
<%--                                  <th>属性字段</th>--%>
                                  </tr>
                              </thead>
                              <tbody class="nt">
                              <tr>
                                  </tr>
                                </tbody>
                                </table>
                              <div class="layui-inline" style="margin-left: 8%">
                                  <label class="layui-form-label">属性名称</label>
                                  <div class="layui-input-inline">
                                      <input style="width: 150px" id="name" name="lendtitle" class="layui-input" type="text">
                                  </div>
                              </div>
<%--                              <div class="layui-inline">--%>
<%--                                  <label class="layui-form-label">属性字段</label>--%>
<%--                                  <div class="layui-input-inline">--%>
<%--                                      <input style="width: 150px" id="ziduan" name="lendtitle" class="layui-input" type="text">--%>
<%--                                  </div>--%>
<%--                              </div>--%>
                              <button class="layui-btn" id="tianjia" type="button">添加</button>
                            </div>
                    </form></div>
                <div style="margin-top: 30px;text-align: center">
                    <button class="layui-btn" type="button" id="add">保存</button>
                </div>
            </div>
            <div>




            </div>
            <div class="layui-tab-item two">
                <div>
                    <span class="zxc">证照分类管理</span>
                </div>
                <form class="layui-form" action="">
                    <div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">分类名称</label>
                            <div class="layui-input-inline">
                                <input id="licenseTypeName1" name="licenseTypeName1" class="layui-input" type="text">
                            </div>
                        </div>

                        <button type="button" class="layui-btn layui-btn-sm"  id="search" lay-event="search" style="height: 30px;line-height: 30px;">查询</button>
                    </div>


                </form>

                <table class="layui-hide" id="test1" lay-filter="test1"></table>
            </div>
        </div>
    </div>

</div>


</table>
<script id="barDemo" type="text/html">
    <div class="long">
        <a lay-event="edit" class="layui-btn layui-btn-xs" id="edit">编辑</a>
        <a lay-event="del" class="layui-btn layui-btn-danger layui-btn-xs" id="delete" >删除</a>
    </div>

</script>
</body>
<script>

    var licenceTypeId=''
    $('#aaa').click(function(){
        $('#top').toggle()
    })
    $('#bbb').click(function(){
        $('#bottom').toggle()
    })
    var z=0;
    $('#tianjia').on('click',function(){
        var a = $('#name').val()
        var b = $('#ziduan').val()
        var c = a+','+c
        var d = c.split(',')
        var str = ''
        var j=1

        if($('#name').val()==''){
            $.layerMsg({content: '属性名称不能为空', icon: 0});
            return false;
        }else{
        for(var i = 0; i < d.length-1; i++) {
            z=z+1
                    str += "<tr ><td id='col" + z + "' value= '" + a + "'>" + a + "</td></tr>"

        }
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
        //节点点击事件
        layui.eleTree.on("nodeClick(data2)",function(d) {
            var parData1 = d.data.currentData;
            $("[name='orgDeptId']").val(parData1.deptName);
            $("#orgDeptName").attr("pid",parData1.deptId);
        })

        $('#search').click(function () {
            var licenseTypeName1 = $("#licenseTypeName1").val()
            table.render({
                elem: '#test1'
                , url:'/licenseType/selectLicenseTypeByName?licenseTypeName='+licenseTypeName1+'&pageSize='+'10'+'&useFlag='+true
                ,cols:[[
                    {field:'licenseTypeNum',title:'排序号',align:'center'},
                    {field:'licenseTypeName',title:'分类名称',align:'center'},
                    // {field:'parentTypeName',title:'上级分类',align:'center'},
                    {title:'操作',toolbar:'#barDemo',minWidth:200,align:'center'},
                ]],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
            });
        });


        table.render({
            elem: '#test1'
            , url: '/licenseType/selectLicenseTypeByCond?pageSize=10&useFlag=true'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                // , {field: 'id', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true}
                {field: 'licenseTypeNum', title: '排序号', }
                , {field: 'licenseTypeName', title: '分类名称', }
                // , {field: 'parentTypeName', title: '上级分类', }
                , {field: '', title: '操作', toolbar: '#barDemo',minWidth:200}
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.data, //解析数据列表
                };
            }
            , page: true
        })
        table.on('tool(test1)', function (obj) {
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if (obj.event === 'edit') {
               //编辑
                layer.open({
                    type: 1 //此处以iframe举例
                    , title: '编辑'
                    , area: ['50%', '60%'],
                    offset:'20',
                    btn: ['确定', '取消'],
                    content: '<div id="top">\n' +
                        '                    <form class="layui-form" action="">\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%;">\n' +
                        '                            <label class="layui-form-label">序号</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="licenseTypeNum6" name="licenseTypeNum6" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 10%;margin-top: 25px">\n' +
                        '                            <label class="layui-form-label">分类名称</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input id="licenseTypeName6" name="licenseTypeName6" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        // '                        <div class="layui-inline" style="margin-left: 10%;margin-top: 20px;">\n' +
                        // '                            <label class="layui-form-label">父级分类</label>\n' +
                        // '                            <div class="layui-input-inline">\n' +
                        // '                                <select id="parentTypeId6" name="parentTypeId6" lay-verify="parentTypeName" style="width: 350px">\n' +
                        // '                                    <option value="0" class="layui-this">请选择</option>\n' +
                        // '                                </select>\n' +
                        // '                            </div>\n' +
                        // '                        </div>\n' +
                        '                             <div class="customize" > </div>' +
                        '                    </form></div>'
                    ,
                    success: function (json) {
                        form.render();
                        var parentTypeId=data.parentTypeId
                        $.ajax({
                            url:'/licenseType/selectParentType',
                            type:'post',
                            success:function(res){
                                var obj = res.obj
                                for(var i =0;i<obj.length;i++){
                                    $("[name='parentTypeId6']").append('<option value="' + obj[i].licenseTypeId + '">' + obj[i].licenseTypeName + '</option>');
                                }
                                form.render()
                            }
                        })
                        var optionItem = $("select[name='parentTypeId6']").find("option")
                        for(var i=0;i<$("select[name='parentTypeId6']").find("option").length;i++){
                            if(parentTypeId==$(optionItem[i]).val()){
                                $("#parentTypeId6").find('option[value="'+parentTypeId+'"]').attr('selected','selected');
                                form.render('select');

                            }

                        }
                        form.render();
                        $.ajax({
                            type: 'post',
                            url: '/licenseType/selectLicenseTypeById',
                            dataType: 'json',
                            async:false,
                            data:{
                                licenseTypeId:data.licenseTypeId,

                            },
                            success: function (json) {
                                var object = json.object;
                                var strs1 = '<div style="margin-top: 20px"></div>';
                                for(var i=0; i<10;i++){
                                    strs1 +=  '<div class="layui-form-item">\n' +
                                        '                             <div class="layui-inline" style="margin-left: 10%;" >\n' +
                                        '                                  <label class="layui-form-label" >' + '属性名称' + (i+1) +'</label>\n' +
                                        '                                  <div class="layui-input-inline">\n' +
                                        '                                        <input type="text" id="col'+ (i+1) + '" name="col'+ (i+1) + '" lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                                        '                                  </div>\n' +
                                        '                             </div>\n' +
                                        '                        </div>\n'
                                }
                                $('.customize').html(strs1)
                                form.render();

                                 licenceTypeId=data.licenceTypeId;

                                    $('#licenseTypeName6').val(json.object.licenseTypeName);
                                $('#licenseTypeNum6').val(json.object.licenseTypeNum);
                                    $('#parentTypeName6').val(json.object.parentTypeName);
                                $('#col1').val(json.object.col1);
                                $('#col2').val(json.object.col2);
                                $('#col3').val(json.object.col3);
                                $('#col4').val(json.object.col4);
                                $('#col5').val(json.object.col5);
                                $('#col6').val(json.object.col6);
                                $('#col7').val(json.object.col7);
                                $('#col8').val(json.object.col8);
                                $('#col9').val(json.object.col9);
                                $('#col10').val(json.object.col10);

                                    form.render();
                            }
                        })



                    }, yes: function () {
                        $.ajax({
                            type: 'post',
                            url: '/licenseType/updateEduorgLicenseTypeById',
                            dataType: 'json',
                            data: {
                                licenseTypeId:data.licenseTypeId,
                                licenseTypeNum :$("#licenseTypeNum6").val(),
                                licenseTypeName :$("#licenseTypeName6").val(),
                                parentTypeId: $("#parentTypeId6").val(),
                                col1:$("#col1").val(),
                                col2:$("#col2").val(),
                                col3:$("#col3").val(),
                                col4:$("#col4").val(),
                                col5:$("#col5").val(),
                                col6:$("#col6").val(),
                                col7:$("#col7").val(),
                                col8:$("#col8").val(),
                                col9:$("#col9").val(),
                                col10:$("#col10").val()

                            },
                            success: function (json) {
                                layer.closeAll()
                                $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        })
                    }
                })
            } else if (obj.event === 'del') {
               //删除
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/licenseType/deleteEduorgLicenseTypeById',
                        dataType: 'json',
                        data: {
                            licenseTypeId:data.licenseTypeId
                        },
                        success: function (json) {
                            if(json.flag){
                                layer.closeAll();
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        }
                    })
                })

            }
        })

        $(document).on("click", "#people1", function () {
            org_id="people1";
            $.popWindow("../common/selectPartyMember?0");
        })


        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        // table.on('tool(test1)', function (obj) {
        //     data = obj.data;
        //     var data = obj.data;
        //     var dataObj = obj.data;
        //     var layEvent = obj.event;
        //     layer.open({
        //         type: 2 //此处以iframe举例
        //         , title: ''
        //         , area: ['80%', '90%'],
        //         content: '/orgLife/addBranchCommitteeMeeting?btnType=1&committeeId='+dataObj.committeeId+''
        //         ,
        //         success: function () {
        //
        //             form.val("formTest",obj.data);
        //             $.ajax({
        //                 url:'/branchCommitteeMeeting/queryById',
        //                 dataType:'json',
        //                 data:{
        //                     committeeId:data.committeeId
        //                 },
        //                 success:function(res){
        //                     var datas = res.object.moderatorId;
        //                     form.render();
        //                 }
        //             })
        //
        //             $.ajax({
        //                 url:'/PtyMemberComment/getOrgDepartment',
        //                 dataType:'json',
        //                 success:function(res){
        //                     var datas = res.obj;
        //                     var str = '<option value=""></option>';
        //                     for(var i=0;i<datas.length;i++){
        //                         str += '<option value="' +datas[i].orgDeptId + '"> '+ datas[i].orgDeptName + '</option>'
        //                     }
        //                     $('#belog').html(str)
        //                     $("#belog").each(function() {
        //                         $(this).children("option").each(function() {
        //                             if (this.value == data.orgDeptId) {
        //                                 $(this).attr("selected","selected");
        //                             }
        //
        //                         });
        //                     })
        //                     form.render();
        //                 }
        //
        //             })
        //
        //             form.render()
        //         },
        //
        //
        //     })
        //
        // })

        $.ajax({
            url:'/licenseType/selectParentType',
            type:'post',
            success:function(res){
                var obj = res.obj
                for(var i =0;i<obj.length;i++){
                    $("[name='parentTypeId']").append('<option value="' + obj[i].licenseTypeId + '">' + obj[i].licenseTypeName + '</option>');
                }
                form.render()
            }
        })
        $(document).on('click',"#add",function(){
            var licenseTypeName = $("input[name='licenseTypeName']").val()
            var licenseTypeNum = $("input[name='licenseTypeNum']").val()
            var col1 = $("#col1").text();
            var col2 = $("#col2").text();
            var col3 = $("#col3").text();
            var col4 = $("#col4").text();
            var col5 = $("#col5").text();
            var col6 = $("#col6").text();
            var col7 = $("#col7").text();
            var col8 = $("#col8").text();
            var col9 = $("#col9").text();
            var col10 = $("#col10").text();
            var parentTypeId;
            if($("select[name='parentTypeId']").val() == ''){
                parentTypeId = 0
            }else{
                parentTypeId = $("select[name='parentTypeId']").val()
            }


            $.ajax({
                url:'/licenseType/addLicenseType',
                data:{
                    licenseTypeName:licenseTypeName,
                    parentTypeId:parentTypeId,
                    licenseTypeNum:licenseTypeNum,
                    col1:col1,
                    col2:col2,
                    col3:col3,
                    col4:col4,
                    col5:col5,
                    col6:col6,
                    col7:col7,
                    col8:col8,
                    col9:col9,
                    col10:col10,

                },
                type:'post',
                success:function(res){
                    if (res.flag){
                        layer.msg('保存成功！',{icon:1},function () {
                            location.reload();
                        });
                        $("input[name='licenseTypeName']").val('')
                        $("input[name='licenseTypeNum']").val('')
                        $("select[name='superiorTypeId']").val('请选择')
                    }else {
                        layer.msg('该证照分类已存在！',{icon:2},function () {

                        });
                    }
                }
            })
        });
    });


</script>
</html>
