<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="workflow.th.ReminderSettings" /></title>

    <style>

    </style>
    <%--<link rel="stylesheet" href="../../lib/alayui-v1.0.9_rls/layui/css/layui.css">--%>
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <style>
        h3{
            font-size: 24px;
            margin-left: 30px;
            margin-top: 12px;
        }
        .count{
            border:1px solid #cccccc;
            margin:20px auto;
            width: 96%;
        }
        li{
            border-bottom:1px solid #cccccc;
        }
        .fl{
            float: left;
        }
        .clearfix:after{
            display:block;
            clear:both;
            content: "";
        }
        .cont,.list1,.list2,.list3{
            width:25%;
            text-align: center;
        }
        input{
            border: none;
        }
        a{
            color: rgb(43, 127, 224);
            text-decoration: none;
        }
        .btn {
            width: 70px;
            height: 24px;
            margin: 0 auto;
            padding: 2px 0 2px 0;
            background: url(/img/confirm.png) no-repeat;
        }
        button {
            background: transparent;
            margin-left: 33px;
            line-height: 26px;
        }
        .cont li{
            font-size: 11pt;
        }
        .count ul:first-child li{
            height: 36px;
            line-height: 36px;
            font-size: 13pt;
        }
    </style>
</head>
<body>
<div class="head" >
    <h1 style="line-height: 45px;font-size: 22px;font-weight: normal;">
        <img style="margin-left: 30px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_menuSet.png" alt="">
        <fmt:message code="workflow.th.ReminderSettings" />
    </h1>
</div>

<%--<table style="width:96%;margin:10px auto;">--%>
<%--<thead>--%>
<%--<tr>--%>
<%--<th class="th" width="10%" align="center">模块名称</th>&lt;%&ndash;序号&ndash;%&gt;--%>
<%--<th class="th" width="10%" align="center">允许事务提醒 全选</th>&lt;%&ndash;业务模块&ndash;%&gt;--%>
<%--<th class="th" width="10%" align="center">默认事务提醒 全选</th>&lt;%&ndash;名称&ndash;%&gt;--%>
<%--<th class="th" width="10%" align="center">手机短信默认提醒 全选</th>&lt;%&ndash;数据方向&ndash;%&gt;--%>
<%--<th class="th" width="10%" align="center">允许分享到企业社区 全选</th>&lt;%&ndash;流程&ndash;%&gt;--%>
<%--<th class="th" width="20%" align="center">默认分享到企业社区 全选</th>&lt;%&ndash;数据映射&ndash;%&gt;--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody class="cont">--%>

<%--</tbody>--%>
<%--</table>--%>
<div class="count clearfix">
    <ul class="clearfix " style="text-align: center;">
        <%--<li class="fl" style="width:25%; margin-top: 7px;" ><fmt:message code="workflow.th.ModuleName" /></li>--%>
        <li class="fl" style="width:25%;"><fmt:message code="workflow.th.ModuleName" /></li>
        <li class="fl" style="width:25%;"><fmt:message code="global.lang.reminding" /> <input type="checkbox" class="allSel_1" /></li>
        <li class="fl" style="width:25%;"><fmt:message code="global.lang.remfgh" /> <input type="checkbox" class="allSel_2" /></li>
        <li class="fl" style="width:25%;"><fmt:message code="global.lang.sgte" /> <input type="checkbox" class="allSel_3" /></li>
    </ul>
    <ul class="cont clearfix fl">


    </ul>
    <ul class="list1 fl">

    </ul>
    <ul class="list2 fl">

    </ul>
    <ul class="list3 fl">

    </ul>
</div>
<div class="btn">
    <button class="save"><fmt:message code="global.lang.save" /></button>
