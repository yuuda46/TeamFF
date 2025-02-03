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
%>

<c:import url="/common/base.jsp">
	<c:param name="content">

		<form  class="detail_font container2 detail_top" action="../notice/PictureUpdateExcute" method="post" enctype="multipart/form-data">
			差し替え画像:<br><input type="file" name="pict" accept="image/png" required multiple><br>
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<div class="position_right position_bottom">
				<button class="button_style detail_button" type="submit">送信</button>
			</div>
		</form>

		<form class="container2 position_form" action="../notice/NoticeUpdate.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<button class="button_style detail_button" type="submit">戻る</button>
		</form>

	</c:param>
</c:import>
