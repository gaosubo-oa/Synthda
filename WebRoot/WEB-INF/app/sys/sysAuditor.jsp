<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/3/28
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统安全审计员</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js?20230216.2"></script>
    <style>
        html,body {
            width: 100%;
        }
        .header {
            height: 45px;
            background-color: #fff;
            padding: 10px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .header .nav {
            height: 100%;
            display: flex;
            align-items: center;
        }
        .nav li {
            height: 28px;
        }
        .nav li .pad {
            padding: 7px;
        }
        .pad.select {
            background-color: #2F8AE3;
            color: #fff;
            border-radius: 8px;
        }
        .pad.journal {
            border-radius: 8px;
        }
        .pad.setting {
            border-radius: 8px;
        }
        .space{
            width:2px;
        }
        h1{
            line-height: 45px;
            font-size: 22px;
        }
        .seePas:hover {
            color: #2F8AE3;
        }
        .seePas {
            cursor: pointer;
        }
        .saveBtn{
            width: 70px;
            height: 28px;
            margin: 0 auto;
            line-height: 28px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            background: url("../../img/confirm.png") no-repeat;
        }
    </style>
</head>
<body>
<div class="header">
    <ul class="nav">
<%--        <li style="margin-left: 4px" id="journal">--%>
<%--            <span class="pad journal select">重置密码</span>--%>
<%--            <img class="space" src="../../img/twoth.png" alt="">--%>
<%--        </li>--%>
        <li style="margin-left: 4px" id="journal1">
            <span class="pad journal select">审计日志</span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
    </ul>
</div>
<hr style="margin-top: 0">
<%--<div class="box content0" style="display: block;">--%>
<%--    <h1 style="height: 80px;line-height: 80px;">--%>
<%--        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">--%>
<%--        重置密码--%>
<%--    </h1>--%>
<%--    <div class="content">--%>
<%--        <div class="respas" style="width: 800px;margin: 30px auto;text-align: center;">--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--&lt;%&ndash;                    <label class="layui-form-label" style="width: 180px;">重置系统安全保密员密码：</label>&ndash;%&gt;--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <select name="setPas" id="setPas" style="width: 100%; margin: 20px 0;height: 35px;">--%>
<%--                            <option value="0">重置系统安全保密员密码</option>--%>
<%--                            <option value="1">重置系统安全管理员密码</option>--%>
<%--                        </select>--%>
<%--                        <input type="password" name="pasVal" autocomplete="off" class="layui-input setPas" style="display: inline-block;width: 335px;">--%>
<%--                        <span style="font-size: 12px;" class="seePas">查看密码</span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">上传附件：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <form method="post" action="/upload?module=sys">       <div class="layui-form-item" style="text-align: left;">--%>
<%--                            <input type="file" multiple="multiple" name="file"  id="fileInp" style="border:none; display:inline-block; cursor:pointer;width: 70px;">--%>
<%--                        </div>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">附件信息：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <table style="margin: 0;border: none;"><tr class="Attachment" style="border:none;">--%>
<%--                            <td style="border:none;" width="75%"   class="files" id="files_txt">--%>
<%--                                <div id="fileContent"></div>--%>
<%--                            </td>--%>
<%--                        </tr></table>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-form-item">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="width: 180px;">变更原因：</label>--%>
<%--                    <div class="layui-input-inline" style="width: 400px;">--%>
<%--                        <textarea name="reason" lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <button class="layui-btn savePasBtn">确定</button>--%>
<%--        </div>--%>

<%--    </div>--%>
<%--</div>--%>
<div class="box content0">
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/theme1/auditLog.png" style="width: 25px;margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        安全审计日志表
    </h1>
    <div class="content">
        <div class="layui-inline">
            <label class="layui-form-label">用户:</label>
            <div class="layui-input-inline" style="width: 212px;">
                <input type="text" id="userId" name="userId" utocomplete="off" class="layui-input" style="width: 150px;display: inline-block;">
                <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type="user">添加</a>
                <a href="javascript:;" class="cleardate">清空</a>

            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">操作类型:</label>
            <div class="layui-input-inline" style="width: 150px;">
                <select name="type" lay-verify="" style="width: 150px;height: 38px; border: 1px solid #ccc;">
                    <option value="">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">日期范围</label>
            <div class="layui-input-inline" style="width: 150px;">
                <input type="text" id="beginTime" name="beginTime" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">-</div>
            <div class="layui-input-inline" style="width: 150px;">
                <input type="text" id="endTime" name="endTime"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <button class="layui-btn searchBtn">查询</button>
        <button class="layui-btn exportBtn">导出</button>
        <table id="demo1" lay-filter="test"></table>
    </div>
</div>
<script>
    renderLogType();
    auditLog();
    var moduleId = 12;
<%--    渲染日志类型--%>
    function renderLogType() {
        $.ajax({
            url:"/sys/getLogType",
            success:function(res) {
                var data = res.obj;
                var result = data.map(function(it) {
                    return '<option value="'+it.codeNo+'">'+it.codeName+'</option>'
                }).join("")
                $('[name=type]').append(result)
            }
        })
    }

$('.addControls').click(function () {
    user_id = $(this).siblings('input').prop('id');
    $.ajax({
        url:'/imfriends/getIsFriends',
        type:'get',
        dataType:'json',
        success:function(obj){
            if(obj.object == 1){
                $.popWindow("/common/selectUserIMAddGroup?0");
            }else{
                $.popWindow("/common/selectUser?0");
            }
        },
        error:function(res){
            $.popWindow("/common/selectUser?0");
        }
    })
})
$(document).on('click','.cleardate',function () {
    $(this).siblings('input').val('');
    $(this).siblings('input').attr('user_id','');
    $(this).siblings('input').attr('dataid','');
    $(this).siblings('input').attr('username','');

    $(this).siblings('input').attr('deptid','');
    $(this).siblings('input').attr('deptname','');

    $(this).siblings('input').attr('privid','');
    $(this).siblings('input').attr('userpriv','');
    $(this).siblings('input').attr('userprivname','');
})
//查询按钮点击事件
$('.searchBtn').on("click",function() {
    auditLog({
        type:$('[name=type]').val() || "",
        userId: $('#userId').attr("user_id") || "",
        beginTime:$('#beginTime').val() || "",
        endTime:$('#endTime').val() || "",
        useFlag: true
    })
})
//导出按钮点击事件
$(".exportBtn").on("click",function() {
    var type= $('[name=type]').val() || "";
    var userId = $('#userId').attr("user_id") || "";
    var beginTime = $('#beginTime').val() || "";
    var endTime = $('#endTime').val() || "";
    window.location.href = '/securityLog/querySecurityLog?type='+type+'&userId='+userId+'&beginTime='+beginTime+'&endTime='+endTime+'&export=1'+'&useFlag=false';
})

//渲染日期选择器
layui.use(['laydate'],function() {
    var laydate = layui.laydate;
    laydate.render({
        elem:"#beginTime",
        type:"date",
        trigger:"click"
    })
    laydate.render({
        elem:"#endTime",
        type:"date",
        trigger:"click"
    })
})


    fileuploadFn('#fileInp',$('.Attachment td').eq(0));
    //附件删除
    $('#files_txt').on('click','.deImgs',function(){
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);
    })
    $('.nav').on("click","li",function() {
        const index = $(this).index();
        $('.box').hide();
        $('.content'+index).show();
    })
    $(".pad").on("click",function() {
        $('.pad').removeClass("select")
        $(this).addClass("select");
    })
    //审计日志点击事件
    $('#journal1').click(function(){
        renderLogType();
        auditLog();
    });
    //查看隐藏密码功能
    $('.seePas').on("click",function() {
        const type = $(this).siblings("input").attr("type");
        if(type == "password") {
            $(this).siblings("input").attr("type","text")
            $(this).text("隐藏密码")
        }else {
            $(this).siblings("input").attr("type","password")
            $(this).text("查看密码")
        }
    })
