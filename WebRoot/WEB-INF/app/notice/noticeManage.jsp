<%--需把局部样式归并为一个通用或符合公告管理的公共样式，
接口对完需调整--%>

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
    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />

    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <style>
        /* .btn_ok{
             width:26%;
             height:40px;
             background: #f0f0f0;
             float:left;
             margin-left:30px;

             border-radius: 4px;
             font-size:18px;
             text-align: center;
             line-height: 40px;
         }*/
        #addtianjia{
            display: inline-block;
            float: left;
            width: 66px;
            height: 30px;
            margin-right: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
            background: url(../../img/save.png) no-repeat;
            padding-left: 23px;
            padding-top: 7px;
            cursor: pointer;
            font-size: 14px;
        }
        .headli4{
            width: 90px;
            display: inline-block;
            text-align: center;
            margin-top: 4px;
        }
        #cont_totals td{
            color: #000;
            font-weight: normal;
        }
        .notice_type{
            width:61px;
        }
        .notice_do{
            width:168px;
        }
        table{
            table-layout:fixed;
        }
        #tr_td tr td.publishtip {
            overflow: hidden;
            text-overflow:ellipsis;
            height: 40px;
            width: 40px;
            white-space:nowrap;
        }
        #add_send{
            display: inline-block;
            float: left;
            width: 66px;
            height: 30px;
            margin-right: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
            background: url(../../img/publish.png) no-repeat;
            padding-left: 23px;
            padding-top: 7px;
            cursor: pointer;
            font-size: 14px;
        }
        #add_baocun{
            display: inline-block;
            float: left;
            width: 66px;
            height: 30px;
            margin-right: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
            background: url(../../img/save.png) no-repeat;
            padding-left: 23px;
            padding-top: 7px;
            cursor: pointer;
            font-size: 14px;
        }
        #add_titileTime{
            text-align: left;
        }
        .foot_mg{
            width: 57%;
            height: 50px;
            margin: 20px auto;
        }
        .start_end_time{
            display: inline-block;
            float: left;
            border: none;
            width: 400px;
            height: 20px;


        }
        .td_title1{
            border:none !important;
            color:#000 !important;
        }
        .step2{
            margin-left:2%;
        }
        .news_t{
            width: 139px !important;
        }
        .news_t h1,.news_two h1{
            line-height: 23px;
            text-align: center;
        }
        .news_two{
            width: 139px;
            margin-top: 3px;
        }
        .add_print,.add_down,.add_nochose{
            float:left;
            margin-top:10px;
        }
        .add_print,.add_down{
            width: 152px;

        }
        .add_nochose{
            width: 195px;
            text-align: center;
            line-height:20px;
        }
        .add_print h1,.add_down h1{
            color: #000;
            line-height: 20px;
            text-align: center;
        }
        .add_show,.textTop,.remindCheck,.remindShow{
            float:left;
        }
        .add_show,.remindShow{
            line-height: 24px;
            /* text-align: -webkit-auto; */
            text-align: center;
        }
        .zhiding{
            margin-top:3px;
        }
        .title a{
            color: #59b7fb;
        }
        .titleOne{
            width: 148px;
        }
        .find_detail{
            cursor: pointer;
        }
        /*标题长时隐藏设置*/
        .title{
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .notice_change,.notice_delete,#add_send,#add_baocun,.release3{
            cursor: pointer;
        }
        .release3{
            margin-top:0px !important;
            line-height: 26px;
        }
        .caozuo a:hover{
            color:#287fe0;
        }
        .notice_geshi{
            display: block;
            margin-top: -46px;
            margin-left: 79px;
        }
        /*#add_type_notice,.notice_type{*/
        /*float:left;*/
        /*}*/
        /*修改的字体*/
        .notice_change{
            color: #1772c0;
            margin-left: 5px;
        }
        .notice_change:hover {
            color: #287fe0 !important;
        }
        /*删除的字体*/
        .notice_delete{
            color: #e01919;
            margin-left: 5px;
        }
        .notice_delete:hover {
            color: #C81623 !important;
        }
        .notice_zhongzhi{
            color: #1772c0;
            margin-left: 5px;
        }
        .center .login .icons div{
            margin-left:9px !important;
        }
        .icons div {
            display: inline-block;
            float: left;
            height: 30px;
            line-height: 30px;
            width: 56px;
            text-align: center;
            margin-right: 15px;
            /*        background: url(../../img/gobbing.png) no-repeat;*/
            cursor: pointer;
            padding-left: 20px;
        }
        #daochu{
            background: url(../../img/news/new_export.png) no-repeat;
        }
        #btn_query{
            background: url(../img/file/cabinet03.png) no-repeat;
        }
        #new_change{
            background: url(../../img/gobbing.png) no-repeat;
        }
        #find_delete{
            background: url(../../img/btn_delete.png) no-repeat;
        }
        .icons h2{
            text-align: center;
            width: 71%;
        }
        table tr td input {
            height: 25px;
            border: #ccc 1px solid;
            padding-left: 5px;
        }
        .last_str{
            cursor: pointer;
        }
        .bgcolor{
            background: #c5e9fb !important;
            color: #000000;
        }
        /*置顶一系列按钮的背景图片*/
        .notice_top{
            display: inline-block;
            width: 56px;
            height: 24px;
            line-height: 24px;
            background: url(../../img/btn_top.png) no-repeat;
            font-size: 12px;
            cursor: pointer;
            margin: 0 20px;
        }

        /*取消置顶*/
        .notice_notop{
            display: inline-block;
            width: 83px;
            height: 24px;
            line-height: 24px;
            cursor: pointer;
            background: url(../../img/btn_canceltop.png) no-repeat;
            font-size: 12px;
        }
        /*选中删除*/
        .delete_check{
            display: inline-block;
            width: 109px;
            height: 24px;
            line-height: 24px;
            background: url(../../img/btn_deleteannounce.png) no-repeat;
            font-size: 12px;
            cursor: pointer;
            margin: 0 20px;
        }
        /*全部删除*/
        .delete_all{
            display: inline-block;
            width: 109px;
            height: 24px;
            line-height: 24px;
            background: url(../../img/btn_deleteannounce.png) no-repeat;
            cursor: pointer;
            font-size: 12px;
        }
        #find_start,#find_end{
            height: 20px;
            line-height: 20px;
            width: 130px;
            /* margin-left: -4.2px; */
            margin-top: 20px;
            cursor: pointer;
        }
        .orgAdd{
            color: rgb(32, 123, 214);
            padding-left: 12px;
            background: url(../../img/org_select.png) 0px 0px no-repeat;
            background-position: 0px 0px;
            cursor: pointer;
        }
        .orgClear{
            color: rgb(154, 169, 184);
            padding-left: 12px;
            margin-left: 5px;
            background: url(../../img/org_select.png) 0px -60px no-repeat;
            background-position: 0px -60px;
            cursor: pointer;
        }
        .navigation{
            display: inline-block;
            float: left;
            width: 96% !important;
            margin-left: 2%;
        }
        /*  #find_end{
              margin-left:20px;
          }*/
        .tbody_th{
            background-color: #fff;
            font-size: 15px !important;
            color: #2F5C8F !important;
            font-weight: bold !important;
            /*  border: 0px !important;
              width:6% !important;*/
        }
        table td{
            /*  height: 22px;*/
            /*width: 20%;*/
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .th{
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="bx">
    <!--标题栏-->
    <div class="head w clearfix" style="height: 42px;">
        <ul class="index_head">
            <li data_id=""><span class="one headli1_1">
              <fmt:message  code="notice.th.notifymanage"/>
           </span><img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            <li data_id="0"><span class="headli2_1">
                <fmt:message code="notice.th.buildnotify"/>
            </span><img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>

            <li data_id="1"><span class="headli3">
              <fmt:message code="notice.title.announcementquery"/>
           </span><img src="../img/twoth.png" alt="" class="headli2_2"/></li>
            <li data_id="2"><span class="headli4">
               <fmt:message code="notice.th.notifycount"/>
           </span></li>

        </ul>
    </div>

    <!--表单选项显示-->
    <div class="step1">
        <div class="navigation  clearfix">
            <div class="left">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png">
                <div class="news">
                    <fmt:message code="notice.th.notifymanage"/>
                </div>
                <select name="TYPE" class="button1 nav_type" id="select">
                    <%-- <option value="0" selected=""> <fmt:message code="notice.type.alltype"/></option>
                     <option tid="01"><fmt:message code="notice.type.Decision"/></option>
                     <option tid="02"> <fmt:message code="notice.type.notice"/></option>
                     <option tid="03"><fmt:message code="notice.type.Bulletin"/></option>
                     <option tid="04"> <fmt:message code="notice.type.other"/></option>
                     <option tid="-1">  <fmt:message  code="news.th.none"/></option>--%>
                </select>
                <div id="cx" class="submit">
                    <fmt:message code="global.lang.query"/>
                </div>
            </div>

            <!-- 分页按钮-->
            <div class="right">
                <div class="M-box3"></div>
            </div>
        </div>

        <!--table表单  标题栏 -->
        <div>
            <div>
                <table id="tr_td">
                    <thead>
                    <tr>
                        <td class="th" style="width: 50px;"><fmt:message code="notice.th.chose"/></td>
                        <td class="th" style="width: 80px;"><fmt:message code="notice.th.publisher"/></td>
                        <td class="th" style="width: 100px;"><fmt:message code="notice.th.type"/></td>
                        <td class="th" ><fmt:message code="notice.th.releasescope"/></td>
                        <td class="th titleOne"><fmt:message code="notice.th.title"/></td>
                        <td class="th" style="width: 155px;"><fmt:message code="notice.th.PostedTime"/></td>
                        <td class="th"><fmt:message code="notice.th.effectivedate"/></td>
                        <td class="th"><fmt:message code="notice.th.endDate"/></td>
                        <td class="th notice_type"><fmt:message code="notice.th.state"/></td>
                        <td class="th notice_do"><fmt:message code="notice.th.operation"/></td>
                    </tr>
                    </thead>
                    <tbody id="j_tb"></tbody>
                </table>
            </div>
        </div>
    </div>


    <!-- ************************************ -->
    <!-- 新建公告 -->
    <div class="step2" style="display: none;">
        <table class="newNews">
            <div class="nav_box clearfix">
                <div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png"></div>
                <div class="nav_t2" class="news"></div>
                <%-- <fmt:message code="notice.th.newnotify"/>--%>
                <!-- <div class="nav_t3">选择格式 -->
                <%--<div class="nav_t3" >--%>
                <%--<select name="" class="sel" id="add_sel">--%>

                <%--<option value="0" selected><fmt:message code="notice.format.Commonformat"/></option>--%>
                <%--<option value="1" disabled="disabled"><fmt:message code="notice.format.MHTformat"/></option>--%>
                <%--<option value="2" disabled="disabled"><fmt:message code="notice.format.hyperlink"/></option>--%>
                <%--</select>--%>
                <%--<span class="notice_geshi"></span>--%>
                <%--</div>--%>
                <%--<div class="nav_t3 sel format" id="add_sel">--%>
                <%--&lt;%&ndash;<select name="" >&ndash;%&gt;--%>
                <%--<fmt:message code="notice.format.Commonformat"/>--%>
                <%--&lt;%&ndash;<div class="" ></div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</select>&ndash;%&gt;--%>
                <%--</div>--%>


            </div>
            <!-- 二级选项 -->
            <tbody>
            <tr>
                <td class="td_w">
                    <select name="" class="type_notice" id="add_type_notice">
                        <%-- <option value="00"><fmt:message code="notice.th.chosenotifytype"/></option>
                         <option value="01"><fmt:message code="notice.type.Decision"/></option>
                         <option value="02"><fmt:message code="notice.type.notice"/></option>
                         <option value="03"><fmt:message code="notice.type.Bulletin"/></option>
                         <option value="04"><fmt:message code="notice.type.other"/></option>
                         <option value="05"> <fmt:message  code="news.th.none"/></option>--%>
                    </select>
                    <%--<span class="notice_type"><img class="td_title2" src="../img/mg2.png" alt=""></span>--%>
                </td>
                <td>
                    <div class="td_title1">
                        <!-- 需调整 -->

                        <input type="text" name="titileTime" id="add_titileTime"  style="height: 20px;line-height:20px; width: 255px; margin-left: -4.2px; margin-top: -1px;"
                               placeholder=" <fmt:message code="global.lang.printsubject"/>..." >

                    </div>
                    <img class="td_title2" src="../img/mg2.png" alt=""/>
                </td>
            </tr>
            <tr>
                <td class="blue_text">  <fmt:message code="notice.th.IssuedByDepartment"/>：<br/><a href="javaScript:;" style="color: #207bd6;font-size: 14px;font-weight: normal;" id="personnel" onclick="showAndHidden('personnel','role','man')"> <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/></a></td><%--隐藏按人员或角色发布--%>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_toId" dataid="" resize="auto"></textarea>
                    <%--<input class="td_title1  release1"  id="query_toId" type="text"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3" id="dept_add"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty"onclick="empty('query_toId')"><fmt:message code="global.lang.empty"/></div>

                </td>
            </tr>
            <tr id="role" style="display: none">
                <td class="blue_text">  <fmt:message code="notice.th.role"/>：</td>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_privId" dataid="" resize="auto"></textarea>
                    <%--<input class="td_title1  release1" id="query_privId" type="text"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3" id="priv_add"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty" onclick="empty('query_privId')"><fmt:message code="global.lang.empty"/></div>
                </td>
            </tr>
            <tr id="man" style="display: none">
                <td class="blue_text"> <fmt:message code="notice.th.somebody"/>：</td>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_userId" dataid="" resize="auto"></textarea>
                    <%--<input class="td_title1  release1" id="query_userId" dataid="" type="text"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3"  id="query_adduser"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty" onclick="empty('query_userId')"><fmt:message code="global.lang.empty"/></div>
                </td>
            </tr>
            <!--- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-->

            <tr>
                <td class="blue_text"><fmt:message code="notice.th.PostedTime"/>：</td>
                <td>
                    <div class="td_title1">
                        <!-- 需引入时间插件 -->
                        <input type="text" id="add_newDate"  name="publishTime" class="publishTime" style="height: 20px; width: 255px; margin-left: -4.2px; margin-top: -1px;">
                    </div>
                    <img class="td_title2 release2" src="../img/mg2.png" alt=""/>

                    <div class="release3" id="add_notice_time"><fmt:message code="notice.th.ResetToCurrentTime"/></div>
                </td>
            </tr>

            <tr>
                <td class="blue_text"><fmt:message code="notice.th.validity"/>：</td>
                <td>
                    <div class="td_title1 start_end_time">
                        <!-- 引入时间控件 和 css 调整  -->
                        <input type="text"  name="startTime" id="notice_start_add" class="startTime notice_startime" style="height: 20px;line-height:20px;width: 130px; margin-left: -4.2px; margin-top: -1px;">
                        <span style="float: left;"><fmt:message code="global.lang.to"/></span>
                        <input type="text"  name="endTime" id="notice_end_add" class="endTime notice_endTime" style="height: 20px;width: 130px;  margin-top: -1px;">
                        <fmt:message code="notice.th.null"/>

                    </div>
                    <%--<img class="td_title2 release2" src="../img/mg2.png" style="margin-left: -10px;" alt="">--%>
                </td>
            </tr>

            <!-- 复选框样式调整  -->
            <tr>
                <td class="blue_text"><fmt:message code="notice.th.reminder"/>：</td>
                <td class="remind">


                    <div class="news_t">
                        <input type="checkbox" name="remind" class="remindCheck" value="0" checked>
                        <h1 class="remindShow"><fmt:message code="notice.th.remindermessage"/></h1>
                    </div>
                    <%--  <div class="news_two">
                          <input type="checkbox" name="remind" ><h1><fmt:message code="notice.th.share"/></h1>
                      </div>--%>
                </td>
            </tr>

            <tr>
                <td class="blue_text"><fmt:message code="notice.th.top"/>：</td>
                <td class="top_box">
                    <div>
                        <input type="checkbox" name="textTop" id="textTop" class="textTop">
                        <h1 class="add_show"><fmt:message code="notice.th.topMajor"/></h1>
                    </div>
                    <div class="t_box" style="border:none;margin-right: 20px;">
                        <input type="text" name="textDay" id="textDay" class="textDay" value="0"
                               style="height: 20px; width: 40px; margin-left: -5.2px; margin-top: -1px;">
                    </div>
                    <div class="zhiding"><fmt:message code="notice.th.endTop"/></div>
                </td>
            </tr>
            <tr>
                <td class="blue_text"><fmt:message code="notice.th.contentValidity"/>：</td>
                <td class="abstract">
                    <div class="abstract1" style="border:none;">
                        <input type="text"  name="summny" id="add_summny" class="summny" style="height: 20px;line-height: 20px;color: #000; width: 255px; margin-left: -4.2px; margin-top: -1px;">
                    </div>
                    <div class="abstract2"><fmt:message code="notice.th.contentHigh"/></div>
                    <%--<img class="td_title2 release2" src="../img/mg2.png" style="margin-left: 3px;" alt="">--%>
                </td>
            </tr>

            <!-- 需调整 -->
            <tr>
                <td class="blue_text"><fmt:message code="notice.th.fileUpload"/>：</td>
                <td class="enclosure">
                    <div id="query_uploadArr" style="display:block;">

                    </div>
                    <div><img src="../img/mg11.png" alt=""/></div>
                    <div class="enclosure_t">
                        <form id="uploadimgform" target="uploadiframe" action="../upload?module=notify" enctype="multipart/form-data" method="post">
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="position: absolute;opacity: 0;width: 70px;
filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="uploadimg" style="cursor: pointer;"><fmt:message code="notice.th.addfile"/></a>

                        </form>

                    </div>

                </td>
            </tr>

            <!--word编辑器-->
            <tr>
                <td colspan="2">
                    <div id="word_container" name="content" type="text/plain" style="width: 100%;min-height: 200px;"></div>
                </td>
            </tr>
            <%--<tr>--%>
            <%--<td class="blue_text">--%>
            <%--<fmt:message code="notice.th.keyWord"/>：--%>
            <%--</td>--%>
            <%--<td class="keyword">--%>
            <%--<input class="keyword_ip"><fmt:message code="global.th.printkey"/></input>--%>
            <%--<div class="keyword_t"><fmt:message code="notice.th.AutomaticKeywordAcquisition"/></div>--%>
            <%--<div><fmt:message code="notice.th.keyContent"/></div>--%>
            <%--</tr>--%>
            </tbody>

        </table>
        <div class="foot_mg clearfix">
            <div class="btn_">
                <div  id="add_send" value="1" date-type="1" type="publish" class="fot_1 btn_ok" style="color:#666666;"><fmt:message code="global.lang.publish"/></div>
                <div  id="addtianjia"   class="fot_1 btn_ok" style="color:#666666;display: none"><fmt:message code="adding.th.Submit" /></div>
                <div  id="add_baocun" date-type="0" value="0" type="save" class="btn_style btn_ok" style="color:#666666;"><fmt:message code="global.lang.save"/></div>
            </div>

        </div>
    </div>

</div>



<!--content部分结束-->


<!-- 公告查询 -->
<div class="center" id="qt">
    <div class="navigation  clearfix" style="float: none">
        <div class="left" >
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png"/>
            <div class="news">
                <%--公告查询--%>
                <fmt:message code="notice.title.announcementquery"/>
            </div>
        </div>
    </div>
    <div class="login" style="margin-top: 0px;">
        <div class="header">
            <fmt:message code="global.lang.inputquerycondition"/>
        </div>
        <form id="queryNews">
            <div class="middle">
                <div class="le publisher">
                    <div class="color" style="width:120px;">
                        <fmt:message code="notice.th.publisher"/> ：
                    </div>
                    <input id="input_text1" type="text"/>
                    <div id="cnotice_person" style="margin-right:16px;font-size: 14px;color:#207BD6;cursor:pointer;">
                        <fmt:message code="global.lang.add"/>
                    </div>
                    <div class="empty" style="cursor:pointer;" onclick="emptys('input_text1','subject_query','beginTime','endTime','content','selectOne','selectTwo','selectThree','selectFour','selectFive')">
                        <fmt:message code="global.lang.empty"/>
                    </div>
                </div>
                <%--格式--%>
                <div class="le ce1">
                    <div class="color" style="width:120px;"> <fmt:message  code="notice.th.format"/>：</div>
                    <div>
                        <!-- <select name="TYPE"  class="button1 input_text5" id="select_query"> -->
                        <select name="TYPE" class="button1 input_text5" id="selectOne">
                            <option value="0"> <fmt:message  code="notice.format.Commonformat"/></option>
                        </select>
                    </div>

                </div>
                <%--类型--%>
                <div class="le ce1">
                    <div class="color" style="width:120px;"> <fmt:message  code="notice.th.type"/>：</div>
                    <div>
                        <!-- <select name="TYPE"  class="button1 input_text5" id="select_query"> -->
                        <select name="TYPE" class="button1 input_text5" id="selectTwo">
                            <%--       <option value="0"> <fmt:message  code="notice.th.chosenotifytype"/></option>
                                   <option value="01"> <fmt:message  code="notice.type.Decision"/></option>
                                   <option value="02"> <fmt:message  code="notice.type.notice"/></option>
                                   <option value="03"> <fmt:message  code="notice.type.Bulletin"/></option>
                                   <option value="04"> <fmt:message  code="notice.type.other"/></option>
                                   <option value=""> <fmt:message  code="news.th.none"/></option>--%>
                        </select>
                    </div>

                </div>
                <%--发布状态--%>
                <div class="le ce1">
                    <div class="color" style="width:120px;"><fmt:message  code="notice.th.postedType"/> ：</div>
                    <div>
                        <!-- <select name="TYPE"  class="button1 input_text5" id="select_query"> -->
                        <select name="TYPE" class="button1 input_text5" id="selectThree">
                            <option value=""> <fmt:message  code="notice.th.all"/></option>
                            <option value="0"> <fmt:message  code="notice.th.unposted"/></option>
                            <option value="1"> <fmt:message  code="notice.th.posted"/></option>
                        </select>
                    </div>

                </div>
                <%--发布置顶--%>
                <div class="le ce1">
                    <div class="color" style="width:120px;"> <fmt:message  code="notice.th.ReleaseTop"/>：</div>
                    <div>
                        <select name="TYPE" class="button1 input_text5" id="selectFour">
                            <option value=""> <fmt:message  code="notice.th.all"/></option>
                            <option value="0"> <fmt:message  code="notice.th.untoped"/></option>
                            <option value="1"> <fmt:message  code="notice.th.toped"/></option>
                        </select>
                    </div>

                </div>


                <div class="le subject">
                    <div class="color" style="width:120px;">
                        <fmt:message code="notice.th.title"/> ：</div>
                    <input id="subject_query" class="input_text2" type="text"/>
                </div>
                <div class="le date">
                    <div class="color" style="width:120px;"><fmt:message code="notice.title.Releasedate"/> ：</div>
                    <input id="beginTime"class="input_text3" type="text"/>
                    <div class="color">
                        <fmt:message code="global.lang.to"/>
                    </div>

                    <div><input id="endTime" class="input_text4" type="text"/></div>
                </div>
                <div class="le ce1">
                    <div class="color" style="width:120px;"> <fmt:message  code="notice.th.effectiveType"/>：</div>
                    <div>
                        <!-- <select name="TYPE"  class="button1 input_text5" id="select_query"> -->
                        <select name="TYPE" class="button1 input_text5" id="selectFive">
                            <option value="0" >  <fmt:message  code="notice.th.all"/></option>
                            <option value="1"> <fmt:message  code="notice.th.uneffective"/></option>
                            <option value="2"> <fmt:message  code="notice.th.effectived"/></option>
                            <option value="3"> <fmt:message  code="notice.th.hasEnd"/></option>

                        </select>
                    </div>

                </div>
                <div class="le ce2">
                    <div class="color" style="width:120px;"><fmt:message code="notice.th.content"/>:</div>
                    <input id="content" class="input_text6" type="text"/>
                </div>
            </div>
        </form>

        <div class="icons">
            <div id="btn_query"  style="margin-right:10px; cursor: pointer;"><h2> <fmt:message  code="global.lang.query"/></h2></div><%--<img id="btn_query" style="margin-right:30px; cursor: pointer;" src="../img/threeth_three.png" alt=""/>--%>
            <div id="daochu"  style="margin-right:10px; cursor: pointer;"><h2> <fmt:message  code="global.lang.report"/></h2></div><%--<img src="../fourth_four.png" alt=""/>--%>
            <div id="find_delete"  style="margin-right:10px; cursor: pointer;width: 42px;"><h2> <fmt:message  code="global.lang.delete"/></h2></div>
        </div>
    </div>
</div>

<%--公告统计--%>
<div class="step_tongji" style="display: none;" >
    <div class="navigation  clearfix">
        <div class="left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/la2.png">
            <div class="news">
                <fmt:message code="notice.th.managenotifynotice"/>
            </div>
            <select name="TYPE" class="button1 nav_type" id="dept_id">
                <%--           <option value="0" selected=""></option>
                           <option tid="01"><fmt:message code="notice.type.Decision"/></option>--%>

            </select>
            <input id="find_start"></input><span style="float: left;color:#000;"><fmt:message code="global.lang.to"/></span><input id="find_end"></input>
            <button class="n_total" style="cursor: pointer;height: 19px;line-height: 19px;"><fmt:message code="notice.th.Statistics"/></button>
            <button class="n_daochu" style="cursor: pointer;height: 19px;line-height: 19px;"><fmt:message code="global.lang.report"/></button>
            <button class="n_today" style="cursor: pointer;height: 19px;line-height: 19px;" ><fmt:message code="notice.th.Today"/></button>
            <button class="n_week" style="cursor: pointer;height: 19px;line-height: 19px;"><fmt:message code="diary.th.thisW"/></button>
            <button class="n_month" style="cursor: pointer;height: 19px;line-height: 19px;"><fmt:message code="diary.th.thisM"/></button>
            <button class="n_years" style="cursor: pointer;height: 19px;line-height: 19px;"><fmt:message code="notice.th.ThisYear"/></button>
        </div>

        <!-- 分页按钮-->
        <%--   <div class="right">
               <div class="M-box3"></div>
           </div>--%>
        <div>
            <div>
                <table id="cont_totals">
                    <%--<thead><tr><td class="th"><fmt:message code="workflow.th.Serial"/></td><td class="th"><fmt:message code="userManagement.th.department"/></td><td class="th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>--%>

                </table>
            </div>
        </div>
    </div>

    <!--table表单  标题栏 -->

</div>


<!--footer部分结束-->
</div>
<!-- word文本编辑器 -->
<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
<script>
    var data_notice={};
    function Refillings(id){
        document.getElementById(id).reset();
    };
    var user_id='';
    var dept_id='';

    /* 新建新闻、修改新闻人员控件清空 */
    function empty(id){
        $("#"+id).val("");
        $("#"+id).attr("deptid","");
    };
    /* 新建新闻、修改新闻人员控件清空 */
    function empty1(id){
        $("#"+id).val("");
        $("#"+id).attr("userpriv","");
    };
    /* 新建新闻、修改新闻人员控件清空 */
    function empty2(id){
        $("#"+id).val("");
        $("#"+id).attr("user_id","");
        $("#"+id).attr("dataid","");
    };
    /* word文本编辑器 */
    var ue = UE.getEditor('word_container',{elementPathEnabled : false});


    function emptys(id,id1,id2,id3,id4,id5,id6,id7,id8,id9){
        $("#"+id).val("");
        $("#"+id1).val("");
        $("#"+id2).val("");
        $("#"+id3).val("");
        $("#"+id4).val("");
        $("#"+id5).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
        $("#"+id6).val('<fmt:message  code="notice.th.chosenotifytype"/>')=='0';//选择公告类型
        $("#"+id7).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
        $("#"+id8).val('')=='';
        $("#"+id9).val('<fmt:message  code="notice.th.all"/>')=='0';//全部
    };
    /* 公告人员控件显示和隐藏 */
    function showAndHidden(persion,role,man){
        if($("#"+persion).html() ==' <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/>'){
            $("#"+persion).html(" <fmt:message  code="notice.th.Hidden"/>");
            $("#"+role).show();
            $("#"+man).show();
        }else{
            $("#"+persion).html(" <fmt:message  code="notice.th.PostedByPersonnelOrRoles"/>");
            $("#"+role).hide();
            $("#"+man).hide();
        }
    }
    $(function(){

        //页面加载时发送ajax获取下拉框数据
        var str="<option value=\"0\" selected=\"\"><fmt:message code="notice.type.alltype"/></option>";
        var str2="<option value=\"0\" selected=\"\"><fmt:message code="notice.th.chosenotifytype"/></option>";
        $.ajax({
            url: "/code/GetDropDownBox",
            type:'get',
            dataType:"JSON",
            data : {"CodeNos":"NOTIFY"},
            success:function(data){
                for (var proId in data){
                    for(var i=0;i<data[proId].length;i++){
                        str += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                        str2 += '<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                    }
                }
//                var arr=data.NOTIFY;
//                for(var i=0;i<arr.length;i++){
//                    str+='<option data-id="'+arr[i].isEdit+'" value="'+arr[i].codeNo+'">'+arr[i].codeName+'</option>'
//                       str2+='<option data-id="'+arr[i].isEdit+'" value="'+arr[i].codeNo+'">'+arr[i].codeName+'</option>'
//                }
                $('#select').append(str);
                $('#add_type_notice').append(str);
                $('#selectTwo').append(str2);
            }

        })


        var now = null;
        function queryTime(){
            function p(s) {
                return s < 10 ? '0' + s: s;
            }

            var myDate = new Date();
            //获取当前年
            var year=myDate.getFullYear();
            //获取当前月
            var month=myDate.getMonth()+1;
            //获取当前日
            var date=myDate.getDate();
            var h=myDate.getHours();       //获取当前小时数(0-23)
            var m=myDate.getMinutes();     //获取当前分钟数(0-59)
            var s=myDate.getSeconds();

            now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
        }







        //获取当前时间
        var now_time = null;
        var now_month = null;

        function p(s) {
            return s < 10 ? '0' + s: s;
        }

        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        var s=myDate.getSeconds();

        now_time=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
        now_month=year+'-'+p(month)

        /*本年的范围*/
        var now_year = year + "-01-01/" + year + "-12-31";

        <!-- 本月 -->
        var now = new Date(); //当前日期
        var nowDayOfWeek = now.getDay(); //今天本周的第几天
        var nowDay = now.getDate(); //当前日
        var nowMonth = now.getMonth(); //当前月
        var nowYear = now.getYear(); //当前年
        nowYear += (nowYear < 2000) ? 1900 : 0; //

        var lastMonthDate = new Date(); //上月日期
        lastMonthDate.setDate(1);
        lastMonthDate.setMonth(lastMonthDate.getMonth()-1);
        var lastYear = lastMonthDate.getYear();
        var lastMonth = lastMonthDate.getMonth();

        //格式化日期：yyyy-MM-dd
        function formatDate(date) {
            var myyear = date.getFullYear();
            var mymonth = date.getMonth()+1;
            var myweekday = date.getDate();

            if(mymonth < 10){
                mymonth = "0" + mymonth;
            }
            if(myweekday < 10){
                myweekday = "0" + myweekday;
            }
            return (myyear+"-"+mymonth + "-" + myweekday);
        }

        //获得某月的天数
        function getMonthDays(myMonth){
            var monthStartDate = new Date(nowYear, myMonth, 1);
            var monthEndDate = new Date(nowYear, myMonth + 1, 1);
            var days = (monthEndDate - monthStartDate)/(1000 * 60 * 60 * 24);
            return days;
        }
        //获得本季度的开始月份
        function getQuarterStartMonth(){
            var quarterStartMonth = 0;
            if(nowMonth<3){
                quarterStartMonth = 0;
            }
            if(2<nowMonth && nowMonth<6){
                quarterStartMonth = 3;
            }
            if(5<nowMonth && nowMonth<9){
                quarterStartMonth = 6;
            }
            if(nowMonth>8){
                quarterStartMonth = 9;
            }
            return quarterStartMonth;
        }

        //获得本周的开始日期
        function getWeekStartDate() {
            var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
            return formatDate(weekStartDate);
        }

        //获得本周的结束日期
        function getWeekEndDate() {
            var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
            return formatDate(weekEndDate);
        }

        //获得本月的开始日期
        function getMonthStartDate(){
            var monthStartDate = new Date(nowYear, nowMonth, 1);
            return formatDate(monthStartDate);
        }

        //获得本月的结束日期
        function getMonthEndDate(){
            var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
            return formatDate(monthEndDate);
        }

        /*公告统计页面的当前月份开始*/
        $('#find_start').val(getMonthStartDate());
        /*公告统计页面的当前月份结束*/
        $('#find_end').val(getMonthEndDate());

        /*公告统计接口*/
        $.ajax({
            url: '/notice/getNotifyGroupFromDept',
            type: 'get',
            data: {
                fromDept:$("#dept_id").val(),
                beginTime:$("#find_start").val(),
                endTime:$("#find_end").val(),
                sendTime:''
            },
            dataType: 'json',
            success: function (obj) {
                var data=obj.obj;
                if(obj.flag==true){
                    var str='';

                    for(var i=0;i<data.length;i++){
                        str+='<tr class="trs" step="1"><td class="th">'+(i+1)+'</td><td class="th" id="deptName" deptId='+data[i].deptId+' step="1">'+data[i].deptName+'</td><td class="th" >'+data[i].count+'</td></tr>'
                    }
                    var theath='<thead><tr><td class="tbody_th" ><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th" ><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                    $('#cont_totals').html(theath+str);

                }
            }
        })

        /*所有部门*/
        //部门共用
        var opt_li_dep='<option value="0"  class="levelleft0"><fmt:message code="workflow.th.allpart" /></option><option value="01"  class="levelleft0" id="choose_more"><fmt:message code="hr.th.MultipleDepartments" /></option>';
        departmentAjax(function (departmentData) {
            opt_li_dep=  departmentChild(departmentData,opt_li_dep,0,-1);
            $('#dept_id').html(opt_li_dep);
        });

        //部门遍历方法
        function departmentChild(datas,opt_li,level,dept){
            for(var i=0;i<datas.length;i++){
                var String="";
                var space=""
                for(var j=0;j<level;j++){
                    space+="├&nbsp;&nbsp;&nbsp;";
                }

                if(i==0){
                    String=space+"┌";
                }else
                if(i!=0){
                    String=space+"├";
                }else
                if(i==datas.length-1){
                    String=space+"└";
                }
                if(dept==datas[i].deptId){
                    opt_li+='<option value="'+datas[i].deptId+'" selected="selected">'+String+datas[i].deptName+'</option>';
                }else{
                    opt_li+='<option value="'+datas[i].deptId+'">'+String+datas[i].deptName+'</option>';
                }
                if(datas[i].childs!=null){
                    opt_li = departmentChild(datas[i].childs,opt_li,level+1,dept);
                }
            }
            return opt_li;
        }
        //部门接口
        function departmentAjax(callback){
            $.ajax({
                url:'../../department/getAlldept',
                type:'get',
                dataType:'json',
                success:function(obj){
                    var data=obj.obj;
                    var  departmentData= digui(data,0);
                    callback(departmentData);
                }
            });
        }
        function digui(datas,departId) {
            var data=new Array();
            for(var i=0;i<datas.length;i++){
                if(datas[i].deptParent==departId){
                    datas[i]["childs"]=digui(datas,datas[i].deptId);
                    data.push(datas[i]);
                }
            }
            return data;
        }
        /*多选部门的点击事件*/
        $('#dept_id').change(function(){
            var pf1=$(this).children('option:selected').val();
            var start_total_time=$('#find_start').val();
            var end_total_time=$('#find_end').val();
            if($(this).children('option:selected').val()=='01'){
                layer.open({
                    type: 1,
                    /* skin: 'layui-layer-rim', //加上边框 */
                    offset: '80px',
                    area: ['402px', '252px'], //宽高
                    title:'<fmt:message code="notify.th.MultiSectoralSelection"/>',/*多部门选择*/
                    content: '<div class="modal-body" style="max-height: 150px;height: 150px;padding: 0px;overflow: hidden;">'+
                    '<div style="margin-top: 30px;margin-left: 20px;"><input name="more_dept_id" type="hidden" value="">'+
                    '<textarea name="more_dept_name" id="query_Tos" value="" class="BigStatic" rows="4" cols="40" wrap="yes" readonly=""></textarea>'+
                    '<a class="orgAdd" id="add"><fmt:message code="global.lang.select"/></a><a class="orgClear"><fmt:message code="global.lang.empty"/></a></div></div>',//选择 清空
                    btn:['<fmt:message code="notice.th.Statistics"/>', '<fmt:message code="global.lang.close"/>'],/*统计 关闭*/
                    yes: function(index, layero){
                        //按钮【按钮三】的回调
                        /*alert($('.name_biaodan').val());*/
                        /* alert('0k');*/

                        var layerIndex = layer.load(0, {shade: false});
                        layer.closeAll();
                        $.ajax({
                            url: '/notice/getNotifyGroupFromDept',
                            type: 'get',
                            data: {
                                fromDept:'',
                                beginTime:'',
                                endTime:'',
                                sendTime:''
                            },
                            dataType: 'json',
                            success: function (obj) {
                                var data=obj.obj;
                                if(obj.flag==true){
                                    var str='';

                                    for(var i=0;i<data.length;i++){
                                        str+='<tr><td class="th">'+(i+1)+'</td><td class="th" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td><td class="th" >'+data[i].count+'</td></tr>'
                                    }
                                    var theath='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                                    $('#cont_totals').html(theath+str);

                                }
                            }
                        })
                    }

                });
            }
            //点击选择，走选择部门的控件
            $('.layui-layer').on('click','#add',function(){
                /*    alert('111');*/
                dept_id='query_Tos';
                $.popWindow("../common/selectDept");
            });

            /*当前部门下调用的接口*/
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:pf1,
                    beginTime:start_total_time,
                    endTime:end_total_time,
                    sendTime:now_time
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true) {
                        var tr = '';
                        if (data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                tr += '<tr class="trs" step="1"><td class="th">' + (i + 1) + '</td><td class="th" deptId='+data[i].deptId+' step="1">' + data[i].deptName + '</td><td class="th" >' + data[i].count + '</td></tr>'
                            }
                        } else {
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }
                        var theath='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                        $('#cont_totals').html(theath+tr);

                    }

                }
            })

        })
        /*第一级的人员点击事件,显示第二级*/
        $('#cont_totals').on('click','#deptName',function(){
            /*var step=1;*/
            var deptId=$(this).attr('deptId');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            /* /notice/getNotifyByFromDept*/
            $.ajax({
                url: '/notice/getNotifyByFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime
                    /* sendTime:now_time*/
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                str+='<tr class="trs" step="2"><td class="th">'+(i+1)+'</td><td class="th" id="deptName" fromId='+data[i].fromId+' deptId='+data[i].fromDept+'>'+data[i].fromDeptStr+'</td><td class="th" id="name" fromId='+data[i].fromId+' deptId='+data[i].fromDept+' step="2">'+data[i].fromIdStr+'</td><td class="th" >'+data[i].resultCount+'</td></tr>'
                            }/*姓名（点击查看详情）  发布数量*/
                            var theat='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notify.th.NameClickToViewDetails"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                            $('#cont_totals').html(theat+str);
                        }else{
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }


                    }
                }
            })
        })
        /*点击人名，显示人员详情*/

        $('#cont_totals').on('click','#name',function(){
            var deptId=$(this).attr('deptId');
            var fromId=$(this).attr('fromId');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/notice/getNotifyByFromIdAndDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    fromId:fromId
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                str+='<tr class="trs" step="3" fromId="'+fromId+'">' +
                                    '<td class="th" width="10%">'+(i+1)+'</td>' +
                                    '<td class="th" width="10%" id="deptName" deptId='+data[i].fromDept+'>'+data[i].fromIdStr+'</td>' +
                                    '<td class="th" width="10%" deptId='+data[i].fromDept+'>'+data[i].typeId+'</td>' +
                                    '<td class="th" width="20%" title='+data[i].toId+'>'+data[i].toId+'</td>' +
                                    '<td class="th subject_detail" width="10%" notifyId='+data[i].notifyId+' step="3">'+data[i].subject+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].sendTime+'</td>' +
                                    '<td class="th" width="10%">'+data[i].beginDate+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].endDate+'</td>' +
                                    '<td class="th" width="10%" >'+data[i].publish+'</td>' +
                                    '</tr>'
                            }
                            /*发布人  类型  发布范围  标题（点击查看详情）创建时间  生效日期  终止日期  状态*/
                            var detail_theat='<thead>' +
                                '<tr>' +
                                '<td class="tbody_th" width="10%"><fmt:message code="workflow.th.Serial"/>\
                                </td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.publisher"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.type"/></td>\
                                <td class="tbody_th" width="20%"><fmt:message code="notice.th.releasescope"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notify.th.TitleClickToViewDetails"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.createTime"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.effectivedate"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.endDate"/></td>\
                                <td class="tbody_th" width="10%"><fmt:message code="notice.th.state"/></td>\
                                </tr></thead>'
                            $('#cont_totals').html(detail_theat+str);
                        }else{
                            layer.msg('<fmt:message code="hr.th.Nopublishedinformation"/>', {icon: 6});/*无发布的公共信息*/
                        }


                    }
                }
            })
        })

        /*点击统计*/
        $('.n_total').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime
                    /*  sendTime:now_time,*/
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';

                        for(var i=0;i<data.length;i++){
                            str+='<tr class="trs" step="1">' +
                                '<td class="th" width="30%">'+(i+1)+'</td>' +
                                '<td class="th" width="30%" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td>' +
                                '<td class="th" width="40%">'+data[i].count+'</td>' +
                                '</tr>'
                        }
                        var theath='<thead><tr>' +
                            '<td class="tbody_th" width="30%">\
                            <fmt:message code="workflow.th.Serial"/>\
                            </td>\
                            <td class="tbody_th" width="30%">\
                            <fmt:message code="userManagement.th.department"/>\
                            </td>\
                            <td class="tbody_th" width="40%">\
                            <fmt:message code="notice.th.PublicationQuantity"/>\
                            </td>\
                            </tr></thead>'
                        $('#cont_totals').html(theath+str);

                    }
                }
            })
        })
        /*点击今天*/
        $('.n_today').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            var beginTime=$('#find_start').val(now_time);
            var endTime=$('#find_end').val(now_time);
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:'',
                    endTime:'',
                    sendTime:now_time
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';

                        for(var i=0;i<data.length;i++){
                            str+='<tr class="trs" step="1">' +
                                '<td class="th" width="30">'+(i+1)+'</td>' +
                                '<td class="th" width="30%" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td>' +
                                '<td class="th" width="40%">'+data[i].count+'</td>' +
                                '</tr>'
                        }
                        var theath='<thead>' +
                            '<tr>' +
                            '<td class="tbody_th" width="30%">\
                            <fmt:message code="workflow.th.Serial"/>\
                            </td>\
                            <td class="tbody_th" width="30%">\
                            <fmt:message code="userManagement.th.department"/>\
                            </td>\
                            <td class="tbody_th" width="40%">\
                            <fmt:message code="notice.th.PublicationQuantity"/>\
                            </td>\
                            </tr></thead>'
                        $('#cont_totals').html(theath+str);

                    }
                }
            })
        })
        /*点击本周*/
        $('.n_week').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            $('#find_start').val(getWeekStartDate());
            $('#find_end').val(getWeekEndDate());
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime,
                    sendTime:''
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';

                        for(var i=0;i<data.length;i++){
                            str+='<tr class="trs" step="1">' +
                                '<td class="th" width="30%">'+(i+1)+'</td>' +
                                '<td class="th" width="30%" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td>' +
                                '<td class="th" width="40%" >'+data[i].count+'</td>' +
                                '</tr>'
                        }
                        var theath='<thead>' +
                            '<tr>' +
                            '<td class="tbody_th" width="30%">\
                            <fmt:message code="workflow.th.Serial"/>\
                            </td>\
                            <td class="tbody_th" width="30%">\
                            <fmt:message code="userManagement.th.department"/>\
                            </td>\
                            <td class="tbody_th" width="40%">\
                            <fmt:message code="notice.th.PublicationQuantity"/>\
                            </td>\
                            </tr></thead>'
                        $('#cont_totals').html(theath+str);

                    }
                }
            })
        })
        /*点击本月*/
        $('.n_month').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            $('#find_start').val(getMonthStartDate());
            $('#find_end').val(getMonthEndDate());
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime,
                    sendTime:''
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';

                        for(var i=0;i<data.length;i++){
                            str+='<tr class="trs" step="1">' +
                                '<td class="th" width="30%">'+(i+1)+'</td>' +
                                '<td class="th" width="30%" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td>' +
                                '<td class="th" width="40%">'+data[i].count+'</td>' +
                                '</tr>'
                        }
                        var theath='<thead>' +
                            '<tr>' +
                            '<td class="tbody_th" width="30%">\
                            <fmt:message code="workflow.th.Serial"/>\
                            </td>\
                            <td class="tbody_th" width="30%">\
                            <fmt:message code="userManagement.th.department"/>\
                            </td>\
                            <td class="tbody_th" width="40%">\
                            <fmt:message code="notice.th.PublicationQuantity"/>\
                            </td>\
                            </tr></thead>'
                        $('#cont_totals').html(theath+str);

                    }
                }
            })
        })
        /*点击本年*/
        $('.n_years').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            $('#find_start').val(year + "-01-01");
            $('#find_end').val(year + "-12-31");
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            $.ajax({
                url: '/notice/getNotifyGroupFromDept',
                type: 'get',
                data: {
                    fromDept:deptId,
                    beginTime:beginTime,
                    endTime:endTime,
                    sendTime:''
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    if(obj.flag==true){
                        var str='';

                        for(var i=0;i<data.length;i++){
                            str+='<tr class="trs" step="1"><td class="th">'+(i+1)+'</td><td class="th" id="deptName" deptId='+data[i].deptId+'>'+data[i].deptName+'</td><td class="th" >'+data[i].count+'</td></tr>'
                        }
                        var theath='<thead><tr><td class="tbody_th"><fmt:message code="workflow.th.Serial"/></td><td class="tbody_th"><fmt:message code="userManagement.th.department"/></td><td class="tbody_th" ><fmt:message code="notice.th.PublicationQuantity"/></td></tr></thead>'
                        $('#cont_totals').html(theath+str);

                    }
                }
            })
        })

        /*点击标题，显示详情*/
        $('#cont_totals').on('click','.subject_detail',function(){
            /* alert('111');*/
            var notifyId=$(this).attr('notifyId');
            $.popWindow("subjectDetail?notifyId="+notifyId,'<fmt:message code="notify.th.ViewAnnouncementNotice"/>','300','300','700px','500px');/*查看公告通知*/
        })
        /*点击导出*/
        /* n_daochu*/
        $('.n_daochu').on('click',function(){
            var deptId=$('#dept_id option:checked').attr('value');
            var beginTime=$('#find_start').val();
            var endTime=$('#find_end').val();
            if($('.trs').attr('step')=='1'){
                window.location.href= '/notice/outputNotify?fromDept='+deptId+'&beginTime='+beginTime+'&endTime='+endTime+'&step=1';

            }else if($('.trs').attr('step')=='2'){
                window.location.href= '/notice/outputNotify?fromDept='+deptId+'&beginTime='+beginTime+'&endTime='+endTime+'&step=2';

            }else if($('.trs').attr('step')=='3'){
                var fromId=$('.trs').attr('fromid');
                window.location.href='/notice/outputNotify?fromDept='+deptId+'&beginTime='+beginTime+'&endTime='+endTime+'&step=3&fromId='+fromId;
            }

        })
        //选人员
        $('#query_adduser').click(function(){
            user_id='query_userId';
            $.popWindow("../common/selectUser");
        });
        //选部门
        $('#dept_add').click(function(){
            dept_id='query_toId';
            $.popWindow("../common/selectDept");
        });
        //选角色
        $('#priv_add').click(function(){
            priv_id='query_privId';
            $.popWindow("../common/selectPriv");
        });
        //查询中添加发布人
        $('#cnotice_person').click(function(){
            user_id='input_text1';
            $.popWindow("../common/selectUser");
        });

        /*查询页面的添加人员fromId*/



        //添加附件
        /* 添加附件 */


        $('#uploadinputimg').fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                            str += '';
                            layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
                                layer.closeAll();
                            });
                        }else{
                            str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                        }
                    }
                    $('#query_uploadArr').append(str);
                }else{
                    //alert('添加附件大小不能为空!');
                    layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });




        var data = {
            read : $('.index_head .one').parent().attr('data_id'),
            typeId : $('#select').val()==0?'':$('#select').val(),
            nTime : $('#sendTime').val(),
            page:1,
            pageSize:5,
            useFlag:true,
            newsTime:'',
            lastEditTime:'',
            content:'',
            subject:'',
            typeId:0,
            beginTime:'',
            endTime:'',
            content:'',
            changeId:'1',
            exportId:'1'
        };

        initPageList(function(pageCount){
            initPagination(pageCount,data.pageSize);
        });


        $(".index_head li").click(function (){
            $(this).find('span').addClass('one').parent().siblings('').find('span').removeClass('one');  // 删除其他兄弟元素的样式
            $(".news").html($(this).find('span').text());
            data.read = $(this).attr('data_id');
            data.typeId = $('#select').val()==0?'':$('#select').val();
            data.nTime = $('#sendTime').val();
            if(data.read == ''){
                data.subject = '';
                data.beginTime = '';
                data.endTime = '';
                data.typeId =  0;
                data.content = '';
                data.fromId='';
                data.page='1';
                data.changeId='1',
                    data.exportId='1'

                $('.step1').show();
                $('.step2').hide();
                $('.step_tongji').hide();
                $('.center').hide();
                initPageList(function(pageCount){
                    initPagination(pageCount,data.pageSize)});
            }else if(data.read == 1){//查询页面
                $('.step1').hide();
                $('.step2').hide();
                $('.step_tongji').hide();
                $('.center').show();
                $('#subject').val('');
                $('#beginTime').val('');
                $('#endTime').val('');
                $('#select').val()==0?'':$('#select').val();
                $('#content').val('');
            }else  if( data.read == 0){//新建页面清空数据
                $('.nav_t2').html('<fmt:message code="notice.th.newnotify"/>');
                $('.step1').hide();
                $('.step2').show();
                $('.step_tongji').hide();
                $('#add_send').attr('ac','add');
                $('.center').hide();
                //清空

                $('#add_baocun').attr('attrType','add');
                $('#add_newDate').val('');//发布时间
                $('#add_titileTime').val('');//标题
                $('#query_userId').val('');//选人
                $('#query_toId').val('');//选部门
                $('#query_privId').val('');//选角色
                $('#add_selectjuese').val('');//角色
                $('#start_add').val('');//起始时间
                $('#end_add').val('');//结束时间
                /*$('#add_selectUser').val(data.userId);*/
                /*$('#add_type_notice').selected(data.typeName);*/
                $('#query_uploadArr').text('');//附件
                $("#add_type_notice").val('<fmt:message code="notice.th.chosenotifytype" />');//类型 //选择公告类型
                /* if(data.top==1){
                 $('#textTop').prop('checked',true);//是否置顶
                 };*/
                $('#textDay').val('');//置顶天数
                ue.setContent('');//内容
                $('#add_summny').val('');//内容
                $('.keyword_ip').val('');//关键词
                //显示当前时间
                queryTime();
                $('#add_newDate').val(now);
            }else if(data.read == 2){//查询页面
                $('.step1').hide();
                $('.step2').hide();
                $('.center').hide();
                $('.step_tongji').show();
                $('#subject').val('');
                $('#beginTime').val('');
                $('#endTime').val('');
                $('#select').val()==0?'':$('#select').val();
                $('#content').val('');
            }

        });
