<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="sms.th.ReceivedReminder" /></title>

    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>

<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>

    <style>
        html,body{
            width:100%;
            height:100%;
        }
        .countSpan {
            color: red;
        }

        .contentTableBody {
            text-align: center;
        }

        .detail_a {
            color: dodgerblue;
            cursor: pointer;
        }

        .bottom_a_style {
            cursor: pointer;
            margin-left: 10px;
            color: #404060;
            display: inline-block;
            padding-left: 22px;
            line-height: 25px;
        }

        .headTable tr {
            border: none;
        }

        table {
            width: 98%;
            margin: 0px 1%;
        }

        .contentTable {
            margin-top: 10px;
        }

        .contentTable thead tr {
            height: 50px;
        }

        label {
            cursor: pointer;
        }

        .contentTableBody tr {
            background: #F6F7F9;
        }

        .contentTableBody tr td{
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }

        .contentTableBody tr:nth-child(even) {
            background: #ffffff;
        }

        .title_span{
            font-size: 20px;
        }
        .font{
            color: white;
            background-color:  #2B7FE0;
        }
        .bottom_table{
            margin-top: 20px;
        }
        .bottom_table .first_td{
            background-color: #f2f2f2;
            border-right: 1px #dddddd solid;
            width: 80px;
        }
        .M-box3{
            margin-top: 0px!important;
        }
        .bottom_table a {
            cursor: pointer;
            margin-left: 10px;
            color: #404060;
            display: inline-block;
            padding-left: 22px;
            line-height: 25px;
        }
        .delete_a{
            background: url(../../img/sms/icon_affairremind_delete_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
        }
        .delete_allRead{
            background: url(../../img/sms/icon_affairremind_delete_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
        }
        .delete_all{
            background: url(../../img/sms/icon_affairremind_delete_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
        }
        .remind_a{
            background: url(../../img/sms/icon_readmark_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 4px;
        }
        .remind_all{
            background: url(../../img/sms/icon_readmarkall_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 4px;
        }
        .title_span{
            margin-left: 5px;
        }
        .page-top-inner-layer table {
            text-align: left;
        }
        .jianju{
            width: 98%;
            margin: 0 1%;
        }
        .juzuo{
            padding: 10px;
        }
        .pagediv .page-top-inner-layer{
            padding-right: 0 !important;
        }
        .pagediv .page-bottom-inner-layer{
            height: 500px!important;
        }
        .imgDiv{
            text-align: center;
            display: none;
            margin-top: 60px;
        }
        .fonts{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
</head>
<body>

<table class="headTable jianju">
    <tr >
        <td class="juzuo"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/title_received_sms.png" alt=""><span class="title_span"><fmt:message code="sms.th.ReceivedReminder" /></span>&nbsp;&nbsp;(<fmt:message code="main.th.general" /><span class="countSpan">0</span><fmt:message code="main.th.BarReminder" />)</td>
        <td></td>
        <td>
        </td>
    </tr>
</table>

<div style="margin-top: 10px">
    <div class="tab" style="display: flex;margin-left: 20px;flex-wrap: wrap;">
    </div>
</div>
<div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
    <div><fmt:message code="doc.th.NoData" /></div>
</div>
<%--<table class="contentTable" style="table-layout: fixed; " >--%>
<%--<thead>--%>
<%--<tr>--%>
<%--<th style="width: 9%;text-align:center;padding-left:10px"><fmt:message code="global.lang.select" /></th>--%>
<%--<th style="width: 16%"><fmt:message code="sup.th.Sender" /></th>--%>
<%--<th style="width: 15%"><fmt:message code="notice.th.type" /></th>--%>
<%--<th style="width: 30%"><fmt:message code="notice.th.content" /></th>--%>
<%--<th style="width: 20%"><fmt:message code="sup.th.SendingTime" /></th>--%>
<%--<th style="width: 10%"><fmt:message code="notice.th.operation" /></th>--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody class="contentTableBody">--%>

<%--</tbody>--%>
<%--</table>--%>

<%--<table class="bottom_table">--%>
<%--<tr>--%>
<%--<td class="first_td"><fmt:message code="news.th.Quickoperation" />：</td>--%>
<%--<td colspan=""><a class="delete_allRead"><fmt:message code="sms.th.DeleteAll" /></a><a class="delete_all"><fmt:message code="meet.th.DeleteAll" /></a><a class="remind_all"><fmt:message code="sms.th.AllMarkedRead" /></a></td>--%>
<%--</tr>--%>
<%--</table>--%>

<div id="pagediv" style="margin-top: 10px" ></div>

<script type="text/javascript">
    var param = $.GetRequest();
    var smsType1
    if($('.font').val()==undefined){
        smsType1 = param.smsType
    }
    if(smsType1==undefined){
        smsType1=''
    }
    var count
    var font
    var str1=''
    var smsType=''
    var a=''
    $.ajax({
        url: "/sms/classification",
        type: 'post',
        dataType: "JSON",
        data:{
            queryType:2
        },
        success: function (res) {
            str1 += '<button id="all"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab1()" ><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px"  src="/img/commonTheme/theme6/title_received_sms.png"></img></div><div class="fonts"  style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px"><fmt:message code="sms.th.ReceivedReminder" /></div></button>'
            for (var i = 0; i < res.data.length; i++) {
                if (res.data[i].smsType == '16' || res.data[i].smsType == '17') {
                    str1 += '<button id="'+i+'"  style="width: 180px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab('+res.data[i].smsType+','+i+')" value="'+res.data[i].smsType+'"><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px;border-radius: 5px;"  src="'+res.data[i].smsTypeIcon+'"></img></div><div class="fonts" style="width: 146px;height: 36px;margin-top: 8px;font-size: 15px">' + res.data[i].smsTypeName + '</div></button>'
                } else {
                    str1 += '<button id="'+i+'"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab('+res.data[i].smsType+','+i+')" value="'+res.data[i].smsType+'"><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px;border-radius: 5px;"  src="'+res.data[i].smsTypeIcon+'"></img></div><div class="fonts" style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px">' + res.data[i].smsTypeName + '</div></button>'
                }
            }
            $('.tab').html(str1)
            if(smsType1==''){
                $(".tab >#all").attr('class','font')
            }
            for ( var j = 0; j <res.data.length; j++ ) {
                if(smsType1==res.data[j].smsType){
                    $(".tab >#all").removeAttr('class','font')
                    $("button").eq(j+1).attr('class','font')
                }


            }
            if(res.data.length=='0'){
                $(".tab >#all").hide()
            }

        }
    });

    function tab1(){
        $("button").removeAttr('class','font')
        $(".tab >#all").attr('class','font')
        var pageObj=$.tablePage('#pagediv','100%',[
                {
                    width:'46px',
                    title:'<fmt:message code="global.lang.select" />',
                    name:'nulls',
                    selectFun:function (name,obj) {

                        return '<input type="checkbox" smsId="' + obj.smsId +' " bodyId="'+obj.bodyId+'"/>'
                    }
                },
                {
                    width:'120px',
                    title:'<fmt:message code="sup.th.Sender" />',
                    name:'fromName'
                },
                {
                    width:'120px',
                    title:'<fmt:message code="notice.th.type" />',
                    name:'smsTypeName'
                },
                {
                    width:'320px',
                    title:'<fmt:message code="notice.th.content" />',
                    name:'content',
                    selectFun:function (name,obj) {
                        //console.log(obj.content);
                        var special = obj.content;
                        var color='#2B7FE0';
                        if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                            color='red'
                            // $(".txtContent").css("color","red");
                        }
                        return '<div class="btnTd" style="color:'+color+';cursor: pointer;" remindUrl="'+obj.remindUrl+'" smsId="' + obj.smsId +' "   bodyId="' + obj.bodyId +' " title="' + obj.content + '">'+obj.content+'</div>'


                    }
                },{
                    width:'170px',
                    title:'<fmt:message code="sup.th.SendingTime" />',
                    name:'sendTimeStr'
                },
                {
                    width:'120px',
                    title:'<div style="padding-left:13px;"><fmt:message code="notice.th.operation" /></div>'
                }
            ],function (me) {
                me.data.queryType=2;
                me.data.pageSize=10;
                //1显示  // 2不显示  //不写fn这个属性就是全显示
                me.init('/sms/selectByQueryType',[{name:'<fmt:message code="roleAuthorization.th.ViewDetails" />',fn:function (obj) {
                        return '<a class="detail_a" remindUrl="'+encodeURI(obj.remindUrl)+'" onclick="look(\''+obj.remindUrl+'\','+ obj.bodyId + ')"><fmt:message code="roleAuthorization.th.ViewDetails" /></a>'
                    }}],function (json) {
                    $('.countSpan').html(" " + json.totleNum + " ");
                    var str = "<tr class='last_str'>" +
                        "<td style='display: flex;width: 100px; '><input id='checkedAll' style='float:left; '  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;margin-top: 3px;\n" +
                        "    margin-left: 6px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                        "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="menuSSetting.th.deleteMenu" /></a></td>" +
                        "</tr>"+'<tr class="bottom_table"> <td colspan="2" class="first_td"><fmt:message code="news.th.Quickoperation" />：</td> <td colspan="4"><a class="delete_allRead"><fmt:message code="sms.th.DeleteAll" /></a></td> </tr>';
                    $('#operation').html(str);
                })
            }
        )
        // 删除
        $('.pagediv').on('click', '.delete_a', function () {

            if ($("#pageTbody tr td input:checked").length == 0) {
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />", {icon: 0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteTheData" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var bodyIds = '';
                $("#pageTbody tr td input:checked").each(function () {

                    bodyIds += $(this).attr("bodyId") + ',';
                });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
                smsType1 = ''
                smsType1 = $('.font').val()
                if (smsType1 == undefined) {
                    smsType1 = ''
                }
                $.ajax({
                    type: "post",
                    url: "/sms/delete",
                    dataType: 'JSON',
                    data: {"smsIds": smsId, "deleteFlag": "1",},
                    success: function (res) {
                        if (res.flag) {
                            var c = $('.font').val()
                            $.ajax({
                                url: '/sms/selectByQueryType',
                                dataType: 'json',
                                type: 'get',
                                data: {
                                    smsType: c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success: function (res) {
                                    var totleNum = res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            $('#checkedAll').prop("checked", false);
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />", {icon: 1});
                            pageObj.init();
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                        } else {
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />", {icon: 2});
                        }
                    }
                })
            });
        });
        // 全部删除
        $('#operation').on("click",".delete_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                $.ajax({
                    type: "post",
                    url: "/sms/delete",
                    dataType: 'JSON',
                    data: {"deleteFlag":"1",},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            pageObj.init();
//                            initPageList(function (pageCount) {
//                                initPagination(pageCount, data.pageSize);
//                            });
                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });

        // 标记为已读
        $('.pagediv').on('click', '.remind_a', function () {

            if ($("#pageTbody tr td input:checked").length == 0) {
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />", {icon: 0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkTheDataAsRead" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var bodyIds = '';
                $("#pageTbody tr td input:checked").each(function () {
                    bodyIds += $(this).attr("bodyId") + ',';
                });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
                $.ajax({
                    type: "post",
                    url: "/sms/updateRemind",
                    dataType: 'JSON',
                    data: {"smsIds": smsId, "remindFlag": "0", queryType: 2},
                    success: function (res) {
                        if (res.flag) {
                            parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />", {icon: 1});
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                            pageObj.init();
                        } else {
                            parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />", {icon: 2});
                        }
                    }
                })
            });
        });

        // 全部标记为已读
        $('#operation').on("click",".remind_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkAllAsRead" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var set = $('.font').val()
                $.ajax({
                    type: "post",
                    url: "/sms/updateRemind",
                    dataType: 'JSON',
                    data: {"remindFlag": "0", queryType: 2, smsType: set},
                    success: function (res) {
                        if (res.flag) {
                            parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />", {icon: 1});
                            pageObj.init();
                            // initPageList(function (pageCount) {
                            //     initPagination(pageCount, data.pageSize);
                            // });
                        } else {
                            parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />", {icon: 2});
                        }
                    }
                })
            });
        });

        // 删除所有已读
        $('#operation').on("click",".delete_allRead",function () {

            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheReadData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var set=$('.font').val()
                smsType1=''
                smsType1=$('.font').val()
                if(smsType1==undefined){
                    smsType1=''
                }
                $.ajax({
                    type: "post",
                    url: "/sms/deleteByRemind",
                    dataType: 'JSON',
                    data:{"deleteType":"1",smsType:set},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            });
                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });
    }

    function tab(data,i){
        $("button").removeAttr('class','font')
        smsType=data;
        $("button").eq(i+1).attr('class','font')
        var pageObj=$.tablePage('#pagediv','100%',[
                {
                    width:'46px',
                    title:'<fmt:message code="global.lang.select" />',
                    name:'nulls',
                    selectFun:function (name,obj) {

                        return '<input type="checkbox" smsId="' + obj.smsId +' " bodyId="'+obj.bodyId+'"/>'
                    }
                },
                {
                    width:'120px',
                    title:'<fmt:message code="sup.th.Sender" />',
                    name:'fromName'
                },
                {
                    width:'120px',
                    title:'<fmt:message code="notice.th.type" />',
                    name:'smsTypeName'
                },
                {
                    width:'320px',
                    title:'<fmt:message code="notice.th.content" />',
                    name:'content',
                    selectFun:function (name,obj) {
                        //console.log(obj.content);
                        var special = obj.content;
                        var color='#2B7FE0';
                        if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                            color='red'
                            // $(".txtContent").css("color","red");
                        }
                        return '<div class="btnTd" style="color:'+color+';cursor: pointer;" remindUrl="'+obj.remindUrl+'" smsId="' + obj.smsId +' "  bodyId="' + obj.bodyId +' " title="' + obj.content + '">'+obj.content+'</div>'


                    }
                },{
                    width:'170px',
                    title:'<fmt:message code="sup.th.SendingTime" />',
                    name:'sendTimeStr'
                },
                {
                    width:'120px',
                    title:'<div style="padding-left:13px;"><fmt:message code="notice.th.operation" /></div>'
                }
            ],function (me) {
                me.data.queryType=2;
                me.data.pageSize=10;
                //1显示  // 2不显示  //不写fn这个属性就是全显示
                me.init('/sms/selectByQueryType?smsType='+smsType,[{name:'<fmt:message code="roleAuthorization.th.ViewDetails" />',fn:function (obj) {
                        return '<a class="detail_a" remindUrl="'+encodeURI(obj.remindUrl)+'" onclick="look(\''+obj.remindUrl+'\','+ obj.bodyId + ')"><fmt:message code="roleAuthorization.th.ViewDetails" /></a>'
                    }}],function (json) {
                    $('.countSpan').html(" " + json.totleNum + " ");
                    var str = "<tr class='last_str'>" +
                        "<td style='display: flex;width: 100px; '><input id='checkedAll' style='float:left; '  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;margin-top: 3px;\n" +
                        "    margin-left: 6px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                        "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="menuSSetting.th.deleteMenu" /></a></td>" +
                        "</tr>"+'<tr class="bottom_table"> <td colspan="2" class="first_td"><fmt:message code="news.th.Quickoperation" />：</td> <td colspan="4"><a class="delete_allRead"><fmt:message code="sms.th.DeleteAll" /></a></td> </tr>';
                    $('#operation').html(str);
                })
            }
        )

        // 删除
        $('.pagediv').on('click', '.delete_a', function () {

            if($("#pageTbody tr td input:checked").length==0){
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var bodyIds = '';
            $("#pageTbody tr td input:checked").each(function () {

                bodyIds+=$(this).attr("bodyId")+',';
            });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
            smsType1=''
            smsType1=$('.font').val()
            if(smsType1==undefined){
                smsType1=''
            }

            $.ajax({
                type: "post",
                url: "/sms/delete",
                dataType: 'JSON',
                data: {"smsIds":smsId,"deleteFlag":"1",},
                success: function (res) {
                    if(res.flag){
                        var c=$('.font').val()
                        $.ajax({
                            url:'/sms/selectByQueryType',
                            dataType:'json',
                            type:'get',
                            data:{
                                smsType:c,
                                page: 1,
                                pageSize: 10,
                                useFlag: true,
                                queryType: 2,
                            },
                            success:function(res){
                                var  totleNum=res.totleNum
                                $('.countSpan').html(" " + totleNum + " ");
                            }
                        })
                        $('#checkedAll').prop("checked", false);
                        parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                        pageObj.init();
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                    }else{
                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                    }
                }
            })
        });
    });
        // 全部删除
        $('#operation').on("click",".delete_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                $.ajax({
                    type: "post",
                    url: "/sms/delete",
                    dataType: 'JSON',
                    data: {"deleteFlag":"1",},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            pageObj.init();
//                            initPageList(function (pageCount) {
//                                initPagination(pageCount, data.pageSize);
//                            });
                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });

        // 标记为已读
        $('.pagediv').on('click', '.remind_a', function () {

            if ($("#pageTbody tr td input:checked").length == 0) {
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />", {icon: 0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkTheDataAsRead" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var bodyIds = '';
                $("#pageTbody tr td input:checked").each(function () {
                    bodyIds += $(this).attr("bodyId") + ',';
                });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
                $.ajax({
                    type: "post",
                    url: "/sms/updateRemind",
                    dataType: 'JSON',
                    data: {"smsIds": smsId, "remindFlag": "0", queryType: 2},
                    success: function (res) {
                        if (res.flag) {
                            parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />", {icon: 1});
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                            pageObj.init();
                        } else {
                            parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />", {icon: 2});
                        }
                    }
                })
            });
        });

        // 全部标记为已读
        $('#operation').on("click",".remind_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkAllAsRead" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var set = $('.font').val()
                $.ajax({
                    type: "post",
                    url: "/sms/updateRemind",
                    dataType: 'JSON',
                    data: {"remindFlag": "0", queryType: 2, smsType: set},
                    success: function (res) {
                        if (res.flag) {
                            parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />", {icon: 1});
                            pageObj.init();
                            // initPageList(function (pageCount) {
                            //     initPagination(pageCount, data.pageSize);
                            // });
                        } else {
                            parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />", {icon: 2});
                        }
                    }
                })
            });
        });

        // 删除所有已读
        $('#operation').on("click",".delete_allRead",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheReadData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var set=$('.font').val()
                smsType1=''
                smsType1=$('.font').val()
                if(smsType1==undefined){
                    smsType1=''
                }
                $.ajax({
                    type: "post",
                    url: "/sms/deleteByRemind",
                    dataType: 'JSON',
                    data:{"deleteType":"1",smsType:set},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            pageObj.init();
                            // initPageList(function (pageCount) {
                            //     initPagination(pageCount, data.pageSize);
                            // });
                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });
    }


    <%--使用表格分页插件--%>
    var pageObj=$.tablePage('#pagediv','100%',[
            {
                width:'46px',
                title:'<fmt:message code="global.lang.select" />',
                name:'nulls',
                selectFun:function (name,obj) {

                    return '<input type="checkbox" smsId="' + obj.smsId +' " bodyId="'+obj.bodyId+'"/>'
                }
            },
            {
                width:'120px',
                title:'<fmt:message code="sup.th.Sender" />',
                name:'fromName'
            },
            {
                width:'120px',
                title:'<fmt:message code="notice.th.type" />',
                name:'smsTypeName'
            },
            {
                width:'320px',
                title:'<fmt:message code="notice.th.content" />',
                name:'content',
                selectFun:function (name,obj) {
                    //console.log(obj.content);
                    var special = obj.content;
                    var color='#2B7FE0';
                    if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                        color='red'
                        // $(".txtContent").css("color","red");
                    }
                    return '<div class="btnTd" style="color:'+color+';cursor: pointer;" remindUrl="'+obj.remindUrl+'" smsId="' + obj.smsId +' "  bodyId="' + obj.bodyId +' " title="' + obj.content + '">'+obj.content+'</div>'


                }
            },{
                width:'170px',
                title:'<fmt:message code="sup.th.SendingTime" />',
                name:'sendTimeStr'
            },
            {
                width:'120px',
                title:'<div style="padding-left:13px;"><fmt:message code="notice.th.operation" /></div>'
            }
        ],function (me) {
            me.data.queryType=2;
            me.data.pageSize=10;
            //1显示  // 2不显示  //不写fn这个属性就是全显示
            me.init('/sms/selectByQueryType?smsType='+smsType1,[{name:'<fmt:message code="roleAuthorization.th.ViewDetails" />',fn:function (obj) {
                    return '<a class="detail_a" remindUrl="'+encodeURI(obj.remindUrl)+'" onclick="look(\''+obj.remindUrl+'\','+ obj.bodyId + ')"><fmt:message code="roleAuthorization.th.ViewDetails" /></a>'
                }}],function (json) {
                $('.countSpan').html(" " + json.totleNum + " ");
                var str = "<tr class='last_str'>" +
                    "<td style='display: flex;width: 100px; '><input id='checkedAll' style='float:left; '  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;margin-top: 3px;\n" +
                    "    margin-left: 6px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                    "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="menuSSetting.th.deleteMenu" /></a></td>" +
                    "</tr>"+'<tr class="bottom_table"> <td colspan="2" class="first_td"><fmt:message code="news.th.Quickoperation" />：</td> <td colspan="4"><a class="delete_allRead"><fmt:message code="sms.th.DeleteAll" /></a></td> </tr>';
                $('#operation').html(str);
            })
        }
    )

    $('.Query').on('click',function () {
        pageObj.data.page=1;
        pageObj.data.fromName=$('[name="fromName"]').val();
        pageObj.data.smsTypeName=$('[name="smsTypeName"]').val()
        pageObj.data.content=$('[name="content"]').val()
        pageObj.data.sendTimeStr=$('[name="sendTimeStr"]').val()
        pageObj.init();
    })
    //点击全选
    $('#pagediv').on('click', '#checkedAll', function () {

        var state = $(this).prop("checked");
        if (state == true) {
            $(this).prop("checked", true);
            $("#pageTbody tr td input").prop("checked", true);
        } else {
            $(this).prop("checked", false);
            $("#pageTbody tr td input").prop("checked", false);
        }
    });

    $(function () {
//        var data = {
//            queryType: 2,
//            page: 1,
//            pageSize: 5,
//            useFlag: true
//        };
//        initPageList(function (pageCount) {
//            initPagination(pageCount, data.pageSize);
//        });

        <%--function initPagination(totalData, pageSize) {--%>
        <%--$('.M-box3').pagination({--%>
        <%--totalData: totalData,--%>
        <%--showData: pageSize,--%>
        <%--jump: true,--%>
        <%--coping: true,--%>
        <%--current: data.page,--%>
        <%--homePage: '<fmt:message code="global.page.first" />',--%>
        <%--endPage: '<fmt:message code="global.page.last" />',--%>
        <%--prevContent: '<fmt:message code="global.page.pre" />',--%>
        <%--nextContent: '<fmt:message code="global.page.next" />',--%>
        <%--jumpBtn: '<fmt:message code="global.page.jump" />',--%>
        <%--callback: function (index) {--%>
        <%--data.page = index.getCurrent();--%>
        <%--initPageList(function (pageCount) {--%>
        <%--initPagination(pageCount, data.pageSize);--%>
        <%--});--%>
        <%--}--%>
        <%--});--%>
        <%--}--%>

        <%--function initPageList(cb) {--%>
        <%--$.ajax({--%>
        <%--type: "get",--%>
        <%--url: "/sms/selectByQueryType",--%>
        <%--dataType: 'JSON',--%>
        <%--data: data,--%>
        <%--success: function (data) {--%>
        <%--var str = "";--%>

        <%--for (var i = 0; i < data.obj.length; i++) {--%>
        <%--// 格式化时间--%>
        <%--var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');--%>
        <%--if (data.obj[i].fromName == undefined) {--%>
        <%--data.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";--%>
        <%--}--%>

        <%--str += "<tr><td style='width: 3em ' ><input class='checkChild' type='checkbox' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +--%>
        <%--"<td style='width: 5em '>" + data.obj[i].fromName + "</td>" +--%>
        <%--"<td style='width: 4em'>" + data.obj[i].smsTypeName + "</td>" +--%>
        <%--"<td title='"+ data.obj[i].content +"'>" + data.obj[i].content + "</td>" +--%>
        <%--"<td style='width:6em'>" + sendTime + "</td>" +--%>
        <%--"<td><a class='detail_a'  remindUrl='"+data.obj[i].remindUrl+"'  bodyId='" + data.obj[i].bodyId + "' >查看详情</a></td></tr>";--%>
        <%--}--%>

        <%--var last_str = "<tr class='last_str'>" +--%>
        <%--"<td><input id='checkedAll' style='float:left; margin-left: 1rem;'  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;'><fmt:message code="notice.th.allchose" /></label></td>" +--%>
        <%--"<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="menuSSetting.th.deleteMenu" /></a><a class='remind_a bottom_a_style' ><fmt:message code="sms.th.MarkRead" /></a></td>" +--%>
        <%--"</tr>";--%>

        <%--if (data.totleNum != undefined) {--%>
        <%--$('.countSpan').html(" " + data.totleNum + " ");--%>
        <%--}--%>
        <%--$(".contentTableBody").html(str + last_str);--%>

        <%--if (data.totleNum == 0) {--%>
        <%--parent.layer.msg("<fmt:message code="sms.th.noData" />");--%>
        <%--}--%>
        <%--if (cb) {--%>
        <%--cb(data.totleNum);--%>
        <%--}--%>

        <%--initPagination(data.totleNum, 5);--%>
        <%--}--%>
        <%--})--%>
        <%--}--%>

        //点击全选
        $('.contentTableBody').on('click', '#checkedAll', function () {
//          alert('111');
            var state = $(this).prop("checked");
            if (state == true) {
                $(this).prop("checked", true);
                $(".checkChild").prop("checked", true);
            } else {
                $(this).prop("checked", false);
                $(".checkChild").prop("checked", false);
            }
        });

        $('#pagediv').on('click','.btnTd',function () {
            var remindUrl = $(this).attr("remindUrl");
            if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){                window.open(remindUrl);
            }else{
                window.open('/'+encodeURI(remindUrl));
            }
        })

        // 删除
        $('.pagediv').on('click', '.delete_a', function () {
            if($("#pageTbody tr td input:checked").length==0){
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var bodyIds = '';
            $("#pageTbody tr td input:checked").each(function () {
                bodyIds+=$(this).attr("bodyId")+',';
            });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
            smsType1=''
            smsType1=$('.font').val()
            if(smsType1==undefined){
                smsType1=''
            }
            $.ajax({
                type: "post",
                url: "/sms/delete",
                dataType: 'JSON',
                data: {"smsIds":smsId,"deleteFlag":"1",},
                success: function (res) {
                    if(res.flag){
                        var c=$('.font').val()
                        $.ajax({
                            url:'/sms/selectByQueryType',
                            dataType:'json',
                            type:'get',
                            data:{
                                smsType:c,
                                page: 1,
                                pageSize: 10,
                                useFlag: true,
                                queryType: 2,
                            },
                            success:function(res){
                                var  totleNum=res.totleNum
                                $('.countSpan').html(" " + totleNum + " ");
                            }
                        })
                        $('#checkedAll').prop("checked", false);
                        parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                        pageObj.init();
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                    }else{
                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                    }
                }
            })
        });
        });
        // 全部删除
        $('#operation').on("click",".delete_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                $.ajax({
                    type: "post",
                    url: "/sms/delete",
                    dataType: 'JSON',
                    data: {"deleteFlag":"1",},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            pageObj.init();
//                            initPageList(function (pageCount) {
//                                initPagination(pageCount, data.pageSize);
//                            });
                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });

        // 标记为已读
        $('.pagediv').on('click', '.remind_a', function () {
            if($("#pageTbody tr td input:checked").length==0){
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkTheDataAsRead" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
            var bodyIds = '';
            $("#pageTbody tr td input:checked").each(function () {
                bodyIds+=$(this).attr("bodyId")+',';
            });
                var smsId = '';
                $("#pageTbody tr td input:checked").each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
            smsType1=''
            smsType1=$('.font').val()
            if(smsType1==undefined){
                smsType1=''
            }

            $.ajax({
                type: "post",
                url: "/sms/updateRemind",
                dataType: 'JSON',
                data: {"smsIds":smsId,"remindFlag":"0",queryType:2},
                success: function (res) {
                    if(res.flag){
                        parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />",{icon:1});
//                        initPageList(function (pageCount) {
//                            initPagination(pageCount, data.pageSize);
//                        });
                        pageObj.init();
                    }else{
                        parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />",{icon:2});
                    }
                }
            })
        });
        });
        // 全部标记为已读
        $('#operation').on("click",".remind_all",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToMarkAllAsRead" />", {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function () {
                var set = $('.font').val()
                $.ajax({
                    type: "post",
                    url: "/sms/updateRemind",
                    dataType: 'JSON',
                    data: {"remindFlag": "0", queryType: 2, smsType: set},
                    success: function (res) {
                        if (res.flag) {
                            parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />", {icon: 1});
                            pageObj.init();
                            // initPageList(function (pageCount) {
                            //     initPagination(pageCount, data.pageSize);
                            // });
                        } else {
                            parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />", {icon: 2});
                        }
                    }
                })
            });
        });

        // 删除所有已读
        $('#operation').on("click",".delete_allRead",function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteAllTheReadData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var set=$('.font').val()
                smsType1=''
                smsType1=$('.font').val()
                if(smsType1==undefined){
                    smsType1=''
                }
                $.ajax({
                    type: "post",
                    url: "/sms/deleteByRemind",
                    dataType: 'JSON',
                    data:{"deleteType":"1",smsType:set},
                    success: function (res) {
                        if(res.flag){
                            var c=$('.font').val()
                            $.ajax({
                                url:'/sms/selectByQueryType',
                                dataType:'json',
                                type:'get',
                                data:{
                                    smsType:c,
                                    page: 1,
                                    pageSize: 10,
                                    useFlag: true,
                                    queryType: 2,
                                },
                                success:function(res){
                                    var  totleNum=res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});
                            pageObj.init();
                            // initPageList(function (pageCount) {
                            //     initPagination(pageCount, data.pageSize);
                            // });

                        }else{
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});
                        }
                    }
                })
            });
        });

        // 详情点击事件
        <%--$('.detail_a').on('click', function () {--%>
        <%--    alert(111111)--%>
        <%--    var remindUrl = $(this).attr("remindUrl");--%>
        <%--    var bodyId = $(this).attr("bodyId");--%>
        <%--    $.ajax({--%>
        <%--        type: "post",--%>
        <%--        url: "/sms/setRead",--%>
        <%--        dataType: 'JSON',--%>
        <%--        data: {"bodyId":bodyId},--%>
        <%--        success: function (res) {--%>
        <%--        }--%>
        <%--    })--%>
        <%--    if(remindUrl.indexOf('http://') > -1||remindUrl.indexOf('https://') > -1){--%>
        <%--        window.open(remindUrl);--%>
        <%--    }else{--%>
        <%--        window.open('/'+encodeURI(remindUrl));--%>
        <%--    }--%>
        <%--});--%>
        window.look = function(remindUrl,bodyId) {
            $.ajax({
                type: "post",
                url: "/sms/setRead",
                dataType: 'JSON',
                data: {"bodyId":bodyId},
                success: function (res) {
                }
            })
            if((remindUrl.indexOf('/work/workformPreView') > -1||remindUrl.indexOf('/work/workform') > -1)&&remindUrl.indexOf('&tableName=document') > -1){
                remindUrl += '&ie_open=yes';
            }
            if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){
                window.open(remindUrl);
            }else{
                window.open('/'+encodeURI(remindUrl));
            }
        }

    });

    function kaifa() {
        parent.layer.msg("<fmt:message code="sup.th.UnderDevelopment" />", {icon: 1});
    }

</script>
</body>
</html>
