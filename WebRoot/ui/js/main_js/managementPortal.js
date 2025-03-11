$(function () {


    yuangongTongji('1');//员工统计初始数据

    $('.age').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').show();
        $('#containerSex').hide();
        $('#containerXueli').hide();
        $('#containerNianxian').hide();
        yuangongTongji('1');
    })
    $('.sex').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').show();
        $('#containerXueli').hide();
        $('#containerNianxian').hide();
        yuangongTongji('2');
    })
    $('.education').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').hide();
        $('#containerXueli').show();
        $('#containerNianxian').hide();
        yuangongTongji('3');
    })
    $('.workingLife').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').hide();
        $('#containerXueli').hide();
        $('#containerNianxian').show();
        yuangongTongji('4');
    })

    var nowTime=getNowFormatDate()
/*
    //公司考勤统计接口
    $.ajax({
        type:'get',
        url:'/attend/companyAttendance',
        dataType:'json',
        data:{
            date:nowTime
        },
        success:function (res) {
            var datas=res.data;
            var arrList=datas.list;
            if(res.flag == true){
                //出勤人员
                circleProgress(datas.userSize,datas.userAll);
                var stringNum=datas.userAll.toString()
                $('.normal').html(arrList[1].num)
                $('.weiqiandao').html(arrList[4].num)
                $('.chidao').html(arrList[6].num)
                $('.qingjia').html(arrList[10].num)
                progress_show('#prog1',stringNum,arrList[1].num,'#29cebd');
                progress_show('#prog2',stringNum,arrList[4].num,'#ffc774');
                progress_show('#prog3',stringNum,arrList[6].num,'#ff5252');
                progress_show('#prog4',stringNum,arrList[10].num,'#ca79bf');
            }
        }
    })*/
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
//    新闻发布数统计接口
    $.ajax({
        type:'get',
        url:'/news/getNewCountByType',
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
            newsTongji(dataNum);
        }
    })
//    合同到期员工统计
    $.ajax({
        type:'get',
        url:'/hr/contract/getMaturityContract',
        dataType:'json',
        data:{
            status:1
        },
        success:function (res) {
            var datas=res.obj;
            var str='';
            if(res.flag == true){
                if(datas.length>3){
                    $('.moreDaoqi').show();
                }else {
                    $('.moreDaoqi').hide();
                }
                var h = parent.document.documentElement.clientWidth;
                if(datas.length>0){
                    for(var i=0;i<datas.length;i++){
                        if(h >= 1673){
                            if(i<3){
                                str+='<li>' +
                                    '<div class="userInfo">'+
                                    '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                                    '<span class="userSpan">'+
                                    '<p>'+datas[i].userName+'</p>'+
                                    '<p>'+datas[i].userPriv+'</p>'+
                                    '</span>'+
                                    '</div>' +
                                    '<div class="userInfo2">'+
                                    '<span>'+
                                    '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
                                    '</span>'+
                                    '</div>'+
                                    '</li>'
                            }
                        }else{
                            if(i<2){
                                str+='<li>' +
                                    '<div class="userInfo">'+
                                    '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                                    '<span class="userSpan">'+
                                    '<p>'+datas[i].userName+'</p>'+
                                    '<p>'+datas[i].userPriv+'</p>'+
                                    '</span>'+
                                    '</div>' +
                                    '<div class="userInfo2">'+
                                    '<span>'+
                                    '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
                                    '</span>'+
                                    '</div>'+
                                    '</li>'
                            }
                        }

                    }
                }else{
                    str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
                        '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
                        '</li>'
                }

                $('#hetongUl').html(str);
            }
        }
    })
//    工作流统计
    $.ajax({
        type:'get',
        url:'/flowRun/queryFlowRunCount',
        dataType:'json',
        success:function(res){
            var data=res.datas
            if(res.flag == true){
                var arrFlow=[];
                for(var i=0;i<data.length;i++){
                    var arrStr=[];
                    arrStr.push(data[i].flowRunModelName);
                    arrStr.push(data[i].flowRunModelPrcsCount);
                    arrFlow.push(arrStr)
                }
                flowTongji(arrFlow)
            }
        }
    })
