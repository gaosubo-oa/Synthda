<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE html>
<!--[if IE 6 ]> <html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]> <html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]> <html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]> <html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]> <html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <title>部门号码添加</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">

    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <%--<script type="text/javascript" src="/js/common/fileupload.js"></script>--%>

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>

    <style>

        body{
            font-size: 15px;
            font-family: 微软雅黑;
        }

        .TableBlock .TableData td, .TableBlock td.TableData {
            background: #FFFFFF;
            border-bottom: none;
            border-right: none;
            padding: 3px;
        }
        .big3{
            margin-left: 5px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-top: -3px;
            margin-right: 40px;
            font-size: 22px;
            color: #494d59;
            font-weight: inherit;
        }


        .btn_ .btn_style {
            background: url("../../img/save.png") no-repeat;
        }
        #rs {
            display: inline-block;
            float: left;
            width: 66px;
            height: 30px;
            text-align: center;
            margin-top: 10px;
            margin-bottom: 20px;
            padding-left: 23px;
            padding-top: 7px;
            cursor: pointer;
            font-size: 14px;
            background: url("../../img/publish.png") no-repeat;
            margin-left: 40%;
        }
        .TableData{
            font-size: 14px;
            color: #2a588c;
            /*   font-weight: bold;*/
        }
        .TableBlock tbody tr{
            height: 52px;
        }
        .TableBlock tbody tr td{
            border: 1px solid #c0c0c0;
        }
        .TableBlock{
            border: 1px #124164 solid;
        }


        .TableBlock tr td:first-of-type,table tr td:nth-child(3){
            text-align: right;
        }
        .div_1{
            margin-left: 20px;
        }
        .newClass{
            float: right;
            width: 90px;
            height: 28px;
            background: #2b7fe0!important;;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin-right: 80px;
            cursor: pointer;
            border-radius: 5px;
        }
        .div_1 {
            margin-left: 20px;
            float: left;
        }
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
    </style>
</head>


<script type="text/javascript">

</script>

<body class="bodycolor" topmargin="5">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
    <tr>
        <td>
            <div class="div_1">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/notify_new.png" align="absmiddle"><span class="big3">部门号码添加</span>&nbsp;&nbsp;
            </div>
        </td>
    </tr>
</table>
<br>
<form enctype="multipart/form-data" action=""  method="post" id="form1" name="form1" onSubmit="return CheckForm();">
    <table class="TableBlock" width="50%" align="center">




        <tr>
            <td nowrap class="TableData">部门：</td><%--备注--%>
            <td class="TableData" colspan=3>
                <input type="text" id="userId" name="userId" style="width: 166px;height:28px;" size="12" class="BigStatic" readonly value="">&nbsp;
                <a href="javascript:;" id="departAdd" class="departAdd" ><fmt:message code="global.lang.select" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap class="TableData">部门号码：</td><%--备注--%>
            <td class="TableData" colspan=3>
                <input type="text" id="smsGateAccount" style="width: 166px;height:28px;" name="smsGateAccount" size="12" class="BigInput" value=""/>
            </td>
        </tr>
        <%--<tr>--%>
            <%--<td nowrap class="TableData">密码：</td>&lt;%&ndash;备注&ndash;%&gt;--%>
            <%--<td class="TableData" colspan=3>--%>
                <%--<input type="text" id="smsGatePassword" style="width: 166px;height:28px;" name="smsGatePassword" size="12" maxlength="10" class="BigInput" value=""/>--%>
            <%--</td>--%>
        <%--</tr>--%>


        <tr align="center" class="TableControl">
            <td colspan=4 nowrap>
                <div id="rs" type="save" class="btn_style btn_ok"><fmt:message code="global.lang.save" /></div><%--保存--%>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">

    var user_id;
    var dept_id;

    function selectNumber(name,val){
        var numbers = $("select[name="+name+"]").find("option"); //获取select下拉框的所有值

        for (var j = 1; j < numbers.length; j++) {
            if ($(numbers[j]).val() == val) {
                $(numbers[j]).attr("selected", "selected");
            }
        }
    }
    var typeHr=getQueryString('typeHr');
    $(function () {
        if(typeHr == '1'){
            $('#newClass').hide();
        }else{
            $('#newClass').show();
        }
//        获取编辑id回显数据
        var id=$.getQueryString('id');


        $('#departAdd').click(function(){
            dept_id="userId";
            $.popWindow("../../common/selectDept");
        })

        //清空
        $('.orgDepartClear').click(function(){
            $('#joinDept').attr("dataid","");
            $('#joinDept').attr("depart_id","");
            $('#joinDept').attr("deptname","");
            $('#joinDept').val("");
        })

        // 清空
        $('.orgUserClear').click(function(){
            $('#joinPerson').attr("dataid","");
            $('#joinPerson').attr("user_id","");
            $('#joinPerson').attr("userprivname","");
            $('#joinPerson').attr("username","");
            $('#joinPerson').val("");
        });

        function CheckForm(){
            if($('#planNo').val()==''){
                layer.msg('<fmt:message  code="event.th.PlanNull"/>',{icon:2});
                return false;
            }
            if($('#planName').val()==''){
                layer.msg('<fmt:message  code="event.th.PlanEmpty"/>',{icon:2});
                return false;
            }
            if($('#assessingOfficer').val()==''){ //审批人不能为空
                layer.msg('<fmt:message  code="withdraw.th.shenpi"/>',{icon:2});
                return false;
            }
            return true;
        }


        // 提交表单
        $("#rs").click(function(){
            $('#form1').attr('action','')
            var fileId=''
            var fileName=''
            if(CheckForm())
            {

                var data = {
                    deptId: $('#userId').attr('deptid'),
                    smsGateAccount:$('#smsGateAccount').val(),
                    smsGatePassword:$('#smsGatePassword').val(),
                }

                    $.ajax({
                        type: 'post',
                        url: '/department/infoAdd',
                        dataType: 'json',
                        data: data,
                        success: function (rsp) {
                            if (rsp.flag == true) {
                                layer.msg('<fmt:message code="url.th.addSuccess" />', {icon: 1},function () {
                                        parent.location.href = '/department/infoSetting';
                                });

                            } else {
                                layer.msg('<fmt:message code="hr.th.AddFailed" />', {icon: 2});
                                /*添加失败*/
                            }
                        }
                    })

            }
        });

    });
    //获取url参数
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return r[2];
        return '';
    }
</script>
</body>
</html>

