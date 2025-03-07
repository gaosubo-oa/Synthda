<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/10/12
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>机构权限设置</title>
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
    .title {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }
    #btn{
        margin-left: 30px;
        margin-top: 40px;
    }
    .layui-table-cell{
        text-align: center!important;
    }
</style>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <span class="title">机构权限设置</span>
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" type="button" id="btn" value="显示">新建权限</button>
            </div>
            <table class="layui-hide" id="test" lay-filter="test"></table>
        </div>
    </div>
</div>
<div>

</div>
</body>
<script id="barDemo" type="text/html">
    <div class="long">
        <a id="detail1" class="layui-btn layui-btn-xs" lay-event="detail" data-index="i">查看</a>
        <a id="change" class="layui-btn layui-btn-xs" lay-event="change" data-index="i" >编辑</a>
        <a id="del" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" data-index="i" >删除</a>
    </div>

</script>
<script>
    var rangeUserIds2='';
    var rangePrivIds2='';
    var rangeDeptIds2='';
    var orgIds2='';


    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {

        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()
var privRange=''
        var el;
        var meetTable=table.render({
            elem: '#test'
            , url: '/priv/selectPrivByCond?pageSize=10&useFlag=true'
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                , {field: '',width: '25%', title: '', }
                , {field: 'privTypeName',width: '15%', title: '权限类型', }
                , {field: 'rangeDeptNames',width: '15%', title: '授权部门', }
                , {field: 'rangePrivNames',width: '15%', title: '授权角色', }
                , {field: 'rangeUserNames',width: '15%', title: '授权人员', }
                , {field: 'privRange',width: '15%',title: '管理范围',}
                , {field: '', title: '操作',width: '20%', toolbar: '#barDemo',minWidth:200}
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


        table.on('tool(test)', function (obj) {

            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;


            if (obj.event === 'del') {
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/priv/deletePrivById',
                        dataType: 'json',
                        data: {
                            privId:data.privId
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
            }else if(obj.event === 'detail') {
                layer.open({
                    type:1,
                    title:'查看机构权限设置',
                    area:['40%','60%'],
                    btnAlign:'c',
                    content:'<form class="layui-form" lay-filter="formTest" action="" style="margin-top: 2%">\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权类型</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input type="text" disabled="disabled"  id="privType5" name="privType5" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '   <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">管理范围</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input type="text"  disabled="disabled" id="privRange5" name="privRange5" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item" id="zdy" >\n' +
                        '        <label class="layui-form-label">自定义机构</label>\n' +
                        '        <div class="layui-input-inline">\n' +
                        '            <textarea disabled="disabled" name="orgIds5" id="orgIds5" style="display: inline-block; width: 330px;height: 100px;"></textarea>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(人员)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input disabled="disabled" type="text"  id="rangeUserIds5" name="rangeUserIds5" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(角色)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input disabled="disabled" type="text" name="rangePrivIds5" id="rangePrivIds5" style="display: inline-block;width: 300px" lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(部门)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input disabled="disabled" type="text" name="rangeDeptIds5" id="rangeDeptIds5" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>',
                    success:function(obj){
                        form.render()


                        $.ajax({
                            url:'/priv/selectPrivByCond',
                            type:'post',
                            dataType:'json',
                            data:{
                                privId:data.privId,

                            },
                            success:function(res){
                                var data=res.obj
                                if(data[0].privRange=='全部机构'){
                                    var ads ='全部机构'
                                }else{
                                    var ads ='自定义机构'
                                }
                                    $('#privType5').val(data[0].privTypeName),
                                    $('#privRange5').val(ads),
                                    $('#orgIds5').val(data[0].orgNames),
                                    $('#rangeUserIds5').val(data[0].rangeUserNames),
                                    $('#rangePrivIds5').val(data[0].rangePrivNames),
                                        $('#rangeDeptIds5').val(data[0].rangeDeptNames)
                                if(ads=='全部机构'){
                                    $('#zdy').hide();
                                }

                            }
                        })

                    }
                })
            }else if (obj.event === 'change') {
                layer.open({
                    type:1,
                    title:'修改机构权限设置',
                    area:['40%','60%'],
                    btn:['提交','取消'],
                    btnAlign:'c',
                    content:'<form class="layui-form" lay-filter="formTest" action="" style="margin-top: 2%">\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label">授权类型</label>\n' +
                        '        <div class="layui-input-inline">\n' +
                        '            <select id="privType" name="privType">\n' +
                        '                <option value="1">查看</option>\n' +
                        '                <option value="2">编辑</option>\n' +
                        '            </select>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label">管理范围</label>\n' +
                        '        <div class="layui-input-inline">\n' +
                        '            <select id="privRange" name="privRange" lay-filter="privRange" >\n' +
                        '                <option value="1">全部机构</option>\n' +
                        '                <option value="2">自定义机构</option>\n' +
                        '            </select>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item" id="zdy" style="display: none">\n' +
                        '        <label class="layui-form-label">自定义机构</label>\n' +
                        '        <div class="layui-input-inline">\n' +
                        '            <textarea disabled="disabled" name="orgIds" id="orgIds" style="display: inline-block; width: 330px;height: 100px;"></textarea>\n' +
                        '            <p class="deptAdds" style="display: inline-block;  margin-right: 20px;">添加</p><p id="deptClears" class="deptClears" style="display: inline-block">清空</p>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(人员)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input type="text" disabled="disabled"  id="rangeUserIds" name="rangeUserIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '            <p class="select_party" style="display: inline-block;margin-right: 20px;">添加</p><p class="clear_party" style="display: inline-block">清空</p>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(角色)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input type="text" disabled="disabled" name="rangePrivIds" id="rangePrivIds" style="display: inline-block;width: 300px" lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '            <p class="userPrivAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="userPrivClear" style="display: inline-block">清空</p>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-form-item">\n' +
                        '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(部门)</label>\n' +
                        '        <div class="layui-input-block" style="width: 500px">\n' +
                        '            <input type="text" disabled="disabled" name="rangeDeptIds" id="rangeDeptIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                        '            <p class="deptAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="deptClear" style="display: inline-block">清空</p>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</form>',
                    success:function(obj){

                        layui.use(['form','laydate','eleTree'],function(){
                            var form=layui.form;
                            var laydate=layui.laydate;
                            var eleTree = layui.eleTree;
                            form.render()
                            var el;

                            form.on('select(privRange)', function(data){
                                console.log(data.value);
                                if(data.value == 2){
                                    $('#zdy').css('display','block')
                                    $('#orgIds').val("");
                                }else{
                                    $('#zdy').css('display','none')
                                }
                            });
                            $(".deptAdds").on("click",function(){
                                priv_id="orgIds";
                                $.popWindow("../EduorgMessage/selectOrg");
                            });
                            // 清空部门信息
                            $('.deptClears').click(function () {
                                $('#orgIds').attr("privid","");
                                $('#orgIds').val("");
                                $('#orgIds').attr("userpriv","");

                            });



                            $(document).on("click", ".select_party", function () {
                                user_id="rangeUserIds";
                                $.popWindow("../common/selectUser");
                            })
                            $(document).on('click', '.clear_party', function () {
                                var moderatorId = $("[name='rangeUserIds']");
                                $(moderatorId).val('');
                                $('#rangeUserIds').attr("user_id","");
                                $(moderatorId).attr('orgid', '');
                            });


                            // 获取角色信息控件
                            $(".userPrivAdd").on("click",function(){
                                priv_id="rangePrivIds";
                                $.popWindow("../common/selectPriv");
                            });
                            // 清空角色信息
                            $('.userPrivClear').click(function () {
                                $('#rangePrivIds').attr("privid","");
                                $('#rangePrivIds').attr("userpriv","");
                                $('#rangePrivIds').val("");
                            });

                            // 获取部门信息控件
                            $(".deptAdd").on("click",function(){
                                dept_id="rangeDeptIds";
                                $.popWindow("../common/selectDept");
                            });
                            // 清空部门信息
                            $('.deptClear').click(function () {
                                $('#rangeDeptIds').attr("deptid","");
                                $('#rangeDeptIds').attr("deptno","");
                                $('#rangeDeptIds').val("");
                            });
                        })
                        $.ajax({
                            url:'/priv/selectPrivByCond',
                            type:'post',
                            dataType:'json',
                            data:{
                                privId:data.privId,

                            },
                            success:function(res){
                                var data1=res.obj
                                var privid=data1[0].orgIds
                                var user_id=data1[0].rangeUserIds
                                var privid1=data1[0].rangePrivIds
                                var deptid=data1[0].rangeDeptIds
                                $("#orgIds").attr("privid",privid);
                                $("#orgIds").attr("userpriv",privid);
                                $("#rangeUserIds").attr("user_id",user_id);
                                $("#rangePrivIds").attr("privid",privid1);
                                $("#rangeDeptIds").attr("deptid",deptid);
                                $("#rangePrivIds").attr("userPriv",privid1);
                                form.render();

                                $('#privType').find('option[value="'+data1[0].privType+'"]').prop('selected',true);
                                if(data1[0].privRange=='全部机构'){
                                    $('#privRange').find('option[value="1"]').prop('selected','selected');
                                }else{
                                    $('#privRange').find('option[value="2"]').prop('selected','selected');
                                    $('#zdy').show();
                                }
                                form.render('select');
                                    $('#orgIds').val(data1[0].orgNames),
                                    $('#rangeUserIds').val(data1[0].rangeUserNames),
                                    $('#rangePrivIds').val(data1[0].rangePrivNames),
                                    $('#rangeDeptIds').val(data1[0].rangeDeptNames);


                            }
                        })
                    },
                    yes:function(){
                        form.render()
                        var cda1='';
                        if($("#privRange").val()=='1'){
                              cda1='全部机构'
                            orgIds2='';

                        }else {
                             cda1=$("#orgIds").val()
                            orgIds2= $('#orgIds').attr('privid');
                        }

                        rangeUserIds2= $('#rangeUserIds').attr('user_id');
                        rangePrivIds2= $('#rangePrivIds').attr('privid');
                        rangeDeptIds2= $('#rangeDeptIds').attr('deptid');

                        $.ajax({
                            url:'/priv/updatePrivById',
                            type:'post',
                            dataType:'json',
                            data:{
                                privId:data.privId,
                                privType:$("#privType").val(),
                                // privId: $("#privType").val(),
                                rangeUserNames: $("#rangeUserIds").val(),
                                rangePrivNames: $("#rangePrivIds").val(),
                                rangeDeptNames: $("#rangeDeptIds").val(),
                                privRange: cda1,
                                orgIds: orgIds2,
                                rangeUserIds: rangeUserIds2,
                                rangePrivIds: rangePrivIds2,
                                rangeDeptIds: rangeDeptIds2,

                            },
                            success:function(obj){
                                if(obj.flag){
                                    layer.closeAll();
                                    $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                        location.reload();
                                    })
                                }


                            }
                        })
                    }
                })
            }
        })
        $('#btn').click(function(){
            layer.open({
                type:1,
                title:'新建机构权限设置',
                area:['40%','60%'],
                btn:['提交','取消'],
                btnAlign:'c',
                content:'<form class="layui-form" lay-filter="formTest" action="" style="margin-top: 2%">\n' +
                    '    <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label">授权类型</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <select id="privType" name="privType">\n' +
                    '                <option value="1">查看</option>\n' +
                    '                <option  value="2">编辑</option>\n' +
                    '            </select>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label">管理范围</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <select id="privRange" name="privRange" lay-filter="privRange" >\n' +
                    '                <option value="1">全部机构</option>\n' +
                    '                <option value="2">自定义机构</option>\n' +
                    '            </select>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-form-item" id="zdy" style="display: none">\n' +
                    '        <label class="layui-form-label">自定义机构</label>\n' +
                    '        <div class="layui-input-inline">\n' +
                    '            <textarea disabled="disabled" name="orgIds" id="orgIds" style="display: inline-block; width: 330px;height: 100px;"></textarea>\n' +
                    '            <p class="deptAdds"  style="display: inline-block;margin-right: 20px;">添加</p><p  class="deptClears" style="display: inline-block">清空</p>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(人员)</label>\n' +
                    '        <div class="layui-input-block" style="width: 500px">\n' +
                    '            <input type="text" disabled="disabled"  id="rangeUserIds" name="rangeUserIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '            <p class="select_party" style="display: inline-block;margin-right: 20px;">添加</p><p class="clear_party" style="display: inline-block">清空</p>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(角色)</label>\n' +
                    '        <div class="layui-input-block" style="width: 500px">\n' +
                    '            <input type="text" disabled="disabled" name="rangePrivIds" id="rangePrivIds" style="display: inline-block;width: 300px" lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '            <p class="userPrivAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="userPrivClear" style="display: inline-block">清空</p>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-form-item">\n' +
                    '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(部门)</label>\n' +
                    '        <div class="layui-input-block" style="width: 500px">\n' +
                    '            <input type="text" disabled="disabled" name="rangeDeptIds" id="rangeDeptIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
                    '            <p class="deptAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="deptClear" style="display: inline-block">清空</p>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</form>',
                success: function (json) {
                    layui.use(['form','laydate','eleTree'],function(){
                        var form=layui.form;
                        var laydate=layui.laydate;
                        var eleTree = layui.eleTree;
                        form.render()
                        var el;

                        form.on('select(privRange)', function(data){
                            console.log(data.value);
                            if(data.value == 2){
                                $('#zdy').css('display','block')
                            }else{
                                $('#zdy').css('display','none')
                            }
                        });
                        $(".deptAdds").on("click",function(){
                            priv_id="orgIds";
                            $.popWindow("../EduorgMessage/selectOrg");
                        });
                        // 清空部门信息
                        $('.deptClears').click(function () {
                            $('#orgIds').attr("privid","");
                            $('#orgIds').val("");
                            $('#orgIds').attr("userpriv","");
                        });


                        $(document).on("click", ".select_party", function () {
                            user_id="rangeUserIds";
                            $.popWindow("../common/selectUser");
                        })
                        $(document).on('click', '.clear_party', function () {
                            var moderatorId = $("[name='rangeUserIds']");
                            $(rangeUserIds).val('');
                            $(rangeUserIds).attr('dataid', '');
                            $(rangeUserIds).attr('user_id', '');
                        });



                        // 获取角色信息控件
                        $(".userPrivAdd").on("click",function(){
                            priv_id="rangePrivIds";
                            $.popWindow("../common/selectPriv");
                        });
                        // 清空角色信息
                        $('.userPrivClear').click(function () {
                            $('#rangePrivIds').attr("privid","");
                            $('#rangePrivIds').attr("userpriv","");
                            $('#rangePrivIds').val("");
                        });

                        // 获取部门信息控件
                        $(".deptAdd").on("click",function(){
                            dept_id="rangeDeptIds";
                            $.popWindow("../common/selectDept");
                        });
                        // 清空部门信息
                        $('.deptClear').click(function () {
                            $('#rangeDeptIds').attr("deptid","");
                            $('#rangeDeptIds').attr("deptno","");
                            $('#rangeDeptIds').val("");
                        });

                        form.render();
                    })

                },
                yes:function(){
                    var cdac='';
                    if($("#privRange").val()=='1'){
                        cdac='全部机构'
                    }else
                    if($("#privRange").val()=='2'){
                        cdac=$("#orgIds").val()
                    }
                    var orgIds= $('#orgIds').attr('dept_id');
                    var rangeUserIds= $('#rangeUserIds').attr('user_id');
                    var rangePrivIds= $('#rangePrivIds').attr('privid');
                    var rangeDeptIds= $('#rangeDeptIds').attr('deptid');
                    var orgIds= $('#orgIds').attr('privid');
                    $.ajax({
                        url:'/priv/addPriv',
                        type:'post',
                        dataType:'json',
                        data:{
                            orgIds:orgIds,
                            // privType:$("#privType").find("option:selected").text(),
                            privType: $("#privType").val(),
                            rangeUserNames: $("#rangeUserIds").val(),
                            rangePrivNames: $("#rangePrivIds").val(),
                            rangeDeptNames: $("#rangeDeptIds").val(),
                            privRange: cdac,
                            orgIds: orgIds,
                            rangeUserIds: rangeUserIds,
                            rangePrivIds: rangePrivIds,
                            rangeDeptIds: rangeDeptIds,
                        },
                        success:function(obj){
                            if(obj.flag){
                                layer.closeAll();
                                $.layerMsg({content: '新建成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }


                        }
                    })
                }
            })
        })

    });
</script>
</html>
