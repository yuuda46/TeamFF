<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="bean.Post2" %>
<%@ page import="java.util.List" %>

<c:import url="/common/base.jsp">
    <c:param name="content">
		<h2>このコメントを本当に削除してもよろしいでしょうか？</h2>

		<c:if test="${not empty Commentdel}">
		    <div>
		        <h3>削除されるコメント内容:</h3>
		        <ul>
					<li><strong>番号:</strong> ${Commentdel[0].comment_id}</li> <!-- commentIdを表示 -->
		            <li><strong>コメント:</strong> ${Commentdel[0].proposal}</li> <!-- コメント内容を表示 -->
		            <li><strong>投稿時間:</strong> ${Commentdel[0].time}</li> <!-- 投稿時間を表示 -->
		        </ul>
		    </div>

		    <form  method="post" action="../notice/ToukouNotice.action">
		        <input type="hidden" name="commentId" value="${Commentdel[0].comment_id}">
		        <input type="hidden" name="items" value="${items}">
		        <input type="submit" value="削除" />
		    </form>

		    <form action="Tokou.action" method="get">
		        <input type="submit" value="戻る" />
		    </form>

		</c:if>

		<c:if test="${empty Commentdel}">
		    <p>削除するコメントが見つかりませんでした。</p>
		</c:if>
    </c:param>
</c:import>