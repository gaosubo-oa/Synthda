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
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>报表门户</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
        <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="/js/echarts.min.js"></script>
        <script type="text/javascript" src="/lib/echarts/china.js"></script>
        <script type="text/javascript" src="/lib/highcharts.js"></script>
        <style>
        html , body{
            height: 100%;
        font-family: "Microsoft Yahei" !important;
        }
        body{
         background: #F5F7FA;;
        }
        .left{
        width: 35%;
        padding: 10px;
        }
        .left1{
        height: 100px;
        background-color: #8591D9;
            border: 1px solid #8591D9;
        border-radius: 0px 0px 6px 6px;
        }
        .left2{
        display: flex;
        margin-top: 10px;
        }
        .title{
        font-size: 16px;
        color: #FFF;
        font-weight: bold;
        margin: 15px;
        }
        .info{
        font-size: 18px;
        color: #FFF;
        font-weight: bold;
        margin: 15px;
        }
        .left3 , .left4 , .right1 , .right2{
        background:#fff;
        margin-top: 10px;
        }
        .right{
        width: 63%;
        }
        .left{
        min-width: 532px;
        }
        .right{
        min-width: 957px
        }
            .picture{
            float: left;
            width: 9%;
            margin-left: 20px;
            height: 100px;
            border-right: 1px solid #fff;
            }
            #main2{
                    width: 100%;
                    height:462px;
            }
        </style>
        </head>
        <body>
        <div style="display: flex">
        <div class="left">
        <%--<div class="left1">--%>
            <%--<div  class="picture">--%>
                <%--<img src="../img/menu/amount.png" alt="" style="width: 30px;margin-top: 29px">--%>
            <%--</div>--%>
            <%--<div  style="float: left">--%>
                    <%--<div class="title">合同金额</div>--%>
                    <%--<div class="info">3860000</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="left2">
        <div style="width:47%;height: 100px;background-color: #EFAE92;border-radius: 6px">
                <div style="float: left;width: 19%;"  class="picture">
                    <img src="../img/menu/num.png" alt="" style="width: 30px;margin-top: 30px">
                </div>
                <div style="float: left;">
                    <div class="title">合同金额</div>
                    <div class="info summoney"></div>
                </div>
        </div>
        <div style="width:47%;height: 100px;background-color: #E4877E;margin-left: 6%;border-radius: 6px">
            <div style="float: left;width: 19%;"  class="picture">
                <img src="../img/menu/peoimg.png" alt="" style="width: 30px;margin-top: 30px">
            </div>
            <div style="float: left;">
                 <div class="title">合同数量</div>
                 <div class="info nums"></div>
            </div>
        </div>
        </div>
        <div class="left3" >
        <div style="border-bottom: 1px solid #ccc;padding: 8px;">合同金额明细</div>
        <div id="main" style="width: 100%;height:340px;"></div>
        </div>
        <%--<div class="left4" >--%>
        <%--<div style="border-bottom: 1px solid #ccc;padding: 8px;">合同状态分析</div>--%>
        <%--<div id="main1" style="width: 100%;height:350px;"></div>--%>
        <%--</div>--%>
        <div class="left4" >
            <div style="border-bottom: 1px solid #ccc;padding: 8px;">公告报表</div>
                <table class="layui-hide" id="test"></table>
            </div>
        </div>
        <div class="right">
        <div class="right1">
        <div style="border-bottom: 1px solid #ccc;padding: 8px;">全国客户分布</div>
        <div id="main2" style="width: 100%;height:462px;"></div>
        </div>
        <div class="right2">
        <div style="border-bottom: 1px solid #ccc;padding: 8px;">公告报表统计</div>
        <div id="main3" style="width: 100%;height:350px;"></div>
        </div>
        </div>
        </div>
        <script type="text/javascript">

        //    公告发布数统计接口
        $.ajax({
        type:'get',
        url:'/notice/selectByType',
        dataType:'json',
        success:function(res){
        var datas=res.data;
        var dataNum=[];
        for(var key in datas){
        var str=[];
        str.push(key);
        str.push(datas[key]);
        dataNum.push(str);
        }
        noteTongji(dataNum);
        }
        })
        // 发布公告统计
        function noteTongji(data) {
        var Gao = [];var Count = [];
        for (var i = 0; i<data.length; i++){
        Gao.push(data[i][0]);
        Count.push(data[i][1]);
        }
        var myChart3= echarts.init(document.getElementById('main3'));
        var option3 = {
        grid:{
        x:40,
        y:20,
        x2:30,
        y2:30
        },
        title:{},
        tooltip:{
        show:true,
        axisPointer:{
        type:'cross',
        crossStyle:{
        color:'#666',
        width:1,
        type:'dashed',
        },
        label:{
        show:true,
        precision : 'auto',
        }
        }
        },
        color:['rgba(92,179,225,1)'],
        xAxis:{
        type: 'category',
        data:Gao,
        left:"center",
        axisLabel:{
        fontSize:16
        }
        },
        yAxis:{},
        series: [
            {
            type: 'bar', name: '公告发布量',
            data: Count,
            barWidth:60,
            }
        ]
        }
        myChart3.setOption(option3);
        }


        </script>
        </body>
        </html>
            <script type="text/javascript">
        //合同的接口
        $.ajax({
            url:'/contract/selectContractAll',
            type:'get',
            dataType:'json',
            success:function(res) {
                if(res.flag){
                    if(res.object.summoney == '' || res.object.summoney==undefined){
                        $('.summoney').append('')
                    }else{
                        $('.summoney').append(res.object.summoney)
                    }
                    if(res.count== '' || res.count==undefined){
                        $('.nums').append('')
                    }else{
                        $('.nums').append(res.count)
                    }
                }else{
                    $('.summoney').append('');$('.nums').append('')
                }
            }
        })
        $.ajax({
        type:'get',
        url:'/contract/selectContractAll?page=1&limit=10',
        dataType:'json',
        success:function (res) {
        var datas=res.data;

        var dataNum=[];
        var str=[];
        for(var i = 0; i< datas.length; i++){

        dataNum.push(datas[i].title);

        str.push(datas[i].money);

        }



        hetongTongji(dataNum,str)
        }

        })
        //合同
        function hetongTongji(dataNum,str) {
        //合同统计
        $('#main').highcharts({
        chart: {
        type: 'column',
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        categories:
        // '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
        dataNum ,
        crosshair: true
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
        '<td style="padding:0"><b>{point.y:.1f}元</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
        },
        plotOptions: {
        column: {
        borderWidth: 0
        }
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '合同金额',
        // data: [149.9, 171.5, 1106.4, 129.2, 144.0, 176.0, 1135.6, 1148.5, 1216.4, 194.1, 95.6, 54.4]
        data:str
        }]
        });
        }

            var dataList=[
            {name:"南海诸岛",value:0},
            {name: '北京', value: randomValue()},
            {name: '天津', value: randomValue()},
            {name: '上海', value: randomValue()},
            {name: '重庆', value: randomValue()},
            {name: '河北', value: randomValue()},
            {name: '河南', value: randomValue()},
            {name: '云南', value: randomValue()},
            {name: '辽宁', value: randomValue()},
            {name: '黑龙江', value: randomValue()},
            {name: '湖南', value: randomValue()},
            {name: '安徽', value: randomValue()},
            {name: '山东', value: randomValue()},
            {name: '新疆', value: randomValue()},
            {name: '江苏', value: randomValue()},
            {name: '浙江', value: randomValue()},
            {name: '江西', value: randomValue()},
            {name: '湖北', value: randomValue()},
            {name: '广西', value: randomValue()},
            {name: '甘肃', value: randomValue()},
            {name: '山西', value: randomValue()},
            {name: '内蒙古', value: randomValue()},
            {name: '陕西', value: randomValue()},
            {name: '吉林', value: randomValue()},
            {name: '福建', value: randomValue()},
            {name: '贵州', value: randomValue()},
            {name: '广东', value: randomValue()},
            {name: '青海', value: randomValue()},
            {name: '西藏', value: randomValue()},
            {name: '四川', value: randomValue()},
            {name: '宁夏', value: randomValue()},
            {name: '海南', value: randomValue()},
            {name: '台湾', value: randomValue()},
            {name: '香港', value: randomValue()},
            {name: '澳门', value: randomValue()}
            ]
            var myChart2 = echarts.init(document.getElementById('main2'));
            function randomValue() {
            return Math.round(Math.random()*1000);
            }
            option2 = {
            tooltip: {
            formatter:function(params,ticket, callback){
            return params.seriesName+'<br />'+params.name+'：'+params.value
            }//数据格式化
            },
            visualMap: {
            min: 0,
            max: 1500,
            left: 'left',
            top: 'bottom',
            text: ['高','低'],//取值范围的文字
            inRange: {
            color: ['#e0ffff', '#006edd']//取值范围的颜色
            },
            show:true//图注
            },
            geo: {
            map: 'china',
            roam: false,//不开启缩放和平移
            zoom:1.23,//视角缩放比例
            label: {
            normal: {
            show: true,
            fontSize:'10',
            color: 'rgba(0,0,0,0.7)'
            }
            },
            itemStyle: {
            normal:{
            borderColor: 'rgba(0, 0, 0, 0.2)'
            },
            emphasis:{
            areaColor: '#F3B329',//鼠标选择区域颜色
            shadowOffsetX: 0,
            shadowOffsetY: 0,
            shadowBlur: 20,
            borderWidth: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
            }
            },
            series : [
            {
            name: '信息量',
            type: 'map',
            geoIndex: 0,
            data:dataList
            }
            ]
            };
            myChart2.setOption(option2);
            myChart2.on('click', function (params) {
            // alert(params.name);
            });
            </script>
        <script>
        layui.use('table', function(){
        var table = layui.table;
        table.render({
        elem: '#test'
        ,url:'/notice/notifyManage'
        ,defaultToolbar: []
        ,height:340
        ,where:{
            read:'',
            useFlag:'true',
            typeId:0,
            pageSize:10,
            limit:'',
            sendTime:''
        }
        ,title: '用户数据表',
        parseData: function(res){ //res 即为原始返回的数据
        return {
        "code":0, //解析接口状态
        "data": res.obj, //解析数据列表
        "count": res.totleNum,
        };
        }
        ,cols: [[
            {field:'name', title:'发布人'}
            ,{field:'subject', title:'标题'}
            ,{field:'begin', title:'生效日期'}
            ,{field:'typeName', title:'类型'}
            ]]
        ,page: true,
        success:function(res){
            console.log(res)
        }
        });
        });
        </script>
