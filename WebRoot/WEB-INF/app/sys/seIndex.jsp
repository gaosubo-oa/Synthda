<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<style>
    body{
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        font-size: 14px;
    }
    a{
        font-weight: inherit;
    }
    .bottom{
        font-family:"微软雅黑";
        font-size: 22px;
        color: #494d59;
        font-weight:inherit;
    }
    .big3{
        font-family:"微软雅黑";
        font-size: 22px;
        color: #494d59;
        font-weight: inherit;
    }
    .bt {
        margin-left: 46%;
        background: url("../../img/confirm.png") no-repeat;
        display: inline-block;
        float: left;
        height: 30px;
        line-height: 30px;
        width: 56px;
        text-align: center;
        margin-right: 15px;
        margin-top: 3px;
        cursor: pointer;
        padding-left: 20px;
    }
    .TableBlock tr{
        height: 40px;
    }
    .small{
        border-collapse: inherit;
    }

</style>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">



    <title><fmt:message code="roleAuthorization.th.RoleSettings" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
   <%-- <script type="text/javascript" src="../js/sys/module.js?v=150805"></script>
     <script type="text/javascript" src="../js/sys/utility.js"></script>
    [if lte IE 8]>
   <script type="text/javascript" src="/static/js/ccorrect_btn.js"></script>
    <![endif]-->--%>
</head>

<body>

<div id="hiddenMain">

<form  name="form1" onsubmit="return check_form();">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
  <tr>
      <td class="Big"><img src="../../img/secure.png" align="absmiddle"><span class="big3" style="font-weight: inherit"> <a name="bottom" class="bottom"><fmt:message code="three.th.ThreeSettings" /></a></span>
    </td>
  </tr>
</table>
<table class="TableBlock" width="65%" align="center">
  <tr>
    <td class="TableContent" width="30%"><fmt:message code="three.th.MemberSettings" /></td>
    <td class="TableData" width="70%">

      <input type="radio" name="SWITCH" value=1 id="switch_on" onclick="showsetting()" ><label for="switch_on"><fmt:message code="three.th.open" /></label>
      <input type="radio" name="SWITCH" value=0 id="switch_off"  onclick="hidesetting()"  checked ><label for="switch_off"><fmt:message code="three.th.Disable" /></label>
	&nbsp;&nbsp;&nbsp;&nbsp;<a href="setSuperPwd"><fmt:message code="three.th.ThreeSuperSettings" /></a>
    </td>
  </tr>
  <tr id="hide1">
    <td class="TableContent"><fmt:message code="email.th.systemmanager" /></td>
    <td class="TableData">
        <div class="inPole"><textarea name="adminuserSd" id="adminuserSd" user_id="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectadminuserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearadminuserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div>
    </td>
  </tr>
  <tr id="hide2">
    <td class="TableContent"><fmt:message code="three.th.SecurityAdministrator" /></td>
    <td class="TableData">
        <div class="inPole"><textarea name="safeuserSd" id="safeuserSd" user_id="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectsafeuserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearsafeuserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div>
    </td>
  </tr>
  <tr id="hide3">
    <td class="TableContent"><fmt:message code="three.th.SecurityAuditor" /></td>
    <td class="TableData">
        <div class="inPole"><textarea name="audituserSd" id="audituserSd" user_id="" value="" disabled style="min-width: 250px;min-height:50px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectaudituserSd" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearaudituserSd" class="clearUserSd "><fmt:message code="global.lang.empty" /></a></span></div>
      </td>
  </tr>
  <tr id="hide4">
    <td class="TableContent"><fmt:message code="three.th.Default" /></td>
    <td class="TableData">
    <select name="USER_PRIV" id="USER_PRIV" class="BigSelect">
        <option value="20" selected>11</option>
        
    </select>
      </td>
  </tr>
  <tr id="hidden_6">
	<td class="TableContent" width="30%"><fmt:message code="three.th.EnableSettings" /></td>
    <td class="TableData" width="70%">
		<input type="radio" name="EMAIL_AUDIT_OPTION" onclick="change_audit_info(1)" id="EMAIL_AUDIT_OPTION1" value="1" ><label for="EMAIL_AUDIT_OPTION1"><fmt:message code="three.th.open" /></label>
		<input type="radio" name="EMAIL_AUDIT_OPTION" onclick="change_audit_info(0)" id="EMAIL_AUDIT_OPTION0" value="0" checked><label for="EMAIL_AUDIT_OPTION0"><fmt:message code="three.th.Disable" /></label>
		<input type="hidden" name="EMAIL_AUDIT_OPTION_OLD" value=""/>
      </td>
  </tr>
	<tr id="hidden_7">
		<td nowrap class="TableContent"><fmt:message code="three.th.Specify" /></td>
		<td class="TableData">
			<input type="hidden" name="EMAIL_FREE_AUDIT_MAN" value="">
			<textarea cols=40 name="EMAIL_FREE_AUDIT_MAN_NAME" rows="7" class="BigStatic" wrap="yes" readonly></textarea>
			<a href="javascript:;" class="orgAdd" onClick="SelectUser('','','EMAIL_FREE_AUDIT_MAN', 'EMAIL_FREE_AUDIT_MAN_NAME')"><fmt:message code="global.lang.add" /></a>
			<a href="javascript:;" class="orgClear" onClick="ClearUser('EMAIL_FREE_AUDIT_MAN', 'EMAIL_FREE_AUDIT_MAN_NAME')"><fmt:message code="global.lang.empty" /></a>
			<input type="hidden" name="EMAIL_FREE_AUDIT_MAN_OLD" value="">
		</td>
	</tr>
  <tr class="TableControl" align="center">
    <td colspan=2 >
        <div class="bt determine" onclick="check_form()"><fmt:message code="global.lang.ok" /></div>
      </td>
  </tr>

