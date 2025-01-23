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
	<form class="detail_font container2" action="../notice/Upload" method="post" enctype="multipart/form-data">
	タイトル:(<input class="form_text form_top" type="text" name="title" placeholder="タイトルを入力してください" required="required" value="${title}"><br>
	<%-- エラー文 --%>
	<div id="error-message" style="color:red;">${error_message_title}</div>
	氏名:)<input class="form_text form_top" type="text" name="name" placeholder="氏名を入力してください" required="required" value="${name}"><br>
	<div id="error" style="color:red;">${error_message_name}</div>
	カテゴリー:<select class="form_top form_select" name="num">
					<option value=0>----------</option>
					<c:forEach var="select_list" items="${select_list}">
					<option value=${select_list.categoryId } <c:if test="${select_list.categoryName==f2}">selected</c:if>>${select_list.categoryName}</option>
					</c:forEach>
				</select><br>
	<div id="error" style="color:red;">${error_message_num}</div>
	お知らせ画像:<br><input type="file" name="pict" accept="image/png" required multiple><br>

	<div class="position_right position_bottom">
		<button class="button_style detail_button" type="submit">送信</button>
	</div>

	</form>
	</c:param>
</c:import>
