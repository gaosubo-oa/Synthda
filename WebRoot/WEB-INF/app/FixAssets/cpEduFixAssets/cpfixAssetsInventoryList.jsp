<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>盘点清单</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>


    .mbox {
        padding: 8px;
    }

    .items {
        background-color: #f2f2f2;
        text-align: center;
        height: 30px;
        line-height: 30px;
    }

    .layui-form-item {
        margin-bottom: 5px;
    }

    .inpWhit {
        width: 300px;
    }

    /*下拉按钮*/
    .dropbtn {
        text-align: left;
        background-color: #009688;
        color: white;
        font-size: 12px;
        border: none;
        cursor: pointer;
        height: 30px;
        width: 90px;
    }

    /* 容器 <div> - 需要定位下拉内容 */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* 下拉内容 (默认隐藏) */
    .dropdown-content {
        margin-left: 0px;
        display: none;
        position: absolute;
        top: 32px;
        background-color: #fff;
        min-width: 115px;
        text-align: center;
        line-height: 36px;
        padding-top: 10px;
        box-shadow: 0px 8px 12px 0px rgba(0, 0, 0, 0.2);
        z-index: 999999999;
    }

    .licon {
        display: inline-block;
        width: 0;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        position: absolute;
        right: 6px;
        top: 52%;
        margin-top: -3px;
        cursor: pointer;
        border-width: 6px;
        border-top-color: #fff;
        border-top-style: solid;
        transition: all .3s;
        -webkit-transition: all .3s;
    }

    * {
        font-family: "Microsoft Yahei" !important;
    }

    b {
        color: red;
    }

    /* 下拉菜单的链接 */
    .dropdown-content a {
        color: black;
        /*padding: 12px 16px;*/
        text-decoration: none;
        display: block;
    }

    /*!* 在鼠标移上去后显示下拉菜单 *!*/
    .icon-on {
        margin-top: -9px;
        -webkit-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .layui-table {
        width: 100% !important;
    }
    .bg{
        background: #f2f2f2;
    }

    nav div{
        float: left !important;
        margin: 15px;
    }
    nav{
        height: 50px;
        border-bottom: 1px solid #cfdbe2;
        background-color: #fafbfc;
        border-radius: 0;
    }
    .time{
        width: 90px;
        margin-left: 0px;
        display: inline;
    }
    .input{
        margin-left: 130px;
    }
    .layui-table-body{overflow-x: hidden;}



</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">盘点数据详情</li>
                <li id="shenhe">盘点清单</li>
                <%--<li class="query">更多筛选</li>--%>
                <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary add" style="float: right;margin-right: 5px" >新增</button>--%>
            </ul>

            <div class="layui-tab-content" style="height: 100px;">
                <%--<input id="inventoryId" name="inventoryId" type="hidden" value="${financialCompanyDO.inventoryId}"/>--%>
                <div class="layui-tab-item layui-show" >
                    <%--内容1--%>
                    <div style="margin-top: 20px;height: 100px;width: 100%">
                        <form class="layui-form" action="">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="font-weight:bold">盘点名称:</label>
                                <div class="layui-input-inline">
                                    <input id="inventoryName"  type="text" name="password" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: none">
                                </div>
                            </div>
                            <div class="layui-form-item" style="width:800px ">
                                <label class="layui-form-label" style="width:108px;font-weight:bold">当前领用用户:</label>
                                <div class="layui-input-inline">
                                    <input id="applyUser" type="text" name="password" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: none">
                                </div>
                            </div>

                            <div class="layui-inline" style="width:800px ">
                                <label class="layui-form-label" style="width:108px;font-weight:bold">资产登记时间:</label>
                                <div class="layui-inline">
                                    <input id="startAt" type="text" class="layui-input test-item" placeholder="" style="border: none">
                                </div><span style="font-weight:bold">至</span>
                                <div class="layui-inline" style="margin-left: 15px">
                                    <div class="layui-inline">
                                        <input id="endAt" style="border: none" class="layui-input test-item" placeholder="" value=" ">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="font-weight:bold">所属分类:</label>
                                <div class="layui-input-inline">
                                    <input id="assetsType" type="text" name="password" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: none">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="margin-left: -15px;font-weight:bold">管理员:</label>
                                <div class="layui-input-inline">
                                    <input id="managers" type="text" name="password" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="border: none">
                                </div>
                            </div>
                            <div class="layui-form-item" style="display: none">
                            <label class="layui-form-label">关联流程</label>
                            <div class="layui-input-inline">
                            <input type="text" id="inventoryId" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input"  value="${inventoryId}">
                            </div>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="layui-tab-item" >
                    <%--内容2--%>
                    <div>
                        <table id="demo" lay-filter="test"></table>
                    </div>

                </div>
            </div>

        </div>
        <div>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            </div>
        </div>
        <%--<script type="text/html" id="barDemo">--%>
        <%--<a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>--%>
        <%--</script>--%>
    </form>

</div>
</div>
<%--表格--%>



<%--<script type="text/html" id="barDemo">--%>
<%--<a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>--%>
<%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>

<script type="text/javascript">
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#shenhe').after('<li style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;"> 机密级★ </li>')
                }
            }
        }
    })
    var inventoryIds = $('#inventoryId').val()
    layui.use(['table', 'form', 'laydate','element'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var element = layui.element
        // console.log(parent.inventoryId,11)
        // console.log(window.parent.inventoryId,22)
        //执行一个laydate实例
        laydate.render({
            elem: '#test1'
        });
        laydate.render({
            elem: '#test'
        });

        $(function() {
            var inventoryId = $('#inventoryId').val()
            $.ajax({
                type: 'get',
                url: '/eduFixAssets/fixAssetsGetInventory',
                dataType: 'json',
                data: {
                    inventoryId: inventoryId
                },
                success: function (obj) {
                    var data=obj.object;
                    $("#inventoryName").val(data[0].inventoryName);
                    $("#applyUser").val(data[0].applyUser);
                    $("#startAt").val(data[0].startAt);
                    $("#endAt").val(data[0].endAt);
                    $("#assetsType").val(data[0].assetsType);
                    $("#managers").val(data[0].operator);
                }
            })
        })

        //第一个实例
        var tableIns = table.render({
            elem: '#demo'
            , url: '/eduFixAssets/fixAssetsGetInventory?type=2&inventoryId='+inventoryIds+'' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo' //头部工具栏
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                  {field: 'assetsName',align: 'center', title: '资产名称'}
                , {field: 'assetsId',align: 'center', title: '资产编码'}
                , {field: 'assetsType',align: 'center', title: '所属分类'}
                , {field: 'applyUser',align: 'center', title: '当前领用用户'}
                , {field: 'createTime',align: 'center', title: '登记时间'}
                , {field: 'recordsStatus',align: 'center', title: '状态',templet:function(d){
                        if(d.recordsStatus==1){
                            return '未使用'
                        }else if(d.recordsStatus==2){
                            return '使用'
                        }else if(d.recordsStatus==3){
                            return '损坏'
                        }else if(d.recordsStatus==4){
                            return '丢失'
                        }else if(d.recordsStatus==5){
                            return '报废'
                        }else if(d.recordsStatus==undefined){
                            return ''
                        }
                    }}
                , {field: 'isInventory',align: 'center', title: '盘点状态',templet:function(d){
                        if(d.isInventory==1){
                            return '已盘点'
                        }else if(d.isInventory==2){
                            return '未盘点'
                        }else if(d.isInventory==undefined){
                            return '未盘点 '
                        }
                    }}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'object',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }

        });

    });




</script>
</body>
</html>



