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

	<c:choose>
		<c:when test="${content.size()>0}">
			<c:forEach var="content" items="${content}">
				<h1 class="notice_left">${content.title}</h1>
				<p class="position_right detail_top detail_font">投稿日<br>
				${content.postDay}</p>
				<p class="detail_font">連絡文書</p>
				<p class="position_center detail_font"><img src="../upload/${content.content}"></p>
				<p class="position_right detail_font">投稿者氏名<br>
				${content.name}</p>
			</c:forEach>
		</c:when>

	</c:choose>

	<form action="../notice/Notice.action">
		<button class="detail_button button_style" type="submit">戻る</button>
	</form>

	</c:param>
</c:import>