<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-11
  Time: 21:12
  To change this template use File | Settings | File Templates.
--%>
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
    <title><fmt:message code="new.th.newsApproval" /></title>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <!-- 新闻管理  -->
    <link rel="stylesheet" type="text/css" href="../css/news/management_query.css" />
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <!-- word文本编辑器 -->
<%--    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>--%>
    
    <!-- kindeditor文本编辑器 -->
		<script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
		<script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>

    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
    *{
        padding:0;
        margin:0;
    }
    .release4{
        margin-top: 10px;
    }
    .publishtip {
        overflow: hidden;
        text-overflow:ellipsis;
        width: 100%;
        white-space:nowrap;
    }

    /*标题长时隐藏设置*/
    .title{
        width: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    #tr_td thead tr td{
        font-size:13pt;
    }
    #j_tb tr td{
        font-size:11pt;
    }
    #tr_td1 thead tr td{
        font-size:13pt;
    }
    #j_tb1 tr td{
        font-size:11pt;
    }
    .blue_text{
        font-size:11pt;
    }
    select, input, textarea{
        font-size: 11pt;
    }
    .total .query_title{
        font-size: 13pt;
    }
    .bar {
        height: 18px;
        background: green;
    }
    .bar_ {
        height: 18px;
        background: green;
    }
    .top_box .t_box{
        float: left;
    }
    th{
        text-align: center;
    }
    .step1 , .step2{
        margin: 0px;
        padding: 8px;
    }
    .jump-ipt{
        padding: 0px;
    }
    #edui1_iframeholder{
        height: 210px;
    }
    table{
        text-align: center;
    }
        input[type="button"],input[type="file"] {
            width: auto;
        }
    .navigation .left div {
        float: left;
    }
    .navigation .left {
        line-height: 82px;
    }
    .navigation .left .news {
        margin-top: -3px;
    }
</style>
</head>

<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="bx">
    <!--head开始-->
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id=""><span class="one headli1_1"><fmt:message code="new.th.newsPendingApproval" /></span><img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            <li data_id="1"><span class="headli2_1"><fmt:message code="new.th.approvedNews" /></span></li>
        </ul>
    </div>
    <!--head通栏结束-->
    <!--navigation开始-->
    <%--待审批--%>
    <div class="step1">
        <div class="navigation  clearfix">
            <div class="left">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenguanli.png">
                <div class="news">
                    <fmt:message code="new.th.newsPendingApproval" />
                </div>
            </div>
        </div>
        <!--navigation结束-->
        <!--content部分开始-->
        <div>
            <div>
                <table id="tr_td" style="table-layout: fixed;">
                    <thead>
                    <tr>
                        <%--<td class="th" style="width: 6%;"><fmt:message code="global.lang.select"/></td>--%>
                        <td class="th" style="width: 9%;"><fmt:message code="notice.th.publisher"/></td>
                        <td class="th" style="width: 8%;"> <fmt:message code="notice.th.type"/></td>
                        <td class="th" style="width: 10%;"><fmt:message code="notice.th.releasescope"/></td>
                        <td class="th" style="width: 17%;"><fmt:message code="notice.th.title"/></td>
                        <td class="th" style="width: 12%;"><fmt:message code="notice.th.PostedTime"/></td>
<%--                        <td class="th" style="width:5%;"><fmt:message code="news.th.clicknumber"/></td>&lt;%&ndash;点击数&ndash;%&gt;--%>
                        <td class="th" style="width:17%;"><fmt:message code="new.th.newsProcessInformation" /></td>
                        <%--<td class="th" style="width: 7%;"><fmt:message code="notice.th.state"/></td>--%>
                        <td class="th" style="width: 7%;"><fmt:message code="notice.th.postedType" /></td>
                        <td class="th" style="width: 7%;"><fmt:message code="event.th.ApprovalStatus" /></td>
                        <td class="th" style="width: 7%;"><fmt:message code="hr.th.Approver" /></td>
                        <td class="th" style="width:12%;"><fmt:message code="notice.th.operation"/></td><%--操作--%>
                    </tr>
                    </thead>
                    <tbody id="j_tb">

                    </tbody>
                </table>
            </div>
        </div>
        <!--content部分结束-->
        <div class="right">
            <!-- 分页按钮-->
            <div class="M-box3">
            </div>
        </div>
    </div>
    <%--已审批--%>
    <div class="step2" style="display: none">
        <div class="navigation  clearfix">
            <div class="left">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenguanli.png">
                <div class="news">
                    <fmt:message code="new.th.approvedNews" />
                </div>
            </div>
        </div>
        <!--navigation结束-->
        <!--content部分开始-->
        <div>
            <div>
                <table id="tr_td1" style="table-layout: fixed;">
                    <thead>
                    <tr>
                        <%--<td class="th" style="width: 6%;"><fmt:message code="global.lang.select"/></td>--%>
                        <td class="th" style="width: 9%;"><fmt:message code="notice.th.publisher"/></td>
                        <td class="th" style="width: 8%;"> <fmt:message code="notice.th.type"/></td>
                        <td class="th" style="width: 10%;"><fmt:message code="notice.th.releasescope"/></td>
                        <td class="th" style="width: 17%;"><fmt:message code="notice.th.title"/></td>
                        <td class="th" style="width: 12%;"><fmt:message code="notice.th.PostedTime"/></td>
