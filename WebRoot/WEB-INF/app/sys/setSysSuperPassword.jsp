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
    <title><fmt:message code="main.usermanage" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/js/UserPriv/roleAuthorization.js"></script>

</head>
<body class="bodycolor">
     <form method="post" action="" name="form1">
          <table class="tr_td" width="400" align="center">
              <tbody>
                <tr>
                    <td class="TableData" width="25%"> <fmt:message code="url.th.OriginalPW" />:</td>
                    <td class="TableData">
                        <input type="password" name="PASS0" style="margin: 0" class="inp" size="30">
                    </td>
                </tr>
                <tr>
                    <td class="TableData" width="25%"><fmt:message code="url.th.newPW" />：</td>
                    <td class="TableData">
                        <input type="password" name="PASS1" style="margin: 0" class="inp" size="30" maxlength="20">
                    </td>
                </tr>
                <tr>
                    <td class="TableData" width="25%"><fmt:message code="url.th.Confirm" />：</td>
                    <td class="TableData">
                        <input type="password" name="PASS2" style="margin: 0" class="inp" size="30" maxlength="20">
                    </td>
                </tr>
                <tr align="centre">
                    <td class="TableData" colspan="2"  align="center">
                        <input type="button"value="<fmt:message code="global.lang.save" />" class="import" >
                    </td>
                </tr>

              </tbody>
          </table>
     </form>

</body>
<script>

    $('.import').click(function () {
        if($('[name="PASS1"]').val()!=$('[name="PASS2"]').val()){
            alert('<fmt:message code="url.th.TwoPassword" />')
            return false;
        }
        $.post('/sys/checkSuperPwd',{'password':$('[name="PASS0"]').val()},function (json) {
            if(json.flag){
                layer.alert('<fmt:message code="main.th.PasswordError" />')
            }else {
                $.post('/sys/updateSuperPwd',{'password':$('[name="PASS1"]').val()},function (json) {
                    if (json.flag){
                        $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess" />',icon:1});
                    }
                },'json')
            }
        },'json')
    })


</script>

</html>