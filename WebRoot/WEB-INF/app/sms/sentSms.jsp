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
    <title><fmt:message code="sms.th.SendReminders"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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

        .reSend_a {
            color: dodgerblue;
            cursor: pointer;
        }

        .delete_a {
            color: #404060;
            cursor: pointer;
            display: inline-block;
            background: url(../../img/sms/icon_affairremind_delete_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
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

        .contentTable thead tr {
            height: 50px;
            font-size: 13pt;
        }

        label {
            cursor: pointer;
        }

        .contentTableBody tr {
            background: #F6F7F9;
        }

        .contentTableBody tr td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .contentTableBody tr:nth-child(even) {
            background: #ffffff;
        }

        .title_span {
            font-size: 20px;
        }

        .bottom_table {
            margin-top: -1px;
        }

        .bottom_table .first_td {
            background-color: #f2f2f2;
            border-right: 1px #dddddd solid;
            width: 80px;
        }

        .bottom_table a {
            cursor: pointer;
            margin-left: 10px;
            color: #404060;
            display: inline-block;
            padding-left: 22px;
            line-height: 25px;
            background: url(../../img/sms/icon_affairremind_delete_12.png) no-repeat;
            background-position-y: 5px;
            padding-right: 6px;
        }
        .title_span{
            margin-left: 5px;
        }
        .contentTableBody td{
            font-size: 11pt;
        }
        .imgDiv{
            text-align: center;
            display: none;
            margin-top: 60px;
        }
        .contentTable tr th{
            color: #2F5C8F;
            text-align: left;
            padding-left: 10px;
        }
        .contentTable tr td{
            text-align: left;
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
        .font{
            color: white;
            background-color:  #2B7FE0;
        }
        .fonts{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>

<table class="headTable">
    <tr>
        <td><img src="/img/commonTheme/${sessionScope.InterfaceModel}/title_send_sms.png" alt=""><span class="title_span"><fmt:message code="sms.th.SendReminders"/></span>&nbsp;&nbsp;(<fmt:message
                code="main.th.general"/><span class="countSpan">0</span><fmt:message code="main.th.BarReminder"/>)
        </td>
        <td></td>
        <td>
            <%--<div class="M-box3">--%>

            <%--</div>--%>
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
<table class="contentTable" style="table-layout: fixed;margin-top: 10px">
    <thead>
    <tr>
        <th style="width: 5%;min-width:50px;text-align: left"><fmt:message code="global.lang.select"/></th>
        <th style="width: 11%;"><fmt:message code="sms.th.Addressee"/></th>
        <th style="width: 12%;"><fmt:message code="notice.th.type"/></th>
        <th style="width: 40%;"><fmt:message code="notice.th.content"/></th>
        <th style="width: 20%;"><fmt:message code="sup.th.SendingTime"/></th>
        <th style="width: 6%;"><fmt:message code="notice.th.state"/></th>
        <th style="width: 6%;"><fmt:message code="notice.th.operation"/></th>
    </tr>
    </thead>
    <tbody class="contentTableBody">

    </tbody>
</table>

<table class="bottom_table" style="display: block;border: #ccc 1px solid;box-sizing: border-box;">
    <tr style="border: none;">
        <td class="first_td"><fmt:message code="news.th.Quickoperation"/>：</td>
        <td style="border-right: none;">
            <a class="delete_allRead"><fmt:message code="sms.th.deleteTheReadReminderForTheRecipient" /></a>
            <a class="delete_toUserDeleted"><fmt:message code="sms.th.DeleteRecipient"/></a>
        <td></td>
    </tr>
</table>
<div class="M-box3" >

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
            queryType:3
        },
        success: function (res) {
            str1 += '<button id="all"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab1()" ><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px"  src="/img/commonTheme/theme6/title_send_sms.png"></img></div><div class="fonts" style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px"><fmt:message code="sms.th.SendReminders" /></div></button>'
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

    function tab(data,i) {
        $("button").removeAttr('class', 'font')
        smsType = data;
        $("button").eq(i + 1).attr('class', 'font')
        var data = {
            smsType:smsType,
            queryType: 3,
            page: 1,
            pageSize: 10,
            useFlag: true
        };

        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
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
                        $(".imgDiv").css("display","block");
                        $(".contentTable").css("display","none");
                        $(".bottom_table").css("display","none");
                        $(".M-box3").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $(".contentTable").css("display","block");
                    $(".bottom_table").css("display","block");
                    $(".M-box3").css("display","block");
                    if(data.obj){
                        for (var i = 0; i < data.obj.length; i++) {
                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                            if (data.obj[i].toName == undefined) {
                                data.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                            }
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }

                            str += "<tr><td  style='min-width:50px;text-align:left' ><input  class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td>" + data.obj[i].toName + "</td>" +
                                "<td style=''>" + data.obj[i].smsTypeName + "</td>" +
                                "<td class='btnTd' remindUrl='"+encodeURI(data.obj[i].remindUrl)+"' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + " title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].deleteFlag == 0) {
                                        if (data.obj[i].remindFlag == 0) {
                                            return "<fmt:message code="email.th.yiread" />";
                                        } else {
                                            return "<fmt:message code="email.th.unRead" />";
                                        }
                                    } else if (data.obj[i].deleteFlag == 1) {
                                        return "<fmt:message code="email.th.del" />";
                                    }
                                }() + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].remindFlag == 0) {
                                        return "<a class='reSend_a' onclick='reSend()' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="email.th.chongxin" /></a>";
                                    } else {
                                        return "";
                                    }
                                }() + "</td></tr>";
                        }
                    }


                    var last_str = "<tr class='last_str'><td><input id='checkedAll'  type='checkbox' conid='29' name='check' value=''><label style='margin-top: 3px;\n" +
                        "    margin-left: 6px;' for='checkedAll'><fmt:message code="notice.th.allchose" /></label></td><td style='text-align: left;' colspan='2' class='btnStyle delete_check'><a class='delete_a'><fmt:message code="global.lang.delete" /></a></td><td class=''></td><td></td><td></td><td></td></tr>";

                    if (data.totleNum != undefined) {
                        $('.countSpan').html(" " + data.totleNum + " ");
                    }

                    $(".contentTableBody").html(str + last_str);


                    if (cb) {
                        cb(data.totleNum);
                    }

                    initPagination(data.totleNum, 10);
                }
            })
        }

    }



    function tab1(){
        $("button").removeAttr('class','font')
        $(".tab >#all").attr('class','font')
        var data = {
            smsType:'',
            queryType: 3,
            page: 1,
            pageSize: 10,
            useFlag: true
        };

        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
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
                        $(".imgDiv").css("display","block");
                        $(".contentTable").css("display","none");
                        $(".bottom_table").css("display","none");
                        $(".M-box3").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $(".contentTable").css("display","block");
                    $(".bottom_table").css("display","block");
                    $(".M-box3").css("display","block");
                    if(data.obj){
                        for (var i = 0; i < data.obj.length; i++) {
                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                            if (data.obj[i].toName == undefined) {
                                data.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                            }
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }

                            str += "<tr><td  style='min-width:50px;text-align:left' ><input  class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td>" + data.obj[i].toName + "</td>" +
                                "<td style=''>" + data.obj[i].smsTypeName + "</td>" +
                                "<td class='btnTd' remindUrl='"+encodeURI(data.obj[i].remindUrl)+"' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + " title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].deleteFlag == 0) {
                                        if (data.obj[i].remindFlag == 0) {
                                            return "<fmt:message code="email.th.yiread" />";
                                        } else {
                                            return "<fmt:message code="email.th.unRead" />";
                                        }
                                    } else if (data.obj[i].deleteFlag == 1) {
                                        return "<fmt:message code="email.th.del" />";
                                    }
                                }() + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].remindFlag == 0) {
                                        return "<a class='reSend_a' onclick='reSend()' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="email.th.chongxin" /></a>";
                                    } else {
                                        return "";
                                    }
                                }() + "</td></tr>";
                        }
                    }


                    var last_str = "<tr class='last_str'><td><input id='checkedAll'  type='checkbox' conid='29' name='check' value=''><label style='margin-top: 3px;\n" +
                        "    margin-left: 6px;' for='checkedAll'><fmt:message code="notice.th.allchose" /></label></td><td style='text-align: left;' colspan='2' class='btnStyle delete_check'><a class='delete_a'><fmt:message code="global.lang.delete" /></a></td><td class=''></td><td></td><td></td><td></td></tr>";

                    if (data.totleNum != undefined) {
                        $('.countSpan').html(" " + data.totleNum + " ");
                    }

                    $(".contentTableBody").html(str + last_str);


                    if (cb) {
                        cb(data.totleNum);
                    }

                    initPagination(data.totleNum, 10);
                }
            })
        }

    }

    $(function () {

        var data = {
            queryType: 3,
            page: 1,
            pageSize: 10,
            useFlag: true
        };

        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
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
                data: data,
                success: function (data) {

                    var str = "";
                    if (data.totleNum == 0) {
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        $(".imgDiv").css("display","block");
                        $(".contentTable").css("display","none");
                        $(".bottom_table").css("display","none");
                        $(".M-box3").css("display","none");
                        return
                    }
                    $(".imgDiv").css("display","none");
                    $(".contentTable").css("display","block");
                    $(".bottom_table").css("display","block");
                    $(".M-box3").css("display","block");
                    if(data.obj){
                        for (var i = 0; i < data.obj.length; i++) {
                            // 格式化时间
                            var sendTime = new Date((data.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                            if (data.obj[i].toName == undefined) {
                                data.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                            }
                            var special = data.obj[i].content;
                            var color='#2B7FE0'
                            if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                color='red'
                                // $(".txtContent").css("color","red");
                            }

                            str += "<tr><td  style='min-width:50px;text-align:left' ><input  class='checkChild'  type='checkbox' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' name='check' value=''></td>" +
                                "<td>" + data.obj[i].toName + "</td>" +
                                "<td style=''>" + data.obj[i].smsTypeName + "</td>" +
                                "<td class='btnTd' remindUrl='"+encodeURI(data.obj[i].remindUrl)+"' smsId='" + data.obj[i].smsId + "'  bodyId='" + data.obj[i].bodyId + " title='" + data.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + data.obj[i].content + "</div></td>" +
                                "<td style=''>" + data.obj[i].sendTimeStr + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].deleteFlag == 0) {
                                        if (data.obj[i].remindFlag == 0) {
                                            return "<fmt:message code="email.th.yiread" />";
                                        } else {
                                            return "<fmt:message code="email.th.unRead" />";
                                        }
                                    } else if (data.obj[i].deleteFlag == 1) {
                                        return "<fmt:message code="email.th.del" />";
                                    }
                                }() + "</td>" +
                                "<td>" + function () {
                                    if (data.obj[i].remindFlag == 0) {
                                        return "<a class='reSend_a' onclick='reSend()' smsId='" + data.obj[i].smsId + "' bodyId='" + data.obj[i].bodyId + "' ><fmt:message code="email.th.chongxin" /></a>";
                                    } else {
                                        return "";
                                    }
                                }() + "</td></tr>";
                        }
                    }


                    var last_str = "<tr class='last_str'><td><input id='checkedAll'  type='checkbox' conid='29' name='check' value=''><label style='margin-top: 3px;\n" +
                        "    margin-left: 6px;' for='checkedAll'><fmt:message code="notice.th.allchose" /></label></td><td style='text-align: left;' colspan='2' class='btnStyle delete_check'><a class='delete_a'><fmt:message code="global.lang.delete" /></a></td><td class=''></td><td></td><td></td><td></td></tr>";

                    if (data.totleNum != undefined) {
                        $('.countSpan').html(" " + data.totleNum + " ");
                    }

                    $(".contentTableBody").html(str + last_str);


                    if (cb) {
                        cb(data.totleNum);
                    }

                    initPagination(data.totleNum, 10);
                }
            })
        }

        //点击全选
        $('.contentTableBody').on('click', '#checkedAll', function () {
//           alert('111');
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
            if(remindUrl.indexOf('http://') > -1 || remindUrl.indexOf('https://') > -1 || remindUrl.substr(0, 1) == '/'){
                window.open(remindUrl);
            }else{
                window.open('/'+encodeURI(remindUrl));
            }
        })

        // 删除
        $('.contentTableBody').on('click', '.delete_a', function () {
            if ($('.checkchild:checked').size() == 0) {
                parent.layer.msg("<fmt:message code="sms.th.SelectLeastOneData" />", {icon: 0});
                return;
            }
                layer.confirm("<fmt:message code="sms.th.areYouSureYouWantToDeleteTheData" />",{
                    btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
                }, function(){
                    var bodyIds = '';
            $('.checkchild:checked').each(function () {
                bodyIds += $(this).attr("bodyId") + ',';
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
                url: "/sms/delete",
                dataType: 'JSON',
                data: {"smsIds": smsId, "deleteFlag": "2",},
                success: function (res) {
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
                            queryType: 3,
                        },
                        success: function (res) {
                            var totleNum = res.totleNum
                            $('.countSpan').html(" " + totleNum + " ");
                        }
                    })
                    if (res.flag) {
                        $.layerMsg({content: "<fmt:message code="workflow.th.delsucess" />", icon: 1,time:1000}, function () {
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            })
                        });
                        <%--parent.layer.msg("<fmt:message code="workflow.th.delsucess" />", {icon: 1});--%>


                    } else {
                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />", {icon: 2});
                    }
                }
            })
            });
        });


        // 删除全部
        $('.delete_all').on('click',function () {
            $.ajax({
                type: "post",
                url: "/sms/delete",
                dataType: 'JSON',
                data: {"deleteFlag": "2",},
                success: function (res) {
                    if (res.flag) {
                        parent.layer.msg("<fmt:message code="workflow.th.delsucess" />", {icon: 1});
                        initPageList(function (pageCount) {
                            initPagination(pageCount, data.pageSize);
                        });
                    } else {
                        parent.layer.msg("<fmt:message code="lang.th.deleSucess" />", {icon: 2});
                    }
                }
            })
        });

        // 删除收信人已删除
        $('.delete_toUserDeleted').on('click',function () {
            parent.layer.confirm("<fmt:message code="sms.th.areYouSureDeletedByTheRecipientsHasBeenDeletedData" />",{
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'] //按钮
            }, function(){
                var set=$('.font').val()
                $.ajax({
                    type: "post",
                    url: "/sms/deleteByDelFlag",
                    dataType: 'JSON',
                    data:{
                        smsType:set,
                    },
                    success: function (res) {
                        if (res.flag) {
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
                                    queryType: 3,
                                },
                                success: function (res) {
                                    var totleNum = res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            parent.layer.msg("<fmt:message code="workflow.th.delsucess" />", {icon: 1});
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            });
                        } else {
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />", {icon: 2});
                        }
                    }
                })
            });
            });

        // 删除已提醒收信人提醒
        $('.delete_allRead').on('click',function () {
            layer.confirm("<fmt:message code="sms.th.areYouSureDeletedRecipientsReminders" />",{
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
                    data: {"deleteType": "2",smsType:set},
                    success: function (res) {
                        if (res.flag) {
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
                                    queryType: 3,
                                },
                                success: function (res) {
                                    var totleNum = res.totleNum
                                    $('.countSpan').html(" " + totleNum + " ");
                                }
                            })
                            $.layerMsg({content: "<fmt:message code="workflow.th.delsucess" />", icon: 1,time:1000}, function () {
                                initPageList(function (pageCount) {
                                    initPagination(pageCount, data.pageSize);
                                })
                            });
                            <%--parent.layer.msg("<fmt:message code="workflow.th.delsucess" />",{icon:1},function () {--%>
                            <%--    location.reload();//刷新当前页面.--%>
                            <%--});--%>
                        } else {
                            parent.layer.msg("<fmt:message code="lang.th.deleSucess" />", {icon: 2});
                        }
                    }
                })
            });
        });

        //重新发送
        $('.contentTableBody').on('click', '.reSend_a', function () {
            var bodyId = $('.reSend_a').attr("bodyId");
            $.ajax({
                type: "post",
                url: "/sms/updateRemind",
                dataType: 'JSON',
                data: {"bodyIds": bodyId, "remindFlag": "1",},
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: "<fmt:message code="workflow.th.delsucess" />", icon: 1,time:1000}, function () {
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            })
                        });
                    } else {
                        parent.layer.msg("<fmt:message code="email.th.filed" />", {icon: 2});
                    }
                }
            })
        });


    });

</script>
</body>
</html>