</table>
</form>
</div>
<br>
</body>
<script type="text/javascript">
    var user_id;
$(function(){
    //选人控件
    $("#selectadminuserSd").on("click",function(){
        user_id='adminuserSd';
        $.popWindow("../common/selectUser");
    });
})


    $('#clearadminuserSd').click(function(){ //清空人员
        $('#adminuserSd').attr('user_id','');
        $('#adminuserSd').attr('dataid','');
        $('#adminuserSd').val('');
    });
    $("#selectsafeuserSd").on("click",function(){
        user_id='safeuserSd';
        $.popWindow("../common/selectUser");
    });

    $('#clearsafeuserSd').click(function(){ //清空人员
        $('#safeuserSd').attr('user_id','');
        $('#safeuserSd').attr('dataid','');
        $('#safeuserSd').val('');
    });
    $("#selectaudituserSd").on("click",function(){
        user_id='audituserSd';
        $.popWindow("../common/selectUser");
    });

    $('#clearaudituserSd').click(function(){ //清空人员
        $('#audituserSd').attr('user_id','');
        $('#audituserSd').attr('dataid','');
        $('#audituserSd').val('');
    });


    $(function()
    {
        $.ajax({
            type: "get",
            url: "/sys/checkSy",
            dataType: 'JSON',
            success: function (data) {
                var res=data.attributes;
                var s = res["switch"];
                if (s==1){
                    $("#switch_on").attr("checked","checked");
                    showsetting();
                }

            }
        });


        hidesetting();
    });
