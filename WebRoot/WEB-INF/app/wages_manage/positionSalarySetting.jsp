
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
    <title>岗位薪资设置</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }
#show2{
    font-size: 20px;
}
    .asd {
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
        height: 35px!important;
    }
    @media print {.notprint{display: none;}}
    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 120px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 10px;
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
</style>
<body>
<div style="margin-top: 20px">
    <div style="
    height: 45px;
    line-height: 45px;
    font-size: 22px;
    margin-left: 50px;
    color: #494d59;">
        <img src="/ui/img/zkim/category.png">
        岗位薪资设置</div>
    <form class="layui-form" action="">
        <div style="position: relative;line-height: 60px;">
            <div class="layui-inline">
                <label class="layui-form-label" >一级分类</label>
                <div class="layui-input-inline"  style="display: flex">
                    <select id="type1" name="type1" class="type1" lay-verify="type1" lay-filter="type1">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" >二级分类</label>
                <div class="layui-input-inline"  style="display: flex">
                    <select id="type2" name="type2" class="type2" lay-verify="type2" lay-filter="type2">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" >薪岗名称</label>
                <div class="layui-input-inline"  style="display: flex">
                    <input  style="width: 200px" id="job" name="job" class="layui-input" type="text">
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;">查询</button>
            <button type="button" class="layui-btn layui-btn-sm" id="add" lay-event="add" style="height: 30px;line-height: 30px;">新建</button>
            <button type="button" class="layui-btn layui-btn-sm" id="import" lay-event="import" style="height: 30px;line-height: 30px;">导入</button>
            <button type="button" class="layui-btn layui-btn-sm" id="export" lay-event="export" style="height: 30px;line-height: 30px;margin-left: 20px">导出</button>
        </div>
    </form>
    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">查看</a>
        <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>
        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>

</script>

