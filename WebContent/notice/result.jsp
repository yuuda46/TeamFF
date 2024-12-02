<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%
	String title=(String)request.getAttribute("title");
	String name=(String)request.getAttribute("name");
	Integer num=(Integer)request.getAttribute("num");
	String path=(String)request.getAttribute("path");
	String filename=(String)request.getAttribute("filename");
%>

<c:import url="/common/base.jsp">
	<c:param name="content">

		<p>タイトル:<%=title %></p>
		<p>氏名:<%=name %></p>
		<p>カテゴリーID:<%=num %></p>
		<p>お知らせ画像:<br><img src="../upload/<%=filename %>"></p>

		<form action="../notice/NoticeReturn.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="num" value=<%=num %>>
			<input type="hidden" name="path" value=<%=path %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button type="submit">戻る</button>
		</form>

		<form action="../notice/NoticeKeep.action" method="post">
			<input type="hidden" name="title" value=<%=title %>>
			<input type="hidden" name="name" value=<%=name %>>
			<input type="hidden" name="num" value=<%=num %>>
			<input type="hidden" name="filename" value=<%=filename %>>
			<button type="submit">確定</button>
		</form>

	</c:param>
</c:import>

