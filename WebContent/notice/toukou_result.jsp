<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String title=(String)request.getAttribute("title");
	String name=(String)request.getAttribute("name");
	String content=(String)request.getAttribute("content");
%>

<link rel="stylesheet" href="../css/notice.css">
<c:import url="/common/base.jsp">
	<c:param name="content">
		<div class="container">
		<h2>投稿結果</h2>

        <!-- エラーがあった場合の表示 -->
        <c:if test="${not empty errorMessage}">
            <div style="color: red;">
                <p>${errorMessage}</p>
            </div>
        </c:if>

        <!-- 投稿が正常に完了した場合の表示 -->
        <c:if test="${empty errorMessage}">
            <h3>投稿内容はこちらでよろしいでしょうか？</h3>
            <p>タイトル: ${title}</p>
            <p>ユーザーネーム: ${name}</p>
            <p><c:out value="${content}" escapeXml="false" /></p> <!-- <br>をそのまま表示 -->
        </c:if>

		<form class ="position_right" action="../notice/ToukouUpload2.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="content" value="<%=content %>">
			<button class="button_style button_button" type="submit">内容を確認</button>
		</form>
		</div>
	</c:param>
</c:import>