<%--                        <td class="th" style="width:5%;"><fmt:message code="news.th.clicknumber"/></td>&lt;%&ndash;点击数&ndash;%&gt;--%>
                        <td class="th" style="width:17%;"><fmt:message code="new.th.newsProcessInformation" /></td>
                        <%--<td class="th" style="width: 7%;"><fmt:message code="notice.th.state"/></td>--%>
                        <td class="th" style="width: 7%;"><fmt:message code="notice.th.postedType" /></td>
                        <td class="th" style="width: 7%;"><fmt:message code="event.th.ApprovalStatus" /></td>
                        <td class="th" style="width: 7%;"><fmt:message code="hr.th.Approver" /></td>
                        <td class="th" style="width:12%;"><fmt:message code="notice.th.operation"/></td><%--操作--%>
                    </tr>
                    </thead>
                    <tbody id="j_tb1">

                    </tbody>
                </table>
            </div>
        </div>
        <!--content部分结束-->
        <div class="right">
            <!-- 分页按钮-->
            <div class="M-box4">
            </div>
        </div>
    </div>
    <!--修改新建新闻页面*************************  -->
    <div class="step3" style="display:none ;margin-left: 10px;">
        <!-- 中间部分 -->
        <table class="newNews">
            <div class="nav_box clearfix">
                <div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenxinjian.png"></div>
                <div class="nav_t2" class="news"><fmt:message code="news.title.new"/></div>
                <div class="nav_t3 sel format" id="format_">
                    <fmt:message code="notice.format.Commonformat"/>
                </div>
            </div>
            <tbody>
            <tr>
                <td class="td_w">
                    <!-- <div class="text1 blue_text">请选择新闻类型</div>
                    <img class="text2" src="../img/mg1.png" alt=""/> -->
                    <select name="" id="step3_type" class="">
                        <%-- <option value="">&nbsp;<fmt:message code="news.th.selecttype"/></option>
                         <option value="01"><fmt:message code="news.th.company"/></option>
                         <option value="02"><fmt:message code="news.th.media"/></option>
                         <option value="03"><fmt:message code="news.th.industry"/></option>
                         <option value="04"><fmt:message code="news.th.partner"/></option>
                         <option value="05"><fmt:message code="news.th.client"/></option>--%>
                    </select>
                </td>
                <td>
                    <input class="td_title1 subject" id="step3_ip1" type="text" placeholder='<fmt:message code="new.th.putnew"/>'/><%--请输入新闻标题...--%>
                    <img class="td_title2" src="../img/mg2.png" alt=""/>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.IssuedByDepartment"/>：<br/><a href="javaScript:;" style="color: #207bd6;font-size: 14px;font-weight: normal;" id="personnel_" onclick="showAndHidden('personnel_','role_','man_')"><fmt:message code="notice.th.Hidden"/> </a><%--隐藏按人员或角色发布--%>
                </td>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="step3_ip2" dataid="" resize="auto" style="width:70%;border-radius: 4px;" rows="5"></textarea>
                    <%--<input class="td_title1  release1 toId" type="text"id="step3_ip2"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3" id="dept_add_"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty" onclick="empty('step3_ip2')"><fmt:message code="global.lang.empty"/></div>

                </td>
            </tr>
            <tr id="role_">
                <td class="blue_text">
                    <fmt:message code="notice.th.role"/>：
                </td>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="privId_" dataid="" resize="auto" style="width:70%;border-radius: 4px;" rows="5"></textarea>
                    <%--<input class="td_title1  release1 toId" type="text"id="privId_"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3" id="priv_add_"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty" onclick="empty1('privId_')"><fmt:message code="global.lang.empty"/></div>
                </td>
            </tr>
            <tr id="man_">
                <td class="blue_text">
                    <fmt:message code="notice.th.somebody"/>：
                </td>
                <td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="userId_" dataid="" resize="auto" style="width:70%;border-radius: 4px;" rows="5"></textarea>
                    <%--<input class="td_title1  release1 toId" type="text"id="userId_"/>--%>
                    <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
                    <div class="release3" id="adduser_"><fmt:message code="global.lang.add"/></div>
                    <div class="release4 empty" onclick="empty2('userId_')"><fmt:message code="global.lang.empty"/></div>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.PostedTime"/>：
                </td>
                <td>
                    <input class="td_title1 newTime" id="step3_ip3"  class="step3_te" type="text" placeholder='<fmt:message code="new.th.puttime"/>'/><%--请输入发布时间...--%>
                    <a href="javascript:;" id="step_release3"><div class="release3" ><fmt:message code="news.th.SetToTheCurrentTime"/></div></a><%--设置为当前时间--%>
                </td>
            </tr>
            <tr>
						<td class="blue_text">
							<fmt:message code="event.th.author" />:
						</td>
						<td>
							<input class="td_title1" id="author" type="text" placeholder="<fmt:message code="new.th.pleaseEnterTheAuthor" />"/>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="new.th.photography" />:
						</td>
						<td>
							<input class="td_title1" id="photographer" type="text" placeholder="<fmt:message code="new.th.pleaseEnterPhotography" />"/>
						</td>
					</tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="news.th.comment"/>:
                </td>
                <td style="text-align: left">
                    <select name="step3_anonymityYn" class="" id="anonymityYn_">
                        <option value="0"><fmt:message code="new.th.noanonymity"/></option>
                        <option value="1"><fmt:message code="new.th.anonymous"/></option>
                        <option value="2"><fmt:message code="new.th.prohibit"/></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.reminder"/>：
                </td>
                <td class="remind">
                    <div><input class="news_t1 remindCheck1"  type="checkbox" checked="checked" /></div>
                    <div class="news_t"><fmt:message code="notice.th.remindermessage"/></div>
                    <%--&lt;%&ndash;<div><input class="news_t1" type="checkbox" checked/></div>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<div class="news_t2"><fmt:message code="notice.th.share"/></div>&ndash;%&gt;--%>
                </td>
            </tr>
            <%--<tr>--%>
            <%--<td class="blue_text">--%>
            <%--<fmt:message code="notice.th.reminder"/>：--%>
            <%--</td>--%>
            <%--<td class="remind">--%>
            <%--<div><input class="news_t1"  type="checkbox" checked/></div>--%>
            <%--<!--  <div><img src="../img/mg3.png" alt=""/></div> -->--%>
            <%--<div class="news_t"><fmt:message code="notice.th.remindermessage"/></div>--%>
            <%--&lt;%&ndash;<div><input class="news_t1" type="checkbox" checked/></div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<div class="news_t2"><fmt:message code="notice.th.share"/></div>&ndash;%&gt;--%>
            <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.top"/>：
                </td>
                <td class="top_box">
                    <div><input class="news_t1" id="top_" type="checkbox"/></div>
                    <div class="news_t3"><fmt:message code="new.th.topMajor"/></div>
                    <input class="t_box topDays" id="topDays" type="text" placeholder="0"/>
                    <div class="news_t4"><fmt:message code="notice.th.endTop"/></div>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.contentValidity"/>：
                </td>
                <td class="abstract">
                    <div>
                        <textarea class="abstract1 Content" name="summary" placeholder='<fmt:message code="new.th.putcontent"/>'  id="step3_ip4" cols="50" rows="2" maxlength="100" style="background: #fff; height: 100px"></textarea>
                    </div>
                    <div class="abstract2"><fmt:message code="notice.th.contentHigh"/></div>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="global.th.fileup"/>：
                </td>
                <td class="enclosure">
                    <div id="query_uploadArr_" style="display:block;text-align: left">
                    </div>
                    <div style="float: left;"><img src="../img/mg11.png" alt=""/></div>
                    <!--  <div class="enclosure_t"><a href="#">添加附件</a></div> -->
                    <div style="cursor: pointer;float: left;">
                        <form  id="uploadimgform_" target="uploadiframe"  action="../upload?module=news" enctype="multipart/form-data" method="post" >
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg_"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;
filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="uploadimg_"><fmt:message code="notice.th.addfile"/></a>
                        </form>
                    </div>
                    <div id="progress_" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                        <div class="bar_" style="width: 0%;"></div>
                    </div>
                    <div class="barText_" style="float: left;margin-left: 10px;"></div>
                    <%--<div><img src="../img/mg12.png" alt=""/></div>--%>
                    <%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.net"/></a></div>--%>
                    <%--<div><img src="../img/mg13.png" alt=""/></div>--%>
                    <%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.poto"/></a></div>--%>
                    <%--<div><img src="../img/mg14.png" alt=""/></div>--%>
                    <%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.up"/></a></div>--%>
                </td>
            </tr>
            <!--word编辑器-->

            <tr>
                <td colspan="2">
