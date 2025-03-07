<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>值班详情</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
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
    <script src="/js/workflow/work/workform.js?20210423"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.jqprint-0.3.js"></script>
    <script src="/js/jquery/jquery-migrate-1.4.1.js"></script>
    <%--<script src="../js/jquery/jquery.cookie.js"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>

        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
    </style>
</head>

<body class="bodycolor">
<div id="pagediv" class="tableMain" style="margin-top:20px">
    <form id="ajaxform" action="">
        <table>
            <tbody>
            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    按部门发布：
                </td>
                <td width="80%" style="text-align: left">
                    <p id="dept" style="float:left"></p>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    按角色发布：
                </td>
                <td width="80%" style="text-align: left">
                    <p id="priv" style="float:left"></p>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    按人员发布：
                </td>
                <td width="80%" style="text-align: left">
                    <p id="user" style="float:left"></p>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    时间:
                </td>
                <td width="80%" style="text-align: left">
                    <input disabled="true" style="width: 204px" readonly="readonly" type="text" name="startTime" id="startTime" placeholder="<fmt:message code="adding.th.PleasePeriod"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                    <%--<span><fmt:message code="global.lang.to"/></span>--%>
                    <span>——</span>
                    <input disabled="true" style="width: 204px" readonly="readonly" type="text" name="endTime" id="endTime"
                           placeholder="<fmt:message code="adding.th.PleasePeriod"/>"
                           onclick="laydate(dataobj)">
                    <%--<span><fmt:message code="notice.th.null"/></span>--%>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--星期:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<select disabled="true" id="weekTime" style="width: 5%;text-align:center">--%>
                        <%--<option>一</option>--%>
                        <%--<option>二</option>--%>
                        <%--<option>三</option>--%>
                        <%--<option>四</option>--%>
                        <%--<option>五</option>--%>
                        <%--<option>六</option>--%>
                        <%--<option>日</option>--%>
                    <%--</select>--%>
                <%--</td>--%>
                <%--<input  name="week" id="getWeekTime">--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--日期:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="dateTime" id="dateTime" style="width:5%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--带班儿领导:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="leaderClass" id="leaderClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室白班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="dayClass" id="dayClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室夜班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="nightClass" id="nightClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--机要室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="chanceClass" id="chanceClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--文秘室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="secretary" id="secretary" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--驾驶员值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input disabled="true" name="driveClass" id="driveClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.fileUpload"/>
                </td>
                <td width="80%"  style="text-align: left">
                    <div class="divContent1" style="padding-top:10px;margin: 20px 40px;">
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>

<div id="pagedivPrint" style="display: none" class="tableMain">
    <form id="ajaxform1" action="">
        <table>
            <tbody>

            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    时间:
                </td>
                <td width="80%" style="text-align: left">
                    <p id="startTime1" style="float:left"></p><p style="float:left">——</p><p id="endTime1" style="float:left"></p>
                </td>
            </tr>
            <tr class="fileBox">
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    附件:
                </td>
                <td width="80%" style="text-align: left">
                    <p id="file"></p>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--星期:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="weekTime1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--日期:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="dateTime1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--带班儿领导:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="leaderClass1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室白班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="dayClass1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室夜班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="nightClass1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--机要室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="chanceClass1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--文秘室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="secretary1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--驾驶员值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<p id="driveClass1"></p>--%>
                <%--</td>--%>
            <%--</tr>--%>
            </tbody>
        </table>
    </form>
</div>
</body>
    <script>
        $(function(){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
                dataType:'json',
                success:function (res) {
                    if(res.object.length!=0){
                        var data=res.object[0]
                        if (data.paraValue!=0){
                            $('#ajaxform').before('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;line-height: 16px;"> 机密级★ </span>')
                        }
                    }
                }
            })
            var str = '<table style="margin-top:-1px">'+
                '<tbody>'+
                '<tr>'+
                '<td colspan="2" style="text-align: center" class="btnarr">'+
                '<a href="javascript:;" class="sendbtn" id="print">打印</a>'+
                '<a href="javascript:;" class="sendbtn" id="returnList">关闭</a>'+
                '</td>'+
                '</tr>'+
                '</tbody>'+
                '</table>';
            $("#ajaxform").append(str);
            $("#returnList").on("click",function(data){
                window.opener=null;
                window.open('','_self');
                window.close();
            });

            $("#print").on("click",function (data) {
                if($('.font_').length == 0){
                    $('.fileBox').hide();
                }else{
                    $('#file').html($('.divContent1').html());
                }
                $('.font_ .download_a').hide();
                $('#pagedivPrint').show();
                $("#pagedivPrint").jqprint();
                $('#pagedivPrint').hide();
                $('.font_ .download_a').show();
            })
            /*查询某条公告数据的接口*/
            var dutyId=$.getQueryString("dutyId");

            $.ajax({
                url: '/dutyManagement/getDutyFormById',
                type: 'get',
                data: {
                    dutyId: dutyId
                },
                dataType: 'json',
                success: function (data) {
                    $('#dept').html(data.toIdStr)
                    $('#priv').html(data.privIdStr)
                    $('#user').html(data.userIdStr)
                    $("#startTime").val(data.startTime);
                    $("#endTime").val(data.endTime);
                    $("#weekTime").val(data.week);
                    $("#dateTime").val(data.dateTime);
                    $("#leaderClass").val(data.leaderClass);
                    $("#dayClass").val(data.dayClass);
                    $("#nightClass").val(data.nightClass);
                    $("#chanceClass").val(data.chanceClass);
                    $("#secretary").val(data.secretary);
                    $("#driveClass").val(data.driveClass);

                    $("#startTime1").html(data.startTime);
                    $("#endTime1").html(data.endTime);
                    $("#weekTime1").html(data.week);
                    $("#dateTime1").html(data.dateTime);
                    $("#leaderClass1").html(data.leaderClass);
                    $("#dayClass1").html(data.dayClass);
                    $("#nightClass1").html(data.nightClass);
                    $("#chanceClass1").html(data.chanceClass);
                    $("#secretary1").html(data.secretary);
                    $("#driveClass1").html(data.driveClass);
                    var arrList=data.attachmentList
                    if(arrList.length>0){
                        attachmentShow(arrList,'1',$('.divContent1'),'1');
                    }
                }
            })
            })
        function dj(e){
            var atturl = e.attr('attrurl');
            pdurl($.UrlGetRequest('?'+atturl),atturl);
        }

        function pdurl(gs,atturl){
            if(gs == 'pdf'||gs == 'txt'){
                $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1500px','800px');
            }else if(gs == 'png'||gs == 'jpg'||gs == 'bmp'){
                $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1500px','800px');
            }else{
                var url = "/common/webOfficeView?documentEditPriv=0&"+atturl;
                $.ajax({
                    url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                    type:'post',
                    datatype:'json',
                    async:false,
                    success: function (res) {
                        if(res.flag){
                            if(res.object[0].paraValue == 0){
                                //默认加载NTKO插件 进行跳转
                                url = "/common/ntkoview?documentEditPriv=0&"+atturl;
                            }else if(res.object[0].paraValue == 2){
                                //默认加载NTKO插件 进行跳转
                                url = "/wps/info?"+ atturl +"&permission=read";
                            }else if(res.object[0].paraValue == 3){
                                //默认加载onlyoffice插件 进行跳转
                                url = "/common/onlyoffice?"+ atturl +"&edit=false";
                            }
                        }

                    }
                })
                $.popWindow(url,PreviewPage,'0','0','1500px','800px');
            }
        }

    </script>
</html>
