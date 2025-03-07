<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript">
   var MYOA_JS_SERVER = "";
   var MYOA_STATIC_SERVER = "";
</script>
</head>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="js/jquery/jquery.ui.autocomplete.min.js"></script>
<script src="js/module.js"></script>
<script type="text/javascript" src="js/utility.js"></script>
<script src="js/wdatepicker.js"></script>
<style>
* {
	padding: 0px;
	margin: 0px auto;
}

#user_priv:hover {
	border: 1px solid #C0BBB4;
}

.bodycolor {
	overflow: auto;
}
</style>
<script Language="JavaScript">
/* jQuery.noConflict();

function refreshPriv(){
    var user_priv_str = jQuery("#USER_PRIV0").val() + "," + jQuery("#PRIV_ID").val();
    jQuery.ajax({
        type: 'POST',
        url:'check_org.php',
        data:{
            user_priv_str: user_priv_str
        },
        async: true,
        success:function(d){
            var data = d;
            if(jQuery("#org_manage") && data.org_id!="")
            {
                jQuery("#org_manage").show();
                jQuery("#USER_MANAGE_ORGS").val(data.org_id);
                jQuery("#USER_MANAGE_ORGS_NAME").val(data.org_name);
            }
            else if(jQuery("#org_manage")){
                jQuery("#USER_MANAGE_ORGS").val('');
                jQuery("#USER_MANAGE_ORGS_NAME").val('');
                jQuery("#org_manage").hide();
            }
            jQuery("#USER_PRIV_TYPE").val(data.user_priv_type);
        }
    });
} */

