<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%
	String post_id=(String)request.getAttribute("post_id");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">

	<form action="../notice/NoticePermission.action" method="get">
		タイトル:(<input type="text" name="title" value="${notice_content.title}"><br>
		氏名:)<input type="text" name="name" value="${notice_content.name}"><br>
		カテゴリー:<select name="num">
						<option value=0>----------</option>
						<c:forEach var="select_list" items="${select_list}">
						<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
						</c:forEach>
					</select><br>
		<input type="hidden" name="post_id" value=<%=post_id %>>
		<button type="submit">投稿情報変更</button>
	</form>

	<p>お知らせ画像:<br><img src="../upload/${notice_content.content}"></p>
	<form action="../notice/PictureUpdate.action" method="get">
		<input type="hidden" name="post_id" value=<%=post_id %>>
		<button type="submit">画像変更</button>
	</form>

	<form action="../notice/UpdatePermission.action" method="get">
		<input type="hidden" name="post_id" value=<%=post_id %>>
		<button type="submit">完了</button>
	</form>

	<form action="../notice/NoticeAdmin.action" method="get">
		<button type="submit">戻る</button>
	</form>

	</c:param>
</c:import>