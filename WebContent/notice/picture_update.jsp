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

		<form action="../notice/PictureUpdateExcute.action" method="post" enctype="multipart/form-data">
			差し替え画像:<input type="file" name="pict" accept="image/png" required multiple><br>
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<button type="submit">送信</button>
		</form>

	</c:param>
</c:import>
