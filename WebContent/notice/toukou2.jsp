<%-- コメントフォーム --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="bean.Post2, java.util.List" %>
<%@ page import="bean.Comment, java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>



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
                <p class="f"><%= p.getContent() %></p>
                <p><%= p.getName() %></p>
                <p><%= p.getPostDay() %></p>


             <!-- ユーザー名と投稿のnameが一致する場合にボタンを表示 -->
            <%
                    // セッションからユーザー名を取得
                    String username = (String) session.getAttribute("username");
                    String postName = p.getName();
                    if (username != null && username.equals(postName)) {
                %>

                    <!-- 削除ボタンをこのフォーム内で扱う -->
            <div>
            <input type="hidden" name="items" value="${items}">
            <input type="submit" name="delete" value="掲示板から削除する" formaction="../notice/ToukouDelete.action">
			</div>
                <%
                    }
                %>

            <% } %>

            <!-- エラーメッセージの表示 -->
	        <% if (request.getAttribute("errorMessage") != null) { %>
	            <div class="error-message" style="color: red;">
	                <%= request.getAttribute("errorMessage") %>
	            </div>
	        <% } %>

		<hr size="2" class="a" color="gray">
        <h1>コメント🖊</h1>

            <!-- コメント入力欄 -->
		    <textarea name="proposalContent" id="textarea" placeholder="コメントを入力"  required="required" rows="5"></textarea>
		    <input type="hidden" name="items" value="${items}" required="required">
		    <button id="filter-button" value="遷移" type="submit">送信</button>
		</form>
        <%
            } else {
        %>
            <p>投稿データを取得できませんでした。時間をおいて再試行してください。</p>
        <%
            }
        %>

        <%
            List<Comment> list4 = (List<Comment>) request.getAttribute("comment");
            if (list4 != null && !list4.isEmpty()) {
        %>

        <!-- コメント情報の表示 -->

        <c:forEach var="comment" items="<%=list4 %>">
            <p>No.${comment.comment_id}</p>
            <p>コメント💬 ${comment.proposal}</p>
            <p>🕝 ${comment.time}</p>
            <hr>
        </c:forEach>
        <% } else { %>
            <p>コメントはありません。</p>
        <% } %>
    </c:param>
</c:import>

<!-- @include file="../footer.html" -->
