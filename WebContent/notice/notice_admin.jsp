<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">
	<c:param name="content">
	<form action="../notice/NoticeAdmin.action" method="get">
		<div>
			<label for="post-f1-select">カテゴリー</label><br>
			<select required id="notice-f1-select" name="f1">
				<option value=0>----------</option>
				<c:forEach var="select_list" items="${select_list}">
					<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
				</c:forEach>
			</select>
		</div>

		<div>
			<button id="filter-button">絞り込み</button>
		</div>
	</form>

	<c:choose>
		<c:when test="${notice_content.size()>0}">
			<div>件数:${notice_content.size()}件</div>
			<table>
				<tr>
					<th>タイトル</th>
					<th>コンテンツ</th>
					<th>氏名</th>
					<th>日付</th>
					<th>カテゴリー</th>
					<th></th>
					<th></th>

				</tr>
				<c:forEach var="notice_content" items="${notice_content}">
					<tr>
					<td>${notice_content.title}</td>
					<td><a href="../notice/AdminDetail.action?id=${notice_content.postId}">${notice_content.content}</a></td>
					<td>${notice_content.name}</td>
					<td>${notice_content.postDay}</td>
					<td>　　${notice_content.categoryId}</td>
					<td>
						<form action="../notice/NoticeUpdate.action" method="get">
						<input type="hidden" name="post_id" value="${notice_content.postId}">
							<button type="submit">変更</button>
						</form>
					</td>
					<td>
						<form action="../notice/DeletePermission.action" method="get">
							<input type="hidden" name="post_id" value="${notice_content.postId}">
							<button type="submit">削除</button>
						</form>
					</td>
					</tr>
				</c:forEach>
			</table>
		</c:when>
	</c:choose>

	</c:param>
</c:import>