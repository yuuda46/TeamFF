<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 文字化けの対策 --%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<c:import url="/common/base.jsp">

    <c:param name="scripts"></c:param>

    <c:param name="content">
    <div class="function">
<%--<c:import url="/common/sidemenu.jsp">
    </c:import> --%>

    <link rel="stylesheet" href="../css/collection.css">

    <form action="./CollectionConfirm.action" method="get">
        <input type="hidden" name="postID" value="your_post_id_value_here">
        <button type="submit">
            完了確認画面へ
        </button>
    </form>

    <form action="./CollectionDeposit.action" method="get">
        <input type="hidden" name="postID" value="your_post_id_value_here">
        <button type="submit">
            入金完了画面へ
        </button>
    </form>

    </div>
    </c:param>
</c:import>