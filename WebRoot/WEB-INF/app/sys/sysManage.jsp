<!--<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>-->
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>系统资源管理</title>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <%--<link rel="stylesheet" type="text/css" href="../css/base.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/sys/sysManage.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<style type="text/css">

    body{
        font-family: 微软雅黑 !important;
    }
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .M-box3{
        margin-top:15px;
        float: right;
    }
    .M-box3 .next,.M-box3 .prev{
        /*width: 50px !important;*/
    }
    table{
        vertical-align: middle;
    }
    .M-box3 .active {
        margin: 0px 3px;
        width: 29px;
        height: 29px;
        line-height: 29px;
        background: #2b7fe0;
        font-size: 12px;
        border: 1px solid #2b7fe0;
    }
    .jump-ipt {
        margin: 0 3px;
        width: 29px;
        height: 29px;
        line-height: 29px;
        font-size: 12px;
        float: left;
    }
    #wrap>li:hover{
        color:#0270c1 !important;
        background-color: #def0ff !important;
        border-bottom:1px solid #00a5e4 !important;
    }
    .M-box3 a {
        margin: 0 3px;
        width: 29px;
        height: 29px;
        line-height: 29px;
        font-size: 12px;
        text-decoration: none;
    }
    .theme{
        color: #1687cb;
        cursor: pointer;
    }
    #top_left{
        font-size: 17pt;
        height: 45px;
        line-height: 45px;
        width: 100%;
        color: #000;
        padding-left: 20px;
        border-bottom: #ccc 1px solid;
    }
    th{
        color: #2F5C8F;
        font-weight: bold;
        padding: 8px;
        font-size: 13pt;
    }
    #tab1 tr:nth-child(even){
        background-color: #F6F7F9;
    }
    #tab1 tr:nth-child(odd){
        background-color: #ffffff;
    }
    #tab2 tr:nth-child(even){
        background-color: #F6F7F9;
    }
    #tab2 tr:nth-child(odd){
        background-color: #ffffff;
    }
    #tab tr:nth-child(even){
        background-color: #F6F7F9;
    }
    #tab tr:nth-child(odd){
        background-color: #ffffff;
    }
    #tabp tr:nth-child(even){
        background-color: #F6F7F9;
    }
    #tabp tr:nth-child(odd){
        background-color: #ffffff;
    }
    #tabj tr:nth-child(even){
        background-color: #F6F7F9;
    }
    #tabj tr:nth-child(odd){
        background-color: #ffffff;
    }
    #tableChaxun tr{
        border: #ccc 1px solid;
    }
    #tableChaxun tr td{
        border: none;
    }
    #tableChaxun tr:nth-child(odd){
        background-color: #F6F7F9;
    }
    #tableChaxun tr:nth-child(even){
        background-color: #ffffff;
    }
    #btn{
        background: #00a0e9;
        margin-left: 10px;
        padding: 5px 1px;
        border-radius: 5px;
        color: #fff;
        cursor: pointer;
        width: 60px;
    }

    #first table td,#second table td,#third table td,#fourth table td,#fifth table td{
        padding-left: 10px;
    }
    .st{
        background-image: url('../../img/sys/icon_rightarrow_03.png') !important;
        background-position: 90% center !important;
        background-repeat:  no-repeat !important;
    }
    .st>img{
        margin-right:30px;
        width:19px;
        margin-bottom:-3px;
    }
    a{
        text-decoration: none !important;
    }
</style>
<body id="body" style="height: 100%; overflow: hidden;">
<div id="top_left" style="">
    <img src="/img/commonTheme/theme6/icon_menuSettings.png" alt="" style="vertical-align: middle;">&nbsp;&nbsp;<fmt:message code="main.systemresource" />
