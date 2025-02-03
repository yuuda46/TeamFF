<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	Integer category=(Integer)request.getAttribute("category");
%>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">

	<div class="container2">
		<c:choose>
			<c:when test="${content.size()>0}">
				<c:forEach var="content" items="${content}">
					<h1>${content.title}</h1>
					<div class="detail_flex">
					<p class="detail_font">${content.categoryName}</p>
					<p class="detail_font">🕑${content.postDay}</p>
					</div>
					<p class="detail_font">回覧物</p>
					<p class="position_center detail_font"><img src="../upload/${content.content}"></p>
					<p class="position_right detail_font">投稿者氏名<br>
					${content.name}</p>
				</c:forEach>
			</c:when>
		</c:choose>

		<form action="../notice/Notice.action">
			<input type="hidden" name="f1" value="<%=category%>">
			<button class="detail_button button_style" type="submit">戻る</button>
		</form>
	</div>

	</c:param>
</c:import>