<%--
  Created by IntelliJ IDEA.
  User: huangzhijian
  Date: 2017/12/30
  Time: 17:08
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
<html>
<head>

    <meta charset="UTF-8">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="../../js/ajaxfileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>

    <title><fmt:message code="workflow.th.Import" /></title>
    <style type="text/css">
        table{
            border-collapse:collapse;
            font-weight: normal;
            font-size: 15px;
            width: 80%;
            height: 180px;
            margin: 0 auto;

        }
        p{
            margin: 0;padding: 0;
        }
        .to{
            text-align: right;
            width:40%;
        }
        .xiazai{
            color: blue;
            cursor: pointer;
        }
        .btn{
            background-color: rgb(43, 127, 224);
            color: #fff;
            border: 0;
            border-radius: 3px;
            cursor:pointer;
        }
        .txt_r{
            text-align: center;
        }
        .p2{
            padding-left:1em;
        }
    </style>
</head>
<body>

<h4><fmt:message code="dem.th.ImportData" /></h4>
    <table border="1">
        <%--<tr>
            <td class="to">下载导入模板：</td>
            <td><p1 class="xiazai">工资报表模板下载</p1></td>
        </tr>--%>
        <tr>
            <td class="txt_r"><fmt:message code="sms.th.templateFile" />:</td>
            <td  class="p2"><span id="down" style="cursor: pointer;color: blue"><fmt:message code="dem.th.ClickTemplate" /></span><fmt:message code="dem.th.(Note)" /></td>
        </tr>
        <tr>
            <td class="txt_r"><fmt:message code="dem.th.DataTime" />:</td>
            <td id="" class="p2">
                <div class="demand">
                    <select  name="YYYY"  id="year" style="text-align: center"> </select>
                    <span><fmt:message code="chat.th.year" /></span>
                  <%--  <select name="MM" id="month" style="text-align: center"></select>
                    <span><fmt:message code="global.lang.month" /></span>--%>
                </div>
            </td>
        </tr>
        <tr>
            <td class="txt_r"><fmt:message code="dem.th.DatasheetType" />:</td>
            <td class="p2">
                <select id='type'>
                    <option value="1"><fmt:message code="dem.th.Payroll" /></option>
                    <option value="2" selected><fmt:message code="dem.th.BonusList" /></option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="to txt_r" ><fmt:message code="hr.th.SelectImportfile" />：</td>
            <td style=" width:60%;" class="p2">
                <input type="file" name="file" id="wj" value="<fmt:message code="file.th.PleaseSelectFile" />"/>
            </td>
        </tr>

    </table>

<script>
    function upfile(){
        var time=$('#year option:selected').val()+'<fmt:message code="chat.th.year" />'/*+$('#month option:selected').val()+'<fmt:message code="global.lang.month" />'*/;
        var type= $("#type option:selected").val();
        $.ajaxFileUpload({
            url : "/bonusmsg/insert",
            type : 'POST',
            fileElementId : 'wj',
            data:{time:time,type:type},
            contentType:"application/json;charset=UTF-8",
            dataType:'json',
            success: function(data){
                if(data.flag){
                    layer.msg('<fmt:message code="menuSSetting.th.importSuccess" />！',{icon: 1});
                    /*setTimeout(function(){
                      back();
                    }, 2000);*/
                }
                else {
                    layer.msg('<fmt:message code="menuSSetting.th.importFailNoAuth" />！',{icon: 2});
                }
            },

        });

    }
    function back(){
        $("#back").on('click',function(){

        })
    }

    $("#down").on('click',function () {
        window.location.href=encodeURI("/file/payroll/模板.xlsx")

    })
    function YYYYMM(){//默认显示查询时间
        var y  = new Date().getFullYear();
        for (var i=(y-10);i<(y+11);i++){
            $('#year').append(new Option(" "+ i ));
        }
        $('#year').val(y);

       /* for (var i=1;i<13;i++){
            $('#month').append(new Option(" " + i ));
        }
        $('#month').val = new Date().getMonth() + 1;*/
    }YYYYMM();

</script>


</body>
</html>
