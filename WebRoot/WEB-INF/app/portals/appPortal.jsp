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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="dem.th.Poag" /></title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">

    <%--<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/news/management_query.css" />--%>

    <!-- 门户设置  -->
    <script src="/js/xoajq/xoajq1.js"></script>

    <script src="../js/news/page.js"></script>

    <script src="../lib/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>


    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/tablePage.js"></script>
    <script src="/js/common/basic.js"></script>
    <%--<script src="http://www.jq22.com/jquery/1.9.1/jquery.min.js"></script>--%>
    <script src="/js/portal/jquery-ui.min.js "></script>
    <script src="/js/portal/jquery.touch-punch.min.js"></script>
    <script src="/js/portal/jquery.shapeshift.js"></script>

    <style>
        html,body{
            width:100%;height:100%;
            background: #fff;
        }
        .total{
            width: 98%;
            margin: auto;
            margin-top: 118px;
        }
        .navigation{
            background: none;

        }
        a {
            text-decoration: none;
            color: #207bd6;
            cursor: pointer;
        }
        select{
            padding: 5px 8px !important;
        }
        td{
            font-size: 11pt;
            line-height: 19px;
            word-break: keep-all;
            white-space: nowrap;
            text-overflow: ellipsis;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-align: center;
        }
        .query {
            width: 550px;
            margin: 133px auto;
        }
        b{
            color: red;
        }

        .all{
            padding-left: 38px;
            display: none;
        }
        .all li{
            margin: 5px 0;
        }

        .btnsava {
            padding: 5px 15px;
            border-radius: 4px;
            background: #2b7fe0;
            color: #fff;
        }
        .div_IMG{
            margin-left: 15px;
        }
        .portalTime{
            margin-top:60px;
        }
        table{
            width:80%;
            margin:0 auto;
        }
        table tr td:nth-child(1){
            width:30%;
        }
        table tr{
            border:none;
        }
        table tbody tr:hover:hover{
            background:none
        }

        .container {
            border: 1px dashed #CCC;
            position: relative;
            min-height: 100px;
            display: flex;
            flex-wrap: wrap;
            /*text-align: left;*/
        }

        .container > div {
            /*background: #AAA;*/
            /*position: absolute;*/
            height: 100px;
            width: 100px;
            padding-left: 10%;
        }

        .container > .ss-placeholder-child {
            background: transparent;
            /*border: 1px dashed blue;*/
        }
        .import{
            background: #3c92e5 !important;
            border-radius: 4px;
            color: #fff !important;
            padding: 3px 10px;
            cursor:pointer;
        }
        #back{
            float:right;
            background: #3c92e5 !important;
            border-radius: 4px;
            color: #fff !important;
            padding: 3px 10px;
            height: 21px;
            width: 50px;
            text-align: center;
            line-height: 21px;
            margin:20px 20px 0px 0px;
            cursor:pointer;
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<script>
    $(document).ready(function() {

    })
</script>
<div class="navigation" style="margin-top: 0px;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
    <h2><fmt:message code="interfaceSetting.th.appPortalContentSetting" /></h2>
    <span id="back"><fmt:message code="interfaceSetting.th.back" /></span>
</div>


<div class="portalTime" style="">
    <table>
        <%--<tr>--%>
        <%--<td>--%>

        <%--</td>--%>
        <%--<td style="text-align: left">显示设置，一行显示<input type="text" style="width:50px;" id="num">个</td>--%>

        <%--</tr>--%>
        <tr>
            <td><fmt:message code="interfaceSetting.th.appPortalDisplayedModules" />:</td>
            <td id="show">
                <div class="container">
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                    <%--<div></div>--%>
                </div>


            </td>
        </tr>
        <tr>
            <td><fmt:message code="interfaceSetting.th.appPortalHiddenModules" />:</td>
            <td id="hide">
                <div class="container shapeshifted_container_h1qwv ui-droppable">
                    <%--<div style="visibility: hidden"></div>--%>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <span class="import"><fmt:message code="interfaceSetting.th.saveContentSetting" /></span>
            </td>
        </tr>
    </table>
