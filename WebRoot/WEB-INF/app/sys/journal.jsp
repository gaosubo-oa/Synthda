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
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="main.systemlogs" /></title>
    <link rel="stylesheet" type="text/css" href="../css/sys/journal.css?20220318"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20230428.1"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../lib/echarts/echarts.common.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/journal.js?20230428.3" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        table{
            font-size: 11pt;
        }
        table tr td:first-child {
            font-size: 13pt;
        }
        table .newData td{
            font-size: 11pt !important;
        }
        #yearDataExport,#journalQueryExport{
            margin: 11px 0px 0px 20px;
            height: 29px;
            line-height: 29px;
            padding: 0 14px;
        }
        #journalQueryExport{
            float: right;
            margin-right: 25px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="content">
    <div class="head w clearfix">
        <ul class="index_head">
            <li id="survey"><span class="one headli"><fmt:message code="journal.th.LogProfile" /></span><img src="../img/twoth.png" alt=""/>
            </li>
            <li id="DATA"><span class="headli"><fmt:message code="journal.th.AnnualData" /></span><img src="../img/twoth.png" alt=""/>
            </li>
            <li id="statistics"><span class="headli"><fmt:message code="journal.th.PeriodStatistics" /></span><img src="../img/twoth.png" alt=""/>
            </li>
            <li id="administration"><span class="headli" style="margin-top: 4px;"><fmt:message code="journal.th.LogManagement" /></span><img src="../img/twoth.png" alt=""/></li>
            <li id="versionlog"><span class="headli" style="margin-top: 4px;"><fmt:message code="interfaceSetting.th.versionUpgradeLog" /></span>
            </li>
        </ul>
    </div><!--标题导航结束-->
    <div class="mainCon" style="width: 100%;margin-top: 46px;">
        <div class="journalSurvey" style="display: block;">
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_logProfile.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="journal.th.LogProfile" /></div>
            </div>
            <div class="table">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr>
                        <td colspan="2" style="text-align: center;color: #2F5C8F;font-weight: bold;"><fmt:message code="journal.th.LogProfile" /></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.TotalDays" />：</td>
                        <td width="80%" class="totalDay"></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.TotalVisits" />：</td>
                        <td width="80%" class="totalCount"></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.ThisTraffic" />：</td>
                        <td width="80%" class="yearCount"></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.ThisMonth" />：</td>
                        <td width="80%" class="mouthCount"></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.Today'sTraffic" />：</td>
                        <td width="80%" class="dayCount"></td>
                    </tr>
                    <tr>
                        <td width="20%"><fmt:message code="journal.th.Average" />：</td>
                        <td width="80%" class="averageDayCount"></td>
                    </tr>
                </table>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr class="newly">
                        <td colspan="7" style="color: #2F5C8F;font-weight: bold;"><fmt:message code="journal.th.Last10logs" /></td>
                    </tr>
                </table>
            </div>
        </div><!--日志概况结束-->
        <div class="yearData" style="display: none">
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_yearData.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="journal.th.AnnualData" /></div>
                <div>
                    <select name="yeay" class="selectYear" id="select">
                        <option value="2018">2018<fmt:message code="chat.th.year" /></option>
                    </select>
                    <select name="month" class="selectMonth" id="seleMonth">
                    </select>
                    <button class="layui-btn layui-btn-sm" type="button" style="margin-left: 20px;margin-top: 10px" id="daochu">
                        <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;"><fmt:message code="interfaceSetting.th.export" />
                    </button>
<%--                    <button id="yearDataExport" name="yearDataExport" class="layui-btn" type="button">导出</button>--%>
                </div>
            </div>
            <div class="yearEcharts" style="position: relative">
                <div style="width: 100%;text-align: center;position: absolute;top: 15px;font-size: 14px;"><span>2017</span><fmt:message code="journal.th.MonthlyAccessData" /></div>
                <div id="monthData" style="width: 900px;height:300px;margin: 0 auto;"></div>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr class="yearJournal">
                        <td colspan="4"><fmt:message code="journal.th.Monthly2017" /></td>
                    </tr>
                </table>
            </div>
            <div class="dateEcharts" style="position: relative">
                <div style="width: 100%;text-align: center;position: absolute;top: 15px;font-size: 14px;"><span class="monthSpan">1</span><fmt:message code="journal.th.DataByMonth" /></div>
                <div id="todyData" style="width: 900px;height:300px;margin: 0 auto;"></div>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr class="monthJournal">
                        <td colspan="4"><span class="monthSpan">1</span><fmt:message code="journal.th.DataByMonth" /></td>
                    </tr>
                </table>
            </div>
        </div><%--年度数据统计结束--%>
        <div class="timeInterval" style="display: none">
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_periodStatistics.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="journal.th.PeriodStatistics" /></div>
                <button class="layui-btn layui-btn-sm" type="button" style="margin-right: 20px;margin-top: 10px;float: right;" id="daochu1">
                    <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;"><fmt:message code="interfaceSetting.th.export" />
                </button>
