<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2022/9/8
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <style>
        .tableInfo table th {
            text-align: center;
        }
        .tableInfo table td {
            text-align: center;
        }
        .layui-form-label {
            text-align: left;
        }
        .item {
            white-space: nowrap;
        }
    </style>
</head>
<body>

<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">人员统计</li>
        <li>工时统计</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div style="
    height: 20px;
    line-height: 10px;
    font-size: 22px;
    color: #494d59;">
                <img src="/ui/img/zkim/category.png">
                人员统计</div>
<%--            船只信息表格--%>
            <div class="tableInfo">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th>船名/项目</th>
                        <th>当前在船人数</th>
                        <th>今日离船人数</th>
                        <th>今日总人数</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="layui-tab-item">
            <div style="
    height: 20px;
    line-height: 10px;
    font-size: 22px;
    color: #494d59;">
                <img src="/ui/img/zkim/category.png">
                工时统计</div>
            <form class="layui-form" action="">
                <div style="position: relative;line-height: 60px;">
                    <div class="item">
                        <div class="layui-inline">
                            <label class="layui-form-label" style="width: 80px !important; margin-left: -10px;">姓名</label>
                            <div class="layui-input-inline">
                                <input  style="width: 200px" id="cName" name="cName" class="layui-input" type="text">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 30px;">单位</label>
                            </div>
                            <div class="layui-inline">
                                <select name="company" lay-verify="" style="width: 200px;">
                                    <option value="">请选择</option>
                                    <option value="局机关">局机关</option>
                                    <option value="救捞工程船队">救捞工程船队</option>
                                    <option value="救捞拖轮船队">救捞拖轮船队</option>
                                    <option value="三用船队">三用船队</option>
                                    <option value="中国海洋工程有限公司">中国海洋工程有限公司</option>
                                    <option value="研发中心">研发中心</option>
                                    <option value="制造基地">制造基地</option>
                                    <option value="保障中心">保障中心</option>
                                    <option value="外部单位">外部单位</option>
                                </select>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 60px;">开始时间</label>
                                <div class="layui-input-inline">
                                    <input  style="width: 200px"  id="startTime" name="startTime" class="layui-input" type="text">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: 60px;">结束时间</label>
                                <div class="layui-input-inline">
                                    <input  style="width: 200px"  id="endTime" name="endTime" class="layui-input" type="text">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="layui-inline" style="margin-top: 10px;">
                        <label class="layui-form-label" style="width: 80px; margin-left: -10px;">船名/项目</label>
                        <div class="layui-input-inline"  style="display: flex">
                            <select id="visitLocation" name="visitLocation" class="visitLocation" lay-verify="visitLocation" lay-filter="visitLocation">
                                <option value="">请选择</option>
                            </select>
                            <div align="center">
                                <button type="button" class="layui-btn layui-btn-sm" id="search1" style="vertical-align: top;height: 38px; margin-left: 20px;" lay-event="search1">查询</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
<%--                工时统计表格--%>
            <div class="table-work"></div>
            <div style="margin-top: 10px;">
                <div class="item" style="padding-left: 5%;">
                    <div class="item layui-inline" style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;">在船总人数</div><div class="item layui-inline" style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;">在船总天数</div><div class="item layui-inline"style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;">总工时</div>
                </div>
                <div class="layui-row" style="padding-left: 5%;">
                    <div class="totalP item layui-inline"style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;"></div><div class="totalD item layui-inline"style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;"></div><div class="totalG item layui-inline"style="width: 30%;height:38px;line-height:38px;text-align: center; background-color:#fff; border: 1px solid #ccc;"></div>
                </div>
            </div>
            <table id="tableWork" lay-filter="test"></table>
        </div>
    </div>
