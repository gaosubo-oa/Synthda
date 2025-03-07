<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table cellspacing="0" cellpadding="3" align="center" border="0"
		width="95%">
		<tbody>
			<tr>
				<td class="Big"><img src="/static/images/notify_open.gif"
					align="absmiddle"><span class="big3"><fmt:message code="news.title.new" /></span>&nbsp; <select
					name="TYPE" class="BigSelect"
					onchange="change_type(this.value,SEND_TIME.value);">
						<option value="0" selected=""><fmt:message code="news.th.type" /></option>
						<option value="01"><fmt:message code="news.th.company" /></option>
						<option value="02"><fmt:message code="news.th.media" /></option>
						<option value="03"><fmt:message code="news.th.industry" /></option>
						<option value="04"><fmt:message code="news.th.partner" /></option>
						<option value="05"><fmt:message code="news.th.client" /></option>
						<option value=""><fmt:message code="news.th.none" /></option>
				</select>&nbsp; <fmt:message code="notice.title.Releasedate" /><input name="SEND_TIME" size="12" maxlength="10"
					class="BigInput" value="" onclick="WdatePicker()" type="text">&nbsp;<input
					class="SmallButton" value="<fmt:message code="global.lang.ok" />" onclick="ajaxGotoPage(1);"
					type="button"></td>
			</tr>
		</tbody>
	</table>
	<jsp:include page="./page_ajax.jsp"/>
	<table class="TableList" align="center" width="95%">
		<tbody>
			<tr class="TableHeader">
				<td onclick="order_by('SUBJECT','1');" style="cursor: hand;"
					nowrap="" align="center"><u><fmt:message code="notice.th.title" /></u></td>
				<td nowrap="" align="center"><fmt:message code="notice.th.type" /></td>
				<td onclick="order_by('NEWS_TIME','0');" style="cursor: hand;"
					nowrap="" align="center"><u><fmt:message code="notice.th.PostedTime" /></u><img
					src="/static/images/arrow_down.gif" height="10" border="0"
					width="11"></td>
				<td onclick="order_by('CLICK_COUNT','1');" style="cursor: hand;"
					nowrap="" align="center"><u><fmt:message code="news.th.clicks" /></u></td>
				<td nowrap="" align="center"><fmt:message code="news.th.commentnew" /></td>
				<td nowrap="" align="center"><fmt:message code="news.th.newscomment" /></td>
			</tr>

			<tr class="TableLine1">
				<td><a href="javascript:open_news('6','0');"
					title="喜欢红色外观的手机？这次你又多了一个选择。3 月 21 日晚上 8 点半，苹果在官方在线商店和天猫旗舰店中「悄悄」上线了红色（RED）的 iPhone 7 和 iPhone 7 Plus，售价 6188 元起。"><font
						color="red"><b><fmt:message code="news.th.other1" /></b></font></a></td>
				<td nowrap="" align="center"></td>
				<td nowrap="" align="center">2017-03-27 14:23:28</td>
				<td nowrap="" align="center">38</td>
				<td nowrap="" align="center">0</td>
				<td nowrap="" align="center"><a href="javascript:re_news('6');"><fmt:message code="news.th.comment" /></a>
				</td>
			</tr>
			<tr class="TableLine2">
				<td><a href="javascript:open_news('5','0');"
					title="如何看待苹果公司 2017年3月21日 上架红色 iPhone 7 和新款 9.7 英寸 iPad？"><font
						color="#f00001"><fmt:message code="news.th.other3" /></font></a></td>
				<td nowrap="" align="center"></td>
				<td nowrap="" align="center">2017-03-27 14:16:51</td>
				<td nowrap="" align="center">5</td>
				<td nowrap="" align="center">0</td>
				<td nowrap="" align="center"><a href="javascript:re_news('5');"><fmt:message code="news.th.comment" /></a>
				</td>
			</tr>
			<tr class="TableLine1">
				<td><a href="javascript:open_news('4','0');" title=""><font
						color=""><fmt:message code="news.th.other4" /></font></a></td>
				<td nowrap="" align="center"></td>
				<td nowrap="" align="center">2017-02-10 00:00:00</td>
				<td nowrap="" align="center">81</td>
				<td nowrap="" align="center">0</td>
				<td nowrap="" align="center"><a href="javascript:re_news('4');"><fmt:message code="news.th.comment" /></a>
				</td>
			</tr>

		</tbody>
	</table>
	<br>
	<table class="TableBlock" align="center" width="95%">
		<tbody>
			<tr>
				<td class="TableContent" nowrap="" align="center" width="80"><b><fmt:message code="news.th.Quickoperation" />：</b></td>
				<td class="TableControl" nowrap="">&nbsp; <a
					href="javascript:read_all();" title="标记所有新闻为已读"><img
						src="/static/images/email_open.gif" align="absMiddle" border="0">
						<fmt:message code="news.th.signread" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</tbody>
	</table>



</body>
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
		if (currentPage < 1 || currentPage == 1)
			currentPage = 0;
		else if ((currentPage > totalsPage)
				|| (currentPage == "${pageEntity.currentPage}"))
			return;

		var resourceSpan = $("#resourceSpan");
		/* alert($("#login").val()) ; */
		$.ajax({
			url : '${pageContext.request.contextPath }/news/showNews',
			type : 'post',
			data : JSON.stringify({
				"News" : [ {
					"typeId" : $(".BigSelect").val(),
					"newsTime" : $("BigInput").val()
				}]

			}),
			dataType : 'json',
			timeout : 60000,
			error : function(e) {
				alert("<fmt:message code="lang.error" />:" + e);
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


</html>