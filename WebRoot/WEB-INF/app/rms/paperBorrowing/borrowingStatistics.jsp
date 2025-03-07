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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>借阅统计</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <style>
        #selectq{
            margin-left: 10px;
            width: 120px;
            outline: none;
            border-radius:4px;
        }
        .editMange input[type="text"]{
            width: 260px;
            height: 30px;
        }
        select{
            width: 260px;
            height: 30px;
        }
        textarea{
            width: 260px;
            height: 50px;
            vertical-align: middle;
        }
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #j_tb tr td {
            font-size: 11pt;
            text-align: center;
        }

    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueTongji.png">
            <div class="news">
                <span>借阅统计</span>
            </div>
        </div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;">
            <table id="tr_td">
                <thead>
                <tr>
                    <td class="th">
                        <fmt:message code="dem.th.FileNum"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.FileTitle"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.Dense"/>
                    </td>
                    <td class="th">
                        <fmt:message code="doc.th.DispatchUnit"/>
                    </td>
                    <td class="th">
                        <fmt:message code="doc.th.DispatchTime"/>
                    </td>
                    <td class="th">
                        <fmt:message code="dem.th.EmergencyGrade"/>
                    </td>
                    <td class="th" style="width: 220px;">
                        借阅次数
                    </td>
                </tr>
                </thead>
                <tbody id="j_tb">

                </tbody>
            </table>
            <div class="right"><!-- 分页显示-->
                <div class="M-box3" id="dbgz_page"></div>
            </div>
        </div>
    </div>

    <div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">
        <iframe src="" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
    </div>
</div>
<script type="text/javascript">

    $(function () {
        initData($('#j_tb'));
//      文件详情
        $('#j_tb').on('click','.to_detail',function () {
            var editId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+editId);
        });
//        点击数量
        $('#j_tb').on('click','.btnNum',function () {
            var fileId=$(this).parents('tr').attr('data-id');
            $('#juMange').hide();
            $('#iframeShow').show();
            $('#iframeThr').attr('src','/RmsLendController/loaningRecord?fileId='+fileId);
        })
    })
    function initData(element) {
        var ajaxPage={
            data:{
                page:1,
                pageSize:10
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/RmsLendController/fileJieYueCount',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        if(datas.length > 0){
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].fileId+'">' +
                                    '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].fileCode+'</td>' +
                                    '<td>'+datas[i].fileTitle+'</td>' +
                                    '<td>'+function () {
                                       if(datas[i].secretName != undefined){
                                           return datas[i].secretName;
                                       } else {
                                           return '';
                                       }
                                    }()+'</td>' +
                                    '<td>'+datas[i].sendUnit+'</td>' +
                                    '<td>'+function () {
                                       if(datas[i].addTime != undefined && datas[i].addTime != ''){
                                           return new Date(datas[i].addTime).Format('yyyy-MM-dd hh:mm:ss')
                                       }else {
                                           return '';
                                       }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].urgencyName != undefined){
                                            return datas[i].urgencyName;
                                        } else{
                                            return '';
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                       if(datas[i].fileCount > 0){
                                           return '<a href="javascript:;" class="btnNum" style="color: #1687cb;">'+datas[i].fileCount+'</a>';
                                       }else{
                                           return datas[i].fileCount;
                                       }
                                    }()+'</td>' +
                                    '</tr>'
                            }
                        }else{
                            str='<tr>' +
                                '<td colspan="5"><img src="/img/rms/shouyekong.png" alt=""><p>暂无数据</p></td>' +
                                '</tr>'
                        }
                        element.html(str);
                        me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
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
