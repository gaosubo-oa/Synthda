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
    <title>权限设置</title>
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
        #pageTbody td{
            text-align: center!important;
        }
        .layui-form-label{
            float: none;
        }
        .layui-input-block{
            margin-left: 90px;
        }
        .page-top-outer-layer,.page-bottom-outer-layer
        .page-top-outer-layer table,.page-bottom-outer-layer table{
            width: 100%;
        }
        .pagediv .page-top-inner-layer{
            padding-right: 0;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<!--head开始-->
<div class="header">
    <div class="title" style="position: relative">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png">
        <span style="">权限设置（主管可以查看下属员工的工资、奖金数据）</span>
        <button  type="button" class="one" id="add_btn" style="width: 120px;position: absolute;right: 150px" onclick="javascript:window.location.href='/bonusPriv/personAdd';">
            <img src="../../img/mywork/newbuildworjk1.png" style="margin-right: 8px;margin-bottom: 2px;"/>新建
        </button>
        <button  type="button" class="one" id="setting" style="width: 120px;position: absolute;right: 20px">
            <img src="../../img/mywork/newbuildworjk1.png" style="margin-right: 8px;margin-bottom: 2px;"/>密码验证设置
        </button>
    </div>
</div>

<div id="pagediv" style="overflow-x: auto">


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
        var pageObj = $.tablePage('#pagediv','100%', [
            {
                width:'400px',
                title: '主管',
                name: 'managerName',
                selectFun:function (n,obj) {
                    if(obj.managerName==undefined){
                        return "";
                    }else{
                        return obj.managerName;
                    }
                }
            },
            {
                width:'400px',
                title: '下属员工',
                name: 'employeeName',
                selectFun:function (n,obj) {
                    if(obj.employeeName==undefined){
                        return "";
                    }else{
                        return obj.employeeName;
                    }
                }
            },
            {
                width:'250px',
                title:'操作',
                name:'orgAddress'
            }
        ], function (me) {
            me.data.pageSize = 10;
            me.init('/bonusPriv/selectByAll',[
                {name:'编辑'},
                {name:'删除'}
            ])
        })
        //       根据id修改数据
        $('#pageTbody').on('click','.editAndDelete0',function(){
            var id = pageObj.arrs[$(this).attr('data-i')].id;
            location.href = '/bonusPriv/personUpdate?id='+id;
        });
        //ajax 根据orgId 删除数据
        $('#pageTbody').on('click','.editAndDelete1',function(){
            var id=0
            if(pageObj.arrs[$(this).attr('data-i')]!=undefined){
                id=pageObj.arrs[$(this).attr('data-i')].id;
            }
            layer.confirm(qued,{
                btn: [sure,cancel], //按钮
                title:'确定删除？'
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/bonusPriv/delSetUpCrmManager',
                    dataType:'json',
                    data:{'id':id},
                    success: function (json) {
                        //第三方扩展皮肤
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        location.reload();
                    }
                })
            }, function () {
                layer.closeAll();
            })
        });
        $("#setting").on("click",function (){
            layer.open({
                type: 1,
                title: '密码验证设置',
                btn: ['确定', '取消'],
                area: ['300px', '230px'],
                content:
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="width: 200px">是否开启密码验证设置</label>'+
                    '<div class="layui-input-block">'+
                    '开启<input type="radio" name="Open" value="0" title="开启" style="margin: 10px">'+
                    '不开启<input type="radio" name="Open" value="1" title="不开启" checked="" style="margin: 10px">'+
                    '</div>'+
                    '</div>',
                success:function (){
                    $.ajax({
                        url:"/syspara/selectTheSysPara?paraName=SALARY_PASSWORD_VERIFICATION",
                        dataType:"json",
                        success:function(res) {
                            if(res.flag) {
                                var data = res.object[0];
                                $(":radio[name='Open'][value='" + data.paraValue + "']").prop("checked", "checked");
                            }
                        }
                    })
                },
                yes:function (index){
                    var val = $("input[name='Open']:checked").val()
                    $.ajax({
                        url:"/syspara/updateSysParaPlus?paraName=SALARY_PASSWORD_VERIFICATION&paraValue="+val,
                        type: "post",
                        dataType: "json",
                        success:function (res) {
                            if(res.flag){
                                layer.msg('操作成功',{icon:1});
                                layer.close(index);
                            }
                            else {
                                layer.msg('操作失败', {icon: 2});
                                layer.close(index);
                            }
                        }
                    })
                }
            })
        })
    });

</script>
</html>
