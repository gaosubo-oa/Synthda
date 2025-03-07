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
    <title>借阅审批</title>
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
        .buttonDiv .deleteBtn{
            width: 112px;
            height: 28px;
            margin: 20px auto;
            background: url("../img/btn_deletecontent_03.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
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
        .bx{
            height: 100%;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        #tr_td{
            width: 96%;
            margin: 10px auto;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #trList tr td {
            font-size: 11pt;
            text-align: center;
        }
        .mainContent{
            border-top: #ccc 1px solid;
        }
        .mainLeft{
            height: 100%;
            width: 208px;
            float: left;
            border-right: #ccc 1px solid;
        }
        .mainLeft ul,.mainLeft li{
            width: 100%;
        }
        .mainLeft li{
            height: 45px;
            line-height: 45px;
            font-size: 11pt;
            text-align: center;
            border-bottom: #ccc 1px solid;
            cursor: pointer;
        }
        .mainLeft li:hover{
            background: #add2f8;
            color: #000;
            font-weight: bold;
        }
        .on{
            background: #add2f8;
            color: #000;
            font-weight: bold;
        }
        .mainRight{
            float: left;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyuejilu.png">
            <div class="news">
                <span>借阅审批</span>
            </div>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div class="mainContent">
        <div class="mainLeft">
            <ul>
                <li class="on"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_daipizhun.png" style="margin-right: 10px;" alt="">待批准借阅</li>
                <li><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_yipizhun.png" style="margin-right: 10px;" alt="">已批准借阅</li>
                <li><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_weipizhun.png" style="margin-right: 10px;" alt="">未批准借阅</li>
                <li><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_yiguihuan.png" style="margin-right: 10px;" alt="">已归还借阅</li>
            </ul>
        </div>
        <div class="mainRight">
            <input type="hidden" name="borrowType" value="0">
            <table id="tr_td">
                <thead>
                <tr>
                    <td class="th">
                        文件号
                    </td>
                    <td class="th">
                        借阅人
                    </td>
                    <td class="th">
                        申请时间
                    </td>
                    <td class="th">
                        审批时间
                    </td>
                    <td class="th">
                        归还时间
                    </td>
                    <td class="th" style="width: 220px;">
                        <fmt:message code="notice.th.operation"/>
                    </td>
                </tr>
                </thead>
                <tbody id="trList">

                </tbody>
            </table>
            <div class="right" style="float: right;margin-right: 2%;">
                <!-- 分页按钮-->
                <div class="M-box3" id="dbgz_page"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var mainHeight=$('.bx').height()-$('#juMange').height()-1;
        $('.mainContent').height(mainHeight);
        var mainWidth=$('.mainContent').width()-209;
        $('.mainRight').width(mainWidth);
        $('.mainRight').height(mainHeight);
        dataList($('#trList'),'0');
        $('.mainLeft li').on('click',function () {
            $(this).addClass('on').siblings().removeClass('on');
            var index=$(this).index();
            $('input[name="borrowType"]').val(index);
            dataList($('#trList'),index);
        });
//      文件详情
        $('#trList').on('click','.to_detail',function () {
            var editId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+editId);
        });
//        点击撤销
        $('#trList').on('click','.revokeData',function () {
            var lendId=$(this).parents('tr').attr('data-id');
            var borrowType=$('input[name="borrowType"]').val();
            playingData(lendId,'0',borrowType);
        });
//        点击删除
        $('#trList').on('click','.deleteData',function () {
            var lendId=$(this).parents('tr').attr('data-id');
            var borrowType=$('input[name="borrowType"]').val();
            playingData(lendId,'1',borrowType);
        });
//        点击批准
        $('#trList').on('click','.approval',function () {
            var lendId=$(this).parents('tr').attr('data-id');
            var borrowType=$('input[name="borrowType"]').val();
            playingData(lendId,'2',borrowType);
        });
//        点击不批准
        $('#trList').on('click','.noApproval',function () {
            var lendId=$(this).parents('tr').attr('data-id');
            var borrowType=$('input[name="borrowType"]').val();
            playingData(lendId,'3',borrowType);
        });

    })

    function playingData(dataId,dType,browType) {
        var titleTxt='';
        var title2='';
        var dataObj='';
        if(dType == '0'){
            titleTxt='确定要撤销该项借阅吗？';
            title2='撤销';
            dataObj={
                lendId:dataId,
                deleteFlag:1
            }
        }else if(dType == '1'){
            titleTxt='确定要删除该项借阅吗？';
            title2='删除';
            dataObj={
                lendId:dataId,
                deleteFlag:1
            }
        }else if(dType == '2'){
            titleTxt='确定要批准该项借阅吗？';
            title2='批准';
            dataObj={
                lendId:dataId,
                allow:1
            }
        }else {
            titleTxt='确定不批准该项借阅吗？';
            title2='不批准';
            dataObj={
                lendId:dataId,
                allow:2
            }
        }
        layer.confirm(titleTxt, {
            btn: [sure,cancel], //按钮
            title:title2
        }, function(){
            $.ajax({
                type:'post',
                url:'/RmsLendController/modifyRmsLendById',
                dataType:'json',
                data:dataObj,
                success:function(res){
                    if(res.flag){
                        if(dType == '0'){
                            layer.msg('撤销成功！', { icon:6});
                        }else if(dType == '1'){
                            layer.msg('删除成功！', { icon:6});
                        }else{
                            layer.msg('操作成功！', { icon:6});
                        }
                        dataList($('#trList'),browType);
                    }else{
                        if(dType == '0'){
                            layer.msg('撤销失败！', { icon:5});
                        }else if(dType == '1'){
                            layer.msg('删除失败！', { icon:5});
                        }else {
                            layer.msg('操作失败！', { icon:5});
                        }
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }

    function dataList(element,allowNum) {
        var ajaxPage={
            data:{
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                allow:allowNum
            },
            page:function () {
                element.find('tr').remove();
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/RmsLendController/selRmsLend',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        var allDate='0000-00-00 00:00:00';
                        if(datas.length > 0){
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].lendId+'">' +
                                    '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].fileCode+'</td>' +
                                    '<td>'+datas[i].userId+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].lendTime != '' || datas[i].lendTime != undefined){
                                            return new Date(datas[i].lendTime).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                            return '';
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].allowTime != undefined){
                                            return new Date(datas[i].allowTime).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                            return allDate;
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].returnTime != undefined){
                                            return new Date(datas[i].returnTime).Format('yyyy-MM-dd hh:mm:ss');
                                        }else{
                                            return allDate;
                                        }
                                    }()+'</td>' +
                                    '<td>'+function () {
                                        if(allowNum == '0'){
                                            return '<a href="javascript:;" class="approval" style="margin-right: 10px;">批准</a><a href="javascript:;" class="noApproval">不批准</a>';
                                        } else if(allowNum == '1' || allowNum == '2'){
                                            return '<a href="javascript:;" class="revokeData" style="margin-right: 10px;">撤销</a><a href="javascript:;" class="deleteData">删除</a>';
                                        }else {
                                            return '<a href="javascript:;" class="deleteData">删除</a>';
                                        }
                                    }()+'</td>' +
                                    '</tr>'
                            }
                        }else{
                            str='<tr>' +
                                '<td colspan="6"><img src="/img/rms/shouyekong.png" alt=""><p>暂无数据</p></td>' +
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
