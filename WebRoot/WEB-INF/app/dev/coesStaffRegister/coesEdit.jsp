<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2022/9/23
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>人员登记编辑</title>
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
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
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
                <option value="">请选择</option>
            </select>
        </div>
    </div>

    <div>
        <label class="layui-form-label">离船地点:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="ashoreAddress" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">离船日期:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" name="ashoreTime" id="ashoreTime" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div>
        <label class="layui-form-label">在船天数:</label>
        <div class="layui-input-inline" style="width: 200px;">
            <input type="text" readonly name="boardDays" autocomplete="off" class="layui-input">
        </div>
    </div>
<%--<div class="footer" style="text-align: center">--%>
<%--    <button class="layui-btn" id="submitBtn">确认</button>--%>
<%--    <button class="layui-btn" id="closeBtn">取消</button>--%>
<%--</div>--%>
</div>
<script>
    layui.use(['form','laydate'],function() {
        var form = layui.form;
        var laydate = layui.laydate;
        var id = +location.search.split('=')[1];
        $.ajax({
            url:"/coesStaffRegister/toEditStaffRegister",
            dataType:"json",
            data:{
                id:id
            },
            success:function(res) {
                if(res.flag) {
                    var data = res.object;
                    laydate.render({
                        elem: '#boardTime',
                        value: data.boardTime,
                        trigger:"click",
                        format:"yyyy-MM-dd HH:mm:ss",
                        type:"datetime"
                    });
                    laydate.render({
                        elem: '#ashoreTime',
                        value: data.ashoreTime,
                        trigger:"click",
                        format:"yyyy-MM-dd HH:mm:ss",
                        type:"datetime"
                    });
                    $('input[name=name]').val(data.name);
                    $('input[name=mobilNo]').val(data.mobilNo);
                    $('input[name=idNumber]').val(data.idNumber);
                    var s1 = $('select[name=company] option');
                    s1.each(function(i,it) {
                        if($(it).text() == data.company) {
                            $(it).prop('selected',true)
                        }
                    })
                    $('input[name=roomNumber]').val(data.roomNumber);
                    $('input[name=boardAddress]').val(data.boardAddress);
                    $('input[name=boardTime]').val(data.boardTime);
                    var s2 = $('select[name=boatName] option');
                    s2.each(function(i,it) {
                        if($(it).text() == data.boatName) {
                            console.log(it)
                            $(it).prop('selected',true)
                        }
                    })
                    var s3 = $('select[name=staffType] option');
                    s3.each(function(i,it) {
                        if($(it).text() == data.boatName) {
                            $(it).prop('selected',true)
                        }
                    })
                    $('input[name=ashoreAddress]').val(data.ashoreAddress);
                    $('input[name=ashoreTime]').val(data.ashoreTime);
                    $('input[name=boardDays]').val(data.boardDays);
                    $('input[name=post]').val(data.post);
                }

            }
        })
//    获取船名信息
        $.ajax({
            url:'/code/getCode?parentNo=COES_BOAT_NAME',
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
                $('select[name="boatName"]').append(str);
                form.render('select');
            }
        })

    })

</script>
</body>
</html>
