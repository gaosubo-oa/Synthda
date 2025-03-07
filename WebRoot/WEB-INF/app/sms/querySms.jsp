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
    <title><fmt:message code="sms.th.ReminderQuery" /></title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>

    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <style type="text/css">
        .contentTableBody {
            text-align: center;
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

        .contentTableBody tr:nth-child(even) {
            background: #ffffff;
        }

        .title_span {
            font-size: 20px;
        }

        .result_div {
            display: none;
        }

        .queryTable {
            width: 60%;
            margin: 0 auto;
        }

        .queryTable td {
            border-right: 1px solid #c0c0c0;
        }
        .queryTable td:first-of-type{
            width: 150px;
        }

        input {
            width: auto;
        }
        .commitBtn {
            background: #2f8ae3;
            outline: none;
            padding: 1px 6px;
            text-align: center;
            cursor: pointer;
            width: 50px;
            height: 28px;
            color: #ffffff;
            border-radius: 4px;
            line-height: 28px;
        }
        a{
            cursor: pointer;
        }

        select{
            width: auto;
        }
        .title_span{
            margin-left: 5px;
        }
        .countSpan {
            color: red;
        }
       tr td{
           font-size: 11pt;
       }
        .font{
            color: white;
            background-color:  #2B7FE0;
        }
        input.timer{
            width: 200px;
            height: 28px;
            border-radius: 5px;
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
    </style>
</head>
<body>
<div class="query_div">
    <table class="headTable">
        <tr>
            <td style=""><img src="/img/commonTheme/${sessionScope.InterfaceModel}/title_query.png" alt=""><span class="title_span"><fmt:message code="sms.th.ReminderQuery" /></span></td>
        </tr>
    </table>
    <table class="queryTable">
        <tr>
            <td>
                <select name="type" style="width: 100px;">
                    <option value="fromIds"><fmt:message code="sup.th.Sender" /></option>
                    <option value="toIds"><fmt:message code="sms.th.Addressee" /></option>
                </select>
            </td>
            <td>
                <textarea id="userIdsText" style="width: 50%;border-radius: 5px;" readonly rows="3"></textarea>
                <a class="userAdd" style="color: #207BD6;"><fmt:message code="global.lang.add" /></a> <a class="userClear" style="color: #207BD6;"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td><fmt:message code="notice.th.type" />：</td>
            <td>
                <select name="smsType" style="width: 200px;">

                </select>
            </td>
        </tr>
        <tr>
            <td><fmt:message code="sms.th.StartDate" />：</td>
            <td><input type="text" class="timer" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" name="beginDate"/></td>
        </tr>
        <tr>
            <td><fmt:message code="sms.th.ClosingDate" />：</td>
            <td><input type="text" class="timer" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" name="endDate"/></td>
        </tr>
        <tr>
            <td><fmt:message code="notice.th.content" />：</td>
            <td>
                <textarea name="content" style="width: 50%;border-radius: 5px;" rows="3"></textarea>
            </td>
        </tr>
        <tr>
            <td><fmt:message code="sms.th.sortField" />：</td>
            <td>
                <select name="orderBy">
                    <option value="sms_type"><fmt:message code="notice.th.type" /></option>
                    <option value="type"><fmt:message code="sms.th.SenderReceiver" /></option>
                    <option value="content"><fmt:message code="notice.th.content" /></option>
                    <option value="send_time" selected><fmt:message code="sup.th.SendingTime" /></option>
                </select>
                <select name="sortType">
                    <option value="desc"><fmt:message code="netdisk.th.desc" /></option>
                    <option value="asc"><fmt:message code="netdisk.th.asc" /></option>
                </select>
            </td>
        </tr>
        <tr>
            <td><fmt:message code="notice.th.operation" />：</td>
            <td>
                <input id="query" type="radio" name="opeType" value="1" checked style="float:none"/>
                <label for="query"><fmt:message code="global.lang.query" /></label>
                <input id="export" type="radio" name="opeType" value="2" style="float:none"/>
                <label for="export"><fmt:message code="global.lang.report" /></label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
                <button class="commitBtn"><fmt:message code="global.lang.ok" /></button>
            </td>
        </tr>
    </table>
</div>

<div class="result_div">
    <table class="headTable">
        <tr>
            <td><span class="title_span"><fmt:message code="sms.th.QueryResult" /></span>&nbsp;&nbsp;(<fmt:message code="main.th.general" /><span class="countSpan">0</span><fmt:message code="main.th.BarReminder" />)</td>
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
    <table class="contentTable">
        <thead>
        <tr>
            <th style="width: 5%;text-align:left;padding-left:10px"><fmt:message code="global.lang.select" /></th>
            <th style="width:10%" class="peopleType"><fmt:message code="sup.th.Sender" /></th>
            <th style="width: 15%"><fmt:message code="notice.th.type"/></th>
            <th style="width: 40%"><fmt:message code="notice.th.content" /></th>
            <th style="width: 20%"><fmt:message code="sup.th.SendingTime" /></th>
            <th style="width: 10%"><fmt:message code="sms.th.remind" /></th>
            <%--<th>操作</th>--%>
        </tr>
        </thead>
        <tbody class="contentTableBody">

        </tbody>
    </table>
    <div class="M-box3">

    </div>
</div>


<script type="text/javascript">
    function tab1(data,i){
        $("button").removeAttr('class','font')
        $(".tab >#all").attr('class','font')
        var data = {
            smsType:'',
            beginDate:$('[name="beginDate"]').val(),
            endDate:$('[name="endDate"]').val(),
            content:$('[name="content"]').val(),
            orderBy:$('[name="orderBy"]').val(),
            sortType:$('[name="sortType"]').val(),
            opeType:$('[name="opeType"]:checked').val(),
            page:1,
            pageSize:10,
            useFlag: true,
            fromIds:''
        };
        $.ajax({
            type: "get",
            url: "/sms/query",
            dataType: 'JSON',
            async:false,
            data:data,
            success: function (res) {
                if(res.flag){
                    if(res.obj.length==0){
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                    }else{
                        $('.contentTableBody').html("");
                        var str = "";
                        var type=$('[name="type"]').val()
                        if(type=='fromIds'){
                            for (var i=0;i<res.obj.length;i++){

                                // 格式化时间
                                var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                if (res.obj[i].fromName == undefined) {
                                    res.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                                }
                                var special = res.obj[i].content;
                                //console.log(special);
                                var color='#2B7FE0'
                                if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                    color='red'
                                    // $(".txtContent").css("color","red");
                                }
                                str += "<tr><td><input class='checkChild'  type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                    "<td>" + res.obj[i].fromName + "</td>" +
                                    "<td>"+res.obj[i].smsTypeName+"</td>"+
                                    "<td class='btnTd' remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                    "<td>" + sendTime + "</td>" +
                                    "<td>"+function () {
                                        if(res.obj[i].remindFlag==0){
                                            return "<fmt:message code="global.lang.no" />";
                                        } else{
                                            return "<fmt:message code="global.lang.yes" />";
                                        }
                                    }()+"</td></tr>";
                                // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                            }
                            $('.contentTableBody').append(str);
                        }else if(type=='toIds'){
                            $('.contentTableBody').html("");
                            for (var i=0;i<res.obj.length;i++){

                                // 格式化时间
                                var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                if (res.obj[i].toName == undefined) {
                                    res.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                                }

                                str += "<tr><td><input class='checkChild' type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                    "<td>" + res.obj[i].toName + "</td>" +
                                    "<td>"+res.obj[i].smsTypeName+"</td>"+
                                    "<td class='btnTd' remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:#2B7FE0;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                    "<td>" + sendTime + "</td>" +
                                    "<td>"+function () {
                                        if(res.obj[i].remindFlag==0){
                                            return "<fmt:message code="global.lang.no" />";
                                        } else{
                                            return "<fmt:message code="global.lang.yes" />";
                                        }
                                    }()+"</td></tr>";
                                // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                            }
                            $('.peopleType').html("<fmt:message code="sms.th.Addressee" />");
                            $('.contentTableBody').append(str);
                        }
                        $('.query_div').css("display","none");
                        $('.result_div').css("display","block");
                        if (res.totleNum != undefined) {
                            $('.countSpan').html(" " + res.totleNum + " ");
                        }

                        // if (cb) {
                        //     cb(res.totleNum);
                        // }
                        //
                        // initPagination(res.totleNum);

                    }

                }else{
                    parent.layer.msg("<fmt:message code="sms.th.noData" />");
                }
            }
        });

    }

    function tab(data,i){
        $("button").removeAttr('class','font')
        smsType=data;
        $("button").eq(i+2).attr('class','font')
        var data = {
            smsType:data,
            beginDate:$('[name="beginDate"]').val(),
            endDate:$('[name="endDate"]').val(),
            content:$('[name="content"]').val(),
            orderBy:$('[name="orderBy"]').val(),
            sortType:$('[name="sortType"]').val(),
            opeType:$('[name="opeType"]:checked').val(),
            page:1,
            pageSize:10,
            useFlag: true,
            fromIds:''
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
                url: "/sms/query",
                dataType: 'JSON',
                async: false,
                data: data,
                success: function (res) {
                    if (res.flag) {
                        if (res.obj.length == 0) {
                            parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        } else {
                            $('.contentTableBody').html("");
                            var str = "";
                            var type = $('[name="type"]').val()
                            if (type == 'fromIds') {
                                for (var i = 0; i < res.obj.length; i++) {

                                    // 格式化时间
                                    var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                    if (res.obj[i].fromName == undefined) {
                                        res.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                                    }
                                    var special = res.obj[i].content;
                                    //console.log(special);
                                    var color = '#2B7FE0'
                                    if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                        color = 'red'
                                        // $(".txtContent").css("color","red");
                                    }
                                    str += "<tr><td><input class='checkChild'  type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                        "<td>" + res.obj[i].fromName + "</td>" +
                                        "<td>" + res.obj[i].smsTypeName + "</td>" +
                                        "<td class='btnTd' remindUrl='" + res.obj[i].remindUrl + "'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:" + color + ";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                        "<td>" + sendTime + "</td>" +
                                        "<td>" + function () {
                                            if (res.obj[i].remindFlag == 0) {
                                                return "<fmt:message code="global.lang.no" />";
                                            } else {
                                                return "<fmt:message code="global.lang.yes" />";
                                            }
                                        }() + "</td></tr>";
                                    // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                                }
                                $('.contentTableBody').append(str);
                            } else if (type == 'toIds') {
                                $('.contentTableBody').html("");
                                for (var i = 0; i < res.obj.length; i++) {

                                    // 格式化时间
                                    var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                    if (res.obj[i].toName == undefined) {
                                        res.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                                    }

                                    str += "<tr><td><input class='checkChild' type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                        "<td>" + res.obj[i].toName + "</td>" +
                                        "<td>" + res.obj[i].smsTypeName + "</td>" +
                                        "<td class='btnTd' remindUrl='" + res.obj[i].remindUrl + "'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:#2B7FE0;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                        "<td>" + sendTime + "</td>" +
                                        "<td>" + function () {
                                            if (res.obj[i].remindFlag == 0) {
                                                return "<fmt:message code="global.lang.no" />";
                                            } else {
                                                return "<fmt:message code="global.lang.yes" />";
                                            }
                                        }() + "</td></tr>";
                                    // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                                }
                                $('.peopleType').html("<fmt:message code="sms.th.Addressee" />");
                                $('.contentTableBody').append(str);
                            }
                            $('.query_div').css("display", "none");
                            $('.result_div').css("display", "block");
                            if (res.totleNum != undefined) {
                                $('.countSpan').html(" " + res.totleNum + " ");
                            }

                            if (cb) {
                                cb(res.totleNum);
                            }

                            initPagination(res.totleNum);

                        }

                    } else {
                        parent.layer.msg("<fmt:message code="sms.th.noData" />");
                    }
                }
            });
        }

    }
    var user_id ;
    $(function () {
        // 查询所有类型
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"SMS_REMIND"},
            success:function(data){
                var str='<option value=""><fmt:message code="news.th.type" />&nbsp;&nbsp;</option>';
                for (var proId in data){
                    for(var i=0;i<data[proId].length;i++){
                        str+='<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                    }
                }
                $('select[name="smsType"]').append(str);
            }
        });

        // 选人控件
        $(Document).on('click','.userAdd',function () {
            user_id='userIdsText';
            $.popWindow("../common/selectUser");
        });

        // 清空
        $('.userClear').on('click',function(){
            $('#userIdsText').attr("dataid","");
            $('#userIdsText').attr("user_id","");
            $('#userIdsText').val("");
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
        var pageInfo = {
            page: 1,
            pageSize: 10,
            useFlag: true
        };

        $(Document).on('click','.commitBtn',function () {
            initPageList(function (pageCount) {
                initPagination(pageCount, pageInfo.pageSize);
            });

        })
        function initPagination(totalData, pageSize) {

            $('.M-box3').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                current: pageInfo.page,
                homePage: '<fmt:message code="global.page.first" />',
                endPage: '<fmt:message code="global.page.last" />',
                prevContent: '<fmt:message code="global.page.pre" />',
                nextContent: '<fmt:message code="global.page.next" />',
                jumpBtn: '<fmt:message code="global.page.jump" />',
                callback: function (index) {

                    pageInfo.page = index.getCurrent();

                    initPageList(function (pageCount) {
                        initPagination(pageCount, pageInfo.pageSize);
                    });
                }
            });
        }
        function  initPageList(cb) {
            var type = $('[name="type"]').val();
            var data = {
                smsType:$('[name="smsType"]').val(),
                beginDate:$('[name="beginDate"]').val(),
                endDate:$('[name="endDate"]').val(),
                content:$('[name="content"]').val(),
                orderBy:$('[name="orderBy"]').val(),
                sortType:$('[name="sortType"]').val(),
                opeType:$('[name="opeType"]:checked').val(),
                page:pageInfo.page,
                pageSize:pageInfo.pageSize,
                useFlag: pageInfo.useFlag
            };
            data[''+type+'']=$('#userIdsText').attr("user_id")==undefined?"":$('#userIdsText').attr("user_id");
            //console.log(data);
            if(data.opeType=="1"){
                $.ajax({
                    type: "get",
                    url: "/sms/query",
                    dataType: 'JSON',
                    data:data,
                    success: function (res) {
                        if(res.flag){
                            var sms=$('[name="smsType"]').val()
                            if(sms==''){
                                var str1=''
                                $.ajax({
                                    url: "/sms/classification",
                                    type: 'post',
                                    dataType: "JSON",
                                    data:{
                                        queryType:4
                                    },
                                    success: function (res) {
                                        str1 += '<button id="all"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab1()" ><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img style="height: 22px;width: 22px"  src="/img/commonTheme/theme6/title_unconfirmed_sms.png"></img></div><div  class="fonts" style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px"><fmt:message code="sms.th.allReminders" /></div></button>'
                                        for (var i = 0; i < res.data.length; i++) {
                                            if (res.data[i].smsType == '16' || res.data[i].smsType == '17') {
                                                str1 += '<button id="'+i+'"  style="width: 180px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab('+res.data[i].smsType+','+i+')" value="'+res.data[i].smsType+'"><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img  src="'+res.data[i].smsTypeIcon+'"></img></div><div class="fonts" style="width: 146px;height: 36px;margin-top: 8px;font-size: 15px">' + res.data[i].smsTypeName + '</div></button>'
                                            } else {
                                                str1 += '<button id="'+i+'"  style="width: 150px;margin-top: 10px;border-radius: 10px;height: 36px;display: flex;margin-left: 5px;"  onclick="tab('+res.data[i].smsType+','+i+')" value="'+res.data[i].smsType+'"><div style="height: 36px;margin-top: 7px;margin-left: 10px;"><img  src="'+res.data[i].smsTypeIcon+'"></img></div><div class="fonts" style="width: 110px;height: 36px;margin-top: 8px;font-size: 15px">' + res.data[i].smsTypeName + '</div></button>'
                                            }
                                        }
                                        $('.tab').html(str1)
                                        if(res.data.length=='0'){
                                            $(".tab >#all").hide()
                                        }

                                    }
                                });
                            }

                            if(res.obj.length==0){
                                parent.layer.msg("<fmt:message code="sms.th.noData" />");
                            }else{
                                $('.contentTableBody').html("");
                                var str = "";
                                if(type=='fromIds'){
                                    for (var i=0;i<res.obj.length;i++){

                                        // 格式化时间
                                        var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                        if (res.obj[i].fromName == undefined) {
                                            res.obj[i].fromName = "<fmt:message code="sms.th.UserNotExist" />";
                                        }
                                        var special = res.obj[i].content;
                                        //console.log(special);
                                        var color='#2B7FE0'
                                        if (special.indexOf("<fmt:message code="sup.th.urgent" />") != -1 || special.indexOf("<fmt:message code="doc.th.ExtraUrgent" />") != -1) {
                                            color='red'
                                            // $(".txtContent").css("color","red");
                                        }
                                        str += "<tr><td><input class='checkChild'  type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                            "<td>" + res.obj[i].fromName + "</td>" +
                                            "<td>"+res.obj[i].smsTypeName+"</td>"+
                                            "<td class='btnTd' remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:"+color+";overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                            "<td>" + sendTime + "</td>" +
                                            "<td>"+function () {
                                                if(res.obj[i].remindFlag==0){
                                                    return "<fmt:message code="global.lang.no" />";
                                                } else{
                                                    return "<fmt:message code="global.lang.yes" />";
                                                }
                                            }()+"</td></tr>";
                                        // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                                    }
                                    $('.contentTableBody').append(str);
                                }else if(type=='toIds'){
                                    $('.contentTableBody').html("");
                                    for (var i=0;i<res.obj.length;i++){

                                        // 格式化时间
                                        var sendTime = new Date((res.obj[i].sendTime) * 1000).Format('yyyy-MM-dd');
                                        if (res.obj[i].toName == undefined) {
                                            res.obj[i].toName = "<fmt:message code="sms.th.UserNotExist" />";
                                        }

                                        str += "<tr><td><input class='checkChild' type='checkbox' bodyId='" + res.obj[i].bodyId + "' name='check' value=''></td>" +
                                            "<td>" + res.obj[i].toName + "</td>" +
                                            "<td>"+res.obj[i].smsTypeName+"</td>"+
                                            "<td class='btnTd' remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + " title='" + res.obj[i].content + "'><div class='txtContent' style='color:#2B7FE0;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;'>" + res.obj[i].content + "</div></td>" +
                                            "<td>" + sendTime + "</td>" +
                                            "<td>"+function () {
                                                if(res.obj[i].remindFlag==0){
                                                    return "<fmt:message code="global.lang.no" />";
                                                } else{
                                                    return "<fmt:message code="global.lang.yes" />";
                                                }
                                            }()+"</td></tr>";
                                        // "<td><a class='detail_a'  remindUrl='"+res.obj[i].remindUrl+"'  bodyId='" + res.obj[i].bodyId + "' >查看详情</a></td></tr>";
                                    }
                                    $('.peopleType').html("<fmt:message code="sms.th.Addressee" />");
                                    $('.contentTableBody').append(str);
                                }
                                $('.query_div').css("display","none");
                                $('.result_div').css("display","block");
                                if (res.totleNum != undefined) {
                                    $('.countSpan').html(" " + res.totleNum + " ");
                                }

                                if (cb) {
                                    cb(res.totleNum);
                                }

                                initPagination(res.totleNum,pageInfo.pageSize);

                            }

                        }else{
                            parent.layer.msg("<fmt:message code="sms.th.noData" />");
                        }
                    }
                });
            }else if(data.opeType=="2") {

                window.location.href = '/sms/query?smsType=' + data.smsType +
                    '&beginDate=' + data.beginDate +
                    '&endDate=' + data.endDate +
                    '&content=' + data.content +
                    '&orderBy=' + data.orderBy +
                    '&sortType=' + data.sortType +
                    '&opeType=' + data.opeType +
                    '&fromIds=' + data.fromIds

            }
        }
    });

</script>
</body>
</html>