//    员工合同统计
    $.ajax({
        type:'get',
        url:'/hr/contract/getHrCountByType',
        dataType:'json',
        success:function (res) {
            var datas=res.data;
            if(res.flag == true){
                var dataNum=[];
                for(var key in datas){
                    var str=[];
                    str.push(key);
                    str.push(datas[key]);
                    dataNum.push(str);
                }
                hetongTongji(dataNum)
            }
        }
    })
//    员工请假统计
    $.ajax({
        type:'get',
        url:'/attendLeave/getAttendLeaveCount',
        dataType:'json',
        success:function (res) {
            var datas=res.data;
            var monthTime=[];
            var dataNum=[];
            if(res.flag == true){
                for(var i=0;i<datas.length;i++){
                    monthTime.push(datas[i].monthname);
                    dataNum.push(datas[i].id)
                }
                qingjiaTongji(monthTime,dataNum);
            }
        }
    })
//    新入职员工
    $.ajax({
        type:'get',
        url:'/hr/api/getHrStaffInfoNews',
        dataType:'json',
        success:function (res) {
            var data=res.datas;
            var str='';
            if(res.flag == true){
                var h = parent.document.documentElement.clientWidth;
                if(data.length>3){
                    if(h >= 1673){

                    }else{
                        $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
                    }
                    $('.moreXinruzhi').hide();
                }else{
                    if(h >= 1673){
                        $('.moreXinruzhi').hide();
                    }else{
                        $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
                        if(data.length == 3){
                            $('.moreXinruzhi').hide();
                        }else{
                            $('.moreXinruzhi').hide();
                        }
                    }

                }
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        if(h >= 1673){
                            if(i<3){
                                str+='<li>'+
                                    '<div class="userInfo">'+
                                    '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                                    '<span class="userSpan">'+
                                    '<p>'+data[i].userName+'</p>'+
                                    '<p>新入职员工</p>'+
                                    '</span>'+
                                    '</div>'+
                                    '<div class="userInfo2">'+
                                    '<span>'+
                                    '<span>性别：</span><span>'+function () {
                                        if(data[i].sex == '0'){
                                            return '男';
                                        }else if(data[i].sex == '1'){
                                            return '女';
                                        }
                                    }()+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>部门：</span><span>'+data[i].deptName+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
                                    '</span>'+
                                    '</div>'+
                                    '</li>';
                            }
                        }else{
                            if(i<2){
                                str+='<li>'+
                                    '<div class="userInfo">'+
                                    '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                                    '<span class="userSpan">'+
                                    '<p>'+data[i].userName+'</p>'+
                                    '<p>新入职员工</p>'+
                                    '</span>'+
                                    '</div>'+
                                    '<div class="userInfo2">'+
                                    '<span>'+
                                    '<span>性别：</span><span>'+function () {
                                        if(data[i].sex == '0'){
                                            return '男';
                                        }else if(data[i].sex == '1'){
                                            return '女';
                                        }
                                    }()+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>部门：</span><span>'+data[i].deptName+'</span>'+
                                    '</span>'+
                                    '<span>'+
                                    '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
                                    '</span>'+
                                    '</div>'+
                                    '</li>';
                            }
                        }
                    }
                }else{
                    str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
                        '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
                        '</li>'
                }
                $('#xinruzhi').html(str);
            }
        }
    })
});

//获取当前时间，格式YYYY-MM-DD
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
    return currentdate;
}