/* (function($){
    $(function(){
        jQuery("[name='orgClear']").click(function(){
            var timer = null;
            timer && clearTimeout(timer);
            timer = setTimeout(refreshPriv, 300);
        });
        
        jQuery(".orgAdd").click(function(){
            if(jQuery(this).attr("name") == "orgAdd")
            {
                org_select_callbacks = {};
                org_select_callbacks.add = org_select_callbacks.remove = org_select_callbacks.clear = (function(){
                    var timer = null;
                    return function(){
                        timer && clearTimeout(timer);
                        timer = setTimeout(refreshPriv, 300);
                    }
                })();
            }
            else{
                org_select_callbacks = {};
            }
        });
    })
})(jQuery); */
/* 
function select_main_priv(id)
{
    var tt = jQuery("#USER_PRIV1").find('option:selected').text();
    jQuery("#user_priv").val(tt); 
    jQuery("#USER_PRIVS").val(id);  
} */
/* function CheckForm()
{
    if(document.form1.BYNAME.value=="")
    {
        alert("用户名不能为空！");
        return (false);
    }
    
   /*  if(document.form1.USER_PRIV.value=="")
    { 
        alert("角色不能为空！");
        return (false);
    } */
    
   /*  if(document.form1.USER_NAME.value=="")
    { 
        alert("真实姓名不能为空！");
        return (false);
    } */
    
  /*  if(document.form1.THEME.value=="")
    { 
        alert("界面主题不能为空！");
        return (false);
    }
    
    if(document.form1.EMAIL.value!="")
    {
        var emailExp = /[a-zA-Z0-9._%-]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}/;
        if(!document.form1.EMAIL.value.match(emailExp))
        {
            alert("请输入有效的E-mail地址！");
            return (false);
        }
    }
}
function change_type()
{
    if(document.form1.IS_WEBMAIL.checked)
    {
        internet1.style.display='none';
        internet2.style.display='none';
    }
    else
    {
        internet1.style.display='';
        internet2.style.display='';
    }
}
//通讯白名单按人员设置
function changeRange()
{
    if(document.getElementById("rang_user").style.display=="none")
    {
        document.getElementById("rang_user").style.display="";
        document.getElementById("rang_dept").style.display="";
        document.getElementById("href_txt").innerText="隐藏按人员、部门设置";
    }
    else
    {
        document.getElementById("rang_user").style.display="none";
        document.getElementById("rang_dept").style.display="none";
        document.getElementById("href_txt").innerText="按人员、部门设置";
    }
}
function select_dept()
{
    if(form1.POST_PRIV.value=="2")
        dept.style.display='';
    else
        dept.style.display="none";
}

function select_priv()
{
    if(priv.style.display=="none")
        priv.style.display="";
    else
        priv.style.display="none";
}
function select_dept_other()
{
    if(dept_other.style.display=="none")
        dept_other.style.display='';
    else
        dept_other.style.display="none";
} */
/* function check_user(id)
{
    if(id=="")
        return;
    
    byname_msg.innerHTML="<img src='img/loading_16.gif' align='absMiddle'> 检查中，请稍候……";
    _get("check_user.php","BYNAME="+encodeURI(id), show_msg);
}
function check_user_name(id)
{
    if(id=="")
        return;
    
    user_name_msg.innerHTML="<img src='img/loading_16.gif' align='absMiddle'> 检查中，请稍候……";
    _get("check_user.php","USER_NAME="+encodeURI(id), show_msg_name);
} */
/* function show_msg_name(req)
{
    if(req.status==200)
    {
        if(req.responseText.substring(0,3)=="+OK")
        {
            document.form1.USER_NAME.value=req.responseText.substring(3);
			user_name_msg.innerHTML=" ";
            user_name_msg.innerHTML="<img src='img/correct.gif' align='absMiddle'>";
        }
        else
        {
            user_name_msg.innerHTML="<img src='img/error.gif' align='absMiddle'> 该真实姓名已存在";
        }
    }
    else
    {
        user_name_msg.innerHTML="<img src='img/error.gif' align='absMiddle'> 错误："+req.status;
    }
}
function show_msg(req)
{
    if(req.status==200)
    {
        if(req.responseText.substring(0,3)=="+OK")
        {
            document.form1.BYNAME.value=req.responseText.substring(3);
			byname_msg.innerHTML=" ";
            byname_msg.innerHTML="<img src='img/correct.gif' align='absMiddle'>";
        }
        else
        {
            byname_msg.innerHTML="<img src='img/error.gif' align='absMiddle'> 该用户名已存在";
            document.form1.BYNAME.focus();
        }
    }
    else
    {
        byname_msg.innerHTML="<img src='img/error.gif' align='absMiddle'> 错误："+req.status;
    }
}

function check_userNo()
{
    var userNo=document.form1.USER_NO.value;
    if(!IsNumber(document.form1.USER_NO.value))
        alert("用户排序号应为数字");
    if(document.form1.USER_NO.value>65535)
        alert("用户排序号应为小于65535的数字");
}
function IsNumber(str)
{
    return str.match(/^[0-9]*$/)!=null;
} */

	function SelectPriv() {
		$.popWindow("../common/selectPrivNew");
	}
</script>

<!-- <script>
	function addUser(){
		$("#form1").form("submit",{
			url:"user/addUser",
			success:function(data){
				$.messager.alert("提示信息","添加成功","info");
				$("#addUser_div").dialog("close");
				$("#user_table").datagrid("load",{});
			}
		}); 
	}
</script> -->

<body class="bodycolor">
<body class="bodycolor" onload="document.form1.BYNAME.focus();"
	style="position:relative">
	<table border="0" width="100%" cellspacing="0" cellpadding="3"
		class="small">
		<tr>
			<td class="Big"><img src="img/notify_new.gif"
				align="absmiddle"> <span class="big3"> 新建用户（离职人员/外部人员）
			</span></td>
		</tr>
	</table>
	<table id="user_table"></table>
