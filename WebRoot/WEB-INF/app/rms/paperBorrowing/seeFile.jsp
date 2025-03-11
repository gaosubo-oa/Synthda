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
    <title>查看文件</title>
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
        #j_tb tr:nth-child(even){
            background-color: #fff;
        }
        #j_tb tr:nth-child(odd){
            background-color: #f6f7f9;
        }

        #tr_td .th{
            font-size: 13pt;
            text-align: center;
        }
        #j_tb tr td {
            font-size: 11pt;
            text-align: center;
        }
        .buttonDiv{
            /*width: 100%;*/
            float: right;
        }
        .buttonDiv .backBtn{
            width: 99px;
            height: 28px;
            margin: 20px auto;
            background: url("../img/icon_backing.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
        .saveBtn_s{
            display: inline-block;
            background: url(../img/icon_query_2.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }
        .saveBtn_s span{
            margin-left: 31px;
        }
        .wrap>input[type="text"]{
            width: 200px;
            height: 30px;
        }
        .batchBorrow{
            width: 112px;
            height: 28px;
            margin: 0px auto;
            background: url(../../img/rms/btn_batchBorrow.png) no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
    </style>
</head>

<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="juMange" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueQuery.png">
            <div class="news">
                <span>文件查询</span>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="wrap" style="margin-left: 50px;">
            <span>文件标题：</span>
            <input type="text" name="fileTitle">
            <span style="margin-left: 20px;">发文单位：</span>
            <input type="text" name="sendUnit">
            <span style="margin-left: 20px;">发文时间：</span>
            <input type="text" name="sendDate" id="beginDate" style="width: 100px;">
            <span>至</span>
            <input type="text" name="sendDate2" id="endDate" style="width: 100px;">
            <div class="saveBtn_s"><span>查询</span></div>
        </div>
    </div>
    <div class="navigation  clearfix dataMange" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyuejilu.png">
            <div class="news">
                <span>查看文件</span>
            </div>
        </div>
        <div class="buttonDiv">
            <div class="backBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
        </div>
        <div style="clear: both;"></div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;">
            <table id="tr_td">
                <thead>
                <tr>
                    <td class="th">
                        <input type="checkbox" id="checkedAll">
                    </td>
                    <td class="th">
                        文件号
                    </td>
                    <td class="th">
                        文件标题
                    </td>
                    <td class="th">
                        密级
                    </td>
                    <td class="th">
                        发文单位
                    </td>
                    <td class="th">
                        发文时间
                    </td>
                    <td class="th">
                        紧急等级
                    </td>
                    <td class="th" style="width: 220px;">
                        <fmt:message code="notice.th.operation" />
                    </td>
                </tr>
                </thead>
                <tbody id="j_tb">

                </tbody>
            </table>
            <div class="right">
                <!-- 分页按钮-->
                <div class="M-box3" id="dbgz_page">
                </div>

            </div>

        </div>
    </div>
</div>
<script type="text/javascript">

    $(function () {
        var rollId=getQueryString('rollId');

        var dataId={
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            delStatus:'0',
            rollId:rollId
        };
        dataList(dataId,$('#j_tb'));

//      文件详情
        $('#j_tb').on('click','.to_detail',function () {
            var editId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+editId);
        });
//      点击全选
        $('#checkedAll').on('click',function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkedChild").prop("checked",true);
            }else{
                $(this).prop("checked",false);
                $(".checkedChild").prop("checked",false);
            }
        });
//      复选框
        $('#j_tb').on('click','.checkedChild',function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
            }else{
                $('#checkedAll').prop("checked",false);
                $(this).prop("checked",false);
            }
            var child =   $(".checkedChild");
            for(var i=0;i<child.length;i++){
                var childstate= $(child[i]).prop("checked");
                if(state!=childstate){
                    return
                }
            }
            $('#checkedAll').prop("checked",state);
        });
//        点击返回var parentElementId=
        $('.backBtn').on('click',function () {
            $('#iframeShow',parent.document).hide();
            $('#juMange',parent.document).show();
            $('#iframeShow',parent.document).find('#iframeThr').attr('src','');
        });
//        点击借阅
        $('#j_tb').on('click','.borrowData',function () {
            var fileId=$(this).parents('tr').attr('data-id');
            layer.confirm('确定要借阅该项文件吗？', {
                btn: [sure,cancel], //按钮
                title:'借阅文件'
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/RmsLendController/addRmsLend',
                    dataType:'json',
                    data:{
                        fileId:fileId,
                        allow:2
                    },
                    success:function(res){
                        if(res.flag){
                            layer.msg('借阅成功！', { icon:6});
                        }else{
                            layer.msg('借阅失败！', { icon:5});
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        });
//        点击批量借阅
        $('#j_tb').on('click','.batchBorrow',function () {
            var fileIds='';
            $(".checkedChild:checkbox:checked").each(function(){
                var conId=$(this).parents('tr').attr("data-id");
                fileIds+=conId+',';
            });
            layer.confirm('确定要借阅这些文件吗？', {
                btn: [sure,cancel], //按钮
                title:'批量借阅'
            }, function(){
                $.ajax({
                    type:'post',
                    url:'/RmsLendController/insertLensd',
                    dataType:'json',
                    data:{
                        fileIds:fileIds
                    },
                    success:function(res){
                        if(res.flag){
                            layer.msg('借阅成功！', { icon:6});
                        }else{
                            layer.msg('借阅失败！', { icon:5});
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        });
//        点击查询
        $('.saveBtn_s').on('click',function () {
            var data={
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                delStatus:'0',
                rollId:rollId,
                fileTitle:$('input[name="fileTitle"]').val(),
                sendUnit:$('input[name="sendUnit"]').val(),
                sendDate:$('input[name="sendDate"]').val(),
                sendDate2:$('input[name="sendDate2"]').val()
            }
            dataList(data,$('#j_tb'));
        })

    })

    function dataList(dataId,element) {
        var ajaxPage={
            data:dataId,
            page:function () {
                element.find('tr').remove();
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/rmsFile/query',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        if(datas.length > 0){
                            for(var i=0;i<datas.length;i++){
                                var secretName='';
                                if(datas[i].secret == '1'){
                                    secretName='<fmt:message code="dem.th.PuDense" />';
                                }else if(datas[i].secret == '2'){
                                    secretName='<fmt:message code="doc.th.Top-secret" />';
                                }else if(datas[i].secret == '3'){
                                    secretName='<fmt:message code="dem.th.Confidential" />';
                                }else if(datas[i].secret == '4'){
                                    secretName='<fmt:message code="dem.th.Secret" />';
                                }
                                if(datas[i].urgency == '1'){
                                    datas[i].urgency='<fmt:message code="hr.th.EmployeeType" />';
                                }else{
                                    datas[i].urgency='<fmt:message code="dem.th.GeneralLevel" />';
                                }
                                str+='<tr data-id="'+datas[i].fileId+'" data-status="'+datas[i].status+'">' +
                                    '<td><input type="checkbox" name="check" class="checkedChild" value=""></td>' +
                                    '<td>'+datas[i].fileCode+'</td>' +
                                    '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].fileTitle+'</td>' +
                                    '<td>'+secretName+'</td>' +
                                    '<td>'+datas[i].sendUnit+'</td>' +
                                    '<td>'+function(){
                                        if(datas[i].sendDate != undefined){
                                            return datas[i].sendDate;
                                        }else{
                                            return '';
                                        }
                                    }()+'</td>' +
                                    '<td>'+datas[i].urgency+'</td>' +
                                    '<td><a href="javascript:;" class="borrowData" style="">借阅</a></td>' +
                                    '</tr>'
                            }
                            str=str+'<tr>' +
                                '<td colspan="8"><div class="batchBorrow"><span style="margin-left: 10px;">批量借阅</span></div></td>' +
                                '</tr>'
                        }else{
                            str='<tr>' +
                                '<td colspan="8"><img src="/img/rms/shouyekong.png" alt=""><p>暂无数据</p></td>' +
                                '</tr>'
                        }


                        element.append(str);
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

    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }
    var start = {
        elem: '#beginDate',
        format: 'YYYY-MM-DD',
//        min: laydate.now(), //设定最小日期为当前日期
//        max: '2099-06-16 23:59:59', //最大日期
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endDate',
        format: 'YYYY-MM-DD',
//        min: laydate.now(),
//        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
</script>
</body>
</html>
