<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">

		<p>編集完了しました</p>

		<form action="../notice/NoticeAdmin.action" method="get">
			<button type="submit">戻る</button>
		</form>

	</c:param>
</c:import>