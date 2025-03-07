<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title><fmt:message code="vote.th.DesktopSettings" /></title>
    <style type="text/css">
        *{
            margin: 0;
            padding: 0;
        }
        h1 {
            font-size: 18px;
            text-align: center;
        }

        table {
            margin: 0 auto;
            border-color: #ddd;
        }

        table tr td {
            padding: 5px 5px;
            font-size: 14px;
            border-color: #ddd;
        }

        table tr td input:not (#fh ){
            width: 80%;
        }

        .btn-mini {
            width: 28px;
            height: 28px;
        }

        .btn-primary {
            padding: 3px 1px;

            font-size: 12px;
            line-height: 6px;
        }
        option:hover{
            background: #ddd;
        }
        #myTable table tbody tr:hover {
            background: #FFFFFF;
        }
        .btn_top{
            background: url('/img/commonTheme/desktop/top.png') no-repeat ;
        }
        .btn-bottom{
            background: url('/img/commonTheme/desktop/bottom.png') no-repeat ;
        }
        .btn-left{
            background: url('/img/commonTheme/desktop/left.png') no-repeat ;
        }
        .btn-right{
            background: url('/img/commonTheme/desktop/right.png') no-repeat ;
        }
        .btn-all{
            width: 77px;
            height: 28px;
            background: url('/img/commonTheme/desktop/all.png') no-repeat ;
        }
        .btn-save{
            width: 94px;
            height: 32px;
            background: url('/img/commonTheme/desktop/save.png') no-repeat;
        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<form id="myTable">
    <table class="table table-bordered" style="width: 800px;">
        <colgroup>
            <col width="40">
            <col width="200">
            <col width="40">
            <col width="200">
        </colgroup>
        <thead>
        <tr>
            <td class="center" colspan="4"><fmt:message code="vote.th.homeSetting" /></td>
        </tr>
        </thead>
        <tbody style="text-align: center;">
        <tr>
            <td><b><fmt:message code="global.lang.order" /></b></td>
            <td><b><fmt:message code="vote.th.AddedCard" /></b></td>
            <td><b><fmt:message code="global.lang.select" /></b></td>
            <td valign="top"><b><fmt:message code="vote.th.TagAdded" /></b></td>
        </tr>

        <tr>
            <td align="center" class="TableData" style="vertical-align: middle;">
                <input class="btn btn-mini btn_top" style="border: none;"  onclick="func_up();" type="button" >
                <br><br>
                <input class="btn btn-mini btn-bottom" style="border: none; margin-left: -5px" onclick="func_down();" type="button" value="  ">
            </td>
            <td align="center" class="TableData" valign="top" style="text-align: center;">
                <select id="select1" style="width: 250px; height: 200px;" ondblclick="func_delete();" multiple="">

                </select>
                <input class="btn  btn-all" style="border: none; margin-top: 10px; margin-left: 130px; display: block;" onclick="func_select_all1();" type="button" value="&nbsp;&nbsp;&nbsp; &nbsp;<fmt:message code="notice.th.allchose" /> ">
            </td>
            <td align="center" class="TableData" style="vertical-align: middle;">
                <input class="btn btn-mini btn-right"  style="border: none;" onclick="func_insert();" type="button" >
                <br><br>
                <input class="btn btn-mini btn-left"  style="border: none; margin-right: 5px" onclick="func_delete();" type="button" >
            </td>

            <td align="center" class="TableData" valign="top" style="text-align: center;">
                <select id="select2" style="width: 250px; height: 200px;" ondblclick="func_insert();" multiple="">

                </select>
                <input class="btn btn-all" style="border: none; margin-top: 10px; margin-left: 130px; display: block;" onclick="func_select_all2();" type="button" value=" &nbsp;&nbsp;&nbsp; &nbsp;<fmt:message code="notice.th.allchose" /> ">
            </td>
        </tr>

        <tr>
            <td align="center" valign="top" style="text-align: center; background-color: rgb(255, 255, 255);" colspan="4">
                <span><fmt:message code="vote.th.ClickSelect" /></span><br>
                <input class="btn btn-primary btn-save" style="border:none; color: #fff" onclick="mysubmit();" type="button" value="&nbsp;&nbsp;&nbsp; &nbsp;<fmt:message code="vote.th.SaveSettings" />">
            </td>
        </tr>

        </tbody>

    </table>
</form>
</body>
<script>

    $(function () {

        var myTable = $("#infoCenter");

        $.ajax({
            type:'get',
            url:"/infoCenter/getHadInfoCenterList",
            dataType: 'json',
            success: function (json){
                if(json.flag){
                    var str = "";
                    for(i = 0; i < json.data.length; i ++){
                        str += '<option value="'+ json.data[i].infoFuncId +'">' + json.data[i].infoName1 + '</option>';
                    }
                    $("#select1").html(str);
                }
            }
        });

        $.ajax({
            type:'get',
            url:"/infoCenter/getChooseInfoCenterList",
            dataType: 'json',
            success: function (json){
                if(json.flag){
                    var str = "";
                    for(i = 0; i < json.data.length; i ++){
                        str += '<option value="'+ json.data[i].infoFuncId +'">' + json.data[i].infoName1 + '</option>';
                    }
                    $("#select2").html(str);
                }
            }
        });
    })

    function func_insert()
    {
        for (i=0; i<myTable.select2.options.length; i++)
        {
            if(myTable.select2.options[i].selected && myTable.select2.options[i].value!="MENU_SORT")
            {
                option_text=myTable.select2.options[i].text;
                option_value=myTable.select2.options[i].value;
                option_style_color=myTable.select2.options[i].style.color;

                var my_option = document.createElement("OPTION");
                my_option.text=option_text;
                my_option.value=option_value;
                my_option.style.color=option_style_color;

                pos=myTable.select2.options.length;
                myTable.select1.options.add(my_option,pos);
                myTable.select2.remove(i);
                i--;
            }
        }
    }

    function func_delete()
    {
        for (i=0;i<myTable.select1.options.length;i++)
        {
            if(myTable.select1.options[i].selected)
            {
                option_text=myTable.select1.options[i].text;
                option_value=myTable.select1.options[i].value;

                var my_option = document.createElement("OPTION");
                my_option.text=option_text;
                my_option.value=option_value;

                pos=myTable.select2.options.length;
                myTable.select2.options.add(my_option,pos);
                myTable.select1.remove(i);
                i--;
            }
        }
    }

    function func_select_all1()
    {
        for (i=myTable.select1.options.length-1; i>=0; i--)
            myTable.select1.options[i].selected=true;
    }

    function func_select_all2()
    {
        for (i=myTable.select2.options.length-1; i>=0; i--)
            myTable.select2.options[i].selected=true;
    }

    function func_up()
    {
        sel_count=0;
        for (i=myTable.select1.options.length-1; i>=0; i--)
        {
            if(myTable.select1.options[i].selected)
                sel_count++;
        }

        if(sel_count==0)
        {
            alert("<fmt:message code="vote.th.Whenyou" />");
            return;
        }
        else if(sel_count>1)
        {
            alert("<fmt:message code="vote.th.Whenyouadjust" />");
            return;
        }

        i=myTable.select1.selectedIndex;

        if(i!=0)
        {
            var my_option = document.createElement("OPTION");
            my_option.text=myTable.select1.options[i].text;
            my_option.value=myTable.select1.options[i].value;

            myTable.select1.options.add(my_option,i-1);
            myTable.select1.remove(i+1);
            myTable.select1.options[i-1].selected=true;
        }
    }

    function func_down()
    {
        sel_count=0;
        for (i=myTable.select1.options.length-1; i>=0; i--)
        {
            if(myTable.select1.options[i].selected)
                sel_count++;
        }

        if(sel_count==0)
        {
            alert("<fmt:message code="vote.th.Whenyou" />");
            return;
        }
        else if(sel_count>1)
        {
            alert("<fmt:message code="vote.th.Whenyouadjust" />");
            return;
        }

        i=myTable.select1.selectedIndex;

        if(i!=myTable.select1.options.length-1)
        {
            var my_option = document.createElement("OPTION");
            my_option.text=myTable.select1.options[i].text;
            my_option.value=myTable.select1.options[i].value;

            myTable.select1.options.add(my_option,i+2);
            myTable.select1.remove(i);
            myTable.select1.options[i+1].selected=true;
        }
    }

    function mysubmit()
    {
        var id = $('#select1>option');
        var attr1=[];
        for (var i = 0; i < id.length; i++) {
            attr1.push(id.eq(i).attr('value'));
        }
        var infoCenterOrder=  attr1.join(',');
        infoCenterOrder = infoCenterOrder+",";
        $.ajax({
            type:'get',
            url:"/infoCenter/setInfoCenterOrder",
            dataType: 'json',
            data:{infoLeftOrder: infoCenterOrder},
            success: function (json){
                if(json.flag){
//                    alert("保存成功！");
                }
                location.reload();
            }
        });
    }
</script>
</html>