//        表格的数据展示
        function initPageList(cb){
            var usersName=$.cookie('userId');
            $.ajax({
                type: "get",
                url: "/notice/notifyList",
                dataType: 'JSON',
                data: data,
                success: function(data){
                    var news = "";
                    for (var i = 0; i < data.obj.length; i++) {
                        var toTypeName = ""
                        var deprange = "";
                        var rolerange = "";
                        var userrange = "";

                        if(data.obj[i].deprange){
                            deprange=data.obj[i].deprange;
                        }
                        if(data.obj[i].rolerange){
                            rolerange=data.obj[i].rolerange;
                        }
                        if(data.obj[i].userrange){
                            userrange=data.obj[i].userrange;
                        }
                        toTypeName = '<fmt:message code="userManagement.th.department" />：'+deprange+'-<fmt:message code="journal.th.user" />：'+userrange+'-<fmt:message code="userManagement.th.role" />:'+ rolerange;
                        var alltype = deprange+userrange+rolerange;
                        var publish = ""
                        if(data.obj[i].publish == 0){
                            publish+="<fmt:message code="notice.th.unposted" />";
                        }
                        if(data.obj[i].publish == 1){
                            publish+="<fmt:message code="notice.state.effective" />";
                        }
                        if(data.obj[i].publish == 2){
                            publish+="<fmt:message code="meet.th.PendingApproval" />";
                        };
                        if(data.obj[i].publish == 3){
                            publish+="<fmt:message code="vote.th.NotThrough" />";
                        };

                        var typeName = data.obj[i].typeName == '-1'? '': data.obj[i].typeName;
                        if(data.obj[i].typeName == '-1'){
                            news +="<tr id='notice_tr' notifyId="+data.obj[i].notifyId+"><td><input class='checkChild' type='checkbox' conid='+data.obj[i].notifyId+' name='check' value=''></td>"+
                                "<td notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].name+"</td>"+
                                "<td notifyId="+data.obj[i].notifyId+" class='windowOpen' ></td>"+
                                "<td notifyId="+data.obj[i].notifyId+" style='cursor:pointer;' class='windowOpen publishtip' toTypeName="+toTypeName+">"+alltype+"</td>"+
                                "<td class='title titleOne' notifyId="+data.obj[i].notifyId+">"
                            if(data.obj[i].top == '1'){
                                news +='<img src="/img/news/top.png" alt="" style="margin-right: 5px;">';
                            }
                            news +="<a href='#'  class='windowOpen' title="+data.obj[i].subject+">"+data.obj[i].subject+"</a></td>"+
                                "<td class='send_time' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].notifyDateTime/*.split(' ')[0]*/+"</td>"+
                                "<td class='start_time' href='#' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].begin.split(' ')[0]+"</td>"+
                                "<td class='end_time' href='#' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].end.split(' ')[0]+"</td>"+
                                "<td class='notice_zhuangtai' notifyId="+data.obj[i].notifyId+">"+publish+"</td>"+//状态
                                "<td class='caozuo'>"+"<a class='find_detail' notifyId="+data.obj[i].notifyId+" style='color:#1772c0;'> <fmt:message  code="notice.th.QueryStatus"/></a>\
                                "+function () {
                                    if(data.obj[i].publish==1){
                                        return "<a class='notice_zhongzhi' id=stop"+data.obj[i].notifyId+" style='cursor:pointer;' onclick='stoprwo(this,"+data.obj[i].notifyId+",\"publish"+data.obj[i].notifyId+"\",\"stop"+data.obj[i].notifyId+"\")'><fmt:message  code="notice.state.end"/></a>"
                                    } else {
                                        return "<a class='notice_zhongzhi' id=stop"+data.obj[i].notifyId+" style='cursor:pointer;' onclick='stoprwo(this,"+data.obj[i].notifyId+",\"publish"+data.obj[i].notifyId+"\",\"stop"+data.obj[i].notifyId+"\")'><fmt:message code="notice.state.effective" /></a>"
                                    }
                                }()+"&nbsp<a notifyId="+data.obj[i].notifyId+" class='notice_change'><fmt:message  code="depatement.th.modify"/></a><a class='notice_delete' notifyId="+data.obj[i].notifyId+"><fmt:message  code="global.lang.delete"/></a></td>"//操作

                        }else{
                            news +="<tr id='notice_tr' notifyId="+data.obj[i].notifyId+"><td><input class='checkChild' type='checkbox' conid="+data.obj[i].notifyId+" name='check' value=''></td>"+
                                "<td notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].name+"</td>"+
                                "<td notifyId="+data.obj[i].notifyId+" class='windowOpen' >"+data.obj[i].typeName+"</td>"+
                                "<td notifyId="+data.obj[i].notifyId+" style='cursor:pointer;' class='windowOpen publishtip' toTypeName="+toTypeName+">"+alltype+"</td>"+
                                "<td class='title titleOne' notifyId="+data.obj[i].notifyId+">";
                            if(data.obj[i].top == '1'){
                                news +='<img src="/img/news/top.png" alt="" style="margin-right: 5px;">';
                            }
                            news +="<a href='#'  class='windowOpen' title="+data.obj[i].subject+">"+data.obj[i].subject+"</a></td>"+
                                "<td class='send_time' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].notifyDateTime/*.split(' ')[0]*/+"</td>"+
                                "<td class='start_time' href='#' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].begin.split(' ')[0]+"</td>"+
                                "<td class='end_time' href='#' notifyId="+data.obj[i].notifyId+" class='windowOpen'>"+data.obj[i].end.split(' ')[0]+"</td>"+
                                "<td class='notice_zhuangtai' notifyId="+data.obj[i].notifyId+">"+publish+"</td>"+//状态
                                "<td class='caozuo'><a class='find_detail' notifyId="+data.obj[i].notifyId+" style='color:#1772c0;'><fmt:message  code="notice.th.QueryStatus"/></a>\
                                "+function () {
                                    if (data.obj[i].publish==1){
                                        return "<a class='notice_zhongzhi' id='stop"+data.obj[i].notifyId+"' style='cursor:pointer;' onclick='stoprwo(this,"+data.obj[i].notifyId+",\"publish"+data.obj[i].notifyId+"\",\"stop"+data.obj[i].notifyId+"\")'><fmt:message  code="notice.state.end"/></a>"
                                    }else {
                                        return "<a class='notice_zhongzhi' id='stop"+data.obj[i].notifyId+"' style='cursor:pointer;' onclick='stoprwo(this,"+data.obj[i].notifyId+",\"publish"+data.obj[i].notifyId+"\",\"stop"+data.obj[i].notifyId+"\")'><fmt:message code="notice.state.effective" /></a>"
                                    }
                                }()+"<a notifyId="+data.obj[i].notifyId+" class='notice_change'><fmt:message  code="depatement.th.modify"/></a><a class='notice_delete' notifyId="+data.obj[i].notifyId+"><fmt:message  code="global.lang.delete"/></a></td>"//操作

                        }

                    }
                    var last_str='';
                    //last_str+="<tr class='last_str'><td><input id='checkedAll' class='checkChild' type='checkbox' conid='29' name='check' value=''><fmt:message  code="notice.th.allchose"/></td><td class='notice_top'><h2><fmt:message  code="notice.th.top"/></h2></td><td class='notice_notop'><h2><fmt:message  code="news.th.quittop"/></h2></td><td class='delete_check'><h2><fmt:message  code="notice.th.DeleteSelectedBulletin"/></h2></td>";

                    last_str+="<tr><td colspan='10'><input id='checkedAll' class='checkChild' type='checkbox' conid='29' name='check' value=''><fmt:message  code="notice.th.allchose"/><a class='notice_top'><span style='margin-left: 23px;'><fmt:message  code="notice.th.top"/></span></a><a class='notice_notop'><span style='margin-left:25px;'><fmt:message  code="news.th.quittop"/></span></a><a class='delete_check'><span style='margin-left: 27px;'><fmt:message  code="notice.th.DeleteSelectedBulletin"/></span></a>";

                    /*if(usersName =='admin'){
                        //last_str+="<td class='delete_all'><h2> <fmt:message  code="notice.th.DeleteAllAnnouncements"/></h2></td>";
                        last_str+="<a class='delete_all'><span style='margin-left:27px;'><fmt:message  code="notice.th.DeleteAllAnnouncements"/></span></a>";
                    }*/
                    last_str+="</td></tr>";

                    <%--if(usersName =='admin'){--%>
                    <%--last_str+="<td class='delete_all'><h2> <fmt:message  code="notice.th.DeleteAllAnnouncements"/></h2></td>";--%>
                    <%--}else{--%>
                    <%--last_str+="<td></td>";--%>
                    <%--}--%>
                    <%--last_str+="<td></td><td></td><td></td><td></td><td></td></tr>";--%>
                    $("#j_tb").html(news+last_str);
                    if(cb){
                        cb(data.totleNum);
                    }

                    if(data.totleNum==0){
                        layer.msg('<fmt:message  code="global.lang.nodata"/>', {icon: 6});
                    }
                }
            })
        };
        $('#tr_td').on('mouseenter','.publishtip',function () {
            var that = $(this);
            var str=that.attr('toTypeName').replace(/-/g,'<br>')
            layer.tips(str,that, {
                tips: [1, '#3595CC'],
                time: 10000
            });
        });
        $('#tr_td').on('mouseleave','.publishtip',function () {
            layer.closeAll();

        })
        function initPagination(totalData,pageSize){

            $('.M-box3').pagination({
                totalData:totalData,
                showData:pageSize,
                jump:true,
                coping:true,
                current: data.page,
                homePage:'<fmt:message code="global.page.first" />',
                endPage:'<fmt:message code="global.page.last" />',
                prevContent:'<fmt:message code="global.page.pre" />',
                nextContent:'<fmt:message code="global.page.next" />',
                jumpBtn:'<fmt:message code="global.page.jump" />',
                callback:function(index){
                    data.page = index.getCurrent();

                    initPageList(function(pageCount){
                        initPagination(pageCount,data.pageSize);
                    });
                }
            });
        }
        /*公告详情页 */
        $("#j_tb").on('click','.title',function(){
            var nid=$(this).attr('notifyId');
            $.popWindow('detail?notifyId='+nid,'<fmt:message code="notice.th.queryDetail"/>','0','100','1200px','700px');
        });

        //公告查询页面
        $('.submit').click(function (){
            data.read = $('.index_head .one').parent().attr('data_id');
            data.typeId = $('#select option:checked').attr("tid");
            data.nTime = $('#sendTime').val();
            //类型
            if($('.nav_type option:checked').attr('value')=='0'){
                data.typeId='';
            }else{
                data.typeId=$('.nav_type option:checked').attr('value');//类型
            }
            initPageList(function(pageCount){
                initPagination(pageCount,data.pageSize);
            });
        });
        $('.empty').click(function () {


        })
