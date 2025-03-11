
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
    <title><fmt:message code="notice.th.buildnotify"/></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>--%>
    <%--<script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <%--<script src="../js/jquery/jquery.cookie.js"></script>--%>
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
        .openFile:hover{
            cursor: pointer;
        }
        .cleardate{
            color: red;
        }
    </style>
    <script src="/js/dutyManagement/dutyFormManagementAdd.js?20230309"></script>
    <script>

    </script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <%--<h2>添加值班表</h2>--%>
    <h3 style="font-weight:normal;display:inline-block;font-size:22px;color:#494d59;vertical-align:middle;margin-left:10px" id="Title"></h3>

</div>
<div id="pagediv" class="tableMain">
    <form id="ajaxform" action="">
        <input type="hidden" id="dutyId" name="dutyId">
    <table>
        <tbody>
            <tr>
                <td class="blue_text" width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="notice.th.IssuedByDepartment"/>：</p>
                    <a href="javascript:;" class="deptandrole">点击添加<fmt:message code="notice.th.PostedByPersonnelOrRoles"/></a>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="department" cols="30" rows="3"></textarea>
                    <b>*</b>
                    <a href="javascript:;" class="addControls" data-type="1"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="toId">
                    <p><fmt:message code="vote.th.(UnionPersonnel)"/></p>
                </td>
            </tr>
            <tr class="deptrole">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.role"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="roleall" cols="30" rows="3"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="2"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="privId">
                </td>
            </tr>
            <tr class="deptrole">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.somebody"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <div id="fileAll">

                    </div>
                    <textarea name="" class="theControlData" readonly="readonly" id="personnel" cols="30" rows="3"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="3"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="userId">
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <%--<fmt:message code="notice.th.validity"/>：--%>
                    时间:
                </td>
                <td width="80%" style="text-align: left">
                    <input style="width: 204px" readonly="readonly" type="text" name="startTime" id="startTime" placeholder="<fmt:message code="adding.th.PleasePeriod"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                    <%--<span><fmt:message code="global.lang.to"/></span>--%>
                    <span>——</span>
                    <input style="width: 204px" readonly="readonly" type="text" name="endTime" id="endTime"
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
                    <%--<select id="weekTime" style="width: 5%;text-align:center">--%>
                        <%--<option value="一">一</option>--%>
                        <%--<option value="二">二</option>--%>
                        <%--<option value="三">三</option>--%>
                        <%--<option value="四">四</option>--%>
                        <%--<option value="五">五</option>--%>
                        <%--<option value="六">六</option>--%>
                        <%--<option value="日">日</option>--%>
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
                    <%--<input name="dateTime" id="dateTime"  style="width:5%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--带班领导:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="leaderClass" id="leaderClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室白班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="dayClass" id="dayClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--值班室夜班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="nightClass" id="nightClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--机要室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="chanceClass" id="chanceClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--文秘室值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="secretary" id="secretary" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="blue_text" width="20%">--%>
                    <%--&lt;%&ndash;<fmt:message code="notice.th.reminder"/>：&ndash;%&gt;--%>
                    <%--驾驶员值班:--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--<input name="driveClass" id="driveClass" style="width:10%;border:1px solid #c0c0c0;border-radius:5px;height:32px"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="blue_text">附件：</td><%--备注--%>
                <td class="TableData" id="files_txt" colspan=3>
                    <%--<textarea name="remark" id="remark" cols="84" rows="3" class="BigInput" value=""></textarea>--%>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                   附件上传:
                </td>
                <td width="80%" style="text-align: left">
                    <div style="float: left">
                        <a href="javascript:;" class="openFile">
                            <img src="../img/mg11.png" alt="">
                            <span><fmt:message code="email.th.addfile"/></span>
                            <input type="file" multiple id="fileupload" data-url="../upload?module=notify" name="file">
                        </a>
                    </div>

                    <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                        <div class="bar" style="width: 0%;"></div>
                    </div>
                    <div class="barText" style="float: left;margin-left: 10px;"></div>
                    <input type="hidden" name="attachmentId">
                    <input type="hidden" name="attachmentName">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center" class="btnarr">
                    <a href="javascript:;" class="sendbtn" onclick="ajaxforms(1)">保存</a>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
</div>
</body>
</html>