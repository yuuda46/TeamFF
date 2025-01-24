<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String title=(String)request.getAttribute("title");
	Integer num=(Integer)request.getAttribute("num");
	String path=(String)request.getAttribute("path");
	String filename=(String)request.getAttribute("filename");
%>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">

		<p>タイトル:<%=title %></p>
		<p>氏名:${name[0].name}</p>
		<p>カテゴリーID:<%=num %></p>
		<p>お知らせ画像:</p>
		<p class="position_center"><img  src="../upload/<%=filename %>"></p>

		<form action="../notice/NoticeKeep.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value="${name[0].name}">
			<input type="hidden" name="num" value=<%=num %>>
			<input type="hidden" name="filename" value=<%=filename %>>

			<div class="position_right position_bottom">
				<button class="button_style detail_button" type="submit">確定</button>
			</div>

		</form>

		<form action="../notice/NoticeReturn.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value="${name[0].name}">
			<input type="hidden" name="num" value=<%=num %>>
			<input type="hidden" name="path" value=<%=path %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button class="detail_button button_style" type="submit">戻る</button>
		</form>

	</c:param>
</c:import>

