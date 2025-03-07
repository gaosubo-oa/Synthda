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
    <title><fmt:message code="sms.th.UnconfirmedReminders" /></title>

    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <script src="/js/common/language.js"></script>
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
            color: #404060;
            cursor: pointer;
            margin-left: 10px;
            display: inline-block;
            padding-left: 23px;
            line-height: 25px;
        }

        .headTable tr {
            border: none;
        }

        table {
            width: 98%;
            margin: 0px 1%;
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

        .delete_a{
            background: url(../../img/sms/icon_affairremind_delete_12.png)  no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
        }
        .remind_a{
            background: url(../../img/sms/icon_readmark_12.png)  no-repeat;
            background-position-y: 5px;
            padding-right: 4px;
        }
        .remind_all{
            background: url(../../img/sms/icon_readmarkall_12.png)  no-repeat;
            background-position-y: 5px;
            padding-right: 2px;
        }
        .title_span{
            margin-left: 5px;
        }
        .contentTable thead th{
            font-size: 13pt;
            color: #2F5C8F;
            text-align: left;
            padding-left: 10px;
        }
        .font{
            color: white;
            background-color:  #2B7FE0;
        }
        .contentTableBody  td {
            font-size: 11pt;
            text-align: left;
        }
        .imgDiv{
            text-align: center;
            display: none;
            margin-top: 60px;
        }
        .fonts{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        @media screen and (max-width:1366px){
            .txtContent{
                width: 300px;
            }
        }
        @media screen and (min-width:1367px){
            .txtContent{
                width: 540px;
            }
        }
        .btnTd{
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<table class="headTable" >
    <tr>
        <td><img src="/img/commonTheme/${sessionScope.InterfaceModel}/title_unconfirmed_sms.png" alt=""><span class="title_span"><fmt:message code="sms.th.UnconfirmedReminders" /></span>&nbsp;&nbsp;(<fmt:message code="main.th.general" /><span class="countSpan">0</span><fmt:message code="main.th.BarReminder" />)</td>
        <td></td>
        <td>
        </td>
    </tr>
</table>

<div style="margin-top: 10px">
    <div class="tab" style="display: flex;margin-left: 20px;flex-wrap: wrap;">
    </div>
</div>
<center><div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
    <div><fmt:message code="doc.th.NoData" /></div>
</div></center>
<table class="contentTable" style="table-layout: fixed;margin-top: 10px">
    <thead>
    <tr>
        <th style="width: 5%;min-width:50px;text-align: left"><fmt:message code="global.lang.select" /></th>
        <th style="width: 10%;"><fmt:message code="sup.th.Sender" /></th>
        <th style="width: 15%;"><fmt:message code="notice.th.type" /></th>
        <th style="width: 40%;"><fmt:message code="notice.th.content" /></th>
        <th style="width: 20%;"><fmt:message code="sup.th.SendingTime" /></th>
        <th style="width: 10%;"><fmt:message code="notice.th.operation" /></th>
    </tr>
    </thead>
    <tbody class="contentTableBody">

    </tbody>
</table>
<div class="M-box3">

</div>
<script type="text/javascript">
    var param = $.GetRequest();
    var smsType1
    if($('.font').val()==undefined){
        smsType1 = param.smsType
    }
    if(smsType1==undefined){
        smsType1=''
    }
    var font
    var str1=''
    var smsType=''
    var a=''
    $.ajax({
        url: "/sms/classification",
        type: 'post',
        dataType: "JSON",
        data:{
            queryType:1
        },
        success: function (res) {
            str1 += '<button id="all"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab1()" ><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px"  src="/img/commonTheme/theme6/title_unconfirmed_sms.png"></img></div><div  class="fonts" style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px"><fmt:message code="sms.th.UnconfirmedReminders" /></div></button>'
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
        var data = {
            queryType: 1,
            page: 1,
            pageSize: 10,
            useFlag: true,
        };
        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
            var active = $.getQueryString("active")||'';
            if(active != ''){
                $('.M-box3 a[data-page='+ active +']').trigger('click');
            }
        });

        function initPagination(totalData, pageSize) {
            $('.M-box3').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                current: data.page,
                homePage: '<fmt:message code="global.page.first" />',
                endPage: '<fmt:message code="global.page.last" />',
                prevContent: '<fmt:message code="global.page.pre" />',
                nextContent: '<fmt:message code="global.page.next" />',
                jumpBtn: '<fmt:message code="global.page.jump" />',
                callback: function (index) {
                    data.page = index.getCurrent();

                    initPageList(function (pageCount) {
                        initPagination(pageCount, data.pageSize);
                    });
                }
            });
        }
        function initPageList(cb) {
            $.ajax({
                type: "get",
                url: "/sms/selectByQueryType",
                dataType: 'JSON',
                data: data
                ,
                success: function (data) {
                    var str = "";
                    if (data.totleNum == 0) {
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        $(".imgDiv").css("display", "block");
                        $(".contentTable").css("display", "none");
                        $(".M-box3").css("display", "none");
                        return

                    }
                    $(".imgDiv").css("display", "none");
                    $(".contentTable").css("display", "block");
                    $(".M-box3").css("display", "block");
                    if (data.obj) {
                        for (var i = 0; i < data.obj.length; i++) {

                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');

                            if (data.obj[i].fromName == undefined) {
                                data.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                            }

                            <%--str += "<tr>" +--%>
                            <%--"<td style='width:2%;min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].fromName + "</td>" +--%>
                            <%--"<td style='width:15%' title='"+ data.obj[i].smsTypeName +"'>" + data.obj[i].smsTypeName + "</td>" +--%>
                            <%--"<td style='width:53%' class='btnTd' title='"+data.obj[i].content+"'><div style='width: 300px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].sendTimeStr + "</td>" +--%>
                            <%--"<td><a class='detail_a' remindUrl='"+data.obj[i].remindUrl+"'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";--%>
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }
                            str += "<tr>" +
                                "<td style='min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td style=''>" + data.obj[i].fromName + "</td>" +
                                "<td style='' title='" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "'>" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "</td>" +
                                "<td style='' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' class='btnTd' title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td><a class='detail_a' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";

                        }
                        // if("div:contains('【紧急】' || '【特急】') "){
                        //     alert(1111111);
                        //     $(".txtContent").css("color","red");
                        // }

                        var last_str = "<tr class='last_str'>" +
                            "<td><input id='checkedAll' style='float:left;'  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;\n" +
                            "    margin-left: 6px;margin-top: 3px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                            "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="global.lang.delete" /></a><a class='remind_a bottom_a_style' ><fmt:message code="sms.th.MarkRead" /></a><a class='remind_all bottom_a_style' ><fmt:message code="sms.th.AllMarkedRead" /></a></td>" +
                            "</tr>";

                        if (data.totleNum != undefined) {
                            $('.countSpan').html(" " + data.totleNum + " ");
                        }

                        $(".contentTableBody").html(str + last_str);




                        if (cb) {
                            cb(data.totleNum);
                        }

                        initPagination(data.totleNum, 10);
                    }
                }
            })
        }
        <%--        //点击全选--%>
        <%--        $('.contentTableBody').on('click', '#checkedAll', function () {--%>
        <%--            /*alert('111');*/--%>
        <%--            var state = $(this).prop("checked");--%>
        <%--            if (state == true) {--%>
        <%--                $(this).prop("checked", true);--%>
        <%--                $(".checkChild").prop("checked", true);--%>
        <%--            } else {--%>
        <%--                $(this).prop("checked", false);--%>
        <%--                $(".checkChild").prop("checked", false);--%>
        <%--            }--%>
        <%--        });--%>

        <%--//        点击内容查看详情--%>
        <%--        $('.contentTableBody').on('click','.btnTd',function () {--%>
        <%--            var remindUrl = $(this).attr("remindUrl");--%>
        <%--            var bodyId = $(this).attr("bodyId");--%>
        <%--            var length = $(this).parents('.contentTableBody').find('tr').length;--%>
        <%--            if(remindUrl.indexOf('/imfriends/geImfriendsByIdPage') > -1||remindUrl.indexOf('$geImfriendsTz') > -1){--%>
        <%--                if(remindUrl.indexOf('$geImfriendsTz') > -1){--%>
        <%--                    $.ajax({--%>
        <%--                        type: "post",--%>
        <%--                        url: "/sms/setRead",--%>
        <%--                        dataType: 'JSON',--%>
        <%--                        data: {"bodyId":bodyId},--%>
        <%--                        success: function (res) {--%>
        <%--                        }--%>
        <%--                    });--%>
        <%--                    if($('.M-box3 .active').text() == '1'){--%>
        <%--                        var active = '';--%>
        <%--                    }else{--%>
        <%--                        if(length > 2){--%>
        <%--                            var active = $('.M-box3 .active').text();--%>
        <%--                        }else if(length == 2){--%>
        <%--                            var active = parseInt($('.M-box3 .active').text()) - 1;--%>
        <%--                        }--%>
        <%--                    }--%>
        <%--                    window.location.href = '/sms/unconfirmedSmsPage?active='+active;--%>
        <%--                }else{--%>
        <%--                    window.open('/'+remindUrl,'',"height=300, width=600, top=0, left=400,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no");--%>

        <%--                }--%>
        <%--            }else{--%>
        <%--                $.ajax({--%>
        <%--                    type: "post",--%>
        <%--                    url: "/sms/setRead",--%>
        <%--                    dataType: 'JSON',--%>
        <%--                    data: {"bodyId":bodyId},--%>
        <%--                    success: function (res) {--%>
        <%--                    }--%>
        <%--                });--%>
        <%--                if((remindUrl.indexOf('/work/workformPreView') > -1||remindUrl.indexOf('/work/workform') > -1)&&remindUrl.indexOf('&tableName=document') > -1){--%>
        <%--                    remindUrl += '&ie_open=yes';--%>
        <%--                }--%>
        <%--                if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){--%>
        <%--                    window.open(remindUrl);--%>
        <%--                }else{--%>
        <%--                    window.open('/'+remindUrl);--%>
        <%--                }--%>
        <%--                if($('.M-box3 .active').text() == '1'){--%>
        <%--                    var active = '';--%>
        <%--                }else{--%>
        <%--                    if(length > 2){--%>
        <%--                        var active = $('.M-box3 .active').text();--%>
        <%--                    }else if(length == 2){--%>
        <%--                        var active = parseInt($('.M-box3 .active').text()) - 1;--%>
        <%--                    }--%>
        <%--                }--%>
        <%--                window.location.href = '/sms/unconfirmedSmsPage?active='+active;--%>
        <%--            }--%>
        <%--        })--%>
        <%--        // 删除--%>
        <%--        $('.contentTableBody').on('click', '.delete_a', function () {--%>
        <%--            var bodyIds = '';--%>
        <%--            if($('.checkchild:checked').size()==0){--%>
        <%--                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0});--%>
        <%--                return;--%>
        <%--            }--%>
        <%--            $('.checkchild:checked').each(function () {--%>
        <%--                bodyIds+=$(this).attr("bodyId")+',';--%>
        <%--            });--%>
        <%--            smsType1=''--%>
        <%--            smsType1=$('.font').val()--%>

        <%--            $.ajax({--%>
        <%--                type: "post",--%>
        <%--                url: "/sms/delete",--%>
        <%--                dataType: 'JSON',--%>
        <%--                data: {"bodyIds":bodyIds,--%>
        <%--                    "deleteFlag":"1",--%>
        <%--                },--%>
        <%--                success: function (res) {--%>
        <%--                    if(res.flag){--%>
        <%--                        parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1});--%>
        <%--                        initPageList(function (pageCount) {--%>
        <%--                            initPagination(pageCount, data.pageSize);--%>
        <%--                        });--%>
        <%--                    }else{--%>
        <%--                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2});--%>
        <%--                    }--%>
        <%--                }--%>
        <%--            })--%>
        <%--        });--%>

        <%--        // 标记为已读--%>
        <%--        $('.contentTableBody').on('click', '.remind_a', function () {--%>
        <%--            var bodyIds = '';--%>
        <%--            if($('.checkchild:checked').size()==0){--%>
        <%--                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0});--%>
        <%--                return;--%>
        <%--            }--%>
        <%--            $('.checkchild:checked').each(function () {--%>
        <%--                bodyIds+=$(this).attr("bodyId")+',';--%>
        <%--            });--%>
        <%--            smsType1=''--%>
        <%--            smsType1=$('.font').val()--%>

        <%--            $.ajax({--%>
        <%--                type: "post",--%>
        <%--                url: "/sms/updateRemind",--%>
        <%--                dataType: 'JSON',--%>
        <%--                data: {"bodyIds":bodyIds,"remindFlag":"0",},--%>
        <%--                success: function (res) {--%>
        <%--                    if(res.flag){--%>
        <%--                        parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />",{icon:1});--%>
        <%--                        initPageList(function (pageCount) {--%>
        <%--                            initPagination(pageCount, data.pageSize);--%>
        <%--                        });--%>
        <%--                    }else{--%>
        <%--                        parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />",{icon:2});--%>
        <%--                    }--%>
        <%--                }--%>
        <%--            })--%>
        <%--        });--%>

        <%--        // 全部标记为已读--%>
        <%--        $('.contentTableBody').on('click', '.remind_all', function () {--%>
        <%--            var set=$('.font').val()--%>
        <%--            $.ajax({--%>
        <%--                type: "post",--%>
        <%--                url: "/sms/updateRemind",--%>
        <%--                dataType: 'JSON',--%>
        <%--                data: {"remindFlag":"0",--%>
        <%--                    smsType:set},--%>
        <%--                success: function (res) {--%>
        <%--                    if(res.flag){--%>
        <%--                        $.layerMsg({content: '标记成功！', icon: 1}, function () {--%>
        <%--                            location.reload();--%>
        <%--                        })--%>
        <%--                    }else{--%>
        <%--                        parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />",{icon:2});--%>
        <%--                    }--%>
        <%--                }--%>
        <%--            })--%>
        <%--        });--%>

        <%--        // 详情点击事件--%>
        <%--        $('.contentTableBody').on('click', '.detail_a', function () {--%>
        <%--            var remindUrl = $(this).attr("remindUrl");--%>
        <%--            var bodyId = $(this).attr("bodyId");--%>
        <%--            var length = $(this).parents('.contentTableBody').find('tr').length;--%>
        <%--            if(remindUrl.indexOf('/imfriends/geImfriendsByIdPage') > -1||remindUrl.indexOf('$geImfriendsTz') > -1){--%>
        <%--                if(remindUrl.indexOf('$geImfriendsTz') > -1){--%>
        <%--                    $.ajax({--%>
        <%--                        type: "post",--%>
        <%--                        url: "/sms/setRead",--%>
        <%--                        dataType: 'JSON',--%>
        <%--                        data: {"bodyId":bodyId},--%>
        <%--                        success: function (res) {--%>
        <%--                        }--%>
        <%--                    });--%>
        <%--                    if($('.M-box3 .active').text() == '1'){--%>
        <%--                        var active = '';--%>
        <%--                    }else{--%>
        <%--                        if(length > 2){--%>
        <%--                            var active = $('.M-box3 .active').text();--%>
        <%--                        }else if(length == 2){--%>
        <%--                            var active = parseInt($('.M-box3 .active').text()) - 1;--%>
        <%--                        }--%>
        <%--                    }--%>
        <%--                    window.location.href = '/sms/unconfirmedSmsPage?active='+active;--%>
        <%--                }else{--%>
        <%--                    window.open('/'+remindUrl,'',"height=300, width=600, top=0, left=400,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no");--%>
        <%--                }--%>
        <%--            }else{--%>
        <%--                $.ajax({--%>
        <%--                    type: "post",--%>
        <%--                    url: "/sms/setRead",--%>
        <%--                    dataType: 'JSON',--%>
        <%--                    data: {"bodyId":bodyId},--%>
        <%--                    success: function (res) {--%>
        <%--                    }--%>
        <%--                });--%>
        <%--                &lt;%&ndash;window.open('/'+remindUrl);&ndash;%&gt;--%>
        <%--                if((remindUrl.indexOf('/work/workformPreView') > -1||remindUrl.indexOf('/work/workform') > -1)&&remindUrl.indexOf('&tableName=document') > -1){--%>
        <%--                    remindUrl += '&ie_open=yes';--%>
        <%--                }--%>
        <%--                if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){--%>
        <%--                    window.open(remindUrl);--%>
        <%--                }else{--%>
        <%--                    window.open('/'+remindUrl);--%>
        <%--                }--%>
        <%--                if($('.M-box3 .active').text() == '1'){--%>
        <%--                    var active = '';--%>
        <%--                }else{--%>
        <%--                    if(length > 2){--%>
        <%--                        var active = $('.M-box3 .active').text();--%>
        <%--                    }else if(length == 2){--%>
        <%--                        var active = parseInt($('.M-box3 .active').text()) - 1;--%>
        <%--                    }--%>
        <%--                }--%>
        <%--                window.location.href = '/sms/unconfirmedSmsPage?active='+active;--%>
        <%--            }--%>
        <%--        });--%>
    }



    function tab(data,i){
        $("button").removeAttr('class','font')
        smsType=data;
        $("button").eq(i+1).attr('class','font')
        var data = {
            queryType: 1,
            page: 1,
            pageSize: 10,
            useFlag: true,
            smsType:smsType
        };
        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
            var active = $.getQueryString("active")||'';
            if(active != ''){
                $('.M-box3 a[data-page='+ active +']').trigger('click');
            }
        });

        function initPagination(totalData, pageSize) {
            $('.M-box3').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                current: data.page,
                homePage: '<fmt:message code="global.page.first" />',
                endPage: '<fmt:message code="global.page.last" />',
                prevContent: '<fmt:message code="global.page.pre" />',
                nextContent: '<fmt:message code="global.page.next" />',
                jumpBtn: '<fmt:message code="global.page.jump" />',
                callback: function (index) {
                    data.page = index.getCurrent();

                    initPageList(function (pageCount) {
                        initPagination(pageCount, data.pageSize);
                    });
                }
            });
        }
        function initPageList(cb) {

            $.ajax({
                type: "get",
                url: "/sms/selectByQueryType",
                dataType: 'JSON',
                data: data,
                success: function (data) {
                    var str = "";
                    if (data.totleNum == 0) {
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        $(".imgDiv").css("display", "block");
                        $(".contentTable").css("display", "none");
                        $(".M-box3").css("display", "none");
                        return

                    }
                    $(".imgDiv").css("display", "none");
                    $(".contentTable").css("display", "block");
                    $(".M-box3").css("display", "block");
                    if (data.obj) {
                        for (var i = 0; i < data.obj.length; i++) {

                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');

                            if (data.obj[i].fromName == undefined) {
                                data.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                            }

                            <%--str += "<tr>" +--%>
                            <%--"<td style='width:2%;min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].fromName + "</td>" +--%>
                            <%--"<td style='width:15%' title='"+ data.obj[i].smsTypeName +"'>" + data.obj[i].smsTypeName + "</td>" +--%>
                            <%--"<td style='width:53%' class='btnTd' title='"+data.obj[i].content+"'><div style='width: 300px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].sendTimeStr + "</td>" +--%>
                            <%--"<td><a class='detail_a' remindUrl='"+data.obj[i].remindUrl+"'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";--%>
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }
                            str += "<tr>" +
                                "<td style='min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td style=''>" + data.obj[i].fromName + "</td>" +
                                "<td style='' title='" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "'>" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "</td>" +
                                "<td style='' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' class='btnTd' title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td><a class='detail_a' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";

                        }
                        // if("div:contains('【紧急】' || '【特急】') "){
                        //     alert(1111111);
                        //     $(".txtContent").css("color","red");
                        // }

                        var last_str = "<tr class='last_str'>" +
                            "<td><input id='checkedAll' style='float:left;'  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;margin-top: 3px;\n" +
                            "    margin-left: 6px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                            "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="global.lang.delete" /></a><a class='remind_a bottom_a_style' ><fmt:message code="sms.th.MarkRead" /></a><a class='remind_all bottom_a_style' ><fmt:message code="sms.th.AllMarkedRead" /></a></td>" +
                            "</tr>";

                        if (data.totleNum != undefined) {
                            $('.countSpan').html(" " + data.totleNum + " ");
                        }

                        $(".contentTableBody").html(str + last_str);




                        if (cb) {
                            cb(data.totleNum);
                        }

                        initPagination(data.totleNum, 10);
                    }
                }
            })
        }
    }


    function openRold(){
        location.reload();
    }
    $(function () {
        var data = {
            queryType: 1,
            page: 1,
            pageSize: 10,
            useFlag: true,
        };
        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
            var active = $.getQueryString("active")||'';
            if(active != ''){
                $('.M-box3 a[data-page='+ active +']').trigger('click');
            }
        });

        function initPagination(totalData, pageSize) {
            $('.M-box3').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                current: data.page,
                homePage: '<fmt:message code="global.page.first" />',
                endPage: '<fmt:message code="global.page.last" />',
                prevContent: '<fmt:message code="global.page.pre" />',
                nextContent: '<fmt:message code="global.page.next" />',
                jumpBtn: '<fmt:message code="global.page.jump" />',
                callback: function (index) {
                    data.page = index.getCurrent();

                    initPageList(function (pageCount) {
                        initPagination(pageCount, data.pageSize);
                    });
                }
            });
        }
        function initPageList(cb) {
            $.ajax({
                type: "get",
                url: "/sms/selectByQueryType?smsType="+smsType1,
                dataType: 'JSON',
                data: data
                ,
                success: function (data) {
                    var str = "";
                    if (data.totleNum == 0) {
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        $(".imgDiv").css("display", "block");
                        $(".contentTable").css("display", "none");
                        $(".M-box3").css("display", "none");
                        return

                    }
                    $(".imgDiv").css("display", "none");
                    $(".contentTable").css("display", "block");
                    $(".M-box3").css("display", "block");
                    if (data.obj) {
                        for (var i = 0; i < data.obj.length; i++) {

                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');

                            if (data.obj[i].fromName == undefined) {
                                data.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                            }

                            <%--str += "<tr>" +--%>
                            <%--"<td style='width:2%;min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].fromName + "</td>" +--%>
                            <%--"<td style='width:15%' title='"+ data.obj[i].smsTypeName +"'>" + data.obj[i].smsTypeName + "</td>" +--%>
                            <%--"<td style='width:53%' class='btnTd' title='"+data.obj[i].content+"'><div style='width: 300px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +--%>
                            <%--"<td style='width:15%'>" + data.obj[i].sendTimeStr + "</td>" +--%>
                            <%--"<td><a class='detail_a' remindUrl='"+data.obj[i].remindUrl+"'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";--%>
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }
                            str += "<tr>" +
                                "<td style='min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td style=''>" + data.obj[i].fromName + "</td>" +
                                "<td style='' title='" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "'>" + function () {
                                    if (data.obj[i].smsTypeName == undefined) {
                                        return ''
                                    } else {
                                        return data.obj[i].smsTypeName
                                    }
                                }() + "</td>" +
                                "<td style='' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' class='btnTd' title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td><a class='detail_a' remindUrl='" + encodeURI(data.obj[i].remindUrl) + "' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="roleAuthorization.th.ViewDetails" /></a></td></tr>";

                        }
                        // if("div:contains('【紧急】' || '【特急】') "){
                        //     alert(1111111);
                        //     $(".txtContent").css("color","red");
                        // }

                        var last_str = "<tr class='last_str'>" +
                            "<td><input id='checkedAll' style='float:left;'  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;margin-top: 3px;\n" +
                            "    margin-left: 6px;'><fmt:message code="notice.th.allchose" /></label></td>" +
                            "<td colspan='5' style='text-align: left' class='btnStyle delete_check'><a class='delete_a bottom_a_style' ><fmt:message code="global.lang.delete" /></a><a class='remind_a bottom_a_style' ><fmt:message code="sms.th.MarkRead" /></a><a class='remind_all bottom_a_style' ><fmt:message code="sms.th.AllMarkedRead" /></a></td>" +
                            "</tr>";

                        if (data.totleNum != undefined) {
                            $('.countSpan').html(" " + data.totleNum + " ");
                        }

                        $(".contentTableBody").html(str + last_str);




                        if (cb) {
                            cb(data.totleNum);
                        }

                        initPagination(data.totleNum, 10);
                    }
                }
            })
        }
        //点击全选
        $('.contentTableBody').on('click', '#checkedAll', function () {
            /*alert('111');*/
            var state = $(this).prop("checked");
            if (state == true) {
                $(this).prop("checked", true);
                $(".checkChild").prop("checked", true);
            } else {
                $(this).prop("checked", false);
                $(".checkChild").prop("checked", false);
            }
        });

