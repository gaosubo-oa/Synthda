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
    <title>计算公式设置</title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="/css/base.css" />
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    .content{
        width:80%;
        margin:20px auto;
    }
    .fl{
        float:left;
        width:50%;
    }
    .cl{
        clear:both;
    }
    .h2,.btn{
        height:50px;
        line-height: 50px;
        text-align: center;
        border:1px solid #eee;
        color: #2F5C8F;
        background: #ddd;


    }
    .btn{
        border:none;
        background: #fff;
    }
    .btn_ {
        width:100px;
        height: 40px;
        padding-left: 10px;
        margin-top:25px;
        font-size: 14px;
        cursor: pointer;
        background: url(/img/save.png) no-repeat;
    }
    .num{
        width:80px;
    }
    .unit{
        width:50px;
    }
    .con{
        line-height: 30px;
    }
    .left,.right{
        box-sizing: border-box;
        border:1px solid #eee;
        padding:20px;

    }
</style>

</head>
<body>
<div class="content">
    <h2 class="h2">重点工作公式设置</h2>
    <div class="fl left">
        <div class="tit">
            <span>办理中工作提醒时间点：</span>
            <input class="num"  num="1" id="date1" type="number" min="0" value="">
            <select name="" id="unit1" class="unit">
                <option value="%">%</option>
                <option value="h">小时</option>
            </select>
        </div>
        <div class="con">
            当剩余时间 ＞ 所需工时的<span id="a1"></span> 时，显示为:<img src="/img/efficiency/greencir.png"/> 未提醒办理中；<br/>
            当所需工时的<span id="b1"></span>≥ 剩余时间 ≥ 0 时，显示为：<img src="/img/efficiency/yellowcir.png"/>  已提醒办理中；<br/>
            当剩余时间 ＜ 0 时，显示为：<img src="/img/efficiency/redcir.png"/>  已超时办理中。
        </div>
    </div>
    <div class="fl right">
        <div class="tit">
            <span>已办结工作提前办结时间点：</span>
            <input class="num" num="2" id="date2" type="number" min="0" value="">
            <select name="" id="unit2" class="unit">
                <option value="%">%</option>
                <option value="h">小时</option>
            </select>
        </div>
        <div class="con">
            当剩余时间 ＞ 所需工时的<span id="a2"></span> 时，显示为:<img src="/img/efficiency/greenstar.png"/> 未提醒办理中；<br/>
            当所需工时的<span id="b2"></span>≥ 剩余时间 ≥ 0 时，显示为：<img src="/img/efficiency/yellowstar.png"/>  已提醒办理中；<br/>
            当剩余时间 ＜ 0 时，显示为：<img src="/img/efficiency/redstar.png"/>  已超时办理中。
        </div>
    </div>
    <div class="cl"></div>
    <h2 class="h2">常规工作公式设置</h2>
    <div class="fl left">
        <div class="tit">
            <span>办理中工作提醒时间点：</span>
            <input class="num" num="3" id="date3" type="number" min="0" value="">
            <select name="" id="unit3" class="unit">
                <option value="%">%</option>
                <option value="h">小时</option>
            </select>
        </div>
        <div class="con">
            当剩余时间 ＞ 所需工时的<span id="a3"></span> 时，显示为:<img src="/img/efficiency/greencir.png"/> 未提醒办理中；<br/>
            当所需工时的<span id="b3"></span>≥ 剩余时间 ≥ 0 时，显示为：<img src="/img/efficiency/yellowcir.png"/>  已提醒办理中；<br/>
            当剩余时间 ＜ 0 时，显示为：<img src="/img/efficiency/redcir.png"/>  已超时办理中。
        </div>
    </div>
    <div class="fl right">
        <div class="tit">
            <span>已办结工作提前办结时间点：</span>
            <input class="num" num="4" id="date4" type="number" min="0" value="">
            <select name="" id="unit4" class="unit">
                <option value="%">%</option>
                <option value="h">小时</option>
            </select>
        </div>
        <div class="con">
            当剩余时间 ＞ 所需工时的<span id="a4"></span> 时，显示为:<img src="/img/efficiency/greenstar.png"/> 未提醒办理中；<br/>
            当所需工时的<span id="b4"></span>≥ 剩余时间 ≥ 0 时，显示为：<img src="/img/efficiency/yellowstar.png"/>  已提醒办理中；<br/>
            当剩余时间 ＜ 0 时，显示为：<img src="/img/efficiency/redstar.png"/>  已超时办理中。
        </div>
    </div>
    <div class="cl"></div>
    <div class="btn"><button id="saveBtn"  class="btn_">保存</button></div>
</div>
</body>
<script>
    $(".num").change(function (){
        init($(this).attr("num"))

    })
    $(".unit").change(function (){
        init($(this).attr("num"))

    })
    function init(e){
        var a = $("#date"+e).val();
        var b = $("#unit"+e).val();
        $("#a"+e).html(a+b);
        $("#b"+e).html(a+b);

    }
    //查询初始化
    query();
    function query(){
        $.ajax({
            url:"/FlowPara/selectFlowPara",
            type:"get",
            dataType:"json",
            success:function(res){
                if(res.flag){
                    var arr1 = res.obj.filter(function(item){
                        return item.paraName=="IMP_REMIND"
                    })
                    var arrValue1 = arr1[0].paraValue.split(",");
                    $("#date1").val(arrValue1[0]);
                    $("#unit1").val(arrValue1[1]);
                    init(1);
                    var arr2 = res.obj.filter(function(item){
                        return item.paraName=="IMP_ADVANCE"
                    })
                    var arrValue2 = arr2[0].paraValue.split(",");
                    $("#date2").val(arrValue1[0]);
                    $("#unit2").val(arrValue1[1]);
                    init(2);
                    var arr3 = res.obj.filter(function(item){
                        return item.paraName=="OTH_REMIND"
                    })
                    var arrValue3 = arr3[0].paraValue.split(",");
                    $("#date3").val(arrValue1[0]);
                    $("#unit3").val(arrValue1[1]);
                    init(3);
                    var arr4 = res.obj.filter(function(item){
                        return item.paraName=="OTH_ADVANCE"
                    })
                    var arrValue4 = arr4[0].paraValue.split(",");
                    $("#date4").val(arrValue1[0]);
                    $("#unit4").val(arrValue1[1]);
                    init(4);
                    save();

                }

            }
        })
    }
    function save(){
        $("#saveBtn").click(function(){
            var  impRemindValue = $("#date1").val()+","+$("#unit1").val();
            var  impAdvanceValue = $("#date2").val()+","+$("#unit2").val();
            var  othRemindValue = $("#date3").val()+","+$("#unit3").val();
            var  othAdvanceValue = $("#date4").val()+","+$("#unit4").val();
            var arr=[{paraName:"IMP_REMIND",paraValue:impRemindValue},{paraName:"IMP_ADVANCE",paraValue:impAdvanceValue},{paraName:"OTH_REMIND",paraValue:othRemindValue},{paraName:"OTH_ADVANCE",paraValue:othAdvanceValue}];
            $.ajax({
                url:"/FlowPara/modify",
                type:"post",
                dataType:"json",
                data:{
                    jsonStr:JSON.stringify(arr)
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('保存成功！', {icon: 1});
                        query();
                    }else{
                        layer.msg('保存失败！', {icon: 2});
                    }

                }
            })

        })
    }

</script>
</html>