<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>动态密码卡管理</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/laydate/skins/default/laydate.css">
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>

    <style>
        * {font-family: "Microsoft Yahei" !important;}
        body{
            background-color: #F5F7F8
        }
        .header{
            position: relative;
            margin-top: 15px;
            height: 40px;
        }
        .header .title{
            margin-left: 22px;
        }
        .sales{
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
            margin-right: 23px;
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
        .queries{
            height: 40px;
        }
        #pageTbody tr{
            height: 40px;
        }
        #pageTbody tr td{
            text-align: center;
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
            margin-right: -25px;
        }
        strong{
            font-size: 12pt;
            line-height: 16px;
        }
        .newNews{
            margin-top: 10px;
        }
        .span_btn span{
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            color: #2B7FE0;
        }
        .page-top-outer-layer{
            width: 990px!important;
        }
        .page-top-outer-layer table{
            width: 990px!important;
        }
        .page-bottom-outer-layer{
            width: 990px!important;
        }
        .page-bottom-outer-layer table{
            width: 990px!important;
        }
        /*tr{*/
        /*    text-align:center;*/
        /*}*/
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<!--head开始-->
<div class="header">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png"><span class="sales">动态密码卡管理</span>
        <div id="Confidential" style="display: inline-block"></div>
    </div>

    <div style="position: absolute; right: 50px; top: 0;">
        <div class="queries">
            <button  type="button" class="one" id="binding" style="width: 120px" onclick="javascript:window.location.href='/secureKey/bulkBinding';">
                批量绑定
            </button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button  type="button" class="one" id="message" style="width: 120px;" onclick="javascript:window.location.href='/secureKey/insertImportCard';">
                导入卡信息
            </button>
        </div>
    </div>
</div>
<div id="pagediv">

