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
    <title>邮件审批</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>



    <!-- 新闻管理  -->
    <script src="/js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>

    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/tablePage.js"></script>
    <style>
        .divTable{
            width: 70%;
            margin: 0px auto;
        }
        .divTable table{
            width: 100%;
        }
        .divTable table tr th{
            /*padding: 8px;*/
            /*font-size: 11pt;*/
            font-size: 13pt;
            color: #2F5C8F;
            /*border-right: #ccc 1px solid;*/
        }

        td{
            font-size: 11pt;
        }

        .divTable table tr td{
            text-align: center;
            border-right: #ccc 1px solid;
            padding: 8px;
        }
    </style>

</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" id="general" data-type="">一般邮件审批</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" id="filter" data-type="0">过滤词审批</li>
    </ul>
</div>
<div class="navigation" style="margin-top: 46px;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
    <h2>一般邮件审批</h2>
</div>
<div class="divTable" style="display: block;">
    <input type="hidden" id="hidVal" value="1">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
        <thead>
        <tr>
            <th>序号</th>
            <th>发件人</th>
            <th>收件人</th>
            <th>标题</th>
            <th>发件日期</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="trList">

        </tbody>
    </table>
   <%-- <div class="right">
        <!-- 分页按钮-->
        <div class="M-box3" id="dbgz_page"></div>
    </div>--%>
</div>
<%--<div class="divTable_s" style="display: none;">--%>
    <%--<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">--%>
        <%--<thead>--%>
        <%--<tr>--%>
            <%--<th>序号</th>--%>
            <%--<th>发件人</th>--%>
            <%--<th>收件人</th>--%>
            <%--<th>标题</th>--%>
            <%--<th>发件日期</th>--%>
            <%--<th>操作</th>--%>
        <%--</tr>--%>
        <%--</thead>--%>
        <%--<tbody id="trList_s">--%>

        <%--</tbody>--%>
    <%--</table>--%>
    <%--<div class="right">--%>
        <%--<!-- 分页按钮-->--%>
        <%--<div class="M-box3" id="dbgz_page_s"></div>--%>
    <%--</div>--%>
<%--</div>--%>

<script type="text/javascript">
    $(function () {
//        初始值
        generalEmail($('#trList'))

        $('#general').click(function () {
            $('.navigation').find('h2').html('一般邮件审批');
            generalEmail($('#trList'));
            $(this).addClass('active');
            $('#filter').removeClass('active');
            $('#hidVal').val('1');
        })
        $('#filter').click(function () {
            $('.navigation').find('h2').html('过滤词审批');
            filterEamil($('#trList'));
            $(this).addClass('active');
            $('#general').removeClass('active');
            $('#hidVal').val('2');
        })
//        批准
        $('#trList').on('click','.approval',function () {
            var hidType = $('#hidVal').val();
            var dataId = $(this).parents('tr').attr('data-id');

            var data;
            if (hidType == '1') {
                data = {
                    bodyId: dataId,
                    flag: hidType,
                    examFlag: 1,
                }
            } else {
                data = {
                    bodyId: dataId,
                    flag: hidType,
                    wordFlag: 1,
                }
            }
            pizhun(data, hidType, $('#trList'))
        })

//            不批准
            $('#trList').on('click','.noApproval',function () {
                var hidType=$('#hidVal').val();
                var dataId=$(this).parents('tr').attr('data-id');
                var data;
                if(hidType == '1'){
                    data={
                        bodyId:dataId,
                        flag:hidType,
                        examFlag:2,
                    }
                }else{
                    data={
                        bodyId:dataId,
                        flag:hidType,
                        wordFlag:2,
                    }
                }
                pizhun(data,hidType,$('#trList'))

            })
    })
        function pizhun(data,hideType,element) {
            $.ajax({
                type: 'post',
                url: '/email/examEmail',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        layer.msg('操作成功！', {icon: 1});
                        if(hideType == '1'){
                            generalEmail(element)
                        }else{
                            filterEamil(element)
                        }
                    } else {
                        layer.msg('操作失败！', {icon: 2});
                    }
                }
            })
        }
    function generalEmail(element) {
        var ajaxPage={
            data:{
                page:1,
                pageSize:10,
                useFlag:true,
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/email/selExamEmail',
                    dataType:'json',
                    data:me.data,
                    success:function (res) {
                        var datas=res.obj;
                        if(res.flag){
                            var str='';
                            for(var i=0;i<datas.length;i++){
                                var sendTime=new Date((datas[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm:ss');
                                str+='<tr data-id="'+datas[i].bodyId+'">' +
                                    '<td>'+(i+1)+'</td>' +
                                    '<td>'+datas[i].fromName+'</td>' +
                                    '<td>'+datas[i].toName+'</td>' +
                                    '<td><a href="/email/details?editType=0&id='+datas[i].bodyId+'" target="_blank">'+datas[i].subject+'</a></td>' +
                                    '<td>'+sendTime+'</td>' +
                                    '<td><a href="javascript:;" style="margin-right: 10px;" class="approval">批准</a><a href="javascript:;" class="noApproval">不批准</a></td>' +
                                    '</tr>'
                            }
                            element.html(str);
                            me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        }
                    }
                })

            },
            pageTwo:function (totalData, pageSize,indexs) {
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
            }
        };
        ajaxPage.page();
    }
    function filterEamil(element) {
        var ajaxPage={
            data:{
                page:1,
                pageSize:10,
                useFlag:true,
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/email/selwordExamEmail',
                    dataType:'json',
                    data:me.data,
                    success:function (res) {
                        var datas=res.obj;
                        if(res.flag){
                            var str='';
                            for(var i=0;i<datas.length;i++){
                                var sendTime=new Date((datas[i].sendTime)*1000).Format('yyyy-MM-dd hh:mm:ss');
                                str+='<tr data-id="'+datas[i].bodyId+'">' +
                                    '<td><input type="checkbox" class="checkchild"></td>' +
                                    '<td>'+datas[i].fromName+'</td>' +
                                    '<td>'+datas[i].toName+'</td>' +
                                    '<td><a href="/email/details?editType=0&id='+datas[i].bodyId+'" target="_blank">'+datas[i].subject+'</a></td>' +
                                    '<td>'+sendTime+'</td>' +
                                    '<td><a href="javascript:;" style="margin-right: 10px;" class="approval">批准</a><a href="javascript:;" class="noApproval">不批准</a></td>' +
                                    '</tr>'
                            }
                            element.html(str);
                            me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                        }
                    }
                })

            },
            pageTwo:function (totalData, pageSize,indexs) {
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
            }
        };
        ajaxPage.page();
    }
</script>

</body>
</html>
