<%-- お知らせJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@page import="bean.Post2, java.util.List" %>
<%@page import="bean.Comment, java.util.List" %>


<c:import url="/common/base.jsp">
	<c:param name="content">
		<%
		    List<Post2> list = (List<Post2>) request.getAttribute("content");
			if (list != null && !list.isEmpty()) {
		%>


		<!-- 現在表示されている投稿情報の表示 -->
		<form name="pos" action="../notice/commentSubmit" method="post">
		    <% for (Post2 p : list) { %>
		        <h1><%= p.getTitle() %></h1>
		        <p><%= p.getContent() %></p>
		        <p><%= p.getName() %></p>
		        <p><%= p.getPostDay() %></p>
		    <% } %>

		    <!-- コメント入力欄と送信ボタン -->
		    <textarea name="proposalContent" id="textarea" placeholder="コメントを入力" rows='5'></textarea>
		    <input type="hidden" name="items" value="${items}">
		      <button id="filter-button" value="遷移" type="submit">送信</button>
		</form>
			<%
			    } else {
			%>
			    <p>投稿はありません。</p>
			<%
			    }
			%>



		<%
		    List<Comment> list4 = (List<Comment>) request.getAttribute("comment");
		    if (list4 != null && !list4.isEmpty()) {
		%>

		    <!-- コメント情報の表示 -->

        <h1>コメント欄</h1>

        <c:forEach var="comment" items="<%=list4 %>">
            <p>No.${comment.comment_id}</p>
            <h2>コメント💬${comment.proposal}</h2>
            <p>🕝${comment.time}</p>
            <hr>
        </c:forEach>
    <% } else { %>
	    <p>コメントはありません。</p>
	<% } %>
	</c:param>
</c:import>

<%@include file="../footer.html" %>