<%--                    <div id="container3" name="content" type="text/plain" style="width: 100%;"></div>--%>
                    <div>
								<textarea id="newKindEditor" name="content" style="width:100%;height:300px;"></textarea>
							</div>
                </td>
            </tr>
            <tr>
                <td class="blue_text">
                    <fmt:message code="notice.th.keyWord"/>：
                </td>
                <td class="keyword">
                    <input class="keyword_ip step3_5 Keyword" id="ip5" type="text" placeholder='<fmt:message code="news.th.PleaseEnterAKeyword"/>'/><%--请输入关键词...--%>
                    <%--<div class="keyword_t"><fmt:message code="notice.th.AutomaticKeywordAcquisition"/></div>--%>

                    <div class="keyword_t2"><fmt:message code="notice.th.keyContent"/></div>
                </td>
            </tr>
            </tbody>

        </table>
        <div  class="foot_mg">
            <!-- <img  id="hd" class="fot_1 submit_ok" src="../img/mg5.png" alt=""/> 发布
            <img  id="step3_rs" class="submit_ok"   src="../img/mg6.png" alt=""/> 保存 -->
            <div class="btn_">
                <%--<div  id="" data-type="1" type_="publish" class="fot_1 submit_ok" style="width:80px;color:#666666; background: url(../img/publish.png) no-repeat;"><fmt:message code="global.lang.publish"/></div>--%>
                <div  id="rs" data-type="0" type_="save" class="btn_style submit_ok" style="width:80px;color:#666666;"><fmt:message code="global.lang.save"/></div>
                <div  id="goBack" style="width:80px;color:#666666;"><fmt:message code="notice.th.return"/></div>

                <input id="hidden_id" type='hidden' value="">
            </div>
        </div>


    </div>
    <!--content部分结束-->
</div>

