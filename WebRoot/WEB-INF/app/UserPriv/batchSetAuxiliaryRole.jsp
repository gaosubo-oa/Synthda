<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/7/10
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><fmt:message code="user.th.AddRoles"/></title>
	<link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">

	<style>
		.TableData input {
			vertical-align: middle;
		}
	</style>
	<script src="/js/common/language.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
	<script src="/js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>

	<script src="/js/UserPriv/theAuxiliaryRole.js?20200716"></script>
</head>
<body>
<div class="navigation clearfix">
	<div class="left">
		<img src="../img/icon_addrole_06.png" alt="">
		<div class="news">辅助角色批量设置</div>
	</div>
</div>
<table class="tr_td" width="560" align="center">
	<tbody>
	<tr class="TableData">
		<td nowrap="" width="80"><fmt:message code="notice.th.operation"/>：</td>
		<td>
			<input type="radio" name="OPERATION" value="1" id="OPERATION0" checked=""><label for="OPERATION0"><fmt:message code="user.th.AddRoles"/></label>
			<input type="radio" name="OPERATION" value="0" id="OPERATION1"><label for="OPERATION1"><fmt:message code="sys.th.delRole"/></label>
		</td>
	</tr>
	<tr>
		<td nowrap="" class="TableData"><fmt:message code="diary.th.body"/>：</td>
		<td class="TableData">
			<input type="hidden" name="TO_ID" value="">
			<textarea cols="50" name="TO_NAME" rows="4" id="BigStatic" class="BigStatic" wrap="yes"
					  readonly=""></textarea>
			<a href="javascript:;" class="orgAdd"><fmt:message code="global.lang.add"/></a>
			<a href="javascript:;" class="orgClear"><fmt:message code="global.lang.empty"/></a>
		</td>
	</tr>
	<tr class="TableData">
		<td nowrap=""><fmt:message code="userManagement.th.role"/>：</td>
		<td class="tadata">
			<label for="USER_PRIV19"><input type="checkbox" name="USER_PRIV" value="19" id="USER_PRIV19">aa</label>&nbsp;
			<label for="USER_PRIV19"><input type="checkbox" name="USER_PRIV" value="19" id="USER_PRIV19">aa</label>&nbsp;
			<label for="USER_PRIV19"><input type="checkbox" name="USER_PRIV" value="19" id="USER_PRIV19">aa</label>&nbsp;
		</td>
	</tr>
	<tr class="TableControl">
		<td colspan="2" align="center">
			<input type="button" value='<fmt:message code="global.lang.ok" />' class="importBtn">
		</td>
	</tr>
	<input type="hidden" name="USER_PRIV_STR" value="">
	<input type="hidden" name="DEPT_ID" value="">

	</tbody>
</table>
<p style="width: 565px;margin: 20px auto;color: red"><fmt:message code="sys.th.toplis"/></p>
<script>
    //选择分级机构下部门
    var classDept = '';
    buildDeptTree();
    function buildDeptTree(){
        $.ajax({
            url: '/hierarchical/getClassifyOrgByAdmin',
            type: 'get',
            dataType: "JSON",
            data: '',
            success: function (obj) {
                buildChild(obj.obj);
            }
        })
    }
    function buildChild(data){
        data.forEach(function(v,i){
            if(v.child && v.child.length>0){
                classDept+=v.deptId+',';
            }
        });
    }

    $('.importBtn').click(function () {
        var obj = {};
        obj.sign = $('[name="OPERATION"]:checked').val();
        obj.funcIds = ''
        $('[name="chesk"]:checked').each(function (i, n) {
            obj.funcIds += $(this).val() + ','
        })
        obj.userId = $('textarea').attr('user_id')
        $.post('/user/updateUserFunByUserId', obj, function (json) {
            if (json.flag) {
                $.layerMsg({content: menuSSetting_th_editSuccess, icon: 1}, function () {
                    // parent.newjump('')
                    location.href = 'batchSetAuxiliaryRole'
                })
            }
        }, 'json')
    })
</script>
</body>
</html>