</div>
</body>
<script>
    $(function () {
        $.ajax({
            url:'/sms2Priv/selectModuleOrder',
            type:'get',
            dataType:'json',
            success:function(res){
                if(res.flag){
                    var obj=res.obj;
                    var str='',list1='',list2='',list3='';
                    for(var i =0;i <obj.length;i++ ){
                        str+='<li style="height: 25px;line-height: 25px;" code="'+obj[i].codeNo+'">'+obj[i].codeName+'</li>';
                        list1+='<li><input type="checkbox" class="sel_1" code="'+obj[i].codeNo+'" value="'+obj[i].codeNo+'"></li>';
                        list2+='<li><input type="checkbox" class="sel_2" code="'+obj[i].codeNo+'" value="'+obj[i].codeNo+'"></li>';
                        list3+='<li><input type="checkbox" class="sel_3" code="'+obj[i].codeNo+'" value="'+obj[i].codeNo+'"></li>';
                    }
                    $('.cont').html(str);
                    $('.list1').html(list1)
                    $('.list2').html(list2)
                    $('.list3').html(list3)

                    $.ajax({
                        url:'/sms2Priv/selectSmsRemind',
                        dataType:'json',
                        type:'get',
                        success:function(res){
                            //  alert(res.object.paraValue)
                            var data1='';
                            var data2='';
                            var data3='';
                            if(res.object.column1!=undefined){
                                data1 = res.object.column1.split(',');//分割成数组
                                //  console.log(data1)
                            }
                            if(res.object.column2!=undefined) {
                                data2 = res.object.column2.split(',');
                            }
                            if(res.object.column3!=undefined) {
                                data3 = res.object.column3.split(',');
                            }

                            if(res.flag){
                                var list1 = $('.list1').find('li input');
                                // console.log(list1)
                                var list2 = $('.list2').find('li input');
                                var list3 = $('.list3').find('li input');
                                if(list1.length <= data1.length){
                                    $(".allSel_1").prop('checked',true)
                                    $(".sel_1").prop('checked',true)
                                }else if(data1 != '' && list1.length > data1.length ){
                                    for( var j =0;j<list1.length;j++){
                                        var code1=$('.list1').find('li input').eq(j).attr('code');
                                        for(var a=0;a<data1.length;a++){
                                            if(code1==(data1[a])){
                                                $(list1[j]).attr("checked",true)
                                            }
                                        }
                                    }
                                }
                                if(list2.length <= data2.length){
                                    $(".allSel_2").prop('checked',true)
                                    $(".sel_2").prop('checked',true)
                                }else if(data2 != '' && list2.length > data2.length ){
                                    for( var k =0;k<list2.length;k++){
                                        var code2=$('.list2').find('li input').eq(k).attr('code');
                                        //console.log(code2)
                                        for(var b=0;b<data2.length;b++){
                                            if(code2==(data2[b])){
                                                $(list2[k]).attr("checked",true)
                                            }
                                        }
                                    }
                                }
                                if(list3.length <= data3.length){
                                    $(".allSel_3").prop('checked',true)
                                    $(".sel_3").prop('checked',true)
                                }else if(data3 != '' && list3.length > data3.length ){
                                    for( var n =0;n<list3.length;n++){
                                        var code3=$('.list3').find('li input').eq(n).attr('code');
                                        for(var d=0;d<data3.length;d++){
                                            if(code3==(data3[d])){
                                                $(list3[n]).attr("checked",true)
                                            }
                                        }
                                    }
                                }

                            }

                        }
                    })
                }
            }
        })
    })

    $('.allSel_1').click(function () {
        if($(this).is(':checked')){
            $(".sel_1").prop('checked',true)
        }else {
            $('.sel_1').prop('checked',false)
        }
    });
    $('.allSel_2').click(function () {
        if($(this).is(':checked')){
            $(".sel_2").prop('checked',true)
        }else {
            $('.sel_2').prop('checked',false)
        }
    });
    $('.allSel_3').click(function () {
        if($(this).is(':checked')){
            $(".sel_3").prop('checked',true)
        }else {
            $('.sel_3').prop('checked',false)
        }
    });

    $('.save').click(function () {
        var column1Length1 = $('.sel_1').length;
        var column1Length2 = $('.sel_2').length;
        var column1Length3 = $('.sel_3').length;
        var columnList1 = '';
        var columnList2 = '';
        var columnList3 = '';
        var paraValue = '';
        for(var i=0; i<column1Length1; i++){
            var ss =$('.sel_1')[i];
            if(ss.checked){
                columnList1 += $(ss).val() +',';
            }
        }
        for(var i=0; i<column1Length2; i++){
            var ss =$('.sel_2')[i];
            if(ss.checked){
                columnList2 += $(ss).val() +',';
            }
        }
        for(var i=0; i<column1Length3; i++){
            var ss =$('.sel_3')[i];
            if(ss.checked){
                columnList3 += $(ss).val() +',';
            }
        }
        if(columnList1!='' || columnList2!='' || columnList3!=''){
            paraValue += columnList1 + '|' +columnList2 + '|' + columnList3;
        }
        $.ajax({
            url:'/sms2Priv/upSmsRemindSet',
            type:'get',
            dataType:'json',
            data:{paraValue:paraValue},
            success:function(res){
                if(res.flag){
                    $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon:1});
                } else {
                    $.layerMsg({content: '<fmt:message code="meet.th.SaveFailed" />！', icon: 2});
                }
            }
        })


    });
</script>


</html>
