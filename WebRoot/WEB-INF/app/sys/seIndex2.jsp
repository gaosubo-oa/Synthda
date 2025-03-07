<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>

<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
     <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
     <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
     <link rel="stylesheet" type="text/css" href="../css/sysManagement/style2.css" />
    <!--[if lte IE 8]>
       <!-- <script type="text/javascript" src="/static/js/ccorrect_btn.js"></script>-->
    <![endif]-->
     <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
     <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
     <script src="/lib/layer/layer.js?20201106"></script>
     <script src="/js/base/base.js"></script>
    <%-- <script type="text/javascript" src="../js/sys/utility.js"></script>--%>

</head>
 <style>
     body{
         font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
         font-size: 14px;
     }
     .small tbody tr{
         height: 52px;
     }
     .small tbody tr td{
         border: 1px solid #c0c0c0;
     }
     input[type="radio" ], input[type="checkbox" ] {
         background-color: initial;
         margin: 3px 0.5ex;
         padding: initial;
         border: initial;
     }
     notice_change1{
         color: #0d94fd;
     }
     .big3{
         font-family:"微软雅黑";
         font-size: 22px;
         color: #494d59;
         font-weight: inherit;
     }
     .big3 a:hover{
         color: #494d59;
     }
   .bt {
         margin-left: 29%;
         background: url("../../img/confirm.png") no-repeat;
        display: inline-block;
        float: left;
        height: 30px;
        line-height: 30px;
        width: 56px;
        text-align: center;
        margin-right: 15px;
        cursor: pointer;
        padding-left: 20px;

   }
     .TableList{
         margin-top: 0px;
     }


     .TableHeader {
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
         font-size: 14px;
     }
   .determine_2{
       margin-left: 0%;
       background: url("../../img/sys/return.png") no-repeat;
       display: inline-block;
       float: left;
       height: 30px;
       line-height: 30px;
       width: 56px;
       text-align: center;
       margin-right: 15px;
       cursor: pointer;
       padding-left: 20px;
   }

    .TableHeader1 .th {
        height: 41px;
        background-color: #fff;
         font-size: 15px;
         color: #2F5C8F;
         font-weight: bold;
         border: 0px;
     }
     .TableHeader1{
         border: 1px #dddddd solid;
     }
     .TableList tbody tr:nth-child(odd) {
         background-color: #F6F7F9;
     }
     .TableList tbody tr:nth-child(even) {
         background-color: #fff;
     }
     .bodycolor{
         padding: 0;
     }
 </style>

<body class="bodycolor">