</div>
<script>
    var No = $.GetRequest().N0;
    var portalsId = $.GetRequest().portalsId;
    $('#back').click(function(){
        window.location.href='/portals/index'
    })

    $.ajax({
        url:'/getMenu',
        type:'get',
        dataType:'json',

        success:function(res){

            if(res.flag){
                $.ajax({
                    url:'/portals/selPortalsById',
                    dataType:'json',
                    data:{portalsId:portalsId},
                    success:function(datas){
                        $('#num').val(datas.object.showNum)

                        var data = res.obj;
                        var str='';
                        var str1=''
                        var arr=[];
                        var ids=""
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                            ids += data[i].id+','
                        }
                        var portals= datas.object.portalsMenu;
                        if(portals!=""&&portals!=undefined){
                            var portalsArr = portals.split(',')
                            for(var j=0;j<portalsArr.length;j++){

                                if(arr.indexOf(portalsArr[j])>=0){
                                    ids = ids.replace(portalsArr[j]+',','')
                                    for(var k=0;k<data.length;k++){
                                        if(portalsArr[j] == data[k].id){
                                            str += '<div class="aa"><div class="item" id="'+data[k].id+'"><div style="position:relative"><img src="/img/main_img/app/'+data[k].fId+'.png" alt="" style="width: 80px"><div>'+data[k].name+'</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="del"><img src="/img/main_img/app/del.png" alt=""></div></div></div></div>'
                                        }
                                    }

                                }
                            }
                        }else{
                            // ids='a'
                            // for(var a = 0;a<data.length;a++){
                            //      str += '<div class="aa"><div class="item" id="'+data[a].id+'"><div style="position:relative"><img src="/img/main_img/app/'+data[a].id+'.png" alt=""><div>'+data[a].name+'</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="del"><img src="/img/main_img/app/del.png" alt=""></div></div></div></div>'
                            // }
                        }





                        if(ids!=''&&ids!='a') {
                            var idsArr = ids.split(',');
                            for(var m=0;m<idsArr.length;m++){
                                for(var n=0;n<data.length;n++){
                                    if(idsArr[m] == data[n].id){
                                        str1 += '<div class="aa"><div class="item" id="'+data[n].id+'"><div style="position:relative"><img src="/img/main_img/app/'+data[n].fId+'.png" alt="" style="width: 80px"><div>'+data[n].name+'</div><div style="position:absolute;right:-8px;top:0px;cursor:pointer;" class="add"><img src="/img/main_img/app/add.png" alt=""></div></div></div></div>'
                                    }
                                }

                            }
                        }

                        $('#show .container').html(str);
                        $('#hide .container').html(str1);
                        $(".container").shapeshift();

                    }
                })



            }
        }
    })
    $('.import').click(function(){
        var ids="";
        for(var i = 0;i<$('#show .container .item').length;i++){
            ids += $('#show .container .item').eq(i).attr('id')+','
        }
        console.log(ids)
        $.ajax({
            url:'/portals/update',
            type:'get',
            dataType:'json',
            data:{portalsMenu:ids,portalsId:portalsId,
                portalsNo: No,showNum:$('#num').val()},
            success:function(res){
                if(res.flag){
                    layer.msg('提交成功！', {icon: 1, time: 2000,offset:['40%','45%'],});
                    // $.layerMsg({content:'提交成功',icon:1})
                }else{
                    layer.msg('提交失败！', {icon: 1, time: 2000,offset:['40%','45%'],});
                }
            }
        })
    })
    $('#show').on('click','.del',function(e){
        e.stopPropagation();
        $(this).addClass('add').removeClass('del').html('<img src="/img/main_img/app/add.png"/>')
        $(this).parents('.aa').appendTo('#hide .container');
        $(".container").shapeshift();
    })
    $('#hide').on('click','.add',function(e){
        e.stopPropagation();
        $(this).addClass('del').removeClass('add').html('<img src="/img/main_img/app/del.png"/>')
        $(this).parents('.aa').appendTo('#show .container');
        $(".container").shapeshift();
    })
</script>

</body>
</html>
