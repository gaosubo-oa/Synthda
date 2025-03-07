<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="main.worklog"/></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/workLog.css?2019101712.55"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar1.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/diary/calendar1.js/"></script>
    <script type="text/javascript" src="../js/diary/date.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <%-- <script type="text/javascript" src="../js/diary/index.js/"></script>--%>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <!-- kindeditor文本编辑器 -->
    <script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>
</head>
<style>
    .layui-layer-title {
        padding: 0 80px 0 20px;
        height: 42px;
        line-height: 42px;
        border-bottom: 1px solid #eee;
        font-size: 16px;
        color: #fff;
        overflow: hidden;
        background-color: #2b7fe0;
        border-radius: 2px 2px 0 0;
    }

    .edui-toolbar{
        height: 22px !important;
    }

    .displayNone{
        display: none;
    }
    .feed-ext-body-readers{
        border: 1px solid #ddd;
        border-top: 0;
        padding: 8px 30px;
        background: #F8F8F8;
    }
    .feed-cmt-list-item {
        position: relative;
        padding: 5px 0;
        border-top: 1px dashed #CCC;
        margin: 0 20px;
        line-height: 20px;
    }
    .feed-cmt-list-item a {
        color: #2A94CF;
        text-decoration: none;
    }
    .feed-cmt-content {
        padding: 4px;
        line-height: 1.3;
    }
    .feed-cmt-list-ext {
        position: absolute;
        right: 5px;
        top: 5px;
    }
    .blue_text{
        width:15%;
        padding-left:10px;
        font-weight:bold;
        text-align:right;
        border: 1px #ccc solid;
    }
    .ATTACH_a{
        text-decoration: none;
    }
    .feed-ext-add-comment{
        margin-bottom: 30px!important;
        min-height:200px;
    }
    /*.controls  textarea.inText{*/
    /*float:none;*/
    /*}*/
    .control-label{
        display:block;
    }
    .controls  div{
        float:left;
        margin-top:68px;
    }
    textarea{
        min-height:50px;
    }
    .step2{
        width:98%;
        margin:0 auto;
        display:block;
        float:none;
    }
    .input-medium{
        width:180px;
    }
    select{
        margin-top:0%;
    }
    .control-group{
        height:auto;
    }

    .newlogHeade{
        height:44px;
        line-height:44px;
    }
    .newlogHeade img{
        margin-top:1%;
    }
    .head .one{
        padding:0px 10px;
    }
    #share_type{
        vertical-align:middle;
        position: absolute;
        right: 50px;
    }
    .modular_user{
        display:inline-block;
    }
    .modular_user img{
        width:68px;
        height:68px;
        float:left;
        border-radius: 50%;
    }
    .head  .titName{
        display:block;
    }
    .newNews {
        border:1px solid #e0e0e0;
    }
    .newNews tr{
        border:1px solid #e0e0e0;
    }
    .title{
        width: 99%;
        height: 50px;
        overflow: hidden;
        margin-left: 10px;
    }
    .title .div_Img{
        float: left;
        width: 23px;
        height: 100%;
        margin-left: 20px;
    }
    .title .new{
        float: left;
        height: 50px;
        line-height: 50px;
        font-size: 22px;
        margin-left: 10px;
        color: #494d59;
    }
    .content_right{
        margin-top:18px;
    }
    .span3{
        margin-top:1.5%;
    }
    .headLog img{
        margin-top: 0.36%;
        width: 30px;
        height: 30px;
    }
    .headLog div{
        margin-left: 0.6%;
    }
    .content_right {
        margin-top: -21px;
    }
    .newNews,.newNews tr{
        border:none;
    }
    .btnLog .btn_ok {
        padding-left:15px;
        line-height:30px;
    }
    .btnLog {
        margin-left: 300px;
    }
    .btn_ok{
        background: url(../../img/diary/save.png) no-repeat;
    }

    #rs{
        padding-left:19px;
        line-height:30px;
    }
    .td_s{
        border: 1px #ccc solid;
    }
    .btnLog div{
        width: 80px;
    }

    .modular_info{
        width:85%;
    }

    /*.step2{overflow-y: auto;}*/
    /*#edui1_iframeholder{*/
    /*max-height: 240px;*/
    /*}*/
    /*.edui-default .edui-editor-iframeholder{*/
    /*height:65px!important;*/
    /*}*/
    /*.edui-default .edui-editor-bottomContainer{*/
    /*display: none;*/
    /*}*/
    #word_container{
        min-height: 250px;
    }
    .attacheName{
        width: 100%;
        margin-bottom: 10px;
    }
    .attachDiv{
        border-bottom: #efefef 1px solid;
        margin-bottom: 10px;
    }
    .modular_footer{
        position: inherit;
        margin-top: 10px;
    }
    .modular_info p{
        margin-bottom: 10px !important;
        font-size: 11pt;
        color:#333;
    }
    .modular_info h3{
        height: 30px;
        line-height: 30px;
        font-size: 11pt;
    }
    .modular_info .modular_name{
        font-size: 9pt;
    }
    /*.feed-ext-comment-sms-op,.feed-ext-comment-sms-advcomment{*/
    /*    margin-top:80px !important;*/
    /*}*/
    .search_{
        font-weight:bold;
        background-color:#0575B0;
        width: 247px;
        margin-left: -10px;
        font-size:14px;
        color:white;
        text-shadow:0px 1px 0px rgba(6, 60, 103, 0.75)
    }
    .icon-search{
        color: #ffffff;
    }
    .controls textarea.inText{
        width: 230px;
    }
    .two{
        background-color: white !important;
    }
    .three{
        background-color: white !important;
    }
    .fore{
        background-color: white !important;
    }
    .shu li{
        display: inline-block;
        width: 32%;
        height: 60px;
        border: 1px solid rgb(219,219,219);
        margin: 0;
        text-align: center;
    }
    .shu li p{
        font-size: 20px;
        color: #39C;
        margin-top: 10px;
        margin-bottom: 8px;
    }
    .rightButtom{
        border: 1px solid rgb(219,219,219);
    }
    .ke-button{
        width: auto;
    }
    .view-month{
        width: 250px;
        display: none;
    }

    input[name='upfile']{
        width:100%
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="overflow: hidden;">
<%--头部样式--%>
<div class="head w clearfix" style="position: fixed;background: #fff;width:100%;z-index:1000;height:45px;">
    <ul class="index_head clearfix">
        <li id="index" data_id=""><span class="one headli1_1 titName">工作日志</span></li>
        <li id="logQuery" data_id=""><span class="two headli1_1 titName" style="background: #fff !important;">日志查询</span></li>
        <li id="noCommentLog" data_id=""><span class="three headli1_1 titName">未点评日志</span></li>
        <li id="reportStatistics" data_id=""><span class="fore headli1_1 titName">汇报统计</span></li>
        <%--<li data_id="0" onclick="develop()"><span class="headli2_1"><fmt:message code="diary.th.LogRetrieval"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/></span>--%>
        <%--</li>--%>
    </ul>
</div>
<div class="title">
    <div class="div_Img"></div>
    <div class="new">
        <fmt:message code="main.worklog"/>
    </div>
</div>
<%--日志信息--%>
<div class="clearfix" id="logInfo" style="display:block;overflow: auto;">
    <%--中间部门--%>
    <div class="headLog clearfix">
        <%--        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/logimg.png">--%>
        <img src="/img/main_img/app/0128.png">
        <div class="">
            <fmt:message code="main.worklog"/>
        </div>
    </div>
    <%--内容部分左侧--%>
    <div class="span3">
        <div class="writeLog" id="writeLog"><fmt:message code="diary.th.write"/></div>
        <div style="border:1px solid #dbdbdb;">
            <h3 class="diary-user-name" style="color: #fff;"><fmt:message code="email.th.systemmanager"/></h3>
            <ul class="shu">
                <li><p></p><span>全部日志</span></li><li><p></p><span>我的日志</span></li><li><p></p><span>他人日志</span></li>
            </ul>
            <ul class="diary-types-box clearfix" style="display: none">

                <li data-type="mine" id="mine">
                    <div class="diary-types-counter" id="zj">0</div>
                    <div class="diary-types-title"><fmt:message code="diary.th.own"/></div>
                </li>
                <li data-type="others" id="others">
                    <div class="diary-types-counter" id="tr">0</div>
                    <div class="diary-types-title">共享日志</div>
                </li>
                <li data-type="all" id="all">
                    <div class="diary-types-counter" id="qb">0</div>
                    <div class="diary-types-title">下属日志</div>
                </li>
            </ul>
            <div class="diary-calendar-wrapper" id="calendar_" style="display: block;">
                <%--日历插件--%>
                <div id="ca"></div>
                <div id="diary-date-result" class="tags" style="border: none;"></div>
            </div>
            <%--高级搜索--%>
            <div id="diary-search-box" >
                <form class="form-search" name="searchForm">
                    <div class="search_">
                        <i class="icon-search" style="margin-left: 10px; margin-top:2%; color:white;"></i>&nbsp;&nbsp;高级查询
                        <i class="icon-chevron-down" id="triangle" style="margin-right:10px;margin-top:9px"></i>
                    </div>

                    <div id="diary-adv-search-box" class="diary-adv-search-box" style="display:none">
                        <div class="control-group control-group2">
                            <div class="controls pull-right">
                                <a class="date-quicklink" id="recent3day" href="javascript:void(0)"><fmt:message code="diary.th.this3"/></a>
                                <a class="date-quicklink" id="recent1week" href="javascript:void(0)"><fmt:message code="diary.th.thisW"/></a>
                                <a class="date-quicklink" id="recent1month" href="javascript:void(0)"><fmt:message code="diary.th.thisM"/></a>
                            </div>
                            <label class="control-label"><b class="date"><fmt:message code="global.lang.date"/></b></label>
                            <div class="controls clearfix">
                                <input type="text" id="startdate">
                                <div class="zhi"><fmt:message code="global.lang.to"/></div>
                                <input type="text" id="enddate">


                            </div>
                        </div>

                        <%--<div class="control-group control-group2">--%>
                        <%--<label class="control-label"><b class="date"><fmt:message code="diary.th.Range"/></b></label>--%>
                        <%--<div class="controls">--%>
                        <%--<select id="diarytype" class="input-medium " name="diarytype">--%>
                        <%--<option value="1"><fmt:message code="diary.th.all"/></option>--%>
                        <%--<option value="2"><fmt:message code="diary.th.my"/></option>--%>
                        <%--<option value="3"><fmt:message code="diary.th.shared"/></option>--%>
                        <%--<option value="4"><fmt:message code="diary.th.Authorized"/></option>--%>
                        <%--</select>--%>
                        <%--</div>--%>

                        <%--</div>--%>
                        <div id="dept-group" class="control-group">
                            <label class="control-label"><b class="date"><fmt:message code="userManagement.th.department"/></b></label>
                            <div class="controls">
                                <textarea class="inText" id="dept" type="text" disabled></textarea>
                                <div id="dept_add" style="margin-top: 5px"><fmt:message code="global.lang.add"/></div>
                                <div onclick="empty('dept')" style="margin-top: 5px"><fmt:message code="global.lang.empty"/></div>
                            </div>
                        </div>

                        <div id="role-group" class="control-group">
                            <label class="control-label"><b class="date"><fmt:message code="userManagement.th.role"/></b></label>
                            <div class="controls">
                                <textarea class="inText" id="add_selectjuese" type="text" disabled></textarea>
                                <div id="priv_add" style="margin-top: 5px"><fmt:message code="global.lang.add"/></div>
                                <div onclick="empty('add_selectjuese')" style="margin-top: 5px"><fmt:message code="global.lang.empty"/></div>
                            </div>
                        </div>
                        <div id="user-group" class="control-group">
                            <label class="control-label"><b class="date"><fmt:message code="diary.th.body"/></b></label>
                            <div class="controls">
                                <textarea class="inText" id="add_selectUser" type="text" disabled></textarea>
                                <div id="add_selectUserbtn" style="margin-top: 5px"><fmt:message code="global.lang.add"/></div>
                                <div onclick="empty('add_selectUser')" style="margin-top: 5px"><fmt:message code="global.lang.empty"/></div>
                            </div>
                        </div>

                        <%--<div class="control-group control-group2">
                            <!-- Select Basic -->
                            <label class="control-label"><b class="date"><fmt:message code="journal.th.LogTable"/></b></label>
                            <div class="controls">
                                <select class="input-medium " id="diarydb" name="diarydb">
                                    <option value=""><fmt:message code="journal.th.CurrentLog"/></option>

                                </select>
                            </div>
                        </div>--%>

                        <div class="control-group control-group3">
                            <a href="javascript:void(0);" id="buttonQuery" class="button_  button_query"><fmt:message code="global.lang.query"/></a>
                            <a href="javascript:void(0);" id="buttonExport" class="button_ buttonExport"><fmt:message code="global.lang.report"/></a>
                        </div>
                    </div>


                </form>
            </div>

        </div>
        <div style="padding-right: 10px;padding-left: 10px;margin-top: 30px;" class="rightButtom"></div>
        <%--<div class="writeLog" id="writeLog"><fmt:message code="diary.th.write"/></div>--%>
        <%--<dl id="diary-cmt-list" class="diary-cmt-list">--%>
        <%--<dt>--%>
        <%--系统管理员 <i>回复了</i>--%>
        <%--</dt>--%>
        <%--<dd>--%>
        <%--<a target="_blank" href="show_diary.php?dia_id=216">《2017-05-12 星期五 工作日志》</a>--%>
        <%--</dd>--%>
        <%--</dl>--%>
    </div>
    <%--内容部分右侧--%>
    <div class="content_right clearfix">
        <div class="button_news clearfix">
            <input type="hidden" name="dirayType" value="0">
            <button class="btn active" type="button" id="oneselfPeople">我的日志</button>
            <button class="btn" type="button" id="myOutline">我的草稿</button>
            <button class="btn" type="button" id="otherPeople">共享日志</button>
            <button class="btn" type="button" id="allPeople">下属日志</button>
        </div>
        <div class="details clearfix" id="detailss" style="zoom:0;margin-bottom:-40px;height: 50%;display: none">
            <%--未发日志人员--%>
            <div style="margin-top: 5px" id="addbutton">



            </div>
            <div style="margin-top: 20px;font-size: 16px" id="addspan">

            </div>

        </div>
        <div class="details clearfix" id="details" style="zoom:0">
            <%--日志列表--%>
            <%--第一板块--%>
        </div>
        <div id="moreButtonDiv">
            <button class="btn" id="moreButton" type="button" >更多</button>
        </div>
        <!-- 分页按钮-->
        <div class="M-box3">
        </div>
    </div>

</div>
<%--新建日志--%>
<div id="lognewBox" style="overflow: auto;">
    <div id="logNew" class="clearfix" style="display:none;padding-top:0px;">
        <div class="newLog_left">
            <%--中间部门--%>
            <div class="headLog newlogHeade clearfix" style="margin-top:-5px">
                <img src="../img/workLog/reviseLog.png">
                <div class="log">
                    <fmt:message code="diary.th.new"/>
                </div>
            </div>
            <!-- 新建日志页面********************* -->


            <div class="step2" >
                <!-- 中间部分 -->
                <table class="newNews" style="width:70%;margin-top:20px;margin-left:170px;border: 1px #ccc solid;table-layout: fixed;">
                    <tbody>
                    <tr id="SecretLevel">
                        <td class="td_w blue_text">
                            <fmt:message code="notice.th.title"/>：
                        </td>
                        <td class="td_s">
                            <input class="td_title1" id="query_subject" style="width:390px;text-align:left;border-radius:3px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td_w blue_text">
                            <fmt:message code="global.lang.date"/>：
                        </td>
                        <td class="td_s">
                            <div class="row-fluid clearfix" style="text-align:left;">
                                <input type="text" id="inputsendTime" name="dia_date" class="input-medium" value="" style="text-align:left;width:390px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_w blue_text">
                            <fmt:message code="notice.th.type"/>：
                        </td>
                        <td class="td_s">
                            <div>
                                <select class="input-medium" name="dia_type" id="diary_log" style="width:396px;">
                                    <option value="1">工作日志</option>
                                    <option value="3">工作周报</option>
                                    <option value="4">工作月报</option>
                                    <option value="2">个人日志</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr id="yuepingdiv">
                        <td class="td_w blue_text">
                            阅评：
                        </td>
                        <td class="td_s">
                            <input style="width: 36%;background-color: rgb(238,238,238)" id="yuep" readonly="readonly" type="text">
                            <button id="tyue" type="button" style="width: 70px;height: 30px;border: 1px solid rgb(220,220,220);margin-left: 10px">添加</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text" valign="top">
                            <fmt:message code="notice.th.content"/>：
                        </td>
                        <!--word编辑器-->
                        <td class="td_s" id="normalDiary">
                            <div class="content" id="newKindEditor" name="content"  style="width: 100%; height: 300px;"></div>
                        </td>
                        <td id='templateDiary' style='display:none'>
                        </td>
                    </tr>
                    <tr id="sharediv">
                        <td valign="top" class="blue_text">
                            <div class="control-group" id="dia_share" style="display:block;">
                                <label class="control-label" style="position:relative;" for="share_type"><input id="share_type" type="checkbox" name="share_type" value="1" onclick="share(this)" checked><span style="margin-right:5px;"><fmt:message code="diary.th.Share"/>:</span> </label>

                            </div>
                        </td>
                        <td class="td_s">
                            <div id="share" style="display: block">
                                <!-- Textarea -->
                                <div class="textarea">
                                    <input type="hidden" name="to_id" value="">
                                    <textarea class="SmallStatic" id="add_text" name="to_name" style="margin: 0px;width: 390px;height: 60px;" readonly=""> </textarea>
                                    <span align="right" style="margin-top:5px;margin-bottom: 8px;">
                                        <a href="javascript:void(0);" class="orgAdd" id="add_log" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
                                        <a href="javascript:void(0);" class="orgClear" style="color:#1772c0" onclick="clearData()"><fmt:message code="global.lang.empty"/></a>
                                    </span>
                                    <div class="">
                                        <label for="is_set"><input type="checkbox" id="is_set" name="is_set" value="" checked>设置为默认共享范围</label>
                                        <label class="dataTixing" for="is_remind"><input type="checkbox" id="is_remind" name="is_remind" value="">发送事务提醒</label>
                                    </div>
                                </div>

                                <%--<label class="sms-remind-labe_" style="padding-right:10px">--%>
                                <%--<input type="checkbox" name="share_init" value="1"><fmt:message code="global.lang.query"/>--%>
                                <%--</label>--%>
                                <%--<label class="sms-remind-labe_" style="padding-right:10px"><input type="checkbox" name="" checked=""><fmt:message code="notice.th.remindermessage"/>--%>
                                <%--</label>--%>
                                <%--<label class="sms-remind-labe_" style="padding-right:10px"><input type="checkbox" name="" checked=""> <fmt:message code="notice.th.share"/>--%>
                                <%--</label>--%>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text">
                            <span style="margin-right:5px;">
                                点评:
                            </span>
                        </td>
                        <td class="enclosure td_s">
                            <input type="radio" name="dian" value="1" checked>允许
                            <input type="radio" name="dian" value="0">禁止
                        </td>
                    </tr>
                    <tr>
                        <td class="blue_text">
                            <span style="margin-right:5px;">
                                <fmt:message code="email.th.file"/>:
                            </span>

                        </td>
                        <td class="files enclosure td_s" style="position: relative">
                            <div id="query_uploadArr" style="margin-bottom: 5px;"></div>
                            <!-- 添加附件 -->
                            <form id="uploadimgform" style="float: left;margin: 0 20px 0 0;" target="uploadiframe" action="/upload?module=diary" method="post">
                                <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                                <a href="#" id="uploadimg" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png">附件上传</a>
                            </form>
<%--                            文件夹上传--%>
                            <form id="uploadimgform2" style="float: left;margin: 0 20px 0 0;"   action=""  method="post" >
                                <input webkitdirectory type="file" multiple="multiple" name="file"  id="Folder"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                                <a href="#" id=" upload" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/>文件夹上传</a>
                            </form>
                            <!-- 从文件柜选择上传 -->
                            <form id="fileform" style="float: left;margin: 0 20px 0 0;" target="" action="" method="post">
                                <a href="#" id="uploadfile" style="display: inline-block;height: 20px;line-height: 20px" onclick="fileBox()"><img style="margin:3px 5px 0 0;float: left;" src="../img/mg12.png">从文件柜选择上传</a>
                            </form>
                            <span id="fileTips" style="color: #b6b1b1">可以将多个文件或文件夹拖动到本页面实现自动上传</span>
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="foot_log" style="float:left;width: 100%;">
            <div class="btnLog" style="margin-left: 0;">
                <div id="hd" type="publish" class="btn_ok" style="background: url(../../img/publish.png) no-repeat;">提交</div>
                <div id="hds" type="publish" class="btn_oks" style="background: url(../../img/save.png) no-repeat;">保存</div>
                <div id="rs" type="save" class="btn_return"><fmt:message code="notice.th.return"/></div>
            </div>
        </div>

    </div>
</div>


</body>
<script>
    var isShowSecret = true;// 判断是否开启 系统参数：模块数据显示密级字段
    //判断是否开启三员管理，如果开启则隐藏编辑功能
    var isOpenSanyuan = false;
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {
                //    进入此判断说明开启了三员管理
                isOpenSanyuan = true;
                //如果开启三员管理，隐藏从文件柜上传附件
                $("#uploadfile").hide();
                $("#fileTips").html('可以将多个文件或文件夹拖动到本页面实现自动上传 <span style="color:red;">(禁止上传高密级文件)</span>');
            }
        }
    })
    //添加密级
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
        dataType:'json',
        success:function (res) {
            if (res.flag && res.object && res.object.length > 0) {
                if (res.object[0].paraValue === "1") {
                    isShowSecret = true;
                    $("#SecretLevel").after(' <tr>' +
                        '<td class="td_w blue_text">' +
                        '<span style="font-family: Microsoft YaHei;font-size: 11pt;margin-right: 10px;"> 密级: </span>' +
                        '</td>' +
                        '<td class="td_s" id="">' +
                        ' <select class="td_title1" id="SecretLevels" style="width:390px;text-align:left;border-radius:3px" />'+
                        '</select> ' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</td>' +
                        '</tr>')
                    $.ajax({
                        type: 'get',
                        url: '/code/getCode?parentNo=CONTENT_SECRECY',
                        dataType: 'json',
                        success: function (res) {
                            var str = '';
                            for (let i = 0; i < res.obj.length; i++) {
                                str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>';
                            }
                            $('#SecretLevels').append(str);
                        }
                    })

                }
            }
        }
    })

    var cg = 1;
    //回显汇报上级
    $.ajax({
        type:'get',
        url:'/userHierarchy/selectUserHierarchy',
        dataType:'json',
        success:function(res){
            if(res.flag && res.object != null){
                $("#yuep").val(res.object.userTopIdName)
                $("#yuep").attr('user_id',res.object.userTopId)
            } else{
                $("#yuep").val("")
                $("#yuep").attr('user_id',"")
            }
        }
    });

    //判断是否是中高管
    var isZhongGaoGuan = 0;
    $.ajax({
        url: "/userPriv/selectIsZhongGaoGuan",
        type:'get',
        dataType:"JSON",
        data: {},
        success:function(data){
            if(data.flag){
                if(data.object != undefined && data.object.isZhongGaoGuan == 1){
                    isZhongGaoGuan = 1;
                }
            }
        }
    });

    //提醒提交日志，设置已读
    $(function () {
        var bodyId = getQueryString('bodyId') || '';
        if (bodyId != ""){
            $.ajax({
                type:'get',
                url:'/sms/setRead',
                dataType:'json',
                data: {bodyId : bodyId},
                success:function(res){}
            });
        }
    });

    function fileBox() {
        file_id='query_uploadArr';
        model = 'diary'
        $.popWindow("../common/selectNewFile?1");
    }
    //判断是否默认开启事务提醒
    $(function () {
        $.ajax({
            type:'get',
            url:'/smsRemind/getRemindFlag',
            dataType:'json',
            data: {type:'13'},
            success:function(res){
                var data = res.obj[0];
                if(data.isCan == 0) {
                    $(".dataTixing").hide();
                }
                if(res.flag){
                    $('#is_remind').attr("checked","true");
                }
            }
        });
        $("#moreButtonDiv").hide();
    });

    <%--获取标题--%>
    function getTitle(){
        $.ajax({
            url:'/users/getUserTheme',
            type:'post',
            dataType:'json',
            success:function(res){
                var data=res.object;
                $('.diary-user-name').html(data.userName)
            }
        })
    }
    getTitle()

    var moreButtonStr="";

    var data = {
        page: 1,
        pageSize: 10,
        useFlag: true,
        diaDate:'', //查询时间 开始
        timeEnd: '',   //查询时间 结束
        userIds:'',    //查询范围 用户范围
        userPrivs:'',    //查询范围 角色范围
        deptIds:'',  //查询范围 部门范围
        sFlag:'', //是否提交  0草稿 1已提交
        isExport:'',//是否导出
    };
    //日历查询的函数
    var datas = {
        page: 1,
        pageSize: 10,
        useFlag: true,
    }
    var mydata = {
        page: 1,
        pageSize: 10,
        useFlag: true,
    };
    var logs = {
        page: 1,
        pageSize: 10,
        useFlag:true
    };
    var sharedata = {
        page: 1,
        pageSize: 10,
        useFlag: true,
    };
    var user_id='userDuser';
    var ue;
    var ue2;
    var kindEditorOption = {
        themeType: 'simple', // 定义编辑器为简洁模式
        filterMode: false, // 开启过滤
        allowFileManager: true, // 开启文件空间
        uploadJson: '/ueditor/upload?module=ueditor', // 上传接口
        filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
        afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
        afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
        afterUploadErrorMsg: 'msg', // 定义上传失败后提示信息的参数名（默认为 message）
        afterUpload: function (url, data, name) {
            console.log(url);
            console.log(data);
            console.log(name);
        }
    }
    // 新建新闻编辑器
    var newKindEditorObj = null;
    KindEditor.ready(function (K) {
        newKindEditorObj = K.create('#newKindEditor', kindEditorOption);
    });
    // 编辑新闻编辑器
    var editKindEditorObj = null;
    KindEditor.ready(function (K) {
        editKindEditorObj = K.create('#editKindEditor', kindEditorOption);
    });
    $(function () {
        //写日志页面富文本编辑器
        ue= UE.getEditor('word_container',{elementPathEnabled : false});
        autodivheight();
        function autodivheight() {
            var winHeight = 0;
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;
            if (document.documentElement && document.documentElement.clientHeight)
                winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
            document.getElementById("lognewBox").style.height = winHeight - 46  + "px";
            document.getElementById("logInfo").style.height = winHeight - 46  + "px";
        }
        window.onresize = autodivheight;
        $('#uploadinputimg').fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);
                        var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"><a style="display:'+(isOpenSanyuan?"none":"block")+'" fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                    }
                    $('#query_uploadArr').append(str);
                }else{
                    //alert('添加附件大小不能为空!');
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
        $('#Folder').fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);
                        var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                    }
                    $('#query_uploadArr').append(str);
                }else{
                    //alert('添加附件大小不能为空!');
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
        //解决拖拽上传执行多次接口，文件夹上传方法如果被点击后执行
        $("#uploadimgform2").on('click',function (){
            var action = $("#uploadimgform2").attr("action")
            if(action=="/upload?module=email"){
                $("#uploadimgform2").attr("action","")
            }else {
                $("#uploadimgform2").attr("action","/upload?module=email")
            }
        })
//新建日志附件删除
        $('#query_uploadArr').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            $(this).parents('.dech').next('br').remove();
            deleteChatment(data,dome);
        })

        //删除附件
        function deleteChatment(data,element){

            layer.confirm('<fmt:message code="menuSSetting.th.isdeleteMenu" />？', {/*确定要删除吗*/
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮 /* 确定  取消*/
                title:'<fmt:message code="notice.th.DeleteAttachment" />'/*删除附件*/
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'../delete',
                    dataType:'json',
                    data:data,
                    success:function(res){

                        if(res.flag == true){
                            layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});/*删除成功*/
                            element.remove();
                        }else{
                            layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});/*删除失败*/
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }


        //日历插件
        $('#ca').calendar({
            width: 250,
            height: 160,
            data: [
                {
                    date: '2015/12/24',
                    value: 'Christmas Eve'
                },
                {
                    date: '2015/12/25',
                    value: 'Me rry Christmas'
                },
                {
                    date: '2016/01/01',
                    value: 'Happy New Year'
                }
            ],
            onSelected: function (view, date) {
                data.queryScope =5;   //queryScope=5
                datas.diaDate =  date.Format('yyyy-MM-dd');    //当前时间
                initPageList_rl(function (pageCount) {
                    initPagination_rl(pageCount, data.pageSize);
                });
            }
        });
        //新建日志的设置当前时间
        $("#inputsendTime").val(getNowFormatDate1());
        // 日历和高级查询的切换和隐藏
        $(".search_").on('click', function () {
            $("#diary-adv-search-box").toggle();
            $("#calendar_").toggle();

            //高级查询日期默认为本月
            $("#enddate").val(getNowFormatDate1());
            $("#startdate").val(getMonthStartDate());

            //  小箭头切换类名
            if ($("#diary-adv-search-box").css('display') == 'none') {
                $("#triangle").addClass("icon-chevron-down").removeClass("icon-chevron-up");
                document.getElementById("diary-search-box").style.borderTop = "1px solid #dbdbdb";

            } else {
                $("#triangle").addClass("icon-chevron-up").removeClass("icon-chevron-down");
                document.getElementById("diary-search-box").style.borderTop = "none"; //高级编辑的时候上边框为空

            }

        });




