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

		<p>タイトル:${ title }</p>
		<p>氏名:${ name }</p>
		<p>コンテンツ:</p>
		<p>${ content }</p>

		<form action="Tokou.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="content" value="<%=content %>">
			<button type="submit">確定</button>
		</form>

		<form action="ToukouForm.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="content" value="<%=content %>">
			<button type="submit">戻る</button>
		</form>

	</c:param>
</c:import>
