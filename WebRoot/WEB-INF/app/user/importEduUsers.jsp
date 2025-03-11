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


    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>
    <style>
        #modle {
            display: block;
            color: #0088cc;
            margin: 18px;
            font-size: 16px;
            margin-left: 150px;
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
            display: block;
            margin-left: 10px;
            margin-top: -3px;
        }

        .center{
            font-size: 16px;
        }
        .formTb{
            min-width: 550px;
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
        a {
            text-decoration: none;
            color: #3eb1f0;
            cursor: pointer;
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
        </div>
        <div class="center">
            <form class="form1" name="form1" id="uploadForm" method="post" action="../user/insertImportUsersByEdu" enctype="multipart/form-data" >
                <table class="tr_td formTb" align="center">
                    <tbody>
                    <tr>
                        <td nowrap="" class="TableData" style="width: 88px;"><b><p>默认密码：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="text" class="pw" name="pw" style="width: 150px;" value="shmhedu2017"><br>
                        </td>
                    </tr>
                   <%-- <tr>
                        <td nowrap="" class="TableData"><b><p>请设置默认角色(为空则不设置)：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="text" name="userPriv" id="userPrivInput"  style="width: 150px;" value="" privid="" userpriv=""> &nbsp;&nbsp;
                            <a href="javascript:;" class="userPrivAdd" name="orgAdd" ><fmt:message code="global.lang.add" /></a>
                            <a href="javascript:;" class="userPrivClear" name="orgClear"><fmt:message code="global.lang.empty"/></a>

                        </td>
                    </tr>


                    <tr>
                        <td nowrap="" class="TableData" style="width: 88px;"><b><p>请设置生成规则(为空则不设置)：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="text" class="rule" name="rule" style="width: 150px;" ><br>
                        </td>
                    </tr>--%>

                    <tr>
                        <td nowrap="" class="TableData" style="width: 88px;"><b><p><fmt:message code="user.th.Specify" />：</p></b></td>
                        <td nowrap="" class="TableData">
                            <input type="file" name="file" class="BigInput" size="30"><br>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" class="TableData"><b><p>身份证号重复时是否更新：</p></b></td>
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
                    <th nowrap="" align="center">部门</th>
                    <th nowrap="" align="center">用户名</th>
                    <th nowrap="" align="center">姓名</th>
                    <th nowrap="" align="center">角色</th>
                    <th nowrap="" align="center">排序号</th>
                    <th nowrap="" align="center">管理范围</th>
                    <th nowrap="" align="center">信息</th>
                </tr>

            </table>
        </div>
    </div>
</div>
<script Language="JavaScript">
    $(function () {
        $('#modle').click(function () {
            window.location.href="/file/user/用户导入模板.xls"
        })

        $('.subBtn').click(function () {
            var flag = CheckForm();
            if (flag) {
                layer.msg("正在导入中，请耐心等候", {icon: 1});
                $('#uploadForm').ajaxSubmit({
                    dataType: 'json',
                    success: function (res) {
                        if(res.flag) {
                            $('.center').css('display', 'none');
                            $('.dataTab').css('display', 'block');
                            var data1 = res.obj;
                            var str = '';
                            var updateCount = data1[0].updateCount;
                            var insertCount = data1[0].insertCount;
                            for (var i = 0; i < data1.length; i++) {
                                str += '<tr class="userData" uid="' + data1[i].uid + '">' +
                                    '<td deptId="' + data1[i].deptId + '">' + data1[i].deptName + '</td>' +
                                    '<td>' + data1[i].byname + '</td>' +
                                    '<td>' + data1[i].userName + '</td>' +
                                    '<td>' + data1[i].userPrivName + '</td>' +
                                    '<td>' + data1[i].userNo + '</td>' +
                                    '<td>' + function () {
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
                                    }() + '</td>' +
                                    '<td>'+data1[i].saveMsg+'</td>' +
                                    '</tr>';
                            }
                            $('.tr_before').after(str);
                            layer.msg("共新增" + insertCount + "条数据,更新" + updateCount + "条数据!", {icon: 1});
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
        $('.userPrivClear').click(function () {
            $('#userPrivInput').attr("privid","");
            $('#userPrivInput').attr("userpriv","");
            $('#userPrivInput').val("");
        });})

</script>
</body>
</html>
