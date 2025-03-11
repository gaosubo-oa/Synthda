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
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../../js/base/base.js"></script>
    <script type="text/javascript" src="../../../js/ewx/waterMark.js?20190819.2"></script>
    <script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>
    <link href="../../lib/mui/mui/mui.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../css/diary/m/diary_base.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        .statistics {
            display: flex;
            flex-direction: column;
            flex: 13;
            overflow: auto;
            display: none;
        }
        .sbox {
            display: flex;
            flex-direction: column;
            flex: 13;
            height: 85%;
        }
        .nav {
            display: flex;
            box-sizing: border-box;
            flex-direction: column;
            align-items: center;
            flex: none;
        }
        .select {
            border: 1px solid #ddd;
            display: flex;
            width: 30%;
            border-radius: 0.15rem;
            overflow: hidden;
            margin-top: 0.4rem;
        }
        .select .native {
            background: #5576ab;
            color: #fff;
        }
        .select div {
            box-sizing: border-box;
            padding: 5px;
            flex: 1;
            justify-content: center;
            align-items: center;
            font-size: 12px;
            letter-spacing: 0.06rem;
            color: #5576ab;
            display: flex;
        }
        .querys {
            background: #5576ab;
            color: #fff;
            font-size: 12px;
            box-sizing: border-box;
            float: right;
            margin-right: 20px;
            flex: 1;
            padding: 6px 10px;
            margin-right: 20px;
            flex: 1;
            position: absolute;
            right: 0px;
            border-radius: 3px;
            top: 6px;
        }
        .daily {
            display: flex;
            flex-direction: column;
            width: 100%;
        }
        .damoye {
            font-size: 13px;
            align-items: center;
            box-sizing: border-box;
            justify-content: space-between;
            padding: 0rem 5rem;
            letter-spacing: 0.03rem;
            display: flex;
        }
        .damoye .dative {
            border-bottom: 0.1rem solid #fe9900;
            color: #fea942;
        }
        .damoye div {
            box-sizing: border-box;
            padding: 10px 34px 10px 14px;
        }
        .date {
            display: flex;
            border-top: 1px solid #000;
            background: #feb74c;
            color: #fff;
            font-size: 12px;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
            padding: 7px;
            width: 100%;
        }
        .pic {
            display: flex;
            width: 100%;
            flex: none;
            height: 50%;
        }

        .noComNum,.noReadNum {
            position: absolute;
            right: 0px;
            top: 0px;
            background: #F81901;
            color: #fff;
            border-radius: 50%;
            width: 17px;
            text-align: center;
            padding: 4px;
            display: none;

        }
        .bomoye {
            display: flex;
            align-items: center;
            box-sizing: border-box;
            justify-content: space-between;
            font-size: 12px;
            padding: 0rem 5rem;
            letter-spacing: 0.03rem;
        }
        .bomoye .dative {
            border-bottom: 0.1rem solid #fe9900;
            color: #fea942;
        }
        .bomoye div {
            box-sizing: border-box;
            padding: 0.3rem 0.1rem 0.3rem 0.4rem;
        }
        .res {
            padding: 9px 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 12px;
        }
        .report div {
            border-bottom: 1px solid #ddd;
            box-sizing: border-box;
        }
        .bottom {
            flex: 1;
            display: flex;
            box-sizing: border-box;
            border-top: 1px solid #000;
            width: 100%;
            background: #fff;
            padding: 0.3rem;
            z-index: 2;
            position: fixed;
            bottom: 0;
        }
        .bottom div {
            display: flex;
            box-sizing: border-box;
            flex-direction: column;
            flex: 1;
            justify-content: center;
            align-items: center;
        }
        .bottom img {
            width: 35px;
            display: block;
        }
        .bottom span {
            font-size: 12px;
        }
        .report {
            box-sizing: border-box;
            padding: 0 0.3rem;
            display: flex;
            flex-direction: column;
            border-top: 1px solid #000;
        }
        #no_subordinate .lst-item span:last-child {
            width: 20%;
            text-align: center;
            background-color: #5576ab;
            color: white;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        .btns {
            width: 100%;
            background: #1772c0;
            text-align: center;
            color: #fff;
            padding: 7px;
            border-radius: 3px;
            margin-bottom: 7px;
        }
        #no_subordinate {
            margin-bottom: 65px;
        }
    </style>