//        点击内容查看详情
        $('.contentTableBody').on('click','.btnTd',function () {
            var remindUrl = $(this).attr("remindUrl");
            var bodyId = $(this).attr("bodyId");
            var length = $(this).parents('.contentTableBody').find('tr').length;
            if(remindUrl.indexOf('/imfriends/geImfriendsByIdPage') > -1||remindUrl.indexOf('$geImfriendsTz') > -1){
                if(remindUrl.indexOf('$geImfriendsTz') > -1){
                    $.ajax({
                        type: "post",
                        url: "/sms/setRead",
                        dataType: 'JSON',
                        data: {"bodyId":bodyId},
                        success: function (res) {
                        }
                    });
                    if($('.M-box3 .active').text() == '1'){
                        var active = '';
                    }else{
                        if(length > 2){
                            var active = $('.M-box3 .active').text();
                        }else if(length == 2){
                            var active = parseInt($('.M-box3 .active').text()) - 1;
                        }
                    }
                    window.location.href = '/sms/unconfirmedSmsPage?active='+active+'&smsType='+smsType1;
                }else{
                    window.open('/'+remindUrl,'',"height=300, width=600, top=0, left=400,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no");

                }
            }else{
                $.ajax({
                    type: "post",
                    url: "/sms/setRead",
                    dataType: 'JSON',
                    data: {"bodyId":bodyId},
                    success: function (res) {
                    }
                });
                if((remindUrl.indexOf('/work/workformPreView') > -1||remindUrl.indexOf('/work/workform') > -1)&&remindUrl.indexOf('&tableName=document') > -1){
                    remindUrl += '&ie_open=yes';
                }
                if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){
                    window.open(remindUrl);
                }else{
                    window.open('/'+remindUrl);
                }
                if($('.M-box3 .active').text() == '1'){
                    var active = '';
                }else{
                    if(length > 2){
                        var active = $('.M-box3 .active').text();
                    }else if(length == 2){
                        var active = parseInt($('.M-box3 .active').text()) - 1;
                    }
                }
                window.location.href = '/sms/unconfirmedSmsPage?active='+active+'&smsType='+smsType1;
            }
        })
        // 删除
        $('.contentTableBody').on('click', '.delete_a', function () {
            if($('.checkchild:checked').size()==0){
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0,time:1000});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteTheData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
            var bodyIds = '';
            var smsId = '';
                $('.checkchild:checked').each(function () {
                    smsId+=$(this).attr("smsId")+',';
                });
            $('.checkchild:checked').each(function () {
                bodyIds+=$(this).attr("bodyId")+',';
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
                data: {"smsIds":smsId,
                    "deleteFlag":"1",
                },
                success: function (res) {
                    if(res.flag){
                        var c=$('.font').val()
                        $.ajax({
                            url: '/sms/selectByQueryType',
                            dataType: 'json',
                            type: 'get',
                            data: {
                                smsType: c,
                                page: 1,
                                pageSize: 10,
                                useFlag: true,
                                queryType: 1,
                            },
                            success: function (res) {
                                var totleNum = res.totleNum
                                $('.countSpan').html(" " + totleNum + " ");
                            }
                        })
                        parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1,time:1000});
                        initPageList(function (pageCount) {
                            initPagination(pageCount, data.pageSize);
                        });
                    }else{
                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />",{icon:2,time:1000});
                    }
                }
            })
        });
        });
        // 标记为已读
        $('.contentTableBody').on('click', '.remind_a', function () {
            if($('.checkchild:checked').size()==0){
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />",{icon:0,time:1000});
                return;
            }
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureToMarkAllAsRead" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
            var bodyIds = '';

            $('.checkchild:checked').each(function () {
                bodyIds+=$(this).attr("bodyId")+',';
            });
                var smsId = '';
                $('.checkchild:checked').each(function () {
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
                data: {"smsIds":smsId,"remindFlag":"0",queryType:1,smsType:"all"},
                success: function (res) {
                    if(res.flag){
                        var c=$('.font').val()
                        $.ajax({
                            url: '/sms/selectByQueryType',
                            dataType: 'json',
                            type: 'get',
                            data: {
                                smsType: c,
                                page: 1,
                                pageSize: 10,
                                useFlag: true,
                                queryType: 1,
                            },
                            success: function (res) {
                                var totleNum = res.totleNum
                                $('.countSpan').html(" " + totleNum + " ");
                            }
                        })
                        parent.layer.msg("<fmt:message code="sms.th.MarkSuccess" />",{icon:1,time:1000});
                        initPageList(function (pageCount) {
                            initPagination(pageCount, data.pageSize);
                        });
                    }else{
                        parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />",{icon:2,time:1000});
                    }
                }
            })
            });
        });

        // 全部标记为已读
        $('.contentTableBody').on('click', '.remind_all', function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureToMarkAllAsRead" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
            var set=$('.font').val()
            $.ajax({
                type: "post",
                url: "/sms/updateRemind",
                dataType: 'JSON',
                data: {"remindFlag":"0",
                    smsType:'all',
                    queryType:1},
                success: function (res) {
                    if(res.flag){
                        var c=$('.font').val()
                        $.ajax({
                            url: '/sms/selectByQueryType',
                            dataType: 'json',
                            type: 'get',
                            data: {
                                smsType: c,
                                page: 1,
                                pageSize: 10,
                                useFlag: true,
                                queryType: 1,
                            },
                            success: function (res) {
                                var totleNum = res.totleNum
                                $('.countSpan').html(" " + totleNum + " ");
                            }
                        })
                        $.layerMsg({content: '<fmt:message code="sms.th.MarkSuccess" />！', icon: 1,time:1000}, function () {
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            });
                        })
                        location.reload();
                    }else{
                        parent.layer.msg("<fmt:message code="sms.th.FlagFailure" />",{icon:2,time:1000});
                    }
                }
            })
        });
        });
        // 详情点击事件
        $('.contentTableBody').on('click', '.detail_a', function () {
            var remindUrl = $(this).attr("remindUrl");
            var bodyId = $(this).attr("bodyId");
            var length = $(this).parents('.contentTableBody').find('tr').length;
            if(remindUrl.indexOf('/imfriends/geImfriendsByIdPage') > -1||remindUrl.indexOf('$geImfriendsTz') > -1){
                if(remindUrl.indexOf('$geImfriendsTz') > -1){
                    $.ajax({
                        type: "post",
                        url: "/sms/setRead",
                        dataType: 'JSON',
                        data: {"bodyId":bodyId},
                        success: function (res) {
                        }
                    });
                    if($('.M-box3 .active').text() == '1'){
                        var active = '';
                    }else{
                        if(length > 2){
                            var active = $('.M-box3 .active').text();
                        }else if(length == 2){
                            var active = parseInt($('.M-box3 .active').text()) - 1;
                        }
                    }
                    window.location.href = '/sms/unconfirmedSmsPage?active='+active+'&smsType='+smsType1;
                }else{
                    window.open('/'+remindUrl,'',"height=300, width=600, top=0, left=400,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no");
                }
            }else{
                $.ajax({
                    type: "post",
                    url: "/sms/setRead",
                    dataType: 'JSON',
                    data: {"bodyId":bodyId},
                    success: function (res) {
                    }
                });
                <%--window.open('/'+remindUrl);--%>
                if((remindUrl.indexOf('/work/workformPreView') > -1||remindUrl.indexOf('/work/workform') > -1)&&remindUrl.indexOf('&tableName=document') > -1){
                    remindUrl += '&ie_open=yes';
                }
                if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){
                    window.open(remindUrl);
                }else{
                    window.open('/'+remindUrl);
                }
                if($('.M-box3 .active').text() == '1'){
                    var active = '';
                }else{
                    if(length > 2){
                        var active = $('.M-box3 .active').text();
                    }else if(length == 2){
                        var active = parseInt($('.M-box3 .active').text()) - 1;
                    }
                }
                window.location.href = '/sms/unconfirmedSmsPage?active='+active+'&smsType='+smsType1;
            }
        });
    });

    function kaifa() {
        parent.layer.msg("<fmt:message code="sup.th.UnderDevelopment" />", {icon: 1});
    }

</script>
</body>
</html>
