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

<c:import url="/common/base.jsp">
	<c:param name="content">

		<h2>投稿結果</h2>

        <!-- エラーがあった場合の表示 -->
        <c:if test="${not empty errorMessage}">
            <div style="color: red;">
                <p>${errorMessage}</p>
            </div>
        </c:if>

        <!-- 投稿が正常に完了した場合の表示 -->
        <c:if test="${empty errorMessage}">
            <h3>投稿が完了しました！</h3>
            <p>タイトル: ${title}</p>
            <p>ユーザーネーム: ${name}</p>
            <p>内容: ${content}</p>
        </c:if>

		<form action="Tokou.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="content" value="<%=content %>">
			<button type="submit">戻る</button>
		</form>

	</c:param>
</c:import>
