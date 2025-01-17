<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">
	<h3>削除しますか</h3>

	<form action="../notice/NoticeDelete.action" method="get">
		<input type="hidden" name="filename" value="${post_id}">
		<button type="submit">削除</button>
	</form>

	<form action="../notice/NoticeAdmin.action" method="get">
		<button type="submit">戻る</button>
	</form>

	</c:param>
</c:import>