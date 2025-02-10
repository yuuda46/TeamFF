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

	<form class="detail_font container2 padding_top_10" action="../notice/NoticePermission.action" method="get">
		<div class="padding_top_10">
			タイトル:<input class="admin_text form_top margin_left_45" type="text" name="title" required="required" value="${notice_content.title}"><br>
		</div>
		<div class="padding_top_10">
			カテゴリー:<select class="form_top admin_select margin_left_27" name="num" id="notice-f1-select">
							<option value=0>----------</option>
							<c:forEach var="select_list" items="${select_list}">
							<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
							</c:forEach>
						</select><br>
		</div>
		<input type="hidden" name="post_id" value=<%=post_id %>>
		<div class="padding_top_10 position_right">
			<button class="button_style keep_button" type="submit">投稿情報編集</button>
		</div>
		<hr class="notice_line">
	</form>

	<p class="detail_font container2">お知らせ画像:</p>
	<p class="position_center"><img src="../upload/${notice_content.content}"></p>
	<form class="detail_font container2" action="../notice/PictureUpdate.action" method="get">
		<input type="hidden" name="post_id" value=<%=post_id %>>
		<div class="padding_top_10 position_right">
			<button class="button_style button_size" type="submit">画像編集</button>
		</div>
		<hr class="notice_line">
	</form>

	<div class="notice_center detail_top">

		<form action="../notice/NoticeAdmin.action" method="get">
			<button class="button_style button_size right_margin" type="submit">戻る</button>
		</form>

		<form action="../notice/UpdatePermission.action" method="get">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<button class="button_style button_size margin_left_10" type="submit">完了</button>
		</form>

	</div>

	<script type="text/javascript">
		var hoge = '${notice_content.category_id}';
		var select = document.getElementById("notice-f1-select");
		select.options[hoge].selected = true
	</script>

	</c:param>
</c:import>