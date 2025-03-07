<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="crumb-wrap">
	<div class="crumb-list">
		<i class="icon-font"></i><a href="mainemp" color="#white"><fmt:message code="global.page.first" /></a><span
			class="crumb-step">&gt;</span><span class="crumb-name"><fmt:message code="workflow.th.sousuo" /></span>
	</div>
</div>
<div class="search-wrap">
	<div class="search-content">
		 <!-- <form action="showUser" method="post" id="getForm" name="getForm">  -->
			<div class="clearfix">
				<table class="search-tab fl">
					<tr>
						<th width="150"><fmt:message code="new.th.iTAccount" />:</th>
						<td><input  class="common-text"
							placeholder="<fmt:message code="new.th.keyword" />" name="empNo" value="${empNo}" id="empNo" type="text"></td>
					</tr>
				</table>
				<table class="search-tab fl">
					<tr>
						<th width="150"><fmt:message code="new.th.loginAccount" />:</th>
						<td><input  class="common-text"
							placeholder="<fmt:message code="new.th.keyword" />" name="login" value="${login}" id="login" type="text"></td>
					</tr>
				</table>
				<table class="search-tab fl">
					<tr>
						<th width="150"><fmt:message code="new.th.employeeName" />:</th>
						<td><input class="common-text"
							placeholder="<fmt:message code="new.th.keyword" />" name="displayName" value="${displayName}" id="displayName"
							type="text"></td>
					</tr>
				</table>
				<table class="search-tab fl">
					<tr>
						<th width="150"><fmt:message code="depatement.th.Departmentname" />:</th>
						<td><input class="common-text"
							placeholder="<fmt:message code="new.th.keyword" />" name="deptName" value="${deptName}" id="deptName"
							type="text"></td>
					</tr>
				</table>
				<table class="search-tab fl">
					<tr>
						<th width="150"><fmt:message code="new.th.userCategory" />:</th>
						<td><input class="common-text"
							placeholder="<fmt:message code="new.th.keyword" />" name=userCategory value="${userCategory}" id="userCategory"
							type="text"></td>
					</tr>
				</table>
			</div>
			<div class="tr">
				<input class="btn btn-primary mr10" id="getButton" value="<fmt:message code="global.lang.query" />" onclick="ajaxGotoPage(1);"
					type="button">
			</div>
		<!-- </form>  -->
	</div>
