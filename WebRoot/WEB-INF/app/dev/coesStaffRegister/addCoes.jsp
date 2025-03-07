<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2022/11/4
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <style>
        .container div {
            margin: 10px auto;
        }
        .layui-form-label {
            line-height: 38px;
            text-align: left;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <label class="layui-form-label">姓名:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="name" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">手机号码:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="mobilNo" autocomplete="off" maxlength="11" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">身份证号码:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="idNumber" autocomplete="off" maxlength="18" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">单位:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <select name="company" id="company" required lay-verify="required" style="font-size: 16px;width: 200px;height:38px;" autocomplete="off" title="单位" >
                <option value="局机关">局机关</option>
                <option value="救捞工程船队">救捞工程船队</option>
                <option value="救捞拖轮船队">救捞拖轮船队</option>
                <option value="三用船队">三用船队</option>
                <option value="中国海洋工程有限公司">中国海洋工程有限公司</option>
                <option value="研发中心">研发中心</option>
                <option value="制造基地">制造基地</option>
                <option value="保障中心">保障中心</option>
                <option value="外部单位">外部单位</option>
            </select>
        </div>
    </div>

    <div>
        <label class="layui-form-label">岗位:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="post" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">人员类型:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <select name="staffType" id="staffType" required lay-verify="required" style="width: 200px;height: 38px;" autocomplete="off" title="人员类型" >
                <option value="1">乘客</option>
                <option value="2">船员</option>
                <option value="3">工程人员</option>
            </select>
        </div>
    </div>

    <div>
        <label class="layui-form-label">房间号:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="roomNumber" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">登船地点:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="boardAddress" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">登船日期:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="boardTime" id="boardTime" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">船名/项目:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <select id="boatName" name="boatName" class="boatName" lay-verify="boatName" lay-filter="boatName" style="width: 200px;height: 38px;">
            </select>
        </div>
    </div>

</div>
<script>
    const info = new URL(location.href).searchParams;
    const qx = info.get('qx');
    layui.use(['form','laydate'],function() {
        const laydate = layui.laydate;
        const form = layui.form;
        laydate.render({
            elem: '#boardTime',
            trigger:"click",
            format:"yyyy-MM-dd HH:mm:ss",
            type:"datetime"
        });
    })
    if(qx == 1) {
        $.ajax({
            url:'/code/getCode?parentNo=COES_BOAT_NAME',
            type:'post',
            dataType:'json',
            success:function(res) {
                if(res.flag) {
                    const data = res.obj;
                    $('#boatName').empty();
                    let str = "<option value=''>请选择</option>";
                    for(let i = 0; i < data.length; i++) {
                        str += '<option value='+data[i].codeName+'>'+data[i].codeName+'</option>'
                    }
                    $('#boatName').html(str);
                }
            }
        })
    }else {
        $.ajax({
            url:"/coesStaffRegister/coesRegisterinset",
            success:function(res) {
                if(res.flag) {
                    const data = res.obj;
                    $('#boatName').empty();
                    let str = "<option value=''>请选择</option>";
                    for(let i = 0; i < data.length; i++) {
                        str += '<option value='+data[i]+'>'+data[i]+'</option>'
                    }
                    $('#boatName').html(str);
                }
            }
        })
    }
</script>
</body>
</html>
