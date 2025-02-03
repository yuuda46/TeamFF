<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">
	<h3 class="detail_font container2 detail_top">削除しますか</h3>

	<div class="notice_center detail_top">

		<form action="../notice/NoticeAdmin.action" method="get">
			<button class="button_style button_size right_margin" type="submit">戻る</button>
		</form>

		<form action="../notice/NoticeDelete.action" method="get">
			<input type="hidden" name="filename" value="${post_id}">
			<button class="button_style button_size margin_left_10" type="submit">削除</button>
		</form>

	</div>

	</c:param>
</c:import>