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
    <title><fmt:message code="office.list"/></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
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

    .layui-this{
        font-size: 22px!important;
        color: black!important;
    }
    .layui-tab-brief>.layui-tab-title .layui-this:after{
        border-bottom:none !important;
    }
    .layui-tab-title{
        border-bottom: 1px solid #9E9E9E!important;
    }
    #derivation{
        background-color: #2b7fe0!important;
    }
    .layui-laypage .layui-laypage-curr .layui-laypage-em{
        background-color:#2b7fe0!important ;
    }
    .layui-table tbody tr:hover{
        background: rgb(232, 244, 252) !important;
    }
    .layui-table-header table thead tr th span{
        font-weight: bold;
        font-size: 13pt!important;
        color: #2F5C8F!important;
    }
</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul id="searchul" class="layui-tab-title" lay-filter="searchul">
                <li class="layui-this" value="0" ><fmt:message code="office.office.list"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 15px; color: red"><fmt:message code="office.list.text"/></span></li>

                <li class="layui-this" value="6" style="display: none"><fmt:message code="notice.th.all"/></li>
                <li id="warning" value="0" style="display: none"><fmt:message code="office.yes.warning"/></li>
                <li id="nowarning" value="3" style="display: none"><fmt:message code="office.no.waring"/></li>
                <button  id="derivation"  type="button" class="layui-btn add layui-btn-sm" style="float: right;margin-right: 30px;width: 67px" >
                <fmt:message code="interfaceSetting.th.export"/>
                </button>
            </ul>

        </div>
        <div>

            <div>
                <table id="demo" lay-filter="test"></table>
            </div>
        </div>
        <script type="text/html" id="barDemo">
            <%--<a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>--%>
        </script>
    </form>

</div>
</div>

<script type="text/javascript">
    layui.use(['table', 'form', 'laydate','element'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var element = layui.element
        //执行一个laydate实例
        laydate.render({
            elem: '#outTime' //指定元素
        });
        laydate.render({
            elem: '#test1'
        });
        
        var tableIns = table.render({
            elem: '#demo'
            , url: '/officetransHistory/selShopList' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo'
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '<fmt:message code="common.th.prompt"/>' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                {field: 'proName',align: 'center', title: '<fmt:message code="office.Item.Name"/>'}
                , {field: 'typeName',align: 'center', title: '<fmt:message code="office.Item.category"/>'}
                , {field: 'proStock',align: 'center', title: '<fmt:message code="vote.th.CurrentStock"/>'}
                , {field: 'shoplistCount',align: 'center', title: '<fmt:message code="office.Minimum.quantity"/>'}
                , {field: 'proLowstock',align: 'center', title: '<fmt:message code="office.Minimum.number"/>'}
                , {field: 'proMaxstock',align: 'center', title: '<fmt:message code="office.Maximum.number"/>'}
                , {field: 'proPrice',align: 'center', title: '<fmt:message code="vote.th.UnitPrice"/>'}
                , {field: 'proUnit',align: 'center', title: '<fmt:message code="office.Company"/>'}
                // , {field: 'receiveAt',align: 'center', title: '规格'}
                // , {title: '详情', align: 'center', toolbar: '#barDemo'}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'obj',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
            ,done: function (res, curr, count) {

                exportData = res.data;

            }
        });


        $('#searchul').on('click','li',function(data){
            var status = this.value
            $.get('/officetransHistory/selShopList', function(res){
                if (res.flag) {
                    tableIns.reload({
                        where: {
                            status: status
                        }
                        ,page: {
                            curr: 1
                        }
                    });
                }
            });
        })

        $('#derivation').on("click",function(){

            window.location.href = "/officetransHistory/exportShopList"

        });

    });

</script>
</body>
</html>

