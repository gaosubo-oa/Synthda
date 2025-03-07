<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
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
    <title>常规工作统计</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdn.hcharts.cn/highcharts/highcharts.js"></script>
    <style>
        .head{
            margin-top: 10px;
            height: 33px;
        }
        .head .title{
            margin-left: 22px;
        }
        .head span{
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }
        label select{
            width: 130px;
            padding-left: 10px;
            height: 32px;
        }
        .fl input{
            padding: 0 10px;
            width: 130px
        }
        #export,#allexport,#allsearch,#alldelete{
            margin-left: 10px;
            border: 1px solid #2b7edf;
            color: #ffffff;
            background-color: #2b7edf;
            cursor: pointer;
            height: 28px;
            border-radius: 5px;
            width: 80px;
            height: 30px;
        }
        #export,#allexport{
            background-color: #0cae32;
            border: 1px solid #0cae32;
            color: #ffffff;
        }
        #export:hover,#allexport:hover{
            background-color: #17bb3e;
            border: 1px solid #17bb3e;

        }
        #alldelete{
            border: 1px solid #ef4747;
            color: #ffffff;
            background-color: #ef4747;
        }
        #alldelete:hover{
            border: 1px solid #fe4f4f;
            color: #ffffff;
            background-color: #fe4f4f;
        }
        #allexport{
            width: 110px;
        }
        #allsearch{
            width: 110px;
        }
        #end{
            background: #00a0e9;
            margin-left: 10px;
            padding: 5px 1px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }
        .Query{
            background: #2b7edf;
            margin-left: 10px;
            padding:5px 1px;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            width: 80px;
            height: 30px;
        }
        #allsearch:hover, .Query:hover{
            background-color: #3b8eef;
        }
        #pagediv #pageTbody input[name="checkbox"]{
            display: inline-block;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            font-weight: normal;
            overflow: hidden;
            white-space: pre;
            height: 40px;
            padding:4px;
            box-sizing: border-box;
            text-overflow: ellipsis;
            font-size: 11pt;
            text-align: left;
            border-right: 1px solid #ddd;
        }
        .sel{
            width:165px;
            max-height:250px;
            position: absolute;
            top:31px;
            left:60px;
            overflow: auto;
            background: #fff;
            border:1px solid #e2e3e3;
            display: none;
        }
        .sel li{
            line-height: 24px;
            color: #000;
        }
        a:focus{outline:none;}
        #list{
            width:40px;
            height:32px;
            background: #f3f3f3;
            border:1px solid #ccc;
            vertical-align: middle;
            position: absolute;
            right: 0px;
            top: 0px;
            border-radius: 0px 3px 3px 0px;
        }
        #list img{
            margin-top: -2px;
            margin-left: 0px;
        }
        .canchoose:hover{
            background: #2b7edf;
            color: #fff;
        }
        .ones{
            list-style-type:disc;
        }
        .fl .radio{
            height: 15px;
            width: 20px;
        }

        #graph{
            /*padding: 0 20px;*/
        }

        .pagediv .page-top-inner-layer{
            padding-right: 0;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<script>
    $(function(){
        $('#displayBtn').click(function () {
            if($('#more_div').css("display")=="none"){
                $('#more_div').css("display","block");
                $("#displayBtn").text("<fmt:message code="main.th.Stop"/>");
            }else {
                $('#more_div').css("display","none");
                $('#more_div').css("height","0px");
                $("#displayBtn").text("<fmt:message code="email.th.more"/>");
            }
        })
    });
</script>

<body>
<div class="head">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png"><span style="">常规工作统计</span>
    </div>
</div>
<div style="margin: 0 auto;width: 97%;height: 210px; ">

    <div id="more_div" style="padding-bottom: 37px;margin-top: 10px" >
        <%--流程发起日期--%>
        <label class="fl clearfix" >
            <span class="fl" style="margin-top: 6px;">工作接收时间：</span>
            <label class="fl">
                <input  name="beginDate" placeholder=""  type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"/>
                &nbsp;&nbsp;<fmt:message code="global.lang.to"/>&nbsp;&nbsp;
                <input  name="endDate" placeholder=""  type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"/>
            </label>
        </label>


    </div>


    <div style="float: left;width: 500px">
        <label class="clearfix">
            <input class="radio" type="radio" name="types" value="0" checked>按人员统计
        </label>
        <div>
            <span class="fl" style="margin-top: 6px;">指定人员：</span>
            <textarea id="users"  cols="40" rows="3" readonly></textarea>
            <a href="javascript:;" style="color: green" class="addusers">添加</a>
            <a href="javascript:;" style="color: red" class="clear">清空</a>
        </div>
    </div>

    <div style="float: left;width: 500px;">
        <label class="clearfix">
            <input class="radio" type="radio" name="types" value="1">按部门统计
        </label>
        <div>
            <span class="fl" style="margin-top: 6px;">指定部门：</span>
            <textarea id="demt"  cols="40" rows="3" readonly></textarea>
            <a href="javascript:;" style="color: green" class="adddemt">添加</a>
            <a href="javascript:;" style="color: red" class="clear">清空</a>
        </div>


        <div class="fl clearfix" style="margin-left: 10px;margin: 20px 0;" >
            <button  type="button" class="Query fl queryBtn">
                <img src="../../img/workflow/worksearch1.png" style="margin-right: 2px;margin-left:5px;margin-bottom: 1px;">
                <span style="margin-right: 5px;"><fmt:message code="global.lang.query"/></span>
            </button>
            <%--<button type="button1"  class="Query fl" id="displayBtn" ><fmt:message code="email.th.more"/></button>--%>
            <button type="button"  class="export fl" id="export" >
                <img src="../../img/workflow/workdc1.png" style="margin-right: 2px;margin-left:5px;margin-bottom: 1px;">
                <%--<img src="../../img/workflow/workdc.png" style="margin-right: 2px;margin-left:5px;margin-bottom: 1px;">--%>
                <span style="margin-right: 5px;"><fmt:message code="global.lang.report"/></span>
            </button>


        </div>
    </div>
</div>

<div class="showbx" style="display: none">
    <div style="padding: 0 25px">
        <ul class="nav nav-tabs">
            <li role="presentation" class="active" type="0"><a href="#">数据报表</a></li>
            <li role="presentation" type="1"  status="0"><a href="#">图形报表</a></li>
        </ul>
    </div>
    <div id="pagediv">

    </div>

    <div id="graph" style="display: none">
        <div id="container" style="min-width:90%;height:400px"></div>
    </div>

</div>
</body>
<script>
    var arrys = [];
    $('.nav-tabs').on('click','li',function(){
        var that = $(this);
        $(this).addClass('active');
        $(this).siblings().removeClass('active');
        if($(this).attr('type')==0){
            $('#pagediv').show();
            $('#graph').hide();
        }else {
            $('#pagediv').hide();
            $('#graph').show();

            if($(this).attr('status')==0){
                var types = $("input[name='types']:checked").val()
                var data ={};
                data.pageSize = 5;
                data.page = 1;
                data.useFlag='true';
                if(types == 0){
                    data.userIds=$('#users').attr('user_id');
                } else {
                    data.deptIds=$('#demt').attr('deptid');
                }
                data.beginDate=$('[name="beginDate"]').val();
                data.endDate=$('[name="endDate"]').val();

                $.ajax({
                    type:'post',
                    data:data,
                    url:'/FlowRunFu/changTong',
                    dataType:'json',
                    success:function(res){
                        arrys = res.datas;

                        that.attr('status','1');
                        var name = [];//用户名
                        var tQCounts = [];//提前办结数量
                        var aSEndCounts = [];//按时办结数量
                        var cSEndCounts = [];//超时办结数量
                        var aSCounts = [];//按时办理中数量
                        var cSCounts = [];//超时办理中数量
                        var shuliang = [];//总数

                        for(var i=0;i<arrys.length;i++){
                            name.push(arrys[i].userName);
                            tQCounts.push(arrys[i].tiqianbanjie);
                            aSEndCounts.push(arrys[i].anshibanjie);
                            cSEndCounts.push(arrys[i].chaoshibanjie);
                            aSCounts.push(arrys[i].anshibanli);
                            cSCounts.push(arrys[i].chaoshibanli);
                            shuliang.push(Number(arrys[i].count));
                        }
                        console.log(name)

                        var chart = Highcharts.chart('container', {
                            chart: {type: 'column'},
                            title: {text: ' '},
                            xAxis: {
                                categories: name,
                                title: {text: null}
                            },
                            yAxis: {
                                min: 0,
                                title: {text: ' '},
                                labels: {overflow: 'justify'}
                            },
                            credits: {enabled:false},
                            plotOptions: {
                                bar: {
                                    dataLabels: {
                                        enabled: true,
                                        allowOverlap: true // 允许数据标签重叠
                                    }
                                }
                            },
                            legend: {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'top',
                                x: -40,
                                y: 100,
                                floating: true,
                                borderWidth: 1,
                                backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                                shadow: true
                            },
                            series: [{
                                name: '总数',
                                data: shuliang
                            }, {
                                name: '提前办结',
                                data: tQCounts
                            }, {
                                name: '按时办结',
                                data: aSEndCounts
                            }, {
                                name: '超时办结',
                                data: cSEndCounts
                            }, {
                                name: '按时办理',
                                data: aSCounts
                            }, {
                                name: '超时办理',
                                data: cSCounts
                            }]
                        });
                    }
                })


            }
        }
    })

    function onblus(x) {
        // 清除两边的空格
        String.prototype.trim = function() {
            return this.replace(/(^\s*)|(\s*$)/g, '');
        };
        var inputStr = x;//用于存放输入的字符串
        if(!inputStr || !inputStr.trim() || isNaN(inputStr)){
            //输入的不是数字
            <%--alert("<fmt:message code="doc.th.number"/>");--%>
        }
    }



    $("#addUser").on("click",function(){
        user_id='userId';
        $.popWindow("../common/selectUser?0");
    });
    $("#clearUser").on("click",function(){
        $("#userId").val("");
        $("#userId").attr('user_id','');
    })

    $("#status").change(function () {
        var str=this.value;
        if(str==5 || str==6){
            $('#userId').css("display","inline-block");
            $('#addUser').css("display","inline-block");
            $('#clearUser').css("display","inline-block");
        }else{
            $('#userId').css("display","none");
            $('#addUser').css("display","none");
            $('#clearUser').css("display","none");
        }
    })
    $(document).click(function(){
        $('.sel').hide()
    })

    $('#list').click(function(e){
        e.stopPropagation()
        if( $('.sel').css('display')!='none'){
            $('.sel').hide()
        }else{
            $('.sel').show()
        }

    })
    $('[name="flowName"]').keyup(function(){
        $('.sel').show()
        var val=$(this).val()
        $('.sel li').each(function(i,v){
//            console.log(v.innerHTML)
            if(v.innerHTML.indexOf(val)>-1){
                $(v).show();
                $(v).parent().show()
            }else{
                $(v).hide();
            }
        })

    })

    $('.sel').on('click','li',function(e){
        e.stopPropagation()
        if($(this).attr('value')){
            $('[name="flowName"]').val($(this).html())
            $('[name="flowName"]').attr('dataType',$(this).attr('value'))
            $('.sel').hide()
        }else{
            $('.sel').show()
        }
    })

    function buildNode(len,data){
        var prefix = 10;
        for(var i=0;i<len;i++){
            prefix += 10;
        }

        $.each(data,function(i,item){
            if(0 < item.childs.length){
                $('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
                $.each(item.flowTypeModels,function(j,v){
                    $('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
                })
                buildNode(len+1,item.childs);
            }else{
                $('.sel').append("<li style='padding-left:"+(prefix)+"px;font-weight:bold;font-size:14px;' id="+item.sortId +">" + item.sortName + "<li>");
                $.each(item.flowTypeModels,function(j,v){
                    $('.sel').append("<li style='padding-left:"+(prefix+10)+"px;cursor:pointer' class='canchoose' value="+v.flowId +">" +  v.flowName + "<li>");
                })
            }
        });
    }

</script>
<script src="/js/efficiency/routineWorkStatistic.js"></script>
</html>