</div>
<script>

    //人员统计接口
    $.ajax({
        url:"/coesStaffStatistics/statisticaQuantity",
        dataType:"json",
        success:function(res) {
            if(res.flag) {
                if(res.datas.length > 0) {
                    for(var i = 0; i < res.datas.length; i++) {
                        var data = res.datas[i];
                        var tr = $('<tr>');
                        tr.html(
                            '<td>'+data.boatName+'</td>'+
                            '<td>'+data.onTheBoat+'</td>'+
                            '<td>'+data.offTheBoat+'</td>'+
                            '<td>'+data.total+'</td>'
                        )
                        $('.tableInfo tbody').append(tr);
                    }
                }else if(res.datas.length == 0) {
                    var tr = $('<tr>');
                    tr.html('<td colspan="4">暂无数据</td>')
                    $('.tableInfo tbody').append(tr);
                }
            }

        }
    })
    //工时统计
    <%--    使用layui--%>
    layui.use(['element','form','laydate','table'], function(){
        var element = layui.element;
        var form = layui.form;
        var laydate = layui.laydate;
        var table = layui.table;
        form.render();
        laydate.render({
            elem:"#startTime",
            tigger:"click",
            format:"yyyy-MM-dd",
        })
        laydate.render({
            elem:"#endTime",
            tigger:"click",
            format:"yyyy-MM-dd",
        })
        //获取船名
        $.ajax({
            url:'/code/getCode?parentNo=COES_BOAT_NAME',
            type:'post',
            dataType:'json',
            data:{
            },
            success:function(res){
                var arr=[];
                var str
                for(var i=0;i<res.obj.length;i++){
                    str+='<option  value="'+res.obj[i].codeNo+'">'+res.obj[i].codeName+'</option>'
                }
                $('select[name="visitLocation"]').append(str);
                form.render('select');
            }
        })
        //执行渲染
        table.render({
            elem: '#tableWork',
            url:"/coesStaffStatistics/hoursStatistics",
            parseData:function(res) {
                return {
                    "code": 0,
                    "msg":"",
                    "data":res.datas,
                    "count":res.datas.length

                }
            },
            cols: [[
                {field:"name",title:"姓名",align:"center",sort: true},
                {field:"company",title:"单位",sort: true,align:"center"},
                {field:"boatName",title:"船名/项目",sort: true,align:"center"},
                {field:"totalDays",title:"在船天数",sort: true,align:"center"},
                {title:"工时",align:"center",templet:function(res) {
                    if(res.company == '救捞工程船队') {
                        return res.totalDays * 12
                    }else {
                        return res.totalDays * 8
                    }

                    }},
            ]],
            done:function(res) {
                var data = res.data;
                //总天数
                var totalDays = data.reduce(function(a,b) {
                    return a + b.totalDays
                },0)
            //    总工时
                var totalGs = data.reduce(function(a,b) {
                    if(b.company == '救捞工程船队') {
                        a += b.totalDays * 12
                    }else {
                        a += b.totalDays * 8
                    }
                    return a
                },0)
                $('.totalP').text(data.length);
                $('.totalD').text(totalDays);
                $('.totalG').text(totalGs);
            }
        });
    //    查询数据
        $('#search1').click(function() {
            var cName = $('input[name=cName]').val();
            var company = $('select[name=company]').val() ;
            var startTime = $('input[name=startTime]').val();
            var endTime = $('input[name=endTime]').val();
            var visitLocation = $('select[name=visitLocation] option:selected').text();
            if(visitLocation == '请选择') {
                visitLocation = ''
            }
            table.render({
                elem: '#tableWork',
                url:"/coesStaffStatistics/hoursStatistics",
                parseData:function(res) {
                    return {
                        "code": 0,
                        "msg":"",
                        "data":res.datas,
                        "count":res.datas.length
                    }
                },
                where: {
                    name:cName,
                    company:company,
                    boardScanTime:startTime,
                    ashoreScanTime: endTime,
                    boatName: visitLocation
                },
                cols: [[
                    {field:"name",title:"姓名",align:"center",sort: true},
                    {field:"company",title:"单位",sort: true,align:"center"},
                    {field:"boatName",title:"船名/项目",sort: true,align:"center"},
                    {field:"totalDays",title:"在船天数",sort: true,align:"center"},
                    {title:"工时",align:"center",templet:function(res) {
                            if(res.company == '救捞工程船队') {
                                return res.totalDays * 12
                            }else {
                                return res.totalDays * 8
                            }
                        }},
                ]],
                done:function(res) {
                    var data = res.data;
                    //总天数
                    var totalDays = data.reduce(function(a,b) {
                        return a + b.totalDays
                    },0)
                    //    总工时
                    var totalGs = data.reduce(function(a,b) {
                        if(b.company == '救捞工程船队') {
                            a += b.totalDays * 12
                        }else {
                            a += b.totalDays * 8
                        }
                        return a
                    },0)
                    $('.totalP').text(data.length);
                    $('.totalD').text(totalDays);
                    $('.totalG').text(totalGs);
                }
            });
        })
    });

</script>
</body>
</html>
