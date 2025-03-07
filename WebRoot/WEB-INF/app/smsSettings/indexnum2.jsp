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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="dem.th.SMSReceivingManagement"/></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>

        table input{
            line-height: 0 ;
        }
        table.table tr td {
            border-right: 0;
        }
        .content{
            background-color: #fff;
        }
        input{
            margin: 0 0px 0 37px;
        }
        .btn{
            width: 66%;
            margin: 0 auto;
        }
        .backQueryBtn1{
            background:url("../img/btn_deletecontent_03.png") no-repeat -4px -2px;
            float: left;
            width: 70px;
            height: 28px;
            line-height: 28px;
            cursor: pointer;
            background-color: #CCCCCC;
        }
        .blue_text{
            width:40%;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="queryUser" style="display: block;">
        <div class="title">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="短信接收管理" style="margin-top: 12px;">
            <span><fmt:message code="dem.th.SMSReceivingManagement"/></span>
        </div>
        <table class="table"  cellspacing="0" cellpadding="0" style="width:500px; border-collapse:collapse;background-color: #fff">
            <tbody >
            <tr>
                <td class="blue_text">发送人手机号码</td>
                <td>
                    <input type="text" name="phone" id="phone" class="inputTd"/>
                </td>
            </tr>
            <tr>
                <td class="blue_text">短信内容</td>
                <td>
                    <input type="text" name="content" id="content" class="inputTd"/>
                </td>
            </tr>
            <tr>
                <td class="blue_text"><fmt:message code="sup.th.SendingTime"/></td>
                <td>
                    <input type="text" id="sendTime" name="sendTime"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                    <%--<input type="text" id="sendTime" name="sendTime"  >--%>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <div class="btn">
                        <input id="submit" type="button" class="backQueryBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.query" />"/>
                        <input id="del_btn" type="button" class="backQueryBtn1" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="menuSSetting.th.deleteMenu"/>">
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="conditionQuery" style="display: none;">
        <div class="title">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="短信接收管理查询" style="    margin-top: 12px;">
            <span></span>
        </div>
        <div class="tab">
            <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;"  class="tt">
                <thead>
                <tr class='Condition'>
                    <th width=""></th>
                    <th width=""></th>
                    <th width=""><fmt:message code="sup.th.SendingTime"/></th>
                    <th width=""><fmt:message code="notice.th.operation"/></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="dbgz_page" class="M-box3 fr clearfix" style="float:right;margin-top:10px;">

            </div>
            <div class="backBtn"><span id="back" style=" margin-left:30px;"><fmt:message code="notice.th.return" /></span></div>
        </div>
    </div>


</div>
<script>
    $(function () {
        var data = null;
        $('#back').on('click',function () {
            $('.queryUser').css('display','block');
            $('.conditionQuery').css('display','none');
            location.reload();
        })
        //查询按钮点击事件
        $('#submit').click(function(){
            data={
                'page':1,//当前处于第几页
                'pageSize':15,//一页显示几条
                'useFlag':true,
                'phone':$('input[name="phone"]').val(),
                'content':$('input[name="content"]').val(),
                'sendTime':$('input[name="sendTime"]').val()
            }
            queryAllSms3(data,$('.Condition'));
            $('.queryUser').css('display','none');
        })

//查询所有人员
        function queryAllSms3(data,element){
            $(".center").hide();
            $(".conditionQuery").show();
            $.ajax({
                type:'get',
                url:'/sms3/selectSms3',
                dataType:'json',
                data:data,
                success:function(res){
                    var data1=res.obj;
                    var str='';
                    for(var i=0;i<data1.length;i++){
                        var phone='';
                        var content='';
                        var sendTime='';

                        if(data1[i].phone!='') {
                            phone = data1[i].phone
                        }
                        if(data1[i].content!=''){
                            content=data1[i].content
                        }
                        if(data1[i].sendTime!=undefined){
                            sendTime=data1[i].sendTime
                        }else if(data1[i].sendTime==undefined){
                            sendTime="0000-00-00 00:00:00"
                        }else if(data1[i].sendTime==''){
                            sendTime="0000-00-00 00:00:00"
                        }

                        str += '<tr class="userData" uId="' + data1[i].smsId + '">' +

                            '<td>' + phone+ '</td>' +
                            '<td>' + content+ '</td>' +
                            '<td>' +sendTime+ '</td>' +
                            '<td>'+'<a href="javascript:void (0)" class="del_btn1" smsId="'+data1[i].smsId+'"><fmt:message code="menuSSetting.th.deleteMenu"/></a></td>'+
                            '</tr>';
                    }
                    var a=element.parents('.tt').find('tbody').html(str);
                    pageTwo(res.totleNum,data.pageSize,data.page)
                }
            })
        }

        function pageTwo(totalData, pageSize,indexs) {
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    data.page=index.getCurrent();
                    queryAllSms3(data,$('.Condition'));
                }
            });
        }

        $("tbody").on('click','.del_btn1',function () {
            var delId=$(this).attr('smsid')
            var that = $(this);
            layer.confirm('<fmt:message code="attend.th.qued" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="event.th.DeleteInformation" />"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms3/delSms3',
                    dataType: 'json',
                    data:{
                        smsId:delId
                    },
                    success: function (data) {

                        if (data.flag) {

                            $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                            that.parents('tr').remove()
                        }else{
                            $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                        }
                    }
                });
            }, function() {
                layer.closeAll();
            });
        })

        $("#del_btn").click(function () {
            layer.confirm('<fmt:message code="attend.th.qued" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="event.th.DeleteInformation" />"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms3/delSms3',
                    dataType: 'json',
                    data:{
                        'phone':$('input[name="phone"]').val(),
                        'content':$('input[name="content"]').val(),
                        'sendTime':$('input[name="sendTime"]').val()
                    },
                    success: function (data) {

                        if (data.flag) {

                            $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });

                        }else{
                            $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                        }
                    }
                });
            }, function() {
                layer.closeAll();
            });

        })
    })

</script>
</body>
</html>

