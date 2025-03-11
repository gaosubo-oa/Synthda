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
    <title>已发短信查询</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style>
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 50px;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .color{
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 229px;
            height: 34px;
            line-height: 34px;
            padding-left: 10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 11pt;
        }
        table tbody td select{
            width: 119px;
            height: 28px;
            border-radius: 4px;
        }
        table tbody td input[type=text]{
            width: 288px;
            height: 32px;
            border-radius: 4px;
            /*padding-left: 10px;*/
            box-sizing: border-box;
            padding: 5px;
        }

        .btnsava2{
            padding:5px 15px;
            border-radius: 4px;
            color: #fff;
            border: 1px solid #ccc;
        }
        .pagediv .page-bottom-outer-layer table td{
            text-align: left;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #dddddd solid;
        }
        .editAndDelete2{
            color: red;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin-left: 20px;
        }
        .bar {
            height: 18px;
            background: green;
        }

        .queryUser{
            width: 600px;
            margin: 0 auto;
            margin-top: 30px;
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

    </style>
</head>
<body >
<div class="navigation">
</div>
<div class="queryUser">
    <form id="uploadForm" method="post" action="/sms2/sendMessageByExcel" enctype="multipart/form-data" >
        <table style="width: 100%;    border: 1px solid #c0c0c0;border-top: none;">
            <tbody>
            <tr class="borderNone">
                <td width="40%" class="color">收信人[内部用户]：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="70%">
                    <textarea   style="height: 60px;width: 260px;line-height: 17px;background-color: #dddcdd;" name="userId"  readonly id="userId" cols="30" rows="10"></textarea>
                    <a href="javascript:;" class="addroles">添加</a>
                    <a href="javascript:;" class="cleardate">清除</a>
                    <input type="hidden" name="userId">
                </td>
            </tr>

            <tr class="borderNone">
                <td width="40%" class="color">收信人[外部用户]：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="70%">
                    <textarea   style="height: 30px;width: 260px;line-height: 25px" id="outNumber" name="outNumber"  onkeyup="value=value.replace(/[^\d|^\n\r]/g,'');"    cols="30" rows="10"></textarea>
                </td>
            </tr>

            <tr class="borderNone">
                <td width="30%" class="color">短信内容：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="70%">
                    <textarea style="height: 90px;width: 260px;line-height: 17px" name="contextString"   id="contextString" cols="30" rows="10"></textarea>
                </td>
            </tr>

            <tr class="borderNone">
                <td width="30%" class="color">发送时间：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="70%">
                <div>
                    <input type="text" style="float: left; width: 32%;" id="begintime" name="begintime"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                    <span style="float: left;  width: 20px; padding: 6px 10px;text-align: center;color: #0A282F;">至</span>
                     <input type="text" style="float: left; width: 32%;" id="endtime" name="endtime"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" >
                </div>
                </td>
            </tr>

            <tr class="borderNone">
                <td colspan="4" style="text-align: center;padding: 15px">
                    <a href="javascript:;" id="sel_btn" style="margin-left: 10px; background-color: #0aa3e3" class="btnsava2 ">查询</a>
                </td>
            </tr>
            </tbody>
        </table>

    </form>
</div>

<div class="conditionQuery"  style="display: none;">
    <div class="title">
        <img src="/img/commonTheme/theme6/icon_personnelQuery.png" class="ChildTitleIcon" alt="短信接收管理查询" style="    margin-top: 12px;">
        <span>已发短信查询结果</span>
    </div>
    <div class="tab" >
        <table cellspacing="0" cellpadding="0" style="width:96%;height:100%;margin:0px 25px 0px 25px; border-collapse:collapse;"  class="tt">
            <thead>
            <tr class='Condition'>
                <th width="">收件人</th>
                <th width="">手机号</th>
                <th width="">短信内容</th>
                <th width="">发送时间</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>

        <div id="dbgz_page" class="M-box3 fr" style="float:right;margin-top:10px;margin-right: 20px;">
        </div>
        <div class="backBtn"><span id="back" style="margin-left: 30px;">返回</span></div>

    </div>
</div>


<script>


    $(function () {
        var arr = null;
        var data = null;
        $('.Statistics').css('display','block');
        $('#back').on('click',function () {
            $('.queryUser').css('display','block');
            $('.Statistics').css('display','block');
            $('.conditionQuery').css('display','none');
            location.reload();
        })

        // $.ajax({
        //     url: '/user/findUserByuserId',
        //     type:'get',
        //     dataType: 'json',
        //     data:{
        //         userId:$.cookie('userId')
        //
        //     },
        //     success: function (data) {
        //         arr=data.object;
        //
        //         $('#userId').val(decodeURI(arr.userName));
        //
        //     }
        // });

        //查询按钮点击事件
        $('#sel_btn').on('click',function(){
            $('.Statistics').css('display','none');
            var  phones = $("#outNumber").val()
            if(phones!='' && phones!=undefined){
                var re =  /^[1][3,4,5,7,8,9][0-9]{9}$/
                if(phones.length==11 && re.test(phones)){

                }else{
                    layer.msg("外部用户电话号码有错误！")
                    return
                }
            }

            data={
                'page':1,//当前处于第几页
                'pageSize':20,//一页显示几条
                'useFlag':true,
                'userIds':$('#userId').attr('user_id') || '',
                'contextString':$("#contextString").val(),
                'mobile':phones,
                'beginDate':$('input[name="begintime"]').val(),
                'endDate':$('input[name="endtime"]').val(),
            }
            queryAllSms2(data,$('.Condition'));
            $('.queryUser').css('display','none');
        })

        //查询所有人员
        function queryAllSms2(data,element){
            var loadIndex = layer.load(1)
            $(".center").hide();
            $(".conditionQuery").show();
            $.ajax({
                type:'get',
                url:'/sendMSms/selectMSms',
                dataType:'json',
                data:data,
                success:function(res){
                    layer.close(loadIndex);
                    var data1=res.obj;
                    var str='';
                    for(var i=0;i<data1.length;i++){
                        var userIds='';
                        var phone ='';
                        var content='';
                        var sendTime='';
                        if(data1[i].userIds!='') {
                            userIds = data1[i].userIds
                        }
                        if(data1[i].phone!=''){
                            phone=data1[i].phone
                        }
                        if(data1[i].recipientName!=''){
                            recipientName=data1[i].recipientName
                        }

                        if(data1[i].content!=''){
                            content=data1[i].content
                        }
                        if(data1[i].sendTime!=undefined){
                            sendTime=data1[i].sendTime
                        }else if(data1[i].sendTime==undefined){
                            sendTime="0000-00-00"
                        }else if(data1[i].sendTime==''){
                            sendTime="0000-00-00"
                        }

                        str += '<tr class="userData" smsId="'+data1[i].smsId+'">' +
                            '<td>' +recipientName+ '</td>' +
                            '<td>' + phone+ '</td>' +
                            '<td>' +content+ '</td>' +
                            '<td>' +sendTime+ '</td>' +
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

        $("#del_btn").on('click',function () {
            layer.confirm('确定要删除吗？', {
                btn: ['确定', '取消'], //按钮
                title: "删除信息"
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url: '/sms2/delSms2',
                    dataType: 'json',
                    data:{
                        phone:$('[id="phone"]').val(),
                        content:$('[id="content"]').val(),
                        sendTime:$('[id="sendTime"]').val(),
                        sendFlag:$('[id="sendFlag"]').val(),
                        sendNum:$('[id="sendNum"]').val()

                    },
                    success: function (data) {

                        if (data.flag) {

                            $.layerMsg({ content: '删除成功！', icon: 1 });

                        }else{
                            $.layerMsg({ content: '删除失败！', icon: 1 });
                        }
                    }
                });
            }, function() {
                layer.closeAll();
            });

        })

        $('.addroles').on('click',function () {
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
    })
</script>
</body>
</html>

