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
    <title>借阅查询</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
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
        a {
            text-decoration: none;
            color: #207bd6;
        }
        .buttonDiv{
            width: 100%;
        }
        .buttonDiv .deleteBtn{
            width: 99px;
            height: 28px;
            margin: 20px auto;
            background: url("../img/icon_backing.png") no-repeat;
            line-height: 28px;
            cursor: pointer;
        }
        #selectq{
            margin-left: 10px;
            width: 120px;
            outline: none;
            border-radius:4px;
        }
        .juMange input[type="text"],.editMange input[type="text"]{
            width: 260px;
            height: 30px;
            float: none;
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
        .newTbale{
            width: 60%;
            margin: 0px auto;
            margin-top: 20px;
        }
        .newTbale tr td{
            border-right: #ccc 1px solid;
            padding: 5px;
        }
        .buttonDiv{
            width: 100%;
            margin-top: 20px;
        }
        .divBtn{
            width: 170px;
            margin: 0 auto;
            height: 30px;
        }
        .saveBtn_s,.saveBtn{
            display: block;
            float: left;
            background: url(../img/icon_query_2.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }
        .resetBtn_s,.resetBtn{
            display: block;
            float: left;
            background: url(../img/news/new_filling.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor:pointer;
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
    <div class="navigation  clearfix juMange" style="display: block;">
        <div class="left" style="margin-left: 30px;width: 40%">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueQuery.png" style="margin-top: 20px">
            <div class="news">
                借阅查询
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;">
            <table class="newTbale">
                <tr>
                    <td>卷库名称：</td>
                    <td>
                        <input type="text" name="roomName">
                    </td>
                    <td><fmt:message code="dem.th.FileName" />：</td>
                    <td>
                        <input type="text" name="rollName">
                    </td>
                </tr>
                <tr>
                    <td>文件号：</td>
                    <td>
                        <input type="text" name="fileCode">
                    </td>
                    <td>文件主题词：</td>
                    <td><input type="text" name="fileSubject"></td>
                </tr>
                <tr>
                    <td>文件标题：</td>
                    <td><input type="text" name="fileTitle"></td>
                    <td>文件辅标题：</td>
                    <td><input type="text" name="fileTitle0"></td>
                </tr>
                <tr>
                    <td>发文单位：</td>
                    <td><input type="text" name="sendUnit"></td>
                    <td>备注：</td>
                    <td>
                        <input type="text" name="remark">
                    </td>
                </tr>
            </table>
            <div class="buttonDiv">
                <div class="divBtn">
                    <div class="saveBtn_s"><span style="margin-left: 32px;"><fmt:message code="global.lang.query" /></span></div>
                    <div class="resetBtn_s"><span style="margin-left: 32px;"><fmt:message code="workflow.th.Reset" /></span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="navigation  clearfix dataMange" style="display: none;">
        <div class="left" style="margin-left: 30px">
            <img style="margin-top: 20px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_jieyueQuery.png">
            <div class="news" style="margin-left: 32px;">
                <span>查询结果</span>
            </div>
        </div>
        <div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 60px;">
            <table id="tr_td">
                <thead>
                <tr>
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
            <div class="buttonDiv">
                <div class="deleteBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var juankuName,anjuanName,wenjianNum,wenjianMain,wenjianTitle,wenjianFuTitle,fawenUnit,remakCont;
    $(function(){
        $('.saveBtn_s').on('click',function () {
            $('.juMange').hide();
            $('.dataMange').show();
            juankuName=$('input[name="roomName"]').val();
            anjuanName=$('input[name="rollName"]').val();
            wenjianNum=$('input[name="fileCode"]').val();
            wenjianMain=$('input[name="fileSubject"]').val();
            wenjianTitle=$('input[name="fileTitle"]').val();
            wenjianFuTitle=$('input[name="fileTitle0"]').val();
            fawenUnit=$('input[name="sendUnit"]').val();
            remakCont=$('input[name="remark"]').val();
            var data={
                page:1,
                pageSize:10,
                roomName:juankuName,
                rollName:anjuanName,
                fileCode:wenjianNum,
                fileSubject: wenjianMain,
                fileTitle:wenjianTitle,
                fileTitle0:wenjianFuTitle,
                sendUnit:fawenUnit,
                remark:remakCont
            }
            queryData(data,$('#j_tb'));
        })

//	    重置
        $('.resetBtn_s').on('click',function(){
            $('input[name="roomName"]').val('');
            $('input[name="rollName"]').val('');
            $('input[name="fileCode"]').val('');
            $('input[name="fileSubject"]').val('');
            $('input[name="fileTitle"]').val('');
            $('input[name="fileTitle0"]').val('');
            $('input[name="sendUnit"]').val('');
            $('input[name="remark"]').val('');
        })
//		返回
        $('.deleteBtn').on('click',function(){
            $('.juMange').show();
            $('.dataMange').hide();
        })
//      文件详情
        $('#j_tb').on('click','.to_detail',function () {
            var editId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+editId);
        });
//        点击借阅
        $('#j_tb').on('click','.borrowBtn',function () {
            var fileId=$(this).parents('tr').attr('data-id');
            layer.confirm('确定要借阅该项文件吗？', {
                btn: ['确定','取消'], //按钮
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
    })

    function queryData(object,element) {
        var ajaxPage={
            data:object,
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/RmsLendController/selAllLendBy',
                    dataType:'json',
                    data:me.data,
                    success:function(res) {
                        var datas=res.obj;
                        var str='';
                        if(datas.length > 0){
                            for(var i=0;i<datas.length;i++){
                                var secretName='';
                                if(datas[i].sECRET == '1'){
                                    secretName='<fmt:message code="dem.th.PuDense" />';
                                }else if(datas[i].sECRET == '2'){
                                    secretName='<fmt:message code="doc.th.Top-secret" />';
                                }else if(datas[i].sECRET == '3'){
                                    secretName='<fmt:message code="dem.th.Confidential" />';
                                }else if(datas[i].sECRET == '4'){
                                    secretName='<fmt:message code="dem.th.Secret" />';
                                }
                                str+='<tr data-id="'+datas[i].fileId+'">' +
                                    '<td class="to_detail" style="color:#1687cb;cursor: pointer">'+datas[i].fileCode+'</td>' +
                                    '<td>'+datas[i].fileTitle+'</td>' +
                                    '<td>'+secretName+'</td>' +
                                    '<td>'+datas[i].sendUnit+'</td>' +
                                    '<td>'+new Date(datas[i].addTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>' +
                                    '<td>'+function () {
                                        if(datas[i].urgency == '1'){
                                            return '员工类型';
                                        } else if(datas[i].urgency == '2'){
                                            return '普级';
                                        }else {
                                            return '';
                                        }
                                    }()+'</td>' +
                                    '<td><a href="javascript:;" class="borrowBtn">借阅</a></td>' +
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


    //查询所有卷库
    function queryAllAnjuan(element){
        $.ajax({
            type:'get',
            url:'/rmsRollRoom/selectAll',
            dataType:'json',
            success:function(res){
                var data=res.obj;
                var str='';
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].roomId+'">'+data[i].roomName+'</option>';
                }
                element.append(str);
            }
        })
    }
</script>
</body>
</html>