//        ##############################################################################################################

        //  评论的显示和隐藏???????????????????这段函数没啥鸟用。。。。。。。。。。。。。。
        $(".commentNumber").on('click', function () {

            $("#comment").toggle();
            if ($("#comment").css('display') == 'block') {
                document.getElementById("commentNumber").style.color = "#1687cb";
                document.getElementById("commentNumber").style.textDecoration = "underline";
            } else {
                document.getElementById("commentNumber").style.color = "#b4b4b4";
                document.getElementById("commentNumber").style.textDecoration = "none";
            }
        });




        // #################################################点击写日志按钮自动生成标题开始#######################################//
        //根据日期动态改变标题
        var subjectDynamicAlteration = {
            elem: '#inputsendTime', //目标元素
            format: 'YYYY-MM-DD', //日期格式
            istime: true, //显示时、分、秒
            istoday: false,
            choose: function (datas) {
                var day = turnDay((new Date(datas)).getDay());
                if ($('#diary_log option:checked').attr('value') == 1) {
                    $("#query_subject").val($("#inputsendTime").val() + " " + day + " " + "工作日志");
                } else if ($('#diary_log option:checked').attr('value') == 2) {
                    $("#query_subject").val($("#inputsendTime").val() + " " + day + " " + "个人日志");
                } else if ($('#diary_log option:checked').attr('value') == 3) {
                    $("#query_subject").val(getWeek($("#inputsendTime").val()) + " " + "工作周报");
                } else if ($('#diary_log option:checked').attr('value') == 4) {
                    $("#query_subject").val(turnTimeYm($("#inputsendTime").val()) + " " + "工作月报");
                }
                getDiaryDefault($("#diary_log").val());
            }
        };
        laydate(subjectDynamicAlteration);
        //时间处理函数将时间处理成yyyy-mm-dd格式
        function turnTime(t){
            var year  = t.getFullYear();
            var month = t.getMonth() + 1;
            var day = t.getDate();
            return year + "-" + plusZero(month) + "-" + plusZero(day);
        }
        //时间处理函数将时间处理成yyyy-mm格式
        function turnTimeYm(t){
            if (t != null){
                t = new Date(t);
            } else {
                t = new Date();
            }
            var year  = t.getFullYear();
            var month = t.getMonth() + 1;
            return year + "-" + plusZero(month);
        }
        //日期补零位数不够两位前面补零
        function plusZero(data){
            if(data>=10){
                return data
            }else{
                return "0"+data
            }

        }
        /*写日志中工作日志、个人日志显示隐藏*/
        $("#diary_log").on('change', function(){
            //切换日志类型，改变标题
            var day = turnDay((new Date($("#inputsendTime").val())).getDay());
            if ($('#diary_log option:checked').attr('value') == 1) {
                $("#query_subject").val($("#inputsendTime").val() + " " + day + " " + "工作日志");
            } else if ($('#diary_log option:checked').attr('value') == 2) {
                $("#query_subject").val($("#inputsendTime").val() + " " + day + " " + "个人日志");
            } else if ($('#diary_log option:checked').attr('value') == 3) {
                $("#query_subject").val(getWeek($("#inputsendTime").val()) + " " + "工作周报");
            } else if ($('#diary_log option:checked').attr('value') == 4) {
                $("#query_subject").val(turnTimeYm($("#inputsendTime").val()) + " " + "工作月报");
            }
            getDiaryDefault($("#diary_log").val());

            if ($('#diary_log option:checked').attr('value') == 2) {
                //隐藏阅评
                $("#yuepingdiv").hide();
                //隐藏共享
                $("#sharediv").hide();
            } else {
                $("#yuepingdiv").show();
                $("#sharediv").show();
            }
        });
        //获取当前周几
        function turnDay(d){
            switch(d){
                case 0:
                    return "星期日";
                case 1:
                    return "星期一";
                case 2:
                    return "星期二";
                case 3:
                    return "星期三";
                case 4:
                    return "星期四";
                case 5:
                    return "星期五";
                case 6:
                    return "星期六";
            }

        };
        //获取当前周一和周日
        function getWeek(date) {
            var now;
            if (date != null){
                now = new Date(date);
            } else {
                now = new Date();
            }
            var nowTime = now.getTime();
            var nowDay = now.getDay() == 0 ? 7 : now.getDay();  //为周日的时候day修改为7
            var oneDayTime = 24 * 60 * 60 * 1000;
            var MondayTime = nowTime - (nowDay - 1) * oneDayTime;
            var SundayTime = nowTime + (7 - nowDay) * oneDayTime;
            var Mondaydate = new Date(MondayTime);
            var Sundaydate = new Date(SundayTime);
            var seperator = "-";
            //Monday
            var year = Mondaydate.getFullYear();
            var month = plusZero(Mondaydate.getMonth() + 1);
            var day = plusZero(Mondaydate.getDate());
            var Monday = year + seperator + month + seperator + day;
            //Sunday
            var year = Sundaydate.getFullYear();
            var month = plusZero(Sundaydate.getMonth() + 1);
            var day = plusZero(Sundaydate.getDate());
            var Sunday = year + seperator + month + seperator + day;
            return Monday + " - " + Sunday;
        };
        //自动填充标题
        $("#writeLog").on("click", function () {
            $("#logInfo").hide();
            $("#logNew").show();
            $(".log").html("<fmt:message code="diary.th.new"/>");
            $('#hd').attr('ac','add');
            $('#hds').attr('ac','add');
            //新建工作日志时，根据角色选择默认日志类型
            var diaType = "1";
            var diaTypeName = "工作日志";
            var date = turnTime(new Date());
            var day = turnDay((new Date()).getDay());
            $("#query_subject").val(date + " " + day + " " + diaTypeName);
            $.ajax({
                type:'get',
                url:'/diary/selectUserDiaType',
                dataType:'json',
                success:function(res){
                    if(res.flag && res.object != null){
                        diaType = res.object.diaType;
                        if (diaType == "1"){
                            //日报
                            $("#diary_log").val(1);
                        } else if (diaType == "3"){
                            //周报
                            diaTypeName = "工作周报";
                            $("#query_subject").val(getWeek() + " " + diaTypeName);
                            $("#diary_log").val(3);
                        } else if (diaType == "4"){
                            //月报
                            diaTypeName = "工作月报";
                            $("#query_subject").val(turnTimeYm() + " " + diaTypeName);
                            $("#diary_log").val(4);
                        }
                    }
                    getDiaryDefault($("#diary_log").val());
                }
            });

            $.ajax({
                type: 'get',
                url: '/sysTasks/getSysParaList',
                dataType: 'json',
                data:{
                    paraName:'DIARY_WORK_LOG_FORMAT'
                },
                success: function (res) {
                    if(res.flag){
                        if(res.obj.length != 0){
                            if(res.obj[0].paraValue != '' && res.obj[0].paraValue != '不使用模板'){
                                var modelId = res.obj[0].paraValue;
                                $.ajax({
                                    type: 'get',
                                    url: '/htmlModel/selectAllHtmlModel',
                                    dataType: 'json',
                                    data:{
                                        modelId:modelId
                                    },
                                    success: function (res) {
                                        if(res.flag){
                                            newKindEditorObj.html(res.obj[0].contentStr);
                                        }
                                    }
                                })
                            }
                        }


                    }
                }
            })
            share();

        });
        // #################################################点击写日志按钮自动生成标题结束#######################################//
        //新建页面的返回按钮
        $("#rs").on("click", function () {
            $("#logInfo").show();
            $("#logNew").hide();
            $("#moreButtonDiv").hide();
            moreButtonStr="";

            var btn = $('.button_news .active').attr('id');
            if (btn == "oneselfPeople") {
                initPageList_zj(function (pageCount) {
                    initPageList_zj(pageCount, data.pageSize);
                });
            } else if (btn == "myOutline") {
                initPageList_my(function (pageCount) {
                    initPagination_my(pageCount, data.pageSize);
                });
            }
        });
        //点击看所有人按钮
        $("#allPeople").on("click", function () {
            $('#detailss').hide();
            $("#moreButtonDiv").hide();
            moreButtonStr="";
            $(this).addClass('active').siblings('').removeClass('active');
            $('input[name="dirayType"]').val('0');
            data.page = 1;
            initPageList_sy(function (pageCount) {
                //分页函数
                initPagination_sy(pageCount, data.pageSize);
            });

        });
        $("#moreButton").on("click", function () {
            $("#moreButtonDiv").show();
            moreButtonStr="all";
            $('#detailss').hide();
            $('input[name="dirayType"]').val('1');
            $(this).addClass('active').siblings('').removeClass('active');
            data.page = 1;
            initPageList_qt(function (pageCount) {
                initPagination_qt(pageCount, data.pageSize);
            });

        });
        //点击左侧全部日志按钮
        $("#all").on("click", function () {
            initPageList_sy(function (pageCount) {
                initPagination_sy(pageCount, data.pageSize);
            });
            $("#allPeople").addClass('active').siblings('').removeClass('active');
        });
        //点击看自己按钮
        <!-- 介意用异步 -->
        $("#oneselfPeople").on("click", function () {
            $('#detailss').hide();
            $('#moreButtonDiv').hide();
            moreButtonStr="";
            $('input[name="dirayType"]').val('2');
            $(this).addClass('active').siblings('').removeClass('active');
            initPageList_zj(function (pageCount) {
                initPagination_zj(pageCount, data.pageSize);
            });
        });
        //我的草稿
        $("#myOutline").on("click", function () {
            $("#moreButtonDiv").hide();
            moreButtonStr="";
            $(this).addClass('active').siblings('').removeClass('active');
            initPageList_my(function (pageCount) {
                initPagination_my(pageCount, data.pageSize);
            });
        });
        $("#mine").on("click", function () {
            /*$(this).addClass('active').siblings('').removeClass('active');*/
            initPageList_zj(function (pageCount) {
                initPagination_zj(pageCount, data.pageSize);
            });
            $("#oneselfPeople").addClass('active').siblings('').removeClass('active');
        });
        initPageList_zj(function (pageCount) {
            initPagination_zj(pageCount, data.pageSize);
        });
        //点击看其他人按钮
        <!-- 介意用异步 -->
        $("#otherPeople").on("click", function () {
            $("#moreButtonDiv").show();
            moreButtonStr="";
            $('#detailss').hide();
            $('input[name="dirayType"]').val('1');
            $(this).addClass('active').siblings('').removeClass('active');
            data.page = 1;
            initPageList_qt(function (pageCount) {
                initPagination_qt(pageCount, data.pageSize);
            });
        });
        $("#others").on("click", function () {
            initPageList_qt(function (pageCount) {
                initPagination_qt(pageCount, data.pageSize);
            });
            $("#otherPeople").addClass('active').siblings('').removeClass('active');
        })
        //获取3天内的日期
        $("#recent3day").on("click", function () {
            $("#enddate").val(getNowFormatDate1());
            $("#startdate").val(getNowFormatDate2());
        });
        //获取本周内的日期
        $("#recent1week").on("click", function () {
            $("#enddate").val(getNowFormatDate1());
            $("#startdate").val(getWeekStartDate());
        });
        //获取本月内的日期
        $("#recent1month").on("click", function () {
            $("#enddate").val(getNowFormatDate1());
            $("#startdate").val(getMonthStartDate());
        });
        //高级查询接口
        $("#buttonQuery").on("click", function () {
            $('#detailss').hide()
            if($('#oneselfPeople').attr('class').indexOf('active')>-1){
                //我的日志
                data.diaDate = $("#startdate").val();   //查询时间 开始
                data.timeEnd = $("#enddate").val();    //查询时间 结束
                data.userIds = $("#add_selectUser").attr("user_id");    //查询范围 人员范围
                data.userPrivs = $("#add_selectjuese").attr("userpriv");   //查询范围 角色范围
                data.deptIds = $("#dept").attr("deptid");  //查询范围部门范围
                data.type=1
                data.sFlag='1'
                // data.queryScope = $('#diarytype option:checked').attr('value');   //高级查询的范围
                initPageList_query(function (pageCount) {
                    initPagination_query(pageCount, data.pageSize);
                });
            }else if($('#myOutline').attr('class').indexOf('active')>-1){
                //我的草稿
                data.diaDate = $("#startdate").val();   //查询时间 开始
                data.timeEnd = $("#enddate").val();    //查询时间 结束
                data.userIds = $("#add_selectUser").attr("user_id");    //查询范围 人员范围
                data.userPrivs = $("#add_selectjuese").attr("userpriv");   //查询范围 角色范围
                data.deptIds = $("#dept").attr("deptid");  //查询范围部门范围
                data.type=4
                data.sFlag='0'
                // data.queryScope = $('#diarytype option:checked').attr('value');   //高级查询的范围
                initPageList_query(function (pageCount) {
                    initPagination_query(pageCount, data.pageSize);
                });
            }else if($('#otherPeople').attr('class').indexOf('active')>-1){
                //共享日志
                data.diaDate = $("#startdate").val();   //查询时间 开始
                data.timeEnd = $("#enddate").val();    //查询时间 结束
                data.userIds = $("#add_selectUser").attr("user_id");    //查询范围 人员范围
                data.userPrivs = $("#add_selectjuese").attr("userpriv");   //查询范围 角色范围
                data.deptIds = $("#dept").attr("deptid");  //查询范围部门范围
                data.type=2
                data.sFlag='1'
                // data.queryScope = $('#diarytype option:checked').attr('value');   //高级查询的范围
                initPageList_query(function (pageCount) {
                    initPagination_query(pageCount, data.pageSize);
                });
            }else if($('#allPeople').attr('class').indexOf('active')>-1){
                //下属日志
                data.diaDate = $("#startdate").val();   //查询时间 开始
                data.timeEnd = $("#enddate").val();    //查询时间 结束
                data.userIds = $("#add_selectUser").attr("user_id");    //查询范围 人员范围
                data.userPrivs = $("#add_selectjuese").attr("userpriv");   //查询范围 角色范围
                data.deptIds = $("#dept").attr("deptid");  //查询范围部门范围
                data.type=3;
                data.sFlag='1'
                data.isSubordinateLog=1;
                // data.queryScope = $('#diarytype option:checked').attr('value');   //高级查询的范围
                initPageList_query(function (pageCount) {
                    initPagination_query(pageCount, data.pageSize);
                });
            }
            //未写日志人员
            if(data.queryScope != 2){
                // $('#detailss').css("display","block");
                var str = $("#dept").val();
                var lastIndex = str.lastIndexOf(',');
                if (lastIndex > -1) {
                    str = str.substring(0, lastIndex) + str.substring(lastIndex + 1, str.length);
                }

                if(str==''){
                    var lis='<button type="button"  style="background-color: #2F8AE3;color: #fff;border-radius:5%;font-size: 14px">'+data.diaDate+'至'+data.timeEnd+'</button>'
                    $('#addbutton').html(lis);
                }
                if(str){
                    var lis='<button type="button" style="background-color: #2F8AE3;color: #fff;border-radius:5%;font-size: 14px">'+str+'</button>&nbsp;&nbsp;<button type="button"  style="background-color: #2F8AE3;color: #fff;border-radius:5%;font-size: 14px ">'+data.diaDate+'至'+data.timeEnd+'</button>'
                    $('#addbutton').html(lis);
                }

                /* $.ajax({
                     url: '/diary/diarySelect',
                     type: 'post',
                     dataType: "JSON",
                     async: false,
                     success: function (res) {
                         var userString = res.object
                         var strs='<textarea name="desc" placeholder="" class="layui-textarea" style="border: none;resize:none;">'+userString+'</textarea>'
                         console.log(userString);
                         $('#addspan').html(strs);

                     }
                 })*/
            }
        });
        $('#buttonExport').on("click", function () {
            data.diaDate = $("#startdate").val();   //查询时间 开始
            data.timeEnd = $("#enddate").val();    //查询时间 结束
            data.userIds = $("#add_selectUser").attr("user_id");    //查询范围 人员范围
            data.userPrivs = $("#add_selectjuese").attr("userpriv");   //查询范围 角色范围
            data.deptIds = $("#dept").attr("deptid");  //查询范围部门范围
            if($('#oneselfPeople').attr('class').indexOf('active')>-1){
                data.type=1
                data.sFlag='1'
                data.isExport='1'
            }else if($('#myOutline').attr('class').indexOf('active')>-1){
                data.type=4
                data.sFlag='0'
                data.isExport='1'
            }else if($('#otherPeople').attr('class').indexOf('active')>-1){
                data.type=2
                data.sFlag='1'
                data.isExport='1'
            }else if($('#allPeople').attr('class').indexOf('active')>-1){
                data.type=3
                data.sFlag='1'
                data.isExport='1'
            }
            window.location.href='/diary/findDiaryGet?diaDate='+data.diaDate+'&timeEnd='+data.timeEnd+
                '&type='+data.type+'&sFlag='+data.sFlag+'&isExport='+data.isExport;
        })
        //新建日志 编辑日志 提交接口
        $("#hd").on("click",function(){
            //判断密级非空
            if(isShowSecret && $("#SecretLevels").val() === ""){
                layer.msg('请选择密级',{icon:5})
                return false;
            }
            //是提交按钮失效，避免多次提交
            $("#hd").css("pointer-events","none");
            $("#hds").css("pointer-events","none");

            var shareAll = $("#is_set").is(":checked")?1:0;//是否设为默认共享范围
            var sendRemind = $("#is_remind").is(":checked")?1:0;//是否发送事务提醒
            var allowComment = $('input:radio[name="dian"]:checked').val();
            var aId = '';
            var uId = '';
            for(var i = 0; i < $('#query_uploadArr').children("div.dech").length; i++){
                if ($('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).attr('name') != undefined){
                    aId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).val();
                    uId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).attr('name');
                } else {
                    aId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).val();
                    uId += $('#query_uploadArr').children("div.dech").eq(i).children("a").eq(0).attr('name');
                }
            };

            //中高管模板新建，修改时处理
            if ($('#diary_log').val() == 3 && isZhongGaoGuan == 1){
                templateToEditor(3);
            }
            var content = newKindEditorObj.html();
            //处理富文本自动生成的<br/>
            while (true){
                var beginbr = content.substring(0,7);
                if (beginbr != "<br />\n"){
                    break;
                }
                content = content.substring(7);
            }

            if (content == ""){
                $.layerMsg({content: '日志内容不能为空！', icon: 2});
                $("#hd").css("pointer-events","auto");
                $("#hds").css("pointer-events","auto");
                return false;
            } else if (($("#yuep").attr('user_id') == undefined || $("#yuep").attr('user_id') == "") && $('#diary_log option:checked').attr('value') != 2) {
                $.layerMsg({content: '您没有阅评上级，无法保存，只可以保存个人日志！', icon: 2});
                $("#hd").css("pointer-events","auto");
                $("#hds").css("pointer-events","auto");
                return false;
            }

            if ($("#yuepingdiv").css("display") == "none"){
                $("#yuep").attr("user_id", "");
            }
            if ($("#sharediv").css("display") == "none"){
                $("#add_text").attr("user_id", "");
            }
            var data = {
                "userId":$(this).attr("userId"),
                "diaType": $('#diary_log option:checked').attr('value'),    // (日志类型(1-工作日志,2-个人日志,3-工作周报,4-工作月报))
                "subject": $("#query_subject").val(),      //（日志标题）
                "content": content  ,//（日志内容）
                "toAll":0,// （是否全部共享(0-否,1-是)）
                "toId": $("#add_text").attr("user_id"), //（共享用户ID串,人员控件）
                "attachmentId":aId,//（附件ID串）
                "attachmentName":uId, //（附件名称串）
                "diaDate":$('#inputsendTime').val(),
                "shareAll":shareAll,
                "sendRemind":sendRemind,
                "sFlag":1,
                "allowComment":allowComment,
                "userTopId":$("#yuep").attr('user_id'),
                "contentSecrecy":$('#SecretLevels').val() || ""
            };
            if($(this).attr("ac")=="update"){
                var noId=$(this).attr("noId");
                data['diaId']=noId;
                update(data);
            }else if($(this).attr("ac")=="add") {
                add_log(data);
            };

            //新建保存的数据接口
            function add_log(data){
                $.ajax({
                    type: "post",
                    url: "/diary/save",
                    dataType: 'json',
                    data: data,
                    success: function (obj) {
                        $.layerMsg({content:'<fmt:message code="diary.th.modify"/>！',icon:1},function(){
                            $("#hd").css("pointer-events","auto");
                            $("#hds").css("pointer-events","auto");
                            $("#logInfo").show();
                            $("#logNew").hide();
                            location.reload();
                        });
                    }
                });
            };
            //修改保存的数据接口
            function update(data){
                $.ajax({
                    url: "/diary/update",
                    type: "post",
                    data: data,
                    dataType: 'json',
                    success: function (obj) {
                        $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                            $("#hd").css("pointer-events","auto");
                            $("#hds").css("pointer-events","auto");
                            $("#logInfo").show();
                            $("#logNew").hide();
                            $("#moreButtonDiv").hide();
                            moreButtonStr="";
                            $(this).addClass('active').siblings('').removeClass('active');
                            initPageList_my(function (pageCount) {
                                initPagination_my(pageCount, data.pageSize);
                            });
                        });
                    }
                })
            }
        })
        //新建日志 编辑日志 保存接口
        $("#hds").on("click",function(){
            //判断密级非空
            if(isShowSecret && $("#SecretLevels").val() === ""){
                layer.msg('请选择密级',{icon:5})
                return;
            }
            //是提交按钮失效，避免多次提交
            $("#hd").css("pointer-events","none");
            $("#hds").css("pointer-events","none");

            var shareAll = $("#is_set").is(":checked")?1:0;//是否设为默认共享范围
            var sendRemind = $("#is_remind").is(":checked")?1:0;//是否发送事务提醒
            var allowComment = $('input:radio[name="dian"]:checked').val();
            var aId = '';
            var uId = '';
            for(var i = 0; i < $('#query_uploadArr').children("div.dech").length; i++){
                if ($('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).attr('name') != undefined){
                    aId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).val();
                    uId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).attr('name');
                } else {
                    aId += $('#query_uploadArr').children("div.dech").eq(i).children("input.inHidden").eq(0).val();
                    uId += $('#query_uploadArr').children("div.dech").eq(i).children("a").eq(0).attr('name');
                }
            };

            //中高管模板新建，修改时处理
            if ($('#diary_log').val() == 3 && isZhongGaoGuan == 1){
                templateToEditor(3);
            }
            var content = newKindEditorObj.html();
            //处理富文本自动生成的<br/>
            while (true){
                var beginbr = content.substring(0,7);
                if (beginbr != "<br />\n"){
                    break;
                }
                content = content.substring(7);
            }

            if(newKindEditorObj.html() == ''){
                $.layerMsg({content: '日志内容不能为空！', icon: 2});
                $("#hd").css("pointer-events","auto");
                $("#hds").css("pointer-events","auto");
                return false;
            }
            if ($("#yuepingdiv").css("display") == "none"){
                $("#yuep").attr("user_id", "");
            }
            if ($("#sharediv").css("display") == "none"){
                $("#add_text").attr("user_id", "");
            }
            var data = {
                "userId":$(this).attr("userId"),
                "diaType": $('#diary_log option:checked').attr('value'),    // (日志类型(1-工作日志,2-个人日志))
                "subject": $("#query_subject").val(),      //（日志标题）
                "content": content  ,//（日志内容）
                "toAll":0,// （是否全部共享(0-否,1-是)）
                "toId": $("#add_text").attr("user_id"), //（共享用户ID串,人员控件）
                "attachmentId":aId,//（附件ID串）
                "attachmentName":uId, //（附件名称串）
                "diaDate":$('#inputsendTime').val(),
                "shareAll":shareAll,
                "sendRemind":sendRemind,
                "sFlag":0,
                "allowComment":allowComment,
                "userTopId":$("#yuep").attr('user_id'),
                "contentSecrecy":$('#SecretLevels').val() || ""
            };
            if($(this).attr("ac")=="update"){
                var noId=$(this).attr("noId");
                data['diaId']=noId;
                update(data);
            }else if($(this).attr("ac")=="add") {
                var noId=$(this).attr("noId");
                data['diaId']=noId;
                add_log(data);
            };
            //新建保存的数据接口
            function add_log(data){
                $.ajax({
                    type: "post",
                    url: "/diary/save",
                    dataType: 'json',
                    data: data,
                    success: function (obj) {
                        $.layerMsg({content:'<fmt:message code="diary.th.modify"/>！',icon:1},function(){
                            $("#hd").css("pointer-events","auto");
                            $("#hds").css("pointer-events","auto");
                            $("#logInfo").show();
                            $("#logNew").hide();
                            location.reload();
                        });
                    }
                });
            };
            //修改保存的数据接口
            function update(data){
                $.ajax({
                    url: "/diary/update",
                    type: "post",
                    data: data,
                    dataType: 'json',
                    success: function (obj) {
                        $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                            $("#hd").css("pointer-events","auto");
                            $("#hds").css("pointer-events","auto");
                            $("#logInfo").show();
                            $("#logNew").hide();
                            $("#moreButtonDiv").hide();
                            moreButtonStr="";
                            $('#myOutline').addClass('active').siblings('').removeClass('active');
                            initPageList_my(function (pageCount) {
                                initPagination_my(pageCount, data.pageSize);
                            });
                            // location.reload();
                        });
                    }
                })
            }
        })
        // 删除评论
        $('.feed-cmt-del-handle').on('click',function () {
        })
    });

    //日志共享弹窗
    function share_log(that,types){
        var shareId=that.attr('share-id');
        var shareName=that.attr('share-name');
        var diarId=that.attr('diaId');
        layer.open({
            type: 1,
            /* skin: 'layui-layer-rim', //加上边框 */
            offset: '80px',
            area: ['400px', '300px'], //宽高
            <%--title:'<fmt:message code="diary.th.Share"/>',--%>
            title:'人员共享',
            closeBtn: 0,
            content: '<div id="" class="ry">'+
                <%--'<label class="control-label"><b class="date"><fmt:message code="diary.th.body"/></b></label>'+--%>
                '<div class="controls">'+
                '<textarea class="inText" id="gx_text" type="text" disabled></textarea>'+
                '<div id="add_gx"><fmt:message code="global.lang.add"/></div>'+
                '<div id="clear_gx"><fmt:message code="global.lang.empty"/></div>'+
                '</div>'+
                ' </div>',
            btn:['<fmt:message code="global.lang.ok"/>', '<fmt:message code="global.lang.close"/>'],
            success:function () {
                $('#gx_text').attr('user_id',shareId);
                $('#gx_text').val(shareName);
            },
            yes: function(){
                var userId=$('#gx_text').attr('user_id');

                commentShare(diarId,userId,types);
                layer.closeAll();
            }
        });
        $('#add_gx').on('click',function(){
            user_id='gx_text';
            $.popWindow("../common/selectUser");
        })
        $('#clear_gx').on('click',function(){
            $('#gx_text').val('');
            $('#gx_text').attr('username','');
            $('#gx_text').attr('dataid','');
            $('#gx_text').attr('user_id','');
            $('#gx_text').attr('userprivname','');
        })
    }
    //日志共享接口
    function commentShare(id,userId,types){
        $.ajax({
            type:'post',
            url:'/diary/update',
            dataType:'json',
            data:{'diaId':id,'toId':userId},
            success:function(){
                $.layerMsg({content:'<fmt:message code="diary.th.sharedSuccess" />！',icon:1});/*共享成功*/
                if(types == '0'){
                    initPageList_sy()
                }else if(types == '2'){
                    initPageList_zj()
                }else if(types == '1'){
                    initPageList_qt()
                }else if(types == '4'){
                    initPageList_query()
                }
            }
        })
    }
    //日志删除接口
    function delete_log(i,type){
        var data1={
            'diaId':$(".delete"+i).attr("del")
        };
        $.layerConfirm({title:'<fmt:message code="workflow.th.suredel"/>',content:'<fmt:message code="workflow.th.que"/>',icon:0},function(){
            $.ajax({
                url:"/diary/delete",
                type:'get',
                dataType:"JSON",
                data : data1,
                success:function(dataResult){
                    if (dataResult.code == '100066'){
                        layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                    }else {
                        if("allPeople"==$(".active").attr("id")){
                            $(this).addClass('active').siblings('').removeClass('active');
                            initPageList_sy(function (pageCount) {
                                initPagination_sy(pageCount, data.pageSize);
                            });
                        }else{
                            if(type) {
                                // location.reload();
                                $("#moreButtonDiv").hide();
                                moreButtonStr="";
                                $('#myOutline').addClass('active').siblings('').removeClass('active');
                                initPageList_my(function (pageCount) {
                                    initPagination_my(pageCount, data.pageSize);
                                });

                            }else {
                                location.reload();
                            }

                        }
                    }
                },
                error:function(e){
                    console.log(e);
                }
            });
        },function(){
            return false;
        })
    }
    //日志编辑接口
    function edit_log(i){
        $("#logInfo").hide();
        $("#logNew").show();
        $(".log").html("<fmt:message code="diary.th.modi"/>");
        if($(".edit"+i).attr("sFlag") == '1'){
            $('#hd').html('保存');
            $('#hds').css('display',"none");
        }
        $('#hd').attr('ac',"update");
        $('#hd').attr('noId',$(".edit"+i).attr("del"));
        $('#hd').attr('sFlag',$(".edit"+i).attr("sFlag"));

        $('#hds').attr('ac',"update");
        $('#hds').attr('noId',$(".edit"+i).attr("del"));
        $('#hds').attr('sFlag',$(".edit"+i).attr("sFlag"));
        var data={
            'diaId':$(".edit"+i).attr("del")
        };
        /* alert(data.diaId);*/
        $.ajax({
            url:"/diary/getConByDiaId",
            type:'get',
            dataType:"JSON",
            data : data,
            success:function(data){
                $('#hd').attr('userId',data.object.userId);
                $("#inputsendTime").val(data.object.diaDate)
                $('#hds').attr('userId',data.object.userId);
                $("#SecretLevels").val(data.object.contentSecrecy)
                $("#yuep").attr('user_id',data.object.userTopId)
                $("#yuep").val(data.object.userTopIdName)
                $('input:radio[name="dian"][value="'+data.object.allowComment+'"]').attr('checked','true')
                $("#diary_log").find("option[value="+data.object.diaType+"]").attr("selected",true);//(日志类型(1-工作日志,2-个人日志))
                $("#query_subject").val(data.object.subject); //（日志标题）

                // ue.setContent(data.object.content);//（日志内容）
                newKindEditorObj.html(data.object.content);//（日志内容）
                //编辑回显中高管模板
                templateInit(data.object.diaType, true);

                if(data.object.diaType==1){
                    $("#dia_share").show();
                }else{
                    $("#dia_share").hide();
                };// （日志类型(1-工作日志,2-个人日志 控制显示隐藏）
                if(data.object.toIdName == ""){
                    $('input:checkbox').attr("checked", false);
                    $("#share").hide();
                }else{
                    $('input:checkbox').attr("checked", true);
                    $("#share").show();
                };// （是否全部共享(0-否,1-是)）
                $("#add_text").val(data.object.toIdName);//（共享用户ID串,人员控件）
                $("#add_text").attr("user_id",data.object.toId);
                //附件下载
                var str1 = "";
                var arr = new Array();
                arr = data.object.attachment;
                if (data.attachmentName != '') {
                    for (var i = 0; i < (arr.length); i++) {
                        str1 += '<div class="font_ dech" deUrl="'+arr[i].attUrl+'"><a href="/download?' + encodeURI(arr[i].attUrl) + '"><img class="img_" src="../img/enclosure.png"/>' + arr[i].attachName + '</a>' +
                            '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>'+
                            '<a target="_blank" style="margin: 0 10px 0 30px;"  color: #207BD6;" href="'+function () {
                                var importUrl = encodeURI(arr[i].attUrl);
                                var d = /\.[^\.]+$/.exec(importUrl);
                                var ds= d[0].slice(1,d[0].length).toLowerCase()
                                if(ds=='pdf'){
                                    return '/pdfPreview?'+ encodeURI(arr[i].attUrl)
                                }
                                else if(ds=='docx' || ds=='doc'){
                                    return '/common/ntkoview?'+ encodeURI(arr[i].attUrl)
                                }
                                else if(ds=='xls'|| ds=='xlsx') {
                                    var url = '/common/webOfficeView?documentEditPriv=0&' + encodeURI(arr[i].attUrl);
                                    $.ajax({
                                        url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                                        type:'post',
                                        datatype:'json',
                                        async:false,
                                        success: function (res) {
                                            if(res.flag){
                                                if(res.object[0].paraValue == 0){
                                                    //默认加载NTKO插件 进行跳转
                                                    url = '/common/ntkoview?documentEditPriv=0&' + encodeURI(arr[i].attUrl);
                                                }else if(res.object[0].paraValue == 2){
                                                    //默认加载NTKO插件 进行跳转
                                                    url = "/wps/info?"+ encodeURI(arr[i].attUrl) +"&permission=read";
                                                }else if(res.object[0].paraValue == 3){
                                                    //默认加载onlyoffice插件 进行跳转
                                                    url = "/common/onlyoffice?"+ encodeURI(arr[i].attUrl) +"&edit=false";
                                                }
                                            }

                                        }
                                    })
                                    return url
                                }else{
                                    return '/xs?'+ encodeURI(arr[i].attUrl)
                                }

                            }() + '">查阅</a>' +
                            '<a download="'+ arr[i].attUrl+'" href="/download?'+ arr[i].attUrl  + '" style="margin-left:10px;    color: #207BD6;"><fmt:message code="file.th.download" /></a>'+
                            '</div></br>'+
                            '<input type="hidden" class="inHidden" NAME="'+arr[i].attachName+'*" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',">';
                    }
                    $('#query_uploadArr').append(str1);
                };
                $()
            },
            error:function(e){
                console.log(e);
            }
        });
    }
    /* 日志详情页 */
    function windowOpen(i,that){
        var personName=that.attr('share-name')
        var nid = i;
        var personId=that.attr('share-id')
        <%--$.popWindow("/diary/details?id="+nid+"")--%>
        window.open ("/diary/details?id="+nid+'&personName='+personName + '&personId=' + personId, "newwindow", "height=1200, width=1600, top=100, left=300, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no")
    }

    //看你自己评论的显示和隐藏
    function details(i,diaId) {
        $('.btn-primary').attr('btnType','2');
        if ($("#comment" + i).css('display') == 'block') {
            $("#comment" + i).hide();
            $(".commentNumber" + i).removeClass("font_color");
        } else {
            disComment(i,diaId)
            $("#comment" + i).show();
            $(".commentNumber" + i).addClass("font_color");
            var a=$('.feed-ext-comment-sms-advcomment');

            a.on('click',function () {
                var ischecked = $(this).find("[name='advcomment']").prop('checked');

                var ue;
                if(ischecked){
                    $textarea= $(this).parents().children('.feed-submit-cmt-context');
                    var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';
                    $($textarea).prop('id',$id);
                    ue = UE.getEditor($id);
                }else{

                    $textarea= $(this).parents().children('.feed-submit-cmt-context');
                    var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';

                    $($textarea).removeProp('id');

                    UE.getEditor($id).destroy();


                }
            })
            $('.txt').on('click',function(){//隐藏富文本
                //console.log('123')
                $('.feed-submit-cmt-context').css('height',0)
                $('.feed-submit-cmt-context').show();
                $(".edui-editor").hide();
            })
            $('.advcomment').on('click',function(){//显示富文本

                //$(".feed-ext-add-comment .feed-submit-cmt-context").css('height',87);
                //console.log('478')
                $(".edui-editor").show();
            })
            $('.feed-ext-comment-sms-advcomment .advcomment').eq(0).css('background','red');
        }
    };

    //我的日志
    function initPageList_zj(cb) {
        $("#details").html("");
        mydata.type=1
        mydata.sFlag='1'
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'get',
            dataType: "JSON",
            data: mydata,
            success: function (obj) {
                $.ajax({
                    url: "/diary/selectDiaryComment",
                    type: 'get',
                    dataType: "JSON",
                    success: function (data) {
                        var shu = data.obj.length
                        for(var i=0;i<shu;i++){
                            var str='';
                            str += '<li style="margin-top: 5px;"><span style="font-weight:bold;font-size:14px">'+data.obj[i].commenter+'</span>&nbsp;&nbsp;回复了&nbsp;&nbsp;<span diaid='+data.obj[i].diaId+' class="tiao" style="color: #1687cb;cursor:pointer;">《'+data.obj[i].subject+'》</span></li></br>'
                        }
                        $(".rightButtom").html(str)
                    }
                })
                if(obj.object != undefined){
                    $('.rightTop').html(obj.object.userName)
                    $('.shu li p').eq(0).html(obj.object.allDiaryNumber)
                    $('.shu li p').eq(1).html(obj.object.myDiaryNumber)
                    $('.shu li p').eq(2).html(obj.object.othersDiaryNumber)
                }
                if (obj.obj != undefined && obj.obj.length == 0) {
                    $("#qb").html(obj.msg.split(",")[0]);
                    $("#zj").html(obj.msg.split(",")[1]);
                    $("#tr").html(obj.msg.split(",")[2]);
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar != undefined && obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1" dailId="'+obj.obj[i].diaId+'">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info" >' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_Blank" style="color:#2B7FE0">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + function(){
                                if(obj.obj[i].diaTime	 == undefined){
                                    return ''
                                }else{
                                    return obj.obj[i].diaTime
                                }
                            }() + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' +obj.obj[i].diaId+ ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            '<div style="margin-bottom: 20px;text-overflow:ellipsis;white-space：nowrap;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNum commentNumber' + i + '" onclick= "details(' + i + ',' + obj.obj[i].diaId + ')" diaId="'+obj.obj[i].diaId + '"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            ' <li><a href="javascript:;" share-id="'+obj.obj[i].toId+'" share-name="'+obj.obj[i].toIdName+'" class="share' + i + '" diaId="'+obj.obj[i].diaId+'" onclick= "share_log($(this),2)"><fmt:message code="diary.th.Share"/></a></li>' +
                            '<li style="display:'+(isOpenSanyuan?"none":"block")+'"><a href="javascript:;"   del='+obj.obj[i].diaId+' class="edit' + i + '" onclick= "edit_log(' + i + ')" sFlag="1"><fmt:message code="global.lang.edit"/></a></li>' +
                            '<li><a href="javascript:;" del='+obj.obj[i].diaId+' class="delete' + i + '" onclick= "delete_log(' + i + ')"><fmt:message code="global.lang.delete"/></a></li>' +
                            ' <li><a href="javascript:;" onclick="setTop(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +
                            '  <li><a href="javascript:;" onclick="showReaders(' + i +','+ obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+ '" onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',1,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/> </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +
                            // 浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+
                            '</div>';
                    }
                    $("#qb").html(obj.msg.split(",")[0]);
                    $("#zj").html(obj.msg.split(",")[1]);
                    $("#tr").html(obj.msg.split(",")[2]);

                    $("#details").html(str);

                    tableHandling();

                    if (cb) {
                        cb(obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //我的日志分页函数
    function initPagination_zj(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: mydata.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                mydata.page = index.getCurrent();
                initPageList_zj(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_zj(pageCount, mydata.pageSize);
                });
            }
        });
    }
    //我的草稿
    function initPageList_my(cb) {
        $("#details").html("");
        mydata.type=4
        mydata.sFlag='0'
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'get',
            dataType: "JSON",
            data: mydata,
            success: function (obj) {
                if (obj.obj.length == 0) {
                    $("#qb").html(obj.msg.split(",")[0]);
                    $("#zj").html(obj.msg.split(",")[1]);
                    $("#tr").html(obj.msg.split(",")[2]);
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar != undefined && obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1" dailId="'+obj.obj[i].diaId+'">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info" >' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_Blank">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + function(){
                                if(obj.obj[i].diaTime	 == undefined){
                                    return ''
                                }else{
                                    return obj.obj[i].diaTime
                                }
                            }() + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' +obj.obj[i].diaId+ ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            '<div style="margin-bottom: 20px;text-overflow:ellipsis;overflow:hidden;white-space：nowrap;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNumber' + i + '" onclick= "details(' + i + ',' + obj.obj[i].diaId + ')"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            ' <li><a href="javascript:;" share-id="'+obj.obj[i].toId+'" share-name="'+obj.obj[i].toIdName+'" class="share' + i + '" diaId="'+obj.obj[i].diaId+'" onclick= "share_log($(this),2)"><fmt:message code="diary.th.Share"/></a></li>' +
                            '<li style="display:'+(isOpenSanyuan?"none":"block")+'"><a href="javascript:;"   del='+obj.obj[i].diaId+' class="edit' + i + '" onclick= "edit_log(' + i + ',cg)" sFlag="0"><fmt:message code="global.lang.edit"/></a></li>' +
                            '<li><a href="javascript:;" del='+obj.obj[i].diaId+' class="delete' + i + '" onclick= "delete_log(' + i + ',cg)"><fmt:message code="global.lang.delete"/></a></li>' +
                            ' <li><a href="javascript:;" onclick="setTop(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +
                            '  <li><a href="javascript:;" onclick="showReaders(' + i +','+ obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+ '" onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',1,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/> </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +
                            // 浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+
                            '</div>';
                    }
                    $("#qb").html(obj.msg.split(",")[0]);
                    $("#zj").html(obj.msg.split(",")[1]);
                    $("#tr").html(obj.msg.split(",")[2]);

                    $("#details").html(str);

                    tableHandling();

                    if (cb) {
                        cb(obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //我的草稿分页函数
    function initPagination_my(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: mydata.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                mydata.page = index.getCurrent();
                initPageList_zj(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_zj(pageCount, mydata.pageSize);
                });
            }
        });
    }
    //看所有人评论的显示和隐藏
    function details_sy(i,diaId) {
        if ($("#comment_sy" + i).css('display') == 'block') {
            $("#comment_sy" + i).hide();
            $(".commentNumber" + i).removeClass("font_color");

        } else {
            $.ajax({
                url: "/diary/getDiaryCommentByDiaId",
                type: 'get',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
//                        for (var j = 0; j < res.obj.length; j++) {
//                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">' +
//                                '<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
//                                '<div class="feed-cmt-list-ext">' +
//                                '<span style="margin-right: 20px;">'+res.obj[j].sendTime+'</span>' +
//                                '<a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus">删除</a> ' +
//                                '<a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;" hidefocus="hidefocus">回复</a>' +
//                                '</div>' +
//                                '<div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
//                                '<div class="feed-cmt-attachments"> </div> ' +
//                                '</li>';
//                        }

                        for (var j = 0; j < res.obj.length; j++) {
                            var stra='';
                            if(res.obj[j].diaryCommentReplyModelList != ''){/*回复  删除 回复*/

                                for(var k=0; k<res.obj[j].diaryCommentReplyModelList.length; k++){

                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[k].replyerName+'</a>&nbsp; &nbsp;<span><fmt:message code="global.lang.reply" /></span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[k].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext">' +

                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[k].replyTime+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[k].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))"><fmt:message code="global.lang.delete" /></a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[k].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[k].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[k].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[k].replyerName+'" href="javascript:;"><fmt:message code="global.lang.reply" /></a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[k].replyComment+'</div> ' +
                                        '</li></ul>';
                                }/*删除 回复*/
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                    '</li>';
                            }else{ /*删除 回复*/
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span style="margin-right: 20px;">'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="menuSSetting.th.deleteMenu" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="email.th.reply" /></a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '</li>';
                            }

                        }

                        $("#comment_sy"+ i +" ul").html(str);
                    }
                }
            });
            $("#comment_sy" + i).show();


            $(".commentNumber" + i).addClass("font_color");

            var a=$('.feed-ext-comment-sms-advcomment');
            a.on('click',function () {
                var ischecked = $(this).find("[name='advcomment']").prop('checked');
                var ue;
                if(ischecked){


                    $textarea= $(this).parents().children('.feed-submit-cmt-context');
                    var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';
                    $($textarea).prop('id',$id);
                    ue = UE.getEditor($id);
                }else{

                    $textarea= $(this).parents().children('.feed-submit-cmt-context');
                    var $id=$(this).parents('.feed-ext-add-comment').parent().prop('id')+'s';

                    $($textarea).removeProp('id');

                    UE.getEditor($id).destroy();


                }

            })

            $('.feed-ext-comment-sms-advcomment .advcomment').eq(0).css('background','red');
        }


    };
    //下属日志函数
    function initPageList_sy(cb) {
        $("#details").html("");
        logs.type=3
        logs.sFlag='1'
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'post',
            dataType: "JSON",
            data: logs,
            success: function (obj) {
                if (obj.obj.length == 0) {
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar != undefined && obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info">' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_Blank" style="color:#2B7FE0">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + obj.obj[i].diaTime + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' + obj.obj[i].diaId + ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            //                            '<div>' + obj.obj[i].content + '</div>' +
                            '<div style="margin-bottom: 20px;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNum ' + 'commentNumber' + i + function(){ if(obj.obj[i].ismodulePrivUser==1){ return " displayNone" }else{return ""}}()+'" onclick= "details_sy(' + i + ',' + obj.obj[i].diaId + ')" diaId="'+obj.obj[i].diaId + '"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            ' <li><a href="javascript:;" share-id="'+obj.obj[i].toId+'" share-name="'+obj.obj[i].toIdName+'" class="displayNone share' + i + '"  onclick= "share_log($(this),0)"><fmt:message code="diary.th.Share"/></a></li>' +
                            '<li style="display:'+(isOpenSanyuan?"none":"block")+'"><a href="javascript:;"  del='+obj.obj[i].diaId+' class="displayNone edit' + i + '" onclick= "edit_log(' + i + ')"><fmt:message code="global.lang.edit"/></a></li>' ;
                        if($.cookie('userId')== obj.obj[i].userId){
                            str+=  '<li><a href="javascript:;" del='+obj.obj[i].diaId+' class="displayNone delete' + i + '" onclick= "delete_log(' + i + ')"><fmt:message code="global.lang.delete"/></a></li>' ;
                        }
                        str+=   ' <li><a href="javascript:;"  class="displayNone" onclick="setTop(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +
                            '  <li><a href="javascript:;" onclick="showReaders(' + i + ',' + obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment_sy' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+ '" onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',2,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/> </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +

                            // 浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+

                            '</div>'
                    }
                    $("#qb").html();

                    $("#details").html(str);

                    tableHandling();

                    if (cb) {
                        cb(obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //下属日志函数分页函数
    function initPagination_sy(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: logs.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                logs.page = index.getCurrent();
                initPageList_sy(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_sy(pageCount, logs.pageSize);
                });
            }
        });
    }
    function imgerrorfun(){
        var img=event.srcElement;
        img.src="/img/user/boy.png";
        img.onerror=null;
    }
    //看其他人的评论的显示和隐藏
    function details_qt(i,diaId) {
        if ($("#comment_qt" + i).css('display') == 'block') {
            $("#comment_qt" + i).hide();
            $(".commentNumber" + i).removeClass("font_color");

        } else {
            $.ajax({
                url: "/diary/getDiaryCommentByDiaId",
                type: 'get',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){

                        for (var j = 0; j < res.obj.length; j++) {/*删除 回复*/
                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                '   <div class="feed-cmt-list-ext">' +
                                '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="menuSSetting.th.deleteMenu" /></a> ' +
                                '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="global.lang.reply" /></a>' +
                                '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                '   </div>    ' +
                                '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                '   <div class="feed-cmt-attachments"> </div> ' +
                                '</li>';
                        }

                        $("#comment_qt" + i +" ul").html(str);
                    }
                }
            });
            $("#comment_qt" + i).show();

            $(".commentNumber" + i).addClass("font_color");
            $('.txt').on('click',function(){//隐藏富文本
                //console.log('123')
                $('.feed-submit-cmt-context').css('height',0)
                $('.feed-submit-cmt-context').show();
                $(".edui-editor").hide();
            })
            $('.advcomment').on('click',function(){//显示富文本
                //$(".feed-ext-add-comment .feed-submit-cmt-context").css('height',87);
                //console.log('478')
                $(".edui-editor").show();
            })
            var a=$('.feed-ext-comment-sms-advcomment');

            a.on('click',function () {
                var ischecked = $(this).find("[name='advcomment']").prop('checked');

                var ue;
                if (ischecked) {
                    $textarea = $(this).parents().children('.feed-submit-cmt-context');
                    var $id = $(this).parents('.feed-ext-add-comment').parent().prop('id') + 's';
                    $($textarea).prop('id', $id);
                    ue = UE.getEditor($id);
                } else {

                    $textarea = $(this).parents().children('.feed-submit-cmt-context');
                    var $id = $(this).parents('.feed-ext-add-comment').parent().prop('id') + 's';

                    $($textarea).removeProp('id');

                    UE.getEditor($id).destroy();


                }



            })
        }
    };
    //共享日志的函数
    function initPageList_qt(cb) {
        // alert(moreButtonStr);
        $("#details").html("");
        sharedata.type=2
        sharedata.sFlag='1'
        sharedata.resultFlag=moreButtonStr;
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'post',
            dataType: "JSON",
            data: sharedata,
            success: function (obj) {
                if (obj.obj.length == 0) {
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar != undefined && obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info">' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_blank" style="color:#2B7FE0">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + obj.obj[i].diaTime + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' + obj.obj[i].diaId + ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            //                            '<div>' + obj.obj[i].content + '</div>' +
                            '<div style="margin-bottom: 20px;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNum  '+ function(){ if(obj.obj[i].isComments==0){ return " displayNone " } }()+'  commentNumber' + i + '" onclick= "details_qt(' + i + ',' + obj.obj[i].diaId + ')" diaId="'+obj.obj[i].diaId + '"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            <%--' <li><a href="javascript:;" share-id="'+obj.obj[i].toId+'" share-name="'+obj.obj[i].toIdName+'" class="share' + i + '" diaId="'+obj.obj[i].diaId+'" onclick= "share_log($(this),1)"><fmt:message code="diary.th.Share"/></a></li>' +--%>
                            <%--'<li><a href="javascript:;"   del='+obj.obj[i].diaId+' class="edit' + i + '" onclick= "edit_log(' + i + ')"><fmt:message code="global.lang.edit"/></a></li>' +--%>
                            <%--' <li><a href="javascript:;" onclick="setTop_qt(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +--%>
                            '  <li><a href="javascript:;" onclick="showReaders(' + i +','+ obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment_qt' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+ '" onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',3,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/> </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +

                            //浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+

                            '</div>'
                    }
                    $("#tr").html();

                    $("#details").html(str);

                    tableHandling();

                    if (cb) {
                        cb(obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //共享日志的分页函数
    function initPagination_qt(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: sharedata.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                sharedata.page = index.getCurrent();
                initPageList_qt(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_qt(pageCount, sharedata.pageSize);
                });
            }
        });
    }
    //高级查询的评论的显示和隐藏
    function details_query(i,diaId) {

        if ($("#comment_query" + i).css('display') == 'block') {
            $("#comment_query" + i).hide();
            $(".commentNumber" + i).removeClass("font_color");

        } else {
            $.ajax({
                url: "/diary/getDiaryCommentByDiaId",
                type: 'get',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        for (var j = 0; j < res.obj.length; j++) {
                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                '   <div class="feed-cmt-list-ext">' +
                                '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="global.lang.reply" /></a>' +
                                '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                '   </div>    ' +
                                '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                '   <div class="feed-cmt-attachments"> </div> ' +
                                '</li>';
                        }
                        $("#comment_query" + i+" ul").html(str);
                    }
                }
            });

            $("#comment_query" + i).show();

            $(".commentNumber" + i).addClass("font_color");
        }

    };
    //高级查询的函数
    function initPageList_query(cb) {
        $("#details").html("");
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'post',
            dataType: "JSON",
            data: data,
            async: false,
            success: function (obj) {
                if (obj.obj.length == 0) {
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                    if(data.queryScope != 2){
                        var userString = obj.object
                        var strs='<textarea readonly name="desc" placeholder="" class="layui-textarea" style="border: none;resize:none;width:100%;height:100%;font-size: 13px ">'+userString+'</textarea>'
                        $('#addspan').html(strs);
                    }
                } else {
                    if(data.queryScope != 2){
                        var userString = obj.object
                        var strs='<textarea readonly name="desc" placeholder="" class="layui-textarea" style="border: none;resize:none;width:100%;height:100%;font-size: 13px ">'+userString+'</textarea>'
                        $('#addspan').html(strs);
                    }
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar != undefined && obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info">' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_blank" style="color:#2B7FE0">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + obj.obj[i].diaTime + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' + obj.obj[i].diaId + ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            //                            '<div>' + obj.obj[i].content + '</div>' +
                            '<div style="margin-bottom: 20px;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNum  '+ function(){ if(obj.obj[i].isComments==0){ return " displayNone " } }()+' ' + function(){ if(obj.obj[i].ismodulePrivUser==1){ return " displayNone" }else{return ""}}()+'  commentNumber' + i + '" onclick= "details_query(' + i+','+ obj.obj[i].diaId + ')" diaId="'+obj.obj[i].diaId + '"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            ' <li><a href="javascript:;" class="'+ function(){ if(obj.obj[i].isSubordinateLog==1){ return " displayNone " } }()+'" onclick= "share_log($(this),4)"><fmt:message code="diary.th.Share"/></a></li>' +
                            '<li style="display:'+(isOpenSanyuan?"none":"block")+'"><a href="javascript:;" del='+obj.obj[i].diaId+' class="edit' + i +' '+ function(){ if(obj.obj[i].isSubordinateLog==1){ return " displayNone " } }()+'" onclick= "edit_log(' + i + ')"><fmt:message code="global.lang.edit"/></a></li>' +
                            '<li><a href="javascript:;" del='+obj.obj[i].diaId+' class="delete' + i +' '+ function(){ if(obj.obj[i].isSubordinateLog==1){ return " displayNone " } }()+'" onclick= "delete_log(' + i + ')"><fmt:message code="global.lang.delete"/></a></li>' +
                            ' <li><a href="javascript:;" class="'+ function(){ if(obj.obj[i].isSubordinateLog==1){ return " displayNone " } }()+'" onclick="setTop(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +
                            '  <li><a href="javascript:;" showReaders(' + i +','+ obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment_query' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+ '" onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',4,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/>  </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list">' +

                            ' </ul>' +
                            '  </div>' +

                            // 浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+'  ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+

                            '</div>'
                    }

                    $("#details").html(str);

                    tableHandling();

                    if (cb) {
                        cb( obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //高级查询的分页函数
    function initPagination_query(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: data.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                data.page = index.getCurrent();
                initPageList_query(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_query(pageCount, data.pageSize);
                });
            }
        });
    }
    //日历的评论的显示和隐藏
    function details_rl(i,diaId) {
        if ($("#comment_rl" + i).css('display') == 'block') {
            $("#comment_rl" + i).hide();
            $(".commentNumber" + i).removeClass("font_color");

        } else {
            $.ajax({
                url: "/diary/getDiaryCommentByDiaId",
                type: 'get',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        for (var j = 0; j < res.obj.length; j++) {
                            str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                '   <div class="feed-cmt-list-ext">' +
                                '       <a class="feed-cmt-del-handle" data-cmd="delReply"  data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;"><fmt:message code="global.lang.reply" /></a>' +
                                '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                '   </div>    ' +
                                '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                '   <div class="feed-cmt-attachments"> </div> ' +
                                '</li>';
                        }
                        $("#comment_rl" + i+" ul").html(str);
                    }
                }
            });
            $("#comment_rl" + i).show();
            $(".commentNumber" + i).addClass("font_color");
        }

    };
    //查看日历
    function initPageList_rl(cb) {
        $("#details").html("");
        var types
        if($('#oneselfPeople').attr('class').indexOf('active')>-1){
            //我的日志
            types=1
            datas.sFlag = '1'
        }else if($('#myOutline').attr('class').indexOf('active')>-1){
            //我的草稿
            types=4
            datas.sFlag = '0'
        }else if($('#otherPeople').attr('class').indexOf('active')>-1){
            //共享日志
            types=2
            datas.sFlag = '1'
        }else if($('#allPeople').attr('class').indexOf('active')>-1){
            //下属日志
            types=3
            datas.sFlag = '1'
        }
        datas.type = types
        $.ajax({
            url: "/diary/findDiaryGet",
            type: 'get',
            dataType: "JSON",
            data:datas,
            async: false,
            success: function (obj) {
                if (obj.obj.length == 0) {
                    $.layerMsg({content:'<fmt:message code="global.lang.nodata"/>',icon:6},function(){});
                    if (cb) {
                        cb(0);
                    }
                } else {
                    var str = "";
                    for (var i = 0; i < obj.obj.length; i++) {
                        var dia_type='';
                        if(obj.obj[i].diaType == '1'){
                            dia_type='工作日志';/*工作日志*/
                        }else if(obj.obj[i].diaType == '2'){
                            dia_type='个人日志';/*个人日志*/
                        }else if(obj.obj[i].diaType == '3'){
                            dia_type='工作周报';/*个人日志*/
                        }else if(obj.obj[i].diaType == '4'){
                            dia_type='工作月报';/*个人日志*/
                        }

                        var src_sex ="";
                        if(obj.obj[i].avatar!=undefined&&obj.obj[i].avatar!=''){
                            if(obj.obj[i].avatar == '0'){
                                src_sex='/img/workLog/basichead_man.png';
                            }else if(obj.obj[i].avatar == '1'){
                                src_sex='/img/workLog/portrait3.png';
                            }else{
                                src_sex='/img/user/'+obj.obj[i].avatar;
                            }
                        }else{
                            if(obj.obj[i].sex == '0'){
                                src_sex='/img/user/boy.png';
                            }else{
                                src_sex='/img/user/girl.png';
                            }
                        }

                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (obj.obj[i].contentSecrecy && obj.obj[i].contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + obj.obj[i].contentSecrecyName + '】</span>';
                        }

                        str += '<div class="tianErNiu1">' +
                            '<div class="details_modular clearfix">' +
                            <%--头像--%>
                            ' <div class="modular_user"  style="float:left"><img src='+src_sex+' onerror="imgerrorfun()"></div>' +
                            <%--内容部分--%>
                            '<div class="modular_info">' +
                            ' <div class="modular_title clearfix">' +
                            '<div class="modular_name clearfix">' +
                            '<ul>' +
                            '<li><a href="/sys/userDetails?uid='+obj.obj[i].uid+'" target="_blank" style="color:#2B7FE0">' + obj.obj[i].userName + '</a></li>' +
                            '<li>'+obj.obj[i].deptName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+obj.obj[i].userPrivName+'</li>' +
                            '<li>'+dia_type+'</li>' +
                            ' </ul>' +
                            ' </div>' +
                            '<div class="modular_time">' + obj.obj[i].diaTime + '</div>' +
                            ' </div>' +
                            '<h3 onclick= "windowOpen(' + obj.obj[i].diaId+ ',$(this))" share-name="'+obj.obj[i].toIdName+'" share-id="'+obj.obj[i].toId+'">' + contentSecrecyName + obj.obj[i].subject + '</h3>' +
                            //                            '<div>' + obj.obj[i].content + '</div>' +
                            '<div style="margin-bottom: 20px;">' + obj.obj[i].content + '</div>' + function () {
                                if(obj.obj[i].attachment != ''&&obj.obj[i].attachment != undefined){
                                    return '<div class="attacheName">' +
                                        '<div class="attachDiv">附件：</div>' +
                                        '<div style="margin-bottom: 5px;">'+attachView(obj.obj[i].attachment,'','4','0','1','0')+'</div>' +
                                        '</div>';
                                }else{
                                    return '';
                                }
                            }()+
                            '<div class="modular_footer">' +
                            ' <ul>' +
                            '<li><a href="javascript:;" class="commentNum  '+ function(){ if(obj.obj[i].isComments==0){ return " displayNone " } }()+'  commentNumber' + i + '" onclick= "details_rl(' + i + ')" diaId="'+obj.obj[i].diaId + '"><fmt:message code="news.th.comment"/>('+obj.obj[i].comTotal+')</a></li>' +
                            ' <li><a href="javascript:;"><fmt:message code="diary.th.Share"/></a></li>' +
                            '<li style="display:'+(isOpenSanyuan?"none":"block")+'"><a href="javascript:;" del='+obj.obj[i].diaId+' class="edit' + i + '" onclick= "edit_log(' + i + ')"><fmt:message code="global.lang.edit"/></a></li>' +
                            '<li><a href="javascript:;" del='+obj.obj[i].diaId+' class="delete' + i + '" onclick= "delete_log(' + i + ')"><fmt:message code="global.lang.delete"/></a></li>' +
                            ' <li><a href="javascript:;" onclick="setTop(' + i + ','+ obj.obj[i].diaId +','+obj.obj[i].topFlag+')">'+ function(){ if(obj.obj[i].topFlag==0){ return "  <fmt:message code="notice.th.top"/> " } else { return "<fmt:message code="news.th.quittop" />"} }()+'</a></li>' +
                            '  <li><a href="javascript:;"  onclick="showReaders(' + i +','+ obj.obj[i].diaId + ')"><fmt:message code="diary.th.show"/></a></li>' +
                            ' </ul>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            <%--评论--%>
                            '<div class="feed-ext-body comment' + i + '" id="comment_rl' + i + '" style="display: none;">' +
                            '<div class="feed-ext-add-comment">' +
                            '<form target="" action="" name="feed-comment-form">' +
                            ' <div class="feed-ext-add-comment-to" style="width:100px;height:28px;line-hight:28px;border:#ccc 1px solid;margin-bottom:5px;display:none;"></div>' +
                            ' <textarea class="feed-submit-cmt-context" name="feed-submit-cmt-context"></textarea>' +
                            '<button type="button" style="margin-top:80px" class="btn btn-primary feed-submit-cmt-btn" cutId="'+obj.obj[i].diaId+'"  onclick="commentDia($(this),' + i +','+obj.obj[i].diaId+ ',5,'+obj.obj[i].allowComment+')"><fmt:message code="diary.th.remand"/></button>' +
                            '<input type="hidden" name="comment-to" value="">' +
                            ' <input type="hidden" name="comment-id" value="">' +
                            '<input type="hidden" name="comment-type" value="">' +
                            '<input type="hidden" name="diary-id" value="11">' +
                            ' <div class="feed-ext-comment-sms-op" style="margin-top:80px">' +
                            '<label class="sms-remind-label">' +
                            ' <input type="checkbox" name="" id="SMS_REMIND_11" checked=""><fmt:message code="notice.th.remindermessage"/></label>' +
                            ' </div>' +
                            ' <div class="feed-ext-comment-sms-advcomment" id="feed-ext-comment-sms-advcomment" style="margin-top:80px">' +
                            '<label> <input type="checkbox" name="advcomment" class="advcomment"><fmt:message code="diary.th.AdvancedReview"/> </label>' +
                            ' </div>' +
                            ' </form>' +
                            ' </div>' +
                            '   <ul class="feed-ext-list comUl"'+i+'>' +

                            ' </ul>' +
                            '  </div>' +

                            // 浏览信息
                            ' <div class="feed-ext-body-readers displayNone  readers_div'+i+' ">' +
                            '   <div class="feed-ext-readers">' +
                            '      <span></span>' +
                            '   </div> ' +
                            ' </div>'+

                            '</div>'
                    }

                    $("#details").html(str);
                    if (cb) {
                        cb( obj.totleNum);
                    }
                }
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
    //日历查询的分页函数
    function initPagination_rl(totalData, pageSize) {
        $('.M-box3').pagination({
            totalData: totalData,
            showData: pageSize,
            jump: true,
            coping: true,
            current: datas.page,
            homePage: '<fmt:message code="global.page.first" />',
            endPage: '<fmt:message code="global.page.last" />',
            prevContent: '<fmt:message code="global.page.pre" />',
            nextContent: '<fmt:message code="global.page.next" />',
            jumpBtn: '<fmt:message code="global.page.jump" />',
            callback: function (index) {
                datas.page = index.getCurrent();
                initPageList_rl(function (pageCount) {
                    /*   console.log(pageCount);*/
                    initPagination_rl(pageCount, datas.pageSize);
                });
            }
        });
    }
    // 置顶操作
    function setTop(num,diaId,flag) {
        if(flag==0){
            $.ajax({ //置顶
                url: "/diary/insertDiaryTop",
                type: 'post',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    if(res.flag){
                        layer.msg("<fmt:message code="notice.th.TopSuccess" />！",{icon:1});/*置顶成功*/
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            });
        }else{
            $.ajax({  //取消置顶
                url: "/diary/deleteDiaryTop",
                type: 'post',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        layer.msg("<fmt:message code="notice.th.CancelTopSuccess" />！",{icon:1});/*取消置顶成功*/
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            });
        }

    }
    //其他置顶操作
    function setTop_qt(num,diaId,flag) {
        if(flag==0){
            $.ajax({ //置顶
                url: "/diary/insertDiaryTop",
                type: 'post',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    if(res.flag){
                        layer.msg("<fmt:message code="notice.th.TopSuccess" />！",{icon:1});/*置顶成功*/
                        initPageList_qt(function (pageCount) {
                            initPagination_qt(pageCount, data.pageSize);
                        });
                    }
                }
            });
        }else{
            $.ajax({  //取消置顶
                url: "/diary/deleteDiaryTop",
                type: 'post',
                dataType: "JSON",
                data: "diaId="+diaId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        layer.msg("<fmt:message code="notice.th.CancelTopSuccess" />！",{icon:1});/*取消置顶成功*/
                        initPageList_qt(function (pageCount) {
                            initPagination_qt(pageCount, data.pageSize);
                        });
                    }
                }
            });
        }

    }
    // 删除评论接口
    function deleteCmt(num,cmtId,type) {
        var cmtId = cmtId;
        layer.confirm('<fmt:message code="diary.th.removeComment" />？', {/*确定删除该条评论*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定  取消*/
            title:'<fmt:message code="notice.th.DeleteFile" />' /*删除文件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                url: "/diary/delDiaryCommentByCommentId",
                type: 'post',
                dataType: "JSON",
                data: "commentId="+cmtId,
                async: false,
                success: function (res) {
                    var str = "";
                    if(res.flag){
                        layer.msg("<fmt:message code="workflow.th.delsucess" />！",{icon:1});/*删除评论成功*/
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
    //评论接口
    function commentEvent(num,diaId,str,isRemind){

        var content = $('.comment'+num+' textarea').val();
        if(content.trim()==""){
            $.layerMsg({content:'评论内容不能为空！',icon:2},function(){

            });
            return
        }
        var data = {
            diaId:diaId,
            content:content,
            isRemind:isRemind
        };
        $.ajax({
            url: "/diary/insertDiaryComment",
            type: 'post',
            dataType: "JSON",
            data: data,
            async: false,
            success: function (res) {
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="diary.th.CommentSuccess" />！',icon:6});/*评论成功*/
                    $('.feed-submit-cmt-context').val('');
                    //清除富文本编辑框内容

//                    UE.getEditor("comment"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_rl"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_query"+num+"s").execCommand('cleardoc');
//                    UE.getEditor("comment_qt"+num+"s").execCommand('cleardoc');
                    var ischecked = $('.feed-ext-comment-sms-advcomment').find("[name='advcomment']").prop('checked');
                    if (ischecked) {

                        if(str==1){
                            UE.getEditor("comment"+num+"s").execCommand('cleardoc');
                        }else if(str==2){
                            UE.getEditor("comment_sy"+num+"s").execCommand('cleardoc');
                        }else if(str==3){
                            UE.getEditor("comment_qt"+num+"s").execCommand('cleardoc');
                        }else if(str==4){
                            UE.getEditor("comment_query"+num+"s").execCommand('cleardoc');
                        }else{
                            UE.getEditor("comment_rl"+num+"s").execCommand('cleardoc');
                        }
                    }
                    disComment(num,diaId)
                }
            }
        });
    }
    function reloadComment(diaId){
        $.ajax({
            type:'get',
            url:'/diary/getConByDiaId',
            dataType:'json',
            data:{
                'diaId':diaId
            },
            success:function(data){
                if(data.flag){
                    $('.commentNum[diaid="'+ diaId+ '"]').text('评论（'+ data.object.comTotal +')')
                }
            }
        })
    }
    //评论数量
    <%--function diaTotalNum(){--%>
    <%--var diaId=that.parents('.tianErNiu1').attr('dailId');--%>
    <%--$.ajax({--%>
    <%--type:'get',--%>
    <%--url:'/diary/getDiaryCommentCount',--%>
    <%--dataType:'json',--%>
    <%--data:{'diaId':diaId},--%>
    <%--success:function(){--%>
    <%----%>
    <%--}--%>
    <%--})--%>
    <%--}--%>

    //回复
    $('.details').on('click','.feed-cmt-reply-handle',function(){

        var uName=$(this).attr('data-to-text');
        var comId=$(this).attr('data-cmt-type');
        var replyId = $(this).attr('data-cmt-id');

        var toId = $(this).attr('data-to-id');
        $('.btn-primary').attr('btnType','1');
        $('.btn-primary').attr('cutId',comId);
        $('.btn-primary').attr('replyId',replyId);
        $('.btn-primary').attr('toId',toId);
        $('.feed-ext-add-comment-to').toggle();

        $('.feed-ext-add-comment-to').text(uName);


    })


    //##################################################点击高级评论开始 #################################################################
    var a=$('.feed-ext-comment-sms-advcomment');
    a.on('click',function () {
        var ischecked = $(this).find("[name='advcomment']").prop('checked');
        var ue;
        if (ischecked) {
            $textarea = $(this).parents().children('.feed-submit-cmt-context');
            var $id = $(this).parents('.feed-ext-add-comment').parent().prop('id') + 's';
            $($textarea).prop('id', $id);
            ue = UE.getEditor($id);
        } else {
            $textarea = $(this).parents().children('.feed-submit-cmt-context');
            var $id = $(this).parents('.feed-ext-add-comment').parent().prop('id') + 's';

            $($textarea).removeProp('id');

            UE.getEditor($id).destroy();

        }
    })
    //##################################################点击高级评论结束 #################################################################
    // 提交按钮
    function commentDia(that,num,diaId,str,allowComment){
        if (allowComment == 0){
            layer.msg('评论功能已关闭');
            return false;
        }
        var cmtTpe=that.attr('cutId');
        var replyId=that.attr('replyId');
        var toId=that.attr('toId');
        var val=that.siblings('.feed-submit-cmt-context').val();
        if(that.siblings().find('#SMS_REMIND_11').is(":checked")){
            var isRemind = true;
            if(that.siblings('.feed-ext-add-comment-to').css('display') == 'none'){
                commentEvent(num,diaId,str,isRemind);
            }else if(that.siblings('.feed-ext-add-comment-to').css('display') == 'block'){
                replayCommetTo(cmtTpe,val,num,diaId,replyId,toId,isRemind)
            }
        }else{
            if(that.siblings('.feed-ext-add-comment-to').css('display') == 'none'){
                commentEvent(num,diaId,str);
            }else if(that.siblings('.feed-ext-add-comment-to').css('display') == 'block'){
                replayCommetTo(cmtTpe,val,num,diaId,replyId,toId)
            }
        }
    }
    // 获取浏览阅读人信息
    function showReaders(num,diaId) {
        if ($('.readers_div'+num ).css('display') == 'block') {
            $('.readers_div'+num ).hide();
        } else {
            $('.readers_div'+num ).removeClass("displayNone");
            $('.readers_div'+num ).show();
            $.ajax({
                url: "/diary/getReaders",
                type: 'get',
                dataType: "JSON",
                data: {diaId:+diaId},
                async: false,
                success: function (res) {
                    if(res.flag){
                        $('.readers_div'+num+' span' ).text(res.object.readersName);
                    }
                }
            });
        }
    }
    //回复评论方法
    function replayCommetTo(cmtTpe,val,num,diaId,replyId,toId,isRemind){

        $.ajax({
            type:'post',
            url:'/diary/insertCommentReply',
            dataType:'json',
            data:{'replyComment':val,
                'commentId':cmtTpe,
                'toId':toId,
                'replyComId':replyId,
                'isRemind':isRemind
            },
            success:function(res){
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="doc.th.ReplySuccessfully" />！',icon:1});/*回复成功*/
                    disComment(num,diaId)
                    $('.feed-submit-cmt-context').val('');
                    $('.feed-ext-add-comment-to').hide();
                }
            }
        })
    }
    //回复删除
    function deleteReplayCom(that){
        var repId=that.attr('data-cmt-id');
        layer.confirm('<fmt:message code="diary.th.removeComment" />？', {/*确定删除该条评论*/
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  /*确定 取消*/
            title:'<fmt:message code="notice.th.DeleteFile" />' /*删除文件*/
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/diary/delCommentReplyByReplyId',
                dataType:'json',
                data:{'replyId':repId},
                success:function(res){
                    if(res.flag){
                        layer.msg("<fmt:message code="workflow.th.delsucess" />！",{icon:1});/*删除评论成功*/
                        initPageList_zj(function (pageCount) {
                            initPagination_zj(pageCount, data.pageSize);
                        });
                    }
                }
            })
        }, function(){
            layer.closeAll();
        });

    }
    //编辑回复
    function editReplayCom(that,i,diaId,type){
        var repId=that.attr('data-cmt-id');
        var contented = that.parent().siblings('.feed-cmt-content').text()
        layer.open({
            type: 1,
            area: ['650px', '400px'], //宽高
            title: ['编辑评论','font-size:16px'],
            maxmin: false,
            btn: ['确定','取消'],
            content: '<div style="margin-top: 45px">' +
                '<form target="" action="" name="feed-comment-form" style="text-align: center">\n' +
                '    <div class="editReply2" name="" id="editContainer" style="width: 84%;min-height:85px;display: none;margin-left:8%"></div>\n' +
                '    <textarea class="editReply" name="feed-submit-cmt-context"></textarea>\n' +
                '    </form>'+
                '    <div class="feed-ext-comment-sms-op" style="display: inline-block;margin-left: 50px;">\n' +
                '    <label class="sms-remind-label">\n' +
                '       <input type="checkbox" name="" id="sendRemind" checked="">发送事务提醒消息</label>\n' +
                '    </div>\n' +
                '    <div class="feed-ext-comment-sms-advcomment" style="display: inline-block;">\n' +
                '    <label> <input type="checkbox" name="advcomment2" class="advcomment2">高级评论 </label>\n' +
                '    </div>\n' +
                '</div>',
            success: function () {
                UE.delEditor('editContainer');
                ue2 = UE.getEditor('editContainer',{elementPathEnabled : false});
                $('.editReply').val(contented)
                ue2.ready(function () {
                    ue2.setContent(contented);
                });
                $('.advcomment2').on('click',function(){//显示富文本
                    $('#editContainer').toggle()
                    $('.editReply').toggle()
                })
            },
            yes: function (index, layero) {
                $.ajax({
                    type:'get',
                    url:'/diary/getConByDiaId',
                    dataType:'json',
                    data:{
                        'diaId':diaId
                    },
                    success:function(data){
                        if(data.object.allowComment == 0){
                            layer.closeAll();
                            layer.msg('评论功能已关闭')
                            return false
                        }else{
                            if(type == '1'){
                                var url = '/diary/updateDiaryCommentReplyByReplyId';
                                if($('.editReply2').css('display') == 'block'){
                                    if($('#sendRemind').is(":checked")){
                                        var data = {
                                            replyId:repId,
                                            replyComment:ue2.getContent(),
                                            isRemind:true
                                        }
                                    }else{
                                        var data = {
                                            replyId:repId,
                                            replyComment:ue2.getContent(),
                                        }
                                    }

                                }else{
                                    if($('#sendRemind').is(":checked")){
                                        var data = {
                                            replyId:repId,
                                            replyComment:$('.editReply').val(),
                                            isRemind:true
                                        }
                                    }else{
                                        var data = {
                                            replyId:repId,
                                            replyComment:$('.editReply').val()
                                        }
                                    }

                                }
                            }else{
                                var url = '/diary/updateDiaryCommentByCommentId';
                                if($('.editReply2').css('display') == 'block'){
                                    if($('#sendRemind').is(":checked")){
                                        var data = {
                                            commentId:repId,
                                            content:ue2.getContent(),
                                            isRemind:true
                                        }
                                    }else{
                                        var data = {
                                            commentId:repId,
                                            content:ue2.getContent(),
                                        }
                                    }

                                }else{
                                    if($('#sendRemind').is(":checked")){
                                        var data = {
                                            commentId:repId,
                                            content:$('.editReply').val(),
                                            isRemind:true
                                        }
                                    }else{
                                        var data = {
                                            commentId:repId,
                                            content:$('.editReply').val()
                                        }
                                    }

                                }
                            }

                            $.ajax({
                                type:'get',
                                url:url,
                                dataType:'json',
                                data:data,
                                success:function(data){
                                    if(data.flag){
                                        layer.closeAll();
                                        layer.msg('编辑成功', {icon: 1});
                                        disComment(i,diaId)
                                    }else{
                                        layer.msg('编辑失败', {icon: 2});
                                    }
                                }
                            })
                        }
                    }
                })

            },
        });
    }
    //评论显示
    function disComment(num,diaId){
        $('.feed-cmt-list-item').remove();
        reloadComment(diaId)
        $.ajax({
            url: "/diary/getDiaryCommentByDiaId",
            type: 'get',
            dataType: "JSON",
            data: "diaId="+diaId,
            async: false,
            success: function (res) {
                var str = "";
                if(res.flag){
                    for (var j = 0; j < res.obj.length; j++) {
                        var stra='';
                        if(res.obj[j].diaryCommentReplyModelList != ''){
                            if(res.obj[j].myDiaryComment == true){
                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span><fmt:message code="email.th.reply" /></span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext">' +
                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))"><fmt:message code="global.lang.delete" /></a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                        '       <a href="javascript:;" onclick="editReplayCom($(this),'+ num +',' + diaId +',1)" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'"   style="cursor:pointer">编辑</a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                        '</li></ul>';
                                }
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                    '       <a href="javascript:;" onclick="editReplayCom($(this),'+ num +',' + diaId +')" data-cmt-id="'+res.obj[j].commentId+'" style="cursor:pointer">编辑</a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                    '</li>';
                            }else{
                                for(var i=0; i<res.obj[j].diaryCommentReplyModelList.length; i++){
                                    stra+='<ul><li class="feed-cmt-list-item " style="border-top:none;">' +
                                        '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'</a>&nbsp; &nbsp;<span><fmt:message code="email.th.reply" /></span>&nbsp;&nbsp;<a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].diaryCommentReplyModelList[i].toName+'</a>' +
                                        '   <div class="feed-cmt-list-ext">' +
                                        '       <span>'+res.obj[j].diaryCommentReplyModelList[i].replyTime+'</span>' +
                                        '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-cmt-type="" href="javascript:;" onclick="deleteReplayCom($(this))"><fmt:message code="global.lang.delete" /></a> ' +
                                        '       <a class="feed-cmt-reply-handle" data-cmd="replyComment"  data-cmt-id="'+res.obj[j].diaryCommentReplyModelList[i].replyId+'" data-to-id="'+res.obj[j].diaryCommentReplyModelList[i].replyer+'" data-cmt-type="'+res.obj[j].diaryCommentReplyModelList[i].commentId+'" data-to-text="'+res.obj[j].diaryCommentReplyModelList[i].replyerName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                        '   </div>    ' +
                                        '   <div class="feed-cmt-content">'+res.obj[j].diaryCommentReplyModelList[i].replyComment+'</div> ' +
                                        '</li></ul>';
                                }
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle"  num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:;"><fmt:message code="email.th.reply" /></a>' +
                                    '      <span class="feed-cmt-list-time" title="'+res.obj[j].sendTime+'" > </span>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '   <div class="feed-cmt-attachments">'+stra+'</div> ' +
                                    '</li>';
                            }

                        }else{
                            if(res.obj[j].myDiaryComment == true){
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="email.th.reply" /></a>' +
                                    '       <a  onclick="editReplayCom($(this),'+ num +',' + diaId +')" data-cmt-id="'+res.obj[j].commentId+'" style="cursor:pointer">编辑</a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '</li>';
                            }else{
                                str+='<li class="feed-cmt-list-item " data-cmt-id="" data-comment-to-id="">  ' +
                                    '   <a href="javascript:void(0);" td-user-id="admin" class="feed-cmt-list-user">'+res.obj[j].userName+'</a>' +
                                    '   <div class="feed-cmt-list-ext">' +
                                    '       <span>'+res.obj[j].sendTime+'</span>' +
                                    '       <a class="feed-cmt-del-handle" data-cmd="delReply" data-cmt-id="'+res.obj[j].commentId+'" data-to-id="'+res.obj[j].userId+'" data-cmt-type="" data-to-text="'+res.obj[j].userName+'" href="javascript:deleteCmt('+j+','+res.obj[j].commentId+');" hidefocus="hidefocus"><fmt:message code="global.lang.delete" /></a> ' +
                                    '       <a class="feed-cmt-reply-handle" num="'+j+'" data-cmd="replyComment" data-to-id="'+res.obj[j].userId+'" data-cmt-type="'+res.obj[j].commentId+'" data-to-text="'+res.obj[j].userName+'" href="javascript:void(0);" hidefocus="hidefocus"><fmt:message code="email.th.reply" /></a>' +
                                    '   </div>    ' +
                                    '   <div class="feed-cmt-content">'+res.obj[j].content+'</div> ' +
                                    '</li>';
                            }

                        }

                    }
                    $(".comment" + num+" ul").html(str);
                    var liLength=$('.feed-cmt-list-item ').length;
                }
            }
        });
    }

    //时间控件调用
    var start = {
        elem: '#startdate',
        format: 'YYYY-MM-DD',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#enddate',
        format: 'YYYY-MM-DD',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
    //获取当前时间
    function getNowFormatDate1() {
        var date = new Date();
        var seperator1 = "-";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }
    //获取3天前时间
    function getNowFormatDate2() {
        var date = new Date();
        var seperator1 = "-";
        var month = date.getMonth() + 1;
        var strDate = date.getDate() - 3;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }
    //高级搜索的选人员
    $('#add_selectUserbtn').on('click',function () {
        user_id = 'add_selectUser';
        $.popWindow("../common/selectUser");
    });
    //高级搜索的选部门
    $('#dept_add').on('click',function () {
        dept_id = 'dept';
        $.popWindow("../common/selectDept");
    });
    //高级搜索的选角色
    $('#priv_add').on('click',function () {
        priv_id = 'add_selectjuese';
        $.popWindow("../common/selectPriv");
    });
    //写日志中选人员
    $('#add_log').on('click',function(){
        user_id='add_text';
        $.popWindow("../common/selectUser");
    });
    //写日志中选人员
    $('#tyue').on('click',function(){
        user_id='yuep';
        $.popWindow("../common/selectUser");
    });
    /* 写日志清空人员控件 */
    function clearData(){
        $("#add_text").val("");
        $("#add_text").attr('username','');
        $("#add_text").attr('dataid','');
        $("#add_text").attr('user_id','');
        $("#add_text").attr('userprivname','');
    };
    /* 高级搜索的清空按钮*/
    function empty(id){
        $("#"+id).val("");
        $("#"+id).attr("user_id","");
        $("#"+id).attr("userpriv","");
        $("#"+id).attr("deptid","");

    };
    /*写日志是否共享*/
    function share(checkbox){
        // $("#share").toggle();
        if (checkbox.checked == true) {
            $(".td_s #share").css("display","block")
        } else {
            $(".td_s #share").css("display","none")
        }
        //当选中共享时，获取默认共享人信息
        if($("#share").css("display")=="block"){
            //获取默认共享人
            $.ajax({
                url:"/diary/selectShareName",
                type:"get",
                dataType:"json",
                success:function(res){
                    if(res.flag){
                        $("#add_text").val(res.object.sm);
                        $("#add_text").attr("user_id",res.object.toId);
                        $("input [name='to_id']").val(res.object.toId);
                    }
                }
            })

        }
    };

    function getDiaryDefault(diaType){
        //判断是否为中高管，如果是中高管则使用中高管模板
        if (diaType == 3 && isZhongGaoGuan == 1){
            templateInit($("#diary_log").val());
            return;
        } else {
            $("#normalDiary").show();
            $("#templateDiary").hide();
        }

        $.ajax({
            url: "/diary/getDiaryDefaultSet",
            type:'get',
            dataType:"JSON",
            data: {
                diaType: diaType
            },
            success:function(data){
                if(data.flag){
                    if(data.object.content != ''){
                        newKindEditorObj.html(data.object.content);
                    }
                }
            }
        });
    };

    //回显内容表格长度过长处理
    function tableHandling(){
        if ($(".modular_info").find("table").length){
            for (var i = 0; i < $(".modular_info").find("table").length; i++) {
                $(".modular_info").find("table")[i].style.width = "100%";
            }
        }
    }

    //获取浏览器参数
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  decodeURI(r[2]); return null;
    }

    //正在开发中
    function develop(i){
        <%--layer.msg('<fmt:message code="global.lang.doing" />', {icon: 6});--%>
        $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:6},function(){});
    }

    $(document).on('click','.operationImg',function () {
        var thisa = $(this).next().attr('openimg')
        var openNmu = $(this).next().attr('openNmu')
        var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
        $('.tianErNiu1').append(str3)
        $('#getIndex').val(thisa)
        console.log(openNmu)
        window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
    })
    $(document).on('click','#index',function () {
        window.location.href = '/diary/index';
    })
    $(document).on('click','#logQuery',function () {
        window.location.href = '/diary/logQuery';
    })
    $(document).on('click','#noCommentLog',function () {
        window.location.href = '/diary/noCommentLog';
    })
    $(document).on('click','#reportStatistics',function () {
        window.location.href = '/diary/reportStatistics';
    })
    $(document).on('click','.tiao',function(){
        var diaid = $(this).attr('diaid')
        window.location.href = '/diary/logCheck?diaId='+diaid+'&type=index';
    })

    //初始化文本内容
    function templateInit(typ, isedit){
        setTimeout(function(){
            if($('#template_diary #template_content').length < 1){
                return;
            }
            $("#templateDiary").hide();
            $("#normalDiary").show();
            //
            $('#template_diary #template_content [template_no]').each(function(){
                var tempno = $(this).attr('template_no');
                var temptyp = $(this).attr("template_typ");
                if(tempno == undefined || temptyp == undefined || typ != temptyp){
                    return;
                }
                //
                if(isedit){//编辑
                    var editorHtml = newKindEditorObj.html();
                    $("#temp_editor_html").html(editorHtml);
                    //var nodDiary = $('#normalDiary .content [template_no]');
                    var nodDiary = $('#temp_editor_html [template_no]');
                    var diaryno = nodDiary.attr("template_no");
                    var diarytyp = nodDiary.attr("template_typ");
                    if(diaryno != tempno || temptyp != diarytyp){
                        return;
                    }
                }
                $("#templateDiary").show();
                $("#normalDiary").hide();
                eval("setTemplate_" + tempno + "(" + (isedit ? "true" : "") + ")");
            });

            // 中高管模板 标题去除 <br>
            if (isZhongGaoGuan == 1) {
                var tr = $('#templateDiary').find('tr').eq(0).find('td');
                var trHtml = tr.html().replace(/<br>\n/g, "");
                tr.html(trHtml);
                for (var i = 1; i < 10; i++) {
                    if (i % 2 == 1) {
                        var td = $('#templateDiary').find('tr').eq(i).find('td').eq(i == 1 ? 2 : 1);
                        var tdHtml = td.html().replace(/<br>/g, "");
                        td.html(tdHtml);
                    }
                }
            }

        }, 50);
    }
    //提交时处理富文本编辑器文本
    function templateToEditor(typ){
        $('#templateDiary [template_no]').each(function(){
            var tempno = $(this).attr('template_no');
            var temptyp = $(this).attr("template_typ");
            if(tempno == undefined || temptyp == undefined || typ != temptyp){
                return;
            }
            eval("template2editor_" + tempno + "()");
        });
    }
