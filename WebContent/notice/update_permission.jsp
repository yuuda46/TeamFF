<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">
		<div class="container">
			<p class="detail_font">保存完了しました</p>

			<div class="notice_center">
				<form class="right_margin" action="../notice/NoticeUpdate.action" method="get">
					<input type="hidden" name="post_id" value="${post_id}">
					<button class="button_style keep_button" type="submit">再編集</button>
				</form>

				<form class="margin_left_10" action="../notice/NoticeAdmin.action" method="get">
					<button class="button_style keep_button" type="submit">編集終了</button>
				</form>
			</div>

		</div>

	</c:param>
</c:import>