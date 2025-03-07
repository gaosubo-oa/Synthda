
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
    <title>词语过滤查询</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <%--<link rel="stylesheet" href="/css/notice/noticeManagement.css">--%>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <%--<script src="../js/jquery/jquery.cookie.js"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>

        .navigation{
            width: 100%;
            box-sizing: border-box;
            height: 70px;
            padding-left: 34px;
            line-height: 70px;
        }
        .navigation img{
            vertical-align: middle;
        }
        .navigation h2{
            font-weight: normal;
            display: inline-block;
            font-size: 22px;
            color: #494d59;
            vertical-align: middle;
            margin-left: 10px;
        }
        .navigation label{
            vertical-align: middle;
            margin-left: 40px;
        }
        .navigation label select,.navigation label a{
            vertical-align: middle;
            color: #000;
        }
        .navigation label select{
            width: 168px;
            height: 29px;
            line-height: 29px;
            border-radius: 4px;
            margin-right: 10px;
        }
        #operation tr td input{
            vertical-align: middle;
        }
        #operation tr td span{
            vertical-align: middle;
        }
        .tableMain{
            width: 97%;
            margin: 0 auto;
            height: 200px;

        }
        .tableMain table{
            width: 500px;
            background: #fff;
            margin: 0 auto;
        }
        .tableMain table tbody td{
            box-sizing: border-box;
            padding:8px;
            border-right: 1px solid #c0c0c0;
            font-size: 11pt;
        }
        .tableMain table tbody td:first-of-type{
            width: 100px;
        }
        .tableMain table tbody td select{
            width: 70%;
            border: 1px solid #c0c0c0;
            border-radius: 4px;
            height: 30px;
            line-height:30px;
            vertical-align: middle;
        }
        .tableMain table tbody td input[type=text]{
            width: 300px;
            border: 1px solid #c0c0c0;
            border-radius: 4px;
            height: 30px;
            line-height:30px;
            padding-left: 10px;
            vertical-align: middle;
        }
        .tableMain table tbody td input{
            vertical-align: middle;
        }
        .tableMain table tbody td span{
            vertical-align: middle;
        }
        .tableMain table tbody td input[type=text]:focus{
            border-color: blue;
        }
        .tableMain table tbody td b{
            color: red;
            vertical-align: middle;
            margin-left: 5px;
        }
        .tableMain table tbody td textarea{
            width: 30%;
            border: 1px solid #c0c0c0;
            border-radius: 4px;
            height: 46px;
            line-height:20px;

            padding-left: 10px;
            vertical-align: middle;
            background-color: #e7e7e7;
            outline: none;
        }
        .blue_text a{
            color: #207bd6;
        }
        .openFile img{
            vertical-align: middle;
        }
        .openFile span{
            vertical-align: middle;
        }
        .openFile input[type=file]{
            position: absolute;
            top:0;
            right: 0;
            bottom: 0;
            left:0;
            width: 100%;
            height: 18px;
            z-index:99;
            opacity: 0;
            filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }
        .btnarr a{
            padding: 5px 15px;
            color: #fff;
            border-radius: 4px;
            background: #2F8AE3;
            margin:0 10px;
        }
        input[type=checkbox]{
            width: 13px!important;
            height: 13px!important;
        }
        .divTable{
            width: 60%;
            margin: 0px auto;
        }
        .divTable table{
            width: 100%;
        }
        .divTable table tr th{
            padding: 8px;
            /*font-size: 11pt;*/
            font-size: 13pt;
            color: #2F5C8F;
            border-right: #ccc 1px solid;
        }

        td{
            font-size: 11pt;
        }

        .divTable table tr td{
            text-align: center;
            border-right: #ccc 1px solid;
            padding: 8px;
        }
        .backBtn{
            width: 100%;
            height: 28px;
        }
        .divBtn{
            width: 60px;
            border-radius: 4px;
            text-align: center;
            margin: 15px auto;
            float: none;
        }
        .divLayer{
            width: 100%;
        }
        .divLayer table{
            width: 96%;
            margin: 15px auto;
        }
        .divLayer table tr{
            border: none;
        }
        .divLayer table tr td{
            text-align: left;
            padding: 8px;
        }
        .divLayer table tr td:first-of-type{
            width: 80px;
        }
        .divLayer table tr td input{
            width: 300px;
            height: 30px;
            border-radius: 4px;
            outline: none;
        }
        .divLayer table tr td b{
            margin-left: 5px;
            color: #f00;
        }

    </style>
    <%--<script src="/js/censor/newAndEdit.js"></script>--%>

</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <h2>词语过滤查询</h2>
    <div id="Confidential"style="display: inline-block"></div>
</div>
<div id="pagediv" class="tableMain">
    <table class="queryTable">
        <tbody>
        <input type="hidden" value="" name="wordId"/>
            <tr>
                <td>不良词语：</td>
                <td>
                    <input type="text" name="find">
                </td>
            </tr>
            <tr>
                <td>替换词语：</td>
                <td>
                    <input type="text" name="replacement">
                </td>
            </tr>
            <tr>
                <td>操作：</td>
                <td>
                    <label for="" style="margin-right: 15px;">
                        <input type="radio" name="flag" value="" checked>查询
                    </label>
                    <label for="" style="margin-right: 15px;">
                        <input type="radio" name="flag" value="1">导出
                    </label>
                    <label for="">
                        <input type="radio" name="flag" value="2">删除
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center" class="btnarr">
                    <a href="javascript:;" class="savebtn">确定</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="divTable" style="display: none;">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
        <thead>
        <tr>
            <th>选择</th>
            <th>不良词语</th>
            <th>替换为</th>
            <th>添加人</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="trList">

        </tbody>
    </table>
    <div class="right">
        <!-- 分页按钮-->
        <div class="M-box3" id="dbgz_page"></div>
    </div>
    <div class="backBtn">
        <div class="divBtn">返回</div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
