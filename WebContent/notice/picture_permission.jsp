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
	String path=(String)request.getAttribute("path");
	String filename=(String)request.getAttribute("filename");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">
		<p class="detail_font container2 detail_top">差し替え画像:</p>
		<p class="position_center"><img src="../upload/<%=filename %>"></p>

	<div class="notice_center detail_top">

		<form action="../notice/PictureReturn.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="path" value=<%=path %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button class="button_style button_size right_margin" type="submit">戻る</button>
		</form>

		<form action="../notice/PictureKeep.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button class="button_style button_size margin_left_10" type="submit">確定</button>
		</form>

	</div>

	</c:param>
</c:import>