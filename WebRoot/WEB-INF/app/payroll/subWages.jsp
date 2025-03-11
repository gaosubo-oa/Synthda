<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>下属工资数据查询</title>

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
    <style>
        html,body{
            height: 100%;
        }
        #body {
            overflow: hidden;
        }
        .headtop{
            font-size: 18px;
        }
        .heads{
            float: left;
            font-size: 17pt;
            color: #494d59;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-left:30px;
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
            min-width: 125px;
        }
        .demand{
            font-size: 16px;
            margin-left:60px ;
            float: left;
        }

        table{
            width: 100%;
            overflow-x: scroll;
            overflow-y: auto;
        }
        td{
            /*word-break: break-all;*/
            text-align: center;
            /*border-right: 1px solid #ccc;*/
            /*width:60px;*/
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
        .pagediv{
            width: 100%;
        }

    </style>
</head>
<body>
<div class="headtop">
    <p  class="heads">
        <img src="/img/commonTheme/theme1/yibanfawen.png" alt="">
        下属工资数据查询
    </p>
    <div class="demand">
        <select  name="YYYY"  id="year" style="text-align: center"> </select>
        <span><fmt:message code="chat.th.year" /></span>
        <%--<select  name="month"  id="month" style="text-align: center">--%>
        <%----%>
        <%--</select>--%>
        <%--<span>月</span>--%>
        <%--<span class="switch query" style="float: none;display: inline-block;margin-left: 10px;"><fmt:message code="global.lang.query" /></span>--%>
    </div>
</div>

<div class="pagediv" id="pagediv2" style="margin-top:21px;width:100%;overflow:auto;">

</div>
<div class="pagediv" id="pagediv1" style="margin:21px 0 0 0;overflow: auto;height: 280px">

</div>
</body>
<script>
    var iframeChild = $("#iframes", $(window.body).width());
    var iframeHead = $("#header", $(window.body).width());

    function YYYYMM(){//默认显示查询时间
        var y  = new Date().getFullYear();
        for (var i=(y-10);i<(y+11);i++){
            $('#year').append(new Option(" "+ i ));
        }
        $('#year').val(y);

        // for (var i=1;i<13;i++){
        //     $('#month').append(new Option(" " + i ));
        // }
        // $('#month').val(new Date().getMonth() + 1)
    }YYYYMM();
    var ajaxPage={
        data:{
            /* page:1,//当前处于第几页
             pageSize:8,//一页显示几条
             useFlag:true,*/
            wageDifference:1,
            type:1,
            head:$('#year option:selected').val()/*+'-'+$('#month option:selected').val()*/
        },

        page:function () {
            var me=this;
            $.post('/bonusmsg/query2',this.data,function (json) {
                var str='';
                var str2='';
                var i=0;
                var datas=json.obj;
                var titles = new Array();
                //应发工资
                var counts = new Array();
                //实发工资
                var actual = new Array();
                if(json.obj.length>0) {
                    // $('#dbgz_page').show();
                    for(var j=0;j<datas.length;j++){
                        counts[j] = 0
                        actual[j] = 0
                        var arr2 = datas[j].bonusMsgList;
                        var arr= datas[j]
                        var count = 0
                        for (var s in arr) {
                            i++
                        }
                        if(arr2!=''){
                            // str+='<table style="margin:15px 30px;"><tr>'
                                str += '<table style="margin:15px 15px;">' +
                                    '<tr><th  class="th" style="width:95px">月份</th>' +
                                    '<th  class="th" style="width:95px">姓名</th>' +
                                    '<th  class="th" style="width:205px">身份证号码</th>'
                                for (var n = 1; n <= i - 3; n++) {//列表头数据展示
                                    var temp = 'DATA_' + n;
                                    if (arr[temp] != null && arr[temp] != undefined) {
                                        //判断表头长度来判断所需的宽度
                                        str += '<th  class="th" title="' + arr[temp] + '">' + arr[temp] + '</th>';
                                    }
                                }
                                str += '</tr>'
                                for(var k = 0;k < arr2.length;k++){
                                    str+='<tr>'
                                    for (var t = 1; t <= i - 3; t++) {//列表内容数据展示
                                        var temp = 'DATA_' + t;
                                        if(arr2[k][temp]!=undefined) {
                                            if (t == 1) {
                                                str += '<td >' + arr2[k].YEARS + '年' + arr2[k].MONTH + '月</td><td >' + arr2[k].USER_NAME + '</td>' +
                                                    '<td >' +   function(){
                                                        if(arr2[k].ID_NUMBER ){
                                                            return  arr2[k].ID_NUMBER
                                                        }else {
                                                            return   ''
                                                        }
                                                    }() + '</td>' + '<td >' + arr2[k][temp] + '</td>';
                                                titles[j] = arr2[k].YEARS + '年' + arr2[k].MONTH + '月';
                                            }else {
                                                str += '<td >' + function () {
                                                    if (arr2[k][temp].toString() == '0.00') {
                                                        return '0'
                                                    } else {
                                                        if (arr2[k][temp].toString().indexOf(".00") >= 0) {
                                                            return parseFloat(arr2[k][temp])
                                                        } else if (arr2[k][temp].length > 10 && arr2[k][temp].toString().indexOf(".") == -1) {
                                                            return parseFloat(arr2[k][temp])
                                                        } else if (isNaN(parseInt(arr2[k][temp]))) {
                                                            return arr2[k][temp]
                                                        } else {
                                                            return parseFloat(arr2[k][temp])
                                                        }
                                                    }
                                                }() + '</td>';
                                                if(arr[temp]!=null &&arr[temp]!=undefined){
                                                    if (arr[temp].indexOf('应发') >= 0 && arr2[k][temp] != undefined && arr2[k][temp] != '') {
                                                        if (arr2[k][temp].toString().indexOf(".00") >= 0) {
                                                            // count = parseFloat(arr2[k][temp]).toFixed(0)
                                                            counts[j] += parseFloat(arr2[k][temp])
                                                        } else if (arr2[k][temp].length > 10 && arr2[k][temp].toString().indexOf(".") == -1) {
                                                            counts[j] += parseFloat(parseFloat(arr2[k][temp]).toFixed(0))
                                                        } else if (isNaN(parseInt(arr2[k][temp]))) {
                                                            counts[j] += arr2[k][temp]
                                                        } else {
                                                            // count = parseFloat(arr2[k][temp]).toFixed(2)
                                                            counts[j] += parseFloat(arr2[k][temp])
                                                        }

                                                    }
                                                    if (arr[temp].indexOf('实发') >= 0 && arr2[k][temp] != undefined && arr2[k][temp] != '') {
                                                        if (arr2[k][temp].toString().indexOf(".00") >= 0) {
                                                            actual[j] += parseFloat(arr2[k][temp])
                                                        } else if (arr2[k][temp].length > 10 && arr2[k][temp].toString().indexOf(".") == -1) {
                                                            actual[j] += parseFloat(arr2[k][temp])
                                                        } else if (isNaN(parseInt(arr2[k][temp]))) {
                                                            actual[j] += arr2[k][temp]
                                                        } else {
                                                            actual[j] += parseFloat(arr2[k][temp])
                                                        }
                                                        // console.log(actual[j])
                                                    }
                                                }
                                            }
                                        }
                                    }//'DATA_' + t
                                    str+='</tr>'
                                }//for--k
                            str+='</table>';
                        }
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
                            $('.pagediv').html(htmlStr);
                        }
                        var thead = '<tr><th class="th">类型</th>';
                        var tr = '<tr><td>应发</td>';
                        var countMoney = 0;
                        var actualTr = '<tr><td>实发</td>';
                        var actualMoney = 0;
                        for(var i = 0; i <= titles.length; i++){
                            if (i == titles.length) {
                                thead += '<th class="th">合计<th>';
                                tr += '<td>' + function () {
                                    if (toString(countMoney).indexOf('.00') >= 0) {
                                        return countMoney.toFixed(0)
                                    } else if (isNaN(parseInt(countMoney)) && countMoney.toString().indexOf(".") == -1) {
                                        return countMoney.toFixed(0)
                                    } else {
                                        return countMoney.toFixed(2)
                                    }

                                }() + '<td>';
                                actualTr += '<td>' + function () {
                                    if (toString(actualMoney).indexOf('.00') >= 0) {
                                        return actualMoney.toFixed(0)
                                    } else if (isNaN(parseInt(actualMoney)) && actualMoney.toString().indexOf(".") == -1) {
                                        return actualMoney.toFixed(0)
                                    } else {
                                        return actualMoney.toFixed(2)
                                    }

                                }() + '<td>';
                            } else {
                                if (titles[i] != undefined && titles[i] != '') {
                                    thead += '<th class="th">' + titles[i] + '<th>';
                                    tr += '<td>' + counts[i] + '<td>'
                                    countMoney += parseFloat(function () {
                                        if (counts[i] == undefined || counts[i] == '') {
                                            return 0
                                        } else {
                                            return counts[i]
                                        }
                                    }());
                                    actualTr += '<td>' + function () {
                                        if (actual[i] == undefined || actual[i] == '') {
                                            return 0
                                        } else {
                                            return actual[i]
                                        }
                                    }() + '<td>'
                                    actualMoney += parseFloat(function () {
                                        if (actual[i] == undefined || actual[i] == '') {
                                            return 0
                                        } else {
                                            return actual[i]
                                        }
                                    }());
                                }
                            }
                        }
                        if (titles.length != 0){
                            $('#pagediv2').html('<table style="margin:15px 15px;">' + thead + '</tr>' + actualTr + '</tr>' + tr + '</tr></table>');
                        }else {
                            $('#pagediv2').html('');
                        }
                        $('#pagediv1').css('overflow-x','auto')
                        $('#pagediv2').css('overflow-x','auto')
                    }//for--datas.length
                   // me.pageTwo(json.totleNum, me.data.pageSize, me.data.page)
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
                    $('.pagediv').html(htmlStr);
                }

            },'json')

        },

        /*  pageTwo:function (totalData, pageSize,indexs) {//设置分页
         var mes=this;
         $('#dbgz_page').pagination({
         totalData: totalData,
         showData: pageSize,
         jump: true,
         coping: true,
         homePage:'',
         endPage: '',
         current:indexs||1,
         callback: function (index) {

         mes.data.page=index.getCurrent();
         mes.page();
         }
         });
         }*/
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



        /*$('tbody').on('mouseenter','.publishtip',function () {

         var that = $(this);
         //var str=that.attr('toTypeName').replace(/-/g,'<br>')
         layer.tips(str,that, {
         tips: [1, '#3595CC'],
         time: 10000
         });
         });*/


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
        // if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
        //     window.location.replace('/bonusmsg/h5subWages');
        // }
    })
</script>

</html>
