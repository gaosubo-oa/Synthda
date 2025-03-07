<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/10/12
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建机构权限设置</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

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
</head>
<body>
<form class="layui-form" lay-filter="formTest" action="" style="margin-top: 2%">
    <div class="layui-form-item">
        <label class="layui-form-label">授权类型</label>
        <div class="layui-input-inline">
            <select id="privType" name="privType">
                <option value="">查看</option>
                <option selected="">编辑</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">管理范围</label>
        <div class="layui-input-inline">
            <select id="privRange" name="privRange" lay-filter="privRange" >
                <option selected="" value="1">全部机构</option>
                <option value="2">自定义机构</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item" id="zdy" style="display: none">
        <label class="layui-form-label">自定义机构</label>
        <div class="layui-input-inline">
            <textarea name="orgIds" id="orgIds" style="display: inline-block; width: 330px;height: 100px;"></textarea>
            <p style="display: inline-block;margin-right: 20px;">添加</p><p style="display: inline-block">清空</p>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(人员)</label>
        <div class="layui-input-block" style="width: 500px">
            <input type="text"  id="rangeUserIds" name="rangeUserIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">
            <p class="select_party" style="display: inline-block;margin-right: 20px;">添加</p><p class="clear_party" style="display: inline-block">清空</p>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(角色)</label>
        <div class="layui-input-block" style="width: 500px">
            <input type="text" name="rangePrivIds" id="rangePrivIds" style="display: inline-block;width: 300px" lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">
            <p class="userPrivAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="userPrivClear" style="display: inline-block">清空</p>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 9px 10px;width: 100px">授权范围(部门)</label>
        <div class="layui-input-block" style="width: 500px">
            <input type="text" name="rangeDeptIds" id="rangeDeptIds" style="display: inline-block;width: 300px"  lay-verify="theme" autocomplete="off" placeholder="" class="layui-input">
            <p class="deptAdd" style="display: inline-block;margin-right: 20px;">添加</p><p class="deptClear" style="display: inline-block">清空</p>
        </div>
    </div>
</form>
</body>
<script>
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
        $(document).on("click", ".select_party", function () {
            org_id="rangeUserIds";
            $.popWindow("../common/selectPartyMember?0");
        })
        $(document).on('click', '.clear_party', function () {
            var moderatorId = $("[name='rangeUserIds']");
            $(moderatorId).val('');
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
        form.render();
    })
</script>
</html>