</body>
<script>
var str1=''
$('#export').on("click",function () {
    var job = $("#job").val()
    var type1 = $("#type1").val()
    var type2 = $("#type2").val()
    window.location.href = '/WagesJobManage/export?job='+job+'&type1='+type1+'&type2='+type2
})
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var upload = layui.upload
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
//右侧的报表导入字段
        $('#import').on("click",function () {
            var repTableId = $('.select').attr('repTableId');
            Import(repTableId);
        })
        //导入
        function Import(data) {
            layer.open({

                type: 1,
                area: ['531px', '372px'], //宽高
                title: '导入',
                maxmin: true,
                moveType: 1,
                btn: ['确定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue;cursor:pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="tests">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success: function () {
                    $('#load').on("click",function () {
                        window.location.href = "/ui/file/dataReport/岗位薪资设置表.xlsx"
                    })
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#tests' //绑定元素
                        , url: '/WagesJobManage/imports'
                        , accept: 'file'
                        , auto: false
                        , bindAction: '.layui-layer-btn0'
                        , choose: function (obj) {
                            var files = obj.pushFile();
                            obj.preview(function (index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        , done: function (res) {
                            var str = ''
                            $.each(res.obj, function (key, value) {
                                str += key + '->' + value + '\n'
                            });
                            layer.msg(res.msg);
                            table.reload('test1', {
                                url: '/WagesJobManage/selectAll',
                                where: {
                                    tableId: data
                                }
                            })
                            layer.open({
                                type: 1 //此处以iframe举例
                                , title: '导入情况详情'
                                , area: ['50%', '50%'],
                                offset:'100',
                                btn: ['确定'],
                                content:'<div id="show2" name="show2"></div>'
                                ,
                                success: function () {
                                },yes:function(){
                                    str1=''
                                    layer.closeAll();
                                }
                            })
                            var last2=res.object
                            var show3=JSON.stringify(last2);
                            str1 +='<div>'+show3+'</div><br/>'

                            for (var i = 0; i < res.obj.length; i++) {
                                var show2=res.obj[i]
                                    str1 += '<div>'+show2+'</div><br/>'
                            }
                            $('[name="show2"]').html(str1);
                        }
                        , error: function () {
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");

                        }
                    });
                },
                yes: function (index) {
                    layer.close(index);
                }
            });
        }
        $('#add').on("click",function () {
            layer.open({
                type: 1 //此处以iframe举例
                , title: '新建岗位薪资'
                , area: ['60%', '80%'],
                offset:'50',
                btn: ['确定', '取消'],
                content: '<form class="layui-form" action="">\n' +
                    '<div style="display: flex;margin-top: 30px">\n' +
                    '    <div style="width: 50%">\n' +
                    '        <div class="layui-inline">\n' +
                    '            <label class="layui-form-label">一级分类<span style="color: red; font-size: 20px;">*</span></label>\n' +
                    '            <div class="layui-input-inline">\n' +
                    '<select id="type11" name="type11" class="type11" lay-verify="type11" lay-filter="type11">\n' +
                    '<option value="">请选择</option>' +
                    '                    </select>' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div style="width: 50%">\n' +
                    '        <div class="layui-inline">\n' +
                    '            <label class="layui-form-label">二级分类<span style="color: red; font-size: 20px;">*</span></label>\n' +
                    '            <div class="layui-input-inline">\n' +
                    '<select id="type22" name="type22" class="type22" lay-verify="type22" lay-filter="type22">\n' +
                    '<option value="">请选择</option>' +
                    '                    </select>' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '    <div style="display: flex;margin-top: 30px" >\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">薪岗名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    ' <input  style="width: 200px" id="job33" name="job33" class="layui-input" type="text">' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">出海绩效(A)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTypea" name="salaryTypea" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div style="display: flex;margin-top: 30px">\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">浮动工资(B)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTypeb" name="salaryTypeb" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">基本工资(C)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTypec" name="salaryTypec" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div style="display: flex;margin-top: 30px">\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">机关岗位工资(D)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTyped" name="salaryTyped" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">其他1(E)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTypee" name="salaryTypee" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div style="display: flex;margin-top: 30px">\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">其他2(F)</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="salaryTypef" name="salaryTypef" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '        <div style="width: 50%">\n' +
                    '            <div class="layui-inline">\n' +
                    '                <label class="layui-form-label">备注</label>\n' +
                    '                <div class="layui-input-inline">\n' +
                    '                    <input  style="width: 200px" id="remarks" name="remarks" class="layui-input" type="text">\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</form>'
                ,
                success: function () {
                    form.render();
                    $.ajax({
                        url:'/code/getCode?parentNo=TYPE1',
                        type:'post',
                        dataType:'json',
                        data:{
                        },
                        success:function(res){
                            var arr=[];
                            var str
                            for(var i=0;i<res.obj.length;i++){

                                str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                            }
                            $('select[name="type11"]').append(str);
                            form.render('select');
                        }
                    })
                    $.ajax({
                        url:'/code/getCode?parentNo=TYPE2',
                        type:'post',
                        dataType:'json',
                        data:{
                        },
                        success:function(res){
                            var arr=[];
                            var str
                            for(var i=0;i<res.obj.length;i++){
                                str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                            }
                            $('select[name="type22"]').append(str);
                            form.render('select');
                        }
                    })

                },yes:function(){
                    if ($("#type11").val()==''||$("#type11").val()==undefined){
                        layer.msg('请选择一级分类！',{icon:0});
                        return false;
                    }
                    if ($("#type22").val()==''||$("#type22").val()==undefined){
                        layer.msg('请选择二级分类！',{icon:0});
                        return false;
                    }
                    if ($("#job33").val()==''||$("#job33").val()==undefined){
                        layer.msg('薪岗名称不能为空！',{icon:0});
                        return false;
                    }
                    $.ajax({
                        type: 'post',
                        url: '/WagesJobManage/insert',
                        dataType: 'json',
                        data: {
                            type1:$("#type11").val(),
                            type2:$("#type22").val(),
                            job:$("#job33").val(),
                            salaryTypea:$("#salaryTypea").val(),
                            salaryTypeb:$("#salaryTypeb").val(),
                            salaryTypec:$("#salaryTypec").val(),
                            salaryTyped:$("#salaryTyped").val(),
                            salaryTypee:$("#salaryTypee").val(),
                            salaryTypef:$("#salaryTypef").val(),
                            remarks:$("#remarks").val(),
                        },
                        success: function (json) {
                                var msg=json.msg
                                $.layerMsg({content: msg, icon: 1}, function () {
                                    layer.closeAll();
                                    location.reload();
                                })
                        }
                    })

                    layer.closeAll();
                }


            })
        })
        form.render()
        $.ajax({
            url:'/code/getCode?parentNo=TYPE1',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="type1"]').append(str);
                form.render('select');
            }
        })
        $.ajax({
            url:'/code/getCode?parentNo=TYPE2',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="type2"]').append(str);
                form.render('select');
            }
        })
        $('#search1').on("click",function () {

            var job = $("#job").val()
            var type1 = $("#type1").val()
            var type2 = $("#type2").val()
            table.render({
                elem: '#test1'
                , url:'/WagesJobManage/selectAll?job='+job+'&pageSize='+'10'+'&useflag='+true+'&type1='+type1+'&type2='+type2
                ,cols:[[
                    {field: 'type1Name', title: '一级分类',  }
                    , {field: 'type2Name',title: '二级分类', }
                    , {field: 'job', title: '薪岗名称',}
                    , {field: 'salaryTypea', title: '出海绩效(A)',}
                    , {field: 'salaryTypeb', title: '浮动工资(B)',}
                    , {field: 'salaryTypec', title: '基本工资(C)', }
                    , {field: 'salaryTyped', title: '机关岗位工资(D)', }
                    , {field: 'salaryTypee', title: '其他1(E)', }
                    , {field: 'salaryTypef',title: '其他2(F)', }
                    , {field: 'remarks',title: '备注', }
                    , {field: '', title: '操作',width:'12%', toolbar: '#barDemos',}
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
            , url: '/WagesJobManage/selectAll?pageSize='+'10'+'&useflag='+true
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'type1Name', title: '一级分类',  }
                , {field: 'type2Name',title: '二级分类', }
                , {field: 'job', title: '薪岗名称',}
                , {field: 'salaryTypea', title: '出海绩效(A)',}
                , {field: 'salaryTypeb', title: '浮动工资(B)',}
                , {field: 'salaryTypec', title: '基本工资(C)', }
                , {field: 'salaryTyped', title: '机关岗位工资(D)', }
                , {field: 'salaryTypee', title: '其他1(E)', }
                , {field: 'salaryTypef',title: '其他2(F)', }
                , {field: 'remarks',title: '备注', }
                , {field: '', title: '操作',width:'12%', toolbar: '#barDemos',}
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




        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if (obj.event === 'detail1') {
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/WagesJobManage/deleteById',
                        dataType: 'json',
                        data: {
                            jobManageId:data.jobManageId
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
            }else if(obj.event === 'detail2'){
                layer.open({
                    type: 1 //此处以iframe举例
                    , title: '查看'
                    , area: ['60%', '80%'],
                    offset:'50',
                    btn: ['确定', '取消'],
                    content: '<form class="layui-form" action="">\n' +
                        '<div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">一级分类</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  disabled="disabled" style="width: 200px" id="type1Name" name="type1Name" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">二级分类</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="type2Name" name="type2Name" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '</div>\n' +
                        '    <div style="display: flex;margin-top: 30px" >\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">薪岗名称</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="job1" name="job1" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">出海绩效(A)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTypea" name="salaryTypea" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">浮动工资(B)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTypeb" name="salaryTypeb" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">基本工资(C)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTypec" name="salaryTypec" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">机关岗位工资(D)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTyped" name="salaryTyped" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">其他1(E)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTypee" name="salaryTypee" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">其他2(F)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="salaryTypef" name="salaryTypef" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">备注</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input disabled="disabled" style="width: 200px" id="remarks" name="remarks" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>'
                    ,
                    success: function () {
                        form.render();
                        $.ajax({
                            type: 'post',
                            url: '/WagesJobManage/selectById',
                            dataType: 'json',
                            data: {
                                jobManageId: data.jobManageId
                            },
                            success: function (json) {
                                $('#salaryTypea').val(json.object.salaryTypea)
                                $('#salaryTypeb').val(json.object.salaryTypeb)
                                $('#salaryTypec').val(json.object.salaryTypec)
                                $('#salaryTyped').val(json.object.salaryTyped)
                                $('#salaryTypee').val(json.object.salaryTypee)
                                $('#salaryTypef').val(json.object.salaryTypef)
                                $('#remarks').val(json.object.remarks)
                                $('#job1').val(json.object.job)
                                $('#type2Name').val(json.object.type2Name)
                                $('#type1Name').val(json.object.type1Name)
                            }
                        })

                    },yes:function(){
                        layer.closeAll();
                    }


                })
            }else if(obj.event === 'detail3'){
                layer.open({
                    type: 1 //此处以iframe举例
                    , title: '编辑'
                    , area: ['60%', '80%'],
                    offset:'50',
                    btn: ['确定', '取消'],
                    content: '<form class="layui-form" action="">\n' +
                        '<div style="display: flex;margin-top: 30px">\n' +
                        '    <div style="width: 50%">\n' +
                        '        <div class="layui-inline">\n' +
                        '            <label class="layui-form-label">一级分类</label>\n' +
                        '            <div class="layui-input-inline">\n' +
                        '<select id="type1111" name="type1111" class="type1111">\n' +
                        '<option value="">请选择</option>' +
                        '                    </select>' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="width: 50%">\n' +
                        '        <div class="layui-inline">\n' +
                        '            <label class="layui-form-label">二级分类</label>\n' +
                        '            <div class="layui-input-inline">\n' +
                        '<select id="type2222" name="type2222" class="type2222">\n' +
                        '<option value="">请选择</option>' +
                        '                    </select>' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '    <div style="display: flex;margin-top: 30px" >\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">薪岗名称</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        ' <input  style="width: 200px" id="job2" name="job2" class="layui-input" type="text">' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">出海绩效(A)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTypea" name="salaryTypea" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">浮动工资(B)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTypeb" name="salaryTypeb" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">基本工资(C)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTypec" name="salaryTypec" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">机关岗位工资(D)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTyped" name="salaryTyped" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">其他1(E)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTypee" name="salaryTypee" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div style="display: flex;margin-top: 30px">\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">其他2(F)</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="salaryTypef" name="salaryTypef" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div style="width: 50%">\n' +
                        '            <div class="layui-inline">\n' +
                        '                <label class="layui-form-label">备注</label>\n' +
                        '                <div class="layui-input-inline">\n' +
                        '                    <input  style="width: 200px" id="remarks" name="remarks" class="layui-input" type="text">\n' +
                        '                </div>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>'
                    ,
                    success: function () {
                        form.render();
                        $.ajax({
                            url:'/code/getCode?parentNo=TYPE1',
                            type:'post',
                            dataType:'json',
                            data:{
                            },
                            success:function(res){
                                var arr=[];
                                var str
                                for(var i=0;i<res.obj.length;i++){

                                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                                }
                                $('select[name="type1111"]').append(str);
                                form.render('select');
                            }
                        })
                        $.ajax({
                            url:'/code/getCode?parentNo=TYPE2',
                            type:'post',
                            dataType:'json',
                            data:{
                            },
                            success:function(res){
                                var arr=[];
                                var str
                                for(var i=0;i<res.obj.length;i++){
                                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                                }
                                $('select[name="type2222"]').append(str);
                                form.render('select');
                            }
                        })
                        $.ajax({
                            type: 'post',
                            url: '/WagesJobManage/selectById',
                            dataType: 'json',
                            data: {
                                jobManageId: data.jobManageId
                            },
                            success: function (json) {
                                $('#salaryTypea').val(json.object.salaryTypea)
                                $('#salaryTypeb').val(json.object.salaryTypeb)
                                $('#salaryTypec').val(json.object.salaryTypec)
                                $('#salaryTyped').val(json.object.salaryTyped)
                                $('#salaryTypee').val(json.object.salaryTypee)
                                $('#salaryTypef').val(json.object.salaryTypef)
                                $('#remarks').val(json.object.remarks)
                                $('#job2').val(json.object.job)
                                $('#type1111').find('option[value="'+json.object.type1+'"]').attr('selected',true);
                                $('#type2222').find('option[value="'+json.object.type2+'"]').attr('selected',true);
                                form.render('select');
                                form.render();
                            }
                        })
                    },yes:function(){
                        $.ajax({
                            type: 'post',
                            url: '/WagesJobManage/update',
                            dataType: 'json',
                            data: {
                                jobManageId:data.jobManageId,
                                type1:$("#type1111").val(),
                                type2:$("#type2222").val(),
                                job:$("#job2").val(),
                                salaryTypea:$("#salaryTypea").val(),
                                salaryTypeb:$("#salaryTypeb").val(),
                                salaryTypec:$("#salaryTypec").val(),
                                salaryTyped:$("#salaryTyped").val(),
                                salaryTypee:$("#salaryTypee").val(),
                                salaryTypef:$("#salaryTypef").val(),
                                remarks:$("#remarks").val(),
                            },
                            success: function (json) {
                                var msg=json.msg
                                $.layerMsg({content: msg, icon: 1}, function () {
                                    layer.closeAll();
                                    location.reload();
                                })
                            }
                        })

                        layer.closeAll();
                    }


                })
            }

        })


    });


</script>
</html>




