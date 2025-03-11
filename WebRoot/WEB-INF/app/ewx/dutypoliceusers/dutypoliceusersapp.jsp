<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title> </title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <style>
        body{
            /*background: #f4f4f4;*/
            /*background-color: #cccccc;*/
        }
        .cont{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            background-color: #fff;
            margin: .24rem .24rem;
            padding: .1rem 0;
        }
        .list{
            min-height: 40px;
            line-height: 40px;
        }
        /*.labeldata{*/
            /*display:inline-block;*/
            /*width: 100px;*/
            /*text-align: center;*/
        /*}*/
        .btn{
            width: 75%;
            margin: 0 auto;
            display: block;
            border-radius: 10px;
            font-size: 18px;
            line-height: 7px;
            margin-bottom: 10px;
        }
        /*.tbody{*/
            /*background: #f4f4f4;*/
        /*}*/
    </style>
</head>
<body>
    <div>
        <form class="layui-form" action="">
            <div class="layui-block" style="margin: 10px auto;">
                <label class="layui-form-label">开始时间</label>
                <div class="layui-input-inline" style="width: 60%">
                    <input type="text" name="date" id="date" lay-verify="date" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-block" style="margin: 10px auto;">
                <label class="layui-form-label">结束时间</label>
                <div class="layui-input-inline" style="width: 60%">
                    <input type="text" name="date" id="dateend" lay-verify="date" autocomplete="off" class="layui-input">
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-normal btn">查询</button>
        </form>
    </div>
    <%--<div class="box">--%>

    <%--</div>--%>
    <%--表格--%>
    <div>
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col width="250">
                <col>
            </colgroup>
            <tbody class="tbody">

            </tbody>
        </table>
    </div>
</body>
</html>
<script>
    layui.use(['form', 'laydate', 'laydate'], function(){
        var form = layui.form
        var laydate = layui.laydate
        // 日期
        laydate.render({
            elem: '#date'
            ,trigger: 'click'//呼出事件改成click
        });
        laydate.render({
            elem: '#dateend'
            ,trigger: 'click'//呼出事件改成click
        });
        $('#date').val(datas())
        $('#dateend').val(datasuy())
        $('.btn').click(function () {
            sear($('#date').val(),$('#dateend').val())
        })
        sear($('#date').val(),$('#dateend').val())
        function sear(start,end) {
            $.ajax({
                url:'/DutyPoliceUsers/findDutyPoliceWhere',
                dataType:'json',
                type:'post',
                data:{
                    dutyDate:start,
                    dutyDateEnd:end
                },
                success:function (res) {
                    var object = res.obj
                    if(res.obj!=''){
                        var app = '';
                        for(var i=0;i<object.length;i++){
                            app += '<tr>\n' +
                                '                <td>\n' +
                                '                    <div style="text-align: center">'+object[i].dutyweek+'</div>\n' +
                                '                    <div style="text-align: center;margin-top: 10px;">'+object[i].dutyDate+'</div>\n' +
                                '                </td>\n' +
                                '                <td>\n' +
                                '                    <div>\n' +
                                '                        <label>局带班:</label>\n' +
                                '                        <span>'+isnulls(object[i].btreeUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>局值班:</label>\n' +
                                '                        <span>'+isnulls(object[i].bdutyUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>总站带班:</label>\n' +
                                '                        <span>'+isnulls(object[i].ttreeUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>总站值班:</label>\n' +
                                '                        <span>'+isnulls(object[i].tdutyUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>操作员:</label>\n' +
                                '                        <span>'+isnulls(object[i].operatingUsers)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>总站备勤:</label>\n' +
                                '                        <span>'+isnulls(object[i].preparationUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>中心值班长:</label>\n' +
                                '                        <span>'+isnulls(object[i].cbigUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                    <div>\n' +
                                '                        <label>中心值班员:</label>\n' +
                                '                        <span>'+isnulls(object[i].cpersonUsersName)+'</span>\n' +
                                '                    </div>\n' +
                                '                </td>\n' +
                                '            </tr>';
                        }
                        $('.tbody').html(app);

                    }else{
                            var  str='<div style="text-align: center;font-size:20px;margin-top: 10px;">暂无数据！</div>';
                            $('.tbody').html(str);
                    }
                }
            })
        }
    })

    //判断是否为空
    var isnulls=(name)=>{
        if(name!=undefined){
            return name;
        }
        return '';
    };

   // 获取当前周一的日期
   function datas() {
       var nowTemp = new Date();//当前时间

       var oneDayLong = 24*60*60*1000 ;//一天的毫秒数

       var c_time = nowTemp.getTime() ;//当前时间的毫秒时间

       var c_day = nowTemp.getDay()||7;//当前时间的星期几

       var m_time = c_time - (c_day-1)*oneDayLong;//当前周一的毫秒时间

       var monday = new Date(m_time);//设置周一时间对象

       var m_year = monday.getFullYear();

       var m_month = monday.getMonth()+1;

       var m_date = monday.getDate();
        return m_year+'-'+m_month+'-'+m_date
   }
    // 获取当前周日的日期
   function datasuy() {
        var nowTemp = new Date();//当前时间

        var oneDayLong = 24*60*60*1000 ;//一天的毫秒数

        var c_time = nowTemp.getTime() ;//当前时间的毫秒时间

        var c_day = nowTemp.getDay()||7;//当前时间的星期几
        var m_time = c_time - (c_day-7)*oneDayLong;//当前周日的毫秒时间

        var monday = new Date(m_time);//设置周一时间对象

        var m_year = monday.getFullYear();

        var m_month = monday.getMonth()+1;

        var m_date = monday.getDate();
        return m_year+'-'+m_month+'-'+m_date
    }
</script>

