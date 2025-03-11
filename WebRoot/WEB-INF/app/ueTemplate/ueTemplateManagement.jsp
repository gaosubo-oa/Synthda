
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
    <title>新建模板</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>

        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .bar {
            height: 18px;
            background: green;
        }
        select{
            width: 228px !important;
            padding-left: 10px;
        }
        .newClass{
            float: right;
            width: 90px;
            height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin: 2% 2% 0 0;
            cursor: pointer;
        }
        .tableMain table tbody td input[type=text]:focus{
            border-color:#ccc;
        }
        .tableMain{
            width: 60%;
        }
        #word_container{
            min-height:230px;
        }
    </style>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>

    <script>

    </script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <h2 id="title_info">新建模板</h2>
    <div class="newClass" id="newClass">
            <span style="margin-left: 30px;">
                <%--<img style="margin-right: 4px;margin-left: -11px;margin-bottom: 2px;" src="../../img/mywork/newbuildworjk.png" alt="">--%>
                返回
            </span>
    </div>
</div>
<div id="pagediv" class="tableMain">
    <%--<form id="ajaxform" action="/Hr/Incentive/addHrIncentive">--%>
    <table>
        <tbody>

        <tr>
            <td class="blue_text" width="20%">
                排序号：
            </td>
            <td width="80%" style="text-align: left">
                <input style="width: 228px" type="text" id="pxh" name="orderNo" class="orderNo">
            </td>
        </tr>
        <tr>
            <td class="blue_text" width="20%">
                模板名称：
            </td>
            <td width="80%" style="text-align: left">
                <input style="width: 228px" type="text" name="title" id="title">
            </td>
        </tr>
        <tr>
            <td width="20%" class="blue_text">
                模板类别：
            </td>
            <td width="80%" style="text-align: left">
                <select id="type" name="type" class="type">
                    <%--  <option value="">请选择</option>
                      <option value="奖励">奖励</option>
                      <option value="惩罚">惩罚</option>--%>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="2" style="padding: 5px;">

                <div id="word_container" name="incentiveDescription">

                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center" class="btnarr">
                <a href="javascript:;" class="savebtn"><fmt:message code="global.lang.save"/></a>
            </td>
        </tr>
        </tbody>
    </table>
    <%--</form>--%>
</div>
<script>

    var user_id='';
    ue = UE.getEditor('word_container',{elementPathEnabled : false});
    UEimgfuc();
    var inDataId=GetQueryString('id')
    $(function () {


        //    返回
        $(document).on('click','.newClass',function () {
//            $(window.parent.document).find('.main').find('iframe').prop('src','/Hr/Incentive/bonpenManage')
            window.location.href='/ueTemplate/newUeTemplate'

        })


        <%--$(function () {--%>


            <%--$.ajax({  //填充奖惩属性拉框--%>
                <%--type:'get',--%>
                <%--url:'/Hr/Incentive/getHrCodes',--%>
                <%--dataType:'json',--%>
                <%--data:{type:'value'},--%>
                <%--success:function(res){--%>
                    <%--if(res.flag) {--%>
                        <%--var lists = res.object;--%>
                        <%--var render = [];--%>
                        <%--render.push("<option value=''><fmt:message code='hr.th.PleaseSelect' /></option>")--%>
                        <%--for(var i=0;i<lists.length;i++){--%>
                            <%--render.push("<option value=\""+lists[i].codeNo+"\">"+lists[i].codeName+"</option>");--%>
                        <%--}--%>
                        <%--$("#incentiveType").html(render.join(""));--%>
                    <%--}--%>

                <%--}--%>
            <%--})--%>

        <%--})--%>
        if(inDataId != '' && inDataId != undefined){
            ue.ready(function(){
                $('#title_info').html('编辑模板')
                $.ajax({
                    type:'get',
                    url:'/ueTemplate/getUeTemplateById',
                    dataType:'json',
                    data:{
                        id:inDataId
                    },
                    success:function (res) {
                        var datas=res.data;
                        $('#title').val(datas.title);
                        $('.orderNo').val(datas.orderNo);
                        ue.setContent(datas.html);
                    }
                })
            })

        }

        $('.savebtn').click(function () {
            var html = ue.getContent();

            if(inDataId != '' && inDataId != undefined){
                $.ajax({
                    type:'post',
                    url:'/ueTemplate/updateUeTemplate',
                    dataType:'json',
                    data:{
                        type:1,
                        title:$('#title').val(),
                        html:html,
                        preHtml:html,
                        id:inDataId,
                        orderNo:$('.orderNo').val()
                    },
                    success:function (res) {
                        if(res.flag){
                            $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                window.location.href='/ueTemplate/newUeTemplate'

                            });
                        }else {
                            $.layerMsg({content:'修改失败！', icon: 2});
                        }
                    }
                })
            }else {
                $.ajax({
                    type:'post',
                    url:'/ueTemplate/insertUeTemplate',
                    dataType:'json',
                    data:{
                        type:1,
                        title:$('#title').val(),
                        html:html,
                        preHtml:html,
                        orderNo:$('.orderNo').val()

                    },
                    success:function (res) {
                        if(res.flag){
                            $.layerMsg({content: '保存成功！', icon: 1}, function () {
                                window.location.href='/ueTemplate/newUeTemplate'

                            });
                        }else {
                            $.layerMsg({content:'保存失败！', icon: 2});
                        }
                    }
                })
            }
        })

    })

    var text3 = document.getElementById("pxh");
    text3.onkeyup = function(){
        this.value=this.value.replace(/\D/g,'');
    }

    // 用正则表达式获取地址栏参数
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);

        if(r!=null) {
            return  unescape(r[2]);
        } else {
            return null;
        }
    }

</script>
</body>
</html>