</head>

<body>
<div class="statistics" style="overflow: auto;display: flex;height: 100%;">
    <div class="sbox">
        <div class="nav">
            <div class="select">
                <div class="native next">下属</div>
                <div class="mine">我的</div>
            </div>
            <div class="querys">搜索</div>
            <div class="daily">
                <div class="damoye">
                    <div  style="position:relative">
                        日报
                        <div style="position:absolute;right:-30px;top:0px;"><span class="green" style="display:block;"></span></div>
                    </div>
                    <div class="dative" style="position:relative">
                        周报
                        <div style="position:absolute;right:-30px;top:0px;"><span class="green" style="display:block;"></span></div>
                    </div>
                    <div style="position:relative">
                        月报
                        <div style="position:absolute;right:-30px;top:0px;"><span class="green" style="display:block;"></span></div>
                    </div>
                </div>
                <input type='hidden' name='diary_type' id="diary_type" value='1' />
            </div>
            <div class="date"></div>
        </div>

        <!-- 统计图 -->
        <div class="pic">
            <div id="main" style="width: 100%;height: 100%"></div>
            <div id="mains" style="width: 100%;height: 100%"></div>
        </div>

        <div class="bots" style="display:none;">
            <div class="bomoye">
                <div class="dative" r_flg='1' id='already'>已汇报</div>
                <div r_flg='0' id='not'>未汇报</div>
            </div>
            <div class="report reported" id="yes_reported">
                <!--<div class="res"><span>2019-03-14</span><span>已汇报</span></div>-->
            </div>
            <div class="report noreported" id="no_reported" style='display:none;'>
                <!--<div class="res"><span>2019-03-15</span><span>未汇报</span></div>-->
            </div>
        </div>

        <div class="bots1" style="">
            <div class="bomoye">
                <div class="dative" r_flg='1' id='sub'>已汇报</div>
                <div r_flg='0' id='subs'>未汇报</div>
            </div>
            <div class="report reported" id='yes_subordinate'>
                <!--<div class="res"><img src="/static/diary/img/tx.png" alt=""><span>系统管理员</span><span>已汇报</span></div>-->
            </div>
            <div class="report noreported" id='no_subordinate' style='display:none;'>
                <!--<div class="res"><img src="/static/diary/img/tx.png" alt=""><span>张三</span><span>未汇报</span></div>-->
            </div>
        </div>

    </div>
    <div class="bottom">
        <div class="manage"><img src="/img/diary/m/gl_.png" alt=""><span>管理</span></div>
        <div class="stat"><img src="/img/diary/m/tj.png" alt=""><span>统计</span></div>
    </div>
</div>
</body>