<script type="text/javascript">
    $(function() {
        init();
          })

    function  init(){
        $.ajax({
            type: "GET",
            url: "/SecureRule/getAllSecureRule",
            dataType: "json",
            success: function(data) {
                var all =data.obj;
                var length = all.length;
                str='<thead class="TableHeader1" align="center">' +
                    '<td class="th"><fmt:message code="three.th.RuleCode" /></td>'+
                    '<td class="th"><fmt:message code="workflow.th.RuleDescription" /></td>' +
                    '<td class="th"><fmt:message code="three.th.OperationAuthority" /></td>' +
                    '<td class="th" width="50"><fmt:message code="notice.th.state" /></td>' +
                    '<td class="th" width="100"><fmt:message code="notice.th.operation" /></td>' +
                    ' </thead>';
                for (var i=0;i<length;i++){
                    if (data.obj[i].useFlag==1) {
                        var str = str + '<tr class="TableHeader" align="center">' +
                            '    <td>' + data.obj[i].ruleCode + '</td>' +
                            '    <td>' + data.obj[i].ruleDesc + '</td>' +
                            '    <td>' + data.obj[i].rulePrivName + '</td>' +
                            '    <td width="50"><img src="../img/sys/correct.gif"></td>' +
                            '    <td width="100">'+'<a href="javascript:edit(' +data.obj[i].ruleId+ ');" color:#59b7fb; notifyId=' + data.obj[i].ruleId + ' class="notice_change1"><fmt:message code="depatement.th.modify" /></a>'+'</td>' +
                            '  </tr>';
                    }else{
                        var str = str + '<tr class="TableHeader" align="center">' +
                            '    <td>' + data.obj[i].ruleCode + '</td>' +
                            '    <td>' + data.obj[i].ruleDesc + '</td>' +
                            '    <td>' + data.obj[i].rulePrivName + '</td>' +
                            '    <td width="50"><img src="../img/sys/error.gif"></td>' +
                            '    <td width="100">'+'<a href="javascript:edit(' +data.obj[i].ruleId+ ');" color:#59b7fb; notifyId=' + data.obj[i].ruleId + ' class="notice_change1"><fmt:message code="depatement.th.modify" /></a>'+'</td>' +
                            '  </tr>';
                    }
                }
                $('.TableList').html(str);
            }
        })
    }
        function edit(e){
        //回显数据
           $.ajax({
               type: "GET",
               url: "/SecureRule/getSecureById",
               data:{ruleId:e},
               dataType: "json",
               success: function(data) {

                   var result=data.object;
               $('.TableList').hide();
               $('#ruleId_1').val(result.ruleId);
               $('.td_1').text(result.ruleDesc);
               $('#userpriv').val(result.rulePriv);
               $(":radio[name='USE_FLAG'][value='" + result.useFlag + "']").prop("checked", "checked");
               $('.editpage').show();


               }
           })
        }
            //修改时提交数据
            function submit(){
                var  datas={
                    ruleId:  $('#ruleId_1').val(),
                    rulePriv:  $('#userpriv').val(),
                    ruleDesc:  $('.td_1').text(),
                    useFlag: $('[name="USE_FLAG"]:checked').val()
                }
                $.ajax({
                    type: "GET",
                    url: "/SecureRule/editSecureRule",
                    data:datas,
                    dataType: "json",
                    success: function(data){
                        if(data.flag==true){
                         layer.msg('<fmt:message code="menuSSetting.th.editSuccess" />',{icon: 6});
                         init();
                            $('.editpage').hide();
                            $('.TableList').show();
                        }else{
                            layer.msg('<fmt:message code="depatement.th.modifyfailed" />',{icon: 6});
                            init();
                            $('.editpage').hide();
                            $('.TableList').show();
                        }
                    }
                })

            }

      function return_1(){
          init();
          $('.editpage').hide();
          $('.TableList').show();
      }

</script>


<table border="0" width="100%" cellspacing="0" cellpadding="3" style="margin-top: 10px;" class="small2">
  <tr>
      <td class="Big"><img src="../../img/secure.png" style="margin-left: 10px;" align="absmiddle"><span class="big3"><a name="bottom"><fmt:message code="three.th.RuleSetting" /></a></span>
    </td>
  </tr>
</table>

<br>
<table class="TableList" width="95%" align="center">

</table>

<div class="editpage" style="display:none;" topmargin="5">
    <table border="0" width="100%" cellspacing="0" cellpadding="0" class="small" style="width:40%; margin-left:25%;">

        <tr><td style="width:20%; text-align:center;"><fmt:message code="three.th.RulDetails" />：</td><td class="td_1" style="width:35%; text-align:center;"></td></tr>
        <tr><td style="width:20%; text-align:center;"><fmt:message code="three.th.RulesRoles" />：</td>
            <td  style="width:35%; text-align:center;">
                <select id="userpriv">
                    <option class="options" value="1"><fmt:message code="email.th.systemmanager" /></option>
                    <option class="options" value="2"><fmt:message code="three.th.SecurityAdministrator" /></option>
                    <option class="options" value="3"><fmt:message code="three.th.SecurityAuditor" /></option>
                </select>
            </td>
        </tr>
        <tr>
            <td style="width:20%; text-align:center;"><fmt:message code="three.th.Enable" /></td>
            <td style="width:35%; text-align:center;">
            <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="USE_FLAG" value="1" ><fmt:message code="three.th.open" />
            <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="USE_FLAG" value="0" ><fmt:message code="three.th.Disable" />
           </td>
        </tr>
        <tr><td colspan="2">
            <div class="bt determine" onclick="submit()"><fmt:message code="global.lang.ok" /></div>
            <div class="determine_2" onclick="return_1()"><fmt:message code="depatement.th.quxiao" /></div>
            <input id="ruleId_1" type="hidden" />
        </td></tr>
    </table>
</div>

</body>

</html>