function showsetting()
{
    var swith="";
    var syserId="";
    var syserName="";
    var saferId="";
    var saferName="";
    var auditorId="";
    var auditorName="";
    var userPriv="";

    $.ajax({
        type: "get",
        url: "/sys/checkSy",
        dataType: 'JSON',
        success: function (data) {
            var res=data.attributes;
            userPriv=res.userPriv;
            for(var i=0;i<res.syser.length;i++){
                syserId+=res.syser[i].uid+",";
                syserName+=res.syser[i].userName+",";
            }
            $('[name="adminuserSd"]').attr("user_id", syserId);
            $('[name="adminuserSd"]').val(syserName);
           for(var i=0;i<res.safer.length;i++){
                saferId+=res.safer[i].uid+",";
                saferName+=res.safer[i].userName+",";
            }
            $('[name="safeuserSd"]').attr("user_id", saferId);
            $('[name="safeuserSd"]').val(saferName);
            for(var i=0;i<res.auditor.length;i++){
                auditorId+=res.auditor[i].uid+",";
                auditorName+=res.auditor[i].userName+",";
            }
            $('[name="audituserSd"]').attr("user_id", auditorId);
            $('[name="audituserSd"]').val(auditorName);
            $('#USER_PRIV').val(userPriv);

        }
    })

   $("#hide1").show();
   $("#hide2").show();
   $("#hide3").show();
   $("#hide4").show();
}
function hidesetting()
{
   $("#hide1").hide();
   $("#hide2").hide();
   $("#hide3").hide();
   $("#hide4").hide();
   $("#EMAIL_AUDIT_OPTION0").attr("checked", true);
   change_audit_info(0);
}
/*$("#switch_on").live("click", function(){
	$("#EMAIL_AUDIT_OPTION1").attr("checked", true);
	change_audit_info(1);
});*/
/*$("#switch_off").live("click", function(){
	$("#EMAIL_AUDIT_OPTION0").attr("checked", true);
	change_audit_info(0);
});*/
$("#TableBlock").delegate("#switch_on","click",function(){
    $("#EMAIL_AUDIT_OPTION1").attr("checked", true);
    change_audit_info(1);
});
$("#TableBlock").delegate("#switch_off","click",function(){
    $("#EMAIL_AUDIT_OPTION0").attr("checked", true);
    change_audit_info(0);
});
function change_audit_info(audit_type){
	if(audit_type == 1){
		if($("#switch_off").attr("checked")){
			alert("<fmt:message code="three.th.TurnedOn" />！");
			$("#EMAIL_AUDIT_OPTION0").attr("checked", true);
			return false;
		}
		$("#hidden_7").show();
	}else{
		$("#hidden_7").hide();
	}
}
function  check_form() {
    if($('#switch_on').is(':checked')) {
        var SYSER = $("textarea[name='adminuserSd']").val();
        var SASFER = $("textarea[name='safeuserSd']").val();
        var AUDITOR = $("textarea[name='audituserSd']").val();
        if (SYSER == "" || SASFER == "" || AUDITOR == "") {
            alert("<fmt:message code="dem.th.ThreeEmpty" />！");
        } else {
            var s = SYSER + SASFER + AUDITOR.slice(0, AUDITOR.length - 1);
            var ary = s.split(",");
            if (isRepeat(ary) == true) {
                submit();
            } else {
                alert("<fmt:message code="three.th.differentPeople" />！");
            }
        }
    }else {
        submit();
    }
}
function isRepeat(arr){
     for (var i=0;i<arr.length;i++){
         if (arr.indexOf(arr[i]) != arr.lastIndexOf(arr[i])){
             return false;
         }
     }
     return true;
}

    function check_secure_user(NAME_STR)
{
   var NAME_STR_ARR = NAME_STR.split(",");
   var flag;
   for(var I=0;I<NAME_STR_ARR.length;I++)
   {
      if(NAME_STR_ARR[I] == '') continue;
      for(var J=(I+1);J < NAME_STR_ARR.length;J++)
      {
        if(NAME_STR_ARR[J] == '') continue;

        flag = check_s(NAME_STR_ARR[I],NAME_STR_ARR[J]);
        if(flag == false)
         return false;
      }

   }
}
function check_s(A,B)
{
      var STR1 = $("[name="+A+"]").val();
      var STR2 = $("[name="+B+"]").val();
      var flag;

      var STR1_ARR = STR1.split(",");
      var STR2_ARR = STR2.split(",");
      for(var I=0;I<STR1_ARR.length;I++)
      {
         if(STR1_ARR[I] == '') continue;
         for(var J=0;J<STR2_ARR.length;J++)
         {
           if(STR2_ARR[J] == '') continue;
           if(STR1_ARR[I]==STR2_ARR[J])
           {
            alert("<fmt:message code="three.th.differentPeople" />！");
            flag = false;
           }
           if(flag == false)
            return false;

         }

      }
}
change_audit_info();


function submit(){

 /* var SYSER = $("textarea[name='adminuserSd']").val();
    var SASFER = $("textarea[name='safeuserSd']").val();
    var AUDITOR = $("textarea[name='audituserSd']").val();
    var s = SYSER+SASFER+AUDITOR;
    if(check_secure_user(s) == false)
    {
        layer.msg('设置失败',{icon: 2});
        return false;
    }*/
    var datas={
         swith:$('[name="SWITCH"]:checked').val(),
         syser:$('[name="adminuserSd"]').attr("dataid"),
         safer:$('[name="safeuserSd"]').attr("dataid"),
         auditor:$('[name="audituserSd"]').attr("dataid"),
        userPriv:$('#USER_PRIV').val()
     }
    $.ajax({
        type: "get",
        url: "/sys/savesy",
        dataType: 'JSON',
        data: datas,
        success: function (data) {
            if(data.flag==true){
                layer.msg('<fmt:message code="three.th.SetSuccessfully" />',{icon: 6});
            }else{
                layer.msg('<fmt:message code="three.th.SetupFailed" />',{icon: 2});
            }
        }
    })
}
</script>


</html>