//公告查询按钮
        $('#btn_query').click(function (){
            data.read = '';
            data.subject = $("#subject_query").val();//标题
            data.beginTime = $('#beginTime').val();//开始时间
            data.endTime = $('#endTime').val();//结束时间
            //格式
            if($('#selectOne option:checked').attr('value')=='0'){
                data.format ='';
            }else{
                data.format = $('#selectOne option:checked').attr('value');//格式
            }
            //类型
            if($('#selectTwo option:checked').attr('value')=='0'){
                data.typeId='';
            }else{
                data.typeId=$('#selectTwo option:checked').attr('value');//类型
            }
            //发布状态
            if($('#selectThree option:checked').attr('value')=='0'){
                data.publish='';
            }else{
                data.publish=$('#selectThree option:checked').attr('value');//发布状态
            }
            //置顶
            if($('#selectFour option:checked').attr('value')==''){
                data.top='';
            }else{
                data.top=$('#selectFour option:checked').attr('value');//置顶
            }

            data.content = $('#content').val();//内容
            data.fromId = $('#input_text1').attr('user_id');//发布人

            initPageList();

            $('.step1').show();
            $('.center').hide();

        });
        //公告导出按钮
        $('#daochu').on('click',function(){
            var read= '';
            var subject=$("#subject_query").val();//标题
            var begintime=$('#beginTime').val();//开始时间
            var endtime=$('#endTime').val();//结束时间
            //格式
            if($('#selectOne option:checked').attr('value')=='0'){
                var format='';
            }else{
                var format=$('#selectOne option:checked').attr('value');//格式
            }
            //类型
            if($('#selectTwo option:checked').attr('value')=='0'){
                var typeId='';
            }else{
                var typeId=$('#selectTwo option:checked').attr('value');//类型
            }
            //发布状态
            if($('#selectThree option:checked').attr('value')=='0'){
                var publish='';
            }else{
                var publish=$('#selectThree option:checked').attr('value');//发布状态
            }
            //置顶
            if($('#selectFour option:checked').attr('value')==''){
                var top='';
            }else{
                var top=$('#selectFour option:checked').attr('value');//置顶
            }

            var content=$('#content').val();//内容
            var fromId=$('#input_text1').attr('user_id');//发布人
            var changeId='1';
            var exportId='2';
            var useFlag='true';
            var pageSize='5';
            var page='1';
            var newsTime='';
            var lastEditTime='';
            /* $('.step1').show();
             $('.center').hide();*/
            window.location.href='/notice/notifyList?read='+read+'&typeId='+typeId+'&useFlag='+useFlag+'&page='+page+'&pageSize='+pageSize+'&newsTime='+newsTime+'&lastEditTime='+lastEditTime+'&content='+content+'&subject='+subject+'&beginTime='+begintime+'&endTime='+endtime+'&changeId=1'+'&exportId=2'+'&format='+format+'&publish='+publish+'&TOP='+top+'&fromId='+fromId;
        })
        //公告删除按钮
        $('#find_delete').on('click',function(){
            data.read = '';
            data.subject = $("#subject_query").val();//标题
            data.beginTime = $('#beginTime').val();//开始时间
            data.endTime = $('#endTime').val();//结束时间
            //格式
            if($('#selectOne option:checked').attr('value')=='0'){
                data.format ='';
            }else{
                data.format = $('#selectOne option:checked').attr('value');//格式
            }
            //类型
            if($('#selectTwo option:checked').attr('value')=='0'){
                data.typeId='';
            }else{
                data.typeId=$('#selectTwo option:checked').attr('value');//类型
            }
            //发布状态
            if($('#selectThree option:checked').attr('value')=='0'){
                data.publish='';
            }else{
                data.publish=$('#selectThree option:checked').attr('value');//发布状态
            }
            //置顶
            if($('#selectFour option:checked').attr('value')==''){
                data.TOP='';
            }else{
                data.TOP=$('#selectFour option:checked').attr('value');//置顶
            }

            data.content = $('#content').val();//内容
            data.fromId=$('#input_text1').attr('user_id');//发布人
            data.exportId='1';
            data.changeId='2';
            initPageList();

            $('.step1').show();
            $('.center').hide();
        })


        $('#add_notice_time').on('click',function(){
            queryTime();
            $("#add_newDate").val(now);
        });
        //新建发布公告通知
        $('#add_send').on('click',function(){
            var dataTypeId=0;
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
                dataTypeId=1;
            }
            //附件循环遍历一下
            var attach=$('#query_uploadArr').find('a');
            var inp_value=$('#query_uploadArr').find('.inHidden');
            var aId='';
            var uId='';
            //value 值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                aId +=inp_value.eq(i).attr('value');
            }
            //name值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                uId += attach.eq(i).attr('name');
            }
            var action=$(this).attr("ac");
            data_notice.tuisong=dataTypeId//推送标识
            data_notice.subject=$('#add_titileTime').val()//标题
            data_notice.toId=$('#query_toId').attr('deptid')//部门发布范围

            data_notice.format=0//格式
            data_notice.userId=$('#query_userId').attr("user_id")//按人员发布
            data_notice.privId=$('#query_privId').attr('userpriv')//按角色发布
            data_notice.attachmentId=aId//附件ID串
            data_notice.attachmentName=uId//附件名称串

            data_notice.topDays=$('#textDay').val()//置顶天数



            data_notice.publish=$(this).attr('value')//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)

            data_notice.top=$("#textTop").eq(0).is(':checked')==false?0:1//是否置顶(0-否,1-是)
            /* /!* top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),*!/*/
            data_notice.summary=$('#add_summny').val()//内容简介

            data_notice.content=ue.getContent()//内容
            data_notice.sendTimes=$('#add_newDate').val()//发布时间
            data_notice.beginDates=$('#notice_start_add').val()//开始日期
            data_notice.endDates=$('#notice_end_add').val()  //结束日期
            data_notice.remind=remindVal//事务提醒

            if($('#add_titileTime').val()==''){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheTitle" />', { icon:6});/*请填写标题*/
                return false;
            }else  if(!($('#query_toId').val() || $('#query_privId').val() || $('#query_userId').val() )){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheScopeOfTheRelease" />', { icon:6});/*请填写发布范围*/
                return false;
            }else  if(ue.getContent() == ''){

                layer.msg('<fmt:message code="notify.th.PleaseFillTheText" />', { icon:6});/*请填写正文*/
                return false;
            }else{
                if(action=="update"){
                    var noId=$(this).attr("noId");
                    data_notice['lastEditTimes']=$('#add_newDate').val();
                    data_notice['notifyId']=noId;
                    data_notice['readers']='';
                    data_notice['typeId']=$('#add_type_notice option:checked').attr('value');//公告类型
                    /*    typeId:$('#add_type_notice option:checked').attr('value'),*///公告类型
                    update(data_notice);

                }else if(action=="add"){
                    if($('#add_type_notice option:checked').attr('value')=='00'){
                        data_notice['typeId']='';//公告类型
                    }else{
                        data_notice['typeId']=$('#add_type_notice option:checked').attr('value');
                    }

                    //公告类型
                    add_notice(data_notice);
                }
            }


        })
        //新建的数据接口
        function add_notice(data_notice){
            layer.load(0,{shade:[0.2, '#ffffff']});
            $.ajax({
                type: "post",
                url: "/notice/addNotify",
                dataType: 'json',
                data: data_notice,
                success: function (obj) {
                    if(obj.flag==true){
                        $.layerMsg({content:'<fmt:message  code="user.th.PublishSuccessfully"/>！',icon:1},function(){
                            window.location.reload();
                        });
                    }
                    layer.closeAll();
                }

            });
        }
        //新建公告通知,保存
        $('#add_baocun').on('click',function(){
            var dataTypeId=$(this).attr('data-type');
            var btnType=$(this).attr('attrtype');
            //事务提醒
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
            }
            var attach=$('#query_uploadArr').find('a');
            var inp_value=$('#query_uploadArr').find('.inHidden');
            var aId='';
            var uId='';
            //value 值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                aId +=inp_value.eq(i).attr('value');

            }
            //name值
            for(var i=0;i<$('#query_uploadArr .inHidden').length;i++){
                uId += attach.eq(i).attr('name');
            }