function yuangongTongji(typeNum) {
    $.ajax({
        type:'get',
        url:'/hr/api/getHrStaffInfoCount',
        dataType:'json',
        data:{
            type:typeNum
        },
        success:function(res){
            var datas=res.data;
            var dataTotal=[];
            if(res.flag == true){
                for(var key in datas){
                    var str=[];
                    str.push(key);
                    str.push(datas[key]);
                    dataTotal.push(str);
                }
                if(typeNum == '1'){
                    nianlingTongji(dataTotal);
                }else if(typeNum == '2'){
                    xingbieTongji(dataTotal);
                }else if(typeNum == '3'){
                    xueliTongji(dataTotal);
                }else if(typeNum == '4'){
                    nianxianTongji(dataTotal);
                }
            }
        }
    })
}
function nianlingTongji(data) {
    //员工统计(年龄)
    $('#containerYuangong').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 30,
                style: {
                    fontSize: '9pt',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['20-25岁', 24],
            //     ['25-30岁', 27],
            //     ['30-35岁', 4],
            //     ['35-40岁', 3],
            //     ['40-45岁', 0],
            //     ['45-50岁', 1],
            //     ['50-55岁', 0],
            //     ['55以上', 0],
            // ]
            data:data
        }]
    });
}
function xingbieTongji(data) {
    //员工统计(性别)
    $('#containerSex').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 0,
                style: {
                    fontSize: '9pt',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['男', 47],
            //     ['女', 17],
            // ]
            data:data
        }]
    });
}
function xueliTongji(data) {
    //员工统计(学历)
    $('#containerXueli').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 30,
                style: {
                    fontSize: '9pt',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['大专 ', 11],
            //     ['本科', 37],
            //     ['研究生', 3],
            //     ['博士', 1],
            // ]
            data:data
        }]
    });
}
function nianxianTongji(data) {
    //员工统计(工作年限)
    $('#containerNianxian').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 0,
                style: {
                    fontSize: '9pt',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['1年以内 ', 11],
            //     ['1-3年', 28],
            //     ['3-5年', 10],
            //     ['5年以上', 3],
            // ]
            data:data
        }]
    });
}
function noteTongji(data) {
    //公告发布统计
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 0,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '发布数量: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['项目部', 13],
            //     ['产品部', 20],
            //     ['市场部', 23],
            //     ['企管部', 18],
            // ],
            data:data,
            dataLabels: {
                enabled: true,
                // rotation: -90,
                color: '#FFFFFF',
                align: 'center',
                format: '{point.y}', // one decimal
                y: 10, // 10 pixels down from the top
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        }]
    });
}
function newsTongji(data) {
    //新闻发布统计
    $('#containerNews').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'category',
            labels: {
                rotation: 0,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: '发布数量: <b>{point.y}</b>'
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '总量',
            // data: [
            //     ['项目部', 13],
            //     ['产品部', 20],
            //     ['市场部', 23],
            //     ['企管部', 18],
            // ],
            data:data,
            dataLabels: {
                enabled: true,
                // rotation: -90,
                color: '#FFFFFF',
                align: 'center',
                format: '{point.y}', // one decimal
                y: 10, // 10 pixels down from the top
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        }]
    });
}
function flowTongji(data) {
    //    工作流统计
    $('#containerFlow').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        colors: ['#0798d1', '#00acee', '#35c4fc', '#0176a2'],
        legend: {
            layout: 'vertical', // default
            itemDistance: 50,
            align: 'right',
            verticalAlign: 'top',
            x: 0,
            y: 50
        },
        tooltip: {
            headerFormat: '{series.name}<br>',
            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f}%',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                },
                showInLegend: true
            }
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            type: 'pie',
            name: '流程类型占比',
            // data: [
            //     ['已归档流程',   13],
            //     ['正在执行流程',       20],
            //     ['已办结流程',58],
            //     ['已中断流程',    9],
            // ]
            data:data
        }]
    });
}
function hetongTongji(data) {
    //    员工合同统计
    $('#containerHetong').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        colors: ['#f6b446', '#fed61f', '#00acee', '#f7896e','#4bcc94','#42bbd1','#5072b9'],
        legend: {
            layout: 'vertical', // default
            itemDistance: 50,
            align: 'right',
            verticalAlign: 'top',
            x: 0,
            y: 50
        },
        tooltip: {
            headerFormat: '{series.name}<br>',
            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                },
                showInLegend: true
            }
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            type: 'pie',
            name: '合同类型占比',
            // data: [
            //     ['聘用合同',   13],
            //     ['实习协议',       20],
            //     ['录用合同',58],
            //     ['兼职合同',    9],
            // ]
            data:data
        }]
    });
}
function qingjiaTongji(dataMonth,dataNum) {
    //    员工请假统计
    var chart = Highcharts.chart('containerQingjia', {
        chart: {
            type: 'line'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            // categories: ['1月', '2月', '3月', '4月', '5月', '6月']
            categories:dataMonth
        },
        yAxis: {
            title: {
                text: ''
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: false          // 开启数据标签
                },
                enableMouseTracking: true, // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                showInLegend: false
            }
        },
        credits: {
            enabled: false     //不显示LOGO
        },
        series: [{
            name: '请假',
            // data: [10, 18, 19, 25, 33, 20]
            data:dataNum
        }]
    });
}