<script>
    var data={
        auditerStatus:0,
        page: 1,
        pageSize: 5,
        useFlag: true
    }
        user_id='query_userId';//选人控件
        user_id='privId_';
        user_id='step3_ip2';
        pareValue = 0
        $(function () {
            $.ajax({
                type:'get',
                url:'/syspara/queryOrgScope',
                dataType:'json',
                success:function (reg) {
                    var item=reg.object;
                    if(item.paraValue == 1 && $.cookie('userId')!= 'admin'){
                        pareValue = 1
                        $('#personnel').text('<fmt:message code="notice.th.somebody" />')
                        // $('#role').hide()
                    }else{
                        $('#personnel').text('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />')
                        pareValue = 0
                        // $('#role').show()
                    }
                }
            })
            //页面加载时发送ajax获取下拉框数据
            var str2="<option value=\"0\" selected=\"\"><fmt:message code="news.th.selecttype"/></option>";
            $.ajax({
                url: "/code/GetDropDownBox",
                type:'get',
                dataType:"JSON",
                data : {"CodeNos":"NEWS"},
                success:function(data){
                    for (var proId in data){
                        for(var i=0;i<data[proId].length;i++){
                            str2+='<option value="'+data[proId][i].codeNo+'">'+data[proId][i].codeName+'</option>'
                        }
                    }
                    $('#step3_type').append(str2);
                }

            })

            fileuploadFn('#uploadinputimg',$('#query_uploadArr'));

            $('#query_uploadArr').on('click','.deImgs',function(){
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
//                            alert(data);
//                            alert(dome);
                deleteChatment(data,dome);
            });

            $('#uploadinputimg_').fileupload({
                dataType:'json',
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress_ .bar_').css(
                        'width',
                        progress + '%'
                    );
                    $('.barText_').html(progress + '%');
                    if(progress >= 100){
                        timer=setTimeout(function () {
                            $('#progress_ .bar_').css(
                                'width',
                                0 + '%'
                            );
                            $('.barText_').html('');
//                            $('#progress').hide();
//                            $('.barText').hide();
                        },2000);

                    }
                },
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
                                str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                            }
                        }
                        $('#query_uploadArr_').append(str);
                    }else{
                        //alert('添加附件大小不能为空!');
                        layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });
            $('#query_uploadArr_').on('click','.deImgs',function(){
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
//                            alert(data);
//                            alert(dome);
                deleteChatment(data,dome);
            });
            /* word文本编辑器 */
            
            initPageList(function(pageCount){
                initPagination(pageCount,data.pageSize);
            });
            //切换栏
            $(".index_head li").on('click',function (){
                $(this).find('span').addClass('one').parent().siblings('').find('span').removeClass('one');  // 删除其他兄弟元素的样式
                if($(this).attr('data_id') == ''){
                    $('.step1').show();
                    $('.step2').hide();
                    $('.step3').hide();
                    data.auditerStatus = 0
                    initPageList(function(pageCount){
                        initPagination(pageCount,data.pageSize);
                    });
                }else if($(this).attr('data_id')== 1){
                    $('.step1').hide();
                    $('.step2').show();
                    $('.step3').hide();
                    data.auditerStatus = 1
                    initPageList1(function(pageCount){
                        initPagination1(pageCount,data.pageSize);
                    });
                }
            });
            function initPageList(cb){
                $.ajax({
                    type: "get",
                    url: "/news/getNewStatus",
                    dataType: 'JSON',
                    data:data,
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

                            var typeName = ""
                            if(data.obj[i].typeName==-1){
                                typeName ="";
                            }else{
                                typeName =data.obj[i].typeName;
                            };
                            var comment="";
                            if(data.obj[i].anonymityYn==2){
                                comment=""
                            }else{
                                comment='<fmt:message code="new.th.ManageComments" />'<%--管理评论--%>
                            };
                            news += "<tr class='trs' id='news_tr' rid='"+data.obj[i].newsId+"'><input class='input_hide' type='hidden' newsID='"+data.obj[i].newsId+"'>"+
                                // "<td><input class='checkChild' type='checkbox' conid="+data.obj[i].newsId+" name='check' value=''></td>"+//选择
                                "<td class='name' nid='"+data.obj[i].newsId+"'>"+data.obj[i].providerName+"</td>"+//发布人
                                "<td class='type' nid='"+data.obj[i].newsId+"'>"+typeName+"</td>"+//类型
                                "<td class='cli' name='"+data.obj[i].depName+"'><div id='break"+data.obj[i].newsId+"' class='break_td  publishtip' style='overflow: hidden;\n" +
                                "    text-overflow: ellipsis;\n" +
                                "    width: 100%;\n" +
                                "    white-space: nowrap;'  toTypeName="+toTypeName+">"+alltype+"</div></td>"+//发布范围
                                "<td time='"+data.obj[i].subject+"'><a  style='color:#59b7fb'  href='#' newsId="+data.obj[i].newsId+" class='windowOpen'><div id='subject"+data.obj[i].newsId+"' class='title' title='"+data.obj[i].subject+"'>";
                            if(data.obj[i].top == 1){
                                news +='<img src="/img/news/top.png" alt="" style="margin-right: 5px;vertical-align: middle;">'
                            }
                            news +=data.obj[i].subject+"</div></a></td>"+//标题
                                "<td  class='tim'>"+timestampToTime1(data.obj[i].newsTime)+"</td>"+//发布时间
                                // "<td class='data'>"+data.obj[i].clickCount+"</td>"+//点击数
                                //"<td class='num'>"+data.obj[i].newsId+"</td>"+//评论（条）
                                "<td class='state'>"+function(){
                                var str = '';
                                        if (data.obj[i].flowRun) {
                                            var flowRun = data.obj[i].flowRun;
                                            str = '<div style="color:#59b7fb;overflow: hidden;text-overflow: ellipsis;width: 100%;white-space: nowrap;"><a class="open_news_flow" style="color:#59b7fb" href="javascript:;" runid="'+flowRun.runId+'" flowid="'+flowRun.flowId+'">'+flowRun.runName+'</a></div>';
                                        }
                                        return str;
                                    }()+"</td>"+// 新闻流程信息
                                "<td class='state' id=publish"+data.obj[i].newsId+">"+function () {
                                    if(data.obj[i].publish==0){
                                        return '<fmt:message code="notice.th.unposted" />'
                                    }else if(data.obj[i].publish==1){
                                        return '<fmt:message code="notice.th.posted" />'
                                    }else if(data.obj[i].publish==2){
                                        return '<fmt:message code="notice.th.hasEnd" />'
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//发布状态
                                "<td class='state' >"+function () {
                                    if(data.obj[i].auditerStatus==0){
                                        return '<fmt:message code="meet.th.PendingApproval" />'
                                    }else if(data.obj[i].auditerStatus==1){
                                        return '<fmt:message code="meet.th.Ratified" />'
                                    }else if(data.obj[i].auditerStatus==2){
                                        return '<fmt:message code="meet.th.NotApprove" />'
                                    }else if(data.obj[i].auditerStatus==3){
                                        return '<fmt:message code="new.th.processApproval" />'
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//批准状态
                                "<td class='state'>"+function () {
                                    if(data.obj[i].auditerName){
                                        return data.obj[i].auditerName
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//审批人
                                "<td>"+
                                "<a  href='javascript:;' id='xg' tid='"+data.obj[i].newsId+"' style='color:#1772C0'>"+"<fmt:message code='depatement.th.modify' />"+"</a>&nbsp"+<%--修改--%>
                                "<a href='javascript:;' id='yesApproval' newsId='"+data.obj[i].newsId+"' onclick='isApproval($(this))' style='color:#1772C0' auditerStatus='1'><fmt:message code="meet.th.Approval" /></a>&nbsp"+<%--批准--%>
                                "<a href='javascript:;' id='noApproval' newsId='"+data.obj[i].newsId+"' onclick='isApproval($(this))' style='color:#1772C0' auditerStatus='2'><fmt:message code="meet.th.NotApprove" /></a>&nbsp"+<%--不批准--%>
                                "</td></tr>"//操作
                        }
                        var last_str='';
                        $("#j_tb").html(news+last_str);
                        if(cb){
                            cb(data.totleNum);
                        }
                        if(data.totleNum==0){
                            layer.msg('<fmt:message code="global.lang.nodata" />', {icon: 6});<%--没有更多数据!--%>
                        }

                    }
                })
            };
            function initPageList1(cb){
                $.ajax({
                    type: "get",
                    url: "/news/getNewStatus",
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

                            var typeName = ""
                            if(data.obj[i].typeName==-1){
                                typeName ="";
                            }else{
                                typeName =data.obj[i].typeName;
                            };
                            var comment="";
                            if(data.obj[i].anonymityYn==2){
                                comment=""
                            }else{
                                comment='<fmt:message code="new.th.ManageComments" />'<%--管理评论--%>
                            };
                            news += "<tr class='trs' id='news_tr' rid='"+data.obj[i].newsId+"'><input class='input_hide' type='hidden' newsID='"+data.obj[i].newsId+"'>"+
                                // "<td><input class='checkChild' type='checkbox' conid="+data.obj[i].newsId+" name='check' value=''></td>"+//选择
                                "<td class='name' nid='"+data.obj[i].newsId+"'>"+data.obj[i].providerName+"</td>"+//发布人
                                "<td class='type' nid='"+data.obj[i].newsId+"'>"+typeName+"</td>"+//类型
                                "<td class='cli' name='"+data.obj[i].depName+"'><div id='break"+data.obj[i].newsId+"' class='break_td  publishtip' style='overflow: hidden;\n" +
                                "    text-overflow: ellipsis;\n" +
                                "    width: 100%;\n" +
                                "    white-space: nowrap;'  toTypeName="+toTypeName+">"+alltype+"</div></td>"+//发布范围
                                "<td time='"+data.obj[i].subject+"'><a  style='color:#59b7fb'  href='#' newsId="+data.obj[i].newsId+" class='windowOpen'><div id='subject"+data.obj[i].newsId+"' class='title' title='"+data.obj[i].subject+"'>";
                            if(data.obj[i].top == 1){
                                news +='<img src="/img/news/top.png" alt="" style="margin-right: 5px;vertical-align: middle;">'
                            }
                            news +=data.obj[i].subject+"</div></a></td>"+//标题
                                "<td  class='tim'>"+timestampToTime1(data.obj[i].newsTime)+"</td>"+//发布时间
                                // "<td class='data'>"+data.obj[i].clickCount+"</td>"+//点击数
                                //"<td class='num'>"+data.obj[i].newsId+"</td>"+//评论（条）
                                "<td class='state'>"+function(){
                                var str = '';
                                        if (data.obj[i].flowRun) {
                                            var flowRun = data.obj[i].flowRun;
                                            str = '<div style="color:#59b7fb;overflow: hidden;text-overflow: ellipsis;width: 100%;white-space: nowrap;"><a class="open_news_flow" style="color:#59b7fb" href="javascript:;" runid="'+flowRun.runId+'" flowid="'+flowRun.flowId+'">'+flowRun.runName+'</a></div>';
                                        }
                                        return str;
                                    }()+"</td>"+//状态
                                "<td class='state' id=publish"+data.obj[i].newsId+">"+function () {
                                    if(data.obj[i].publish==0){
                                        return '<fmt:message code="notice.th.unposted" />'
                                    }else if(data.obj[i].publish==1){
                                        return '<fmt:message code="notice.th.posted" />'
                                    }else if(data.obj[i].publish==2){
                                        return '<fmt:message code="notice.th.hasEnd" />'
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//发布状态
                                "<td class='state' >"+function () {
                                    if(data.obj[i].auditerStatus==0){
                                        return '<fmt:message code="meet.th.PendingApproval" />'
                                    }else if(data.obj[i].auditerStatus==1){
                                        return '<fmt:message code="meet.th.Ratified" />'
                                    }else if(data.obj[i].auditerStatus==2){
                                        return '<fmt:message code="meet.th.NotApprove" />'
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//批准状态
                                "<td class='state'>"+function () {
                                    if(data.obj[i].auditerName){
                                        return data.obj[i].auditerName
                                    }else{
                                        return ''
                                    }
                                }()+"</td>"+//审批人
                              "<td>"+
                               /* "<a  href='javascript:;' id='xg' tid='"+data.obj[i].newsId+"' style='color:#1772C0'>"+"<fmt:message code='depatement.th.modify' />"+"</a>&nbsp"+<%--修改--%>
                                "<a href='javascript:;' id='yesApproval' newsId='"+data.obj[i].newsId+"' onclick='isApproval($(this))' style='color:#1772C0' auditerStatus='1'>批准</a>&nbsp"+<%--批准--%>
                                "<a href='javascript:;' id='noApproval' newsId='"+data.obj[i].newsId+"' onclick='isApproval($(this))' style='color:#1772C0' auditerStatus='2'>不批准</a>&nbsp"+<%--不批准--%>*/
                              //判断是否显示取消置顶按钮
                               function () {
                                   if(data.obj[i].top==1){
                                       return  "<a href='javascript:;' class='cancelTop' newsId='"+data.obj[i].newsId+"' style='color:#1772C0' ><fmt:message code="news.th.quittop" /></a>"
                                   }else{
                                       return ''
                                   }
                               }()+
                                "</td>" +
                                "</tr>"//操作
                        }
                        var last_str='';
                        $("#j_tb1").html(news+last_str);
                        if(cb){
                            cb(data.totleNum);
                        }
                        if(data.totleNum==0){
                            layer.msg('<fmt:message code="global.lang.nodata" />', {icon: 6});<%--没有更多数据!--%>
                        }

                    }
                })
            };
            //取消置顶
            $(document).on('click','.cancelTop',function () {
                // console.log($(this).attr('newsId'))
                var newsIds=[]
                newsIds.push($(this).attr('newsId'))
                layer.confirm('<fmt:message code="new.th.areYouSureToCancelTheTopPlacement" />？',{icon:3,title:'<fmt:message code="common.th.prompt" />'},function (index) {
                    $.get('/news/updateByIds',{newsIds:newsIds,top:0},function (res) {
                        if(res.flag){
                            layer.msg('<fmt:message code="notice.th.CancelTopSuccess" />！', { icon:1});
                            layer.close(index)
                            initPageList1()
                        }
                    })
                })
            })
            /*发布范围的弹窗*/
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

            });
            /*发布范围的弹窗*/
            $('#tr_td1').on('mouseenter','.publishtip',function () {
                var that = $(this);
                var str=that.attr('toTypeName').replace(/-/g,'<br>')
                layer.tips(str,that, {
                    tips: [1, '#3595CC'],
                    time: 10000
                });
            });
            $('#tr_td1').on('mouseleave','.publishtip',function () {
                layer.closeAll();

            });

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
            function initPagination1(totalData,pageSize){
                $('.M-box4').pagination({
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
                        initPageList1(function(pageCount){
                            initPagination1(pageCount,data.pageSize);
                        });
                    }
                });
            }
            /* 新闻详情页 */
            $("#j_tb").on('click','.windowOpen',function(){
                var nid=$(this).attr('newsId');
                //$.popWindow('detail?newsId='+nid,'<fmt:message code="news.th.newsDetail"/>','0','100','1200px','700px');
                window.open('detail?newsId='+nid+'&changId=1','<fmt:message code="news.th.newsDetail"/>');
            });
            /* 新闻管理修改页面 */
            $("#j_tb").on('click', '#xg', function(){
                //修改新闻页面
                var id=$(this).attr('tid');
                if(id==$(this).parent().parent().attr('rid')){
                    //新闻详情获得内容：
                    $.ajax({
                        url: "/news/getOneById",
                        type: 'get',
                        dataType: "JSON",
                        data: {
                            "newsId": id,
                            "changId": "0"
                        },
                        success: function (data) {
                            $("#step3_type").find("option[value=" + data.object.typeId + "]").attr("selected", true);//类型
                            $("#step3_ip2").val(data.object.deprange); //部门
                            $("#step3_ip2").attr("deptid", data.object.toId);
                            $("#privId_").val(data.object.rolerange); //角色
                            $("#privId_").attr("userpriv", data.object.privId);
                            $("#userId_").val(data.object.userrange); //人员
                            $("#userId_").attr("user_id", data.object.userId);
//                                $("#step3_ip4").val();//发布范围
                            $("#step3_ip1").val(data.object.subject);//标题
                            $("#anonymityYn_").find("option[value=" + data.object.anonymityYn + "]").attr("selected", true);//评论
                            $("#step3_ip3").val(data.object.newsDateTime);//发布时间
                            $("#hidden_id").val(data.object.newsId);
                            $("#step3_ip4").val(data.object.summary);
                            newKindEditorObj.html(data.object.content);
                            $("#step3_type").find("option[value=" + data.typeId + "]").attr("selected", true);//新闻类型
                            $("#ip5").val(data.object.keyword); //内容关键字
                            if (data.object.top == 1) {
                                $('#top_').prop('checked', true);//是否置顶
                            }
                            ;
                            $("#topDays").val(data.object.topDays);
//                                            附件下载
                            var str1 = "";
                            var arr = new Array();
                            arr = data.object.attachment;
                            $('#newVote').empty();
                            $("#author").val(data.object.author); // 作者
	                        $("#photographer").val(data.object.photographer); // 摄影
                            if (data.attachmentName != '') {
                                for (var i = 0; i < (arr.length); i++) {
                                    str1 += '<div class="font_ dech" deUrl="' + arr[i].attUrl + '" style="display:block;"><a style="color: #000;" href="/download?'+encodeURI(arr[i].attUrl)+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>' + arr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                            '<input type="hidden" class="inHidden" NAME="' + arr[i].attachName + '*" value="' + arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',"></div>';
                                }
                                $('#query_uploadArr_').html(str1);
                            }
            
                        },
                            error:function(){
                                alert("<fmt:message code="global.th.error" />");
                                return;
                            }
                        });
                    $('.step1').hide();
                    $('.center').hide();
                    $('.step2').hide();
                    $('.step3').show();
                }
            });
            /* 新闻详情页 */
            $("#j_tb1").on('click','.windowOpen',function(){
                var nid=$(this).attr('newsId');
                //$.popWindow('detail?newsId='+nid,'<fmt:message code="news.th.newsDetail"/>','0','100','1200px','700px');
                window.open('detail?newsId='+nid+'&changId=1','<fmt:message code="news.th.newsDetail"/>');
            });
            /* 新闻管理修改页面 */
            $("#j_tb1").on('click', '#xg', function(){
                //修改新闻页面
                var id=$(this).attr('tid');
                if(id==$(this).parent().parent().attr('rid')){
                    //新闻详情获得内容：
                    $.ajax({
                        url: "/news/getOneById",
                        type: 'get',
                        dataType: "JSON",
                        data: {
                            "newsId": id,
                            "changId": "0"
                        },
                        success: function (data) {
                            $("#step3_type").find("option[value=" + data.object.typeId + "]").attr("selected", true);//类型
                            $("#step3_ip2").val(data.object.deprange); //部门
                            $("#step3_ip2").attr("deptid", data.object.toId);
                            $("#privId_").val(data.object.rolerange); //角色
                            $("#privId_").attr("userpriv", data.object.privId);
                            $("#userId_").val(data.object.userrange); //人员
                            $("#userId_").attr("user_id", data.object.userId);
//                                $("#step3_ip4").val();//发布范围
                            $("#step3_ip1").val(data.object.subject);//标题
                            $("#anonymityYn_").find("option[value=" + data.object.anonymityYn + "]").attr("selected", true);//评论
                            $("#step3_ip3").val(data.object.newsDateTime);//发布时间
                            $("#hidden_id").val(data.object.newsId);
                            $("#step3_ip4").val(data.object.summary);
                            newKindEditorObj.html(data.object.content);
                            $("#step3_type").find("option[value=" + data.typeId + "]").attr("selected", true);//新闻类型
                            $("#ip5").val(data.object.keyword); //内容关键字
                            if (data.object.top == 1) {
                                $('#top_').prop('checked', true);//是否置顶
                            }
                            ;
                            $("#topDays").val(data.object.topDays);
//                                            附件下载
                            var str1 = "";
                            var arr = new Array();
                            arr = data.object.attachment;
                            $('#newVote').empty();
                            $("#author").val(data.object.author); // 作者
	                        $("#photographer").val(data.object.photographer); // 摄影
                            if (data.attachmentName != '') {
                                for (var i = 0; i < (arr.length); i++) {
                                    str1 += '<div class="font_ dech" deUrl="' + arr[i].attUrl + '" style="display:block;"><a style="color: #000;" href="/download?'+encodeURI(arr[i].attUrl)+'"><img style="width:16px;" src="../img/file/cabinet@.png"/>' + arr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                            '<input type="hidden" class="inHidden" NAME="' + arr[i].attachName + '*" value="' + arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',"></div>';
                                }
                                $('#query_uploadArr_').html(str1);
                            }
            
                        },
                        error: function () {
                            alert("<fmt:message code="global.th.error" />");
                            return;
                        }
                    });
                    $('.step1').hide();
                    $('.center').hide();
                    $('.step2').hide();
                    $('.step3').show();
                }
            });
            //编辑新闻页面   修改新闻页面保存时调用的方法***************
            $(".submit_ok").on('click',function(){
                var dataTypeId=$(this).attr('data-type');
                var remindVal=0;
                if($('.remindCheck1').is(":checked")){
                    remindVal=1;
                }
                var aId_='';
                var uId_='';
                for(var i=0;i<$('#query_uploadArr_  .inHidden').length;i++){
                    aId_ += $('#query_uploadArr_ .inHidden').eq(i).val();
                    uId_ += $('#query_uploadArr_ .inHidden').eq(i).attr('name');
                };
                console.log(uId_);
                var data = {
                    "tuisong":dataTypeId,//推送标识
                    "newsId":$("#hidden_id").val(),
                    "subject": $("#step3_ip1").val(),    //标题
                    "newTime": $("#step3_ip3").val(),      //发布时间
                    "keyword":$("#ip5").val(),  //内容关键词
                    "topDays": $("#topDays").val(),// 限制新闻置顶时间
                    "content":  newKindEditorObj.html(),//  新闻内容
                    "toId": $("#step3_ip2").attr("deptid"),//发布部门
                    "keyword":$('#ip5').val(),//关键字
                    "summary":$('#step3_ip4').val(),//内容简介
                    "typeId": $('#step3_type option:checked').attr('value'),//新闻类型
                    "anonymityYn":$("#anonymityYn_ option:checked").attr('value'),//实名评论
                    "format":0,//新闻格式(0-普通格式,1-MHT格式,2-超链接)
                    "publish":0,  // 发布标识(0-未发布,1-已发布,2-已终止)
                    "top":$("#top_").eq(0).is(':checked')==false?0:1,//是否置顶(0-否,1-是)
                    "clickCount":'0',//点击数
                    "lastEditor":'1',//最后编辑人
                    "lastTime":new Date().Format('yyyy-MM-dd hh:mm:ss'),//最后编辑时间
                    "subjectColor":'1',//新闻标题颜色
                    "compressContent":'1',//压缩后的新闻内容
//                    "summary":$("#ip4").val(),//新闻内容简介  */
                    "attachmentId":aId_,//附件ID串
                    "attachmentName":uId_,//附件名称串
                    "privId":$("#privId_").attr("userpriv"),//发布角色 -
                    "userId":$("#userId_").attr("user_id"),//发布用户 -
                    "readers": '',//发布角色
                    "remind":remindVal,//提醒标识
                    "author": $('#author').val() || '', // 作者
                    "photographer": $('#photographer').val() || '' // 摄影
                };
                if($(this).attr("type_") == "publish"){
                    data.publish = '1';
                };
                if($('#step3_ip1').val()==''){
                    /* alert('请填写标题');*/
                    layer.msg('<fmt:message code="notify.th.PleaseFillTheTitle" />', { icon:6});
                    return false;
                }else if($('#step3_ip2').val()==''&&$('#privId_').val()==''&&$('#userId_').val()==''){
                    layer.msg('<fmt:message code="new.th.DepartmentRolePersonAtLeastFillInOne" />', { icon:6});
                    return false;
                }else if(newKindEditorObj.html()==''){
                    layer.msg('<fmt:message code="new.th.PleaseFillInTheNewsContent" />', { icon:6});
                    return false;
                }else{
                    $.ajax({
                        url:"/news/updateNews",
                        type:'post',
                        dataType:"JSON",
                        data : data,
                        success:function(data){
                            $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />',icon:1});


                            /*  initPageList(); */
                            setTimeout(function(){
                                $('.step1').show();
                                $('.center').hide();
                                $('.step2').hide();
                                $('.step3').hide();
                                location.reload();
                            },1000)
                        },
                        error:function(e){
                            console.log(e);
                        }
                    });
                };


            });
            /* 返回按钮 */
            $("#goBack").on('click',function(){
                $('.step1').show();
                $('.center').hide();
                $('.step2').hide();
                $('.step3').hide();
            });
            /* 选人控件修改页面 */
            $("#adduser_").on("click",function(){
                user_id = "userId_";
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("../common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser");
                    }
                })
            });
            //选部门
            $('#dept_add_').on('click',function(){
                dept_id='step3_ip2';
                $.popWindow("../common/selectDept?allDept=1");
            });
            //选角色
            $('#priv_add_').on('click',function(){
                priv_id='privId_';
                $.popWindow("../common/selectPriv");
            });
            
            $(document).on('click', '.open_news_flow', function(){
                var runId = $(this).attr('runid');
                var flowId = $(this).attr('flowid');
                window.open('/workflow/work/workformPreView?flowId='+flowId+'&flowStep=&runId='+runId+'&prcsId=');
            });

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

            //获取当前时间 修改时页面
            queryTime();
            $("#step3_ip3").val(now);
            $("#step_release3").on('click',function(){
                queryTime();
                $("#step3_ip3").val(now);
            });

            //获取当前时间 新建时页面
