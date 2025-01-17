<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String post_id=(String)request.getAttribute("post_id");
	String title=(String)request.getAttribute("title");
	String name=(String)request.getAttribute("name");
	Integer category_id=(Integer)request.getAttribute("category_id");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">

		<p>タイトル:<%=title %></p>
		<p>氏名:<%=name %></p>
		<p>カテゴリーID:<%=category_id %></p>

		<form action="../notice/NoticeUpdateExcute.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="category_id" value=<%=category_id %>>
			<button type="submit">確定</button>
		</form>

		<form action="../notice/NoticeUpdateReturn.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<button type="submit">戻る</button>
		</form>

	</c:param>
</c:import>