//公司考勤
function circleProgress(value,average){
    var canvas = document.getElementById("yuan");
    var context = canvas.getContext('2d');
    var _this = $(canvas),
        value= Number(value),// 当前数值
        average = Number(average),// 总数值
        color = "#80e5da",// 进度条、文字样式
        maxpercent = 100,//最大百分比,可设置
        c_width = 100,// canvas,宽度
        c_height =100;// canvas,高度
    // 判断设置当前显示颜色



    // 清空画布

    context.clearRect(0, 0, c_width, c_height);

    // 画初始圆

    context.beginPath();

    // 将起始点移到canvas中心

    context.moveTo(c_width/2+15, c_height/2+15);

    // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2，起始点0，终止点为Math.PI * 2的 整圆

    context.arc(c_width/2+15, c_height/2+15, c_height/2+15, 0, Math.PI * 2, false);

    context.closePath();

    context.fillStyle = '#68b5fb'; //填充颜色

    context.fill();

    // 绘制内圆

    context.beginPath();

    context.strokeStyle = color;

    context.lineCap = 'square';

    context.closePath();

    context.fill();

    context.lineWidth = 8.0;//绘制内圆的线宽度



    function draw(cur){

        // 画内部空白

        context.beginPath();

        context.moveTo(24, 24);

        context.arc(c_width/2+15, c_height/2+15, c_height/2+7, 0, Math.PI * 2, true);

        context.closePath();

        context.fillStyle = 'rgba(255,255,255,1)';  // 填充内部颜色

        context.fill();

        // 画内圆

        context.beginPath();

        // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2-5不与外圆重叠，

        // 起始点-(Math.PI/2)，终止点为((Math.PI*2)*cur)-Math.PI/2的 整圆cur为每一次绘制的距离

        context.arc(c_width/2+15, c_height/2+15, c_height/2-5, -(Math.PI / 2), ((Math.PI * 2) * cur ) - Math.PI / 2, false);

        context.stroke();

        // 在中间写字

        context.font = "10pt Arial";  // 字体大小，样式

        context.fillStyle = color;  // 颜色

        context.textAlign = 'center';  // 位置

        context.textBaseline = 'middle';

        context.moveTo(c_width/2+15, c_height/2+15);  // 文字填充位置

        context.fillText(value+'/'+average, c_width/2+15, c_height/2+5);

        context.stroke();

        context.fillStyle = '#666';

        context.fillText("出勤人员", c_width/2+15, c_height/2+25);

    }

    // 调用定时器实现动态效果

    var timer=null,n=0;

    function loadCanvas(nowT){

        timer = setInterval(function(){

            if(n>nowT){

                clearInterval(timer);

            }else{

                draw(n);

                n += 0.01;

            }

        },15);

    }

    loadCanvas((value/average));

    timer=null;

};

function progress_show (id,goal,raised,barColor) {
    $(id).jQMeter({
        goal:goal,
        raised:raised,
        width:'100%',
        height:'10px',
        bgColor:'#eeeeee',
        barColor:barColor,
        displayTotal:false
    });
}
function timers() {
    var timer=setTimeout(function () {
        location.reload();
    },100);
}