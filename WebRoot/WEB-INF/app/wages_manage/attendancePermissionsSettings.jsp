<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/11/25
  Time: 13:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考勤权限设置</title>
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
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div>
    <h3 style="margin-left: 60px;margin-top: 50px;margin-bottom: 20px;font-size: 25px">考勤权限设置</h3>
    <div>
        <label class="layui-form-label">主管</label>
        <div class="layui-input-inline" style="width: 300px">
            <input type="text" name="userId" style="display: inline-block;width: 60%"  id="userId" lay-verify="required|phone" autocomplete="off" title="主管" class="layui-input jinyong mustEdit">
            <p class="deptAdd" style="display: inline-block;  margin-right: 20px;cursor:pointer;color: #0000FF">添加</p><p id="deptClear" class="deptClear" style="display: inline-block;cursor:pointer;color: #0000FF">清空</p>
        </div>
    </div>
    <div style="margin-top: 30px;">
        <label class="layui-form-label">下属员工</label>
        <div class="layui-input-inline">
            <textarea disabled="disabled" name="subordinateUserId" id="subordinateUserId" style="display: inline-block; width: 330px;height: 100px;"></textarea>
            <p class="deptAdds" style="display: inline-block;  margin-right: 20px;cursor:pointer;color: #0000FF">添加</p><p id="deptClears" class="deptClears" style="display: inline-block;cursor:pointer;color: #0000FF">清空</p>
        </div>
    </div>
    <div style="margin-top: 30px;">
        <label class="layui-form-label">下属部门</label>
        <div class="layui-input-inline">
            <textarea disabled="disabled" name="subordinateDeptId" id="subordinateDeptId" style="display: inline-block; width: 330px;height: 100px;"></textarea>
            <p class="deptAddss" style="display: inline-block;  margin-right: 20px;cursor:pointer;color: #0000FF">添加</p><p id="deptClearss" class="deptClearss" style="display: inline-block;cursor:pointer;color: #0000FF">清空</p>
        </div>
    </div>
    <button type="button" class="layui-btn layui-btn-sm save" style="margin-left: 240px;margin-top: 20px;">保存</button>
</div>

</body>
<script>
    var attendancePriv = $.GetRequest()['attendancePriv'] || '';
    var type = $.GetRequest()['type'] || '';
    if(attendancePriv != '' && attendancePriv != undefined){
        $.ajax({
            type:'post',
            url:'/AttendancePriv/selectAllAttendancePriv',
            dataType:'json',
            data:{'attendancePriv':attendancePriv},
            success: function (json) {
                $("input[name='userId']").val(json.obj[0].userName)
                $("input[name='userId']").attr('userId',json.obj[0].userId)
                $("textarea[name='subordinateUserId']").val(json.obj[0].subordinateUserName)
                $("textarea[name='subordinateUserId']").attr('subordinateUserId',json.obj[0].subordinateUserId)
                $("textarea[name='subordinateDeptId']").val(json.obj[0].subordinateDeptName)
                $("textarea[name='subordinateDeptId']").attr('subordinateDeptId',json.obj[0].subordinateDeptId)
            }
        })
    }
    $(document).on("click", ".deptAdd", function () {
        user_id="userId";
        $.popWindow("../common/selectUser");
    })
    $(document).on('click', '.deptClear', function () {
        var userId = $("[name='userId']");
        $(userId).val('');
        $('#userId').attr("user_id","");
        $('#userId').attr("username","");
        $('#userId').attr("userprivname","");
        $(userId).attr('dataid', '');
    });

    $(document).on("click", ".deptAdds", function () {
        user_id="subordinateUserId";
        $.popWindow("../common/selectUser");
    })
    $(document).on('click', '.deptClears', function () {
        var subordinateUserId = $("[name='subordinateUserId']");
        $(subordinateUserId).val('');
        $('#subordinateUserId').attr("user_id","");
        $('#subordinateUserId').attr("username","");
        $('#subordinateUserId').attr("userprivname","");
        $(subordinateUserId).attr('dataid', '');
    });

    // 获取部门信息控件
    $(".deptAddss").on("click",function(){
        dept_id="subordinateDeptId";
        $.popWindow("../common/selectDept");
    });
    // 清空部门信息
    $('.deptClearss').on("click",function () {
        $('#subordinateDeptId').attr("deptid","");
        $('#subordinateDeptId').attr("deptno","");
        $('#subordinateDeptId').attr("deptname","");
        $('#subordinateDeptId').val("");
    });
    if(type == 0){
        $(document).on('click','.save',function(){
            var wagesAttendancePriv = {}
            wagesAttendancePriv.userId = $("input[name='userId']").attr('user_id')
            wagesAttendancePriv.subordinateUserId = $("textarea[name='subordinateUserId']").attr('user_id')
            wagesAttendancePriv.subordinateDeptId = $("textarea[name='subordinateDeptId']").attr('deptid')

            $.ajax({
                url:'/AttendancePriv/addAttendancePriv',
                data: wagesAttendancePriv,
                type: 'post',
                success:function(res){
                    if(res.flag == true){
                        // window.history.back()
                        window.open('/wages/attendancePermissions','_self');
                        layer.msg('修改成功！',{icon:1});
                    }else{
                        layer.msg('修改失败！',{icon:2});
                    }
                }
            })
        })
    }else if (type == 1){
        $(document).on('click','.save',function(){
            var wagesAttendancePriv = {}
            wagesAttendancePriv.userId = $("input[name='userId']").attr('user_id')
            wagesAttendancePriv.subordinateUserId = $("textarea[name='subordinateUserId']").attr('user_id')
            wagesAttendancePriv.subordinateDeptId = $("textarea[name='subordinateDeptId']").attr('deptid')
            wagesAttendancePriv.attendancePriv = attendancePriv

            $.ajax({
                url:'/AttendancePriv/updateAttendancePriv',
                data: wagesAttendancePriv,
                type: 'post',
                success:function(res){
                    if(res.flag == true){
                        layer.msg('修改成功！',{icon:1});
                        window.open('/wages/attendancePermissions','_self');
                        // window.history.back()
                    }else{
                        layer.msg('修改失败！',{icon:2});
                    }
                }
            })
        })
    }

</script>
</html>
