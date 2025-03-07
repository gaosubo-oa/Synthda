<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>效能监察管理密码设置</title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="/css/base.css" />
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    .btn{
        text-align: center;
    }
    .btn_ {
        width:100px;
        height: 40px;
        padding-left: 10px;
        margin-top:25px;
        font-size: 14px;
        cursor: pointer;
        background: url(/img/save.png) no-repeat;
    }
    .table{
        width:60%;
        margin:20px auto;
    }
    td{
        width:50%;
    }
    table,tr,td,th{
        border:1px solid #eee;
        border-collapse: collapse;
    }
    .th{
        height: 50px;
        line-height: 50px;
        text-align: center;
        border: 1px solid #eee;
        color: #2F5C8F;
        background: #ddd;
    }
    input{
        width:80%;
    }
    .left{
        width:30%;
    }
    .right{
        width:70%;
    }
</style>
<body>
<table class="table">
    <tr class="th">
        <th colspan="2" >效能监察管理密码设置</th>
    </tr>
    <tr>
        <td class="left">原密码:</td>
        <td class="right"><input type="password" id="oldpassword"></td>
    </tr>
    <tr>
        <td class="left">新密码:</td>
        <td class="right"><input type="password" id="newpassword" onblur="checkPassword()"></td>
    </tr>
    <tr>
        <td class="left">确认新密码:</td>
        <td class="right"><input type="password" id="newpassword1"></td>
    </tr>

</table>
<div class="btn"><button id="saveBtn"  class="btn_">修改</button></div>

</body>
<script>
    //点击保存

    function checkPassword(a){
        a = typeof a !== 'undefined' ?  a :$("#newpassword").val();
        var pwdReg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/;//8到16位数字与字母组合
        console.log(a)
        if(!pwdReg.test(a)){
            layer.msg('请输入8到16位数字与字母组合密码！', {icon: 2});
            return
        }

    }

    $("#saveBtn").click(function(){
        var oldpassword = $("#oldpassword").val();
        var newpassword =$("#newpassword").val();
        var newpassword1 =$("#newpassword1").val();
        if(newpassword!=newpassword1){
            layer.msg('两次输入的新密码不一致！', {icon: 2});
            return
        }
        checkPassword(newpassword);
        $.ajax({
            url:"/FlowPara/modifyPwd",
            type:"post",
            dataType:"json",
            data:{
                oldpassword:oldpassword,
                newpassword:newpassword

            },
            success:function(res){
                if(res.flag){

                    layer.msg("修改成功", {icon: 1});
                    $("#oldpassword").val("");
                    $("#newpassword").val("");
                    $("#newpassword1").val("");
                }else{
                    layer.msg(res.msg, {icon: 2});
                    $("#oldpassword").val("");

                }

            }
        })

    })

</script>
</html>