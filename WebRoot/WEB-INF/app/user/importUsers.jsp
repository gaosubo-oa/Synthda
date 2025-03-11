<%--
  Created by IntelliJ IDEA.
  User: gsb
  Date: 2017/7/7
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title><fmt:message code="userManagement.th.Userimport" /></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>


    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>
    <style>
        #modle {
            color: #0088cc;
            margin: 18px;
            font-size: 16px;
            margin-top: -22px;
        }
        #export {
            color: #0088cc;
            margin: 18px;
            font-size: 16px;
            margin-top: -22px;
        }
        .headPer{
            font-size: 22px;
            display: block;
            margin-top: 20px;
            margin-left: 30px;

        }
        .BigInput{
            width: 200px;
            display: block;
            margin-left: 10px;
        }
        b{
            display: block;
            margin-left: 20px;
        }
        .BigButton{
            width: 45px;
            background-color: #dcdcdc;
            border-radius: 5px;
        }
        .IMPORT_STYLE{
            margin-left: 10px;
            margin-top: -3px;
        }

        .center{
            font-size: 16px;
        }
        .formTb{
            min-width: 600px;
            max-width: 50%;
        }
        p{
            min-width: 230px;
        }
        .TableControl{
            padding-left: 50%;
        }
        .form1 {
            display: block;
            margin-top: 55px;
        }
        .BigButton{
            width: 70px;
            height: 28px;
            font-size: 13px !important;
            cursor: pointer;
            background-repeat: no-repeat;
            background-image: url(../../img/sys/confirm.png);
            padding-left: 25px;
            border: none;
        }
        .dataTab{
            display: none;
        }
        .tableList tr{
            text-align: center;
            padding: 10px;
        }
        .tableList th{
            color: #2F5C8F;
            font-weight: normal;
            padding: 10px;
            text-align: center;
            font-size:14px;
        }
        .userPrivOper{
            color:#207bd6;
            cursor: pointer;
            text-decoration: none;
        }
        .dataTab .tableList .tr_before th{
            font-size:13pt;
            font-weight: bold;
        }
        .dataTab .tableList .userData td{
            font-size:13pt;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right">
        <%--head 头部--%>
        <div class="headPer">
            <span style="font-size: 22px"><img src="../img/icon_addrole_06.png" style="margin-right: 12px;margin-bottom: 2px;"><fmt:message code="user.th.ImportUser" /></span>
            <a href="javascript:void(0)"  class="modlepanl"  id="modle" style=""><fmt:message code="user.th.TemplateDownload" /></a>
            <a href="javascript:void(0)"  class="export"  id="export" style="">错误数据下载</a>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
        <div class="center">
            <form class="form1" name="form1" id="uploadForm" method="post" action="../user/insertImportUsers" enctype="multipart/form-data" >
                <table class="tr_td formTb" align="center">
                    <tbody>

                    <tr>
                        <td nowrap="" class="TableData" style="width: 88px;"><b><p><fmt:message code="sys.th.setMima" />：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="text" class="psWord" name="psWord" style="width: 200px; margin-left: 10px;" ><br>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" class="TableData"><b><p><fmt:message code="sys.th.setRole" />：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="text" name="userPriv" id="userPrivInput"  style="width: 200px; margin-left: 10px;" value="" privid="" userpriv=""> &nbsp;&nbsp;
                            <a href="javascript:;" class="userPrivAdd userPrivOper" name="orgAdd" style="display: inline-block;margin-top: 5px;"><fmt:message code="global.lang.add" /></a>
                            <a href="javascript:;" class="userPrivClear userPrivOper" name="orgClear"><fmt:message code="global.lang.empty"/></a>

                        </td>
                    </tr>

                    <tr>
                        <td nowrap="" class="TableData" style="width: 88px;"><b><p><fmt:message code="user.th.Specify" />：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="file" name="file" class="BigInput" size="30"><br>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" class="TableData"><b><p><fmt:message code="user.th.repeated" />：</p></b></td>
                        <td nowrap="" class="TableData">

                            <input type="checkbox" class="IMPORT_STYLE" name="ifUpdate"  checked value="yes" >
                            <span><fmt:message code="global.lang.yes" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" align="center" valign="middle"  class="TableControl" colspan="2" align="center">
                            <%--<input type="hidden" value="" name="FILE_NAME">
                            <input type="hidden" value="" name="GROUP_ID">--%>
                            <input type="button"  value="<fmt:message code="workflow.th.Import" />" class="BigButton subBtn">&nbsp;&nbsp;
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="dataTab">
            <table class="tableList" width="100%" align="center">
                <tr class="tr_before">
                    <th nowrap="" align="center"><fmt:message code="hr.th.department" /></th>
                    <th nowrap="" align="center"><fmt:message code="global.lang.user" /></th>
                    <th nowrap="" align="center"><fmt:message code="userDetails.th.name" /></th>
                    <th nowrap="" align="center"><fmt:message code="userManagement.th.role" /></th>
                    <th nowrap="" align="center"><fmt:message code="vote.th.SortNumber" /></th>
                    <th nowrap="" align="center"><fmt:message code="userManagement.th.ManagementScope" /></th>
                    <th nowrap="" align="center"><fmt:message code="information" /></th>
                </tr>

            </table>
        </div>
    </div>
</div>
<script Language="JavaScript">
    var urL
    $('.export').hide();
    $(function () {
        if(parent.location.href.indexOf('/hierarchical/common/userManager') > -1){
            $('#uploadForm').attr('action','/hierarchicalGlobal/GlobalinsertImportUsers');
        }
        $('#modle').on("click",function () {
            window.location.href="/file/user/用户导入模板.xls"
        })
        $('.subBtn').on("click",function () {
            $('.export').show();
            var flag = CheckForm();
            if (flag) {
                layer.msg('<fmt:message code="down.th.2" />', {icon: 1});
                $('#uploadForm').ajaxSubmit({
                    dataType: 'json',
                    success: function (res) {
                        if(res.flag) {
                            if(res.object!=''){
                                urL=res.object[0].attUrl
                            }
                            $('.center').css('display', 'none');
                            $('.dataTab').css('display', 'block');
                            var data1 = res.obj;
                            var str = '';
                            var updateCount = data1[0].updateCount;
                            var insertCount = data1[0].insertCount;
                            for (var i = 0; i < data1.length; i++) {
                                str += '<tr class="userData" uid="' + data1[i].uid + '">' +
                                    '<td deptId="' + data1[i].deptId + '">' + undefindData(data1[i].deptName) + '</td>' +
                                    '<td>' + undefindData(data1[i].byname) + '</td>' +
                                    '<td>' + function () {
                                       if(data1[i].userName != undefined){
                                           return data1[i].userName;
                                       } else{
                                           return '';
                                       }
                                    }() + '</td>' +
                                    '<td>' + undefindData(data1[i].userPrivName) + '</td>' +
                                    '<td>' + undefindData(data1[i].userNo) + '</td>' +
                                    '<td>' + function () {
                                    if(data1[i].postPriv!=undefined){
                                        switch (parseInt(data1[i].postPriv)) {
                                            case 1:
                                                return '<fmt:message code="url.th.all" />';
                                                break
                                            case 2:
                                                return '<fmt:message code="sys.th.DesignatedDepartment" />';
                                                break
                                            case 0:
                                                return '<fmt:message code="sys.th.ThisDepartment" />';
                                                break
                                        }
                                    }else{
                                        return "";
                                    }

                                    }() + '</td>' +
                                    '<td>'+data1[i].saveMsg+'</td>' +
                                    '</tr>';
                            }
                            $('.tr_before').after(str);
                            layer.msg('<fmt:message code="sys.th.addNew" />' + insertCount + '<fmt:message code="sys.th.date" />' + updateCount + '<fmt:message code="sys.th.date2" />!', {icon: 1});
                        }else{
                            layer.msg(res.msg, {icon: 2});
                        }
                    }
                })
            }
        });

    })

    function CheckForm(){
        if(document.form1.file.value==""){
            layer.msg("<fmt:message code="user.th.selectImport" />！",{icon:2});
            return (false);
        }

        /*if (document.form1.file.value!="")
         {
         var file_temp=document.form1.file.value,file_name;
         var Pos;
         Pos=file_temp.lastIndexOf("\\");
         file_name=file_temp.substring(Pos+1,file_temp.length);
         document.form1.FILE_NAME.value=file_name;
         }*/

        return (true);
    }
    function undefindData(data) {
        if(data == undefined){
            return '';
        }else {
            return data
        }
    }
    $('.export').on("click",function () {
        if(urL==undefined){
            layer.msg('未查询到错误数据', { icon:6});
            return false;
        }
        window.location.href = '/download?'+urL
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
<script type="text/javascript">
    var priv_id;
    $(function () {
        // 获取角色信息控件
        $(".userPrivAdd").on("click",function(){
            priv_id="userPrivInput";
            $.popWindow("../common/selectPriv?0");
        });
        // 清空角色信息
        $('.userPrivClear').on("click",function () {
            $('#userPrivInput').attr("privid","");
            $('#userPrivInput').attr("userpriv","");
            $('#userPrivInput').val("");
        });})

</script>
</body>
</html>