</div>
<div id="main">
    <div id="left" style="float: left;">
        <ul id="wrap">
            <li class="st" id="st" title="硬盘空间" style=" background-color: #def0ff ;font-size: 12px" >
                <img src="/img/commonTheme/theme6/xthhkxx.png" alt="硬盘空间"  ><fmt:message code="interfaceSetting.th.diskSpace" /></li>
            <li class="st" id="st1" title="主要模块数据量" style="font-size: 12px">
                <img src="/img/commonTheme/theme6/icon_addMainMenuCate.png" alt="主要模块数据量"><fmt:message code="interfaceSetting.th.mainModuleDataAmount" /></li>
            <li class="st" id="st2" title="邮件监控" style="font-size: 10px">
                <img src="/img/address/email.png" alt="邮件监控" ><fmt:message code="interfaceSetting.th.mailMonitoring" /></li>
            <li class="st" id ="st3" title="网络硬盘空间" style="font-size: 12px">
                <img src="/img/main_img/theme6/managementPortal/manageportal_icon_ods.png" alt="网络硬盘空间"><fmt:message code="interfaceSetting.th.networkDiskSpace" /></li>
            <li class="st" id ="st4" title="附件空间" style="font-size: 12px">
                <img src="/img/commonTheme/theme6/zcxx.png" alt="附件空间"><fmt:message code="interfaceSetting.th.attachmentSpace" /></li>
        </ul>
    </div>

    <div id="right" style="float: right; overflow: auto;">
        <%--磁盘空间--%>
        <div id="first" style="overflow-y: hidden;">
            <table   cellspacing="0" cellpadding="2px" id="tab" style="border-collapse: collapse;">
                <tr>
                    <td style="text-align: left;" colspan="2"><img style="margin-right:5px ;  margin-bottom: -4px;  " src="/img/commonTheme/theme6/xthhkxx.png" alt="">
                        <b style="font-size: 15pt;color:#494949; font-weight: bold;"><fmt:message code="interfaceSetting.th.oapartitionDiskSpaceUsage" /></b> </td>
                </tr>
                <tr>
                    <td style=" text-align: left; color: #000000; width: 500px"><b style="font-weight: bold; width:200px;"><fmt:message code="interfaceSetting.th.usedSpace" />：</b></td>
                    <td style=" text-align:left; "><span id="used"></span>  <span id="usedFuzzy" style="margin-left: 10px; font-weight: bold" ></span> </td>
                </tr>
                <tr>
                    <td style="text-align: left;  color: #000000;"><b style="font-weight: bold"><fmt:message code="interfaceSetting.th.availableSpace" />:</b></td>
                    <td style="text-align:left;"><span id="usable"></span> <span id="usableFuzzy" style="margin-left: 10px; font-weight: bold"></span></td>
                </tr>
                <tr >
                    <td style=" text-align: left;  color: #000000; "><b style="font-weight: bold"><fmt:message code="interfaceSetting.th.capacity" />：</b></td>
                    <td style=" text-align:left; "><span id="dosage"></span>  <span id="dosageFuzzy" style="margin-left: 10px; font-weight: bold"></span></td>
                </tr>
            </table>

        </div>
            <%--主要模块数据量--%>
            <div id="second" style="overflow-x: hidden">

                <span class="h2"><img style="margin-bottom: -2px;" src="/img/commonTheme/theme6/icon_addMainMenuCate.png" alt="">&nbsp;&nbsp;<fmt:message code="interfaceSetting.th.mainModuleDataAmount" /></span>
                <table  border="0" cellspacing="0" cellpadding="0"  id="tab1" style="border: 1px solid #ccc;"  >
                    <tr>
                        <th><fmt:message code="interfaceSetting.th.dataTable" /></th>
                        <th><fmt:message code="interfaceSetting.th.recordCount" /></th>
                        <th><fmt:message code="interfaceSetting.th.tableFileSize" /></th>
                    </tr>
                    <tbody class="list">
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">邮件</td>--%>
                    <%--<td id="ema"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">邮件内容</td>--%>
                    <%--<td id="emabody"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">提醒</td>--%>
                    <%--<td id="remind"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">提醒内容</td>--%>
                    <%--<td id="remind_content"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">工作流</td>--%>
                    <%--<td id="work"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">工作流数据</td>--%>
                    <%--<td id="work_flow"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">文件柜文件夹</td>--%>
                    <%--<td id="paper_file"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">文件柜文件</td>--%>
                    <%--<td id="file"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">公告通知</td>--%>
                    <%--<td id="notice"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                    <%--<td style="color: #000000; ">工作日志</td>--%>
                    <%--<td id="daily_log"></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    </tbody>
                </table>
            </div>
            <%--邮件监控查询--%>
            <div id="third" style=" overflow-x: hidden; ">
                <span class="h2"><img style="    margin-bottom: -5px;width: 26px;" src="/img/address/email.png" alt="">&nbsp;&nbsp;<fmt:message code="mailMonitoring.queryTitle" /></span>
                <table border="1" id="tab2">
                    <tr style="background-color: dodgerblue; color: white;">
                        <td colspan="2" style="font-size: 13pt;padding-left: 10px"><fmt:message code="mailMonitoring.inputQueryConditions" /></td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.mailTable" />：</td>
                        <td class="radio" id="emailTable"><input  style=" vertical-align:middle; width: 14px; height: 14px;" type="radio" name="radio" checked value="1"><fmt:message code="mailMonitoring.currentMailTable" /></td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.sender" />：</td>
                        <td class="radio">
                            <textarea style="margin-top: 5px;" name="" readonly="readonly"  id="addresser" rows="3" cols="30"></textarea>
                            <div class="clickc"> <b style="color:red;margin-left:5px;">*</b> <a class="add" href="javascript:;" id="add1"><fmt:message code="mailMonitoring.add" /></a>
                                <a class="clear" href="javascript:;" id="clear1"><fmt:message code="mailMonitoring.clear" /></a></div>

                        </td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.receiver" />：</td>
                        <td class="radio">
                            <textarea style="margin-top: 5px;" name="" readonly="readonly" id="email" rows="3" cols="30"></textarea>
                            <div class="clickc">
                                <b style="color: red ;margin-left:5px;">*</b>
                                <a class="add"  href="javascript:;" id="add2"><fmt:message code="mailMonitoring.add" /></a>
                                <a class="clear"  href="javascript:;" id="clear2"><fmt:message code="mailMonitoring.clear" /></a>
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.subject" />：</td>
                        <td class="radio" id="theme">
                            <input type="text" placeholder="<fmt:message code="mailMonitoring.enterSubject" />" class="TXT" id="TXT" />
                        </td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.attachmentName" />:</td>
                        <td class="radio" ><input id="name"  placeholder="<fmt:message code="mailMonitoring.enterAttachmentName" />" type="text" class="TXT" /></td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.body" />：</td>
                        <td class="radio"><input id="content" placeholder="<fmt:message code="mailMonitoring.editBody" />" type="text" class="TXT" /></td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.startTime" />：</td>
                        <td class="radio"><input id="startTime"  placeholder="<fmt:message code="mailMonitoring.selectStartTime" />" onclick="laydate({istime: true, format:'YYYY-MM-DD hh:mm:ss'})"  type="text" class="txt" /></td>
                    </tr>
                    <tr>
                        <td  style="padding-left: 10px"><fmt:message code="mailMonitoring.endTime" />：</td>
                        <td class="radio"><input id="endTime"onclick="laydate({istime: true, format:'YYYY-MM-DD hh:mm:ss'})" placeholder="<fmt:message code="mailMonitoring.selectEndTime" />"  type="text" id="txt1" class="txt" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center"><input type="button" id="btn" value="<fmt:message code="mailMonitoring.query" />" style="font-family: 微软雅黑;outline: none;" /></td>
                    </tr>
                </table>

            </div>
            <%--查询结果--%>
            <div id="chaxun" style="margin: 0 auto;width: 100%">
                <span class="h2"><img style="    margin-bottom: -5px;width: 26px;" src="/img/address/email.png" alt="">&nbsp;&nbsp;<fmt:message code="mailMonitoring.queryResult" /></span>
                <table id="tableChaxun" style="width: 96%;margin: 20px auto;" >
                    <thead id="tHead">
                    <tr class="odd" style="height: 40px;">
                        <th><fmt:message code="mailMonitoring.select" /></th>
                        <th><fmt:message code="mailMonitoring.status" /></th>
                        <th><fmt:message code="mailMonitoring.sender" /></th>
                        <th><fmt:message code="mailMonitoring.receiver" /></th>
                        <th><fmt:message code="mailMonitoring.subject" /></th>
                        <th style="width: 400px;"><fmt:message code="mailMonitoring.attachment" /></th>
                        <th><fmt:message code="mailMonitoring.sendTime" /></th>
                    </tr>
                    </thead>
                    <tbody id="tBody">
                    <%--<tr>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <%--</tr>--%>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="7" style="text-align: left;">
                            <label style="margin-left:12px;">
                                <input id="all_check" style="vertical-align: middle;margin-left: 20px;" type="checkbox" ><fmt:message code="mailMonitoring.selectAll" /></label>
                            <input id="btn1"  type="button"
                                   style="margin-left: 15px; background: url(/img/btn_deleteannounce.png); background-position:100% 100%;background-repeat:no-repeat; cursor: pointer; width: 109px; height: 24px; line-height: 24px; border: none;" class="checkedAll" value="<fmt:message code="mailMonitoring.deleteMail" />"></td>
                    </tr>
                    <tr>
                        <td colspan="7" style="text-align: center"><input style="background: url(../img/email/return.png) no-repeat; cursor: pointer; width: 85px; height: 30px; border: none;font-family: 微软雅黑;outline: none;" id="return" type="button" value="<fmt:message code="mailMonitoring.back" />"></td>
                    </tr>
                    </tfoot>
                </table>
                <div class="right"  style="float: right;margin-right: 2%;">
                    <!-- 分页按钮-->
                    <div class="M-box3" id="dbgz_pagesd"></div>
                </div>
            </div>
            <%--网络硬盘空间--%>
            <div id="fourth" style="overflow-y:hidden; overflow-x: hidden;   ">
                <table  border="0" cellspacing="0" cellpadding="2px"   id="tabp" style=" border-collapse: collapse">
                    <tr>
                        <td style="text-align: left; height: 55px" colspan="2"><img
                                style="margin-right:5px ; width:26px; margin-bottom: -3px;" src="/img/main_img/theme6/managementPortal/manageportal_icon_ods.png" alt="">
                            <b style="font-size: 15pt;color:#494949; font-weight: bold;"><fmt:message code="interfaceSetting.th.networkDiskSpace" /></b> </td>
                    </tr>
                    <tr>
                        <td style=" text-align: left; color: #000000;  width: 500px"><b style="font-weight: bold"><fmt:message code="interfaceSetting.th.usedSpace" />:</b></td>
                        <td style=" text-align:left; "><span id="usedp"></span>
                            <span id="usedFuzzyp" style="font-weight: bolder;margin-left:10px;"></span> </td>
                    </tr>
                </table>

            </div>
            <%--附件监控--%>
            <div id="fifth" style="overflow-x: hidden;overflow-y: hidden">

                <table  border="0" cellspacing="0" cellpadding="2px"   id="tabj" style=" border-collapse: collapse">
                    <tr>
                        <td style="text-align: left; height: 55px;" colspan="2"><img style="margin-right:5px; margin-bottom: -5px;" src="/img/commonTheme/theme6/zcxx.png" alt="">
                            <b style="font-size: 15pt;color:#494949; font-weight: bold;"><fmt:message code="interfaceSetting.th.attachmentSpace" /></b> </td>
                    </tr>
                    <tr>
                        <td style=" text-align: left; color: #000000; width: 500px"><b style="font-weight: bold"><fmt:message code="interfaceSetting.th.usedSpace" />:</b></td>
                        <td style=" text-align:left; "><span id="usedj"></span>  <span id="usedFuzzyj" style="font-weight: bolder;margin-left:10px;"></span> </td>
                    </tr>
                </table>

            </div>
    </div>
