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
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="../../js/ajaxfileupload.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>

    <title><fmt:message code="workflow.th.Import" /></title>
    <style type="text/css">
        table{
            border-collapse:collapse;
            font-weight: normal;
            width: 50%;
            margin: 0 auto;
            border: #ccc 1px solid;
        }
        table tr td{
            padding: 5px;
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
        select{
            width: 100px;
            height: 28px;
        }
        .export,.export_s{
            width:70px;
            font-size:14px;
            line-height: 30px;
            height:30px;
            border-radius:5px;
            background: #2b7fe0;
            color:#ffffff;
            text-align: center;
            margin-right:30px;
            cursor:pointer;
            margin: 0 auto;
        }
    </style>
</head>
<body>

    <div class="headPer" style="height: 45px;line-height: 45px;">
        <span style="font-size: 22px"><img src="../img/icon_addrole_06.png" style="margin-right: 12px;vertical-align: middle;margin-left: 30px;">工资数据导入</span>
        <a href="/file/payroll/工资模板.xlsx" style="color: #0088cc;font-size: 10pt;margin-left: 20px;">点击下载模板</a>
    </div>
    <form class="form1" name="form1" id="uploadForm" method="post" action="/bonusmsg/insert" enctype="multipart/form-data" >
        <table border="1">
            <tr>
                <td colspan="2" style="text-align: center;font-size: 12pt;"><fmt:message code="dem.th.ImportData" /></td>
            </tr>
            <tr>
                <td class="txt_r"><fmt:message code="dem.th.DataTime" />:</td>
                <td id="" class="p2">
                    <input type="hidden" name="time" value="">
                    <div class="demand">
                        <select id="year" style="text-align: center"> </select>
                        <span><fmt:message code="chat.th.year" /></span>
                       <select id="month" style="text-align: center"></select>
                        <span><fmt:message code="global.lang.month" /></span>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td class="txt_r"><fmt:message code="dem.th.DatasheetType" />:</td>--%>
                <%--<td class="p2">--%>
                    <%--<input type="hidden" name="type" value="">--%>
                    <%--<select id='type'>--%>
                        <%--<option value="1"><fmt:message code="dem.th.Payroll" /></option>--%>
                        <%--<option value="2" selected><fmt:message code="dem.th.BonusList" /></option>--%>
                    <%--</select>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="to txt_r" ><fmt:message code="hr.th.SelectImportfile" />：</td>
                <td style=" width:60%;" class="p2">
                    <input type="file" name="file" id="wj" value="<fmt:message code="file.th.PleaseSelectFile" />"/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><div class="export">导入</div></td>
            </tr>

        </table>
    </form>


    <div class="headPer" style="height: 45px;line-height: 45px;">
        <span style="font-size: 22px"><img src="../img/icon_addrole_06.png" style="margin-right: 12px;vertical-align: middle;margin-left: 30px;">奖金数据导入</span>
        <a href="/file/payroll/奖金模板.xlsx" style="color: #0088cc;font-size: 10pt;margin-left: 20px;">点击下载模板</a>
    </div>
    <form class="form1" name="form1" id="uploadForm_s" method="post" action="/bonusmsg/insert" enctype="multipart/form-data" >
        <table border="1">
            <tr>
                <td colspan="2" style="text-align: center;font-size: 12pt;"><fmt:message code="dem.th.ImportData" /></td>
            </tr>
            <tr>
                <td class="txt_r"><fmt:message code="dem.th.DataTime" />:</td>
                <td class="p2">
                    <input type="hidden" class="Tims" value="">
                    <div class="demand">
                        <select id="year_s" style="text-align: center"> </select>
                        <span><fmt:message code="chat.th.year" /></span>
                        <select id="month_s" style="text-align: center"></select>
                        <span><fmt:message code="global.lang.month" /></span>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td class="txt_r"><fmt:message code="dem.th.DatasheetType" />:</td>--%>
                <%--<td class="p2">--%>
                    <%--<input type="hidden" name="type" value="">--%>
                    <%--<select id='type_s'>--%>
                        <%--<option value="1"><fmt:message code="dem.th.Payroll" /></option>--%>
                        <%--<option value="2" selected><fmt:message code="dem.th.BonusList" /></option>--%>
                    <%--</select>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="to txt_r" ><fmt:message code="hr.th.SelectImportfile" />：</td>
                <td style=" width:60%;" class="p2">
                    <input type="file" name="file" id="wj_s" value="<fmt:message code="file.th.PleaseSelectFile" />"/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><div class="export_s">导入</div></td>
            </tr>

        </table>
    </form>

<script>
    
    $(function () {
        $('.export').on("click",function () {
            var file=document.getElementById("wj").value;
             if(file.length<1){
                 layer.msg('请选择文件！',{icon: 2});
             }
            else{
                var dateYear=$('#year option:selected').val();
                var dateMonth=$('#month option:selected').val();
                $('input[name="time"]').val(dateYear +'年'+dateMonth+'月');
                var iframeChild=$("#iframes" , parent.document);
                var iframeUl=$('#iframeUl' , parent.document).find('li');
                $('#uploadForm').ajaxSubmit({
                    dataType: 'json',
                    data:{
                        type:1
                    },
                    success:function (res) {
                        $(iframeUl).eq(0).find('span').addClass('one').end().siblings().find('span').removeClass('one');
                        $(iframeChild).attr('src','/personSalary/personWages');
                    }
                })
            }
        })


        $('.export_s').on("click",function () {
            var file=document.getElementById("wj_s").value;
            if(file.length<1){
                layer.msg('请选择文件！',{icon: 2});
            }
            else{
                var dateYear=$('#year_s option:selected').val();
                var dateMonth=$('#month_s option:selected').val();
                $('.Tims').val(dateYear +'年'+dateMonth+'月');
                var iframeChild=$("#iframes" , parent.document);
                var iframeUl=$('#iframeUl' , parent.document).find('li');
                $('#uploadForm_s').ajaxSubmit({
                    dataType: 'json',
                    data:{
                        type:2,
                        time:dateYear +'年'+dateMonth+'月'
                    },
                    success:function (res) {
                        $(iframeUl).eq(1).find('span').addClass('one').end().siblings().find('span').removeClass('one');
                        $(iframeChild).attr('src','/personSalary/personBonus');
                    }
                })
            }
            })

    })
    
    
    function upfile(){
        var time=$('#year option:selected').val()+'<fmt:message code="chat.th.year" />'+$('#month option:selected').val()+'<fmt:message code="global.lang.month" />';
        var type= $("#type option:selected").val();
        $.ajaxFileUpload({
            url : "/personBonusmsg/personInsert",
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
    
    $("#down").on("click",function () {
        window.location.href=encodeURI("/file/payroll/模板.xlsx")

    })
    function YYYYMM(){//默认显示查询时间
        var y  = new Date().getFullYear();
        for (var i=(y-10);i<(y+11);i++){
            $('#year').append(new Option(" "+ i ));
            $('#year_s').append(new Option(" "+ i ));
        }
        $('#year').val(y);
        $('#year_s').val(y);

        for (var i=1;i<13;i++){
            $('#month').append(new Option(" " + i ));
            $('#month_s').append(new Option(" " + i ));
        }
        $('#month').val = new Date().getMonth() + 1;
        $('#month_s').val = new Date().getMonth() + 1;
    }YYYYMM();

</script>


</body>
</html>
