<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>查看文件</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <style>
        .head{
            font-size: 22px;
            color: #494d59;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .head span{
            margin-left: 24px;
            margin-top: 10px;
        }
        .content_table {
            margin: 40px auto 0px auto;
            width: 88%;
        }
    </style>
</head>
<body>

<div class="head">
    <span>查看文件</span>
</div>

<div class="content">
    <table class="content_table">

    </table>
</div>

<script type="text/javascript">
    $(function () {
        var rollId = $.GetRequest().rollId;
        $.ajax({
            url: "selectById",
            data: {
                rollId: rollId
            },
            type: "get",
            success: function (res) {
                var str = '';
                if (res.flag) {
                    var object = res.object;
                    if(object.beginDate==undefined){
                        object.beginDate = '';
                    }
                    if(object.endDate==undefined){
                        object.endDate = '';
                    }
                    // 密级判断
                    if(object.secret==1){
                        object.secret = '普密';
                    }else if(object.secret==2){
                        object.secret = '绝密';
                    }else if(object.secret==3){
                        object.secret = '机密';
                    }else if(object.secret==4){
                        object.secret = '秘密';
                    }

                    // 借阅判断
                    if(object.borrow==1){
                        object.borrow = '是';
                    }else {
                        object.borrow = '否';
                    }

                    str += '<tr>' +
                        '   <td>文件号：</td><td>'+object.rollCode+'</td>' +
                        '<td>文件主题词：</td><td>'+object.rollName+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>文件标题：</td><td>'+object.roomName+'</td>' +
                        '<td>文件辅标题：</td><td>'+object.years+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>发文单位：</td><td>'+object.beginDate+'</td>' +
                        '<td>发文日期：</td><td>'+object.endDate+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>密级：</td><td>'+object.deptName+'</td>' +
                        '<td>紧急等级：</td><td>'+object.editDept+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>文件分类：</td><td>'+object.deadline+'</td>' +
                        '<td>公文类别：</td><td>'+object.secret+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>文件页数：</td><td>'+object.categoryNo+'</td>' +
                        ' <td>打印页数：</td><td>'+object.catalogNo+'</td>' +
                        ' </tr>' +
                        '<tr>' +
                        '<td>备注：</td><td colspan="3">'+object.remark+'</td>' +
                        '</tr>'+
                        '<tr>' +
                        '<td><div>关闭</div></td>' +
                        '</tr>'
                }
                $('.content_table').html(str);
            },
            dataType: "json"
        })
    })
</script>
</body>
</html>
