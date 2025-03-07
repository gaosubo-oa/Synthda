<%--
  Created by IntelliJ IDEA.
  User: GZY
  Date: 20/6/24
  Time: 14:50
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>我的奖金数据查询</title>

    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/management_query.css" />
    <%--<link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">--%>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript"  src="/js/base/tablePage.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <style>
        html,body{
            height: 100%;
            overflow-x: hidden;
        }
        .headtop{
            font-size: 18px;
        }
        .heads{
            float: left;
            font-size: 15pt;
            color: #494d59;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin:10px 0 0 30px;
        }
        .switch{
            float: left;
            width:70px;
            font-size:14px;
            line-height: 30px;
            height:30px;
            border-radius:5px;
            background: #2b7fe0;
            color:#ffffff;
            text-align: center;
            margin-right:30px;
            cursor:pointer;
        }
        .img{
            margin:-3px 0px 0px -2px;
        }
        .th{
            padding:10px 5px 10px 0;
            min-width:100px;
        }
        .th {
            background-color: rgb(255, 255, 255);
            font-size: 13pt;
            color: rgb(47, 92, 143);
            font-weight: bold;
            border-width: 0px;
            border-style: initial;
            border-color: initial;
            border-image: initial;
        }
        .demand{
            font-size: 16px;
            margin:10px 0 0 40px;
            float: left;
        }
        td{
            /*word-break: break-all;*/
            text-align: center;
            /*width:60px;*/
        }
        .thead  tr th:first-of-type{
            width: 40px;
        }
        .thead  tr th:nth-child(2){
            width: 60px;
        }
        table{
            overflow-x: scroll;
            width: 100% !important;
        }
        .M-box3{
            margin-bottom: 10px;
            margin-right: 10px;
        }
        table tbody tr:nth-child(even){
            background-color: #F6F7F9;
        }
        table tbody tr:nth-child(odd){
            background-color: #ffffff;
        }
        table tr th:nth-child(1),table tr td:nth-child(1){
            /*width: 40px;*/
        }
        table tr th:nth-child(2),table tr td:nth-child(2){
            width: 110px;
        }
        table tr th:nth-child(3),table tr td:nth-child(3){
            /*width: 40px;*/
        }
    </style>
</head>
<body>
<div class="headtop">
    <p  class="heads">
        <img src="/img/commonTheme/theme1/yibanfawen.png" alt="" style="width: 18px;height: 18px;">
        我的奖金数据查询
    </p>
    <div class="demand">
        <select  name="YYYY"  id="year" style="text-align: center;width: 60px;height: 25px"> </select>
        <span><fmt:message code="chat.th.year" /></span>
    </div>
    <div style="clear:both;"></div>
</div>

<div class="pagediv" id="pagediv2" style="margin:21px 0 10px 0;width:100%;overflow: auto;"></div>
<div style="color: red;height: 10px;width:100%;font-size: 10px;text-align: center">提示：点击下方月份查看明细</div>
<div class="pagediv" id="pagediv1" style="margin-top:21px;width:100%;height:100px;">

</div>