</div>
<div class="result-wrap">
	<h3 class="result-title-text"><fmt:message code="new.th.searchResults" /></h3>
	<!-- 模糊查询展示 -->
	<div class="result-content" id="restabb">
		<table class="details">
			<tr class="noticClsSrm">
				<th style="width: 81px;"><fmt:message code="notice.th.title" /></th>
				<th style="width: 70px;"><fmt:message code="notice.th.type" /></th>
				<th style="width: 50px;"><fmt:message code="notice.th.PostedTime" /></th>
				<th style="width: 30px;"><fmt:message code="news.th.clicks" /></th>
				<th style="width: 30px;"><fmt:message code="new.th.Comment(Article)" /></th>
				<th style="width: 100px;"><fmt:message code="news.th.newscomment" /></th>
			</tr>
			<c:forEach var="userDto" items="${userListDto}">
				<tr>
					<td align="center">${userDto.login }</td>
					<td align="center" style="cursor: pointer;">
                        <%--<input type="hidden" id = "onewShowObj" name = "onewShowObj" value="">--%>
                        <a onclick="showUserClick(${userDto.userID})">${userDto.empNo }</a></td>
					<td align="center">${userDto.displayName }</td>
					<td align="center">
					<%-- <c:if test="${userDto.sex==1 }">男</c:if> <c:if
							test="${userDto.sex==2 }">女</c:if> <c:if
							test="${userDto.sex != 1 && userDto.sex != 2 }">${userDto.sex}</c:if> --%>
							${userDto.sex }
					</td>
					<td align="center">${userDto.status }</td>
					<td align="center">${userDto.dept.deptName}</td>
					<td align="center">${userDto.titleName }</td>
					<td align="center">${userDto.postName }</td>
					<td align="center">${userDto.idCard }</td>
					<td align="center"><fmt:formatDate value="${userDto.entryDate }"
							pattern="yyyy年MM月dd日" />
							</td>
					<td align="center">${userDto.empType }</td>
					<td align="center">${userDto.mobile }</td>
					<td align="center">${userDto.postalAddress }</td> 
				</tr>
			</c:forEach>
		</table>
		<%-- <jsp:include page="../page/page_ajax.jsp" /> --%>
	</div>
	<form action="" id="passwordForm" method="post">
		<div class="showUser">
			<div class="theme-closess">
				<a href="javascript:;" title="<fmt:message code="global.lang.close" />" class="close"
					onmouseover="this.style.backgroundColor='white';"
					onmouseout="this.style.backgroundColor='';">×</a>
			</div>
			<table width="525" class="showTable">
				<tr>
					<td width="80" height="40" align="center" valign="middle"><fmt:message code="new.th.employeeNumber" /></td>
					<%--<td><input id="eNoPassword" name="eNoPassword" value=""--%>
						<%--disabled="true"--%>
						<%--style="position: absolute; left: 130px; top: 40px;" /></td>--%>
                    <td>${user.login}</td>
                    <%--${pageContext.login}--%>
				</tr>
				<tr>
					<td width="80" height="40" align="center" valign="middle"><fmt:message code="url.th.newPW" /></td>
					<td><input type="password" id="password" name="password"
						style="position: absolute; left: 130px; top: 82px;" /><span
						style="color: red;">*</span> &nbsp;&nbsp;&nbsp;&nbsp;<label
						class="error" for="password"
						style="color: red; font-size: 10px; position: absolute; left: 340px; top: 80px;"></label></td>

				</tr>
				<tr>
					<td width="80" height="40" align="center" valign="middle"><fmt:message code="url.th.Confirm" /></td>
					<td><input type="password"
						style="position: absolute; left: 130px; top: 125px;"
						id="newPassword" name="newPassword" /> <span style="color: red;">*</span>&nbsp;&nbsp;&nbsp;&nbsp;
						<label class="error" for="newPassword"
						style="color: red; font-size: 10px; position: absolute; left: 340px; top: 125px;"></label></td>
				</tr>
			</table>
			<input style="text-align: center;" type="button" value="<fmt:message code="new.th.resetPassword" />"
				onclick="passwordForm()" class="btn btn-primary mr10" />
		</div>
	</form>
</div>
<script type="text/javascript">
	//分页跳转  
	var totalsPage = '${pageEntity.totalsPage}';
	if (totalsPage == '')
		totalsPage = 1;
	function ajaxGotoPage(currentPage) {
		if (currentPage == null || currentPage == "")
			return;
		if (isNaN(currentPage))
			return;
		if (currentPage < 1 ||currentPage == 1)
			currentPage = 0;
		else if ((currentPage > totalsPage)
				|| (currentPage == "${pageEntity.currentPage}"))
			return;

		var resourceSpan = $("#resourceSpan");
		 /* alert($("#login").val()) ; */
		$.ajax({
			url : '${pageContext.request.contextPath }/showUser',
			type : 'post',
			data : {
				currentPage : currentPage,
				empNo : $("#empNo").val(),
				displayName : $("#displayName").val(),
				login : $("#login").val(),
				deptName : $("#deptName").val(),
				userCategory : $("#userCategory").val()
			},
			dataType : 'text',
			timeout : 60000,
			error : function(e) {
				alert("<fmt:message code="lang.error" />:"+e);
			},
			success : function(result) {
				resourceSpan.html(result);
			}
		});
	}
	function gotoPageByInput() {
		var currentPage = document.getElementById('goInput').value;
		ajaxGotoPage(parseInt(currentPage));
	}
</script>




