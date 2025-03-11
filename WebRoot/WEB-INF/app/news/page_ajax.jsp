<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="yk-pager">
	<a href="javascript:ajaxGotoPage(1);">首页</a> <a
		href="javascript:ajaxGotoPage(${pageEntity.currentPage-1});"> ◄上一页</a>
	<a href="javascript:ajaxGotoPage(${pageEntity.currentPage+1});">
		下一页► </a> <a href="javascript:ajaxGotoPage(${pageEntity.totalsPage });">
		末页</a> 总${pageEntity.totalsCount }条，第${pageEntity.currentPage}/${pageEntity.totalsPage }页，到第<input
		size=2 id="goInput" value='' />页, <input type="button"
		class="goButton" onclick="gotoPageByInput();" value="跳转"/>
</div>
