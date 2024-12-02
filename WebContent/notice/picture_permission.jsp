<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%
	String post_id=(String)request.getAttribute("post_id");
	String path=(String)request.getAttribute("path");
	String filename=(String)request.getAttribute("filename");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">
		<p>差し替え画像:<br><img src="../upload/<%=filename %>"></p>

		<form action="../notice/PictureReturn.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="path" value=<%=path %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button type="submit">戻る</button>
		</form>

		<form action="../notice/PictureKeep.action" method="post">
			<input type="hidden" name="post_id" value=<%=post_id %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button type="submit">確定</button>
		</form>
	</c:param>
</c:import>