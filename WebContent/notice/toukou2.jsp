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
<%@ page import="bean.Comment" %>
<%@ page import="java.util.List" %>

<link rel="stylesheet" href="../css/notice.css">
<c:import url="/common/base.jsp">
<c:param name="content">
<div class="container3">
        <%
            List<Post2> list = (List<Post2>) request.getAttribute("content");
            if (list != null && !list.isEmpty()) {
        %>

        <!-- 現在表示されている投稿情報の表示 -->
        <form name="pos" action="../notice/commentSubmit" method="post">
            <% for (Post2 p : list) { %>
                <h1><%= p.getTitle() %></h1>
                <p class="f"><%= p.getContent().replace("\n", "<br>") %></p>
                <p>投稿者👤:<%= p.getName() %></p>
                <p>投稿時間⌚:<%= p.getPostDay() %></p>


             <!-- ユーザーが管理者権限を持っている場合にボタンを表示 -->
            <%
         		// セッションからadminフラグを取得
            	Boolean isAdmin = (Boolean) session.getAttribute("admin");

          		// 管理者フラグがtrueの場合にメニューを表示
             	if (isAdmin != null && isAdmin) {

                %>

                    <!-- 削除ボタンをこのフォーム内で扱う -->
            <div class="position_right">
            <input type="hidden" name="items" value="${items}">
            <input class="button_style button_button" type="submit" name="delete" value="掲示板から削除する" formaction="../notice/ToukouDelete.action">
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
		</form>
		<!-- 現在表示されている投稿情報の表示 -->
        <form name="pos" action="../notice/commentSubmit" method="post">
		<hr size="2" class="notice_line" color="gray">
        <h1>コメント🖊</h1>

            <!-- コメント入力欄 -->
            <div class="padding_top_10 padding_bottom_10 ">
		    <textarea class="tarea border_style" name="proposalContent" id="textarea" placeholder="コメントを入力"  required="required" rows="5"></textarea>
		    </div>

		    <input type="hidden" name="items" value="${items}" required="required">
		    <div class="position_right">
		    <button class="button_style  detail_button" id="filter-button" value="遷移" type="submit">送信</button>
			</div>

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

			<!-- 管理者のみ削除ボタンを表示 -->
		    <c:if test="${sessionScope.admin}">
		        <form action="../notice/CommentDelete.action" method="post" style="display: inline;">
		            <input type="hidden" name="commentId" value="${comment.comment_id}">
		            <input type="hidden" name="items" value="${items}">
		            <div class="position_right">
		            <button class="button_style button_button" type="submit">コメントを削除する</button>
		            </div>
		        </form>
		    </c:if>
            <hr class=" position_right">
        </c:forEach>
	        <% } else { %>
	            <p>コメントはありません。</p>
	        <% } %>
	     </div>
	</c:param>
</c:import>


<!-- @include file="../footer.html" -->
