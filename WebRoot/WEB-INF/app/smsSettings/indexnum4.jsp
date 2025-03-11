
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>被提醒权限</title>

    <style>
        .news{
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <style>

        .sendsave senduser{
            height: 30px;
            line-height:30px;
            width: auto;
            padding: 0 20px;
        }
        .btnSure{
            background-image: url(../../img/confirm.png);
            width: 70px;
            height: 28px;
            margin: 2px auto;
            line-height: 28px;
            cursor: pointer;
            position: absolute;
            left:40%;
            bottom: 47%
        }

        table{
            width: 70%;
            margin:0 auto;
           margin-top:25px;
        }

        .leftBox{
            width: 28%;
            float: left;
            display: inline-block;
            height: 150px;
            line-height: 150px;
            margin-top: 20px;
            font-size: 16px;
            font-weight: 400;
            color: #666;
            text-align: center;
        }
    </style>
</head>
<body style="background: #fff;position: relative">

<div class="maintop clearfix" style="">
    <p style="margin-left: 5px">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/wangguan.png" style="width: 25px;height: 24px;vertical-align: text-bottom;" alt="">
        <label>被提醒权限</label><%--内部接口配置--%>
    </p>

<%--<a  class="newsBtn newsBtntwo btnTheme " id="newBtn1" style="float: right;margin-right: 3%;margin-top: 5px;" href="javascript:void (0)" data-num="0"><img src="../../img/mywork/newbuildworjk.png" alt="" style="margin:-3px 0px 0px -8px;"><fmt:message code="global.lang.new" /></a>&lt;%&ndash;新建&ndash;%&gt;--%>
</div>

<div class="divtable" style="  position: relative; width: 620px;height: 250px; left:50%;top:70px;margin-left:-310px;  position: absolute; border:1px solid #C8C8CD;background:#fff;">
    <div class="leftBox">
        被提醒人员
    </div>
    <div style="width: 72%;float: left;display: inline-block">
        <textarea name="txt" id="remindPriv" user_id="" style="width: 350px;height: 150px; margin-top: 20px;"  class="sendsave senduser" disabled rows="3" cols="50"></textarea>
        <a style="margin-left: 10px;cursor: pointer;color: #0aa3e3;" id="adduesr">添加</a>
        <a style="margin-left: 10px;cursor: pointer;color: #0aa3e3;" id="del_user">清除</a>
    </div>
    <div class="btnSure" style=" left: 45%; bottom: 20px;" >
        <span style="margin-left: 32px;" id="okbtn">保存</span>
    </div>

</div>
</div>
</body>
<script type="text/javascript">

    //获取权限信息
    $(function () {
        $('#del_user').click(function(){ //清空人员
            $('#remindPriv').attr('user_id','');
            $('#remindPriv').val('');
        });

        $.ajax({
            url: '/sms2Priv/selectRemindPriv',
            dataType: 'json',
            success: function (data) {
                var str = '';
                var userids ='';
                for (var i = 0; i < data.obj.length;i++){
                    str+=data.obj[i].userName+",";
                     userids += data.obj[i].userId+",";
                    $('#remindPriv').attr('user_id',userids) || '',
                    $('#remindPriv').val(str);
                }
            }
        });
    })
    var user_id='';
    $(function () {
        $("#adduesr").click(function () {
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
            // user_id = 'remindPriv';
        });

        $("#okbtn").click(function () {
            $.ajax({
                type:'get',
                url: '/sms2Priv/upRemindPriv',
                dataType: 'json',
                data:{
                    // remindPriv:$('[id="remindPriv"]').val()
                    remindPriv:$('#remindPriv').attr('user_id') || '',
                },
                success: function (data) {
                    if (data.flag) {
                        layer.msg('<fmt:message code="netdisk.th.Success" />!', {icon: 6});

                    }
                }
            });

        });
    })
</script>
</html>
