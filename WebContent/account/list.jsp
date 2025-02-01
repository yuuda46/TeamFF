<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<header>
    <h1 id="logo"><img src="../images/logo.png" alt="SAMPLE COMPANY"></h1>
    <% String username = (String) session.getAttribute("username"); %>
    <% if (username != null) { %>
        <a href="../login/logout-in.jsp" class="button12">ログアウト</a>
    <% } else { %>
        <a href="../login/login.jsp" class="button12">ログイン</a>
        <a href="../account/signUp.jsp" class="button12">新規登録</a>
    <% } %>


 <%
        // セッションからadminフラグを取得
        Boolean isAdmin = (Boolean) session.getAttribute("admin");

        // 管理者フラグがtrueの場合にメニューを表示
        if (isAdmin != null && isAdmin) {
    %>
        <!-- 管理者用ドロップダウンメニュー -->
        <div class="dropdown">
            <button class="dropdown-toggle">メニュー ▼</button>
            <ul class="dropdown-menu">
                <li><a href="../account/AccountList.action">個人情報</a></li>
                <li><a href="../notice/NoticeForm.action">回覧物投稿</a></li>
				<li><a href="../notice/NoticeAdmin.action">回覧物編集</a></li>
            	<li><a href="../c_detail/C_detailList.action">集金物投稿</a></li>
            </ul>
        </div>
    <% } %>
</header>
<head>
    <title>アカウント一覧</title>
    <link rel="stylesheet" href="../css/account.css">

</head>
<body>

<section class="mo-3">
    <h2 class="titlesize h3 mb-3 fw-normal bg-opacity-10 py-2 px-4 user">個人情報一覧</h2>
    <table border="1">
        <tr>
            <th>名前</th>
            <th>ユーザー名</th>
            <th>電話番号</th>
            <th>メール</th>
            <th>郵便番号</th>
            <th>住所</th>
            <th>権限</th>
            <th>詳細</th>
        </tr>

    <%-- 組長を先に表示 --%>
    <c:forEach var="account" items="${accountList}">
        <c:if test="${account.admini == true}">
            <tr>
                <td>${account.name}</td>
                <td>${account.user_name}</td>
                <td>${account.phone_number}</td>
                <td>${account.email}</td>
                <td>${account.post_code}</td>
                <td>${account.address}</td>
                <td>組長</td>
                <td><a href="AccountDetail?email=${account.email}">詳細</a></td>
            </tr>
        </c:if>
    </c:forEach>

    <%-- 組員を最後に表示 --%>
    <c:forEach var="account" items="${accountList}">
        <c:if test="${empty account.admini}">
            <tr>
                <td>${account.name}</td>
                <td>${account.user_name}</td>
                <td>${account.phone_number}</td>
                <td>${account.email}</td>
                <td>${account.post_code}</td>
                <td>${account.address}</td>
                <td>組員</td>
                <td><a href="AccountDetail?email=${account.email}">詳細</a></td>
            </tr>
        </c:if>
    </c:forEach>
    </table>

    <%-- ページネーションリンク --%>
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="AccountList.action?page=${currentPage - 1}">« 前へ</a>
        </c:if>

        <c:forEach var="page" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${page == currentPage}">
                    <span class="current">${page}</span>
                </c:when>
                <c:otherwise>
                    <a href="AccountList.action?page=${page}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="AccountList.action?page=${currentPage + 1}">次へ »</a>
        </c:if>
    </div>

    <form action="../common/index.jsp" method="get">
        <button class="btn btn-secondary" type="submit">戻る</button>
    </form>
</section>

<footer>
    <small>Copyright&copy; <a href="index.jsp">SAMPLE COMPANY</a> All Rights Reserved.</small>
</footer>

</body>
</html>
