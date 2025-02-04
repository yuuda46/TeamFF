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
	<p class="detail_font container2 detail_top">削除完了しました</p>

	<form class="position_center detail_top" action="../notice/NoticeAdmin.action" method="get">
		<button class="button_style button_size" type="submit">戻る</button>
	</form>

	</c:param>
</c:import>