<div id="addUser_div">
	<form action="user/addUser" method="post" name="form1" id="form1"
		onSubmit="CheckForm();">
		<table class="TableBlock" width="95%" align="center">
			<tr>
				<td nowrap class="TableHeader" colspan="2"><img
					src="img/green_arrow.gif" align="absMiddle"> 用户基本信息</td>
			</tr>
			<tr>
				<td nowrap class="TableData" width="120">用户名：</td>
				<td nowrap class="TableData"><input type="text" name="BYNAME" id="BYNAME"
					class="BigInput" size="10" maxlength="20"
					>&nbsp;<span id="byname_msg"></span>
				</td>
			</tr>
			<tr>
				<td nowrap class="TableData">真实姓名：</td>
				<td nowrap class="TableData"><input type="text"
					name="USER_NAME" class="BigInput" size="10" maxlength="30" id="USER_NAME"
					>&nbsp;<span
					id="user_name_msg"></span></td>
			</tr>
			<tr>
				<td nowrap class="TableData">主角色：</td>
				<td nowrap class="TableData"><span style="position: relative;">
						<input type="hidden" name="USER_PRIV" id="USER_PRIV0" value="">
						<input type="text" name="PRIV_NAME0" class="BigInput" value=""
						style="width: 230px;" readonly> <a href="javascript:;"
						class="orgAdd" name="orgAdd"
						onClick="SelectPrivSingle('','USER_PRIV','PRIV_NAME0','1','','33')">添加</a>
						<a href="javascript:;" class="orgClear" name="orgClear"
						onClick="ClearUser('USER_PRIV', 'PRIV_NAME0')">清空</a> </span>&nbsp;&nbsp;
					<a href="javascript:select_priv()">指定辅助角色</a></td>
			</tr>
			<tr id="priv" style="display:none;">
				<td nowrap class="TableData">辅助角色：</td>
				<td class="TableData"><input type="hidden" name="PRIV_ID"
					id="PRIV_ID" value=""> <textarea cols=30 name="PRIV_NAME"
						rows=2 class="BigStatic" wrap="yes" readonly></textarea> <a
					href="javascript:;" class="orgAdd" name="orgAdd"
					onClick="SelectPriv('','','','1','','33')">添加</a> <a
					href="javascript:;" class="orgClear" name="orgClear"
					onClick="ClearUser('PRIV_ID', 'PRIV_NAME')">清空</a> <br>辅助角色仅用于扩展主角色的模块权限
				</td>
			</tr>

			<tr>
				<td nowrap class="TableData">部门：</td>
				<td nowrap class="TableData">
				</td>
			</tr>
			<tr id="dept_other" style="display:none;">
				<td nowrap class="TableData">所属部门：</td>
				<td class="TableData"><input type="hidden" name="DEPT_ID_OTHER"
					value=""> <textarea cols=30 name="DEPT_NAME_OTHER" rows=2
						class="BigStatic" wrap="yes" readonly></textarea> <a
					href="javascript:;" class="orgAdd"
					onClick="SelectDept('2','DEPT_ID_OTHER','DEPT_NAME_OTHER','1')">选择</a>
					<a href="javascript:;" class="orgClear"
					onClick="ClearUser('DEPT_ID_OTHER','DEPT_NAME_OTHER')">清空</a></td>
			</tr>
			<tr>
				<td nowrap class="TableData">用户排序号：</td>
				<td nowrap class="TableData"><input type="text" name="USER_NO"
					class="BigInput" size="10" value="10" onBlur="check_userNo();">&nbsp;
					用于同角色用户的排序，不能是大于65535的数字</td>
			</tr>
			<tr>
				<td nowrap class="TableHeader" colspan="2"><img
					src="img/green_arrow.gif" align="absMiddle"> 用户权限信息</td>
			</tr>
			<tr>
				<td nowrap class="TableData" width="120">管理范围：</td>
				<td nowrap class="TableData"><select name="POST_PRIV"
					class="BigSelect" OnChange="select_dept()">
						<option value="0">本部门</option>
						<option value="1">全体</option>
						<option value="2">指定部门</option>
				</select> 在管理型模块中起约束作用</td>
			</tr>
			<tr id="dept" style="display:none;">
				<td nowrap class="TableData">管理范围（部门）：</td>
				<td class="TableData"><input type="hidden" name="TO_ID"
					value=""> <textarea cols=30 name="TO_NAME" rows=2
						class="BigStatic" wrap="yes" readonly></textarea>&nbsp; <input
					type="button" value="选择" class="SmallButton"
					onClick="SelectDept('','','','1')" title="选择部门" name="button">&nbsp;
					<input type="button" value="清空" class="SmallButton"
					onClick="ClearUser()" title="清空部门" name="button"></td>
			</tr>
			<tr>
				<td nowrap class="TableData">访问控制 ：</td>
				<td nowrap class="TableData"><input type="checkbox"
					name="NOT_VIEW_USER" id="NOT_VIEW_USER"><label
					for="NOT_VIEW_USER">禁止查看用户列表</label>&nbsp; <input type="checkbox"
					name="NOT_VIEW_TABLE" id="NOT_VIEW_TABLE"><label
					for="NOT_VIEW_TABLE">禁止显示桌面</label> <input type="checkbox"
					name="USEING_KEY" id="USEING_KEY" disabled><label
					for="USEING_KEY">使用USB KEY登录</label> <input type="checkbox"
					name="USING_FINGER" id="USING_FINGER"><label
					for="USING_FINGER">使用指纹验证</label><br /> <input type="radio"
					name="NOT_LOGIN" id="NOT_LOGIN_0" value="0" checked><label
					for="NOT_LOGIN_0">允许登录OA系统</label> <input type="radio"
					name="NOT_LOGIN" id="NOT_LOGIN_1" value="1"><label
					for="NOT_LOGIN_1">禁止登录OA系统</label> <input type="radio"
					name="NOT_MOBILE_LOGIN" id="NOT_MOBILE_LOGIN_0" value="0" checked><label
					for="NOT_MOBILE_LOGIN_0">允许登录手机客户端（不受OA用户数限制）</label> <input
					type="radio" name="NOT_MOBILE_LOGIN" id="NOT_MOBILE_LOGIN_1"
					value="1"><label for="NOT_MOBILE_LOGIN_1">禁止登录手机客户端</label>
				</td>
			</tr>
			<tr>
				<td nowrap class="TableData" width="120">即时通讯使用权限：</td>
				<td nowrap class="TableData"><select name="IM_RANGE"
					class="BigSelect">
						<option value="1">允许使用</option>
						<option value="2">禁止使用</option>
				</select></td>
			</tr>
			<tr>
				<td nowrap class="TableData">通讯白名单：<br>按角色设置<br>
				<a href="javascript:;" id="href_txt" onClick="changeRange();">按人员设置</a>
				</td>
				<td class="TableData"><input type="hidden" name="PRIV_ID1"
					value=""> <textarea cols=40 name="PRIV_NAME1" rows=2
						class="BigStatic" wrap="yes" readonly></textarea> <a
					href="javascript:;" class="orgAdd"
					onClick="SelectPriv('','PRIV_ID1','PRIV_NAME1','1','','33')">添加</a>
					<a href="javascript:;" class="orgClear"
					onClick="ClearUser('PRIV_ID1', 'PRIV_NAME1')">清空</a><br>
					属于以上所选角色的人员可以给此用户发送邮件和微讯，<b>角色和人员设置均为空则不限制</b></td>
			</tr>
			<tr id="rang_user" style="display:none">
				<td nowrap class="TableData">通讯白名单：<br>按人员设置</td>
				<td class="TableData"><input type="hidden" name="USER_ID1"
					value=""> <textarea cols=40 name="USER_NAME1" rows=2
						class="BigStatic" wrap="yes" readonly></textarea> <a
					href="javascript:;" class="orgAdd"
					onClick="SelectUser('','5','USER_ID1', 'USER_NAME1')">添加</a> <a
					href="javascript:;" class="orgClear"
					onClick="ClearUser('USER_ID1', 'USER_NAME1')">清空</a><br>
					属于以上所选人员可以给此用户发送邮件和微讯，<b>角色和人员设置均为空则不限制</b></td>
			</tr>
			<tr id="rang_dept" style="display:none">
				<td nowrap class="TableData">通讯白名单：<br>按部门设置</td>
				<td class="TableData"><input type="hidden" name="DEPT_ID_MSG"
					value=""> <textarea cols=40 name="DEPT_NAME_MSG" rows=2
						class="BigStatic" wrap="yes" readonly></textarea> <a
					href="javascript:;" class="orgAdd"
					onClick="SelectDept('','DEPT_ID_MSG', 'DEPT_NAME_MSG','1')">添加</a>
					<a href="javascript:;" class="orgClear"
					onClick="ClearUser('DEPT_ID_MSG', 'DEPT_NAME_MSG')">清空</a><br>
					属于以上所选部门可以给此用户发送邮件和微讯，<b>角色、人员和部门设置均为空则不限制</b></td>
			</tr>
			<tr
				onClick="if(option1.style.display=='none') option1.style.display=''; else option1.style.display='none';"
				title="点击展开/收缩选项">
				<td nowrap class="TableHeader" colspan="2" style="cursor:pointer;"><img
					src="img/green_arrow.gif" align="absMiddle"> 其它选项</td>
			</tr>
			<tbody id="option1" style="display:none;">
				<tr>
					<td nowrap class="TableData">考勤排班类型：</td>
					<td nowrap class="TableData"><select name="DUTY_TYPE"
						class="BigSelect">
							<option value="1">正常班</option>
							<option value="2">全日班</option>
							<option value="99">轮班制</option>
					</select></td>
				</tr>
				<tr>
					<td nowrap class="TableData">内部邮箱容量：</td>
					<td nowrap class="TableData"><input type="text"
						name="EMAIL_CAPACITY" class="BigInput" size="5" maxlength="11"
						value="500">&nbsp;MB 为空则表示不限制大小</td>
				</tr>
				<tr>
					<td nowrap class="TableData">个人文件柜容量：</td>
					<td nowrap class="TableData"><input type="text"
						name="FOLDER_CAPACITY" class="BigInput" size="5" maxlength="11"
						value="500">&nbsp;MB 为空则表示不限制大小</td>
				</tr>
				<tr>
					<td nowrap class="TableData">是否启用POP3功能：</td>
					<td nowrap class="TableData"><input type="checkbox"
						name="USE_POP3" id="USE_POP3"><label for="USE_POP3">是</label>
					</td>
				</tr>
				<tr>
					<td nowrap class="TableData">是否启用邮件发送限制：</td>
					<td nowrap class="TableData"><input type="checkbox"
						name="USE_EMAIL" id="USE_EMAIL"><label for="USE_EMAIL">是</label>&nbsp;开启后将会限制内部收件人数一次最多20人
					</td>
				</tr>
				<tr>
					<td nowrap class="TableData">禁用Internet邮箱：</td>
					<td nowrap class="TableData"><input type="checkbox"
						name="IS_WEBMAIL" id="IS_WEBMAIL" onClick="change_type()"><label
						for="IS_WEBMAIL">禁止使用Internet邮件功能</label></td>
				</tr>
				<tr id="internet1">
					<td nowrap class="TableData">Internet邮箱数量：</td>
					<td nowrap class="TableData"><input type="text"
						name="WEBMAIL_NUM" class="BigInput" size="5" maxlength="11"
						value="">&nbsp;个 为空则表示不限制数量</td>
				</tr>
				<tr id="internet2">
					<td nowrap class="TableData">每个Internet邮箱容量：</td>
					<td nowrap class="TableData"><input type="text"
						name="WEBMAIL_CAPACITY" class="BigInput" size="5" maxlength="11"
						value="">&nbsp;MB 为空则表示不限制大小</td>
				</tr>
				<tr>
					<td nowrap class="TableData">绑定IP地址：</td>
					<td nowrap class="TableData"><textarea name="BIND_IP"
							class="BigInput" cols="50" rows="2"></textarea><br>
						为空则该用户不绑定固定的IP地址，绑定多个IP地址用英文逗号(,)隔开<br>也可以绑定IP段，如“192.168.0.60,192.168.0.100-192.168.0.200”<br>表示192.168.0.60或192.168.0.100到192.168.0.200这个范围内都可以登录
					</td>
				</tr>
				<tr>
					<td nowrap class="TableData">备注：</td>
					<td nowrap class="TableData"><textarea name="REMARK"
							class="BigInput" cols="50" rows="2"></textarea></td>
				</tr>
			</tbody>
			<tr
				onClick="if(option2.style.display=='none') option2.style.display=''; else option2.style.display='none';"
				title="点击展开/收缩选项">
				<td nowrap class="TableHeader" colspan="2" style="cursor:pointer;"><img
					src="img/green_arrow.gif" align="absMiddle"> 用户可自定义选项</td>
			</tr>
			<tbody id="option2" style="display:none;">
				<tr>
					<td nowrap class="TableData">密码：</td>
					<td nowrap class="TableData"><input type="password"
						name="PASSWORD" class="BigInput" size="20" maxlength="20">
						8-20位，必须同时包含字母和数字</td>
				</tr>
				<tr>
					<td nowrap class="TableData">性别：</td>
					<td nowrap class="TableData"><select name="SEX"
						class="BigSelect">
							<option value="0">男</option>
							<option value="1">女</option>
					</select></td>
				</tr>
				<tr>
					<td nowrap class="TableData">生日：</td>
					<td nowrap class="TableData"><input type="text"
						name="BIRTHDAY" size="10" maxlength="10" class="BigInput"
						onClick="WdatePicker()" />&nbsp;&nbsp; <input type="checkbox"
						name="IS_LUNAR" id="IS_LUNAR"><label for="IS_LUNAR">是农历生日</label>
					</td>
				</tr>
				<tr>
					<td nowrap class="TableData">界面主题：</td>
					<td class="TableData"><select name="THEME" class="BigSelect">
							<option value="1">2008版经典主题：儒雅深沉</option>
							<option value="2">2008版经典主题：清新怡然</option>
							<option value="9">2009版经典主题：生命与自然之美</option>
							<option value="10">2010版梦幻灵动主题：宁静的思考</option>
							<option value="13">2013版梦幻灵动主题：现代或未来</option>
							<option value="15" selected>2015版梦幻灵动主题：T-OS</option>
					</select></td>
				</tr>
				<tr>
					<td nowrap class="TableData">手机：</td>
					<td class="TableData"><input type="text" name="MOBIL_NO"
						size="16" maxlength="23" class="BigInput" value=""> <input
						type="checkbox" name="MOBIL_NO_HIDDEN" id="MOBIL_NO_HIDDEN"><label
						for="MOBIL_NO_HIDDEN">手机号码不公开</label><br>
						填写后可接收OA系统发送的手机短信，手机号码不公开仍可接收短信</td>
				</tr>
				<tr>
					<td nowrap class="TableData">电子邮件：</td>
					<td class="TableData"><input type="text" name="EMAIL"
						size="25" maxlength="50" class="BigInput" value=""></td>
				</tr>
				<tr>
					<td nowrap class="TableData">工作电话：</td>
					<td class="TableData"><input type="text" name="TEL_NO_DEPT"
						size="16" maxlength="23" class="BigInput" value=""></td>
				</tr>
			</tbody>
			<tr>
				<td nowrap class="TableControl" colspan="2" align="center"><input
					type="hidden" value="" name="USER_PRIV_TYPE" id="USER_PRIV_TYPE">
					<input type="submit" value="新建" class="BigButton" title="新建用户"
					name="button">&nbsp;&nbsp; <input type="button" value="关闭"
					class="BigButton" title="关闭窗口" onClick="window.close();"></td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>