$("#setPas").on("change",function() {
    $('[name=pasVal]').val("");
    $("#files_txt .dech").remove();
    $('[name=reason]').val("");
})
    $(".savePasBtn").on("click",function() {
        let val = $("[name=pasVal]").val();
        if(!val) {
            layer.msg("密码不能为空",{icon:2})
            return
        }
        val = val.replaceAll(" ","");
       layer.confirm("确定修改密码吗",{icon:0,title:"提示"},function (index) {
           var approveUser = "";
           var attachmentId = [];
           var attachmentName = [];
           var doms = $('.inHidden');
           if(doms.length > 0) {
               for(var i = 0; i < doms.length; i++) {
                   attachmentId.push($(doms[i]).val().replaceAll(",",""))
                   attachmentName.push($(doms[i]).parents(".dech").attr("name1"))
               }
           }
           var reason = $('[name=reason]').val();
           if(attachmentId.length == 0 || attachmentName.length == 0) {
               layer.msg("请选择附件",{icon:2})
               return
           }
           if(!reason) {
               layer.msg("请填写原因",{icon:2})
               return
           }
           const opVal = $("#setPas").val();
           if(opVal == 0) {
               approveUser = "SECRECY"
           }else if(opVal == 1) {
               approveUser = "MANAGE"
           }
            $.ajax({
                url:"/securityApproval/updateApproveUserPass",
                async:false,
                data: {
                    approveUser:approveUser,
                    password:val,
                    attachmentId:attachmentId.join(","),
                    attachmentName:attachmentName.join(","),
                    reason:reason,
                },
                success:function(res) {
                    if(res.flag) {
                        layer.msg("密码修改成功",{icon:1},function() {
                            $('[name=pasVal]').val("");
                            $("#files_txt .dech").remove();
                            $('[name=reason]').val("");
                            layer.close(index)
                        })
                    }else {
                        layer.msg(res.msg,{icon:0},function() {
                            layer.close(index)
                        })
                        return
                    }

                }
            })

        })
    })

    function auditLog(where) {
        layui.use(['table', 'layer', 'form'], function () {
            var table = layui.table;
            var layer = layui.layer;
            var form = layui.form;
            where = where?where:{};
            //第一个实例
            const tableIns = table.render({
                elem: '#demo1',
                url: '/securityLog/querySecurityLog?useFlag=true', //数据接口
                page: true, //开启分页
                parseData: function (res) {
                    return {
                        code: 0,
                        msg: res.msg,
                        data: res.obj,
                        count: res.totleNum,
                    }
                },
                request:{
                    pageName:'page',
                    limitName:'pageSize'
                },
                where:where,
                cols: [[ //表头
                    {
                        field: 'logId', title: '日志ID',align:'center'
                    }
                    ,{
                        field: 'userId', title: '用户ID',align:'center'
                    }
                    , {
                        field: 'userName', title: '用户姓名',align:'center'
                    }
                    , {
                        field: 'time', title: '时间',align:'center'
                    }
                    , {
                        field: 'ip', title: 'IP地址',align:'center'
                    }
                    , {
                        field: 'typeName', title: '日志类型',align:'center'
                    }
                    , {
                        field: 'remark', title: '备注',align:'center'
                    }
                    , {
                        field: 'remark', title: '附件',align:'center',templet:function(d) {
                            var str = "";
                            if(d.attachmentList && d.attachmentList.length > 0) {
                                for(var i = 0; i < d.attachmentList.length; i++) {
                                    var item = d.attachmentList[i];
                                    str += '<a style="display: block;" href="/download?'+item.attUrl+'">'+item.attachName+'</a>'
                                }
                            }
                            return str;
                        }
                    }
                    , {
                        field: 'clientTypeName', title: '设备类型',align:'center'
                    }
                    , {
                        field: 'clientVersion', title: '版本号',align:'center'
                    }
                ]]
            });
        });
    }
</script>
</body>
</html>
