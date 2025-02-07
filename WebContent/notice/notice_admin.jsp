<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	Integer category=(Integer)request.getAttribute("category");
%>
<link rel="stylesheet" href="../css/notice.css">

<c:import url="/common/base.jsp">
	<c:param name="content">
	<form class="notice_center" action="../notice/NoticeAdmin.action" method="get">
		<div class="right_margin top_margin">
			<select class="select_size detail_font" required id="notice-f1-select" name="f1">
				<option value=0>----------</option>
				<c:forEach var="select_list" items="${select_list}">
					<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
				</c:forEach>
			</select>
		</div>

		<div>
			<button class="top_margin button_size button_style detail_font" id="filter-button">検索</button>
		</div>
	</form>

	<c:choose>
		<c:when test="${notice_content.size()>0}">
		<div class="container">
			<div class="position_right">件数:${notice_content.size()}件</div>
			<table border="1">
				<tr>
					<th>タイトル</th>
					<th>コンテンツ</th>
					<th>氏名</th>
					<th>日付</th>
					<th class="padding_none">カテゴリー</th>
					<th></th>
					<th></th>

				</tr>
				<c:forEach var="notice_content" items="${notice_content}" varStatus="loop">
					<tr>
					<td class="padding_none">${notice_content.title}</td>
					<td class="padding_none">
						<form class="padding_bottom_0 text_left" action="../notice/AdminDetail.action?" method="post">
							<input type="hidden" name="post_id" value="${notice_content.postId}">
							<input type="hidden" name="category_id" value=<%=category%>>
							<button class="button_style border-none padding_left_12 padding_top_10 padding_bottom_10 text_left" type="submit">${notice_content.content}</button>
						</form>
					</td>
					<td class="padding_none">${notice_content.name}</td>
					<td class="padding_none">${post_day[loop.index]}</td>
					<td class="padding_none">${notice_content.categoryName}</td>
					<td class="padding_none">
						<form class="padding_bottom_0" action="../notice/NoticeUpdate.action" method="get">
							<input type="hidden" name="post_id" value="${notice_content.postId}">
							<button class="button_style border-none hit_judgment_mechanics" type="submit">編集</button>
						</form>
					</td>
					<td class="padding_none">
						<form class="padding_bottom_0" action="../notice/DeletePermission.action" method="get">
							<input type="hidden" name="post_id" value="${notice_content.postId}">
							<button class="button_style border-none hit_judgment_mechanics" type="submit">削除</button>
						</form>
					</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		</c:when>
	</c:choose>

	<script type="text/javascript">
		var hoge = '<%=category%>';
		var select = document.getElementById("notice-f1-select");
		select.options[hoge].selected = true
	</script>

	</c:param>
</c:import>