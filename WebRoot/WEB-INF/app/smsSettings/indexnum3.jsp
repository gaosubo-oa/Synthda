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
    <title><fmt:message code="lang.th.deleSgfh" /></title>
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
    <script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .delete_check{
            display: inline-block;
            width: 50px;
            height: 24px;
            line-height: 30px;
            background: url(../../img/btn_deleteannounce.png) no-repeat;
            font-size: 14px;
            cursor: pointer;
            margin: 0 20px;
        }

        table input{
            line-height: 0 ;
        }
        table input{
            line-height: 0 ;
        }
        table.table tr td {
            border-right: 0;
            border: 1px solid #dddcdd;
        }
        .content{
            background-color: #fff;
        }
        .blue_text {
            width: 100px;
        }
        /*input{*/
        /*    margin: 0 0px 0 37px;*/
        /*}*/
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
            border-radius: 4px;
        }
        table.table tr td input[type="text"]{
            width: 250px;
            height: 22px;
            border: none;
            outline: none;
            border: #ccc 1px solid;
            /*margin-left: 30px;*/
            /*padding-left: 3px;*/
        }
        .content .right{
            float: left;
            width: 100%;
            font-size: 14px;
            overflow-y: auto;
            height: 100%;
        }
        .tab table {
            width: 94%;
            font-size: 14px;
            margin: 0px auto;
        }
        .tab table .M-box3 a{
            text-align: center;
        }
        .tab table .M-box,.tab table .M-box1,.tab table .M-box2,.tab table .M-box3,.tab table .M-box4{
            position: relative;
            text-align: center;
            zoom: 1;
        }
        .M-box3 .active{
            float: left;
            margin:0 5px;
            width: 30px;
            height: 30px;
            line-height: 30px;
            background: #fff;
            border: 1px solid #ebebeb;
            font-size: 12px;
            color: #fff!important;
            background: #2b7fe0!important;
        }
        .M-box3 a {
            float: left;
            margin:0 5px;
            width: 30px;
            height: 30px;
            line-height: 30px;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            font-size: 12px;
        }
        .M-box3 .active{
            float: left;
            margin:0 5px;
            width: 30px;
            height: 30px;
            line-height: 30px;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            font-size: 12px;
            color: #fff;
            background: #2b7fe0!important;
        }
        .M-box3 a:hover {
            color: #fff;
            background: #2b7fe0!important;
        }
        .tab table tr:nth-child(odd){
            background-color: #fff;
        }
        .tab table tr:nth-child(even){
            background-color: #F6F7F9;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right">
        <div class="queryUser" style="display: block;width:52%">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="<fmt:message code="main.th.Sendgl" />" style="    margin-top: 12px;">
                <span>已发短信管理</span>
            </div>
            <table class="table" cellspacing="0" cellpadding="0" style="width:540px; border-collapse:collapse;background-color: #fff;margin-left: 300px" >
                <tbody >
                <tr >
                    <td  width="30%" class="blue_text">发信人：</td>
                    <td  width="70%">
                        <textarea   style="height: 60px;  margin-left: 30px;width: 254px;line-height: 17px" name=""    readonly id="fromId" cols="30" rows="10"></textarea>
                        <a href="javascript:;"  class="addroles">添加</a>
                        <a href="javascript:;" class="cleardate">清除</a>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text">收件人手机号：</td>
                    <td class="right_td">
                        <input  style="margin-left: 30px;" type="text" name="phone" id="phone"  onkeyup="value=value.replace(/[^\d|^\n\r]/g,'');"   class="inputTd"/>
                    </td>
                </tr>

                <tr>
                    <td class="blue_text">短信内容:</td>
                    <td class="right_td">
                        <textarea style="height: 90px;margin-left: 30px;width: 254px;line-height: 17px" name="content"   id="content" cols="30" rows="10"></textarea>
                    </td>
                </tr>

                <tr>
                    <td width="30%" class="div-left">发送时间：</td>
                    <td width="70%" class="right_td">
                        <div >
                            <input type="text" style="float: left; width: 26%;  margin-left: 30px" id="begintime1" name="begintime1" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                            <span style="float: left;  width: 20px; padding: 4px 10px;text-align: center;color: #0A282F;">至</span>
                            <input type="text" style="float: left; width: 26%;" id="endtime" name="endtime"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <div class="btn" style="width:240px;height: 30px;">
                            <input id="sel_btn" type="button" style="margin: 0 20px"  class="backQueryBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.query" />"/>
                            <input id="del_btn" type="button" style="margin: 0 20px" class="backQueryBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.delete" />">
                        </div>

                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="conditionQuery" style="display: none;">
            <div class="title" style="width: 300px;margin: 10px;">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="<fmt:message code="global.lang.del" />" style="    margin-top: 12px;">
                <span>已发短信查询结果</span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" id="smsSent" style="border-collapse:collapse;" class="tt">
                    <thead>
                    <tr class='Condition' style="background-color: #f0f1f3">
                        <th width="">选择</th>
                        <th width="">发信人</th>
                        <th width="">收信人</th>
                        <th width="">收信人手机号</th>
                        <th width="">短信内容</th>
                        <th width="">发送时间</th>
                        <th width="">操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <table cellspacing="0" cellpadding="0"  style="border-collapse:collapse;" class="tt">
                    <thead>
                    <tr style="border-top: none;background-color: #f0f1f3">
                        <th width=""> <input style="" type="checkbox" class="checkbox  allcheckbox" ischecked="false"></th>
                        <th width=""><button type="button" class="bigButton  import"   id="delall"  style="width: 80px;height: 35px;color:#23477e" value="<fmt:message code="workflow.th.Stati" />" >批量删除</button></th>
                        <th width="" colspan="5"><div id="dbgz_page" class="M-box3 fr" style="float:right;margin-top:10px;">

                        </div></th>
                    </tr>
                    </thead>
                </table>
                <div class="backBtn"><span id="back" style="margin-left: 30px;"><fmt:message code="notice.th.return" /></span></div>

            </div>
        </div>

        <div class="Statistics" style="display: block;width:52%">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_inservicsPersonnel.png" class="ChildTitleIcon" alt="<fmt:message code="userInfor.th.UserQuery" />">
                <span>已发短信统计</span>
            </div>
            <table class="table" cellspacing="0" cellpadding="0" style="width:540px; border-collapse:collapse;background-color: #fff;margin-left: 300px">
                <tr>
                    <td  width="30%" class="blue_text">发送时间:</td>
                    <td width="70%" class="right_td" style="  padding: 10px;">
                        <div >
                            <input type="text" style="float: left; width: 26%;  margin-left: 30px" id="begintime2" name="begintime2"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                            <span style="float: left;  width: 20px; padding: 4px 10px;text-align: center;color: #0A282F;">至</span>
                            <input type="text" style="float: left; width: 26%;" id="endtime2" name="endtime2"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="blue_text">统计方式</td>
                    <td class="right_td" style="  padding: 10px;">

                        <label><input style="float: none; width:15px;height: 15px;vertical-align: bottom;margin-left: 60px" name="stat" type="radio" value="1"  checked><span>按人员统计</span>
                            <input name="stat" style="float: none; width:15px;height: 15px;vertical-align: bottom;margin-left: 30px" name="stat" type="radio"  value="2"  ><span>按部门统计</span>
                        </label>

                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;padding: 10px;">
                        <div class="btn">
                            <button type="button" class="bigButton  import" value="<fmt:message code="workflow.th.Stati" />" id="sta_btn" >查看统计</button>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="statisticsQuery" style="display: none;">
            <div class="title" style="width: 350px;margin: 10px;">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="<fmt:message code="global.lang.del" />" style="    margin-top: 12px;">
                <span class="title1" style="display: none;" >已发短信统计结果（按人员）</span>
                <span class="title2" style="display: none;">已发短信统计结果（按部门）</span>
            </div>
            <div class="tab" >
                <div id="personnelBox" style="display: none;">
                    <table cellspacing="0" cellpadding="0" id="personnel" style="border-collapse:collapse;" class="tt1">
                        <thead>
                        <tr class='Condition1'>
                            <th width="">发信人姓名</th>
                            <th width="">发信人部门</th>
                            <th width="">发送短信数量</th>
                            <th width="">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>


                <div id="departmentBox" style="display: none;">
                    <table cellspacing="0" cellpadding="0" id="department" style="border-collapse:collapse;" class="tt2">
                        <thead>
                        <tr class='Condition2'>
                            <th width="">部门名称</th>
                            <th width="">发送短信数量</th>
                            <th width="">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div id="dbgz_page3"  class="M-box3 fr" style="float:right;margin-top:10px;margin-right: 20px;">

                </div>

                <div class="backBtn"><span id="back3" style="margin-left: 30px;"><fmt:message code="notice.th.return" /></span></div>

            </div>
        </div>

    </div>
</div>
<script>

    $(function () {
        var arr = null;
        var data = null;
        var newbegintime;
        var newendtime;
        var way;
        /*console.log(decodeURI($.cookie('userName')))*/
        $('.Statistics').css('display','block');
        $('#back').on('click',function () {
            $('.queryUser').css('display','block');
            $('.Statistics').css('display','block');
            $('.conditionQuery').css('display','none');
            location.reload();
        })
        $('#back3').on('click',function () {
            $('.queryUser').css('display','block');
            $('.Statistics').css('display','block');
            $('.conditionQuery').css('display','none');
            location.reload();
        })
        $.ajax({
            url: '/user/findUserByuserId',
            type:'get',
            dataType: 'json',
            data:{
                userId:$.cookie('userId')
            },
            success: function (data) {
                arr=data.object;
                // $('#fromId').val(decodeURI(arr.userName));//获取当前用户
            }
        });
        //查询按钮点击事件
        $('#sel_btn').click(function(){
            var  phones = $("#phone").val()
            if(phones!='' && phones!=undefined){
                var re =  /^[1][3,4,5,7,8,9][0-9]{9}$/
                if(phones.length==11 && re.test(phones)){
                }else{
                    layer.msg("收件人手机号码有误，请重填！")
                    return
                }
            }

            $('.Statistics').css('display','none');
            data={
                'page':1,//当前处于第几页
                'pageSize':50,//一页显示几条
                'useFlag':true,
                'fromIds':$('#fromId').attr('user_id') || '',
                'phone':$('input[name="phone"]').val(),
                'content':$('#content').val(),
                'beginDate':$('input[name="begintime1"]').val(),
                'endDate':$('input[name="endtime"]').val()
            }
            queryAllSms2(data,$('.Condition'));
            $('.queryUser').css('display','none');
        })

        //查询所有人员
        function queryAllSms2(data,element){
            var loadIndex = layer.load(1)
            $(".center").css('display','none');
            $(".conditionQuery").css('display','');
            $.ajax({
                type:'get',
                url:'/sms2/selectSms2',
                dataType:'json',
                data:data,
                success:function(res){
                    layer.close(loadIndex);
                    var data1=res.obj;
                    var str='';
                    for(var i=0;i<data1.length;i++){
                        /* var fromId=$('#fromId').val(decodeURI(arr.userName));*/
                        var fromName =''
                        var recipientName = '';
                        var phone='';
                        var content='';
                        var sendTime='';
                        var recipientName = '';
                        if(data1[i].fromName!='') {
                            fromName = data1[i].fromName
                        }
                        if(data1[i].recipientName!='') {
                            recipientName = data1[i].recipientName
                        }
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
                        str += '<tr class="userData" smsId="'+data1[i].smsId+'">' +
                            '<td><input type="checkbox" name="checkbox" class="checkbox  kx" ischecked="false"></td>' +
                            '<td>' +fromName+ '</td>' +
                            '<td>' + recipientName+ '</td>' +
                            '<td>' + phone+ '</td>' +
                            '<td>' + content+ '</td>' +
                            '<td>' +sendTime+ '</td>' +
                            '<td>'+'<a href="javascript:void (0)" class="del_btn1" smsId="'+data1[i].smsId+'"><fmt:message code="global.lang.delete" /></a></td>'+
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
                // homePage:'',
                // endPage: '',
                homePage: '首页',
                endPage: '末页',
                prevContent: '上一页',
                nextContent: '下一页',
                current:indexs||1,
                callback: function (index) {
                    data.page=index.getCurrent();
                    queryAllSms2(data,$('.Condition'));
                }
            });
        }

        //查看统计按钮点击事件
        $('#sta_btn').click(function(){
            $('.Statistics').css('display','none');//已发短信统计
            $('.statisticsQuery').css('display','block');//短信统计结果
            $('.queryUser').css('display','none');//已发短信管理
             way=$('input:radio[name="stat"]:checked').val();
            if(way == "1"){
                $('#personnelBox').css('display','block');
                $('.title1').css('display','block');
            }else if(way == "2"){
                $('#departmentBox').css('display','block');
                $('.title2').css('display','block');
            }
            data={
                'page':1,//当前处于第几页
                'pageSize':50,//一页显示几条50
                'useFlag':true,
                'way':way,
                'beginDate':$('input[name="begintime2"]').val(),
                'endDate':$('input[name="endtime2"]').val()
            }
            if(way == "1"){
                queryAllSms3(data,$('.Condition1'),way);
            }else if(way == "2"){
                queryAllSms3(data,$('.Condition2'),way);
            }
        })

        //已发短信统计结果(按人员，按部门两种情况)
        function queryAllSms3(data,element,way){
            var loadIndex = layer.load(1)
            $.ajax({
                type:'get',
                url:'/sms2/sendSmsByUserOrDept',
                dataType:'json',
                data:data,
                success:function(res){
                    layer.close(loadIndex);
                    var data1=res.obj;
                    if(res.object.beginDate !='' &&  res.object.beginDate !=undefined){
                         newbegintime = res.object.beginDate;
                    }else{
                         newbegintime =''
                    }
                    if(res.object.endDate !='' && res.object.endDate !=undefined){
                         newendtime =res.object.endDate;
                    }else{
                         newendtime =''
                    }
                    var str1='';
                    var str2='';
                    if(way == '1'){
                        for(var i=0;i<data1.length;i++){
                            var fromName='';
                            var deptName='';
                            var count = '';
                            if(data1[i].fromName!='') {
                                fromName = data1[i].fromName
                            }
                            if(data1[i].deptName!='') {
                                deptName = data1[i].deptName
                            }
                            if(data1[i].count!=undefined){
                                count=data1[i].count
                            }
                            str1 += '<tr class="userData" fromId="'+data1[i].fromId+'">' +
                                '<td>' + fromName+ '</td>' +
                                '<td>' + deptName+ '</td>' +
                                '<td>' +count+ '</td>' +
                                '<td>'+'<a href="javascript:void (0)" class="del_btn2" fromId="'+data1[i].fromId+'"><fmt:message code="global.lang.delete" /></a></td>'+
                                '</tr>';
                        }
                        var a=element.parents('.tt1').find('tbody').html(str1);
                        pageTwo2(res.totleNum,data.pageSize,data.page,way)
                    }
                    if(way == '2'){
                        for(var i=0;i<data1.length;i++){
                            var deptName='';
                            var count = '';
                            if(data1[i].deptName!='') {
                                deptName = data1[i].deptName
                            }
                            if(data1[i].count!=undefined){
                                count=data1[i].count
                            }
                            str2 += '<tr class="userData" deptId="'+data1[i].deptId+'">' +
                                '<td>' + deptName+ '</td>' +
                                '<td>' +count+ '</td>' +
                                '<td>'+'<a href="javascript:void (0)" class="del_btn3" deptId="'+data1[i].deptId+'"><fmt:message code="global.lang.delete" /></a></td>'+
                                '</tr>';
                        }
                        var a=element.parents('.tt2').find('tbody').html(str2);
                        pageTwo2(res.totleNum,data.pageSize,data.page,way)
                    }

                }
            })
        }
        function pageTwo2(totalData, pageSize,indexs,way) {
            if(way=='1'){
                $('#dbgz_page3').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    // homePage:'',
                    // endPage: '',
                    homePage: '首页',
                    endPage: '末页',
                    prevContent: '上一页',
                    nextContent: '下一页',
                    current:indexs||1,
                    callback: function (index) {
                        data.page=index.getCurrent();
                        queryAllSms3(data,$('.Condition1'),way);
                    }
                });
            }
            if(way=='2'){
                $('#dbgz_page3').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    // homePage:'',
                    // endPage: '',
                    homePage: '首页',
                    endPage: '末页',
                    prevContent: '上一页',
                    nextContent: '下一页',
                    current:indexs||1,
                    callback: function (index) {
                        data.page=index.getCurrent();
                        queryAllSms3(data,$('.Condition2'),way);
                    }
                });
            }

        }

        //已发短信查询结果,表格行内删除
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
                    url: '/sms2/delSms2',
                    dataType: 'json',
                    data:{
                        smsIds:delId
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

        //已发短信查询结果,批量删除
        $(document).on('click','#delall',function () {
            var  smsIds =''
            var lengthn = $('.kx[name=checkbox]:checked').length;
            if (lengthn < 0 || lengthn == 0) {
                layer.msg("请至少选择一条记录！");
                return false;
            }else{
                for (var i = 0; i < lengthn; i++) {
                    var $this = $('.kx[name=checkbox]:checked').eq(i);
                     smsIds += $this.parents('tr').attr('smsid')+',';
                }
                layer.confirm('<fmt:message code="attend.th.qued" />？', {
                    btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                    title: "<fmt:message code="event.th.DeleteInformation" />"
                }, function() {
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url: '/sms2/delSms2',
                        dataType: 'json',
                        data:{
                            smsIds:smsIds
                        },
                        success: function (data) {
                            if (data.flag) {
                                $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                                datas={
                                    'page':1,//当前处于第几页
                                    'pageSize':50,//一页显示几条
                                    'useFlag':true,
                                    'fromIds':$('#fromId').attr('user_id') || '',
                                    'phone':$('input[name="phone"]').val(),
                                    'content':$('#content').val(),
                                    'beginDate':$('input[name="begintime1"]').val(),
                                    'endDate':$('input[name="endtime"]').val()
                                }
                                queryAllSms2(datas,$('.Condition'));
                            }else{
                                $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                            }
                        }
                    });
                })
            }
        })

        $("#del_btn").click(function () {
            var fromIdn = $('#fromId').val()
            var phonen =$('input[name="phone"]').val()
            var contentn =$('#content').val()
            var begintimen =$('input[name="begintime1"]').val()
            var endtimen =$('input[name="endtime"]').val()
            if(fromIdn == '' && phonen == '' && contentn == ''&& begintimen == ''&& endtimen == ''){
                layer.msg("请填写要删除数据的相关内容！")
                return
            }
            layer.confirm('<fmt:message code="attend.th.qued" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="event.th.DeleteInformation" />"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms2/delSms2',
                    dataType: 'json',
                    data:{
                        fromIds:$('#fromId').attr('user_id') || '',
                        phone:$('input[name="phone"]').val(),
                        content:$('#content').val(),
                        beginDate:$('input[name="begintime1"]').val(),
                        endDate:$('input[name="endtime"]').val()
                    },
                    success: function (data) {
                        if (data.flag) {
                            $.layerMsg({ content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1 });
                            $('#fromId').val('');
                            $('input[name="phone"]').val('');
                            $('#content').val('');
                            $('input[name="begintime1"]').val('');
                            $('input[name="endtime"]').val('');
                        }else{
                            $.layerMsg({ content: '<fmt:message code="lang.th.deleSucess" />！', icon: 1 });
                        }
                    }
                });
            }, function() {
                layer.closeAll();
            });
        })





        //已发短信统计结果（按人员）行内删除
        $("tbody").on('click','.del_btn2',function () {
            var that = $(this);
            var fromId=$(this).attr('fromId')
            layer.confirm('<fmt:message code="attend.th.qued" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="event.th.DeleteInformation" />"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms2/delSmsByUserOrDept',
                    dataType: 'json',
                    data:{
                        fromId:fromId,
                        beginDate:newbegintime,
                        endDate:newendtime
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



        //已发短信统计结果（按部门）行内删除
        $("tbody").on('click','.del_btn3',function () {
            var that = $(this);
            var deptId=$(this).attr('deptId')

            layer.confirm('<fmt:message code="attend.th.qued" />？', {
                btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
                title: "<fmt:message code="event.th.DeleteInformation" />"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms2/delSmsByUserOrDept',
                    dataType: 'json',
                    data:{
                        deptId:deptId,
                        beginDate:newbegintime,
                        endDate:newendtime
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




        $('.addroles').click(function () {
            user_id = $(this).siblings('textarea').prop('id');
            $.popWindow("../common/selectUser");
        })
        $(document).on('click','.cleardate',function () {
            $(this).siblings('textarea').val('');
            $(this).siblings('textarea').attr('user_id','');
            $(this).siblings('textarea').attr('deptid','');
            $(this).siblings('textarea').attr('deptname','');
            $(this).siblings('textarea').attr('privid','');
            $(this).siblings('textarea').attr('userpriv','');
            $(this).siblings('textarea').attr('username','');
            $(this).siblings('textarea').attr('dataid','');
            $(this).siblings('textarea').attr('userprivname','');
        })
        //全选
        $(document).on('click', '.allcheckbox', function () {
            var ischecked = $(this).attr('ischecked');
            if (ischecked == 'true') {
                $('.kx').prop("checked", "");
                $(this).attr('ischecked', false);
            } else {
                $('.kx').prop("checked", "checked");
                $(this).attr('ischecked', true);
            }
        })
    })
</script>
</body>
</html>

