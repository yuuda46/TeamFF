<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">
	<form action="../notice/Notice.action" method="get">
	<div>
		<label for="post-f1-select">カテゴリー</label><br>
		<select required id="notice-f1-select" name="f1">
			<option value=0>----------</option>
			<c:forEach var="select_list" items="${select_list}">
				<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
			</c:forEach>
		</select>
	</div>

	<div>
		<button id="filter-button">絞り込み</button>
	</div>

	<c:choose>
		<c:when test="${notice_content.size()>0}">
			<div>件数:${notice_content.size()}件</div>
			<c:forEach var="notice_content" items="${notice_content}">
				<h2><a href="../notice/NoticeDetail.action?id=${notice_content.postId}">${notice_content.title}</a></h2>
				<p>${notice_content.postDay}</p>
				<p></p>
			</c:forEach>
		</c:when>
	</c:choose>

	</form>

	</c:param>
</c:import>