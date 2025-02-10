<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	Integer category_id=(Integer)request.getAttribute("category_id");
%>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">

	<div class="container2">
		<c:choose>
			<c:when test="${content.size()>0}">
				<c:forEach var="content" items="${content}">
					<p class="notice_left detail_font margin_top_0">タイトル:</p>
					<p class="position_center detail_font">${content.title}</p>
					<p class="detail_font notice_line">回覧物</p>
					<p class="position_center detail_font"><img src="../upload/${content.content}"></p>
					<p class="position_center detail_font">${content.content}</p>
				</c:forEach>
			</c:when>

		</c:choose>

		<form action="../notice/NoticeAdmin.action">
			<input type="hidden" name="f1" value=<%=category_id%>>
			<button class="detail_button button_style" type="submit">戻る</button>
		</form>
	</div>

	</c:param>
</c:import>