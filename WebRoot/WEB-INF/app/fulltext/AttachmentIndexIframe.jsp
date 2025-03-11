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
<div id="test" style=" margin-top: 5%;">

</div>
<button type="button" class="layui-btn layui-btn-sm" id="save1" lay-event="search1" style="height: 30px;line-height: 30px;margin-left: 40%;margin-top: 40px">保存</button>
</body>
<script>

    var param = $.GetRequest();
    var x = param.x
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
        var privRange = ''

        var str = '<form class="layui-form" lay-filter="formTest" action="" style="margin-top: 2%">\n' +
            '    <div class="layui-form-item">\n' +
            '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px;margin-top: 50px;">授权范围(人员)</label>\n' +
            '        <div class="layui-input-block" style="width: 80%">\n' +
            '            <input type="text" disabled="disabled"  id="rangeUserIds" name="rangeUserIds" style="display: inline-block;width: 80%;height: 100px;    margin-top: 20px;"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
            '            <p class="select_party" style="display: inline-block;margin-right: 20px;">添加</p><p class="clear_party" style="display: inline-block">清空</p>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '    <div class="layui-form-item">\n' +
            '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px;margin-top: 50px;">授权范围(角色)</label>\n' +
            '        <div class="layui-input-block" style="width: 80%">\n' +
            '            <input type="text" disabled="disabled" name="rangePrivIds" id="rangePrivIds" style="display: inline-block;width: 80%;height: 100px;    margin-top: 20px;" lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
            '            <p class="userPrivAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="userPrivClear" style="display: inline-block">清空</p>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '    <div class="layui-form-item">\n' +
            '        <label class="layui-form-label" style="padding: 9px 10px;width: 100px;margin-top: 50px;">授权范围(部门)</label>\n' +
            '        <div class="layui-input-block" style="width: 80%">\n' +
            '            <input type="text" disabled="disabled" name="rangeDeptIds" id="rangeDeptIds" style="display: inline-block;width: 80%;height: 100px;    margin-top: 20px;"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">\n' +
            '            <p class="deptAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="deptClear" style="display: inline-block">清空</p>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '</form>'
        $("#test").append(str);


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


    });




    $('#save1').click(function () {
        var rangeUserIds= $('#rangeUserIds').attr('user_id');
        var rangePrivIds= $('#rangePrivIds').attr('privid');
        var rangeDeptIds= $('#rangeDeptIds').attr('deptid');
        $.ajax({
            url:'/attachPriv/update',
            type:'post',
            dataType:'json',
            data:{
                moduleId:x,
                userIds: rangeUserIds,
                privIds: rangePrivIds,
                deptIds: rangeDeptIds,
            },
            success:function(res){
                if(res.flag){
                    layer.msg('保存成功！', {icon: 1,time:1000}, function () {
                    })
                }else{
                    layer.msg('保存失败！', {icon: 0,time:1000}, function () {

                    })
                }
            }
        })
    })



    $.ajax({
        url:'/attachPriv/selectByModuleId',
        type:'post',
        dataType:'json',
        data:{
            moduleId:x,
        },
        success:function(res){
            $('#rangeUserIds').val(res.object.userNames?res.object.userNames:"")
            $('#rangeDeptIds').val(res.object.deptNames)
            $('#rangePrivIds').val(res.object.privNames)
            $('#rangePrivIds').attr("privid",res.object.privIds);
            $('#rangeUserIds').attr("user_id",res.object.userIds);
            $('#rangeDeptIds').attr("deptid",res.object.deptIds);
        }
    })
</script>
</html>