//                        $("#query_newTime").val(now);
            $("#step_release2").on('click',function(){
                queryTime();
                $("#query_newTime").val(now);
            });
            //时间控件调用
            $('#btn_query').on('click',function (){
                data.subject = $('#subject').val();
                data.beginTime = $('#beginTime').val();
                data.endTime = $('#endTime').val();
                data.typeId =  $('#select').val()==0?'':$('#select').val();
                data.content = $('#content').val();
                initPageList();
                $('.step1').show();
                $('.center').hide();
            });
            //选部门
            $('#dept_add').on('click',function(){
                dept_id='query_toId';
                $.popWindow("../common/selectDept?allDept=1");
            });
            //选角色
            $('#priv_add').on('click',function(){
                priv_id='query_privId';
                $.popWindow("../common/selectPriv");
            });
        });
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
        /* 新闻人员控件显示和隐藏 */
        function showAndHidden(persion,role,man){
            if($("#"+persion).html() =='<fmt:message code="notice.th.PostedByPersonnelOrRoles" />'||$("#"+persion).html() =='<fmt:message code="notice.th.somebody" />'){<%--按人员或角色发布--%>

                if(pareValue == 0){
                    $("#"+persion).html('<fmt:message code="notice.th.Hidden" />');<%--隐藏按人员或角色发布--%>
                    $("#"+role).show();
                }else{
                    $("#"+persion).html('<fmt:message code="new.th.hideTheReleaseByPerson" />');<%--隐藏按人员或角色发布--%>
                    $("#"+role).hide();
                }

                $("#"+man).show();
            }else{
                if(pareValue == 0){
                    $("#"+persion).html('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />')

                }else{
                    $("#"+persion).html('<fmt:message code="notice.th.somebody" />')

                }
                <%--$("#"+persion).html('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />');&lt;%&ndash;按人员或角色发布&ndash;%&gt;--%>
                $("#"+role).hide();
                $("#"+man).hide();
            }
        }
        laydate({
            elem: '#step3_ip3', //目标元素。
            format: 'YYYY-MM-DD hh:mm:ss', //日期格式
            istime: true, //显示时、分、秒
        });

        //删除附件
        function deleteChatment(data,element){

            layer.confirm('<fmt:message code="workflow.th.que" />？', {<%--确定要删除吗--%>
                btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮  <%--确定 取消--%>
                title:'<fmt:message code="notice.th.DeleteAttachment" />'  <%--删除附件--%>
            }, function(){
                //确定删除，调接口
                $.ajax({
                    type:'get',
                    url:'../delete',
                    dataType:'json',
                    data:data,
                    success:function(res){

                        if(res.flag == true){
                            layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});<%--删除成功--%>
                            element.remove();
                        }else{
                            layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});<%--删除失败--%>
                        }
                    }
                });

            }, function(){
                layer.closeAll();
            });
        }

        //时间戳转变日期格式 年-月-日 时-分-秒
        function timestampToTime1(timestamp) {
            var date = new Date(timestamp );//时间戳为10位需*1000，时间戳为13位的话不需乘1000
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
            var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
            var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
            var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
            return Y+M+D+h+m+s;
        }
        //批准和不批准
        function isApproval(me){
            layer.confirm('<fmt:message code="global.lang.ok" />'+me.html()+'<fmt:message code="new.th.youWantIt" />？', function(index){
                var data={
                        auditerStatus:me.attr('auditerStatus'),
                        newsId:me.attr('newsId')
                    }
                    if(me.html()=='<fmt:message code="meet.th.Approval" />'){
                        data.publish=1
                    }else{
                        data.publish=0
                    }
                // layer.close(index);
                $.ajax({
                    type:'get',
                    url:'/news/upNewStatus',
                    dataType:'json',
                    data:data,
                    success:function (res) {
                        window.location.reload()
                    }
                })
            });

        }
        
        var kindEditorOption = {
                themeType: 'simple', // 定义编辑器为简洁模式
                filterMode: false, // 开启过滤
                allowFileManager: true, // 开启文件空间
                uploadJson: '/ueditor/upload?module=ueditor', // 上传接口
                filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
                afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
                afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
                afterUploadErrorMsg: 'msg' // 定义上传失败后提示信息的参数名（默认为 message）
            }
            // 新建新闻编辑器
            var newKindEditorObj = null;
            KindEditor.ready(function (K) {
                newKindEditorObj = K.create('#newKindEditor', kindEditorOption);
            });
        
</script>

</body>
</html>