<%--                <button id="journalQueryExport" name="journalQueryExport" class="layui-btn" type="button">导出</button>--%>
            </div>
            <div class="hourEcharts">
                <div id="hourData" style="width: 900px;height:300px;margin: 0 auto;"></div>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <tr class="period">
                        <td colspan="4"><fmt:message code="journal.th.TotalDistributionData" /></td>
                    </tr>
                </table>
            </div>
        </div><%--时段统计结束--%>
        <div class="journalQuery" style="display: none;">
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_logQuery.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="journal.th.SystemLogQuery" /></div>
            </div>
            <div class="table">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 40%;">
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.LogTable" />：</td>
                        <td>
                            <input type="radio" name="radio" checked>
                            <span><fmt:message code="journal.th.CurrentLog" /> </span>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.LogType" />：</td>
                        <td>
                            <select id="journalType" style="width: 150px;height: 25px;">
                                <option value=""><fmt:message code="journal.th.AllLogs" /></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.user" />：</td>
                        <td>
                            <div class="inPole">
                                <textarea name="txt" id="senduser" user_id='' value="" disabled style="min-width: 200px;min-height: 50px;"></textarea>
                                <span class="add_img" style="margin-left: 10px">
                                    <a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a>
                                </span>
                                <span class="add_img">
                                    <a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.StartingTime" />：</td>
                        <td>
                            <input type="text" class="laydate-icon" id="start">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.Deadline" />：</td>
                        <td>
                            <input type="text" class="laydate-icon" id="end">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.IPaddress" />：</td>
                        <td>
                            <input type="text" name="timer" id="IP">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.Remarks" />：</td>
                        <td>
                            <input type="text" name="timer" id="remarks">
                        </td>
                    </tr>
                    <tr>
                        <td width="25%"><fmt:message code="journal.th.OperationType" />：</td>
                        <td>
                            <input type="radio" name="TYPE" value="1" class="Query">
                            <span><fmt:message code="global.lang.query" /></span>
                            <input type="radio" name="TYPE" value="2" class="Export">
                            <span><fmt:message code="global.lang.report" /></span>
                           <%-- <input type="radio" name="TYPE" value="3" class="Delete">
                            <span><fmt:message code="global.lang.delete" /></span>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="blue_text">
                            <div class="sureBtn">
                                <%--<input type="button" name="Btn" id="Btn" value="<fmt:message code="global.lang.ok" />" />--%>
                                <div id="Btn" class="Btn"><span style="margin-left: 23px;"><fmt:message code="global.lang.ok" /></span></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
           <%-- <hr style="width: 99.8%;border-color: #ddd;border: #eee 1px solid;margin-top: 15px;"/>--%>
            <%--<div class="emptyTitle">
                <span class="emptyNews"><fmt:message code="journal.th.ClearSystemLogs" /></span>
            </div>--%>
          <%--  <div class="title">
                <div class="div_Img">
                    <img src="../img/sys/icon_empty.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="journal.th.ClearSystemLogs" /></div>
            </div>
            <div class="emptyBtn" id="emptyBtn"><span style="margin-left: 26px"><fmt:message code="journal.th.ClearSystemLogs" /></span></div>--%>
        </div><%--系统日志查询结束--%>
        <div class="queryResult" style="display:none;">
            <div class="title">
                <span class="news"><fmt:message code="journal.th.QueryResults" /></span>
                <span class="news"><fmt:message code="journal.th.NumberOfQueries" />：</span>
                <input type="text" name="num" class="num" value="">
                <%--<input type="button" name="numBtn" id="numBtn" class="numBtnT" value="<fmt:message code="global.lang.query" />">--%>
                <div id="numBtn" class="numBtnT"><span style="margin-left: 30px;"><fmt:message code="global.lang.query" /></span></div>
            </div>
            <div class="tabTwo">
                <table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 90%;">
                    <tr class="queryJournalList">
                        <th><fmt:message code="global.lang.select" /></th>
                        <th><fmt:message code="journal.th.UserName" /></th>
                        <th><fmt:message code="email.th.time" /></th>
                        <th><fmt:message code="journal.th.IPaddress" /></th>
                        <th><fmt:message code="journal.th.LocationIP" /></th>
                        <th><fmt:message code="journal.th.LogType" /></th>
                        <th style="width:150px"><fmt:message code="journal.th.Remarks" /></th>
                        <th>设备类型</th>
                        <th>版本号</th>
                    </tr>
                    <tr>
                        <td colspan="9" style="text-align: left">
                            <input id="checkedAll" type="checkbox" name="check" value="" style="margin-left: 20px;" >
                            <label for="checkedAll"><fmt:message code="notice.th.allchose" /></label>
                            <input type="button" name="delete" id="delete" class="numBtn" value="<fmt:message code="global.lang.delete" />">
                        </td>
                    </tr>
                </table>
                <div class="divBack" id="divBack"><span style="margin-left: 33px;"><fmt:message code="notice.th.return" /></span></div>
            </div>
        </div><%--查询结果列表结束--%>
        <div class="versionlog" style="display:none;"> <%--版本升级日志--%>
            <div class="title">
                <div class="div_Img">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_logProfile.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain" />">
                </div>
                <div class="new"><fmt:message code="interfaceSetting.th.versionUpgradeLog" /></div>
            </div>
            <div class="tabTwo1">
                <table cellspacing="0" id="versionlogat" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff">
                    <thead>
                    <tr>
                        <th><fmt:message code="interfaceSetting.th.versionUpgradeLog" /></th>
                        <th><fmt:message code="interfaceSetting.th.operation" /></th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var user_id='senduser';
    var res;
    //时间控件调用
    var start = {
        elem: '#start',
        format: 'YYYY-MM-DD 00:00:00',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    // $.ajax({
    //     type:'get',
    //     url:'../syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN',
    //     dataType:'json',
    //     success:function(res){
    //         if (res.object[0].paraValue==0){
    //             $('#survey').hide()
    //         }else {
    //             $('#survey').show()
    //         }
    //     }
    // })
    $("#start").on("click",function(){
        var starts = {
            elem: '#start',
            format: 'YYYY-MM-DD hh:mm:ss',
            /* min: laydate.now(), //设定最小日期为当前日期*/
            /* max: '2099-06-16 23:59:59', //最大日期*/
            istime: true,
            istoday: false,
            choose: function(datas){
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        laydate(starts);
    });
    $('#daochu').on("click",function(){
        var year=$('#select option:checked').val();
        var moth=$('#seleMonth option:checked').val();
        window.location.href = '/sys/getEachMouthLogData?year='+year+'&month='+moth+'&export='+1;
    })
    $('#daochu1').on("click",function(){
        window.location.href = '/sys/getHourLog?export='+1;
    })
    var end = {
        elem: '#end',
        format: 'YYYY-MM-DD hh:mm:ss',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
    $(function(){
        var years = '<option value="" >请选择年份</option>';
        for(var lastYear = parseInt(new Date().getFullYear()),oldYear = lastYear-20;lastYear>oldYear;lastYear--){
            years += '<option value="'+lastYear+'" >'+lastYear+'</option>'
        }
        $('#select').html(years);
        var yearss = new Date().getFullYear();
        $('#select').val(yearss);
        //选人控件
        $("#selectUser").on("click",function(){
            user_id='senduser';
            $.popWindow("../common/selectUser");
        });
        $('.clear').on("click",function(){

            $("#senduser").val("").attr({
                'username':'',
                'dataid':'',
                'user_id':'',
                'userprivname':''
            });
        })
        var date = new Date();
        $('.monthSpan').html(date.getMonth()+1);
        $('.yearEcharts div span').html(date.getFullYear());
        $('.yearJournal td').html(date.getFullYear()+'<fmt:message code="journal.th.MonthlyAccessData" />');
    })
</script>
</body>
</html>

