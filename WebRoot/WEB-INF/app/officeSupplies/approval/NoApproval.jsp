<%--
  Created by IntelliJ IDEA.
  User: 牛江丽
  Date: 2017/10/12
  Time: 11:05
  办公用品发放
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><fmt:message code="event.th.PendingApplication" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/myMeeting.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">

    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        table tbody tr td:nth-child(1){
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }
        .table .span_td{
            text-align: right;
        }
        select {
            margin-left: 6px;
            width: 150px;
            height: 30px;
            border: #ebebeb 1px solid;
            border-radius: 5px;
            padding: 0 5px;
        }
        .listShow td{
            line-height: 40px;
        }
        .jump-ipt{
            float: left;
            width: 30px;
            height: 30px;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
        .bottom {
            width: 97%;
            margin: 0 auto;
            border: 1px solid #c0c0c0;
            margin-top: 10px;
            background-color: #fff;
        }
        .bottom .boto div {
            cursor: pointer;
            color: #2B7FE0;
            font-size: 14px;
            display: block;
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            margin-top: 0;
            margin-left: 0;
        }
        .bottom div {
            display: inline-block;
            float: left;
            margin-left: 30px;
            margin-top: 5px;
            margin-bottom: 5px;
            background: none;
        }
        element.style {
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="headTop" style="border-bottom:none">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_myMeeting.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="event.th.PendingApplication" />
    </div>
</div>
<div class="main">
    <div class="byDepart">
        <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
            <table class="listShow">
                <thead>
                <tr>
                    <th width="4%">

                    </th>
                    <th style="text-align: center" width="7%"><fmt:message code="workflow.th.Serial" /></th>
                    <th style="text-align: center" width="18%"><fmt:message code="vote.th.OfficeName" /></th>
                    <th style="text-align: center" width="10%"><fmt:message code="vote.th.Registration" /></th>
                    <th style="text-align: center" width="15%"><fmt:message code="sup.th.Applicant" /></th>
                    <th style="text-align: center" width="7%"><fmt:message code="vote.th.Total" /></th>
                    <th style="text-align: center" width="15%"><fmt:message code="hr.th.DateOfApplication" /></th>
                    <th style="text-align: center" width="10%"><fmt:message code="journal.th.Remarks" /></th>
                    <th style="text-align: center" width="7%"><fmt:message code="notice.th.operation" /></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="dbgz_page" class="M-box3 fr" style="float: right;margin-top: 1%">

            </div>
        </div>
    </div>
</div>
<div class="bottom w clearfix">
    <div class="checkALL">
        <input id="checkedAll" type="checkbox" name="" value="" >
        <label for="checkedAll" style="font-size: 14px;"><fmt:message code="notice.th.allchose" /></label>
    </div>
    <div class="boto">
        <div class="ONE" href="javascript:void(0)"><span><fmt:message code="office.approvals"/></span></div>
    </div>
    <div class="boto">
        <div class="TWO" href="javascript:void(0)"><span><fmt:message code="office.disapprovals"/></span></div>
    </div>

</div>
<script>
    $(function () {
        //列表显示
        queryNoApprove();
    })
    var transId = '';
    var proId='';
    if(location.search){
        var obj = {};
        var url = location.href.split('?')[1].split('&');
        for(var i = 0; i < url.length; i++){
            obj[url[i].split('=')[0]] = url[i].split('=')[1];
        }
        transId = obj.transId;
        proIds=obj.proId;
    }


    function queryNoApprove() {
        //列表显示
        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                transId: transId
                // computationNumber:null
            },
            page: function () {
                var me = this;
                $.ajax({
                    url: '/officetransHistory/selTranshistoryByState',
                    type: 'get',
                    dataType: 'json',
                    data:me.data,
                    success: function (obj) {
                        var data = obj.obj;
                        var str = "";
                        for (var i = 0; i < data.length; i++) {
                            proId=data[i].proId;
                            str += '<tr class="userData"  transState= "' +data[i].transState +'"  transId= "' +data[i].transId +'" proId= "' +data[i].proId +'" >' +
                                '<td>'+
                                ' <input type="checkbox" class="checkChild" name="checkbox" value=""  style="width:13px;height:13px;" />'+
                                '</td>' +
                                '<td style="text-align: center" width="7%"">'+(i+1)+'</td>' +
                                '<td style="text-align: center" width="18%" title="' + data[i].proName + '">' + data[i].proName + '</td>' ;
                            if(data[i].transFlag=="1"){
                                str+='<td style="text-align: center" width="10%"><fmt:message code="vote.th.user" /></td>' ;
                            }else{
                                str+='<td style="text-align: center" width="10%"><fmt:message code="vote.th.borrow" /></td>' ;
                            }
                            str+='<td style="text-align: center" width="15%">' + data[i].borrowerName + '</td>' +
                                '<td style="text-align: center" width="7%">' + data[i].transQty + '</td>' +
                                '<td style="text-align: center" width="15%">' + data[i].transDate + '</td>' ;
                            str+='<td style="text-align: center" width="10%">' + data[i].remark + '</td>' ;

                            str+='<td style="text-align: center" width="10%"><a href="javascript:;" style="" onclick="approval(1,'+data[i].transId+','+proId+')"><fmt:message code="meet.th.Approval" /></a> &nbsp;<a href="javascript:;" style="color: red" onclick="approval(2,'+data[i].transId+','+proId+')"><fmt:message code="meet.th.NotApprove" /></a></td>' ;

                            str+='</tr>';
                        }
                        $("#already tbody").html(str);
                        me.pageTwo(obj.totleNum, me.data.pageSize, me.data.page)

                        $('#checkedAll').on("click",function(){//全选
                            var inCh=$(this).parents('.clearfix').siblings('.main').find('.checkChild').prop('checked');
                            if(inCh == false){
                                $(this).parents('.clearfix').siblings('.main').find('.checkChild').prop('checked',true);
                            }else {
                                $('#checkedAll').prop('checked',false);
                                $(this).parents('.clearfix').siblings('.main').find('.checkChild').prop('checked',false);
                            }
                            var child = $(".checkChild");
                            for(var i=0;i<child.length;i++){
                                var childstate= $(child[i]).prop("checked");
                                if(inCh!=childstate){
                                    return
                                }
                            }
                            $('#checkedAll').prop("checked",inCh);
                        })
                    }
                });

            },
            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: indexs || 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();
    }

    //批准和不批准操作
    function approval(status,id,proId) {
        $.ajax({
            url: '/officetransHistory/upTransHistoryState',
            type: 'get',
            dataType: 'json',
            data: {
                transState:status,
                transId:id,
                proIds:proId
            },
            success: function (obj) {
                if(obj.flag){
                    layer.msg('<fmt:message code="vote.th.Approval"/>', { icon:6});
                    queryNoApprove();
                }else{
                    layer.msg('<fmt:message code="office.Approval.failed"/>', { icon:2});
                }
            }
        })
    }
    //一键批准
    $('.ONE').on("click",function(){
        if($('#already table input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:'请先选择一条数据进行批准',icon:3})
            return
        }
        var transIds=''
        var proIds=''
        $('#already table input[type="checkbox"]:checked').each(function () {
            var transId =$(this).parent().parent().attr('transId');
            var proId =$(this).parent().parent().attr('proId');
            if(transId!='undefined'){
                transIds += transId + ",";
                proIds += proId+",";
            }
        });
        $.ajax({
            url: '/officetransHistory/upTransHistoryState',
            type: 'get',
            dataType: 'json',
            data: {
                transState:1,
                transId:transIds,
                proIds:proIds
            },
            success: function (obj) {
                if(obj.flag){
                    layer.msg('<fmt:message code="office.approvals.successful"/>', { icon:6});
                    queryNoApprove();
                }else{
                    layer.msg('<fmt:message code="office.approvals.failed"/>', { icon:2});
                }
            }
        })

    })
    //一键不批准
    $('.TWO').on("click",function(){
        if($('#already table input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:'<fmt:message code="office.one.approval"/>',icon:3})
            return
        }
        var transIds=''
        var proIds=''

        $('#already table input[type="checkbox"]:checked').each(function () {
            var proId =$(this).parent().parent().attr('proId');
            var transId =$(this).parent().parent().attr('transId');
            if(transId!='undefined'){
                transIds += transId + ",";
                proIds += proId+",";
            }
        });
        $.ajax({
            url: '/officetransHistory/upTransHistoryState',
            type: 'get',
            dataType: 'json',
            data: {
                transState:2,
                transId:transIds,
                proIds:proIds
            },
            success: function (obj) {
                if(obj.flag){
                    layer.msg('<fmt:message code="office.not.approved"/>', { icon:6});
                    queryNoApprove();
                }else{
                    layer.msg('<fmt:message code="event.th.ApprovalFailure" />', { icon:2});
                }
            }
        })

    })
</script>
</body>
</html>
