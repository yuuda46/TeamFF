<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">

	<c:choose>
		<c:when test="${content.size()>0}">
			<c:forEach var="content" items="${content}">
				<h2>${content.title}</h2>
				<p>連絡文書</p>
				<p><img src="../upload/${content.content}"></p>
				<p>投稿者氏名</p>
				<p>${content.name}</p>
				<p>投稿日</p>
				<p>${content.postDay}</p>
			</c:forEach>
		</c:when>

	</c:choose>

	<form action="../notice/Notice.action">
		<button type="submit">戻る</button>
	</form>

	</c:param>
</c:import>