</script>
<div id="temp_editor_html" style="display: none">

</div>
<div id="template_diary" style="display: none">
    <script type="text/javascript">
        $.fn.autoHeight_20211117 = function(){
            function autoHeight_20211117(elem){
                elem.style.height = 'auto';
                elem.scrollTop = 0; //防抖动
                elem.style.height = (elem.scrollHeight + 3) + 'px';
            }
            this.each(function(){
                autoHeight_20211117(this);
                $(this).on('keyup', function(){
                    autoHeight_20211117(this);
                });
            });
        }
        var setTemplate_20211117 = function(isedit){
            var htmlcontent = '';
            if(isedit == undefined || !isedit){
                htmlcontent = $("#template_content [template_no='20211117']")[0].outerHTML;
                htmlcontent = clearAll_20211117(htmlcontent, '\n');
                htmlcontent = clearAll_20211117(htmlcontent, '\r');
                htmlcontent = clearAll_20211117(htmlcontent, '  ');
            }else{
                $('#temp_editor_html').contents().find('[man]').each(function(){
                    var nodTd = $(this);
                    var htmltd = nodTd.html().replace(/\n\t\t\t\t/g, "").replace(/\n\t\t\t/g, "").replace(/<br>/g,"");
                    nodTd.html('<textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">' + htmltd + '</textarea>');
                });
                htmlcontent = $('#temp_editor_html').html();
            }
            $("#templateDiary").html(htmlcontent);
            $('#templateDiary').contents().find('[man]').each(function(){
                var nodTd = $(this);
                var nodText = nodTd.find('textarea').eq(0);
                nodText.autoHeight_20211117();
                nodText.on('click',function(){
                    $('body').removeClass('mui-focusin');
                    var flag = nodTd.attr('clr');
                    if(flag == undefined){
                        return;
                    }
                    nodTd.removeAttr('clr');
                    nodText.val('');
                });
                nodText.on('change',function() {
                    nodText.html(nodText.val());
                });
            });
        }
        var template2editor_20211117 = function(){
            $('#templateDiary').contents().find('textarea').change();
            var htmlcontent = $('#templateDiary').html();
            htmlcontent = htmlcontent.replace(/<\/textarea[^>]+>/g,"").replace(/<textarea[^\/^>]+>/g,"").replace(/\n/g,"<br>");
            newKindEditorObj.html(htmlcontent);
        }
        function clearAll_20211117(str,clearStr){
            while(str.indexOf(clearStr) != -1){
                str = str.replace(clearStr,'');
            }
            return str;
        }
    </script>
    <div id="template_content">
        <table class="td-min-height" style="border: 1px solid #7f7f7f; width: 100%;font:12px/1.2rem 宋体,SimSun;" data-sort="sortDisabled" template_no="20211117" template_typ="3">
            <tbody>
            <tr class="firstRow">
                <td style="border: 1px solid;padding:5px;height:27px;text-align:center;background-color: rgb(247, 150, 70); font-size: 14px;" rowspan="1" colspan="3">
                    <strong>工作周报事项</strong><br>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;" rowspan="10">
                    <strong><span>工<br>作<br>复<br>盘</span></strong><br>
                </td>
                <td style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;" rowspan="2">
                    <strong><span>1</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <span><strong>本人亲自执行的系统建设</strong></span>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：亲自拟定市场策略、规章制度、管理流程、工作方法，起草工作文件，编排工作分工，研究市场情况后的通报文件等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>2</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>督导下属的工作</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：检查工作成果，督查工作进程，指导工作落地，教导下属工作方法等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <span><strong>3</strong></span>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <span><strong>跨部门沟通、协调、合作</strong></span>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：跨部门的沟通、协调、合作等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>4</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>外部互动</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：外部客户、供应商沟通，公关项目，社会互动等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>5</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>组织文化建设</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：招聘、岗位职责梳理、学习培训、文化共创活动、员工沟通等</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>工<br>作<br>总<br>结</span></strong>
                </td>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">针对前5项工作内容进行一个概括性的总结，提出对上周工作的思考、感悟以及需求</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" colspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>下<br>周<br>计<br>划</span></strong><br>
                </td>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">（1）下周核心工作事项，包括：集团重点事项、部门重点跟进事项；</textarea>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">（2）对应的量化目标、时间节点以及预计产出结果。</textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%--<script type="text/javascript" src="/js/common/watermark.js?20220317.1"></script>--%>
</html>





