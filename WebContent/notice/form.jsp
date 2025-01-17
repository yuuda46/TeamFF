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
	<form class="detail_font" action="../notice/Upload" method="post" enctype="multipart/form-data">
	タイトル:(<input type="text" name="title" value="${title}"><br>
	<%-- エラー文 --%>
	<div id="error">${error_message}</div>
	氏名:)<input type="text" name="name" value="${name}"><br>
	カテゴリー:<select name="num">
					<option value=0>----------</option>
					<c:forEach var="select_list" items="${select_list}">
					<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
					</c:forEach>
			   </select><br>
	お知らせ画像:<input type="file" name="pict" accept="image/png" required multiple><br>
	<button type="submit">送信</button>

	</form>
	</c:param>
</c:import>
