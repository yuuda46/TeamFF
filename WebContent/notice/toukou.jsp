<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<c:import url="/common/base.jsp">
<style>
	.cont {
	　color: red !important;
	  width: 300px !important;
	  overflow: hidden !important;
	  display: -webkit-box !important;
	  text-overflow: ellipsis !important;
	  -webkit-box-orient: vertical !important;
	  -webkit-line-clamp: 3 !important;
	  /* ブラウザがサポートしていない場合のフェールセーフ */
	  max-height: 24px !important;
	}
</style>



	<c:param name="content">
	<%-- ここにコンテンツを挟む --%>

		<form action="../notice/Tokou.action" method="get">
		<c:choose>
	        <c:when test="${not empty list2}">
	            <div>件数:${list2.size()}件</div>
	            <c:forEach var="post" items="${list2}">
	                <h1><a href="../notice/ToukouNotice.action?items=${post.postId}">${post.title}</a></h1>
	                <p>${post.postDay}</p>
	                <p>${post.Name}</p>
	                <p class="cont">${post.content}</p>
	                <hr>

	            </c:forEach>
	        </c:when>
	    </c:choose>
		</form>
	</c:param>
</c:import>
