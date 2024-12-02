<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
<c:param name="content">
<%-- ここにコンテンツを挟む --%>
		<form action="../notice/Tokou.action" method="get">
		    <input placeholder="検索" name="searchQuery">
		    <div>
		        <button id="filter-button" type="submit">検索</button>
		    </div>

		    <c:choose>
		        <c:when test="${not empty list2}">
		            <div>件数:${list2.size()}件</div>
		            <c:forEach var="post" items="${list2}">
		                <h1><a href="../notice/ToukouNotice.action?items=${post.postId}">${post.title}</a></h1>
		                <p>${post.postDay}</p>
		                <p>${post.content}</p>
		                <hr>
		            </c:forEach>
		        </c:when>
		    </c:choose>
		</form>
</c:param>
</c:import>