</html>
<script type="text/javascript" charset="gbk">
    var year = new Date().getFullYear() ;
    var month = new Date().getMonth()+1;
    $('.date').html(''+year+'-'+month)
    //跳转统计页
    $('.stat').click(function() {
        $('.manage img').attr("src", '/img/diary/m/gl_.png');
        $('.stat img').attr("src", '/img/diary/m/tj.png');
        location.href = "/ewx/reportStatis"
    })
    $('.manage').click(function() {
        $('.manage img').attr("src", '/img/diary/m/gl.png');
        $('.stat img').attr("src", '/img/diary/m/tj_.png');
        location.href = "/ewx/diaryIndex"
    })
    var diary_type = 1;
    var allData = {};
    //跳转到日志详情页
    function consult(did) {
        location.href = "/ewx/consult?id=" + did;
    }

    //跳转到下属汇报列表页
    function subordinate(userId, diaType) {
        location.href = "/ewx/iStartedList?type=initiated&userId=" + userId + "&diaType=" + diaType;
    }

    //跳转到新建日志页
    function add() {
        location.href = "/ewx/diaryCreate?type=add";
    }

    //创建群聊功能
    function add_group(user_ids) {
        //当前登陆人（群主）
        var user_id = 'wudaoquan';
        //当前模式 0日报	1周报	2月报
        var diary_type = $("#diary_type").val();
        $.ajax({
            url: "/pda/diary/data/data.php",
            type: "POST",
            dataType: 'json',
            data: {
                flag: "26",
                user_id: user_id,
                user_ids: user_ids,
                diary_type: diary_type
            },
            success: function(data) {
                if (data == 0) {
                    layer.msg("创建成功！", {
                        time: 1000
                    });
                } else {
                    layer.msg("创建失败！", {
                        time: 1000
                    });
                }
            }
        });
    }

    //单个人提醒功能
    function remind(userId, date, userName) {
        //当前模式 0日报	1周报	2月报
        var diaType = $("#diary_type").val();
        $.ajax({
            url: "/diary/submitNotice",
            type: "POST",
            dataType: 'json',
            data: {
                toId: userId,
                diaDate: date,
                diaType: diaType
            },
            success: function(data) {
                if (data.flag) {
                    layer.msg("已提醒该用户！", {
                        time: 800
                    });
                } else {
                    layer.msg("提醒失败！", {
                        time: 1000
                    });
                }
            }
        });
    }

    $(function() {
        $('#main').width($('.pic').width())
        $('#mains').width($('.pic').width())
        $('#main').height($('.pic').height())
        $('#mains').height($('.pic').height())
        var DiaryType = 3;
        loading_data(function() {

            var myChart = echarts.init(document.getElementById('main'));
            myChart.setOption(staMine(allData.me));

            var myCharts = echarts.init(document.getElementById('mains'));

            if (allData.lower.sum && JSON.stringify(allData.lower.sum) != '{}') {
                myCharts.setOption(staSubordinates(allData.lower));
            }

        });
        //我的统计图
        function staMine(data){
            moption = {
                tooltip: {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
                legend: {
                    orient: 'vertical',
                    left: 'right',
                    data: ['未汇报','已汇报'],
                    textStyle:{fontSize:20}
                },
                series : [
                    {
                        name: '2019',
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '50%'],
                        data:[
                            {value:Number(data.not), name:'未汇报'},
                            {value:Number(data.already), name:'已汇报'},
                        ],
                        color: ['#c03636', '#759e84'],
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            },
                            normal:{
                                label:{
                                    textStyle:{
                                        fontSize:16
                                    }
                                }
                            }
                        }
                    }
                ]
            };
            return moption;
        }
        //下属统计图
        function staSubordinates(data){

            var yiArr = [];
            var weiArr = [];
            var xzhou = data.sum.data.slice(0,data.sum.data.length-1);
            xzhou = xzhou.split(',');

            for(var i=0;i<xzhou.length;i++){
                for(var key in data.sum){

                    if(xzhou[i] == key){
                        yiArr.push(Number(data.sum[key].yi));
                        weiArr.push(Number(data.sum[key].wei));
                    }
                }
            }

            zheoption = {
                tooltip : {trigger: 'axis',axisPointer: {type: 'cross',label: {backgroundColor: '#6a7985'}}},
                legend: {data:['未提交','已提交']},
                minInterval:1,
                grid: {left: '3%',right: '4%',bottom: '3%',containLabel: true},
                xAxis : [{type : 'category',boundaryGap : false,
                    data : xzhou
                }],
                yAxis : [{type : 'value'}],
                series : [
                    {
                        name:'未提交',
                        type:'line',
                        color:['#d59178'],
                        label: {normal: {show: true,position: 'top'}},
                        areaStyle: {normal: {}},
                        data:weiArr
                    },
                    {
                        name:'已提交',
                        type:'line',
                        color:['#91ab9e'],
                        label: {normal: {show: true,position: 'top'}},
                        areaStyle: {normal: {}},
                        data:yiArr
                    }
                ]
            };
            return zheoption;
        }

        //加载数据
        function loading_data(fn) {
            //当前模式 0日报	1周报	2月报
            var diary_type = $("#diary_type").val();
            $.ajax({
                url: "/diary/mobileTerminalMySubordinatesOrReportStatistic",
                type: "POST",
                dataType: 'json',
                data: {
                    diaType: DiaryType
                },
                success: function(data) {
                    if (data.flag) {
                        var data = data.object
                        $('.green').eq(0).html("（" + data.sum.alreadyDiary + "）")
                        $('.green').eq(1).html("（" + data.sum.alreadyWeekly + "）")
                        $('.green').eq(2).html("（" + data.sum.alreadyMonthly + "）")

                        //我的已汇报
                        var str = "";
                        for (var i = 0; i < data.me.reported.length; i++) {
                            var item = data.me.reported[i];
                            str += '<div class="res" onclick="consult(' + item.diaId + ');"><span>' + item.diaDate + '</span><span>已汇报</span></div>';
                        }
                        if (str == "") {
                            str = '<div class="res"><span>暂无汇报日志</span><span></span></div>';
                        }
                        $("#yes_reported").html(str);

                        //我的未汇报
                        var str = "";
                        for (var i = 0; i < data.me.no_report.length; i++) {
                            var item = data.me.no_report[i];
                            str += '<div class="res" onclick="add();"><span>' + item.diaDate + '</span><span>未汇报</span></div>';
                        }
                        if (str == "") {
                            str = '<div class="res"><span>已完成汇报</span><span></span></div>';
                        }
                        $("#no_reported").html(str);



                        //下属的已汇报
                        var str = "";
                        for (var i = 0; i < data.lower.subordinate.length; i++) {
                            var item = data.lower.subordinate[i];
                            str += '<div class="res" onclick="subordinate(\'' + item.userId + '\',' + diary_type + ');" style="cursor: pointer;">' +
                                '<span style="width: 50%;text-align: left;cursor: pointer;">' + item.userName + '</span>' +
                                '<span style="width: 25%;text-align: center;"></span><span style="width: 10%;text-align: right;">已汇报</span></div>';
                        }
                        if (str == "") {
                            str = '<div class="res"><span>暂无人员汇报</span><span></span></div>';
                        }
                        $("#yes_subordinate").html(str);

                        //下属的未汇报
                        var str = "";
                        for (var i = 0; i < data.lower.subordinates.length; i++) {
                            var item = data.lower.subordinates[i];
                            str += '<div class="res lst-item"><span onclick="subordinate(\'' + item.userId + '\',' + diary_type + ')" style="width: 50%;cursor: pointer;" userName="' + item.userName +'">' + item.userName + '</span><span style="width: 25%;">' + item.diaDate;
                            str += '</span><span onclick="remind(\'' + item.userId + '\',\'' + item.diaDate + '\',\'';
                            str += item.userName + '\')" style="width: 10%;cursor: pointer;">通知</span></div>';
                        }
                        //拼接创建企业微信聊天群
                        // if (str != "") {
                        //     str += '<div class="res btns" onclick="add_group(\'' + data.lower.userBottomIds + '\');"><span style="width:100%;letter-spacing:3px;">创建群聊</span></div>';
                        // }
                        if (str == "") {
                            str = '<div class="res"><span>所有人员已汇报</span><span></span></div>';
                        }
                        $("#no_subordinate").html(str);

                        var already = data.me.already; //我的本月已汇报总数
                        var not = data.me.not; //我的本月未汇报总数
                        var sub = data.lower.sub; //下属本月已汇报总数
                        var subs = data.lower.subs; //下属本月未汇报总数

                        $("#already").html("已汇报（" + already + "）");
                        $("#not").html("未汇报（" + not + "）");
                        $("#sub").html("已汇报（" + sub + "）");
                        $("#subs").html("未汇报（" + subs + "）");

                        allData = data;

                        if (typeof fn == 'function') {
                            fn();
                        }
                    } else {
                        layer.msg("加载失败！", {
                            time: 800
                        });
                        return false;
                    }
                }
            });
        }
        $('#main').hide();
        $(".querys").click(function() {
            window.location.href = "/ewx/logQuery";
        }); //日志查询
        // 下属
        $('.next').click(function() {
            $(this).addClass('native').siblings('div').removeClass('native');
            $('.damoye').children().eq(1).addClass('dative').siblings('div').removeClass('dative');
            $('.bots1 .bomoye').find('div').eq(0).addClass('dative').siblings('div').removeClass('dative');

            if ($('.bomoye').children(":first").attr('r_flg') == '1') {

                $('.reported').show();
                $('.noreported').hide();
            } else {
                $('.reported').hide();
                $('.noreported').show();
            }
            $('.damoye').show();
            $('#main').hide();
            $('#mains').show();
            $('.bots').hide();
            $('.bots1').show();

            // $("#diary_type").val('0');
            loading_data(function() {
                var myChart = echarts.init(document.getElementById('main'));
                myChart.setOption(staMine(allData.me));

                var myCharts = echarts.init(document.getElementById('mains'));
                if (allData.lower.sum && JSON.stringify(allData.lower.sum) != '{}') {
                    myCharts.setOption(staSubordinates(allData.lower));
                }

            });
        })
        // 我的
        $('.mine').click(function() {
            $(this).addClass('native').siblings('div').removeClass('native');
            $('.bots').show();
            $('.bots1').hide();
            $('#main').show();
            $('#mains').hide();
            $('.bomoye').children(":first").addClass('dative').siblings('div').removeClass('dative');
            if ($('.bomoye').children(":first").attr('r_flg') == '1') {
                $('.reported').show();
                $('.noreported').hide();
            } else {
                $('.reported').hide();
                $('.noreported').show();
            }

            var bows = 'liuqiaoyan,'

            if (bows) {
                $('.damoye').hide();
                $("#diary_type").val(DiaryType);
                loading_data(function() {

                    var myChart = echarts.init(document.getElementById('main'));
                    myChart.setOption(staMine(allData.me));

                    var myCharts = echarts.init(document.getElementById('mains'));
                    if (allData.lower.sum && JSON.stringify(allData.lower.sum) != '{}') {
                        myCharts.setOption(staSubordinates(allData.lower));
                    }

                });
            } else {
                loading_data();
            }
        })

        //日报、周报、月报样式样式切换
        $('.damoye>div').click(function(e) {
            $(this).addClass('dative').siblings('div').removeClass('dative');
            var data = $(this).text();
            //选择模式 0日报	1周报	2月报

            if (data.indexOf("周报") >= 0) {
                DiaryType = 3;
            } else if (data.indexOf("月报") >= 0) {
                DiaryType = 4;
            } else {
                DiaryType = 1;
            }
            //更新文本框的值用于接口后台判断
            $("#diary_type").val(DiaryType);
            loading_data(function() {
                var myChart = echarts.init(document.getElementById('main'));
                myChart.setOption(staMine(allData.me));
                var myCharts = echarts.init(document.getElementById('mains'));
                if (allData.lower.sum && JSON.stringify(allData.lower.sum) != '{}') {
                    myCharts.setOption(staSubordinates(allData.lower));
                }
            });
        });

        //已汇报、未汇报样式切换
        $('.bomoye div').click(function() {
            $(this).addClass('dative').siblings('div').removeClass('dative');
            if ($(this).attr('r_flg') == '1') {
                $('.reported').show();
                $('.noreported').hide();
            } else {
                $('.reported').hide();
                $('.noreported').show();
            }
        });

        var bows = 'bitesta,'
        if (bows == "") {

            $('.mine').addClass('native').siblings('div').removeClass('native');
            $('.bots').show();
            $('.bots1').hide();
            $('#main').show();

            $('#mains').hide();
            $("#diary_type").val(DiaryType);
            $('.damoye').hide();


            loading_data()

        }
    })
</script>