//            var action=$(this).attr("ac");

            if(btnType == 'add'){
                layer.load(0,{shade:[0.2, '#ffffff']});
                $.ajax({
                    type: "post",
                    url: "/notice/addNotify",
                    dataType: 'json',
                    data: {
                        tuisong:dataTypeId,
                        subject:$('#add_titileTime').val(),//标题
                        toId:$('#query_toId').attr('deptid'),//部门发布范围
                        format:0,//格式
                        userId:$('#query_userId').attr("user_id"),//按人员发布
                        privId:$('#query_privId').attr('privid'),//按角色发布
                        attachmentId:aId,//附件ID串
                        attachmentName:uId,//附件名称串
                        download:$(".down").is(':checked')==false?0:1,//是否允许下载office附件(0-不允许,1-允许)
                        subjectColor:'',//标题颜色
                        keyword:$('.keyword_ip').val(),//内容关键词
                        topDays:$('#textDay').val(),//置顶天数
                        publish:$(this).attr('value'),//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
                        top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),
                        summary:$('#add_summny').val(),//内容简介
                        content:ue.getContent(),//内容
                        sendTimes:$('#add_newDate').val(),//发布时间
                        beginDates:$('#notice_start_add').val(),//开始日期
                        endDates:$('#notice_end_add').val(), //结束日期
                        remind:remindVal//事务提醒
                    },
                    success: function (obj) {
                        if(obj.flag==true){
                            $.layerMsg({content:' <fmt:message  code="diary.th.modify"/>！',icon:1},function(){
                                window.location.reload();
                            });
                        }
                        layer.closeAll();
                    }

                });
            }else{
                var notifyId=$('#add_send').attr('noid');
                layer.load(0,{shade:[0.2, '#ffffff']});
                $.ajax({
                    url: "updateNotify",
                    type: "post",
                    data: {
                        notifyId:notifyId,//主键ID
                        subject:$('#add_titileTime').val(),//标题
                        toId:$('#query_toId').attr('deptid'),//部门发布范围
                        format:0,//格式
                        typeId:$('#add_type_notice option:checked').val(),//公告类型
                        //startTime:$('#notice_start_add').val(),//有效期
                        userId:$('#query_userId').attr("user_id"),//按人员发布
                        privId:$('#query_privId').attr('userpriv'),//按角色发布
                        attachmentId:aId,//附件ID串
                        attachmentName:uId,//附件名称串
                        download:$(".down").is(':checked')==false?0:1,//是否允许下载office附件(0-不允许,1-允许)
                        subjectColor:'',//标题颜色
                        keyword:$('.keyword_ip').val(),//内容关键词
                        topDays:$('#textDay').val(),//置顶天数
                        publish:$(this).attr('value'),//发布标识(0-未发布,1-已发布,2-待审批,3-未通过)
                        top:$("#textTop").eq(0).is(':checked')==false?0:1,//是否置顶(0-否,1-是)
                        /* /!* top:$("#add_textTop").is(':checked')==false?0:1,//是否置顶(0-否,1-是),*!/*/
                        summary:$('#add_summny').val(),//内容简介
                        content:ue.getContent(),//内容
                        sendTimes:$('#add_newDate').val(),//发布时间
                        beginDates:$('#notice_start_add').val(),//开始日期
                        endDates:$('#notice_end_add').val(),  //结束日期
                        remind:remindVal//事务提醒
                    },
                    dataType: 'json',
                    success: function (obj) {

                        if(obj.flag==true){
                            $.layerMsg({content:' <fmt:message  code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                                window.location.reload();
                            });
                        }
                        layer.closeAll();
                    }
                })
            }

        })

        //修改保存的数据接口
        function update(data_notice){
            $.ajax({
                url: "updateNotify",
                type: "post",
                data: data_notice,
                dataType: 'json',
                success: function (obj) {

                    if(obj.flag==true){
                        $.layerMsg({content:' <fmt:message  code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                            window.location.reload();
                        });
                    }

                }
            })
        }

        //修改公告通知管理
        $('#j_tb').on('click','.notice_change',function(){
            $('.nav_t2').html('<fmt:message code="notify.th.AnnounceNoticeOfNotice" />');/*修改公告通知*/

            var tid=$(this).attr('notifyId');
            $('.step1').hide();
            $('.step2').show();
            $('#add_send').attr('ac',"update");
            $('#add_send').attr('noId',tid);

            $('.center').hide();
            $('#add_baocun').attr('attrType','edit');
            ue.ready(function(){
                //公告详情
                $.ajax({
                    url: "getOneById",
                    type: "get",
                    data:{
                        notifyId:tid,
                        permissionId:'1',
                        changId:'1'
                    },
                    dataType: 'json',
                    success: function (obj) {
                        var data=obj.object;
                        var durl;
                        var attachs='';
                        for(var i=0;i<data.attachment.length;i++){
                            attachs += '<div class="dech" deUrl="'+encodeURI(data.attachment[i].attUrl)+'"><a class="ATTACH_a" NAME="'+data.attachment[i].attachName+'*" href="/download?'+encodeURI(data.attachment[i].attUrl)+'">'+data.attachment[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data.attachment[i].attachName+'*"  class="inHidden" value="'+data.attachment[i].aid+'@'+data.attachment[i].ym+'_'+data.attachment[i].attachId+',"></div>'//附件内容
                        }

                        var endTime=new Date((data.endDate)*1000).Format('yyyy-MM-dd hh:mm:ss');
                        var beginDate=new Date((data.beginDate)*1000).Format('yyyy-MM-dd hh:mm:ss');
                        $('#add_titileTime').val(data.subject);
                        $('#query_privId').val(data.rolerange);//选角色
                        $('#query_privId').attr('userpriv',data.privId);
                        $('#query_userId').val(data.userrange);//选人
                        $('#query_userId').attr('user_id',data.userId);
                        $('#query_toId').val(data.deprange);//选部门
                        $('#query_toId').attr('deptid',data.toId);
                        /*if($('.start_time').val()==''){
                            $('#notice_start_add').val('');//起始时间
                        }else{
                            $('#notice_start_add').val(data.beginDate);//起始时间
                        }
                        if($('.end_time').val()==''){
                            $('#notice_end_add').val('');//结束时间
                        }else{
                            $('#notice_end_add').val(data.endDate);//结束时间
                        }*/

                        $('#notice_start_add').val(data.begin),//开始日期
                            $('#notice_end_add').val(data.end),  //结束日期
                            $('#add_newDate').val(data.notifyDateTime);//发布时间


                        $('#query_uploadArr').html(attachs);//附件

                        //  $("#add_type_notice").find("option[value="+data.typeId+"]").attr("selected",true);//类型
                        if(data.top==1){
                            $('#textTop').prop('checked',true);//是否置顶
                        };
                        ue.setContent(data.content);//内容
                        if(data.top==1){
                            $('.print').prop('checked',true);//是否打印
                        }
                        if(data.top==1){
                            $('.down').prop('checked',true);//是否下载
                        }
                        $('#add_type_notice').val(data.typeId);//公告类型
                        $('#textDay').val(data.topDays)//置顶天数
                        $('#add_summny').val(data.summary);//内容
                        $('.keyword_ip').val(data.keyword);//关键词


                    }

                })
            })

        });
        //点击复选框
        $("#j_tb").on('click','#notice_tr',function () {
            /*    alert('111');*/
            var state=$(this).find('.checkChild').prop("checked");
            if(state==true){
                $(this).find('.checkChild').prop("checked",true);
                $(this).addClass('bgcolor');
            }else{
                $('#checkedAll').prop("checked",false);
                $(this).find('.checkChild').prop("checked",false);
                $(this).removeClass('bgcolor');
            }
            var child =   $(".checkChild");
            for(var i=0;i<child.length;i++){
                var childstate= $(child[i]).prop("checked");
                if(state!=childstate){
                    return
                }
            }
            $('#notice_tr').prop("checked",state);
        })
        //点击全选
        $('#j_tb').on('click','#checkedAll',function(){
            /*alert('111');*/
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkChild").prop("checked",true);
                $(this).parents('tr').siblings('#notice_tr').addClass('bgcolor');
            }else{
                $(this).prop("checked",false);
                $(".checkChild").prop("checked",false);;
                $(this).parents('tr').siblings('#notice_tr').removeClass('bgcolor');
            }
        })
        //删除封装的方法
        function dataDelete(fileId){
            layer.confirm(' <fmt:message  code="global.lang.sure"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title:" <fmt:message  code="notice.th.DeleteFile"/>"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'post',
                    url:'/notice/deleteByIds',
                    dataType:'json',
                    data:{'notifyIds':fileId},
                    success:function(json){
                        if (json.code == '100066'){
                            layer.msg('<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', {icon: 4});
                        } else {
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                        }
                        /* init(4,id,1);*/
                        window.location.reload();
                    }
                })

            }, function(){
                layer.closeAll();
            });

        }
        //点击删除选中按钮
        $('#j_tb').on('click','.delete_check',function(){
            /* alert('111');*/
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){

                var conId=$(this).attr("conId");
                /*  alert(conId);*/
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                /*    $('.contentTrs').remove();
                    $('.mainContent').show();
                    $('.details').hide();*/
                dataDelete(fileId)
            }
        })

        //设置置顶
        $('#j_tb').on('click','.notice_top',function(){
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){
                var conId=$(this).attr("conId");
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                layer.confirm(' <fmt:message  code="notice.th.ifTop"/>？', {
                    btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title:" <fmt:message  code="notice.th.TopFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/notice/updateByIds',
                        dataType:'json',
                        data:{
                            notifyIds:fileId,
                            top:'1'
                        },
                        success:function(){
                            layer.msg(' <fmt:message  code="notice.th.TopSuccess"/>', { icon:6});
                            /* init(4,id,1);*/
                            window.location.reload();
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            }
        })
        //取消置顶
        $('#j_tb').on('click','.notice_notop',function(){
            var fileId=[];
            $("#j_tb .checkChild:checkbox:checked").each(function(){
                var conId=$(this).attr("conId");
                fileId.push(conId);

            })
            if(fileId == ''){
                $.layerMsg({content:'<fmt:message code="file.th.PleaseSelectFile"/>！',icon:1});
            }else{
                layer.confirm('<fmt:message  code="notice.th.cancelTop"/>？ ', {
                    btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                    title:" <fmt:message  code="notice.th.CancelTopFile"/>"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'/notice/updateByIds',
                        dataType:'json',
                        data:{
                            notifyIds:fileId,
                            top:'0'
                        },
                        success:function(){
                            layer.msg(' <fmt:message  code="notice.th.CancelTopSuccess"/>', { icon:6});
                            /* init(4,id,1);*/
                            window.location.reload();
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            }
        })
        //查阅情况
        $('#j_tb').on('click','.find_detail',function(){
            /* alert('111');*/
            var notifyId=$(this).attr('notifyId');
            $.popWindow("finddetail?notifyId="+notifyId,'<fmt:message code="news.th.querysituation" />','0','0','1150px','700px');
        })


        //删除公告通知管理
        $('#j_tb').on('click','.notice_delete',function(){
            var that = $(this).parents('#notice_tr');
            var tid=$(this).attr('notifyId');

            layer.confirm(' <fmt:message  code="global.lang.sure"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'] ,//按钮
                title:' <fmt:message  code="workflow.th.suredel"/>'
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: "/notice/deleteById",
                    type: "get",
                    data:{
                        notifyId:tid
                    },
                    dataType: 'json',
                    success: function (obj) {
                        if (obj.code == '100066'){
                            layer.msg('<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', {icon: 4});
                        } else {
                            //第三方扩展皮肤
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});
                        }
                        that.remove();
                    }
                })

            }, function(){
                layer.closeAll();
            });


        })
        //删除附件
        function deleteChatment(data,element){

            layer.confirm(' <fmt:message  code="workflow.th.que"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>',' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title:" <fmt:message  code="notice.th.DeleteAttachment"/>"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'../delete',
                    dataType:'json',
                    data:data,
                    success:function(res){

                        if(res.flag == true){
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', { icon:6});
                            element.remove();
                        }else{
                            layer.msg(' <fmt:message  code="lang.th.deleSucess"/>', { icon:6});
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }

        //点击x，删除附件
        $('.enclosure').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })
        //改代码用于处理因页面初始化有效期起止时间为相同时间造成的修改公告 数据回显功能错误
        $('#notice_start_add').val(' ');
        $('#notice_end_add').val(' ');

    });

    /* 终止和生效方法 */

    function stoprwo(me,id,publishId,stopId){
        var pulbish;
        /*  alert($(stopId).html()); */
        if($('#'+stopId).html()=='<fmt:message code="notice.state.end" />'){
            pulbish = "0";
            /* 	alert(2); */
        }else if($('#'+stopId).html() == '<fmt:message code="notice.state.effective" />'){
            pulbish = "1";
        }
        var data={
            "notifyId":id,
            "publish":pulbish  // 发布标识(0-未发布,1-已发布,2-已终止)
        };
        $.ajax({
            url:"updateNotify",
            type:'post',
            dataType:"JSON",
            data : data,
            success:function(data){
                if($(me).html()=='<fmt:message code="notice.state.end" />'){
                    $(me).parent().prev().html("<fmt:message code="notice.state.end" />");
                    $(me).html("<fmt:message code="notice.state.effective" />");
                }else if($(me).html() == '<fmt:message code="notice.state.effective" />'){
                    $(me).parent().prev().html("<fmt:message code="notice.state.effective" />");
                    $(me).html("<fmt:message code="notice.state.end" />");
                }
            },
            error:function(e){
            }
        });

    }

    var now = null;
    function queryTime(){
        function p(s) {
            return s < 10 ? '0' + s: s;
        }
        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        var s=myDate.getSeconds();

        now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
    }

    laydate({
        elem: '#add_newDate', //目标元素。
        format: 'YYYY-MM-DD hh:mm:ss', //日期格式
        istoday: true,
        istime: true //显示时、分、秒
    });

    //查询公告时间控件调用
    var start = {
        elem: '#beginTime',
        format: 'YYYY-MM-DD hh:mm:ss',
        /* min: laydate.now(), //设定最小日期为当前日期
         max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endTime',
        format: 'YYYY-MM-DD hh:mm:ss',
        /*     min: laydate.now(),
             max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    /*新建公告时间控件调用*/

    var starts = {
        elem: '#notice_start_add',
        format: 'YYYY-MM-DD',
        /*        min: laydate.now(), //设定最小日期为当前日期
                max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };
    var ends = {
        elem: '#notice_end_add',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
               max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    /*   find_start*/
    var find_start = {
        elem: '#find_start',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
         max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    var find_end = {
        elem: '#find_end',
        format: 'YYYY-MM-DD',
        /*       min: laydate.now(),
         max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
    laydate(starts);
    laydate(ends);
    laydate(find_start);
    laydate(find_end);

    $('#add_type_notice').change(function () {
        //console.log($(this).find('option:selected').attr('data-id'))
        if($(this).find('option:selected').val()=='01'){
            $('#addtianjia').show()
            $('#add_send').hide()
            $('#add_send').attr('value',2)

        }else {
            $('#addtianjia').hide()
            $('#add_send').show()
            $('#add_send').attr('value',1)
        }
    })

    $('#addtianjia').click(function () {
        layer.open({
            title:'<fmt:message code="adding.th.Submit" />',
            content:'' +
            '<ul class="formUl">' +
            '<li class="clearfix"><label><fmt:message code="hr.th.Approver" /></label><select name="shenpiren" id=""><option value=""><fmt:message code="customer.pleaseSelect" /></option></select></li>' +
            '<li class="clearfix" style="display: none;"><label><fmt:message code="notice.th.remindTheApprover" /></label><label><input type="checkbox" style="float: none"><fmt:message code="notice.th.remindermessage" /></label></li>' +
            '</ul>',
            btn:['<fmt:message code="system_setting.confirm" />','<fmt:message code="license.cancel" />'],
            success:function () {
                $.get('/sys/getDeptManagers',function (json) {
                    if(json.flag){
                        var arr=json.obj;
                        var str='<option value=""><fmt:message code="customer.pleaseSelect" /></option>';
                        for(var i=0;i<arr.length;i++){
                            str+='<option value="'+arr[i].userId+'">'+arr[i].userName+'</option>'
                        }
                        $('[name="shenpiren"]').html(str)

                    }
                },'json')
            },
            yes:function (index) {
                data_notice.auditer=$('[name="shenpiren"]').val()
                $('#add_send').click()
            }
        })
    })


</script>
</body>
</html>