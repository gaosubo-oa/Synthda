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
    <title><fmt:message code="adding.th.EducationalWages" /></title>

    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/management_query.css" />
    <link rel="stylesheet" href="/lib/layui/layuiadmin/layui/css/layui.css?20210319.1">
    <%--<link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">--%>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../../js/news/page.js"></script>

    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript"  src="/js/base/tablePage.js"></script>
    <style>
        html,body{
            height: 100%;
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
        }
        .demand{
            font-size: 16px;
            margin-left:60px ;
            float: left;
        }

        td{
            word-break: break-all;
            text-align: center;
            padding: 0;
            /*width:60px;*/
        }
        table{
            overflow-x: scroll;
            width: 99% !important;
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
        .del{
            width: 135px;
            font-size: 14px;
            line-height: 30px;
            height: 30px;
            /* border-radius: 5px; */
            background: #2b7fe0;
            color: #ffffff;
            text-align: center;
            /* margin-right: 30px; */
            cursor: pointer;
            margin: 0px 15px;
            position: relative;
            top: -15px;
        }
    </style>
</head>
<body>
<div class="headtop">
    <p  class="heads">
        <img src="/img/commonTheme/theme1/yibanfawen.png" alt="">
        <fmt:message code="adding.th.EducationalWages" />
    </p>
    <div class="demand">
        <select  name="YYYY"  id="year" style="text-align: center"> </select>
        <span><fmt:message code="chat.th.year" /></span>
        <select name="MM" id="month" style="text-align: center"></select>
        <span><fmt:message code="global.lang.month" /></span>
        <div class="layui-form" style="float: right;width: 300px;display: flex;">
            <div style="margin-left: 20px">
            <input type="text" class="layui-input" id="userName" placeholder="请输入查询姓名" >
            </div>
            <div style="margin-left: 20px">
            <input type="button" class="layui-btn" id="insert" value="查询" style="width: 55px" >
            </div>
        </div>
        <%--<span class="switch query" style="float: none;display: inline-block"><fmt:message code="global.lang.query" /></span>--%>
    </div>
    <div style="clear:both;"></div>
</div>


<div class="pagediv" style="margin-top:21px;width:100%;overflow-y: auto;">
    <table style=" margin:0 16px 0 16px;overflow-x: auto;width: 100%;">
        <thead class="thead" style="width: 100%">
        <tr></tr>
        </thead>
        <tbody class="tbody">

        </tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>
</body>
<script>
    layui.use('form',function(){
        var form = layui.form;
    })
    var heightBox=$('body').height()-$('.headtop').height()-21;
    $('.pagediv').height(heightBox);
    var iframeChild=$("#iframes" , parent.document);
    var iframeHead=$("#header" , parent.document);
    function YYYYMM(){//默认显示查询时间
        var y  = new Date().getFullYear();
        for (var i=(y-10);i<(y+11);i++){
            $('#year').append('<option value='+i+'>'+i+'</option>');
        }
        $('#year').find('option[value='+y+']').attr("selected",true);
        for (var i=1;i<13;i++){
            $('#month').append('<option value='+i+'>'+i+'</option>');
        }
        //        $('#month').val = new Date().getMonth() + 1;
        var month=new Date().getMonth() + 1
        $('#month').find('option[value='+month+']').attr("selected",true);
    }YYYYMM();
    var ajaxPage={
        data:{
            /*  page:1,//当前处于第几页
             pageSize:8,//一页显示几条
             useFlag:true,*/
            wageDifference:1,
            type:2,
            head:$('#year option:selected').val()+"-"+$('#month option:selected').val()
        },

        page:function () {
            var me=this;
            $.get('/personBonusmsg/personQuery',this.data,function (json) {
                var str='';
                var str2='';
                var i=0;
                var datas=json.obj;
                if(json.obj.length>0) {
                    $('#dbgz_page').show();
//                    $(iframeHead).width('1850px');
//                    $(iframeChild).width('1850px');
                    for(var j=0;j<datas.length;j++){
                        var arr2 = datas[j].bonusMsgList;
                        var arr= datas[j]
                        for (var s in arr) {
                            i++
                        }
                        if(arr2!=undefined&&arr2!=''){
                            str+='<table style="margin:15px 15px;"><tr>' +
                                '<th  class="th" style="width:95px">月份</th>' +
                            '<th  class="th" style="width:95px">姓名</th>'
                            for (var n = 1; n <= i - 3; n++) {//列表头数据展示
                                var temp = 'DATA_' + n;
                                if(arr[temp]!=null &&arr[temp]!=undefined) {
                                    //判断表头长度来判断所需的宽度
                                    if(temp == 'data50' || temp == 'data51'){
                                        str+='';
                                    }else {
                                        str += '<th  class="th" title="' + arr[temp] + '">' + arr[temp] + '</th>';
                                    }


                                }
                            }
                            str+='</tr>'
                            for(var k=0;k<arr2.length;k++){
                                str+='<tr>'
                                for (var t = 0; t < i - 4; t++) {//列表内容数据展示
                                    var temp = 'DATA_'+ t;
                                    if(arr2[k][temp]!=undefined||t==0) {
                                        if(temp == 'data50' || temp == 'data51'){
                                            str+='';
                                        }else {
                                            if(t==0){
                                                str += '<td >' + arr2[k].YEARS+'年'+arr2[k].MONTH+ '月</td><td >' + arr2[k].USER_NAME+ '</td>';
                                            }else {
                                                str += '<td >' +function(){
                                                    if(arr2[k][temp].toString()=='0.00'){
                                                        return '0'
                                                    }else{
                                                        // console.log(isNaN(arr2[k][temp]))

                                                        if(!isNaN(arr2[k][temp])){
                                                            if(parseFloat(arr2[k][temp]).toFixed(2)=='NaN'){
                                                                return ''
                                                            }else{

                                                                if(arr2[k][temp].toString().indexOf(".00")>=0){
                                                                    return parseFloat(arr2[k][temp]).toFixed(0)
                                                                }else if(arr2[k][temp].length>10&&arr2[k][temp].toString().indexOf(".")==-1){
                                                                    return parseFloat(arr2[k][temp]).toFixed(0)
                                                                }else if(isNaN(parseInt(arr2[k][temp]))){
                                                                    return arr2[k][temp]
                                                                }else{
                                                                    return parseFloat(arr2[k][temp]).toFixed(2)
                                                                }
                                                                // return parseFloat(arr2[k][temp]).toFixed(2)
                                                            }
                                                        }else{
                                                            return arr2[k][temp]
                                                        }

                                                    }

                                                }()   + '</td>';
                                            }
                                        }

                                    }
                                }
                                str+='</tr>'
                            }

                            str+='</table><div bonusId="'+arr.BONUS_ID+'" headId="'+arr.HEAD_ID+'" bonusType="'+arr.BONUS_TYPE+'" class="del">删除本次导入数据</div>';
                        }
                        $('.pagediv').html(str);
                        $('.pagediv th').width('150px')
                        $('.pagediv td').width('150px')
                        $(iframeHead).width(150*$('.pagediv tbody').children('tr').eq(0).children('th').length);
                        $(iframeChild).width(150*$('.pagediv tbody').children('tr').eq(0).children('th').length);

                        if(str==''){
                            var htmlStr='<table style=" margin:0 16px 0 16px"><thead class="thead"><tr></tr></thead><tbody class="tbody"><tr style="border: none;">' +
                                '<td>' +
                                '<img style="display: block;text-align: center;margin: 0 auto;margin-top: 160px;margin-bottom: 10px;" src="/img/main_img/shouyekong.png" alt="">' +
                                '<h2 style="text-align: center;color: #666;font-size: 11pt;">暂无数据</h2>' +
                                '</td>' +
                                '</tr></tbody></table>'
                            $('.pagediv').html(htmlStr);
                            $('.thead tr').find('th').remove();
                            $('#dbgz_page').hide();
                            $(iframeHead).width('100%');
                            $(iframeChild).width('100%');
                        }
                    }
//                    me.pageTwo(json.totleNum, me.data.pageSize, me.data.page)

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
    };
    $("#insert").on("click",function(){
        var year =$('#year option:selected').val()+"-"+$('#month option:selected').val();
        var username = $('#userName').val();
        $.ajax({
            url: '/personBonusmsg/personQuery',
            type: 'get',
            dataType: 'json',
            data:{
                wageDifference:1,
                type:2,
                head:$('#year option:selected').val()+"-"+$('#month option:selected').val(),
                userName:username,
            },
            success: function (json) {
                var str='';
                var str2='';
                var i=0;
                var datas=json.obj;
                if(json.obj.length>0) {
                    $('#dbgz_page').show();
//                    $(iframeHead).width('1850px');
//                    $(iframeChild).width('1850px');
                    for(var j=0;j<datas.length;j++){
                        var arr2 = datas[j].bonusMsgList;
                        var arr= datas[j]
                        for (var s in arr) {
                            i++
                        }
                        if(arr2!=undefined&&arr2!=''){
                            str+='<table style="margin:15px 15px;"><tr>' +
                                '<th  class="th" style="width:95px">月份</th>' +
                                '<th  class="th" style="width:95px">姓名</th>'
                            for (var n = 1; n <= i - 3; n++) {//列表头数据展示
                                var temp = 'DATA_' + n;
                                if(arr[temp]!=null &&arr[temp]!=undefined) {
                                    //判断表头长度来判断所需的宽度
                                    if(temp == 'data50' || temp == 'data51'){
                                        str+='';
                                    }else {
                                        str += '<th  class="th" title="' + arr[temp] + '">' + arr[temp] + '</th>';
                                    }


                                }
                            }
                            str+='</tr>'
                            for(var k=0;k<arr2.length;k++){
                                str+='<tr>'
                                for (var t = 0; t < i - 4; t++) {//列表内容数据展示
                                    var temp = 'DATA_'+ t;
                                    if(arr2[k][temp]!=undefined||t==0) {
                                        if(temp == 'data50' || temp == 'data51'){
                                            str+='';
                                        }else {
                                            if(t==0){
                                                str += '<td >' + arr2[k].YEARS+'年'+arr2[k].MONTH+ '月</td><td >' + arr2[k].USER_NAME+ '</td>';
                                            }else {
                                                str += '<td >' +function(){
                                                    if(arr2[k][temp].toString()=='0.00'){
                                                        return '0'
                                                    }else{
                                                        // console.log(isNaN(arr2[k][temp]))

                                                        if(!isNaN(arr2[k][temp])){
                                                            if(parseFloat(arr2[k][temp]).toFixed(2)=='NaN'){
                                                                return ''
                                                            }else{

                                                                if(arr2[k][temp].toString().indexOf(".00")>=0){
                                                                    return parseFloat(arr2[k][temp]).toFixed(0)
                                                                }else if(arr2[k][temp].length>10&&arr2[k][temp].toString().indexOf(".")==-1){
                                                                    return parseFloat(arr2[k][temp]).toFixed(0)
                                                                }else if(isNaN(parseInt(arr2[k][temp]))){
                                                                    return arr2[k][temp]
                                                                }else{
                                                                    return parseFloat(arr2[k][temp]).toFixed(2)
                                                                }
                                                                // return parseFloat(arr2[k][temp]).toFixed(2)
                                                            }
                                                        }else{
                                                            return arr2[k][temp]
                                                        }

                                                    }

                                                }()   + '</td>';
                                            }
                                        }

                                    }
                                }
                                str+='</tr>'
                            }

                            str+='</table><div bonusId="'+arr.BONUS_ID+'" headId="'+arr.HEAD_ID+'" bonusType="'+arr.BONUS_TYPE+'" class="del">删除本次导入数据</div>';
                        }
                        $('.pagediv').html(str);
                        $('.pagediv th').width('150px')
                        $('.pagediv td').width('150px')
                        $(iframeHead).width(150*$('.pagediv tbody').children('tr').eq(0).children('th').length);
                        $(iframeChild).width(150*$('.pagediv tbody').children('tr').eq(0).children('th').length);

                        if(str==''){
                            var htmlStr='<table style=" margin:0 16px 0 16px"><thead class="thead"><tr></tr></thead><tbody class="tbody"><tr style="border: none;">' +
                                '<td>' +
                                '<img style="display: block;text-align: center;margin: 0 auto;margin-top: 160px;margin-bottom: 10px;" src="/img/main_img/shouyekong.png" alt="">' +
                                '<h2 style="text-align: center;color: #666;font-size: 11pt;">暂无数据</h2>' +
                                '</td>' +
                                '</tr></tbody></table>'
                            $('.pagediv').html(htmlStr);
                            $('.thead tr').find('th').remove();
                            $('#dbgz_page').hide();
                            $(iframeHead).width('100%');
                            $(iframeChild).width('100%');
                        }
                    }
//                    me.pageTwo(json.totleNum, me.data.pageSize, me.data.page)

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
            },
        })
    })
    $(function () {
        ajaxPage.page()
        $('.add').on("click",function () {//导入
            layer.open({
                type: 2,
                title: '<fmt:message code="adding.th.salary" />',
                shadeClose: true,
                shade: 0.5,
                area: ['30%', '350px'],
                content: '/personSalary/personPayimport',
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

        $(document).on('click','.del',function () {
            var bonusId = $(this).attr('bonusId');
            var headId = $(this).attr('headId');
            var bonusType = $(this).attr('bonusType');

            layer.confirm(qued, {
                btn: [sure,cancel] ,//按钮
                title:ifDelete,
                offset:['200px','480px']
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/bonusmsg/delete",
                    type: "get",
                    data:{
                        bonusId:bonusId,
                        headId:headId,
                        bonusType:bonusType
                    },
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: delc, icon: 1}, function () {
                                var bshead=$('#year option:selected').val()+"-"+$('#month option:selected').val()
                                ajaxPage.data.head=bshead;
                                ajaxPage.page();
                            })
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })


        /*$('tbody').on('mouseenter','.publishtip',function () {

         var that = $(this);
         //var str=that.attr('toTypeName').replace(/-/g,'<br>')
         layer.tips(str,that, {
         tips: [1, '#3595CC'],
         time: 10000
         });
         });*/


        $('.query').on("click",function(json){
            var bshead=$('#year option:selected').val()+"-"+$('#month option:selected').val()
            ajaxPage.data.head=bshead;
            ajaxPage.page();
        });

        $('#year,#month').on("change",function () {
            var bshead=$('#year option:selected').val()+"-"+$('#month option:selected').val()
            ajaxPage.data.head=bshead;
            ajaxPage.page();
            $('.personnel').on("change",function () {
                ajaxPage.data.granter = $('.personnel option:selected').val().toString();
                ajaxPage.page();
            });
        });


    })
</script>

</html>
