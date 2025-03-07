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
    <title>统计时间设置</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="/css/base.css" />
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script src="/js/xoajq/xoajq2.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    .table{
        width: 50%;
        margin: 0 auto;
        background-color: #fff;

    }
    .table-bordered > tbody > tr > td{
        border:1px solid #000;
    }
    .table > tbody > tr > td,.table > thead > tr > th{
        vertical-align: inherit;
        padding: 0 6px;
    }
    .table > thead > tr > th{
        text-align: center;
    }
    .form-control{
        height: 30px;
        margin: 5px 0;
        width: 50%
    }
    .btn{
        padding: 3px 11px;
        margin: 5px 0;
    }
    .tdBtn{
        text-align: center;
        background: linear-gradient( #e9e5e1,#f0e6db);
    }
    .titNav{
        color: #124064;
        margin: 11px 16px;
        font-weight: 700;
        font-size: 17px;
    }
    .administration td{
        text-align: center;
        height: 40px;
    }
    .administration thead{
        background-color: #e9e5e1;
        color: #124064;
    }
    .administration thead th{
        border-right: 1px solid #ccc;
        height: 36px;
    }
    /* .operation{
        color: #a4a1a1;
    } */
    .operation a{
        margin: 0 3px;
    }
    .administration .form-control{
        width: 140px;
        display: inline-block;
    }
    .administration caption{
        font-size:16px;
        font-weight: 700;
        margin: 30px 0;
    }
    .lastTbody tr:hover{
        background-color: #ddd;
    }
    .imgDiv{
        text-align: center;
        display: none;
        margin-top: 60px;
    }
    .year{
        text-align: center;
        height:50px;
        line-height:50px;
    }
    .mt{
        margin-top: 60px;
    }
</style>
</head>
<body>
<div>
    <div>
        <p class="titNav">++添加节假日</p>
        <form role="form">
            <table class="table table-bordered">
                <tr>
                    <td>起始日期：</td>
                    <td><input name="beginDate"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"  type="text" class="form-control" placeholder="请选择起始日期"></td>
                </tr>
                <tr>
                    <td>结束日期：</td>
                    <td><input name="endDate"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" type="text" class="form-control" placeholder="请选择结束日期"></td>
                </tr>
                <tr>
                    <td>节假日名称：</td>
                    <td><input name="holidayName" type="text" class="form-control" placeholder="请输入节假日名称"></td>
                </tr>
                <tr>
                    <td colspan="2" class="tdBtn">
                        <button onclick="add()" type="button" class="btn btn-primary" data-toggle="button">添加</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="administration">
        <p class="titNav">++管理节假日</p>
        <div class="year"><span>管理年份：</span><select id="query" class="form-control">
        </select></div>
        <div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
            <div>暂无数据</div>
        </div>
            <table class="table" id="table1">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>节假日名称</th>
                    <th>起始时间</th>
                    <th>结束时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody class="lastTbody" id="tbody">



                </tbody>
            </table>

    </div>

</div>
</body>
<script>
    //年份自动生成
    function allYear(){
        var str=""
        for(var i=1970;i<2049;i++){

            if(i==(new Date()).getFullYear()){
                str+="<option selected val='"+i+"'>"+i+"</option>"
            }else{
                str+="<option val='"+i+"'>"+i+"</option>"
            }


        }
     $("#query").html(str);
    }
    allYear()
    //添加节假日
    function add(){
        var holidayName=$('[name=holidayName]').val();
        var beginDate=$('[name=beginDate]').val();
        var endDate=$('[name=endDate]').val();
        $.ajax({
            type:'post',
            url: '/FlowSettingHoliday/insertFlowSettingHoliday',
            dataType: 'json',
            data:{
                holidayName:holidayName,//节假日名称
                beginDate:beginDate,  //开始日期
                endDate:endDate, //结束日期
            },
            success:function(res){

                if(res.flag){
                    layer.msg('新增成功！', {icon: 1});
                    $('[name=holidayName]').val("");
                    $('[name=beginDate]').val("");
                    $('[name=endDate]').val("");
                    init()
                } else {
                    layer.msg('新增失败！', {icon: 2});
                }
            }

        })
    }
    init()
    //初始化查询节假日
    function init(){
        var beginYear = $("#query").val();
        $.ajax({
            type:'post',
            url: '/FlowSettingHoliday/selectFlowSettingHoliday',
            dataType: 'json',
            data:{
                beginyear:beginYear
            },
            success:function(res){
                if (res.flag) {
                    var str=""
                    $("#tbody").html("");
                    if(res.obj.length==0){
                        $(".imgDiv").css("display","block");
                        $("#table1").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $("#table1").css("display","block");
                    for(var i=0;i<res.obj.length;i++){
                        str+='<tr data-id="'+res.obj[i].holidayId+'">'+
                            '<td class="num">'+res.obj[i].holidayId+'</td>'+
                            '<td class="name">'+res.obj[i].holidayName+'</td>'+
                            '<td class="beginDate">'+res.obj[i].beginDate+'</td>'+
                            '<td class="endDate">'+res.obj[i].endDate+'</td>'+
                            '<td class="operation"><a class="edit" href="javascript:;">编辑</a><a class="del" href="javascript:;">删除</a></td>'+
                            '</tr>'

                    }
                    $("#tbody").html(str)

                } else {
                    layer.msg('查询失败！', {icon: 2});
                }
            }

        })
    }
    //查询
    $('#query').change(function(){
        init()
    })
//修改
    $('#tbody').on("click",".edit",function(){
        var holidayId = $(this).parents("tr").attr("data-id");
        var holidayName = $(this).parent("td").siblings(".name").html();
        var beginDate = $(this).parent("td").siblings(".beginDate").html();
        var endDate = $(this).parent("td").siblings(".endDate").html();
        layer.open({
            type: 1,
            title: ['修改','background-color:#2e8ded;color:#fff'],
            content:'<form class="mt" role="form" >'+
            '<table id="table1" class="table table-bordered">'+
            '<tr style="display: none">'+
            '<td>id：</td>'+
            '<td><input name="holidayId1" value="'+holidayId+'"  type="text" class="form-control" placeholder="请选择起始日期"></td>'+
            '</tr>'+
            '<tr>'+
            '<td>起始日期：</td>'+
            '<td><input name="beginDate1" value="'+beginDate+'" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})"  type="text" class="form-control" placeholder="请选择起始日期"></td>'+
            '</tr>'+
            '<tr>'+
            '<td>结束日期：</td>'+
            '<td><input name="endDate1" value="'+endDate+'"  onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" type="text" class="form-control" placeholder="请选择结束日期"></td>'+
            '</tr>'+
            '<tr>'+
            '<td>节假日名称：</td>'+
            '<td><input name="holidayName1" value="'+holidayName+'" type="text" class="form-control" placeholder="请输入节假日名称"></td>'+
            '</tr>'+
            '</table>'+
            '</form>',
            area: ['70%', '470px'],
            btn: ['修改','关闭'],
            yes:function(index){
                var holidayId1 = $('[name=holidayId1]').val();
                var holidayName1=$('[name=holidayName1]').val();
                var beginDate1=$('[name=beginDate1]').val();
                var endDate1=$('[name=endDate1]').val();
                $.ajax({
                    type:'post',
                    url: '/FlowSettingHoliday/updateByPrimaryKey',
                    dataType: 'json',
                    data:{
                        holidayId:holidayId1,
                        holidayName:holidayName1,//节假日名称
                        beginDate:beginDate1,  //开始日期
                        endDate:endDate1, //结束日期
                    },
                    success:function(res){

                        if(res.flag){
                            layer.msg('修改成功！',{icon: 1,time:2000},function() {
                                layer.closeAll();
                                init()

                            })


                        } else {
                            layer.msg('修改失败！', {icon: 2});

                        }
                    }

                })

            },
            btn2: function (index) {
                layer.close(index)
            },
            btnAlign:'c',

        })
    })



    // 删除
    $('#tbody').on("click",".del",function() {
        var holidayId = $(this).parents("tr").attr("data-id");
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteAssets" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                type:'post',
                url: '/FlowSettingHoliday/deleteByPrimaryKey',
                dataType: 'json',
                data:{
                    holidayId:holidayId
                },
                success:function(res){
                    if (res.flag) {
                        layer.msg('删除成功！', {icon: 1});
                        init();
                    } else {
                        layer.msg('删除失败！', {icon: 2});
                    }
                }

            })
        }, function () {
            layer.closeAll();
        });


    })

</script>
</html>