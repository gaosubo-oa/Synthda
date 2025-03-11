
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
    <title><fmt:message code="censor.th.wordmanager" /></title>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <%--<link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>--%>
    <script type="text/javascript" src="../js/common/language.js" ></script>
    <script type="text/javascript" charset="utf-8" src="../js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <%--<script src="../lib/laydate/laydate.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        a{
            text-decoration: none;
            color: #207bd6;
        }
        .fileDone select{
            width: 160px;
            height:28px;
        }
        #tr_td tr:nth-child(odd){
            background-color: #fff;
        }

        input{
            float: none;
        }
        .newMange input[type="text"]{
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
        .divBtn{
            float: right;
            width: 90px;
            height: 28px;
            background: #2b7fe0;
            color: #fff;
            font-size: 11pt;
            line-height: 28px;
            margin-right: 4%;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
        }
        .import{
            float: right;
            width: 50px;
            height:28px;
            background: #2b7fe0;
            color: #fff;
            font-size: 11pt;
            text-align: center;
            line-height: 28px;
            margin-right: 20px;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
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
        .importDiv{
            width: 100%;
            height: 96%;
        }
        .divAim{
            width: 100%;
            height: 40px;
        }
        .divAim a{
            margin-top: 6px;
            display: inline-block;
            width: 90px;
            height: 28px;
            line-height: 28px;
            text-align: center;
            background: #2b7fe0;
            color: #fff;
            border-radius: 4px;
        }

    </style>
    <%--<script src="/js/censor/management.js"></script>--%>
</head>
<body>
<div class="bx">
    <div class="navigation  clearfix juMange" id="atSet" style="display: block;">
        <div class="left" style="margin-left: 30px">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
            <div class="news" style="width: 300px;margin-top: 30px"><fmt:message code="censor.th.wordmanager"/><div id="Confidential"style="display: inline-block"></div></div>
        </div>

        <div class="divBtn">
            <img src="../../img/mywork/newbuildworjk.png" alt="" style="margin-left: 6px;margin-top: -4px;">
            <span style="font-size: 11pt;">添加词语</span>
        </div>
        <div class="import">导入</div>
    </div>
    <div class="divTable" style="display: block;">
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
    </div>
</div>
<script type="text/javascript">
    $(function () {
        dataList($('#trList'));
//        添加
        $('.divBtn').on("click",function () {
            layer.open({
                type:1,
                title:['添加词语过滤', 'background-color:#2b7fe0;color:#fff;'],
                area: ['480px', '240px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['确定', '取消'],
                content:'<div class="divLayer">' +
                '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 94%;">' +
                '<tr>' +
                '<td>不良词语：</td>' +
                '<td><input type="text" name="find" placeholder="请输入不良词语"><b>*</b></td>' +
                '</tr>' +
                '<tr>' +
                '<td>替换为：</td>' +
                '<td><input type="text" name="replacement" placeholder="请输入替换词语"><b>*</b></td>' +
                '</tr>' +
                '</table>' +
                '</div>',
                yes:function (index) {
                    var findText=$('input[name="find"]').val();
                    if($('input[name="find"]').val() == ''){
                        layer.msg('请输入不良词语！',{icon:5});
                        return false;
                    }
                    if($('input[name="replacement"]').val() == ''){
                        layer.msg('请输入替换词语！',{icon:5});
                        return false;
                    }
                    $.ajax({
                        type:'post',
                        url:'/censor/addCensorWords',
                        dataType:'json',
                        data:{
                            find:$('input[name="find"]').val(),
                            replacement:$('input[name="replacement"]').val()
                        },
                        success:function (res) {
                            if(res.flag){
                                if(res.msg == 'ok'){
                                    layer.msg('添加成功！',{icon:1});
                                    dataList($('#trList'));
                                    layer.close(index);
                                }else {
                                    layer.msg('词语"'+findText+'"已存在',{icon:5})
                                }
                            }else{
                                layer.msg('添加失败！',{icon:2});
                            }
                        }
                    })
                }
            })
        });
//        导入
        $('.import').on("click",function () {
            layer.open({
                type:1,
                title:['导入', 'background-color:#2b7fe0;color:#fff;'],
                area: ['500px', '240px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['确定', '取消'],
                content:'<div class="importDiv">' +
                '<div class="divAim"><span style="font-size: 11pt;margin-left: 10px;display: inline-block;width: 245px;">请下载模板：</span><a href="/file/censor/词语过滤信息.xls" class="importA" style="">模板下载</a></div>' +
                '<form class="form1" name="form1" id="uploadForm" method="post" action="/censor/inputCensorWord"><div>' +
                '<span style="font-size: 11pt;display: inline-block;width: 245px;margin-left: 10px;">请指定用于导入过滤词的Excel文件：</span>' +
                '<input type="file" name="file" style="width: 200px;"></div></form>' +
                '</div>',
                yes:function () {
                    $('#uploadForm').ajaxSubmit({
                        dataType: 'json',
                        success:function (res) {
                            if(res.flag){
                                layer.msg('导入成功！',{icon:1});
                                dataList($('#trList'));
                                layer.closeAll();
                            }else{
                                layer.msg('导入失败！',{icon:2});
                            }
                        }
                    })
                }
            })
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
                '<td><input type="text" name="find" placeholder="请输入不良词语"><b>*</b></td>' +
                '</tr>' +
                '<tr>' +
                '<td>替换为：</td>' +
                '<td><input type="text" name="replacement" placeholder="请输入替换词语"><b>*</b></td>' +
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
                            $('input[name="find"]').val(datas.find);
                            $('input[name="replacement"]').val(datas.replacement);
                        }
                    })
                },
                yes:function (index) {
                    var findText=$('input[name="find"]').val();
                    if($('input[name="find"]').val() == ''){
                        layer.msg('请输入不良词语！',{icon:5});
                        return false;
                    }
                    if($('input[name="replacement"]').val() == ''){
                        layer.msg('请输入替换词语！',{icon:5});
                        return false;
                    }
                    $.ajax({
                        type:'post',
                        url:'/censor/updateCensorWords',
                        dataType:'json',
                        data:{
                            wordId:wordId,
                            find:$('input[name="find"]').val(),
                            replacement:$('input[name="replacement"]').val()
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

    function dataList(element){
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