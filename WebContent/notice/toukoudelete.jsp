<%-- コメントフォーム --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="bean.Post2" %>
<%@ page import="java.util.List" %>

<link rel="stylesheet" href="../css/notice.css">
<c:import url="/common/base.jsp">
    <c:param name="content">
    <div class="container">
        <title>投稿削除確認</title>
        <h2>この投稿内容を本当に削除してもよろしいでしょうか？</h2>

        <c:if test="${not empty list2}">
            <div>
                <h3>削除される投稿内容:</h3>
                <ul>
                    <li><strong>タイトル:</strong> ${list2[0].title}</li>
                    <li><strong>内容:</strong> ${list2[0].content}</li>
                    <li><strong>投稿者:</strong> ${list2[0].name}</li>
                    <li><strong>投稿日時:</strong> ${list2[0].postDay}</li>
                </ul>
            </div>
            <div class="notice_center">
            <form action="Tokou.action" method="post">
                <input type="hidden" name="items" value="${list2[0].postId}" />
                <input type="hidden" name="items" value="${items}">
                <button type="submit" class="button_style detail_button">はい</button>
            </form>
            <form action="../notice/ToukouNotice.action" method="get">
            	<input type="hidden" name="items" value="${items}">
                <button type="submit" class="margin_left_800 button_style detail_button">戻る</button>
            </form>
            </div>
        </c:if>
        <c:if test="${empty list2}">
            <p>削除する投稿が見つかりません。</p>
        </c:if>
       </div>
    </c:param>
</c:import>

