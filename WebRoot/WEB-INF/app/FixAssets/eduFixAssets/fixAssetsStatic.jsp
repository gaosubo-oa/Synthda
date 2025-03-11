<%--
  Created by IntelliJ IDEA.
  User: 王润
  Date: 2017/7/26
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
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
    <title>固定资产分布概况</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .headDiv {
            width: 100%;
            height: 45px;
            border-bottom: #999 1px solid;
            overflow: hidden;
        }

        .main_title li {
            width: 135px;
            height: 28px;
            line-height: 28px;
            display: inline-block;
            float: left;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            font-size: 14px;
            margin-left: 20px;
            margin-top: 10px;
            cursor: pointer;
            text-align: center;
            font-weight: 700;
            border-radius: 10px;
        }

        .main_title .title_on {
            background: #2F8AE3;
            color:white;
        }

        .head {
            margin-top: 25px;
            height: 33px;
        }

        .head .title {
            margin-left: 22px;
            font-family: STKaiti;
        }

        .head span {
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }

        .selectInp {
            width: 100%;
            min-height: 70px;
            /*height: 170px;*/
            /*line-height: 170px;*/
            font-size: 20px;
            font-family: 'simsun';
            font-weight: 500;
            margin-top:25px;
        }

        .selectInp select {
            width: 220px;
            height: 36px;
            font-size: 17px;
            border-radius: 10px;
            padding-left: 10px;
            cursor: pointer;
        }
        .selectInp span {
            margin-left: 100px;
        }

        .pieChart {
            height: 500px;
        }

        .chartDetail {
            width: 40%;
            height: 80%;
            float: left;
            margin-left: 130px;
            position: relative;
        }

        .chartDetail{
            font-size: 20px;
            font-family: 'simsun';
        }

        .pieData {
            width: 185px;
            height: 140px;
            position: absolute;
            text-align: left;
            top: 3%;
            left: -10%;
            font-size: 18px;
            line-height: 30px;
        }

        .inp {
            width: 80px;
            height: 30px;
            background: url('../../img/address/shape.png') no-repeat;
            background-color: #2d7de0;
            color: white;
            text-align: center;
            background-position: 11px 7px;
            padding-left: 10px;
            cursor: pointer;
            float: left;
            /*margin-top: 72px;*/
            margin-left: 20px;
            border-radius: 10px;
        }

        .selectWrap {
            float: left;
        }

        .selectInp .inp {
            line-height: 30px;
        }
        .main_title li img{
            margin-left: 9px;
        }
        .workPeo{
            left: -22%;
        }
    </style>
</head>
<body>
<div class="selectInp">
    <div class="selectWrap">
        <span>项目名称：</span>
        <select id="project">
            <option value="">请选择</option>
        </select>
    </div>
    <div class="selectWrap">
        <span>所在位置：</span>
        <select id="currrntLocation">
            <option value="">请选择</option>
        </select>
    </div>
    <div class="inp" id="checkOut">查询</div>
</div>
<div class="pieChart">
    <div class="chartDetail chartOne">
        <div id="people0" class="pie" style="min-width: 350px;height:360px;"></div>
        <div class="pieData projPeo">

        </div>
    </div>
    <div class="chartDetail chartTwo">
        <div id="people1" class="pie" style="min-width: 350px;height:360px;"></div>
        <div class="pieData workPeo">
        </div>
    </div>
    <div class="chartDetail chartThere">
        <div id="people2" class="pie" style="min-width: 350px;height:360px;"></div>
        <div class="pieData projPeo">

        </div>
    </div>
    <div class="chartDetail chartFour">
        <div id="people3" class="pie" style="min-width: 350px;height:360px;"></div>
        <div class="pieData projPeo">

        </div>
    </div>

</div>
</body>
<script type="text/javascript">
    (function dep_user_select() {
        $("#selectDept").on("click", function () {
            dept_id = 'deptment';
            $.popWindow("../../common/selectDept?allDept=1");
        });
        function clearDept() {
            $('#deptment').removeAttr('deptid');
            $('#deptment').attr('dataid', '');
            $('#deptment').removeAttr('deptno');
            $('#deptment').val('');
        }
        $('#clearDept').on("click",function () {
            clearDept();
        });
    })();
    $(".main_title li").eq(0).on("click",function(){
        window.location.href = "/hrPersonnelScheduling/peopleSchedulingStatistics"
    })
    $(".main_title li").eq(2).on("click",function(){
        window.location.href = "/hrPersonnelScheduling/peopleSchedulingList"
    })
    $(function () {
        untilAjax();
        function untilAjax(projectId,currrntLocation){
            $('#people0').html('');
            $('#people1').html('');
            $('#people2').html('');
            $('#people3').html('');
            $.ajax({
                type: 'get',
                url: '/eduFixAssets/eduFixAssetsStatistical',
                dataType:'json',
                data:{
                    projectId:projectId,
                    currrntLocation: currrntLocation
                },
                success: function (res) {
                    for(var i =0; i< res.object.length;i++){
                        var Arr = [];
                        for(var x in res.object[i]){
                            Arr.push([x,res.object[i][x]])
                        }
                        var set = new Set(Arr);
                        var chooseArr = Array.from(set);
                        projectPeople(res.obj[i],chooseArr,'people'+i);
                    }

                }
            });
        }
        //项目名称
        $.ajax({
            type: 'get',
            url: "/crashParent/showAllTree",
            // data: {"parentNo": "PROJECT_NAME"},
            success: function (data) {
                for (var x = 0; x < data.length; x++) {

                    var children = data[x].children
                    if(children !=undefined){
                        for(var i=0;i<children.length;i++){
                            $("#project").append("<option value=" + children[i].id + ">" + children[i].name + "</option>")
                        }
                    }else{
                        $("#project").append("<option value=" + data[x].id + ">" + data[x].name + "</option>")
                    }



                }

            }
        });
        //所在位置
        $.ajax({
            type: 'get',
            url: "/code/getCode",
            data: {"parentNo": "LOCATION_ADDRESS"},
            success: function (data) {
                for (var x = 0; x < data.obj.length; x++) {
                    $("#currrntLocation").append("<option value=" + data.obj[x]["codeId"] + ">" + data.obj[x]["codeName"] + "</option>")
                }
            }
        });
        /*$.ajax({
            type: 'get',
            url: "/eduFixAssets/getCurrrntLocation",
            success: function (data) {
                for (var x = 0; x < data.obj.length; x++) {
                    $("#currrntLocation").append("<option value=" + data.obj[x] + ">" + data.obj[x] + "</option>")
                }
            }
        });*/
        function projectPeople(text,data,id) {
            $("#"+id).highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                title: {
                    text: text,
                    align:'left',
                    x:100,
                    margin:20
                },
                colors: ['rgb(68,175,228)', 'rgb(227,68,69)', 'rgb(76,217,64)','yellow','purple','pink','gray'],
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
                            // format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            format: '<b>{point.name}</b>: {point.y}个',
                            style: {
                                color: 'red'
                            }
                        },
                        y:20,
                        showInLegend: true
                    }
                },
                credits: {
                    enabled: false     //不显示LOGO
                },
                series: [{
                    type: 'pie',
                    name: '百分比',
                    data:data
                }]
            });
        };
        $("#checkOut").on("click",function () {
            var project = $('#project option:selected').val();
            var currrntLocation = $('#currrntLocation option:selected').val();
            untilAjax(project,currrntLocation);
        });
    });
</script>
</html>