</div>
</body>
<script>
    var pageObj;
    $(function () {
        var screenwidth = document.documentElement.clientWidth;
        if (screenwidth  > 2000) {
            var nums = screenwidth * 0.97;
            var sumwidth = screenwidth * 0.97 + 'px';
        } else {
            var nums = 890;
            var sumwidth = '890px';
        }
        var width0 = nums * 0.025 + 'px';
        var width1 = nums * 0.045 + 'px';
        var width2 = nums * 0.045 + 'px';
        var width3 = nums * 0.075 + 'px';
        var width4 = nums * 0.095 + 'px';
        var width5 = nums * 0.040 + 'px';
        //表格初始化
        pageObj=$.tablePage('#pagediv',sumwidth,[
            {
                width:width0,
                title:'选择',
                name:'checkbox',
                selectFun:function (n,obj) {
                    return '<input type="checkbox"  name="checkbox" uid="'+obj.uid+'" keySn="'+obj.keySn+'"/>'
                }
            },
            {
                width:width1,
                title:'卡号',
                name:'keySn',
            },
            {
                width:width2,
                title:'用户',
                name:'userName',
            },
            {
                width:width3,
                title:'部门',
                name:'deptName',
            },
            {
                width:width4,
                title:'数据',
                name:'keyInfo',

            },
            {
                width:width5,
                title:'操作',
                name:'orgAddress'
            }
        ],function (me) {
//          me.obj.codeId=$('[name="type"]').val();
            me.data.pageSize=10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init('/secureKey/SelectSecureKeyInfo',[
                {
                    name:'绑定用户',
                    fn:function(obj) {
                        if (obj.userName !=undefined) {
                            return '';
                        } else {
                            return '绑定用户';
                        }
                    }
                },
                {name:'同步'},

            ],function () {
                var str='<tr>' +
                    '<td style="width: 400px;text-align: left;"><input type="checkbox" name="all"><span style="color: black;cursor:pointer;">'+notice_th_allchose+'</span></td>'+
                    '<td colspan="5" style="text-align: left">'+
                    '<a class="notice_notop span_btn"><span style="cursor:pointer;">删除</span></a>'+
                    '<a class="delete_check span_btn"><span style="margin-left: 27px;cursor:pointer;" >解除绑定</span></a>'+
                    '</td>'+
                    '</tr>';
                $('#operation').html(str)
                //删除
                $('.notice_notop').on("click",function () {
                    var keySn = "";
                    var keySns='';
                    $("input[type='checkbox']:checked").each(function () {
                        var keySn =$(this).attr('keySn');
//                        多选操作
//                        keySns += keySn + ",";
                        keySns+=keySn;
                    });
                    if (keySns== '') {
                        $.layerMsg({content: '<fmt:message  code="meet.th.PleaseDelete"/>', icon: 0});
                    } else {
                        layer.confirm('<fmt:message  code="global.lang.sure"/>', {
                            btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                            title: " <fmt:message  code="notice.th.DeleteFile"/>"
                        }, function () {
                            //确定删除，调接口
                            $.ajax({
                                type: 'post',
                                url: '/secureKey/deleteSecureKeyInfo',
                                dataType: 'json',
                                data: {'keySn': keySns},
                                success: function () {
                                    layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                                    window.location.reload();
                                }
                            })
                        }, function () {
                            layer.closeAll();
                        });
                    }
                });

                //解除绑定
                $('.delete_check').on("click",function () {
                    var cardNumber='';
                    var uid = "";
                    var uids='';
                    $("input[type='checkbox']:checked").each(function () {
                        var uid =$(this).attr('uid');
//                        多选操作
                        if(uid!='undefined'){
//                           uids += uid + ",";
                            uids+=uid
                        }
                    });
                    if (uids== '') {
                        $.layerMsg({content: '请选择要解除绑定的数据', icon: 0});
                    } else {
                        layer.confirm('是否解除绑定', {
                            btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                            title: "解除绑定"
                        }, function () {
                            $.ajax({
                                type: 'post',
                                url: '/user/bindUserInfo',
                                dataType: 'json',
                                data: {
                                    uid:uids,
                                    cardNumber:''
                                },
                                success: function () {
                                    layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                                    window.location.reload();
                                }
                            })
                        }, function () {
                            layer.closeAll();
                        });
                    }
                });


            });
        });


        $('#pagediv').on('click','[name="all"]',function(){//全选
            if($(this).is(':checked')){
                $('#pageTbody').find('input[type=checkbox]').prop('checked',true)
            }else {
                $('#pageTbody').find('input[type=checkbox]').removeProp('checked')
            }
        })
        $('#pageTbody').on('click','.editAndDelete0',function(){
            var cardNumber = pageObj.arrs[$(this).parent().find('.editAndDelete0').attr('data-i')].keySn;
            layer.open({
                type: 1,
                title:['绑定用户', 'background-color:#2b7fe0;color:#fff;'],
                area: ['430px', '170px'],
//                shadeClose: false, //点击遮罩关闭
                content:'<table class="newNews" ><tbody><tr style="border: none"><td class="blue_text" style="width: 140px;padding-left:20px">请选择要绑定的用户: </td>' +
                '<td> <textarea name="textUser" id="textUser" style="width: 200px;height: 30px" disabled></textarea>' +
                '<a href="javascript:;" class="governor" id="add">添加</a>' +
                '</td></tr></tbody></table>',
                btn:['确定','取消'],
                yes:function(){
//                    var name = $.trim($('#category_name').val());
                    $.post(
                        '/user/bindUserInfo',
                        {
                            uid:$('#textUser').attr('dataid').replace(/,/g, ""),
                            cardNumber:cardNumber
                        },
                        function(data){
                            // console.log(data);return;
                            if(data.flag){
                                layer.closeAll();
                                layer.msg("绑定成功", {icon: 6, time:1000});
                                pageObj.init();
                            }else{
                                layer.msg(data.msg, {icon: 7, time:1000});return;
                            }
                        }
                    );
                },
                btn2:function(){
                    layer.close();
                }
            });
            $("#add").on("click",function(){
                user_id = 'textUser';
                $.popWindow("../common/selectUser?0");
            });
        });

        $('#pageTbody').on('click','.editAndDelete1',function(){
            var keySn = pageObj.arrs[$(this).attr('data-i')].keySn;
            layer.open({
                type: 1,
                title:['动态密码卡同步', 'background-color:#2b7fe0;color:#fff;'],
                area: ['430px', '170px'],
//                shadeClose: false, //点击遮罩关闭
                content:'<table class="newNews" ><tbody><tr style="border: none"><td class="blue_text" style="width: 140px;padding-left:20px">请输入动态密码: </td>' +
                '<td> <textarea name="textUser" id="sdh" style="width: 200px;height: 30px"></textarea>' +
                '</td></tr></tbody></table>',
                btn:['确定','取消'],
                yes:function(){
                    var dynPassword = $('#sdh').val();
                    $.post(
                        '/secureKey/user/passwordsyn',
                        {
                            keySn:keySn,
                            dynPassword:dynPassword
                        },
                        function(data){
//                            if(data.flag){
                                layer.closeAll();
                                layer.msg(data.msg, {icon: 0, time:1000});
                                pageObj.init();
//                            }else{
//                                layer.msg("输入的动态密码错误", {icon: 7, time:3000});return;
//                            }
                        }
                    );
                },
                btn2:function(){
                    layer.close();
                }
            });
        })
        $(".layui-layer-setwin").remove();
    });
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>

</html>