</body>
<script>
    var heightBox=$('body').height()-$('.headtop').height()-200;
    $('#pagediv1').height(heightBox);
    var iframeChild = $("#iframes", $(document).width()-400);
    var iframeHead = $("#header", $(document).width()-400);
    function YYYYMM(){//默认显示查询时间
        var y  = new Date().getFullYear();
        for (var i=(y-10);i<(y+11);i++){
            $('#year').append('<option value='+i+'>'+i+'</option>');
        }
        $('#year').find('option[value='+y+']').attr("selected",true);

        // for (var i=1;i<13;i++){
        //     $('#month').append(new Option(" " + i ));
        // }
        // $('#month').val(new Date().getMonth() + 1)
    }YYYYMM();
    var data = ''
    var ajaxPage={
        data:{
            /* page:1,//当前处于第几页
             pageSize:8,//一页显示几条
             useFlag:true,*/
            wageDifference:2,
            type:1,
            head:$('#year option:selected').val()/*+'-'+$('#month option:selected').val()*/,
        },

        page:function () {
            var me=this;
            $.post('/bonusmsg/query',this.data,function (json) {
                var str='';
                var str2='';
                var i=0;
                var datas=json.obj;
                data = json.obj;
                var titles = new Array();
                //应发工资
                var counts = new Array();
                //实发工资
                var actual = new Array();

                if(json.obj.length>0) {
                    $('#dbgz_page').show();
                    for(var j=0;j<datas.length;j++){
                        var arr2 = datas[j].bonusMsgList;
                        var arr= datas[j]

                        for (var s in arr) {
                            i++
                        }
                        if(arr2!=''){
                            str+='<table style="margin:0;">' +
                                '<tr><th  class="th" style="width:95px">月份</th>' +
                                '<th  class="th" style="width:95px">姓名</th>' +
                                '<th  class="th" style="width:205px">身份证号码</th></tr>'
                            for(var k=0;k<arr2.length;k++){
                                for (var t = 1; t <= i - 3; t++) {//列表内容数据展示
                                    var temp = 'DATA_' + t;
                                    if(arr2[k][temp]!=undefined) {
                                        if(t==1){
                                            str += '<tr onclick="getdata('+j+','+k+')"><td >' + arr2[k].YEARS+'年'+arr2[k].MONTH+ '月</td>'+
                                                '<td >' + arr2[k].USER_NAME+ '</td>' +
                                                '<td >' +   function(){
                                                    if(arr2[k].ID_NUMBER ){
                                                        return  arr2[k].ID_NUMBER
                                                    }else {
                                                        return   ''
                                                    }
                                                }()  + '</td>'
                                                // '<td >' + arr2[k][temp] + '</td>' ;
                                            titles[j] = arr2[k].YEARS+'年'+arr2[k].MONTH+ '月';
                                        }else {

                                            if(arr[temp].indexOf('应发')>=0&&arr2[k][temp]!=undefined&&arr2[k][temp]!=''){
                                                if(arr2[k][temp].toString().indexOf(".00")>=0){
                                                    counts[j]= parseFloat(arr2[k][temp])
                                                }else if(arr2[k][temp].length>10&&arr2[k][temp].toString().indexOf(".")==-1){
                                                    counts[j]= parseFloat(arr2[k][temp])
                                                }else if(isNaN(parseInt(arr2[k][temp]))){
                                                    counts[j]= arr2[k][temp]
                                                }else{
                                                    counts[j]= parseFloat(arr2[k][temp])
                                                }
                                            }
                                            if(arr[temp].indexOf('实发')>=0&&arr2[k][temp]!=undefined&&arr2[k][temp]!=''){
                                                if(arr2[k][temp].toString().indexOf(".00")>=0){
                                                    actual[j]= parseFloat(arr2[k][temp])
                                                }else if(arr2[k][temp].length>10&&arr2[k][temp].toString().indexOf(".")==-1){
                                                    actual[j]= parseFloat(arr2[k][temp])
                                                }else if(isNaN(parseInt(arr2[k][temp]))){
                                                    actual[j]= arr2[k][temp]
                                                }else{
                                                    actual[j]= parseFloat(arr2[k][temp])
                                                }
                                            }
                                        }
                                    }
                                }
                                str+='</tr>'
                            }

                            str+='</table>';
                        }
                        $(iframeHead).width('4550px');
                        $(iframeChild).width('4550px');
                        $('#pagediv1').html(str);

                        if(str==''){
                            $('.thead tr').find('th').remove();
                            $('#dbgz_page').hide();
                            $(iframeHead).width('100%');
                            $(iframeChild).width('100%');
                            var htmlStr='<table style=" margin:0 16px 0 16px"><thead class="thead"><tr></tr></thead><tbody class="tbody"><tr style="border: none;">' +
                                '<td>' +
                                '<img style="display: block;text-align: center;margin: 0 auto;margin-top: 160px;margin-bottom: 10px;" src="/img/main_img/shouyekong.png" alt="">' +
                                '<h2 style="text-align: center;color: #666;font-size: 11pt;">暂无数据</h2>' +
                                '</td>' +
                                '</tr></tbody></table>'
                            $('#pagediv1').html(htmlStr);
                        }
                    }

                    var thead = '<tr style="width: 90%"><th class="th">类型</th>';
                    var tr = '<tr><td>应发</td>';
                    var countMoney = 0;
                    var actualTr = '<tr><td>实发</td>';
                    var actualMoney = 0;

                    /// 原为正序排序
                    // for(var i=titles.length-1;i>=-1;i--){
                    // if(i==-1){
                    // 改为倒叙排序
                    for (var i = 0; i <= titles.length; i++) {
                        if (i == titles.length) {
                            thead+='<th class="th">合计<th>';
                            tr +='<td>'+function () {
                                if(countMoney.toString().indexOf(".00")>=0){
                                    return parseFloat(countMoney).toFixed(0)
                                }else if(isNaN(parseInt(countMoney))&&countMoney.toString().indexOf(".")==-1){
                                    return parseFloat(countMoney).toFixed(0)
                                }else{
                                    return parseFloat(countMoney).toFixed(2)
                                }
                            }()+'<td>'
                            actualTr += '<td>'+function () {
                                if(actualMoney.toString().indexOf(".00")>=0){
                                    return parseFloat(actualMoney).toFixed(0)
                                }else if(isNaN(parseInt(actualMoney))&&actualMoney.toString().indexOf(".")==-1){
                                    return parseFloat(actualMoney).toFixed(0)
                                }else{
                                    return parseFloat(actualMoney).toFixed(2)
                                }
                            }()+'<td>'
                        }else{
                            if(titles[i]!=undefined&&titles[i]!=''){
                                thead += '<th class="th">'+titles[i]+'<th>';
                                tr +='<td>'+counts[i]+'<td>'
                                countMoney+=parseFloat( function () {
                                    if(counts[i]==undefined||counts[i]==''){
                                        return 0
                                    }else{
                                        return  counts[i]
                                    }
                                }());
                                actualTr +='<td>'+function () {
                                    if(actual[i]==undefined||actual[i]==''){
                                        return 0
                                    }else{
                                        return  actual[i]
                                    }
                                }()+'<td>'
                                actualMoney += parseFloat(function () {
                                    if(actual[i]==undefined||actual[i]==''){
                                        return 0
                                    }else{
                                        return  actual[i]
                                    }
                                }());
                            }
                        }
                    }
                    if(titles.length!=0){
                        $('#pagediv2').html('<table style="margin:0;">'+thead+'</tr>'+actualTr+'</tr>'+tr+'</tr></table>');
                    }else{
                        $('#pagediv2').html('');
                    }
                }else {
                    $('.thead tr').find('th').remove();
                    $('#dbgz_page').hide();
                    $(iframeHead).width('100%');
                    $(iframeChild).width('100%');
                    var htmlStr='<table style=" margin:0 16px 0 16px"><thead class="thead"><tr></tr></thead><tbody class="tbody"><tr style="border: none;">' +
                        '<td>' +
                        '<img style="display: block;text-align: center;margin: 0 auto;margin-top: 160px;margin-bottom: 10px;" src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;font-size: 11pt;">暂无数据</h2>' +
                        '</td>' +
                        '</tr></tbody></table>'
                    $('#pagediv1').html(htmlStr);
                    $('#pagediv2').html(htmlStr);
                }

            },'json')

        },
    }

    function getdata(j,k){
        layui.use(['layer'],function () {
            var layer = layui.layer;
            $(function (){
                var i = 0;
                var str = ''
                layer.open({
                    type: 1,
                    title:'我的工资数据查询',
                    area:['100%','100%'],
                    id:'id',
                    moveType: 1,
                    content:'<div class="tb"></div>',
                    success:function (layeo) {
                        if (data.length > 0){
                            var arr2 = data[j].bonusMsgList;
                            var arr = data[j]
                            for (var s in arr) {
                                i++
                            }
                            if (arr2 != '') {
                                str += '<table style="margin:0;">'
                                    for (var t = 1; t <= i - 3; t++){
                                        var temp = 'DATA_' + t;
                                        if (arr2[k][temp] != undefined){
                                            if (t == 1) {
                                                str += '<tr><th class="th">月份</th><td>' + arr2[k].YEARS + '年' + arr2[k].MONTH + '月</td></tr>'+
                                                    '<tr><th  class="th" style="">姓名</th><td >' + arr2[k].USER_NAME + '</td></tr>' +
                                                    '<tr><th  class="th" style="">身份证号码</th><td>' +   function(){
                                                        if(arr2[k].ID_NUMBER ){
                                                            return  arr2[k].ID_NUMBER
                                                        }else {
                                                            return   ''
                                                        }
                                                    }()  + '</td></tr>'+
                                                    '<tr><th  class="th" title="' + arr[temp] + '">' + arr[temp] + '</th><td >' + arr2[k][temp] + '</td></tr>';
                                            }
                                            else{

                                                if (arr[temp] != null && arr[temp] != undefined) {
                                                    //判断表头长度来判断所需的宽度
                                                    str += '<tr><th  class="th" title="' + arr[temp] + '">' + arr[temp] + '</th><td>' + arr2[k][temp] + '</td></tr>';
                                                }
                                            }
                                        }
                                    }
                                $('.tb').html(str);
                            }
                        }
                    }
                })
            })
        })//layui.use

    }

    $(function () {
        ajaxPage.page()
        $('.add').click(function () {//导入
            layer.open({
                type: 2,
                title: '<fmt:message code="adding.th.salary" />',
                shadeClose: true,
                shade: 0.5,
                area: ['30%', '350px'],
                content: '/salary/payimport',
                btn:['<fmt:message code="workflow.th.Import" />','<fmt:message code="global.lang.close" />'],
                yes: function(index, layero){
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']];//子页面对象
                    iframeWin.upfile();
                    setTimeout(function () {
                        ajaxPage.page()
                        layer.close(index)
                    },1000)
                }

            });

        });

        $('.query').click(function(json){
            var bshead=$('#year option:selected').val()/*+'-'+$('#month option:selected').val()*/;
            ajaxPage.data.head=bshead;
            ajaxPage.page();
        })

        $('#year,#month').change(function () {
            var bshead=$('#year option:selected').val()+'-'+$('#month option:selected').val();
            ajaxPage.data.head=bshead;
            ajaxPage.page();
        })

    })
</script>
</html>
