<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">
		<form action="../notice/ToukouUpload.action" method="post">
			<div>
		        タイトル:
		        <input type="text" name="title" value="${param.title}"><br>
		        ユーザーネーム:
		        <input type="text" name="name" value="${param.name}"><br>

		        <textarea name="content" rows="5" cols="50" maxlength="10000">${param.content}</textarea>
		    </div>

			<%--改行を保持したままjavaに送信するためのテキストエリア --%>
			<%--rows:テキストエリアの縦幅(行) cols:テキストエリアの横幅(文字) --%>


			<button type="submit">送信</button>

		</form>

	<!-- エラーメッセージ表示 -->
        <c:if test="${not empty errorMessage}">
            <div style="color: red;">
                <p>${errorMessage}</p>
            </div>
        </c:if>
	</c:param>
</c:import>