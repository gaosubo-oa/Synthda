<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/11/29
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>考勤权限</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/laydate/skins/default/laydate.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <style>
        * {font-family: "Microsoft Yahei" !important;}
        .header{
            height: 40px;
        }
        .header .title{
            margin-left: 22px;
            margin-top: 20px;
        }
        .header span{
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }
        .content_label ul li{
            height: 16px;
            line-height: 16px;
            padding: 5px 12px;
            margin: 25px 0px;
            font-size: 15px;
            border-radius: 3px;
            display: inline;
        }
        .content_label ul{
            margin: 15px 0;
        }
        .pagediv table thead {
            background: white;
            line-height: 40px;
            border-bottom: 1px #dddddd solid;
            font-size: 13pt;
            color: #2F5C8F;
            font-weight: bold;
            height: 50px;
            border: 0px;
        }
        .pagediv tr:hover {
            background-color: #D3E7FA;
        }
        .pagediv tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
        .pagediv tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
        #pageTbody tr{
            height: 40px;
        }
        .index_content_1 .one{
            color: white;
            padding: 4px;
        }
        .index_content_2 .one{
            color: white;
            padding: 4px;
        }
        .one{
            width: 120px;
            height: 30px;
            border: none;
            color: #fff;
            cursor: pointer;
            padding: 5px;
        }
        .editAndDelete1{
            color: red;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<!--head开始-->
<div class="header">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png">
        <span style="">考勤权限设置</span>
        <button  type="button" class="one" id="add_btn" style="width: 120px;margin-left:10%" onclick="javascript:window.location.href='/wages/attendancePermissionsSettings?type=0';">
            <img src="../../img/mywork/newbuildworjk1.png" style="margin-right: 8px;margin-bottom: 2px;"/>新建
        </button>

    </div>
</div>

<div  style="overflow-x: hidden;">
        <table id="pagediv" style="width: 85%;">

        </table>

</div>

</body>
<script>
    $(function () {
        var screenwidth = document.documentElement.clientWidth;
        if (screenwidth  > 2200) {
            var nums = screenwidth * 0.97;
            var sumwidth = screenwidth * 0.97 + 'px';
        } else {
            var nums = 1000;
            var sumwidth = '1000px';
        }
        var width1 = nums * 0.055 + 'px';
        var width2 = nums * 0.075 + 'px';
        var width3 = nums * 0.025 + 'px';
        //表格数据初始化展示
        var pageObj = $.tablePage('#pagediv',sumwidth, [
            {
                width:'30%',
                title: '主管',
                name: 'userId',
                selectFun:function (n,obj) {
                    if(obj.userId==undefined){
                        return "";
                    }else{
                        return obj.userName;
                    }
                }
            },
            {
                width:'30%',
                title: '下属员工',
                name: 'subordinateUserId',
                selectFun:function (n,obj) {
                    if(obj.subordinateUserId==undefined){
                        return "";
                    }else{
                        return obj.subordinateUserName;
                    }
                }
            },
            {
                width:'20%',
                title: '下属部门',
                name: 'subordinateUserId',
                selectFun:function (n,obj) {
                    if(obj.subordinateDeptId==undefined){
                        return "";
                    }else{
                        return obj.subordinateDeptName;
                    }
                }
            },
            {
                width:'15%',
                title:'操作',
                name:'orgAddress'
            }
        ], function (me) {
            me.data.pageSize = 10;
            me.init('/AttendancePriv/selectAllAttendancePriv',[
                {name:'编辑'},
                {name:'删除'}
            ])
        })
        //       根据id修改数据
        $('#pageTbody').on('click','.editAndDelete0',function(){
            var attendancePriv = pageObj.arrs[$(this).attr('data-i')].attendancePriv;
            location.href = '/wages/attendancePermissionsSettings?type=1&attendancePriv='+attendancePriv;
        });
        //ajax 根据orgId 删除数据
        $('#pageTbody').on('click','.editAndDelete1',function(){
            var attendancePriv=0
            if(pageObj.arrs[$(this).attr('data-i')]!=undefined){
                attendancePriv=pageObj.arrs[$(this).attr('data-i')].attendancePriv;
            }
            layer.confirm(qued,{
                btn: [sure,cancel], //按钮
                title:'确定删除？'
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/AttendancePriv/deleteAttendancePriv',
                    dataType:'json',
                    data:{'attendancePriv':attendancePriv},
                    success: function (json) {
                        //第三方扩展皮肤
                        layer.msg('删除成功', {icon: 1});
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();

            })
        });
    });

</script>
</html>
