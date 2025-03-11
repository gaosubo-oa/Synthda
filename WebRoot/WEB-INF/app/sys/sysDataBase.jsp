<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>数据库管理</title>

    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <script src="/js/common/language.js"></script>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
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

        .export_one_style {
            color: dodgerblue;
            cursor: pointer;
            margin-left: 10px;
        }

        .bottom_a_style {
            color: dodgerblue;
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
            margin: 0 1%;
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

        .export_table{
            background-position-y: 5px;
            padding-right: 4px;
        }
        .export_all{
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
        .contentTableBody  td {
            font-size: 11pt;
            text-align: left;
        }
        .imgDiv{
            text-align: center;
            display: none;
            margin-top: 60px;
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
        .search-input {
            height: 26px;
            width: 168px;
            border: 1px solid #d0d0d0;
            border-radius: 3px;
            margin: 20px 10px;
        }
        .title_span{
            margin-left: 5px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-top: -3px;
            font-size: 17pt;
            color: #494d59;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<table class="headTable" >
    <tr>
        <td><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRoll.png" alt="">
            <span class="title_span"><fmt:message code="database.queryResult" /></span>&nbsp;&nbsp;(<fmt:message code="database.total" /><span class="countSpan">0</span><fmt:message code="database.count" />)

            <span style="margin-left: 20px"><fmt:message code="database.tableName" />：</span>
            <input type="text" class="search-input"  />
            <div id="search-btn" class="submit" style="display: inline-block;background: #009688;border-radius: 5px;color: white;">
                <fmt:message code="database.query" />
            </div>

        </td>

    </tr>
</table>
<div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
    <div><fmt:message code="database.noData" /></div>
</div>
<table class="contentTable" style="table-layout: fixed">
    <thead>
    <tr>
        <th style="width: 5%;min-width:50px;text-align: left"><fmt:message code="global.lang.select" /></th>
        <th style="width: 15%;"><fmt:message code="database.tableNameAbbr" /></th>
        <th style="width: 10%;"><fmt:message code="database.tableRows" /></th>
        <th style="width: 15%;"><fmt:message code="database.tableSize" /></th>
        <th style="width: 10%;"><fmt:message code="database.tableType" /></th>
        <th style="width: 10%;"><fmt:message code="database.tableCharset" /></th>
        <th style="width: 20%;"><fmt:message code="database.tableComment" /></th>
        <th style="width: 15%;"><fmt:message code="database.operation" /></th>
    </tr>
    </thead>
    <tbody class="contentTableBody">

    </tbody>
</table>
<div class="M-box3">

</div>
<script type="text/javascript">

    function openRold(){
        location.reload();
    }
    $(function () {
        var data = {
            queryType: 1,
            page: 1,
            pageSize: 10,
            useFlag: true
        };

        initPageList(function (pageCount) {
            initPagination(pageCount, data.pageSize);
            var active = $.getQueryString("active")||'';
            if(active != ''){
                $('.M-box3 a[data-page='+ active +']').click();
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

            var searchValue = $('.search-input').val();
            data.searchValue = searchValue;

            $.ajax({
                type: "get",
                url: "/sysDataBase/selTables",
                dataType: 'JSON',
                data: data,
                success: function (res) {

                    $(".imgDiv").css("display","none");
                    $(".contentTable").css("display","block");
                    $(".M-box3").css("display","block");
                    var str = "";
                    if(res.data){
                        for (var i = 0; i < res.data.length; i++) {
                            var data = res.data[i];
                            str += "<tr>" +
                                "<td style='min-width:50px;text-align:left' ><input class='checkChild'  type='checkbox' name='check' value='' tableName='"+data.tableName+"' '></td>" +
                                "<td style=''>" + data.tableName + "</td>" +
                                "<td style=''>" + data.tableRows+"</td>" +
                                "<td style=''>" + data.dataLength+"</td>" +
                                "<td style=''>" + data.engine+"</td>" +
                                "<td style=''>" + data.tableCollation + "</td>" +
                                "<td style=''>" + data.tableComment + "</td>" +
                                "<td tableName='"+data.tableName+"' ><a class='export_one_style export_one_table'  ><fmt:message code="database.exportStructure" /></a><a class='export_one_style export_one_all'  ><fmt:message code="database.exportStructureAndData" /></a></td></tr>";
                        }
                    }


                    var last_str = "<tr class='last_str'>" +
                        "<td><input id='checkedAll' style='float:left;'  type='checkbox' conid='29' name='check' value=''><label for='checkedAll' style='float:left;'><fmt:message code="notice.th.allchose" /></label></td>" +
                        "<td colspan='7' style='text-align: left' class='btnStyle delete_check'><a class='export_table bottom_a_style' ><fmt:message code="database.exportTableStructure" /></a><a class='export_all bottom_a_style' ><fmt:message code="database.exportTableStructureAndData" /></a></td>" +
                        "</tr>";

                    if (res.data != undefined) {
                        $('.countSpan').html(" " + res.data.length + " ");
                    }

                    $(".contentTableBody").html(str + last_str);


                }
            })
        }

        // 点击查询
        $('#search-btn').click(function(){
            initPageList();
        });

        //点击全选
        $('.contentTableBody').on('click', '#checkedAll', function () {
            var state = $(this).prop("checked");
            if (state == true) {
                $(this).prop("checked", true);
                $(".checkChild").prop("checked", true);
            } else {
                $(this).prop("checked", false);
                $(".checkChild").prop("checked", false);
            }
        });

        // 单独导出表结构
        $('.contentTableBody').on('click', '.export_one_table', function () {

            var table = $(this).parent().attr("tableName");

            window.open("/sysDataBase/exportTables?exportType=0&tables="+table);
        });

        //  单独导出表结构和数据
        $('.contentTableBody').on('click', '.export_one_all', function () {

            var tables = $(this).parent().attr("tableName");

            window.open("/sysDataBase/exportTables?exportType=1&tables="+tables);

        });

        // 导出选中的表结构
        $('.contentTableBody').on('click', '.export_table', function () {
            var tables = '';
            $('.checkchild:checked').each(function () {
                tables+=$(this).attr("tableName")+',';
            });

            $.ajax({
                type: "get",
                url: "/sysDataBase/exportTables",
                dataType: 'application/octet-stream',
                data: {
                    exportType:"0",
                    tables:tables
                },
                success: function (res) {
                    urlDownload(res,"ces.sql");
                }
            })

        });

        //  导出选中的表结构和数据
        $('.contentTableBody').on('click', '.export_all', function () {

            var tables = '';
            $('.checkchild:checked').each(function () {
                tables+=$(this).attr("tableName")+',';
            });

            $.ajax({
                type: "get",
                url: "/sysDataBase/exportTables",
                dataType: 'application/octet-stream',
                data: {
                    exportType:"1",
                    tables:tables
                },
                success: function (res) {
                    urlDownload(res,"ces.sql");
                }
            })

        });

        const urlDownload = (v, fileName) => {
            let isblob = typeof v == 'string';
            const url = isblob ? v : window.URL.createObjectURL(v);
            const a = document.createElement('a');
            document.body.appendChild(a);
            a.href = url;
            a.download = fileName;
            a.click();
            if (!blob) {
                window.URL.revokeObjectURL(url);
            }
            document.body.removeChild(a);
        }

    });


</script>
</body>
</html>