//        确定
        $('.savebtn').on("click",function () {
            var findText=$('input[name="find"]').val();
            var replacementText=$('input[name="replacement"]').val();
            var radioVal=$("input[name='flag']:checked").val();

            if(radioVal == ''){
                $('#pagediv').hide();
                $('.divTable').show();
                dataList($('#trList'),findText,replacementText,radioVal);
            }else if(radioVal == '1'){
                exportList(findText,replacementText,radioVal);
            }else{
                deleteList(findText,replacementText,radioVal);
            }

        })
//        返回
        $('.divBtn').on("click",function () {
            $('#pagediv').show();
            $('.divTable').hide();
            $('#trList').find('tr').remove();
        })

        //        编辑
        $('#trList').on('click','.editData',function () {
            var wordId=$(this).parents('tr').attr('data-id');
            layer.open({
                type:1,
                title:['修改词语过滤', 'background-color:#2b7fe0;color:#fff;'],
                area: ['480px', '240px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['确定', '取消'],
                content:'<div class="divLayer">' +
                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                '<tr>' +
                '<td>不良词语：</td>' +
                '<td><input type="text" name="finds" placeholder="请输入不良词语"><b>*</b></td>' +
                '</tr>' +
                '<tr>' +
                '<td>替换为：</td>' +
                '<td><input type="text" name="replacements" placeholder="请输入替换词语"><b>*</b></td>' +
                '</tr>' +
                '</table>' +
                '</div>',
                success:function () {
                    $.ajax({
                        type:'get',
                        url:'/censor/getCensorWordsById',
                        dataType:'json',
                        data:{
                            wordId:wordId
                        },
                        success:function (res) {
                            var datas=res.object;
                            $('input[name="finds"]').val(datas.find);
                            $('input[name="replacements"]').val(datas.replacement);
                        }
                    })
                },
                yes:function (index) {
                    var findText=$('input[name="find"]').val();
                    if($('input[name="finds"]').val() == ''){
                        layer.msg('请输入不良词语！',{icon:5});
                        return false;
                    }
                    if($('input[name="replacements"]').val() == ''){
                        layer.msg('请输入替换词语！',{icon:5});
                        return false;
                    }
                    $.ajax({
                        type:'post',
                        url:'/censor/updateCensorWords',
                        dataType:'json',
                        data:{
                            wordId:wordId,
                            find:$('input[name="finds"]').val(),
                            replacement:$('input[name="replacements"]').val()
                        },
                        success:function (res) {
                            if(res.flag){
                                if(res.msg == 'ok'){
                                    layer.msg('修改成功！',{icon:1});
                                    dataList($('#trList'));
                                    layer.close(index);
                                }else {
                                    layer.msg('词语"'+findText+'"已存在',{icon:5})
                                }
                            }else{
                                layer.msg('修改失败！',{icon:2});
                            }
                        }
                    })
                }
            })
        })
//        删除
        $('#trList').on('click','.deleteData',function () {
            var wordId=$(this).parents('tr').attr('data-id');
            layer.confirm('确定要删除吗？', {
                btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
                title:"删除"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/censor/delCensorWords',
                    dataType:'json',
                    data:{
                        wordId:wordId
                    },
                    success:function(res){
                        if(res.flag){
                            layer.msg('删除成功！', { icon:6});
                            dataList($('#trList'));
                        }else{
                            layer.msg('删除失败！', { icon:5});
                        }
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })


    })
//查询
    function dataList(element,findTx,replacementTx,flagChose){
        var ajaxPage={
            data:{
                page:1,
                pageSize:10,
                useFlag:true,
                find:findTx,
                replacement:replacementTx,
                flag:flagChose
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'get',
                    url:'/censor/getCensorWords',
                    dataType:'json',
                    data:me.data,
                    success:function (res) {
                        var datas=res.obj;
                        if(res.flag){
                            var str='';
                            for(var i=0;i<datas.length;i++){
                                str+='<tr data-id="'+datas[i].wordId+'">' +
                                    '<td><input type="checkbox" name="tdCheck" value=""></td>' +
                                    '<td>'+datas[i].find+'</td>' +
                                    '<td>'+datas[i].replacement+'</td>' +
                                    '<td>'+datas[i].userName+'</td>' +
                                    '<td><a href="javascript:;" class="editData" style="margin-right: 10px;">编辑</a><a href="javascript:;" class="deleteData">删除</a></td>' +
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
// 导出
    function exportList(findTx,replacementTx,flagChose) {
        window.location.href='/censor/getCensorWords?find='+findTx+'&replacement='+replacementTx+'&flag='+flagChose;
    }
// 删除
    function deleteList(findTx,replacementTx,flagChose) {
        layer.confirm('确定要删除吗？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'], //按钮
            title:"删除"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/censor/getCensorWords',
                dataType:'json',
                data:{
                    find:findTx,
                    replacement:replacementTx,
                    flag:flagChose
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('删除成功！', { icon:6});
                        location.reload()
                    }else{
                        layer.msg('删除失败！', { icon:5});
                    }
                }
            })

        }, function(){
            layer.closeAll();
        });
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>