</div>

</body>
</html>
<script type="text/javascript">
    var user_id='';

    $(function () {
        $('#body').height();
        $('#top_left').height();
        $('#body').width();
        $('#top_left').width();
        $('#top_left').height();
        $('#main').height($('#body').height()-$('#top_left').height());
        $("#left").height($('#body').height()-$('#top_left').height())
        $('#right').width($('#body').width()-270);
        $('#right').height($('#body').height()-$('#top_left').height()-10);
        $('#fourth').height($('#body').height()-$('#top_left').height()-10);
        $('#fifth').height($('#body').height()-$('#top_left').height()-10);

        window.onresize=function(){
            $('#body').height();
            $('#top_left').height();
            $('#body').width();
            $('#top_left').width();
            $('#top_left').height();
            $('#main').height($('#body').height()-$('#top_left').height());
            $("#left").height($('#body').height()-$('#top_left').height())
            $('#right').width($('#body').width()-270);
            $('#right').height($('#body').height()-$('#top_left').height()-10);
            $('#fourth').height($('#body').height()-$('#top_left').height()-10);
        }


        $("#incumbency").click(function(){
            var state=$("#incumbency_on").css("display");
            if(state=="none"){
                $("#incumbency_on").css("display","block");
                $("#change_1").attr("src","arrow_d.png");
            }else{
                $("#incumbency_on").css("display","none");
                $("#change_1").attr("src","ar.png");
            }

        })
        $("#dimission").click(function(){
            var state=$("#dimission_on").css("display");
            if(state=="none"){
                $("#dimission_on").css("display","block");
                $("#change_2").attr("src","arrow_d.png");
            }else{
                $("#dimission_on").css("display","none");
                $("#change_2").attr("src","ar.png");
            }

        })

        $('#add1').click(function () {
            user_id='addresser';
            $.popWindow("../common/selectUser");
        })
        $('#add2').click(function () {
            user_id='email';
            $.popWindow("../common/selectUser");
        })

        $('#clear1').click(function () {
            $('#addresser').val("");
            $('#addresser').attr("userName",'');
            $('#addresser').attr("user_Id",'');
        })

        $('#clear2').click(function () {
            $('#email').val("");
            $('#email').attr("userName",'');
            $('#email').attr("user_Id",'');
        })



//        st点击事件
        $("#st").click(function(){
            $("#first").show();
            $("#second").hide();
            $("#third").hide();
            $("#chaxun").hide();
            $('#fourth').hide();
            $('#fifth').hide();
            $(this).css('background','#def0ff').css('border-bottom','1px solid #00A5E4').css('color','#494949');
            $(this).siblings().css('color','#494949').css('background','white').css('border-bottom','1px solid #ccc');

        });
//        st1点击事件
        $("#st1").click(function(){
            $("#second").show();
            $("#third").hide();
            $("#first").hide();
            $("#chaxun").hide();
            $('#fourth').hide();
            $('#fifth').hide();

            $(this).css('background','#def0ff').css('border-bottom','1px solid #00A5E4').css('color','#494949');
            $(this).siblings().css('color','#494949').css('background','white').css('border-bottom','1px solid #ccc');


        });
//        st2点击事件
        $("#st2").click(function(){
            $("#third").show();
            $("#first").hide();
            $("#second").hide();
            $("#chaxun").hide();
            $('#fourth').hide();
            $('#fifth').hide();
            $(this).css('background','#def0ff').css('border-bottom','1px solid #00A5E4').css('color','#494949');
            $(this).siblings().css('color','#494949').css('background','white').css('border-bottom','1px solid #ccc');

        });
//          st3点击事件
        $("#st3").click(function(){
            $("#third").hide();
            $("#first").hide();
            $("#second").hide();
            $("#chaxun").hide();
            $('#fourth').show();
            $('#fifth').hide();
            $(this).css('background','#def0ff').css('border-bottom','1px solid #00A5E4').css('color','#494949');
            $(this).siblings().css('color','#494949').css('background','white').css('border-bottom','1px solid #ccc');

        });
//          st4点击事件
        $("#st4").click(function(){
            $("#third").hide();
            $("#first").hide();
            $("#second").hide();
            $("#chaxun").hide();
            $('#fourth').hide();
            $('#fifth').show();
            $(this).css('background','#def0ff').css('border-bottom','1px solid #00A5E4').css('color','#494949');
            $(this).siblings().css('color','#494949').css('background','white').css('border-bottom','1px solid #ccc');
//
        });
        var date=new Date();

        $("#txt1").val(getTime());
        function getTime(){
            var year=date.getFullYear();
            var month=date.getMonth()+1;
            var day=date.getDate();
            var hour=date.getHours();
            var minute=date.getMinutes();
            var second=date.getSeconds();
            if (second >= 0 && second <= 9) {
                second = "0" + second;
            }
            if (minute >= 0 && minute <= 9) {
                minute = "0" + minute;
                if (hour >= 0 && hour <= 9) 	{
                }
                hour = "0" + hour;
            }
            if(month>0 && month<10){
                month="0"+month;
            }
            if(day>0 && day<10){
                day="0"+day;
            }
            return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
        }
        $("#btn").click(function () {

            $("#first").hide();
            $("#second").hide();
            $("#third").hide();
            $("#chaxun").show();
            $('#fourth').hide();
            init();
        })

        $("#return").click(function () {
            $("#first").hide();
            $("#second").hide()
            $("#third").show();;
            $("#chaxun").hide();
            $('#fourth').hide();
        })


        //        点击全选
        $('#all_check').click(function () {
            var state=$(this).prop('checked');
            if(state == true){
                $(this).prop('checked',true);
                $('#tBody').find('input[name="checkChild"]').prop('checked',true);
            }else{
                $(this).prop('checked',false);
                $('#tBody').find('input[name="checkChild"]').prop('checked',false);
            }
        })


        $(document).on('click','.theme',function(){
            var dataId=$(this).parents('tr').attr('data-id');
//                window.open('/email/eamilDetailByOne?dataId='+dataId+'&editType=0');
            window.open('/disk/details?id='+dataId+'&editType=0');
        })


//        点击复选框
        $('#tBody').on('click','input[name="checkChild"]',function () {
            var state=$(this).prop('checked');
            if(state == true){
                $(this).prop('checked',true);
            }else {
                $('#all_check').prop('checked',false);
                $(this).prop('checked',false);
            }

            var childCheck=$('#tBody').find('input[name="checkChild"]');
            for(var i=0;i<childCheck.length;i++){
                var stateChild=$(childCheck[i]).prop('checked');
                if(state != stateChild){
                    return
                }
            }
            $('#all_check').prop('checked',state);
        })





        //        点击删除按钮
        $('#btn1').click(function () {
            var bodyId='';
            $('#tBody').find('input[name="checkChild"]:checked').each(function () {
                bodyId += $(this).parents('tr').attr('data-id')+',';
            })
            deleteData(bodyId);
        })
    })


    function deleteData(data) {
        layer.confirm('确定删除该条数据吗？', {
            btn: ['确定','取消'], //按钮
            title:"删除"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/disk/alldelete',
                dataType:'json',
                data:{
                    bodyId:data
                },
                success:function(res){
                    if(res.flag){
                        layer.msg('删除成功！', { icon:6});
                        init()//删除成功后刷新页面
                    }else {
                        layer.msg('删除失败！', { icon:5});
                    }

                }
            })

        }, function(){
            layer.closeAll();
        });
    }




    //   硬盘空间 ajax
    $.ajax({
        type:'get',
        url:'/disk/diskSpace',
        dataType:'json',
        success:function(res){
            //封装判断千位符
            function Th (n){
                n =  parseInt(n).toString();
                var len = n.length;
                if(len<=3){
                    return n;
                }else{
                    return n;
                }
            }
            var space = res.obj;
            var kb1 = Th(space[0]);
            var kb2 = Th(space[1]);
            var kb3 = Th(space[2]);
            $("#used").html("<fmt:message code="sys.byte"/>："+kb1+"b");
            $("#usable").html("<fmt:message code="sys.byte"/>："+kb2+"b");
            $("#dosage").html("<fmt:message code="sys.byte"/>："+kb3+"b");
            $("#usedFuzzy").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[3]+"GB");
            $("#usableFuzzy").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[4]+"GB");
            $("#dosageFuzzy").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[5]+" GB");
        },error:function(error){

        }
    });


    //    邮件监控 ajax
    $.ajax({
        type:'get',
        url:'/disk/email',
        dataType:'json',
        success:function(res){
            var email=res.object;
            var str="";
            for(var i=0;i<email.length;i++){
                str += '<tr>' +
                    '<td >'+email[i].name+'</td>' +
                    '<td >'+email[i].rows+'<fmt:message code="sys.piece"/></td>' +
                    '<td >'+email[i].datalength+'K</td>' +
                    '</tr>'
            }
            $('.list').html(str);
        }
    });

    //    网络硬盘空间
    $.ajax(
        {
            type:'get',
            url:'/disk/showIntDiskSpace',
            dataType:'json',
            success:function(res){
                //封装判断千位符
                function Th (n){
                    n =  parseInt(n).toString();
                    var len = n.length;
                    if(len<=3){
                        return n;
                    }else{
                        return n;
                    }
                }
                var space=res.obj;
                var kb1 = Th(space[0]);
                var kb2 = Th(space[1]);
                var kb3 = Th(space[2]);
                $("#usedp").html("<fmt:message code="sys.byte"/>："+kb1+"b");
                $("#usablep").html("<fmt:message code="sys.byte"/>："+kb2+"b");
                $("#dosagep").html("<fmt:message code="sys.byte"/>："+kb3+"b");
                $("#usedFuzzyp").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[3]+"GB");
                $("#usableFuzzyp").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[4]+"GB");
                $("#dosageFuzzyp").html("&nbsp;&nbsp;&nbsp;&nbsp"+space[5]+" GB");
            },error:function(error){
                alert("网络状况不佳,请检查网络后重试!")
            }
        });
    //    附件空间ajax
    $.ajax(
        {
            type:'get',
            url:'/disk/showAttchmentSize',
            dataType:'json',
            success:function(res){
                //封装判断千位符
                function Th (n){
                    n =  parseInt(n).toString();
                    var len = n.length;
                    if(len<=3){
                        return n;
                    }else{
                        return n;
                    }
                }
                var space=res.obj;
                var kb1 = Th(space[0]);
                var kb2 = Th(space[1]);
                var kb3 = Th(space[2]);
                $("#usedj").html("<fmt:message code="sys.byte"/>："+kb1+"b");
                $("#usablej").html("<fmt:message code="sys.byte"/>："+kb2+"b");
                $("#dosagej").html("<fmt:message code="sys.byte"/>："+kb3+"b");
                $("#usedFuzzyj").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[3]+"GB");
                $("#usableFuzzyj").html("&nbsp;&nbsp;&nbsp;&nbsp;"+space[4]+"GB");
                $("#dosageFuzzyj").html("&nbsp;&nbsp;&nbsp;&nbsp"+space[5]+" GB");
            },error:function(error){
                alert("网络状况不佳,请检查网络后重试!")
            }
        });
    //封装一个函数判断data是否是undefined的函数
    function undefinedData(data) {
        if(data == undefined){
            return '';
        }else {
            return data;
        }
    }



    function init() {
        var ajaxPage={
            data:{
                fromId:$('#addresser').attr('user_id'),
                toId2:$('#email').attr('user_id'),
                Subject:$("#TXT").val(),
                attachmentName:$("#name").val(),
                content:$("#content").val(),
                startTimes:$("#startTime").val(),
                endTimes:$("#endTime").val(),
//                endTime:$("#txt1").val(),
                page:1,
                pageSize:10,
                useFlag:true,
            },
            page:function () {
                var me=this;
                $.ajax({
                    type:'post',
                    url:'/disk/selectEmailAll',
                    dataType:'json',
                    data:me.data,
                    success:function(res){
                        var email=res.obj;
                        var Eam='';
                        for(var i=0;i<email.length;i++) {
                            Eam +='<tr data-id="'+email[i].bodyId+'">' +
                                '<td style="text-align:center;"><input name="checkChild" type="checkbox" ></td>' +
                                '<td style="text-align:center;">'+function () {
                                    if (email[i].readFlag==1)
                                    {
                                        return '<img src="/img/icon_read_2_03.png">';
                                    }
                                    else{
                                        return '<img src="/img/icon_notread_1_03.png">';
                                    }
                                }()+'</td>' +
                                '<td style="text-align:center;" >'+undefinedData(email[i].fromName)+'</td>' +
                                '<td style="text-align:center;">'+undefinedData(email[i].toName)+'</td>' +
                                '<td class="theme" style="text-align:center;">'+undefinedData(email[i].subject)+'</td>' +
                                '<td style="text-align:center;">'+undefinedData(email[i].attachmentName)+'</td>' +
                                '<td style="text-align:center;">'+undefinedData(email[i].sendTimeStr)+'</td>' +
                                '</tr>'
                        }
                        $('#tBody').html(Eam);


                        me.pageTwo(res.totleNum,me.data.pageSize,me.data.page)
                    }
                });

            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_pagesd').pagination({
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
        }
        ajaxPage.page();
    }


    $('#right').width(function () {
        $(body).width-270+"px";
    })

    //    var oTable=document.getElementById("tablechaxun");
    //    var aTr=oTable.getElementsByTagName("tr");
    //    for(var i=0;i<aTr.length;i++){
    //        aTr[i].onmouseover=function(){
    //            aTr[i].style.backgroundColor="#2F8AE3";
    //        }
    //        if(i%2==0){
    //            aTr[i].style.backgroundColor="#ccc";
    //        }
    //        else{
    //            aTr[i].style.backgroundColor="#C0C0C0";
    //        }
    //    }
</script>



