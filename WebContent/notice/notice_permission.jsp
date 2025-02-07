<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<link rel="stylesheet" href="../css/notice.css">
<%
	String post_id=(String)request.getAttribute("post_id");
	String title=(String)request.getAttribute("title");
	Integer category_id=(Integer)request.getAttribute("category_id");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">

	<div class="detail_font container2">
		<p>タイトル:<%=title %></p>
		<p>氏名:${name[0].name}</p>
		<p>カテゴリー:${category[0].categoryName}</p>
	</div>

	<div class="notice_center detail_top">

		<form action="../notice/NoticeUpdateReturn.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=${name[0].name}>
			<button class="button_style button_size right_margin" type="submit">戻る</button>
		</form>

		<form action="../notice/NoticeUpdateExcute.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=${name[0].name}>
			<input type="hidden" name="category_id" value=<%=category_id %>>
			<button class="button_style button_size margin_left_10" type="submit">確定</button>
		</form>

	</div>

	</c:param>
</c:import>