<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>心通达OA</title>
    <link href="/lib/mui/mui/mui.css" rel="stylesheet"/>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="/lib/mui/mui/mui.min.js"></script>
    <style>

    .user-msg-role{
        font-size: 13px;
        color: #8f8f94;
    }
    .mui-card{
        margin:0px;
    }
    .mui-card-header:after, .mui-card-footer:before{
        height:0px;
    }
        .user-msg-name{
            font-size:16px;
            padding: 10px;
            font-weight: bold;
        }
    .user-msg-role,.user-msg-dept{
        margin: 5px 10px;

    }
        .user-msg-avatar{
            margin-left: 20px;
            float: left;
        }
    .mui-card-header.mui-card-media .mui-media-body{
        margin-left: 10px;
    }
    .mui-table-view-cell > a:not(.mui-btn){
        margin: -11px -28px;
    }
        .banben{
            margin-left: 30%;
            height: 10px;
            position: absolute;
            top: 85%;
            color: #4d4d4d;
            font-size: 15px;
        }
    .mui-card-header{
        font-size: 105px!important;
    }
    #zhuxiao{
        width: 90%;
        position: relative;
        top: -100px;
        left: -20px;
        float: right;
        background: #0b8aff;
        color: white;
        font-weight: bold;
    }
    </style>

    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750 * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>

</head>

<body style="background: rgb(247, 247, 247);">
<div class="top">
    <div class="mui-card">
        <!--页眉，放置标题-->
        <ul class="mui-card-header">

            <ul class="mui-card-header mui-card-media mui-table-view" style="    width: 100%;">
                <li class="mui-table-view-cell" style="position: relative;top: -100px;">
                    <%--<a class="mui-navigate-right">--%>
                        <img class="user-msg-avatar" src="/img/user/boy.png"/>

                        <div class="mui-media-body" style=" float: left;">

                            <span class="user-msg-name"></span>
                            <p class="user-msg-role"></p>
                            <p class="user-msg-dept"></p>
                        </div>
                    <%--</a>--%>
                </li>
            </ul>
        </ul>
    </div>
    <div><button type="button" class="layui-btn layui-btn-fluid" id="zhuxiao">注销</button></div>
    <div class="banben">版本号：<span class="bbNum"></span></div>
</div>

</body>

<script>
    $(function (){
        $("#zhuxiao").click(function (){
            $.ajax({
                url: '/logOut',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    if (obj.flag == true) {
                        window.parent.location.href = "/h5";
                    }
                }
            });
        })
    })
    $(function () {

        // 获取当前登陆用户信息
        mui.ajax('/user/getNowLoginUser',{
            data:{
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            timeout:5000,//超时时间设置为10秒；
            headers:{'Content-Type':'application/json'},
            success:function(res){
                if (res.flag) {
                    var data = res.object;

                    // 设置用户姓名
                    $('.user-msg-name').html(data.userName);
                    // 设置角色
                    $('.user-msg-role').html(data.userPrivName);
                    // 设置用户部门
                    $('.user-msg-dept').html(data.deptName);
                    // 设置头像
                    if (data.avatar != undefined && data.avatar != '') {
                        if (data.avatar == '1') {
                            $('.user-msg-avatar').attr('src', '/img/user/girl.png');
                        } else {
                            //$('.user-msg-avatar').attr('src', '/img/user/' + data.avatar);
                        }
                    } else {
                        if (data.sex == '1') {
                            $('.user-msg-avatar').attr('src', '/img/user/girl.png');
                        }
                    }

                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });

        //    获取版本号
        mui.ajax('../../sys/getSysMessage',{
            data:{
                queryType:'sysInfo',
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            timeout:5000,//超时时间设置为10秒；
            // headers:{'Content-Type':'application/json'},
            success:function(res){
                if (res.flag) {
                    $('.bbNum').html(res.object.softVersion)
                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });


    })

</script>
</html>