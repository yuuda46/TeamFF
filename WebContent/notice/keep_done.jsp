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

		<p>保存完了しました</p>

		<form action="../notice/Notice.action" method="get">
			<button class="keep_button button_style" type="submit">
				お知らせ一覧
			</button>
		</form>

		<form action="../notice/NoticeForm.action" method="get">
			<button class="keep_button button_style" type="submit">
				続けて登録
			</button>
		</form>

	</c:param>
</c:import>